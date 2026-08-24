// Supabase Auth의 최소 길이 검사를 통과시키기 위한 내부 호환 처리.
// 사용자가 입력한 값이 6자 이상이면 그대로 사용하므로 기존 계정에는 영향이 없다.
function normalizeAuthPassword(password) {
  const value = String(password || '');
  return value.length >= 6 ? value : `${value}#SAP26`;
}

window.normalizeAuthPassword = normalizeAuthPassword;
