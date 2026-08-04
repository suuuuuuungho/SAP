// Shared by Home and Gallery: 기도/말씀 인증 모달 로직 + Supabase 연동 (pray_records/word_records + Storage).
// Both pages load this before their own home.js/gallery.js, and both duplicate the same modal HTML
// (#pray-modal/#pray-class-template/#word-modal/#word-verse-template) — no build step, so HTML is
// duplicated per page while this JS module is the single shared source of behavior.

const VERIFICATION_PHOTOS_BUCKET = 'verification-photos-v2';
const PRAY_PLACEHOLDER_IMAGE = 'assets/img/pray-placeholder.svg';
const PRAY_FIXED_LOCATIONS = ['대성전', '요한성전', '중등부기도', '가정'];

// Home과 Gallery 둘 다 쓰는 날짜 키 헬퍼 (Gallery는 항상 오늘 날짜만 사용).
function todayKey() {
  return dateKey(new Date());
}

function dateKey(date) {
  const y = date.getFullYear();
  const m = String(date.getMonth() + 1).padStart(2, '0');
  const d = String(date.getDate()).padStart(2, '0');
  return `${y}-${m}-${d}`;
}

let cachedUserId = null;
async function getCurrentUserId() {
  if (cachedUserId) return cachedUserId;
  if (!window.supabaseClient) return null;
  const { data: { session } } = await window.supabaseClient.auth.getSession();
  cachedUserId = session ? session.user.id : null;
  return cachedUserId;
}

function getPhotoUrl(path) {
  if (!path) return PRAY_PLACEHOLDER_IMAGE;
  const { data } = window.supabaseClient.storage.from(VERIFICATION_PHOTOS_BUCKET).getPublicUrl(path);
  return data.publicUrl;
}

function fileExtension(file) {
  const parts = file.name.split('.');
  return parts.length > 1 ? parts.pop().toLowerCase() : 'jpg';
}

async function uploadPrayPhoto(userId, dateKey, index, file) {
  const path = `pray/${userId}/${dateKey}/${index}-${Date.now()}.${fileExtension(file)}`;
  const { error } = await window.supabaseClient.storage.from(VERIFICATION_PHOTOS_BUCKET).upload(path, file, { upsert: true });
  if (error) throw error;
  return path;
}

async function uploadWordPhoto(userId, dateKey, file) {
  const path = `word/${userId}/${dateKey}-${Date.now()}.${fileExtension(file)}`;
  const { error } = await window.supabaseClient.storage.from(VERIFICATION_PHOTOS_BUCKET).upload(path, file, { upsert: true });
  if (error) throw error;
  return path;
}

async function fetchPrayRecord(userId, dateKey) {
  const { data, error } = await window.supabaseClient
    .from('pray_records').select('*').eq('user_id', userId).eq('record_date', dateKey).maybeSingle();
  if (error) { console.error('[pray-word] fetchPrayRecord', error); return null; }
  return data;
}

async function fetchWordRecord(userId, dateKey) {
  const { data, error } = await window.supabaseClient
    .from('word_records').select('*').eq('user_id', userId).eq('record_date', dateKey).maybeSingle();
  if (error) { console.error('[pray-word] fetchWordRecord', error); return null; }
  return data;
}

// Home(캐시)과 Gallery(그리드) 둘 다 쓰는 공용 조회 진입점.
async function fetchPrayWordStatus(userId, dateKey) {
  const [prayRow, wordRow] = await Promise.all([fetchPrayRecord(userId, dateKey), fetchWordRecord(userId, dateKey)]);
  const entries = prayRow ? prayRow.entries : [];
  const verses = wordRow ? wordRow.verses : [];
  return {
    pray: { entries, verified: entries.length > 0 },
    word: {
      verses,
      photoPath: wordRow ? wordRow.photo_path : null,
      photoUnavailable: wordRow ? wordRow.photo_unavailable : false,
      verified: verses.length > 0
    }
  };
}

