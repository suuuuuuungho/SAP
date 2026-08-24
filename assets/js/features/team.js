// Team 탭: 팀별 활동 시간 스택 차트(기도/말씀/공부/예배, 막대 위에 합계 표시) + 팀 명단
// (팀장/부팀장 배지, 팀별 기여도 Top3에게 순위·비중(%) 표시).
// Week1~4 + 전체누적 탭 — 기본값은 Hall of Fame과 동일한 규칙으로 "현재 날짜가 속한 주"를 연다.
// home.js는 로드하지 않는다(다른 탭과 동일한 이유 — layout.js의 renderApp()이 initHomeWidgets를
// 페이지 구분 없이 호출하기 때문).

const TEAM_PROGRAM_START = '2026-08-10';
const TEAM_PROGRAM_END = '2026-09-06';

let teamActiveTab = 'total'; // '1' | '2' | '3' | '4' | 'total'
let teamTotalsChart = null;
let teamRosterRows = [];       // get_team_roster() 결과 — 탭과 무관, 최초 1회만 로드
let teamRosterAvatarUrls = {};

// 오늘 날짜가 속한 주차를 기본 탭으로 연다 — hall-of-fame.js의 hofDefaultTab()과 동일한 규칙.
function teamDefaultTab() {
  const now = new Date();
  const todayKey = new Date(now.getTime() - now.getTimezoneOffset() * 60000).toISOString().slice(0, 10);
  if (todayKey < TEAM_PROGRAM_START) return '1';
  if (todayKey > TEAM_PROGRAM_END) return 'total';
  const diffDays = Math.round((new Date(`${todayKey}T00:00:00`) - new Date(`${TEAM_PROGRAM_START}T00:00:00`)) / 86400000);
  const week = Math.floor(diffDays / 7) + 1;
  return String(Math.max(1, Math.min(4, week)));
}

function weekNoForTab(tab) {
  return tab === 'total' ? null : Number(tab);
}

const teamEscape = escapeHTML;

function teamFormatMinutes(minutes) {
  const value = Math.round(Number(minutes) || 0);
  if (value < 60) return `${value}분`;
  const hours = Math.floor(value / 60);
  const rest = value % 60;
  return rest ? `${hours}시간 ${rest}분` : `${hours}시간`;
}

// 팀장/부팀장을 다른 학생과 구분하는 배지 — 아이디(@username) 옆에 붙는다.
function teamRoleBadgeHTML(role) {
  if (role === 'leader') return '<span class="inline-flex items-center gap-1 text-[10px] font-bold text-amber-700 bg-amber-100 rounded-full px-2 py-0.5 ml-1.5 align-middle whitespace-nowrap"><i class="fa-solid fa-crown"></i>팀장</span>';
  if (role === 'vice_leader') return '<span class="inline-flex items-center gap-1 text-[10px] font-bold text-sky-700 bg-sky-100 rounded-full px-2 py-0.5 ml-1.5 align-middle whitespace-nowrap"><i class="fa-solid fa-star"></i>부팀장</span>';
  return '';
}

const TEAM_CONTRIBUTION_MEDALS = { 1: '🥇', 2: '🥈', 3: '🥉' };

function teamAvatar(userId, name, avatarUrls) {
  const photoUrl = avatarUrls[userId];
  if (photoUrl) {
    return `<div class="w-9 h-9 rounded-full overflow-hidden bg-surface-container flex-shrink-0"><img src="${teamEscape(photoUrl)}" loading="lazy" decoding="async" alt="" class="w-full h-full object-cover"></div>`;
  }
  const initial = teamEscape((name || '?').charAt(0));
  return `<div class="w-9 h-9 rounded-full bg-gradient-to-br from-primary-container to-tertiary-container text-white flex items-center justify-center font-bold text-sm flex-shrink-0">${initial}</div>`;
}

function groupByTeam(rows) {
  const map = new Map();
  rows.forEach((row) => {
    if (!map.has(row.team_id)) map.set(row.team_id, { team_id: row.team_id, team_name: row.team_name, items: [] });
    map.get(row.team_id).items.push(row);
  });
  return [...map.values()];
}

// --- 탭 wiring ---

