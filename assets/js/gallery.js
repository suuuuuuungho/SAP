// Sapians 날짜별 갤러리: 운영기간 20개 평일을 이동하며 학생별 고유 칸을 보여준다.

const GALLERY_START_DATE = '2026-08-10';
const GALLERY_END_DATE = '2026-09-06';
const GALLERY_PAGE_SIZE = 8;

let galleryDays = [];
let gallerySelectedIndex = 0;
let gallerySelectedPage = 0;
let galleryActiveType = 'pray';
let galleryCalendarPage = 0;
let galleryUsers = [];
let galleryPrayMap = {};
let galleryWordMap = {};
let galleryAvatarUrls = {};
let galleryCurrentUserId = null;
let galleryActiveCommentsPost = null;
let galleryComments = [];
let galleryCommentProfiles = {};
let galleryEditingCommentId = null;

function galleryDateKey(date) {
  const year = date.getFullYear();
  const month = String(date.getMonth() + 1).padStart(2, '0');
  const day = String(date.getDate()).padStart(2, '0');
  return `${year}-${month}-${day}`;
}

function buildGalleryDays() {
  const result = [];
  const cursor = new Date(`${GALLERY_START_DATE}T12:00:00`);
  const end = new Date(`${GALLERY_END_DATE}T12:00:00`);
  while (cursor <= end) {
    const weekday = cursor.getDay();
    if (weekday >= 1 && weekday <= 5) result.push(galleryDateKey(cursor));
    cursor.setDate(cursor.getDate() + 1);
  }
  return result;
}

function galleryEscape(value) {
  return String(value == null ? '' : value)
    .replaceAll('&', '&amp;').replaceAll('<', '&lt;').replaceAll('>', '&gt;')
    .replaceAll('"', '&quot;').replaceAll("'", '&#039;');
}

function galleryDateParts(key) {
  const date = new Date(`${key}T12:00:00`);
  return {
    short: `${date.getMonth() + 1}/${date.getDate()}`,
    full: new Intl.DateTimeFormat('ko-KR', { month: 'long', day: 'numeric', weekday: 'long' }).format(date)
  };
}

async function loadGalleryUsers() {
  const { data, error } = await window.supabaseClient.rpc('get_gallery_users');
  if (error) {
    console.error('[gallery] users', error);
    return [];
  }
  return data || [];
}

async function loadGalleryDateRecords(dateKey) {
  const ids = galleryUsers.map((user) => user.id);
  if (!ids.length) {
    galleryPrayMap = {};
    galleryWordMap = {};
    return;
  }
  const [prayResult, wordResult] = await Promise.all([
    window.supabaseClient.from('pray_records').select('user_id, record_date, entries').eq('record_date', dateKey).in('user_id', ids),
    window.supabaseClient.from('word_records').select('user_id, record_date, verses, photo_path, photo_unavailable').eq('record_date', dateKey).in('user_id', ids)
  ]);
  if (prayResult.error) console.error('[gallery] pray records', prayResult.error);
  if (wordResult.error) console.error('[gallery] word records', wordResult.error);
  galleryPrayMap = Object.fromEntries((prayResult.data || []).map((row) => [row.user_id, row]));
  galleryWordMap = Object.fromEntries((wordResult.data || []).map((row) => [row.user_id, row]));
}

function galleryCategoryData(userId, type) {
  if (type === 'pray') {
    const row = galleryPrayMap[userId];
    const entries = row && Array.isArray(row.entries) ? row.entries : [];
    return {
      verified: entries.length > 0,
      photos: entries.filter((entry) => !entry.photoUnavailable && entry.photoPath).map((entry) => entry.photoPath)
    };
  }
  const row = galleryWordMap[userId];
  const verses = row && Array.isArray(row.verses) ? row.verses : [];
  return {
    verified: verses.length > 0,
    photos: row && !row.photo_unavailable && row.photo_path ? [row.photo_path] : []
  };
}

