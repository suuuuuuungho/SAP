// Requires: assets/config.js (window.APP_CONFIG) and the supabase-js CDN script, both loaded before this file.
window.supabaseClient = null;

// "자동 로그인" preference: when off, the session lives in sessionStorage (cleared when the
// browser closes) instead of localStorage, so the user has to log in again next visit.
const SAP_REMEMBER_KEY = 'sap_remember_me';
function sapAuthBackingStore() {
  return window.localStorage.getItem(SAP_REMEMBER_KEY) === '1' ? window.localStorage : window.sessionStorage;
}
const sapAuthStorage = {
  getItem: (key) => sapAuthBackingStore().getItem(key),
  setItem: (key, value) => sapAuthBackingStore().setItem(key, value),
  removeItem: (key) => sapAuthBackingStore().removeItem(key)
};

if (window.supabase && window.APP_CONFIG && window.APP_CONFIG.SUPABASE_URL && window.APP_CONFIG.SUPABASE_ANON_KEY) {
  window.supabaseClient = window.supabase.createClient(
    window.APP_CONFIG.SUPABASE_URL,
    window.APP_CONFIG.SUPABASE_ANON_KEY,
    { auth: { storage: sapAuthStorage } }
  );
} else {
  console.warn('[supabase-client] APP_CONFIG가 없습니다. assets/config.example.js를 assets/config.js로 복사하고 값을 채워주세요.');
}
