-- SAP 1기 대시보드: Sapians 피드 댓글 기능용 스키마
-- Supabase 대시보드 → SQL Editor에서 전체를 한 번 실행하세요. (gallery_schema.sql 실행 이후에 실행)

create extension if not exists pgcrypto;

alter table public.profiles
  add column if not exists app_role text not null default 'student',
  add column if not exists is_active boolean not null default true;

-- 게시물은 별도 테이블이 없고 (post_owner_id, post_date, post_type)으로 pray_records/word_records의
-- 특정 행 하나를 가리킨다 — Sapians 피드 자체가 그 두 테이블을 그대로 읽어서 만들어지는 것과 동일한 설계.
create table if not exists public.post_comments (
  id uuid primary key default gen_random_uuid(),
  post_owner_id uuid not null references auth.users (id) on delete cascade,
  post_date date not null,
  post_type text not null check (post_type in ('pray', 'word')),
  author_id uuid not null references auth.users (id) on delete cascade,
  body text not null check (char_length(trim(body)) > 0 and char_length(body) <= 300),
  created_at timestamptz not null default now()
);

create index if not exists post_comments_post_idx
  on public.post_comments (post_owner_id, post_date, post_type, created_at);

alter table public.post_comments enable row level security;

create or replace function public.can_write_gallery_comments()
returns boolean language sql stable security definer set search_path = public
as $$
  select exists (
    select 1 from public.profiles p
    where p.id = auth.uid()
      and (p.is_admin = true or p.app_role in ('admin', 'teacher', 'pastor', 'department_head', 'secretary'))
      and p.is_active = true
  );
$$;
grant execute on function public.can_write_gallery_comments() to authenticated;

-- gallery_enabled=true인 유저의 게시물에 달린 댓글은 누구나 조회 가능 (Sapians 피드를 보는 모든 로그인 유저)
drop policy if exists "post_comments_select" on public.post_comments;
create policy "post_comments_select"
  on public.post_comments for select
  using (
    exists (select 1 from public.profiles p where p.id = post_comments.post_owner_id and p.gallery_enabled = true)
  );

-- 로그인 유저는 자기 이름으로만, gallery_enabled=true인 게시물에만 댓글 작성 가능
drop policy if exists "post_comments_insert" on public.post_comments;
create policy "post_comments_insert"
  on public.post_comments for insert
  with check (
    author_id = auth.uid()
    and public.can_write_gallery_comments()
    and exists (select 1 from public.profiles p where p.id = post_comments.post_owner_id and p.gallery_enabled = true)
  );

-- 본인이 쓴 댓글만 수정 가능
drop policy if exists "post_comments_update" on public.post_comments;
create policy "post_comments_update"
  on public.post_comments for update
  using (author_id = auth.uid() and public.can_write_gallery_comments())
  with check (
    author_id = auth.uid()
    and public.can_write_gallery_comments()
    and char_length(trim(body)) > 0
    and char_length(body) <= 300
  );

-- 본인이 쓴 댓글만 삭제 가능
drop policy if exists "post_comments_delete" on public.post_comments;
create policy "post_comments_delete"
  on public.post_comments for delete
  using (author_id = auth.uid());
