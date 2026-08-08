// Admin 전광판: is_admin=true인 계정만 메시지/성경구절을 관리한다.

let adminCurrentUserId = null;
let adminUsers = [];
let adminEditingMessageId = null;
let adminMessages = [];

const ADMIN_FEATURE_STRUCTURE = [
  { key: 'board', title: 'Board', description: '전체 이용자가 보는 소식과 랭킹 탭', icon: 'fa-solid fa-clipboard-list', children: [
    { key: 'board_messages', title: 'Board Message', description: '전체 공지와 개인 메시지를 표시합니다.' },
    { key: 'board_verse', title: '오늘의 말씀', description: '관리자가 등록한 성경 말씀을 상단에 표시합니다.' },
    { key: 'ranking', title: '실시간 랭킹', description: '활동 시간 기준 상위 이용자를 표시합니다.' }
  ] },
  { key: 'mypage', title: 'MyPage', description: '개인의 일별 인증과 활동 기록 탭', icon: 'fa-solid fa-user', children: [
    { key: 'pray', title: '기도 인증', description: '기도 시간과 인증 사진을 기록합니다.' },
    { key: 'word', title: '말씀 묵상 인증', description: '읽은 말씀과 묵상 시간을 기록합니다.' },
    { key: 'study_timer', title: '공부 시간 기록', description: '타이머 또는 직접 입력으로 공부 시간을 기록합니다.' },
    { key: 'worship', title: '예배 인증', description: '예배 참석 여부와 시간을 기록합니다.' }
  ] },
  { key: 'study', title: 'Study', description: '영단어 학습 탭', icon: 'fa-solid fa-book', children: [
    { key: 'study_vocab', title: '영단어 학습', description: '단어 목록, 암기 카드와 퀴즈를 제공합니다.' }
  ] },
  { key: 'gallery', title: 'Gallery', description: '전체 이용자의 인증 게시물 탭', icon: 'fa-regular fa-images', children: [
    { key: 'gallery_pray', title: '기도 갤러리', description: '기도 인증 게시물과 사진을 표시합니다.' },
    { key: 'gallery_word', title: '말씀 묵상 갤러리', description: '말씀 묵상 게시물과 사진을 표시합니다.' },
    { key: 'comments', title: '댓글', description: '게시물의 댓글 작성과 조회를 허용합니다.' }
  ] },
  { key: 'stat', title: 'Stat', description: '개인 활동 통계와 시각화 탭', icon: 'fa-solid fa-chart-line', children: [
    { key: 'stat_summary', title: '요약 지표', description: '연속 달성, 목표 달성률과 핵심 수치를 표시합니다.' },
    { key: 'stat_heatmap', title: '히트맵', description: '운영기간의 일별 활동량을 표시합니다.' },
    { key: 'stat_trend', title: '활동 추이', description: '날짜별 총 활동 시간의 변화를 표시합니다.' },
    { key: 'stat_balance', title: '카테고리 균형', description: '기도·말씀·공부·예배의 균형을 표시합니다.' },
    { key: 'stat_breakdown', title: '시간 비중', description: '카테고리별 누적 시간 비중을 표시합니다.' },
    { key: 'stat_bests', title: '개인 최고 기록', description: '운영기간 동안의 최고 기록을 표시합니다.' }
  ] },
  { key: null, title: '계정', description: '가입과 개인 계정 기능', icon: 'fa-solid fa-shield-halved', children: [
    { key: 'profile_photo', title: '프로필 사진', description: '프로필 사진 등록·수정·삭제를 허용합니다.' },
    { key: 'signup', title: '회원가입', description: '새로운 이용자의 회원가입을 허용합니다.' },
    { key: 'password_reset', title: '비밀번호 찾기', description: '문자 인증을 통한 비밀번호 변경을 허용합니다.' },
    { key: 'account_delete', title: '회원탈퇴', description: '이용자가 직접 계정과 모든 기록을 영구 삭제하도록 허용합니다.' }
  ] }
];

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
let adminMemberAvatarUrls = {};
let adminDashboardRows = [];
let adminActiveTab = 'board';
const ADMIN_DASHBOARD_PAGE_SIZE = 20;
let adminDashboardPage = 1;
let adminDashboardGrade = 'all';
let adminDashboardClass = 'all';

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
  const flagMap = Object.fromEntries((data || []).map((item) => [item.feature_key, item.is_enabled]));
  const switchHTML = (feature, parentKey, master = false) => `<label class="admin-switch" aria-label="${adminEscape(feature.title)} 켜기 또는 끄기"><input type="checkbox" data-feature-key="${feature.key}" data-feature-label="${adminEscape(feature.title)}" data-feature-section="${adminEscape(parentKey || '계정')}" ${master ? 'data-feature-master' : ''} ${flagMap[feature.key] !== false ? 'checked' : ''}><span class="admin-switch-track"></span></label>`;
  wrap.innerHTML = ADMIN_FEATURE_STRUCTURE.map((group) => `<section class="glass-card rounded-[1.5rem] p-5 sm:p-6" data-feature-group="${group.key || 'account'}"><div class="flex items-center gap-4"><div class="icon-glass w-11 h-11 rounded-full flex items-center justify-center text-primary flex-shrink-0"><i class="${group.icon}"></i></div><div class="min-w-0 flex-1"><h3 class="text-lg font-bold">${group.title}</h3><p class="text-xs text-on-surface-variant mt-0.5">${group.description}</p></div>${group.key ? switchHTML(group, group.title, true) : ''}</div><div class="ml-5 sm:ml-[3.35rem] pl-4 border-l-2 border-outline-variant/45 mt-4 divide-y divide-outline-variant/30" data-feature-children>${group.children.map((feature) => `<div class="flex items-center justify-between gap-4 py-3.5"><div class="min-w-0"><p class="text-sm font-semibold">${feature.title}</p><p class="text-[11px] leading-5 text-on-surface-variant mt-0.5">${feature.description}</p></div>${switchHTML(feature, group.title)}</div>`).join('')}</div></section>`).join('');
  const syncGroups = () => document.querySelectorAll('[data-feature-group]').forEach((group) => { const master = group.querySelector('[data-feature-master]'); group.querySelector('[data-feature-children]')?.classList.toggle('opacity-45', !!master && !master.checked); });
  syncGroups();
  wrap.querySelectorAll('[data-feature-key]').forEach((input) => input.addEventListener('change', async () => {
    const { error: updateError } = await window.supabaseClient.from('app_feature_flags').upsert({ feature_key: input.dataset.featureKey, label: input.dataset.featureLabel, section: input.dataset.featureSection, is_enabled: input.checked, updated_by: adminCurrentUserId, updated_at: new Date().toISOString() }, { onConflict: 'feature_key' });
    if (updateError) { input.checked = !input.checked; adminShowStatus('기능 상태를 변경하지 못했습니다.', true); }
    else adminShowStatus(`${input.dataset.featureLabel} 기능을 ${input.checked ? '켰습니다' : '껐습니다'}.`);
    syncGroups();
  }));
}

