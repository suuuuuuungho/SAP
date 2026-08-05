// Stat 탭: 기도/말씀/공부/예배 인증 데이터를 다양한 시각화로 보여주는 개인 통계 페이지.
// home.js는 로드하지 않는다(layout.js의 renderApp()이 initHomeWidgets를 페이지 구분 없이 호출하기
// 때문에, 불필요한 "오늘" 조회가 Stat 페이지에서도 실행되는 것을 막기 위함) — 대신 pray-word.js의
// todayKey/dateKey/getCurrentUserId/durationMinutes만 재사용하고, home.js의 상수/공식은 이 파일에
// stat 접두사로 재구현한다.

const STAT_DAILY_GOAL_MINUTES = 300;
const STAT_WORD_VERIFIED_MINUTES = 60;
const STAT_WORSHIP_ACTIVE_WEEKDAYS = [3, 5]; // 수(3), 금(5)
const STAT_CATEGORY_TOKEN = { pray: 'primary', word: 'secondary', study: 'tertiary', worship: 'quaternary' };
const STAT_CATEGORY_LABEL = { pray: '기도', word: '말씀', study: '공부', worship: '예배' };

const STAT_RING_RADIUS = 52;
const STAT_RING_CIRCUMFERENCE = 2 * Math.PI * STAT_RING_RADIUS;

let statFullDays = [];
let statActiveRangeKey = 'weekly';
let statHeatmapMetric = 'completed';
let statTrendChart = null;
let statRadarChart = null;
let statDonutChart = null;

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

function statIsWorshipDayActive(key) {
  const [y, m, d] = key.split('-').map(Number);
  return STAT_WORSHIP_ACTIVE_WEEKDAYS.includes(new Date(y, m - 1, d).getDay());
}

function statActiveCategories(key) {
  const cats = ['pray', 'word', 'study'];
  if (statIsWorshipDayActive(key)) cats.push('worship');
  return cats;
}

// 발견된 가장 이른 날짜 ~ 오늘까지 하루 단위로 순회하며, 기록이 없는 날은 0분/미인증 기본값으로 채운다.
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

  const today = todayKey();
  const cursor = allDates.length > 0
    ? new Date(Math.min(...allDates.map((d) => new Date(`${d}T00:00:00`).getTime())))
    : new Date(`${today}T00:00:00`);
  // 모달에서 미래 날짜(시작/종료 일시)를 직접 입력할 수 있어 기록이 "오늘"보다 나중일 수 있다 —
  // 그런 경우에도 루프가 최소 1회는 돌도록 종료일을 오늘과 최대 기록일 중 더 늦은 쪽으로 잡는다.
  const end = allDates.length > 0
    ? new Date(Math.max(new Date(`${today}T00:00:00`).getTime(), ...allDates.map((d) => new Date(`${d}T00:00:00`).getTime())))
    : new Date(`${today}T00:00:00`);

  const days = [];
  while (cursor <= end) {
    const key = dateKey(cursor);
    const entries = byDate.pray[key] ? byDate.pray[key].entries : [];
    const verses = byDate.word[key] ? byDate.word[key].verses : [];
    const sessions = byDate.study[key] ? byDate.study[key].sessions : [];
    const worshipRow = byDate.worship[key];

    const prayMin = entries.reduce((s, e) => s + durationMinutes(e.start, e.end), 0);
    const wordMin = verses.length > 0 ? STAT_WORD_VERIFIED_MINUTES : 0;
    const studyMin = Math.round((statGetStudySeconds(sessions, 'record') + statGetStudySeconds(sessions, 'manual')) / 60);
    const worshipMin = worshipRow ? (worshipRow.minutes || 0) : 0;
    const totalMin = prayMin + wordMin + studyMin + worshipMin;

    const verified = {
      pray: entries.length > 0,
      word: verses.length > 0,
      study: sessions.length > 0,
      worship: !!worshipRow && (worshipRow.status === 'attended' || worshipRow.status === 'home')
    };
    const activeCategories = statActiveCategories(key);

    days.push({
      key,
      prayMin,
      wordMin,
      studyMin,
      worshipMin,
      totalMin,
      percent: Math.round((totalMin / STAT_DAILY_GOAL_MINUTES) * 100),
      verified,
      activeCategories,
      completed: activeCategories.every((cat) => verified[cat])
    });

    cursor.setDate(cursor.getDate() + 1);
  }
  return days;
}

// --- 스트릭 (연속 기록) ---

function currentStreak(days) {
  let i = days.length - 1;
  if (i < 0) return 0;
  if (!days[i].completed) i -= 1; // 오늘이 아직 미완료면 오늘은 건너뛰고 어제부터 카운트
  let streak = 0;
  while (i >= 0 && days[i].completed) {
    streak += 1;
    i -= 1;
  }
  return streak;
}

function longestStreak(days) {
  let max = 0;
  let run = 0;
  days.forEach((day) => {
    run = day.completed ? run + 1 : 0;
    if (run > max) max = run;
  });
  return max;
}

// --- 범위 슬라이싱 ---

function sliceWeekly(days) {
  return days.slice(-28);
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
  const avgPercent = days.length > 0 ? Math.round(days.reduce((s, d) => s + d.percent, 0) / days.length) : 0;
  const completedCount = days.filter((d) => d.completed).length;
  const best = days.reduce((acc, d) => (!acc || d.totalMin > acc.totalMin ? d : acc), null);
  return { totalMin, avgPercent, completedCount, totalCount: days.length, best };
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
  if (subEl) subEl.textContent = `${days.filter((d) => d.percent >= 100).length}/${days.length}일 300분 달성`;
}

