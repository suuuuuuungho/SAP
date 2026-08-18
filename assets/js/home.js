// Home page only: date-scoped daily records, Progress checkmarks, widget verification rings,
// the Daily Goals ring, the calendar date picker, and the 공부/예배 modals.
// 기도/말씀은 assets/js/pray-word.js가, 공부/예배는 이 파일이 각각 Supabase에 저장/조회한다.
// (기도/말씀만 Gallery와 공유되고, 공부/예배는 본인만 볼 수 있는 데이터라 별도 테이블.)

const DAILY_GOAL_MINUTES = 300;
const WORD_VERIFIED_MINUTES = 60; // 말씀 has no natural duration input, so a verified 말씀 is a flat 60분.
const VERIFICATION_PERIOD_START = '2026-08-10';
const VERIFICATION_PERIOD_END = '2026-09-06';

let selectedDateKey = todayKey();
let galleryReturnType = null;

async function fetchStudyRecord(userId, dateKey) {
  const { data, error } = await window.supabaseClient
    .from('study_records').select('*').eq('user_id', userId).eq('record_date', dateKey).maybeSingle();
  if (error) { console.error('[home] fetchStudyRecord', error); return null; }
  return data;
}

async function fetchWorshipRecord(userId, dateKey) {
  const { data, error } = await window.supabaseClient
    .from('worship_records').select('*').eq('user_id', userId).eq('record_date', dateKey).maybeSingle();
  if (error) { console.error('[home] fetchWorshipRecord', error); return null; }
  return data;
}

async function saveStudySessions(userId, dateKey, sessions) {
  const { error } = await window.supabaseClient.from('study_records').upsert(
    { user_id: userId, record_date: dateKey, sessions, updated_at: new Date().toISOString() },
    { onConflict: 'user_id,record_date' }
  );
  if (error) throw error;
}

async function deleteStudyRecord(userId, dateKey) {
  const { error } = await window.supabaseClient.from('study_records').delete().eq('user_id', userId).eq('record_date', dateKey);
  if (error) throw error;
}

async function saveWorshipRecord(userId, dateKey, status, minutes) {
  const { error } = await window.supabaseClient.from('worship_records').upsert(
    { user_id: userId, record_date: dateKey, status, minutes, updated_at: new Date().toISOString() },
    { onConflict: 'user_id,record_date' }
  );
  if (error) throw error;
}

async function deleteWorshipRecord(userId, dateKey) {
  const { error } = await window.supabaseClient.from('worship_records').delete().eq('user_id', userId).eq('record_date', dateKey);
  if (error) throw error;
}

// 4개 카테고리(기도/말씀/공부/예배) 전부 이 캐시 하나에 모인다 (dateKey -> 상태).
// 기도/말씀은 pray-word.js의 fetchPrayWordStatus, 공부/예배는 이 파일의 fetchStudyWorshipStatus가 채운다.
let dailyStatus = {};

async function fetchStudyWorshipStatus(userId, dateKey) {
  const [studyRow, worshipRow] = await Promise.all([fetchStudyRecord(userId, dateKey), fetchWorshipRecord(userId, dateKey)]);
  const sessions = studyRow ? studyRow.sessions : [];
  const worshipAttended = worshipRow && (worshipRow.status === 'attended' || worshipRow.status === 'home');
  return {
    study: { sessions, verified: sessions.length > 0 },
    worship: { status: worshipRow ? worshipRow.status : null, minutes: worshipRow ? worshipRow.minutes : 0, verified: !!worshipAttended }
  };
}

async function refreshDailyStatus(key) {
  const userId = await getCurrentUserId();
  const [prayWord, studyWorship] = await Promise.all([
    fetchPrayWordStatus(userId, key),
    fetchStudyWorshipStatus(userId, key)
  ]);
  dailyStatus[key] = Object.assign({}, prayWord, studyWorship);
}

function getDailyStatus(key) {
  return dailyStatus[key] || {
    pray: { entries: [], verified: false },
    word: { verses: [], verified: false },
    study: { sessions: [], verified: false },
    worship: { status: null, minutes: 0, verified: false }
  };
}

// 인증 체크마크/셀레브레이션이 보는 통합 progress (4개 카테고리 전부 캐시에서 옴).
function getMergedProgress(key) {
  const s = getDailyStatus(key);
  return { pray: s.pray.verified, word: s.word.verified, study: s.study.verified, worship: s.worship.verified };
}

