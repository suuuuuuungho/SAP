// Sapians: 인스타그램 스타일 피드. 기도/말씀 인증(pray_records/word_records)을 그대로 읽어서
// 하루 전체 기록 = 게시물 1개로 렌더링한다. 새 테이블/별도 sync 없음 — MyPage와 완전히 같은 데이터.

let sapiansCurrentUserId = null;
let sapiansUsers = []; // [{id, username, name}]
let sapiansFeedItems = []; // [{type: 'pray'|'word', user, row, sortKey}], 최신순

const FEED_WINDOW_DAYS = 30;

function initialOf(name) {
  return name ? name.charAt(0) : '?';
}

async function loadSapiansUsers() {
  const { data, error } = await window.supabaseClient.rpc('get_gallery_users');
  if (error) {
    console.error('[sapians] loadSapiansUsers', error);
    return [];
  }
  return data || [];
}

function feedWindowStartKey() {
  const d = new Date();
  d.setDate(d.getDate() - FEED_WINDOW_DAYS);
  return dateKey(d);
}

async function loadSapiansFeed() {
  const ids = sapiansUsers.map((u) => u.id);
  if (ids.length === 0) {
    sapiansFeedItems = [];
    return;
  }
  const sinceKey = feedWindowStartKey();

  const [prayRes, wordRes] = await Promise.all([
    window.supabaseClient.from('pray_records').select('*').gte('record_date', sinceKey).in('user_id', ids),
    window.supabaseClient.from('word_records').select('*').gte('record_date', sinceKey).in('user_id', ids)
  ]);
  if (prayRes.error) console.error('[sapians] pray_records', prayRes.error);
  if (wordRes.error) console.error('[sapians] word_records', wordRes.error);

  const usersById = Object.fromEntries(sapiansUsers.map((u) => [u.id, u]));

  const prayItems = (prayRes.data || [])
    .filter((row) => row.entries && row.entries.length > 0)
    .map((row) => ({ type: 'pray', user: usersById[row.user_id], row, sortKey: row.updated_at }));

  const wordItems = (wordRes.data || [])
    .filter((row) => row.verses && row.verses.length > 0)
    .map((row) => ({ type: 'word', user: usersById[row.user_id], row, sortKey: row.updated_at }));

  sapiansFeedItems = [...prayItems, ...wordItems].sort((a, b) => new Date(b.sortKey) - new Date(a.sortKey));
}

function feedItemPhotoPaths(item) {
  if (item.type === 'pray') {
    return item.row.entries.map((entry) => (entry.photoUnavailable ? null : entry.photoPath));
  }
  return [item.row.photo_unavailable ? null : item.row.photo_path];
}

function feedItemSummary(item) {
  return item.type === 'pray' ? formatPrayerSummary(item.row.entries) : formatWordSummary(item.row.verses);
}

function feedItemTypeLabel(item) {
  return item.type === 'pray' ? '기도 인증' : '말씀 묵상';
}

// 게시물에 적히는 날짜는 저장 시각(updated_at)이 아니라 실제 기도/말씀 인증 날짜(record_date) 기준.
// 올해면 "8월 10일", 해가 다르면 "2025년 8월 10일"처럼 인스타그램의 절대 날짜 표기를 따른다.
function formatPostDate(recordDateKey) {
  const [y, m, d] = recordDateKey.split('-').map(Number);
  const label = `${m}월 ${d}일`;
  return y === new Date().getFullYear() ? label : `${y}년 ${label}`;
}

function avatarHTML(user, sizeClass) {
  const initial = initialOf(user ? user.name : null);
  return `
    <div class="story-ring ${sizeClass}">
      <div class="story-ring-inner w-full h-full">
        <div class="w-full h-full rounded-full bg-gradient-to-br from-primary-container to-tertiary-container text-on-primary flex items-center justify-center font-bold text-sm">${initial}</div>
      </div>
    </div>`;
}

