// Home page only: Progress checkmarks, widget verification rings, and the 기도 인증 모달.
// State is stored locally (per-browser) for now — not yet saved to Supabase.
const PROGRESS_STORAGE_KEY = 'sap_progress_v1';
const PRAYER_CLASSES_STORAGE_KEY = 'sap_prayer_classes_v1';
const WORD_VERSES_STORAGE_KEY = 'sap_word_verses_v1';

function loadProgress() {
  try {
    return Object.assign(
      { pray: false, word: false, study: false, worship: false },
      JSON.parse(localStorage.getItem(PROGRESS_STORAGE_KEY) || '{}')
    );
  } catch (e) {
    return { pray: false, word: false, study: false, worship: false };
  }
}

function saveProgress(progress) {
  localStorage.setItem(PROGRESS_STORAGE_KEY, JSON.stringify(progress));
}

function loadPrayerClasses() {
  try {
    return JSON.parse(localStorage.getItem(PRAYER_CLASSES_STORAGE_KEY) || '[]');
  } catch (e) {
    return [];
  }
}

function loadWordVerses() {
  try {
    return JSON.parse(localStorage.getItem(WORD_VERSES_STORAGE_KEY) || '[]');
  } catch (e) {
    return [];
  }
}

// Same checkmark icon everywhere — colored gradient when verified, neutral glass when not.
// Verified widget cards also get a gradient ring matching the active nav pill color.
function renderVerificationState() {
  const progress = loadProgress();

  document.querySelectorAll('[data-progress-icon]').forEach((el) => {
    const key = el.getAttribute('data-progress-icon');
    el.className = progress[key]
      ? 'w-8 h-8 rounded-full bg-gradient-to-br from-primary-container to-tertiary-container text-on-primary flex items-center justify-center shrink-0'
      : 'icon-glass w-8 h-8 rounded-full text-on-surface-variant flex items-center justify-center shrink-0';
  });

  document.querySelectorAll('[data-widget]').forEach((el) => {
    const key = el.getAttribute('data-widget');
    el.classList.toggle('is-verified', !!progress[key]);
  });
}

function formatPrayerSummary(entries) {
  return entries
    .filter((entry) => entry.location)
    .map((entry) => (entry.start && entry.end ? `${entry.location} ${entry.start}–${entry.end}` : entry.location))
    .join(', ');
}

function timeToMinutes(hhmm) {
  if (!hhmm) return null;
  const [h, m] = hhmm.split(':').map(Number);
  if (Number.isNaN(h) || Number.isNaN(m)) return null;
  return h * 60 + m;
}

function durationMinutes(start, end) {
  const s = timeToMinutes(start);
  const e = timeToMinutes(end);
  if (s === null || e === null) return 0;
  let diff = e - s;
  if (diff < 0) diff += 24 * 60; // crossed midnight
  return diff;
}

function renderPrayWidgetSummary() {
  const slot = document.querySelector('#widget-pray .widget-summary');
  if (!slot) return;

  const entries = loadPrayerClasses();
  const summary = formatPrayerSummary(entries);

  if (summary) {
    const totalMinutes = entries.reduce((sum, entry) => sum + durationMinutes(entry.start, entry.end), 0);
    slot.innerHTML = `
      <p class="text-3xl font-bold text-primary">${totalMinutes}<span class="text-base font-semibold ml-0.5">분</span></p>
      <p class="text-xs text-on-surface-variant mt-2 leading-relaxed">${summary}</p>
    `;
  } else {
    slot.innerHTML = '<div class="w-full border-t-2 border-dashed border-outline-variant"></div>';
  }
}

function formatVerseRange(entry) {
  if (!entry.startBook || !entry.startChapter || !entry.startVerse) return '';
  const start = `${entry.startBook} ${entry.startChapter}:${entry.startVerse}`;
  if (!entry.endBook || !entry.endChapter || !entry.endVerse) return start;
  const end = entry.endBook === entry.startBook
    ? `${entry.endChapter}:${entry.endVerse}`
    : `${entry.endBook} ${entry.endChapter}:${entry.endVerse}`;
  return `${start} ~ ${end}`;
}

function formatWordSummary(entries) {
  return entries.map(formatVerseRange).filter(Boolean).join(', ');
}

function renderWordWidgetSummary() {
  const slot = document.querySelector('#widget-word .widget-summary');
  if (!slot) return;

  const summary = formatWordSummary(loadWordVerses());
  if (summary) {
    slot.innerHTML = `<p class="text-xs text-on-surface leading-relaxed">${summary}</p>`;
  } else {
    slot.innerHTML = '<div class="w-full border-t-2 border-dashed border-outline-variant"></div>';
  }
}

