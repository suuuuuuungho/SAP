-- 단어 시험(Word Exam) 스키마: 학생이 시험지 사진을 올리면 관리자가 점수를 매기고,
-- 그 점수를 Stat/Hall of Fame/개인 리포트에서 확인할 수 있게 한다.
-- Supabase Dashboard > SQL Editor에서 전체 실행하세요.
-- (admin_console_schema.sql, gallery_schema.sql 실행 이후에 실행 — is_app_admin(), profiles,
--  app_feature_flags, verification-photos-v2 버킷, student_report_links를 사용합니다.)

create table if not exists public.word_exam_submissions (
  user_id uuid not null references auth.users(id) on delete cascade,
  exam_date date not null,
  photo_path text not null,
  score numeric,
  max_score numeric not null default 100,
  status text not null default 'pending' check (status in ('pending', 'graded')),
  graded_by uuid references auth.users(id) on delete set null,
  graded_at timestamptz,
  -- 관리자가 학생 화면에 시험지 사진/점수를 공개할지 학생별로 직접 켜고 끈다. 기본값은 비공개 —
  -- 사진을 첨부하거나 채점만 해서는 바로 노출되지 않고, 관리자가 명시적으로 공개해야 보인다.
  visible_to_student boolean not null default false,
  updated_at timestamptz not null default now(),
  primary key (user_id, exam_date)
);

alter table public.word_exam_submissions add column if not exists visible_to_student boolean not null default false;

create index if not exists word_exam_submissions_date_idx on public.word_exam_submissions (exam_date);

alter table public.word_exam_submissions enable row level security;

-- 학생은 관리자가 visible_to_student를 켠 본인 행만 볼 수 있다(그전까지는 존재 자체가 안 보임 —
-- Study/Stat이 "아직 시험지가 등록되지 않았어요"로 표시). 관리자는 공개 여부와 무관하게 전부 본다.
drop policy if exists "word_exam_submissions_select" on public.word_exam_submissions;
create policy "word_exam_submissions_select"
  on public.word_exam_submissions for select
  using ((user_id = auth.uid() and visible_to_student = true) or public.is_app_admin(auth.uid()));

-- 학생은 채점 전(status='pending')까지만 본인 행을 쓰거나 지울 수 있다 — 사진 재업로드/삭제는
-- 허용하되 점수/상태는 절대 직접 못 건드리고(score는 항상 null이어야 통과), 채점이 끝나면
-- (status='graded') 더 이상 update/delete가 걸리지 않아 사진을 바꾸거나 지워서 점수와 어긋나는
-- 일을 막는다. 점수 기록은 아래 admin_grade_word_exam() 함수(security definer)로만 가능하다.
drop policy if exists "word_exam_submissions_insert_own" on public.word_exam_submissions;
create policy "word_exam_submissions_insert_own"
  on public.word_exam_submissions for insert
  with check (user_id = auth.uid() and status = 'pending' and score is null);

drop policy if exists "word_exam_submissions_update_own" on public.word_exam_submissions;
create policy "word_exam_submissions_update_own"
  on public.word_exam_submissions for update
  using (user_id = auth.uid() and status = 'pending')
  with check (user_id = auth.uid() and status = 'pending' and score is null);

drop policy if exists "word_exam_submissions_delete_own" on public.word_exam_submissions;
create policy "word_exam_submissions_delete_own"
  on public.word_exam_submissions for delete
  using (user_id = auth.uid() and status = 'pending');

drop policy if exists "word_exam_submissions_admin_all" on public.word_exam_submissions;
create policy "word_exam_submissions_admin_all"
  on public.word_exam_submissions for all
  using (public.is_app_admin(auth.uid()))
  with check (public.is_app_admin(auth.uid()));

-- storage 버킷은 gallery_schema.sql에서 만든 'verification-photos-v2'를 그대로 재사용한다.
-- 이제는 학생이 아니라 관리자가 시험지 사진을 학생 폴더(wordexam/{student_id}/...)에 올리므로,
-- 기존 "본인 폴더만" 정책(verification_photos_v2_all_own)만으로는 관리자 쓰기가 막힌다.
-- 이 버킷에 한해 관리자에게 폴더 제한 없이 읽기/쓰기/삭제를 허용하는 정책을 추가한다.
drop policy if exists "verification_photos_v2_admin_all" on storage.objects;
create policy "verification_photos_v2_admin_all"
  on storage.objects for all to authenticated
  using (bucket_id = 'verification-photos-v2' and public.is_app_admin(auth.uid()))
  with check (bucket_id = 'verification-photos-v2' and public.is_app_admin(auth.uid()));

