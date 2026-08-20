// Sapians 날짜별 갤러리: 운영기간 20개 평일을 이동하며 학생별 고유 칸을 보여준다.

const GALLERY_START_DATE = '2026-08-10';
const GALLERY_END_DATE = '2026-09-06';
const GALLERY_PAGE_SIZE = 8;
const GALLERY_GRID_CLASS_VIEW = 'gallery-swipe-grid';
const GALLERY_GRID_CLASS_MANAGE = 'grid grid-cols-1 sm:grid-cols-2 xl:grid-cols-4 gap-4';

let galleryDays = [];
let gallerySelectedIndex = 0;
let gallerySelectedPage = 0;
let galleryActiveType = 'word';
let galleryCalendarPage = 0;
let galleryUsers = [];
let galleryPrayMap = {};
let galleryWordMap = {};
let galleryAvatarUrls = {};
let galleryCurrentUserId = null;
let galleryCanComment = false;
let galleryActiveCommentsPost = null;
let galleryComments = [];
let galleryCommentProfiles = {};
let galleryEditingCommentId = null;
let galleryAdminEditingPost = null;

function applyGalleryFeatureFlags(flags = window.APP_FEATURE_FLAGS || {}) {
  if (flags.comments === false && !window.IS_ADMIN_CONSOLE) {
    document.querySelectorAll('[data-gallery-comment-user]').forEach((button) => button.classList.add('hidden'));
    closeGalleryComments();
  }
}

window.addEventListener('app-feature-flags', (event) => applyGalleryFeatureFlags(event.detail));

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

function galleryDefaultDayIndex() {
  const todayKey = galleryDateKey(new Date());
  const exact = galleryDays.indexOf(todayKey);
  if (exact >= 0) return exact;
  if (todayKey < galleryDays[0]) return 0;
  if (todayKey > galleryDays[galleryDays.length - 1]) return galleryDays.length - 1;
  const next = galleryDays.findIndex((day) => day > todayKey);
  return next >= 0 ? next : galleryDays.length - 1;
}

function galleryReadingLabel(index) {
  return index === galleryDays.length - 1 ? '요한복음 20장·21장' : `요한복음 ${index + 1}장`;
}

async function loadGalleryUsers() {
  const { data, error } = await window.supabaseClient.rpc('get_gallery_users');
  if (error) {
    console.error('[gallery] users', error);
    return [];
  }
  return data || [];
}

async function loadGalleryCommentPermission() {
  const { data, error } = await window.supabaseClient.rpc('can_write_gallery_comments');
  if (!error) return data === true;
  const { data: profile } = await window.supabaseClient.from('profiles').select('app_role,is_admin').eq('id', galleryCurrentUserId).maybeSingle();
  return !!(profile?.is_admin || ['admin', 'teacher', 'pastor', 'department_head', 'secretary'].includes(profile?.app_role));
}

