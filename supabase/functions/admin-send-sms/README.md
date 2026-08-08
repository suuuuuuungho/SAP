# admin-send-sms

1. `admin_console_schema.sql`을 먼저 실행합니다.
2. 기존 비밀번호 인증 문자와 같은 Secrets를 사용합니다: `SOLAPI_API_KEY`, `SOLAPI_API_SECRET`, `SOLAPI_SENDER_NUMBER`.
3. Supabase Edge Functions에서 `admin-send-sms`를 배포합니다. JWT 확인은 켠 상태로 둡니다.
4. Admin Dashboard의 문자 버튼은 관리자 로그인 토큰과 함께 이 함수를 호출합니다.
