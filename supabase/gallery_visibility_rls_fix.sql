-- SAP Gallery/Comment: 다른 사람 게시물이 전부 "미인증"으로 보이던 근본 원인 수정.
-- Supabase Dashboard > SQL Editor에서 전체 실행하세요.
--
-- 원인
-- pray_records_select / word_records_select / post_comments_select 정책은 "글쓴이가 활성
-- 학생인가"를 확인하려고 policy의 USING절 안에서 public.profiles를 직접 서브쿼리로 읽는다.
-- 그런데 profiles 테이블 자체의 SELECT 정책(profiles_select_own, schema.sql)은 "본인 행만
-- 조회 가능"이라, 이 서브쿼리도 똑같이 그 제한을 받는다 (RLS가 정책 안의 서브쿼리에도 그대로
-- 적용되는 재귀 문제). 그 결과 "글쓴이 = 나"가 아닌 모든 행에서 이 서브쿼리가 항상 빈 결과를
-- 반환해, 다른 학생의 기도/말씀 기록·댓글이 전부 안 보이거나(=미인증으로 표시) 했다.
-- (host가 Admin 콘솔의 admin_get_gallery_records RPC로 볼 때는 SECURITY DEFINER라 이 문제를
-- 우회해서 정상으로 보였고, 그래서 지금까지 드러나지 않았다.)
--
-- 해결
-- profiles 조회를 SECURITY DEFINER 함수로 감싸서 RLS 재귀를 피하고, 그 함수를 정책에서 쓴다.

create or replace function public.is_active_student(check_user_id uuid)
returns boolean
language sql stable security definer set search_path = public
as $$
  select coalesce((
    select p.app_role = 'student' and p.is_active = true
    from public.profiles p where p.id = check_user_id
  ), false);
$$;
revoke all on function public.is_active_student(uuid) from public;
grant execute on function public.is_active_student(uuid) to authenticated;

create or replace function public.is_active_profile(check_user_id uuid)
returns boolean
language sql stable security definer set search_path = public
as $$
  select coalesce((select p.is_active from public.profiles p where p.id = check_user_id), false);
$$;
revoke all on function public.is_active_profile(uuid) from public;
grant execute on function public.is_active_profile(uuid) to authenticated;

drop policy if exists "pray_records_select" on public.pray_records;
create policy "pray_records_select" on public.pray_records for select to authenticated
using (user_id = auth.uid() or public.is_active_student(pray_records.user_id));

drop policy if exists "word_records_select" on public.word_records;
create policy "word_records_select" on public.word_records for select to authenticated
using (user_id = auth.uid() or public.is_active_student(word_records.user_id));

drop policy if exists "post_comments_select" on public.post_comments;
create policy "post_comments_select" on public.post_comments for select to authenticated
using (public.is_active_profile(post_comments.post_owner_id));

drop policy if exists "post_comments_insert" on public.post_comments;
create policy "post_comments_insert" on public.post_comments for insert to authenticated
with check (
  author_id = auth.uid()
  and public.can_write_gallery_comments()
  and public.is_active_profile(post_comments.post_owner_id)
);