async function loadGalleryDateRecords(dateKey) {
  const ids = galleryUsers.map((user) => user.id);
  if (!ids.length) {
    galleryPrayMap = {};
    galleryWordMap = {};
    return;
  }
  if (window.IS_ADMIN_CONSOLE) {
    const { data: adminRows, error: adminError } = await window.supabaseClient.rpc('admin_get_gallery_records', { target_date: dateKey });
    if (!adminError) {
      galleryPrayMap = Object.fromEntries((adminRows || []).filter((row) => row.post_type === 'pray').map((row) => [row.user_id, { user_id: row.user_id, record_date: row.record_date, entries: row.content || [], admin_hidden: row.admin_hidden }]));
      galleryWordMap = Object.fromEntries((adminRows || []).filter((row) => row.post_type === 'word').map((row) => [row.user_id, { user_id: row.user_id, record_date: row.record_date, verses: row.content || [], photo_path: row.photo_path, photo_unavailable: row.photo_unavailable, admin_hidden: row.admin_hidden }]));
      return true;
    }
    console.warn('[gallery] admin RPC unavailable; falling back to table query', adminError);
  }

  let prayQuery = window.supabaseClient.from('pray_records').select('user_id, record_date, entries, admin_hidden').eq('record_date', dateKey).in('user_id', ids);
  let wordQuery = window.supabaseClient.from('word_records').select('user_id, record_date, verses, photo_path, photo_unavailable, admin_hidden').eq('record_date', dateKey).in('user_id', ids);
  if (!window.IS_ADMIN_CONSOLE) {
    prayQuery = prayQuery.eq('admin_hidden', false);
    wordQuery = wordQuery.eq('admin_hidden', false);
  }
  const [prayResult, wordResult] = await Promise.all([prayQuery, wordQuery]);
  if (prayResult.error || wordResult.error) {
    console.error('[gallery] records', prayResult.error || wordResult.error);
    galleryPrayMap = {};
    galleryWordMap = {};
    return false;
  }
  galleryPrayMap = Object.fromEntries((prayResult.data || []).map((row) => [row.user_id, row]));
  galleryWordMap = Object.fromEntries((wordResult.data || []).map((row) => [row.user_id, row]));
  return true;
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
    ${photos.map((photo, index) => `<div class="gallery-carousel-slide absolute inset-0 ${index === 0 ? '' : 'hidden'}" data-carousel-slide="${index}"><img ${index === 0 ? `src="${galleryEscape(getPhotoUrl(photo))}"` : `data-src="${galleryEscape(getPhotoUrl(photo))}"`} loading="lazy" decoding="async" data-gallery-photo class="w-full h-full object-contain bg-surface-container cursor-zoom-in" alt="${type === 'pray' ? '기도' : '말씀'} 인증 사진 ${index + 1}">${window.IS_ADMIN_CONSOLE ? `<button type="button" data-admin-gallery-photo-delete data-admin-gallery-owner="${userId}" data-admin-gallery-type="${type}" data-admin-gallery-photo-path="${galleryEscape(photo)}" class="absolute left-2 top-2 w-9 h-9 rounded-full bg-black/60 text-white flex items-center justify-center hover:bg-error" aria-label="사진 삭제"><i class="fa-solid fa-trash text-xs"></i></button>` : ''}</div>`).join('')}
    ${photos.length > 1 ? `
      <button type="button" data-carousel-direction="-1" class="absolute left-2 top-1/2 -translate-y-1/2 w-8 h-8 rounded-full bg-black/45 text-white flex items-center justify-center" aria-label="이전 사진"><i class="fa-solid fa-chevron-left text-xs"></i></button>
      <button type="button" data-carousel-direction="1" class="absolute right-2 top-1/2 -translate-y-1/2 w-8 h-8 rounded-full bg-black/45 text-white flex items-center justify-center" aria-label="다음 사진"><i class="fa-solid fa-chevron-right text-xs"></i></button>
      <span class="absolute top-2 right-2 rounded-full bg-black/55 text-white text-[10px] px-2 py-1" data-carousel-counter>1/${photos.length}</span>
    ` : ''}
  </div>`;
}

function galleryVerificationSummary(userId, type) {
  if (type === 'pray') {
    return { text: '' };
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
  if (!summary.text) return '';
  return `<div class="${compact ? 'mt-2' : 'mt-3'} min-w-0">
    <p class="text-xs leading-5 text-on-surface-variant ${compact ? 'line-clamp-2' : ''}">${galleryEscape(summary.text)}</p>
  </div>`;
}

function galleryStudentCardHTML(user, type) {
  const data = galleryCategoryData(user.id, type);
  const record = type === 'pray' ? galleryPrayMap[user.id] : galleryWordMap[user.id];
  const accent = type === 'pray' ? 'text-primary bg-primary/10' : 'text-secondary bg-secondary/10';
  const avatar = galleryAvatarUrls[user.id]
    ? `<img src="${galleryEscape(galleryAvatarUrls[user.id])}" loading="lazy" decoding="async" alt="" class="w-full h-full object-cover">`
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
        <div class="flex items-center gap-3">${user.id === galleryCurrentUserId && !window.IS_ADMIN_CONSOLE ? `<button type="button" data-gallery-verify="${type}" class="text-xs font-bold text-primary"><i class="fa-solid fa-plus mr-1"></i>${data.verified ? '수정' : '인증'}</button>` : ''}${data.verified ? `<button type="button" data-gallery-comment-user="${user.id}" data-gallery-comment-type="${type}" class="text-xs font-semibold text-on-surface-variant hover:text-primary"><i class="fa-regular fa-comment mr-1"></i>comment</button>` : ''}</div>
      </div>
      ${window.IS_ADMIN_CONSOLE && data.verified ? `<div class="mt-3 pt-3 border-t border-outline-variant/40 flex flex-wrap items-center gap-2"><button type="button" data-admin-gallery-visibility="${user.id}" data-admin-gallery-type="${type}" data-admin-gallery-action="${record?.admin_hidden ? 'show' : 'hide'}" class="rounded-full px-3 py-1.5 text-[11px] font-bold ${record?.admin_hidden ? 'bg-error/10 text-error' : 'bg-quaternary/10 text-quaternary'}"><i class="fa-solid ${record?.admin_hidden ? 'fa-eye-slash' : 'fa-earth-americas'} mr-1"></i>${record?.admin_hidden ? '비공개' : '공개'}</button><span class="flex-1"></span><button type="button" data-admin-gallery-edit="${user.id}" data-admin-gallery-type="${type}" class="glass-card rounded-full px-3 py-1.5 text-xs font-semibold"><i class="fa-solid fa-pen mr-1"></i>수정</button><button type="button" data-admin-gallery-delete="${user.id}" data-admin-gallery-type="${type}" class="glass-card rounded-full px-3 py-1.5 text-xs font-semibold text-error"><i class="fa-solid fa-trash mr-1"></i>삭제</button></div>` : ''}
    </article>`;
}

