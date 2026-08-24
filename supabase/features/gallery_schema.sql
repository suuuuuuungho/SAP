-- SAP 1기 대시보드: Gallery 기능용 스키마 (기도/말씀 인증 공유 + 테스트 계정 8개)
-- Supabase 대시보드 → SQL Editor에서 전체를 한 번 실행하세요. (schema.sql 실행 이후에 실행)

create extension if not exists pgcrypto;

-- 1) Admin 페이지가 생기기 전까지의 임시 방편: 전원 기본 노출.
--    나중에 Admin 페이지에서 유저별로 이 값을 꺼서 Gallery 칸 생성을 제어하면 됩니다.
alter table public.profiles
  add column if not exists gallery_enabled boolean not null default true;

-- 2) 기도/말씀 인증 기록 (날짜당 1행, Home/Gallery 공용)
create table if not exists public.pray_records (
  user_id uuid not null references auth.users (id) on delete cascade,
  record_date date not null,
  entries jsonb not null default '[]'::jsonb, -- [{location, start, end, photoUnavailable, photoPath}]
  updated_at timestamptz not null default now(),
  primary key (user_id, record_date)
);

create table if not exists public.word_records (
  user_id uuid not null references auth.users (id) on delete cascade,
  record_date date not null,
  verses jsonb not null default '[]'::jsonb, -- [{startBook, startChapter, startVerse, endBook, endChapter, endVerse}]
  photo_path text,
  photo_unavailable boolean not null default false,
  updated_at timestamptz not null default now(),
  primary key (user_id, record_date)
);

create index if not exists pray_records_date_idx on public.pray_records (record_date);
create index if not exists word_records_date_idx on public.word_records (record_date);

alter table public.pray_records enable row level security;
alter table public.word_records enable row level security;

-- 본인 행은 전부 가능, 그 외에는 gallery_enabled=true인 유저 행만 조회 가능
drop policy if exists "pray_records_select" on public.pray_records;
create policy "pray_records_select"
  on public.pray_records for select
  using (
    user_id = auth.uid()
    or exists (select 1 from public.profiles p where p.id = pray_records.user_id and p.gallery_enabled = true)
  );

drop policy if exists "pray_records_write" on public.pray_records;
create policy "pray_records_write"
  on public.pray_records for all
  using (user_id = auth.uid())
  with check (user_id = auth.uid());

drop policy if exists "word_records_select" on public.word_records;
create policy "word_records_select"
  on public.word_records for select
  using (
    user_id = auth.uid()
    or exists (select 1 from public.profiles p where p.id = word_records.user_id and p.gallery_enabled = true)
  );

drop policy if exists "word_records_write" on public.word_records;
create policy "word_records_write"
  on public.word_records for all
  using (user_id = auth.uid())
  with check (user_id = auth.uid());

-- 3) Gallery에 보여줄 유저 목록 (id/username/name만 — phone/email은 노출하지 않음)
create or replace function public.get_gallery_users()
returns table (id uuid, username text, name text)
language sql
security definer
set search_path = public
as $$
  select id, username, name from public.profiles where gallery_enabled = true order by username;
$$;

grant execute on function public.get_gallery_users() to authenticated;

-- 4) 인증 사진 Storage 버킷 (public — getPublicUrl로 접근, 본인 폴더에만 쓰기 가능)
-- 버킷 이름이 'verification-photos-v2'인 이유: 최초 배포 때 'verification-photos'로 만들었다가
-- 원인 불명의 캐싱 문제로 RLS insert가 계속 막혀서 새 이름으로 다시 만들어 해결했습니다.
-- (storage.buckets 자체에도 select 정책이 없으면 클라이언트가 버킷을 아예 "못 찾아서" 같은 에러가 나니 꼭 필요합니다.)
insert into storage.buckets (id, name, public)
values ('verification-photos-v2', 'verification-photos-v2', true)
on conflict (id) do nothing;

drop policy if exists "verification_photos_v2_buckets_select" on storage.buckets;
create policy "verification_photos_v2_buckets_select"
  on storage.buckets for select
  using (id = 'verification-photos-v2');

