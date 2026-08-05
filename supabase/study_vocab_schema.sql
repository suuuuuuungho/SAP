-- SAP 1기 대시보드: Study 탭(영단어 학습) 스키마.
-- Supabase 대시보드 → SQL Editor에서 전체를 한 번 실행하세요. (schema.sql 실행 이후에 실행)
--
-- 단어 배치 추가 절차 (매 배치마다 반복):
--   1. 운영자가 채팅에서 Claude Code에게 (영단어, 뜻) 쌍의 목록을 준다.
--   2. Claude가 각 단어의 품사와 중학교 내신 기출 스타일 예문 3개(영/한)를 생성한다.
--   3. Claude가 결과를 study_day/sort_order가 채워진 새 insert 블록으로 작성한다.
--   4. 운영자가 Supabase SQL Editor에서 그 SQL을 수동으로 실행한다.
-- 이 프로젝트의 다른 모든 테이블과 동일한 방식이며, 이 앱에는 admin UI가 전혀 없다.
-- (성경구절 관련 컬럼은 이번 범위에서 의도적으로 제외 — 나중에 alter table로 추가 예정.)

create extension if not exists pgcrypto;

-- 1) 단어 콘텐츠 테이블 — 운영자가 SQL Editor에서 직접 INSERT하는 큐레이션 콘텐츠.
--    클라이언트에서 쓰기(insert/update/delete)할 방법이 없으므로 select 정책만 둔다.
create table if not exists public.vocab_words (
  id uuid primary key default gen_random_uuid(),
  word text not null,
  meaning text not null,               -- 뜻 (운영자 제공)
  part_of_speech text not null,        -- 품사 (Claude 생성, 예: '동사', '명사')
  example_sentences jsonb not null default '[]'::jsonb,
    -- 정확히 3개: [{"en": "...", "ko": "..."}, ...] — 중학교 내신 기출 스타일 예문 (Claude 생성)
  study_day integer not null,          -- Day 1, 2, 3 ... (Stat 탭의 20 평일 운영기간과 개념적으로 정렬)
  sort_order integer not null default 0, -- 같은 study_day 내 표시 순서
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create index if not exists vocab_words_day_idx on public.vocab_words (study_day, sort_order);

alter table public.vocab_words enable row level security;

drop policy if exists "vocab_words_select_authenticated" on public.vocab_words;
create policy "vocab_words_select_authenticated"
  on public.vocab_words for select
  to authenticated
  using (true);
-- insert/update/delete 정책 없음 — 콘텐츠는 운영자가 Supabase SQL Editor에서만 관리.

-- 2) 학습 진행도 테이블 — 학생별/단어별 "학습 완료" 여부. pray_records 등과 동일한 소유자-전용 RLS.
create table if not exists public.vocab_progress (
  user_id uuid not null references auth.users (id) on delete cascade,
  word_id uuid not null references public.vocab_words (id) on delete cascade,
  learned boolean not null default false,
  correct_count integer not null default 0,   -- 퀴즈 정답 누적 횟수 (향후 Stat 탭 연동 여지)
  incorrect_count integer not null default 0, -- 퀴즈 오답 누적 횟수
  learned_at timestamptz,                     -- 처음 학습완료로 표시된 시각
  updated_at timestamptz not null default now(),
  primary key (user_id, word_id)
);

create index if not exists vocab_progress_user_idx on public.vocab_progress (user_id);

alter table public.vocab_progress enable row level security;

drop policy if exists "vocab_progress_own" on public.vocab_progress;
create policy "vocab_progress_own"
  on public.vocab_progress for all
  using (user_id = auth.uid())
  with check (user_id = auth.uid());

