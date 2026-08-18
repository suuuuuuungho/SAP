# admin-send-sms

1. `admin_console_schema.sql`을 먼저 실행합니다.
2. 기존 비밀번호 인증 문자와 같은 Secrets를 사용합니다: `SOLAPI_API_KEY`, `SOLAPI_API_SECRET`, `SOLAPI_SENDER_NUMBER`.
3. Supabase Edge Functions에서 `admin-send-sms`를 배포합니다. JWT 확인은 켠 상태로 둡니다.
4. Admin Dashboard의 문자 버튼은 관리자 로그인 토큰과 함께 이 함수를 호출합니다.
5. 개인 리포트 전송은 Member에 저장된 `parent_phone`으로 발송합니다. 변경 후 함수를 다시 배포하세요.
6. 리포트 문자는 클라이언트가 공유 토큰과 사이트 주소를 전달하고, Edge Function이 최종 링크를 조합해 발송합니다.
7. Board Message 예약 기능을 사용하려면 `board_message_schedule_schema.sql`을 실행한 뒤 이 함수를 다시 배포합니다.
8. Board Message의 시작 시각은 SOLAPI `scheduledDate`로 전달됩니다. 시작 전 수정·삭제·비활성화 시 저장된 그룹 ID로 예약을 취소합니다.
9. 문자 서명에 사용되는 관리자 이름은 클라이언트 문자열을 신뢰하지 않고, 전달받은 관리자 ID를 서버의 `profiles`에서 다시 검증합니다.
