// Admin 콘솔 — Dashboard 탭: 날짜별 학생 인증 현황, 미인증 안내 문자, 개인 리포트 발송/내보내기, 문자 로그.

let adminDashboardRows = [];
const ADMIN_DASHBOARD_PAGE_SIZE = 10;
let adminDashboardPage = 1;
const ADMIN_SMS_LOG_PAGE_SIZE = 15;
let adminSmsLogPage = 1;

function adminFormatMinutes(value) { const min = Number(value) || 0; return min >= 60 ? `${Math.floor(min / 60)}h ${min % 60 ? `${min % 60}m` : ''}` : `${min}m`; }
function adminDoneCell(done, minutes, key, required = true) {
  if (!required) return `<div class="flex items-center gap-2"><span class="admin-status-dot bg-surface-highest"></span><span class="text-xs font-semibold text-on-surface-variant">해당 없음</span><span class="sr-only">${key}</span></div>`;
  return `<div class="flex items-center gap-2"><span class="admin-status-dot ${done ? 'bg-quaternary' : 'bg-error/60'}"></span><span class="text-xs font-semibold">${done ? adminFormatMinutes(minutes) : '미인증'}</span><span class="sr-only">${key}</span></div>`;
}

function adminDashboardMobileStatus(label, done, minutes, required = true) {
  const stateClass = !required ? 'bg-surface-low text-on-surface-variant' : done ? 'bg-quaternary/10 text-quaternary' : 'bg-error/10 text-error';
  const value = !required ? '해당 없음' : done ? adminFormatMinutes(minutes) : '미인증';
  return `<div class="min-w-0 text-center"><p class="text-[9px] font-bold text-on-surface-variant mb-1">${label}</p><div class="min-h-8 rounded-lg px-0.5 flex items-center justify-center gap-1 ${stateClass}"><span class="w-1.5 h-1.5 rounded-full flex-shrink-0 ${!required ? 'bg-surface-highest' : done ? 'bg-quaternary' : 'bg-error/60'}"></span><span class="text-[9px] leading-tight font-bold">${value}</span></div></div>`;
}

function adminDashboardActionsHTML(missing, mobile = false) {
  const size = mobile ? 'w-9 h-9' : 'w-9 h-9';
  return `<div class="flex items-center gap-2 ${mobile ? 'justify-end' : ''}"><button data-report-view class="icon-glass ${size} rounded-full text-primary" title="개인 리포트 보기" aria-label="개인 리포트 보기"><i class="fa-solid fa-file-lines text-sm"></i></button><button data-report-sms class="icon-glass ${size} rounded-full text-emerald-500" title="학부모에게 리포트 링크 전송" aria-label="학부모에게 리포트 링크 전송"><i class="fa-solid fa-link text-sm"></i></button><button data-sms data-missing="${adminEscape(missing.join(', '))}" class="icon-glass ${size} rounded-full ${missing.length ? 'text-sky-500' : 'opacity-30'}" ${missing.length ? '' : 'disabled'} title="학생에게 미인증 문자 발송" aria-label="학생에게 미인증 문자 발송"><i class="fa-solid fa-paper-plane text-sm"></i></button></div>`;
}

async function adminLoadDashboard() {
  const date = document.getElementById('admin-dashboard-date')?.value || '2026-08-10';
  const { data, error } = await window.supabaseClient.rpc('admin_get_dashboard', { target_date: date });
  if (error) { adminShowStatus('인증 현황을 불러오지 못했습니다. 관리자 스키마를 확인해주세요.', true); return; }
  adminDashboardRows = (data || []).filter((row) => !row.app_role || row.app_role === 'student');
  adminDashboardPage = 1;
  adminRenderDashboard();
  await adminLoadSmsLogs();
}

function adminDashboardGroup(gradeClass) {
  const value = String(gradeClass || '').trim();
  let match = value.match(/^([1-3])-(\d+)반$/);
  if (match) return { grade: `${match[1]}학년`, className: `${match[2]}반` };
  match = value.match(/^신입(\d+)반$/);
  if (match) return { grade: '신입반', className: `${match[1]}반` };
  return { grade: value || '미지정', className: value || '미지정' };
}

function adminDashboardMissing(row, worshipRequired) {
  return [['기도', row.pray_done], ['말씀', row.word_done], ['공부', row.study_done], ...(worshipRequired ? [['예배', row.worship_done]] : [])]
    .filter(([, done]) => !done).map(([name]) => name);
}

