// Admin 콘솔 — Word Test 탭: 단어 시험 채점(8/22, 9/5) — 시험지 사진 첨부, 점수 입력, 공개 여부.

const ADMIN_WORD_EXAM_DATES = ['2026-08-22', '2026-09-05'];
let adminWordExamActiveDate = ADMIN_WORD_EXAM_DATES[0];
let adminWordExamRows = [];
let adminWordExamSearch = '';

const WORD_EXAM_BUCKET = 'verification-photos-v2';

function adminWordExamPhotoUrl(path) {
  if (!path) return '';
  return window.supabaseClient.storage.from(WORD_EXAM_BUCKET).getPublicUrl(path).data.publicUrl;
}

function adminWordExamFileExtension(file) {
  const fromName = String(file?.name || '').split('.').pop();
  if (fromName && fromName.length <= 5) return fromName.toLowerCase();
  return String(file?.type || '').split('/').pop() || 'jpg';
}

// 관리자가 시험지 사진을 직접 첨부/교체한다 — admin_all RLS(is_app_admin)가 테이블 전체 행에
// 대한 쓰기를 이미 허용하므로 RPC 없이 upsert로 충분하다. 점수/상태는 건드리지 않는다.
async function adminAttachWordExamPhoto(userId, examDate, file) {
  const uploadFile = window.optimizeImageForUpload ? await window.optimizeImageForUpload(file, { maxDimension: 1600, quality: 0.8 }) : file;
  const path = `wordexam/${userId}/${examDate}-${Date.now()}.${adminWordExamFileExtension(uploadFile)}`;
  const { error: uploadError } = await window.supabaseClient.storage.from(WORD_EXAM_BUCKET)
    .upload(path, uploadFile, { upsert: true, contentType: uploadFile.type, cacheControl: '31536000' });
  if (uploadError) throw uploadError;
  const { error: saveError } = await window.supabaseClient.from('word_exam_submissions').upsert(
    { user_id: userId, exam_date: examDate, photo_path: path, updated_at: new Date().toISOString() },
    { onConflict: 'user_id,exam_date' }
  );
  if (saveError) throw saveError;
}

// 학생 화면(Study/Stat/개인 리포트/Hall of Fame)에 이 시험의 사진·점수를 보여줄지 학생별로 켜고 끈다.
async function adminSetWordExamVisibility(userId, examDate, visible) {
  const { error } = await window.supabaseClient.from('word_exam_submissions')
    .update({ visible_to_student: visible, updated_at: new Date().toISOString() })
    .eq('user_id', userId).eq('exam_date', examDate);
  if (error) throw error;
}

// 선택한 시험 날짜에 제출된(사진이 있는) 행 전체를 한 번에 공개/비공개로 전환한다.
async function adminSetAllWordExamVisibility(examDate, visible) {
  const { error } = await window.supabaseClient.from('word_exam_submissions')
    .update({ visible_to_student: visible, updated_at: new Date().toISOString() })
    .eq('exam_date', examDate);
  if (error) throw error;
}

// 사진과 제출 행을 통째로 지운다 — 사진 없이 점수만 남는 상태를 만들지 않기 위해서다.
async function adminDeleteWordExamPhoto(userId, examDate, photoPath) {
  const { error } = await window.supabaseClient.from('word_exam_submissions').delete().eq('user_id', userId).eq('exam_date', examDate);
  if (error) throw error;
  if (photoPath) {
    const { error: storageError } = await window.supabaseClient.storage.from(WORD_EXAM_BUCKET).remove([photoPath]);
    if (storageError) console.error('[admin] word exam photo storage remove', storageError);
  }
}