async function savePrayRecord(userId, dateKey, entries) {
  const { error } = await window.supabaseClient.from('pray_records').upsert(
    { user_id: userId, record_date: dateKey, entries, updated_at: new Date().toISOString() },
    { onConflict: 'user_id,record_date' }
  );
  if (error) throw error;
}

async function saveWordRecord(userId, dateKey, verses, photoPath, photoUnavailable) {
  const { error } = await window.supabaseClient.from('word_records').upsert(
    { user_id: userId, record_date: dateKey, verses, photo_path: photoPath, photo_unavailable: photoUnavailable, updated_at: new Date().toISOString() },
    { onConflict: 'user_id,record_date' }
  );
  if (error) throw error;
}

async function deletePrayRecord(userId, dateKey) {
  const { error } = await window.supabaseClient.from('pray_records').delete().eq('user_id', userId).eq('record_date', dateKey);
  if (error) throw error;
}

async function deleteWordRecord(userId, dateKey) {
  const { error } = await window.supabaseClient.from('word_records').delete().eq('user_id', userId).eq('record_date', dateKey);
  if (error) throw error;
}

// --- Formatters (used by Home widget summaries and Gallery cells alike) ---

function formatPrayerSummary(entries) {
  return entries
    .filter((entry) => entry.location)
    .map((entry) => (entry.start && entry.end ? `${entry.location} ${entry.start}–${entry.end}` : entry.location))
    .join(', ');
}

function timeToMinutes(hhmm) {
  if (!hhmm) return null;
  const [h, m] = hhmm.split(':').map(Number);
  if (Number.isNaN(h) || Number.isNaN(m)) return null;
  return h * 60 + m;
}

function durationMinutes(start, end) {
  const s = timeToMinutes(start);
  const e = timeToMinutes(end);
  if (s === null || e === null) return 0;
  let diff = e - s;
  if (diff < 0) diff += 24 * 60; // crossed midnight
  return diff;
}

function formatVerseRange(entry) {
  if (!entry.startBook || !entry.startChapter || !entry.startVerse) return '';
  const start = `${entry.startBook} ${entry.startChapter}:${entry.startVerse}`;
  if (!entry.endBook || !entry.endChapter || !entry.endVerse) return start;
  const end = entry.endBook === entry.startBook
    ? `${entry.endChapter}:${entry.endVerse}`
    : `${entry.endBook} ${entry.endChapter}:${entry.endVerse}`;
  return `${start} ~ ${end}`;
}

function formatWordSummary(entries) {
  return entries.map(formatVerseRange).filter(Boolean).join(', ');
}

// dateKey가 오늘이 아니면 "(M/D)" 접미사 — Home의 날짜 선택에서만 실제로 붙는다 (Gallery는 항상 오늘).
function formatDateSuffix(dateKey) {
  if (dateKey === todayKey()) return '';
  const [, m, d] = dateKey.split('-').map(Number);
  return ` (${m}/${d})`;
}

// --- 기도 modal ---

function wirePhotoPreview(entryEl) {
  const input = entryEl.querySelector('.pray-photo-input');
  const wrap = entryEl.querySelector('.pray-photo-preview-wrap');
  const preview = entryEl.querySelector('.pray-photo-preview');
  const removeBtn = entryEl.querySelector('.pray-photo-remove');
  const unavailableInput = entryEl.querySelector('.pray-photo-unavailable-input');
  if (!input || !wrap || !preview) return;

  function clearPhoto() {
    if (preview.dataset.objectUrl) {
      URL.revokeObjectURL(preview.dataset.objectUrl);
      delete preview.dataset.objectUrl;
    }
    delete entryEl.dataset.existingPhotoPath;
    preview.src = '';
    wrap.classList.add('hidden');
    input.value = '';
  }

  input.addEventListener('change', () => {
    const file = input.files && input.files[0];
    if (!file) {
      clearPhoto();
      return;
    }
    delete entryEl.dataset.existingPhotoPath;
    if (preview.dataset.objectUrl) URL.revokeObjectURL(preview.dataset.objectUrl);
    const url = URL.createObjectURL(file);
    preview.src = url;
    preview.dataset.objectUrl = url;
    wrap.classList.remove('hidden');
  });

  if (removeBtn) {
    removeBtn.addEventListener('click', () => {
      clearPhoto();
      if (unavailableInput && unavailableInput.checked) {
        unavailableInput.checked = false;
      }
    });
  }

  if (unavailableInput) {
    unavailableInput.addEventListener('change', () => {
      if (unavailableInput.checked) {
        clearPhoto();
        input.disabled = true;
        preview.src = PRAY_PLACEHOLDER_IMAGE;
        wrap.classList.remove('hidden');
      } else {
        input.disabled = false;
        clearPhoto();
      }
    });
  }
}

