// Study 탭: 영단어 학습(목록/암기카드/퀴즈/단어 시험) — vocab_words(콘텐츠, 읽기전용) +
// vocab_progress(학생별 학습완료 여부, 본인 행만) + word_exam_submissions(시험지 사진/점수, 본인 행만)를
// 조합해 렌더링한다. home.js는 로드하지 않는다(다른 탭과 동일한 이유 — layout.js의 renderApp()이
// initHomeWidgets를 페이지 구분 없이 호출하기 때문). getCurrentUserId는 이 파일 자체에 구현한다(pray-word.js 미로드).

const STUDY_QUIZ_MAX_QUESTIONS = 15; // 세트가 커질 때 퀴즈 세션 길이 상한
const STUDY_QUIZ_MIN_WORDS = 2;      // 퀴즈를 진행하기 위한 최소 단어 수
const STUDY_LEVEL = 1;
const STUDY_PAGE_SIZE = 1000;        // Supabase REST 기본 최대 반환 행 수 — 이보다 크면 나눠 받아야 함

// 단어 시험(오프라인 시험지 사진 제출) — 8/22, 9/3 두 번만 고정으로 연다.
const STUDY_EXAM_BUCKET = 'verification-photos-v2';
const STUDY_EXAM_DATES = [
  { key: '2026-08-22', label: '8/22 (토)' },
  { key: '2026-09-03', label: '9/3 (토)' }
];

let studyAllWords = [];      // vocab_words 전체, study_day/sort_order 순
let studyProgressMap = {};   // word_id -> vocab_progress row
let studyCurrentUserId = null;
let studyExamSubmissions = {}; // exam_date -> word_exam_submissions row

let studyActiveMode = 'list';  // 'list' | 'flashcard' | 'quiz' | 'exam'
let studyActiveDay = 'all';    // 'all' | integer

let studyFlashcardIndex = 0;
let studyFlashcardFlipped = false;

let studyQuizState = null; // { questions, index, score, missed } | null (null = 시작화면)

let studyCompleteDays = new Set(); // 모든 단어가 품사+예문 3개까지 채워진 Day

// --- 데이터 조회 ---

async function getStudyCurrentUserId() {
  if (studyCurrentUserId) return studyCurrentUserId;
  if (!window.supabaseClient) return null;
  const { data: { session } } = await window.supabaseClient.auth.getSession();
  studyCurrentUserId = session ? session.user.id : null;
  return studyCurrentUserId;
}

// vocab_words가 6000개를 넘어 Supabase REST 기본 페이지 크기(1000)를 초과하므로 끝까지 나눠 받는다.
async function fetchAllVocabWords() {
  let all = [];
  let from = 0;
  while (true) {
    const { data, error } = await window.supabaseClient
      .from('vocab_words')
      .select('id,word,meaning,part_of_speech,example_sentences,level,study_day,sort_order')
      .eq('level', STUDY_LEVEL)
      .order('study_day', { ascending: true })
      .order('sort_order', { ascending: true })
      .range(from, from + STUDY_PAGE_SIZE - 1);
    if (error) { console.error('[study] vocab_words', error); break; }
    all = all.concat(data);
    if (data.length < STUDY_PAGE_SIZE) break;
    from += STUDY_PAGE_SIZE;
  }
  return all;
}

async function fetchStudyData(userId) {
  const [words, progressRes] = await Promise.all([
    fetchAllVocabWords(),
    window.supabaseClient.from('vocab_progress').select('user_id,word_id,learned,correct_count,incorrect_count,learned_at,updated_at').eq('user_id', userId)
  ]);
  if (progressRes.error) console.error('[study] vocab_progress', progressRes.error);
  return { words, progress: progressRes.data || [] };
}

async function fetchExamSubmissions(userId) {
  const { data, error } = await window.supabaseClient.from('word_exam_submissions').select('*').eq('user_id', userId);
  if (error) { console.error('[study] word_exam_submissions', error); return {}; }
  return Object.fromEntries((data || []).map((row) => [row.exam_date, row]));
}

// --- 필터 헬퍼 ---

function getStudyDays() {
  return [...new Set(studyAllWords.map((w) => w.study_day))].sort((a, b) => a - b);
}

// 품사 + 예문 3개까지 전부 채워진 단어인지 — 아직 안 채워진 단어는 학습 화면에 노출하지 않는다.
function isWordFilled(word) {
  return !!word.part_of_speech && Array.isArray(word.example_sentences) && word.example_sentences.length >= 3;
}