function adminWordExamRowHTML(row) {
  const photoUrl = adminWordExamPhotoUrl(row.photo_path);
  const submitted = !!row.photo_path;
  const graded = row.status === 'graded';
  const visible = !!row.visible_to_student;
  return `
    <div class="glass-card rounded-[1.5rem] p-4 flex flex-col sm:flex-row sm:items-center gap-4" data-word-exam-user="${row.user_id}">
      <div class="min-w-0 flex-1 flex items-center gap-3">
        <div class="min-w-0">
          <p class="font-bold truncate">${adminEscape(row.name)} <span class="text-xs text-on-surface-variant font-normal">@${adminEscape(row.username)}</span></p>
          <p class="text-xs text-on-surface-variant truncate">${adminEscape(row.grade_class || '')}</p>
        </div>
        <label class="flex items-center gap-1.5 text-[11px] font-semibold text-on-surface-variant flex-shrink-0 ${submitted ? 'cursor-pointer' : 'opacity-40 pointer-events-none'}">
          <input type="checkbox" class="rounded text-primary word-exam-visible-toggle" ${visible ? 'checked' : ''} ${submitted ? '' : 'disabled'}>
          공개
        </label>
      </div>
      <div class="flex items-center gap-2 flex-shrink-0 flex-wrap">
        <label class="icon-glass w-10 h-10 rounded-full flex items-center justify-center text-primary cursor-pointer flex-shrink-0" aria-label="시험지 사진 첨부">
          <i class="fa-solid fa-plus"></i>
          <input type="file" accept="image/*" class="hidden word-exam-photo-input">
        </label>
        ${photoUrl ? `
          <div class="relative w-12 h-12 flex-shrink-0">
            <a href="${photoUrl}" target="_blank" rel="noopener" class="block w-12 h-12 rounded-xl overflow-hidden bg-surface-container"><img src="${photoUrl}" loading="lazy" class="w-full h-full object-cover"></a>
            <button type="button" class="absolute -top-1.5 -right-1.5 w-5 h-5 rounded-full bg-error text-white flex items-center justify-center text-[10px] word-exam-photo-delete" aria-label="사진 삭제"><i class="fa-solid fa-xmark"></i></button>
          </div>` : ''}
        <input type="number" min="0" max="100" step="1" class="glass-input rounded-xl px-3 py-2 text-sm w-20 word-exam-score-input" placeholder="점수" value="${row.score != null ? row.score : ''}" ${submitted ? '' : 'disabled'}>
        <span class="text-xs text-on-surface-variant">/ 100점</span>
        <button type="button" class="pill-btn-primary px-4 py-2 text-sm word-exam-save-btn disabled:opacity-40 disabled:cursor-not-allowed" ${submitted ? '' : 'disabled'}>${graded ? '수정' : '채점'}</button>
      </div>
    </div>`;
}

function adminRenderWordExamList() {
  const wrap = document.getElementById('admin-word-exam-list');
  if (!wrap) return;
  const q = adminWordExamSearch.trim().toLowerCase();
  const rows = adminWordExamRows.filter((row) => !q || row.name.toLowerCase().includes(q) || row.username.toLowerCase().includes(q));
  wrap.innerHTML = rows.length ? rows.map(adminWordExamRowHTML).join('') : '<p class="text-sm text-on-surface-variant text-center py-10">조건에 맞는 학생이 없습니다.</p>';
  wrap.querySelectorAll('.word-exam-visible-toggle').forEach((input) => {
    input.addEventListener('change', async () => {
      const userId = input.closest('[data-word-exam-user]').dataset.wordExamUser;
      const checked = input.checked;
      input.disabled = true;
      try {
        await adminSetWordExamVisibility(userId, adminWordExamActiveDate, checked);
        const row = adminWordExamRows.find((r) => r.user_id === userId);
        if (row) row.visible_to_student = checked;
        adminShowStatus(checked ? '학생에게 공개했습니다.' : '학생에게 비공개로 전환했습니다.');
      } catch (error) {
        console.error('[admin] word exam visibility', error);
        adminShowStatus('공개 설정을 변경하지 못했습니다.', true);
        input.checked = !checked;
      }
      input.disabled = false;
    });
  });
  wrap.querySelectorAll('.word-exam-photo-input').forEach((input) => {
    input.addEventListener('change', async () => {
      const file = input.files[0];
      if (!file) return;
      const userId = input.closest('[data-word-exam-user]').dataset.wordExamUser;
      input.disabled = true;
      try {
        await adminAttachWordExamPhoto(userId, adminWordExamActiveDate, file);
        adminShowStatus('시험지 사진을 첨부했습니다.');
        await adminLoadWordExam();
      } catch (error) {
        console.error('[admin] word exam photo attach', error);
        adminShowStatus('사진 첨부에 실패했습니다.', true);
        input.disabled = false;
      }
    });
  });
  wrap.querySelectorAll('.word-exam-photo-delete').forEach((btn) => {
    btn.addEventListener('click', async () => {
      if (!confirm('첨부한 시험지 사진을 삭제할까요? 점수도 함께 초기화됩니다.')) return;
      const card = btn.closest('[data-word-exam-user]');
      const userId = card.dataset.wordExamUser;
      const row = adminWordExamRows.find((r) => r.user_id === userId);
      btn.disabled = true;
      try {
        await adminDeleteWordExamPhoto(userId, adminWordExamActiveDate, row?.photo_path);
        adminShowStatus('시험지 사진을 삭제했습니다.');
        await adminLoadWordExam();
      } catch (error) {
        console.error('[admin] word exam photo delete', error);
        adminShowStatus('사진 삭제에 실패했습니다.', true);
        btn.disabled = false;
      }
    });
  });
  wrap.querySelectorAll('.word-exam-save-btn').forEach((btn) => {
    btn.addEventListener('click', async () => {
      const card = btn.closest('[data-word-exam-user]');
      const userId = card.dataset.wordExamUser;
      const input = card.querySelector('.word-exam-score-input');
      const score = Number(input.value);
      if (!Number.isFinite(score) || score < 0 || score > 100) { adminShowStatus('0~100 사이 점수를 입력해주세요.', true); return; }
      btn.disabled = true;
      const { error } = await window.supabaseClient.rpc('admin_grade_word_exam', { target_user_id: userId, target_exam_date: adminWordExamActiveDate, new_score: score, new_max_score: 100 });
      if (error) { adminShowStatus('채점 저장에 실패했습니다.', true); btn.disabled = false; return; }
      adminShowStatus('채점을 저장했습니다.');
      await adminLoadWordExam();
    });
  });
  adminRenderWordExamBulkVisible();
}

