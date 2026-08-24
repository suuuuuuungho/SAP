// 여러 페이지(admin/gallery/hall-of-fame/home/team/report)에서 각자 거의 동일하게
// 구현하고 있던 HTML 이스케이프 함수를 하나로 통합. 각 페이지의 기존 xxxEscape 이름은
// 그대로 두고 이 함수를 가리키는 별칭으로만 바꿔서, 호출부(수십 곳)는 건드리지 않는다.
function escapeHTML(value) {
  return String(value == null ? '' : value)
    .replaceAll('&', '&amp;').replaceAll('<', '&lt;').replaceAll('>', '&gt;')
    .replaceAll('"', '&quot;').replaceAll("'", '&#039;');
}
