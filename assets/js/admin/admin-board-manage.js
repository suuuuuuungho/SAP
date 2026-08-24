// Admin 콘솔 — Board manage 탭: Board Message(전체 공지/개인 메시지) + 학부모 메시지.

let adminUsers = [];
let adminEditingMessageId = null;
let adminMessages = [];
const ADMIN_MESSAGE_PAGE_SIZE = 5;
let adminMessageHistoryFilter = 'global';
let adminMessageHistoryPage = 1;
let adminMessageHistoryCount = 0;
const ADMIN_MESSAGE_SENDER_ROLES = new Set(['admin', 'teacher', 'pastor', 'department_head', 'secretary']);
let adminParentMessages = [];
let adminParentMessageHistoryFilter = 'global';
let adminParentMessageHistoryPage = 1;
let adminParentMessageHistoryCount = 0;

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

function adminParentRecipientLabel(userId) {
  if (!userId) return '전체 학부모';
  const member = adminMembers.find((item) => item.id === userId);
  return member ? `${member.name} 학생 학부모님` : '학생 학부모님';
}

async function adminLoadMessages() {
  const from = (adminMessageHistoryPage - 1) * ADMIN_MESSAGE_PAGE_SIZE;
  const to = from + ADMIN_MESSAGE_PAGE_SIZE - 1;
  let query = window.supabaseClient.from('home_messages').select('*', { count: 'exact' }).order('created_at', { ascending: false });
  query = adminMessageHistoryFilter === 'personal'
    ? query.not('recipient_user_id', 'is', null)
    : query.is('recipient_user_id', null);
  const { data, error, count } = await query.range(from, to);
  if (error) { console.error('[admin] messages', error); return; }
  adminMessageHistoryCount = count || 0;
  const totalPages = Math.max(1, Math.ceil(adminMessageHistoryCount / ADMIN_MESSAGE_PAGE_SIZE));
  if (adminMessageHistoryPage > totalPages) {
    adminMessageHistoryPage = totalPages;
    await adminLoadMessages();
    return;
  }
  adminMessages = data || [];
  const wrap = document.getElementById('admin-message-list');
  if (!wrap) return;
  const now = new Date();
  wrap.innerHTML = adminMessages.length ? adminMessages.map((message) => {
    const startsAt = new Date(message.starts_at || message.created_at);
    const expiresAt = message.expires_at ? new Date(message.expires_at) : null;
    const isCancelled = message.sms_status === 'cancelled' || message.sms_status === 'partial_cancelled';
    const timingLabel = isCancelled ? '예약취소됨' : startsAt > now ? '예약' : expiresAt && expiresAt <= now ? '종료' : '게시 중';
    const timingClass = isCancelled ? 'bg-error/10 text-error' : startsAt > now ? 'bg-secondary/10 text-secondary' : expiresAt && expiresAt <= now ? 'bg-surface-container text-on-surface-variant' : 'bg-quaternary/10 text-quaternary';
    return `
    <article class="glass-card rounded-2xl p-4 ${message.is_active ? '' : 'opacity-50'}" data-message-id="${message.id}">
      <div class="flex items-start justify-between gap-3">
        <div class="min-w-0">
          <div class="flex flex-wrap items-center gap-1.5 mb-1"><span class="text-[10px] font-bold rounded-full px-2 py-0.5 ${message.recipient_user_id ? 'bg-secondary/10 text-secondary' : 'bg-primary/10 text-primary'}">${message.recipient_user_id ? '개인 메시지' : '전체 공지'}</span><span class="text-[10px] font-bold rounded-full px-2 py-0.5 ${timingClass}">${timingLabel}</span></div>
          <p class="text-[11px] font-bold text-secondary mb-1">${adminEscape(adminRecipientLabel(message.recipient_user_id))} · ${adminEscape(adminMessageSenderLabel(message.sender_user_id || message.created_by))} 선생님</p>
          <p class="text-sm whitespace-pre-wrap">${adminEscape(message.body)}</p>
          <p class="text-[10px] text-on-surface-variant mt-2">${startsAt.toLocaleString('ko-KR')}부터${message.expires_at ? ` · ${expiresAt.toLocaleString('ko-KR')}까지` : ''} · 문자 ${{ scheduled: '예약됨', sent: '발송 접수', partial: '일부 실패', cancelled: '취소됨', partial_cancelled: '일부만 취소됨' }[message.sms_status] || '미접수'}</p>
        </div>
        <div class="flex gap-1 flex-shrink-0">
          <button type="button" data-action="edit" class="icon-glass w-8 h-8 rounded-full" aria-label="수정"><i class="fa-solid fa-pen text-xs"></i></button>
          <button type="button" data-action="toggle" class="icon-glass w-8 h-8 rounded-full" aria-label="활성 전환"><i class="fa-solid ${message.is_active ? 'fa-eye' : 'fa-eye-slash'} text-xs"></i></button>
          <button type="button" data-action="delete" class="icon-glass w-8 h-8 rounded-full text-error" aria-label="삭제"><i class="fa-solid fa-trash text-xs"></i></button>
        </div>
      </div>
    </article>`;
  }).join('') : `<p class="text-sm text-on-surface-variant py-8 text-center">등록된 ${adminMessageHistoryFilter === 'personal' ? '개인 공지' : '전체 공지'}가 없습니다.</p>`;
  adminRenderMessageHistoryControls();
}

