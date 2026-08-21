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

// --- 말씀 묵상 스캔 OCR: 날짜별 예상 본문(요한복음 1~21장, 평일만)과 대조해 caution 표시 ---
// Gallery의 galleryReadingLabel()과 동일한 매핑(운영기간 2026-08-10~09-06 평일 20일,
// 마지막 날만 20·21장 두 장)을 index.html이 gallery.js를 불러오지 않아도 되도록 여기서 다시 구현.
const WORD_READING_START = '2026-08-10';
const WORD_READING_END = '2026-09-06';
let wordPhotoOcrToken = 0;
let wordPhotoOcrMismatch = false;
let wordPhotoProcessedFile = null;

function buildWordReadingDays() {
  const result = [];
  const cursor = new Date(`${WORD_READING_START}T12:00:00`);
  const end = new Date(`${WORD_READING_END}T12:00:00`);
  while (cursor <= end) {
    const weekday = cursor.getDay();
    if (weekday >= 1 && weekday <= 5) result.push(dateKey(cursor));
    cursor.setDate(cursor.getDate() + 1);
  }
  return result;
}

function expectedWordChapters(targetDateKey) {
  const days = buildWordReadingDays();
  const index = days.indexOf(targetDateKey);
  if (index < 0) return null;
  return index === days.length - 1 ? [20, 21] : [index + 1];
}

function expectedWordChapterLabel(targetDateKey) {
  const chapters = expectedWordChapters(targetDateKey);
  return chapters ? `요한복음 ${chapters.join('·')}장` : null;
}

function wordOcrTextMatchesChapters(text, chapters) {
  if (!text) return false;
  // OCR이 숫자를 문자로 잘못 읽는 흔한 오탐(O→0, l/I→1)만 가볍게 보정한 뒤
  // "숫자+장" 패턴을 전부 뽑아 기대 챕터와 겹치는 게 있는지 확인한다.
  const normalized = text.replace(/[Oo](?=\d*\s*장)/g, '0').replace(/[lI](?=\d*\s*장)/g, '1');
  const matches = [...normalized.matchAll(/(\d{1,2})\s*장/g)].map((m) => Number(m[1]));
  return matches.some((n) => chapters.includes(n));
}

function setWordOcrCaution(message) {
  const banner = document.getElementById('word-photo-ocr-caution');
  const text = document.getElementById('word-photo-ocr-caution-text');
  wordPhotoOcrMismatch = !!message;
  if (!banner || !text) return;
  if (message) {
    text.textContent = message;
    banner.classList.remove('hidden');
  } else {
    banner.classList.add('hidden');
  }
}

function setWordOcrStatus(message) {
  const statusEl = document.getElementById('word-photo-ocr-status');
  const textEl = document.getElementById('word-photo-ocr-status-text');
  if (!statusEl) return;
  if (message) {
    if (textEl) textEl.textContent = message;
    statusEl.classList.remove('hidden');
  } else {
    statusEl.classList.add('hidden');
  }
}

async function runWordPhotoOcr(file) {
  setWordOcrCaution('');
  const token = ++wordPhotoOcrToken;
  const chapters = expectedWordChapters(wordModalDateKey);
  if (!chapters || !window.Tesseract) return;
  setWordOcrStatus('본문 인식 중...');
  try {
    const { data } = await window.Tesseract.recognize(file, 'kor+eng');
    if (token !== wordPhotoOcrToken) return;
    const matched = wordOcrTextMatchesChapters(data.text, chapters);
    if (!matched) {
      setWordOcrCaution(`선택하신 날짜(${wordModalDateKey})의 본문은 ${expectedWordChapterLabel(wordModalDateKey)}인데, 스캔한 사진에서 확인하지 못했어요.`);
    }
  } catch (err) {
    console.error('[pray-word] word photo ocr', err);
  } finally {
    if (token === wordPhotoOcrToken) setWordOcrStatus('');
  }
}