const DAILY_GOAL_MINUTES = 300;
const GOAL_CELEBRATED_KEY = 'sap_goal_celebrated_v1';

// Small dependency-free confetti burst, fired once the moment the goal is first reached.
function launchConfetti() {
  const colors = ['#ff4b91', '#ee6650', '#cca9fe', '#b9045e', '#6e4f9c'];
  const container = document.createElement('div');
  container.className = 'confetti-container';

  for (let i = 0; i < 120; i += 1) {
    const piece = document.createElement('div');
    const size = 6 + Math.random() * 6;
    const duration = 2.2 + Math.random() * 1.4;

    piece.className = 'confetti-piece';
    piece.style.left = `${Math.random() * 100}vw`;
    piece.style.width = `${size}px`;
    piece.style.height = `${size * 0.4}px`;
    piece.style.background = colors[Math.floor(Math.random() * colors.length)];
    piece.style.transform = `rotate(${Math.random() * 360}deg)`;
    piece.style.setProperty('--drift', `${(Math.random() - 0.5) * 220}px`);
    piece.style.animation = `confetti-fall ${duration}s ease-in ${Math.random() * 0.4}s forwards`;

    container.appendChild(piece);
  }

  document.body.appendChild(container);
  setTimeout(() => container.remove(), 4000);
}

// Only 기도 has real tracked minutes so far; 말씀/공부/예배 default to 0
// until their own input flows exist, same as the Progress checkmarks.
function getCategoryMinutes(key) {
  if (key === 'pray') {
    return loadPrayerClasses().reduce((sum, entry) => sum + durationMinutes(entry.start, entry.end), 0);
  }
  return 0;
}

function renderDailyGoals() {
  const ring = document.getElementById('daily-goal-ring');
  const percentEl = document.getElementById('daily-goal-percent');
  const captionEl = document.getElementById('daily-goal-caption');
  if (!ring || !percentEl || !captionEl) return;

  const totalMinutes = ['pray', 'word', 'study', 'worship'].reduce((sum, key) => sum + getCategoryMinutes(key), 0);
  const percent = Math.round((totalMinutes / DAILY_GOAL_MINUTES) * 100);
  const filledPercent = Math.min(percent, 100);

  const alreadyCelebrated = localStorage.getItem(GOAL_CELEBRATED_KEY) === 'true';
  if (percent >= 100 && !alreadyCelebrated) {
    launchConfetti();
    localStorage.setItem(GOAL_CELEBRATED_KEY, 'true');
  } else if (percent < 100 && alreadyCelebrated) {
    localStorage.setItem(GOAL_CELEBRATED_KEY, 'false');
  }

  const radius = 52;
  const circumference = 2 * Math.PI * radius;
  ring.setAttribute('stroke-dasharray', String(circumference));
  ring.setAttribute('stroke-dashoffset', String(circumference * (1 - filledPercent / 100)));

  percentEl.textContent = `${percent}%`;
  captionEl.textContent = percent > 100 ? '목표 초과 달성' : '달성';
}

function renderCalendarStrip() {
  const stripEl = document.getElementById('calendar-strip');
  const monthEl = document.getElementById('calendar-month');
  const dayEl = document.getElementById('calendar-day');
  if (!stripEl || !monthEl || !dayEl) return;

  const monthNames = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
  const dayNames = ['SUN', 'MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT'];
  const today = new Date();

  monthEl.textContent = monthNames[today.getMonth()];
  dayEl.textContent = String(today.getDate());

  stripEl.innerHTML = '';
  for (let offset = -3; offset <= 3; offset += 1) {
    const d = new Date(today);
    d.setDate(today.getDate() + offset);
    const isToday = offset === 0;

    const cell = document.createElement('div');
    cell.className = 'flex flex-col items-center gap-2';
    cell.innerHTML = `
      <span class="text-[10px] font-semibold ${isToday ? 'text-primary' : 'text-on-surface-variant'}">${dayNames[d.getDay()]}</span>
      <span class="w-9 h-9 flex items-center justify-center rounded-full text-sm ${isToday ? 'bg-gradient-to-br from-primary-container to-tertiary-container text-on-primary font-bold' : 'text-on-surface'}">${d.getDate()}</span>
    `;
    stripEl.appendChild(cell);
  }
}