function galleryMediaHTML(userId, type, view = 'card') {
  const data = galleryCategoryData(userId, type);
  const photos = data.photos;
  const aspectClass = view === 'detail' ? 'aspect-square' : 'aspect-[4/3]';
  if (!photos.length) {
    const message = data.verified ? '사진 없이 인증했어요' : '아직 인증 사진이 없어요';
    return `<div class="${aspectClass} rounded-2xl bg-surface-container flex flex-col items-center justify-center text-on-surface-variant"><i class="fa-regular fa-image text-2xl mb-2 opacity-50"></i><p class="text-xs">${message}</p></div>`;
  }
  return `<div class="relative ${aspectClass} rounded-2xl overflow-hidden bg-surface-container" data-gallery-carousel data-carousel-index="0">
    ${photos.map((photo, index) => `<div class="gallery-carousel-slide absolute inset-0 ${index === 0 ? '' : 'hidden'}" data-carousel-slide="${index}"><img src="${galleryEscape(getPhotoUrl(photo))}" class="w-full h-full object-contain bg-surface-container" alt="${type === 'pray' ? '기도' : '말씀'} 인증 사진 ${index + 1}"></div>`).join('')}
    ${photos.length > 1 ? `
      <button type="button" data-carousel-direction="-1" class="absolute left-2 top-1/2 -translate-y-1/2 w-8 h-8 rounded-full bg-black/45 text-white flex items-center justify-center" aria-label="이전 사진"><i class="fa-solid fa-chevron-left text-xs"></i></button>
      <button type="button" data-carousel-direction="1" class="absolute right-2 top-1/2 -translate-y-1/2 w-8 h-8 rounded-full bg-black/45 text-white flex items-center justify-center" aria-label="다음 사진"><i class="fa-solid fa-chevron-right text-xs"></i></button>
      <span class="absolute top-2 right-2 rounded-full bg-black/55 text-white text-[10px] px-2 py-1" data-carousel-counter>1/${photos.length}</span>
    ` : ''}
  </div>`;
}

function galleryVerificationSummary(userId, type) {
  if (type === 'pray') {
    return { text: '기도 인증' };
  }
  const row = galleryWordMap[userId];
  const verses = row && Array.isArray(row.verses) ? row.verses : [];
  return {
    text: formatWordSummary(verses) || '말씀묵상 인증'
  };
}

function galleryVerificationSummaryHTML(userId, type, compact = false) {
  const data = galleryCategoryData(userId, type);
  if (!data.verified) return '';
  const summary = galleryVerificationSummary(userId, type);
  return `<div class="${compact ? 'mt-2' : 'mt-3'} min-w-0">
    <p class="text-xs leading-5 text-on-surface-variant ${compact ? 'line-clamp-2' : ''}">${galleryEscape(summary.text)}</p>
  </div>`;
}

function galleryStudentCardHTML(user, type) {
  const data = galleryCategoryData(user.id, type);
  const accent = type === 'pray' ? 'text-primary bg-primary/10' : 'text-secondary bg-secondary/10';
  const avatar = galleryAvatarUrls[user.id]
    ? `<img src="${galleryEscape(galleryAvatarUrls[user.id])}" alt="" class="w-full h-full object-cover">`
    : (galleryEscape(user.name).charAt(0) || '?');
  return `
    <article class="glass-card rounded-[1.5rem] p-4 min-w-0" data-gallery-user="${user.id}" data-gallery-type="${type}">
      <div class="flex items-center gap-3 mb-3">
        <div class="w-10 h-10 rounded-full bg-gradient-to-br from-primary-container to-tertiary-container text-on-primary flex items-center justify-center font-bold flex-shrink-0 overflow-hidden">${avatar}</div>
        <div class="min-w-0"><p class="font-bold text-sm truncate">${galleryEscape(user.name)}</p><p class="text-[11px] text-on-surface-variant truncate">@${galleryEscape(user.username)}</p></div>
      </div>
      ${galleryMediaHTML(user.id, type)}
      ${galleryVerificationSummaryHTML(user.id, type, true)}
      <div class="mt-3 flex items-center justify-between gap-2">
        <span class="rounded-full px-2.5 py-1 text-[11px] font-semibold ${data.verified ? accent : 'text-on-surface-variant bg-surface-container'}">${data.verified ? '인증 완료' : '미인증'}</span>
        ${data.verified ? `<button type="button" data-gallery-comment-user="${user.id}" data-gallery-comment-type="${type}" class="text-xs font-semibold text-on-surface-variant hover:text-primary"><i class="fa-regular fa-comment mr-1"></i>comment</button>` : ''}
      </div>
    </article>`;
}

function galleryRelativeTime(isoString) {
  const minutes = Math.floor((Date.now() - new Date(isoString).getTime()) / 60000);
  if (minutes < 1) return '방금';
  if (minutes < 60) return `${minutes}분 전`;
  const hours = Math.floor(minutes / 60);
  if (hours < 24) return `${hours}시간 전`;
  return `${Math.floor(hours / 24)}일 전`;
}

