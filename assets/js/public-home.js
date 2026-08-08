// Public Home: 로그인한 모든 가입자에게 전광판과 집계 Top 5를 보여준다.
// 원본 개인 기록은 읽지 않고 SECURITY DEFINER RPC의 집계 결과만 사용한다.

const HOME_REFRESH_MS = 30000;
const HOME_RANKING_META = {
  total: { title: 'Overall', description: '기도 · 공부 · 말씀 · 예배 합산', icon: 'fa-solid fa-trophy', accent: 'text-primary' },
  pray: { title: 'Prayer', description: '누적 기도 시간', icon: 'fa-solid fa-hands-praying', accent: 'text-primary' },
  study: { title: 'Study', description: '누적 공부 시간', icon: 'fa-solid fa-book-open', accent: 'text-tertiary' },
  word: { title: 'Word', description: '누적 말씀 묵상 시간', icon: 'fa-solid fa-book-bible', accent: 'text-secondary' }
};

let publicHomeCurrentUserId = null;
let publicHomeRefreshTimer = null;
let publicHomeAvatarUrls = {};

function publicHomeEscape(value) {
  return String(value == null ? '' : value)
    .replaceAll('&', '&amp;').replaceAll('<', '&lt;').replaceAll('>', '&gt;')
    .replaceAll('"', '&quot;').replaceAll("'", '&#039;');
}

function publicHomeFormatMinutes(minutes) {
  const value = Number(minutes) || 0;
  if (value < 60) return `${value}분`;
  const hours = Math.floor(value / 60);
  const rest = value % 60;
  return rest ? `${hours}시간 ${rest}분` : `${hours}시간`;
}

function publicHomeAvatar(userId, name) {
  const photoUrl = publicHomeAvatarUrls[userId];
  if (photoUrl) {
    return `<div class="w-9 h-9 rounded-full overflow-hidden bg-surface-container flex-shrink-0"><img src="${publicHomeEscape(photoUrl)}" alt="" class="w-full h-full object-cover"></div>`;
  }
  const initial = publicHomeEscape((name || '?').charAt(0));
  return `<div class="w-9 h-9 rounded-full bg-gradient-to-br from-primary-container to-tertiary-container text-white flex items-center justify-center font-bold text-sm flex-shrink-0">${initial}</div>`;
}

function publicHomeRankingRows(rows, category) {
  const categoryRows = rows.filter((row) => row.category === category);
  if (categoryRows.length === 0) {
    return '<div class="py-8 text-center text-sm text-on-surface-variant">아직 집계된 기록이 없어요.</div>';
  }
  return categoryRows.map((row) => {
    const isMe = row.user_id === publicHomeCurrentUserId;
    const medal = row.rank_no <= 3 ? ['🥇', '🥈', '🥉'][row.rank_no - 1] : String(row.rank_no);
    return `
      <div class="flex items-center gap-3 py-3 ${row.rank_no !== categoryRows.length ? 'border-b border-outline-variant/35' : ''} ${isMe ? 'bg-primary/5 -mx-3 px-3 rounded-xl' : ''}">
        <div class="w-7 text-center text-sm font-bold">${medal}</div>
        ${publicHomeAvatar(row.user_id, row.name)}
        <div class="min-w-0 flex-1">
          <p class="text-sm font-semibold truncate">${publicHomeEscape(row.name)}${isMe ? ' <span class="text-[10px] text-primary">ME</span>' : ''}</p>
          <p class="text-[11px] text-on-surface-variant truncate">@${publicHomeEscape(row.username)}</p>
        </div>
        <p class="text-sm font-bold text-on-surface whitespace-nowrap">${publicHomeFormatMinutes(row.minutes)}</p>
      </div>`;
  }).join('');
}

function renderPublicHomeRankings(rows) {
  const wrap = document.getElementById('home-ranking-grid');
  if (!wrap) return;
  wrap.innerHTML = ['total', 'pray', 'study', 'word'].map((category) => {
    const meta = HOME_RANKING_META[category];
    return `
      <section class="glass-card rounded-[1.5rem] p-5 ${category === 'total' ? 'lg:col-span-2' : ''}">
        <div class="flex items-start justify-between gap-3 mb-3">
          <div>
            <h2 class="text-lg font-bold">${meta.title}</h2>
            <p class="text-xs text-on-surface-variant">${meta.description}</p>
          </div>
          <div class="icon-glass w-10 h-10 rounded-full flex items-center justify-center ${meta.accent}"><i class="${meta.icon}"></i></div>
        </div>
        <div>${publicHomeRankingRows(rows, category)}</div>
      </section>`;
  }).join('');
}

