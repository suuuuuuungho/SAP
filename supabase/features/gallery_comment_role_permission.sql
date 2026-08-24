-- SAP Admin Console: Gallery 댓글 작성 권한을 Control Panel에서 역할 단위로 관리할 수 있게 합니다.
-- admin_console_role_split.sql 실행 이후 적용하세요. Supabase Dashboard > SQL Editor에서 전체 실행하세요.
--
-- 변경 요약
-- 1) app_role_permissions 테이블 신설: permission_key별로 어떤 app_role이 허용되는지 저장합니다.
--    조회는 누구나 가능(RLS), 수정은 host만 가능(is_app_admin).
-- 2) gallery_comments 권한을 기본값(admin/teacher/pastor/department_head/secretary)으로 시드합니다.
--    Control Panel에서 이 목록을 언제든 켜고 끌 수 있습니다.
-- 3) can_write_gallery_comments()가 하드코딩된 역할 목록 대신 위 테이블을 참조하도록 바뀝니다.
--    host 여부는 더 이상 관여하지 않고, 오직 app_role만 봅니다.
-- 4) admin_add_post_comment()(Gallery manage 화면에서 host가 댓글을 작성하는 경로)도
--    can_write_gallery_comments()를 추가로 검사해, host라도 허용된 역할이 아니면 댓글을 달 수 없습니다.

create table if not exists public.app_role_permissions (
  permission_key text not null,
  role text not null check (role in ('admin', 'teacher', 'pastor', 'department_head', 'secretary')),
  created_at timestamptz not null default now(),
  primary key (permission_key, role)
);

alter table public.app_role_permissions enable row level security;

drop policy if exists "app_role_permissions_read" on public.app_role_permissions;
create policy "app_role_permissions_read" on public.app_role_permissions
  for select to authenticated using (true);

drop policy if exists "app_role_permissions_admin_write" on public.app_role_permissions;
create policy "app_role_permissions_admin_write" on public.app_role_permissions
  for all to authenticated
  using (public.is_app_admin(auth.uid())) with check (public.is_app_admin(auth.uid()));

insert into public.app_role_permissions (permission_key, role)
values
  ('gallery_comments', 'admin'),
  ('gallery_comments', 'teacher'),
  ('gallery_comments', 'pastor'),
  ('gallery_comments', 'department_head'),
  ('gallery_comments', 'secretary')
on conflict (permission_key, role) do nothing;

create or replace function public.can_write_gallery_comments()
returns boolean language sql stable security definer set search_path = public
as $$
  select exists (
    select 1 from public.profiles p
    where p.id = auth.uid()
      and p.is_active = true
      and p.app_role in (select role from public.app_role_permissions where permission_key = 'gallery_comments')
  );
$$;
grant execute on function public.can_write_gallery_comments() to authenticated;

create or replace function public.admin_add_post_comment(
  target_owner_id uuid, target_post_date date, target_post_type text, comment_body text
)
returns uuid language plpgsql security definer set search_path = public
as $$
declare new_id uuid;
begin
  if not public.is_app_admin(auth.uid()) then raise exception 'admin access required'; end if;
  if not public.can_write_gallery_comments() then raise exception 'comment permission required'; end if;
  if target_post_type not in ('pray','word') or char_length(trim(comment_body)) not between 1 and 300 then
    raise exception 'invalid comment';
  end if;
  insert into public.post_comments (post_owner_id, post_date, post_type, author_id, body)
  values (target_owner_id, target_post_date, target_post_type, auth.uid(), trim(comment_body))
  returning id into new_id;
  return new_id;
end; $$;
grant execute on function public.admin_add_post_comment(uuid,date,text,text) to authenticated;
