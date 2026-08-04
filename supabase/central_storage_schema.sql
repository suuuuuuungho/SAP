-- SAP 1기 대시보드: 공부/예배 기록도 기도/말씀처럼 Supabase로 중앙화.
-- (gallery_schema.sql까지 실행한 프로젝트에 이어서 실행하세요.)
-- 기도/말씀과 달리 Gallery에서 다른 사람에게 보여주지 않으므로, 본인 행만
-- select/insert/update/delete 가능하도록 gallery_enabled 예외 없이 잠급니다.

create table if not exists public.study_records (
  user_id uuid not null references auth.users (id) on delete cascade,
  record_date date not null,
  sessions jsonb not null default '[]'::jsonb, -- [{source:'record'|'manual', seconds, startedAt?, endedAt?}]
  updated_at timestamptz not null default now(),
  primary key (user_id, record_date)
);

create table if not exists public.worship_records (
  user_id uuid not null references auth.users (id) on delete cascade,
  record_date date not null,
  status text, -- 'attended' | 'absent' | 'home' | null
  minutes integer not null default 0,
  updated_at timestamptz not null default now(),
  primary key (user_id, record_date)
);

create index if not exists study_records_date_idx on public.study_records (record_date);
create index if not exists worship_records_date_idx on public.worship_records (record_date);

alter table public.study_records enable row level security;
alter table public.worship_records enable row level security;

drop policy if exists "study_records_own" on public.study_records;
create policy "study_records_own"
  on public.study_records for all
  using (user_id = auth.uid())
  with check (user_id = auth.uid());

drop policy if exists "worship_records_own" on public.worship_records;
create policy "worship_records_own"
  on public.worship_records for all
  using (user_id = auth.uid())
  with check (user_id = auth.uid());