// (level, study_day) 세트 안의 단어가 전부 채워져 있어야 그 Day를 "완료"로 본다 — 절반만 채워진
// Day를 보여주면 학생이 학습하다가 빈 카드를 만나게 되므로, 하나라도 미완성이면 그 Day 전체를 비활성화.
function computeCompleteDays() {
  const groups = {};
  studyAllWords.forEach((w) => {
    const key = String(w.study_day);
    (groups[key] = groups[key] || []).push(w);
  });
  const complete = new Set();
  Object.entries(groups).forEach(([key, words]) => {
    if (words.every(isWordFilled)) complete.add(key);
  });
  return complete;
}

function isDayComplete(day) {
  return studyCompleteDays.has(String(day));
}

function getActiveWordSet() {
  const completeWords = studyAllWords.filter((w) => isDayComplete(w.study_day));
  return studyActiveDay === 'all' ? completeWords : completeWords.filter((w) => w.study_day === studyActiveDay);
}

function isLearned(wordId) {
  return !!(studyProgressMap[wordId] && studyProgressMap[wordId].learned);
}

// --- 진행도 저장 (목록/암기카드/퀴즈 공용) ---

async function upsertVocabProgress(wordId, patch) {
  const existing = studyProgressMap[wordId] || { user_id: studyCurrentUserId, word_id: wordId, learned: false, correct_count: 0, incorrect_count: 0, learned_at: null };
  const next = { ...existing, ...patch, updated_at: new Date().toISOString() };
  studyProgressMap[wordId] = next; // optimistic local update

  const { error } = await window.supabaseClient
    .from('vocab_progress')
    .upsert(
      { user_id: next.user_id, word_id: next.word_id, learned: next.learned, correct_count: next.correct_count, incorrect_count: next.incorrect_count, learned_at: next.learned_at, updated_at: next.updated_at },
      { onConflict: 'user_id,word_id' }
    );
  if (error) console.error('[study] upsertVocabProgress', error);
}

function toggleLearned(wordId) {
  const next = !isLearned(wordId);
  const prev = studyProgressMap[wordId];
  upsertVocabProgress(wordId, { learned: next, learned_at: next ? new Date().toISOString() : (prev ? prev.learned_at : null) });
}

// --- 포맷 헬퍼 ---

function exampleSentencesHTML(examples) {
  return (examples || []).map((ex) => `
    <div class="border-l-2 border-outline-variant pl-3">
      <p class="text-sm text-on-surface">${ex.en}</p>
      <p class="text-xs text-on-surface-variant">${ex.ko}</p>
    </div>`).join('');
}

// --- Day 셀렉터 ---

function renderDaySelector() {
  const select = document.getElementById('study-day-selector');
  if (!select) return;
  const days = getStudyDays();
  const options = [{ value: 'all', label: '전체', disabled: studyCompleteDays.size === 0 }, ...days.map((d) => ({
    value: String(d),
    label: isDayComplete(d) ? `Day ${d}` : `Day ${d} (준비중)`,
    disabled: !isDayComplete(d)
  }))];
  select.innerHTML = options.map((o) =>
    `<option value="${o.value}" ${o.disabled ? 'disabled' : ''} ${String(studyActiveDay) === o.value ? 'selected' : ''}>${o.label}</option>`
  ).join('');
}

function wireDaySelector() {
  const select = document.getElementById('study-day-selector');
  if (!select) return;
  select.addEventListener('change', () => {
    studyActiveDay = select.value === 'all' ? 'all' : Number(select.value);
    studyFlashcardIndex = 0;
    studyFlashcardFlipped = false;
    studyQuizState = null;
    renderContent();
  });
}

// --- 모드 스위처 ---

function wireModeTabs() {
  const buttons = {
    exam: document.getElementById('study-mode-exam'),
    list: document.getElementById('study-mode-list'),
    flashcard: document.getElementById('study-mode-flashcard'),
    quiz: document.getElementById('study-mode-quiz')
  };
  Object.entries(buttons).forEach(([key, btn]) => {
    if (!btn) return;
    btn.addEventListener('click', () => {
      studyActiveMode = key;
      studyFlashcardIndex = 0;
      studyFlashcardFlipped = false;
      studyQuizState = null;
      Object.entries(buttons).forEach(([k, b]) => {
        b.classList.toggle('nav-pill-active', k === key);
        b.classList.toggle('text-on-surface-variant', k !== key);
      });
      document.getElementById('study-daybar')?.classList.toggle('hidden', key === 'exam');
      renderContent();
    });
  });
}

