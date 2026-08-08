// Admin 전광판: is_admin=true인 계정만 메시지/성경구절을 관리한다.

let adminCurrentUserId = null;
let adminUsers = [];
let adminEditingMessageId = null;
let adminMessages = [];

const ADMIN_BIBLE_BOOKS = [
  ['창세기','GEN'],['출애굽기','EXO'],['레위기','LEV'],['민수기','NUM'],['신명기','DEU'],['여호수아','JOS'],['사사기','JDG'],['룻기','RUT'],
  ['사무엘상','1SA'],['사무엘하','2SA'],['열왕기상','1KI'],['열왕기하','2KI'],['역대상','1CH'],['역대하','2CH'],['에스라','EZR'],['느헤미야','NEH'],
  ['에스더','EST'],['욥기','JOB'],['시편','PSA'],['잠언','PRO'],['전도서','ECC'],['아가','SNG'],['이사야','ISA'],['예레미야','JER'],
  ['예레미야애가','LAM'],['에스겔','EZK'],['다니엘','DAN'],['호세아','HOS'],['요엘','JOL'],['아모스','AMO'],['오바댜','OBA'],['요나','JON'],
  ['미가','MIC'],['나훔','NAM'],['하박국','HAB'],['스바냐','ZEP'],['학개','HAG'],['스가랴','ZEC'],['말라기','MAL'],
  ['마태복음','MAT'],['마가복음','MRK'],['누가복음','LUK'],['요한복음','JHN'],['사도행전','ACT'],['로마서','ROM'],['고린도전서','1CO'],['고린도후서','2CO'],
  ['갈라디아서','GAL'],['에베소서','EPH'],['빌립보서','PHP'],['골로새서','COL'],['데살로니가전서','1TH'],['데살로니가후서','2TH'],['디모데전서','1TI'],['디모데후서','2TI'],
  ['디도서','TIT'],['빌레몬서','PHM'],['히브리서','HEB'],['야고보서','JAS'],['베드로전서','1PE'],['베드로후서','2PE'],['요한일서','1JN'],['요한이서','2JN'],
  ['요한삼서','3JN'],['유다서','JUD'],['요한계시록','REV']
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

function adminBibleStatus(message, isError = false) {
  const el = document.getElementById('admin-bible-lookup-status');
  if (!el) return;
  el.textContent = message;
  el.classList.remove('hidden', 'text-error', 'text-on-surface-variant');
  el.classList.add(isError ? 'text-error' : 'text-on-surface-variant');
}

function adminRenderBibleBooks() {
  const select = document.getElementById('admin-bible-book');
  if (!select) return;
  select.innerHTML = '<option value="">성경책</option>' + ADMIN_BIBLE_BOOKS.map(([name, id]) => `<option value="${id}" data-book-name="${name}">${name}</option>`).join('');
}

async function adminLoadBibleVersions() {
  const select = document.getElementById('admin-bible-version');
  if (!select) return;
  const { data, error } = await window.supabaseClient.functions.invoke('bible-lookup', { body: { action: 'bibles' } });
  if (error || !data || data.error) {
    select.innerHTML = '<option value="">번역본을 불러오지 못했습니다</option>';
    adminBibleStatus('API.Bible 키와 Edge Function 배포 상태를 확인해주세요.', true);
    console.error('[admin] bible versions', error || data.error);
    return;
  }
  const bibles = data.bibles || [];
  select.innerHTML = bibles.length
    ? '<option value="">번역본 선택</option>' + bibles.map((bible) => `<option value="${adminEscape(bible.id)}">${adminEscape(bible.name)}${bible.abbreviation ? ` (${adminEscape(bible.abbreviation)})` : ''}</option>`).join('')
    : '<option value="">사용 가능한 한국어 번역본이 없습니다</option>';
}

async function adminLookupBibleVerse() {
  const version = document.getElementById('admin-bible-version');
  const book = document.getElementById('admin-bible-book');
  const chapter = document.getElementById('admin-bible-chapter');
  const verse = document.getElementById('admin-bible-verse');
  const button = document.getElementById('admin-bible-lookup');
  if (!version.value || !book.value || Number(chapter.value) < 1 || Number(verse.value) < 1) {
    adminBibleStatus('번역본, 성경책, 장, 절을 모두 선택해주세요.', true);
    return;
  }
  button.disabled = true;
  button.textContent = '불러오는 중...';
  const { data, error } = await window.supabaseClient.functions.invoke('bible-lookup', {
    body: { action: 'verse', bibleId: version.value, bookId: book.value, chapter: Number(chapter.value), verse: Number(verse.value) }
  });
  button.disabled = false;
  button.textContent = '구절 불러오기';
  if (error || !data || data.error || !data.text) {
    adminBibleStatus(data && data.error ? data.error : '구절을 불러오지 못했습니다.', true);
    console.error('[admin] bible verse', error || data?.error);
    return;
  }
  const bookName = book.options[book.selectedIndex].dataset.bookName;
  document.getElementById('admin-verse-reference').value = `${bookName} ${chapter.value}:${verse.value}`;
  document.getElementById('admin-verse-text').value = data.text;
  adminBibleStatus('구절을 불러왔습니다. 내용을 확인한 뒤 등록해주세요.');
}

function adminWireBibleLookup() {
  adminRenderBibleBooks();
  document.getElementById('admin-bible-lookup')?.addEventListener('click', adminLookupBibleVerse);
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
  if (submit) submit.textContent = '메시지 전송';
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
        <div><p class="text-xs font-bold text-secondary mb-1">${adminEscape(verse.reference)}</p><p class="text-sm leading-6">${adminEscape(verse.verse_text)}</p></div>
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
  adminWireBibleLookup();
  await adminLoadUsers();
  await Promise.all([adminLoadMessages(), adminLoadVerses(), adminLoadBibleVersions()]);
}

window.initAdminWidgets = initAdminWidgets;
