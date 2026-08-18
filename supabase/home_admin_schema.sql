-- SAP 1기 대시보드: 공개 Home 랭킹 + 관리자 전광판 스키마.
-- Supabase SQL Editor에서 전체 실행하세요.
-- 실행 후 마지막의 관리자 지정 예시에서 실제 username을 넣어 별도로 실행해야 합니다.

create extension if not exists pgcrypto;

alter table public.profiles
  add column if not exists is_admin boolean not null default false;

create or replace function public.is_app_admin(check_user_id uuid default auth.uid())
returns boolean
language sql
stable
security definer
set search_path = public
as $$
  select coalesce((select p.is_admin from public.profiles p where p.id = check_user_id), false);
$$;

revoke all on function public.is_app_admin(uuid) from public;
grant execute on function public.is_app_admin(uuid) to authenticated;

create table if not exists public.home_messages (
  id uuid primary key default gen_random_uuid(),
  recipient_user_id uuid references auth.users(id) on delete cascade, -- null이면 전체 공지
  body text not null check (char_length(body) between 1 and 500),
  is_active boolean not null default true,
  starts_at timestamptz not null default now(),
  expires_at timestamptz,
  sender_user_id uuid references auth.users(id) on delete set null,
  sms_group_ids jsonb not null default '[]'::jsonb,
  sms_status text not null default 'not_requested',
  created_by uuid not null references auth.users(id) on delete restrict,
  created_at timestamptz not null default now()
);

create index if not exists home_messages_recipient_idx
  on public.home_messages (recipient_user_id, is_active, created_at desc);

alter table public.home_messages enable row level security;

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

drop policy if exists "home_messages_admin_write" on public.home_messages;
drop policy if exists "home_messages_admin_insert" on public.home_messages;
drop policy if exists "home_messages_admin_update" on public.home_messages;
drop policy if exists "home_messages_admin_delete" on public.home_messages;
create policy "home_messages_admin_insert" on public.home_messages for insert to authenticated
  with check (public.is_app_admin(auth.uid()) and created_by = auth.uid());
create policy "home_messages_admin_update" on public.home_messages for update to authenticated
  using (public.is_app_admin(auth.uid())) with check (public.is_app_admin(auth.uid()));
create policy "home_messages_admin_delete" on public.home_messages for delete to authenticated
  using (public.is_app_admin(auth.uid()));

create table if not exists public.home_bible_verses (
  id uuid primary key default gen_random_uuid(),
  reference text not null check (char_length(reference) between 1 and 100),
  verse_text text not null check (char_length(verse_text) between 1 and 1000),
  is_active boolean not null default true,
  created_by uuid not null references auth.users(id) on delete restrict,
  created_at timestamptz not null default now()
);

alter table public.home_bible_verses enable row level security;

drop policy if exists "home_bible_verses_read_active" on public.home_bible_verses;
create policy "home_bible_verses_read_active"
  on public.home_bible_verses for select to authenticated
  using (is_active = true or public.is_app_admin(auth.uid()));

drop policy if exists "home_bible_verses_admin_write" on public.home_bible_verses;
drop policy if exists "home_bible_verses_admin_insert" on public.home_bible_verses;
drop policy if exists "home_bible_verses_admin_update" on public.home_bible_verses;
drop policy if exists "home_bible_verses_admin_delete" on public.home_bible_verses;
create policy "home_bible_verses_admin_insert" on public.home_bible_verses for insert to authenticated
  with check (public.is_app_admin(auth.uid()) and created_by = auth.uid());
create policy "home_bible_verses_admin_update" on public.home_bible_verses for update to authenticated
  using (public.is_app_admin(auth.uid())) with check (public.is_app_admin(auth.uid()));
create policy "home_bible_verses_admin_delete" on public.home_bible_verses for delete to authenticated
  using (public.is_app_admin(auth.uid()));

-- 관리자 화면의 수신자 목록. 개인정보는 id/username/name만 반환합니다.
create or replace function public.get_admin_message_users()
returns table (id uuid, username text, name text)
language plpgsql
security definer
set search_path = public
as $$
begin
  if not public.is_app_admin(auth.uid()) then
    raise exception 'admin access required';
  end if;
  return query select p.id, p.username, p.name from public.profiles p order by p.name, p.username;
end;
$$;

revoke all on function public.get_admin_message_users() from public;
grant execute on function public.get_admin_message_users() to authenticated;