function renderContent() {
  if (studyActiveMode === 'exam') { renderExamMode(); return; }
  const wordSet = getActiveWordSet();
  if (studyActiveMode === 'list') renderListMode(wordSet);
  else if (studyActiveMode === 'flashcard') renderFlashcardMode(wordSet);
  else renderQuizMode(wordSet);
}

// --- 단어 시험 모드 (시험지 사진 제출 + 채점 결과 확인) ---

function studyExamPhotoUrl(path) {
  if (!path) return '';
  return window.supabaseClient.storage.from(STUDY_EXAM_BUCKET).getPublicUrl(path).data.publicUrl;
}

function studyFileExtension(file) {
  const fromName = String(file?.name || '').split('.').pop();
  if (fromName && fromName.length <= 5) return fromName.toLowerCase();
  return String(file?.type || '').split('/').pop() || 'jpg';
}

async function uploadExamPhoto(userId, examDate, file) {
  const uploadFile = window.optimizeImageForUpload ? await window.optimizeImageForUpload(file, { maxDimension: 1600, quality: 0.8 }) : file;
  const path = `wordexam/${userId}/${examDate}-${Date.now()}.${studyFileExtension(uploadFile)}`;
  const { error } = await window.supabaseClient.storage.from(STUDY_EXAM_BUCKET)
    .upload(path, uploadFile, { upsert: true, contentType: uploadFile.type, cacheControl: '31536000' });
  if (error) throw error;
  return path;
}

async function saveExamSubmission(userId, examDate, photoPath) {
  const { error } = await window.supabaseClient.from('word_exam_submissions').upsert(
    { user_id: userId, exam_date: examDate, photo_path: photoPath, updated_at: new Date().toISOString() },
    { onConflict: 'user_id,exam_date' }
  );
  if (error) throw error;
}

// 채점 전(status='pending')에만 RLS가 허용 — 채점 완료된 시험은 삭제되지 않는다.
async function deleteExamSubmission(userId, examDate, photoPath) {
  const { error } = await window.supabaseClient.from('word_exam_submissions').delete().eq('user_id', userId).eq('exam_date', examDate);
  if (error) throw error;
  if (photoPath) {
    const { error: storageError } = await window.supabaseClient.storage.from(STUDY_EXAM_BUCKET).remove([photoPath]);
    if (storageError) console.error('[study] exam photo storage remove', storageError);
  }
}

function examCardHTML(examInfo) {
  const sub = studyExamSubmissions[examInfo.key];
  const photoUrl = sub ? studyExamPhotoUrl(sub.photo_path) : '';
  const graded = sub && sub.status === 'graded';
  const statusLabel = graded ? '채점 완료' : sub ? '채점 대기중' : '아직 제출하지 않았어요';
  return `
    <div class="glass-card rounded-[1.5rem] p-5" data-exam-date="${examInfo.key}">
      <div class="flex items-center justify-between gap-3 mb-4">
        <div>
          <p class="font-bold text-on-surface">${examInfo.label} 단어 시험</p>
          <p class="text-xs text-on-surface-variant mt-0.5">${statusLabel}</p>
        </div>
        ${graded ? `<span class="pill-btn-primary px-4 py-1.5 text-sm whitespace-nowrap">${sub.score} / ${sub.max_score}점</span>` : ''}
      </div>
      ${photoUrl ? `
        <div class="rounded-2xl overflow-hidden bg-surface-container aspect-[4/3] mb-3">
          <img src="${photoUrl}" loading="lazy" decoding="async" alt="${examInfo.label} 시험지 사진" class="w-full h-full object-contain">
        </div>` : ''}
      ${!graded ? `
        <div class="flex items-center gap-2">
          <label class="pill-btn-primary px-5 py-2.5 text-sm inline-flex items-center gap-2 cursor-pointer">
            <i class="fa-solid fa-camera"></i><span>${sub ? '사진 다시 올리기' : '시험지 사진 올리기'}</span>
            <input type="file" accept="image/*" capture="environment" class="hidden study-exam-file" data-exam-date="${examInfo.key}">
          </label>
          ${sub ? `<button type="button" class="glass-card rounded-full px-4 py-2.5 text-sm text-error study-exam-delete" data-exam-date="${examInfo.key}">삭제</button>` : ''}
        </div>` : ''}
    </div>`;
}

