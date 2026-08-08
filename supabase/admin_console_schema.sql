-- SAP Admin Console 스키마
-- Supabase Dashboard > SQL Editor에서 전체 실행하세요.
-- home_admin_schema.sql, central_storage_schema.sql, gallery_schema.sql 실행 이후 사용합니다.

alter table public.profiles
  add column if not exists app_role text not null default 'student',
  add column if not exists is_host boolean not null default false,
  add column if not exists is_active boolean not null default true,
  add column if not exists parent_phone text;

alter table public.profiles drop constraint if exists profiles_app_role_check;
alter table public.profiles add constraint profiles_app_role_check
  check (app_role in ('student', 'teacher', 'admin'));

update public.profiles
set app_role = case
  when is_admin = true or grade_class = '관리자' then 'admin'
  when grade_class = '교사' then 'teacher'
  else 'student'
end;

create table if not exists public.app_feature_flags (
  feature_key text primary key,
  label text not null,
  section text not null,
  is_enabled boolean not null default true,
  updated_by uuid references auth.users(id) on delete set null,
  updated_at timestamptz not null default now()
);

insert into public.app_feature_flags (feature_key, label, section) values
  ('board', 'Board', 'Public'), ('board_messages', 'Board Messages', 'Public'),
  ('board_verse', 'Bible Verse', 'Public'), ('ranking', 'Ranking', 'Public'),
  ('gallery', 'Gallery', 'Public'), ('gallery_pray', 'Prayer Gallery', 'Public'),
  ('gallery_word', 'Word Gallery', 'Public'), ('comments', 'Comments', 'Public'),
  ('mypage', 'MyPage', 'Private'), ('pray', 'Prayer Verification', 'Private'),
  ('word', 'Word Verification', 'Private'), ('study_timer', 'Study Timer', 'Private'),
  ('worship', 'Worship Verification', 'Private'), ('study', 'Study', 'Private'),
  ('study_vocab', 'Vocabulary Learning', 'Private'),
  ('stat', 'Stat', 'Private'), ('profile_photo', 'Profile Photo', 'Account'),
  ('stat_summary', 'Summary', 'Private'), ('stat_heatmap', 'Heatmap', 'Private'),
  ('stat_trend', 'Trend', 'Private'), ('stat_balance', 'Balance', 'Private'),
  ('stat_breakdown', 'Time Breakdown', 'Private'), ('stat_bests', 'Personal Bests', 'Private'),
  ('signup', 'Sign Up', 'Account'), ('password_reset', 'Password Reset', 'Account')
on conflict (feature_key) do update set label = excluded.label, section = excluded.section;

alter table public.app_feature_flags enable row level security;
drop policy if exists "feature_flags_read" on public.app_feature_flags;
create policy "feature_flags_read" on public.app_feature_flags for select to authenticated using (true);
drop policy if exists "feature_flags_admin_write" on public.app_feature_flags;
create policy "feature_flags_admin_write" on public.app_feature_flags for all to authenticated
  using (public.is_app_admin(auth.uid())) with check (public.is_app_admin(auth.uid()));

alter table public.pray_records add column if not exists admin_hidden boolean not null default false;
alter table public.word_records add column if not exists admin_hidden boolean not null default false;

create or replace function public.get_app_feature_flags()
returns table (feature_key text, is_enabled boolean)
language sql stable security definer set search_path = public
as $$ select f.feature_key, f.is_enabled from public.app_feature_flags f order by f.feature_key; $$;
grant execute on function public.get_app_feature_flags() to anon, authenticated;

create or replace function public.admin_get_members()
returns table (
  id uuid, username text, name text, grade_class text, phone text, email text,
  parent_phone text, app_role text, is_host boolean, is_active boolean,
  avatar_path text, created_at timestamptz
)
language plpgsql security definer set search_path = public
as $$
begin
  if not public.is_app_admin(auth.uid()) then raise exception 'admin access required'; end if;
  return query select p.id, p.username, p.name, p.grade_class, p.phone, p.email,
    p.parent_phone, p.app_role, p.is_host, p.is_active, p.avatar_path, p.created_at
  from public.profiles p order by p.is_host desc, p.app_role, p.name, p.username;
