// 학년반 드롭다운 옵션 생성. 학생 반과 교직원 역할을 함께 제공한다.
const GRADE_CLASS_GROUPS = [
  { label: '1학년', values: Array.from({ length: 6 }, (_, i) => `1-${i + 1}반`) },
  { label: '2학년', values: Array.from({ length: 7 }, (_, i) => `2-${i + 1}반`) },
  { label: '3학년', values: Array.from({ length: 6 }, (_, i) => `3-${i + 1}반`) },
  { label: '신입반', values: Array.from({ length: 4 }, (_, i) => `신입${i + 1}반`) },
  { label: '교직원', values: ['교사', '관리자'] }
];

function renderGradeClassOptions(selectEl) {
  const placeholder = document.createElement('option');
  placeholder.value = '';
  placeholder.textContent = '학년반을 선택하세요';
  placeholder.disabled = true;
  placeholder.selected = true;
  selectEl.appendChild(placeholder);

  GRADE_CLASS_GROUPS.forEach((group) => {
    const optgroup = document.createElement('optgroup');
    optgroup.label = group.label;
    group.values.forEach((value) => {
      const option = document.createElement('option');
      option.value = value;
      option.textContent = value;
      optgroup.appendChild(option);
    });
    selectEl.appendChild(optgroup);
  });
}
