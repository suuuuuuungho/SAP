// Hall of Fame: 전체누적 랭킹(원래 Board에 있던 것을 이쪽으로 옮김) + 주차별(Week1~4) 랭킹.
// 원본 개인 기록은 읽지 않고 SECURITY DEFINER RPC의 집계 결과만 사용한다.

const HOF_REFRESH_MS = 5 * 60 * 1000;
const HOF_RANKING_META = {
  total: { title: 'Overall', description: '기도 · 공부 · 말씀 · 예배 합산', icon: 'fa-solid fa-trophy', accent: 'text-primary' },
  pray: { title: 'Prayer', description: '누적 기도 시간', icon: 'fa-solid fa-hands-praying', accent: 'text-primary' },
  study: { title: 'Study', description: '누적 공부 시간', icon: 'fa-solid fa-book-open', accent: 'text-tertiary' },
  word: { title: 'Word', description: '누적 말씀 묵상 시간', icon: 'fa-solid fa-book-bible', accent: 'text-secondary' }
};

const HOF_PROGRAM_START = '2026-08-10';
const HOF_PROGRAM_END = '2026-09-06';
const HOF_GROWTH_CATEGORIES = ['pray', 'word', 'study'];
const HOF_GROWTH_META = {
  pray: { title: 'Prayer', ko: '기도', icon: 'fa-solid fa-hands-praying', gradient: 'from-pink-500 to-rose-400', tint: 'bg-pink-500/10 text-pink-600' },
  word: { title: 'Word', ko: '말씀', icon: 'fa-solid fa-book-bible', gradient: 'from-violet-500 to-indigo-400', tint: 'bg-violet-500/10 text-violet-600' },
  study: { title: 'Study', ko: '공부', icon: 'fa-solid fa-book-open', gradient: 'from-orange-500 to-amber-400', tint: 'bg-orange-500/10 text-orange-600' }
};

let hofCurrentUserId = null;
let hofRefreshTimer = null;
let hofAvatarUrls = {};
let hofProfiles = {};
let hofActiveTab = 'total';

// 오늘 날짜가 속한 주차를 기본 탭으로 연다 (예: 8/18 -> Week2). 운영기간 시작 전이면
// Week1, 운영기간이 끝났으면 전체누적을 기본으로 보여준다.
function hofDefaultTab() {
  const now = new Date();
  const todayKey = new Date(now.getTime() - now.getTimezoneOffset() * 60000).toISOString().slice(0, 10);
  if (todayKey < HOF_PROGRAM_START) return '1';
  if (todayKey > HOF_PROGRAM_END) return 'total';
  const diffDays = Math.round((new Date(`${todayKey}T00:00:00`) - new Date(`${HOF_PROGRAM_START}T00:00:00`)) / 86400000);
  const week = Math.floor(diffDays / 7) + 1;
  return String(Math.max(1, Math.min(4, week)));
}

function hofGrowthPeriod() {
  const now = new Date();
  const localToday = new Date(now.getTime() - now.getTimezoneOffset() * 60000).toISOString().slice(0, 10);
  if (localToday < HOF_PROGRAM_START) return { week: 1, elapsed: 1, beforeStart: true, afterEnd: false };
  const clamped = localToday > HOF_PROGRAM_END ? HOF_PROGRAM_END : localToday;
  const diffDays = Math.floor((new Date(`${clamped}T12:00:00`) - new Date(`${HOF_PROGRAM_START}T12:00:00`)) / 86400000);
  return { week: Math.max(1, Math.min(4, Math.floor(diffDays / 7) + 1)), elapsed: Math.max(1, Math.min(5, (diffDays % 7) + 1)), beforeStart: false, afterEnd: localToday > HOF_PROGRAM_END };
}

function hofPeriodForActiveTab(currentPeriod) {
  if (hofActiveTab === 'total') return { ...currentPeriod, isFuture: false, showGrowth: false };
  const selectedWeek = Number(hofActiveTab);
  const isFuture = currentPeriod.beforeStart || (!currentPeriod.afterEnd && selectedWeek > currentPeriod.week);
  return {
    week: selectedWeek,
    elapsed: selectedWeek === currentPeriod.week ? currentPeriod.elapsed : 5,
    isFuture,
    showGrowth: true
  };
}

