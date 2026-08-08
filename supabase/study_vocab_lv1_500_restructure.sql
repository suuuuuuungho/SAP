-- SAP 1기 대시보드: Study 단어장을 Lv.1 앞 500개로 최종 정리.
-- Supabase 대시보드 -> SQL Editor에서 전체를 한 번 실행하세요.
-- 정렬 기준: 기존 study_day -> 기존 sort_order -> created_at -> id

begin;

do $$
begin
  if (select count(*) from public.vocab_words where level = 1) < 500 then
    raise exception 'Lv.1 단어가 500개보다 적어 정리를 중단합니다.';
  end if;
end $$;

create temporary table keep_vocab_words on commit drop as
select id,
       row_number() over (order by study_day, sort_order, created_at, id) as new_position
from public.vocab_words
where level = 1
order by study_day, sort_order, created_at, id
limit 500;

-- Lv.1 앞 500개 외에는 다른 레벨을 포함해 모두 제거합니다.
-- 삭제되는 단어의 vocab_progress는 FK(on delete cascade)로 함께 삭제됩니다.
delete from public.vocab_words v
where not exists (
  select 1 from keep_vocab_words k where k.id = v.id
);

-- 1~25 = Day 1, 26~50 = Day 2, ... 476~500 = Day 20.
update public.vocab_words v
set level = 1,
    study_day = ((k.new_position - 1) / 25)::integer + 1,
    sort_order = ((k.new_position - 1) % 25)::integer + 1,
    updated_at = now()
from keep_vocab_words k
where v.id = k.id;

do $$
declare
  total_count integer;
  day_count integer;
  invalid_day_count integer;
begin
  select count(*) into total_count from public.vocab_words;
  select count(distinct study_day) into day_count from public.vocab_words;
  select count(*) into invalid_day_count
  from (
    select study_day
    from public.vocab_words
    group by study_day
    having count(*) <> 25
  ) invalid_days;

  if total_count <> 500 or day_count <> 20 or invalid_day_count <> 0 then
    raise exception '검증 실패: total=%, days=%, invalid_days=%', total_count, day_count, invalid_day_count;
  end if;
end $$;

commit;

select level, study_day, count(*) as word_count,
       min(sort_order) as first_order, max(sort_order) as last_order
from public.vocab_words
group by level, study_day
order by level, study_day;
