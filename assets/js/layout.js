// Shared app shell (sidebar + mobile header) injected into every page.
// Each page provides a <template id="page-content"> with its own <h1> + body,
// and calls renderApp({ activePage: 'public-home' | 'mypage' | ... }) on DOMContentLoaded.
// Visual language: "Luminous Glass" — glassmorphic panels floating over a vibrant mesh background.

const NAV_ITEMS = [
  { id: 'public-home', label: 'Board', href: 'home.html', icon: 'fa-solid fa-clipboard-list' },
  // shared: true -> 학생/교사/관리자 등급과 무관하게 항상 보인다 (auth.js의
  // [data-member-nav] 숨김 로직 대상에서 제외). 다른 항목은 관리자/교사 등급이면
  // 숨겨지는 게 기존 의도된 동작이라 그대로 둔다.
  { id: 'hall-of-fame', label: 'Hall of Fame', href: 'hall-of-fame.html', icon: 'fa-solid fa-trophy', shared: true },
  { id: 'mypage', label: 'MyPage', href: 'index.html', icon: 'fa-solid fa-user' },
  { id: 'study', label: 'Study', href: 'study.html', icon: 'fa-solid fa-book' },
  { id: 'gallery', label: 'Gallery', href: 'gallery.html', icon: 'fa-regular fa-image' },
  { id: 'stat', label: 'Stat', href: 'stat.html', icon: 'fa-solid fa-chart-line' },
  { id: 'admin', label: 'Admin', href: 'admin.html', icon: 'fa-solid fa-sliders', adminOnly: true }
];

const ADMIN_NAV_GROUPS = [
  [
    { id: 'board', label: 'Board', icon: 'fa-solid fa-clipboard-list' },
    { id: 'gallery', label: 'Gallery', icon: 'fa-regular fa-images' },
    { id: 'comment', label: 'Comment', icon: 'fa-regular fa-comment-dots', tier: 'comment' }
  ],
  [
    { id: 'board-manage', label: 'Board manage', icon: 'fa-solid fa-bullhorn', full: true },
    { id: 'gallery-manage', label: 'Gallery manage', icon: 'fa-solid fa-photo-film', full: true },
    { id: 'control', label: 'Control Panel', icon: 'fa-solid fa-sliders', full: true },
    { id: 'member', label: 'Member', icon: 'fa-solid fa-users', full: true },
    { id: 'dashboard', label: 'Dashboard', icon: 'fa-solid fa-table-cells-large', full: true },
    { id: 'stat', label: 'Stat', icon: 'fa-solid fa-chart-line', full: true }
  ]
];

const OFFCANVAS_HIDDEN = '-translate-x-[120%]';

function navLinkFull(item, activePage) {
  const isActive = item.id === activePage;
  const activeCls = isActive ? 'nav-pill-active' : 'text-on-surface hover:bg-white/40';
  const visibilityAttr = item.shared ? '' : (item.adminOnly ? 'data-admin-only' : 'data-member-nav');
  const hiddenCls = item.adminOnly ? 'hidden' : '';
  return `
    <a href="${item.href}" ${visibilityAttr} class="${hiddenCls} flex items-center gap-3 px-4 py-2.5 rounded-full ${activeCls} font-medium text-sm transition-all duration-200">
      <i class="${item.icon} w-4 text-center"></i>
      ${item.label}
    </a>`;
}

function navLinkIcon(item, activePage) {
  const isActive = item.id === activePage;
  const activeCls = isActive ? 'nav-pill-active' : 'text-on-surface-variant hover:bg-white/40';
  const visibilityAttr = item.shared ? '' : (item.adminOnly ? 'data-admin-only' : 'data-member-nav');
  const hiddenCls = item.adminOnly ? 'hidden' : '';
  return `
    <a href="${item.href}" aria-label="${item.label}" ${visibilityAttr} class="${hiddenCls} nav-icon-item w-12 h-12 rounded-full ${activeCls} flex items-center justify-center mx-auto transition-all relative">
      <i class="${item.icon} text-lg"></i>
      <div class="nav-tooltip absolute left-16 glass-card text-on-surface text-xs py-1 px-2.5 rounded-full pointer-events-none whitespace-nowrap z-50">${item.label}</div>
    </a>`;
}

function adminNavTierAttr(item) {
  if (item.full) return 'data-admin-full-only';
  if (item.tier === 'comment') return 'data-admin-comment-only';
  return 'data-admin-only';
}