function applyTeamTabStyles() {
  document.querySelectorAll('[data-team-tab]').forEach((btn) => {
    const active = btn.dataset.teamTab === teamActiveTab;
    btn.classList.toggle('nav-pill-active', active);
    btn.classList.toggle('text-on-surface-variant', !active);
  });
}

function wireTeamTabs() {
  document.querySelectorAll('[data-team-tab]').forEach((btn) => {
    btn.addEventListener('click', () => {
      if (btn.dataset.teamTab === teamActiveTab) return;
      teamActiveTab = btn.dataset.teamTab;
      applyTeamTabStyles();
      refreshTeamPeriodViews();
    });
  });
}

// --- 팀 명단 (팀장/부팀장 배지 + 팀별 기여도 Top3 순위·비중) ---

function teamRosterCardHTML(team, avatarUrls, contributionMap) {
  const rows = team.items.map((member) => {
    const contribution = contributionMap[member.user_id];
    const contributionHTML = contribution ? `
      <div class="text-right flex-shrink-0">
        <p class="text-xs font-bold text-primary whitespace-nowrap">${TEAM_CONTRIBUTION_MEDALS[contribution.rankNo]} ${contribution.rankNo}위</p>
        <p class="text-[10px] text-on-surface-variant">${contribution.percent}%</p>
      </div>` : '';
    return `
      <div class="flex items-center gap-3 py-2.5 border-b border-outline-variant/30 last:border-b-0">
        ${teamAvatar(member.user_id, member.name, avatarUrls)}
        <div class="min-w-0 flex-1">
          <p class="text-sm font-semibold truncate">${teamEscape(member.name)}${teamRoleBadgeHTML(member.team_role)}</p>
          <p class="text-[11px] text-on-surface-variant truncate">@${teamEscape(member.username)}${member.grade_class ? ` · ${teamEscape(member.grade_class)}` : ''}</p>
        </div>
        ${contributionHTML}
      </div>`;
  }).join('');
  return `
    <section class="glass-card rounded-[1.5rem] p-5">
      <div class="flex items-center justify-between gap-3 mb-2">
        <h3 class="text-lg font-bold">${teamEscape(team.team_name)}</h3>
        <span class="text-xs text-on-surface-variant">${team.items.length}명</span>
      </div>
      <div>${rows || '<p class="text-sm text-on-surface-variant py-4 text-center">팀원이 없어요.</p>'}</div>
    </section>`;
}

function renderTeamRosterGrid(rows, avatarUrls, contributionMap) {
  const wrap = document.getElementById('team-roster-grid');
  if (!wrap) return;
  const teams = groupByTeam(rows);
  wrap.innerHTML = teams.length
    ? teams.map((team) => teamRosterCardHTML(team, avatarUrls, contributionMap)).join('')
    : '<p class="glass-card rounded-2xl p-8 text-sm text-center text-on-surface-variant col-span-full">아직 구성된 팀이 없어요.</p>';
}

async function loadTeamRoster() {
  const { data, error } = await window.supabaseClient.rpc('get_team_roster');
  if (error) { console.error('[team] get_team_roster', error); return []; }
  return data || [];
}

// --- 팀별 활동 시간 스택 차트 (기도/말씀/공부/예배) ---

// 스택 맨 위(마지막 데이터셋) 막대 바로 위에 그 팀의 총 합계 시간을 그려 넣는 Chart.js 플러그인.
const teamTotalsLabelPlugin = {
  id: 'teamTotalsLabelPlugin',
  afterDatasetsDraw(chart) {
    const { ctx, data } = chart;
    const topMeta = chart.getDatasetMeta(data.datasets.length - 1);
    ctx.save();
    ctx.font = "bold 11px 'Pretendard', sans-serif";
    ctx.fillStyle = '#4b3f3f';
    ctx.textAlign = 'center';
    topMeta.data.forEach((bar, index) => {
      const total = data.datasets.reduce((sum, ds) => sum + (Number(ds.data[index]) || 0), 0);
      if (!total) return;
      ctx.fillText(teamFormatMinutes(total), bar.x, bar.y - 6);
    });
    ctx.restore();
  }
};