function adminFilteredDashboardRows() {
  return adminDashboardRows;
}

function adminRenderDashboard() {
  const date = document.getElementById('admin-dashboard-date')?.value || '2026-08-10';
  const worshipRequired = [3, 5].includes(new Date(`${date}T12:00:00`).getDay());
  const cats = worshipRequired ? ['pray_done','word_done','study_done','worship_done'] : ['pray_done','word_done','study_done'];
  const completed = adminDashboardRows.filter((row) => cats.every((cat) => row[cat])).length;
  const pending = adminDashboardRows.length - completed;
  document.getElementById('admin-dashboard-summary').innerHTML = [
    ['students',adminDashboardRows.length,'전체 학생수'],['complete',completed,worshipRequired ? '4개 인증완료' : '3개 인증완료'],['needs-action',pending,'하나 이상 미인증'],['completion',(adminDashboardRows.length ? `${Math.round(completed/adminDashboardRows.length*100)}%` : '0%'),'완료 학생 비율']
  ].map(([key,value,desc]) => `<article class="glass-card rounded-2xl p-4"><p class="text-2xl font-bold ${key==='needs-action'&&pending?'text-error':'text-primary'}">${value}</p><p class="text-xs font-bold text-on-surface-variant mt-2">${desc}</p></article>`).join('');
  const filtered = adminFilteredDashboardRows();
  const totalPages = Math.max(1, Math.ceil(filtered.length / ADMIN_DASHBOARD_PAGE_SIZE));
  adminDashboardPage = Math.min(adminDashboardPage, totalPages);
  const pageRows = filtered.slice((adminDashboardPage - 1) * ADMIN_DASHBOARD_PAGE_SIZE, adminDashboardPage * ADMIN_DASHBOARD_PAGE_SIZE);
  const wrap = document.getElementById('admin-dashboard-list');
  const empty = '<p class="text-sm text-on-surface-variant py-10 text-center">학생이 없습니다.</p>';
  const mobileCards = pageRows.map((row) => { const missing = adminDashboardMissing(row, worshipRequired); return `<article class="glass-card rounded-2xl p-3" data-dashboard-user="${row.user_id}"><div class="flex items-center justify-between gap-3 mb-3"><div class="min-w-0"><p class="text-sm font-bold truncate">${adminEscape(row.name)}</p><p class="text-[10px] text-on-surface-variant truncate">@${adminEscape(row.username)}</p></div>${adminDashboardActionsHTML(missing, true)}</div><div class="grid grid-cols-4 gap-1">${adminDashboardMobileStatus('기도',row.pray_done,row.pray_minutes)}${adminDashboardMobileStatus('말씀',row.word_done,row.word_minutes)}${adminDashboardMobileStatus('공부',row.study_done,row.study_minutes)}${adminDashboardMobileStatus('예배',row.worship_done,row.worship_minutes,worshipRequired)}</div></article>`; }).join('');
  const desktopRows = pageRows.map((row) => { const missing = adminDashboardMissing(row, worshipRequired); return `<article class="grid grid-cols-[minmax(150px,1.45fr)_repeat(4,minmax(68px,.8fr))_132px] gap-2 items-center glass-card rounded-2xl px-3 py-3 mb-2" data-dashboard-user="${row.user_id}"><div class="min-w-0"><p class="text-sm font-bold truncate">${adminEscape(row.name)}</p><p class="text-[10px] text-on-surface-variant truncate">@${adminEscape(row.username)}</p></div>${adminDoneCell(row.pray_done,row.pray_minutes,'pray')}${adminDoneCell(row.word_done,row.word_minutes,'word')}${adminDoneCell(row.study_done,row.study_minutes,'study')}${adminDoneCell(row.worship_done,row.worship_minutes,'worship',worshipRequired)}${adminDashboardActionsHTML(missing)}</article>`; }).join('');
  wrap.innerHTML = pageRows.length ? `<div class="xl:hidden flex flex-col gap-3">${mobileCards}</div><div class="hidden xl:block max-h-[70vh] overflow-y-auto scrollbar-hide rounded-2xl"><div class="sticky top-0 z-20 grid grid-cols-[minmax(150px,1.45fr)_repeat(4,minmax(68px,.8fr))_132px] gap-2 px-3 py-3 mb-2 text-[10px] font-bold tracking-wider text-on-surface-variant bg-white/95 backdrop-blur-xl shadow-sm rounded-xl"><span>학생</span><span>기도</span><span>말씀</span><span>공부</span><span>예배</span><span>관리</span></div>${desktopRows}</div>` : empty;
  wrap.querySelectorAll('[data-sms]').forEach((button) => button.addEventListener('click', () => adminSendMissingSms(button.closest('[data-dashboard-user]').dataset.dashboardUser, button.dataset.missing)));
  wrap.querySelectorAll('[data-report-view]').forEach((button) => button.addEventListener('click', () => adminOpenStudentReport(button.closest('[data-dashboard-user]').dataset.dashboardUser)));
  wrap.querySelectorAll('[data-report-sms]').forEach((button) => button.addEventListener('click', () => adminSendStudentReport(button.closest('[data-dashboard-user]').dataset.dashboardUser, button)));
  adminRenderDashboardPagination(filtered.length, totalPages);
  const bulkButton = document.getElementById('admin-dashboard-bulk-sms');
  if (bulkButton) bulkButton.disabled = pending === 0;
}

