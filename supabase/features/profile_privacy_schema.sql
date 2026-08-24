-- 개인정보(Profile) 화면용 스키마.
-- Supabase Dashboard > SQL Editor에서 전체 내용을 한 번 실행하세요.

alter table public.profiles
  add column if not exists avatar_path text;

-- 프로필 사진 경로만 본인이 변경할 수 있도록 제한된 RPC를 사용합니다.
create or replace function public.set_my_avatar_path(new_path text)
returns void
language plpgsql
security definer
set search_path = public
as $$
begin
  if auth.uid() is null then
    raise exception 'authentication required';
  end if;
  -- null은 사진 삭제, 문자열은 아래 경로 규칙({user_id}/avatar)만 허용합니다.
  if new_path is not null and new_path <> (auth.uid()::text || '/avatar') then
    raise exception 'invalid avatar path';
  end if;
  update public.profiles set avatar_path = new_path where id = auth.uid();
end;
$$;

grant execute on function public.set_my_avatar_path(text) to authenticated;

-- Home/Gallery에서 가입자 프로필 사진만 표시하기 위한 제한된 조회 함수입니다.
-- 이름, 전화번호 등 다른 개인정보는 반환하지 않습니다.
create or replace function public.get_profile_avatar_paths(requested_user_ids uuid[])
returns table (user_id uuid, avatar_path text)
language sql
stable
security definer
set search_path = public
as $$
  select p.id, p.avatar_path
  from public.profiles p
  where p.id = any(coalesce(requested_user_ids, array[]::uuid[]));
$$;

revoke all on function public.get_profile_avatar_paths(uuid[]) from public;
grant execute on function public.get_profile_avatar_paths(uuid[]) to authenticated;

-- 댓글 작성자와 공용 화면의 프로필 표시용 정보입니다.
-- 역할은 학생/교사/관리자 구분 뱃지에 필요한 값만 반환합니다.
create or replace function public.get_public_profile_cards(requested_user_ids uuid[])
returns table (
  user_id uuid,
  username text,
  name text,
  avatar_path text,
  badge_role text
)
language sql
stable
security definer
set search_path = public
as $$
  select p.id,
         p.username,
         p.name,
         p.avatar_path,
         case
           when p.is_admin = true or p.grade_class = '관리자' then 'admin'
           when p.grade_class = '교사' then 'teacher'
           else null
         end
  from public.profiles p
  where p.id = any(coalesce(requested_user_ids, array[]::uuid[]));
$$;

revoke all on function public.get_public_profile_cards(uuid[]) from public;
grant execute on function public.get_public_profile_cards(uuid[]) to authenticated;

insert into storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
values (
  'profile-avatars',
  'profile-avatars',
  false,
  5242880,
  array['image/jpeg', 'image/png', 'image/webp']
)
on conflict (id) do update set
  public = false,
  file_size_limit = excluded.file_size_limit,
  allowed_mime_types = excluded.allowed_mime_types;

drop policy if exists "profile_avatars_bucket_select" on storage.buckets;
create policy "profile_avatars_bucket_select"
  on storage.buckets for select to authenticated
  using (id = 'profile-avatars');

drop policy if exists "profile_avatars_own" on storage.objects;
create policy "profile_avatars_own"
  on storage.objects for all to authenticated
  using (
    bucket_id = 'profile-avatars'
    and (storage.foldername(name))[1] = auth.uid()::text
  )
  with check (
    bucket_id = 'profile-avatars'
    and (storage.foldername(name))[1] = auth.uid()::text
  );

-- Home/Gallery는 가입자만 볼 수 있으므로 인증된 가입자에게 사진 읽기만 허용합니다.
-- 업로드·수정·삭제는 위 profile_avatars_own 정책에 따라 계속 본인만 가능합니다.
drop policy if exists "profile_avatars_authenticated_read" on storage.objects;
create policy "profile_avatars_authenticated_read"
  on storage.objects for select to authenticated
  using (bucket_id = 'profile-avatars');
