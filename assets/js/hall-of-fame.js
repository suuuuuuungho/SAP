// Hall of Fame: 전체누적 랭킹(원래 Board에 있던 것을 이쪽으로 옮김) + 주차별(Week1~4) 랭킹.
// 원본 개인 기록은 읽지 않고 SECURITY DEFINER RPC의 집계 결과만 사용한다.

const HOF_REFRESH_MS = 30000;
const HOF_RANKING_META = {
  total: { title: 'Overall', description: '기도 · 공부 · 말씀 · 예배 합산', icon: 'fa-solid fa-trophy', accent: 'text-primary' },
  pray: { title: 'Prayer', description: '누적 기도 시간', icon: 'fa-solid fa-hands-praying', accent: 'text-primary' },
  study: { title: 'Study', description: '누적 공부 시간', icon: 'fa-solid fa-book-open', accent: 'text-tertiary' },
  word: { title: 'Word', description: '누적 말씀 묵상 시간', icon: 'fa-solid fa-book-bible', accent: 'text-secondary' }
};

let hofCurrentUserId = null;
let hofRefreshTimer = null;
let hofAvatarUrls = {};
let hofProfiles = {};
let hofActiveTab = 'total';

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
    return `<div class="w-9 h-9 rounded-full overflow-hidden bg-surface-container flex-shrink-0"><img src="${hofEscape(photoUrl)}" alt="" class="w-full h-full object-cover"></div>`;
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

function renderHofRankings(rows) {
  const wrap = document.getElementById('hof-ranking-grid');
  if (!wrap) return;
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

async function loadHofTabRows(tab) {
  const { data, error } = tab === 'total'
    ? await window.supabaseClient.rpc('get_home_rankings')
    : await window.supabaseClient.rpc('get_home_rankings_by_week', { week_no: Number(tab) });
  if (error) { console.error('[hall-of-fame] rankings', tab, error); return []; }
  return data || [];
}

async function refreshHofActiveTab() {
  const rows = await loadHofTabRows(hofActiveTab);
  hofProfiles = window.getPublicProfileCards ? await window.getPublicProfileCards(rows.map((row) => row.user_id)) : {};
  hofAvatarUrls = Object.fromEntries(Object.entries(hofProfiles).map(([id, profile]) => [id, profile.avatarUrl || '']));
  renderHofRankings(rows);
  const refreshed = document.getElementById('hof-last-refreshed');
  if (refreshed) refreshed.textContent = `${new Date().toLocaleTimeString('ko-KR', { hour: '2-digit', minute: '2-digit', second: '2-digit' })} 업데이트`;
}

function wireHofTabs() {
  const tabs = [...document.querySelectorAll('[data-hof-tab]')];
  tabs.forEach((btn) => {
    btn.addEventListener('click', () => {
      if (btn.dataset.hofTab === hofActiveTab) return;
      hofActiveTab = btn.dataset.hofTab;
      tabs.forEach((b) => {
        const active = b === btn;
        b.classList.toggle('nav-pill-active', active);
        b.classList.toggle('text-on-surface-variant', !active);
      });
      refreshHofActiveTab();
    });
  });
}

async function initHallOfFameWidgets() {
  const { data: { session } } = await window.supabaseClient.auth.getSession();
  hofCurrentUserId = session ? session.user.id : null;
  wireHofTabs();
  await refreshHofActiveTab();
  if (hofRefreshTimer) clearInterval(hofRefreshTimer);
  hofRefreshTimer = setInterval(() => {
    if (document.visibilityState === 'visible') refreshHofActiveTab();
  }, HOF_REFRESH_MS);
}

window.initHallOfFameWidgets = initHallOfFameWidgets;
