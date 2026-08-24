// Stat 탭: 기도/말씀/공부/예배 인증 데이터를 다양한 시각화로 보여주는 개인 통계 페이지.
// home.js는 로드하지 않는다(layout.js의 renderApp()이 initHomeWidgets를 페이지 구분 없이 호출하기
// 때문에, 불필요한 "오늘" 조회가 Stat 페이지에서도 실행되는 것을 막기 위함) — 대신 pray-word.js의
// todayKey/dateKey/getCurrentUserId/durationMinutes만 재사용하고, home.js의 상수/공식은 이 파일에
// stat 접두사로 재구현한다.

const STAT_DAILY_GOAL_MINUTES = 300;
const STAT_WORD_VERIFIED_MINUTES = 60;
const STAT_CATEGORY_TOKEN = { pray: 'primary', word: 'secondary', study: 'tertiary', worship: 'quaternary' };
const STAT_CATEGORY_LABEL = { pray: '기도', word: '말씀', study: '공부', worship: '예배' };

// 운영기간: 8/10~9/6, 평일(월~금)만. 주말과 이 기간 밖의 기록은 통계에서 아예 제외한다.
const STAT_PROGRAM_START_KEY = '2026-08-10';
const STAT_PROGRAM_END_KEY = '2026-09-06';
const STAT_ACTIVE_WEEKDAYS = [1, 2, 3, 4, 5]; // 월~금
const STAT_PROGRAM_TOTAL_WEEKDAYS = 20; // 8/10~9/6 평일 총 일수 (고정값 — 프로그램 진행 중에도 분모가 바뀌지 않도록)

const STAT_RING_RADIUS = 52;
const STAT_RING_CIRCUMFERENCE = 2 * Math.PI * STAT_RING_RADIUS;

let statFullDays = [];
let statActiveRangeKey = 'weekly';
let statHeatmapMetric = 'completed';
let statTrendChart = null;
let statRadarChart = null;
let statDonutChart = null;

// 단어 시험(오프라인 시험지 채점 결과) — Study 탭과 동일하게 8/22, 9/5 두 번 고정.
const STAT_EXAM_DATES = [
  { key: '2026-08-22', label: '8/22 (토)' },
  { key: '2026-09-05', label: '9/5 (토)' }
];

// --- 데이터 조회 & 정규화 ---

async function fetchFullHistory(userId) {
  const [prayRes, wordRes, studyRes, worshipRes] = await Promise.all([
    window.supabaseClient.from('pray_records').select('record_date, entries').eq('user_id', userId).order('record_date'),
    window.supabaseClient.from('word_records').select('record_date, verses').eq('user_id', userId).order('record_date'),
    window.supabaseClient.from('study_records').select('record_date, sessions').eq('user_id', userId).order('record_date'),
    window.supabaseClient.from('worship_records').select('record_date, status, minutes').eq('user_id', userId).order('record_date')
  ]);
  if (prayRes.error) console.error('[stat] pray_records', prayRes.error);
  if (wordRes.error) console.error('[stat] word_records', wordRes.error);
  if (studyRes.error) console.error('[stat] study_records', studyRes.error);
  if (worshipRes.error) console.error('[stat] worship_records', worshipRes.error);

  return {
    pray: prayRes.data || [],
    word: wordRes.data || [],
    study: studyRes.data || [],
    worship: worshipRes.data || []
  };
}

function statGetStudySeconds(sessions, source) {
  return (sessions || []).filter((s) => s.source === source).reduce((sum, s) => sum + (s.seconds || 0), 0);
}