function renderKpiTiles(days) {
  const stats = computeRangeStats(days);
  const totalEl = document.getElementById('stat-kpi-total');
  const avgEl = document.getElementById('stat-kpi-avg');
  const completedEl = document.getElementById('stat-kpi-completed');
  const bestEl = document.getElementById('stat-kpi-best');

  if (totalEl) totalEl.textContent = formatStatMinutes(stats.totalMin);
  if (avgEl) avgEl.textContent = `${stats.avgPercent}%`;
  if (completedEl) completedEl.textContent = `${stats.completedCount} / ${stats.totalCount}일`;
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

function heatmapIntensityClass(value, maxValue, token) {
  if (value <= 0) return 'bg-surface-container';
  const ratio = maxValue > 0 ? value / maxValue : 0;
  if (ratio > 0.75) return `bg-${token}`;
  if (ratio > 0.5) return `bg-${token}/70`;
  if (ratio > 0.25) return `bg-${token}/45`;
  return `bg-${token}/25`;
}

function heatmapCompletedClass(day) {
  if (day.activeCategories.length === 0) return 'bg-surface-container';
  if (day.completed) return 'bg-gradient-to-br from-primary-container to-tertiary-container';
  if (day.totalMin > 0) return 'bg-primary/25';
  return 'bg-surface-container';
}

function statHeatmapTooltip(day) {
  if (statHeatmapMetric === 'completed') return `${formatStatDateLabel(day.key)} · ${day.completed ? '완료' : `${day.totalMin}분`}`;
  const label = STAT_CATEGORY_LABEL[statHeatmapMetric];
  return `${formatStatDateLabel(day.key)} · ${label} ${day[`${statHeatmapMetric}Min`] || 0}분`;
}

function renderHeatmap(days) {
  const container = document.getElementById('stat-heatmap');
  if (!container) return;

  if (days.length === 0) {
    container.innerHTML = '<p class="text-xs text-on-surface-variant py-6 text-center w-full">표시할 기록이 없어요.</p>';
    return;
  }

  const weeks = groupByWeeks(days);
  const maxValue = statHeatmapMetric === 'completed'
    ? 0
    : Math.max(1, ...days.map((d) => d[`${statHeatmapMetric}Min`] || 0));

  container.innerHTML = weeks.map((week) => `
    <div class="flex flex-col gap-1 shrink-0 w-4">
      ${week.map((day) => {
        if (!day) return '<div class="heatmap-cell bg-transparent"></div>';
        const cls = statHeatmapMetric === 'completed'
          ? heatmapCompletedClass(day)
          : heatmapIntensityClass(day[`${statHeatmapMetric}Min`] || 0, maxValue, STAT_CATEGORY_TOKEN[statHeatmapMetric]);
        return `<div class="heatmap-cell ${cls}" title="${statHeatmapTooltip(day)}"></div>`;
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
          label: '총 활동 시간(분)',
          data: values,
          borderColor: '#b9045e',
          backgroundColor: 'rgba(255,75,145,0.18)',
          fill: true,
          tension: 0.35,
          pointRadius: 2,
          pointBackgroundColor: '#b9045e'
        },
        {
          label: '목표 300분',
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

  const totals = { pray: 0, word: 0, study: 0, worship: 0 };
  days.forEach((d) => {
    totals.pray += d.prayMin;
    totals.word += d.wordMin;
    totals.study += d.studyMin;
    totals.worship += d.worshipMin;
  });
  const dayCount = Math.max(1, days.length);

  if (statRadarChart) statRadarChart.destroy();
  statRadarChart = new Chart(canvas.getContext('2d'), {
    type: 'radar',
    data: {
      labels: ['기도', '말씀', '공부', '예배'],
      datasets: [{
        label: '일 평균(분)',
        data: [totals.pray, totals.word, totals.study, totals.worship].map((v) => Math.round(v / dayCount)),
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

function renderDonutChart(days) {
  const canvas = document.getElementById('stat-donut-chart');
  if (!canvas || typeof Chart === 'undefined') return;

  const totals = { pray: 0, word: 0, study: 0, worship: 0 };
  days.forEach((d) => {
    totals.pray += d.prayMin;
    totals.word += d.wordMin;
    totals.study += d.studyMin;
    totals.worship += d.worshipMin;
  });
  const sum = totals.pray + totals.word + totals.study + totals.worship;

  if (statDonutChart) statDonutChart.destroy();
  statDonutChart = new Chart(canvas.getContext('2d'), {
    type: 'doughnut',
    data: {
      labels: ['기도', '말씀', '공부', '예배'],
      datasets: [{
        data: [totals.pray, totals.word, totals.study, totals.worship],
        backgroundColor: ['#b9045e', '#6e4f9c', '#aa3524', '#146b3a'],
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
    chips.push(statChipHTML('하루 최다 활동', `${formatStatMinutes(overall.totalMin)} · ${formatStatDateLabel(overall.key)}`, 'primary'));
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
  });
}

async function initStatWidgets() {
  wireRangeTabs();
  wireHeatmapMetricTabs();

  const userId = await getCurrentUserId();
  if (!userId) return;

  const history = await fetchFullHistory(userId);
  statFullDays = buildDailySeries(history);

  renderStreakCard(statFullDays);
  renderPersonalBestChips(statFullDays);
  renderRangeDependentViews();
}

window.initStatWidgets = initStatWidgets;
