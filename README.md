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
3. Supabase 대시보드 → Authentication → URL Configuration에서 GitHub Pages 배포 URL을 Redirect URL로 등록 (매직 링크 로그인 후 리다이렉트에 필요)

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
- `login.html` — Supabase 이메일 매직 링크 로그인

모든 페이지는 `assets/js/layout.js`가 공통 사이드바/헤더를 주입합니다. 각 페이지의 실제 콘텐츠는 `<template id="page-content">` 안에 있으며, 현재는 레이아웃 셸(placeholder)만 구현되어 있습니다.