// 운영기간(8/10~9/6) 중 평일만 순회하며, 기록이 없는 날은 0분/미인증 기본값으로 채운다.
// 운영기간 밖의 기록(예: 테스트 데이터)과 주말은 통계에 아예 포함되지 않는다.
function buildDailySeries(history) {
  const byDate = { pray: {}, word: {}, study: {}, worship: {} };
  history.pray.forEach((r) => { byDate.pray[r.record_date] = r; });
  history.word.forEach((r) => { byDate.word[r.record_date] = r; });
  history.study.forEach((r) => { byDate.study[r.record_date] = r; });
  history.worship.forEach((r) => { byDate.worship[r.record_date] = r; });

  const allDates = [
    ...history.pray.map((r) => r.record_date),
    ...history.word.map((r) => r.record_date),
    ...history.study.map((r) => r.record_date),
    ...history.worship.map((r) => r.record_date)
  ];

  const start = new Date(`${STAT_PROGRAM_START_KEY}T00:00:00`);
  const programEnd = new Date(`${STAT_PROGRAM_END_KEY}T00:00:00`);
  const today = new Date(`${todayKey()}T00:00:00`);
  // 브라우저의 "오늘"이 실제 운영 시작일에 아직 못 미치더라도(로컬 테스트 등), 이미 입력된 기록이
  // 있는 날짜까지는 보여준다 — 종료 상한은 오늘과 최신 기록일 중 늦은 쪽, 단 운영 종료일은 못 넘음.
  const latestDataDate = allDates.length > 0
    ? new Date(Math.max(...allDates.map((d) => new Date(`${d}T00:00:00`).getTime())))
    : today;
  const cappedEnd = today > latestDataDate ? today : latestDataDate;
  const end = cappedEnd < programEnd ? cappedEnd : programEnd;

  const days = [];
  if (end < start) return days; // 아직 운영기간이 시작되지 않았고 기록도 없음

  const cursor = new Date(start);
  while (cursor <= end) {
    if (STAT_ACTIVE_WEEKDAYS.includes(cursor.getDay())) {
      const key = dateKey(cursor);
      const entries = byDate.pray[key] ? byDate.pray[key].entries : [];
      const verses = byDate.word[key] ? byDate.word[key].verses : [];
      const sessions = byDate.study[key] ? byDate.study[key].sessions : [];
      const worshipRow = byDate.worship[key];

      const prayMin = entries.reduce((s, e) => s + durationMinutes(e.start, e.end), 0);
      const wordMin = calculateWordMinutes(verses);
      const studyMin = Math.round((statGetStudySeconds(sessions, 'record') + statGetStudySeconds(sessions, 'manual')) / 60);
      const worshipMin = worshipRow ? (worshipRow.minutes || 0) : 0;
      const totalMin = prayMin + wordMin + studyMin + worshipMin;

      days.push({
        key,
        prayMin,
        wordMin,
        studyMin,
        worshipMin,
        totalMin,
        percent: Math.round((totalMin / STAT_DAILY_GOAL_MINUTES) * 100)
      });
    }
    cursor.setDate(cursor.getDate() + 1);
  }
  return days;
}

// --- 스트릭 (연속 기록) ---

// 스트릭 = "연속적으로 300분(하루 목표)을 달성한 일 수" — day.percent >= 100 기준.
// Days Completed KPI, Heatmap "완료" 탭도 전부 이 기준을 함께 쓴다(카테고리 전체 인증 여부가 아님).
function currentStreak(days) {
  let i = days.length - 1;
  if (i < 0) return 0;
  // 마지막 항목이 "오늘"이고 아직 300분 미달성이면 건너뛰고 그 전 평일부터 카운트한다.
  // (주말/운영기간 종료 후에는 마지막 항목이 지나간 평일이라 이 유예를 주면 안 됨)
  if (days[i].key === todayKey() && days[i].percent < 100) i -= 1;
  let streak = 0;
  while (i >= 0 && days[i].percent >= 100) {
    streak += 1;
    i -= 1;
  }
  return streak;
}

function longestStreak(days) {
  let max = 0;
  let run = 0;
  days.forEach((day) => {
    run = day.percent >= 100 ? run + 1 : 0;
    if (run > max) max = run;
  });
  return max;
}

// --- 범위 슬라이싱 ---

