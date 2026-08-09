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

function renderReportStatistics(days) {
  const allCategories = [
    { key: 'pray_minutes', label: '기도', color: '#ff4b91' },
    { key: 'word_minutes', label: '말씀', color: '#6e4f9c' },
    { key: 'study_minutes', label: '공부', color: '#ee6650' },
    { key: 'worship_minutes', label: '예배', color: '#14b8a6' }
  ];
  const compositionCategories = allCategories.filter((category) => category.key !== 'worship_minutes');
  const dayTotals = days.map((day) => allCategories.reduce((sum, category) => sum + (Number(day[category.key]) || 0), 0));
  const categoryTotals = compositionCategories.map((category) => ({ ...category, minutes: days.reduce((sum, day) => sum + (Number(day[category.key]) || 0), 0) }));
  const total = dayTotals.reduce((sum, minutes) => sum + minutes, 0);
  const now = new Date();
  const todayKey = `${now.getFullYear()}-${String(now.getMonth() + 1).padStart(2, '0')}-${String(now.getDate()).padStart(2, '0')}`;
  const latestActiveIndex = dayTotals.reduce((latest, minutes, index) => minutes > 0 ? index : latest, -1);
  const todayIndex = days.reduce((latest, day, index) => day.record_date <= todayKey ? index : latest, -1);
  const movingEndIndex = Math.max(latestActiveIndex, todayIndex);
  const movingDays = movingEndIndex >= 0 ? days.slice(0, movingEndIndex + 1) : [];
  const movingTotal = movingDays.reduce((sum, day) => sum + allCategories.reduce((daySum, category) => daySum + (Number(day[category.key]) || 0), 0), 0);
  const average = movingDays.length ? Math.round(movingTotal / movingDays.length) : 0;
  const completedDays = dayTotals.filter((minutes) => minutes >= 300).length;
  const bestMinutes = Math.max(0, ...dayTotals);
  const bestIndex = dayTotals.indexOf(bestMinutes);
  const bestDate = bestMinutes > 0 && days[bestIndex] ? reportDate(days[bestIndex].record_date) : '-';

  document.getElementById('report-kpis').innerHTML = [
    { value: reportMinutes(total), label: '누적 시간' },
    { value: reportMinutes(average), label: '하루 평균', note: `현재까지 ${movingDays.length}일 기준` },
    { value: `${completedDays}일`, label: '300분 달성일' },
    { value: reportMinutes(bestMinutes), label: '최고 기록', note: bestDate }
  ].map((item) => `<article class="glass-card rounded-2xl p-4 sm:p-5"><p class="text-xl sm:text-2xl font-bold text-primary">${reportEscape(item.value)}</p><p class="text-xs font-bold text-on-surface-variant mt-2">${reportEscape(item.label)}</p>${item.note ? `<p class="text-[10px] text-on-surface-variant mt-1">${reportEscape(item.note)}</p>` : ''}</article>`).join('');

  document.getElementById('report-total-time').textContent = `총 ${reportMinutes(total)}`;
  const compositionTotal = categoryTotals.reduce((sum, category) => sum + category.minutes, 0);
  const maxCategory = Math.max(1, ...categoryTotals.map((category) => category.minutes));
  document.getElementById('report-category-stats').innerHTML = categoryTotals.map((category) => {
    const width = category.minutes ? Math.max(4, Math.round(category.minutes / maxCategory * 100)) : 0;
    const share = compositionTotal ? Math.round(category.minutes / compositionTotal * 100) : 0;
    return `<div><div class="flex items-center justify-between gap-3 text-xs mb-2"><span class="font-bold">${category.label}</span><span class="text-on-surface-variant">${reportMinutes(category.minutes)} · ${share}%</span></div><div class="h-2.5 rounded-full bg-surface-container overflow-hidden"><div class="h-full rounded-full" style="width:${width}%;background:${category.color}"></div></div></div>`;
  }).join('');
}

function renderSharedReport(data) {
  const student = data.student || {};
  document.getElementById('report-student').textContent = `${student.name || '-'} · @${student.username || '-'}`;
  document.getElementById('report-generated').textContent = `생성 ${new Date(data.generatedAt).toLocaleString('ko-KR')}`;
  renderReportStatistics(data.days || []);
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
