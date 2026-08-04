// Dashboard pages (index/study/gallery/stat) only: block rendering until a Supabase
// session is confirmed. No session -> redirect to login.html before the page ever
// shows anything, so the dashboard never flashes for a logged-out visitor.
async function requireAuth() {
  if (!window.supabaseClient) {
    console.warn('[auth-guard] Supabase 설정이 없어 로그인 여부를 확인할 수 없습니다. assets/config.example.js를 assets/config.js로 복사하고 값을 채워주세요.');
    window.location.replace('login.html');
    return false;
  }

  const { data: { session } } = await window.supabaseClient.auth.getSession();
  if (!session) {
    window.location.replace('login.html');
    return false;
  }

  return true;
}