function updatePrayRemoveButtons() {
  const entries = document.querySelectorAll('#pray-class-list .pray-class-entry');
  entries.forEach((entry) => {
    const removeBtn = entry.querySelector('.pray-remove-class');
    if (removeBtn) removeBtn.classList.toggle('hidden', entries.length <= 1);
  });
}

// "YYYY.MM.DD HH:MM ~ YYYY.MM.DD HH:MM" 형태로 보여주는 캡션. 항목 자체의 날짜 입력값을 쓴다
// (항목마다 다른 날짜를 지정할 수 있으므로, 모달을 연 날짜가 아니라 이 항목의 날짜 기준).
function updatePrayEntryDateTimeLabel(entryEl) {
  const label = entryEl.querySelector('.pray-entry-datetime');
  if (!label) return;
  const dateValue = entryEl.querySelector('.pray-date-input').value;
  const start = entryEl.querySelector('.pray-start-input').value;
  const end = entryEl.querySelector('.pray-end-input').value;
  if (!dateValue || !start || !end) {
    label.textContent = '';
    return;
  }
  const [y, m, d] = dateValue.split('-');
  const datePrefix = `${y}.${m}.${d}`;
  label.textContent = `${datePrefix} ${start} ~ ${datePrefix} ${end}`;
}

function addPrayClassEntry(dateKey, data) {
  const template = document.getElementById('pray-class-template');
  const list = document.getElementById('pray-class-list');
  if (!template || !list) return;

  list.appendChild(template.content.cloneNode(true));
  const entryEl = list.lastElementChild;
  wirePhotoPreview(entryEl);

  const dateInput = entryEl.querySelector('.pray-date-input');
  dateInput.value = (data && data.date) || dateKey;

  const locationSelect = entryEl.querySelector('.pray-location-input');
  const locationOtherInput = entryEl.querySelector('.pray-location-other-input');
  locationSelect.addEventListener('change', () => {
    locationOtherInput.classList.toggle('hidden', locationSelect.value !== '기타');
  });

  if (data) {
    if (data.location) {
      if (PRAY_FIXED_LOCATIONS.includes(data.location)) {
        locationSelect.value = data.location;
      } else {
        locationSelect.value = '기타';
        locationOtherInput.value = data.location;
        locationOtherInput.classList.remove('hidden');
      }
    }
    if (data.start) entryEl.querySelector('.pray-start-input').value = data.start;
    if (data.end) entryEl.querySelector('.pray-end-input').value = data.end;
    if (data.photoUnavailable) {
      const unavailableInput = entryEl.querySelector('.pray-photo-unavailable-input');
      if (unavailableInput) {
        unavailableInput.checked = true;
        unavailableInput.dispatchEvent(new Event('change'));
      }
    } else if (data.photoPath) {
      entryEl.dataset.existingPhotoPath = data.photoPath;
      const wrap = entryEl.querySelector('.pray-photo-preview-wrap');
      const preview = entryEl.querySelector('.pray-photo-preview');
      preview.src = getPhotoUrl(data.photoPath);
      wrap.classList.remove('hidden');
    }
  }

  updatePrayEntryDateTimeLabel(entryEl);
  dateInput.addEventListener('input', () => updatePrayEntryDateTimeLabel(entryEl));
  entryEl.querySelector('.pray-start-input').addEventListener('input', () => updatePrayEntryDateTimeLabel(entryEl));
  entryEl.querySelector('.pray-end-input').addEventListener('input', () => updatePrayEntryDateTimeLabel(entryEl));

  updatePrayRemoveButtons();
}