function adminRenderDashboardPagination(total, totalPages) {
  const wrap = document.getElementById('admin-dashboard-pagination');
  if (!wrap) return;
  const start = total ? (adminDashboardPage - 1) * ADMIN_DASHBOARD_PAGE_SIZE + 1 : 0;
  const end = Math.min(adminDashboardPage * ADMIN_DASHBOARD_PAGE_SIZE, total);
  const pageButtons = Array.from({ length: totalPages }, (_, index) => index + 1)
    .filter((page) => page === 1 || page === totalPages || Math.abs(page - adminDashboardPage) <= 2)
    .map((page, index, pages) => `${index > 0 && page - pages[index - 1] > 1 ? '<span class="text-on-surface-variant">…</span>' : ''}<button type="button" data-dashboard-page="${page}" class="w-9 h-9 rounded-full text-xs font-bold ${page === adminDashboardPage ? 'nav-pill-active' : 'glass-card'}">${page}</button>`).join('');
  wrap.innerHTML = `<span class="text-xs text-on-surface-variant mr-2">${start}-${end} / ${total}명</span><button type="button" data-dashboard-page="${adminDashboardPage - 1}" class="icon-glass w-9 h-9 rounded-full" ${adminDashboardPage <= 1 ? 'disabled' : ''}><i class="fa-solid fa-chevron-left text-xs"></i></button>${pageButtons}<button type="button" data-dashboard-page="${adminDashboardPage + 1}" class="icon-glass w-9 h-9 rounded-full" ${adminDashboardPage >= totalPages ? 'disabled' : ''}><i class="fa-solid fa-chevron-right text-xs"></i></button>`;
  wrap.querySelectorAll('[data-dashboard-page]').forEach((button) => button.addEventListener('click', () => { adminDashboardPage = Number(button.dataset.dashboardPage); adminRenderDashboard(); }));
}

async function adminCreateStudentReportLink(userId) {
  const { data, error } = await window.supabaseClient.rpc('admin_create_student_report_link', { target_user_id: userId });
  if (error || !data) throw new Error(error?.message || '리포트 링크를 만들지 못했습니다.');
  const url = new URL('report.html', window.location.href);
  url.searchParams.set('token', data);
  return { token: String(data), url: url.href };
}

async function adminOpenStudentReport(userId) {
  const popup = window.open('', '_blank');
  try {
    const report = await adminCreateStudentReportLink(userId);
    if (popup) popup.location.href = report.url; else window.open(report.url, '_blank', 'noopener');
  } catch (error) {
    if (popup) popup.close();
    adminShowStatus(error.message || '리포트를 열지 못했습니다.', true);
  }
}

