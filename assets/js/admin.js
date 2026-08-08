// Admin 전광판: is_admin=true인 계정만 메시지/성경구절을 관리한다.

let adminCurrentUserId = null;
let adminUsers = [];
let adminEditingMessageId = null;
let adminMessages = [];

function adminEscape(value) {
  return String(value == null ? '' : value)
    .replaceAll('&', '&amp;').replaceAll('<', '&lt;').replaceAll('>', '&gt;')
    .replaceAll('"', '&quot;').replaceAll("'", '&#039;');
}

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
  const { data, error } = await window.supabaseClient.from('profiles').select('is_admin').eq('id', adminCurrentUserId).maybeSingle();
  return !error && !!(data && data.is_admin);
}

async function adminLoadUsers() {
  const { data, error } = await window.supabaseClient.rpc('get_admin_message_users');
  if (error) { console.error('[admin] users', error); return; }
  adminUsers = data || [];
  const select = document.getElementById('admin-message-recipient');
  if (!select) return;
  select.innerHTML = '<option value="">전체 가입자</option>' + adminUsers.map((user) =>
    `<option value="${user.id}">${adminEscape(user.name)} (@${adminEscape(user.username)})</option>`
  ).join('');
}

function adminRecipientLabel(userId) {
  if (!userId) return '전체 가입자';
  const user = adminUsers.find((item) => item.id === userId);
  return user ? `${user.name} (@${user.username})` : '개별 이용자';
}

async function adminLoadMessages() {
  const { data, error } = await window.supabaseClient.from('home_messages').select('*').order('created_at', { ascending: false }).limit(50);
  if (error) { console.error('[admin] messages', error); return; }
  adminMessages = data || [];
  const wrap = document.getElementById('admin-message-list');
  if (!wrap) return;
  wrap.innerHTML = adminMessages.length ? adminMessages.map((message) => `
    <article class="glass-card rounded-2xl p-4 ${message.is_active ? '' : 'opacity-50'}" data-message-id="${message.id}">
      <div class="flex items-start justify-between gap-3">
        <div class="min-w-0">
          <p class="text-[11px] font-bold text-secondary mb-1">${adminEscape(adminRecipientLabel(message.recipient_user_id))}</p>
          <p class="text-sm whitespace-pre-wrap">${adminEscape(message.body)}</p>
          <p class="text-[10px] text-on-surface-variant mt-2">${new Date(message.created_at).toLocaleString('ko-KR')}${message.expires_at ? ` · ${new Date(message.expires_at).toLocaleString('ko-KR')}까지` : ''}</p>
        </div>
        <div class="flex gap-1 flex-shrink-0">
          <button type="button" data-action="edit" class="icon-glass w-8 h-8 rounded-full" aria-label="수정"><i class="fa-solid fa-pen text-xs"></i></button>
          <button type="button" data-action="toggle" class="icon-glass w-8 h-8 rounded-full" aria-label="활성 전환"><i class="fa-solid ${message.is_active ? 'fa-eye' : 'fa-eye-slash'} text-xs"></i></button>
          <button type="button" data-action="delete" class="icon-glass w-8 h-8 rounded-full text-error" aria-label="삭제"><i class="fa-solid fa-trash text-xs"></i></button>
        </div>
      </div>
    </article>`).join('') : '<p class="text-sm text-on-surface-variant">등록된 메시지가 없습니다.</p>';
}

function adminDateTimeLocalValue(isoValue) {
  if (!isoValue) return '';
  const date = new Date(isoValue);
  const local = new Date(date.getTime() - date.getTimezoneOffset() * 60000);
  return local.toISOString().slice(0, 16);
}

function adminResetMessageForm() {
  const form = document.getElementById('admin-message-form');
  if (form) form.reset();
  adminEditingMessageId = null;
  const submit = document.getElementById('admin-message-submit');
  const cancel = document.getElementById('admin-message-edit-cancel');
  if (submit) submit.textContent = 'Board Message 전송';
  if (cancel) cancel.classList.add('hidden');
}