// 선택한 시험 날짜에 제출된 학생 기준으로 "전체 공개" 체크박스의 켜짐/부분선택 상태를 계산한다.
function adminRenderWordExamBulkVisible() {
  const checkbox = document.getElementById('admin-word-exam-bulk-visible');
  const countEl = document.getElementById('admin-word-exam-bulk-count');
  if (!checkbox) return;
  const submitted = adminWordExamRows.filter((row) => row.photo_path);
  const visibleCount = submitted.filter((row) => row.visible_to_student).length;
  checkbox.disabled = submitted.length === 0;
  checkbox.checked = submitted.length > 0 && visibleCount === submitted.length;
  checkbox.indeterminate = visibleCount > 0 && visibleCount < submitted.length;
  if (countEl) countEl.textContent = submitted.length ? `제출 ${submitted.length}명 중 ${visibleCount}명 공개` : '제출된 학생이 없습니다.';
}

async function adminLoadWordExam() {
  const wrap = document.getElementById('admin-word-exam-list');
  if (wrap) wrap.innerHTML = '<p class="text-sm text-on-surface-variant text-center py-10"><i class="fa-solid fa-spinner fa-spin mr-2"></i>불러오는 중...</p>';
  const { data, error } = await window.supabaseClient.rpc('admin_get_word_exam_submissions', { target_exam_date: adminWordExamActiveDate });
  if (error) { if (wrap) wrap.innerHTML = '<p class="text-sm text-error text-center py-10">word_exam_schema.sql을 먼저 실행해주세요.</p>'; return; }
  adminWordExamRows = data || [];
  adminRenderWordExamList();
  await adminLoadWordExamFeatureToggles();
}

// Control Panel에 있던 '단어 시험'/'단어 시험 랭킹' on/off를 Word Test 탭으로 옮겨왔다 —
// 학생 점수 공개 관련 설정을 전부 이 탭 하나에서 관리하기 위함. app_feature_flags 테이블은
// 그대로 재사용하고(section/label 값도 기존 시드와 동일하게 유지), 여기서 직접 읽고 쓴다.
const WORD_EXAM_FEATURE_TOGGLES = [
  { key: 'word_exam', label: 'Word Exam', section: 'Private', display: '학생 화면 노출 (Study)' },
  { key: 'hall_of_fame_word_exam', label: 'Word Exam Ranking', section: 'Public', display: 'Hall of Fame 랭킹' }
];

