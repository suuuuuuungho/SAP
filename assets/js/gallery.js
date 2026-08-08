// Sapians 날짜별 갤러리: 운영기간 20개 평일을 이동하며 학생별 고유 칸을 보여준다.

const GALLERY_START_DATE = '2026-08-10';
const GALLERY_END_DATE = '2026-09-06';
const GALLERY_PAGE_SIZE = 8;

let galleryDays = [];
let gallerySelectedIndex = 0;
let gallerySelectedPage = 0;
let galleryUsers = [];
let galleryPrayMap = {};
let galleryWordMap = {};

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

function galleryMediaHTML(userId, type) {
  const data = galleryCategoryData(userId, type);
  const photos = data.photos;
  if (!photos.length) {
    const message = data.verified ? '사진 없이 인증했어요' : '아직 인증 사진이 없어요';
    return `<div class="aspect-[4/3] rounded-2xl bg-surface-container flex flex-col items-center justify-center text-on-surface-variant"><i class="fa-regular fa-image text-2xl mb-2 opacity-50"></i><p class="text-xs">${message}</p></div>`;
  }
  const columns = photos.length === 1 ? 'grid-cols-1' : 'grid-cols-2';
  return `<div class="grid ${columns} gap-1 aspect-[4/3] rounded-2xl overflow-hidden bg-surface-container">${photos.slice(0, 4).map((photo, index) => `
    <div class="relative min-h-0 ${photos.length === 3 && index === 0 ? 'row-span-2' : ''}">
      <img src="${getPhotoUrl(photo)}" class="w-full h-full object-contain bg-surface-container" alt="${type === 'pray' ? '기도' : '말씀'} 인증 사진">
    </div>`).join('')}</div>`;
}

function galleryStudentCardHTML(user, type) {
  const data = galleryCategoryData(user.id, type);
  const accent = type === 'pray' ? 'text-primary bg-primary/10' : 'text-secondary bg-secondary/10';
  return `
    <article class="glass-card rounded-[1.5rem] p-4 min-w-0" data-gallery-user="${user.id}" data-gallery-type="${type}">
      <div class="flex items-center gap-3 mb-3">
        <div class="w-10 h-10 rounded-full bg-gradient-to-br from-primary-container to-tertiary-container text-on-primary flex items-center justify-center font-bold flex-shrink-0">${galleryEscape(user.name).charAt(0) || '?'}</div>
        <div class="min-w-0"><p class="font-bold text-sm truncate">${galleryEscape(user.name)}</p><p class="text-[11px] text-on-surface-variant truncate">@${galleryEscape(user.username)}</p></div>
      </div>
      ${galleryMediaHTML(user.id, type)}
      <div class="mt-3"><span class="rounded-full px-2.5 py-1 text-[11px] font-semibold ${data.verified ? accent : 'text-on-surface-variant bg-surface-container'}">${data.verified ? '인증 완료' : '미인증'}</span></div>
    </article>`;
}

function renderGalleryGrid() {
  const start = gallerySelectedPage * GALLERY_PAGE_SIZE;
  const pageUsers = galleryUsers.slice(start, start + GALLERY_PAGE_SIZE);
  ['pray', 'word'].forEach((type) => {
    const grid = document.getElementById(`gallery-${type}-grid`);
    if (!grid) return;
    grid.innerHTML = pageUsers.length
      ? pageUsers.map((user) => galleryStudentCardHTML(user, type)).join('')
      : '<div class="glass-panel rounded-[2rem] p-12 text-center text-sm text-on-surface-variant col-span-full">표시할 학생이 없습니다.</div>';
  });
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
  const input = document.getElementById('gallery-date-control');
  const count = document.getElementById('gallery-day-count');
  const label = document.getElementById('gallery-date-label');
  const prev = document.getElementById('gallery-prev-day');
  const next = document.getElementById('gallery-next-day');
  if (input) {
    if (!input.options.length) {
      input.innerHTML = galleryDays.map((day) => `<option value="${day}">${galleryDateParts(day).short}</option>`).join('');
    }
    input.value = key;
  }
  if (count) count.textContent = `DAY ${gallerySelectedIndex + 1} / ${galleryDays.length}`;
  if (label) label.textContent = parts.full;
  if (prev) prev.disabled = gallerySelectedIndex === 0;
  if (next) next.disabled = gallerySelectedIndex === galleryDays.length - 1;

}

async function selectGalleryDay(index) {
  const nextIndex = Math.max(0, Math.min(galleryDays.length - 1, index));
  gallerySelectedIndex = nextIndex;
  gallerySelectedPage = 0;
  renderGalleryCalendar();
  ['pray', 'word'].forEach((type) => {
    const grid = document.getElementById(`gallery-${type}-grid`);
    if (grid) grid.innerHTML = '<div class="col-span-full py-16 text-center text-sm text-on-surface-variant"><i class="fa-solid fa-circle-notch fa-spin mr-2"></i>불러오는 중</div>';
  });
  await loadGalleryDateRecords(galleryDays[gallerySelectedIndex]);
  renderGalleryGrid();
}

function wireGalleryCalendar() {
  document.getElementById('gallery-prev-day')?.addEventListener('click', () => selectGalleryDay(gallerySelectedIndex - 1));
  document.getElementById('gallery-next-day')?.addEventListener('click', () => selectGalleryDay(gallerySelectedIndex + 1));
  document.getElementById('gallery-date-control')?.addEventListener('change', (event) => selectGalleryDay(galleryDays.indexOf(event.target.value)));
  document.getElementById('gallery-pagination')?.addEventListener('click', (event) => {
    const button = event.target.closest('[data-gallery-page]');
    if (!button) return;
    gallerySelectedPage = Number(button.dataset.galleryPage);
    renderGalleryGrid();
    document.getElementById('gallery-pray-grid')?.scrollIntoView({ behavior: 'smooth', block: 'start' });
  });
}

async function initGalleryWidgets() {
  galleryDays = buildGalleryDays();
  wireGalleryCalendar();
  renderGalleryCalendar();
  galleryUsers = await loadGalleryUsers();
  await selectGalleryDay(0);
}

window.initGalleryWidgets = initGalleryWidgets;
