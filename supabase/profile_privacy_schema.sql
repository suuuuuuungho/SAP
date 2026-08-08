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