function sliceWeekly(days) {
  return days.slice(-20); // 평일만 있는 시리즈라 4주 = 20일
}

function sliceMonthly(days) {
  const now = new Date();
  const monthStartKey = `${now.getFullYear()}-${String(now.getMonth() + 1).padStart(2, '0')}-01`;
  const idx = days.findIndex((d) => d.key >= monthStartKey);
  return idx === -1 ? [] : days.slice(idx);
}

function sliceAll(days) {
  return days;
}

const STAT_RANGES = { weekly: sliceWeekly, monthly: sliceMonthly, all: sliceAll };

function getActiveRangeDays() {
  return STAT_RANGES[statActiveRangeKey](statFullDays);
}

// --- 포맷터 ---

function formatStatMinutes(minutes) {
  if (minutes >= 60) {
    const h = Math.floor(minutes / 60);
    const m = minutes % 60;
    return m > 0 ? `${h}시간 ${m}분` : `${h}시간`;
  }
  return `${minutes}분`;
}

function formatStatDateLabel(key) {
  const [, m, d] = key.split('-').map(Number);
  return `${m}/${d}`;
}

// --- KPI / 목표 달성률 계산 ---

function computeRangeStats(days) {
  const totalMin = days.reduce((s, d) => s + d.totalMin, 0);
  const avgMinutes = days.length > 0 ? Math.round(totalMin / days.length) : 0;
  const best = days.reduce((acc, d) => (!acc || d.totalMin > acc.totalMin ? d : acc), null);
  return { totalMin, avgMinutes, totalCount: days.length, best };
}

function computeGoalHitRate(days) {
  if (days.length === 0) return 0;
  const hit = days.filter((d) => d.percent >= 100).length;
  return Math.round((hit / days.length) * 100);
}

// --- 렌더: 스트릭 카드 / 범위 목표 링 / KPI 타일 ---

function renderStreakCard(fullDays) {
  const currentEl = document.getElementById('stat-streak-current');
  const longestEl = document.getElementById('stat-streak-longest');
  if (currentEl) currentEl.textContent = `${currentStreak(fullDays)}일`;
  if (longestEl) longestEl.textContent = `최장 ${longestStreak(fullDays)}일`;
}

function renderRangeGoalRing(days) {
  const ring = document.getElementById('stat-goal-ring');
  const percentEl = document.getElementById('stat-goal-percent');
  const subEl = document.getElementById('stat-goal-sub');
  if (!ring) return;

  const rate = computeGoalHitRate(days);
  const offset = STAT_RING_CIRCUMFERENCE * (1 - Math.min(rate, 100) / 100);
  ring.setAttribute('stroke-dasharray', String(STAT_RING_CIRCUMFERENCE));
  ring.setAttribute('stroke-dashoffset', String(offset));
  ring.setAttribute('stroke', rate >= 50 ? 'url(#stat-goal-gradient-high)' : 'url(#stat-goal-gradient-low)');

  if (percentEl) percentEl.textContent = `${rate}%`;
  if (subEl) subEl.textContent = `${days.filter((d) => d.percent >= 100).length}/${days.length}일 달성`;
}

function renderKpiTiles(days) {
  const stats = computeRangeStats(days);
  const totalEl = document.getElementById('stat-kpi-total');
  const avgEl = document.getElementById('stat-kpi-avg');
  const completedEl = document.getElementById('stat-kpi-completed');
  const bestEl = document.getElementById('stat-kpi-best');

  if (totalEl) totalEl.textContent = formatStatMinutes(stats.totalMin);
  if (avgEl) avgEl.textContent = formatStatMinutes(stats.avgMinutes);
  // Days Completed는 탭(주간/월간)과도, 진행 중인 날짜와도 무관하게 항상 "달성일수 / 20일" 고정 —
  // 프로그램이 끝나기 전에도 분모가 계속 바뀌지 않게 하기 위함 (Streak/Personal Bests와 같은 이유).
  // "달성"의 기준은 Streak와 동일하게 하루 300분 목표(percent>=100) — 카테고리 전체 인증 여부(completed)와는 다르다.
  if (completedEl) completedEl.textContent = `${statFullDays.filter((d) => d.percent >= 100).length} / ${STAT_PROGRAM_TOTAL_WEEKDAYS}일`;
  if (bestEl) bestEl.textContent = stats.best && stats.best.totalMin > 0
    ? `${formatStatMinutes(stats.best.totalMin)} · ${formatStatDateLabel(stats.best.key)}`
    : '-';
}