// 1D 박스 블러(이동 평균): 반경 radius 윈도우의 평균을 O(n)에 계산해 조명/그림자의
// "국소 배경 밝기"를 추정하는 데 쓴다. horizontal=true면 가로 방향, false면 세로 방향.
function boxBlur1D(src, width, height, radius, horizontal) {
  const out = new Float32Array(src.length);
  if (horizontal) {
    for (let y = 0; y < height; y += 1) {
      const rowStart = y * width;
      let sum = 0;
      let count = 0;
      for (let x = 0; x <= radius && x < width; x += 1) { sum += src[rowStart + x]; count += 1; }
      out[rowStart] = sum / count;
      for (let x = 1; x < width; x += 1) {
        const addIdx = x + radius;
        const removeIdx = x - radius - 1;
        if (addIdx < width) { sum += src[rowStart + addIdx]; count += 1; }
        if (removeIdx >= 0) { sum -= src[rowStart + removeIdx]; count -= 1; }
        out[rowStart + x] = sum / count;
      }
    }
  } else {
    for (let x = 0; x < width; x += 1) {
      let sum = 0;
      let count = 0;
      for (let y = 0; y <= radius && y < height; y += 1) { sum += src[y * width + x]; count += 1; }
      out[x] = sum / count;
      for (let y = 1; y < height; y += 1) {
        const addIdx = y + radius;
        const removeIdx = y - radius - 1;
        if (addIdx < height) { sum += src[addIdx * width + x]; count += 1; }
        if (removeIdx >= 0) { sum -= src[removeIdx * width + x]; count -= 1; }
        out[y * width + x] = sum / count;
      }
    }
  }
  return out;
}

function localBackgroundLuma(lumas, width, height, radius) {
  return boxBlur1D(boxBlur1D(lumas, width, height, radius, true), width, height, radius, false);
}

