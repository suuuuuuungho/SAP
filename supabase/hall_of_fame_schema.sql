-- Hall of Fame 탭: 기존에 Board(home.html)에 있던 실시간 랭킹을 이쪽으로 옮기고,
-- 주차별(Week1~4) 랭킹을 추가한다. 운영기간(2026-08-10~2026-09-06, 평일만)을
-- 월요일 시작 7일 단위 4구간으로 나눈다 — get_home_rankings()와 동일한 집계 로직을
-- week_no(1~4)로 받은 날짜 범위에만 적용한 버전이다.
--
-- Week1: 2026-08-10 ~ 2026-08-16 (평일만 08-10~08-14)
-- Week2: 2026-08-17 ~ 2026-08-23 (평일만 08-17~08-21)
-- Week3: 2026-08-24 ~ 2026-08-30 (평일만 08-24~08-28)
-- Week4: 2026-08-31 ~ 2026-09-06 (평일만 08-31~09-04)

create or replace function public.get_home_rankings_by_week(week_no int)
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
with week_range as (
  select
    (date '2026-08-10' + ((greatest(1, least(4, week_no)) - 1) * 7))::date as range_start,
    (date '2026-08-10' + ((greatest(1, least(4, week_no)) - 1) * 7) + 6)::date as range_end
),
pray_minutes as (
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
  cross join week_range w
  cross join lateral jsonb_array_elements(r.entries) e(value)
  where r.record_date between w.range_start and w.range_end
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
  cross join week_range w
  where r.record_date between w.range_start and w.range_end
    and extract(isodow from r.record_date) between 1 and 5
    and jsonb_array_length(r.verses) > 0
  group by r.user_id
),
study_minutes as (
  select r.user_id,
         (coalesce(sum(coalesce(nullif(s.value->>'seconds', '')::numeric, 0)), 0) / 60)::bigint as minutes
  from public.study_records r
  cross join week_range w
  cross join lateral jsonb_array_elements(r.sessions) s(value)
  where r.record_date between w.range_start and w.range_end
    and extract(isodow from r.record_date) between 1 and 5
  group by r.user_id
),
worship_minutes as (
  select r.user_id, coalesce(sum(r.minutes), 0)::bigint as minutes
  from public.worship_records r
  cross join week_range w
  where r.record_date between w.range_start and w.range_end
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

revoke all on function public.get_home_rankings_by_week(int) from public;
grant execute on function public.get_home_rankings_by_week(int) to authenticated;

-- ranking은 이제 Board가 아니라 Hall of Fame 탭 소속으로 다시 분류하고,
-- 주차별 랭킹 토글(ranking_weekly)과 탭 전체 토글(hall_of_fame)을 새로 추가한다.
insert into public.app_feature_flags (feature_key, label, section) values
  ('hall_of_fame', 'Hall of Fame', 'Public'),
  ('ranking_weekly', 'Weekly Ranking', 'Public')
on conflict (feature_key) do update set label = excluded.label, section = excluded.section;

update public.app_feature_flags set label = 'Overall Ranking', section = 'Public' where feature_key = 'ranking';
