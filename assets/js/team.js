// Team 탭: 팀별 활동 시간 차트(기도/말씀/공부) + 팀별 기여도 Top3 "wagon" 그래픽 + 팀 명단(팀장/부팀장 배지).
// Week1~4 + 전체누적 탭 — 기본값은 Hall of Fame과 동일한 규칙으로 "현재 날짜가 속한 주"를 연다.
// home.js는 로드하지 않는다(다른 탭과 동일한 이유 — layout.js의 renderApp()이 initHomeWidgets를
// 페이지 구분 없이 호출하기 때문).

const TEAM_PROGRAM_START = '2026-08-10';
const TEAM_PROGRAM_END = '2026-09-06';

let teamActiveTab = 'total'; // '1' | '2' | '3' | '4' | 'total'
let teamTotalsChart = null;

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

function teamEscape(value) {
  return String(value == null ? '' : value)
    .replaceAll('&', '&amp;').replaceAll('<', '&lt;').replaceAll('>', '&gt;')
    .replaceAll('"', '&quot;').replaceAll("'", '&#039;');
}

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

// --- 팀 명단(팀장/부팀장 배지) ---

function teamRosterCardHTML(team, avatarUrls) {
  const rows = team.items.map((member) => `
    <div class="flex items-center gap-3 py-2.5 border-b border-outline-variant/30 last:border-b-0">
      ${teamAvatar(member.user_id, member.name, avatarUrls)}
      <div class="min-w-0 flex-1">
        <p class="text-sm font-semibold truncate">${teamEscape(member.name)}${teamRoleBadgeHTML(member.team_role)}</p>
        <p class="text-[11px] text-on-surface-variant truncate">@${teamEscape(member.username)}${member.grade_class ? ` · ${teamEscape(member.grade_class)}` : ''}</p>
      </div>
    </div>`).join('');
  return `
    <section class="glass-card rounded-[1.5rem] p-5">
      <div class="flex items-center justify-between gap-3 mb-2">
        <h3 class="text-lg font-bold">${teamEscape(team.team_name)}</h3>
        <span class="text-xs text-on-surface-variant">${team.items.length}명</span>
      </div>
      <div>${rows || '<p class="text-sm text-on-surface-variant py-4 text-center">팀원이 없어요.</p>'}</div>
    </section>`;
}

function renderTeamRosterGrid(rows, avatarUrls) {
  const wrap = document.getElementById('team-roster-grid');
  if (!wrap) return;
  const teams = groupByTeam(rows);
  wrap.innerHTML = teams.length
    ? teams.map((team) => teamRosterCardHTML(team, avatarUrls)).join('')
    : '<p class="glass-card rounded-2xl p-8 text-sm text-center text-on-surface-variant col-span-full">아직 구성된 팀이 없어요.</p>';
}

async function loadTeamRoster() {
  const { data, error } = await window.supabaseClient.rpc('get_team_roster');
  if (error) { console.error('[team] get_team_roster', error); return []; }
  return data || [];
}

