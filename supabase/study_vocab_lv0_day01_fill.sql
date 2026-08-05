-- SAP 1기 대시보드: Study 탭 — Lv.0(중등 BASIC) Day 01 품사/예문 채우기 (파일럿 배치, 20단어).
-- Supabase 대시보드 → SQL Editor에서 실행하세요.
-- 스타일 확인용 첫 배치 — 이 톤이 괜찮으면 나머지 레벨/Day도 같은 방식으로 이어서 채운다.

update public.vocab_words v
set part_of_speech = t.pos, example_sentences = t.examples, updated_at = now()
from (values
  ('name', 0, 1, '명사', '[
    {"en":"What is your name?","ko":"네 이름이 뭐니?"},
    {"en":"Please write your name on the paper.","ko":"종이에 이름을 써 주세요."},
    {"en":"My name is Mina.","ko":"제 이름은 미나입니다."}
  ]'::jsonb),
  ('boy', 0, 1, '명사', '[
    {"en":"The boy is playing soccer in the park.","ko":"그 소년은 공원에서 축구를 하고 있다."},
    {"en":"A young boy waved at us.","ko":"어린 소년이 우리에게 손을 흔들었다."},
    {"en":"He was a shy boy when he was little.","ko":"그는 어릴 때 수줍은 소년이었다."}
  ]'::jsonb),
  ('girl', 0, 1, '명사', '[
    {"en":"The girl is reading a book by the window.","ko":"그 소녀는 창가에서 책을 읽고 있다."},
    {"en":"A little girl smiled at me.","ko":"어린 소녀가 나에게 미소지었다."},
    {"en":"She was the tallest girl in her class.","ko":"그녀는 반에서 가장 키가 큰 여자아이였다."}
  ]'::jsonb),
  ('baby', 0, 1, '명사', '[
    {"en":"The baby is sleeping in the crib.","ko":"아기가 요람에서 자고 있다."},
    {"en":"My sister just had a baby.","ko":"내 여동생이 막 아기를 낳았다."},
    {"en":"The baby smiled at her mother.","ko":"아기가 엄마를 보고 미소지었다."}
  ]'::jsonb),
  ('man', 0, 1, '명사', '[
    {"en":"The man is walking his dog.","ko":"그 남자는 개를 산책시키고 있다."},
    {"en":"An old man was sitting on the bench.","ko":"한 노인이 벤치에 앉아 있었다."},
    {"en":"He grew up to be a kind man.","ko":"그는 자라서 친절한 남자가 되었다."}
  ]'::jsonb),
  ('woman', 0, 1, '명사', '[
    {"en":"The woman is a famous scientist.","ko":"그 여자는 유명한 과학자이다."},
    {"en":"A young woman helped the old man cross the street.","ko":"한 젊은 여성이 노인이 길을 건너도록 도와주었다."},
    {"en":"She became a strong woman after the experience.","ko":"그녀는 그 경험 후 강한 여성이 되었다."}
  ]'::jsonb),
  ('age', 0, 1, '명사', '[
    {"en":"What is your age?","ko":"나이가 어떻게 되세요?"},
    {"en":"People of all ages enjoyed the festival.","ko":"모든 연령대의 사람들이 축제를 즐겼다."},
    {"en":"Age doesn''t matter when it comes to friendship.","ko":"우정에 있어서 나이는 중요하지 않다."}
  ]'::jsonb),
  ('dear', 0, 1, '형용사', '[
    {"en":"Dear Mom, thank you for everything.","ko":"사랑하는 엄마께, 모든 것에 감사드려요."},
    {"en":"She is a dear friend of mine.","ko":"그녀는 나의 소중한 친구이다."},
    {"en":"He kept the letter as a dear memory.","ko":"그는 그 편지를 소중한 추억으로 간직했다."}
  ]'::jsonb),
  ('child', 0, 1, '명사', '[
    {"en":"Every child needs love and care.","ko":"모든 아이는 사랑과 보살핌이 필요하다."},
    {"en":"The child was playing with her toys.","ko":"그 아이는 장난감을 가지고 놀고 있었다."},
    {"en":"As a child, he loved to draw.","ko":"어렸을 때, 그는 그림 그리는 것을 좋아했다."}
  ]'::jsonb),
  ('teenager', 0, 1, '명사', '[
    {"en":"Many teenagers use social media every day.","ko":"많은 십대들이 매일 소셜 미디어를 사용한다."},
    {"en":"As a teenager, I was interested in music.","ko":"십대 때, 나는 음악에 관심이 있었다."},
    {"en":"The magazine is popular among teenagers.","ko":"그 잡지는 십대들 사이에서 인기가 있다."}
  ]'::jsonb),
  ('adult', 0, 1, '명사', '[
    {"en":"Only adults can watch this movie.","ko":"성인만 이 영화를 볼 수 있다."},
    {"en":"He became an adult at the age of twenty.","ko":"그는 스무 살에 성인이 되었다."},
    {"en":"Adults should be good role models for children.","ko":"어른들은 아이들에게 좋은 본보기가 되어야 한다."}
  ]'::jsonb),
  ('someone', 0, 1, '대명사', '[
    {"en":"Someone left this bag here.","ko":"누군가 여기에 이 가방을 두고 갔다."},
    {"en":"I need someone to help me with my homework.","ko":"나는 숙제를 도와줄 누군가가 필요하다."},
    {"en":"There is someone at the door.","ko":"문 앞에 누군가 있다."}
  ]'::jsonb),
  ('everyone', 0, 1, '대명사', '[
    {"en":"Everyone in the class passed the test.","ko":"반의 모든 사람이 시험에 통과했다."},
    {"en":"Everyone enjoyed the school festival.","ko":"모두가 학교 축제를 즐겼다."},
    {"en":"Good morning, everyone!","ko":"여러분, 안녕하세요!"}
  ]'::jsonb),
  ('lady', 0, 1, '명사', '[
    {"en":"The lady in the red dress is my teacher.","ko":"빨간 드레스를 입은 그 여성분은 나의 선생님이다."},
    {"en":"An elderly lady asked me for directions.","ko":"한 나이 든 부인이 나에게 길을 물었다."},
    {"en":"She always behaves like a true lady.","ko":"그녀는 항상 진정한 숙녀처럼 행동한다."}
  ]'::jsonb),
  ('gentleman', 0, 1, '명사', '[
    {"en":"He always acts like a gentleman.","ko":"그는 항상 신사처럼 행동한다."},
    {"en":"The old gentleman greeted us politely.","ko":"그 노신사는 우리에게 정중하게 인사했다."},
    {"en":"A true gentleman respects others.","ko":"진정한 신사는 다른 사람을 존중한다."}
  ]'::jsonb),
  ('person', 0, 1, '명사', '[
    {"en":"She is a very kind person.","ko":"그녀는 매우 친절한 사람이다."},
    {"en":"Each person has their own opinion.","ko":"각 사람은 자신만의 의견을 가지고 있다."},
    {"en":"He is the right person for this job.","ko":"그는 이 일에 적합한 사람이다."}
  ]'::jsonb),
  ('people', 0, 1, '명사', '[
    {"en":"Many people visit this museum every year.","ko":"매년 많은 사람들이 이 박물관을 방문한다."},
    {"en":"People were waiting in line for the bus.","ko":"사람들이 버스를 기다리며 줄을 서 있었다."},
    {"en":"Some people prefer tea to coffee.","ko":"어떤 사람들은 커피보다 차를 선호한다."}
  ]'::jsonb),
  ('own', 0, 1, '형용사', '[
    {"en":"She has her own room.","ko":"그녀는 자신만의 방을 가지고 있다."},
    {"en":"He wrote his own story.","ko":"그는 자신만의 이야기를 썼다."},
    {"en":"Everyone has their own way of learning.","ko":"모두는 자신만의 학습 방법을 가지고 있다."}
  ]'::jsonb),
  ('each other', 0, 1, '대명사구', '[
    {"en":"The two friends helped each other.","ko":"그 두 친구는 서로를 도왔다."},
    {"en":"We should respect each other.","ko":"우리는 서로를 존중해야 한다."},
    {"en":"They smiled at each other.","ko":"그들은 서로를 보고 미소지었다."}
  ]'::jsonb),
  ('be[come] from', 0, 1, '동사구', '[
    {"en":"She comes from Canada.","ko":"그녀는 캐나다 출신이다."},
    {"en":"Where do you come from?","ko":"당신은 어디 출신인가요?"},
    {"en":"He is from a small town.","ko":"그는 작은 마을 출신이다."}
  ]'::jsonb)
) as t(word, level, study_day, pos, examples)
where v.word = t.word and v.level = t.level and v.study_day = t.study_day;