function renderMonthlyCalendar() {
  const grid = document.getElementById('calendar-monthly-view');
  if (!grid) return;

  const dayNames = ['SUN', 'MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT'];
  const today = new Date();
  const year = today.getFullYear();
  const month = today.getMonth();
  const firstWeekday = new Date(year, month, 1).getDay();
  const daysInMonth = new Date(year, month + 1, 0).getDate();

  grid.innerHTML = '';

  dayNames.forEach((name) => {
    const header = document.createElement('span');
    header.className = 'text-[10px] font-semibold text-on-surface-variant py-1';
    header.textContent = name;
    grid.appendChild(header);
  });

  for (let i = 0; i < firstWeekday; i += 1) {
    grid.appendChild(document.createElement('span'));
  }

  for (let date = 1; date <= daysInMonth; date += 1) {
    const isToday = date === today.getDate();
    const cell = document.createElement('div');
    cell.className = 'flex items-center justify-center py-1';
    cell.innerHTML = `<span class="w-8 h-8 flex items-center justify-center rounded-full text-sm ${isToday ? 'bg-gradient-to-br from-primary-container to-tertiary-container text-on-primary font-bold' : 'text-on-surface'}">${date}</span>`;
    grid.appendChild(cell);
  }
}

function wireCalendarTabs() {
  const weeklyBtn = document.getElementById('calendar-tab-weekly');
  const monthlyBtn = document.getElementById('calendar-tab-monthly');
  const weeklyView = document.getElementById('calendar-weekly-view');
  const monthlyView = document.getElementById('calendar-monthly-view');
  if (!weeklyBtn || !monthlyBtn) return;

  function selectTab(active, inactive) {
    active.classList.add('nav-pill-active');
    active.classList.remove('text-on-surface-variant');
    inactive.classList.remove('nav-pill-active');
    inactive.classList.add('text-on-surface-variant');
  }

  weeklyBtn.addEventListener('click', () => {
    selectTab(weeklyBtn, monthlyBtn);
    if (weeklyView) weeklyView.classList.remove('hidden');
    if (monthlyView) {
      monthlyView.classList.add('hidden');
      monthlyView.classList.remove('grid');
    }
  });

  monthlyBtn.addEventListener('click', () => {
    selectTab(monthlyBtn, weeklyBtn);
    renderMonthlyCalendar();
    if (monthlyView) {
      monthlyView.classList.remove('hidden');
      monthlyView.classList.add('grid');
    }
    if (weeklyView) weeklyView.classList.add('hidden');
  });
}

function wirePhotoPreview(entryEl) {
  const input = entryEl.querySelector('.pray-photo-input');
  const wrap = entryEl.querySelector('.pray-photo-preview-wrap');
  const preview = entryEl.querySelector('.pray-photo-preview');
  const removeBtn = entryEl.querySelector('.pray-photo-remove');
  if (!input || !wrap || !preview) return;

  function clearPhoto() {
    if (preview.dataset.objectUrl) {
      URL.revokeObjectURL(preview.dataset.objectUrl);
      delete preview.dataset.objectUrl;
    }
    preview.src = '';
    wrap.classList.add('hidden');
    input.value = '';
  }

  input.addEventListener('change', () => {
    const file = input.files && input.files[0];
    if (!file) {
      clearPhoto();
      return;
    }
    if (preview.dataset.objectUrl) URL.revokeObjectURL(preview.dataset.objectUrl);
    const url = URL.createObjectURL(file);
    preview.src = url;
    preview.dataset.objectUrl = url;
    wrap.classList.remove('hidden');
  });

  if (removeBtn) removeBtn.addEventListener('click', clearPhoto);
}

function updatePrayRemoveButtons() {
  const entries = document.querySelectorAll('#pray-class-list .pray-class-entry');
  entries.forEach((entry) => {
    const removeBtn = entry.querySelector('.pray-remove-class');
    if (removeBtn) removeBtn.classList.toggle('hidden', entries.length <= 1);
  });
}

function addPrayClassEntry(data) {
  const template = document.getElementById('pray-class-template');
  const list = document.getElementById('pray-class-list');
  if (!template || !list) return;

  list.appendChild(template.content.cloneNode(true));
  const entryEl = list.lastElementChild;
  wirePhotoPreview(entryEl);

  if (data) {
    if (data.location) entryEl.querySelector('.pray-location-input').value = data.location;
    if (data.start) entryEl.querySelector('.pray-start-input').value = data.start;
    if (data.end) entryEl.querySelector('.pray-end-input').value = data.end;
  }

  updatePrayRemoveButtons();
}