function feedCardHTML(item, index) {
  const isOwn = item.user && item.user.id === sapiansCurrentUserId;
  const photoUrls = feedItemPhotoPaths(item).map((path) => getPhotoUrl(path));
  const mediaHTML = photoUrls
    .map((src) => `<img src="${src}" class="snap-center shrink-0 w-full h-full object-contain" alt="게시물 사진">`)
    .join('');
  const dotsHTML = photoUrls.length > 1
    ? `<div class="flex justify-center gap-1 mt-2">${photoUrls.map((_, i) => `<span class="w-1.5 h-1.5 rounded-full ${i === 0 ? 'bg-primary' : 'bg-outline-variant'}"></span>`).join('')}</div>`
    : '';
  const name = item.user ? item.user.name : '?';
  const username = item.user ? item.user.username : '?';

  return `
    <article class="pt-4 pb-6 border-b border-outline-variant last:border-b-0">
      <div class="flex items-center justify-between px-4 pb-3">
        <div class="flex items-center gap-3">
          ${avatarHTML(item.user, 'w-9 h-9')}
          <div class="flex flex-col leading-tight">
            <span class="text-sm font-semibold text-on-surface">${name} <span class="text-on-surface-variant font-normal">(${username})</span></span>
            <span class="text-[11px] text-on-surface-variant">${feedItemTypeLabel(item)}</span>
          </div>
        </div>
      </div>
      <div class="relative w-full aspect-square bg-surface-container overflow-hidden ${isOwn ? 'cursor-pointer sapians-own-media' : ''}" data-feed-index="${index}">
        <div class="flex overflow-x-auto snap-x snap-mandatory scrollbar-hide w-full h-full">${mediaHTML}</div>
      </div>
      ${dotsHTML}
      <div class="flex items-center gap-4 px-4 pt-3 text-on-surface-variant">
        <i class="fa-regular fa-heart text-xl"></i>
        <i class="fa-regular fa-comment text-xl cursor-pointer sapians-comment-btn" data-feed-index="${index}"></i>
        <i class="fa-regular fa-paper-plane text-xl"></i>
      </div>
      <p class="px-4 pt-2 text-sm text-on-surface"><span class="font-semibold mr-1">${name}</span>${feedItemSummary(item)}</p>
      <p class="px-4 pt-1 text-[11px] text-on-surface-variant/70">${formatPostDate(item.row.record_date)}</p>
    </article>`;
}

function renderSapiansFeed() {
  const feedEl = document.getElementById('sapians-feed');
  if (!feedEl) return;

  if (sapiansFeedItems.length === 0) {
    feedEl.innerHTML = '<p class="text-sm text-on-surface-variant text-center py-16">아직 게시물이 없습니다.</p>';
    return;
  }
  feedEl.innerHTML = sapiansFeedItems.map(feedCardHTML).join('');
}

function renderSapiansStories() {
  const el = document.getElementById('sapians-stories');
  if (!el) return;

  const own = sapiansUsers.find((u) => u.id === sapiansCurrentUserId);
  const others = sapiansUsers.filter((u) => u.id !== sapiansCurrentUserId);

  const ownHTML = `
    <div class="flex flex-col items-center gap-1 shrink-0 cursor-pointer" id="sapians-own-story">
      <div class="relative">
        ${avatarHTML(own, 'w-16 h-16')}
        <div class="absolute bottom-0 right-0 bg-primary text-on-primary rounded-full w-5 h-5 flex items-center justify-center border-2 border-surface text-xs pointer-events-none">
          <i class="fa-solid fa-plus"></i>
        </div>
      </div>
      <span class="text-[11px] text-on-surface-variant truncate w-16 text-center">나</span>
    </div>`;

  const othersHTML = others.map((u) => `
    <div class="flex flex-col items-center gap-1 shrink-0" data-user-id="${u.id}">
      ${avatarHTML(u, 'w-16 h-16')}
      <span class="text-[11px] text-on-surface-variant truncate w-16 text-center">${u.username}</span>
    </div>`).join('');

  el.innerHTML = ownHTML + othersHTML;
}

async function onFeedSaved() {
  await loadSapiansFeed();
  renderSapiansFeed();
}

function openComposeModal() {
  const modal = document.getElementById('sapians-compose-modal');
  if (!modal) return;
  modal.classList.remove('hidden');
  modal.classList.add('flex');
}

function closeComposeModal() {
  const modal = document.getElementById('sapians-compose-modal');
  if (!modal) return;
  modal.classList.add('hidden');
  modal.classList.remove('flex');
}

function wireCompose() {
  const composeBtn = document.getElementById('sapians-compose-btn');
  const overlay = document.getElementById('sapians-compose-overlay');
  const cancelBtn = document.getElementById('sapians-compose-cancel');
  const prayBtn = document.getElementById('sapians-compose-pray');
  const wordBtn = document.getElementById('sapians-compose-word');
  const storiesEl = document.getElementById('sapians-stories');

  if (composeBtn) composeBtn.addEventListener('click', openComposeModal);
  if (overlay) overlay.addEventListener('click', closeComposeModal);
  if (cancelBtn) cancelBtn.addEventListener('click', closeComposeModal);
  if (prayBtn) prayBtn.addEventListener('click', () => { closeComposeModal(); openPrayModal(todayKey(), onFeedSaved); });
  if (wordBtn) wordBtn.addEventListener('click', () => { closeComposeModal(); openWordModal(todayKey(), onFeedSaved); });

  // 본인 스토리 원은 매번 다시 그려지므로(이벤트 위임) 상위 컨테이너에 한 번만 건다.
  if (storiesEl) {
    storiesEl.addEventListener('click', (e) => {
      if (e.target.closest('#sapians-own-story')) openComposeModal();
    });
  }
}