-- 경로 규칙: pray/{user_id}/{date}/{n}-{random}.ext, word/{user_id}/{date}-{random}.ext
-- => (storage.foldername(name))[1] = 'pray' | 'word', [2] = user_id
drop policy if exists "verification_photos_v2_all_own" on storage.objects;
create policy "verification_photos_v2_all_own"
  on storage.objects for all to authenticated
  using (bucket_id = 'verification-photos-v2' and (storage.foldername(name))[2] = auth.uid()::text)
  with check (bucket_id = 'verification-photos-v2' and (storage.foldername(name))[2] = auth.uid()::text);

-- 5) 테스트 계정 8개 (signUp() API를 거치지 않고 auth.users/auth.identities에 직접 생성 —
--    signUp()은 이메일 발송 시도 중 rate limit에 걸린 이력이 있어 우회합니다.
--    handle_new_user() 트리거가 자동으로 profiles 행도 만들어줍니다.)
--    비밀번호는 전부 test1234 입니다.
do $$
declare
  test_users jsonb := '[
    {"username":"test01","name":"김민준","grade_class":"1-1반","phone":"010-0000-0001","email":"test01@example.com"},
    {"username":"test02","name":"이서연","grade_class":"1-2반","phone":"010-0000-0002","email":"test02@example.com"},
    {"username":"test03","name":"박도윤","grade_class":"2-1반","phone":"010-0000-0003","email":"test03@example.com"},
    {"username":"test04","name":"최지우","grade_class":"2-2반","phone":"010-0000-0004","email":"test04@example.com"},
    {"username":"test05","name":"정하은","grade_class":"3-1반","phone":"010-0000-0005","email":"test05@example.com"},
    {"username":"test06","name":"강시우","grade_class":"3-2반","phone":"010-0000-0006","email":"test06@example.com"},
    {"username":"test07","name":"윤서아","grade_class":"신입1반","phone":"010-0000-0007","email":"test07@example.com"},
    {"username":"test08","name":"임주원","grade_class":"신입2반","phone":"010-0000-0008","email":"test08@example.com"}
  ]'::jsonb;
  u jsonb;
  new_id uuid;
begin
  for u in select * from jsonb_array_elements(test_users)
  loop
    if exists (select 1 from public.profiles where username = u->>'username') then
      continue; -- 이미 만들어져 있으면 스킵 (재실행 안전)
    end if;

    new_id := gen_random_uuid();

    insert into auth.users (
      instance_id, id, aud, role, email, encrypted_password,
      email_confirmed_at, raw_app_meta_data, raw_user_meta_data,
      created_at, updated_at,
      confirmation_token, email_change, email_change_token_new, recovery_token
    ) values (
      '00000000-0000-0000-0000-000000000000',
      new_id, 'authenticated', 'authenticated', u->>'email',
      crypt('test1234', gen_salt('bf')),
      now(), '{"provider":"email","providers":["email"]}',
      jsonb_build_object('username', u->>'username', 'name', u->>'name', 'grade_class', u->>'grade_class', 'phone', u->>'phone'),
      now(), now(),
      '', '', '', ''
    );

    insert into auth.identities (
      id, user_id, provider_id, identity_data, provider, last_sign_in_at, created_at, updated_at
    ) values (
      gen_random_uuid(), new_id, new_id::text,
      jsonb_build_object('sub', new_id::text, 'email', u->>'email'),
      'email', now(), now(), now()
    );
  end loop;
end $$;

-- 6) 데모용 샘플 인증 기록 (일부는 인증완료, 일부는 미인증 상태로 남겨 Gallery에서 두 상태 다 보이게)
insert into public.pray_records (user_id, record_date, entries)
select id, current_date,
  '[{"location":"대성전","start":"07:00","end":"07:30","photoUnavailable":true,"photoPath":null}]'::jsonb
from public.profiles
where username in ('test01', 'test02', 'test04', 'test07')
on conflict (user_id, record_date) do nothing;

insert into public.word_records (user_id, record_date, verses, photo_path, photo_unavailable)
select id, current_date,
  '[{"startBook":"요한복음","startChapter":"3","startVerse":"16","endBook":"요한복음","endChapter":"3","endVerse":"18"}]'::jsonb,
  null, true
from public.profiles
where username in ('test01', 'test03', 'test04')
on conflict (user_id, record_date) do nothing;
-- test05/06/08은 기도/말씀 둘 다 미인증 상태로 남겨둡니다.
