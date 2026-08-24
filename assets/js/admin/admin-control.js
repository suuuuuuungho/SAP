// Admin 콘솔 — Control Panel 탭: 기능 on/off 스위치 + 댓글 작성 권한(역할별) 토글.

const ADMIN_FEATURE_STRUCTURE = [
  { key: 'board', title: 'Board', description: '전체 이용자가 보는 소식 탭', icon: 'fa-solid fa-clipboard-list', children: [
    { key: 'board_messages', title: 'Board Message', description: '전체 공지와 개인 메시지를 표시합니다.' },
    { key: 'board_verse', title: '오늘의 말씀', description: '관리자가 등록한 성경 말씀을 상단에 표시합니다.' }
  ] },
  { key: 'hall_of_fame', title: 'Hall of Fame', description: '전체 이용자가 보는 랭킹 탭', icon: 'fa-solid fa-trophy', children: [
    { key: 'ranking', title: '전체 누적 랭킹', description: '운영기간 전체 누적 활동 시간 기준 상위 이용자를 표시합니다.' },
    { key: 'ranking_weekly', title: '주차별 랭킹', description: 'Week1~4 탭으로 나눈 주차별 랭킹을 표시합니다.' }
  ] },
  { key: 'team', title: 'Team', description: '팀별 활동 시간과 기여도를 보는 공개 탭', icon: 'fa-solid fa-people-group', children: [] },
  { key: 'mypage', title: 'MyPage', description: '개인의 일별 인증과 활동 기록 탭', icon: 'fa-solid fa-user', children: [
    { key: 'pray', title: '기도 인증', description: '기도 시간과 인증 사진을 기록합니다.' },
    { key: 'word', title: '말씀 묵상 인증', description: '읽은 말씀과 묵상 시간을 기록합니다.' },
    { key: 'study_timer', title: '공부 시간 기록', description: '타이머 또는 직접 입력으로 공부 시간을 기록합니다.' },
    { key: 'worship', title: '예배 인증', description: '예배 참석 여부와 시간을 기록합니다.' }
  ] },
  { key: 'study', title: 'Study', description: '영단어 학습 탭', icon: 'fa-solid fa-book', children: [
    { key: 'study_vocab', title: '영단어 학습', description: '단어 목록, 암기 카드와 퀴즈를 제공합니다.' }
  ] },
  { key: 'gallery', title: 'Gallery', description: '전체 이용자의 인증 게시물 탭', icon: 'fa-regular fa-images', children: [
    { key: 'gallery_pray', title: '기도 갤러리', description: '기도 인증 게시물과 사진을 표시합니다.' },
    { key: 'gallery_word', title: '말씀 묵상 갤러리', description: '말씀 묵상 게시물과 사진을 표시합니다.' },
    { key: 'comments', title: '댓글', description: '게시물의 댓글 작성과 조회를 허용합니다.' }
  ] },
  { key: 'stat', title: 'Stat', description: '개인 활동 통계와 시각화 탭', icon: 'fa-solid fa-chart-line', children: [
    { key: 'stat_summary', title: '요약 지표', description: '연속 달성, 목표 달성률과 핵심 수치를 표시합니다.' },
    { key: 'stat_heatmap', title: '히트맵', description: '운영기간의 일별 활동량을 표시합니다.' },
    { key: 'stat_trend', title: '활동 추이', description: '날짜별 총 활동 시간의 변화를 표시합니다.' },
    { key: 'stat_balance', title: '카테고리 균형', description: '기도·말씀·공부·예배의 균형을 표시합니다.' },
    { key: 'stat_breakdown', title: '시간 비중', description: '카테고리별 누적 시간 비중을 표시합니다.' },
    { key: 'stat_bests', title: '개인 최고 기록', description: '운영기간 동안의 최고 기록을 표시합니다.' }
  ] },
  { key: null, title: '계정', description: '가입과 개인 계정 기능', icon: 'fa-solid fa-shield-halved', children: [
    { key: 'profile_photo', title: '프로필 사진', description: '프로필 사진 등록·수정·삭제를 허용합니다.' },
    { key: 'signup', title: '회원가입', description: '새로운 이용자의 회원가입을 허용합니다.' },
    { key: 'password_reset', title: '비밀번호 찾기', description: '문자 인증을 통한 비밀번호 변경을 허용합니다.' },
    { key: 'account_delete', title: '회원탈퇴', description: '이용자가 직접 계정과 모든 기록을 영구 삭제하도록 허용합니다.' }
  ] }
];

