// Admin 콘솔 — Stat 탭: 전체 회원 활동 시간 통계(검색/역할 필터).

let adminStatRows = [];

async function adminLoadAllStats() {
  const wrap = document.getElementById('admin-stat-list');
  if (wrap) wrap.innerHTML = '<p class="text-sm text-on-surface-variant py-10 text-center"><i class="fa-solid fa-spinner fa-spin mr-2"></i>회원 통계를 불러오고 있습니다.</p>';
  const { data, error } = await window.supabaseClient.rpc('admin_get_all_member_stats');
  if (error) {
    if (wrap) wrap.innerHTML = '<p class="text-sm text-error py-10 text-center">admin_console_schema.sql을 다시 실행해주세요.</p>';
    return;
  }
  adminStatRows = data || [];
  adminRenderAllStats();
}

function adminRenderAllStats() {
  const search = (document.getElementById('admin-stat-search')?.value || '').trim().toLowerCase();
  const role = document.getElementById('admin-stat-role')?.value || 'student';
  const filtered = adminStatRows.filter((row) => (role === 'all' || row.app_role === role)
    && (!search || `${row.name} ${row.username} ${row.grade_class}`.toLowerCase().includes(search)));

  const wrap = document.getElementById('admin-stat-list');
  if (!wrap) return;
  if (!filtered.length) { wrap.innerHTML = '<p class="text-sm text-on-surface-variant py-10 text-center">조건에 맞는 Member가 없습니다.</p>'; return; }
  const mobileMetric = (label, value, strong = false) => `<div class="min-w-0 text-center rounded-xl bg-white/70 px-1 py-2"><p class="text-[9px] text-on-surface-variant leading-none mb-1.5">${label}</p><p class="text-[10px] sm:text-xs font-bold truncate ${strong ? 'text-primary' : ''}">${value}</p></div>`;
  const mobileRows = filtered.map((row) => `<article class="glass-card rounded-2xl p-3 ${row.is_active ? '' : 'opacity-50'}"><div class="min-w-0 mb-3"><div class="flex items-center gap-1.5"><p class="text-sm font-bold truncate">${adminEscape(row.name)}</p>${adminRoleBadge(row)}</div><p class="text-[10px] text-on-surface-variant truncate">@${adminEscape(row.username)} · ${adminEscape(row.grade_class || '학년/반 미지정')} · ${row.is_active ? '활성' : '비활성'}</p></div><div class="grid grid-cols-4 gap-1 mb-1">${mobileMetric('기도',adminFormatMinutes(row.pray_minutes))}${mobileMetric('말씀',adminFormatMinutes(row.word_minutes))}${mobileMetric('공부',adminFormatMinutes(row.study_minutes))}${mobileMetric('예배',adminFormatMinutes(row.worship_minutes))}</div><div class="grid grid-cols-2 gap-1">${mobileMetric('총 시간',adminFormatMinutes(row.total_minutes),true)}${mobileMetric('300분 달성',`${Number(row.goal_days) || 0}일`)}</div></article>`).join('');
  const desktopRows = filtered.map((row) => `<article class="grid grid-cols-[minmax(145px,1.5fr)_repeat(4,minmax(58px,.72fr))_minmax(74px,.85fr)_68px] gap-2 items-center glass-card rounded-2xl px-3 py-3 mb-2 ${row.is_active ? '' : 'opacity-50'}"><div class="min-w-0"><div class="flex items-center gap-1.5"><p class="text-sm font-bold truncate">${adminEscape(row.name)}</p>${adminRoleBadge(row)}</div><p class="text-[9px] text-on-surface-variant truncate">@${adminEscape(row.username)} · ${adminEscape(row.grade_class || '미지정')} · ${adminEscape(adminRoleLabel(row.app_role))}</p></div><span class="text-[11px] font-semibold truncate">${adminFormatMinutes(row.pray_minutes)}</span><span class="text-[11px] font-semibold truncate">${adminFormatMinutes(row.word_minutes)}</span><span class="text-[11px] font-semibold truncate">${adminFormatMinutes(row.study_minutes)}</span><span class="text-[11px] font-semibold truncate">${adminFormatMinutes(row.worship_minutes)}</span><span class="text-xs font-bold text-primary truncate">${adminFormatMinutes(row.total_minutes)}</span><span class="text-xs font-bold">${Number(row.goal_days) || 0}일</span></article>`).join('');
  const header = '<div class="sticky top-0 z-20 grid grid-cols-[minmax(145px,1.5fr)_repeat(4,minmax(58px,.72fr))_minmax(74px,.85fr)_68px] gap-2 px-3 py-3 mb-2 text-[9px] font-bold tracking-wide text-on-surface-variant bg-white/95 backdrop-blur-xl shadow-sm rounded-xl"><span>Member</span><span>기도</span><span>말씀</span><span>공부</span><span>예배</span><span>총 시간</span><span>300분</span></div>';
  wrap.innerHTML = `<div class="lg:hidden flex flex-col gap-3">${mobileRows}</div><div class="hidden lg:block max-h-[70vh] overflow-y-auto scrollbar-hide rounded-2xl">${header}${desktopRows}</div>`;
}