function adminNavFull() {
  const active = window.location.hash.replace('#', '') || 'board';
  return ADMIN_NAV_GROUPS.map((group, groupIndex) => `${groupIndex ? '<div class="flex items-center gap-2 px-3 pt-5 pb-2"><span class="h-px bg-outline-variant/60 flex-1"></span><span class="text-[9px] font-bold tracking-[.16em] text-on-surface-variant">MANAGEMENT</span><span class="h-px bg-outline-variant/60 flex-1"></span></div>' : ''}${group.map((item) => `
    <button type="button" ${adminNavTierAttr(item)} data-admin-tab="${item.id}" class="hidden flex w-full items-center gap-3 px-4 py-2.5 rounded-full ${item.id === active ? 'nav-pill-active' : 'text-on-surface hover:bg-white/40'} font-medium text-sm transition-all duration-200 text-left">
      <i class="${item.icon} w-4 text-center"></i><span>${item.label}</span>
    </button>`).join('')}`).join('');
}

function adminNavIcon() {
  const active = window.location.hash.replace('#', '') || 'board';
  return ADMIN_NAV_GROUPS.map((group, groupIndex) => `${groupIndex ? '<div class="h-px bg-outline-variant/60 mx-2 my-2"></div>' : ''}${group.map((item) => `
    <button type="button" aria-label="${item.label}" ${adminNavTierAttr(item)} data-admin-tab="${item.id}" class="hidden flex nav-icon-item w-12 h-12 rounded-full ${item.id === active ? 'nav-pill-active' : 'text-on-surface-variant hover:bg-white/40'} items-center justify-center mx-auto transition-all relative">
      <i class="${item.icon} text-lg"></i><div class="nav-tooltip absolute left-16 glass-card text-on-surface text-xs py-1 px-2.5 rounded-full pointer-events-none whitespace-nowrap z-50">${item.label}</div>
    </button>`).join('')}`).join('');
}

function profileBlock(idSuffix) {
  return `
    <div class="flex items-center gap-1">
      <a href="login.html" id="sidebar-profile-${idSuffix}" class="flex-1 min-w-0 flex items-center gap-3 cursor-pointer hover:bg-white/40 p-2 rounded-full transition-colors">
        <div class="icon-glass w-9 h-9 rounded-full text-on-surface flex items-center justify-center font-semibold text-sm flex-shrink-0 overflow-hidden" data-role="avatar">?</div>
        <div class="flex flex-col overflow-hidden">
          <span class="text-sm font-medium truncate text-on-surface"><span data-role="name">로그인</span><span data-role="profile-badge"></span></span>
          <span class="text-xs text-on-surface-variant truncate" data-role="subtext">로그인이 필요합니다</span>
        </div>
      </a>
      <button type="button" data-action="logout" class="hidden h-9 rounded-full flex-shrink-0 items-center justify-center gap-1.5 px-3 text-xs text-on-surface-variant hover:text-error hover:bg-white/40 transition-colors" aria-label="Logout" title="Logout">
        <i class="fa-solid fa-arrow-right-from-bracket text-xs"></i><span>Logout</span>
      </button>
    </div>`;
}