// --- 팀별 활동 시간 차트 (기도/말씀/공부) ---

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
        { label: '기도', data: rows.map((row) => row.pray_minutes), backgroundColor: '#ec4899', borderRadius: 6, maxBarThickness: 48 },
        { label: '말씀', data: rows.map((row) => row.word_minutes), backgroundColor: '#6366f1', borderRadius: 6, maxBarThickness: 48 },
        { label: '공부', data: rows.map((row) => row.study_minutes), backgroundColor: '#f97316', borderRadius: 6, maxBarThickness: 48 }
      ]
    },
    options: {
      maintainAspectRatio: false,
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

// --- 팀별 기여도 Top3 "wagon" 그래픽 ---
// 개인 식별은 실제 사진이 아니라 요청대로 원형 placeholder(사람 아이콘)로 표시한다.
// 1·2·3위가 서로 이어지는 게 아니라, 각자의 밧줄이 wagon 한 곳(hitch)에 따로 모이는 모양으로 그린다.
// 배경 SVG(밧줄+wagon)와 HTML 원형 placeholder를 같은 좌표계(고정 aspect-ratio 컨테이너)에 겹쳐서
// 정확히 맞아떨어지게 한다.

const TEAM_WAGON_MEDALS = { 1: '🥇', 2: '🥈', 3: '🥉' };
const TEAM_WAGON_VIEWBOX = { width: 460, height: 180 };
const TEAM_WAGON_HITCH = { x: 398, y: 94 };
// rankNo별: 밧줄이 시작되는 y좌표(행 높이), 밧줄 시작 x(placeholder 오른쪽 끝 근처), 밧줄 굵기, placeholder 크기.
const TEAM_WAGON_ROWS = {
  1: { y: 38, ropeStartX: 66, ropeWidth: 5, circleSize: 'w-14 h-14', iconSize: 'text-2xl' },
  2: { y: 94, ropeStartX: 62, ropeWidth: 4, circleSize: 'w-12 h-12', iconSize: 'text-xl' },
  3: { y: 150, ropeStartX: 58, ropeWidth: 3, circleSize: 'w-11 h-11', iconSize: 'text-lg' }
};

function teamWagonSVG(byRank) {
  const ropes = [1, 2, 3].map((rankNo) => {
    if (!byRank[rankNo]) return '';
    const row = TEAM_WAGON_ROWS[rankNo];
    return `<line x1="${row.ropeStartX}" y1="${row.y}" x2="${TEAM_WAGON_HITCH.x}" y2="${TEAM_WAGON_HITCH.y}" stroke="#b08968" stroke-width="${row.ropeWidth}" stroke-linecap="round" />`;
  }).join('');
  const wagon = `
    <g>
      <rect x="402" y="76" width="50" height="32" rx="8" fill="#c98a4b" />
      <rect x="402" y="76" width="50" height="8" rx="4" fill="#e0a86a" />
      <circle cx="416" cy="112" r="10" fill="#4b3621" />
      <circle cx="416" cy="112" r="4" fill="#c9b79c" />
      <circle cx="440" cy="112" r="10" fill="#4b3621" />
      <circle cx="440" cy="112" r="4" fill="#c9b79c" />
    </g>`;
  return `<svg viewBox="0 0 ${TEAM_WAGON_VIEWBOX.width} ${TEAM_WAGON_VIEWBOX.height}" class="absolute inset-0 w-full h-full" preserveAspectRatio="none" aria-hidden="true" focusable="false">${ropes}${wagon}</svg>`;
}

function teamWagonMemberRowHTML(member) {
  const row = TEAM_WAGON_ROWS[member.rank_no];
  const topPct = (row.y / TEAM_WAGON_VIEWBOX.height * 100).toFixed(2);
  return `
    <div class="absolute left-0 flex items-center gap-2" style="top:${topPct}%; transform: translateY(-50%); max-width: 60%;">
      <div class="relative flex-shrink-0">
        <div class="${row.circleSize} rounded-full bg-gradient-to-br from-primary-container to-tertiary-container text-white flex items-center justify-center ring-4 ring-white shadow-md">
          <i class="fa-solid fa-user ${row.iconSize}"></i>
        </div>
        <span class="absolute -top-1.5 -right-1 text-base leading-none">${TEAM_WAGON_MEDALS[member.rank_no]}</span>
      </div>
      <div class="min-w-0">
        <p class="text-xs font-bold text-on-surface truncate">${teamEscape(member.name)}</p>
        <p class="text-[10px] text-on-surface-variant truncate">@${teamEscape(member.username)}</p>
      </div>
    </div>`;
}

function teamWagonCardHTML(team) {
  const byRank = Object.fromEntries(team.items.map((member) => [member.rank_no, member]));
  const hasAny = [1, 2, 3].some((rankNo) => byRank[rankNo]);
  return `
    <section class="glass-card rounded-[1.5rem] p-5">
      <h3 class="text-lg font-bold mb-3">${teamEscape(team.team_name)}</h3>
      ${hasAny ? `
        <div class="relative w-full" style="aspect-ratio: ${TEAM_WAGON_VIEWBOX.width} / ${TEAM_WAGON_VIEWBOX.height};">
          ${teamWagonSVG(byRank)}
          ${[1, 2, 3].map((rankNo) => byRank[rankNo] ? teamWagonMemberRowHTML(byRank[rankNo]) : '').join('')}
        </div>` : '<div class="py-8 text-center text-sm text-on-surface-variant">아직 집계된 기록이 없어요.</div>'}
    </section>`;
}

function renderTeamWagonGrid(rows) {
  const wrap = document.getElementById('team-wagon-grid');
  if (!wrap) return;
  const teams = groupByTeam(rows);
  wrap.innerHTML = teams.length
    ? teams.map((team) => teamWagonCardHTML(team)).join('')
    : '<p class="glass-card rounded-2xl p-8 text-sm text-center text-on-surface-variant col-span-full">아직 구성된 팀이 없어요.</p>';
}

async function loadTeamContributionTop3(weekNo) {
  const { data, error } = await window.supabaseClient.rpc('get_team_contribution_top3', { week_no: weekNo });
  if (error) { console.error('[team] get_team_contribution_top3', error); return []; }
  return data || [];
}

// --- 진입점 ---

async function refreshTeamPeriodViews() {
  const weekNo = weekNoForTab(teamActiveTab);
  const [totalsRows, wagonRows] = await Promise.all([loadTeamTotals(weekNo), loadTeamContributionTop3(weekNo)]);
  renderTeamTotalsChart(totalsRows);
  renderTeamWagonGrid(wagonRows);
}

async function initTeamWidgets() {
  wireTeamTabs();
  teamActiveTab = teamDefaultTab();
  applyTeamTabStyles();

  const rosterRows = await loadTeamRoster();
  const avatarUrls = window.getProfileAvatarUrls ? await window.getProfileAvatarUrls(rosterRows.map((row) => row.user_id)) : {};
  renderTeamRosterGrid(rosterRows, avatarUrls);

  await refreshTeamPeriodViews();
}

window.initTeamWidgets = initTeamWidgets;