function adminStartMessageEdit(messageId) {
  const message = adminMessages.find((item) => item.id === messageId);
  if (!message) return;
  adminEditingMessageId = message.id;
  document.getElementById('admin-message-recipient').value = message.recipient_user_id || '';
  document.getElementById('admin-message-body').value = message.body || '';
  document.getElementById('admin-message-expires').value = adminDateTimeLocalValue(message.expires_at);
  document.getElementById('admin-message-submit').textContent = '변경 저장';
  document.getElementById('admin-message-edit-cancel').classList.remove('hidden');
  document.getElementById('admin-message-form').scrollIntoView({ behavior: 'smooth', block: 'start' });
  document.getElementById('admin-message-body').focus();
}

async function adminLoadVerses() {
  const { data, error } = await window.supabaseClient.from('home_bible_verses').select('*').order('created_at', { ascending: false }).limit(30);
  if (error) { console.error('[admin] verses', error); return; }
  const wrap = document.getElementById('admin-verse-list');
  if (!wrap) return;
  wrap.innerHTML = (data || []).length ? data.map((verse) => `
    <article class="glass-card rounded-2xl p-4 ${verse.is_active ? 'ring-2 ring-secondary' : 'opacity-50'}" data-verse-id="${verse.id}">
      <div class="flex items-start justify-between gap-3">
        <div><p class="text-xs font-bold text-secondary mb-1">${adminEscape(verse.reference)}</p><p class="text-sm leading-6">${adminEscape(verse.verse_text)}</p><p class="text-[10px] text-on-surface-variant mt-2">등록 ${new Date(verse.created_at).toLocaleString('ko-KR')}</p></div>
        <div class="flex gap-1 flex-shrink-0">
          <button type="button" data-action="activate" class="icon-glass w-8 h-8 rounded-full" aria-label="대표 말씀으로 설정"><i class="fa-solid fa-star text-xs"></i></button>
          <button type="button" data-action="delete" class="icon-glass w-8 h-8 rounded-full text-error" aria-label="삭제"><i class="fa-solid fa-trash text-xs"></i></button>
        </div>
      </div>
    </article>`).join('') : '<p class="text-sm text-on-surface-variant">등록된 성경구절이 없습니다.</p>';
}

function adminWireMessageForm() {
  const form = document.getElementById('admin-message-form');
  if (!form) return;
  form.addEventListener('submit', async (event) => {
    event.preventDefault();
    const body = document.getElementById('admin-message-body').value.trim();
    const recipient = document.getElementById('admin-message-recipient').value || null;
    const expiresValue = document.getElementById('admin-message-expires').value;
    const payload = {
      recipient_user_id: recipient,
      body,
      expires_at: expiresValue ? new Date(expiresValue).toISOString() : null
    };
    const result = adminEditingMessageId
      ? await window.supabaseClient.from('home_messages').update(payload).eq('id', adminEditingMessageId)
      : await window.supabaseClient.from('home_messages').insert({ ...payload, created_by: adminCurrentUserId });
    if (result.error) { adminShowStatus('메시지를 저장하지 못했습니다.', true); console.error('[admin] save message', result.error); return; }
    const wasEditing = !!adminEditingMessageId;
    adminResetMessageForm();
    adminShowStatus(wasEditing ? '메시지를 수정했습니다.' : '메시지를 전송했습니다.');
    await adminLoadMessages();
  });
  document.getElementById('admin-message-edit-cancel')?.addEventListener('click', adminResetMessageForm);
}

function adminWireMessageList() {
  const wrap = document.getElementById('admin-message-list');
  if (!wrap) return;
  wrap.addEventListener('click', async (event) => {
    const button = event.target.closest('[data-action]');
    const article = event.target.closest('[data-message-id]');
    if (!button || !article) return;
    const id = article.dataset.messageId;
    if (button.dataset.action === 'edit') {
      adminStartMessageEdit(id);
      return;
    }
    if (button.dataset.action === 'delete') {
      await window.supabaseClient.from('home_messages').delete().eq('id', id);
      if (adminEditingMessageId === id) adminResetMessageForm();
    } else {
      const currentlyActive = !article.classList.contains('opacity-50');
      await window.supabaseClient.from('home_messages').update({ is_active: !currentlyActive }).eq('id', id);
    }
    await adminLoadMessages();
  });
}