// Re-opening loads previously saved classes so they can be edited, not just appended to.
// (사진은 브라우저에만 임시로 있던 미리보기라 저장되지 않으므로 다시 열면 비어 있습니다.)
function openPrayModal() {
  const modal = document.getElementById('pray-modal');
  const list = document.getElementById('pray-class-list');
  if (!modal || !list) return;
  list.innerHTML = '';

  const existing = loadPrayerClasses();
  if (existing.length > 0) {
    existing.forEach((entry) => addPrayClassEntry(entry));
  } else {
    addPrayClassEntry();
  }

  modal.classList.remove('hidden');
  modal.classList.add('flex');
}

function closePrayModal() {
  const modal = document.getElementById('pray-modal');
  if (!modal) return;
  modal.classList.add('hidden');
  modal.classList.remove('flex');
}

// 말씀 modal: one shared required photo (not per-entry, unlike 기도) + repeatable verse ranges.
function wireWordPhotoPreview() {
  const input = document.getElementById('word-photo-input');
  const wrap = document.getElementById('word-photo-preview-wrap');
  const preview = document.getElementById('word-photo-preview');
  const removeBtn = document.getElementById('word-photo-remove');
  const hint = document.getElementById('word-photo-hint');
  if (!input || !wrap || !preview) return;

  function clearPhoto() {
    if (preview.dataset.objectUrl) {
      URL.revokeObjectURL(preview.dataset.objectUrl);
      delete preview.dataset.objectUrl;
    }
    preview.src = '';
    wrap.classList.add('hidden');
    input.value = '';
  }

  input.addEventListener('change', () => {
    if (hint) hint.classList.add('hidden');
    const file = input.files && input.files[0];
    if (!file) {
      clearPhoto();
      return;
    }
    if (preview.dataset.objectUrl) URL.revokeObjectURL(preview.dataset.objectUrl);
    const url = URL.createObjectURL(file);
    preview.src = url;
    preview.dataset.objectUrl = url;
    wrap.classList.remove('hidden');
  });

  if (removeBtn) removeBtn.addEventListener('click', clearPhoto);
}

function updateWordRemoveButtons() {
  const entries = document.querySelectorAll('#word-verse-list .word-verse-entry');
  entries.forEach((entry) => {
    const removeBtn = entry.querySelector('.word-remove-verse');
    if (removeBtn) removeBtn.classList.toggle('hidden', entries.length <= 1);
  });
}

function addWordVerseEntry(data) {
  const template = document.getElementById('word-verse-template');
  const list = document.getElementById('word-verse-list');
  if (!template || !list) return;

  list.appendChild(template.content.cloneNode(true));
  const entryEl = list.lastElementChild;

  renderBibleBookOptions(entryEl.querySelector('.word-start-book'));
  renderBibleBookOptions(entryEl.querySelector('.word-end-book'));

  if (data) {
    if (data.startBook) entryEl.querySelector('.word-start-book').value = data.startBook;
    if (data.startChapter) entryEl.querySelector('.word-start-chapter').value = data.startChapter;
    if (data.startVerse) entryEl.querySelector('.word-start-verse').value = data.startVerse;
    if (data.endBook) entryEl.querySelector('.word-end-book').value = data.endBook;
    if (data.endChapter) entryEl.querySelector('.word-end-chapter').value = data.endChapter;
    if (data.endVerse) entryEl.querySelector('.word-end-verse').value = data.endVerse;
  }

  updateWordRemoveButtons();
}

// Re-opening loads previously saved verse ranges for editing. The required photo can't be
// restored (only an in-memory preview URL was ever kept), so it must be re-attached to save again.
function openWordModal() {
  const modal = document.getElementById('word-modal');
  const list = document.getElementById('word-verse-list');
  if (!modal || !list) return;
  list.innerHTML = '';

  const existing = loadWordVerses();
  if (existing.length > 0) {
    existing.forEach((entry) => addWordVerseEntry(entry));
  } else {
    addWordVerseEntry();
  }

  const photoInput = document.getElementById('word-photo-input');
  const photoWrap = document.getElementById('word-photo-preview-wrap');
  const photoHint = document.getElementById('word-photo-hint');
  if (photoInput) photoInput.value = '';
  if (photoWrap) photoWrap.classList.add('hidden');
  if (photoHint) photoHint.classList.add('hidden');

  modal.classList.remove('hidden');
  modal.classList.add('flex');
}