function moveGalleryCarousel(button) {
  const carousel = button.closest('[data-gallery-carousel]');
  if (!carousel) return;
  const slides = [...carousel.querySelectorAll('[data-carousel-slide]')];
  if (slides.length < 2) return;
  const direction = Number(button.dataset.carouselDirection || 0);
  const current = Number(carousel.dataset.carouselIndex || 0);
  const next = (current + direction + slides.length) % slides.length;
  carousel.dataset.carouselIndex = String(next);
  slides.forEach((slide, index) => slide.classList.toggle('hidden', index !== next));
  const counter = carousel.querySelector('[data-carousel-counter]');
  if (counter) counter.textContent = `${next + 1}/${slides.length}`;
}

function galleryCommentAvatar(profile) {
  if (profile?.avatarUrl) return `<div class="w-9 h-9 rounded-full overflow-hidden bg-surface-container flex-shrink-0"><img src="${galleryEscape(profile.avatarUrl)}" alt="" class="w-full h-full object-cover"></div>`;
  const initial = galleryEscape((profile?.name || '?').charAt(0));
  return `<div class="w-9 h-9 rounded-full bg-gradient-to-br from-primary-container to-tertiary-container text-white flex items-center justify-center font-bold text-sm flex-shrink-0">${initial}</div>`;
}

async function loadGalleryComments() {
  if (!galleryActiveCommentsPost) return;
  const { data, error } = await window.supabaseClient.from('post_comments').select('*')
    .eq('post_owner_id', galleryActiveCommentsPost.ownerId)
    .eq('post_date', galleryActiveCommentsPost.date)
    .eq('post_type', galleryActiveCommentsPost.type)
    .order('created_at', { ascending: true });
  if (error) {
    console.error('[gallery] comments', error);
    galleryComments = [];
    galleryCommentProfiles = {};
    return;
  }
  galleryComments = data || [];
  galleryCommentProfiles = window.getPublicProfileCards
    ? await window.getPublicProfileCards(galleryComments.map((comment) => comment.author_id))
    : {};
}

function renderGalleryComments() {
  const list = document.getElementById('gallery-comments-list');
  if (!list) return;
  if (!galleryComments.length) {
    list.innerHTML = '<p class="text-sm text-on-surface-variant text-center py-10">첫 댓글을 남겨보세요.</p>';
    return;
  }
  list.innerHTML = galleryComments.map((comment) => {
    const profile = galleryCommentProfiles[comment.author_id];
    const badge = window.publicProfileBadgeHTML ? window.publicProfileBadgeHTML(profile?.badge_role) : '';
    const controls = comment.author_id === galleryCurrentUserId
      ? `<span class="inline-flex gap-2 ml-2"><button type="button" data-comment-edit="${comment.id}" class="hover:text-primary">수정</button><button type="button" data-comment-delete="${comment.id}" class="hover:text-error">삭제</button></span>`
      : '';
    return `<article class="flex items-start gap-3">
      ${galleryCommentAvatar(profile)}
      <div class="flex-1 min-w-0">
        <p class="text-sm break-words"><span class="font-bold mr-1">${galleryEscape(profile?.username || '?')}${badge}</span>${galleryEscape(comment.body)}</p>
        <span class="text-[11px] text-on-surface-variant">${galleryRelativeTime(comment.created_at)}${controls}</span>
      </div>
    </article>`;
  }).join('');
  list.scrollTop = list.scrollHeight;
}

async function openGalleryComments(userId, type) {
  const user = galleryUsers.find((item) => item.id === userId);
  galleryActiveCommentsPost = { ownerId: userId, date: galleryDays[gallerySelectedIndex], type };
  const modal = document.getElementById('gallery-comments-modal');
  const label = document.getElementById('gallery-comments-post-label');
  const preview = document.getElementById('gallery-comments-post-preview');
  if (label) label.textContent = `${user?.name || ''} · ${type === 'pray' ? '기도' : '말씀묵상'} · ${galleryDateParts(galleryActiveCommentsPost.date).short}`;
  if (preview && user) {
    const avatar = galleryAvatarUrls[user.id]
      ? `<img src="${galleryEscape(galleryAvatarUrls[user.id])}" alt="" class="w-full h-full object-cover">`
      : (galleryEscape(user.name).charAt(0) || '?');
    preview.innerHTML = `<article>
      <div class="flex items-center gap-3 mb-3">
        <div class="w-9 h-9 rounded-full bg-gradient-to-br from-primary-container to-tertiary-container text-white flex items-center justify-center font-bold overflow-hidden">${avatar}</div>
        <div class="min-w-0"><p class="text-sm font-bold truncate">${galleryEscape(user.name)}</p><p class="text-[11px] text-on-surface-variant">@${galleryEscape(user.username)}</p></div>
      </div>
      ${galleryMediaHTML(user.id, type, 'detail')}
      ${galleryVerificationSummaryHTML(user.id, type)}
    </article>`;
  }
  modal.classList.remove('hidden');
  modal.classList.add('flex');
  document.getElementById('gallery-comments-list').innerHTML = '<p class="text-sm text-on-surface-variant text-center py-10">불러오는 중...</p>';
  resetGalleryCommentEditor();
  await loadGalleryComments();
  renderGalleryComments();
}

