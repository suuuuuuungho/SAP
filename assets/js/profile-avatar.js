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

window.getProfileAvatarUrls = getProfileAvatarUrls;
