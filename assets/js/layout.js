// Shared app shell (sidebar + mobile header) injected into every page.
// Each page provides a <template id="page-content"> with its own <h1> + body,
// and calls renderApp({ activePage: 'home' }) on DOMContentLoaded.
// Visual language: "Luminous Glass" — glassmorphic panels floating over a vibrant mesh background.

const NAV_ITEMS = [
  { id: 'home', label: 'Home', href: 'index.html', icon: 'fa-solid fa-house' },
  { id: 'study', label: 'Study', href: 'study.html', icon: 'fa-solid fa-book' },
  { id: 'gallery', label: 'Gallery', href: 'gallery.html', icon: 'fa-regular fa-image' },
  { id: 'stat', label: 'Stat', href: 'stat.html', icon: 'fa-solid fa-chart-line' }
];

const OFFCANVAS_HIDDEN = '-translate-x-[120%]';

function navLinkFull(item, activePage) {
  const isActive = item.id === activePage;
  const activeCls = isActive ? 'nav-pill-active' : 'text-on-surface hover:bg-white/40';
  return `
    <a href="${item.href}" class="flex items-center gap-3 px-4 py-2.5 rounded-full ${activeCls} font-medium text-sm transition-all duration-200">
      <i class="${item.icon} w-4 text-center"></i>
      ${item.label}
    </a>`;
}

function navLinkIcon(item, activePage) {
  const isActive = item.id === activePage;
  const activeCls = isActive ? 'nav-pill-active' : 'text-on-surface-variant hover:bg-white/40';
  return `
    <a href="${item.href}" aria-label="${item.label}" class="nav-icon-item w-12 h-12 rounded-full ${activeCls} flex items-center justify-center mx-auto transition-all relative">
      <i class="${item.icon} text-lg"></i>
      <div class="nav-tooltip absolute left-16 glass-card text-on-surface text-xs py-1 px-2.5 rounded-full pointer-events-none whitespace-nowrap z-50">${item.label}</div>
    </a>`;
}

function profileBlock(idSuffix) {
  return `
    <a href="login.html" id="sidebar-profile-${idSuffix}" class="flex items-center gap-3 cursor-pointer hover:bg-white/40 p-2 rounded-full transition-colors">
      <div class="icon-glass w-9 h-9 rounded-full text-on-surface flex items-center justify-center font-semibold text-sm flex-shrink-0" data-role="avatar">?</div>
      <div class="flex flex-col overflow-hidden">
        <span class="text-sm font-medium truncate text-on-surface" data-role="name">로그인</span>
        <span class="text-xs text-on-surface-variant truncate" data-role="subtext">로그인이 필요합니다</span>
      </div>
    </a>`;
}

function renderShell(activePage) {
  const fullNav = NAV_ITEMS.map((item) => navLinkFull(item, activePage)).join('');
  const iconNav = NAV_ITEMS.map((item) => navLinkIcon(item, activePage)).join('');

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
          <div class="w-6 h-6 bg-gradient-to-br from-primary to-tertiary text-white rounded-full text-xs flex items-center justify-center font-bold">S</div>
        </button>
        <nav class="flex-1 w-full flex flex-col gap-2 px-2">${iconNav}</nav>
        <div class="mt-auto flex flex-col gap-2 items-center pb-2 w-full px-2">
          <a href="login.html" aria-label="Profile" class="icon-glass w-10 h-10 rounded-full flex items-center justify-center text-on-surface text-sm font-bold mt-2" id="sidebar-profile-tablet" data-role="avatar">?</a>
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

function renderApp({ activePage }) {
  const appRoot = document.getElementById('app');
  const template = document.getElementById('page-content');
  if (!appRoot || !template) return;

  appRoot.innerHTML = renderShell(activePage);
  appRoot.querySelector('#page-main > div').appendChild(template.content.cloneNode(true));
  wireMobileMenu();

  if (window.initAuthUI) window.initAuthUI();
}
