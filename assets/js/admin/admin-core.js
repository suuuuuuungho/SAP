// Admin 콘솔 공통 인프라: 접근 권한 체크, 상태 메시지, 탭 전환, 진입점(initAdminWidgets).
// 관리자 콘솔의 나머지 탭별 스크립트(admin-board-manage.js 등)는 전부 이 파일 다음에 로드되며,
// 클래식 스크립트는 전역 스코프를 공유하므로 여기 정의된 것들을 그대로 참조한다.

let adminCurrentUserId = null;
const ADMIN_REPORT_PUBLIC_SITE_URL = 'https://suuuuuuungho.github.io/SAP/';
const adminEscape = escapeHTML;

function adminShowStatus(message, isError = false) {
  const el = document.getElementById('admin-status');
  if (!el) return;
  el.textContent = message;
  el.classList.remove('hidden', 'text-error', 'text-quaternary');
  el.classList.add(isError ? 'text-error' : 'text-quaternary');
}

async function adminCheckAccess() {
  const { data: { session } } = await window.supabaseClient.auth.getSession();
  if (!session) return false;
  adminCurrentUserId = session.user.id;
  const { data, error } = await window.supabaseClient.rpc('can_view_admin_console');
  return !error && data === true;
}

async function adminCheckFullAccess() {
  const { data, error } = await window.supabaseClient.rpc('is_app_admin');
  return !error && data === true;
}

async function adminCheckCommentTabAccess() {
  if (adminFullAccess) return true;
  const { data, error } = await window.supabaseClient.from('profiles').select('app_role').eq('id', adminCurrentUserId).maybeSingle();
  return !error && data?.app_role === 'pastor';
}

let adminActiveTab = 'board';
let adminFullAccess = false;
let adminCommentTabAccess = false;

function adminRoleBadge(member) {
  const roleConfig = {
    admin: { label: 'Admin', color: 'bg-blue-500' },
    pastor: { label: '목사님', color: 'bg-teal-400' },
    department_head: { label: '부장님', color: 'bg-violet-300' },
    secretary: { label: '총무님', color: 'bg-orange-500' },
    teacher: { label: '교사', color: 'bg-lime-500' }
  }[member.app_role];
  const roleBadge = roleConfig
    ? `<span class="inline-flex w-4 h-4 rounded-full ${roleConfig.color} text-white items-center justify-center" title="${roleConfig.label}"><i class="fa-solid fa-check text-[8px]"></i></span>`
    : '';
  const host = member.is_host ? '<span class="inline-flex w-5 h-5 rounded-full bg-amber-100 text-amber-600 items-center justify-center" title="호스트"><i class="fa-solid fa-crown text-[9px]"></i></span>' : '';
  return `${host}${roleBadge}`;
}

function adminRoleLabel(role) {
  return { admin: 'Admin', pastor: '목사님', department_head: '부장님', secretary: '총무님', teacher: '교사', student: '학생' }[role] || role;
}

const ADMIN_PANEL_FOR_TAB = { 'gallery-manage': 'gallery' };
const ADMIN_FULL_ONLY_TABS = new Set(['board-manage', 'verse', 'gallery-manage', 'word-exam', 'team-manage', 'control', 'member', 'dashboard', 'stat']);