let prayModalDateKey = null;
let prayModalOnSaved = null;

async function resetPrayerRecord() {
  if (!confirm('기도 기록을 전체 초기화할까요?')) return;
  const userId = await getCurrentUserId();
  await deletePrayRecord(userId, prayModalDateKey);
  if (prayModalOnSaved) prayModalOnSaved();
  closePrayModal();
}

// dateKey: 이 인증이 저장될 날짜 (Home은 선택된 날짜, Gallery는 항상 오늘).
// onSaved: 저장/초기화 성공 후 호출되는 콜백 (호출한 쪽이 자기 화면을 다시 그림).
async function openPrayModal(dateKey, onSaved) {
  const modal = document.getElementById('pray-modal');
  const list = document.getElementById('pray-class-list');
  if (!modal || !list) return;

  prayModalDateKey = dateKey;
  prayModalOnSaved = onSaved;
  list.innerHTML = '';

  const titleEl = modal.querySelector('h2');
  if (titleEl) titleEl.textContent = `기도 인증${formatDateSuffix(dateKey)}`;

  const userId = await getCurrentUserId();
  const record = await fetchPrayRecord(userId, dateKey);
  const existing = record ? record.entries : [];
  if (existing.length > 0) {
    existing.forEach((entry) => addPrayClassEntry(dateKey, entry));
  } else {
    addPrayClassEntry(dateKey);
  }

  const hint = document.getElementById('pray-class-hint');
  if (hint) hint.classList.add('hidden');

  modal.classList.remove('hidden');
  modal.classList.add('flex');
}

function closePrayModal() {
  const modal = document.getElementById('pray-modal');
  if (!modal) return;
  modal.classList.add('hidden');
  modal.classList.remove('flex');
}

