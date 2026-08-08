// 현재 로그인 사용자의 사이드바 프로필과 독립된 로그아웃 버튼을 설정합니다.
async function initAuthUI() {
  const profileLinks = document.querySelectorAll('[id^="sidebar-profile-"]');
  const logoutButtons = document.querySelectorAll('[data-action="logout"]');
  if (!profileLinks.length || !window.supabaseClient) return;

  const { data: { session } } = await window.supabaseClient.auth.getSession();
  let displayName = '';
  let avatarUrl = '';
  let profile = null;

  if (session?.user) {
    displayName = session.user.email || '';
    let result = await window.supabaseClient
      .from('profiles')
      .select('name, username, grade_class, is_admin, avatar_path')
      .eq('id', session.user.id)
      .maybeSingle();

    // profile_privacy_schema.sql 또는 home_admin_schema.sql 실행 전에도 기존 화면을 유지합니다.
    if (result.error) {
      result = await window.supabaseClient.from('profiles').select('name, username').eq('id', session.user.id).maybeSingle();
    }
    profile = result.data;
    if (profile) displayName = `${profile.name} (${profile.username})`;

    if (profile?.avatar_path) {
      const { data } = await window.supabaseClient.storage
        .from('profile-avatars')
        .createSignedUrl(profile.avatar_path, 3600);
      avatarUrl = data?.signedUrl || '';
    }

    const isAdmin = !!profile?.is_admin;
    document.querySelectorAll('[data-admin-only]').forEach((el) => {
      el.classList.toggle('hidden', !isAdmin);
      el.style.display = isAdmin ? '' : 'none';
    });
    document.querySelectorAll('[data-member-nav]').forEach((el) => {
      el.classList.toggle('hidden', isAdmin);
      el.style.display = isAdmin ? 'none' : '';
    });
  }

  profileLinks.forEach((link) => {
    const avatar = link.matches('[data-role="avatar"]') ? link : link.querySelector('[data-role="avatar"]');
    const name = link.querySelector('[data-role="name"]');
    const subtext = link.querySelector('[data-role="subtext"]');
    const badge = link.querySelector('[data-role="profile-badge"]');

    if (session?.user) {
      if (avatarUrl) {
        avatar.innerHTML = `<img src="${avatarUrl}" alt="" class="w-full h-full object-cover">`;
      } else {
        avatar.textContent = displayName.charAt(0).toUpperCase() || 'U';
      }
      if (name) name.textContent = displayName;
      if (badge) {
        const role = profile?.is_admin || profile?.grade_class === '관리자' ? '관리자' : profile?.grade_class === '교사' ? '교사' : '';
        badge.innerHTML = role ? `<span class="inline-flex w-4 h-4 rounded-full bg-blue-500 text-white items-center justify-center align-middle ml-1" title="${role}" aria-label="${role}"><i class="fa-solid fa-check text-[8px]"></i></span>` : '';
      }
      if (subtext) subtext.textContent = '개인 프로필 보기';
      link.href = 'profile.html';
      link.onclick = null;
    } else {
      avatar.textContent = '?';
      if (name) name.textContent = '로그인';
      if (badge) badge.innerHTML = '';
      if (subtext) subtext.textContent = '로그인이 필요합니다';
      link.href = 'login.html';
      link.onclick = null;
    }
  });

  logoutButtons.forEach((button) => {
    button.classList.toggle('hidden', !session?.user);
    button.classList.toggle('flex', !!session?.user);
    button.onclick = session?.user ? async () => {
      button.disabled = true;
      await window.supabaseClient.auth.signOut();
      window.location.href = 'login.html';
    } : null;
  });
}

window.initAuthUI = initAuthUI;