function hofEscape(value) {
  return String(value == null ? '' : value)
    .replaceAll('&', '&amp;').replaceAll('<', '&lt;').replaceAll('>', '&gt;')
    .replaceAll('"', '&quot;').replaceAll("'", '&#039;');
}

function hofFormatMinutes(minutes) {
  const value = Number(minutes) || 0;
  if (value < 60) return `${value}분`;
  const hours = Math.floor(value / 60);
  const rest = value % 60;
  return rest ? `${hours}시간 ${rest}분` : `${hours}시간`;
}

function hofAvatar(userId, name) {
  const photoUrl = hofAvatarUrls[userId];
  if (photoUrl) {
    return `<div class="w-9 h-9 rounded-full overflow-hidden bg-surface-container flex-shrink-0"><img src="${hofEscape(photoUrl)}" loading="lazy" decoding="async" alt="" class="w-full h-full object-cover"></div>`;
  }
  const initial = hofEscape((name || '?').charAt(0));
  return `<div class="w-9 h-9 rounded-full bg-gradient-to-br from-primary-container to-tertiary-container text-white flex items-center justify-center font-bold text-sm flex-shrink-0">${initial}</div>`;
}

function hofRankingRows(rows, category) {
  const categoryRows = rows.filter((row) => row.category === category);
  if (categoryRows.length === 0) {
    return '<div class="py-8 text-center text-sm text-on-surface-variant">아직 집계된 기록이 없어요.</div>';
  }
  return categoryRows.map((row) => {
    const isMe = row.user_id === hofCurrentUserId;
    const medal = row.rank_no <= 3 ? ['🥇', '🥈', '🥉'][row.rank_no - 1] : String(row.rank_no);
    const badgeProfile = hofProfiles[row.user_id];
    const badge = window.publicProfileBadgeHTML ? window.publicProfileBadgeHTML(badgeProfile?.badge_role, badgeProfile?.is_host) : '';
    return `
      <div class="flex items-center gap-3 py-3 ${row.rank_no !== categoryRows.length ? 'border-b border-outline-variant/35' : ''} ${isMe ? 'bg-primary/5 -mx-3 px-3 rounded-xl' : ''}">
        <div class="w-7 text-center text-sm font-bold">${medal}</div>
        ${hofAvatar(row.user_id, row.name)}
        <div class="min-w-0 flex-1">
          <p class="text-sm font-semibold truncate">${hofEscape(row.name)}${badge}${isMe ? ' <span class="text-[10px] text-primary">ME</span>' : ''}</p>
          <p class="text-[11px] text-on-surface-variant truncate">@${hofEscape(row.username)}</p>
        </div>
        <p class="text-sm font-bold text-on-surface whitespace-nowrap">${hofFormatMinutes(row.minutes)}</p>
      </div>`;
  }).join('');
}

function renderHofRankings(rows, period) {
  const wrap = document.getElementById('hof-ranking-grid');
  if (!wrap) return;
  if (period.isFuture) {
    wrap.innerHTML = `<div class="glass-card rounded-[1.5rem] p-10 text-center lg:col-span-2"><i class="fa-regular fa-calendar-xmark text-3xl text-on-surface-variant mb-3"></i><p class="font-bold">Week ${period.week}는 아직 시작 전이에요</p><p class="text-xs text-on-surface-variant mt-1">해당 주차가 시작되면 랭킹이 표시됩니다.</p></div>`;
    return;
  }
  wrap.innerHTML = ['total', 'pray', 'study', 'word'].map((category) => {
    const meta = HOF_RANKING_META[category];
    return `
      <section class="glass-card rounded-[1.5rem] p-5 ${category === 'total' ? 'lg:col-span-2' : ''}">
        <div class="flex items-start justify-between gap-3 mb-3">
          <div>
            <h2 class="text-lg font-bold">${meta.title}</h2>
            <p class="text-xs text-on-surface-variant">${meta.description}</p>
          </div>
          <div class="icon-glass w-10 h-10 rounded-full flex items-center justify-center ${meta.accent}"><i class="${meta.icon}"></i></div>
        </div>
        <div>${hofRankingRows(rows, category)}</div>
      </section>`;
  }).join('');
}