end; $$;
grant execute on function public.admin_get_members() to authenticated;

create or replace function public.admin_update_member(
  target_user_id uuid, new_name text, new_grade_class text, new_phone text,
  new_parent_phone text, new_role text, new_is_host boolean, new_is_active boolean
)
returns void language plpgsql security definer set search_path = public
as $$
begin
  if not public.is_app_admin(auth.uid()) then raise exception 'admin access required'; end if;
  if new_role not in ('student','teacher','admin') then raise exception 'invalid role'; end if;
  update public.profiles set
    name = trim(new_name), grade_class = new_grade_class, phone = coalesce(new_phone, ''),
    parent_phone = nullif(regexp_replace(coalesce(new_parent_phone,''), '[^0-9]', '', 'g'), ''),
    app_role = new_role, is_admin = (new_role = 'admin'), is_host = new_is_host,
    is_active = new_is_active
  where id = target_user_id;
end; $$;
grant execute on function public.admin_update_member(uuid,text,text,text,text,text,boolean,boolean) to authenticated;

create or replace function public.admin_delete_member(target_user_id uuid)
returns void language plpgsql security definer set search_path = public
as $$
begin
  if not public.is_app_admin(auth.uid()) then raise exception 'admin access required'; end if;
  if target_user_id = auth.uid() then raise exception 'cannot delete current admin'; end if;
  delete from auth.users where id = target_user_id;
end; $$;
grant execute on function public.admin_delete_member(uuid) to authenticated;

create or replace function public.admin_set_gallery_post(
  owner_id uuid, post_date date, post_type text, action text
)
returns void language plpgsql security definer set search_path = public
as $$
begin
  if not public.is_app_admin(auth.uid()) then raise exception 'admin access required'; end if;
  if post_type = 'pray' then
    if action = 'delete' then delete from public.pray_records where user_id=owner_id and record_date=post_date;
    else update public.pray_records set admin_hidden=(action='hide') where user_id=owner_id and record_date=post_date; end if;
  elsif post_type = 'word' then
    if action = 'delete' then delete from public.word_records where user_id=owner_id and record_date=post_date;
    else update public.word_records set admin_hidden=(action='hide') where user_id=owner_id and record_date=post_date; end if;
  else raise exception 'invalid post type'; end if;
end; $$;
grant execute on function public.admin_set_gallery_post(uuid,date,text,text) to authenticated;

create or replace function public.admin_update_gallery_post(
  owner_id uuid, post_date date, post_type text, new_content jsonb
)
returns void language plpgsql security definer set search_path = public
as $$
begin
  if not public.is_app_admin(auth.uid()) then raise exception 'admin access required'; end if;
  if jsonb_typeof(new_content) <> 'array' or jsonb_array_length(new_content) < 1 then
    raise exception 'content must be a non-empty array';
  end if;
  if post_type = 'pray' then
    update public.pray_records set entries = new_content, updated_at = now()
      where user_id = owner_id and record_date = post_date;
  elsif post_type = 'word' then
    update public.word_records set verses = new_content, updated_at = now()
      where user_id = owner_id and record_date = post_date;
  else
    raise exception 'invalid post type';
  end if;
end; $$;
grant execute on function public.admin_update_gallery_post(uuid,date,text,jsonb) to authenticated;

create or replace function public.admin_get_gallery_records(target_date date)
returns table (
  post_type text, user_id uuid, record_date date, content jsonb,
  photo_path text, photo_unavailable boolean, admin_hidden boolean
)
language plpgsql stable security definer set search_path = public
as $$
begin
  if not public.is_app_admin(auth.uid()) then raise exception 'admin access required'; end if;
  return query
    select 'pray'::text, r.user_id, r.record_date, r.entries,
      null::text, false, r.admin_hidden
    from public.pray_records r where r.record_date = target_date
    union all
    select 'word'::text, r.user_id, r.record_date, r.verses,
      r.photo_path, r.photo_unavailable, r.admin_hidden
    from public.word_records r where r.record_date = target_date;
