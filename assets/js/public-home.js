// Public Home (Board): 로그인한 모든 가입자에게 공지와 오늘의 말씀을 보여준다.
// 랭킹은 Hall of Fame 탭(hall-of-fame.js)으로 옮겼다.

const HOME_REFRESH_MS = 5 * 60 * 1000;

let publicHomeCurrentUserId = null;
let publicHomeRefreshTimer = null;

function publicHomeEscape(value) {
  return String(value == null ? '' : value)
    .replaceAll('&', '&amp;').replaceAll('<', '&lt;').replaceAll('>', '&gt;')
    .replaceAll('"', '&quot;').replaceAll("'", '&#039;');
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
        <time class="text-[10px] text-on-surface-variant">${new Date(message.starts_at || message.created_at).toLocaleString('ko-KR', { month: 'numeric', day: 'numeric', hour: '2-digit', minute: '2-digit' })}</time>
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
  const now = new Date();
  const nowIso = now.toISOString();
  const messageFields = 'id, recipient_user_id, body, created_at, starts_at, expires_at';
  const baseGlobal = window.supabaseClient.from('home_messages').select(messageFields)
    .eq('is_active', true).is('recipient_user_id', null).or(`starts_at.is.null,starts_at.lte.${nowIso}`)
    .or(`expires_at.is.null,expires_at.gt.${nowIso}`).order('starts_at', { ascending: false }).limit(10);
  const basePersonal = window.supabaseClient.from('home_messages').select(messageFields)
    .eq('is_active', true).eq('recipient_user_id', publicHomeCurrentUserId).or(`starts_at.is.null,starts_at.lte.${nowIso}`)
    .or(`expires_at.is.null,expires_at.gt.${nowIso}`).order('starts_at', { ascending: false }).limit(10);
  const [globalRes, personalRes, verseRes] = await Promise.all([
    baseGlobal,
    basePersonal,
    window.supabaseClient.from('home_bible_verses').select('id, reference, verse_text, created_at').eq('is_active', true).order('created_at', { ascending: false }).limit(1).maybeSingle()
  ]);

  if (globalRes.error) console.error('[public-home] global messages', globalRes.error);
  if (personalRes.error) console.error('[public-home] personal messages', personalRes.error);
  if (verseRes.error) console.error('[public-home] verse', verseRes.error);

  const visibleMessages = [...(globalRes.data || []), ...(personalRes.data || [])]
    .sort((a, b) => new Date(b.starts_at || b.created_at) - new Date(a.starts_at || a.created_at))
    .slice(0, 10);
  renderPublicHomeMessages(visibleMessages);
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
