const PROFILE_AVATAR_BUCKET = 'profile-avatars';
let profileUser = null;
let profileData = null;

function setProfileStatus(element, message, isError = false) {
  element.textContent = message;
  element.classList.remove('hidden', 'text-error', 'text-primary', 'text-on-surface-variant');
  element.classList.add(isError ? 'text-error' : 'text-primary');
}

async function renderProfileAvatar(path) {
  const preview = document.getElementById('profile-avatar-preview');
  const deleteButton = document.getElementById('profile-photo-delete');
  if (!preview) return;
  deleteButton?.classList.toggle('hidden', !path);
  if (!path) {
    preview.innerHTML = '';
    preview.textContent = (profileData?.name || profileData?.username || '?').charAt(0).toUpperCase();
    return;
  }
  const { data, error } = await window.supabaseClient.storage.from(PROFILE_AVATAR_BUCKET).createSignedUrl(path, 3600);
  if (error || !data?.signedUrl) {
    preview.textContent = (profileData?.name || '?').charAt(0).toUpperCase();
    return;
  }
  preview.innerHTML = `<img src="${data.signedUrl}" alt="프로필 사진" class="w-full h-full object-cover">`;
}

async function loadProfile() {
  const { data: { session } } = await window.supabaseClient.auth.getSession();
  if (!session?.user) return;
  profileUser = session.user;

  let result = await window.supabaseClient
    .from('profiles')
    .select('username, name, grade_class, phone, email, avatar_path')
    .eq('id', profileUser.id)
    .maybeSingle();
  if (result.error) {
    result = await window.supabaseClient
      .from('profiles')
      .select('username, name, grade_class, phone')
      .eq('id', profileUser.id)
      .maybeSingle();
  }
  profileData = result.data;
  if (!profileData) return;

  document.getElementById('profile-display-name').textContent = `${profileData.name} (${profileData.username})`;
  document.getElementById('profile-meta').textContent = `${profileData.grade_class} · ${profileData.phone}`;
  await renderProfileAvatar(profileData.avatar_path);
}

function wireProfilePhoto() {
  const input = document.getElementById('profile-photo-input');
  const button = document.getElementById('profile-photo-select');
  const deleteButton = document.getElementById('profile-photo-delete');
  const status = document.getElementById('profile-photo-status');
  if (!input || !button) return;

  button.addEventListener('click', () => input.click());
  input.addEventListener('change', async () => {
    const file = input.files?.[0];
    if (!file) return;
    if (!['image/jpeg', 'image/png', 'image/webp'].includes(file.type)) {
      setProfileStatus(status, 'JPG, PNG, WebP 사진만 사용할 수 있습니다.', true);
      return;
    }
    if (file.size > 5 * 1024 * 1024) {
      setProfileStatus(status, '사진 크기는 5MB 이하여야 합니다.', true);
      return;
    }

    button.disabled = true;
    button.innerHTML = '<i class="fa-solid fa-spinner fa-spin mr-2"></i>업로드 중...';
    const path = `${profileUser.id}/avatar`;
    const { error: uploadError } = await window.supabaseClient.storage
      .from(PROFILE_AVATAR_BUCKET)
      .upload(path, file, { upsert: true, contentType: file.type, cacheControl: '3600' });

    if (uploadError) {
      setProfileStatus(status, '사진을 저장하지 못했습니다. 프로필 스키마를 먼저 실행해주세요.', true);
    } else {
      const { error: rpcError } = await window.supabaseClient.rpc('set_my_avatar_path', { new_path: path });
      if (rpcError) {
        setProfileStatus(status, '프로필 정보를 갱신하지 못했습니다.', true);
      } else {
        profileData.avatar_path = path;
        await renderProfileAvatar(path);
        setProfileStatus(status, '프로필 사진이 변경되었습니다.');
        initAuthUI();
      }
    }
    button.disabled = false;
    button.innerHTML = '<i class="fa-solid fa-camera mr-2"></i>사진 변경';
    input.value = '';
  });

  deleteButton.addEventListener('click', async () => {
    if (!profileData?.avatar_path) return;
    deleteButton.disabled = true;
    button.disabled = true;
    deleteButton.innerHTML = '<i class="fa-solid fa-spinner fa-spin mr-2"></i>삭제 중...';
    const path = profileData.avatar_path;
    const { error: removeError } = await window.supabaseClient.storage
      .from(PROFILE_AVATAR_BUCKET)
      .remove([path]);
    if (removeError) {
      setProfileStatus(status, '프로필 사진을 삭제하지 못했습니다.', true);
    } else {
      const { error: rpcError } = await window.supabaseClient.rpc('set_my_avatar_path', { new_path: null });
      if (rpcError) {
        setProfileStatus(status, '프로필 정보를 갱신하지 못했습니다.', true);
      } else {
        profileData.avatar_path = null;
        await renderProfileAvatar(null);
        setProfileStatus(status, '프로필 사진이 삭제되었습니다.');
        initAuthUI();
      }
    }
    deleteButton.disabled = false;
    button.disabled = false;
    deleteButton.innerHTML = '<i class="fa-regular fa-trash-can mr-2"></i>사진 삭제';
  });
}

function wireProfilePassword() {
  const form = document.getElementById('profile-password-form');
  if (!form) return;
  const newInput = document.getElementById('profile-new-password-input');
  const confirmInput = document.getElementById('profile-new-password-confirm-input');
  const matchHint = document.getElementById('profile-password-match');
  const submit = document.getElementById('profile-password-submit');
  const status = document.getElementById('profile-password-status');

  form.addEventListener('submit', async (event) => {
    event.preventDefault();
    matchHint.classList.add('hidden');
    status.classList.add('hidden');
    if (newInput.value !== confirmInput.value) {
      matchHint.classList.remove('hidden');
      return;
    }

    submit.disabled = true;
    submit.textContent = '변경 중...';
    const { error } = await window.supabaseClient.auth.updateUser({ password: normalizeAuthPassword(newInput.value) });
    if (error) {
      setProfileStatus(status, '비밀번호를 변경하지 못했습니다.', true);
    } else {
      setProfileStatus(status, '비밀번호가 변경되었습니다.');
      form.reset();
    }
    submit.disabled = false;
    submit.textContent = '비밀번호 변경';
  });
}

async function initProfileWidgets() {
  if (!document.getElementById('profile-avatar-preview') || !window.supabaseClient) return;
  await loadProfile();
  wireProfilePhoto();
  wireProfilePassword();
}

window.initProfileWidgets = initProfileWidgets;
