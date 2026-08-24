// Admin 콘솔 — Bible Verse 탭: 오늘의 말씀 등록/전환/삭제.

async function adminLoadVerses() {
  const { data, error } = await window.supabaseClient.from('home_bible_verses').select('*').order('created_at', { ascending: false }).limit(30);
  if (error) { console.error('[admin] verses', error); return; }
  const wrap = document.getElementById('admin-verse-list');
  if (!wrap) return;
  wrap.innerHTML = (data || []).length ? data.map((verse) => `
    <article class="glass-card rounded-2xl p-4 ${verse.is_active ? 'ring-2 ring-secondary' : 'opacity-50'}" data-verse-id="${verse.id}">
      <div class="flex items-start justify-between gap-3">
        <div><p class="text-xs font-bold text-secondary mb-1">${adminEscape(verse.reference)}</p><p class="text-sm leading-6">${adminEscape(verse.verse_text)}</p><p class="text-[10px] text-on-surface-variant mt-2">등록 ${new Date(verse.created_at).toLocaleString('ko-KR')}</p></div>
        <div class="flex gap-1 flex-shrink-0">
          <button type="button" data-action="activate" class="icon-glass w-8 h-8 rounded-full" aria-label="대표 말씀으로 설정"><i class="fa-solid fa-star text-xs"></i></button>
          <button type="button" data-action="delete" class="icon-glass w-8 h-8 rounded-full text-error" aria-label="삭제"><i class="fa-solid fa-trash text-xs"></i></button>
        </div>
      </div>
    </article>`).join('') : '<p class="text-sm text-on-surface-variant">등록된 성경구절이 없습니다.</p>';
}

function adminWireVerseForm() {
  const form = document.getElementById('admin-verse-form');
  if (!form) return;
  form.addEventListener('submit', async (event) => {
    event.preventDefault();
    const reference = document.getElementById('admin-verse-reference').value.trim();
    const verseText = document.getElementById('admin-verse-text').value.trim();
    const { data: inserted, error } = await window.supabaseClient.from('home_bible_verses')
      .insert({ reference, verse_text: verseText, is_active: true, created_by: adminCurrentUserId })
      .select('id')
      .single();
    if (error) { adminShowStatus('성경구절을 저장하지 못했습니다.', true); console.error('[admin] insert verse', error); return; }
    const { error: deactivateError } = await window.supabaseClient.from('home_bible_verses')
      .update({ is_active: false })
      .eq('is_active', true)
      .neq('id', inserted.id);
    if (deactivateError) console.error('[admin] deactivate previous verses', deactivateError);
    form.reset();
    adminShowStatus('Home 성경구절을 변경했습니다.');
    await adminLoadVerses();
  });
}

function adminWireVerseList() {
  const wrap = document.getElementById('admin-verse-list');
  if (!wrap) return;
  wrap.addEventListener('click', async (event) => {
    const button = event.target.closest('[data-action]');
    const article = event.target.closest('[data-verse-id]');
    if (!button || !article) return;
    const id = article.dataset.verseId;
    if (button.dataset.action === 'delete') {
      await window.supabaseClient.from('home_bible_verses').delete().eq('id', id);
    } else {
      const { error: activateError } = await window.supabaseClient.from('home_bible_verses').update({ is_active: true }).eq('id', id);
      if (activateError) { adminShowStatus('성경구절을 변경하지 못했습니다.', true); return; }
      const { error: deactivateError } = await window.supabaseClient.from('home_bible_verses')
        .update({ is_active: false })
        .eq('is_active', true)
        .neq('id', id);
      if (deactivateError) console.error('[admin] deactivate other verses', deactivateError);
    }
    await adminLoadVerses();
  });
}
