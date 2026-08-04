// Requires: assets/config.js (window.APP_CONFIG) and the supabase-js CDN script, both loaded before this file.
window.supabaseClient = null;

if (window.supabase && window.APP_CONFIG && window.APP_CONFIG.SUPABASE_URL && window.APP_CONFIG.SUPABASE_ANON_KEY) {
  window.supabaseClient = window.supabase.createClient(
    window.APP_CONFIG.SUPABASE_URL,
    window.APP_CONFIG.SUPABASE_ANON_KEY
  );
} else {
  console.warn('[supabase-client] APP_CONFIG가 없습니다. assets/config.example.js를 assets/config.js로 복사하고 값을 채워주세요.');
}