// 활성화된(예배는 수/금만 해당) 카테고리 4개(또는 3개)가 모두 인증됐는지 판단할 때 쓰는 목록.
function getActiveCategoriesForDate(key) {
  const categories = ['pray', 'word', 'study'];
  if (isWorshipDayActive(key)) categories.push('worship');
  return categories;
}

function getVerificationPeriodDays() {
  const days = [];
  const cursor = new Date(`${VERIFICATION_PERIOD_START}T12:00:00`);
  const end = new Date(`${VERIFICATION_PERIOD_END}T12:00:00`);
  while (cursor <= end) {
    if (cursor.getDay() >= 1 && cursor.getDay() <= 5) days.push(dateKey(cursor));
    cursor.setDate(cursor.getDate() + 1);
  }
  return days;
}

async function loadVerificationPeriodStatus() {
  const userId = await getCurrentUserId();
  const days = getVerificationPeriodDays();
  const [prayResult, wordResult, studyResult, worshipResult] = await Promise.all([
    window.supabaseClient.from('pray_records').select('record_date,entries').eq('user_id', userId).in('record_date', days),
    window.supabaseClient.from('word_records').select('record_date,verses,photo_path,photo_unavailable').eq('user_id', userId).in('record_date', days),
    window.supabaseClient.from('study_records').select('record_date,sessions').eq('user_id', userId).in('record_date', days),
    window.supabaseClient.from('worship_records').select('record_date,status,minutes').eq('user_id', userId).in('record_date', days)
  ]);
  const failed = [prayResult, wordResult, studyResult, worshipResult].find((result) => result.error);
  if (failed) {
    console.error('[home] loadVerificationPeriodStatus', failed.error);
    await refreshDailyStatus(selectedDateKey);
    return;
  }
  const prayMap = Object.fromEntries((prayResult.data || []).map((row) => [row.record_date, row]));
  const wordMap = Object.fromEntries((wordResult.data || []).map((row) => [row.record_date, row]));
  const studyMap = Object.fromEntries((studyResult.data || []).map((row) => [row.record_date, row]));
  const worshipMap = Object.fromEntries((worshipResult.data || []).map((row) => [row.record_date, row]));
  days.forEach((key) => {
    const pray = prayMap[key];
    const word = wordMap[key];
    const study = studyMap[key];
    const worship = worshipMap[key];
    const entries = Array.isArray(pray?.entries) ? pray.entries : [];
    const verses = Array.isArray(word?.verses) ? word.verses : [];
    const sessions = Array.isArray(study?.sessions) ? study.sessions : [];
    dailyStatus[key] = {
      pray: { entries, verified: entries.length > 0 },
      word: { verses, photoPath: word?.photo_path || null, photoUnavailable: !!word?.photo_unavailable, verified: verses.length > 0 },
      study: { sessions, verified: sessions.length > 0 },
      worship: { status: worship?.status || null, minutes: worship?.minutes || 0, verified: worship?.status === 'attended' || worship?.status === 'home' }
    };
  });
  if (!days.includes(selectedDateKey)) await refreshDailyStatus(selectedDateKey);
}

function legacyVerificationOverviewCellHTML(key, category) {
  if (category === 'worship' && !isWorshipDayActive(key)) {
    return '<span class="inline-flex items-center justify-center w-full min-h-9 rounded-xl bg-surface-low text-[11px] font-semibold text-outline">해당 없음</span>';
  }
  const verified = !!getMergedProgress(key)[category];
  const label = { pray: '기도', word: '말씀', study: '공부', worship: '예배' }[category];
  return `<button type="button" data-overview-date="${key}" data-overview-category="${category}" class="w-full min-h-9 rounded-xl px-2 text-xs font-bold transition-all ${verified ? 'bg-quaternary/10 text-quaternary hover:bg-quaternary/20' : 'bg-error/10 text-error hover:bg-error hover:text-white'}" aria-label="${key} ${label} ${verified ? '인증 완료' : '미인증, 인증하기'}">
    <i class="fa-solid ${verified ? 'fa-check' : 'fa-plus'} mr-1" aria-hidden="true"></i>${verified ? '완료' : '미인증'}
  </button>`;
}

