-- Sapians 날짜별 학생 갤러리용 사용자 목록 정리.
-- Supabase SQL Editor에서 실행하면 교사/관리자 계정은 학생 칸에서 제외됩니다.

create or replace function public.get_gallery_users()
returns table (id uuid, username text, name text)
language sql
security definer
set search_path = public
as $$
  select p.id, p.username, p.name
  from public.profiles p
  where p.gallery_enabled = true
    and p.grade_class not in ('교사', '관리자')
  order by p.username;
$$;

grant execute on function public.get_gallery_users() to authenticated;