function adminWireVerseForm() {
  const form = document.getElementById('admin-verse-form');
  if (!form) return;
  form.addEventListener('submit', async (event) => {
    event.preventDefault();
    const reference = document.getElementById('admin-verse-reference').value.trim();
    const verseText = document.getElementById('admin-verse-text').value.trim();
    const { data: inserted, error } = await window.supabaseClient.from('home_bible_verses')
      .insert({ reference, verse_text: verseText, is_active: true, created_by: adminCurrentUserId })
      .select('id')
      .single();
    if (error) { adminShowStatus('성경구절을 저장하지 못했습니다.', true); console.error('[admin] insert verse', error); return; }
    const { error: deactivateError } = await window.supabaseClient.from('home_bible_verses')
      .update({ is_active: false })
      .eq('is_active', true)
      .neq('id', inserted.id);
    if (deactivateError) console.error('[admin] deactivate previous verses', deactivateError);
    form.reset();
    adminShowStatus('Home 성경구절을 변경했습니다.');
    await adminLoadVerses();
  });
}

function adminWireVerseList() {
  const wrap = document.getElementById('admin-verse-list');
  if (!wrap) return;
  wrap.addEventListener('click', async (event) => {
    const button = event.target.closest('[data-action]');
    const article = event.target.closest('[data-verse-id]');
    if (!button || !article) return;
    const id = article.dataset.verseId;
    if (button.dataset.action === 'delete') {
      await window.supabaseClient.from('home_bible_verses').delete().eq('id', id);
    } else {
      const { error: activateError } = await window.supabaseClient.from('home_bible_verses').update({ is_active: true }).eq('id', id);
      if (activateError) { adminShowStatus('성경구절을 변경하지 못했습니다.', true); return; }
      const { error: deactivateError } = await window.supabaseClient.from('home_bible_verses')
        .update({ is_active: false })
        .eq('is_active', true)
        .neq('id', id);
      if (deactivateError) console.error('[admin] deactivate other verses', deactivateError);
    }
    await adminLoadVerses();
  });
}

let adminMembers = [];
let adminDashboardRows = [];
let adminActiveTab = 'board';

function adminRoleBadge(member) {
  const role = member.app_role;
  const roleBadge = role === 'admin'
    ? '<span class="inline-flex w-4 h-4 rounded-full bg-blue-500 text-white items-center justify-center" title="Admin"><i class="fa-solid fa-check text-[8px]"></i></span>'
    : role === 'teacher'
      ? '<span class="inline-flex w-4 h-4 rounded-full bg-lime-500 text-white items-center justify-center" title="Teacher"><i class="fa-solid fa-check text-[8px]"></i></span>' : '';
  const host = member.is_host ? '<span class="inline-flex w-5 h-5 rounded-full bg-amber-100 text-amber-600 items-center justify-center" title="Host"><i class="fa-solid fa-crown text-[9px]"></i></span>' : '';
  return `${host}${roleBadge}`;
}

function adminWireTabs() {
  const validTabs = ['board', 'gallery', 'control', 'member', 'dashboard'];
  const selectTab = (tab) => {
    adminActiveTab = validTabs.includes(tab) ? tab : 'board';
    window.history.replaceState(null, '', `#${adminActiveTab}`);
    document.querySelectorAll('[data-admin-tab]').forEach((item) => item.classList.toggle('nav-pill-active', item.dataset.adminTab === adminActiveTab));
    document.querySelectorAll('[data-admin-panel]').forEach((panel) => panel.classList.toggle('hidden', panel.dataset.adminPanel !== adminActiveTab));
    if (adminActiveTab === 'control') adminLoadFeatures();
    if (adminActiveTab === 'member') adminLoadMembers();
    if (adminActiveTab === 'dashboard') adminLoadDashboard();
    document.getElementById('sidebar-menu')?.classList.add('-translate-x-[120%]');
    document.getElementById('sidebar-overlay')?.classList.add('hidden', 'opacity-0');
    document.body.style.overflow = '';
  };
  document.querySelectorAll('[data-admin-tab]').forEach((button) => button.addEventListener('click', () => selectTab(button.dataset.adminTab)));
  selectTab(window.location.hash.replace('#', '') || 'board');
}