function renderExamMode() {
  const container = document.getElementById('study-content');
  container.innerHTML = `<div class="flex flex-col gap-4 max-w-xl mx-auto">${STUDY_EXAM_DATES.map(examCardHTML).join('')}</div>`;
  wireExamMode();
}

function wireExamMode() {
  const container = document.getElementById('study-content');
  container.querySelectorAll('.study-exam-file').forEach((input) => {
    input.addEventListener('change', async () => {
      const file = input.files[0];
      if (!file) return;
      const examDate = input.dataset.examDate;
      const label = input.closest('label');
      const originalHTML = label.innerHTML;
      label.innerHTML = '<i class="fa-solid fa-spinner fa-spin"></i><span>업로드 중...</span>';
      try {
        const photoPath = await uploadExamPhoto(studyCurrentUserId, examDate, file);
        await saveExamSubmission(studyCurrentUserId, examDate, photoPath);
        studyExamSubmissions[examDate] = { ...(studyExamSubmissions[examDate] || {}), user_id: studyCurrentUserId, exam_date: examDate, photo_path: photoPath, status: 'pending' };
        renderExamMode();
      } catch (error) {
        console.error('[study] exam upload', error);
        alert('사진 업로드에 실패했어요. 다시 시도해주세요.');
        label.innerHTML = originalHTML;
      }
    });
  });
  container.querySelectorAll('.study-exam-delete').forEach((btn) => {
    btn.addEventListener('click', async () => {
      if (!confirm('제출한 시험지 사진을 삭제할까요?')) return;
      const examDate = btn.dataset.examDate;
      btn.disabled = true;
      try {
        const sub = studyExamSubmissions[examDate];
        await deleteExamSubmission(studyCurrentUserId, examDate, sub && sub.photo_path);
        delete studyExamSubmissions[examDate];
        renderExamMode();
      } catch (error) {
        console.error('[study] exam delete', error);
        alert('삭제에 실패했어요. 다시 시도해주세요.');
        btn.disabled = false;
      }
    });
  });
}

// --- 목록 모드 ---

function wordCardHTML(word) {
  const learned = isLearned(word.id);
  return `
    <div class="glass-card rounded-[1.5rem] p-5 widget-card ${learned ? 'is-verified' : ''}" data-word-id="${word.id}">
      <div class="flex items-center justify-between gap-3 cursor-pointer study-list-toggle">
        <div>
          <p class="font-bold text-lg text-on-surface">${word.word}</p>
          <p class="text-sm text-on-surface-variant">${word.meaning}</p>
        </div>
        <button type="button" class="icon-glass w-9 h-9 rounded-full flex items-center justify-center flex-shrink-0 study-learned-toggle ${learned ? 'text-quaternary' : 'text-on-surface-variant'}" aria-label="학습 완료 표시">
          <i class="fa-solid ${learned ? 'fa-circle-check' : 'fa-circle'}"></i>
        </button>
      </div>
      <div class="study-list-detail hidden mt-4 pt-4 border-t border-outline-variant/40">
        <span class="inline-block text-[11px] font-semibold text-secondary bg-secondary-container/30 rounded-full px-2.5 py-1 mb-3">${word.part_of_speech}</span>
        <div class="flex flex-col gap-2">${exampleSentencesHTML(word.example_sentences)}</div>
      </div>
    </div>`;
}

function renderListMode(wordSet) {
  const container = document.getElementById('study-content');
  if (wordSet.length === 0) {
    container.innerHTML = '<div class="glass-panel rounded-[2rem] p-12 text-center text-on-surface-variant">이 세트에는 아직 단어가 없어요.</div>';
    return;
  }
  container.innerHTML = `<div class="flex flex-col gap-3" id="study-list">${wordSet.map(wordCardHTML).join('')}</div>`;
  wireListMode();
}

function wireListMode() {
  const list = document.getElementById('study-list');
  if (!list) return;
  list.addEventListener('click', (e) => {
    const card = e.target.closest('[data-word-id]');
    if (!card) return;
    const wordId = card.dataset.wordId;

    if (e.target.closest('.study-learned-toggle')) {
      toggleLearned(wordId);
      const btn = card.querySelector('.study-learned-toggle');
      const icon = btn.querySelector('i');
      const nowLearned = isLearned(wordId);
      btn.classList.toggle('text-quaternary', nowLearned);
      btn.classList.toggle('text-on-surface-variant', !nowLearned);
      card.classList.toggle('is-verified', nowLearned);
      icon.classList.toggle('fa-circle-check', nowLearned);
      icon.classList.toggle('fa-circle', !nowLearned);
      return;
    }

    if (e.target.closest('.study-list-toggle')) {
      card.querySelector('.study-list-detail').classList.toggle('hidden');
    }
  });
}