end; $$;
grant execute on function public.admin_get_gallery_records(date) to authenticated;

create or replace function public.admin_get_post_comments(target_owner_id uuid, target_post_date date, target_post_type text)
returns table (id uuid, post_owner_id uuid, post_date date, post_type text, author_id uuid, body text, created_at timestamptz)
language plpgsql stable security definer set search_path = public
as $$
begin
  if not public.is_app_admin(auth.uid()) then raise exception 'admin access required'; end if;
  return query select c.id, c.post_owner_id, c.post_date, c.post_type, c.author_id, c.body, c.created_at
  from public.post_comments c
  where c.post_owner_id = target_owner_id and c.post_date = target_post_date and c.post_type = target_post_type
  order by c.created_at;
end; $$;
grant execute on function public.admin_get_post_comments(uuid,date,text) to authenticated;

create or replace function public.admin_delete_post_comment(comment_id uuid)
returns void language plpgsql security definer set search_path = public
as $$
begin
  if not public.is_app_admin(auth.uid()) then raise exception 'admin access required'; end if;
  delete from public.post_comments c where c.id = comment_id;
end; $$;
grant execute on function public.admin_delete_post_comment(uuid) to authenticated;

create or replace function public.admin_add_post_comment(
  target_owner_id uuid, target_post_date date, target_post_type text, comment_body text
)
returns uuid language plpgsql security definer set search_path = public
as $$
declare new_id uuid;
begin
  if not public.is_app_admin(auth.uid()) then raise exception 'admin access required'; end if;
  if target_post_type not in ('pray','word') or char_length(trim(comment_body)) not between 1 and 300 then
    raise exception 'invalid comment';
  end if;
  insert into public.post_comments (post_owner_id, post_date, post_type, author_id, body)
  values (target_owner_id, target_post_date, target_post_type, auth.uid(), trim(comment_body))
  returning id into new_id;
  return new_id;
end; $$;
grant execute on function public.admin_add_post_comment(uuid,date,text,text) to authenticated;

create or replace function public.admin_delete_gallery_photo(
  owner_id uuid, post_date date, post_type text, target_photo_path text
)
returns void language plpgsql security definer set search_path = public
as $$
begin
  if not public.is_app_admin(auth.uid()) then raise exception 'admin access required'; end if;
  if post_type = 'pray' then
    update public.pray_records r set entries = (
      select coalesce(jsonb_agg(
        case when item->>'photoPath' = target_photo_path
          then jsonb_set(jsonb_set(item, '{photoPath}', 'null'::jsonb), '{photoUnavailable}', 'true'::jsonb)
          else item end
      ), '[]'::jsonb) from jsonb_array_elements(r.entries) item
    ), updated_at = now()
    where r.user_id = owner_id and r.record_date = post_date;
  elsif post_type = 'word' then
    update public.word_records r set photo_path = null, photo_unavailable = true, updated_at = now()
    where r.user_id = owner_id and r.record_date = post_date and r.photo_path = target_photo_path;
  else raise exception 'invalid post type'; end if;
end; $$;
grant execute on function public.admin_delete_gallery_photo(uuid,date,text,text) to authenticated;