// 휴대폰으로 찍은 원본 사진을 스캐너 앱처럼 순수 흑백(이진화)으로 자동 보정한다.
// 종이 전체의 밝기 평균이 아니라 각 픽셀 주변의 "국소 배경 밝기"와 비교해서 어둡게 찍힌
// 그림자 부분도 흰 배경으로, 글씨는 검게 떨어지도록 만든다(적응형 이진화).
// 미리보기/OCR/실제 업로드 모두 이 보정된 파일을 사용해 글자를 더 또렷하게 만든다.
async function scanEnhanceImage(file) {
  if (!file || !String(file.type || '').startsWith('image/')) return file;
  if (file.type === 'image/gif' || file.type === 'image/svg+xml') return file;

  const maxDimension = 1800;
  let source = null;
  let objectUrl = '';
  try {
    if ('createImageBitmap' in window) {
      try {
        source = await createImageBitmap(file, { imageOrientation: 'from-image' });
      } catch (_) {
        try {
          source = await createImageBitmap(file);
        } catch (_2) {
          source = null;
        }
      }
    }
    if (!source) {
      // 일부 브라우저/사진 형식(예: HEIC)에서 createImageBitmap이 실패할 수 있어
      // <img> 엘리먼트로 디코딩하는 방식으로 한 번 더 시도한다.
      objectUrl = URL.createObjectURL(file);
      source = await new Promise((resolve, reject) => {
        const image = new Image();
        image.onload = () => resolve(image);
        image.onerror = reject;
        image.src = objectUrl;
      });
    }

    const width = source.width || source.naturalWidth;
    const height = source.height || source.naturalHeight;
    if (!width || !height) return file;
    const scale = Math.min(1, maxDimension / Math.max(width, height));
    const targetWidth = Math.max(1, Math.round(width * scale));
    const targetHeight = Math.max(1, Math.round(height * scale));
    const canvas = document.createElement('canvas');
    canvas.width = targetWidth;
    canvas.height = targetHeight;
    const context = canvas.getContext('2d');
    context.drawImage(source, 0, 0, targetWidth, targetHeight);

    const imageData = context.getImageData(0, 0, targetWidth, targetHeight);
    const pixels = imageData.data;
    const lumas = new Float32Array(targetWidth * targetHeight);
    for (let i = 0, p = 0; i < pixels.length; i += 4, p += 1) {
      lumas[p] = 0.299 * pixels[i] + 0.587 * pixels[i + 1] + 0.114 * pixels[i + 2];
    }
    // 반경은 이미지 크기에 비례하되, 글씨 획보다는 충분히 크고(획을 배경으로 착각하지 않게)
    // 그림자 얼룩보다는 충분히 작게(20~80px 사이) 잡는다.
    const radius = Math.max(20, Math.min(80, Math.round(Math.max(targetWidth, targetHeight) / 20)));
    const background = localBackgroundLuma(lumas, targetWidth, targetHeight, radius);
    // 완전 흑/백으로 이진화하면 연필/옅은 펜 글씨가 지워져 보이지 않을 수 있어,
    // 대신 각 픽셀을 "국소 배경 대비 상대값"으로 다시 매핑한다: 배경은 그림자와 무관하게
    // 항상 밝게(bgTarget) 정리되면서도, 옅은 글씨는 회색조 그러데이션으로 남아 눈에 보인다.
    const bgTarget = 235;
    const gain = 2.1;
    for (let i = 0, p = 0; i < pixels.length; i += 4, p += 1) {
      const value = Math.max(0, Math.min(255, bgTarget + (lumas[p] - background[p]) * gain));
      pixels[i] = pixels[i + 1] = pixels[i + 2] = value;
    }
    context.putImageData(imageData, 0, 0);

    const blob = await new Promise((resolve) => canvas.toBlob(resolve, 'image/jpeg', 0.92));
    if (!blob) return file;
    const baseName = String(file.name || 'photo').replace(/\.[^.]+$/, '');
    return new File([blob], `${baseName}-scan.jpg`, { type: 'image/jpeg', lastModified: Date.now() });
  } catch (error) {
    console.warn('[pray-word] scan enhance failed, using original photo', error);
    return file;
  } finally {
    if (source && typeof source.close === 'function') source.close();
    if (objectUrl) URL.revokeObjectURL(objectUrl);
  }
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
  const uploadFile = window.optimizeImageForUpload
    ? await window.optimizeImageForUpload(file, { maxDimension: 1600, quality: 0.8 })
    : file;
  const path = `pray/${userId}/${dateKey}/${index}-${Date.now()}.${fileExtension(uploadFile)}`;
  const { error } = await window.supabaseClient.storage.from(VERIFICATION_PHOTOS_BUCKET).upload(path, uploadFile, { upsert: true, contentType: uploadFile.type, cacheControl: '31536000' });
  if (error) throw error;
  return path;
}

