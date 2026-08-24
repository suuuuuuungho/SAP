// Admin 콘솔 — Team Manage 탭: 팀 생성/삭제 + 학생별 팀·역할 배정.

let adminTeams = [];
let adminTeamMembers = [];
let adminTeamMemberSearch = '';

async function adminLoadTeams() {
  const { data, error } = await window.supabaseClient.from('teams').select('id,name,sort_order').order('sort_order').order('name');
  if (error) { console.error('[admin] teams', error); adminTeams = []; return; }
  adminTeams = data || [];
}

function adminTeamRowHTML(team) {
  return `
    <div class="glass-card rounded-2xl px-4 py-2.5 flex items-center justify-between gap-3" data-team-id="${team.id}">
      <span class="text-sm font-semibold">${adminEscape(team.name)}</span>
      <button type="button" class="text-xs text-error font-semibold admin-team-delete">삭제</button>
    </div>`;
}

function adminRenderTeamList() {
  const wrap = document.getElementById('admin-team-list');
  if (!wrap) return;
  wrap.innerHTML = adminTeams.length ? adminTeams.map(adminTeamRowHTML).join('') : '<p class="text-sm text-on-surface-variant py-4 text-center">아직 팀이 없습니다.</p>';
  wrap.querySelectorAll('.admin-team-delete').forEach((btn) => btn.addEventListener('click', async () => {
    const teamId = btn.closest('[data-team-id]').dataset.teamId;
    const team = adminTeams.find((t) => t.id === teamId);
    if (!confirm(`"${team?.name || ''}" 팀을 삭제할까요? 배정된 학생들은 팀 없음 상태가 됩니다.`)) return;
    const { error } = await window.supabaseClient.from('teams').delete().eq('id', teamId);
    if (error) { adminShowStatus('팀 삭제에 실패했습니다.', true); return; }
    adminShowStatus('팀을 삭제했습니다.');
    await adminLoadTeamManage();
  }));
}

async function adminLoadTeamMembers() {
  const { data, error } = await window.supabaseClient.rpc('admin_get_team_assignments');
  if (error) { console.error('[admin] admin_get_team_assignments', error); adminTeamMembers = []; return; }
  adminTeamMembers = data || [];
}

function adminTeamMemberRowHTML(member) {
  const teamOptions = ['<option value="">팀 없음</option>', ...adminTeams.map((team) => `<option value="${team.id}" ${member.team_id === team.id ? 'selected' : ''}>${adminEscape(team.name)}</option>`)].join('');
  const hasTeam = !!member.team_id;
  const role = hasTeam ? (member.team_role || '') : '';
  return `
    <div class="glass-card rounded-2xl px-4 py-3 flex flex-col sm:flex-row sm:items-center gap-3" data-team-member-user="${member.user_id}">
      <div class="min-w-0 flex-1">
        <p class="text-sm font-semibold truncate">${adminEscape(member.name)} <span class="text-xs text-on-surface-variant font-normal">@${adminEscape(member.username)}</span></p>
        <p class="text-xs text-on-surface-variant truncate">${adminEscape(member.grade_class || '')}</p>
      </div>
      <div class="flex items-center gap-2 flex-shrink-0">
        <select class="glass-input rounded-xl px-3 py-2 text-xs admin-team-member-team">${teamOptions}</select>
        <select class="glass-input rounded-xl px-3 py-2 text-xs admin-team-member-role" ${hasTeam ? '' : 'disabled'}>
          <option value="" ${role === '' ? 'selected' : ''}>일반 팀원</option>
          <option value="leader" ${role === 'leader' ? 'selected' : ''}>팀장</option>
          <option value="vice_leader" ${role === 'vice_leader' ? 'selected' : ''}>부팀장</option>
        </select>
      </div>
    </div>`;
}

function adminRenderTeamMemberList() {
  const wrap = document.getElementById('admin-team-member-list');
  if (!wrap) return;
  const q = adminTeamMemberSearch.trim().toLowerCase();
  const rows = adminTeamMembers.filter((member) => !q || member.name.toLowerCase().includes(q) || member.username.toLowerCase().includes(q));
  wrap.innerHTML = rows.length ? rows.map(adminTeamMemberRowHTML).join('') : '<p class="text-sm text-on-surface-variant py-6 text-center">조건에 맞는 학생이 없습니다.</p>';

  wrap.querySelectorAll('[data-team-member-user]').forEach((card) => {
    const userId = card.dataset.teamMemberUser;
    const teamSelect = card.querySelector('.admin-team-member-team');
    const roleSelect = card.querySelector('.admin-team-member-role');

    const saveAssignment = async () => {
      const teamId = teamSelect.value || null;
      const role = teamId ? (roleSelect.value || null) : null;
      teamSelect.disabled = true;
      roleSelect.disabled = true;
      const { error } = await window.supabaseClient.rpc('admin_set_member_team', { target_user_id: userId, target_team_id: teamId, target_team_role: role });
      if (error) {
        adminShowStatus(error.message && error.message.includes('이미') ? error.message : '팀 배정에 실패했습니다.', true);
        await adminLoadTeamManage();
        return;
      }
      const member = adminTeamMembers.find((m) => m.user_id === userId);
      if (member) { member.team_id = teamId; member.team_role = role; }
      adminShowStatus('팀 배정을 저장했습니다.');
      teamSelect.disabled = false;
      roleSelect.disabled = !teamId;
    };

    teamSelect.addEventListener('change', () => {
      if (!teamSelect.value) { roleSelect.value = ''; roleSelect.disabled = true; }
      else roleSelect.disabled = false;
      saveAssignment();
    });
    roleSelect.addEventListener('change', saveAssignment);
  });
}

async function adminLoadTeamManage() {
  const teamListWrap = document.getElementById('admin-team-list');
  if (teamListWrap) teamListWrap.innerHTML = '<p class="text-sm text-on-surface-variant py-4 text-center"><i class="fa-solid fa-spinner fa-spin mr-2"></i>불러오는 중...</p>';
  await adminLoadTeams();
  await adminLoadTeamMembers();
  adminRenderTeamList();
  adminRenderTeamMemberList();
}

function adminWireTeamManage() {
  document.getElementById('admin-team-create-form')?.addEventListener('submit', async (event) => {
    event.preventDefault();
    const input = document.getElementById('admin-team-create-name');
    const name = input.value.trim();
    if (!name) return;
    const nextSortOrder = adminTeams.length ? Math.max(...adminTeams.map((team) => team.sort_order)) + 1 : 0;
    const { error } = await window.supabaseClient.from('teams').insert({ name, sort_order: nextSortOrder });
    if (error) { adminShowStatus('팀 추가에 실패했습니다.', true); return; }
    input.value = '';
    adminShowStatus('팀을 추가했습니다.');
    await adminLoadTeamManage();
  });
  document.getElementById('admin-team-member-search')?.addEventListener('input', (event) => {
    adminTeamMemberSearch = event.target.value;
    adminRenderTeamMemberList();
  });
}
