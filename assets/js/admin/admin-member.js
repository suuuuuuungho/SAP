// Admin 콘솔 — Member 탭: 회원 목록/검색/편집(역할·활성화·연락처)/탈퇴.

let adminMembers = [];
let adminMemberAvatarUrls = {};

async function adminLoadMembers() {
  const { data, error } = await window.supabaseClient.rpc('admin_get_members');
  if (error) { adminShowStatus('회원 정보를 불러오지 못했습니다. 관리자 스키마를 확인해주세요.', true); return; }
  adminMembers = data || [];
  adminMemberAvatarUrls = window.getProfileAvatarUrls
    ? await window.getProfileAvatarUrls(adminMembers.map((member) => member.id))
    : {};
  adminRenderMembers();
  adminRenderMessageSenders(document.querySelector('input[name="admin-message-sender"]:checked')?.value || null);
  adminRenderParentMessageRecipients(document.getElementById('admin-parent-message-recipient')?.value || null);
  await adminLoadMessages();
}

function adminRenderMembers() {
  const wrap = document.getElementById('admin-member-list');
  const query = (document.getElementById('admin-member-search')?.value || '').trim().toLowerCase();
  if (!wrap) return;
  const filtered = adminMembers.filter((member) => !query || `${member.name} ${member.username} ${member.grade_class}`.toLowerCase().includes(query));
  wrap.innerHTML = filtered.map((member) => `<article class="admin-member-row glass-card rounded-2xl p-4 flex flex-wrap sm:flex-nowrap items-center gap-3 ${member.is_active ? '' : 'opacity-50'}" data-member-id="${member.id}"><div class="w-11 h-11 rounded-full bg-gradient-to-br from-primary-container to-secondary-container text-white flex items-center justify-center font-bold overflow-hidden">${adminMemberAvatarUrls[member.id] ? `<img src="${adminEscape(adminMemberAvatarUrls[member.id])}" alt="" class="w-full h-full object-cover">` : adminEscape((member.name || '?')[0])}</div><div class="min-w-0 flex-1"><div class="flex items-center gap-1.5"><p class="font-bold truncate">${adminEscape(member.name)}</p>${adminRoleBadge(member)}</div><p class="text-xs text-on-surface-variant truncate">@${adminEscape(member.username)} · ${adminEscape(member.grade_class || '-')}</p></div><p class="text-xs font-semibold text-on-surface-variant whitespace-nowrap">${member.is_active ? '활성' : '비활성'} · ${adminEscape(adminRoleLabel(member.app_role))}</p><button type="button" data-edit-member class="icon-glass w-10 h-10 rounded-full"><i class="fa-solid fa-ellipsis"></i></button></article>`).join('') || '<p class="text-sm text-on-surface-variant py-10 text-center">검색 결과가 없습니다.</p>';
  wrap.querySelectorAll('[data-edit-member]').forEach((button) => button.addEventListener('click', () => adminOpenMember(button.closest('[data-member-id]').dataset.memberId)));
}

function adminOpenMember(id) {
  const member = adminMembers.find((item) => item.id === id);
  if (!member) return;
  document.getElementById('admin-member-id').value = member.id;
  document.getElementById('admin-member-name').value = member.name || '';
  document.getElementById('admin-member-grade').value = member.grade_class || '';
  document.getElementById('admin-member-phone').value = member.phone || '';
  document.getElementById('admin-member-parent-phone').value = member.parent_phone || '';
  document.getElementById('admin-member-role').value = member.app_role || 'student';
  document.getElementById('admin-member-host').checked = !!member.is_host;
  document.getElementById('admin-member-active').checked = !!member.is_active;
  const modal = document.getElementById('admin-member-modal'); modal.classList.remove('hidden'); modal.classList.add('flex');
}

function adminCloseMember() { const modal = document.getElementById('admin-member-modal'); modal?.classList.add('hidden'); modal?.classList.remove('flex'); }

function adminWireMember() {
  const roleSelect = document.getElementById('admin-member-role');
  if (roleSelect) roleSelect.innerHTML = '<option value="admin">Admin</option><option value="pastor">목사님</option><option value="department_head">부장님</option><option value="secretary">총무님</option><option value="teacher">교사</option><option value="student">학생</option>';
  const hostLabel = document.getElementById('admin-member-host')?.closest('label');
  const activeLabel = document.getElementById('admin-member-active')?.closest('label');
  if (hostLabel?.firstChild) hostLabel.firstChild.textContent = '호스트 ';
  if (activeLabel?.firstChild) activeLabel.firstChild.textContent = '활성 ';
  document.getElementById('admin-member-search')?.addEventListener('input', adminRenderMembers);
  document.querySelectorAll('[data-close-modal]').forEach((item) => item.addEventListener('click', adminCloseMember));
  document.getElementById('admin-member-form')?.addEventListener('submit', async (event) => {
    event.preventDefault();
    const args = { target_user_id: document.getElementById('admin-member-id').value, new_name: document.getElementById('admin-member-name').value.trim(), new_grade_class: document.getElementById('admin-member-grade').value.trim(), new_phone: document.getElementById('admin-member-phone').value.trim(), new_parent_phone: document.getElementById('admin-member-parent-phone').value.trim(), new_role: document.getElementById('admin-member-role').value, new_is_host: document.getElementById('admin-member-host').checked, new_is_active: document.getElementById('admin-member-active').checked };
    const { error } = await window.supabaseClient.rpc('admin_update_member', args);
    if (error) { adminShowStatus('회원 정보를 저장하지 못했습니다.', true); return; }
    adminCloseMember(); adminShowStatus('회원 정보를 저장했습니다.'); await adminLoadMembers();
  });
  document.getElementById('admin-member-delete')?.addEventListener('click', async () => {
    const id = document.getElementById('admin-member-id').value;
    const member = adminMembers.find((item) => item.id === id);
    if (!member || !confirm(`${member.name} 회원을 강제 탈퇴시키고 모든 기록을 삭제할까요? 이 작업은 되돌릴 수 없습니다.`)) return;
    const { error } = await window.supabaseClient.rpc('admin_delete_member', { target_user_id: id });
    if (error) { adminShowStatus(error.message || '탈퇴 처리에 실패했습니다.', true); return; }
    adminCloseMember(); adminShowStatus('회원과 모든 기록을 삭제했습니다.'); await adminLoadMembers();
  });
}
