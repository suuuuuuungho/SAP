-- Team 기능: 학생을 팀으로 묶고, 팀별 기도/말씀/공부 누적 시간과 팀 내 기여도 Top 3를 보여준다.
-- 팀 구성(생성/삭제, 팀장·부팀장 지정, 팀원 배정)은 관리자만 할 수 있고(Team Manage 탭),
-- 결과는 학생 전체가 보는 공개 탭(Team)에 표시된다.
-- Supabase Dashboard > SQL Editor에서 전체 실행하세요.
-- (admin_console_schema.sql, gallery_schema.sql, home_admin_schema.sql 실행 이후에 실행 —
--  is_app_admin(), profiles, pray_records/word_records/study_records/worship_records,
--  app_feature_flags를 사용합니다.)

create table if not exists public.teams (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  sort_order int not null default 0,
  created_at timestamptz not null default now()
);

alter table public.profiles
  add column if not exists team_id uuid references public.teams(id) on delete set null,
  add column if not exists team_role text;

alter table public.profiles drop constraint if exists profiles_team_role_check;
alter table public.profiles add constraint profiles_team_role_check
  check (team_role is null or team_role in ('leader', 'vice_leader'));

-- 팀당 팀장/부팀장은 각각 최대 1명 — DB 레벨에서 중복 지정을 원천 차단한다.
create unique index if not exists profiles_team_one_leader_idx on public.profiles(team_id) where team_role = 'leader';
create unique index if not exists profiles_team_one_vice_leader_idx on public.profiles(team_id) where team_role = 'vice_leader';

alter table public.teams enable row level security;
drop policy if exists "teams_select" on public.teams;
create policy "teams_select" on public.teams for select to authenticated using (true);
drop policy if exists "teams_admin_write" on public.teams;
create policy "teams_admin_write" on public.teams for all to authenticated
  using (public.is_app_admin(auth.uid())) with check (public.is_app_admin(auth.uid()));

-- Admin: 전체 학생의 팀 배정 현황(팀 없음 포함) 조회.
create or replace function public.admin_get_team_assignments()
returns table (user_id uuid, username text, name text, grade_class text, team_id uuid, team_role text)
language plpgsql stable security definer set search_path = public
as $$
begin
  if not public.is_app_admin(auth.uid()) then raise exception 'admin access required'; end if;
  return query
    select p.id, p.username, p.name, p.grade_class, p.team_id, p.team_role
    from public.profiles p
    where p.app_role = 'student' and p.is_active = true
    order by p.grade_class, p.name, p.username;
end; $$;
grant execute on function public.admin_get_team_assignments() to authenticated;

-- Admin: 학생 한 명의 팀/역할을 지정한다(team_id=null이면 팀 해제, team_role=null이면 일반 팀원).
create or replace function public.admin_set_member_team(
  target_user_id uuid, target_team_id uuid, target_team_role text default null
)
returns void language plpgsql security definer set search_path = public
as $$
begin
  if not public.is_app_admin(auth.uid()) then raise exception 'admin access required'; end if;
  if target_team_role is not null and target_team_role not in ('leader', 'vice_leader') then
    raise exception 'invalid team role';
  end if;
  if target_team_id is not null and target_team_role is not null and exists (
    select 1 from public.profiles
    where team_id = target_team_id and team_role = target_team_role and id <> target_user_id
  ) then
    raise exception '해당 팀에 이미 %가 있습니다', (case target_team_role when 'leader' then '팀장' else '부팀장' end);
  end if;
  update public.profiles set team_id = target_team_id, team_role = target_team_role where id = target_user_id;
end; $$;
grant execute on function public.admin_set_member_team(uuid, uuid, text) to authenticated;

-- 학생 공개 조회: 팀별 명단(리더/부리더 배지 표시용).
create or replace function public.get_team_roster()
returns table (
  team_id uuid, team_name text, team_sort_order int,
  user_id uuid, username text, name text, avatar_path text, team_role text, grade_class text
)
language sql stable security definer set search_path = public
as $$
  select t.id, t.name, t.sort_order, p.id, p.username, p.name, p.avatar_path, p.team_role, p.grade_class
  from public.teams t
  join public.profiles p on p.team_id = t.id
  where p.app_role = 'student' and p.is_active = true
  order by t.sort_order, t.name,
    case p.team_role when 'leader' then 0 when 'vice_leader' then 1 else 2 end, p.name;
$$;
grant execute on function public.get_team_roster() to authenticated;