async function adminSendStudentReport(userId, button) {
  const row = adminDashboardRows.find((item) => item.user_id === userId);
  const member = adminMembers.find((item) => item.id === userId);
  const parentPhone = row?.parent_phone || member?.parent_phone || '';
  const studentName = row?.name || member?.name || '학생';
  if (!parentPhone) { adminShowStatus(`${studentName} 학생의 학부모 연락처가 없습니다. Member에서 입력해주세요.`, true); return; }
  if (!confirm(`${studentName} 학생의 개인 리포트 링크를 학부모에게 보낼까요?`)) return;
  const original = button.innerHTML;
  button.disabled = true;
  button.innerHTML = '<i class="fa-solid fa-spinner fa-spin text-sm"></i>';
  try {
    const report = await adminCreateStudentReportLink(userId);
    // Admin 미리보기 주소(blob/data/localhost)가 문자에 들어가지 않도록 실제 GitHub Pages 주소를 사용합니다.
    const siteUrl = window.APP_CONFIG?.PUBLIC_SITE_URL || ADMIN_REPORT_PUBLIC_SITE_URL;
    const { data, error } = await window.supabaseClient.functions.invoke('admin-send-sms', { body: { mode: 'report', userId, reportToken: report.token, siteUrl, date: document.getElementById('admin-dashboard-date').value } });
    if (error || !data?.ok) throw new Error(data?.message || '문자를 보내지 못했습니다.');
    adminShowStatus(`${studentName} 학생의 학부모에게 리포트 링크를 보냈습니다.`);
    await adminLoadSmsLogs(true);
  } catch (error) {
    adminShowStatus(error.message || '리포트 링크를 보내지 못했습니다.', true);
  } finally {
    button.disabled = false;
    button.innerHTML = original;
  }
}

async function adminSendBulkStudentReports() {
  const date = document.getElementById('admin-dashboard-date')?.value || '2026-08-10';
  const targets = adminDashboardRows.filter((row) => String(row.parent_phone || '').replace(/\D/g, '').length >= 10);
  const missingPhoneCount = adminDashboardRows.length - targets.length;
  if (!targets.length) { adminShowStatus('학부모 연락처가 등록된 학생이 없습니다.', true); return; }
  const notice = missingPhoneCount ? `\n학부모 연락처가 없는 ${missingPhoneCount}명은 제외됩니다.` : '';
  if (!confirm(`전체 학생 ${adminDashboardRows.length}명 중 ${targets.length}명의 학부모에게 개인 리포트를 발송할까요?${notice}`)) return;

  const button = document.getElementById('admin-dashboard-bulk-report');
  const original = button?.innerHTML || '';
  if (button) { button.disabled = true; button.innerHTML = `<i class="fa-solid fa-spinner fa-spin mr-2"></i>발송 중 0/${targets.length}`; }
  let cursor = 0;
  let success = 0;
  let failed = 0;
  const siteUrl = window.APP_CONFIG?.PUBLIC_SITE_URL || ADMIN_REPORT_PUBLIC_SITE_URL;
  const worker = async () => {
    while (cursor < targets.length) {
      const target = targets[cursor++];
      try {
        const report = await adminCreateStudentReportLink(target.user_id);
        const { data, error } = await window.supabaseClient.functions.invoke('admin-send-sms', { body: { mode: 'report', userId: target.user_id, reportToken: report.token, siteUrl, date } });
        if (error || !data?.ok) throw new Error(data?.message || '발송 실패');
        success += 1;
      } catch (error) {
        console.error('[adminSendBulkStudentReports]', target.user_id, error);
        failed += 1;
      }
      if (button) button.innerHTML = `<i class="fa-solid fa-spinner fa-spin mr-2"></i>발송 중 ${success + failed}/${targets.length}`;
    }
  };
  await Promise.all(Array.from({ length: Math.min(3, targets.length) }, worker));
  if (button) { button.disabled = false; button.innerHTML = original; }
  adminShowStatus(`리포트 일괄 발송 완료: 성공 ${success}명 · 실패 ${failed}명${missingPhoneCount ? ` · 연락처 미입력 ${missingPhoneCount}명` : ''}`, failed > 0);
  await adminLoadSmsLogs(true);
}

