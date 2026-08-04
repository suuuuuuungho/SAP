// Home page only: date-scoped daily records, Progress checkmarks, widget verification rings,
// the Daily Goals ring, the calendar date picker, and the 기도/말씀/공부 인증 modals.
// State is stored locally (per-browser) for now — not yet saved to Supabase.

const RECORDS_STORAGE_KEY = 'sap_daily_records_v1';
const DAILY_GOAL_MINUTES = 300;
const WORD_VERIFIED_MINUTES = 60; // 말씀 has no natural duration input, so a verified 말씀 is a flat 60분.

function todayKey() {
  return dateKey(new Date());
}

function dateKey(date) {
  const y = date.getFullYear();
  const m = String(date.getMonth() + 1).padStart(2, '0');
  const d = String(date.getDate()).padStart(2, '0');
  return `${y}-${m}-${d}`;
}

let selectedDateKey = todayKey();

function defaultRecord() {
  return {
    progress: { pray: false, word: false, study: false, worship: false },
    prayerClasses: [],
    wordVerses: [],
    studySessions: [], // { source: 'record' | 'manual', seconds }
    worshipStatus: null, // 'attended' | 'absent' | 'home'
    worshipMinutes: 0,
    goalCelebrated: false
  };
}

function loadAllRecords() {
  try {
    return JSON.parse(localStorage.getItem(RECORDS_STORAGE_KEY) || '{}');
  } catch (e) {
    return {};
  }
}

function saveAllRecords(records) {
  localStorage.setItem(RECORDS_STORAGE_KEY, JSON.stringify(records));
}

function getRecord(key) {
  const stored = loadAllRecords()[key] || {};
  const base = defaultRecord();
  return {
    progress: Object.assign({}, base.progress, stored.progress),
    prayerClasses: stored.prayerClasses || base.prayerClasses,
    wordVerses: stored.wordVerses || base.wordVerses,
    studySessions: stored.studySessions || base.studySessions,
    worshipStatus: typeof stored.worshipStatus === 'string' ? stored.worshipStatus : base.worshipStatus,
    worshipMinutes: typeof stored.worshipMinutes === 'number' ? stored.worshipMinutes : base.worshipMinutes,
    goalCelebrated: typeof stored.goalCelebrated === 'boolean' ? stored.goalCelebrated : base.goalCelebrated
  };
}

function updateRecord(key, updater) {
  const all = loadAllRecords();
  all[key] = updater(getRecord(key));
  saveAllRecords(all);
}

function formatSelectedDateShort() {
  if (selectedDateKey === todayKey()) return '';
  const [, m, d] = selectedDateKey.split('-').map(Number);
  return ` (${m}/${d})`;
}