async function adminLoadFeatures() {
  const { data, error } = await window.supabaseClient.from('app_feature_flags').select('*').order('section').order('label');
  const wrap = document.getElementById('admin-feature-groups');
  if (!wrap) return;
  if (error) { wrap.innerHTML = '<p class="text-sm text-error">admin_console_schema.sql을 먼저 실행해주세요.</p>'; return; }
  const flagMap = Object.fromEntries((data || []).map((item) => [item.feature_key, item.is_enabled]));
  const switchHTML = (feature, parentKey, master = false) => `<label class="admin-switch" aria-label="${adminEscape(feature.title)} 켜기 또는 끄기"><input type="checkbox" data-feature-key="${feature.key}" data-feature-label="${adminEscape(feature.title)}" data-feature-section="${adminEscape(parentKey || '계정')}" ${master ? 'data-feature-master' : ''} ${flagMap[feature.key] !== false ? 'checked' : ''}><span class="admin-switch-track"></span></label>`;
  wrap.innerHTML = ADMIN_FEATURE_STRUCTURE.map((group) => `<section class="glass-card rounded-[1.5rem] p-5 sm:p-6" data-feature-group="${group.key || 'account'}"><div class="flex items-center gap-4"><div class="icon-glass w-11 h-11 rounded-full flex items-center justify-center text-primary flex-shrink-0"><i class="${group.icon}"></i></div><div class="min-w-0 flex-1"><h3 class="text-lg font-bold">${group.title}</h3><p class="text-xs text-on-surface-variant mt-0.5">${group.description}</p></div>${group.key ? switchHTML(group, group.title, true) : ''}</div><div class="ml-5 sm:ml-[3.35rem] pl-4 border-l-2 border-outline-variant/45 mt-4 divide-y divide-outline-variant/30" data-feature-children>${group.children.map((feature) => `<div class="flex items-center justify-between gap-4 py-3.5"><div class="min-w-0"><p class="text-sm font-semibold">${feature.title}</p><p class="text-[11px] leading-5 text-on-surface-variant mt-0.5">${feature.description}</p></div>${switchHTML(feature, group.title)}</div>`).join('')}</div></section>`).join('');
  const syncGroups = () => document.querySelectorAll('[data-feature-group]').forEach((group) => { const master = group.querySelector('[data-feature-master]'); group.querySelector('[data-feature-children]')?.classList.toggle('opacity-45', !!master && !master.checked); });
  syncGroups();
  wrap.querySelectorAll('[data-feature-key]').forEach((input) => input.addEventListener('change', async () => {
    const { error: updateError } = await window.supabaseClient.from('app_feature_flags').upsert({ feature_key: input.dataset.featureKey, label: input.dataset.featureLabel, section: input.dataset.featureSection, is_enabled: input.checked, updated_by: adminCurrentUserId, updated_at: new Date().toISOString() }, { onConflict: 'feature_key' });
    if (updateError) { input.checked = !input.checked; adminShowStatus('기능 상태를 변경하지 못했습니다.', true); }
    else adminShowStatus(`${input.dataset.featureLabel} 기능을 ${input.checked ? '켰습니다' : '껐습니다'}.`);
    syncGroups();
  }));
}

const ADMIN_COMMENT_ROLE_OPTIONS = [
  { role: 'admin', label: 'Admin' },
  { role: 'teacher', label: '교사' },
  { role: 'pastor', label: '목사님' },
  { role: 'department_head', label: '부장님' },
  { role: 'secretary', label: '총무님' }
];
let adminCommentRoles = new Set();

async function adminLoadCommentRoles() {
  const wrap = document.getElementById('admin-comment-roles');
  if (!wrap) return;
  const { data, error } = await window.supabaseClient.from('app_role_permissions').select('role').eq('permission_key', 'gallery_comments');
  if (error) { wrap.innerHTML = '<p class="text-sm text-error">gallery_comment_role_permission.sql을 먼저 실행해주세요.</p>'; return; }
  adminCommentRoles = new Set((data || []).map((row) => row.role));
  adminRenderCommentRoles();
}

function adminRenderCommentRoles() {
  const wrap = document.getElementById('admin-comment-roles');
  if (!wrap) return;
  wrap.innerHTML = ADMIN_COMMENT_ROLE_OPTIONS.map((option) => `<label class="glass-card rounded-full pl-3 pr-4 py-2 flex items-center gap-2 text-sm font-semibold cursor-pointer"><input type="checkbox" data-comment-role="${option.role}" class="rounded text-primary" ${adminCommentRoles.has(option.role) ? 'checked' : ''}>${option.label}</label>`).join('');
  wrap.querySelectorAll('[data-comment-role]').forEach((input) => input.addEventListener('change', () => adminToggleCommentRole(input.dataset.commentRole, input.checked, input)));
}

async function adminToggleCommentRole(role, enabled, input) {
  const label = ADMIN_COMMENT_ROLE_OPTIONS.find((option) => option.role === role)?.label || role;
  if (enabled) {
    const { error } = await window.supabaseClient.from('app_role_permissions').upsert({ permission_key: 'gallery_comments', role });
    if (error) { if (input) input.checked = false; adminShowStatus('권한을 저장하지 못했습니다.', true); return; }
    adminCommentRoles.add(role);
  } else {
    const { error } = await window.supabaseClient.from('app_role_permissions').delete().eq('permission_key', 'gallery_comments').eq('role', role);
    if (error) { if (input) input.checked = true; adminShowStatus('권한을 저장하지 못했습니다.', true); return; }
    adminCommentRoles.delete(role);
  }
  adminShowStatus(`${label} 댓글 작성 권한을 ${enabled ? '켰습니다' : '껐습니다'}.`);
}