function legacyRenderVerificationOverview() {
  const wrap = document.getElementById('verification-overview');
  const summary = document.getElementById('verification-overview-summary');
  if (!wrap) return;
  const days = getVerificationPeriodDays();
  const weekday = ['일', '월', '화', '수', '목', '금', '토'];
  const completedDays = days.filter((key) => getActiveCategoriesForDate(key).every((category) => getMergedProgress(key)[category])).length;
  if (summary) summary.textContent = `${completedDays} / ${days.length}일 완료`;
  wrap.innerHTML = `<div class="grid grid-cols-[110px_repeat(4,minmax(105px,1fr))] gap-2 items-center">
    <span class="text-[11px] font-bold text-on-surface-variant px-2">날짜</span>
    ${['기도', '말씀', '공부', '예배'].map((label) => `<span class="text-[11px] font-bold text-center text-on-surface-variant">${label}</span>`).join('')}
    ${days.map((key) => {
      const date = new Date(`${key}T12:00:00`);
      const selected = key === selectedDateKey;
      return `<button type="button" data-overview-select-date="${key}" class="text-left rounded-xl px-2 py-2 transition-colors ${selected ? 'bg-primary/10 text-primary' : 'hover:bg-surface-low'}"><span class="block text-xs font-bold">${date.getMonth() + 1}.${String(date.getDate()).padStart(2, '0')}</span><span class="text-[10px] text-on-surface-variant">${weekday[date.getDay()]}요일</span></button>
        ${['pray', 'word', 'study', 'worship'].map((category) => verificationOverviewCellHTML(key, category)).join('')}`;
    }).join('')}
  </div>`;
}

// 인증 현황 표의 최종 렌더러. 완료 셀은 상태만 표시하고 미인증 셀만 인증 버튼으로 동작한다.
function legacyVerificationOverviewCellHTMLV2(key, category) {
  if (category === 'worship' && !isWorshipDayActive(key)) {
    return '<span class="inline-flex items-center justify-center w-full min-h-9 rounded-xl bg-surface-low text-[11px] font-semibold text-outline">해당 없음</span>';
  }
  const verified = !!getMergedProgress(key)[category];
  const label = { pray: '기도', word: '말씀', study: '공부', worship: '예배' }[category];
  if (verified) {
    return `<span class="inline-flex items-center justify-center w-full min-h-9 rounded-xl px-2 text-xs font-bold bg-quaternary/10 text-quaternary" aria-label="${key} ${label} 인증 완료"><i class="fa-solid fa-check mr-1" aria-hidden="true"></i>완료</span>`;
  }
  return `<button type="button" data-overview-date="${key}" data-overview-category="${category}" class="w-full min-h-9 rounded-xl px-2 text-xs font-bold transition-all bg-error/10 text-error hover:bg-error hover:text-white" aria-label="${key} ${label} 미인증, 인증하기"><i class="fa-solid fa-plus mr-1" aria-hidden="true"></i>미인증</button>`;
}

function legacyRenderVerificationOverviewV2() {
  const wrap = document.getElementById('verification-overview');
  const summary = document.getElementById('verification-overview-summary');
  if (!wrap) return;
  const section = wrap.closest('section');
  const heading = section?.querySelector('h2');
  const description = heading?.nextElementSibling;
  if (heading) heading.textContent = '인증 현황';
  if (description) description.textContent = '미인증 항목을 누르면 해당 날짜의 인증 화면이 바로 열립니다.';
  const days = getVerificationPeriodDays();
  const weekday = ['일', '월', '화', '수', '목', '금', '토'];
  const completedDays = days.filter((key) => getActiveCategoriesForDate(key).every((category) => getMergedProgress(key)[category])).length;
  if (summary) summary.textContent = `${completedDays} / ${days.length}일 완료`;
  wrap.innerHTML = `<div class="grid grid-cols-[110px_repeat(4,minmax(105px,1fr))] gap-2 items-center">
    <span class="text-[11px] font-bold text-on-surface-variant px-2">날짜</span>
    ${['기도', '말씀', '공부', '예배'].map((label) => `<span class="text-[11px] font-bold text-center text-on-surface-variant">${label}</span>`).join('')}
    ${days.map((key) => {
      const date = new Date(`${key}T12:00:00`);
      const selected = key === selectedDateKey;
      return `<button type="button" data-overview-select-date="${key}" class="text-left rounded-xl px-2 py-2 transition-colors ${selected ? 'bg-primary/10 text-primary' : 'hover:bg-surface-low'}"><span class="block text-xs font-bold">${date.getMonth() + 1}.${String(date.getDate()).padStart(2, '0')}</span><span class="text-[10px] text-on-surface-variant">${weekday[date.getDay()]}요일</span></button>
        ${['pray', 'word', 'study', 'worship'].map((category) => verificationOverviewCellHTML(key, category)).join('')}`;
    }).join('')}
  </div>`;
}

