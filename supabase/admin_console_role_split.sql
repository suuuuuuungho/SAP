-- SAP Admin Console: host 전용 Management vs 그 외 스태프의 열람 전용(Board/Gallery) 권한 분리.
-- admin_console_schema.sql 실행 이후 적용하세요. Supabase Dashboard > SQL Editor에서 전체 실행하세요.
--
-- 변경 요약
-- 1) is_app_admin()을 "host만" true를 반환하도록 좁힙니다. Member/Dashboard/Control Panel/Stat/
--    Board manage/Gallery manage 등 민감한 관리 RPC·RLS 정책은 전부 이 함수로 게이트되어 있으므로,
--    app_role='admin'이어도 host가 아니면 더 이상 이 기능들에 접근할 수 없습니다.
-- 2) can_view_admin_console()을 새로 추가합니다. host + admin/teacher/pastor/department_head/secretary
--    는 Admin 콘솔에 들어가서 Board/Gallery(학생과 동일한 읽기 전용 화면)를 볼 수 있습니다. 이 함수는
--    admin.html 진입 게이트로만 쓰이고, Board/Gallery 데이터 자체는 일반 사용자와 동일한 RLS를 그대로 탑니다.

create or replace function public.is_app_admin(check_user_id uuid default auth.uid())
returns boolean
language sql stable security definer set search_path = public
as $$
  select coalesce((select p.is_host from public.profiles p where p.id = check_user_id), false);
$$;
revoke all on function public.is_app_admin(uuid) from public;
grant execute on function public.is_app_admin(uuid) to authenticated;

create or replace function public.can_view_admin_console(check_user_id uuid default auth.uid())
returns boolean
language sql stable security definer set search_path = public
as $$
  select coalesce((
    select p.is_host or p.app_role in ('admin', 'teacher', 'pastor', 'department_head', 'secretary')
    from public.profiles p where p.id = check_user_id
  ), false);
$$;
revoke all on function public.can_view_admin_console(uuid) from public;
grant execute on function public.can_view_admin_console(uuid) to authenticated;