// Same checkmark icon everywhere — colored gradient when verified, neutral glass when not.
// Verified widget cards also get a gradient ring matching the active nav pill color.
function renderVerificationState() {
  const progress = getRecord(selectedDateKey).progress;

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

function formatMinutesSeconds(totalSeconds) {
  const minutes = Math.floor(totalSeconds / 60);
  const seconds = totalSeconds % 60;
  return seconds > 0 ? `${minutes}분 ${seconds}초` : `${minutes}분`;
}

function renderPrayWidgetSummary() {
  const slot = document.querySelector('#widget-pray .widget-summary');
  if (!slot) return;

  const entries = getRecord(selectedDateKey).prayerClasses;
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

  const summary = formatWordSummary(getRecord(selectedDateKey).wordVerses);
  if (summary) {
    slot.innerHTML = `
      <p class="text-3xl font-bold text-primary">${WORD_VERIFIED_MINUTES}<span class="text-base font-semibold ml-0.5">분</span></p>
      <p class="text-xs text-on-surface-variant mt-2 leading-relaxed">${summary}</p>
    `;
  } else {
    slot.innerHTML = '<div class="w-full border-t-2 border-dashed border-outline-variant"></div>';
  }
}

function getStudySeconds(record, source) {
  return record.studySessions
    .filter((entry) => entry.source === source)
    .reduce((sum, entry) => sum + entry.seconds, 0);
}

function renderStudyWidgetSummary() {
  const slot = document.querySelector('#widget-study .widget-summary');
  if (!slot) return;

  const record = getRecord(selectedDateKey);
  const recordSeconds = getStudySeconds(record, 'record');
  const manualSeconds = getStudySeconds(record, 'manual');

  if (recordSeconds > 0 || manualSeconds > 0) {
    slot.innerHTML = `
      <div class="grid grid-cols-2 gap-3">
        <div>
          <p class="text-[11px] text-on-surface-variant mb-1">Record</p>
          <p class="text-lg font-bold text-primary leading-tight">${recordSeconds > 0 ? formatMinutesSeconds(recordSeconds) : '-'}</p>
        </div>
        <div>
          <p class="text-[11px] text-on-surface-variant mb-1">직접 입력</p>
          <p class="text-lg font-bold text-primary leading-tight">${manualSeconds > 0 ? formatMinutesSeconds(manualSeconds) : '-'}</p>
        </div>
      </div>
    `;
  } else {
    slot.innerHTML = '<div class="w-full border-t-2 border-dashed border-outline-variant"></div>';
  }
}

function renderStudyHistoryModal() {
  const record = getRecord(selectedDateKey);
  const recordSessions = record.studySessions.filter((entry) => entry.source === 'record');
  const manualSessions = record.studySessions.filter((entry) => entry.source === 'manual');

  const recordTotalEl = document.getElementById('study-history-record-total');
  const manualTotalEl = document.getElementById('study-history-manual-total');
  const recordListEl = document.getElementById('study-history-record-list');
  const manualListEl = document.getElementById('study-history-manual-list');
  if (!recordTotalEl || !manualTotalEl || !recordListEl || !manualListEl) return;

  const recordTotal = getStudySeconds(record, 'record');
  const manualTotal = getStudySeconds(record, 'manual');

  recordTotalEl.textContent = recordSessions.length ? formatMinutesSeconds(recordTotal) : '-';
  manualTotalEl.textContent = manualSessions.length ? formatMinutesSeconds(manualTotal) : '-';

  const rowHTML = (entry, i) => `
    <div class="glass-card rounded-xl px-4 py-2.5 text-sm flex items-center justify-between">
      <span class="text-on-surface-variant">${i + 1}회차</span>
      <span class="font-semibold">${formatMinutesSeconds(entry.seconds)}</span>
    </div>`;

  recordListEl.innerHTML = recordSessions.length
    ? recordSessions.map(rowHTML).join('')
    : '<p class="text-xs text-on-surface-variant">기록 없음</p>';

  manualListEl.innerHTML = manualSessions.length
    ? manualSessions.map(rowHTML).join('')
    : '<p class="text-xs text-on-surface-variant">기록 없음</p>';
}

function openStudyHistoryModal() {
  const modal = document.getElementById('study-history-modal');
  if (!modal) return;
  renderStudyHistoryModal();
  modal.classList.remove('hidden');
  modal.classList.add('flex');
}

function closeStudyHistoryModal() {
  const modal = document.getElementById('study-history-modal');
  if (!modal) return;
  modal.classList.add('hidden');
  modal.classList.remove('flex');
}

const WORSHIP_AUTO_MINUTES = 120; // O 또는 가정 선택 시 자동 2시간
const WORSHIP_ACTIVE_WEEKDAYS = [3, 5]; // 수(3), 금(5)

function isWorshipDayActive(key) {
  const [y, m, d] = key.split('-').map(Number);
  return WORSHIP_ACTIVE_WEEKDAYS.includes(new Date(y, m - 1, d).getDay());
}

function renderWorshipWidgetState() {
  const widget = document.getElementById('widget-worship');
  if (!widget) return;
  const active = isWorshipDayActive(selectedDateKey);
  widget.classList.toggle('opacity-40', !active);
  widget.classList.toggle('pointer-events-none', !active);
  widget.classList.toggle('cursor-pointer', active);
  widget.classList.toggle('hover:bg-white', active);
}

function renderWorshipWidgetSummary() {
  const slot = document.querySelector('#widget-worship .widget-summary');
  if (!slot) return;

  const record = getRecord(selectedDateKey);
  if (!record.worshipStatus) {
    slot.innerHTML = '<div class="w-full border-t-2 border-dashed border-outline-variant"></div>';
    return;
  }

  const statusLabel = { attended: 'O 참석', absent: 'X 미참석', home: '가정예배' }[record.worshipStatus] || '';
  if (record.worshipMinutes > 0) {
    slot.innerHTML = `
      <p class="text-3xl font-bold text-primary">${record.worshipMinutes}<span class="text-base font-semibold ml-0.5">분</span></p>
      <p class="text-xs text-on-surface-variant mt-2">${statusLabel}</p>
    `;
  } else {
    slot.innerHTML = `<p class="text-sm font-semibold text-on-surface-variant mt-10">${statusLabel}</p>`;
  }
}

// 기도 sums real logged time; 말씀 is a flat 60분 once verified; 공부 sums Record + manual entries;
// 예배 is a flat 120분 when O/가정 was chosen (수/금만 활성화).
function getCategoryMinutes(key) {
  const record = getRecord(selectedDateKey);
  if (key === 'pray') return record.prayerClasses.reduce((sum, entry) => sum + durationMinutes(entry.start, entry.end), 0);
  if (key === 'word') return record.progress.word ? WORD_VERIFIED_MINUTES : 0;
  if (key === 'study') return Math.round((getStudySeconds(record, 'record') + getStudySeconds(record, 'manual')) / 60);
  if (key === 'worship') return record.worshipMinutes || 0;
  return 0;
}

// Small dependency-free confetti burst, fired once the moment a day's goal is first reached.
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

function renderDailyGoals() {
  const ring = document.getElementById('daily-goal-ring');
  const percentEl = document.getElementById('daily-goal-percent');
  const captionEl = document.getElementById('daily-goal-caption');
  if (!ring || !percentEl || !captionEl) return;

  const totalMinutes = ['pray', 'word', 'study', 'worship'].reduce((sum, key) => sum + getCategoryMinutes(key), 0);
  const percent = Math.round((totalMinutes / DAILY_GOAL_MINUTES) * 100);
  const filledPercent = Math.min(percent, 100);

  const record = getRecord(selectedDateKey);
  if (percent >= 100 && !record.goalCelebrated) {
    launchConfetti();
    updateRecord(selectedDateKey, (r) => Object.assign(r, { goalCelebrated: true }));
  } else if (percent < 100 && record.goalCelebrated) {
    updateRecord(selectedDateKey, (r) => Object.assign(r, { goalCelebrated: false }));
  }

  const radius = 52;
  const circumference = 2 * Math.PI * radius;
  ring.setAttribute('stroke-dasharray', String(circumference));
  ring.setAttribute('stroke-dashoffset', String(circumference * (1 - filledPercent / 100)));

  percentEl.textContent = `${percent}%`;
  captionEl.textContent = percent > 100 ? '목표 초과 달성' : '달성';
}

function renderSelectedDateLabel() {
  const label = document.getElementById('selected-date-label');
  const resetBtn = document.getElementById('selected-date-reset');
  if (!label) return;

  const [y, m, d] = selectedDateKey.split('-').map(Number);
  label.textContent = `${y}년 ${m}월 ${d}일 기록`;
  if (resetBtn) resetBtn.classList.toggle('hidden', selectedDateKey === todayKey());
}

function calendarCellHTML(d, { isToday, isSelected }) {
  const filled = isSelected
    ? 'bg-gradient-to-br from-primary-container to-tertiary-container text-on-primary font-bold'
    : isToday
      ? 'ring-2 ring-primary text-on-surface font-semibold'
      : 'text-on-surface';
  return { filled };
}

function renderCalendarStrip() {
  const stripEl = document.getElementById('calendar-strip');
  const monthEl = document.getElementById('calendar-month');
  const dayEl = document.getElementById('calendar-day');
  if (!stripEl || !monthEl || !dayEl) return;

  const monthNames = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
  const dayNames = ['SUN', 'MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT'];
  const todayKeyValue = todayKey();
  const [sy, sm, sd] = selectedDateKey.split('-').map(Number);
  const selectedDate = new Date(sy, sm - 1, sd);

  monthEl.textContent = monthNames[selectedDate.getMonth()];
  dayEl.textContent = String(selectedDate.getDate());

  stripEl.innerHTML = '';
  for (let offset = -3; offset <= 3; offset += 1) {
    const d = new Date(selectedDate);
    d.setDate(selectedDate.getDate() + offset);
    const key = dateKey(d);
    const { filled } = calendarCellHTML(d, { isToday: key === todayKeyValue, isSelected: key === selectedDateKey });

    const cell = document.createElement('button');
    cell.type = 'button';
    cell.className = 'calendar-day-cell flex flex-col items-center gap-2';
    cell.dataset.dateKey = key;
    cell.innerHTML = `
      <span class="text-[10px] font-semibold ${key === todayKeyValue ? 'text-primary' : 'text-on-surface-variant'}">${dayNames[d.getDay()]}</span>
      <span class="w-9 h-9 flex items-center justify-center rounded-full text-sm ${filled}">${d.getDate()}</span>
    `;
    stripEl.appendChild(cell);
  }
}

function renderMonthlyCalendar() {
  const grid = document.getElementById('calendar-monthly-view');
  if (!grid) return;

  const dayNames = ['SUN', 'MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT'];
  const todayKeyValue = todayKey();
  const [sy, sm] = selectedDateKey.split('-').map(Number);
  const year = sy;
  const month = sm - 1;
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
    const d = new Date(year, month, date);
    const key = dateKey(d);
    const { filled } = calendarCellHTML(d, { isToday: key === todayKeyValue, isSelected: key === selectedDateKey });

    const cell = document.createElement('button');
    cell.type = 'button';
    cell.className = 'calendar-day-cell flex items-center justify-center py-1';
    cell.dataset.dateKey = key;
    cell.innerHTML = `<span class="w-8 h-8 flex items-center justify-center rounded-full text-sm ${filled}">${date}</span>`;
    grid.appendChild(cell);
  }
}

