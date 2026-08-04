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
    worshipMinutes: 0
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
    worshipMinutes: typeof stored.worshipMinutes === 'number' ? stored.worshipMinutes : base.worshipMinutes
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

function formatFullDateKorean(key) {
  const [y, m, d] = key.split('-').map(Number);
  return `${y}년 ${m}월 ${d}일`;
}

// 활성화된(예배는 수/금만 해당) 카테고리 4개(또는 3개)가 모두 인증됐는지 판단할 때 쓰는 목록.
function getActiveCategoriesForDate(key) {
  const categories = ['pray', 'word', 'study'];
  if (isWorshipDayActive(key)) categories.push('worship');
  return categories;
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

function formatFullTimestamp(ms) {
  const d = new Date(ms);
  const m = String(d.getMonth() + 1).padStart(2, '0');
  const day = String(d.getDate()).padStart(2, '0');
  const hh = String(d.getHours()).padStart(2, '0');
  const mm = String(d.getMinutes()).padStart(2, '0');
  const ss = String(d.getSeconds()).padStart(2, '0');
  return `${d.getFullYear()}.${m}.${day} ${hh}:${mm}:${ss}`;
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
  // keep each entry's original index in record.studySessions so deletes target the right one
  const indexed = record.studySessions.map((entry, index) => ({ ...entry, index }));
  const recordSessions = indexed.filter((entry) => entry.source === 'record');
  const manualSessions = indexed.filter((entry) => entry.source === 'manual');

  const recordTotalEl = document.getElementById('study-history-record-total');
  const manualTotalEl = document.getElementById('study-history-manual-total');
  const recordListEl = document.getElementById('study-history-record-list');
  const manualListEl = document.getElementById('study-history-manual-list');
  if (!recordTotalEl || !manualTotalEl || !recordListEl || !manualListEl) return;

  recordTotalEl.textContent = recordSessions.length ? formatMinutesSeconds(getStudySeconds(record, 'record')) : '-';
  manualTotalEl.textContent = manualSessions.length ? formatMinutesSeconds(getStudySeconds(record, 'manual')) : '-';

  const rowHTML = (entry, i) => {
    const hasTimestamps = entry.source === 'record' && entry.startedAt && entry.endedAt;
    const timestampCaption = hasTimestamps
      ? `<p class="study-session-timestamp hidden text-[11px] text-on-surface-variant mt-2 pt-2 border-t border-outline-variant">${formatFullTimestamp(entry.startedAt)} ~ ${formatFullTimestamp(entry.endedAt)}</p>`
      : '';
    return `
    <div class="glass-card rounded-xl px-4 py-2.5 text-sm ${hasTimestamps ? 'study-session-row cursor-pointer' : ''}" data-index="${entry.index}">
      <div class="flex items-center justify-between">
        <span class="text-on-surface-variant">${i + 1}회차</span>
        <span class="flex items-center gap-3">
          <span class="font-semibold">${formatMinutesSeconds(entry.seconds)}</span>
          <button type="button" class="study-session-remove text-on-surface-variant hover:text-error" data-index="${entry.index}" aria-label="삭제">
            <i class="fa-solid fa-xmark text-xs"></i>
          </button>
        </span>
      </div>
      ${timestampCaption}
    </div>`;
  };

  recordListEl.innerHTML = recordSessions.length
    ? recordSessions.map(rowHTML).join('')
    : '<p class="text-xs text-on-surface-variant">기록 없음</p>';

  manualListEl.innerHTML = manualSessions.length
    ? manualSessions.map(rowHTML).join('')
    : '<p class="text-xs text-on-surface-variant">기록 없음</p>';
}

function removeStudySession(index) {
  const target = getRecord(selectedDateKey).studySessions[index];
  if (target && target.source === 'record' && !confirm('Record로 기록한 시간을 삭제할까요?')) return;

  updateRecord(selectedDateKey, (record) => {
    record.studySessions = record.studySessions.filter((_, i) => i !== index);
    record.progress.study = record.studySessions.length > 0;
    return record;
  });
  renderVerificationState();
  renderStudyWidgetSummary();
  renderDailyGoals();
  renderStudyHistoryModal();
}

function resetStudyRecord() {
  if (!confirm('공부 기록을 전체 초기화할까요?')) return;
  updateRecord(selectedDateKey, (record) => {
    record.studySessions = [];
    record.progress.study = false;
    return record;
  });
  renderVerificationState();
  renderStudyWidgetSummary();
  renderDailyGoals();
  renderStudyHistoryModal();
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

// 작은 confetti (모든 카테고리 인증 완료): 화면 위에서 랜덤하게 떨어지는 기존 방식.
const SMALL_CONFETTI_COLORS = ['#ff4b91', '#ee6650', '#cca9fe', '#b9045e', '#6e4f9c'];

function launchSmallConfetti() {
  const container = document.createElement('div');
  container.className = 'confetti-container';

  for (let i = 0; i < 45; i += 1) {
    const piece = document.createElement('div');
    const size = 5 + Math.random() * 4;
    const duration = 1.6 + Math.random() * 0.7;

    piece.className = 'confetti-piece';
    piece.style.left = `${Math.random() * 100}vw`;
    piece.style.width = `${size}px`;
    piece.style.height = `${size * 0.4}px`;
    piece.style.background = SMALL_CONFETTI_COLORS[Math.floor(Math.random() * SMALL_CONFETTI_COLORS.length)];
    piece.style.transform = `rotate(${Math.random() * 360}deg)`;
    piece.style.setProperty('--drift', `${(Math.random() - 0.5) * 140}px`);
    piece.style.animation = `confetti-fall ${duration}s ease-in ${Math.random() * 0.4}s forwards`;

    container.appendChild(piece);
  }

  document.body.appendChild(container);
  setTimeout(() => container.remove(), 2500);
}

// 큰 confetti (300분 목표 달성): 코너에서 터지는 3연발. 좌하단 -> 우하단 -> 상단 순서로 빠르게.
const BIG_CONFETTI_COLORS = ['#ff4b91', '#ee6650', '#cca9fe', '#b9045e', '#6e4f9c', '#ffd23f', '#4ecdc4', '#ff9f1c', '#2ec4b6', '#f72585', '#7bdff2'];

const BIG_CONFETTI_ORIGINS = [
  { left: '0', bottom: '0', txRange: [15, 45], tyRange: [-70, -30] }, // 좌측 하단 -> 우상 방향으로 발사
  { right: '0', bottom: '0', txRange: [-45, -15], tyRange: [-70, -30] }, // 우측 하단 -> 좌상 방향으로 발사
  { left: '50%', top: '0', txRange: [-40, 40], tyRange: [30, 70] } // 상단 -> 아래로 퍼지며 발사
];

function launchConfettiBurst(origin) {
  const container = document.createElement('div');
  container.className = 'confetti-container';

  for (let i = 0; i < 540; i += 1) {
    const piece = document.createElement('div');
    const size = 6 + Math.random() * 8;
    const duration = 1.5 + Math.random() * 0.8;
    const tx = origin.txRange[0] + Math.random() * (origin.txRange[1] - origin.txRange[0]);
    const ty = origin.tyRange[0] + Math.random() * (origin.tyRange[1] - origin.tyRange[0]);

    piece.className = 'confetti-burst-piece';
    if (origin.left) piece.style.left = origin.left;
    if (origin.right) piece.style.right = origin.right;
    if (origin.top) piece.style.top = origin.top;
    if (origin.bottom) piece.style.bottom = origin.bottom;
    piece.style.width = `${size}px`;
    piece.style.height = `${size * 0.4}px`;
    piece.style.background = BIG_CONFETTI_COLORS[Math.floor(Math.random() * BIG_CONFETTI_COLORS.length)];
    piece.style.setProperty('--tx', `${tx}vw`);
    piece.style.setProperty('--ty', `${ty}vh`);
    piece.style.setProperty('--rot', `${360 + Math.random() * 360}deg`);
    piece.style.animation = `confetti-burst ${duration}s cubic-bezier(0.2, 0.8, 0.3, 1) ${Math.random() * 0.1}s forwards`;

    container.appendChild(piece);
  }

  document.body.appendChild(container);
  setTimeout(() => container.remove(), 2600);
}

function launchBigConfetti() {
  launchConfettiBurst(BIG_CONFETTI_ORIGINS[0]);
  setTimeout(() => launchConfettiBurst(BIG_CONFETTI_ORIGINS[1]), 180);
  setTimeout(() => launchConfettiBurst(BIG_CONFETTI_ORIGINS[2]), 360);
}

// 인증하기의 활성 카테고리(예배는 수/금만)가 모두 완료되어 있으면 작은 confetti.
// 300분 목표 달성(checkGoalCelebration)의 큰 confetti와 차등을 둠.
// 둘 다 개별 modal 저장이 아니라 "저장하기" 버튼을 눌러야만 확인/발사되고,
// 조건을 만족하는 한 저장할 때마다 매번 터진다 (하루에 한 번만 터지도록 막지 않음).
function checkAllCategoriesCelebration() {
  const record = getRecord(selectedDateKey);
  const categories = getActiveCategoriesForDate(selectedDateKey);
  const allDone = categories.every((key) => record.progress[key]);

  if (allDone) launchSmallConfetti();
}

function checkGoalCelebration() {
  const totalMinutes = ['pray', 'word', 'study', 'worship'].reduce((sum, key) => sum + getCategoryMinutes(key), 0);
  const percent = Math.round((totalMinutes / DAILY_GOAL_MINUTES) * 100);

  if (percent >= 100) launchBigConfetti();
}

function renderDailyGoals() {
  const ring = document.getElementById('daily-goal-ring');
  const percentEl = document.getElementById('daily-goal-percent');
  const captionEl = document.getElementById('daily-goal-caption');
  const totalEl = document.getElementById('daily-goal-total');
  if (!ring || !percentEl || !captionEl) return;

  const totalMinutes = ['pray', 'word', 'study', 'worship'].reduce((sum, key) => sum + getCategoryMinutes(key), 0);
  const percent = Math.round((totalMinutes / DAILY_GOAL_MINUTES) * 100);
  const filledPercent = Math.min(percent, 100);

  const radius = 52;
  const circumference = 2 * Math.PI * radius;
  ring.setAttribute('stroke-dasharray', String(circumference));
  ring.setAttribute('stroke-dashoffset', String(circumference * (1 - filledPercent / 100)));
  ring.setAttribute('stroke', percent >= 50 ? 'url(#daily-goal-gradient-high)' : 'url(#daily-goal-gradient-low)');

  percentEl.textContent = `${percent}%`;
  captionEl.textContent = percent > 100 ? '목표 초과 달성' : '달성';
  if (totalEl) totalEl.textContent = `${totalMinutes}분 / ${DAILY_GOAL_MINUTES}분`;
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

// 저장된 기록을 열었을 때 "YYYY년 M월 D일 HH:MM부터 HH:MM까지" 형태로 정확히 보여주는 캡션.
function updatePrayEntryDateTimeLabel(entryEl) {
  const label = entryEl.querySelector('.pray-entry-datetime');
  if (!label) return;
  const start = entryEl.querySelector('.pray-start-input').value;
  const end = entryEl.querySelector('.pray-end-input').value;
  label.textContent = start && end
    ? `${formatFullDateKorean(selectedDateKey)} ${start}부터 ${end}까지`
    : '';
}

const PRAY_FIXED_LOCATIONS = ['대성전', '요한성전', '중등부기도', '가정'];

function addPrayClassEntry(data) {
  const template = document.getElementById('pray-class-template');
  const list = document.getElementById('pray-class-list');
  if (!template || !list) return;

  list.appendChild(template.content.cloneNode(true));
  const entryEl = list.lastElementChild;
  wirePhotoPreview(entryEl);

  const locationSelect = entryEl.querySelector('.pray-location-input');
  const locationOtherInput = entryEl.querySelector('.pray-location-other-input');
  locationSelect.addEventListener('change', () => {
    locationOtherInput.classList.toggle('hidden', locationSelect.value !== '기타');
  });

  if (data) {
    if (data.location) {
      if (PRAY_FIXED_LOCATIONS.includes(data.location)) {
        locationSelect.value = data.location;
      } else {
        locationSelect.value = '기타';
        locationOtherInput.value = data.location;
        locationOtherInput.classList.remove('hidden');
      }
    }
    if (data.start) entryEl.querySelector('.pray-start-input').value = data.start;
    if (data.end) entryEl.querySelector('.pray-end-input').value = data.end;
  }

  updatePrayEntryDateTimeLabel(entryEl);
  entryEl.querySelector('.pray-start-input').addEventListener('input', () => updatePrayEntryDateTimeLabel(entryEl));
  entryEl.querySelector('.pray-end-input').addEventListener('input', () => updatePrayEntryDateTimeLabel(entryEl));

  updatePrayRemoveButtons();
}

function resetPrayerRecord() {
  if (!confirm('기도 기록을 전체 초기화할까요?')) return;
  updateRecord(selectedDateKey, (record) => {
    record.prayerClasses = [];
    record.progress.pray = false;
    return record;
  });
  renderVerificationState();
  renderPrayWidgetSummary();
  renderDailyGoals();
  closePrayModal();
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

  const hint = document.getElementById('pray-class-hint');
  if (hint) hint.classList.add('hidden');

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
  const verseHint = document.getElementById('word-verse-hint');
  if (photoInput) photoInput.value = '';
  if (photoWrap) photoWrap.classList.add('hidden');
  if (photoHint) photoHint.classList.add('hidden');
  if (verseHint) verseHint.classList.add('hidden');

  modal.classList.remove('hidden');
  modal.classList.add('flex');
}

function closeWordModal() {
  const modal = document.getElementById('word-modal');
  if (!modal) return;
  modal.classList.add('hidden');
  modal.classList.remove('flex');
}

function resetWordRecord() {
  if (!confirm('말씀 기록을 전체 초기화할까요?')) return;
  updateRecord(selectedDateKey, (record) => {
    record.wordVerses = [];
    record.progress.word = false;
    return record;
  });
  renderVerificationState();
  renderWordWidgetSummary();
  renderDailyGoals();
  closeWordModal();
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

  const startedAt = recordStartTime;
  const endedAt = Date.now();
  // Match the whole-second timestamps shown in the history list (no ms), so the
  // displayed duration always equals endedAt's second minus startedAt's second.
  const elapsedSeconds = Math.floor(endedAt / 1000) - Math.floor(startedAt / 1000);
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
      record.studySessions = [...record.studySessions, { source: 'record', seconds: elapsedSeconds, startedAt, endedAt }];
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

function resetWorship() {
  updateRecord(selectedDateKey, (record) => {
    record.worshipStatus = null;
    record.worshipMinutes = 0;
    record.progress.worship = false;
    return record;
  });
  renderVerificationState();
  renderWorshipWidgetSummary();
  renderDailyGoals();
  closeWorshipModal();
}

// 각 modal의 개별 저장은 이미 즉시 반영되지만, 페이지 하단 "저장하기"로 한 번 더
// 명확한 확인 피드백을 준다 (별도 데이터 변경 없음).
function showSaveToast() {
  const existing = document.getElementById('save-toast');
  if (existing) existing.remove();

  const toast = document.createElement('div');
  toast.id = 'save-toast';
  toast.className = 'fixed bottom-6 left-1/2 -translate-x-1/2 z-[80] glass-card rounded-full px-5 py-2.5 text-sm font-medium text-on-surface';
  toast.textContent = '저장되었습니다';
  document.body.appendChild(toast);
  setTimeout(() => toast.remove(), 2000);
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
  const resetBtn = document.getElementById('pray-reset');
  const list = document.getElementById('pray-class-list');

  if (closeBtn) closeBtn.addEventListener('click', closePrayModal);
  if (overlay) overlay.addEventListener('click', closePrayModal);
  if (cancelBtn) cancelBtn.addEventListener('click', closePrayModal);
  if (addBtn) addBtn.addEventListener('click', () => addPrayClassEntry());
  if (resetBtn) resetBtn.addEventListener('click', resetPrayerRecord);

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
      const entryEls = [...document.querySelectorAll('#pray-class-list .pray-class-entry')];
      const entries = entryEls.map((entry) => {
        const locationSelect = entry.querySelector('.pray-location-input');
        const location = locationSelect.value === '기타'
          ? entry.querySelector('.pray-location-other-input').value.trim()
          : locationSelect.value;
        return {
          hasPhoto: entry.querySelector('.pray-photo-input').files.length > 0,
          location,
          start: entry.querySelector('.pray-start-input').value,
          end: entry.querySelector('.pray-end-input').value
        };
      });

      const prayClassHint = document.getElementById('pray-class-hint');
      const hasIncompleteEntry = entries.some((entry) => !entry.hasPhoto || !entry.location || !entry.start || !entry.end);
      if (hasIncompleteEntry) {
        if (prayClassHint) prayClassHint.classList.remove('hidden');
        return;
      }
      if (prayClassHint) prayClassHint.classList.add('hidden');

      updateRecord(selectedDateKey, (record) => {
        record.prayerClasses = entries.map(({ location, start, end }) => ({ location, start, end }));
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
  const wordResetBtn = document.getElementById('word-reset');
  const wordList = document.getElementById('word-verse-list');

  if (wordCloseBtn) wordCloseBtn.addEventListener('click', closeWordModal);
  if (wordOverlay) wordOverlay.addEventListener('click', closeWordModal);
  if (wordCancelBtn) wordCancelBtn.addEventListener('click', closeWordModal);
  if (wordAddBtn) wordAddBtn.addEventListener('click', () => addWordVerseEntry());
  if (wordResetBtn) wordResetBtn.addEventListener('click', resetWordRecord);

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

      const wordVerseHint = document.getElementById('word-verse-hint');
      const entries = [...document.querySelectorAll('#word-verse-list .word-verse-entry')].map((entry) => ({
        startBook: entry.querySelector('.word-start-book').value,
        startChapter: entry.querySelector('.word-start-chapter').value,
        startVerse: entry.querySelector('.word-start-verse').value,
        endBook: entry.querySelector('.word-end-book').value,
        endChapter: entry.querySelector('.word-end-chapter').value,
        endVerse: entry.querySelector('.word-end-verse').value
      }));

      const hasIncompleteEntry = entries.some((entry) => Object.values(entry).some((value) => !value));
      if (hasIncompleteEntry) {
        if (wordVerseHint) wordVerseHint.classList.remove('hidden');
        return;
      }
      if (wordVerseHint) wordVerseHint.classList.add('hidden');

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
  const studyHistoryResetBtn = document.getElementById('study-history-reset');
  if (studyHistoryCloseBtn) studyHistoryCloseBtn.addEventListener('click', closeStudyHistoryModal);
  if (studyHistoryOverlay) studyHistoryOverlay.addEventListener('click', closeStudyHistoryModal);
  if (studyHistoryResetBtn) studyHistoryResetBtn.addEventListener('click', resetStudyRecord);

  const studyHistoryModal = document.getElementById('study-history-modal');
  if (studyHistoryModal) {
    studyHistoryModal.addEventListener('click', (e) => {
      const removeBtn = e.target.closest('.study-session-remove');
      if (removeBtn) {
        removeStudySession(Number(removeBtn.dataset.index));
        return;
      }
      const row = e.target.closest('.study-session-row');
      if (row) {
        const timestamp = row.querySelector('.study-session-timestamp');
        if (timestamp) timestamp.classList.toggle('hidden');
      }
    });
  }

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
  const worshipResetBtn = document.getElementById('worship-reset');
  if (worshipOBtn) worshipOBtn.addEventListener('click', () => recordWorship('attended'));
  if (worshipXBtn) worshipXBtn.addEventListener('click', () => recordWorship('absent'));
  if (worshipHomeBtn) worshipHomeBtn.addEventListener('click', () => recordWorship('home'));
  if (worshipResetBtn) worshipResetBtn.addEventListener('click', resetWorship);

  const verificationSaveBtn = document.getElementById('verification-save-btn');
  if (verificationSaveBtn) {
    verificationSaveBtn.addEventListener('click', () => {
      showSaveToast();
      checkAllCategoriesCelebration();
      checkGoalCelebration();
    });
  }
}

window.initHomeWidgets = initHomeWidgets;