function closeWordModal() {
  const modal = document.getElementById('word-modal');
  if (!modal) return;
  modal.classList.add('hidden');
  modal.classList.remove('flex');
}

function initHomeWidgets() {
  renderVerificationState();
  renderPrayWidgetSummary();
  renderWordWidgetSummary();
  renderDailyGoals();
  renderCalendarStrip();
  wireCalendarTabs();
  wireWordPhotoPreview();

  const prayWidget = document.getElementById('widget-pray');
  if (prayWidget) prayWidget.addEventListener('click', openPrayModal);

  const wordWidget = document.getElementById('widget-word');
  if (wordWidget) wordWidget.addEventListener('click', openWordModal);

  const closeBtn = document.getElementById('pray-modal-close');
  const overlay = document.getElementById('pray-modal-overlay');
  const cancelBtn = document.getElementById('pray-cancel');
  const addBtn = document.getElementById('pray-add-class');
  const saveBtn = document.getElementById('pray-save');
  const list = document.getElementById('pray-class-list');

  if (closeBtn) closeBtn.addEventListener('click', closePrayModal);
  if (overlay) overlay.addEventListener('click', closePrayModal);
  if (cancelBtn) cancelBtn.addEventListener('click', closePrayModal);
  if (addBtn) addBtn.addEventListener('click', addPrayClassEntry);

  if (list) {
    list.addEventListener('click', (e) => {
      const removeBtn = e.target.closest('.pray-remove-class');
      if (!removeBtn) return;
      removeBtn.closest('.pray-class-entry').remove();
      updatePrayRemoveButtons();
    });
  }

  if (saveBtn) {
    saveBtn.addEventListener('click', () => {
      const entries = [...document.querySelectorAll('#pray-class-list .pray-class-entry')].map((entry) => ({
        location: entry.querySelector('.pray-location-input').value,
        start: entry.querySelector('.pray-start-input').value,
        end: entry.querySelector('.pray-end-input').value
      }));

      localStorage.setItem(PRAYER_CLASSES_STORAGE_KEY, JSON.stringify(entries));

      const progress = loadProgress();
      progress.pray = true;
      saveProgress(progress);

      renderVerificationState();
      renderPrayWidgetSummary();
      renderDailyGoals();
      closePrayModal();
    });
  }

  const wordCloseBtn = document.getElementById('word-modal-close');
  const wordOverlay = document.getElementById('word-modal-overlay');
  const wordCancelBtn = document.getElementById('word-cancel');
  const wordAddBtn = document.getElementById('word-add-verse');
  const wordSaveBtn = document.getElementById('word-save');
  const wordList = document.getElementById('word-verse-list');

  if (wordCloseBtn) wordCloseBtn.addEventListener('click', closeWordModal);
  if (wordOverlay) wordOverlay.addEventListener('click', closeWordModal);
  if (wordCancelBtn) wordCancelBtn.addEventListener('click', closeWordModal);
  if (wordAddBtn) wordAddBtn.addEventListener('click', () => addWordVerseEntry());

  if (wordList) {
    wordList.addEventListener('click', (e) => {
      const removeBtn = e.target.closest('.word-remove-verse');
      if (!removeBtn) return;
      removeBtn.closest('.word-verse-entry').remove();
      updateWordRemoveButtons();
    });
  }

  if (wordSaveBtn) {
    wordSaveBtn.addEventListener('click', () => {
      const photoInput = document.getElementById('word-photo-input');
      const photoHint = document.getElementById('word-photo-hint');
      const hasPhoto = !!(photoInput && photoInput.files && photoInput.files.length > 0);

      if (!hasPhoto) {
        if (photoHint) photoHint.classList.remove('hidden');
        return;
      }

      const entries = [...document.querySelectorAll('#word-verse-list .word-verse-entry')].map((entry) => ({
        startBook: entry.querySelector('.word-start-book').value,
        startChapter: entry.querySelector('.word-start-chapter').value,
        startVerse: entry.querySelector('.word-start-verse').value,
        endBook: entry.querySelector('.word-end-book').value,
        endChapter: entry.querySelector('.word-end-chapter').value,
        endVerse: entry.querySelector('.word-end-verse').value
      }));

      localStorage.setItem(WORD_VERSES_STORAGE_KEY, JSON.stringify(entries));

      const progress = loadProgress();
      progress.word = true;
      saveProgress(progress);

      renderVerificationState();
      renderWordWidgetSummary();
      closeWordModal();
    });
  }
}

window.initHomeWidgets = initHomeWidgets;