-- Hall of Fame용 Top 5 랭킹 (채점 완료된 시험만 합산) — 점수는 순위 계산에만 쓰고 클라이언트에는
-- 절대 내려주지 않는다. 노출은 이름/아이디/학년반까지만.
drop function if exists public.get_word_exam_rankings();
create or replace function public.get_word_exam_rankings()
returns table (
  rank_no bigint, user_id uuid, username text, name text, grade_class text
)
language sql stable security definer set search_path = public
as $$
  with totals as (
    select s.user_id, sum(s.score) as total_score, count(*) as exam_count
    from public.word_exam_submissions s
    where s.status = 'graded' and s.visible_to_student = true
    group by s.user_id
  ),
  ranked as (
    -- dense_rank: 총점·응시횟수가 완전히 같으면 공동 순위를 매기고(예: 공동 3등),
    -- 그다음 사람은 등수를 건너뛰지 않고 바로 다음 순번(4등)을 받는다.
    select t.*, dense_rank() over (order by t.total_score desc, t.exam_count desc) as rank_no
    from totals t
  )
  -- rank_no <= 5로 거르면 5등 동점자가 여럿일 때 5명보다 많이 나올 수 있어,
  -- 등수는 전체 인원 기준으로 정확히 매기되(동점 순위 유지) 표시 인원만 5명으로 자른다.
  select r.rank_no, r.user_id, p.username, p.name, p.grade_class
  from ranked r
  join public.profiles p on p.id = r.user_id
  order by r.rank_no
  limit 5;
$$;
grant execute on function public.get_word_exam_rankings() to authenticated;

-- Admin: 특정 시험 날짜의 전체 학생 제출 현황(미제출 포함) 조회.
-- 반환 컬럼(visible_to_student 추가)이 바뀌어 create or replace만으로는 안 되므로 먼저 drop한다.
drop function if exists public.admin_get_word_exam_submissions(date);
create or replace function public.admin_get_word_exam_submissions(target_exam_date date)
returns table (
  user_id uuid, username text, name text, grade_class text,
  photo_path text, score numeric, max_score numeric, status text,
  visible_to_student boolean, updated_at timestamptz
)
language plpgsql stable security definer set search_path = public
as $$
begin
  if not public.is_app_admin(auth.uid()) then raise exception 'admin access required'; end if;
  return query
    select p.id, p.username, p.name, p.grade_class,
      s.photo_path, s.score, s.max_score, coalesce(s.status, 'none'),
      coalesce(s.visible_to_student, false), s.updated_at
    from public.profiles p
    left join public.word_exam_submissions s on s.user_id = p.id and s.exam_date = target_exam_date
    where p.app_role = 'student' and p.is_active = true
    order by p.grade_class, p.name, p.username;
end; $$;
grant execute on function public.admin_get_word_exam_submissions(date) to authenticated;

-- Admin: 채점 저장 (제출된 행에만 적용 가능, 0~max_score 범위만 허용).
create or replace function public.admin_grade_word_exam(
  target_user_id uuid, target_exam_date date, new_score numeric, new_max_score numeric default 100
)
returns void language plpgsql security definer set search_path = public
as $$
begin
  if not public.is_app_admin(auth.uid()) then raise exception 'admin access required'; end if;
  if new_score is null or new_score < 0 or new_max_score is null or new_max_score <= 0 or new_score > new_max_score then
    raise exception 'invalid score';
  end if;
  update public.word_exam_submissions
    set score = new_score, max_score = new_max_score, status = 'graded',
        graded_by = auth.uid(), graded_at = now(), updated_at = now()
  where user_id = target_user_id and exam_date = target_exam_date;
  if not found then raise exception 'submission not found'; end if;
