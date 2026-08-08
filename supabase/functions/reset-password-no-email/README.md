# SOLAPI 문자 인증 비밀번호 재설정 배포

1. Supabase SQL Editor에서 `supabase/password_reset_schema.sql` 전체를 실행합니다.
2. Supabase Dashboard의 Edge Functions > Secrets에 다음 값을 등록합니다.
   - `SOLAPI_API_KEY`: SOLAPI에서 발급받은 API Key
   - `SOLAPI_API_SECRET`: SOLAPI에서 발급받은 API Secret
   - `SOLAPI_SENDER_NUMBER`: SOLAPI에 등록되어 ACTIVE 상태인 발신번호(하이픈 없이 숫자만)
3. 기존 `reset-password-no-email` Edge Function의 코드를 이 폴더의 `index.ts` 내용으로 교체하고 다시 배포합니다.
4. 이 함수는 로그아웃 상태에서 호출하므로 Dashboard에서 Verify JWT를 끕니다.

## 동작 및 제한

- 가입 아이디·이름·전화번호가 모두 일치할 때만 문자로 6자리 인증번호를 보냅니다.
- 인증번호 유효시간은 3분이며, 5회 틀리면 더 이상 사용할 수 없습니다.
- 동일 번호는 1분 후 재발송할 수 있습니다.
- 동일 아이디 또는 IP에서는 15분에 최대 5회 요청할 수 있습니다.
- 인증 성공 후 발급되는 일회용 재설정 권한은 10분 동안 유효하며, 비밀번호 변경 후 재사용할 수 없습니다.
- 인증번호와 재설정 권한 원문은 데이터베이스에 저장하지 않습니다.
