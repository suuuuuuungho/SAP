// 로그인 전 화면(회원가입/비밀번호 찾기)의 관리자 기능 스위치를 적용합니다.
document.addEventListener('DOMContentLoaded', async () => {
  const featureKey = document.body.dataset.requiredFeature;
  if (!featureKey || !window.supabaseClient) return;
  const { data, error } = await window.supabaseClient.rpc('get_app_feature_flags');
  if (error) return;
  const flag = (data || []).find((item) => item.feature_key === featureKey);
  if (!flag || flag.is_enabled) return;
  const label = featureKey === 'signup' ? '회원가입' : '비밀번호 찾기';
  document.body.innerHTML = `<div class="mesh-bg"></div><main class="relative z-10 glass-panel rounded-[2rem] p-10 w-full max-w-md text-center"><div class="icon-glass w-14 h-14 rounded-full mx-auto flex items-center justify-center text-on-surface-variant"><i class="fa-solid fa-power-off"></i></div><h1 class="text-xl font-bold mt-4">${label} 기능이 현재 꺼져 있습니다</h1><p class="text-sm text-on-surface-variant mt-2">관리자에게 문의해주세요.</p><a href="login.html" class="pill-btn-primary inline-block px-6 py-2.5 text-sm mt-6">로그인으로 돌아가기</a></main>`;
});