function closeGalleryComments() {
  const modal = document.getElementById('gallery-comments-modal');
  modal?.classList.add('hidden');
  modal?.classList.remove('flex');
  galleryActiveCommentsPost = null;
  resetGalleryCommentEditor();
}

function resetGalleryCommentEditor() {
  galleryEditingCommentId = null;
  const input = document.getElementById('gallery-comments-input');
  const submit = document.getElementById('gallery-comments-submit');
  const cancel = document.getElementById('gallery-comments-edit-cancel');
  if (input) input.value = '';
  if (submit) submit.textContent = '게시';
  cancel?.classList.add('hidden');
}

function wireGalleryComments() {
  document.getElementById('page-main')?.addEventListener('click', (event) => {
    const carouselButton = event.target.closest('[data-carousel-direction]');
    if (carouselButton) {
      event.preventDefault();
      event.stopPropagation();
      moveGalleryCarousel(carouselButton);
    }
  });
  document.getElementById('gallery-active-grid')?.addEventListener('click', (event) => {
    const button = event.target.closest('[data-gallery-comment-user]');
    if (button) openGalleryComments(button.dataset.galleryCommentUser, button.dataset.galleryCommentType);
  });
  document.getElementById('gallery-comments-overlay')?.addEventListener('click', closeGalleryComments);
  document.getElementById('gallery-comments-close')?.addEventListener('click', closeGalleryComments);
  document.getElementById('gallery-comments-edit-cancel')?.addEventListener('click', resetGalleryCommentEditor);
  document.getElementById('gallery-comments-list')?.addEventListener('click', async (event) => {
    const editButton = event.target.closest('[data-comment-edit]');
    const deleteButton = event.target.closest('[data-comment-delete]');
    if (editButton) {
      const comment = galleryComments.find((item) => item.id === editButton.dataset.commentEdit);
      if (!comment || comment.author_id !== galleryCurrentUserId) return;
      galleryEditingCommentId = comment.id;
      const input = document.getElementById('gallery-comments-input');
      input.value = comment.body;
      input.focus();
      document.getElementById('gallery-comments-submit').textContent = '수정';
      document.getElementById('gallery-comments-edit-cancel').classList.remove('hidden');
      return;
    }
    if (deleteButton) {
      const comment = galleryComments.find((item) => item.id === deleteButton.dataset.commentDelete);
      if (!comment || comment.author_id !== galleryCurrentUserId || !confirm('댓글을 삭제할까요?')) return;
      const { error } = await window.supabaseClient.from('post_comments').delete().eq('id', comment.id).eq('author_id', galleryCurrentUserId);
      if (error) console.error('[gallery] delete comment', error);
      else {
        if (galleryEditingCommentId === comment.id) resetGalleryCommentEditor();
        await loadGalleryComments();
        renderGalleryComments();
      }
    }
  });
  document.getElementById('gallery-comments-form')?.addEventListener('submit', async (event) => {
    event.preventDefault();
    const input = document.getElementById('gallery-comments-input');
    const submit = document.getElementById('gallery-comments-submit');
    const body = input.value.trim();
    if (!body || !galleryActiveCommentsPost) return;
    submit.disabled = true;
    const request = galleryEditingCommentId
      ? window.supabaseClient.from('post_comments').update({ body }).eq('id', galleryEditingCommentId).eq('author_id', galleryCurrentUserId)
      : window.supabaseClient.from('post_comments').insert({
          post_owner_id: galleryActiveCommentsPost.ownerId,
          post_date: galleryActiveCommentsPost.date,
          post_type: galleryActiveCommentsPost.type,
          author_id: galleryCurrentUserId,
          body
        });
    const { error } = await request;
    submit.disabled = false;
    if (error) {
      console.error('[gallery] submit comment', error);
      return;
    }
    resetGalleryCommentEditor();
    await loadGalleryComments();
    renderGalleryComments();
  });
}