function wireFeedClicks() {
  const feedEl = document.getElementById('sapians-feed');
  if (!feedEl) return;

  feedEl.addEventListener('click', (e) => {
    const commentBtn = e.target.closest('.sapians-comment-btn');
    if (commentBtn) {
      const item = sapiansFeedItems[Number(commentBtn.dataset.feedIndex)];
      if (item) openCommentsModal(item);
      return;
    }

    const mediaEl = e.target.closest('.sapians-own-media');
    if (!mediaEl) return;
    const item = sapiansFeedItems[Number(mediaEl.dataset.feedIndex)];
    if (!item) return;

    if (item.type === 'pray') {
      openPrayModal(item.row.record_date, onFeedSaved);
    } else {
      openWordModal(item.row.record_date, onFeedSaved);
    }
  });
}

// --- 댓글 (post_comments 테이블. 게시물은 별도 테이블이 없어 owner/date/type 조합으로 특정) ---

let activeCommentsPost = null; // { ownerId, date, type }
let sapiansComments = [];

function userById(userId) {
  return sapiansUsers.find((u) => u.id === userId) || null;
}

// 댓글은 상대적 시간이 자연스러운 곳 — 게시물 자체의 날짜 표기(formatPostDate)와는 별개.
function relativeTimeShort(isoString) {
  const diffMs = Date.now() - new Date(isoString).getTime();
  const mins = Math.floor(diffMs / 60000);
  if (mins < 1) return '방금';
  if (mins < 60) return `${mins}분`;
  const hours = Math.floor(mins / 60);
  if (hours < 24) return `${hours}시간`;
  const days = Math.floor(hours / 24);
  return `${days}일`;
}

async function loadComments(post) {
  const { data, error } = await window.supabaseClient
    .from('post_comments')
    .select('*')
    .eq('post_owner_id', post.ownerId)
    .eq('post_date', post.date)
    .eq('post_type', post.type)
    .order('created_at', { ascending: true });
  if (error) {
    console.error('[sapians] loadComments', error);
    return [];
  }
  return data || [];
}

function commentRowHTML(comment) {
  const user = userById(comment.author_id);
  return `
    <div class="flex items-start gap-3">
      ${avatarHTML(user, 'w-8 h-8')}
      <div class="flex-1 min-w-0">
        <p class="text-sm text-on-surface break-words"><span class="font-semibold mr-1">${user ? user.username : '?'}</span>${comment.body}</p>
        <span class="text-[11px] text-on-surface-variant">${relativeTimeShort(comment.created_at)} 전</span>
      </div>
    </div>`;
}

function renderComments() {
  const list = document.getElementById('sapians-comments-list');
  if (!list) return;
  list.innerHTML = sapiansComments.length > 0
    ? sapiansComments.map(commentRowHTML).join('')
    : '<p class="text-xs text-on-surface-variant text-center py-6">첫 댓글을 남겨보세요.</p>';
}

async function openCommentsModal(item) {
  activeCommentsPost = { ownerId: item.user.id, date: item.row.record_date, type: item.type };
  const modal = document.getElementById('sapians-comments-modal');
  if (!modal) return;
  modal.classList.remove('hidden');
  modal.classList.add('flex');

  const list = document.getElementById('sapians-comments-list');
  if (list) list.innerHTML = '<p class="text-xs text-on-surface-variant text-center py-6">불러오는 중...</p>';

  sapiansComments = await loadComments(activeCommentsPost);
  renderComments();
}

function closeCommentsModal() {
  const modal = document.getElementById('sapians-comments-modal');
  if (!modal) return;
  modal.classList.add('hidden');
  modal.classList.remove('flex');
  activeCommentsPost = null;
}

async function submitComment(e) {
  e.preventDefault();
  const input = document.getElementById('sapians-comments-input');
  const submitBtn = document.getElementById('sapians-comments-submit');
  const body = input.value.trim();
  if (!body || !activeCommentsPost) return;

  submitBtn.disabled = true;
  const { error } = await window.supabaseClient.from('post_comments').insert({
    post_owner_id: activeCommentsPost.ownerId,
    post_date: activeCommentsPost.date,
    post_type: activeCommentsPost.type,
    author_id: sapiansCurrentUserId,
    body
  });
  submitBtn.disabled = false;

  if (error) {
    console.error('[sapians] submitComment', error);
    return;
  }
  input.value = '';
  sapiansComments = await loadComments(activeCommentsPost);
  renderComments();
}

function wireComments() {
  const overlay = document.getElementById('sapians-comments-overlay');
  const closeBtn = document.getElementById('sapians-comments-close');
  const form = document.getElementById('sapians-comments-form');

  if (overlay) overlay.addEventListener('click', closeCommentsModal);
  if (closeBtn) closeBtn.addEventListener('click', closeCommentsModal);
  if (form) form.addEventListener('submit', submitComment);
}

async function initGalleryWidgets() {
  wireCompose();
  wireFeedClicks();
  wireComments();
  wirePrayModalStatic();
  wireWordModalStatic();

  sapiansCurrentUserId = await getCurrentUserId();
  sapiansUsers = await loadSapiansUsers();
  renderSapiansStories();
  await loadSapiansFeed();
  renderSapiansFeed();
}

window.initGalleryWidgets = initGalleryWidgets;