// --- 렌더: 완료 히트맵 ---

// 일요일부터 시작하는 주 단위 컬럼으로 묶는다 (buildDailySeries가 매일 채워주므로 요일 계산만 하면 됨).
function groupByWeeks(days) {
  if (days.length === 0) return [];
  const weeks = [];
  let week = new Array(7).fill(null);
  let prevDow = new Date(`${days[0].key}T00:00:00`).getDay();

  days.forEach((day) => {
    const dow = new Date(`${day.key}T00:00:00`).getDay();
    if (dow < prevDow) {
      weeks.push(week);
      week = new Array(7).fill(null);
    }
    week[dow] = day;
    prevDow = dow;
  });
  weeks.push(week);
  return weeks;
}

// 셀 배경색 + (배경 위에서 잘 보이는) 텍스트 색을 함께 정한다 — 진한/그라데이션 셀은 흰 글자,
// 옅은/빈 셀은 어두운 글자.
function heatmapCellStyle(day, maxValue) {
  if (statHeatmapMetric === 'completed') {
    // "완료"의 기준은 Streak/Days Completed와 동일하게 하루 300분 목표(percent>=100).
    if (day.percent >= 100) return { bg: 'bg-gradient-to-br from-primary-container to-tertiary-container', text: 'text-white' };
    if (day.totalMin > 0) return { bg: 'bg-primary/25', text: 'text-on-surface-variant' };
    return { bg: 'bg-surface-container', text: 'text-on-surface-variant/40' };
  }

  const token = STAT_CATEGORY_TOKEN[statHeatmapMetric];
  const value = day[`${statHeatmapMetric}Min`] || 0;
  if (value <= 0) return { bg: 'bg-surface-container', text: 'text-on-surface-variant/40' };
  const ratio = maxValue > 0 ? value / maxValue : 0;
  if (ratio > 0.75) return { bg: `bg-${token}`, text: 'text-white' };
  if (ratio > 0.5) return { bg: `bg-${token}/70`, text: 'text-white' };
  if (ratio > 0.25) return { bg: `bg-${token}/45`, text: 'text-on-surface-variant' };
  return { bg: `bg-${token}/25`, text: 'text-on-surface-variant' };
}

function statHeatmapTooltip(day) {
  if (statHeatmapMetric === 'completed') return `${formatStatDateLabel(day.key)} · ${day.percent >= 100 ? '완료' : `${day.totalMin}분`}`;
  const label = STAT_CATEGORY_LABEL[statHeatmapMetric];
  return `${formatStatDateLabel(day.key)} · ${label} ${day[`${statHeatmapMetric}Min`] || 0}분`;
}

// GitHub 잔디 그래프를 참고하되, 데이터가 4주 남짓으로 작아서 컬럼(주)이 아니라 행(주) 단위로
// 쌓고 각 칸에 날짜 숫자를 직접 표시한다 — 위쪽 Mon~Fri 헤더(정적 마크업, stat.html)와 짝을 이룬다.
function renderHeatmap(days) {
  const container = document.getElementById('stat-heatmap');
  if (!container) return;

  if (days.length === 0) {
    container.innerHTML = '<p class="text-xs text-on-surface-variant py-6 text-center">표시할 기록이 없어요.</p>';
    return;
  }

  const weeks = groupByWeeks(days);
  const maxValue = statHeatmapMetric === 'completed'
    ? 0
    : Math.max(1, ...days.map((d) => d[`${statHeatmapMetric}Min`] || 0));

  container.innerHTML = weeks.map((week) => `
    <div class="grid grid-cols-5 gap-1">
      ${[1, 2, 3, 4, 5].map((dow) => {
        const day = week[dow];
        if (!day) return '<div class="heatmap-cell bg-transparent"></div>';
        const { bg, text } = heatmapCellStyle(day, maxValue);
        const dayNum = Number(day.key.split('-')[2]);
        return `<div class="heatmap-cell ${bg} ${text} flex items-center justify-center text-[9px] font-medium cursor-pointer" data-key="${day.key}">${dayNum}</div>`;
      }).join('')}
    </div>`).join('');
}