async function uploadWordPhoto(userId, dateKey, file) {
  const uploadFile = window.optimizeImageForUpload
    ? await window.optimizeImageForUpload(file, { maxDimension: 1600, quality: 0.8 })
    : file;
  const path = `word/${userId}/${dateKey}-${Date.now()}.${fileExtension(uploadFile)}`;
  const { error } = await window.supabaseClient.storage.from(VERIFICATION_PHOTOS_BUCKET).upload(path, uploadFile, { upsert: true, contentType: uploadFile.type, cacheControl: '31536000' });
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

// 시작/종료는 "YYYY-MM-DDTHH:MM" 전체 일시(신규 데이터)이며, 자정을 넘겨도(예: 12/31 23:00 ~
// 1/1 01:00) 그대로 계산된다. 예전 "HH:MM"만 있던 데이터는 파싱 불가하면 null.
function parsePrayDateTime(value) {
  if (!value || !value.includes('T')) return null;
  const d = new Date(value);
  return Number.isNaN(d.getTime()) ? null : d;
}

function durationMinutes(start, end) {
  const s = parsePrayDateTime(start);
  const e = parsePrayDateTime(end);
  if (!s || !e) return 0;
  return Math.max(0, Math.round((e - s) / 60000));
}

function formatTimeShort(date) {
  return `${String(date.getHours()).padStart(2, '0')}:${String(date.getMinutes()).padStart(2, '0')}`;
}

// 같은 날이면 "07:00–07:30", 자정을 넘기면 "23:00–1/1 01:00"처럼 종료 쪽에만 날짜를 붙인다.
function formatPrayerTimeRange(start, end) {
  const s = parsePrayDateTime(start);
  const e = parsePrayDateTime(end);
  if (!s || !e) return (start && end) ? `${start}–${end}` : ''; // 예전 데이터 그대로 표시
  const sameDay = s.getFullYear() === e.getFullYear() && s.getMonth() === e.getMonth() && s.getDate() === e.getDate();
  return sameDay
    ? `${formatTimeShort(s)}–${formatTimeShort(e)}`
    : `${formatTimeShort(s)}–${e.getMonth() + 1}/${e.getDate()} ${formatTimeShort(e)}`;
}

function formatPrayerSummary(entries) {
  return entries
    .filter((entry) => entry.location)
    .map((entry) => (entry.start && entry.end ? `${entry.location} ${formatPrayerTimeRange(entry.start, entry.end)}` : entry.location))
    .join(', ');
}

function formatVerseRange(entry) {
  if (!entry.startBook || !entry.startChapter) return '';
  const endBook = entry.endBook || entry.startBook;
  const endChapter = entry.endChapter || entry.startChapter;
  return `${entry.startBook} ${entry.startChapter}장 ~ ${endBook} ${endChapter}장`;
}

function formatWordSummary(entries) {
  return entries.map(formatVerseRange).filter(Boolean).join(', ');
}

// 첫 말씀 인증은 기본 60분, 두 번째 이후 추가 구절은 입력한 묵상 시간을 더합니다.
// 기존 데이터에는 meditationMinutes가 없으므로 자동으로 0분으로 처리됩니다.
function calculateWordMinutes(verses) {
  if (!Array.isArray(verses) || verses.length === 0) return 0;
  const extraMinutes = verses.slice(1).reduce((sum, verse) => {
    const minutes = Number(verse && verse.meditationMinutes);
    return sum + (Number.isFinite(minutes) && minutes > 0 ? Math.round(minutes) : 0);
  }, 0);
  return 60 + extraMinutes;
}
window.calculateWordMinutes = calculateWordMinutes;

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

// "YYYY.MM.DD HH:MM ~ YYYY.MM.DD HH:MM" 형태로 보여주는 캡션. 시작/종료 일시 입력값에서 직접 뽑는다.
function updatePrayEntryDateTimeLabel(entryEl) {
  const label = entryEl.querySelector('.pray-entry-datetime');
  if (!label) return;
  const start = entryEl.querySelector('.pray-start-input').value;
  const end = entryEl.querySelector('.pray-end-input').value;
  const s = parsePrayDateTime(start);
  const e = parsePrayDateTime(end);
  if (!s || !e) {
    label.textContent = '';
    return;
  }
  const fmt = (d) => `${d.getFullYear()}.${String(d.getMonth() + 1).padStart(2, '0')}.${String(d.getDate()).padStart(2, '0')} ${formatTimeShort(d)}`;
  label.textContent = `${fmt(s)} ~ ${fmt(e)}`;
}

function formatPrayDateTimeLocal(date) {
  const y = date.getFullYear();
  const m = String(date.getMonth() + 1).padStart(2, '0');
  const d = String(date.getDate()).padStart(2, '0');
  const h = String(date.getHours()).padStart(2, '0');
  const min = String(date.getMinutes()).padStart(2, '0');
  return `${y}-${m}-${d}T${h}:${min}`;
}

function nextPrayMinute(value) {
  const date = parsePrayDateTime(value);
  if (!date) return value;
  date.setMinutes(date.getMinutes() + 1);
  return formatPrayDateTimeLocal(date);
}

function applyPrayDateTimeLimits(entryEl) {
  const startInput = entryEl.querySelector('.pray-start-input');
  const endInput = entryEl.querySelector('.pray-end-input');
  if (!startInput || !endInput || !prayModalDateKey) return;

  const selectedDateMinimum = `${prayModalDateKey}T00:00`;
  startInput.min = selectedDateMinimum;
  endInput.min = startInput.value ? nextPrayMinute(startInput.value) : selectedDateMinimum;

  const startsTooEarly = !!startInput.value && startInput.value < selectedDateMinimum;
  const endsTooEarly = !!startInput.value && !!endInput.value && endInput.value <= startInput.value;
  startInput.setCustomValidity(startsTooEarly ? '시작 일시는 선택한 날짜보다 이전으로 설정할 수 없습니다.' : '');
  endInput.setCustomValidity(endsTooEarly ? '종료 일시는 시작 일시보다 나중이어야 합니다.' : '');
}

function addPrayClassEntry(data) {
  const template = document.getElementById('pray-class-template');
  const list = document.getElementById('pray-class-list');
  if (!template || !list) return;

  list.appendChild(template.content.cloneNode(true));
  const entryEl = list.lastElementChild;
  wirePhotoPreview(entryEl);

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

  applyPrayDateTimeLimits(entryEl);
  updatePrayEntryDateTimeLabel(entryEl);
  entryEl.querySelector('.pray-start-input').addEventListener('input', () => {
    applyPrayDateTimeLimits(entryEl);
    updatePrayEntryDateTimeLabel(entryEl);
  });
  entryEl.querySelector('.pray-end-input').addEventListener('input', () => {
    applyPrayDateTimeLimits(entryEl);
    updatePrayEntryDateTimeLabel(entryEl);
  });

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
    existing.forEach((entry) => addPrayClassEntry(entry));
  } else {
    addPrayClassEntry();
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
    const start = entry.querySelector('.pray-start-input').value;
    const end = entry.querySelector('.pray-end-input').value;
    return {
      entry, location, photoUnavailable, newFile, existingPhotoPath, start, end,
      date: start ? start.slice(0, 10) : null, // 기록은 시작 일시의 날짜 기준
      hasPhoto: photoUnavailable || !!newFile || !!existingPhotoPath
    };
  });

  const hasIncompleteEntry = drafts.some((d) => !d.hasPhoto || !d.location || !d.start || !d.end || !d.date);
  const hasStartBeforeSelectedDate = !hasIncompleteEntry
    && drafts.some((d) => d.start < `${originalDateKey}T00:00`);
  const hasInvalidRange = !hasIncompleteEntry && drafts.some((d) => new Date(d.end) <= new Date(d.start));
  if (hasIncompleteEntry || hasStartBeforeSelectedDate || hasInvalidRange) {
    if (prayClassHint) {
      if (hasStartBeforeSelectedDate) {
        prayClassHint.textContent = '시작 일시는 선택한 날짜보다 이전으로 설정할 수 없습니다.';
      } else if (hasInvalidRange) {
        prayClassHint.textContent = '종료 일시는 시작 일시보다 나중이어야 합니다.';
      } else {
        prayClassHint.textContent = '사진 첨부, 기도 장소, 시작/종료 일시를 모두 입력해주세요.';
      }
      prayClassHint.classList.remove('hidden');
    }
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
  if (addBtn) addBtn.addEventListener('click', () => addPrayClassEntry());
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
    wordPhotoProcessedFile = null;
    wordPhotoOcrToken += 1;
    setWordOcrCaution('');
    setWordOcrStatus('');
  }

  input.addEventListener('change', async () => {
    if (hint) hint.classList.add('hidden');
    const file = input.files && input.files[0];
    if (!file) {
      clearPhoto();
      return;
    }
    delete wrap.dataset.existingPhotoPath;
    const token = ++wordPhotoOcrToken;
    wordPhotoProcessedFile = null;
    setWordOcrCaution('');
    setWordOcrStatus('스캔 보정 중...');

    const processed = await scanEnhanceImage(file);
    if (token !== wordPhotoOcrToken) return;
    wordPhotoProcessedFile = processed;

    if (preview.dataset.objectUrl) URL.revokeObjectURL(preview.dataset.objectUrl);
    const url = URL.createObjectURL(processed);
    preview.src = url;
    preview.dataset.objectUrl = url;
    wrap.classList.remove('hidden');
    runWordPhotoOcr(processed);
  });

  if (removeBtn) removeBtn.addEventListener('click', clearPhoto);
}

