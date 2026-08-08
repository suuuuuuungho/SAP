# 이메일 없는 비밀번호 재설정 배포

1. Supabase SQL Editor에서 `supabase/password_reset_schema.sql`을 실행합니다.
2. `reset-password-no-email` Edge Function을 `index.ts` 내용으로 배포합니다.
   - CLI: `supabase functions deploy reset-password-no-email`
   - 또는 Supabase Dashboard의 Edge Functions에서 같은 이름으로 생성 후 배포합니다.
3. 이 함수는 Supabase가 기본 제공하는 `SUPABASE_URL`, `SUPABASE_SERVICE_ROLE_KEY`를 사용하므로 별도 비밀값 등록은 필요하지 않습니다.

15분 동안 동일 아이디 또는 IP에서 최대 5회만 요청할 수 있습니다. 개인정보 일치 여부는 응답으로 노출하지 않습니다.