function hofGrowthRows(rows, category, comparison) {
  const categoryRows = rows.filter((row) => row.category === category && row.comparison_type === comparison);
  if (!categoryRows.length) return '<div class="h-32 flex items-center justify-center text-center text-xs text-on-surface-variant px-4">아직 상승률을 계산할 수 있는 기록이 없어요.</div>';
  const maxRate = Math.max(...categoryRows.map((row) => Number(row.growth_rate) || 0), 1);
  return categoryRows.map((row, index) => {
    const rate = Number(row.growth_rate) || 0;
    const width = Math.max(12, Math.round((rate / maxRate) * 100));
    const isMe = row.user_id === hofCurrentUserId;
    const medal = index < 3 ? ['🥇', '🥈', '🥉'][index] : `${index + 1}`;
    return `<div class="relative py-3 ${index ? 'border-t border-outline-variant/30' : ''} ${isMe ? 'bg-primary/5 -mx-2 px-2 rounded-xl' : ''}">
      <div class="flex items-center gap-2.5 relative z-10">
        <span class="w-6 text-center text-sm font-bold">${medal}</span>${hofAvatar(row.user_id, row.name)}
        <div class="min-w-0 flex-1"><p class="text-xs font-bold truncate">${hofEscape(row.name)}${isMe ? ' <span class="text-[9px] text-primary">ME</span>' : ''}</p></div>
        <div class="text-right"><p class="text-sm font-black text-quaternary">+${rate.toLocaleString('ko-KR')}%</p><i class="fa-solid fa-arrow-trend-up text-[10px] text-quaternary"></i></div>
      </div>
      <div class="ml-[4.625rem] mt-2 h-1.5 rounded-full bg-surface-container overflow-hidden"><div class="h-full rounded-full bg-gradient-to-r ${HOF_GROWTH_META[category].gradient}" style="width:${width}%"></div></div>
    </div>`;
  }).join('');
}

function renderHofGrowth(rows, period) {
  const section = document.getElementById('hof-growth-section');
  const wrap = document.getElementById('hof-growth-grid');
  const periodEl = document.getElementById('hof-growth-period');
  const canShowGrowth = period.showGrowth !== false && !period.isFuture && period.week > 1;
  if (section) section.classList.toggle('hidden', !canShowGrowth);
  if (!canShowGrowth) {
    if (wrap) wrap.innerHTML = '';
    return;
  }
  if (periodEl) periodEl.innerHTML = period.isFuture
    ? `<i class="fa-regular fa-calendar mr-1.5 text-primary"></i>Week ${period.week} · 시작 전`
    : `<i class="fa-regular fa-calendar mr-1.5 text-primary"></i>Week ${period.week} · ${period.elapsed}일차 기준`;
  if (!wrap) return;
  wrap.innerHTML = HOF_GROWTH_CATEGORIES.map((category) => {
    const meta = HOF_GROWTH_META[category];
    return `<article class="glass-card rounded-[1.5rem] p-4 sm:p-5 overflow-hidden">
      <header class="flex items-center justify-between gap-3 mb-4"><div class="flex items-center gap-3"><span class="w-10 h-10 rounded-xl ${meta.tint} flex items-center justify-center"><i class="${meta.icon}"></i></span><div><h3 class="font-bold">${meta.title}</h3><p class="text-[10px] text-on-surface-variant">${meta.ko} 활동시간 성장률</p></div></div><span class="text-[10px] font-bold text-quaternary"><i class="fa-solid fa-sparkles mr-1"></i>TOP 5</span></header>
      <div class="grid grid-cols-1 sm:grid-cols-2 gap-3">
        <section class="rounded-2xl bg-white/55 border border-white/70 p-3"><div class="flex items-center justify-between gap-2 mb-1"><p class="text-[11px] font-bold">지난주 대비</p><span class="text-[9px] text-on-surface-variant">W${period.week - 1} → W${period.week}</span></div>${hofGrowthRows(rows, category, 'previous')}</section>
        <section class="rounded-2xl bg-white/55 border border-white/70 p-3"><div class="flex items-center justify-between gap-2 mb-1"><p class="text-[11px] font-bold">첫 주 대비</p><span class="text-[9px] text-on-surface-variant">W1 → W${period.week}</span></div>${hofGrowthRows(rows, category, 'first')}</section>
      </div>
    </article>`;
  }).join('');
}