function closeAdminGalleryEdit() {
  const modal = document.getElementById('admin-gallery-edit-modal');
  modal?.classList.add('hidden'); modal?.classList.remove('flex');
  galleryAdminEditingPost = null;
}

function adminGalleryPrayerFields(entries) {
  return entries.map((entry, index) => `<div class="admin-gallery-edit-row glass-card rounded-2xl p-4" data-entry-index="${index}"><p class="text-xs font-bold text-primary mb-3">기도 ${index + 1}</p><div class="grid grid-cols-1 sm:grid-cols-2 gap-3"><label class="text-xs sm:col-span-2">장소<input data-field="location" class="glass-input rounded-xl px-3 py-2 w-full mt-1" value="${galleryEscape(entry.location || '')}"></label><label class="text-xs">시작 일시<input data-field="start" type="datetime-local" class="glass-input rounded-xl px-3 py-2 w-full mt-1" value="${galleryEscape(entry.start || '')}"></label><label class="text-xs">종료 일시<input data-field="end" type="datetime-local" class="glass-input rounded-xl px-3 py-2 w-full mt-1" value="${galleryEscape(entry.end || '')}"></label></div></div>`).join('');
}

function adminGalleryWordFields(verses) {
  return verses.map((verse, index) => `<div class="admin-gallery-edit-row glass-card rounded-2xl p-4" data-entry-index="${index}"><p class="text-xs font-bold text-secondary mb-3">말씀 구절 ${index + 1}</p><div class="grid grid-cols-2 sm:grid-cols-4 gap-3"><label class="text-xs col-span-2">시작 성경책<input data-field="startBook" class="glass-input rounded-xl px-3 py-2 w-full mt-1" value="${galleryEscape(verse.startBook || '')}"></label><label class="text-xs">장<input data-field="startChapter" type="number" min="1" class="glass-input rounded-xl px-3 py-2 w-full mt-1" value="${galleryEscape(verse.startChapter || '')}"></label><label class="text-xs">절<input data-field="startVerse" type="number" min="1" class="glass-input rounded-xl px-3 py-2 w-full mt-1" value="${galleryEscape(verse.startVerse || '')}"></label><label class="text-xs col-span-2">끝 성경책<input data-field="endBook" class="glass-input rounded-xl px-3 py-2 w-full mt-1" value="${galleryEscape(verse.endBook || '')}"></label><label class="text-xs">장<input data-field="endChapter" type="number" min="1" class="glass-input rounded-xl px-3 py-2 w-full mt-1" value="${galleryEscape(verse.endChapter || '')}"></label><label class="text-xs">절<input data-field="endVerse" type="number" min="1" class="glass-input rounded-xl px-3 py-2 w-full mt-1" value="${galleryEscape(verse.endVerse || '')}"></label><label class="text-xs col-span-2 sm:col-span-4">추가 묵상 시간(분)<input data-field="meditationMinutes" type="number" min="0" class="glass-input rounded-xl px-3 py-2 w-full mt-1" value="${galleryEscape(verse.meditationMinutes || '')}"></label></div></div>`).join('');
}