function renderTeamTotalsChart(rows) {
  const canvas = document.getElementById('team-totals-chart');
  if (!canvas || typeof Chart === 'undefined') return;
  const labels = rows.map((row) => row.team_name);
  if (teamTotalsChart) teamTotalsChart.destroy();
  teamTotalsChart = new Chart(canvas.getContext('2d'), {
    type: 'bar',
    data: {
      labels,
      datasets: [
        { label: '기도', data: rows.map((row) => row.pray_minutes), backgroundColor: '#ec4899', maxBarThickness: 48 },
        { label: '말씀', data: rows.map((row) => row.word_minutes), backgroundColor: '#6366f1', maxBarThickness: 48 },
        { label: '공부', data: rows.map((row) => row.study_minutes), backgroundColor: '#f97316', maxBarThickness: 48 },
        { label: '예배', data: rows.map((row) => row.worship_minutes), backgroundColor: '#14b8a6', borderRadius: { topLeft: 6, topRight: 6 }, maxBarThickness: 48 }
      ]
    },
    plugins: [teamTotalsLabelPlugin],
    options: {
      maintainAspectRatio: false,
      layout: { padding: { top: 24 } },
      plugins: {
        legend: { labels: { font: { family: 'Pretendard' }, boxWidth: 12 } },
        tooltip: { callbacks: { label: (ctx) => `${ctx.dataset.label}: ${teamFormatMinutes(ctx.parsed.y)}` } }
      },
      scales: {
        x: { stacked: true, grid: { display: false }, ticks: { font: { family: 'Pretendard' } } },
        y: { stacked: true, beginAtZero: true, ticks: { callback: (value) => teamFormatMinutes(value), font: { family: 'Pretendard', size: 10 } } }
      }
    }
  });
}

async function loadTeamTotals(weekNo) {
  const { data, error } = await window.supabaseClient.rpc('get_team_totals', { week_no: weekNo });
  if (error) { console.error('[team] get_team_totals', error); return []; }
  return data || [];
}

async function loadTeamContributionTop3(weekNo) {
  const { data, error } = await window.supabaseClient.rpc('get_team_contribution_top3', { week_no: weekNo });
  if (error) { console.error('[team] get_team_contribution_top3', error); return []; }
  return data || [];
}

// --- 진입점 ---

// 기여도 Top3(rank_no, total_minutes)와 팀 총 활동시간(기도+말씀+공부+예배)을 합쳐,
// 팀 명단에 표시할 "순위 · 팀 내 비중(%)" 맵을 만든다.
function buildContributionMap(totalsRows, top3Rows) {
  const totalsByTeam = Object.fromEntries(totalsRows.map((row) => [row.team_id, row]));
  const map = {};
  top3Rows.forEach((row) => {
    const teamTotal = totalsByTeam[row.team_id];
    const denom = teamTotal ? (teamTotal.pray_minutes + teamTotal.word_minutes + teamTotal.study_minutes + teamTotal.worship_minutes) : 0;
    // 팀 합산 활동 시간이 0이면(아직 아무도 인증하지 않은 주 등) 순위가 의미 없으므로
    // 메달을 아예 달지 않는다.
    if (denom <= 0) return;
    map[row.user_id] = { rankNo: row.rank_no, percent: Math.round((row.total_minutes / denom) * 100) };
  });
  return map;
}

async function refreshTeamPeriodViews() {
  const weekNo = weekNoForTab(teamActiveTab);
  const [totalsRows, top3Rows] = await Promise.all([loadTeamTotals(weekNo), loadTeamContributionTop3(weekNo)]);
  renderTeamTotalsChart(totalsRows);
  renderTeamRosterGrid(teamRosterRows, teamRosterAvatarUrls, buildContributionMap(totalsRows, top3Rows));
}

async function initTeamWidgets() {
  wireTeamTabs();
  teamActiveTab = teamDefaultTab();
  applyTeamTabStyles();

  teamRosterRows = await loadTeamRoster();
  teamRosterAvatarUrls = window.getProfileAvatarUrls ? await window.getProfileAvatarUrls(teamRosterRows.map((row) => row.user_id)) : {};

  await refreshTeamPeriodViews();
}

window.initTeamWidgets = initTeamWidgets;