// --- 암기카드 모드 ---

function renderFlashcardMode(wordSet) {
  const container = document.getElementById('study-content');
  if (wordSet.length === 0) {
    container.innerHTML = '<div class="glass-panel rounded-[2rem] p-12 text-center text-on-surface-variant">이 세트에는 아직 단어가 없어요.</div>';
    return;
  }
  if (studyFlashcardIndex >= wordSet.length) studyFlashcardIndex = 0;
  const word = wordSet[studyFlashcardIndex];
  const learned = isLearned(word.id);

  container.innerHTML = `
    <div class="max-w-xl mx-auto">
      <p class="text-center text-sm text-on-surface-variant mb-3">${studyFlashcardIndex + 1} / ${wordSet.length} · Day ${word.study_day}</p>

      <div class="flip-card ${studyFlashcardFlipped ? 'is-flipped' : ''}" id="study-flashcard">
        <div class="flip-card-inner">
          <div class="flip-card-face flip-card-front glass-panel rounded-[2rem] p-8 flex flex-col items-center justify-center text-center cursor-pointer">
            <p class="text-4xl sm:text-5xl font-bold text-on-surface">${word.word}</p>
            <p class="text-xs text-on-surface-variant mt-4"><i class="fa-solid fa-hand-pointer mr-1"></i>탭해서 뜻 보기</p>
          </div>
          <div class="flip-card-face flip-card-back glass-panel rounded-[2rem] p-6 flex flex-col cursor-pointer">
            <p class="text-2xl font-bold text-on-surface">${word.meaning}</p>
            <span class="inline-block w-fit text-[11px] font-semibold text-secondary bg-secondary-container/30 rounded-full px-2.5 py-1 my-2">${word.part_of_speech}</span>
            <div class="flex flex-col gap-2 my-2">${exampleSentencesHTML(word.example_sentences)}</div>
          </div>
        </div>
      </div>

      <div class="flex items-center justify-between gap-3 mt-5">
        <button type="button" id="study-flash-prev" class="icon-glass w-11 h-11 rounded-full flex items-center justify-center text-on-surface" aria-label="이전"><i class="fa-solid fa-chevron-left"></i></button>
        <div class="flex gap-2">
          <button type="button" id="study-flash-know" class="pill-btn-primary px-5 py-2 text-sm ${learned ? 'ring-2 ring-quaternary' : ''}">안다 (학습완료)</button>
          <button type="button" id="study-flash-dontknow" class="glass-card rounded-full px-5 py-2 text-sm text-on-surface-variant">모른다</button>
        </div>
        <button type="button" id="study-flash-next" class="icon-glass w-11 h-11 rounded-full flex items-center justify-center text-on-surface" aria-label="다음"><i class="fa-solid fa-chevron-right"></i></button>
      </div>
    </div>`;

  wireFlashcardMode(wordSet, word);
}

function wireFlashcardMode(wordSet, word) {
  const card = document.getElementById('study-flashcard');
  card.addEventListener('click', () => {
    studyFlashcardFlipped = !studyFlashcardFlipped;
    card.classList.toggle('is-flipped', studyFlashcardFlipped);
  });

  document.getElementById('study-flash-prev').addEventListener('click', () => moveFlashcard(wordSet, -1));
  document.getElementById('study-flash-next').addEventListener('click', () => moveFlashcard(wordSet, 1));

  document.getElementById('study-flash-know').addEventListener('click', (e) => {
    e.stopPropagation();
    upsertVocabProgress(word.id, { learned: true, learned_at: new Date().toISOString() });
    moveFlashcard(wordSet, 1);
  });
  document.getElementById('study-flash-dontknow').addEventListener('click', (e) => {
    e.stopPropagation();
    upsertVocabProgress(word.id, { learned: false });
    moveFlashcard(wordSet, 1);
  });
}

function moveFlashcard(wordSet, delta) {
  studyFlashcardIndex = (studyFlashcardIndex + delta + wordSet.length) % wordSet.length;
  studyFlashcardFlipped = false;
  renderFlashcardMode(wordSet);
}