async function adminLoadMembers() {
  const { data, error } = await window.supabaseClient.rpc('admin_get_members');
  if (error) { adminShowStatus('회원 정보를 불러오지 못했습니다. 관리자 스키마를 확인해주세요.', true); return; }
  adminMembers = data || [];
  adminMemberAvatarUrls = window.getProfileAvatarUrls
    ? await window.getProfileAvatarUrls(adminMembers.map((member) => member.id))
    : {};
  adminRenderMembers();
}

function adminRenderMembers() {
  const wrap = document.getElementById('admin-member-list');
  const query = (document.getElementById('admin-member-search')?.value || '').trim().toLowerCase();
  if (!wrap) return;
  const filtered = adminMembers.filter((member) => !query || `${member.name} ${member.username} ${member.grade_class}`.toLowerCase().includes(query));
  wrap.innerHTML = filtered.map((member) => `<article class="admin-member-row glass-card rounded-2xl p-4 flex flex-wrap sm:flex-nowrap items-center gap-3 ${member.is_active ? '' : 'opacity-50'}" data-member-id="${member.id}"><div class="w-11 h-11 rounded-full bg-gradient-to-br from-primary-container to-secondary-container text-white flex items-center justify-center font-bold overflow-hidden">${adminMemberAvatarUrls[member.id] ? `<img src="${adminEscape(adminMemberAvatarUrls[member.id])}" alt="" class="w-full h-full object-cover">` : adminEscape((member.name || '?')[0])}</div><div class="min-w-0 flex-1"><div class="flex items-center gap-1.5"><p class="font-bold truncate">${adminEscape(member.name)}</p>${adminRoleBadge(member)}</div><p class="text-xs text-on-surface-variant truncate">@${adminEscape(member.username)} · ${adminEscape(member.grade_class || '-')}</p></div><div class="text-right hidden md:block"><p class="text-xs font-semibold">${adminEscape(member.parent_phone || '학부모 번호 미입력')}</p><p class="text-[10px] text-on-surface-variant">${member.is_active ? 'Active' : 'Inactive'} · ${adminEscape(member.app_role)}</p></div><button type="button" data-edit-member class="icon-glass w-10 h-10 rounded-full"><i class="fa-solid fa-ellipsis"></i></button></article>`).join('') || '<p class="text-sm text-on-surface-variant py-10 text-center">검색 결과가 없습니다.</p>';
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
function adminDoneCell(done, minutes, key, required = true) {
  if (!required) return `<div class="flex items-center gap-2"><span class="admin-status-dot bg-surface-highest"></span><span class="text-xs font-semibold text-on-surface-variant">해당 없음</span><span class="sr-only">${key}</span></div>`;
  return `<div class="flex items-center gap-2"><span class="admin-status-dot ${done ? 'bg-quaternary' : 'bg-error/60'}"></span><span class="text-xs font-semibold">${done ? adminFormatMinutes(minutes) : '미인증'}</span><span class="sr-only">${key}</span></div>`;
}

async function adminLoadDashboard() {
  const date = document.getElementById('admin-dashboard-date')?.value || '2026-08-10';
  const { data, error } = await window.supabaseClient.rpc('admin_get_dashboard', { target_date: date });
  if (error) { adminShowStatus('인증 현황을 불러오지 못했습니다. 관리자 스키마를 확인해주세요.', true); return; }
  adminDashboardRows = data || [];
  adminDashboardPage = 1;
  adminBuildDashboardFilters();
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

function adminBuildDashboardFilters() {
  const gradeSelect = document.getElementById('admin-dashboard-grade');
  const classSelect = document.getElementById('admin-dashboard-class');
  if (!gradeSelect || !classSelect) return;
  const grades = [...new Set(adminDashboardRows.map((row) => adminDashboardGroup(row.grade_class).grade))].sort();
  gradeSelect.innerHTML = '<option value="all">전체 학년</option>' + grades.map((grade) => `<option value="${adminEscape(grade)}">${adminEscape(grade)}</option>`).join('');
  if (!grades.includes(adminDashboardGrade)) adminDashboardGrade = 'all';
  gradeSelect.value = adminDashboardGrade;
  const classes = [...new Set(adminDashboardRows.filter((row) => adminDashboardGrade === 'all' || adminDashboardGroup(row.grade_class).grade === adminDashboardGrade).map((row) => adminDashboardGroup(row.grade_class).className))].sort((a, b) => a.localeCompare(b, 'ko', { numeric: true }));
  classSelect.innerHTML = '<option value="all">전체 반</option>' + classes.map((className) => `<option value="${adminEscape(className)}">${adminEscape(className)}</option>`).join('');
  if (!classes.includes(adminDashboardClass)) adminDashboardClass = 'all';
  classSelect.value = adminDashboardClass;
}

function adminDashboardMissing(row, worshipRequired) {
  return [['기도', row.pray_done], ['말씀', row.word_done], ['공부', row.study_done], ...(worshipRequired ? [['예배', row.worship_done]] : [])]
    .filter(([, done]) => !done).map(([name]) => name);
}

function adminFilteredDashboardRows() {
  return adminDashboardRows.filter((row) => {
    const group = adminDashboardGroup(row.grade_class);
    return (adminDashboardGrade === 'all' || group.grade === adminDashboardGrade)
      && (adminDashboardClass === 'all' || group.className === adminDashboardClass);
  });
}

function adminRenderDashboard() {
  const date = document.getElementById('admin-dashboard-date')?.value || '2026-08-10';
  const worshipRequired = [3, 5].includes(new Date(`${date}T12:00:00`).getDay());
  const cats = worshipRequired ? ['pray_done','word_done','study_done','worship_done'] : ['pray_done','word_done','study_done'];
  const completed = adminDashboardRows.filter((row) => cats.every((cat) => row[cat])).length;
  const pending = adminDashboardRows.length - completed;
  document.getElementById('admin-dashboard-summary').innerHTML = [
    ['Students',adminDashboardRows.length,'전체 학생 수'],['Complete',completed,worshipRequired ? '4개 인증 완료' : '3개 인증 완료'],['Needs Action',pending,'하나 이상 미인증'],['Completion',(adminDashboardRows.length ? `${Math.round(completed/adminDashboardRows.length*100)}%` : '0%'),'완료 학생 비율']
  ].map(([title,value,desc]) => `<article class="glass-card rounded-2xl p-4"><p class="text-xs text-on-surface-variant">${title}</p><p class="text-2xl font-bold mt-1 ${title==='Needs Action'&&pending?'text-error':'text-primary'}">${value}</p><p class="text-[10px] text-on-surface-variant mt-1">${desc}</p></article>`).join('');
  const filtered = adminFilteredDashboardRows();
  const totalPages = Math.max(1, Math.ceil(filtered.length / ADMIN_DASHBOARD_PAGE_SIZE));
  adminDashboardPage = Math.min(adminDashboardPage, totalPages);
  const pageRows = filtered.slice((adminDashboardPage - 1) * ADMIN_DASHBOARD_PAGE_SIZE, adminDashboardPage * ADMIN_DASHBOARD_PAGE_SIZE);
  const wrap = document.getElementById('admin-dashboard-list');
  wrap.innerHTML = `<div class="grid grid-cols-[minmax(220px,1.6fr)_repeat(4,minmax(110px,1fr))_140px] gap-3 px-3 pb-3 text-[10px] font-bold tracking-wider text-on-surface-variant"><span>학생 / 학년반</span><span>기도</span><span>말씀</span><span>공부</span><span>예배</span><span>문자 발송</span></div>${pageRows.map((row) => { const missing = adminDashboardMissing(row, worshipRequired); return `<article class="grid grid-cols-[minmax(220px,1.6fr)_repeat(4,minmax(110px,1fr))_140px] gap-3 items-center glass-card rounded-2xl px-3 py-3 mb-2" data-dashboard-user="${row.user_id}"><div><p class="text-sm font-bold">${adminEscape(row.name)}</p><p class="text-[11px] font-medium text-secondary mt-0.5">${adminEscape(row.grade_class || '학년반 미지정')}</p><p class="text-[10px] text-on-surface-variant">@${adminEscape(row.username)}</p></div>${adminDoneCell(row.pray_done,row.pray_minutes,'pray')}${adminDoneCell(row.word_done,row.word_minutes,'word')}${adminDoneCell(row.study_done,row.study_minutes,'study')}${adminDoneCell(row.worship_done,row.worship_minutes,'worship',worshipRequired)}<div><button data-sms data-missing="${adminEscape(missing.join(', '))}" class="icon-glass w-9 h-9 rounded-full ${missing.length ? 'text-sky-500' : 'opacity-30'}" ${missing.length ? '' : 'disabled'} title="학생에게 미인증 문자 발송"><i class="fa-solid fa-paper-plane text-sm"></i></button></div></article>`; }).join('') || '<p class="text-sm text-on-surface-variant py-10 text-center">조건에 맞는 학생이 없습니다.</p>'}`;
  wrap.querySelectorAll('[data-sms]').forEach((button) => button.addEventListener('click', () => adminSendMissingSms(button.closest('[data-dashboard-user]').dataset.dashboardUser, button.dataset.missing)));
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

async function adminSendMissingSms(userId, missing) {
  const row = adminDashboardRows.find((item) => item.user_id === userId);
  const member = adminMembers.find((item) => item.id === userId);
  const studentPhone = row?.phone || member?.phone || '';
  if (!studentPhone) { adminShowStatus(`${row?.name || member?.name || '학생'}의 본인 연락처가 없습니다. Member에서 입력해주세요.`, true); return; }
  const studentName = row?.name || member?.name || '학생';
  if (!confirm(`${studentName} 학생에게 미인증 안내 문자를 보낼까요?\n현재 미인증: ${missing}`)) return;
  const { data, error } = await window.supabaseClient.functions.invoke('admin-send-sms', { body: { userId, date: document.getElementById('admin-dashboard-date').value, missing: missing.split(', ') } });
  if (error || !data?.ok) adminShowStatus(data?.message || '문자를 보내지 못했습니다.', true); else adminShowStatus(`${studentName} 학생에게 문자를 보냈습니다.`);
  await adminLoadSmsLogs();
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
  await adminLoadSmsLogs();
}

async function adminLoadSmsLogs() {
  const wrap = document.getElementById('admin-sms-log-list');
  if (!wrap) return;
  const { data, error } = await window.supabaseClient.from('admin_sms_logs').select('*').order('created_at', { ascending: false }).limit(100);
  if (error) { wrap.innerHTML = '<p class="text-xs text-on-surface-variant py-4 text-center">문자 로그 스키마를 적용하면 발송 현황이 표시됩니다.</p>'; return; }
  wrap.innerHTML = (data || []).map((log) => `<article class="glass-card rounded-2xl px-4 py-3 flex flex-wrap sm:flex-nowrap items-center gap-3"><span class="w-8 h-8 rounded-full flex items-center justify-center flex-shrink-0 ${log.status === 'success' ? 'bg-sky-100 text-sky-500' : 'bg-error-container text-error'}"><i class="fa-solid ${log.status === 'success' ? 'fa-check' : 'fa-xmark'} text-xs"></i></span><div class="min-w-0 flex-1"><p class="text-sm font-bold">${adminEscape(log.target_name || '학생')} <span class="font-normal text-on-surface-variant">· ${adminEscape(log.grade_class || '-')}</span></p><p class="text-xs text-on-surface-variant truncate">${adminEscape(log.target_date || '')} · 미인증 ${adminEscape((log.missing_items || []).join(', '))}${log.error_message ? ` · ${adminEscape(log.error_message)}` : ''}</p></div><time class="text-[10px] text-on-surface-variant whitespace-nowrap">${new Date(log.created_at).toLocaleString('ko-KR')}</time></article>`).join('') || '<p class="text-xs text-on-surface-variant py-4 text-center">아직 문자 발송 기록이 없습니다.</p>';
}

function adminWireConsole() {
  adminWireTabs(); adminWireMember();
  document.getElementById('admin-dashboard-date')?.addEventListener('change',adminLoadDashboard);
  document.getElementById('admin-dashboard-grade')?.addEventListener('change', (event) => { adminDashboardGrade = event.target.value; adminDashboardClass = 'all'; adminDashboardPage = 1; adminBuildDashboardFilters(); adminRenderDashboard(); });
  document.getElementById('admin-dashboard-class')?.addEventListener('change', (event) => { adminDashboardClass = event.target.value; adminDashboardPage = 1; adminRenderDashboard(); });
  document.getElementById('admin-dashboard-bulk-sms')?.addEventListener('click', adminSendBulkMissingSms);
  document.getElementById('admin-sms-log-refresh')?.addEventListener('click', adminLoadSmsLogs);
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