// 항목마다 날짜가 다를 수 있으므로, 저장 시 날짜별로 묶어서 각자의 pray_records 행에 나눠 쓴다.
// 모달을 연 원래 날짜(originalDateKey)는 지금 모달에 남아있는 것으로 완전히 교체(비었으면 행 삭제),
// 다른 날짜로 옮겨진 항목은 그 날짜의 기존 기록 뒤에 이어붙인다 (그 날짜의 다른 항목은 안 불러왔으므로 덮어쓰지 않음).
async function savePrayModal() {
  const originalDateKey = prayModalDateKey;
  const saveBtn = document.getElementById('pray-save');
  const prayClassHint = document.getElementById('pray-class-hint');
  const entryEls = [...document.querySelectorAll('#pray-class-list .pray-class-entry')];

  const drafts = entryEls.map((entry) => {
    const locationSelect = entry.querySelector('.pray-location-input');
    const location = locationSelect.value === '기타'
      ? entry.querySelector('.pray-location-other-input').value.trim()
      : locationSelect.value;
    const photoUnavailable = entry.querySelector('.pray-photo-unavailable-input').checked;
    const newFile = entry.querySelector('.pray-photo-input').files[0] || null;
    const existingPhotoPath = entry.dataset.existingPhotoPath || null;
    return {
      entry, location, photoUnavailable, newFile, existingPhotoPath,
      date: entry.querySelector('.pray-date-input').value,
      start: entry.querySelector('.pray-start-input').value,
      end: entry.querySelector('.pray-end-input').value,
      hasPhoto: photoUnavailable || !!newFile || !!existingPhotoPath
    };
  });

  const hasIncompleteEntry = drafts.some((d) => !d.hasPhoto || !d.location || !d.start || !d.end || !d.date);
  if (hasIncompleteEntry) {
    if (prayClassHint) prayClassHint.classList.remove('hidden');
    return;
  }
  if (prayClassHint) prayClassHint.classList.add('hidden');

  if (saveBtn) { saveBtn.disabled = true; saveBtn.textContent = '저장 중...'; }

  try {
    const userId = await getCurrentUserId();
    const byDate = {};
    for (let i = 0; i < drafts.length; i += 1) {
      const d = drafts[i];
      let photoPath = d.photoUnavailable ? null : d.existingPhotoPath;
      if (!d.photoUnavailable && d.newFile) {
        photoPath = await uploadPrayPhoto(userId, d.date, i, d.newFile);
      }
      if (!byDate[d.date]) byDate[d.date] = [];
      byDate[d.date].push({ location: d.location, start: d.start, end: d.end, photoUnavailable: d.photoUnavailable, photoPath });
    }

    if (byDate[originalDateKey] && byDate[originalDateKey].length > 0) {
      await savePrayRecord(userId, originalDateKey, byDate[originalDateKey]);
    } else {
      await deletePrayRecord(userId, originalDateKey);
    }

    const otherDates = Object.keys(byDate).filter((d) => d !== originalDateKey);
    for (const date of otherDates) {
      const existingRecord = await fetchPrayRecord(userId, date);
      const merged = [...(existingRecord ? existingRecord.entries : []), ...byDate[date]];
      await savePrayRecord(userId, date, merged);
    }

    if (saveBtn) { saveBtn.disabled = false; saveBtn.textContent = '저장'; }
    if (prayModalOnSaved) prayModalOnSaved();
    closePrayModal();
  } catch (err) {
    console.error('[pray-word] savePrayModal', err);
    if (saveBtn) { saveBtn.disabled = false; saveBtn.textContent = '저장'; }
    if (prayClassHint) {
      prayClassHint.textContent = '저장에 실패했습니다. 잠시 후 다시 시도해주세요.';
      prayClassHint.classList.remove('hidden');
    }
  }
}

// 기도 모달의 정적 버튼(닫기/취소/추가/저장/초기화)은 페이지당 한 번만 wiring하면 됨 —
// 항목 자체는 addPrayClassEntry가 매번 새로 만들어 붙인다.
function wirePrayModalStatic() {
  const closeBtn = document.getElementById('pray-modal-close');
  const overlay = document.getElementById('pray-modal-overlay');
  const cancelBtn = document.getElementById('pray-cancel');
  const addBtn = document.getElementById('pray-add-class');
  const saveBtn = document.getElementById('pray-save');
  const resetBtn = document.getElementById('pray-reset');
  const list = document.getElementById('pray-class-list');

  if (closeBtn) closeBtn.addEventListener('click', closePrayModal);
  if (overlay) overlay.addEventListener('click', closePrayModal);
  if (cancelBtn) cancelBtn.addEventListener('click', closePrayModal);
  if (addBtn) addBtn.addEventListener('click', () => addPrayClassEntry(prayModalDateKey));
  if (resetBtn) resetBtn.addEventListener('click', resetPrayerRecord);
  if (saveBtn) saveBtn.addEventListener('click', savePrayModal);

  if (list) {
    list.addEventListener('click', (e) => {
      const removeBtn = e.target.closest('.pray-remove-class');
      if (!removeBtn) return;
      removeBtn.closest('.pray-class-entry').remove();
      updatePrayRemoveButtons();
    });
  }
}

// --- 말씀 modal (사진 하나 + 구절 여러 개) ---

