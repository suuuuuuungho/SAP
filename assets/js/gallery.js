// Gallery page: 기도 인증/말씀 묵상 두 탭, 유저별 칸(선으로만 구분, 위젯 스타일 아님).
// 데이터는 pray-word.js를 통해 Home과 동일한 Supabase 테이블을 읽고 쓴다 (동기화).

let galleryCurrentUserId = null;
let galleryUsers = []; // [{id, username, name}]
let galleryActiveTab = 'pray'; // 'pray' | 'word'
let galleryDateKey = todayKey(); // 그리드에 표시 중인 날짜 (날짜 입력으로 변경 가능)
let galleryPrayMap = {}; // user_id -> pray_records row
let galleryWordMap = {}; // user_id -> word_records row

async function loadGalleryUsers() {
  const { data, error } = await window.supabaseClient.rpc('get_gallery_users');
  if (error) {
    console.error('[gallery] loadGalleryUsers', error);
    return [];
  }
  return data || [];
}

async function loadGalleryRecords() {
  const ids = galleryUsers.map((u) => u.id);
  if (ids.length === 0) {
    galleryPrayMap = {};
    galleryWordMap = {};
    return;
  }
  const [prayRes, wordRes] = await Promise.all([
    window.supabaseClient.from('pray_records').select('*').eq('record_date', galleryDateKey).in('user_id', ids),
    window.supabaseClient.from('word_records').select('*').eq('record_date', galleryDateKey).in('user_id', ids)
  ]);
  if (prayRes.error) console.error('[gallery] pray_records', prayRes.error);
  if (wordRes.error) console.error('[gallery] word_records', wordRes.error);
  galleryPrayMap = Object.fromEntries((prayRes.data || []).map((r) => [r.user_id, r]));
  galleryWordMap = Object.fromEntries((wordRes.data || []).map((r) => [r.user_id, r]));
}

function galleryCellHTML(user) {
  const isOwn = user.id === galleryCurrentUserId;
  const clickableCls = isOwn ? 'cursor-pointer hover:bg-white/40 transition-colors' : '';
  const label = `${user.name} <span class="text-on-surface-variant">(${user.username})</span>`;

  if (galleryActiveTab === 'pray') {
    const row = galleryPrayMap[user.id];
    const entries = row ? row.entries : [];
    if (entries.length > 0) {
      const photoPath = entries[0].photoUnavailable ? null : entries[0].photoPath;
      const summary = formatPrayerSummary(entries);
      return `
        <div class="p-4 ${clickableCls}" data-user-id="${user.id}">
          <img src="${getPhotoUrl(photoPath)}" class="w-full aspect-square object-cover rounded-xl mb-2" alt="${user.name} 기도 인증 사진">
          <p class="text-sm font-semibold text-on-surface truncate">${label}</p>
          <p class="text-xs text-on-surface-variant mt-1 leading-relaxed">${summary}</p>
        </div>`;
    }
  } else {
    const row = galleryWordMap[user.id];
    const verses = row ? row.verses : [];
    if (verses.length > 0) {
      const photoPath = row.photo_unavailable ? null : row.photo_path;
      const summary = formatWordSummary(verses);
      return `
        <div class="p-4 ${clickableCls}" data-user-id="${user.id}">
          <img src="${getPhotoUrl(photoPath)}" class="w-full aspect-square object-cover rounded-xl mb-2" alt="${user.name} 말씀 인증 사진">
          <p class="text-sm font-semibold text-on-surface truncate">${label}</p>
          <p class="text-xs text-on-surface-variant mt-1 leading-relaxed">${summary}</p>
        </div>`;
    }
  }

  return `
    <div class="p-4 flex items-center justify-center min-h-[140px] text-center ${clickableCls}" data-user-id="${user.id}">
      <p class="text-sm font-medium text-on-surface-variant">${label}</p>
    </div>`;
}

function renderGalleryGrid() {
  const grid = document.getElementById('gallery-grid');
  if (!grid) return;

  if (galleryUsers.length === 0) {
    grid.innerHTML = '<p class="text-sm text-on-surface-variant text-center py-12">표시할 이용자가 없습니다.</p>';
    return;
  }

  grid.innerHTML = `
    <div class="border border-outline-variant rounded-[2rem] overflow-hidden grid grid-cols-2 sm:grid-cols-3 lg:grid-cols-4 divide-x divide-y divide-outline-variant">
      ${galleryUsers.map(galleryCellHTML).join('')}
    </div>`;
}

async function onGallerySaved() {
  await loadGalleryRecords();
  renderGalleryGrid();
}

function wireGalleryTabs() {
  const prayBtn = document.getElementById('gallery-tab-pray');
  const wordBtn = document.getElementById('gallery-tab-word');
  if (!prayBtn || !wordBtn) return;

  function selectTab(active, inactive, tab) {
    active.classList.add('nav-pill-active');
    active.classList.remove('text-on-surface-variant');
    inactive.classList.remove('nav-pill-active');
    inactive.classList.add('text-on-surface-variant');
    galleryActiveTab = tab;
    renderGalleryGrid();
  }

  prayBtn.addEventListener('click', () => selectTab(prayBtn, wordBtn, 'pray'));
  wordBtn.addEventListener('click', () => selectTab(wordBtn, prayBtn, 'word'));
}

function wireGalleryGridClicks() {
  const grid = document.getElementById('gallery-grid');
  if (!grid) return;

  grid.addEventListener('click', (e) => {
    const cell = e.target.closest('[data-user-id]');
    if (!cell || cell.dataset.userId !== galleryCurrentUserId) return;

    if (galleryActiveTab === 'pray') {
      openPrayModal(galleryDateKey, onGallerySaved);
    } else {
      openWordModal(galleryDateKey, onGallerySaved);
    }
  });
}

function wireGalleryDateControl() {
  const dateInput = document.getElementById('gallery-date-input');
  const todayBtn = document.getElementById('gallery-date-today');
  if (!dateInput) return;

  function syncTodayButton() {
    if (todayBtn) todayBtn.classList.toggle('hidden', galleryDateKey === todayKey());
  }

  dateInput.value = galleryDateKey;
  syncTodayButton();

  dateInput.addEventListener('change', async () => {
    if (!dateInput.value) return;
    galleryDateKey = dateInput.value;
    syncTodayButton();
    await loadGalleryRecords();
    renderGalleryGrid();
  });

  if (todayBtn) {
    todayBtn.addEventListener('click', async () => {
      galleryDateKey = todayKey();
      dateInput.value = galleryDateKey;
      syncTodayButton();
      await loadGalleryRecords();
      renderGalleryGrid();
    });
  }
}

async function initGalleryWidgets() {
  wireGalleryTabs();
  wireGalleryGridClicks();
  wireGalleryDateControl();
  wirePrayModalStatic();
  wireWordModalStatic();

  galleryCurrentUserId = await getCurrentUserId();
  galleryUsers = await loadGalleryUsers();
  await loadGalleryRecords();
  renderGalleryGrid();
}

window.initGalleryWidgets = initGalleryWidgets;