async function adminLoadFeatures() {
  const { data, error } = await window.supabaseClient.from('app_feature_flags').select('*').order('section').order('label');
  const wrap = document.getElementById('admin-feature-groups');
  if (!wrap) return;
  if (error) { wrap.innerHTML = '<p class="text-sm text-error">admin_console_schema.sql을 먼저 실행해주세요.</p>'; return; }
  const groups = Object.groupBy ? Object.groupBy(data || [], (item) => item.section) : (data || []).reduce((acc, item) => { (acc[item.section] ||= []).push(item); return acc; }, {});
  wrap.innerHTML = Object.entries(groups).map(([section, items]) => `<section class="glass-card rounded-[1.5rem] p-5"><h3 class="text-xs font-bold tracking-[.16em] uppercase text-on-surface-variant mb-3">${adminEscape(section)}</h3><div class="divide-y divide-outline-variant/30">${items.map((item) => `<label class="flex items-center justify-between gap-4 py-3 cursor-pointer"><div><p class="text-sm font-semibold">${adminEscape(item.label)}</p><p class="text-[11px] text-on-surface-variant">${adminEscape(item.feature_key)}</p></div><span class="admin-switch"><input type="checkbox" data-feature-key="${adminEscape(item.feature_key)}" ${item.is_enabled ? 'checked' : ''}><span class="admin-switch-track"></span></span></label>`).join('')}</div></section>`).join('');
  wrap.querySelectorAll('[data-feature-key]').forEach((input) => input.addEventListener('change', async () => {
    const { error: updateError } = await window.supabaseClient.from('app_feature_flags').update({ is_enabled: input.checked, updated_by: adminCurrentUserId, updated_at: new Date().toISOString() }).eq('feature_key', input.dataset.featureKey);
    if (updateError) { input.checked = !input.checked; adminShowStatus('기능 상태를 변경하지 못했습니다.', true); }
    else adminShowStatus(`${input.dataset.featureKey} 기능을 ${input.checked ? '켰습니다' : '껐습니다'}.`);
  }));
}

async function adminLoadMembers() {
  const { data, error } = await window.supabaseClient.rpc('admin_get_members');
  if (error) { adminShowStatus('회원 정보를 불러오지 못했습니다. 관리자 스키마를 확인해주세요.', true); return; }
  adminMembers = data || [];
  adminRenderMembers();
}

function adminRenderMembers() {
  const wrap = document.getElementById('admin-member-list');
  const query = (document.getElementById('admin-member-search')?.value || '').trim().toLowerCase();
  if (!wrap) return;
  const filtered = adminMembers.filter((member) => !query || `${member.name} ${member.username} ${member.grade_class}`.toLowerCase().includes(query));
  wrap.innerHTML = filtered.map((member) => `<article class="admin-member-row glass-card rounded-2xl p-4 flex flex-wrap sm:flex-nowrap items-center gap-3 ${member.is_active ? '' : 'opacity-50'}" data-member-id="${member.id}"><div class="w-11 h-11 rounded-full bg-gradient-to-br from-primary-container to-secondary-container text-white flex items-center justify-center font-bold">${adminEscape((member.name || '?')[0])}</div><div class="min-w-0 flex-1"><div class="flex items-center gap-1.5"><p class="font-bold truncate">${adminEscape(member.name)}</p>${adminRoleBadge(member)}</div><p class="text-xs text-on-surface-variant truncate">@${adminEscape(member.username)} · ${adminEscape(member.grade_class || '-')}</p></div><div class="text-right hidden md:block"><p class="text-xs font-semibold">${adminEscape(member.parent_phone || '학부모 번호 미입력')}</p><p class="text-[10px] text-on-surface-variant">${member.is_active ? 'Active' : 'Inactive'} · ${adminEscape(member.app_role)}</p></div><button type="button" data-edit-member class="icon-glass w-10 h-10 rounded-full"><i class="fa-solid fa-ellipsis"></i></button></article>`).join('') || '<p class="text-sm text-on-surface-variant py-10 text-center">검색 결과가 없습니다.</p>';
  wrap.querySelectorAll('[data-edit-member]').forEach((button) => button.addEventListener('click', () => adminOpenMember(button.closest('[data-member-id]').dataset.memberId)));
}