function wireWordPhotoPreview() {
  const input = document.getElementById('word-photo-input');
  const wrap = document.getElementById('word-photo-preview-wrap');
  const preview = document.getElementById('word-photo-preview');
  const removeBtn = document.getElementById('word-photo-remove');
  const hint = document.getElementById('word-photo-hint');
  if (!input || !wrap || !preview) return;

  function clearPhoto() {
    if (preview.dataset.objectUrl) {
      URL.revokeObjectURL(preview.dataset.objectUrl);
      delete preview.dataset.objectUrl;
    }
    delete wrap.dataset.existingPhotoPath;
    preview.src = '';
    wrap.classList.add('hidden');
    input.value = '';
  }

  input.addEventListener('change', () => {
    if (hint) hint.classList.add('hidden');
    const file = input.files && input.files[0];
    if (!file) {
      clearPhoto();
      return;
    }
    delete wrap.dataset.existingPhotoPath;
    if (preview.dataset.objectUrl) URL.revokeObjectURL(preview.dataset.objectUrl);
    const url = URL.createObjectURL(file);
    preview.src = url;
    preview.dataset.objectUrl = url;
    wrap.classList.remove('hidden');
  });

  if (removeBtn) removeBtn.addEventListener('click', clearPhoto);
}

function updateWordRemoveButtons() {
  const entries = document.querySelectorAll('#word-verse-list .word-verse-entry');
  entries.forEach((entry) => {
    const removeBtn = entry.querySelector('.word-remove-verse');
    if (removeBtn) removeBtn.classList.toggle('hidden', entries.length <= 1);
  });
}

function addWordVerseEntry(data) {
  const template = document.getElementById('word-verse-template');
  const list = document.getElementById('word-verse-list');
  if (!template || !list) return;

  list.appendChild(template.content.cloneNode(true));
  const entryEl = list.lastElementChild;

  renderBibleBookOptions(entryEl.querySelector('.word-start-book'));
  renderBibleBookOptions(entryEl.querySelector('.word-end-book'));

  if (data) {
    if (data.startBook) entryEl.querySelector('.word-start-book').value = data.startBook;
    if (data.startChapter) entryEl.querySelector('.word-start-chapter').value = data.startChapter;
    if (data.startVerse) entryEl.querySelector('.word-start-verse').value = data.startVerse;
    if (data.endBook) entryEl.querySelector('.word-end-book').value = data.endBook;
    if (data.endChapter) entryEl.querySelector('.word-end-chapter').value = data.endChapter;
    if (data.endVerse) entryEl.querySelector('.word-end-verse').value = data.endVerse;
  }

  updateWordRemoveButtons();
}

let wordModalDateKey = null;
let wordModalOnSaved = null;

async function resetWordRecord() {
  if (!confirm('말씀 기록을 전체 초기화할까요?')) return;
  const userId = await getCurrentUserId();
  await deleteWordRecord(userId, wordModalDateKey);
  if (wordModalOnSaved) wordModalOnSaved();
  closeWordModal();
}

async function openWordModal(dateKey, onSaved) {
  const modal = document.getElementById('word-modal');
  const list = document.getElementById('word-verse-list');
  if (!modal || !list) return;

  wordModalDateKey = dateKey;
  wordModalOnSaved = onSaved;
  list.innerHTML = '';

  const titleEl = modal.querySelector('h2');
  if (titleEl) titleEl.textContent = `말씀 인증${formatDateSuffix(dateKey)}`;

  const userId = await getCurrentUserId();
  const record = await fetchWordRecord(userId, dateKey);
  const existing = record ? record.verses : [];
  if (existing.length > 0) {
    existing.forEach((entry) => addWordVerseEntry(entry));
  } else {
    addWordVerseEntry();
  }

  const photoInput = document.getElementById('word-photo-input');
  const photoWrap = document.getElementById('word-photo-preview-wrap');
  const photoPreview = document.getElementById('word-photo-preview');
  const photoHint = document.getElementById('word-photo-hint');
  const verseHint = document.getElementById('word-verse-hint');
  if (photoInput) photoInput.value = '';
  if (photoWrap) { photoWrap.classList.add('hidden'); delete photoWrap.dataset.existingPhotoPath; }
  if (photoHint) photoHint.classList.add('hidden');
  if (verseHint) verseHint.classList.add('hidden');

  if (record && !record.photo_unavailable && record.photo_path && photoWrap && photoPreview) {
    photoWrap.dataset.existingPhotoPath = record.photo_path;
    photoPreview.src = getPhotoUrl(record.photo_path);
    photoWrap.classList.remove('hidden');
  }

  modal.classList.remove('hidden');
  modal.classList.add('flex');
}