async function loadHofGrowthRows(period) {
  if (period.showGrowth === false || period.isFuture || period.week <= 1) return [];
  const { data, error } = await window.supabaseClient.rpc('get_hof_growth_rankings', { week_no: period.week, elapsed_weekdays: period.elapsed });
  if (error) { console.error('[hall-of-fame] growth rankings', error); return []; }
  return data || [];
}

async function loadHofTabRows(tab, period) {
  if (period.isFuture) return [];
  const { data, error } = tab === 'total'
    ? await window.supabaseClient.rpc('get_home_rankings')
    : await window.supabaseClient.rpc('get_home_rankings_by_week', { week_no: Number(tab) });
  if (error) { console.error('[hall-of-fame] rankings', tab, error); return []; }
  return data || [];
}

async function refreshHofActiveTab() {
  const currentPeriod = hofGrowthPeriod();
  const growthPeriod = hofPeriodForActiveTab(currentPeriod);
  const [rows, growthRows] = await Promise.all([loadHofTabRows(hofActiveTab, growthPeriod), loadHofGrowthRows(growthPeriod)]);
  const profileIds = [...new Set([...rows, ...growthRows].map((row) => row.user_id))];
  hofProfiles = window.getPublicProfileCards ? await window.getPublicProfileCards(profileIds) : {};
  hofAvatarUrls = Object.fromEntries(Object.entries(hofProfiles).map(([id, profile]) => [id, profile.avatarUrl || '']));
  renderHofRankings(rows, growthPeriod);
  renderHofGrowth(growthRows, growthPeriod);
  const refreshed = document.getElementById('hof-last-refreshed');
  if (refreshed) refreshed.textContent = `${new Date().toLocaleTimeString('ko-KR', { hour: '2-digit', minute: '2-digit', second: '2-digit' })} 업데이트`;
}

function applyHofTabStyles() {
  const currentPeriod = hofGrowthPeriod();
  document.querySelectorAll('[data-hof-tab]').forEach((btn) => {
    const active = btn.dataset.hofTab === hofActiveTab;
    const selectedWeek = Number(btn.dataset.hofTab);
    const isFutureWeek = Number.isFinite(selectedWeek) && !currentPeriod.afterEnd && selectedWeek > currentPeriod.week;
    btn.disabled = isFutureWeek;
    btn.setAttribute('aria-disabled', String(isFutureWeek));
    btn.classList.toggle('opacity-35', isFutureWeek);
    btn.classList.toggle('cursor-not-allowed', isFutureWeek);
    btn.classList.toggle('nav-pill-active', active);
    btn.classList.toggle('text-on-surface-variant', !active);
  });
}

function wireHofTabs() {
  document.querySelectorAll('[data-hof-tab]').forEach((btn) => {
    btn.addEventListener('click', () => {
      if (btn.disabled || btn.dataset.hofTab === hofActiveTab) return;
      hofActiveTab = btn.dataset.hofTab;
      applyHofTabStyles();
      refreshHofActiveTab();
    });
  });
}

async function initHallOfFameWidgets() {
  const { data: { session } } = await window.supabaseClient.auth.getSession();
  hofCurrentUserId = session ? session.user.id : null;
  hofActiveTab = hofDefaultTab();
  applyHofTabStyles();
  wireHofTabs();
  await refreshHofActiveTab();
  if (hofRefreshTimer) clearInterval(hofRefreshTimer);
  hofRefreshTimer = setInterval(() => {
    if (document.visibilityState === 'visible') refreshHofActiveTab();
  }, HOF_REFRESH_MS);
}

window.initHallOfFameWidgets = initHallOfFameWidgets;