function renderAllForSelectedDate() {
  renderVerificationState();
  renderPrayWidgetSummary();
  renderWordWidgetSummary();
  renderStudyWidgetSummary();
  renderWorshipWidgetState();
  renderWorshipWidgetSummary();
  renderDailyGoals();
  renderSelectedDateLabel();
  renderCalendarStrip();
  renderMonthlyCalendar();
}

function selectDate(key) {
  selectedDateKey = key;
  renderAllForSelectedDate();
}

function wireCalendarSelection() {
  const weeklyView = document.getElementById('calendar-weekly-view');
  const monthlyView = document.getElementById('calendar-monthly-view');
  [weeklyView, monthlyView].forEach((container) => {
    if (!container) return;
    container.addEventListener('click', (e) => {
      const cell = e.target.closest('[data-date-key]');
      if (!cell) return;
      selectDate(cell.dataset.dateKey);
    });
  });
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

// Re-opening loads the selected date's previously saved classes so they can be edited.
// (사진은 브라우저에만 임시로 있던 미리보기라 저장되지 않으므로 다시 열면 비어 있습니다.)
function openPrayModal() {
  const modal = document.getElementById('pray-modal');
  const list = document.getElementById('pray-class-list');
  if (!modal || !list) return;
  list.innerHTML = '';

  const titleEl = modal.querySelector('h2');
  if (titleEl) titleEl.textContent = `기도 인증${formatSelectedDateShort()}`;

  const existing = getRecord(selectedDateKey).prayerClasses;
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

// Re-opening loads the selected date's saved verse ranges for editing. The required photo can't
// be restored (only an in-memory preview URL was ever kept), so it must be re-attached to save again.
function openWordModal() {
  const modal = document.getElementById('word-modal');
  const list = document.getElementById('word-verse-list');
  if (!modal || !list) return;
  list.innerHTML = '';

  const titleEl = modal.querySelector('h2');
  if (titleEl) titleEl.textContent = `말씀 인증${formatSelectedDateShort()}`;

  const existing = getRecord(selectedDateKey).wordVerses;
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

// --- 공부: Record 타이머 (포그라운드 전용) + 수동 분 입력 ---

let recordStartTime = null;
let recordIntervalId = null;

function formatElapsed(ms) {
  const totalSeconds = Math.max(0, Math.floor(ms / 1000));
  const mm = String(Math.floor(totalSeconds / 60)).padStart(2, '0');
  const ss = String(totalSeconds % 60).padStart(2, '0');
  return `${mm}:${ss}`;
}

function updateRecordTimerDisplay() {
  const el = document.getElementById('study-record-timer');
  if (!el || !recordStartTime) return;
  el.textContent = formatElapsed(Date.now() - recordStartTime);
}

function startRecording() {
  if (recordStartTime) return;
  recordStartTime = Date.now();

  const modal = document.getElementById('study-record-modal');
  if (modal) {
    modal.classList.remove('hidden');
    modal.classList.add('flex');
  }

  updateRecordTimerDisplay();
  recordIntervalId = setInterval(updateRecordTimerDisplay, 1000);
}

// Triggered by Pause, or automatically when the tab/window loses focus — either way the elapsed
// time is logged, since only the *continuation* while away is what must be prevented, not the
// honest time already spent.
function stopRecording() {
  if (!recordStartTime) return;

  const elapsedSeconds = Math.round((Date.now() - recordStartTime) / 1000);
  clearInterval(recordIntervalId);
  recordIntervalId = null;
  recordStartTime = null;

  const modal = document.getElementById('study-record-modal');
  if (modal) {
    modal.classList.add('hidden');
    modal.classList.remove('flex');
  }

  if (elapsedSeconds > 0) {
    updateRecord(selectedDateKey, (record) => {
      record.studySessions = [...record.studySessions, { source: 'record', seconds: elapsedSeconds }];
      record.progress.study = true;
      return record;
    });
  }

  renderVerificationState();
  renderStudyWidgetSummary();
  renderDailyGoals();
}

function openStudyAddModal() {
  const modal = document.getElementById('study-add-modal');
  const input = document.getElementById('study-add-minutes-input');
  if (!modal) return;
  if (input) input.value = '';
  modal.classList.remove('hidden');
  modal.classList.add('flex');
}

function closeStudyAddModal() {
  const modal = document.getElementById('study-add-modal');
  if (!modal) return;
  modal.classList.add('hidden');
  modal.classList.remove('flex');
}

function openWorshipModal() {
  if (!isWorshipDayActive(selectedDateKey)) return;
  const modal = document.getElementById('worship-modal');
  if (!modal) return;
  modal.classList.remove('hidden');
  modal.classList.add('flex');
}

function closeWorshipModal() {
  const modal = document.getElementById('worship-modal');
  if (!modal) return;
  modal.classList.add('hidden');
  modal.classList.remove('flex');
}

function recordWorship(status) {
  updateRecord(selectedDateKey, (record) => {
    record.worshipStatus = status;
    record.worshipMinutes = status === 'attended' || status === 'home' ? WORSHIP_AUTO_MINUTES : 0;
    record.progress.worship = status === 'attended' || status === 'home';
    return record;
  });

  renderVerificationState();
  renderWorshipWidgetSummary();
  renderDailyGoals();
  closeWorshipModal();
}

function initHomeWidgets() {
  renderAllForSelectedDate();
  wireCalendarTabs();
  wireCalendarSelection();
  wireWordPhotoPreview();

  const dateResetBtn = document.getElementById('selected-date-reset');
  if (dateResetBtn) dateResetBtn.addEventListener('click', () => selectDate(todayKey()));

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
  if (addBtn) addBtn.addEventListener('click', () => addPrayClassEntry());

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

      updateRecord(selectedDateKey, (record) => {
        record.prayerClasses = entries;
        record.progress.pray = true;
        return record;
      });

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

      updateRecord(selectedDateKey, (record) => {
        record.wordVerses = entries;
        record.progress.word = true;
        return record;
      });

      renderVerificationState();
      renderWordWidgetSummary();
      renderDailyGoals();
      closeWordModal();
    });
  }

  const studyWidget = document.getElementById('widget-study');
  if (studyWidget) studyWidget.addEventListener('click', openStudyHistoryModal);

  const studyHistoryCloseBtn = document.getElementById('study-history-close');
  const studyHistoryOverlay = document.getElementById('study-history-overlay');
  if (studyHistoryCloseBtn) studyHistoryCloseBtn.addEventListener('click', closeStudyHistoryModal);
  if (studyHistoryOverlay) studyHistoryOverlay.addEventListener('click', closeStudyHistoryModal);

  const recordBtn = document.getElementById('study-record-btn');
  if (recordBtn) recordBtn.addEventListener('click', (e) => { e.stopPropagation(); startRecording(); });

  const pauseBtn = document.getElementById('study-pause-btn');
  if (pauseBtn) pauseBtn.addEventListener('click', stopRecording);

  document.addEventListener('visibilitychange', () => {
    if (document.hidden) stopRecording();
  });
  window.addEventListener('blur', stopRecording);

  const studyAddBtn = document.getElementById('study-add-btn');
  if (studyAddBtn) studyAddBtn.addEventListener('click', (e) => { e.stopPropagation(); openStudyAddModal(); });

  const studyAddCloseBtn = document.getElementById('study-add-modal-close');
  const studyAddOverlay = document.getElementById('study-add-overlay');
  const studyAddCancelBtn = document.getElementById('study-add-cancel');
  const studyAddSaveBtn = document.getElementById('study-add-save');

  if (studyAddCloseBtn) studyAddCloseBtn.addEventListener('click', closeStudyAddModal);
  if (studyAddOverlay) studyAddOverlay.addEventListener('click', closeStudyAddModal);
  if (studyAddCancelBtn) studyAddCancelBtn.addEventListener('click', closeStudyAddModal);

  if (studyAddSaveBtn) {
    studyAddSaveBtn.addEventListener('click', () => {
      const input = document.getElementById('study-add-minutes-input');
      const minutes = input ? parseInt(input.value, 10) : NaN;
      if (!Number.isInteger(minutes) || minutes <= 0) return;

      updateRecord(selectedDateKey, (record) => {
        record.studySessions = [...record.studySessions, { source: 'manual', seconds: minutes * 60 }];
        record.progress.study = true;
        return record;
      });

      renderVerificationState();
      renderStudyWidgetSummary();
      renderDailyGoals();
      closeStudyAddModal();
    });
  }

  const worshipWidget = document.getElementById('widget-worship');
  if (worshipWidget) worshipWidget.addEventListener('click', openWorshipModal);

  const worshipCloseBtn = document.getElementById('worship-modal-close');
  const worshipOverlay = document.getElementById('worship-modal-overlay');
  if (worshipCloseBtn) worshipCloseBtn.addEventListener('click', closeWorshipModal);
  if (worshipOverlay) worshipOverlay.addEventListener('click', closeWorshipModal);

  const worshipOBtn = document.getElementById('worship-o-btn');
  const worshipXBtn = document.getElementById('worship-x-btn');
  const worshipHomeBtn = document.getElementById('worship-home-btn');
  if (worshipOBtn) worshipOBtn.addEventListener('click', () => recordWorship('attended'));
  if (worshipXBtn) worshipXBtn.addEventListener('click', () => recordWorship('absent'));
  if (worshipHomeBtn) worshipHomeBtn.addEventListener('click', () => recordWorship('home'));
}

window.initHomeWidgets = initHomeWidgets;