function openAdminGalleryEdit(userId, type) {
  const user = galleryUsers.find((item) => item.id === userId);
  const row = type === 'pray' ? galleryPrayMap[userId] : galleryWordMap[userId];
  if (!row) return;
  galleryAdminEditingPost = { userId, type, row };
  document.getElementById('admin-gallery-edit-title').textContent = `${type === 'pray' ? '기도' : '말씀묵상'} 게시물 수정`;
  document.getElementById('admin-gallery-edit-subtitle').textContent = `${user?.name || ''} · ${row.record_date}`;
  document.getElementById('admin-gallery-edit-fields').innerHTML = type === 'pray' ? adminGalleryPrayerFields(row.entries || []) : adminGalleryWordFields(row.verses || []);
  const modal = document.getElementById('admin-gallery-edit-modal'); modal.classList.remove('hidden'); modal.classList.add('flex');
}

async function saveAdminGalleryEdit() {
  if (!galleryAdminEditingPost) return;
  const rows = [...document.querySelectorAll('#admin-gallery-edit-fields .admin-gallery-edit-row')];
  const original = galleryAdminEditingPost.type === 'pray' ? galleryAdminEditingPost.row.entries : galleryAdminEditingPost.row.verses;
  const payload = rows.map((row, index) => {
    const next = { ...(original[index] || {}) };
    row.querySelectorAll('[data-field]').forEach((input) => {
      const numeric = ['startChapter','startVerse','endChapter','endVerse','meditationMinutes'].includes(input.dataset.field);
      next[input.dataset.field] = numeric && input.value !== '' ? Number(input.value) : input.value;
    });
    return next;
  });
  const invalid = galleryAdminEditingPost.type === 'pray' && payload.some((entry) => !entry.location || !entry.start || !entry.end || entry.end <= entry.start);
  if (invalid) { alert('기도 장소와 시작/종료 일시를 확인해주세요. 종료는 시작보다 나중이어야 합니다.'); return; }
  const { error } = await window.supabaseClient.rpc('admin_update_gallery_post', { owner_id: galleryAdminEditingPost.userId, post_date: galleryAdminEditingPost.row.record_date, post_type: galleryAdminEditingPost.type, new_content: payload });
  if (error) { alert('게시물을 수정하지 못했습니다. 관리자 스키마를 확인해주세요.'); console.error('[gallery] admin edit', error); return; }
  closeAdminGalleryEdit();
  await loadGalleryDateRecords(galleryDays[gallerySelectedIndex]); renderGalleryGrid();
}

async function deleteAdminGalleryPost(userId, type) {
  const row = type === 'pray' ? galleryPrayMap[userId] : galleryWordMap[userId];
  if (!row || !confirm('이 게시물과 인증 기록을 완전히 삭제할까요? 이 작업은 되돌릴 수 없습니다.')) return;
  const { error } = await window.supabaseClient.rpc('admin_set_gallery_post', { owner_id: userId, post_date: row.record_date, post_type: type, action: 'delete' });
  if (error) { alert('게시물을 삭제하지 못했습니다.'); return; }
  await loadGalleryDateRecords(galleryDays[gallerySelectedIndex]); renderGalleryGrid();
}

async function toggleAdminGalleryVisibility(userId, type, action) {
  const row = type === 'pray' ? galleryPrayMap[userId] : galleryWordMap[userId];
  if (!row) return;
  const { error } = await window.supabaseClient.rpc('admin_set_gallery_post', { owner_id: userId, post_date: row.record_date, post_type: type, action });
  if (error) { alert('공개 상태를 변경하지 못했습니다.'); return; }
  await loadGalleryDateRecords(galleryDays[gallerySelectedIndex]); renderGalleryGrid();
}

async function deleteAdminGalleryPhoto(userId, type, photoPath) {
  const row = type === 'pray' ? galleryPrayMap[userId] : galleryWordMap[userId];
  if (!row || !photoPath || !confirm('이 사진 한 장을 게시물에서 완전히 삭제할까요?')) return;
  let request = await window.supabaseClient.functions.invoke('admin-gallery-media', { body: { ownerId: userId, date: row.record_date, type, photoPath } });
  if (request.error || !request.data?.ok) {
    request = await window.supabaseClient.rpc('admin_delete_gallery_photo', { owner_id: userId, post_date: row.record_date, post_type: type, target_photo_path: photoPath });
  }
  if (request.error) { alert('사진을 삭제하지 못했습니다. 관리자 서버 함수를 확인해주세요.'); return; }
  await loadGalleryDateRecords(galleryDays[gallerySelectedIndex]); renderGalleryGrid();
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
  const nextImage = slides[next].querySelector('img[data-src]');
  if (nextImage) { nextImage.src = nextImage.dataset.src; delete nextImage.dataset.src; }
  slides.forEach((slide, index) => slide.classList.toggle('hidden', index !== next));
  const counter = carousel.querySelector('[data-carousel-counter]');
  if (counter) counter.textContent = `${next + 1}/${slides.length}`;
}

