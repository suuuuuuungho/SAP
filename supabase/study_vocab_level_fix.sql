-- SAP 1기 대시보드: Study 탭 — 가장 먼저 넣었던 "중등 고난도" 900단어의 레벨 번호 수정.
-- Supabase 대시보드 → SQL Editor에서 실행하세요.
-- 순서: study_vocab_schema.sql, study_vocab_level_migration.sql은 이미 실행 완료.
--       이 파일이 지금 실행해야 할 첫 번째 파일이다.
--
-- 처음엔 "중등 고난도"가 Lv.1인 줄 알고 level=1로 넣었는데, 실제 레벨 체계가 확정되면서
-- "중등 고난도"는 Lv.2로 재배정됐다. 이 시점엔 level=1인 행이 전부 그 900단어뿐이라
-- 단순 UPDATE로 안전하게 옮길 수 있다.
update public.vocab_words set level = 2 where level = 1;
