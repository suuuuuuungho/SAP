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

**일반 이용자 (사이드바 있음, `assets/js/layout.js`가 공통 셸을 주입)**

- `index.html` — MyPage (기도/말씀 인증, 오늘 위젯)
- `home.html` — Board (공지, 오늘의 말씀, 내 게시물 댓글 알림)
- `study.html` — Study (단어 학습, 단어 시험 확인)
- `gallery.html` — Gallery (기도/말씀 인증 게시물, 댓글)
- `stat.html` — Stat (개인 활동 통계·차트)
- `hall-of-fame.html` — Hall of Fame (주차별/누적 랭킹, 단어 시험 Top 5)
- `team.html` — Team (팀별 활동시간·기여도 랭킹)
- `profile.html` — 내 프로필 (아바타, 계정 설정)

**관리자 전용**

- `admin.html` — 관리자 콘솔 (Board 관리, 학부모 메시지, 성경 말씀, Comment, Gallery 관리, Word Test, Team 관리, Control Panel, Member, Dashboard, Stat) — 탭별로 `assets/js/admin/`에 파일이 나뉘어 있음
- `report.html` — 학부모에게 문자로 발송되는 학생 개인 리포트 (토큰 기반, 로그인 불필요)

**인증**

- `login.html` / `signup.html` / `find-id.html` / `find-password.html` / `reset-password.html`

## `assets/js/` 폴더 구조

- `assets/js/core/` — 인증, 레이아웃(사이드바), Supabase 클라이언트 등 페이지 공통 인프라
- `assets/js/features/` — 페이지별 기능 스크립트 (gallery, study, stat, team, hall-of-fame, report 등)
- `assets/js/admin/` — 관리자 콘솔 탭별 스크립트 (admin-core, admin-board-manage, admin-comment 등)