// --- 렌더: Chart.js (추세 라인 / 밸런스 레이더 / 시간 배분 도넛) ---

function bucketDaysWeekly(days) {
  return groupByWeeks(days).map((week) => {
    const present = week.filter(Boolean);
    return {
      label: present.length > 0 ? formatStatDateLabel(present[0].key) : '',
      totalMin: present.reduce((s, d) => s + d.totalMin, 0)
    };
  });
}

function renderTrendChart(days) {
  const canvas = document.getElementById('stat-trend-chart');
  if (!canvas || typeof Chart === 'undefined') return;

  const useWeeklyBuckets = days.length > 70;
  const points = useWeeklyBuckets ? bucketDaysWeekly(days) : days.map((d) => ({ label: formatStatDateLabel(d.key), totalMin: d.totalMin }));
  const labels = points.map((p) => p.label);
  const values = points.map((p) => p.totalMin);

  if (statTrendChart) statTrendChart.destroy();
  statTrendChart = new Chart(canvas.getContext('2d'), {
    type: 'line',
    data: {
      labels,
      datasets: [
        {
          label: 'Total Minutes',
          data: values,
          borderColor: '#b9045e',
          backgroundColor: 'rgba(255,75,145,0.18)',
          fill: true,
          tension: 0.35,
          pointRadius: 2,
          pointBackgroundColor: '#b9045e'
        },
        {
          label: '300 Min Goal',
          data: values.map(() => STAT_DAILY_GOAL_MINUTES),
          borderColor: '#8d6f76',
          borderDash: [6, 6],
          pointRadius: 0,
          fill: false
        }
      ]
    },
    options: {
      maintainAspectRatio: false,
      plugins: { legend: { labels: { font: { family: 'Pretendard' }, boxWidth: 12 } } },
      scales: {
        x: { grid: { display: false } },
        y: { beginAtZero: true }
      }
    }
  });
}

function renderRadarChart(days) {
  const canvas = document.getElementById('stat-radar-chart');
  if (!canvas || typeof Chart === 'undefined') return;

  const totals = { pray: 0, word: 0, study: 0 };
  days.forEach((d) => {
    totals.pray += d.prayMin;
    totals.word += d.wordMin;
    totals.study += d.studyMin;
  });
  const dayCount = Math.max(1, days.length);

  if (statRadarChart) statRadarChart.destroy();
  statRadarChart = new Chart(canvas.getContext('2d'), {
    type: 'radar',
    data: {
      labels: ['기도', '말씀', '공부'],
      datasets: [{
        label: 'Daily Avg (min)',
        data: [totals.pray, totals.word, totals.study].map((v) => Math.round(v / dayCount)),
        backgroundColor: 'rgba(255,75,145,0.22)',
        borderColor: '#b9045e',
        pointBackgroundColor: '#b9045e'
      }]
    },
    options: {
      maintainAspectRatio: false,
      plugins: { legend: { display: false } },
      scales: { r: { beginAtZero: true, pointLabels: { font: { family: 'Pretendard' }, size: 12 } } }
    }
  });
}

