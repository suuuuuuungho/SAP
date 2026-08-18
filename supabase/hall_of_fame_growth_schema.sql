-- Hall of Fame 성장 랭킹.
-- Supabase Dashboard -> SQL Editor에서 hall_of_fame_schema.sql 실행 후 한 번 실행하세요.
-- 진행 중인 주차는 같은 요일까지 비교하며, 기준 주 활동이 0분인 학생은 상승률 랭킹에서 제외합니다.

create or replace function public.get_hof_growth_rankings(week_no int, elapsed_weekdays int)
returns table (
  comparison_type text,
  category text,
  rank_no bigint,
  user_id uuid,
  username text,
  name text,
  baseline_minutes bigint,
  current_minutes bigint,
  growth_rate numeric
)
language sql
stable
security definer
set search_path = public
as $$
with params as (
  select
    greatest(1, least(4, week_no)) as current_week,
    greatest(1, least(5, elapsed_weekdays)) as elapsed,
    (date '2026-08-10' + ((greatest(1, least(4, week_no)) - 1) * 7))::date as current_start
),
ranges as (
  select 'previous'::text comparison_type,
         (p.current_start - 7)::date baseline_start,
         (p.current_start - 7 + p.elapsed - 1)::date baseline_end,
         p.current_start,
         (p.current_start + p.elapsed - 1)::date current_end
  from params p where p.current_week > 1
  union all
  select 'first', date '2026-08-10', (date '2026-08-10' + p.elapsed - 1)::date,
         p.current_start, (p.current_start + p.elapsed - 1)::date
  from params p where p.current_week > 1
),
daily_values as (
  select 'pray'::text category, r.user_id, r.record_date,
         coalesce(sum(case
           when e.value->>'start' ~ '^[0-9]{4}-[0-9]{2}-[0-9]{2}T[0-9]{2}:[0-9]{2}'
            and e.value->>'end' ~ '^[0-9]{4}-[0-9]{2}-[0-9]{2}T[0-9]{2}:[0-9]{2}'
           then greatest(0, extract(epoch from ((e.value->>'end')::timestamp - (e.value->>'start')::timestamp)) / 60)
           else 0 end), 0)::bigint minutes
  from public.pray_records r
  cross join lateral jsonb_array_elements(r.entries) e(value)
  where r.record_date between date '2026-08-10' and date '2026-09-06'
    and extract(isodow from r.record_date) between 1 and 5
  group by r.user_id, r.record_date
  union all
  select 'word', r.user_id, r.record_date,
         (60 + coalesce((select sum(case
           when verse.value->>'meditationMinutes' ~ '^[0-9]+([.][0-9]+)?$'
           then greatest(0, round((verse.value->>'meditationMinutes')::numeric)) else 0 end)
           from jsonb_array_elements(r.verses) with ordinality verse(value, position)
           where verse.position > 1), 0))::bigint
  from public.word_records r
  where r.record_date between date '2026-08-10' and date '2026-09-06'
    and extract(isodow from r.record_date) between 1 and 5
    and jsonb_array_length(r.verses) > 0
  union all
  select 'study', r.user_id, r.record_date,
         (coalesce(sum(coalesce(nullif(s.value->>'seconds', '')::numeric, 0)), 0) / 60)::bigint
  from public.study_records r
  cross join lateral jsonb_array_elements(r.sessions) s(value)
  where r.record_date between date '2026-08-10' and date '2026-09-06'
    and extract(isodow from r.record_date) between 1 and 5
  group by r.user_id, r.record_date
  union all
  select 'worship', r.user_id, r.record_date, greatest(0, r.minutes)::bigint
  from public.worship_records r
  where r.record_date between date '2026-08-10' and date '2026-09-06'
    and extract(isodow from r.record_date) between 1 and 5
),
totals as (
  select rg.comparison_type, d.category, d.user_id,
         coalesce(sum(d.minutes) filter (where d.record_date between rg.baseline_start and rg.baseline_end), 0)::bigint baseline_minutes,
         coalesce(sum(d.minutes) filter (where d.record_date between rg.current_start and rg.current_end), 0)::bigint current_minutes
  from ranges rg
  join daily_values d on d.record_date between least(rg.baseline_start, rg.current_start) and rg.current_end
  group by rg.comparison_type, d.category, d.user_id
),
scored as (
  select t.*,
         round(((t.current_minutes - t.baseline_minutes)::numeric / t.baseline_minutes::numeric) * 100, 1) growth_rate
  from totals t
  where t.baseline_minutes > 0 and t.current_minutes > t.baseline_minutes
),
ranked as (
  select s.comparison_type, s.category, p.id user_id, p.username, p.name,
         s.baseline_minutes, s.current_minutes, s.growth_rate,
         row_number() over (
           partition by s.comparison_type, s.category
           order by s.growth_rate desc, s.current_minutes desc, p.name, p.username
         ) rank_no
  from scored s
  join public.profiles p on p.id = s.user_id
  where coalesce(p.is_active, true) = true and coalesce(p.app_role, 'student') = 'student'
)
select r.comparison_type, r.category, r.rank_no, r.user_id, r.username, r.name,
       r.baseline_minutes, r.current_minutes, r.growth_rate
from ranked r
where r.rank_no <= 5
order by case r.category when 'pray' then 1 when 'word' then 2 when 'study' then 3 else 4 end,
         case r.comparison_type when 'previous' then 1 else 2 end,
         r.rank_no;
$$;

revoke all on function public.get_hof_growth_rankings(int, int) from public;
grant execute on function public.get_hof_growth_rankings(int, int) to authenticated;
