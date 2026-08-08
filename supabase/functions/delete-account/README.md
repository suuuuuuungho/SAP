# 회원탈퇴 Edge Function 배포

1. Supabase Dashboard → Edge Functions → Deploy a new function → Via Editor를 선택합니다.
2. 함수 이름을 정확히 `delete-account`로 입력합니다.
3. `index.ts` 전체 내용을 붙여넣고 배포합니다.
4. 이 함수는 로그인한 본인만 호출해야 하므로 `Verify JWT`를 켭니다.

별도 Secret은 필요하지 않습니다. Supabase가 기본 제공하는 `SUPABASE_URL`,
`SUPABASE_ANON_KEY`, `SUPABASE_SERVICE_ROLE_KEY`만 사용합니다.

탈퇴 시 인증사진과 프로필사진을 먼저 삭제한 뒤 Auth 사용자를 삭제합니다. 사용자 ID를
참조하는 기도·말씀·공부·예배·댓글·단어학습·서약 기록은 외래키의 `on delete cascade`로
함께 삭제됩니다.