function renderGalleryGrid() {
  const start = gallerySelectedPage * GALLERY_PAGE_SIZE;
  const pageUsers = galleryUsers.slice(start, start + GALLERY_PAGE_SIZE);
  const grid = document.getElementById('gallery-active-grid');
  const title = document.getElementById('gallery-active-title');
  if (!grid) return;
  if (title) title.textContent = galleryActiveType === 'pray' ? 'Prayer Gallery' : 'Word Gallery';
  grid.innerHTML = pageUsers.length
    ? pageUsers.map((user) => galleryStudentCardHTML(user, galleryActiveType)).join('')
    : '<div class="glass-panel rounded-[2rem] p-12 text-center text-sm text-on-surface-variant col-span-full">표시할 학생이 없습니다.</div>';
  renderGalleryPagination();
}

function renderGalleryPagination() {
  const nav = document.getElementById('gallery-pagination');
  if (!nav) return;
  const pageCount = Math.max(1, Math.ceil(galleryUsers.length / GALLERY_PAGE_SIZE));
  nav.innerHTML = Array.from({ length: pageCount }, (_, index) => `<button type="button" data-gallery-page="${index}" class="w-9 h-9 rounded-full text-sm font-bold ${index === gallerySelectedPage ? 'nav-pill-active' : 'glass-card text-on-surface-variant'}" aria-label="${index + 1}페이지">${index + 1}</button>`).join('');
}

function renderGalleryCalendar() {
  const key = galleryDays[gallerySelectedIndex];
  const parts = galleryDateParts(key);
  const display = document.getElementById('gallery-date-display');
  const count = document.getElementById('gallery-day-count');
  const label = document.getElementById('gallery-date-label');
  const prev = document.getElementById('gallery-prev-day');
  const next = document.getElementById('gallery-next-day');
  if (display) display.textContent = key;
  if (count) count.textContent = `DAY ${gallerySelectedIndex + 1} / ${galleryDays.length}`;
  if (label) label.textContent = parts.full;
  if (prev) prev.disabled = gallerySelectedIndex === 0;
  if (next) next.disabled = gallerySelectedIndex === galleryDays.length - 1;
  renderGalleryCalendarMonths();
}

function galleryMonthHTML(year, monthIndex) {
  const monthStart = new Date(year, monthIndex, 1, 12);
  const daysInMonth = new Date(year, monthIndex + 1, 0, 12).getDate();
  const mondayOffset = (monthStart.getDay() + 6) % 7;
  const blanks = Array.from({ length: mondayOffset }, () => '<span></span>').join('');
  const days = Array.from({ length: daysInMonth }, (_, offset) => {
    const dayNumber = offset + 1;
    const key = galleryDateKey(new Date(year, monthIndex, dayNumber, 12));
    const validIndex = galleryDays.indexOf(key);
    const selected = key === galleryDays[gallerySelectedIndex];
    const enabledClass = selected ? 'nav-pill-active' : 'hover:bg-white/70 text-on-surface';
    return `<button type="button" data-calendar-date="${key}" ${validIndex < 0 ? 'disabled' : ''} class="aspect-square rounded-full text-xs font-semibold ${validIndex < 0 ? 'text-outline-variant/45 cursor-not-allowed' : enabledClass}" aria-label="${monthIndex + 1}월 ${dayNumber}일">${dayNumber}</button>`;
  }).join('');
  return `<div><div class="grid grid-cols-7 gap-1 text-center mb-1">${['Mon','Tue','Wed','Thu','Fri','Sat','Sun'].map((day) => `<span class="text-[9px] text-on-surface-variant">${day}</span>`).join('')}</div><div class="grid grid-cols-7 gap-1">${blanks}${days}</div></div>`;
}

function renderGalleryCalendarMonths() {
  const months = document.getElementById('gallery-calendar-months');
  if (!months || !galleryDays.length) return;
  const monthIndex = galleryCalendarPage === 0 ? 7 : 8;
  months.innerHTML = `
    <div class="flex items-center justify-between mb-3">
      <button type="button" data-calendar-month-nav="-1" ${galleryCalendarPage === 0 ? 'disabled' : ''} class="icon-glass w-8 h-8 rounded-full disabled:opacity-25" aria-label="이전 달"><i class="fa-solid fa-chevron-left text-xs"></i></button>
      <p class="text-sm font-bold text-center">2026. ${String(monthIndex + 1).padStart(2, '0')}</p>
      <button type="button" data-calendar-month-nav="1" ${galleryCalendarPage === 1 ? 'disabled' : ''} class="icon-glass w-8 h-8 rounded-full disabled:opacity-25" aria-label="다음 달"><i class="fa-solid fa-chevron-right text-xs"></i></button>
    </div>
    ${galleryMonthHTML(2026, monthIndex)}`;
}