function adminRenderMessageHistoryControls() {
  document.querySelectorAll('[data-message-history-filter]').forEach((button) => {
    const active = button.dataset.messageHistoryFilter === adminMessageHistoryFilter;
    button.classList.toggle('nav-pill-active', active);
    button.classList.toggle('text-on-surface-variant', !active);
    button.setAttribute('aria-selected', String(active));
  });
  const count = document.getElementById('admin-message-history-count');
  if (count) count.textContent = `총 ${adminMessageHistoryCount}개`;
  const pagination = document.getElementById('admin-message-pagination');
  if (!pagination) return;
  const totalPages = Math.max(1, Math.ceil(adminMessageHistoryCount / ADMIN_MESSAGE_PAGE_SIZE));
  pagination.innerHTML = `
    <button type="button" data-message-history-page="prev" class="icon-glass w-9 h-9 rounded-full disabled:opacity-30" aria-label="이전 페이지" ${adminMessageHistoryPage <= 1 ? 'disabled' : ''}><i class="fa-solid fa-chevron-left text-xs"></i></button>
    <span class="text-xs font-bold text-on-surface-variant">${adminMessageHistoryPage} / ${totalPages}</span>
    <button type="button" data-message-history-page="next" class="icon-glass w-9 h-9 rounded-full disabled:opacity-30" aria-label="다음 페이지" ${adminMessageHistoryPage >= totalPages ? 'disabled' : ''}><i class="fa-solid fa-chevron-right text-xs"></i></button>`;
}