const LIGHTBOX_MIN_SCALE = 1;
const LIGHTBOX_MAX_SCALE = 5;
let lightboxScale = 1;
let lightboxOriginX = 0;
let lightboxOriginY = 0;
let lightboxPointers = new Map();
let lightboxPinchDistance = null;
let lightboxDragStart = null;

function clampLightboxScale(scale) {
  return Math.min(LIGHTBOX_MAX_SCALE, Math.max(LIGHTBOX_MIN_SCALE, scale));
}

function applyLightboxTransform() {
  const img = document.getElementById('photo-lightbox-img');
  const reset = document.getElementById('photo-lightbox-reset');
  if (!img) return;
  img.style.transform = `translate(${lightboxOriginX}px, ${lightboxOriginY}px) scale(${lightboxScale})`;
  img.classList.toggle('is-zoomed', lightboxScale > 1);
  if (reset) reset.textContent = `${Math.round(lightboxScale * 100)}%`;
}

function resetLightboxTransform() {
  lightboxScale = 1;
  lightboxOriginX = 0;
  lightboxOriginY = 0;
  applyLightboxTransform();
}

function setLightboxScale(nextScale) {
  lightboxScale = clampLightboxScale(nextScale);
  if (lightboxScale === 1) { lightboxOriginX = 0; lightboxOriginY = 0; }
  applyLightboxTransform();
}

function openPhotoLightbox(url) {
  const overlay = document.getElementById('photo-lightbox');
  const img = document.getElementById('photo-lightbox-img');
  if (!overlay || !img) return;
  img.src = url;
  resetLightboxTransform();
  overlay.classList.remove('hidden');
  document.body.style.overflow = 'hidden';
}

function closePhotoLightbox() {
  const overlay = document.getElementById('photo-lightbox');
  const img = document.getElementById('photo-lightbox-img');
  if (!overlay) return;
  overlay.classList.add('hidden');
  document.body.style.overflow = '';
  lightboxPointers.clear();
  lightboxPinchDistance = null;
  lightboxDragStart = null;
  if (img) img.src = '';
}

function wirePhotoLightbox() {
  const overlay = document.getElementById('photo-lightbox');
  const img = document.getElementById('photo-lightbox-img');
  if (!overlay || !img || overlay.dataset.wired) return;
  overlay.dataset.wired = '1';

  document.getElementById('photo-lightbox-close')?.addEventListener('click', closePhotoLightbox);
  document.getElementById('photo-lightbox-zoom-in')?.addEventListener('click', () => setLightboxScale(lightboxScale + 0.6));
  document.getElementById('photo-lightbox-zoom-out')?.addEventListener('click', () => setLightboxScale(lightboxScale - 0.6));
  document.getElementById('photo-lightbox-reset')?.addEventListener('click', resetLightboxTransform);
  document.getElementById('photo-lightbox-stage')?.addEventListener('click', (event) => {
    if (event.target === img) return;
    closePhotoLightbox();
  });
  document.addEventListener('keydown', (event) => {
    if (event.key === 'Escape' && !overlay.classList.contains('hidden')) closePhotoLightbox();
  });

  overlay.addEventListener('wheel', (event) => {
    event.preventDefault();
    const delta = -event.deltaY * 0.0018;
    setLightboxScale(lightboxScale + delta * lightboxScale);
  }, { passive: false });

  img.addEventListener('dblclick', () => setLightboxScale(lightboxScale > 1 ? 1 : 2.5));

  img.addEventListener('pointerdown', (event) => {
    try { img.setPointerCapture(event.pointerId); } catch (error) { /* 합성 포인터 등 캡처 불가 상황은 무시하고 계속 진행 */ }
    lightboxPointers.set(event.pointerId, { x: event.clientX, y: event.clientY });
    if (lightboxPointers.size === 1) {
      lightboxDragStart = { x: event.clientX - lightboxOriginX, y: event.clientY - lightboxOriginY };
    } else if (lightboxPointers.size === 2) {
      const [a, b] = [...lightboxPointers.values()];
      lightboxPinchDistance = Math.hypot(a.x - b.x, a.y - b.y);
    }
  });

  img.addEventListener('pointermove', (event) => {
    if (!lightboxPointers.has(event.pointerId)) return;
    lightboxPointers.set(event.pointerId, { x: event.clientX, y: event.clientY });
    if (lightboxPointers.size === 2) {
      const [a, b] = [...lightboxPointers.values()];
      const distance = Math.hypot(a.x - b.x, a.y - b.y);
      if (lightboxPinchDistance) setLightboxScale(lightboxScale * (distance / lightboxPinchDistance));
      lightboxPinchDistance = distance;
    } else if (lightboxPointers.size === 1 && lightboxScale > 1 && lightboxDragStart) {
      img.classList.add('is-panning');
      lightboxOriginX = event.clientX - lightboxDragStart.x;
      lightboxOriginY = event.clientY - lightboxDragStart.y;
      applyLightboxTransform();
    }
  });

  const endLightboxPointer = (event) => {
    lightboxPointers.delete(event.pointerId);
    if (lightboxPointers.size < 2) lightboxPinchDistance = null;
    if (lightboxPointers.size === 0) { lightboxDragStart = null; img.classList.remove('is-panning'); }
  };
  img.addEventListener('pointerup', endLightboxPointer);
  img.addEventListener('pointercancel', endLightboxPointer);
  img.addEventListener('pointerleave', endLightboxPointer);
}

