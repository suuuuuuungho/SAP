# SAP 1기 대시보드

Tailwind CDN + 순수 HTML/CSS/JS로 만든 반응형 대시보드 셸. 빌드 과정 없이 GitHub Pages에 그대로 배포합니다.

## 로컬 실행

빌드 도구가 없으므로 정적 서버로 폴더를 열기만 하면 됩니다.

```bash
npx serve .
```

## Supabase 설정

1. `assets/config.example.js`를 `assets/config.js`로 복사
2. Supabase 프로젝트의 URL/anon key를 채워 넣기 (`assets/config.js`는 `.gitignore`에 포함되어 커밋되지 않음)
3. Supabase 대시보드 → **SQL Editor**에서 [`supabase/schema.sql`](supabase/schema.sql) 전체 실행 (`profiles` 테이블, 자동 프로필 생성 트리거, 로그인/아이디찾기용 RPC 생성)
4. Supabase 대시보드 → **Authentication → URL Configuration**에서 Redirect URLs에 배포 URL의 `index.html`과 `reset-password.html`을 등록
   - 예: `https://<사용자명>.github.io/SAP/index.html`, `https://<사용자명>.github.io/SAP/reset-password.html`
5. (선택) **Authentication → Emails → Confirm signup**을 켜두면 가입 시 이메일 인증을 요구합니다. 꺼두면 가입 즉시 로그인됩니다. 어느 쪽이든 회원가입 코드는 그대로 동작합니다.

### 계정 구조

- 로그인은 **아이디 + 비밀번호**로 하지만, Supabase Auth 자체는 이메일 계정입니다. 회원가입 시 입력한 이메일이 실제 Auth 이메일이 되고, `profiles.username`으로 아이디를 매핑합니다.
- 로그인 시 `get_login_email(아이디)` RPC로 이메일을 조회한 뒤 `signInWithPassword`를 호출합니다.
- 아이디 찾기는 `find_username(이름, 전화번호)`, 비밀번호 찾기는 `get_login_email` + `resetPasswordForEmail`을 사용합니다.
- 세 RPC 모두 `profiles` 테이블 전체를 노출하지 않고 필요한 값 하나만 반환하도록 `SECURITY DEFINER`로 작성되어 있습니다.

## GitHub Pages 배포

1. GitHub에 새 저장소 생성 (또는 기존 저장소 사용)
2. 이 폴더 내용을 저장소 루트에 push
   ```bash
   git remote add origin <저장소 URL>
   git branch -M main
   git push -u origin main
   ```
3. 저장소 Settings → Pages → Source를 "Deploy from a branch" → `main` / `/(root)`로 설정
4. 배포된 URL을 Supabase Redirect URL에 추가

## 페이지 구성

- `index.html` — Home
- `study.html` — Study
- `gallery.html` — Gallery
- `stat.html` — Stat
- `login.html` — 아이디/비밀번호 로그인
- `signup.html` — 회원가입 (아이디/비밀번호/비밀번호 확인/이름/학년반/전화번호/이메일)
- `find-id.html` — 아이디 찾기 (이름 + 전화번호)
- `find-password.html` — 비밀번호 찾기 (아이디 → 이메일로 재설정 링크 발송)
- `reset-password.html` — 이메일로 받은 재설정 링크가 도착하는 페이지 (새 비밀번호 설정)

Home은 원본 목업 그대로의 대시보드 콘텐츠(Section 1 시작하기 체크리스트 + Section 2 지표 카드)가 구현되어 있고, Study/Gallery/Stat은 아직 레이아웃 셸(placeholder)만 있습니다. 모든 페이지는 `assets/js/layout.js`가 공통 사이드바/헤더를 주입합니다.