function setGalleryCalendarOpen(open) {
  const popover = document.getElementById('gallery-calendar-popover');
  const toggle = document.getElementById('gallery-calendar-toggle');
  if (!popover || !toggle) return;
  popover.classList.toggle('hidden', !open);
  toggle.setAttribute('aria-expanded', String(open));
}

function renderGalleryTypeTabs() {
  document.querySelectorAll('[data-gallery-type-tab]').forEach((button) => {
    const active = button.dataset.galleryTypeTab === galleryActiveType;
    button.classList.toggle('nav-pill-active', active);
    button.classList.toggle('text-on-surface-variant', !active);
  });
}

async function selectGalleryDay(index) {
  const nextIndex = Math.max(0, Math.min(galleryDays.length - 1, index));
  gallerySelectedIndex = nextIndex;
  gallerySelectedPage = 0;
  galleryCalendarPage = galleryDays[nextIndex].startsWith('2026-09') ? 1 : 0;
  renderGalleryCalendar();
  const grid = document.getElementById('gallery-active-grid');
  if (grid) grid.innerHTML = '<div class="col-span-full py-16 text-center text-sm text-on-surface-variant"><i class="fa-solid fa-circle-notch fa-spin mr-2"></i>불러오는 중</div>';
  await loadGalleryDateRecords(galleryDays[gallerySelectedIndex]);
  renderGalleryGrid();
}

function wireGalleryCalendar() {
  document.getElementById('gallery-prev-day')?.addEventListener('click', () => selectGalleryDay(gallerySelectedIndex - 1));
  document.getElementById('gallery-next-day')?.addEventListener('click', () => selectGalleryDay(gallerySelectedIndex + 1));
  document.getElementById('gallery-calendar-toggle')?.addEventListener('click', (event) => {
    event.stopPropagation();
    const open = document.getElementById('gallery-calendar-popover')?.classList.contains('hidden');
    setGalleryCalendarOpen(open);
  });
  document.getElementById('gallery-calendar-popover')?.addEventListener('click', (event) => {
    event.stopPropagation();
    const monthButton = event.target.closest('[data-calendar-month-nav]');
    if (monthButton && !monthButton.disabled) {
      galleryCalendarPage = Math.max(0, Math.min(1, galleryCalendarPage + Number(monthButton.dataset.calendarMonthNav)));
      renderGalleryCalendarMonths();
      return;
    }
    const button = event.target.closest('[data-calendar-date]');
    if (!button || button.disabled) return;
    setGalleryCalendarOpen(false);
    selectGalleryDay(galleryDays.indexOf(button.dataset.calendarDate));
  });
  document.addEventListener('click', () => setGalleryCalendarOpen(false));
  document.getElementById('gallery-type-tabs')?.addEventListener('click', (event) => {
    const button = event.target.closest('[data-gallery-type-tab]');
    if (!button) return;
    galleryActiveType = button.dataset.galleryTypeTab;
    gallerySelectedPage = 0;
    renderGalleryTypeTabs();
    renderGalleryGrid();
  });
  document.getElementById('gallery-pagination')?.addEventListener('click', (event) => {
    const button = event.target.closest('[data-gallery-page]');
    if (!button) return;
    gallerySelectedPage = Number(button.dataset.galleryPage);
    renderGalleryGrid();
    document.getElementById('gallery-active-grid')?.scrollIntoView({ behavior: 'smooth', block: 'start' });
  });
}

async function initGalleryWidgets() {
  galleryDays = buildGalleryDays();
  wireGalleryCalendar();
  wireGalleryComments();
  renderGalleryTypeTabs();
  renderGalleryCalendar();
  galleryCurrentUserId = await getCurrentUserId();
  galleryUsers = await loadGalleryUsers();
  galleryAvatarUrls = window.getProfileAvatarUrls
    ? await window.getProfileAvatarUrls(galleryUsers.map((user) => user.id))
    : {};
  await selectGalleryDay(0);
}

window.initGalleryWidgets = initGalleryWidgets;