async function adminLoadParentMessages() {
  const from = (adminParentMessageHistoryPage - 1) * ADMIN_MESSAGE_PAGE_SIZE;
  const to = from + ADMIN_MESSAGE_PAGE_SIZE - 1;
  let query = window.supabaseClient.from('parent_messages').select('*', { count: 'exact' }).order('created_at', { ascending: false });
  query = adminParentMessageHistoryFilter === 'personal'
    ? query.not('recipient_user_id', 'is', null)
    : query.is('recipient_user_id', null);
  const { data, error, count } = await query.range(from, to);
  const wrap = document.getElementById('admin-parent-message-list');
  if (error) { if (wrap) wrap.innerHTML = '<p class="text-sm text-error py-8 text-center">parent_messages_schema.sql을 먼저 실행해주세요.</p>'; return; }
  adminParentMessageHistoryCount = count || 0;
  const totalPages = Math.max(1, Math.ceil(adminParentMessageHistoryCount / ADMIN_MESSAGE_PAGE_SIZE));
  if (adminParentMessageHistoryPage > totalPages) {
    adminParentMessageHistoryPage = totalPages;
    await adminLoadParentMessages();
    return;
  }
  adminParentMessages = data || [];
  if (!wrap) return;
  const now = new Date();
  wrap.innerHTML = adminParentMessages.length ? adminParentMessages.map((message) => {
    const startsAt = new Date(message.starts_at || message.created_at);
    const isCancelled = message.sms_status === 'cancelled' || message.sms_status === 'partial_cancelled';
    const scheduled = !isCancelled && startsAt > now;
    const timingLabel = isCancelled ? '예약취소됨' : scheduled ? '예약' : '발송완료';
    const timingClass = isCancelled ? 'bg-error/10 text-error' : scheduled ? 'bg-secondary/10 text-secondary' : 'bg-quaternary/10 text-quaternary';
    const statusLabel = { scheduled: '예약됨', sent: '발송 접수', partial: '일부 실패', failed: '발송 실패', no_phone: '연락처 없음', cancelled: '취소됨', partial_cancelled: '일부만 취소됨', pending: '처리 중' }[message.sms_status] || message.sms_status;
    return `
    <article class="glass-card rounded-2xl p-4" data-parent-message-id="${message.id}">
      <div class="flex items-start justify-between gap-3">
        <div class="min-w-0">
          <div class="flex flex-wrap items-center gap-1.5 mb-1"><span class="text-[10px] font-bold rounded-full px-2 py-0.5 ${message.recipient_user_id ? 'bg-secondary/10 text-secondary' : 'bg-primary/10 text-primary'}">${message.recipient_user_id ? '특정 학부모' : '전체 학부모'}</span><span class="text-[10px] font-bold rounded-full px-2 py-0.5 ${timingClass}">${timingLabel}</span></div>
          <p class="text-[11px] font-bold text-secondary mb-1">${adminEscape(adminParentRecipientLabel(message.recipient_user_id))}</p>
          <p class="text-sm whitespace-pre-wrap">${adminEscape(message.body)}</p>
          <p class="text-[10px] text-on-surface-variant mt-2">${startsAt.toLocaleString('ko-KR')} · 문자 ${statusLabel}</p>
        </div>
        <div class="flex gap-1 flex-shrink-0">
          ${scheduled ? `<button type="button" data-action="cancel" class="icon-glass w-8 h-8 rounded-full text-secondary" aria-label="예약 취소"><i class="fa-solid fa-ban text-xs"></i></button>` : ''}
          <button type="button" data-action="delete" class="icon-glass w-8 h-8 rounded-full text-error" aria-label="삭제"><i class="fa-solid fa-trash text-xs"></i></button>
        </div>
      </div>
    </article>`;
  }).join('') : `<p class="text-sm text-on-surface-variant py-8 text-center">등록된 ${adminParentMessageHistoryFilter === 'personal' ? '특정 학부모' : '전체 학부모'} 메시지가 없습니다.</p>`;
  adminRenderParentMessageHistoryControls();
}

function adminRenderParentMessageHistoryControls() {
  document.querySelectorAll('[data-parent-message-history-filter]').forEach((button) => {
    const active = button.dataset.parentMessageHistoryFilter === adminParentMessageHistoryFilter;
    button.classList.toggle('nav-pill-active', active);
    button.classList.toggle('text-on-surface-variant', !active);
    button.setAttribute('aria-selected', String(active));
  });
  const count = document.getElementById('admin-parent-message-history-count');
  if (count) count.textContent = `총 ${adminParentMessageHistoryCount}개`;
  const pagination = document.getElementById('admin-parent-message-pagination');
  if (!pagination) return;
  const totalPages = Math.max(1, Math.ceil(adminParentMessageHistoryCount / ADMIN_MESSAGE_PAGE_SIZE));
  pagination.innerHTML = `
    <button type="button" data-parent-message-history-page="prev" class="icon-glass w-9 h-9 rounded-full disabled:opacity-30" aria-label="이전 페이지" ${adminParentMessageHistoryPage <= 1 ? 'disabled' : ''}><i class="fa-solid fa-chevron-left text-xs"></i></button>
    <span class="text-xs font-bold text-on-surface-variant">${adminParentMessageHistoryPage} / ${totalPages}</span>
    <button type="button" data-parent-message-history-page="next" class="icon-glass w-9 h-9 rounded-full disabled:opacity-30" aria-label="다음 페이지" ${adminParentMessageHistoryPage >= totalPages ? 'disabled' : ''}><i class="fa-solid fa-chevron-right text-xs"></i></button>`;
}

