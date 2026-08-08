// Updates every sidebar profile block (desktop/tablet/mobile) based on the current Supabase session.
// Called by layout.js right after the app shell is injected into the page.
async function initAuthUI() {
  const profiles = document.querySelectorAll('[id^="sidebar-profile-"]');
  if (!profiles.length) return;

  if (!window.supabaseClient) {
    return; // no Supabase config yet — leave default "로그인" state
  }

  const { data: { session } } = await window.supabaseClient.auth.getSession();

  let displayName = '';
  if (session && session.user) {
    displayName = session.user.email || '';
    let { data: profile, error: profileError } = await window.supabaseClient
      .from('profiles')
      .select('name, username, is_admin')
      .eq('id', session.user.id)
      .maybeSingle();
    // home_admin_schema.sql 실행 전에도 기존 페이지가 깨지지 않도록 구버전 스키마로 폴백.
    if (profileError) {
      const fallback = await window.supabaseClient.from('profiles').select('name, username').eq('id', session.user.id).maybeSingle();
      profile = fallback.data;
    }
    if (profile) displayName = `${profile.name} (${profile.username})`;
    document.querySelectorAll('[data-admin-only]').forEach((el) => el.classList.toggle('hidden', !profile || !profile.is_admin));
  }

  profiles.forEach((el) => {
    const avatar = el.querySelector('[data-role="avatar"]');
    const name = el.querySelector('[data-role="name"]');
    const subtext = el.querySelector('[data-role="subtext"]');

    if (session && session.user) {
      const initial = displayName.charAt(0).toUpperCase() || 'U';
      if (avatar) avatar.textContent = initial;
      if (name) name.textContent = displayName;
      if (subtext) subtext.textContent = '로그아웃';
      el.href = '#';
      el.onclick = async (e) => {
        e.preventDefault();
        await window.supabaseClient.auth.signOut();
        window.location.reload();
      };
    } else {
      if (avatar) avatar.textContent = '?';
      if (name) name.textContent = '로그인';
      if (subtext) subtext.textContent = '로그인이 필요합니다';
      el.href = 'login.html';
      el.onclick = null;
    }
  });
}

window.initAuthUI = initAuthUI;
