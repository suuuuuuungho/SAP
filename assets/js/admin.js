// Admin 전광판: is_admin=true인 계정만 메시지/성경구절을 관리한다.

let adminCurrentUserId = null;
let adminUsers = [];
let adminEditingMessageId = null;
let adminMessages = [];
const ADMIN_REPORT_PUBLIC_SITE_URL = 'https://suuuuuuungho.github.io/SAP/';
const ADMIN_MESSAGE_SENDER_ROLES = new Set(['admin', 'teacher', 'pastor', 'department_head', 'secretary']);

const ADMIN_FEATURE_STRUCTURE = [
  { key: 'board', title: 'Board', description: '전체 이용자가 보는 소식 탭', icon: 'fa-solid fa-clipboard-list', children: [
    { key: 'board_messages', title: 'Board Message', description: '전체 공지와 개인 메시지를 표시합니다.' },
    { key: 'board_verse', title: '오늘의 말씀', description: '관리자가 등록한 성경 말씀을 상단에 표시합니다.' }
  ] },
  { key: 'hall_of_fame', title: 'Hall of Fame', description: '전체 이용자가 보는 랭킹 탭', icon: 'fa-solid fa-trophy', children: [
    { key: 'ranking', title: '전체 누적 랭킹', description: '운영기간 전체 누적 활동 시간 기준 상위 이용자를 표시합니다.' },
    { key: 'ranking_weekly', title: '주차별 랭킹', description: 'Week1~4 탭으로 나눈 주차별 랭킹을 표시합니다.' }
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

async function adminLoadUsers() {
  const { data, error } = await window.supabaseClient.rpc('get_admin_message_users');
  if (error) { console.error('[admin] users', error); return; }
  adminUsers = data || [];
  const select = document.getElementById('admin-message-recipient');
  if (!select) return;
  select.innerHTML = '<option value="">받는 사람을 선택하세요</option>' + adminUsers.map((user) =>
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
  const now = new Date();
  wrap.innerHTML = adminMessages.length ? adminMessages.map((message) => {
    const startsAt = new Date(message.starts_at || message.created_at);
    const expiresAt = message.expires_at ? new Date(message.expires_at) : null;
    const timingLabel = startsAt > now ? '예약' : expiresAt && expiresAt <= now ? '종료' : '게시 중';
    const timingClass = startsAt > now ? 'bg-secondary/10 text-secondary' : expiresAt && expiresAt <= now ? 'bg-surface-container text-on-surface-variant' : 'bg-quaternary/10 text-quaternary';
    return `
    <article class="glass-card rounded-2xl p-4 ${message.is_active ? '' : 'opacity-50'}" data-message-id="${message.id}">
      <div class="flex items-start justify-between gap-3">
        <div class="min-w-0">
          <div class="flex flex-wrap items-center gap-1.5 mb-1"><span class="text-[10px] font-bold rounded-full px-2 py-0.5 ${message.recipient_user_id ? 'bg-secondary/10 text-secondary' : 'bg-primary/10 text-primary'}">${message.recipient_user_id ? '개인 메시지' : '전체 공지'}</span><span class="text-[10px] font-bold rounded-full px-2 py-0.5 ${timingClass}">${timingLabel}</span></div>
          <p class="text-[11px] font-bold text-secondary mb-1">${adminEscape(adminRecipientLabel(message.recipient_user_id))} · ${adminEscape(adminMessageSenderLabel(message.sender_user_id || message.created_by))} 선생님</p>
          <p class="text-sm whitespace-pre-wrap">${adminEscape(message.body)}</p>
          <p class="text-[10px] text-on-surface-variant mt-2">${startsAt.toLocaleString('ko-KR')}부터${message.expires_at ? ` · ${expiresAt.toLocaleString('ko-KR')}까지` : ''} · 문자 ${message.sms_status === 'scheduled' ? '예약됨' : message.sms_status === 'sent' ? '발송 접수' : message.sms_status === 'partial' ? '일부 실패' : '미접수'}</p>
        </div>
        <div class="flex gap-1 flex-shrink-0">
          <button type="button" data-action="edit" class="icon-glass w-8 h-8 rounded-full" aria-label="수정"><i class="fa-solid fa-pen text-xs"></i></button>
          <button type="button" data-action="toggle" class="icon-glass w-8 h-8 rounded-full" aria-label="활성 전환"><i class="fa-solid ${message.is_active ? 'fa-eye' : 'fa-eye-slash'} text-xs"></i></button>
          <button type="button" data-action="delete" class="icon-glass w-8 h-8 rounded-full text-error" aria-label="삭제"><i class="fa-solid fa-trash text-xs"></i></button>
        </div>
      </div>
    </article>`;
  }).join('') : '<p class="text-sm text-on-surface-variant">등록된 메시지가 없습니다.</p>';
}

function adminDateTimeLocalValue(isoValue) {
  if (!isoValue) return '';
  const date = new Date(isoValue);
  const local = new Date(date.getTime() - date.getTimezoneOffset() * 60000);
  return local.toISOString().slice(0, 16);
}

function adminTodayDateValue() {
  const date = new Date();
  const local = new Date(date.getTime() - date.getTimezoneOffset() * 60000);
  return local.toISOString().slice(0, 10);
}

function adminResetMessageForm() {
  const form = document.getElementById('admin-message-form');
  if (form) form.reset();
  adminEditingMessageId = null;
  adminSetMessageAudience('global');
  const starts = document.getElementById('admin-message-starts');
  if (starts) starts.value = adminDateTimeLocalValue(new Date().toISOString());
  adminRenderMessageSenders();
  const submit = document.getElementById('admin-message-submit');
  const cancel = document.getElementById('admin-message-edit-cancel');
  if (submit) submit.textContent = 'Board Message 전송';
  if (cancel) cancel.classList.add('hidden');
}

function adminStartMessageEdit(messageId) {
  const message = adminMessages.find((item) => item.id === messageId);
  if (!message) return;
  adminEditingMessageId = message.id;
  adminSetMessageAudience(message.recipient_user_id ? 'personal' : 'global');
  document.getElementById('admin-message-recipient').value = message.recipient_user_id || '';
  document.getElementById('admin-message-body').value = message.body || '';
  document.getElementById('admin-message-starts').value = adminDateTimeLocalValue(message.starts_at || message.created_at);
  document.getElementById('admin-message-expires').value = adminDateTimeLocalValue(message.expires_at);
  adminRenderMessageSenders(message.sender_user_id || message.created_by);
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
  document.querySelectorAll('input[name="admin-message-audience"]').forEach((input) => input.addEventListener('change', () => adminSetMessageAudience(input.value)));
  adminResetMessageForm();
  form.addEventListener('submit', async (event) => {
    event.preventDefault();
    const body = document.getElementById('admin-message-body').value.trim();
    const audience = adminMessageAudienceValue();
    const recipient = audience === 'personal' ? document.getElementById('admin-message-recipient').value || null : null;
    const senderId = document.querySelector('input[name="admin-message-sender"]:checked')?.value || '';
    const startsValue = document.getElementById('admin-message-starts').value;
    const expiresValue = document.getElementById('admin-message-expires').value;
    const startsAt = startsValue ? new Date(startsValue) : null;
    const expiresAt = expiresValue ? new Date(expiresValue) : null;
    if (audience === 'personal' && !recipient) { adminShowStatus('개인 메시지를 받을 사람을 선택해주세요.', true); return; }
    if (!senderId) { adminShowStatus('문자 발신자를 선택해주세요.', true); return; }
    if (!startsAt || Number.isNaN(startsAt.getTime())) { adminShowStatus('시작 시각을 확인해주세요.', true); return; }
    if (expiresAt && expiresAt <= startsAt) { adminShowStatus('종료 시각은 시작 시각보다 늦어야 합니다.', true); return; }
    const sixMonthsLater = new Date(); sixMonthsLater.setMonth(sixMonthsLater.getMonth() + 6);
    if (startsAt > sixMonthsLater) { adminShowStatus('문자 예약은 현재부터 최대 6개월 이내로 설정해주세요.', true); return; }
    const payload = {
      recipient_user_id: recipient,
      body,
      starts_at: startsAt.toISOString(),
      expires_at: expiresAt ? expiresAt.toISOString() : null,
      sender_user_id: senderId
    };
    const wasEditing = !!adminEditingMessageId;
    const previousMessage = wasEditing ? adminMessages.find((message) => message.id === adminEditingMessageId) : null;
    const submitButton = document.getElementById('admin-message-submit');
    const originalLabel = submitButton?.textContent || 'Board Message 전송';
    if (submitButton) submitButton.disabled = true;
    if (previousMessage && new Date(previousMessage.starts_at || previousMessage.created_at) > new Date() && Array.isArray(previousMessage.sms_group_ids) && previousMessage.sms_group_ids.length) {
      const cancelled = await adminCancelBoardMessageSms(previousMessage);
      if (!cancelled) { adminShowStatus('기존 예약 문자를 취소하지 못해 수정을 중단했습니다.', true); if (submitButton) submitButton.disabled = false; return; }
    }
    const result = adminEditingMessageId
      ? await window.supabaseClient.from('home_messages').update(payload).eq('id', adminEditingMessageId).select('*').single()
      : await window.supabaseClient.from('home_messages').insert({ ...payload, created_by: adminCurrentUserId }).select('*').single();
    if (result.error) {
      adminShowStatus('메시지를 저장하지 못했습니다.', true);
      console.error('[admin] save message', result.error);
      if (submitButton) submitButton.disabled = false;
      return;
    }
    const savedMessage = result.data;
    adminResetMessageForm();
    await adminLoadMessages();
    if (wasEditing && startsAt <= new Date()) {
      adminShowStatus('게시 중인 메시지를 수정했습니다. 이미 발송된 문자는 다시 보내지 않습니다.');
      if (submitButton) submitButton.disabled = false;
    } else {
      await adminSendBoardMessageSms(savedMessage.id, recipient, body, startsAt.toISOString(), senderId, audience, submitButton, originalLabel);
    }
  });
  document.getElementById('admin-message-edit-cancel')?.addEventListener('click', adminResetMessageForm);
}

async function adminCancelBoardMessageSms(message) {
  const groupIds = Array.isArray(message?.sms_group_ids) ? message.sms_group_ids.filter(Boolean) : [];
  if (!groupIds.length) return true;
  const { data, error } = await window.supabaseClient.functions.invoke('admin-send-sms', { body: { mode: 'board_cancel', groupIds } });
  if (error || !data?.ok) { console.error('[admin] cancel board sms', error || data); return false; }
  await window.supabaseClient.from('home_messages').update({ sms_group_ids: [], sms_status: 'cancelled' }).eq('id', message.id);
  return true;
}

async function adminSendBoardMessageSms(messageId, recipientId, body, startsAt, senderId, audience, submitButton, originalLabel) {
  const restoreButton = () => { if (submitButton) { submitButton.disabled = false; submitButton.textContent = originalLabel; } };
  const targets = recipientId
    ? adminMembers.filter((member) => member.id === recipientId)
    : adminMembers.filter((member) => member.is_active);
  const withPhone = targets.filter((member) => String(member.phone || '').replace(/\D/g, '').length >= 10);
  const missingPhoneCount = targets.length - withPhone.length;
  if (!withPhone.length) {
    adminShowStatus(`메시지를 전송했습니다.${targets.length ? ` (연락처 미등록으로 문자는 못 보냄: ${missingPhoneCount}명)` : ''}`, targets.length > 0);
    await window.supabaseClient.from('home_messages').update({ sms_group_ids: [], sms_status: 'no_phone' }).eq('id', messageId);
    restoreButton();
    return;
  }
  const startDate = new Date(startsAt);
  const localStart = new Date(startDate.getTime() - startDate.getTimezoneOffset() * 60000);
  const targetDate = localStart.toISOString().slice(0, 10);
  const isScheduled = startDate.getTime() > Date.now() + 60000;
  if (submitButton) submitButton.innerHTML = `<i class="fa-solid fa-spinner fa-spin mr-2"></i>문자 ${isScheduled ? '예약' : '발송'} 중 0/${withPhone.length}`;
  let cursor = 0; let success = 0; let failed = 0;
  const groupIds = [];
  const worker = async () => {
    while (cursor < withPhone.length) {
      const target = withPhone[cursor++];
      const { data, error } = await window.supabaseClient.functions.invoke('admin-send-sms', { body: { mode: 'board', userId: target.id, messageBody: body, date: targetDate, scheduledAt: startsAt, senderId, audienceType: audience } });
      if (!error && data?.ok) { success += 1; if (data.groupId) groupIds.push(data.groupId); } else failed += 1;
      if (submitButton) submitButton.innerHTML = `<i class="fa-solid fa-spinner fa-spin mr-2"></i>문자 ${isScheduled ? '예약' : '발송'} 중 ${success + failed}/${withPhone.length}`;
    }
  };
  await Promise.all(Array.from({ length: Math.min(5, withPhone.length) }, worker));
  const smsStatus = failed ? (success ? 'partial' : 'failed') : isScheduled ? 'scheduled' : 'sent';
  await window.supabaseClient.from('home_messages').update({ sms_group_ids: groupIds, sms_status: smsStatus }).eq('id', messageId);
  restoreButton();
  adminShowStatus(`메시지를 저장했습니다. 문자 ${isScheduled ? '예약' : '발송 접수'}: 성공 ${success}명${failed ? ` · 실패 ${failed}명` : ''}${missingPhoneCount ? ` · 연락처 미등록 ${missingPhoneCount}명 제외` : ''}.`, failed > 0);
  await adminLoadMessages();
  await adminLoadSmsLogs();
}

function adminWireMessageList() {
  const wrap = document.getElementById('admin-message-list');
  if (!wrap) return;
  wrap.addEventListener('click', async (event) => {
    const button = event.target.closest('[data-action]');
    const article = event.target.closest('[data-message-id]');
    if (!button || !article) return;
    const id = article.dataset.messageId;
    const message = adminMessages.find((item) => item.id === id);
    if (button.dataset.action === 'edit') {
      adminStartMessageEdit(id);
      return;
    }
    if (button.dataset.action === 'delete') {
      if (message && new Date(message.starts_at || message.created_at) > new Date() && !(await adminCancelBoardMessageSms(message))) {
        adminShowStatus('예약 문자를 취소하지 못해 메시지 삭제를 중단했습니다.', true);
        return;
      }
      await window.supabaseClient.from('home_messages').delete().eq('id', id);
      if (adminEditingMessageId === id) adminResetMessageForm();
    } else {
      const currentlyActive = !article.classList.contains('opacity-50');
      const futureMessage = message && new Date(message.starts_at || message.created_at) > new Date();
      if (currentlyActive && futureMessage && !(await adminCancelBoardMessageSms(message))) {
        adminShowStatus('예약 문자를 취소하지 못해 비활성화를 중단했습니다.', true);
        return;
      }
      await window.supabaseClient.from('home_messages').update({ is_active: !currentlyActive }).eq('id', id);
      if (!currentlyActive && futureMessage) {
        await adminSendBoardMessageSms(message.id, message.recipient_user_id, message.body, message.starts_at, message.sender_user_id || message.created_by, message.recipient_user_id ? 'personal' : 'global', null, '');
      }
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
let adminFullAccess = false;
let adminCommentTabAccess = false;
const ADMIN_DASHBOARD_PAGE_SIZE = 20;
let adminDashboardPage = 1;
let adminStatRows = [];

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
const ADMIN_FULL_ONLY_TABS = new Set(['board-manage', 'gallery-manage', 'control', 'member', 'dashboard', 'stat']);

function adminWireTabs() {
  const validTabs = ['board', 'gallery', 'comment', 'board-manage', 'gallery-manage', 'control', 'member', 'dashboard', 'stat'];
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

const ADMIN_COMMENT_ROLE_OPTIONS = [
  { role: 'admin', label: 'Admin' },
  { role: 'teacher', label: '교사' },
  { role: 'pastor', label: '목사님' },
  { role: 'department_head', label: '부장님' },
  { role: 'secretary', label: '총무님' }
];
let adminCommentRoles = new Set();

async function adminLoadCommentRoles() {
  const wrap = document.getElementById('admin-comment-roles');
  if (!wrap) return;
  const { data, error } = await window.supabaseClient.from('app_role_permissions').select('role').eq('permission_key', 'gallery_comments');
  if (error) { wrap.innerHTML = '<p class="text-sm text-error">gallery_comment_role_permission.sql을 먼저 실행해주세요.</p>'; return; }
  adminCommentRoles = new Set((data || []).map((row) => row.role));
  adminRenderCommentRoles();
}

function adminRenderCommentRoles() {
  const wrap = document.getElementById('admin-comment-roles');
  if (!wrap) return;
  wrap.innerHTML = ADMIN_COMMENT_ROLE_OPTIONS.map((option) => `<label class="glass-card rounded-full pl-3 pr-4 py-2 flex items-center gap-2 text-sm font-semibold cursor-pointer"><input type="checkbox" data-comment-role="${option.role}" class="rounded text-primary" ${adminCommentRoles.has(option.role) ? 'checked' : ''}>${option.label}</label>`).join('');
  wrap.querySelectorAll('[data-comment-role]').forEach((input) => input.addEventListener('change', () => adminToggleCommentRole(input.dataset.commentRole, input.checked, input)));
}

async function adminToggleCommentRole(role, enabled, input) {
  const label = ADMIN_COMMENT_ROLE_OPTIONS.find((option) => option.role === role)?.label || role;
  if (enabled) {
    const { error } = await window.supabaseClient.from('app_role_permissions').upsert({ permission_key: 'gallery_comments', role });
    if (error) { if (input) input.checked = false; adminShowStatus('권한을 저장하지 못했습니다.', true); return; }
    adminCommentRoles.add(role);
  } else {
    const { error } = await window.supabaseClient.from('app_role_permissions').delete().eq('permission_key', 'gallery_comments').eq('role', role);
    if (error) { if (input) input.checked = true; adminShowStatus('권한을 저장하지 못했습니다.', true); return; }
    adminCommentRoles.delete(role);
  }
  adminShowStatus(`${label} 댓글 작성 권한을 ${enabled ? '켰습니다' : '껐습니다'}.`);
}

const COMMENT_PAGE_SIZE = 5;
let commentDays = [];
let commentSelectedIndex = 0;
let commentSelectedPage = 0;
let commentUsers = [];
let commentAvatarUrls = {};
let commentCanWrite = false;
let commentWordMap = {};
let commentThreads = {};
let commentTabInitialized = false;
let commentViewMode = 'list';
let commentTableWordMap = {};
let commentTableThreadCounts = {};
let commentTableLoaded = false;
let commentProfileUserId = null;

function commentCellKey(userId, dateKey) { return `${userId}|${dateKey}`; }

function renderCommentViewTabs() {
  document.querySelectorAll('[data-comment-view-tab]').forEach((button) => {
    const active = button.dataset.commentViewTab === commentViewMode;
    button.classList.toggle('nav-pill-active', active);
    button.classList.toggle('text-on-surface-variant', !active);
  });
  document.getElementById('comment-list-view')?.classList.toggle('hidden', commentViewMode !== 'list');
  document.getElementById('comment-table-view')?.classList.toggle('hidden', commentViewMode !== 'table');
}

async function selectCommentView(view) {
  commentViewMode = view === 'table' ? 'table' : 'list';
  renderCommentViewTabs();
  if (commentViewMode === 'table') await loadCommentTable();
}

function commentPhotoHTML(record) {
  if (!record || record.photo_unavailable || !record.photo_path) {
    const message = record && Array.isArray(record.verses) && record.verses.length ? '사진 없이 인증했어요' : '아직 인증 사진이 없어요';
    return `<div class="aspect-[4/3] rounded-2xl bg-surface-container flex flex-col items-center justify-center text-on-surface-variant"><i class="fa-regular fa-image text-2xl mb-2 opacity-50"></i><p class="text-xs">${message}</p></div>`;
  }
  return `<div class="aspect-[4/3] rounded-2xl overflow-hidden bg-surface-container"><img src="${galleryEscape(getPhotoUrl(record.photo_path))}" data-gallery-photo class="w-full h-full object-contain bg-surface-container cursor-zoom-in" alt="말씀 묵상 인증 사진"></div>`;
}

function adminMessageSenderLabel(userId) {
  const member = adminMembers.find((item) => item.id === userId);
  return member?.name || '관리자';
}

function adminMessageAudienceValue() {
  return document.querySelector('input[name="admin-message-audience"]:checked')?.value === 'personal' ? 'personal' : 'global';
}

function adminSetMessageAudience(audience) {
  const value = audience === 'personal' ? 'personal' : 'global';
  const input = document.querySelector(`input[name="admin-message-audience"][value="${value}"]`);
  if (input) input.checked = true;
  const recipientWrap = document.getElementById('admin-message-recipient-wrap');
  const recipient = document.getElementById('admin-message-recipient');
  recipientWrap?.classList.toggle('hidden', value !== 'personal');
  if (recipient) {
    recipient.required = value === 'personal';
    recipient.disabled = value !== 'personal';
    if (value !== 'personal') recipient.value = '';
  }
}

function adminMessageSenderName(member) {
  return String(member?.name || '').trim() || String(member?.username || '').trim() || '관리자';
}

function adminRenderMessageSenders(selectedId = null) {
  const wrap = document.getElementById('admin-message-senders');
  if (!wrap) return;
  const managers = adminMembers.filter((member) => member.is_active && ADMIN_MESSAGE_SENDER_ROLES.has(member.app_role));
  const fallbackId = selectedId || (managers.some((member) => member.id === adminCurrentUserId) ? adminCurrentUserId : managers[0]?.id);
  wrap.innerHTML = managers.length ? managers.map((member) => {
    const senderName = adminMessageSenderName(member);
    return `<label class="glass-card rounded-2xl px-3 py-2.5 flex items-center gap-3 cursor-pointer">
    <input type="radio" name="admin-message-sender" value="${member.id}" class="text-primary" ${member.id === fallbackId ? 'checked' : ''} required>
    <span class="w-8 h-8 rounded-full bg-gradient-to-br from-primary-container to-secondary-container text-white flex items-center justify-center text-xs font-bold flex-shrink-0 overflow-hidden">${adminMemberAvatarUrls[member.id] ? `<img src="${adminEscape(adminMemberAvatarUrls[member.id])}" alt="" class="w-full h-full object-cover">` : adminEscape(senderName[0])}</span>
    <span class="min-w-0"><span class="block text-sm font-bold truncate">${adminEscape(senderName)} 선생님</span><span class="block text-[10px] text-on-surface-variant">회원가입 이름 · ${adminEscape(adminRoleLabel(member.app_role))}</span></span>
  </label>`;
  }).join('') : '<p class="text-xs text-error">활성 관리자 계정을 찾을 수 없습니다.</p>';
}

function commentProfileAvatarHTML(user, sizeClass = 'w-12 h-12') {
  const avatarUrl = commentAvatarUrls[user?.id];
  if (avatarUrl) {
    return `<div class="${sizeClass} rounded-full overflow-hidden bg-surface-container flex-shrink-0"><img src="${galleryEscape(avatarUrl)}" alt="${galleryEscape(user?.name || '')} 프로필 사진" class="w-full h-full object-cover"></div>`;
  }
  return `<div class="${sizeClass} rounded-full bg-gradient-to-br from-primary-container to-tertiary-container text-white flex items-center justify-center font-bold flex-shrink-0">${galleryEscape((user?.name || '?').charAt(0))}</div>`;
}

function commentProfilePhotoHTML(record) {
  if (record.photo_unavailable || !record.photo_path) {
    return `<div class="aspect-square bg-surface-container flex flex-col items-center justify-center text-on-surface-variant"><i class="fa-regular fa-image text-3xl mb-2 opacity-40"></i><p class="text-xs">사진 없이 인증했어요</p></div>`;
  }
  return `<div class="aspect-square bg-surface-container overflow-hidden"><img src="${galleryEscape(getPhotoUrl(record.photo_path))}" data-gallery-photo class="w-full h-full object-contain cursor-zoom-in" alt="말씀 묵상 인증 사진"></div>`;
}

function commentProfileCommentHTML(comment, profiles) {
  const profile = profiles[comment.author_id];
  const avatar = profile?.avatarUrl
    ? `<img src="${galleryEscape(profile.avatarUrl)}" alt="" class="w-full h-full object-cover">`
    : galleryEscape((profile?.name || profile?.username || '?').charAt(0));
  const editControl = commentCanWrite && comment.author_id === adminCurrentUserId
    ? `<button type="button" data-profile-comment-edit="${comment.id}" data-profile-comment-body="${galleryEscape(comment.body)}" class="ml-2 font-semibold hover:text-primary">수정</button>`
    : '';
  return `<div class="flex items-start gap-2.5" data-profile-comment-id="${comment.id}">
    <div class="w-8 h-8 rounded-full overflow-hidden bg-gradient-to-br from-primary-container to-tertiary-container text-white flex items-center justify-center text-xs font-bold flex-shrink-0">${avatar}</div>
    <div class="min-w-0 flex-1"><p class="text-xs leading-5 break-words"><span class="font-bold mr-1">${galleryEscape(profile?.username || profile?.name || 'member')}</span>${galleryEscape(comment.body)}</p><p class="text-[10px] text-on-surface-variant mt-0.5">${galleryRelativeTime(comment.created_at)}${editControl}</p></div>
  </div>`;
}

function commentProfilePostHTML(record, comments, profiles, user) {
  const summary = formatWordSummary(Array.isArray(record.verses) ? record.verses : []) || '말씀 묵상 인증';
  const date = galleryDateParts(record.record_date);
  return `<article class="bg-white border-y sm:border border-outline-variant sm:rounded-[1.5rem] overflow-hidden">
    <header class="flex items-center gap-3 px-4 py-3">
      ${commentProfileAvatarHTML(user, 'w-9 h-9')}
      <div class="min-w-0 flex-1"><p class="text-sm font-bold truncate">${galleryEscape(user.name)}</p><p class="text-[10px] text-on-surface-variant">${galleryEscape(record.record_date)} · ${galleryEscape(date.full)}</p></div>
      <i class="fa-solid fa-book-bible text-secondary text-sm" aria-hidden="true"></i>
    </header>
    ${commentProfilePhotoHTML(record)}
    <div class="px-4 py-4">
      <p class="text-sm leading-6"><span class="font-bold mr-2">@${galleryEscape(user.username)}</span>${galleryEscape(summary)}</p>
      <p class="text-[10px] font-semibold uppercase tracking-wide text-on-surface-variant mt-2">${galleryEscape(date.short)}</p>
      <div class="mt-4 pt-4 border-t border-outline-variant/60">
        <p class="text-xs font-bold mb-3"><i class="fa-regular fa-comment mr-1.5"></i>Comments <span class="text-on-surface-variant font-medium">${comments.length}</span></p>
        ${comments.length ? `<div class="flex flex-col gap-3">${comments.map((comment) => commentProfileCommentHTML(comment, profiles)).join('')}</div>` : '<p class="text-xs text-on-surface-variant">아직 댓글이 없습니다.</p>'}
        ${commentCanWrite ? `<form data-profile-comment-form data-profile-owner="${record.user_id}" data-profile-date="${record.record_date}" class="flex items-center gap-2 mt-4">
          <button type="button" data-profile-comment-cancel class="hidden text-xs text-on-surface-variant px-1">취소</button>
          <input type="text" data-profile-comment-input required maxlength="300" autocomplete="off" placeholder="댓글 달기..." class="glass-input flex-1 rounded-full px-4 py-2.5 text-sm">
          <button type="submit" data-profile-comment-submit class="text-primary font-bold text-sm px-2 disabled:opacity-40">게시</button>
        </form>` : ''}
      </div>
    </div>
  </article>`;
}

async function openCommentProfile(userId) {
  const user = commentUsers.find((item) => item.id === userId);
  const modal = document.getElementById('comment-profile-modal');
  const content = document.getElementById('comment-profile-content');
  if (!user || !modal || !content) return;
  commentProfileUserId = userId;
  modal.classList.remove('hidden');
  modal.classList.add('flex');
  document.body.style.overflow = 'hidden';
  content.innerHTML = '<div class="min-h-full flex items-center justify-center"><p class="text-sm text-on-surface-variant"><i class="fa-solid fa-spinner fa-spin mr-2"></i>기록을 불러오는 중</p></div>';

  const [recordsResult, commentsResult] = await Promise.all([
    window.supabaseClient.from('word_records').select('user_id,record_date,verses,photo_path,photo_unavailable,admin_hidden').eq('user_id', userId).gte('record_date', GALLERY_START_DATE).lte('record_date', GALLERY_END_DATE).order('record_date', { ascending: false }),
    window.supabaseClient.from('post_comments').select('*').eq('post_owner_id', userId).eq('post_type', 'word').gte('post_date', GALLERY_START_DATE).lte('post_date', GALLERY_END_DATE).order('created_at', { ascending: true })
  ]);
  if (commentProfileUserId !== userId) return;
  if (recordsResult.error || commentsResult.error) {
    console.error('[comment-profile]', recordsResult.error || commentsResult.error);
    content.innerHTML = '<div class="min-h-full flex items-center justify-center px-6 text-center"><p class="text-sm text-error">프로필 기록을 불러오지 못했습니다.</p></div>';
    return;
  }

  const records = (recordsResult.data || []).filter((record) => Array.isArray(record.verses) && record.verses.length > 0);
  const comments = commentsResult.data || [];
  const profiles = window.getPublicProfileCards ? await window.getPublicProfileCards(comments.map((comment) => comment.author_id)) : {};
  if (commentProfileUserId !== userId) return;
  const commentsByDate = {};
  comments.forEach((comment) => { (commentsByDate[comment.post_date] ||= []).push(comment); });
  content.innerHTML = `<section class="bg-white px-5 py-6 border-b border-outline-variant">
    <div class="flex items-center gap-5 max-w-lg mx-auto">
      ${commentProfileAvatarHTML(user, 'w-20 h-20 sm:w-24 sm:h-24')}
      <div class="min-w-0 flex-1"><h2 id="comment-profile-name" class="text-xl font-bold truncate">${galleryEscape(user.name)}</h2><p class="text-sm text-on-surface-variant truncate">@${galleryEscape(user.username)}</p><div class="mt-3"><span class="text-base font-bold">${records.length}</span><span class="text-xs text-on-surface-variant ml-1">Posts</span></div></div>
    </div>
  </section>
  <div class="max-w-xl mx-auto sm:px-5 py-5 flex flex-col gap-5">
    ${records.length ? records.map((record) => commentProfilePostHTML(record, commentsByDate[record.record_date] || [], profiles, user)).join('') : '<div class="py-20 text-center text-on-surface-variant"><i class="fa-regular fa-images text-3xl mb-3 opacity-40"></i><p class="text-sm">아직 말씀 묵상 기록이 없습니다.</p></div>'}
  </div>`;
  content.scrollTop = 0;
}

function closeCommentProfile() {
  const modal = document.getElementById('comment-profile-modal');
  modal?.classList.add('hidden');
  modal?.classList.remove('flex');
  commentProfileUserId = null;
  document.body.style.overflow = '';
}

function commentDayMeta() {
  const count = document.getElementById('comment-day-count');
  if (count) count.textContent = `DAY ${commentSelectedIndex + 1} / ${commentDays.length}`;
  const select = document.getElementById('comment-day-select');
  if (select) select.value = commentDays[commentSelectedIndex];
  const prev = document.getElementById('comment-prev-day');
  const next = document.getElementById('comment-next-day');
  if (prev) prev.disabled = commentSelectedIndex === 0;
  if (next) next.disabled = commentSelectedIndex === commentDays.length - 1;
}

function renderCommentDaySelect() {
  const select = document.getElementById('comment-day-select');
  if (!select) return;
  select.innerHTML = commentDays.map((day) => `<option value="${day}">${day} · ${galleryDateParts(day).full}</option>`).join('');
}

function renderCommentList() {
  const wrap = document.getElementById('comment-list');
  if (!wrap) return;
  if (!commentUsers.length) { wrap.innerHTML = '<p class="text-sm text-on-surface-variant py-10 text-center">표시할 학생이 없습니다.</p>'; renderCommentPagination(); return; }
  const start = commentSelectedPage * COMMENT_PAGE_SIZE;
  const pageUsers = commentUsers.slice(start, start + COMMENT_PAGE_SIZE);
  wrap.innerHTML = pageUsers.map((user) => {
    const record = commentWordMap[user.id];
    const verses = record && Array.isArray(record.verses) ? record.verses : [];
    const verified = verses.length > 0;
    const threads = commentThreads[user.id] || [];
    const avatar = commentAvatarUrls[user.id]
      ? `<img src="${galleryEscape(commentAvatarUrls[user.id])}" alt="" class="w-full h-full object-cover">`
      : (galleryEscape(user.name).charAt(0) || '?');
    return `<article class="glass-card rounded-2xl p-4" data-comment-user="${user.id}">
      <div class="flex flex-wrap items-center gap-2 mb-3">
        <button type="button" data-comment-profile-user="${user.id}" class="w-10 h-10 rounded-full bg-gradient-to-br from-primary-container to-tertiary-container text-white flex items-center justify-center font-bold flex-shrink-0 overflow-hidden ring-offset-2 hover:ring-2 hover:ring-primary focus:outline-none focus:ring-2 focus:ring-primary transition-shadow" aria-label="${galleryEscape(user.name)}님의 기록 보기" title="기존 기록 보기">${avatar}</button>
        <div class="min-w-0 flex-1"><p class="font-bold text-sm truncate">${galleryEscape(user.name)}</p><p class="text-[11px] text-on-surface-variant truncate">@${galleryEscape(user.username)}</p></div>
        <span class="rounded-full px-2.5 py-1 text-[11px] font-semibold flex-shrink-0 ${verified ? 'text-secondary bg-secondary/10' : 'text-on-surface-variant bg-surface-container'}">${verified ? '인증완료' : '미인증'}</span>
        <span class="rounded-full px-2.5 py-1 text-[11px] font-semibold flex-shrink-0 ${threads.length ? 'text-primary bg-primary/10' : 'text-on-surface-variant bg-surface-container'}">${threads.length ? `댓글 ${threads.length}개` : '댓글 없음'}</span>
      </div>
      <div class="mb-3">${commentPhotoHTML(record)}</div>
      ${threads.length ? `<div class="flex flex-col gap-1.5 mb-3 pl-3 border-l-2 border-outline-variant/40">${threads.map((c) => `<p class="text-xs leading-5">${galleryEscape(c.body)} <span class="text-on-surface-variant">· ${galleryRelativeTime(c.created_at)}</span></p>`).join('')}</div>` : ''}
      ${commentCanWrite
        ? `<form data-comment-form="${user.id}" class="flex items-center gap-2"><input type="text" data-comment-input required maxlength="300" autocomplete="off" placeholder="댓글 달기..." class="glass-input flex-1 rounded-full px-4 py-2 text-sm"><button type="submit" class="text-primary font-bold text-sm px-2">게시</button></form>`
        : ''}
    </article>`;
  }).join('');
  renderCommentPagination();
}

function renderCommentPagination() {
  const nav = document.getElementById('comment-pagination');
  if (!nav) return;
  const pageCount = Math.max(1, Math.ceil(commentUsers.length / COMMENT_PAGE_SIZE));
  commentSelectedPage = Math.min(commentSelectedPage, pageCount - 1);
  nav.innerHTML = Array.from({ length: pageCount }, (_, index) => `<button type="button" data-comment-page="${index}" class="w-9 h-9 rounded-full text-sm font-bold ${index === commentSelectedPage ? 'nav-pill-active' : 'glass-card text-on-surface-variant'}" aria-label="${index + 1}페이지">${index + 1}</button>`).join('');
}

async function loadCommentTable() {
  const wrap = document.getElementById('comment-table');
  if (!wrap) return;
  const ids = commentUsers.map((user) => user.id);
  if (!ids.length) { wrap.innerHTML = '<p class="text-sm text-on-surface-variant py-10 text-center">표시할 학생이 없습니다.</p>'; return; }
  wrap.innerHTML = '<p class="text-sm text-on-surface-variant py-10 text-center"><i class="fa-solid fa-spinner fa-spin mr-2"></i>불러오는 중</p>';
  const [wordResult, commentsResult] = await Promise.all([
    window.supabaseClient.from('word_records').select('user_id, record_date, verses').in('user_id', ids).in('record_date', commentDays),
    window.supabaseClient.from('post_comments').select('post_owner_id, post_date').in('post_owner_id', ids).eq('post_type', 'word').in('post_date', commentDays)
  ]);
  if (wordResult.error || commentsResult.error) { wrap.innerHTML = '<p class="text-sm text-error py-10 text-center">현황을 불러오지 못했습니다.</p>'; return; }
  commentTableWordMap = {};
  (wordResult.data || []).forEach((row) => {
    const verified = Array.isArray(row.verses) && row.verses.length > 0;
    if (verified) commentTableWordMap[commentCellKey(row.user_id, row.record_date)] = true;
  });
  commentTableThreadCounts = {};
  (commentsResult.data || []).forEach((row) => {
    const key = commentCellKey(row.post_owner_id, row.post_date);
    commentTableThreadCounts[key] = (commentTableThreadCounts[key] || 0) + 1;
  });
  commentTableLoaded = true;
  renderCommentTable();
}

function commentTableCellHTML(userId, dateKey) {
  const key = commentCellKey(userId, dateKey);
  if (!commentTableWordMap[key]) return '<span class="text-outline-variant">–</span>';
  if (commentTableThreadCounts[key]) return `<button type="button" data-comment-jump-user="${userId}" data-comment-jump-date="${dateKey}" class="inline-flex w-6 h-6 rounded-full bg-quaternary/15 text-quaternary hover:bg-quaternary hover:text-white items-center justify-center transition-colors" title="댓글 보기"><i class="fa-solid fa-check text-[11px]"></i></button>`;
  return `<button type="button" data-comment-jump-user="${userId}" data-comment-jump-date="${dateKey}" class="inline-flex w-6 h-6 rounded-full bg-error/10 text-error hover:bg-error hover:text-white items-center justify-center transition-colors" title="댓글 달기"><i class="fa-solid fa-comment-dots text-[11px]"></i></button>`;
}

function renderCommentTable() {
  const wrap = document.getElementById('comment-table');
  if (!wrap) return;
  if (!commentUsers.length) { wrap.innerHTML = '<p class="text-sm text-on-surface-variant py-10 text-center">표시할 학생이 없습니다.</p>'; return; }
  const headerCells = commentDays.map((day) => `<th class="px-2 py-2 text-center text-[10px] font-bold text-on-surface-variant whitespace-nowrap">${galleryDateParts(day).short}</th>`).join('');
  const rows = commentUsers.map((user) => `<tr>
    <td class="sticky left-0 bg-white px-3 py-2 text-xs font-bold whitespace-nowrap border-r border-outline-variant/30">${galleryEscape(user.name)}</td>
    ${commentDays.map((day) => `<td class="px-2 py-2 text-center">${commentTableCellHTML(user.id, day)}</td>`).join('')}
  </tr>`).join('');
  wrap.innerHTML = `<table class="border-collapse w-full"><thead><tr><th class="sticky left-0 bg-white px-3 py-2 text-left text-[10px] font-bold text-on-surface-variant border-r border-outline-variant/30">학생</th>${headerCells}</tr></thead><tbody>${rows}</tbody></table>`;
}

async function loadCommentDay() {
  const dateKey = commentDays[commentSelectedIndex];
  const ids = commentUsers.map((user) => user.id);
  if (!ids.length) { commentWordMap = {}; commentThreads = {}; renderCommentList(); return; }
  const [wordResult, commentsResult] = await Promise.all([
    window.supabaseClient.from('word_records').select('user_id, record_date, verses, photo_path, photo_unavailable, admin_hidden').eq('record_date', dateKey).in('user_id', ids),
    window.supabaseClient.from('post_comments').select('*').in('post_owner_id', ids).eq('post_date', dateKey).eq('post_type', 'word').order('created_at', { ascending: true })
  ]);
  if (wordResult.error || commentsResult.error) { adminShowStatus('말씀 묵상 기록을 불러오지 못했습니다.', true); return; }
  commentWordMap = Object.fromEntries((wordResult.data || []).map((row) => [row.user_id, row]));
  commentThreads = {};
  (commentsResult.data || []).forEach((row) => { (commentThreads[row.post_owner_id] ||= []).push(row); });
  renderCommentList();
}

async function selectCommentDay(index) {
  commentSelectedIndex = Math.max(0, Math.min(commentDays.length - 1, index));
  commentSelectedPage = 0;
  commentDayMeta();
  await loadCommentDay();
}

async function jumpToCommentEntry(userId, dateKey) {
  const dayIndex = commentDays.indexOf(dateKey);
  if (dayIndex < 0) return;
  const userIndex = commentUsers.findIndex((user) => user.id === userId);
  commentSelectedIndex = dayIndex;
  commentSelectedPage = userIndex >= 0 ? Math.floor(userIndex / COMMENT_PAGE_SIZE) : 0;
  commentViewMode = 'list';
  renderCommentViewTabs();
  commentDayMeta();
  await loadCommentDay();
  const row = document.querySelector(`#comment-list [data-comment-user="${userId}"]`);
  if (!row) return;
  row.scrollIntoView({ behavior: 'smooth', block: 'center' });
  row.classList.add('ring-2', 'ring-primary');
  setTimeout(() => row.classList.remove('ring-2', 'ring-primary'), 2000);
  row.querySelector('[data-comment-input]')?.focus();
}

function wireCommentControls() {
  document.getElementById('comment-view-tabs')?.addEventListener('click', (event) => {
    const button = event.target.closest('[data-comment-view-tab]');
    if (!button) return;
    selectCommentView(button.dataset.commentViewTab);
  });
  document.getElementById('comment-table')?.addEventListener('click', (event) => {
    const button = event.target.closest('[data-comment-jump-user]');
    if (!button) return;
    jumpToCommentEntry(button.dataset.commentJumpUser, button.dataset.commentJumpDate);
  });
  document.getElementById('comment-prev-day')?.addEventListener('click', () => selectCommentDay(commentSelectedIndex - 1));
  document.getElementById('comment-next-day')?.addEventListener('click', () => selectCommentDay(commentSelectedIndex + 1));
  document.getElementById('comment-day-select')?.addEventListener('change', (event) => selectCommentDay(commentDays.indexOf(event.target.value)));
  document.getElementById('comment-pagination')?.addEventListener('click', (event) => {
    const button = event.target.closest('[data-comment-page]');
    if (!button) return;
    commentSelectedPage = Number(button.dataset.commentPage);
    renderCommentList();
    document.getElementById('comment-list')?.scrollIntoView({ behavior: 'smooth', block: 'start' });
  });
  document.getElementById('comment-list')?.addEventListener('click', (event) => {
    const profileButton = event.target.closest('[data-comment-profile-user]');
    if (profileButton) openCommentProfile(profileButton.dataset.commentProfileUser);
  });
  document.getElementById('comment-profile-overlay')?.addEventListener('click', closeCommentProfile);
  document.getElementById('comment-profile-back')?.addEventListener('click', closeCommentProfile);
  document.getElementById('comment-profile-close')?.addEventListener('click', closeCommentProfile);
  document.getElementById('comment-profile-content')?.addEventListener('click', (event) => {
    const editButton = event.target.closest('[data-profile-comment-edit]');
    const cancelButton = event.target.closest('[data-profile-comment-cancel]');
    if (editButton) {
      const article = editButton.closest('article');
      const form = article?.querySelector('[data-profile-comment-form]');
      const input = form?.querySelector('[data-profile-comment-input]');
      if (!form || !input) return;
      form.dataset.editingCommentId = editButton.dataset.profileCommentEdit;
      input.value = editButton.dataset.profileCommentBody || '';
      input.focus();
      form.querySelector('[data-profile-comment-submit]').textContent = '수정';
      form.querySelector('[data-profile-comment-cancel]').classList.remove('hidden');
      return;
    }
    if (cancelButton) {
      const form = cancelButton.closest('[data-profile-comment-form]');
      if (!form) return;
      delete form.dataset.editingCommentId;
      form.querySelector('[data-profile-comment-input]').value = '';
      form.querySelector('[data-profile-comment-submit]').textContent = '게시';
      cancelButton.classList.add('hidden');
    }
  });
  document.getElementById('comment-profile-content')?.addEventListener('submit', async (event) => {
    const form = event.target.closest('[data-profile-comment-form]');
    if (!form) return;
    event.preventDefault();
    if (!commentCanWrite || !commentProfileUserId) return;
    const input = form.querySelector('[data-profile-comment-input]');
    const submit = form.querySelector('[data-profile-comment-submit]');
    const body = input.value.trim();
    if (!body) return;
    submit.disabled = true;
    const editingId = form.dataset.editingCommentId;
    const result = editingId
      ? await window.supabaseClient.from('post_comments').update({ body }).eq('id', editingId).eq('author_id', adminCurrentUserId)
      : await window.supabaseClient.from('post_comments').insert({
          post_owner_id: form.dataset.profileOwner,
          post_date: form.dataset.profileDate,
          post_type: 'word',
          author_id: adminCurrentUserId,
          body
        });
    submit.disabled = false;
    if (result.error) {
      console.error('[comment-profile] save comment', result.error);
      adminShowStatus(editingId ? '댓글을 수정하지 못했습니다.' : '댓글을 저장하지 못했습니다.', true);
      return;
    }
    const activeUserId = commentProfileUserId;
    await openCommentProfile(activeUserId);
    adminShowStatus(editingId ? '댓글을 수정했습니다.' : '댓글을 저장했습니다.');
  });
  document.addEventListener('keydown', (event) => {
    const modal = document.getElementById('comment-profile-modal');
    if (event.key === 'Escape' && modal && !modal.classList.contains('hidden')) closeCommentProfile();
  });
  document.getElementById('comment-list')?.addEventListener('submit', async (event) => {
    const form = event.target.closest('[data-comment-form]');
    if (!form) return;
    event.preventDefault();
    const input = form.querySelector('[data-comment-input]');
    const body = input.value.trim();
    if (!body) return;
    const submitButton = form.querySelector('button[type="submit"]');
    submitButton.disabled = true;
    const { error } = await window.supabaseClient.from('post_comments').insert({
      post_owner_id: form.dataset.commentForm, post_date: commentDays[commentSelectedIndex], post_type: 'word', author_id: adminCurrentUserId, body
    });
    submitButton.disabled = false;
    if (error) { adminShowStatus('댓글을 저장하지 못했습니다.', true); return; }
    input.value = '';
    await loadCommentDay();
  });
}

async function adminLoadCommentTab() {
  if (!commentTabInitialized) {
    commentTabInitialized = true;
    commentDays = buildGalleryDays();
    commentSelectedIndex = galleryDefaultDayIndex();
    commentUsers = await loadGalleryUsers();
    commentAvatarUrls = window.getProfileAvatarUrls ? await window.getProfileAvatarUrls(commentUsers.map((user) => user.id)) : {};
    commentCanWrite = await loadGalleryCommentPermission();
    wireCommentControls();
    renderCommentDaySelect();
  }
  commentDayMeta();
  if (commentViewMode === 'table') { await loadCommentTable(); } else { await loadCommentDay(); }
}

async function adminLoadMembers() {
  const { data, error } = await window.supabaseClient.rpc('admin_get_members');
  if (error) { adminShowStatus('회원 정보를 불러오지 못했습니다. 관리자 스키마를 확인해주세요.', true); return; }
  adminMembers = data || [];
  adminMemberAvatarUrls = window.getProfileAvatarUrls
    ? await window.getProfileAvatarUrls(adminMembers.map((member) => member.id))
    : {};
  adminRenderMembers();
  adminRenderMessageSenders(document.querySelector('input[name="admin-message-sender"]:checked')?.value || null);
  await adminLoadMessages();
}

function adminRenderMembers() {
  const wrap = document.getElementById('admin-member-list');
  const query = (document.getElementById('admin-member-search')?.value || '').trim().toLowerCase();
  if (!wrap) return;
  const filtered = adminMembers.filter((member) => !query || `${member.name} ${member.username} ${member.grade_class}`.toLowerCase().includes(query));
  wrap.innerHTML = filtered.map((member) => `<article class="admin-member-row glass-card rounded-2xl p-4 flex flex-wrap sm:flex-nowrap items-center gap-3 ${member.is_active ? '' : 'opacity-50'}" data-member-id="${member.id}"><div class="w-11 h-11 rounded-full bg-gradient-to-br from-primary-container to-secondary-container text-white flex items-center justify-center font-bold overflow-hidden">${adminMemberAvatarUrls[member.id] ? `<img src="${adminEscape(adminMemberAvatarUrls[member.id])}" alt="" class="w-full h-full object-cover">` : adminEscape((member.name || '?')[0])}</div><div class="min-w-0 flex-1"><div class="flex items-center gap-1.5"><p class="font-bold truncate">${adminEscape(member.name)}</p>${adminRoleBadge(member)}</div><p class="text-xs text-on-surface-variant truncate">@${adminEscape(member.username)} · ${adminEscape(member.grade_class || '-')}</p></div><p class="text-xs font-semibold text-on-surface-variant whitespace-nowrap">${member.is_active ? '활성' : '비활성'} · ${adminEscape(adminRoleLabel(member.app_role))}</p><button type="button" data-edit-member class="icon-glass w-10 h-10 rounded-full"><i class="fa-solid fa-ellipsis"></i></button></article>`).join('') || '<p class="text-sm text-on-surface-variant py-10 text-center">검색 결과가 없습니다.</p>';
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
  const roleSelect = document.getElementById('admin-member-role');
  if (roleSelect) roleSelect.innerHTML = '<option value="admin">Admin</option><option value="pastor">목사님</option><option value="department_head">부장님</option><option value="secretary">총무님</option><option value="teacher">교사</option><option value="student">학생</option>';
  const hostLabel = document.getElementById('admin-member-host')?.closest('label');
  const activeLabel = document.getElementById('admin-member-active')?.closest('label');
  if (hostLabel?.firstChild) hostLabel.firstChild.textContent = '호스트 ';
  if (activeLabel?.firstChild) activeLabel.firstChild.textContent = '활성 ';
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
  wrap.innerHTML = `<div class="grid grid-cols-[minmax(220px,1.6fr)_repeat(4,minmax(110px,1fr))_240px] gap-3 px-3 pb-3 text-[10px] font-bold tracking-wider text-on-surface-variant"><span>학생</span><span>기도</span><span>말씀</span><span>공부</span><span>예배</span><span>관리</span></div>${pageRows.map((row) => { const missing = adminDashboardMissing(row, worshipRequired); return `<article class="grid grid-cols-[minmax(220px,1.6fr)_repeat(4,minmax(110px,1fr))_240px] gap-3 items-center glass-card rounded-2xl px-3 py-3 mb-2" data-dashboard-user="${row.user_id}"><div><p class="text-sm font-bold">${adminEscape(row.name)}</p><p class="text-[10px] text-on-surface-variant">@${adminEscape(row.username)}</p></div>${adminDoneCell(row.pray_done,row.pray_minutes,'pray')}${adminDoneCell(row.word_done,row.word_minutes,'word')}${adminDoneCell(row.study_done,row.study_minutes,'study')}${adminDoneCell(row.worship_done,row.worship_minutes,'worship',worshipRequired)}<div class="flex items-center gap-2"><button data-report-view class="icon-glass w-9 h-9 rounded-full text-primary" title="개인 리포트 보기"><i class="fa-solid fa-file-lines text-sm"></i></button><button data-report-sms class="icon-glass w-9 h-9 rounded-full text-emerald-500" title="학부모에게 리포트 링크 전송"><i class="fa-solid fa-link text-sm"></i></button><button data-sms data-missing="${adminEscape(missing.join(', '))}" class="icon-glass w-9 h-9 rounded-full ${missing.length ? 'text-sky-500' : 'opacity-30'}" ${missing.length ? '' : 'disabled'} title="학생에게 미인증 문자 발송"><i class="fa-solid fa-paper-plane text-sm"></i></button></div></article>`; }).join('') || '<p class="text-sm text-on-surface-variant py-10 text-center">학생이 없습니다.</p>'}`;
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
    await adminLoadSmsLogs();
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
  await adminLoadSmsLogs();
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
  wrap.innerHTML = (data || []).map((log) => {
    const items = log.missing_items || [];
    const detail = items.includes('개인 리포트') ? '개인 리포트 링크' : `미인증 ${items.join(', ')}`;
    return `<article class="glass-card rounded-2xl px-4 py-3 flex flex-wrap sm:flex-nowrap items-center gap-3"><span class="w-8 h-8 rounded-full flex items-center justify-center flex-shrink-0 ${log.status === 'success' ? 'bg-sky-100 text-sky-500' : 'bg-error-container text-error'}"><i class="fa-solid ${log.status === 'success' ? 'fa-check' : 'fa-xmark'} text-xs"></i></span><div class="min-w-0 flex-1"><p class="text-sm font-bold">${adminEscape(log.target_name || '학생')} <span class="font-normal text-on-surface-variant">· ${adminEscape(log.grade_class || '-')}</span></p><p class="text-xs text-on-surface-variant truncate">${adminEscape(log.target_date || '')} · ${adminEscape(detail)}${log.error_message ? ` · ${adminEscape(log.error_message)}` : ''}</p></div><time class="text-[10px] text-on-surface-variant whitespace-nowrap">${new Date(log.created_at).toLocaleString('ko-KR')}</time></article>`;
  }).join('') || '<p class="text-xs text-on-surface-variant py-4 text-center">아직 문자 발송 기록이 없습니다.</p>';
}

async function adminLoadAllStats() {
  const wrap = document.getElementById('admin-stat-list');
  if (wrap) wrap.innerHTML = '<p class="text-sm text-on-surface-variant py-10 text-center"><i class="fa-solid fa-spinner fa-spin mr-2"></i>회원 통계를 불러오고 있습니다.</p>';
  const { data, error } = await window.supabaseClient.rpc('admin_get_all_member_stats');
  if (error) {
    if (wrap) wrap.innerHTML = '<p class="text-sm text-error py-10 text-center">admin_console_schema.sql을 다시 실행해주세요.</p>';
    return;
  }
  adminStatRows = data || [];
  adminRenderAllStats();
}

function adminRenderAllStats() {
  const search = (document.getElementById('admin-stat-search')?.value || '').trim().toLowerCase();
  const role = document.getElementById('admin-stat-role')?.value || 'student';
  const filtered = adminStatRows.filter((row) => (role === 'all' || row.app_role === role)
    && (!search || `${row.name} ${row.username} ${row.grade_class}`.toLowerCase().includes(search)));

  const wrap = document.getElementById('admin-stat-list');
  if (!wrap) return;
  const header = '<div class="grid grid-cols-[minmax(220px,1.6fr)_repeat(4,minmax(100px,1fr))_minmax(115px,1fr)_90px] gap-3 px-3 pb-3 text-[10px] font-bold tracking-wider text-on-surface-variant"><span>Member</span><span>기도</span><span>말씀</span><span>공부</span><span>예배</span><span>총 시간</span><span>300분 달성</span></div>';
  const rows = filtered.map((row) => `<article class="grid grid-cols-[minmax(220px,1.6fr)_repeat(4,minmax(100px,1fr))_minmax(115px,1fr)_90px] gap-3 items-center glass-card rounded-2xl px-3 py-3 mb-2 ${row.is_active ? '' : 'opacity-50'}"><div class="min-w-0"><div class="flex items-center gap-1.5"><p class="text-sm font-bold truncate">${adminEscape(row.name)}</p>${adminRoleBadge(row)}</div><p class="text-[10px] text-on-surface-variant truncate">@${adminEscape(row.username)} · ${adminEscape(row.grade_class || '학년/반 미지정')} · ${row.is_active ? '활성' : '비활성'} · ${adminEscape(adminRoleLabel(row.app_role))}</p></div><span class="text-xs font-semibold">${adminFormatMinutes(row.pray_minutes)}</span><span class="text-xs font-semibold">${adminFormatMinutes(row.word_minutes)}</span><span class="text-xs font-semibold">${adminFormatMinutes(row.study_minutes)}</span><span class="text-xs font-semibold">${adminFormatMinutes(row.worship_minutes)}</span><span class="text-sm font-bold text-primary">${adminFormatMinutes(row.total_minutes)}</span><span class="text-xs font-bold">${Number(row.goal_days) || 0}일</span></article>`).join('') || '<p class="text-sm text-on-surface-variant py-10 text-center">조건에 맞는 Member가 없습니다.</p>';
  wrap.innerHTML = header + rows;
}

function adminWireConsole() {
  adminWireTabs(); adminWireMember();
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
  document.getElementById('admin-sms-log-refresh')?.addEventListener('click', adminLoadSmsLogs);
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
    await adminLoadUsers();
  }
  adminWireConsole();
  if (adminFullAccess) await Promise.all([adminLoadMessages(), adminLoadVerses(), adminLoadMembers()]);
}

window.initAdminWidgets = initAdminWidgets;