// 그룹 취소는 all-or-nothing이 아니다: 발송 시각이 임박해 이미 이통사로 넘어간 건은
// 정상적으로 취소가 안 될 수 있으므로, 성공한 것만 반영하고 남은 실패분은 계속 추적한다.
// 반환값의 ok는 "완전히 취소됨"을 뜻하고, cancelled/failed는 호출자가 상세 메시지를 만들 때 쓴다.
async function adminCancelParentMessageSms(message) {
  const groupIds = Array.isArray(message?.sms_group_ids) ? message.sms_group_ids.filter(Boolean) : [];
  if (!groupIds.length) return { ok: true, cancelled: 0, failed: 0 };
  const { data, error } = await window.supabaseClient.functions.invoke('admin-send-sms', { body: { mode: 'board_cancel', groupIds } });
  if (error || !data?.ok) { console.error('[admin] cancel parent sms', error || data); return { ok: false, cancelled: 0, failed: groupIds.length }; }
  const failedGroupIds = Array.isArray(data.failedGroupIds) ? data.failedGroupIds.filter((id) => groupIds.includes(id)) : [];
  const cancelled = groupIds.length - failedGroupIds.length;
  await window.supabaseClient.from('parent_messages').update({
    sms_group_ids: failedGroupIds,
    sms_status: failedGroupIds.length === 0 ? 'cancelled' : cancelled > 0 ? 'partial_cancelled' : (message.sms_status || 'scheduled'),
  }).eq('id', message.id);
  return { ok: failedGroupIds.length === 0, cancelled, failed: failedGroupIds.length };
}