function adminOpenMember(id) {
  const member = adminMembers.find((item) => item.id === id);
  if (!member) return;
  document.getElementById('admin-member-id').value = member.id;
  document.getElementById('admin-member-name').value = member.name || '';
  document.getElementById('admin-member-grade').value = member.grade_class || '';
  document.getElementById('admin-member-phone').value = member.phone || '';
  document.getElementById('admin-member-parent-phone').value = member.parent_phone || '';
  document.getElementById('admin-member-role').value = member.app_role || 'student';
  document.getElementById('admin-member-host').checked = !!member.is_host;
  document.getElementById('admin-member-active').checked = !!member.is_active;
  const modal = document.getElementById('admin-member-modal'); modal.classList.remove('hidden'); modal.classList.add('flex');
}

function adminCloseMember() { const modal = document.getElementById('admin-member-modal'); modal?.classList.add('hidden'); modal?.classList.remove('flex'); }

function adminWireMember() {
  document.getElementById('admin-member-search')?.addEventListener('input', adminRenderMembers);
  document.querySelectorAll('[data-close-modal]').forEach((item) => item.addEventListener('click', adminCloseMember));
  document.getElementById('admin-member-form')?.addEventListener('submit', async (event) => {
    event.preventDefault();
    const args = { target_user_id: document.getElementById('admin-member-id').value, new_name: document.getElementById('admin-member-name').value.trim(), new_grade_class: document.getElementById('admin-member-grade').value.trim(), new_phone: document.getElementById('admin-member-phone').value.trim(), new_parent_phone: document.getElementById('admin-member-parent-phone').value.trim(), new_role: document.getElementById('admin-member-role').value, new_is_host: document.getElementById('admin-member-host').checked, new_is_active: document.getElementById('admin-member-active').checked };
    const { error } = await window.supabaseClient.rpc('admin_update_member', args);
    if (error) { adminShowStatus('회원 정보를 저장하지 못했습니다.', true); return; }
    adminCloseMember(); adminShowStatus('회원 정보를 저장했습니다.'); await adminLoadMembers();
  });
  document.getElementById('admin-member-delete')?.addEventListener('click', async () => {
    const id = document.getElementById('admin-member-id').value;
    const member = adminMembers.find((item) => item.id === id);
    if (!member || !confirm(`${member.name} 회원을 강제 탈퇴시키고 모든 기록을 삭제할까요? 이 작업은 되돌릴 수 없습니다.`)) return;
    const { error } = await window.supabaseClient.rpc('admin_delete_member', { target_user_id: id });
    if (error) { adminShowStatus(error.message || '탈퇴 처리에 실패했습니다.', true); return; }
    adminCloseMember(); adminShowStatus('회원과 모든 기록을 삭제했습니다.'); await adminLoadMembers();
  });
}

function adminFormatMinutes(value) { const min = Number(value) || 0; return min >= 60 ? `${Math.floor(min / 60)}h ${min % 60 ? `${min % 60}m` : ''}` : `${min}m`; }
function adminDoneCell(done, minutes, key) { return `<div class="flex items-center gap-2"><span class="admin-status-dot ${done ? 'bg-quaternary' : 'bg-error/60'}"></span><span class="text-xs font-semibold">${done ? adminFormatMinutes(minutes) : '미인증'}</span><span class="sr-only">${key}</span></div>`; }