-- 3) 플레이스홀더 샘플 단어 (Day 1: 5개=정상 케이스, Day 2: 4개=정상 경계,
--    Day 3: 2개=퀴즈 선택지가 4개 미만으로 줄어드는 케이스, Day 4: 1개=퀴즈 자체가
--    비활성화되는 케이스 — 검증 체크리스트의 두 예외 케이스를 실제로 확인하기 위한 용도).
--    ⚠️ 실제 콘텐츠 아님 — 검증용 더미 데이터. 실제 단어 배치는 운영자가 (단어,뜻)을 주면
--    별도 SQL 파일로 추가한다.
insert into public.vocab_words (word, meaning, part_of_speech, example_sentences, study_day, sort_order)
values
  ('apple', '사과', '명사',
   '[{"en":"She ate a red apple for breakfast.","ko":"그녀는 아침으로 빨간 사과를 먹었다."},
     {"en":"There is an apple tree in the garden.","ko":"정원에 사과나무가 한 그루 있다."},
     {"en":"He picked an apple from the basket.","ko":"그는 바구니에서 사과 하나를 집었다."}]'::jsonb,
   1, 1),
  ('run', '달리다', '동사',
   '[{"en":"I run every morning before school.","ko":"나는 학교 가기 전에 매일 아침 달린다."},
     {"en":"She ran to catch the bus.","ko":"그녀는 버스를 타려고 뛰었다."},
     {"en":"They run fast during P.E. class.","ko":"그들은 체육 시간에 빠르게 달린다."}]'::jsonb,
   1, 2),
  ('happy', '행복한', '형용사',
   '[{"en":"He looks happy today.","ko":"그는 오늘 행복해 보인다."},
     {"en":"We were happy to see our friends.","ko":"우리는 친구들을 만나서 행복했다."},
     {"en":"A happy family lives next door.","ko":"행복한 가족이 옆집에 산다."}]'::jsonb,
   1, 3),
  ('quickly', '빠르게', '부사',
   '[{"en":"She finished her homework quickly.","ko":"그녀는 숙제를 빠르게 끝냈다."},
     {"en":"He quickly answered the question.","ko":"그는 질문에 빠르게 대답했다."},
     {"en":"The bus arrived quickly.","ko":"버스가 빠르게 도착했다."}]'::jsonb,
   1, 4),
  ('friend', '친구', '명사',
   '[{"en":"She is my best friend.","ko":"그녀는 나의 가장 친한 친구이다."},
     {"en":"I made a new friend at school.","ko":"나는 학교에서 새 친구를 사귀었다."},
     {"en":"A good friend always listens.","ko":"좋은 친구는 항상 귀 기울여 들어준다."}]'::jsonb,
   1, 5),
  ('decide', '결정하다', '동사',
   '[{"en":"We need to decide soon.","ko":"우리는 곧 결정해야 한다."},
     {"en":"She decided to study science.","ko":"그녀는 과학을 공부하기로 결정했다."},
     {"en":"He couldn''t decide what to eat.","ko":"그는 무엇을 먹을지 결정하지 못했다."}]'::jsonb,
   2, 1),
  ('important', '중요한', '형용사',
   '[{"en":"Education is very important.","ko":"교육은 매우 중요하다."},
     {"en":"This is an important test.","ko":"이것은 중요한 시험이다."},
     {"en":"It is important to be honest.","ko":"정직한 것은 중요하다."}]'::jsonb,
   2, 2),
  ('however', '그러나', '접속사/부사',
   '[{"en":"He studied hard; however, he failed.","ko":"그는 열심히 공부했다. 그러나 그는 실패했다."},
     {"en":"I like tea. However, I prefer coffee.","ko":"나는 차를 좋아한다. 그러나 나는 커피를 더 좋아한다."},
     {"en":"However, the weather was bad.","ko":"그러나 날씨가 나빴다."}]'::jsonb,
   2, 3),
  ('explain', '설명하다', '동사',
   '[{"en":"Can you explain this problem?","ko":"이 문제를 설명해 줄 수 있니?"},
     {"en":"The teacher explained the rule clearly.","ko":"선생님은 규칙을 명확하게 설명했다."},
     {"en":"She explained why she was late.","ko":"그녀는 왜 늦었는지 설명했다."}]'::jsonb,
   2, 4),
  ('curious', '궁금한, 호기심 많은', '형용사',
   '[{"en":"He is curious about space.","ko":"그는 우주에 대해 궁금해한다."},
     {"en":"The curious cat looked into the box.","ko":"호기심 많은 고양이가 상자 안을 들여다보았다."},
     {"en":"I am curious about the result.","ko":"나는 결과가 궁금하다."}]'::jsonb,
   3, 1),
  ('brave', '용감한', '형용사',
   '[{"en":"The brave firefighter saved the cat.","ko":"용감한 소방관이 고양이를 구했다."},
     {"en":"She was brave enough to speak first.","ko":"그녀는 먼저 말할 만큼 용감했다."},
     {"en":"It takes a brave heart to admit a mistake.","ko":"실수를 인정하려면 용감한 마음이 필요하다."}]'::jsonb,
   3, 2),
  ('gentle', '온화한, 부드러운', '형용사',
   '[{"en":"She has a gentle voice.","ko":"그녀는 목소리가 부드럽다."},
     {"en":"He gave the dog a gentle pat.","ko":"그는 개를 부드럽게 쓰다듬었다."},
     {"en":"A gentle breeze blew through the window.","ko":"부드러운 바람이 창문으로 불어왔다."}]'::jsonb,
   4, 1)
on conflict do nothing;