function galleryCommentAvatar(profile) {
  if (profile?.avatarUrl) return `<div class="w-9 h-9 rounded-full overflow-hidden bg-surface-container flex-shrink-0"><img src="${galleryEscape(profile.avatarUrl)}" loading="lazy" decoding="async" alt="" class="w-full h-full object-cover"></div>`;
  const initial = galleryEscape((profile?.name || '?').charAt(0));
  return `<div class="w-9 h-9 rounded-full bg-gradient-to-br from-primary-container to-tertiary-container text-white flex items-center justify-center font-bold text-sm flex-shrink-0">${initial}</div>`;
}

async function loadGalleryComments() {
  if (!galleryActiveCommentsPost) return;
  let data;
  let error;
  if (window.IS_ADMIN_CONSOLE) {
    let result = await window.supabaseClient.rpc('admin_get_post_comments', { target_owner_id: galleryActiveCommentsPost.ownerId, target_post_date: galleryActiveCommentsPost.date, target_post_type: galleryActiveCommentsPost.type });
    if (result.error) {
      result = await window.supabaseClient.from('post_comments').select('*').eq('post_owner_id', galleryActiveCommentsPost.ownerId).eq('post_date', galleryActiveCommentsPost.date).eq('post_type', galleryActiveCommentsPost.type).order('created_at', { ascending: true });
    }
    data = result.data; error = result.error;
  } else {
    const result = await window.supabaseClient.from('post_comments').select('*').eq('post_owner_id', galleryActiveCommentsPost.ownerId).eq('post_date', galleryActiveCommentsPost.date).eq('post_type', galleryActiveCommentsPost.type).order('created_at', { ascending: true });
    data = result.data; error = result.error;
  }
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
    const badge = window.publicProfileBadgeHTML ? window.publicProfileBadgeHTML(profile?.badge_role, profile?.is_host) : '';
    const controls = comment.author_id === galleryCurrentUserId
      ? `<span class="inline-flex gap-2 ml-2">${galleryCanComment ? `<button type="button" data-comment-edit="${comment.id}" class="hover:text-primary">수정</button>` : ''}<button type="button" data-comment-delete="${comment.id}" class="hover:text-error">삭제</button></span>`
      : window.IS_ADMIN_CONSOLE ? `<span class="inline-flex gap-2 ml-2"><button type="button" data-admin-comment-delete="${comment.id}" class="text-error hover:underline">관리자 삭제</button></span>` : '';
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
      ? `<img src="${galleryEscape(galleryAvatarUrls[user.id])}" loading="lazy" decoding="async" alt="" class="w-full h-full object-cover">`
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
  document.getElementById('gallery-comments-form')?.classList.toggle('hidden', !galleryCanComment);
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
    const adminPhotoButton = event.target.closest('[data-admin-gallery-photo-delete]');
    if (adminPhotoButton) {
      event.preventDefault(); event.stopPropagation();
      deleteAdminGalleryPhoto(adminPhotoButton.dataset.adminGalleryOwner, adminPhotoButton.dataset.adminGalleryType, adminPhotoButton.dataset.adminGalleryPhotoPath);
      return;
    }
    const carouselButton = event.target.closest('[data-carousel-direction]');
    if (carouselButton) {
      event.preventDefault();
      event.stopPropagation();
      moveGalleryCarousel(carouselButton);
      return;
    }
    const photo = event.target.closest('img[data-gallery-photo]');
    if (photo && photo.src) {
      event.preventDefault();
      openPhotoLightbox(photo.src);
    }
  });
  document.getElementById('gallery-active-grid')?.addEventListener('click', (event) => {
    const verifyButton = event.target.closest('[data-gallery-verify]');
    if (verifyButton) {
      const date = galleryDays[gallerySelectedIndex];
      window.location.href = `index.html?date=${encodeURIComponent(date)}&verify=${encodeURIComponent(verifyButton.dataset.galleryVerify)}&return=gallery`;
      return;
    }
    const visibilityButton = event.target.closest('[data-admin-gallery-visibility]');
    if (visibilityButton) { toggleAdminGalleryVisibility(visibilityButton.dataset.adminGalleryVisibility, visibilityButton.dataset.adminGalleryType, visibilityButton.dataset.adminGalleryAction); return; }
    const editButton = event.target.closest('[data-admin-gallery-edit]');
    const deleteButton = event.target.closest('[data-admin-gallery-delete]');
    if (editButton) { openAdminGalleryEdit(editButton.dataset.adminGalleryEdit, editButton.dataset.adminGalleryType); return; }
    if (deleteButton) { deleteAdminGalleryPost(deleteButton.dataset.adminGalleryDelete, deleteButton.dataset.adminGalleryType); return; }
    const button = event.target.closest('[data-gallery-comment-user]');
    if (button) openGalleryComments(button.dataset.galleryCommentUser, button.dataset.galleryCommentType);
  });
  document.getElementById('gallery-comments-overlay')?.addEventListener('click', closeGalleryComments);
  document.getElementById('gallery-comments-close')?.addEventListener('click', closeGalleryComments);
  document.getElementById('gallery-comments-edit-cancel')?.addEventListener('click', resetGalleryCommentEditor);
  document.getElementById('gallery-comments-list')?.addEventListener('click', async (event) => {
    const editButton = event.target.closest('[data-comment-edit]');
    const deleteButton = event.target.closest('[data-comment-delete]');
    const adminDeleteButton = event.target.closest('[data-admin-comment-delete]');
    if (adminDeleteButton) {
      if (!confirm('이 댓글을 관리자로서 삭제할까요?')) return;
      const { error } = await window.supabaseClient.rpc('admin_delete_post_comment', { comment_id: adminDeleteButton.dataset.adminCommentDelete });
      if (error) console.error('[gallery] admin delete comment', error);
      else { await loadGalleryComments(); renderGalleryComments(); }
      return;
    }
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
    if (!galleryCanComment) return;
    const input = document.getElementById('gallery-comments-input');
    const submit = document.getElementById('gallery-comments-submit');
    const body = input.value.trim();
    if (!body || !galleryActiveCommentsPost) return;
    submit.disabled = true;
    let result;
    if (galleryEditingCommentId) {
      result = await window.supabaseClient.from('post_comments').update({ body }).eq('id', galleryEditingCommentId).eq('author_id', galleryCurrentUserId);
    } else if (window.IS_ADMIN_CONSOLE) {
      result = await window.supabaseClient.rpc('admin_add_post_comment', { target_owner_id: galleryActiveCommentsPost.ownerId, target_post_date: galleryActiveCommentsPost.date, target_post_type: galleryActiveCommentsPost.type, comment_body: body });
      if (result.error) {
        result = await window.supabaseClient.from('post_comments').insert({ post_owner_id: galleryActiveCommentsPost.ownerId, post_date: galleryActiveCommentsPost.date, post_type: galleryActiveCommentsPost.type, author_id: galleryCurrentUserId, body });
      }
    } else {
      result = await window.supabaseClient.from('post_comments').insert({ post_owner_id: galleryActiveCommentsPost.ownerId, post_date: galleryActiveCommentsPost.date, post_type: galleryActiveCommentsPost.type, author_id: galleryCurrentUserId, body });
    }
    const { error } = result;
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
  applyGalleryFeatureFlags();
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
  let reading = document.getElementById('gallery-reading-label');
  const prev = document.getElementById('gallery-prev-day');
  const next = document.getElementById('gallery-next-day');
  const readingText = galleryReadingLabel(gallerySelectedIndex);
  if (display) display.textContent = `${key}(${readingText})`;
  if (count) count.textContent = `DAY ${gallerySelectedIndex + 1} / ${galleryDays.length}`;
  if (label) label.textContent = parts.full;
  if (!reading && label) {
    reading = document.createElement('p');
    reading.id = 'gallery-reading-label';
    reading.className = 'text-xl sm:text-2xl font-black text-on-surface mt-2';
    label.insertAdjacentElement('afterend', reading);
  }
  if (reading) reading.textContent = readingText;
  document.getElementById('gallery-calendar-toggle')?.classList.replace('max-w-[220px]', 'max-w-[340px]');
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
    const readingText = validIndex >= 0 ? galleryReadingLabel(validIndex) : '';
    return `<button type="button" data-calendar-date="${key}" ${validIndex < 0 ? 'disabled' : ''} class="aspect-square rounded-full text-xs font-semibold ${validIndex < 0 ? 'text-outline-variant/45 cursor-not-allowed' : enabledClass}" aria-label="${monthIndex + 1}월 ${dayNumber}일${readingText ? `, ${readingText}` : ''}" title="${validIndex >= 0 ? `${key}(${readingText})` : ''}">${dayNumber}</button>`;
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
  const loaded = await loadGalleryDateRecords(galleryDays[gallerySelectedIndex]);
  if (!loaded) {
    if (grid) grid.innerHTML = '<div class="col-span-full glass-panel rounded-[2rem] p-10 text-center"><i class="fa-solid fa-triangle-exclamation text-error text-xl mb-3"></i><p class="text-sm font-bold">Gallery 기록을 불러오지 못했습니다.</p><p class="text-xs text-on-surface-variant mt-2">관리자 스키마를 다시 실행한 뒤 새로고침해주세요.</p></div>';
    return;
  }
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
  const params = new URLSearchParams(window.location.search);
  const requestedDate = params.get('date');
  const requestedType = params.get('type');
  gallerySelectedIndex = requestedDate && galleryDays.includes(requestedDate)
    ? galleryDays.indexOf(requestedDate)
    : galleryDefaultDayIndex();
  if (requestedType === 'pray' || requestedType === 'word') galleryActiveType = requestedType;
  galleryCalendarPage = galleryDays[gallerySelectedIndex]?.startsWith('2026-09') ? 1 : 0;
  wireGalleryCalendar();
  wireGalleryComments();
  renderGalleryTypeTabs();
  renderGalleryCalendar();
  galleryCurrentUserId = await getCurrentUserId();
  galleryCanComment = await loadGalleryCommentPermission();
  galleryUsers = await loadGalleryUsers();
  galleryAvatarUrls = window.getProfileAvatarUrls
    ? await window.getProfileAvatarUrls(galleryUsers.map((user) => user.id))
    : {};
  applyGalleryGridClass();
  wirePhotoLightbox();
  await selectGalleryDay(gallerySelectedIndex);
  document.querySelectorAll('[data-admin-gallery-edit-close]').forEach((button) => button.addEventListener('click', closeAdminGalleryEdit));
  document.getElementById('admin-gallery-edit-save')?.addEventListener('click', saveAdminGalleryEdit);
}

function applyGalleryGridClass() {
  const grid = document.getElementById('gallery-active-grid');
  if (!grid) return;
  grid.className = window.IS_ADMIN_CONSOLE ? GALLERY_GRID_CLASS_MANAGE : GALLERY_GRID_CLASS_VIEW;
}

async function setGalleryAdminMode(isAdmin) {
  if (window.IS_ADMIN_CONSOLE === isAdmin) return;
  window.IS_ADMIN_CONSOLE = isAdmin;
  applyGalleryGridClass();
  galleryCanComment = await loadGalleryCommentPermission();
  if (galleryDays.length) await selectGalleryDay(gallerySelectedIndex);
}

window.initGalleryWidgets = initGalleryWidgets;
window.setGalleryAdminMode = setGalleryAdminMode;