// --- 퀴즈 모드 ---

function shuffle(arr) {
  const a = [...arr];
  for (let i = a.length - 1; i > 0; i--) {
    const j = Math.floor(Math.random() * (i + 1));
    [a[i], a[j]] = [a[j], a[i]];
  }
  return a;
}

function buildQuizQuestions(wordSet) {
  const pool = shuffle(wordSet).slice(0, Math.min(wordSet.length, STUDY_QUIZ_MAX_QUESTIONS));
  return pool.map((word) => {
    const direction = Math.random() < 0.5 ? 'word2meaning' : 'meaning2word';
    const others = wordSet.filter((w) => w.id !== word.id);
    const distractors = shuffle(others).slice(0, Math.min(3, others.length));
    const choiceWords = shuffle([word, ...distractors]);
    return {
      wordId: word.id,
      direction,
      prompt: direction === 'word2meaning' ? word.word : word.meaning,
      choices: choiceWords.map((w) => (direction === 'word2meaning' ? w.meaning : w.word)),
      correctIndex: choiceWords.findIndex((w) => w.id === word.id)
    };
  });
}

function renderQuizMode(wordSet) {
  const container = document.getElementById('study-content');

  if (wordSet.length < STUDY_QUIZ_MIN_WORDS) {
    container.innerHTML = '<div class="glass-panel rounded-[2rem] p-12 text-center text-on-surface-variant">퀴즈를 진행하려면 이 세트에 단어가 2개 이상 있어야 해요.<br>다른 Day나 \'전체\'를 선택해보세요.</div>';
    return;
  }

  if (!studyQuizState) {
    renderQuizStartScreen(wordSet);
    return;
  }
  if (studyQuizState.index >= studyQuizState.questions.length) {
    renderQuizResultsScreen(wordSet);
    return;
  }
  renderQuizQuestionScreen(wordSet);
}

function renderQuizStartScreen(wordSet) {
  const container = document.getElementById('study-content');
  container.innerHTML = `
    <div class="glass-panel rounded-[2rem] p-10 text-center max-w-md mx-auto">
      <i class="fa-solid fa-graduation-cap text-4xl text-primary mb-3"></i>
      <p class="font-semibold text-on-surface mb-1">${wordSet.length}개 단어로 퀴즈를 시작할까요?</p>
      <p class="text-xs text-on-surface-variant mb-5">${Math.min(wordSet.length, STUDY_QUIZ_MAX_QUESTIONS)}문제 · 4지선다</p>
      <button type="button" id="study-quiz-start" class="pill-btn-primary px-6 py-2.5 text-sm">퀴즈 시작</button>
    </div>`;
  document.getElementById('study-quiz-start').addEventListener('click', () => {
    studyQuizState = { questions: buildQuizQuestions(wordSet), index: 0, score: 0, missed: [] };
    renderQuizMode(wordSet);
  });
}

function renderQuizQuestionScreen(wordSet) {
  const container = document.getElementById('study-content');
  const q = studyQuizState.questions[studyQuizState.index];
  const total = studyQuizState.questions.length;
  const promptLabel = q.direction === 'word2meaning' ? '이 단어의 뜻은?' : '다음 뜻에 맞는 단어는?';

  container.innerHTML = `
    <div class="max-w-xl mx-auto">
      <div class="flex items-center justify-between text-xs text-on-surface-variant mb-2">
        <span>문제 ${studyQuizState.index + 1} / ${total}</span>
        <span>점수 ${studyQuizState.score}</span>
      </div>
      <div class="w-full h-1.5 rounded-full bg-surface-container mb-5">
        <div class="h-1.5 rounded-full bg-primary transition-all" style="width:${(studyQuizState.index / total) * 100}%"></div>
      </div>
      <div class="glass-card rounded-[1.5rem] p-8 text-center mb-5">
        <p class="text-xs text-on-surface-variant mb-2">${promptLabel}</p>
        <p class="text-2xl font-bold text-on-surface">${q.prompt}</p>
      </div>
      <div class="grid grid-cols-1 sm:grid-cols-2 gap-3" id="study-quiz-choices">
        ${q.choices.map((c, i) => `<button type="button" data-choice="${i}" class="glass-card rounded-2xl p-4 text-sm font-medium text-on-surface text-left transition-colors">${c}</button>`).join('')}
      </div>
      <div class="text-center mt-5 h-10" id="study-quiz-next-wrap"></div>
    </div>`;

  wireQuizQuestion(wordSet, q);
}