function renderShell(activePage) {
  const isAdminShell = activePage === 'admin';
  const fullNav = isAdminShell ? adminNavFull() : NAV_ITEMS.map((item) => navLinkFull(item, activePage)).join('');
  const iconNav = isAdminShell ? adminNavIcon() : NAV_ITEMS.map((item) => navLinkIcon(item, activePage)).join('');

  return `
    <div class="mesh-bg"></div>
    <div class="h-screen flex overflow-hidden text-on-surface">
      <!-- Desktop sidebar (>=lg): floating glass panel, full labels -->
      <aside class="hidden lg:flex w-[272px] m-4 rounded-[2rem] glass-panel flex-col flex-shrink-0 overflow-hidden">
        <div class="flex items-center justify-between hover:bg-white/30 cursor-pointer transition-colors duration-200 m-3 mb-1 p-2 rounded-2xl">
          <div class="flex items-center gap-2 overflow-hidden pl-1">
            <span class="text-sm truncate font-bold">SAP 1기</span>
            <i class="fa-solid fa-chevron-down text-xs text-on-surface-variant"></i>
          </div>
          <button class="icon-glass w-8 h-8 rounded-full flex items-center justify-center text-on-surface-variant hover:text-on-surface" aria-label="Switch workspace">
            <i class="fa-solid fa-table-columns text-xs"></i>
          </button>
        </div>
        <nav class="flex-1 overflow-y-auto scrollbar-hide py-2 px-3 flex flex-col gap-1">${fullNav}</nav>
        <div class="p-3 flex flex-col gap-2">${profileBlock('desktop')}</div>
      </aside>

      <!-- Tablet sidebar (md~lg): floating glass icon rail -->
      <aside class="hidden md:flex lg:hidden w-20 m-4 rounded-[2rem] glass-panel flex-shrink-0 flex-col items-center py-4 z-20">
        <button class="icon-glass w-10 h-10 rounded-full flex items-center justify-center mb-6 text-on-surface-variant transition-colors" aria-label="Switch workspace">
          <div class="w-6 h-6 bg-gradient-to-br from-primary-container to-tertiary-container text-white rounded-full text-xs flex items-center justify-center font-bold">S</div>
        </button>
        <nav class="flex-1 w-full flex flex-col gap-2 px-2">${iconNav}</nav>
        <div class="mt-auto flex flex-col gap-2 items-center pb-2 w-full px-2">
          <a href="login.html" aria-label="개인 프로필" class="relative w-10 h-10 mt-2" id="sidebar-profile-tablet">
            <span class="icon-glass w-10 h-10 rounded-full flex items-center justify-center text-on-surface text-sm font-bold overflow-hidden" data-role="avatar">?</span>
            <span class="absolute -right-1 -bottom-1" data-role="profile-badge"></span>
          </a>
          <button type="button" data-action="logout" class="hidden icon-glass w-10 h-10 rounded-full items-center justify-center text-on-surface-variant hover:text-error" aria-label="Logout" title="Logout"><i class="fa-solid fa-arrow-right-from-bracket text-xs"></i></button>
        </div>
      </aside>

      <!-- Main column -->
      <div class="flex-1 flex flex-col overflow-hidden">
        <!-- Mobile top header (<md): floating glass pill bar -->
        <header class="md:hidden fixed top-4 left-4 right-4 h-14 glass-panel rounded-full z-30 flex items-center justify-between px-4">
          <div class="flex items-center gap-3">
            <button aria-label="Open menu" class="p-1 -ml-1 text-on-surface-variant hover:text-on-surface focus:outline-none rounded-full" id="menu-toggle">
              <i class="fa-solid fa-bars text-xl"></i>
            </button>
            <div class="text-sm flex items-center gap-1 font-bold text-on-surface">SAP 1기 <i class="fa-solid fa-chevron-down text-xs text-on-surface-variant"></i></div>
          </div>
          <div></div>
        </header>
        <main id="page-main" class="flex-1 overflow-y-auto relative mt-24 md:mt-0">
          <div class="max-w-[1200px] mx-auto px-4 sm:px-6 lg:px-8 py-4 md:py-8 lg:py-10 pb-24"></div>
        </main>
      </div>

      <!-- Mobile off-canvas sidebar (<md): floating glass drawer -->
      <div class="md:hidden fixed inset-0 bg-on-surface/30 backdrop-blur-sm z-40 hidden opacity-0 sidebar-overlay" id="sidebar-overlay"></div>
      <aside class="md:hidden fixed inset-y-4 left-4 w-[280px] rounded-[2rem] glass-panel z-50 ${OFFCANVAS_HIDDEN} sidebar-offcanvas flex flex-col" id="sidebar-menu">
        <div class="p-4 flex justify-end">
          <button class="icon-glass w-9 h-9 rounded-full text-on-surface-variant flex items-center justify-center" id="menu-close" aria-label="Close menu">
            <i class="fa-solid fa-xmark text-lg"></i>
          </button>
        </div>
        <nav class="flex-1 overflow-y-auto px-3 py-2 space-y-1">${fullNav}</nav>
        <div class="p-3">${profileBlock('mobile')}</div>
      </aside>
    </div>`;
}

function wireMobileMenu() {
  const menuToggleBtn = document.getElementById('menu-toggle');
  const menuCloseBtn = document.getElementById('menu-close');
  const sidebarMenu = document.getElementById('sidebar-menu');
  const sidebarOverlay = document.getElementById('sidebar-overlay');
  const body = document.body;

  function openMenu() {
    sidebarMenu.classList.remove(OFFCANVAS_HIDDEN);
    sidebarOverlay.classList.remove('hidden');
    setTimeout(() => sidebarOverlay.classList.remove('opacity-0'), 10);
    body.style.overflow = 'hidden';
  }

  function closeMenu() {
    sidebarMenu.classList.add(OFFCANVAS_HIDDEN);
    sidebarOverlay.classList.add('opacity-0');
    setTimeout(() => sidebarOverlay.classList.add('hidden'), 300);
    body.style.overflow = '';
  }

  menuToggleBtn.addEventListener('click', openMenu);
  menuCloseBtn.addEventListener('click', closeMenu);
  sidebarOverlay.addEventListener('click', closeMenu);
}