// Time Breakdown 도넛 전용 팔레트 — 공용 브랜드 토큰(primary 핑크 #b9045e / secondary 퍼플 #6e4f9c)은
// 작은 조각으로 나뉘면 채도/명도가 비슷해 기도·말씀이 잘 구분되지 않아서, 이 차트에서만 색상환을
// 넓게 벌린 팔레트로 교체한다 (히트맵/칩 등 다른 곳의 카테고리 색상은 그대로 유지).
const STAT_DONUT_COLORS = ['#ec4899', '#6366f1', '#f97316']; // 기도/말씀/공부

function renderDonutChart(days) {
  const canvas = document.getElementById('stat-donut-chart');
  if (!canvas || typeof Chart === 'undefined') return;

  const totals = { pray: 0, word: 0, study: 0 };
  days.forEach((d) => {
    totals.pray += d.prayMin;
    totals.word += d.wordMin;
    totals.study += d.studyMin;
  });
  const sum = totals.pray + totals.word + totals.study;

  if (statDonutChart) statDonutChart.destroy();
  statDonutChart = new Chart(canvas.getContext('2d'), {
    type: 'doughnut',
    data: {
      labels: ['기도', '말씀', '공부'],
      datasets: [{
        data: [totals.pray, totals.word, totals.study],
        backgroundColor: STAT_DONUT_COLORS,
        borderColor: '#ffffff',
        borderWidth: 2
      }]
    },
    options: {
      maintainAspectRatio: false,
      cutout: '65%',
      plugins: {
        legend: { position: 'bottom', labels: { font: { family: 'Pretendard' }, boxWidth: 12 } },
        tooltip: {
          callbacks: {
            label: (ctx) => `${ctx.label}: ${ctx.parsed}분${sum > 0 ? ` (${Math.round((ctx.parsed / sum) * 100)}%)` : ''}`
          }
        }
      }
    }
  });
}

// --- 렌더: 퍼스널 베스트 칩 ---

function statChipHTML(label, value, token) {
  return `
    <div class="glass-card rounded-full pl-3 pr-4 py-2 flex items-center gap-2">
      <span class="w-2 h-2 rounded-full bg-${token}"></span>
      <span class="text-xs text-on-surface-variant">${label}</span>
      <span class="text-xs font-semibold text-on-surface">${value}</span>
    </div>`;
}

function renderPersonalBestChips(fullDays) {
  const wrap = document.getElementById('stat-best-chips');
  if (!wrap) return;

  const chips = [];
  const overall = fullDays.reduce((acc, d) => (!acc || d.totalMin > acc.totalMin ? d : acc), null);
  if (overall && overall.totalMin > 0) {
    chips.push(statChipHTML('하루 최대 시간', `${formatStatMinutes(overall.totalMin)} · ${formatStatDateLabel(overall.key)}`, 'primary'));
  }

  ['pray', 'word', 'study', 'worship'].forEach((cat) => {
    const best = fullDays.reduce((acc, d) => (!acc || d[`${cat}Min`] > acc[`${cat}Min`] ? d : acc), null);
    if (best && best[`${cat}Min`] > 0) {
      chips.push(statChipHTML(`${STAT_CATEGORY_LABEL[cat]} 최다`, `${formatStatMinutes(best[`${cat}Min`])} · ${formatStatDateLabel(best.key)}`, STAT_CATEGORY_TOKEN[cat]));
    }
  });

  const longest = longestStreak(fullDays);
  if (longest > 0) chips.push(statChipHTML('최장 연속기록', `${longest}일`, 'quaternary'));

  wrap.innerHTML = chips.length > 0
    ? chips.join('')
    : '<p class="text-sm text-on-surface-variant">아직 기록이 없어요. 오늘부터 시작해볼까요?</p>';
}

// --- 렌더: 단어 시험 점수 ---

