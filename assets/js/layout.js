// Shared app shell (sidebar + mobile header) injected into every page.
// Each page provides a <template id="page-content"> with its own <h1> + body,
// and calls renderApp({ activePage: 'home' }) on DOMContentLoaded.

const NAV_ITEMS = [
  { id: 'home', label: 'Home', href: 'index.html', icon: 'fa-solid fa-house' },
  { id: 'study', label: 'Study', href: 'study.html', icon: 'fa-solid fa-book' },
  { id: 'gallery', label: 'Gallery', href: 'gallery.html', icon: 'fa-regular fa-image' },
  { id: 'stat', label: 'Stat', href: 'stat.html', icon: 'fa-solid fa-chart-line' }
];

function navLinkFull(item, activePage) {
  const isActive = item.id === activePage;
  const activeCls = isActive ? 'bg-sidebar-active text-text-primary' : 'hover:bg-sidebar-hover text-text-primary';
  return `
    <a href="${item.href}" class="flex items-center gap-3 px-3 py-2 rounded-md ${activeCls} font-medium text-sm transition-colors duration-200">
      <i class="${item.icon} w-4 text-center"></i>
      ${item.label}
    </a>`;
}

function navLinkIcon(item, activePage) {
  const isActive = item.id === activePage;
  const activeCls = isActive ? 'bg-gray-200 text-gray-900' : 'text-gray-600 hover:bg-gray-100';
  return `
    <a href="${item.href}" aria-label="${item.label}" class="nav-icon-item w-12 h-12 rounded-lg ${activeCls} flex items-center justify-center mx-auto transition-colors relative">
      <i class="${item.icon} text-lg"></i>
      <div class="nav-tooltip absolute left-14 bg-gray-800 text-white text-xs py-1 px-2 rounded pointer-events-none whitespace-nowrap z-50">${item.label}</div>
    </a>`;
}

function profileBlock(idSuffix) {
  return `
    <a href="login.html" id="sidebar-profile-${idSuffix}" class="flex items-center gap-3 cursor-pointer hover:bg-sidebar-hover p-2 rounded-md -mx-2 transition-colors">
      <div class="w-8 h-8 rounded-full bg-gray-800 text-white flex items-center justify-center font-semibold text-sm flex-shrink-0" data-role="avatar">?</div>
      <div class="flex flex-col overflow-hidden">
        <span class="text-sm font-medium truncate" data-role="name">로그인</span>
        <span class="text-xs text-text-secondary truncate" data-role="subtext">로그인이 필요합니다</span>
      </div>
    </a>`;
}

function renderShell(activePage) {
  const fullNav = NAV_ITEMS.map((item) => navLinkFull(item, activePage)).join('');
  const iconNav = NAV_ITEMS.map((item) => navLinkIcon(item, activePage)).join('');

  return `
    <div class="h-screen flex overflow-hidden bg-white text-text-primary">
      <!-- Desktop sidebar (>=lg): full labels -->
      <aside class="hidden lg:flex w-[260px] bg-sidebar-bg flex-col border-r border-border-color h-full flex-shrink-0">
        <div class="px-4 py-3 flex items-center justify-between hover:bg-sidebar-hover cursor-pointer transition-colors duration-200 mt-2">
          <div class="flex items-center gap-2 overflow-hidden">
            <span class="text-sm truncate font-bold">SAP 1기</span>
            <i class="fa-solid fa-chevron-down text-xs text-text-secondary"></i>
          </div>
          <button class="text-text-secondary hover:text-text-primary" aria-label="Switch workspace">
            <i class="fa-solid fa-table-columns text-sm"></i>
          </button>
        </div>
        <nav class="flex-1 overflow-y-auto scrollbar-hide py-2 px-3 flex flex-col gap-0.5">${fullNav}</nav>
        <div class="p-4 border-t border-border-color flex flex-col gap-4">${profileBlock('desktop')}</div>
      </aside>

      <!-- Tablet sidebar (md~lg): icon rail -->
      <aside class="hidden md:flex lg:hidden w-16 flex-shrink-0 bg-gray-50 border-r border-gray-200 flex-col items-center py-4 z-20">
        <button class="w-10 h-10 rounded-md hover:bg-gray-200 flex items-center justify-center mb-6 text-gray-600 transition-colors" aria-label="Switch workspace">
          <div class="w-6 h-6 bg-gray-800 text-white rounded text-xs flex items-center justify-center font-bold">S</div>
        </button>
        <nav class="flex-1 w-full flex flex-col gap-1 px-2">${iconNav}</nav>
        <div class="mt-auto flex flex-col gap-2 items-center pb-2 w-full px-2">
          <a href="login.html" aria-label="Profile" class="w-10 h-10 rounded-full bg-gray-800 text-white flex items-center justify-center text-sm font-bold mt-2" id="sidebar-profile-tablet" data-role="avatar">?</a>
        </div>
      </aside>

      <!-- Main column -->
      <div class="flex-1 flex flex-col overflow-hidden">
        <!-- Mobile top header (<md) -->
        <header class="md:hidden fixed top-0 left-0 right-0 h-14 bg-white border-b border-gray-100 z-30 flex items-center justify-between px-4">
          <div class="flex items-center gap-3">
            <button aria-label="Open menu" class="p-1 -ml-1 text-gray-600 hover:text-gray-900 focus:outline-none rounded-md" id="menu-toggle">
              <i class="fa-solid fa-bars text-xl"></i>
            </button>
            <div class="text-sm flex items-center gap-1 font-bold">SAP 1기 <i class="fa-solid fa-chevron-down text-xs text-gray-400"></i></div>
          </div>
          <div></div>
        </header>
        <main id="page-main" class="flex-1 overflow-y-auto bg-white relative mt-14 md:mt-0">
          <div class="max-w-[1200px] mx-auto px-4 sm:px-6 lg:px-8 py-8 lg:py-10 pb-24"></div>
        </main>
      </div>

      <!-- Mobile off-canvas sidebar (<md) -->
      <div class="md:hidden fixed inset-0 bg-black/40 z-40 hidden opacity-0 sidebar-overlay" id="sidebar-overlay"></div>
      <aside class="md:hidden fixed inset-y-0 left-0 w-[280px] bg-[#f9f9f9] z-50 -translate-x-full sidebar-offcanvas flex flex-col h-full border-r border-gray-200" id="sidebar-menu">
        <div class="p-4 flex justify-end">
          <button class="p-2 text-gray-500 hover:bg-gray-200 rounded-md" id="menu-close" aria-label="Close menu">
            <i class="fa-solid fa-xmark text-lg"></i>
          </button>
        </div>
        <nav class="flex-1 overflow-y-auto px-3 py-2 space-y-0.5">${fullNav}</nav>
        <div class="p-4 border-t border-gray-200">${profileBlock('mobile')}</div>
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
    sidebarMenu.classList.remove('-translate-x-full');
    sidebarOverlay.classList.remove('hidden');
    setTimeout(() => sidebarOverlay.classList.remove('opacity-0'), 10);
    body.style.overflow = 'hidden';
  }

  function closeMenu() {
    sidebarMenu.classList.add('-translate-x-full');
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
