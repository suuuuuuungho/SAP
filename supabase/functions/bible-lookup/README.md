# API.Bible 연결 방법

1. [API.Bible](https://api.bible/)에서 계정을 만들고 API Key를 발급합니다.
2. Supabase Dashboard의 **Edge Functions → Secrets**에서 다음 값을 추가합니다.
   - Name: `API_BIBLE_KEY`
   - Value: 발급받은 API Key
3. `bible-lookup` Edge Function을 배포합니다.
   - Dashboard에서 새 Function 이름을 `bible-lookup`으로 만들고 `index.ts` 내용을 붙여넣어 Deploy하거나,
   - Supabase CLI에서 `supabase functions deploy bible-lookup`을 실행합니다.
4. Admin 페이지를 새로 열면 계정에서 사용할 수 있는 한국어 번역본이 자동으로 표시됩니다.

번역본마다 별도 라이선스 조건이 있으므로 API.Bible Dashboard에서 사용 권한을 확인해야 합니다. API Key는 HTML이나 `assets/config.js`에 넣지 않습니다.