function statExamCardHTML(examInfo, row) {
  const graded = row && row.status === 'graded';
  const statusLabel = graded ? `${row.score} / ${row.max_score}점` : row ? '채점 대기중' : '미제출';
  return `
    <div class="glass-card rounded-[1.5rem] p-4 flex items-center justify-between gap-3">
      <div>
        <p class="text-xs font-bold text-on-surface-variant">${examInfo.label}</p>
        <p class="text-sm text-on-surface mt-1">단어 시험</p>
      </div>
      <p class="text-lg font-bold ${graded ? 'text-primary' : 'text-on-surface-variant'}">${statusLabel}</p>
    </div>`;
}

async function renderStatWordExam(userId) {
  const wrap = document.getElementById('stat-word-exam-list');
  if (!wrap) return;
  const { data, error } = await window.supabaseClient.from('word_exam_submissions').select('exam_date,score,max_score,status').eq('user_id', userId);
  if (error) { console.error('[stat] word_exam_submissions', error); return; }
  const byDate = Object.fromEntries((data || []).map((row) => [row.exam_date, row]));
  wrap.innerHTML = STAT_EXAM_DATES.map((examInfo) => statExamCardHTML(examInfo, byDate[examInfo.key])).join('');
}

// --- 탭 wiring ---

function renderRangeDependentViews() {
  const days = getActiveRangeDays();
  renderRangeGoalRing(days);
  renderKpiTiles(days);
  renderHeatmap(days);
  renderTrendChart(days);
  renderRadarChart(days);
  renderDonutChart(days);
}

function wireRangeTabs() {
  const buttons = {
    weekly: document.getElementById('stat-range-weekly'),
    monthly: document.getElementById('stat-range-monthly'),
    all: document.getElementById('stat-range-all')
  };
  Object.entries(buttons).forEach(([key, btn]) => {
    if (!btn) return;
    btn.addEventListener('click', () => {
      statActiveRangeKey = key;
      Object.entries(buttons).forEach(([k, b]) => {
        if (!b) return;
        b.classList.toggle('nav-pill-active', k === key);
        b.classList.toggle('text-on-surface-variant', k !== key);
      });
      renderRangeDependentViews();
    });
  });
}

function wireHeatmapMetricTabs() {
  const wrap = document.getElementById('stat-heatmap-metric-tabs');
  if (!wrap) return;
  wrap.addEventListener('click', (e) => {
    const btn = e.target.closest('[data-metric]');
    if (!btn) return;
    statHeatmapMetric = btn.dataset.metric;
    [...wrap.querySelectorAll('[data-metric]')].forEach((b) => {
      b.classList.toggle('nav-pill-active', b === btn);
      b.classList.toggle('text-on-surface-variant', b !== btn);
    });
    renderHeatmap(getActiveRangeDays());
    const detail = document.getElementById('stat-heatmap-detail');
    if (detail) detail.textContent = '칸에 커서를 올리거나 눌러보세요';
  });
}

// Time Breakdown(Chart.js 툴팁)처럼 커서를 올리거나 탭하면 값이 뜨도록 — 다만 네이티브 title
// 팝업 대신, 항상 같은 자리에 있는 텍스트 라벨을 갱신하는 방식으로 구현한다.
function wireHeatmapHover() {
  const container = document.getElementById('stat-heatmap');
  const detail = document.getElementById('stat-heatmap-detail');
  if (!container || !detail) return;

  function showDetail(e) {
    const cell = e.target.closest('[data-key]');
    if (!cell) return;
    const day = statFullDays.find((d) => d.key === cell.dataset.key);
    if (day) detail.textContent = statHeatmapTooltip(day);
  }

  container.addEventListener('mouseover', showDetail);
  container.addEventListener('click', showDetail);
}

async function initStatWidgets() {
  wireRangeTabs();
  wireHeatmapMetricTabs();
  wireHeatmapHover();

  const userId = await getCurrentUserId();
  if (!userId) return;

  const history = await fetchFullHistory(userId);
  statFullDays = buildDailySeries(history);

  renderStreakCard(statFullDays);
  renderPersonalBestChips(statFullDays);
  renderRangeDependentViews();
  await renderStatWordExam(userId);
}

window.initStatWidgets = initStatWidgets;
