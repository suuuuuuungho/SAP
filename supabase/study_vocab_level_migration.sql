-- SAP 1기 대시보드: Study 탭에 레벨(Lv.0~4) 개념 추가.
-- Supabase 대시보드 → SQL Editor에서 실행하세요. (study_vocab_schema.sql 실행 이후에 실행)
--
-- Day 번호가 레벨마다 반복되므로(예: Lv.0의 Day 1과 Lv.1의 Day 1은 서로 다른 단어 세트),
-- level 컬럼을 추가해 (level, study_day)로 세트를 구분한다.
-- part_of_speech는 NOT NULL 제약을 풀어둔다 — 이번 배치는 예문과 함께 나중에 채울 예정이라
-- 지금은 word/meaning/level/study_day만 채워서 넣는다.

alter table public.vocab_words add column if not exists level integer not null default 1;
alter table public.vocab_words alter column part_of_speech drop not null;

create index if not exists vocab_words_level_day_idx on public.vocab_words (level, study_day, sort_order);

-- 이전에 검증용으로 넣었던 placeholder 더미 단어(love/faith/apple/run 등, study_vocab_schema.sql의
-- 3번 섹션) 삭제 — 실제 Lv.1 단어의 Day 1~4 번호와 겹쳐서 혼란을 주므로 정리한다.
delete from public.vocab_words
where word in ('love','faith','peace','grace','wisdom','strength','joy','hope','truth','mercy','humble','obey');
