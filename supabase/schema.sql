-- SAP 1기 대시보드: 아이디/비밀번호 회원가입·로그인용 스키마
-- Supabase 대시보드 → SQL Editor에서 전체를 한 번 실행하세요.

-- 1) 프로필 테이블
-- auth.users는 Supabase 표준 이메일 계정을 그대로 사용하고,
-- 아이디/이름/학년반/전화번호 등 부가 정보는 profiles에 별도 보관합니다.
create table if not exists public.profiles (
  id uuid primary key references auth.users (id) on delete cascade,
  username text not null unique,
  name text not null,
  grade_class text not null,
  phone text not null,
  email text not null,
  created_at timestamptz not null default now()
);

alter table public.profiles enable row level security;

-- 본인 프로필만 조회 가능 (사이드바에 이름 표시용)
drop policy if exists "profiles_select_own" on public.profiles;
create policy "profiles_select_own"
  on public.profiles for select
  using (auth.uid() = id);

-- 2) 회원가입 시 auth.users → profiles 자동 생성 트리거
-- signUp() 호출 시 options.data로 넘긴 username/name/grade_class/phone을
-- raw_user_meta_data에서 읽어 profiles에 그대로 복사합니다.
-- "이메일 확인" 설정(on/off)과 무관하게 가입 즉시 실행됩니다.
create or replace function public.handle_new_user()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  insert into public.profiles (id, username, name, grade_class, phone, email)
  values (
    new.id,
    new.raw_user_meta_data ->> 'username',
    new.raw_user_meta_data ->> 'name',
    new.raw_user_meta_data ->> 'grade_class',
    new.raw_user_meta_data ->> 'phone',
    new.email
  );
  return new;
end;
$$;

drop trigger if exists on_auth_user_created on auth.users;
create trigger on_auth_user_created
  after insert on auth.users
  for each row execute function public.handle_new_user();

-- 3) 로그인/아이디 찾기/비밀번호 찾기용 RPC
-- profiles 테이블 전체를 공개하지 않고, 꼭 필요한 값 하나만 반환합니다.

-- 아이디 → 로그인용 이메일 (signInWithPassword, resetPasswordForEmail에 사용)
create or replace function public.get_login_email(p_username text)
returns text
language sql
security definer
set search_path = public
as $$
  select email from public.profiles where username = p_username limit 1;
$$;

-- 이름 + 전화번호 → 아이디 (아이디 찾기)
create or replace function public.find_username(p_name text, p_phone text)
returns text
language sql
security definer
set search_path = public
as $$
  select username from public.profiles
  where name = p_name and phone = p_phone
  limit 1;
$$;

-- 아이디 중복 확인 (회원가입 폼에서 실시간 체크)
create or replace function public.username_exists(p_username text)
returns boolean
language sql
security definer
set search_path = public
as $$
  select exists(select 1 from public.profiles where username = p_username);
$$;

-- 로그인 전(익명) 상태에서도 호출 가능해야 하는 함수들
grant execute on function public.get_login_email(text) to anon, authenticated;
grant execute on function public.find_username(text, text) to anon, authenticated;
grant execute on function public.username_exists(text) to anon, authenticated;