end; $$;
grant execute on function public.admin_grade_word_exam(uuid, date, numeric, numeric) to authenticated;

-- Control Panel 토글: Study 탭의 '단어 시험' 전체(제출/확인), Hall of Fame의 '단어 시험 랭킹' 카드.
insert into public.app_feature_flags (feature_key, label, section) values
  ('word_exam', 'Word Exam', 'Private'),
  ('hall_of_fame_word_exam', 'Word Exam Ranking', 'Public')
on conflict (feature_key) do update set label = excluded.label, section = excluded.section;

-- 개인 리포트(get_shared_student_report)에 시험 점수 포함 — admin_console_schema.sql의 정의에
-- exam_posts CTE와 examPosts 필드만 추가한 전체 재정의본이다.
create or replace function public.get_shared_student_report(report_token uuid)
returns jsonb
language sql stable security definer set search_path = public
as $$
with valid_link as (
  select l.student_id from public.student_report_links l
  where l.token=report_token and l.revoked_at is null and l.expires_at>now()
), student as (
  select p.id,p.name,p.username,p.grade_class from public.profiles p join valid_link l on l.student_id=p.id
), days as (
  select d::date record_date from generate_series(date '2026-08-10',date '2026-09-06','1 day') d
  where extract(isodow from d) between 1 and 5
), daily as (
  select d.record_date,
    coalesce((select sum(greatest(0,extract(epoch from ((e->>'end')::timestamp-(e->>'start')::timestamp))/60))::bigint
      from public.pray_records r cross join lateral jsonb_array_elements(r.entries)e
      where r.user_id=s.id and r.record_date=d.record_date and e->>'start' ~ '^[0-9]{4}-' and e->>'end' ~ '^[0-9]{4}-'),0) pray_minutes,
    case when coalesce(jsonb_array_length(wo.verses),0)>0 then 60 + coalesce((select sum(coalesce(nullif(v->>'meditationMinutes','')::numeric,0))::bigint from jsonb_array_elements(wo.verses) with ordinality x(v,n) where n>1),0) else 0 end word_minutes,
    coalesce((select round(sum(coalesce(nullif(x->>'seconds','')::numeric,0))/60)::bigint from jsonb_array_elements(coalesce(st.sessions,'[]'::jsonb))x),0) study_minutes,
    coalesce(wr.minutes,0)::bigint worship_minutes,
    wr.status worship_status
  from days d cross join student s
  left join public.word_records wo on wo.user_id=s.id and wo.record_date=d.record_date
  left join public.study_records st on st.user_id=s.id and st.record_date=d.record_date
  left join public.worship_records wr on wr.user_id=s.id and wr.record_date=d.record_date
), pray_posts as (
  select coalesce(jsonb_agg(jsonb_build_object('date',r.record_date,'entries',r.entries) order by r.record_date),'[]'::jsonb) value
  from public.pray_records r join student s on s.id=r.user_id where jsonb_array_length(r.entries)>0
), word_posts as (
  select coalesce(jsonb_agg(jsonb_build_object('date',r.record_date,'verses',r.verses,'photoPath',r.photo_path,'photoUnavailable',r.photo_unavailable) order by r.record_date),'[]'::jsonb) value
  from public.word_records r join student s on s.id=r.user_id where jsonb_array_length(r.verses)>0
), exam_posts as (
  select coalesce(jsonb_agg(jsonb_build_object('date',e.exam_date,'photoPath',e.photo_path,'score',e.score,'maxScore',e.max_score,'status',e.status) order by e.exam_date),'[]'::jsonb) value
  from public.word_exam_submissions e join student s on s.id=e.user_id where e.visible_to_student = true
)
select case when not exists(select 1 from student) then null else jsonb_build_object(
  'student',(select jsonb_build_object('name',name,'username',username,'gradeClass',grade_class) from student),
  'days',(select coalesce(jsonb_agg(to_jsonb(daily) order by record_date),'[]'::jsonb) from daily),
  'prayPosts',(select value from pray_posts),
  'wordPosts',(select value from word_posts),
  'examPosts',(select value from exam_posts),
  'generatedAt',now()
) end;
$$;
grant execute on function public.get_shared_student_report(uuid) to anon, authenticated;