function wireQuizQuestion(wordSet, q) {
  const choicesWrap = document.getElementById('study-quiz-choices');
  choicesWrap.addEventListener('click', (e) => {
    const btn = e.target.closest('[data-choice]');
    if (!btn || choicesWrap.dataset.answered) return;
    choicesWrap.dataset.answered = '1';

    const chosenIndex = Number(btn.dataset.choice);
    const correct = chosenIndex === q.correctIndex;

    [...choicesWrap.children].forEach((el, i) => {
      if (i === q.correctIndex) el.classList.add('bg-quaternary/20', 'ring-2', 'ring-quaternary');
      else if (i === chosenIndex) el.classList.add('bg-error/10', 'ring-2', 'ring-error');
    });

    const prevProgress = studyProgressMap[q.wordId];
    if (correct) {
      studyQuizState.score += 1;
      upsertVocabProgress(q.wordId, {
        correct_count: (prevProgress ? prevProgress.correct_count : 0) + 1,
        learned: true,
        learned_at: prevProgress && prevProgress.learned_at ? prevProgress.learned_at : new Date().toISOString()
      });
    } else {
      studyQuizState.missed.push(q);
      upsertVocabProgress(q.wordId, { incorrect_count: (prevProgress ? prevProgress.incorrect_count : 0) + 1 });
    }

    document.getElementById('study-quiz-next-wrap').innerHTML =
      '<button type="button" id="study-quiz-next" class="pill-btn-primary px-6 py-2 text-sm">다음 →</button>';
    document.getElementById('study-quiz-next').addEventListener('click', () => {
      studyQuizState.index += 1;
      renderQuizMode(wordSet);
    });
  });
}

function renderQuizResultsScreen(wordSet) {
  const container = document.getElementById('study-content');
  const { score, questions, missed } = studyQuizState;
  const percent = Math.round((score / questions.length) * 100);
  const missedWords = [...new Map(missed.map((q) => [q.wordId, wordSet.find((w) => w.id === q.wordId)])).values()];

  container.innerHTML = `
    <div class="glass-panel rounded-[2rem] p-10 max-w-lg mx-auto text-center">
      <p class="text-sm text-on-surface-variant mb-1">퀴즈 결과</p>
      <p class="text-4xl font-bold text-primary mb-1">${score} / ${questions.length}</p>
      <p class="text-sm text-on-surface-variant mb-6">${percent}%</p>
      ${missedWords.length > 0 ? `
        <div class="text-left mb-6">
          <p class="text-xs font-semibold text-on-surface-variant mb-2">다시 볼 단어</p>
          <div class="flex flex-col gap-2">
            ${missedWords.map((w) => `<div class="glass-card rounded-xl px-4 py-2 flex justify-between text-sm"><span class="font-medium">${w.word}</span><span class="text-on-surface-variant">${w.meaning}</span></div>`).join('')}
          </div>
        </div>` : '<p class="text-sm text-on-surface-variant mb-6">전부 맞혔어요!</p>'}
      <div class="flex justify-center gap-3">
        <button type="button" id="study-quiz-retry" class="pill-btn-primary px-6 py-2.5 text-sm">다시 풀기</button>
        <button type="button" id="study-quiz-to-list" class="glass-card rounded-full px-6 py-2.5 text-sm text-on-surface-variant">목록으로</button>
      </div>
    </div>`;

  document.getElementById('study-quiz-retry').addEventListener('click', () => { studyQuizState = null; renderQuizMode(wordSet); });
  document.getElementById('study-quiz-to-list').addEventListener('click', () => {
    document.getElementById('study-mode-list').click();
  });
}

// --- 진입점 ---

async function initStudyWidgets() {
  wireModeTabs();
  wireDaySelector();

  const userId = await getStudyCurrentUserId();
  if (!userId) return;

  const [{ words, progress }, examSubmissions] = await Promise.all([
    fetchStudyData(userId),
    fetchExamSubmissions(userId)
  ]);
  studyAllWords = words;
  studyProgressMap = Object.fromEntries(progress.map((p) => [p.word_id, p]));
  studyCompleteDays = computeCompleteDays();
  studyExamSubmissions = examSubmissions;

  renderDaySelector();
  renderContent();
}

window.initStudyWidgets = initStudyWidgets;