async function adminLoadDashboard() {
  const date = document.getElementById('admin-dashboard-date')?.value || '2026-08-10';
  const { data, error } = await window.supabaseClient.rpc('admin_get_dashboard', { target_date: date });
  if (error) { adminShowStatus('인증 현황을 불러오지 못했습니다. 관리자 스키마를 확인해주세요.', true); return; }
  adminDashboardRows = data || [];
  const cats = ['pray_done','word_done','study_done','worship_done'];
  const completed = adminDashboardRows.filter((row) => cats.every((cat) => row[cat])).length;
  const pending = adminDashboardRows.length - completed;
  document.getElementById('admin-dashboard-summary').innerHTML = [
    ['Students',adminDashboardRows.length,'전체 활성 학생'],['Complete',completed,'4개 인증 완료'],['Needs Action',pending,'하나 이상 미인증'],['Completion',(adminDashboardRows.length ? `${Math.round(completed/adminDashboardRows.length*100)}%` : '0%'),'완료 학생 비율']
  ].map(([title,value,desc]) => `<article class="glass-card rounded-2xl p-4"><p class="text-xs text-on-surface-variant">${title}</p><p class="text-2xl font-bold mt-1 ${title==='Needs Action'&&pending?'text-error':'text-primary'}">${value}</p><p class="text-[10px] text-on-surface-variant mt-1">${desc}</p></article>`).join('');
  const wrap = document.getElementById('admin-dashboard-list');
  wrap.innerHTML = `<div class="grid grid-cols-[minmax(180px,1.4fr)_repeat(4,minmax(110px,1fr))_170px] gap-3 px-3 pb-3 text-[10px] font-bold tracking-wider text-on-surface-variant"><span>MEMBER</span><span>PRAYER</span><span>WORD</span><span>STUDY</span><span>WORSHIP</span><span>ACTIONS</span></div>${adminDashboardRows.map((row) => { const missing = [['기도',row.pray_done],['말씀',row.word_done],['공부',row.study_done],['예배',row.worship_done]].filter(([,done])=>!done).map(([name])=>name); return `<article class="grid grid-cols-[minmax(180px,1.4fr)_repeat(4,minmax(110px,1fr))_170px] gap-3 items-center glass-card rounded-2xl px-3 py-3 mb-2" data-dashboard-user="${row.user_id}"><div><p class="text-sm font-bold">${adminEscape(row.name)}</p><p class="text-[10px] text-on-surface-variant">@${adminEscape(row.username)} · ${adminEscape(row.grade_class)}</p></div>${adminDoneCell(row.pray_done,row.pray_minutes,'pray')}${adminDoneCell(row.word_done,row.word_minutes,'word')}${adminDoneCell(row.study_done,row.study_minutes,'study')}${adminDoneCell(row.worship_done,row.worship_minutes,'worship')}<div class="flex gap-2"><button data-sms data-missing="${adminEscape(missing.join(', '))}" class="icon-glass w-9 h-9 rounded-full ${missing.length ? 'text-primary' : 'opacity-30'}" ${missing.length ? '' : 'disabled'} title="미인증 SMS"><i class="fa-solid fa-message text-xs"></i></button><button data-report class="pill-btn-primary px-3 py-2 text-xs">Report</button></div></article>`; }).join('') || '<p class="text-sm text-on-surface-variant py-10 text-center">활성 학생이 없습니다.</p>'}`;
  wrap.querySelectorAll('[data-sms]').forEach((button) => button.addEventListener('click', () => adminSendMissingSms(button.closest('[data-dashboard-user]').dataset.dashboardUser, button.dataset.missing)));
  wrap.querySelectorAll('[data-report]').forEach((button) => button.addEventListener('click', () => adminOpenReport(button.closest('[data-dashboard-user]').dataset.dashboardUser)));
}

async function adminSendMissingSms(userId, missing) {
  const row = adminDashboardRows.find((item) => item.user_id === userId);
  if (!row?.parent_phone) { adminShowStatus(`${row?.name || '학생'}의 학부모 번호가 없습니다. Member에서 입력해주세요.`, true); return; }
  if (!confirm(`${row.name} 학부모에게 미인증 안내 문자를 보낼까요?\n미인증: ${missing}`)) return;
  const { data, error } = await window.supabaseClient.functions.invoke('admin-send-sms', { body: { userId, date: document.getElementById('admin-dashboard-date').value, missing: missing.split(', ') } });
  if (error || !data?.ok) adminShowStatus(data?.message || '문자를 보내지 못했습니다.', true); else adminShowStatus(`${row.name} 학부모에게 문자를 보냈습니다.`);
}