function renderPublicHomeMessages(messages) {
  const wrap = document.getElementById('home-message-list');
  if (!wrap) return;
  if (messages.length === 0) {
    wrap.innerHTML = '<p class="text-sm text-on-surface-variant py-5">현재 전달된 메시지가 없습니다.</p>';
    return;
  }
  const orderedMessages = [...messages].sort((a, b) => {
    const audienceOrder = Number(!!a.recipient_user_id) - Number(!!b.recipient_user_id);
    return audienceOrder || new Date(b.created_at) - new Date(a.created_at);
  });
  wrap.innerHTML = orderedMessages.map((message) => `
    <article class="glass-card rounded-2xl p-4 border-l-4 ${message.recipient_user_id ? 'border-secondary' : 'border-primary'}">
      <div class="flex items-center gap-2 mb-2">
        <span class="text-[10px] font-bold rounded-full px-2 py-0.5 ${message.recipient_user_id ? 'bg-secondary-container/40 text-secondary' : 'bg-primary-container/20 text-primary'}">${message.recipient_user_id ? 'FOR YOU' : 'NOTICE'}</span>
        <time class="text-[10px] text-on-surface-variant">${new Date(message.created_at).toLocaleString('ko-KR', { month: 'numeric', day: 'numeric', hour: '2-digit', minute: '2-digit' })}</time>
      </div>
      <p class="text-sm leading-6 whitespace-pre-wrap">${publicHomeEscape(message.body)}</p>
    </article>`).join('');
}

function renderPublicHomeVerse(verse) {
  const reference = document.getElementById('home-verse-reference');
  const text = document.getElementById('home-verse-text');
  if (!reference || !text) return;
  reference.textContent = verse ? verse.reference : '오늘의 말씀';
  text.textContent = verse ? verse.verse_text : '관리자가 등록한 성경구절이 여기에 표시됩니다.';
}

async function loadPublicHome() {
  const [rankingRes, messageRes, verseRes] = await Promise.all([
    window.supabaseClient.rpc('get_home_rankings'),
    window.supabaseClient.from('home_messages').select('id, recipient_user_id, body, created_at, expires_at').order('created_at', { ascending: false }).limit(10),
    window.supabaseClient.from('home_bible_verses').select('id, reference, verse_text, created_at').eq('is_active', true).order('created_at', { ascending: false }).limit(1).maybeSingle()
  ]);

  if (rankingRes.error) console.error('[public-home] rankings', rankingRes.error);
  if (messageRes.error) console.error('[public-home] messages', messageRes.error);
  if (verseRes.error) console.error('[public-home] verse', verseRes.error);

  publicHomeAvatarUrls = window.getProfileAvatarUrls
    ? await window.getProfileAvatarUrls((rankingRes.data || []).map((row) => row.user_id))
    : {};
  renderPublicHomeRankings(rankingRes.data || []);
  renderPublicHomeMessages(messageRes.data || []);
  renderPublicHomeVerse(verseRes.data || null);

  const refreshed = document.getElementById('home-last-refreshed');
  if (refreshed) refreshed.textContent = `${new Date().toLocaleTimeString('ko-KR', { hour: '2-digit', minute: '2-digit', second: '2-digit' })} 업데이트`;
}

async function initPublicHomeWidgets() {
  const { data: { session } } = await window.supabaseClient.auth.getSession();
  publicHomeCurrentUserId = session ? session.user.id : null;
  await loadPublicHome();
  if (publicHomeRefreshTimer) clearInterval(publicHomeRefreshTimer);
  publicHomeRefreshTimer = setInterval(() => {
    if (document.visibilityState === 'visible') loadPublicHome();
  }, HOME_REFRESH_MS);
}

window.initPublicHomeWidgets = initPublicHomeWidgets;