drop function if exists public.admin_get_dashboard(date);
create or replace function public.admin_get_dashboard(target_date date)
returns table (
  user_id uuid, username text, name text, grade_class text, phone text, parent_phone text,
  pray_done boolean, pray_minutes bigint, word_done boolean, word_minutes bigint,
  study_done boolean, study_minutes bigint, worship_done boolean, worship_minutes bigint
)
language sql stable security definer set search_path = public
as $$
  select p.id, p.username, p.name, p.grade_class, p.phone, p.parent_phone,
    coalesce(jsonb_array_length(pr.entries)>0,false),
    coalesce((select sum(greatest(0,extract(epoch from ((e->>'end')::timestamp-(e->>'start')::timestamp))/60))::bigint
      from jsonb_array_elements(coalesce(pr.entries,'[]'::jsonb)) e
      where e->>'start' ~ '^\\d{4}-' and e->>'end' ~ '^\\d{4}-'),0),
    coalesce(jsonb_array_length(wo.verses)>0,false),
    case when coalesce(jsonb_array_length(wo.verses),0)>0 then 60 + coalesce((select sum(coalesce(nullif(v->>'meditationMinutes','')::numeric,0))::bigint from jsonb_array_elements(wo.verses) with ordinality x(v,n) where n>1),0) else 0 end,
    coalesce(jsonb_array_length(st.sessions)>0,false),
    coalesce((select round(sum(coalesce(nullif(s->>'seconds','')::numeric,0))/60)::bigint from jsonb_array_elements(coalesce(st.sessions,'[]'::jsonb)) s),0),
    case when extract(isodow from target_date) in (3,5) then coalesce(wr.status in ('attended','home'),false) else true end,
    coalesce(wr.minutes,0)::bigint
  from public.profiles p
  left join public.pray_records pr on pr.user_id=p.id and pr.record_date=target_date
  left join public.word_records wo on wo.user_id=p.id and wo.record_date=target_date
  left join public.study_records st on st.user_id=p.id and st.record_date=target_date
  left join public.worship_records wr on wr.user_id=p.id and wr.record_date=target_date
  where public.is_app_admin(auth.uid()) and p.app_role='student' and p.is_active=true
  order by p.name, p.username;
$$;
grant execute on function public.admin_get_dashboard(date) to authenticated;

create or replace function public.admin_get_member_report(target_user_id uuid)
returns table (record_date date, pray_minutes bigint, word_minutes bigint, study_minutes bigint, worship_minutes bigint)
language sql stable security definer set search_path = public
as $$
with days as (select d::date record_date from generate_series(date '2026-08-10',date '2026-09-06','1 day') d where extract(isodow from d) between 1 and 5)
select d.record_date,
  coalesce((select sum(greatest(0,extract(epoch from ((e->>'end')::timestamp-(e->>'start')::timestamp))/60))::bigint from public.pray_records r cross join lateral jsonb_array_elements(r.entries)e where r.user_id=target_user_id and r.record_date=d.record_date and e->>'start' ~ '^\\d{4}-' and e->>'end' ~ '^\\d{4}-'),0),
  case when exists(select 1 from public.word_records r where r.user_id=target_user_id and r.record_date=d.record_date and jsonb_array_length(r.verses)>0) then 60 else 0 end,
  coalesce((select round(sum(coalesce(nullif(s->>'seconds','')::numeric,0))/60)::bigint from public.study_records r cross join lateral jsonb_array_elements(r.sessions)s where r.user_id=target_user_id and r.record_date=d.record_date),0),
  coalesce((select r.minutes::bigint from public.worship_records r where r.user_id=target_user_id and r.record_date=d.record_date),0)
from days d where public.is_app_admin(auth.uid()) order by d.record_date;
$$;
grant execute on function public.admin_get_member_report(uuid) to authenticated;

-- 공개 프로필 뱃지 함수는 host 왕관과 역할을 함께 표시할 수 있도록 role 값을 반환합니다.
drop function if exists public.get_public_profile_cards(uuid[]);
create function public.get_public_profile_cards(requested_user_ids uuid[])
returns table (user_id uuid, username text, name text, avatar_path text, badge_role text, is_host boolean)
language sql stable security definer set search_path = public
as $$
select p.id,p.username,p.name,p.avatar_path,
  case when p.app_role='admin' or p.is_admin then 'admin' when p.app_role='teacher' or p.grade_class='교사' then 'teacher' else null end,
  p.is_host
from public.profiles p where p.id=any(coalesce(requested_user_ids,array[]::uuid[])) and p.is_active=true;
$$;
grant execute on function public.get_public_profile_cards(uuid[]) to authenticated;
