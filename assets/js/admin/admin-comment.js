// Admin 콘솔 — Comment 탭: List/Table view, 학생 프로필 팝업, 댓글 작성/수정/삭제.

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
let commentViewMode = 'table';
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
  return `<div class="aspect-[4/3] rounded-2xl overflow-hidden bg-surface-container"><img src="${galleryEscape(getPhotoUrl(record.photo_path))}" loading="lazy" decoding="async" data-gallery-photo class="w-full h-full object-contain bg-surface-container cursor-zoom-in" alt="말씀 묵상 인증 사진"></div>`;
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
  return `<div class="aspect-square bg-surface-container overflow-hidden"><img src="${galleryEscape(getPhotoUrl(record.photo_path))}" loading="lazy" decoding="async" data-gallery-photo class="w-full h-full object-contain cursor-zoom-in" alt="말씀 묵상 인증 사진"></div>`;
}

function commentProfileCommentHTML(comment, profiles) {
  const profile = profiles[comment.author_id];
  const avatar = profile?.avatarUrl
    ? `<img src="${galleryEscape(profile.avatarUrl)}" alt="" class="w-full h-full object-cover">`
    : galleryEscape((profile?.name || profile?.username || '?').charAt(0));
  const editControl = commentCanWrite && comment.author_id === adminCurrentUserId
    ? `<button type="button" data-profile-comment-edit="${comment.id}" data-profile-comment-body="${galleryEscape(comment.body)}" class="ml-2 font-semibold hover:text-primary">수정</button><button type="button" data-profile-comment-delete="${comment.id}" class="ml-2 font-semibold hover:text-error">삭제</button>`
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
      ${threads.length ? `<div class="flex flex-col gap-1.5 mb-3 pl-3 border-l-2 border-outline-variant/40">${threads.map((c) => `<p class="text-xs leading-5">${galleryEscape(c.body)} <span class="text-on-surface-variant">· ${galleryRelativeTime(c.created_at)}</span>${c.author_id === adminCurrentUserId ? `<button type="button" data-comment-thread-delete="${c.id}" class="ml-2 font-semibold text-on-surface-variant hover:text-error">삭제</button>` : ''}</p>`).join('')}</div>` : ''}
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
  const headerCells = commentDays.map((day) => `<th class="sticky top-0 z-20 bg-white px-2 py-2 text-center text-[10px] font-bold text-on-surface-variant whitespace-nowrap">${galleryDateParts(day).short}</th>`).join('');
  const rows = commentUsers.map((user) => `<tr>
    <td class="sticky left-0 bg-white px-3 py-2 text-xs font-bold whitespace-nowrap border-r border-outline-variant/30">${galleryEscape(user.name)}</td>
    ${commentDays.map((day) => `<td class="px-2 py-2 text-center">${commentTableCellHTML(user.id, day)}</td>`).join('')}
  </tr>`).join('');
  wrap.innerHTML = `<table class="border-collapse w-full"><thead><tr><th class="sticky top-0 left-0 z-30 bg-white px-3 py-2 text-left text-[10px] font-bold text-on-surface-variant border-r border-outline-variant/30">학생</th>${headerCells}</tr></thead><tbody>${rows}</tbody></table>`;
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
  document.getElementById('comment-list')?.addEventListener('click', async (event) => {
    const profileButton = event.target.closest('[data-comment-profile-user]');
    if (profileButton) { openCommentProfile(profileButton.dataset.commentProfileUser); return; }
    const deleteButton = event.target.closest('[data-comment-thread-delete]');
    if (deleteButton) {
      if (!confirm('이 댓글을 삭제할까요?')) return;
      const { error } = await window.supabaseClient.from('post_comments').delete().eq('id', deleteButton.dataset.commentThreadDelete).eq('author_id', adminCurrentUserId);
      if (error) { console.error('[comment-list] delete comment', error); adminShowStatus('댓글을 삭제하지 못했습니다.', true); return; }
      await loadCommentDay();
      adminShowStatus('댓글을 삭제했습니다.');
    }
  });
  document.getElementById('comment-profile-overlay')?.addEventListener('click', closeCommentProfile);
  document.getElementById('comment-profile-back')?.addEventListener('click', closeCommentProfile);
  document.getElementById('comment-profile-close')?.addEventListener('click', closeCommentProfile);
  document.getElementById('comment-profile-content')?.addEventListener('click', async (event) => {
    const editButton = event.target.closest('[data-profile-comment-edit]');
    const deleteButton = event.target.closest('[data-profile-comment-delete]');
    const cancelButton = event.target.closest('[data-profile-comment-cancel]');
    if (deleteButton) {
      if (!confirm('이 댓글을 삭제할까요?')) return;
      const { error } = await window.supabaseClient.from('post_comments').delete().eq('id', deleteButton.dataset.profileCommentDelete).eq('author_id', adminCurrentUserId);
      if (error) { console.error('[comment-profile] delete comment', error); adminShowStatus('댓글을 삭제하지 못했습니다.', true); return; }
      const activeUserId = commentProfileUserId;
      await openCommentProfile(activeUserId);
      adminShowStatus('댓글을 삭제했습니다.');
      return;
    }
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
    renderCommentViewTabs();
  }
  commentDayMeta();
  if (commentViewMode === 'table') { await loadCommentTable(); } else { await loadCommentDay(); }
}
