-- SAP 1기 대시보드: Study 탭 — 검증용 더미 단어 12개 삭제 (2차 정리).
-- Supabase 대시보드 → SQL Editor에서 실행하세요. 지금 바로 실행해야 하는 파일.
--
-- study_vocab_level_migration.sql의 DELETE 문이 예전 초안(성경구절 버전, love/faith/peace...)의
-- 단어 목록을 그대로 쓰고 있어서, 실제로 study_vocab_schema.sql에 심어둔 검증용 더미
-- (apple/run/happy...)는 지워지지 않고 남아 있었다. 그 결과 study_vocab_level_fix.sql이
-- level=1 -> 2로 옮길 때 이 12개도 같이 딸려가서 Lv.2(중등 고난도)가 900개가 아니라
-- 912개로 보이는 상태다. 지금 바로 삭제한다.
delete from public.vocab_words
where word in ('apple','run','happy','quickly','friend','decide','important','however','explain','curious','brave','gentle')
  and level = 2;
