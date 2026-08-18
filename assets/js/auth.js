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
      .select('name, username, grade_class, is_admin, avatar_path, app_role, is_host, is_active')
      .eq('id', session.user.id)
      .maybeSingle();

    // profile_privacy_schema.sql 또는 home_admin_schema.sql 실행 전에도 기존 화면을 유지합니다.
    if (result.error) {
      result = await window.supabaseClient.from('profiles').select('name, username').eq('id', session.user.id).maybeSingle();
    }
    profile = result.data;
    if (profile) displayName = `${profile.name} (${profile.username})`;

    if (profile?.is_active === false) {
      await window.supabaseClient.auth.signOut();
      window.location.replace('login.html?inactive=1');
      return;
    }

    if (profile?.avatar_path) {
      const { data } = await window.supabaseClient.storage
        .from('profile-avatars')
        .createSignedUrl(profile.avatar_path, 3600);
      avatarUrl = data?.signedUrl || '';
    }

    const CONSOLE_TIER_ROLES = ['admin', 'teacher', 'pastor', 'department_head', 'secretary'];
    const isConsoleTier = !!(profile?.is_admin || profile?.is_host || CONSOLE_TIER_ROLES.includes(profile?.app_role));
    const isFullTier = !!profile?.is_host;
    const isCommentTier = isFullTier || profile?.app_role === 'pastor';
    document.querySelectorAll('[data-admin-only]').forEach((el) => {
      el.classList.toggle('hidden', !isConsoleTier);
      el.style.display = isConsoleTier ? '' : 'none';
    });
    document.querySelectorAll('[data-admin-full-only]').forEach((el) => {
      el.classList.toggle('hidden', !isFullTier);
      el.style.display = isFullTier ? '' : 'none';
    });
    document.querySelectorAll('[data-admin-comment-only]').forEach((el) => {
      el.classList.toggle('hidden', !isCommentTier);
      el.style.display = isCommentTier ? '' : 'none';
    });
    document.querySelectorAll('[data-member-nav]').forEach((el) => {
      el.classList.toggle('hidden', isConsoleTier);
      el.style.display = isConsoleTier ? 'none' : '';
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
        const role = profile?.is_admin || profile?.app_role === 'admin' || profile?.grade_class === '관리자' ? '관리자' : profile?.app_role === 'teacher' || profile?.grade_class === '교사' ? '교사' : '';
        const roleColor = role === '교사' ? 'bg-lime-500' : 'bg-blue-500';
        const hostBadge = profile?.is_host ? '<span class="inline-flex w-4 h-4 rounded-full bg-amber-100 text-amber-600 items-center justify-center align-middle ml-1" title="Host"><i class="fa-solid fa-crown text-[8px]"></i></span>' : '';
        badge.innerHTML = `${hostBadge}${role ? `<span class="inline-flex w-4 h-4 rounded-full ${roleColor} text-white items-center justify-center align-middle ml-1" title="${role}" aria-label="${role}"><i class="fa-solid fa-check text-[8px]"></i></span>` : ''}`;
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
      window.location.replace('login.html');
    } : null;
  });
}

window.initAuthUI = initAuthUI;