async function adminExportStudentReportLinks() {
  if (typeof XLSX === 'undefined') { adminShowStatus('엑셀 내보내기 라이브러리를 불러오지 못했습니다. 새로고침 후 다시 시도해주세요.', true); return; }
  const rows = adminDashboardRows;
  if (!rows.length) { adminShowStatus('내보낼 학생이 없습니다.', true); return; }
  if (!confirm(`학생 ${rows.length}명의 개인 리포트 링크를 새로 생성해서 엑셀로 내보낼까요?`)) return;

  const button = document.getElementById('admin-dashboard-export-excel');
  const original = button?.innerHTML || '';
  if (button) { button.disabled = true; button.innerHTML = `<i class="fa-solid fa-spinner fa-spin mr-2"></i>생성 중 0/${rows.length}`; }

  // 문자 발송과 동일하게, 관리자가 로컬/미리보기 주소에서 실행해도 링크는 항상
  // 실제 GitHub Pages 주소를 가리키도록 한다.
  const siteUrl = window.APP_CONFIG?.PUBLIC_SITE_URL || ADMIN_REPORT_PUBLIC_SITE_URL;
  const results = new Array(rows.length);
  let cursor = 0;
  let done = 0;
  let failed = 0;
  const worker = async () => {
    while (cursor < rows.length) {
      const index = cursor++;
      const row = rows[index];
      try {
        const report = await adminCreateStudentReportLink(row.user_id);
        const reportUrl = new URL('report.html', siteUrl);
        reportUrl.searchParams.set('token', report.token);
        results[index] = { 학생이름: row.name, 학년반: row.grade_class || '', 개인리포트링크: reportUrl.href };
      } catch (error) {
        console.error('[adminExportStudentReportLinks]', row.user_id, error);
        results[index] = { 학생이름: row.name, 학년반: row.grade_class || '', 개인리포트링크: '링크 생성 실패' };
        failed += 1;
      }
      done += 1;
      if (button) button.innerHTML = `<i class="fa-solid fa-spinner fa-spin mr-2"></i>생성 중 ${done}/${rows.length}`;
    }
  };
  await Promise.all(Array.from({ length: Math.min(3, rows.length) }, worker));

  const worksheet = XLSX.utils.json_to_sheet(results);
  worksheet['!cols'] = [{ wch: 14 }, { wch: 12 }, { wch: 62 }];
  const workbook = XLSX.utils.book_new();
  XLSX.utils.book_append_sheet(workbook, worksheet, '개인리포트링크');
  const dateStr = document.getElementById('admin-dashboard-date')?.value || adminTodayDateValue();
  XLSX.writeFile(workbook, `SAP_학생_리포트링크_${dateStr}.xlsx`);

  if (button) { button.disabled = false; button.innerHTML = original; }
  adminShowStatus(`엑셀 파일을 내려받았습니다 (성공 ${rows.length - failed}명${failed ? ` · 실패 ${failed}명` : ''}).`, failed > 0);
}

async function adminSendMissingSms(userId, missing) {
  const row = adminDashboardRows.find((item) => item.user_id === userId);
  const member = adminMembers.find((item) => item.id === userId);
  const studentPhone = row?.phone || member?.phone || '';
  if (!studentPhone) { adminShowStatus(`${row?.name || member?.name || '학생'}의 본인 연락처가 없습니다. Member에서 입력해주세요.`, true); return; }
  const studentName = row?.name || member?.name || '학생';
  if (!confirm(`${studentName} 학생에게 미인증 안내 문자를 보낼까요?\n현재 미인증: ${missing}`)) return;
  const { data, error } = await window.supabaseClient.functions.invoke('admin-send-sms', { body: { userId, date: document.getElementById('admin-dashboard-date').value, missing: missing.split(', ') } });
  if (error || !data?.ok) adminShowStatus(data?.message || '문자를 보내지 못했습니다.', true); else adminShowStatus(`${studentName} 학생에게 문자를 보냈습니다.`);
  await adminLoadSmsLogs(true);
}

async function adminSendBulkMissingSms() {
  const date = document.getElementById('admin-dashboard-date')?.value || '2026-08-10';
  const worshipRequired = [3, 5].includes(new Date(`${date}T12:00:00`).getDay());
  const targets = adminDashboardRows.map((row) => ({ row, missing: adminDashboardMissing(row, worshipRequired) })).filter((item) => item.missing.length > 0);
  if (!targets.length) { adminShowStatus('미인증 학생이 없습니다.'); return; }
  if (!confirm(`${date} 미인증 학생 ${targets.length}명에게 문자를 발송할까요?\n학생별 미인증 항목이 각각 포함됩니다.`)) return;
  const button = document.getElementById('admin-dashboard-bulk-sms');
  if (button) { button.disabled = true; button.innerHTML = '<i class="fa-solid fa-spinner fa-spin mr-2"></i>발송 중 0/' + targets.length; }
  let cursor = 0; let success = 0; let failed = 0;
  const worker = async () => {
    while (cursor < targets.length) {
      const index = cursor++;
      const target = targets[index];
      const { data, error } = await window.supabaseClient.functions.invoke('admin-send-sms', { body: { userId: target.row.user_id, date, missing: target.missing } });
      if (!error && data?.ok) success += 1; else failed += 1;
      if (button) button.innerHTML = `<i class="fa-solid fa-spinner fa-spin mr-2"></i>발송 중 ${success + failed}/${targets.length}`;
    }
  };
  await Promise.all(Array.from({ length: Math.min(5, targets.length) }, worker));
  if (button) { button.disabled = false; button.innerHTML = '<i class="fa-solid fa-paper-plane mr-2"></i>미인증 내역 알림 문자 발송'; }
  adminShowStatus(`일괄 발송 완료: 성공 ${success}명 · 실패 ${failed}명`, failed > 0);
  await adminLoadSmsLogs(true);
}