function adminWireTabs() {
  const validTabs = ['board', 'gallery', 'comment', 'board-manage', 'verse', 'gallery-manage', 'word-exam', 'team-manage', 'control', 'member', 'dashboard', 'stat'];
  const selectTab = (tab, historyMode = 'push') => {
    let nextTab = validTabs.includes(tab) ? tab : 'board';
    if (ADMIN_FULL_ONLY_TABS.has(nextTab) && !adminFullAccess) nextTab = 'board';
    if (nextTab === 'comment' && !adminCommentTabAccess) nextTab = 'board';
    adminActiveTab = nextTab;
    const nextUrl = `#${adminActiveTab}`;
    const nextState = { ...(window.history.state || {}), sapOverlay: null, adminTab: adminActiveTab };
    if (historyMode === 'push' && window.location.hash !== nextUrl) {
      if (window.history.state?.sapOverlay) window.history.replaceState(nextState, '', nextUrl);
      else window.history.pushState(nextState, '', nextUrl);
    }
    if (historyMode === 'replace') window.history.replaceState(nextState, '', nextUrl);
    document.querySelectorAll('[data-admin-tab]').forEach((item) => item.classList.toggle('nav-pill-active', item.dataset.adminTab === adminActiveTab));
    const panelId = ADMIN_PANEL_FOR_TAB[adminActiveTab] || adminActiveTab;
    document.querySelectorAll('[data-admin-panel]').forEach((panel) => panel.classList.toggle('hidden', panel.dataset.adminPanel !== panelId));
    if (adminActiveTab === 'gallery' || adminActiveTab === 'gallery-manage') window.setGalleryAdminMode?.(adminActiveTab === 'gallery-manage');
    if (adminActiveTab === 'word-exam') adminLoadWordExam();
    if (adminActiveTab === 'team-manage') adminLoadTeamManage();
    if (adminActiveTab === 'comment') adminLoadCommentTab();
    if (adminActiveTab === 'control') { adminLoadFeatures(); adminLoadCommentRoles(); }
    if (adminActiveTab === 'member') adminLoadMembers();
    if (adminActiveTab === 'dashboard') adminLoadDashboard();
    if (adminActiveTab === 'stat') adminLoadAllStats();
    document.getElementById('sidebar-menu')?.classList.add('-translate-x-[120%]');
    document.getElementById('sidebar-overlay')?.classList.add('hidden', 'opacity-0');
    document.body.style.overflow = '';
  };
  document.querySelectorAll('[data-admin-tab]').forEach((button) => button.addEventListener('click', () => selectTab(button.dataset.adminTab, 'push')));
  window.addEventListener('popstate', () => selectTab(window.location.hash.replace('#', '') || 'board', 'none'));
  selectTab(window.location.hash.replace('#', '') || 'board', 'replace');
}

function adminWireConsole() {
  adminWireTabs(); adminWireMember();
  adminWireWordExam();
  adminWireTeamManage();
  const dashboardDateInput = document.getElementById('admin-dashboard-date');
  if (dashboardDateInput) {
    const today = adminTodayDateValue();
    dashboardDateInput.value = dashboardDateInput.min && today < dashboardDateInput.min ? dashboardDateInput.min
      : dashboardDateInput.max && today > dashboardDateInput.max ? dashboardDateInput.max
      : today;
  }
  document.getElementById('admin-dashboard-date')?.addEventListener('change',adminLoadDashboard);
  document.getElementById('admin-dashboard-bulk-sms')?.addEventListener('click', adminSendBulkMissingSms);
  document.getElementById('admin-dashboard-bulk-report')?.addEventListener('click', adminSendBulkStudentReports);
  document.getElementById('admin-dashboard-export-excel')?.addEventListener('click', adminExportStudentReportLinks);
  document.getElementById('admin-sms-log-refresh')?.addEventListener('click', () => adminLoadSmsLogs(true));
  document.getElementById('admin-sms-log-pagination')?.addEventListener('click', (event) => {
    const button = event.target.closest('[data-sms-log-page]');
    if (!button || button.disabled) return;
    adminSmsLogPage = Number(button.dataset.smsLogPage);
    adminLoadSmsLogs();
  });
  document.getElementById('admin-stat-search')?.addEventListener('input', adminRenderAllStats);
  document.getElementById('admin-stat-role')?.addEventListener('change', adminRenderAllStats);
  document.getElementById('admin-stat-refresh')?.addEventListener('click', adminLoadAllStats);
}

async function initAdminWidgets() {
  const allowed = await adminCheckAccess();
  const denied = document.getElementById('admin-access-denied');
  const content = document.getElementById('admin-content');
  if (!allowed) {
    if (denied) denied.classList.remove('hidden');
    if (content) content.classList.add('hidden');
    return;
  }
  adminFullAccess = await adminCheckFullAccess();
  adminCommentTabAccess = await adminCheckCommentTabAccess();
  if (denied) denied.classList.add('hidden');
  if (content) content.classList.remove('hidden');
  if (adminFullAccess) {
    adminWireMessageForm();
    adminWireMessageList();
    adminWireVerseForm();
    adminWireVerseList();
    adminWireParentMessageForm();
    adminWireParentMessageList();
    await adminLoadUsers();
  }
  adminWireConsole();
  if (adminFullAccess) await Promise.all([adminLoadMessages(), adminLoadVerses(), adminLoadMembers(), adminLoadParentMessages()]);
}

window.initAdminWidgets = initAdminWidgets;
