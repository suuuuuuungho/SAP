// Home page only: Progress checkmarks + 기도 인증 모달.
// Progress state is stored locally (per-browser) for now — not yet saved to Supabase.
const PROGRESS_STORAGE_KEY = 'sap_progress_v1';
const PRAYER_CLASSES_STORAGE_KEY = 'sap_prayer_classes_v1';

function loadProgress() {
  try {
    return Object.assign(
      { pray: false, word: false, study: false, worship: false },
      JSON.parse(localStorage.getItem(PROGRESS_STORAGE_KEY) || '{}')
    );
  } catch (e) {
    return { pray: false, word: false, study: false, worship: false };
  }
}

function saveProgress(progress) {
  localStorage.setItem(PROGRESS_STORAGE_KEY, JSON.stringify(progress));
}

// Same checkmark icon everywhere — colored gradient when verified, neutral glass when not.
function renderProgressIcons() {
  const progress = loadProgress();
  document.querySelectorAll('[data-progress-icon]').forEach((el) => {
    const key = el.getAttribute('data-progress-icon');
    el.className = progress[key]
      ? 'w-8 h-8 rounded-full bg-gradient-to-br from-primary-container to-tertiary-container text-on-primary flex items-center justify-center shrink-0'
      : 'icon-glass w-8 h-8 rounded-full text-on-surface-variant flex items-center justify-center shrink-0';
  });
}

function updatePrayRemoveButtons() {
  const entries = document.querySelectorAll('#pray-class-list .pray-class-entry');
  entries.forEach((entry) => {
    const removeBtn = entry.querySelector('.pray-remove-class');
    if (removeBtn) removeBtn.classList.toggle('hidden', entries.length <= 1);
  });
}

function addPrayClassEntry() {
  const template = document.getElementById('pray-class-template');
  const list = document.getElementById('pray-class-list');
  if (!template || !list) return;
  list.appendChild(template.content.cloneNode(true));
  updatePrayRemoveButtons();
}

function openPrayModal() {
  const modal = document.getElementById('pray-modal');
  const list = document.getElementById('pray-class-list');
  if (!modal || !list) return;
  list.innerHTML = '';
  addPrayClassEntry();
  modal.classList.remove('hidden');
  modal.classList.add('flex');
}

function closePrayModal() {
  const modal = document.getElementById('pray-modal');
  if (!modal) return;
  modal.classList.add('hidden');
  modal.classList.remove('flex');
}

function initHomeWidgets() {
  renderProgressIcons();

  const prayWidget = document.getElementById('widget-pray');
  if (prayWidget) prayWidget.addEventListener('click', openPrayModal);

  const closeBtn = document.getElementById('pray-modal-close');
  const overlay = document.getElementById('pray-modal-overlay');
  const cancelBtn = document.getElementById('pray-cancel');
  const addBtn = document.getElementById('pray-add-class');
  const saveBtn = document.getElementById('pray-save');
  const list = document.getElementById('pray-class-list');

  if (closeBtn) closeBtn.addEventListener('click', closePrayModal);
  if (overlay) overlay.addEventListener('click', closePrayModal);
  if (cancelBtn) cancelBtn.addEventListener('click', closePrayModal);
  if (addBtn) addBtn.addEventListener('click', addPrayClassEntry);

  if (list) {
    list.addEventListener('click', (e) => {
      const removeBtn = e.target.closest('.pray-remove-class');
      if (!removeBtn) return;
      removeBtn.closest('.pray-class-entry').remove();
      updatePrayRemoveButtons();
    });
  }

  if (saveBtn) {
    saveBtn.addEventListener('click', () => {
      const entries = [...document.querySelectorAll('#pray-class-list .pray-class-entry')].map((entry) => ({
        location: entry.querySelector('.pray-location-input').value,
        start: entry.querySelector('.pray-start-input').value,
        end: entry.querySelector('.pray-end-input').value
      }));

      localStorage.setItem(PRAYER_CLASSES_STORAGE_KEY, JSON.stringify(entries));

      const progress = loadProgress();
      progress.pray = true;
      saveProgress(progress);
      renderProgressIcons();

      closePrayModal();
    });
  }
}

window.initHomeWidgets = initHomeWidgets;