async function adminLoadWordExamFeatureToggles() {
  const wrap = document.getElementById('admin-word-exam-feature-toggles');
  if (!wrap) return;
  const { data, error } = await window.supabaseClient.from('app_feature_flags').select('feature_key,is_enabled')
    .in('feature_key', WORD_EXAM_FEATURE_TOGGLES.map((toggle) => toggle.key));
  if (error) { wrap.innerHTML = '<p class="text-xs text-error">기능 상태를 불러오지 못했습니다.</p>'; return; }
  const flagMap = Object.fromEntries((data || []).map((row) => [row.feature_key, row.is_enabled]));
  wrap.innerHTML = WORD_EXAM_FEATURE_TOGGLES.map((toggle) => `
    <div class="flex items-center gap-2">
      <span class="text-xs font-semibold text-on-surface-variant">${adminEscape(toggle.display)}</span>
      <label class="admin-switch" aria-label="${adminEscape(toggle.display)} 켜기 또는 끄기">
        <input type="checkbox" data-word-exam-feature-key="${toggle.key}" ${flagMap[toggle.key] !== false ? 'checked' : ''}>
        <span class="admin-switch-track"></span>
      </label>
    </div>`).join('');
  wrap.querySelectorAll('[data-word-exam-feature-key]').forEach((input) => input.addEventListener('change', async () => {
    const toggle = WORD_EXAM_FEATURE_TOGGLES.find((t) => t.key === input.dataset.wordExamFeatureKey);
    const { error: updateError } = await window.supabaseClient.from('app_feature_flags').upsert(
      { feature_key: toggle.key, label: toggle.label, section: toggle.section, is_enabled: input.checked, updated_by: adminCurrentUserId, updated_at: new Date().toISOString() },
      { onConflict: 'feature_key' }
    );
    if (updateError) { input.checked = !input.checked; adminShowStatus('기능 상태를 변경하지 못했습니다.', true); }
    else adminShowStatus(`${toggle.display} 기능을 ${input.checked ? '켰습니다' : '껐습니다'}.`);
  }));
}

function adminWireWordExam() {
  document.querySelectorAll('[data-word-exam-date]').forEach((btn) => {
    btn.addEventListener('click', () => {
      if (btn.dataset.wordExamDate === adminWordExamActiveDate) return;
      adminWordExamActiveDate = btn.dataset.wordExamDate;
      document.querySelectorAll('[data-word-exam-date]').forEach((b) => {
        b.classList.toggle('nav-pill-active', b === btn);
        b.classList.toggle('text-on-surface-variant', b !== btn);
      });
      adminLoadWordExam();
    });
  });
  document.getElementById('admin-word-exam-search')?.addEventListener('input', (event) => {
    adminWordExamSearch = event.target.value;
    adminRenderWordExamList();
  });
  // 학생들이 점수 공개에 민감한 항목이라 실수 방지를 위해 항상 확인창을 거친다.
  document.getElementById('admin-word-exam-bulk-visible')?.addEventListener('change', async (event) => {
    const checkbox = event.target;
    const target = checkbox.checked;
    const submittedCount = adminWordExamRows.filter((row) => row.photo_path).length;
    if (submittedCount === 0) { adminRenderWordExamBulkVisible(); return; }
    const confirmMessage = target
      ? `제출된 학생 ${submittedCount}명 전체에게 시험지 사진과 점수를 공개할까요?`
      : `제출된 학생 ${submittedCount}명 전체를 비공개로 전환할까요?`;
    if (!confirm(confirmMessage)) { adminRenderWordExamBulkVisible(); return; }
    checkbox.disabled = true;
    try {
      await adminSetAllWordExamVisibility(adminWordExamActiveDate, target);
      adminShowStatus(target ? '전체 공개했습니다.' : '전체 비공개로 전환했습니다.');
      await adminLoadWordExam();
    } catch (error) {
      console.error('[admin] word exam bulk visibility', error);
      adminShowStatus('일괄 공개 설정에 실패했습니다.', true);
      adminRenderWordExamBulkVisible();
    }
  });
}