function closeWordModal() {
  const modal = document.getElementById('word-modal');
  if (!modal) return;
  modal.classList.add('hidden');
  modal.classList.remove('flex');
}

async function saveWordModal() {
  const dateKey = wordModalDateKey;
  const saveBtn = document.getElementById('word-save');
  const photoInput = document.getElementById('word-photo-input');
  const photoWrap = document.getElementById('word-photo-preview-wrap');
  const photoHint = document.getElementById('word-photo-hint');
  const wordVerseHint = document.getElementById('word-verse-hint');

  const newFile = photoInput && photoInput.files && photoInput.files[0];
  const existingPhotoPath = (photoWrap && photoWrap.dataset.existingPhotoPath) || null;
  const hasPhoto = !!newFile || !!existingPhotoPath;

  if (!hasPhoto) {
    if (photoHint) photoHint.classList.remove('hidden');
    return;
  }

  const verses = [...document.querySelectorAll('#word-verse-list .word-verse-entry')].map((entry) => ({
    startBook: entry.querySelector('.word-start-book').value,
    startChapter: entry.querySelector('.word-start-chapter').value,
    startVerse: entry.querySelector('.word-start-verse').value,
    endBook: entry.querySelector('.word-end-book').value,
    endChapter: entry.querySelector('.word-end-chapter').value,
    endVerse: entry.querySelector('.word-end-verse').value
  }));

  const hasIncompleteEntry = verses.some((entry) => Object.values(entry).some((value) => !value));
  if (hasIncompleteEntry) {
    if (wordVerseHint) wordVerseHint.classList.remove('hidden');
    return;
  }
  if (wordVerseHint) wordVerseHint.classList.add('hidden');

  if (saveBtn) { saveBtn.disabled = true; saveBtn.textContent = '저장 중...'; }

  try {
    const userId = await getCurrentUserId();
    const photoPath = newFile ? await uploadWordPhoto(userId, dateKey, newFile) : existingPhotoPath;

    await saveWordRecord(userId, dateKey, verses, photoPath, false);

    if (saveBtn) { saveBtn.disabled = false; saveBtn.textContent = '저장'; }
    if (wordModalOnSaved) wordModalOnSaved();
    closeWordModal();
  } catch (err) {
    console.error('[pray-word] saveWordModal', err);
    if (saveBtn) { saveBtn.disabled = false; saveBtn.textContent = '저장'; }
    if (photoHint) {
      photoHint.textContent = '저장에 실패했습니다. 잠시 후 다시 시도해주세요.';
      photoHint.classList.remove('hidden');
    }
  }
}

function wireWordModalStatic() {
  const closeBtn = document.getElementById('word-modal-close');
  const overlay = document.getElementById('word-modal-overlay');
  const cancelBtn = document.getElementById('word-cancel');
  const addBtn = document.getElementById('word-add-verse');
  const saveBtn = document.getElementById('word-save');
  const resetBtn = document.getElementById('word-reset');
  const list = document.getElementById('word-verse-list');

  wireWordPhotoPreview();

  if (closeBtn) closeBtn.addEventListener('click', closeWordModal);
  if (overlay) overlay.addEventListener('click', closeWordModal);
  if (cancelBtn) cancelBtn.addEventListener('click', closeWordModal);
  if (addBtn) addBtn.addEventListener('click', () => addWordVerseEntry());
  if (resetBtn) resetBtn.addEventListener('click', resetWordRecord);
  if (saveBtn) saveBtn.addEventListener('click', saveWordModal);

  if (list) {
    list.addEventListener('click', (e) => {
      const removeBtn = e.target.closest('.word-remove-verse');
      if (!removeBtn) return;
      removeBtn.closest('.word-verse-entry').remove();
      updateWordRemoveButtons();
    });
  }
}