async function adminOpenReport(userId) {
  const member = adminMembers.find((item) => item.id === userId) || adminDashboardRows.find((item) => item.user_id === userId);
  const { data, error } = await window.supabaseClient.rpc('admin_get_member_report', { target_user_id: userId });
  if (error) { adminShowStatus('리포트를 만들지 못했습니다.', true); return; }
  const totals = (data || []).reduce((sum,row) => ({ pray:sum.pray+Number(row.pray_minutes), word:sum.word+Number(row.word_minutes), study:sum.study+Number(row.study_minutes), worship:sum.worship+Number(row.worship_minutes) }), {pray:0,word:0,study:0,worship:0});
  const total = Object.values(totals).reduce((a,b)=>a+b,0); const achieved = (data || []).filter((row)=>Object.values(row).slice(1).reduce((a,b)=>a+Number(b),0)>=300).length;
  document.getElementById('admin-report-card').innerHTML = `<div class="flex justify-between items-start border-b border-outline-variant/40 pb-6"><div><p class="text-xs font-bold tracking-[.2em] text-primary">SAP ACTIVITY REPORT</p><h2 class="text-3xl font-bold mt-2">${adminEscape(member?.name || '')}</h2><p class="text-sm text-on-surface-variant mt-1">@${adminEscape(member?.username || '')} · 2026.08.10—09.06</p></div><div class="w-14 h-14 rounded-2xl bg-gradient-to-br from-primary-container to-tertiary-container text-white flex items-center justify-center font-black text-xl">SAP</div></div><div class="grid grid-cols-2 sm:grid-cols-4 gap-3 my-6">${[['Prayer',totals.pray],['Word',totals.word],['Study',totals.study],['Worship',totals.worship]].map(([n,v])=>`<div class="rounded-2xl bg-white p-4"><p class="text-xs text-on-surface-variant">${n}</p><p class="text-xl font-bold mt-1">${adminFormatMinutes(v)}</p></div>`).join('')}</div><div class="grid grid-cols-2 gap-4"><div class="rounded-2xl bg-white p-5"><p class="text-xs text-on-surface-variant">Total Activity</p><p class="text-3xl font-bold text-primary mt-2">${adminFormatMinutes(total)}</p></div><div class="rounded-2xl bg-white p-5"><p class="text-xs text-on-surface-variant">300-min Days</p><p class="text-3xl font-bold text-secondary mt-2">${achieved} / 20</p></div></div><div class="mt-6 flex gap-1">${(data||[]).map(row=>`<div class="flex-1 h-12 rounded-lg ${Object.values(row).slice(1).reduce((a,b)=>a+Number(b),0)>=300?'bg-primary':'bg-surface-highest'}" title="${row.record_date}"></div>`).join('')}</div><p class="text-[10px] text-on-surface-variant mt-3">각 막대는 운영기간 평일 1일을 나타냅니다. 분홍색은 300분 달성일입니다.</p>`;
  const modal=document.getElementById('admin-report-modal'); modal.classList.remove('hidden'); modal.classList.add('flex');
}

function adminWireReport() {
  document.querySelectorAll('[data-close-report]').forEach((item)=>item.addEventListener('click',()=>{const modal=document.getElementById('admin-report-modal');modal.classList.add('hidden');modal.classList.remove('flex');}));
  document.getElementById('admin-report-copy')?.addEventListener('click', async () => {
    const canvas = await html2canvas(document.getElementById('admin-report-card'), { scale: 2, backgroundColor: '#fcf9f8' });
    canvas.toBlob(async (blob) => { try { await navigator.clipboard.write([new ClipboardItem({ 'image/png': blob })]); adminShowStatus('리포트 이미지를 클립보드에 복사했습니다.'); } catch { const link=document.createElement('a');link.download='SAP-report.png';link.href=canvas.toDataURL('image/png');link.click();adminShowStatus('브라우저 제한으로 리포트 이미지를 다운로드했습니다.'); } });
  });
}

function adminWireConsole() {
  adminWireTabs(); adminWireMember(); adminWireReport();
  document.getElementById('admin-dashboard-date')?.addEventListener('change',adminLoadDashboard);
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
  if (denied) denied.classList.add('hidden');
  if (content) content.classList.remove('hidden');
  adminWireMessageForm();
  adminWireMessageList();
  adminWireVerseForm();
  adminWireVerseList();
  await adminLoadUsers();
  adminWireConsole();
  await Promise.all([adminLoadMessages(), adminLoadVerses(), adminLoadMembers()]);
}

window.initAdminWidgets = initAdminWidgets;
