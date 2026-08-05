-- SAP 1기 대시보드: Study 탭 — 이미 넣은 "중등 고난도" 900단어의 레벨 번호 수정.
-- Supabase 대시보드 → SQL Editor에서 실행하세요. (study_vocab_lv1_seed.sql 실행 이후, 아래
-- 다른 레벨 시드 파일들을 실행하기 전에 먼저 실행)
--
-- study_vocab_lv1_seed.sql을 만들 당시엔 "중등 고난도"가 Lv.1인 줄 알고 level=1로 넣었는데,
-- 실제 레벨 체계가 확정되면서 "중등 고난도"는 Lv.2로 재배정됐다. 이 시점엔 level=1인 행이
-- 전부 그 900단어뿐이라 단순 UPDATE로 안전하게 옮길 수 있다.
update public.vocab_words set level = 2 where level = 1;
