// Home/Gallery에서 사용할 가입자 프로필 사진의 1시간짜리 임시 접근 주소를 만듭니다.
async function getProfileAvatarUrls(userIds) {
  const ids = [...new Set((userIds || []).filter(Boolean))];
  if (!ids.length || !window.supabaseClient) return {};

  const { data: paths, error } = await window.supabaseClient
    .rpc('get_profile_avatar_paths', { requested_user_ids: ids });
  if (error) {
    console.error('[profile-avatar] paths', error);
    return {};
  }

  const entries = await Promise.all((paths || []).filter((row) => row.avatar_path).map(async (row) => {
    const { data } = await window.supabaseClient.storage
      .from('profile-avatars')
      .createSignedUrl(row.avatar_path, 3600);
    return [row.user_id, data?.signedUrl || ''];
  }));
  return Object.fromEntries(entries.filter(([, url]) => url));
}

async function getPublicProfileCards(userIds) {
  const ids = [...new Set((userIds || []).filter(Boolean))];
  if (!ids.length || !window.supabaseClient) return {};
  const { data: profiles, error } = await window.supabaseClient
    .rpc('get_public_profile_cards', { requested_user_ids: ids });
  if (error) {
    console.error('[profile-avatar] public cards', error);
    return {};
  }
  const entries = await Promise.all((profiles || []).map(async (profile) => {
    let avatarUrl = '';
    if (profile.avatar_path) {
      const { data } = await window.supabaseClient.storage
        .from('profile-avatars')
        .createSignedUrl(profile.avatar_path, 3600);
      avatarUrl = data?.signedUrl || '';
    }
    return [profile.user_id, { ...profile, avatarUrl }];
  }));
  return Object.fromEntries(entries);
}

function publicProfileBadgeHTML(role, isHost = false) {
  const host = isHost ? '<span class="inline-flex w-4 h-4 rounded-full bg-amber-100 text-amber-600 items-center justify-center align-middle ml-1" title="Host" aria-label="Host"><i class="fa-solid fa-crown text-[8px]"></i></span>' : '';
  if (!role) return host;
  const labels = { admin: '관리자', teacher: '교사', pastor: '목사님', department_head: '부장님', secretary: '총무님' };
  const colors = { teacher: 'bg-lime-500', pastor: 'bg-violet-500', department_head: 'bg-amber-500', secretary: 'bg-cyan-500' };
  const label = labels[role] || role;
  const color = colors[role] || 'bg-blue-500';
  return `${host}<span class="inline-flex w-4 h-4 rounded-full ${color} text-white items-center justify-center align-middle ml-1" title="${label}" aria-label="${label}"><i class="fa-solid fa-check text-[8px]"></i></span>`;
}

window.getProfileAvatarUrls = getProfileAvatarUrls;
window.getPublicProfileCards = getPublicProfileCards;
window.publicProfileBadgeHTML = publicProfileBadgeHTML;