async function applyFeatureFlags(activePage) {
  if (!window.supabaseClient || activePage === 'admin') return;
  const { data, error } = await window.supabaseClient.rpc('get_app_feature_flags');
  if (error) return; // 관리자 스키마 적용 전에는 기존 기능을 그대로 유지합니다.
  const flags = Object.fromEntries((data || []).map((item) => [item.feature_key, item.is_enabled]));
  window.APP_FEATURE_FLAGS = flags;
  const pageFeature = { 'public-home': 'board', 'hall-of-fame': 'hall_of_fame', mypage: 'mypage', study: 'study', gallery: 'gallery', stat: 'stat' }[activePage];
  NAV_ITEMS.forEach((item) => {
    const key = { 'public-home': 'board', 'hall-of-fame': 'hall_of_fame', mypage: 'mypage', study: 'study', gallery: 'gallery', stat: 'stat' }[item.id];
    if (key && flags[key] === false) document.querySelectorAll(`a[href="${item.href}"]`).forEach((link) => { link.classList.add('hidden'); link.style.display = 'none'; });
  });
  const hideClosest = (selector, key) => { if (flags[key] === false) document.querySelector(selector)?.closest('section')?.classList.add('hidden'); };
  hideClosest('#home-message-list', 'board_messages'); hideClosest('#home-verse-text', 'board_verse');
  hideClosest('#hof-ranking-grid', 'ranking');
  if (flags.ranking_weekly === false) document.querySelectorAll('[data-hof-tab]:not([data-hof-tab="total"])').forEach((btn) => btn.classList.add('hidden'));
  if (flags.pray === false) document.getElementById('widget-pray')?.classList.add('hidden');
  if (flags.word === false) document.getElementById('widget-word')?.classList.add('hidden');
  if (flags.study_timer === false) document.getElementById('widget-study')?.classList.add('hidden');
  if (flags.worship === false) document.getElementById('widget-worship')?.classList.add('hidden');
  if (flags.gallery_pray === false) document.getElementById('gallery-type-pray')?.classList.add('hidden');
  if (flags.gallery_word === false) document.getElementById('gallery-type-word')?.classList.add('hidden');
  if (flags.study_vocab === false) {
    const studyContent = document.getElementById('study-content');
    if (studyContent) studyContent.innerHTML = '<div class="glass-panel rounded-[2rem] p-10 text-center text-sm text-on-surface-variant">영단어 학습 기능이 현재 꺼져 있습니다.</div>';
  }
  if (flags.stat_summary === false) { document.getElementById('stat-streak-current')?.closest('section')?.classList.add('hidden'); document.getElementById('stat-kpi-total')?.closest('section')?.classList.add('hidden'); }
  hideClosest('#stat-heatmap', 'stat_heatmap');
  hideClosest('#stat-trend-chart', 'stat_trend');
  if (flags.stat_balance === false) document.getElementById('stat-radar-chart')?.closest('.glass-card')?.classList.add('hidden');
  if (flags.stat_breakdown === false) document.getElementById('stat-donut-chart')?.closest('.glass-card')?.classList.add('hidden');
  hideClosest('#stat-best-chips', 'stat_bests');
  if (flags.profile_photo === false) document.getElementById('profile-avatar-preview')?.closest('section')?.classList.add('hidden');
  if (flags.account_delete === false) document.getElementById('profile-delete-open')?.closest('section')?.classList.add('hidden');
  if (pageFeature && flags[pageFeature] === false) {
    const main = document.querySelector('#page-main > div');
    if (main) main.innerHTML = '<div class="glass-panel rounded-[2rem] p-12 text-center"><div class="icon-glass w-14 h-14 rounded-full mx-auto flex items-center justify-center text-on-surface-variant"><i class="fa-solid fa-power-off"></i></div><h1 class="text-xl font-bold mt-4">현재 사용할 수 없는 기능입니다</h1><p class="text-sm text-on-surface-variant mt-2">관리자가 기능을 잠시 꺼두었습니다.</p></div>';
  }
  window.dispatchEvent(new CustomEvent('app-feature-flags', { detail: flags }));
}

function renderApp({ activePage }) {
  const appRoot = document.getElementById('app');
  const template = document.getElementById('page-content');
  if (!appRoot || !template) return;

  appRoot.innerHTML = renderShell(activePage);
  appRoot.querySelector('#page-main > div').appendChild(template.content.cloneNode(true));
  wireMobileMenu();

  if (window.initAuthUI) window.initAuthUI();
  if (window.initHomeWidgets) window.initHomeWidgets();
  if (window.initPublicHomeWidgets) window.initPublicHomeWidgets();
  if (window.initHallOfFameWidgets) window.initHallOfFameWidgets();
  if (window.initStudyWidgets) window.initStudyWidgets();
  if (window.initGalleryWidgets) window.initGalleryWidgets();
  if (window.initStatWidgets) window.initStatWidgets();
  if (window.initAdminWidgets) window.initAdminWidgets();
  if (window.initProfileWidgets) window.initProfileWidgets();
  applyFeatureFlags(activePage);
}