-- 내부 헬퍼(비공개, authenticated에 직접 grant하지 않음): week_no(1~4)면 해당 주차 평일만,
-- null이면 운영기간(2026-08-10~09-06) 평일 전체를 대상으로 유저별 카테고리 분(分)을 계산한다.
-- get_home_rankings_by_week()와 동일한 산식이며, 팀이 배정된 유저로 한정한다.
create or replace function public.team_user_period_minutes(week_no int default null)
returns table (user_id uuid, pray_minutes bigint, word_minutes bigint, study_minutes bigint, worship_minutes bigint)
language sql stable security definer set search_path = public
as $$
  with range as (
    select
      (case when week_no is null then date '2026-08-10' else date '2026-08-10' + ((greatest(1, least(4, week_no)) - 1) * 7) end)::date as range_start,
      (case when week_no is null then date '2026-09-06' else date '2026-08-10' + ((greatest(1, least(4, week_no)) - 1) * 7) + 6 end)::date as range_end
  ),
  pray_min as (
    select r.user_id,
      coalesce(sum(case
        when e.value->>'start' ~ '^[0-9]{4}-[0-9]{2}-[0-9]{2}T[0-9]{2}:[0-9]{2}' and e.value->>'end' ~ '^[0-9]{4}-[0-9]{2}-[0-9]{2}T[0-9]{2}:[0-9]{2}'
        then greatest(0, extract(epoch from ((e.value->>'end')::timestamp - (e.value->>'start')::timestamp)) / 60)
        else 0 end), 0)::bigint as minutes
    from public.pray_records r
    cross join range g
    cross join lateral jsonb_array_elements(r.entries) e(value)
    where r.record_date between g.range_start and g.range_end and extract(isodow from r.record_date) between 1 and 5
    group by r.user_id
  ),
  word_min as (
    select r.user_id,
      coalesce(sum(60 + coalesce((
        select sum(case when verse.value->>'meditationMinutes' ~ '^[0-9]+([.][0-9]+)?$' then greatest(0, round((verse.value->>'meditationMinutes')::numeric)) else 0 end)
        from jsonb_array_elements(r.verses) with ordinality verse(value, position) where verse.position > 1
      ), 0)), 0)::bigint as minutes
    from public.word_records r
    cross join range g
    where r.record_date between g.range_start and g.range_end and extract(isodow from r.record_date) between 1 and 5
      and jsonb_array_length(r.verses) > 0
    group by r.user_id
  ),
  study_min as (
    select r.user_id,
      (coalesce(sum(coalesce(nullif(s.value->>'seconds', '')::numeric, 0)), 0) / 60)::bigint as minutes
    from public.study_records r
    cross join range g
    cross join lateral jsonb_array_elements(r.sessions) s(value)
    where r.record_date between g.range_start and g.range_end and extract(isodow from r.record_date) between 1 and 5
    group by r.user_id
  ),
  worship_min as (
    select r.user_id, coalesce(sum(r.minutes), 0)::bigint as minutes
    from public.worship_records r
    cross join range g
    where r.record_date between g.range_start and g.range_end and extract(isodow from r.record_date) between 1 and 5
    group by r.user_id
  )
  select p.id,
    coalesce(pm.minutes, 0)::bigint, coalesce(wm.minutes, 0)::bigint,
    coalesce(sm.minutes, 0)::bigint, coalesce(wo.minutes, 0)::bigint
  from public.profiles p
  left join pray_min pm on pm.user_id = p.id
  left join word_min wm on wm.user_id = p.id
  left join study_min sm on sm.user_id = p.id
  left join worship_min wo on wo.user_id = p.id
  where p.team_id is not null and p.app_role = 'student' and p.is_active = true;
$$;

-- 팀별 기도/말씀/공부/예배 누적 시간 합계 (첫 번째 차트용).
-- 반환 컬럼(worship_minutes 추가)이 바뀌어 create or replace만으로는 안 되므로 먼저 drop한다.
drop function if exists public.get_team_totals(int);
create or replace function public.get_team_totals(week_no int default null)
returns table (team_id uuid, team_name text, pray_minutes bigint, word_minutes bigint, study_minutes bigint, worship_minutes bigint)
language sql stable security definer set search_path = public
as $$
  select t.id, t.name,
    coalesce(sum(m.pray_minutes), 0)::bigint, coalesce(sum(m.word_minutes), 0)::bigint,
    coalesce(sum(m.study_minutes), 0)::bigint, coalesce(sum(m.worship_minutes), 0)::bigint
  from public.teams t
  left join public.profiles p on p.team_id = t.id and p.app_role = 'student' and p.is_active = true
  left join public.team_user_period_minutes(week_no) m on m.user_id = p.id
  group by t.id, t.name, t.sort_order
  order by t.sort_order, t.name;
$$;
grant execute on function public.get_team_totals(int) to authenticated;

-- 팀별 기여도(기도+말씀+공부+예배 총 분) Top 3 — 팀 명단에서 순위·비중(%) 표시용.
create or replace function public.get_team_contribution_top3(week_no int default null)
returns table (
  team_id uuid, team_name text, rank_no bigint,
  user_id uuid, username text, name text, avatar_path text, total_minutes bigint
)
language sql stable security definer set search_path = public
as $$
  with totals as (
    select p.id as user_id, p.team_id,
      (coalesce(m.pray_minutes, 0) + coalesce(m.word_minutes, 0) + coalesce(m.study_minutes, 0) + coalesce(m.worship_minutes, 0))::bigint as total_minutes
    from public.profiles p
    left join public.team_user_period_minutes(week_no) m on m.user_id = p.id
    where p.team_id is not null and p.app_role = 'student' and p.is_active = true
  ),
  ranked as (
    select t.*, row_number() over (partition by team_id order by total_minutes desc, user_id) as rank_no
    from totals t
  )
  select r.team_id, tm.name, r.rank_no, r.user_id, p.username, p.name, p.avatar_path, r.total_minutes
  from ranked r
  join public.teams tm on tm.id = r.team_id
  join public.profiles p on p.id = r.user_id
  where r.rank_no <= 3
  order by tm.sort_order, r.rank_no;
$$;
grant execute on function public.get_team_contribution_top3(int) to authenticated;

-- Control Panel(Word Test처럼 자체 탭에서 관리) 토글: Team 탭 전체 on/off.
insert into public.app_feature_flags (feature_key, label, section) values
  ('team', 'Team', 'Public')
on conflict (feature_key) do update set label = excluded.label, section = excluded.section;