function updateWordRemoveButtons() {
  const entries = document.querySelectorAll('#word-verse-list .word-verse-entry');
  entries.forEach((entry, index) => {
    const removeBtn = entry.querySelector('.word-remove-verse');
    const timeWrap = entry.querySelector('.word-meditation-time-wrap');
    if (removeBtn) removeBtn.classList.toggle('hidden', entries.length <= 1);
    if (timeWrap) timeWrap.classList.toggle('hidden', index === 0);
  });
}

function addWordVerseEntry(data) {
  const template = document.getElementById('word-verse-template');
  const list = document.getElementById('word-verse-list');
  if (!template || !list) return;

  list.appendChild(template.content.cloneNode(true));
  const entryEl = list.lastElementChild;
  entryEl.dataset.meditationMinutes = String((data && data.meditationMinutes) || 0);

  renderBibleBookOptions(entryEl.querySelector('.word-start-book'));
  renderBibleBookOptions(entryEl.querySelector('.word-end-book'));

  if (data) {
    if (data.startBook) entryEl.querySelector('.word-start-book').value = data.startBook;
    if (data.startChapter) entryEl.querySelector('.word-start-chapter').value = data.startChapter;
    if (data.endBook) entryEl.querySelector('.word-end-book').value = data.endBook;
    if (data.endChapter) entryEl.querySelector('.word-end-chapter').value = data.endChapter;
    const minutesInput = entryEl.querySelector('.word-meditation-minutes');
    if (minutesInput && data.meditationMinutes) minutesInput.value = data.meditationMinutes;
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
  wordPhotoProcessedFile = null;
  wordPhotoOcrToken += 1;
  setWordOcrCaution('');
  setWordOcrStatus('');

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

  const verseElements = [...document.querySelectorAll('#word-verse-list .word-verse-entry')];
  const verses = verseElements.map((entry, index) => {
    const minutesInput = entry.querySelector('.word-meditation-minutes');
    const startBook = entry.querySelector('.word-start-book').value;
    const startChapter = entry.querySelector('.word-start-chapter').value;
    return {
      startBook,
      startChapter,
      startVerse: '',
      endBook: entry.querySelector('.word-end-book').value,
      endChapter: entry.querySelector('.word-end-chapter').value,
      endVerse: '',
      meditationMinutes: index === 0
        ? 0
        : Number(minutesInput ? minutesInput.value : entry.dataset.meditationMinutes || 0)
    };
  });

  const referenceFields = ['startBook', 'startChapter', 'endBook', 'endChapter'];
  const hasIncompleteEntry = verses.some((entry) => referenceFields.some((field) => !entry[field]));
  const hasInvalidExtraMinutes = verses.slice(1).some((entry, index) => {
    const supportsTimeInput = !!verseElements[index + 1].querySelector('.word-meditation-minutes');
    return supportsTimeInput && (!Number.isFinite(entry.meditationMinutes) || entry.meditationMinutes <= 0);
  });
  if (hasIncompleteEntry || hasInvalidExtraMinutes) {
    if (wordVerseHint) {
      wordVerseHint.textContent = hasInvalidExtraMinutes
        ? '추가한 말씀 구절의 묵상 시간을 입력해주세요.'
        : '시작 책과 장, 끝 책과 장을 모두 입력해주세요.';
      wordVerseHint.classList.remove('hidden');
    }
    return;
  }
  if (wordVerseHint) wordVerseHint.classList.add('hidden');

  if (newFile && wordPhotoOcrMismatch) {
    const label = expectedWordChapterLabel(dateKey);
    const confirmed = confirm(`스캔한 사진에서 오늘의 본문${label ? `(${label})` : ''}을 확인하지 못했어요. 그래도 이 사진으로 저장할까요?`);
    if (!confirmed) return;
  }

  if (saveBtn) { saveBtn.disabled = true; saveBtn.textContent = '저장 중...'; }

  try {
    const userId = await getCurrentUserId();
    const uploadTarget = newFile ? (wordPhotoProcessedFile || newFile) : null;
    const photoPath = uploadTarget ? await uploadWordPhoto(userId, dateKey, uploadTarget) : existingPhotoPath;

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