-- 운영기간(2026-08-10~2026-09-06) 평일 누적 랭킹.
-- 개인 원본 행은 공개하지 않고, category별 상위 5명의 합계만 반환합니다.
create or replace function public.get_home_rankings()
returns table (
  category text,
  rank_no bigint,
  user_id uuid,
  username text,
  name text,
  minutes bigint
)
language sql
stable
security definer
set search_path = public
as $$
with pray_minutes as (
  select r.user_id,
         coalesce(sum(
           case
             when e.value->>'start' ~ '^[0-9]{4}-[0-9]{2}-[0-9]{2}T[0-9]{2}:[0-9]{2}'
              and e.value->>'end' ~ '^[0-9]{4}-[0-9]{2}-[0-9]{2}T[0-9]{2}:[0-9]{2}'
             then greatest(0, extract(epoch from ((e.value->>'end')::timestamp - (e.value->>'start')::timestamp)) / 60)
             else 0
           end
         ), 0)::bigint as minutes
  from public.pray_records r
  cross join lateral jsonb_array_elements(r.entries) e(value)
  where r.record_date between date '2026-08-10' and date '2026-09-06'
    and extract(isodow from r.record_date) between 1 and 5
  group by r.user_id
),
word_minutes as (
  select r.user_id,
         coalesce(sum(
           60 + coalesce((
             select sum(
               case
                 when verse.value->>'meditationMinutes' ~ '^[0-9]+([.][0-9]+)?$'
                 then greatest(0, round((verse.value->>'meditationMinutes')::numeric))
                 else 0
               end
             )
             from jsonb_array_elements(r.verses) with ordinality verse(value, position)
             where verse.position > 1
           ), 0)
         ), 0)::bigint as minutes
  from public.word_records r
  where r.record_date between date '2026-08-10' and date '2026-09-06'
    and extract(isodow from r.record_date) between 1 and 5
    and jsonb_array_length(r.verses) > 0
  group by r.user_id
),
study_minutes as (
  select r.user_id,
         (coalesce(sum(coalesce(nullif(s.value->>'seconds', '')::numeric, 0)), 0) / 60)::bigint as minutes
  from public.study_records r
  cross join lateral jsonb_array_elements(r.sessions) s(value)
  where r.record_date between date '2026-08-10' and date '2026-09-06'
    and extract(isodow from r.record_date) between 1 and 5
  group by r.user_id
),
worship_minutes as (
  select r.user_id, coalesce(sum(r.minutes), 0)::bigint as minutes
  from public.worship_records r
  where r.record_date between date '2026-08-10' and date '2026-09-06'
    and extract(isodow from r.record_date) between 1 and 5
  group by r.user_id
),
category_values as (
  select 'pray'::text category, p.id user_id, coalesce(m.minutes, 0)::bigint minutes
  from public.profiles p left join pray_minutes m on m.user_id = p.id
  union all
  select 'word', p.id, coalesce(m.minutes, 0)::bigint
  from public.profiles p left join word_minutes m on m.user_id = p.id
  union all
  select 'study', p.id, coalesce(m.minutes, 0)::bigint
  from public.profiles p left join study_minutes m on m.user_id = p.id
  union all
  select 'total', p.id,
         (coalesce(pr.minutes, 0) + coalesce(wo.minutes, 0) + coalesce(st.minutes, 0) + coalesce(wr.minutes, 0))::bigint
  from public.profiles p
  left join pray_minutes pr on pr.user_id = p.id
  left join word_minutes wo on wo.user_id = p.id
  left join study_minutes st on st.user_id = p.id
  left join worship_minutes wr on wr.user_id = p.id
),
ranked as (
  select v.category, p.id user_id, p.username, p.name, v.minutes,
         row_number() over (partition by v.category order by v.minutes desc, p.name, p.username) rank_no
  from category_values v
  join public.profiles p on p.id = v.user_id
  where v.minutes > 0
)
select r.category, r.rank_no, r.user_id, r.username, r.name, r.minutes
from ranked r
where r.rank_no <= 5
order by case r.category when 'total' then 1 when 'pray' then 2 when 'study' then 3 else 4 end, r.rank_no;
$$;

revoke all on function public.get_home_rankings() from public;
grant execute on function public.get_home_rankings() to authenticated;

-- 최초 관리자 지정 예시(아래 username을 실제 관리자 아이디로 바꿔 별도 실행):
-- update public.profiles set is_admin = true where username = '관리자아이디';
