const REPORT_PHOTO_BUCKET = 'verification-photos-v2';

function reportEscape(value) {
  return String(value ?? '').replace(/[&<>'"]/g, (char) => ({ '&': '&amp;', '<': '&lt;', '>': '&gt;', "'": '&#39;', '"': '&quot;' }[char]));
}

function reportDate(value) {
  const date = new Date(`${value}T12:00:00`);
  return `${date.getMonth() + 1}/${date.getDate()} (${['일','월','화','수','목','금','토'][date.getDay()]})`;
}

function reportMinutes(value) {
  const minutes = Math.max(0, Number(value) || 0);
  if (!minutes) return '-';
  const hours = Math.floor(minutes / 60);
  const rest = minutes % 60;
  return hours ? `${hours}시간${rest ? ` ${rest}분` : ''}` : `${rest}분`;
}

function reportPhotoUrl(path) {
  if (!path) return '';
  return window.supabaseClient.storage.from(REPORT_PHOTO_BUCKET).getPublicUrl(path).data.publicUrl;
}

function reportPrayerDetails(entries) {
  return (entries || []).map((entry) => {
    const start = entry.start ? new Date(entry.start) : null;
    const end = entry.end ? new Date(entry.end) : null;
    const minutes = start && end && !Number.isNaN(start.getTime()) && !Number.isNaN(end.getTime()) ? Math.max(0, Math.round((end - start) / 60000)) : 0;
    const time = start && end ? `${start.toLocaleString('ko-KR', { month:'numeric', day:'numeric', hour:'2-digit', minute:'2-digit' })} ~ ${end.toLocaleString('ko-KR', { month:'numeric', day:'numeric', hour:'2-digit', minute:'2-digit' })}` : '';
    return `<li class="text-sm"><span class="font-semibold">${reportEscape(entry.location || '기도')}</span>${time ? ` · ${reportEscape(time)}` : ''}${minutes ? ` · ${minutes}분` : ''}</li>`;
  }).join('');
}

function reportVerseDetails(verses) {
  return (verses || []).map((verse) => {
    const endBook = verse.endBook || verse.startBook;
    const endChapter = verse.endChapter || verse.startChapter;
    return `<li class="text-sm"><span class="font-semibold">${reportEscape(verse.startBook)} ${reportEscape(verse.startChapter)}장 ~ ${reportEscape(endBook)} ${reportEscape(endChapter)}장</span>${Number(verse.meditationMinutes) > 0 ? ` · 추가 ${Number(verse.meditationMinutes)}분` : ''}</li>`;
  }).join('');
}

function reportPhotosHTML(paths, alt) {
  const photos = paths.filter(Boolean);
  if (!photos.length) return '<div class="rounded-2xl bg-surface-container h-36 flex items-center justify-center text-xs text-on-surface-variant">첨부 사진 없음</div>';
  return `<div class="grid ${photos.length > 1 ? 'grid-cols-2' : 'grid-cols-1'} gap-2">${photos.map((path) => `<a href="${reportEscape(reportPhotoUrl(path))}" target="_blank" rel="noopener" class="block rounded-2xl overflow-hidden bg-surface-container aspect-[4/3]"><img src="${reportEscape(reportPhotoUrl(path))}" alt="${reportEscape(alt)}" class="w-full h-full object-contain"></a>`).join('')}</div>`;
}

function renderSharedReport(data) {
  const student = data.student || {};
  document.getElementById('report-student').textContent = `${student.name || '-'} · @${student.username || '-'}`;
  document.getElementById('report-generated').textContent = `생성 ${new Date(data.generatedAt).toLocaleString('ko-KR')}`;
  document.getElementById('report-daily-body').innerHTML = (data.days || []).map((day) => {
    const total = ['pray_minutes','word_minutes','study_minutes','worship_minutes'].reduce((sum, key) => sum + (Number(day[key]) || 0), 0);
    const worship = day.worship_status ? reportMinutes(day.worship_minutes) : '-';
    return `<tr class="border-b border-outline-variant/50"><td class="py-3 px-2 font-semibold">${reportEscape(reportDate(day.record_date))}</td><td class="py-3 px-2">${reportMinutes(day.pray_minutes)}</td><td class="py-3 px-2">${reportMinutes(day.word_minutes)}</td><td class="py-3 px-2">${reportMinutes(day.study_minutes)}</td><td class="py-3 px-2">${worship}</td><td class="py-3 px-2 font-bold text-primary">${reportMinutes(total)}</td></tr>`;
  }).join('');
  document.getElementById('report-pray-posts').innerHTML = (data.prayPosts || []).map((post) => `<article class="glass-card rounded-[1.5rem] p-5"><p class="text-xs font-bold text-primary mb-3">${reportEscape(reportDate(post.date))}</p>${reportPhotosHTML((post.entries || []).map((entry) => entry.photoPath), '기도 인증 사진')}<ul class="mt-4 space-y-2 text-on-surface-variant">${reportPrayerDetails(post.entries)}</ul></article>`).join('') || '<p class="glass-card rounded-2xl p-8 text-sm text-center text-on-surface-variant lg:col-span-2">기도 인증 기록이 없습니다.</p>';
  document.getElementById('report-word-posts').innerHTML = (data.wordPosts || []).map((post) => `<article class="glass-card rounded-[1.5rem] p-5"><p class="text-xs font-bold text-secondary mb-3">${reportEscape(reportDate(post.date))}</p>${reportPhotosHTML([post.photoPath], '말씀 묵상 인증 사진')}<ul class="mt-4 space-y-2 text-on-surface-variant">${reportVerseDetails(post.verses)}</ul></article>`).join('') || '<p class="glass-card rounded-2xl p-8 text-sm text-center text-on-surface-variant lg:col-span-2">말씀 묵상 인증 기록이 없습니다.</p>';
}

async function initSharedReport() {
  const token = new URLSearchParams(location.search).get('token');
  if (!token) { document.getElementById('report-loading').classList.add('hidden'); document.getElementById('report-error').classList.remove('hidden'); return; }
  const { data, error } = await window.supabaseClient.rpc('get_shared_student_report', { report_token: token });
  document.getElementById('report-loading').classList.add('hidden');
  if (error || !data) { document.getElementById('report-error').classList.remove('hidden'); return; }
  renderSharedReport(data);
  document.getElementById('report-content').classList.remove('hidden');
}

document.addEventListener('DOMContentLoaded', initSharedReport);