function adminWireParentMessageList() {
  const wrap = document.getElementById('admin-parent-message-list');
  if (!wrap) return;
  document.getElementById('admin-parent-message-history-tabs')?.addEventListener('click', async (event) => {
    const button = event.target.closest('[data-parent-message-history-filter]');
    if (!button || button.dataset.parentMessageHistoryFilter === adminParentMessageHistoryFilter) return;
    adminParentMessageHistoryFilter = button.dataset.parentMessageHistoryFilter === 'personal' ? 'personal' : 'global';
    adminParentMessageHistoryPage = 1;
    await adminLoadParentMessages();
  });
  document.getElementById('admin-parent-message-pagination')?.addEventListener('click', async (event) => {
    const button = event.target.closest('[data-parent-message-history-page]');
    if (!button || button.disabled) return;
    adminParentMessageHistoryPage += button.dataset.parentMessageHistoryPage === 'next' ? 1 : -1;
    await adminLoadParentMessages();
  });
  wrap.addEventListener('click', async (event) => {
    const button = event.target.closest('[data-action]');
    const article = event.target.closest('[data-parent-message-id]');
    if (!button || !article) return;
    const id = article.dataset.parentMessageId;
    const message = adminParentMessages.find((item) => item.id === id);
    if (!message) return;
    if (button.dataset.action === 'cancel') {
      if (!confirm('예약된 학부모 문자 발송을 취소할까요?')) return;
      const result = await adminCancelParentMessageSms(message);
      if (result.ok) {
        adminShowStatus(result.cancelled ? `예약 문자 ${result.cancelled}건을 취소했습니다.` : '취소할 예약 문자가 없습니다.');
      } else if (result.cancelled) {
        adminShowStatus(`${result.cancelled}건은 취소했지만, ${result.failed}건은 이미 발송 처리가 시작되어 취소하지 못했습니다.`, true);
      } else {
        adminShowStatus('이미 발송 처리가 시작되었거나 완료되어 취소하지 못했습니다.', true);
      }
      await adminLoadParentMessages();
      return;
    }
    if (button.dataset.action === 'delete') {
      if (new Date(message.starts_at) > new Date() && !(await adminCancelParentMessageSms(message)).ok) {
        adminShowStatus('예약 문자를 취소하지 못해 삭제를 중단했습니다. 목록에서 남은 예약 상태를 확인해주세요.', true);
        await adminLoadParentMessages();
        return;
      }
      await window.supabaseClient.from('parent_messages').delete().eq('id', id);
      if (adminParentMessages.length === 1 && adminParentMessageHistoryPage > 1) adminParentMessageHistoryPage -= 1;
      await adminLoadParentMessages();
    }
  });
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
      const cancelResult = await adminCancelBoardMessageSms(previousMessage);
      if (!cancelResult.ok) { adminShowStatus('기존 예약 문자를 취소하지 못해 수정을 중단했습니다. 목록에서 남은 예약 상태를 확인해주세요.', true); if (submitButton) submitButton.disabled = false; return; }
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
    adminMessageHistoryFilter = audience;
    adminMessageHistoryPage = 1;
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

// adminCancelParentMessageSms와 동일한 partial-cancel 방침(all-or-nothing 아님).
async function adminCancelBoardMessageSms(message) {
  const groupIds = Array.isArray(message?.sms_group_ids) ? message.sms_group_ids.filter(Boolean) : [];
  if (!groupIds.length) return { ok: true, cancelled: 0, failed: 0 };
  const { data, error } = await window.supabaseClient.functions.invoke('admin-send-sms', { body: { mode: 'board_cancel', groupIds } });
  if (error || !data?.ok) { console.error('[admin] cancel board sms', error || data); return { ok: false, cancelled: 0, failed: groupIds.length }; }
  const failedGroupIds = Array.isArray(data.failedGroupIds) ? data.failedGroupIds.filter((id) => groupIds.includes(id)) : [];
  const cancelled = groupIds.length - failedGroupIds.length;
  await window.supabaseClient.from('home_messages').update({
    sms_group_ids: failedGroupIds,
    sms_status: failedGroupIds.length === 0 ? 'cancelled' : cancelled > 0 ? 'partial_cancelled' : (message.sms_status || 'scheduled'),
  }).eq('id', message.id);
  return { ok: failedGroupIds.length === 0, cancelled, failed: failedGroupIds.length };
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
  await adminLoadSmsLogs(true);
}

function adminResetParentMessageForm() {
  const form = document.getElementById('admin-parent-message-form');
  if (form) form.reset();
  adminSetParentMessageAudience('global');
  const starts = document.getElementById('admin-parent-message-starts');
  if (starts) starts.value = adminDateTimeLocalValue(new Date().toISOString());
}

function adminWireParentMessageForm() {
  const form = document.getElementById('admin-parent-message-form');
  if (!form) return;
  document.querySelectorAll('input[name="admin-parent-message-audience"]').forEach((input) => input.addEventListener('change', () => adminSetParentMessageAudience(input.value)));
  adminResetParentMessageForm();
  adminRenderParentMessageRecipients();
  form.querySelectorAll('[data-parent-message-insert]').forEach((button) => {
    button.addEventListener('click', () => {
      const textarea = document.getElementById('admin-parent-message-body');
      if (!textarea) return;
      const placeholder = button.dataset.parentMessageInsert;
      const start = textarea.selectionStart ?? textarea.value.length;
      const end = textarea.selectionEnd ?? textarea.value.length;
      textarea.value = textarea.value.slice(0, start) + placeholder + textarea.value.slice(end);
      const cursor = start + placeholder.length;
      textarea.focus();
      textarea.setSelectionRange(cursor, cursor);
    });
  });
  form.addEventListener('submit', async (event) => {
    event.preventDefault();
    const body = document.getElementById('admin-parent-message-body').value.trim();
    const audience = adminParentMessageAudienceValue();
    const recipient = audience === 'personal' ? document.getElementById('admin-parent-message-recipient').value || null : null;
    const startsValue = document.getElementById('admin-parent-message-starts').value;
    const startsAt = startsValue ? new Date(startsValue) : null;
    if (audience === 'personal' && !recipient) { adminShowStatus('메시지를 보낼 학생을 선택해주세요.', true); return; }
    if (!body) { adminShowStatus('학부모님께 보낼 메시지를 입력해주세요.', true); return; }
    if (!startsAt || Number.isNaN(startsAt.getTime())) { adminShowStatus('시작 시각을 확인해주세요.', true); return; }
    const sixMonthsLater = new Date(); sixMonthsLater.setMonth(sixMonthsLater.getMonth() + 6);
    if (startsAt > sixMonthsLater) { adminShowStatus('문자 예약은 현재부터 최대 6개월 이내로 설정해주세요.', true); return; }
    if (!recipient) {
      const targetCount = adminMembers.filter((member) => member.app_role === 'student' && member.is_active).length;
      if (!confirm(`전체 학부모 ${targetCount}명에게 문자를 보낼까요?`)) return;
    }
    const submitButton = document.getElementById('admin-parent-message-submit');
    const originalLabel = submitButton?.textContent || '학부모님께 문자 발송';
    if (submitButton) submitButton.disabled = true;
    const { data: savedMessage, error } = await window.supabaseClient.from('parent_messages')
      .insert({ recipient_user_id: recipient, body, starts_at: startsAt.toISOString(), created_by: adminCurrentUserId })
      .select('*').single();
    if (error) {
      adminShowStatus('메시지를 저장하지 못했습니다. parent_messages_schema.sql을 먼저 실행해주세요.', true);
      console.error('[admin] save parent message', error);
      if (submitButton) submitButton.disabled = false;
      return;
    }
    adminParentMessageHistoryFilter = audience;
    adminParentMessageHistoryPage = 1;
    adminResetParentMessageForm();
    await adminSendParentMessageSms(savedMessage.id, recipient, body, startsAt.toISOString(), submitButton, originalLabel);
  });
}

// 학부모 메시지 본문의 {{이름}}/{{리포트링크}}를 학생별로 채워 넣는다.
// 리포트 링크는 실제 요청이 있을 때만(placeholder가 쓰였을 때만) 토큰을 발급해 불필요한 생성을 피한다.
async function adminPersonalizeParentMessageBody(template, member) {
  let text = template.split('{{이름}}').join(member.name || '학생');
  if (text.includes('{{리포트링크}}')) {
    try {
      const report = await adminCreateStudentReportLink(member.id);
      const siteUrl = window.APP_CONFIG?.PUBLIC_SITE_URL || ADMIN_REPORT_PUBLIC_SITE_URL;
      const url = new URL('report.html', siteUrl);
      url.searchParams.set('token', report.token);
      text = text.split('{{리포트링크}}').join(url.href);
    } catch (error) {
      console.error('[adminPersonalizeParentMessageBody] report link', member.id, error);
      text = text.split('{{리포트링크}}').join('(리포트 링크 생성 실패)');
    }
  }
  return text;
}

async function adminSendParentMessageSms(messageId, recipientId, body, startsAt, submitButton, originalLabel) {
  const restoreButton = () => { if (submitButton) { submitButton.disabled = false; submitButton.textContent = originalLabel; } };
  const targets = recipientId
    ? adminMembers.filter((member) => member.id === recipientId)
    : adminMembers.filter((member) => member.app_role === 'student' && member.is_active);
  const withPhone = targets.filter((member) => String(member.parent_phone || '').replace(/\D/g, '').length >= 10);
  const missingPhoneCount = targets.length - withPhone.length;
  if (!withPhone.length) {
    adminShowStatus(`메시지를 저장했습니다.${targets.length ? ` (연락처 미등록으로 문자는 못 보냄: ${missingPhoneCount}명)` : ''}`, targets.length > 0);
    await window.supabaseClient.from('parent_messages').update({ sms_group_ids: [], sms_status: 'no_phone' }).eq('id', messageId);
    restoreButton();
    await adminLoadParentMessages();
    return;
  }
  const startDate = new Date(startsAt);
  const localStart = new Date(startDate.getTime() - startDate.getTimezoneOffset() * 60000);
  const targetDate = localStart.toISOString().slice(0, 10);
  const isScheduled = startDate.getTime() > Date.now() + 60000;
  if (submitButton) submitButton.innerHTML = `<i class="fa-solid fa-spinner fa-spin mr-2"></i>문자 ${isScheduled ? '예약' : '발송'} 중 0/${withPhone.length}`;
  let cursor = 0; let success = 0; let failed = 0;
  const groupIds = [];
  const hasPlaceholder = body.includes('{{이름}}') || body.includes('{{리포트링크}}');
  const worker = async () => {
    while (cursor < withPhone.length) {
      const target = withPhone[cursor++];
      const messageBody = hasPlaceholder ? await adminPersonalizeParentMessageBody(body, target) : body;
      const { data, error } = await window.supabaseClient.functions.invoke('admin-send-sms', { body: { mode: 'parent', userId: target.id, messageBody, date: targetDate, scheduledAt: startsAt, audienceType: recipientId ? 'personal' : 'global' } });
      if (!error && data?.ok) { success += 1; if (data.groupId) groupIds.push(data.groupId); } else failed += 1;
      if (submitButton) submitButton.innerHTML = `<i class="fa-solid fa-spinner fa-spin mr-2"></i>문자 ${isScheduled ? '예약' : '발송'} 중 ${success + failed}/${withPhone.length}`;
    }
  };
  await Promise.all(Array.from({ length: Math.min(hasPlaceholder ? 3 : 5, withPhone.length) }, worker));
  const smsStatus = failed ? (success ? 'partial' : 'failed') : isScheduled ? 'scheduled' : 'sent';
  await window.supabaseClient.from('parent_messages').update({ sms_group_ids: groupIds, sms_status: smsStatus }).eq('id', messageId);
  restoreButton();
  adminShowStatus(`학부모 문자 ${isScheduled ? '예약' : '발송 접수'}: 성공 ${success}명${failed ? ` · 실패 ${failed}명` : ''}${missingPhoneCount ? ` · 연락처 미등록 ${missingPhoneCount}명 제외` : ''}.`, failed > 0);
  await adminLoadParentMessages();
  await adminLoadSmsLogs(true);
}

function adminWireMessageList() {
  const wrap = document.getElementById('admin-message-list');
  if (!wrap) return;
  document.getElementById('admin-message-history-tabs')?.addEventListener('click', async (event) => {
    const button = event.target.closest('[data-message-history-filter]');
    if (!button || button.dataset.messageHistoryFilter === adminMessageHistoryFilter) return;
    adminMessageHistoryFilter = button.dataset.messageHistoryFilter === 'personal' ? 'personal' : 'global';
    adminMessageHistoryPage = 1;
    await adminLoadMessages();
  });
  document.getElementById('admin-message-pagination')?.addEventListener('click', async (event) => {
    const button = event.target.closest('[data-message-history-page]');
    if (!button || button.disabled) return;
    adminMessageHistoryPage += button.dataset.messageHistoryPage === 'next' ? 1 : -1;
    await adminLoadMessages();
  });
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
      if (message && new Date(message.starts_at || message.created_at) > new Date() && !(await adminCancelBoardMessageSms(message)).ok) {
        adminShowStatus('예약 문자를 취소하지 못해 메시지 삭제를 중단했습니다. 목록에서 남은 예약 상태를 확인해주세요.', true);
        await adminLoadMessages();
        return;
      }
      await window.supabaseClient.from('home_messages').delete().eq('id', id);
      if (adminMessages.length === 1 && adminMessageHistoryPage > 1) adminMessageHistoryPage -= 1;
      if (adminEditingMessageId === id) adminResetMessageForm();
    } else {
      const currentlyActive = !article.classList.contains('opacity-50');
      const futureMessage = message && new Date(message.starts_at || message.created_at) > new Date();
      if (currentlyActive && futureMessage && !(await adminCancelBoardMessageSms(message)).ok) {
        adminShowStatus('예약 문자를 취소하지 못해 비활성화를 중단했습니다. 목록에서 남은 예약 상태를 확인해주세요.', true);
        await adminLoadMessages();
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

function adminMessageSenderLabel(userId) {
  const member = adminMembers.find((item) => item.id === userId);
  return String(member?.name || '').trim() || '이름 미등록';
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
  return String(member?.name || '').trim();
}

function adminRenderMessageSenders(selectedId = null) {
  const wrap = document.getElementById('admin-message-senders');
  if (!wrap) return;
  const managers = adminMembers.filter((member) => member.is_active && ADMIN_MESSAGE_SENDER_ROLES.has(member.app_role));
  const selectableManagers = managers.filter((member) => adminMessageSenderName(member));
  const fallbackId = selectedId || (selectableManagers.some((member) => member.id === adminCurrentUserId) ? adminCurrentUserId : selectableManagers[0]?.id);
  wrap.innerHTML = managers.length ? managers.map((member) => {
    const senderName = adminMessageSenderName(member);
    const hasSignupName = !!senderName;
    return `<label class="glass-card rounded-2xl px-3 py-2.5 flex items-center gap-3 ${hasSignupName ? 'cursor-pointer' : 'cursor-not-allowed opacity-50'}">
    <input type="radio" name="admin-message-sender" value="${member.id}" class="text-primary" ${hasSignupName && member.id === fallbackId ? 'checked' : ''} ${hasSignupName ? 'required' : 'disabled'}>
    <span class="w-8 h-8 rounded-full bg-gradient-to-br from-primary-container to-secondary-container text-white flex items-center justify-center text-xs font-bold flex-shrink-0 overflow-hidden">${adminMemberAvatarUrls[member.id] ? `<img src="${adminEscape(adminMemberAvatarUrls[member.id])}" alt="" class="w-full h-full object-cover">` : adminEscape(senderName[0] || '?')}</span>
    <span class="min-w-0"><span class="block text-sm font-bold truncate">${adminEscape(senderName || '이름 미등록')}${hasSignupName ? ' 선생님' : ''}</span><span class="block text-[10px] text-on-surface-variant">${hasSignupName ? '회원가입 이름' : 'Member에서 이름을 먼저 등록하세요'} · ${adminEscape(adminRoleLabel(member.app_role))}</span></span>
  </label>`;
  }).join('') : '<p class="text-xs text-error">활성 관리자 계정을 찾을 수 없습니다.</p>';
}

function adminParentMessageAudienceValue() {
  return document.querySelector('input[name="admin-parent-message-audience"]:checked')?.value === 'personal' ? 'personal' : 'global';
}

function adminSetParentMessageAudience(audience) {
  const value = audience === 'personal' ? 'personal' : 'global';
  const input = document.querySelector(`input[name="admin-parent-message-audience"][value="${value}"]`);
  if (input) input.checked = true;
  const recipientWrap = document.getElementById('admin-parent-message-recipient-wrap');
  const recipient = document.getElementById('admin-parent-message-recipient');
  recipientWrap?.classList.toggle('hidden', value !== 'personal');
  if (recipient) {
    recipient.required = value === 'personal';
    recipient.disabled = value !== 'personal';
    if (value !== 'personal') recipient.value = '';
  }
}

function adminRenderParentMessageRecipients(selectedId = null) {
  const select = document.getElementById('admin-parent-message-recipient');
  if (!select) return;
  const students = adminMembers.filter((member) => member.app_role === 'student' && member.is_active);
  select.innerHTML = '<option value="">학생을 선택하세요</option>' + students.map((member) =>
    `<option value="${member.id}" ${member.id === selectedId ? 'selected' : ''}>${adminEscape(member.name)} (@${adminEscape(member.username)})</option>`
  ).join('');
}
