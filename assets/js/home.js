// Home page only: Progress checkmarks, widget verification rings, and the 기도 인증 모달.
// State is stored locally (per-browser) for now — not yet saved to Supabase.
const PROGRESS_STORAGE_KEY = 'sap_progress_v1';
const PRAYER_CLASSES_STORAGE_KEY = 'sap_prayer_classes_v1';

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

const DAILY_GOAL_MINUTES = 300;

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

function wireCalendarTabs() {
  const weeklyBtn = document.getElementById('calendar-tab-weekly');
  const monthlyBtn = document.getElementById('calendar-tab-monthly');
  if (!weeklyBtn || !monthlyBtn) return;

  function selectTab(active, inactive) {
    active.classList.add('nav-pill-active');
    active.classList.remove('text-on-surface-variant');
    inactive.classList.remove('nav-pill-active');
    inactive.classList.add('text-on-surface-variant');
  }

  weeklyBtn.addEventListener('click', () => selectTab(weeklyBtn, monthlyBtn));
  monthlyBtn.addEventListener('click', () => selectTab(monthlyBtn, weeklyBtn));
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

function addPrayClassEntry() {
  const template = document.getElementById('pray-class-template');
  const list = document.getElementById('pray-class-list');
  if (!template || !list) return;

  list.appendChild(template.content.cloneNode(true));
  wirePhotoPreview(list.lastElementChild);
  updatePrayRemoveButtons();
}

function openPrayModal() {
  const modal = document.getElementById('pray-modal');
  const list = document.getElementById('pray-class-list');
  if (!modal || !list) return;
  list.innerHTML = '';
  addPrayClassEntry();
  modal.classList.remove('hidden');
  modal.classList.add('flex');
}

function closePrayModal() {
  const modal = document.getElementById('pray-modal');
  if (!modal) return;
  modal.classList.add('hidden');
  modal.classList.remove('flex');
}

function initHomeWidgets() {
  renderVerificationState();
  renderPrayWidgetSummary();
  renderDailyGoals();
  renderCalendarStrip();
  wireCalendarTabs();

  const prayWidget = document.getElementById('widget-pray');
  if (prayWidget) prayWidget.addEventListener('click', openPrayModal);

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
}

window.initHomeWidgets = initHomeWidgets;
