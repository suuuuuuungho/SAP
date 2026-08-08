# admin-gallery-media

Admin Gallery에서 사진 한 장을 Storage와 게시물에서 함께 삭제하는 서버 함수입니다.

1. Supabase Edge Functions에서 `admin-gallery-media` 함수를 생성합니다.
2. 같은 폴더의 `index.ts` 내용을 붙여넣고 배포합니다.
3. JWT 확인은 켠 상태로 둡니다.
4. 별도 Secret은 필요하지 않으며 Supabase 기본 환경변수를 사용합니다.