function verificationOverviewCellHTML(key, category) {
  const labels = { pray: '\uAE30\uB3C4', word: '\uB9D0\uC500', study: '\uACF5\uBD80', worship: '\uC608\uBC30' };
  if (category === 'worship' && !isWorshipDayActive(key)) {
    return '<span class="inline-flex items-center justify-center w-full min-h-9 rounded-xl bg-surface-low text-[11px] font-semibold text-outline">\uD574\uB2F9 \uC5C6\uC74C</span>';
  }
  const verified = !!getMergedProgress(key)[category];
  if (verified) {
    return `<span class="inline-flex items-center justify-center w-full min-h-9 rounded-xl px-2 text-xs font-bold bg-quaternary/10 text-quaternary" aria-label="${key} ${labels[category]} \uC778\uC99D \uC644\uB8CC"><i class="fa-solid fa-check mr-1" aria-hidden="true"></i>\uC644\uB8CC</span>`;
  }
  return `<button type="button" data-overview-date="${key}" data-overview-category="${category}" class="w-full min-h-9 rounded-xl px-2 text-xs font-bold transition-all bg-error/10 text-error hover:bg-error hover:text-white" aria-label="${key} ${labels[category]} \uBBF8\uC778\uC99D, \uC778\uC99D\uD558\uAE30"><i class="fa-solid fa-plus mr-1" aria-hidden="true"></i>\uBBF8\uC778\uC99D</button>`;
}

function renderVerificationOverview() {
  const wrap = document.getElementById('verification-overview');
  const summary = document.getElementById('verification-overview-summary');
  if (!wrap) return;
  const section = wrap.closest('section');
  const heading = section?.querySelector('h2');
  const description = heading?.nextElementSibling;
  if (heading) heading.textContent = '\uC778\uC99D \uD604\uD669';
  if (description) description.textContent = '\uBBF8\uC778\uC99D \uD56D\uBAA9\uC744 \uB204\uB974\uBA74 \uD574\uB2F9 \uB0A0\uC9DC\uC758 \uC778\uC99D \uD654\uBA74\uC774 \uBC14\uB85C \uC5F4\uB9BD\uB2C8\uB2E4.';
  const days = getVerificationPeriodDays();
  const weekdays = ['\uC77C', '\uC6D4', '\uD654', '\uC218', '\uBAA9', '\uAE08', '\uD1A0'];
  const categoryLabels = ['\uAE30\uB3C4', '\uB9D0\uC500', '\uACF5\uBD80', '\uC608\uBC30'];
  const completedDays = days.filter((key) => getActiveCategoriesForDate(key).every((category) => getMergedProgress(key)[category])).length;
  if (summary) summary.textContent = `${completedDays} / ${days.length}\uC77C \uC644\uB8CC`;
  wrap.innerHTML = `<div class="grid grid-cols-[110px_repeat(4,minmax(105px,1fr))] gap-2 items-center">
    <span class="text-[11px] font-bold text-on-surface-variant px-2">\uB0A0\uC9DC</span>
    ${categoryLabels.map((label) => `<span class="text-[11px] font-bold text-center text-on-surface-variant">${label}</span>`).join('')}
    ${days.map((key) => {
      const date = new Date(`${key}T12:00:00`);
      const selected = key === selectedDateKey;
      return `<button type="button" data-overview-select-date="${key}" class="text-left rounded-xl px-2 py-2 transition-colors ${selected ? 'bg-primary/10 text-primary' : 'hover:bg-surface-low'}"><span class="block text-xs font-bold">${date.getMonth() + 1}.${String(date.getDate()).padStart(2, '0')}</span><span class="text-[10px] text-on-surface-variant">${weekdays[date.getDay()]}\uC694\uC77C</span></button>
        ${['pray', 'word', 'study', 'worship'].map((category) => verificationOverviewCellHTML(key, category)).join('')}`;
    }).join('')}
  </div>`;
}