function adminRenderSmsLogPagination(total) {
  const wrap = document.getElementById('admin-sms-log-pagination');
  if (!wrap) return;
  const totalPages = Math.max(1, Math.ceil(total / ADMIN_SMS_LOG_PAGE_SIZE));
  adminSmsLogPage = Math.min(adminSmsLogPage, totalPages);
  const start = total ? (adminSmsLogPage - 1) * ADMIN_SMS_LOG_PAGE_SIZE + 1 : 0;
  const end = Math.min(adminSmsLogPage * ADMIN_SMS_LOG_PAGE_SIZE, total);
  wrap.innerHTML = `<span class="text-xs text-on-surface-variant mr-2">${start}-${end} / ${total}명</span><button type="button" data-sms-log-page="${adminSmsLogPage - 1}" class="icon-glass w-9 h-9 rounded-full" ${adminSmsLogPage <= 1 ? 'disabled' : ''}><i class="fa-solid fa-chevron-left text-xs"></i></button><span class="text-xs font-bold min-w-12 text-center">${adminSmsLogPage} / ${totalPages}</span><button type="button" data-sms-log-page="${adminSmsLogPage + 1}" class="icon-glass w-9 h-9 rounded-full" ${adminSmsLogPage >= totalPages ? 'disabled' : ''}><i class="fa-solid fa-chevron-right text-xs"></i></button>`;
}

async function adminLoadSmsLogs(resetPage = false) {
  const wrap = document.getElementById('admin-sms-log-list');
  if (!wrap) return;
  if (resetPage) adminSmsLogPage = 1;
  const from = (adminSmsLogPage - 1) * ADMIN_SMS_LOG_PAGE_SIZE;
  const { data, error, count } = await window.supabaseClient.from('admin_sms_logs').select('*', { count: 'exact' }).order('created_at', { ascending: false }).range(from, from + ADMIN_SMS_LOG_PAGE_SIZE - 1);
  if (error) { wrap.innerHTML = '<p class="text-xs text-on-surface-variant py-4 text-center">문자 로그 스키마를 적용하면 발송 현황이 표시됩니다.</p>'; adminRenderSmsLogPagination(0); return; }
  const total = Number(count) || 0;
  const totalPages = Math.max(1, Math.ceil(total / ADMIN_SMS_LOG_PAGE_SIZE));
  if (adminSmsLogPage > totalPages) { adminSmsLogPage = totalPages; return adminLoadSmsLogs(); }
  wrap.innerHTML = (data || []).map((log) => {
    const items = log.missing_items || [];
    const detail = items.includes('개인 리포트') ? '개인 리포트 링크' : `미인증 ${items.join(', ')}`;
    return `<article class="glass-card rounded-2xl px-4 py-3 flex flex-wrap sm:flex-nowrap items-center gap-3"><span class="w-8 h-8 rounded-full flex items-center justify-center flex-shrink-0 ${log.status === 'success' ? 'bg-sky-100 text-sky-500' : 'bg-error-container text-error'}"><i class="fa-solid ${log.status === 'success' ? 'fa-check' : 'fa-xmark'} text-xs"></i></span><div class="min-w-0 flex-1"><p class="text-sm font-bold">${adminEscape(log.target_name || '학생')} <span class="font-normal text-on-surface-variant">· ${adminEscape(log.grade_class || '-')}</span></p><p class="text-xs text-on-surface-variant truncate">${adminEscape(log.target_date || '')} · ${adminEscape(detail)}${log.error_message ? ` · ${adminEscape(log.error_message)}` : ''}</p></div><time class="text-[10px] text-on-surface-variant whitespace-nowrap">${new Date(log.created_at).toLocaleString('ko-KR')}</time></article>`;
  }).join('') || '<p class="text-xs text-on-surface-variant py-4 text-center">아직 문자 발송 기록이 없습니다.</p>';
  adminRenderSmsLogPagination(total);
}
