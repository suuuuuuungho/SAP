-- SAP Admin Console: 학부모 메시지 예약 발송 + 발송 내역을 위한 테이블.
-- Supabase Dashboard > SQL Editor에서 전체 실행하세요. admin_console_role_split.sql 이후 적용.
--
-- home_messages(학생 Board에 표시되는 공지)와 완전히 분리된 별도 테이블입니다.
-- 학부모 메시지는 학생 화면에 절대 노출되면 안 되므로, RLS로 host(is_app_admin)에게만
-- 읽기/쓰기를 허용하고 다른 화면에서는 이 테이블을 아예 참조하지 않습니다.

create table if not exists public.parent_messages (
  id uuid primary key default gen_random_uuid(),
  recipient_user_id uuid references auth.users(id) on delete set null, -- null이면 전체 학부모
  body text not null check (char_length(body) between 1 and 500),
  starts_at timestamptz not null default now(),
  sms_group_ids text[] not null default '{}',
  sms_status text not null default 'pending',
  created_by uuid not null references auth.users(id) on delete restrict,
  created_at timestamptz not null default now()
);

create index if not exists parent_messages_created_idx on public.parent_messages (created_at desc);

alter table public.parent_messages enable row level security;

drop policy if exists "parent_messages_admin_all" on public.parent_messages;
create policy "parent_messages_admin_all" on public.parent_messages
  for all to authenticated
  using (public.is_app_admin(auth.uid()))
  with check (public.is_app_admin(auth.uid()));