async function openVerificationFromOverview(key, category) {
  await selectDate(key);
  if (category === 'pray') openPrayModal(key, onPrayWordSaved);
  if (category === 'word') openWordModal(key, onPrayWordSaved);
  if (category === 'study') {
    if (getMergedProgress(key).study) openStudyHistoryModal();
    else openStudyAddModal();
  }
  if (category === 'worship') openWorshipModal();
}

// Same checkmark icon everywhere — colored gradient when verified, neutral glass when not.
// Verified widget cards also get a gradient ring matching the active nav pill color.
function renderVerificationState() {
  const progress = getMergedProgress(selectedDateKey);

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

  const entries = getDailyStatus(selectedDateKey).pray.entries;
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

function renderWordWidgetSummary() {
  const slot = document.querySelector('#widget-word .widget-summary');
  if (!slot) return;

  const summary = formatWordSummary(getDailyStatus(selectedDateKey).word.verses);
  if (summary) {
    const totalMinutes = calculateWordMinutes(getDailyStatus(selectedDateKey).word.verses);
    slot.innerHTML = `
      <p class="text-3xl font-bold text-primary">${totalMinutes}<span class="text-base font-semibold ml-0.5">분</span></p>
      <p class="text-xs text-on-surface-variant mt-2 leading-relaxed">${summary}</p>
    `;
  } else {
    slot.innerHTML = '<div class="w-full border-t-2 border-dashed border-outline-variant"></div>';
  }
}

function getStudySeconds(sessions, source) {
  return sessions
    .filter((entry) => entry.source === source)
    .reduce((sum, entry) => sum + entry.seconds, 0);
}

function renderStudyWidgetSummary() {
  const slot = document.querySelector('#widget-study .widget-summary');
  if (!slot) return;

  const sessions = getDailyStatus(selectedDateKey).study.sessions;
  const recordSeconds = getStudySeconds(sessions, 'record');
  const manualSeconds = getStudySeconds(sessions, 'manual');

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
  const sessions = getDailyStatus(selectedDateKey).study.sessions;
  // keep each entry's original index in sessions so deletes target the right one
  const indexed = sessions.map((entry, index) => ({ ...entry, index }));
  const recordSessions = indexed.filter((entry) => entry.source === 'record');
  const manualSessions = indexed.filter((entry) => entry.source === 'manual');

  const recordTotalEl = document.getElementById('study-history-record-total');
  const manualTotalEl = document.getElementById('study-history-manual-total');
  const recordListEl = document.getElementById('study-history-record-list');
  const manualListEl = document.getElementById('study-history-manual-list');
  if (!recordTotalEl || !manualTotalEl || !recordListEl || !manualListEl) return;

  recordTotalEl.textContent = recordSessions.length ? formatMinutesSeconds(getStudySeconds(sessions, 'record')) : '-';
  manualTotalEl.textContent = manualSessions.length ? formatMinutesSeconds(getStudySeconds(sessions, 'manual')) : '-';

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

async function saveStudySessionsAndRefresh(sessions) {
  const userId = await getCurrentUserId();
  if (sessions.length > 0) {
    await saveStudySessions(userId, selectedDateKey, sessions);
  } else {
    await deleteStudyRecord(userId, selectedDateKey);
  }
  await refreshDailyStatus(selectedDateKey);
  renderVerificationState();
  renderStudyWidgetSummary();
  renderDailyGoals();
  renderStudyHistoryModal();
  renderVerificationOverview();
}

async function removeStudySession(index) {
  const sessions = getDailyStatus(selectedDateKey).study.sessions;
  const target = sessions[index];
  if (target && target.source === 'record' && !confirm('Record로 기록한 시간을 삭제할까요?')) return;

  await saveStudySessionsAndRefresh(sessions.filter((_, i) => i !== index));
}

async function resetStudyRecord() {
  if (!confirm('공부 기록을 전체 초기화할까요?')) return;
  await saveStudySessionsAndRefresh([]);
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

  const worship = getDailyStatus(selectedDateKey).worship;
  if (!worship.status) {
    slot.innerHTML = '<div class="w-full border-t-2 border-dashed border-outline-variant"></div>';
    return;
  }

  const statusLabel = { attended: 'O 참석', absent: 'X 미참석', home: '가정예배' }[worship.status] || '';
  if (worship.minutes > 0) {
    slot.innerHTML = `
      <p class="text-3xl font-bold text-primary">${worship.minutes}<span class="text-base font-semibold ml-0.5">분</span></p>
      <p class="text-xs text-on-surface-variant mt-2">${statusLabel}</p>
    `;
  } else {
    slot.innerHTML = `<p class="text-sm font-semibold text-on-surface-variant mt-10">${statusLabel}</p>`;
  }
}

// 기도 sums real logged time; 말씀은 기본 60분 + 추가 구절별 묵상 시간; 공부 sums Record + manual entries;
// 예배 is a flat 120분 when O/가정 was chosen (수/금만 활성화).
function getCategoryMinutes(key) {
  const s = getDailyStatus(selectedDateKey);
  if (key === 'pray') return s.pray.entries.reduce((sum, entry) => sum + durationMinutes(entry.start, entry.end), 0);
  if (key === 'word') return calculateWordMinutes(s.word.verses);
  if (key === 'study') return Math.round((getStudySeconds(s.study.sessions, 'record') + getStudySeconds(s.study.sessions, 'manual')) / 60);
  if (key === 'worship') return s.worship.minutes || 0;
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
  const progress = getMergedProgress(selectedDateKey);
  const categories = getActiveCategoriesForDate(selectedDateKey);
  const allDone = categories.every((key) => progress[key]);

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

function isWeekendDate(d) {
  const day = d.getDay();
  return day === 0 || day === 6;
}

function calendarCellHTML(d, { isToday, isSelected }) {
  const weekend = isWeekendDate(d);
  const filled = isSelected
    ? 'bg-gradient-to-br from-primary-container to-tertiary-container text-on-primary font-bold'
    : isToday
      ? 'ring-2 ring-primary text-on-surface font-semibold'
      : weekend
        ? 'text-outline-variant'
        : 'text-on-surface';
  return { filled, weekend };
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
  // 선택된 날짜가 속한 주의 일요일부터 2주(14일)를 보여준다.
  const weekStart = new Date(selectedDate);
  weekStart.setDate(selectedDate.getDate() - selectedDate.getDay());
  for (let offset = 0; offset < 14; offset += 1) {
    const d = new Date(weekStart);
    d.setDate(weekStart.getDate() + offset);
    const key = dateKey(d);
    const { filled, weekend } = calendarCellHTML(d, { isToday: key === todayKeyValue, isSelected: key === selectedDateKey });

    const weekdayLabel = offset < 7
      ? `<span class="text-[10px] font-semibold ${key === todayKeyValue ? 'text-primary' : 'text-on-surface-variant'}">${dayNames[d.getDay()]}</span>`
      : '';

    const cell = document.createElement('button');
    cell.type = 'button';
    cell.className = `calendar-day-cell flex flex-col items-center gap-2${weekend ? ' opacity-40 cursor-not-allowed' : ''}`;
    cell.dataset.dateKey = key;
    if (weekend) cell.disabled = true;
    cell.innerHTML = `
      ${weekdayLabel}
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
    const { filled, weekend } = calendarCellHTML(d, { isToday: key === todayKeyValue, isSelected: key === selectedDateKey });

    const cell = document.createElement('button');
    cell.type = 'button';
    cell.className = `calendar-day-cell flex items-center justify-center py-1${weekend ? ' opacity-40 cursor-not-allowed' : ''}`;
    cell.dataset.dateKey = key;
    if (weekend) cell.disabled = true;
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
  renderVerificationOverview();
}

async function selectDate(key) {
  selectedDateKey = key;
  await refreshDailyStatus(key);
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

// --- 공부: Record 타이머 (포그라운드 전용, Pause/On/Off) + 수동 분 입력 ---

let recordStartTime = null; // 현재 진행 중인 구간의 시작 시각. 일시정지/미시작 상태면 null.
let recordSessionStartedAt = null; // 이 Record 세션을 처음 시작한 시각(로그의 startedAt). 세션이 없으면 null.
let recordAccumulatedSeconds = 0; // 지금까지 (일시정지 제외하고) 실제로 흐른 시간의 합.
let recordIntervalId = null;

function formatElapsed(ms) {
  const totalSeconds = Math.max(0, Math.floor(ms / 1000));
  const mm = String(Math.floor(totalSeconds / 60)).padStart(2, '0');
  const ss = String(totalSeconds % 60).padStart(2, '0');
  return `${mm}:${ss}`;
}

function updateRecordTimerDisplay() {
  const el = document.getElementById('study-record-timer');
  if (!el || !recordSessionStartedAt) return;
  const runningMs = recordStartTime ? Date.now() - recordStartTime : 0;
  el.textContent = formatElapsed(recordAccumulatedSeconds * 1000 + runningMs);
}

function updateRecordButtonsUI() {
  const pauseBtn = document.getElementById('study-pause-btn');
  const resumeBtn = document.getElementById('study-resume-btn');
  const statusEl = document.getElementById('study-record-status');
  const running = !!recordStartTime;
  if (pauseBtn) pauseBtn.classList.toggle('hidden', !running);
  if (resumeBtn) resumeBtn.classList.toggle('hidden', running);
  if (statusEl) statusEl.textContent = running ? '공부 기록 중' : '일시정지됨';
}

function startRecording() {
  if (recordSessionStartedAt) return;
  recordSessionStartedAt = Date.now();
  recordStartTime = recordSessionStartedAt;
  recordAccumulatedSeconds = 0;

  const modal = document.getElementById('study-record-modal');
  if (modal) {
    modal.classList.remove('hidden');
    modal.classList.add('flex');
  }

  updateRecordButtonsUI();
  updateRecordTimerDisplay();
  recordIntervalId = setInterval(updateRecordTimerDisplay, 1000);
}

// Pause (수동 클릭 또는 다른 화면/앱으로 이동 시 자동): 타이머만 멈추고 세션은 유지,
// On으로 다시 이어서 잴 수 있다. 백그라운드에 있는 동안은 절대 카운트되지 않는다.
function pauseRecording() {
  if (!recordStartTime) return;
  // 표시되는 타임스탬프와 정확히 맞도록 구간별로도 초 단위로 끊어서 누적한다.
  recordAccumulatedSeconds += Math.floor(Date.now() / 1000) - Math.floor(recordStartTime / 1000);
  recordStartTime = null;
  clearInterval(recordIntervalId);
  recordIntervalId = null;

  updateRecordButtonsUI();
  updateRecordTimerDisplay();
}

// On: 일시정지 상태에서 다시 재개.
function resumeRecording() {
  if (!recordSessionStartedAt || recordStartTime) return;
  recordStartTime = Date.now();

  updateRecordButtonsUI();
  updateRecordTimerDisplay();
  recordIntervalId = setInterval(updateRecordTimerDisplay, 1000);
}

// Off: 세션을 종료하고 지금까지 잰 시간을 기록으로 저장한다 (실행 중이었다면 마지막 구간도 합산).
async function stopRecording() {
  if (!recordSessionStartedAt) return;

  if (recordStartTime) {
    recordAccumulatedSeconds += Math.floor(Date.now() / 1000) - Math.floor(recordStartTime / 1000);
  }
  const startedAt = recordSessionStartedAt;
  const endedAt = Date.now();
  const elapsedSeconds = recordAccumulatedSeconds;

  clearInterval(recordIntervalId);
  recordIntervalId = null;
  recordStartTime = null;
  recordSessionStartedAt = null;
  recordAccumulatedSeconds = 0;

  const modal = document.getElementById('study-record-modal');
  if (modal) {
    modal.classList.add('hidden');
    modal.classList.remove('flex');
  }

  if (elapsedSeconds > 0) {
    const sessions = getDailyStatus(selectedDateKey).study.sessions;
    await saveStudySessionsAndRefresh([...sessions, { source: 'record', seconds: elapsedSeconds, startedAt, endedAt }]);
  }
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

async function recordWorship(status) {
  const userId = await getCurrentUserId();
  const minutes = status === 'attended' || status === 'home' ? WORSHIP_AUTO_MINUTES : 0;
  await saveWorshipRecord(userId, selectedDateKey, status, minutes);
  await refreshDailyStatus(selectedDateKey);

  renderVerificationState();
  renderWorshipWidgetSummary();
  renderDailyGoals();
  renderVerificationOverview();
  closeWorshipModal();
}

async function resetWorship() {
  const userId = await getCurrentUserId();
  await deleteWorshipRecord(userId, selectedDateKey);
  await refreshDailyStatus(selectedDateKey);

  renderVerificationState();
  renderWorshipWidgetSummary();
  renderDailyGoals();
  renderVerificationOverview();
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

// 기도/말씀 저장·초기화 이후 Home 쪽에서 다시 그려줘야 하는 것들 (pray-word.js가 호출).
async function onPrayWordSaved() {
  await refreshDailyStatus(selectedDateKey);
  renderVerificationState();
  renderPrayWidgetSummary();
  renderWordWidgetSummary();
  renderDailyGoals();
  renderVerificationOverview();
}

async function onGalleryPrayWordSaved() {
  await onPrayWordSaved();
  if (!galleryReturnType) return;
  const cameFromGallery = document.referrer.includes('/gallery.html');
  if (cameFromGallery && window.history.length > 1) {
    window.history.back();
    return;
  }
  window.location.replace(`gallery.html?date=${encodeURIComponent(selectedDateKey)}&type=${encodeURIComponent(galleryReturnType)}`);
}

async function initHomeWidgets() {
  const params = new URLSearchParams(window.location.search);
  const requestedDate = params.get('date');
  const requestedVerification = params.get('verify');
  if (/^2026-(08|09)-\d{2}$/.test(requestedDate || '')) selectedDateKey = requestedDate;
  if (params.get('return') === 'gallery' && (requestedVerification === 'pray' || requestedVerification === 'word')) galleryReturnType = requestedVerification;
  wireCalendarTabs();
  wireCalendarSelection();
  wirePrayModalStatic();
  wireWordModalStatic();

  document.getElementById('verification-overview')?.addEventListener('click', (event) => {
    const categoryButton = event.target.closest('[data-overview-category]');
    if (categoryButton) {
      openVerificationFromOverview(categoryButton.dataset.overviewDate, categoryButton.dataset.overviewCategory);
      return;
    }
    const dateButton = event.target.closest('[data-overview-select-date]');
    if (dateButton) selectDate(dateButton.dataset.overviewSelectDate);
  });

  const dateResetBtn = document.getElementById('selected-date-reset');
  if (dateResetBtn) dateResetBtn.addEventListener('click', () => selectDate(todayKey()));

  const prayWidget = document.getElementById('widget-pray');
  if (prayWidget) prayWidget.addEventListener('click', () => openPrayModal(selectedDateKey, onPrayWordSaved));

  const wordWidget = document.getElementById('widget-word');
  if (wordWidget) wordWidget.addEventListener('click', () => openWordModal(selectedDateKey, onPrayWordSaved));

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
  if (pauseBtn) pauseBtn.addEventListener('click', pauseRecording);

  const resumeBtn = document.getElementById('study-resume-btn');
  if (resumeBtn) resumeBtn.addEventListener('click', resumeRecording);

  const stopBtn = document.getElementById('study-stop-btn');
  if (stopBtn) stopBtn.addEventListener('click', stopRecording);

  document.addEventListener('visibilitychange', () => {
    if (document.hidden) pauseRecording();
  });
  window.addEventListener('blur', pauseRecording);

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
    studyAddSaveBtn.addEventListener('click', async () => {
      const input = document.getElementById('study-add-minutes-input');
      const minutes = input ? parseInt(input.value, 10) : NaN;
      if (!Number.isInteger(minutes) || minutes <= 0) return;

      const sessions = getDailyStatus(selectedDateKey).study.sessions;
      await saveStudySessionsAndRefresh([...sessions, { source: 'manual', seconds: minutes * 60 }]);
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

  // 버튼 wiring은 전부 즉시 끝내고, 4개 카테고리 최초 데이터만 비동기로 불러온 뒤 첫 렌더를 한다.
  await loadVerificationPeriodStatus();
  renderAllForSelectedDate();
  if (galleryReturnType === 'pray') openPrayModal(selectedDateKey, onGalleryPrayWordSaved);
  if (galleryReturnType === 'word') openWordModal(selectedDateKey, onGalleryPrayWordSaved);
}

window.initHomeWidgets = initHomeWidgets;
