-- Board Message 시작 시각·예약 문자·선택 발신자 지원
-- Supabase SQL Editor에서 한 번 실행하세요.

alter table public.home_messages
  add column if not exists starts_at timestamptz,
  add column if not exists sender_user_id uuid references auth.users(id) on delete set null,
  add column if not exists sms_group_ids jsonb not null default '[]'::jsonb,
  add column if not exists sms_status text not null default 'not_requested';

-- 기존 메시지는 등록 시각부터 노출된 것으로 보정합니다.
update public.home_messages
set starts_at = created_at
where starts_at is null;

alter table public.home_messages
  alter column starts_at set default now(),
  alter column starts_at set not null;

update public.home_messages
set sender_user_id = created_by
where sender_user_id is null;

create index if not exists home_messages_active_window_idx
  on public.home_messages (is_active, starts_at, expires_at);

drop policy if exists "home_messages_read_target" on public.home_messages;
create policy "home_messages_read_target"
  on public.home_messages for select to authenticated
  using (
    public.is_app_admin(auth.uid())
    or (
      is_active = true
      and starts_at <= now()
      and (expires_at is null or expires_at > now())
      and (recipient_user_id is null or recipient_user_id = auth.uid())
    )
  );
