-- SAP 1기 대시보드: Study 탭 — Lv.0(중등 BASIC) Day 18~25 품사/예문 채우기 (160단어).
-- Supabase 대시보드 → SQL Editor에서 실행하세요.

update public.vocab_words v
set part_of_speech = t.pos, example_sentences = t.examples, updated_at = now()
from (values
  ('subway', 0, 18, '명사', '[
    {"en":"I go to school by subway every day.","ko":"나는 매일 지하철을 타고 학교에 간다."},
    {"en":"The subway was very crowded this morning.","ko":"오늘 아침 지하철은 매우 붐볐다."},
    {"en":"We took the subway to visit the museum.","ko":"우리는 박물관을 방문하기 위해 지하철을 탔다."}
  ]'::jsonb),
  ('bike', 0, 18, '명사', '[
    {"en":"He rides his bike to school every morning.","ko":"그는 매일 아침 자전거를 타고 학교에 간다."},
    {"en":"I got a new bike for my birthday.","ko":"나는 생일에 새 자전거를 받았다."},
    {"en":"She parked her bike next to the gate.","ko":"그녀는 대문 옆에 자전거를 세웠다."}
  ]'::jsonb),
  ('airplane', 0, 18, '명사', '[
    {"en":"The airplane took off on time.","ko":"그 비행기는 제시간에 이륙했다."},
    {"en":"We flew to Jeju Island by airplane.","ko":"우리는 비행기를 타고 제주도로 갔다."},
    {"en":"My uncle works as an airplane pilot.","ko":"나의 삼촌은 비행기 조종사로 일한다."}
  ]'::jsonb),
  ('truck', 0, 18, '명사', '[
    {"en":"A big truck was parked in front of the store.","ko":"큰 트럭이 가게 앞에 주차되어 있었다."},
    {"en":"The truck carried fresh vegetables to the market.","ko":"그 트럭은 신선한 채소를 시장으로 실어 날랐다."},
    {"en":"My father drives a truck for his job.","ko":"나의 아버지는 일 때문에 트럭을 운전하신다."}
  ]'::jsonb),
  ('boat', 0, 18, '명사', '[
    {"en":"We rode a boat across the lake.","ko":"우리는 호수를 가로질러 배를 탔다."},
    {"en":"The small boat floated on the calm water.","ko":"작은 배가 잔잔한 물 위에 떠 있었다."},
    {"en":"He goes fishing on his boat every weekend.","ko":"그는 매 주말 자신의 배에서 낚시를 한다."}
  ]'::jsonb),
  ('ride', 0, 18, '동사', '[
    {"en":"Can you ride a bicycle?","ko":"너는 자전거를 탈 줄 아니?"},
    {"en":"We rode the bus to the zoo.","ko":"우리는 버스를 타고 동물원에 갔다."},
    {"en":"She likes to ride her bike in the park.","ko":"그녀는 공원에서 자전거 타는 것을 좋아한다."}
  ]'::jsonb),
  ('street', 0, 18, '명사', '[
    {"en":"Many shops line this street.","ko":"이 거리에는 많은 가게들이 늘어서 있다."},
    {"en":"Look both ways before you cross the street.","ko":"길을 건너기 전에 양쪽을 살펴봐라."},
    {"en":"Our house is at the end of the street.","ko":"우리 집은 이 거리의 끝에 있다."}
  ]'::jsonb),
  ('road', 0, 18, '명사', '[
    {"en":"The road to the village was narrow.","ko":"그 마을로 가는 도로는 좁았다."},
    {"en":"Be careful, the road is wet today.","ko":"조심해, 오늘 도로가 젖어 있어."},
    {"en":"We drove along a quiet country road.","ko":"우리는 조용한 시골길을 따라 운전했다."}
  ]'::jsonb),
  ('drive', 0, 18, '동사', '[
    {"en":"My mother drives me to school every morning.","ko":"나의 어머니는 매일 아침 나를 학교까지 차로 데려다주신다."},
    {"en":"He learned to drive last year.","ko":"그는 작년에 운전하는 법을 배웠다."},
    {"en":"We drove to the beach for our vacation.","ko":"우리는 방학 동안 해변까지 차를 몰고 갔다."}
  ]'::jsonb),
  ('right', 0, 18, '명사', '[
    {"en":"Turn right at the next corner.","ko":"다음 모퉁이에서 오른쪽으로 도세요."},
    {"en":"The library is on your right.","ko":"도서관은 당신의 오른쪽에 있어요."},
    {"en":"He raised his right hand to ask a question.","ko":"그는 질문을 하려고 오른손을 들었다."}
  ]'::jsonb),
  ('left', 0, 18, '명사', '[
    {"en":"Turn left at the traffic light.","ko":"신호등에서 왼쪽으로 도세요."},
    {"en":"The bakery is on the left.","ko":"그 빵집은 왼쪽에 있다."},
    {"en":"She writes with her left hand.","ko":"그녀는 왼손으로 글씨를 쓴다."}
  ]'::jsonb),
  ('block', 0, 18, '동사', '[
    {"en":"A big truck blocked the street.","ko":"큰 트럭이 그 도로를 막았다."},
    {"en":"Please don''t block the doorway.","ko":"출입구를 막지 말아 주세요."},
    {"en":"The fallen tree blocked the road.","ko":"쓰러진 나무가 도로를 막았다."}
  ]'::jsonb),
  ('straight', 0, 18, '형용사', '[
    {"en":"Walk straight down this street.","ko":"이 거리를 따라 곧장 걸어가세요."},
    {"en":"She has long, straight hair.","ko":"그녀는 길고 곧은 머리카락을 가지고 있다."},
    {"en":"Draw a straight line on the paper.","ko":"종이에 직선을 그리세요."}
  ]'::jsonb),
  ('bridge', 0, 18, '명사', '[
    {"en":"We crossed the bridge to get to the town.","ko":"우리는 그 마을에 가기 위해 다리를 건넜다."},
    {"en":"The bridge over the river is very long.","ko":"그 강 위의 다리는 매우 길다."},
    {"en":"Many cars pass over this bridge every day.","ko":"매일 많은 차들이 이 다리를 지나간다."}
  ]'::jsonb),
  ('across', 0, 18, '전치사', '[
    {"en":"She walked across the street carefully.","ko":"그녀는 조심스럽게 길을 건너갔다."},
    {"en":"There is a park across the river.","ko":"강 건너편에 공원이 있다."},
    {"en":"He swam across the pool.","ko":"그는 수영장을 가로질러 수영했다."}
  ]'::jsonb),
  ('sign', 0, 18, '명사', '[
    {"en":"The sign says ''No Parking.''","ko":"그 표지판에는 ''주차 금지''라고 쓰여 있다."},
    {"en":"Follow the signs to the station.","ko":"역까지 가는 표지판을 따라가세요."},
    {"en":"I couldn''t find the street sign.","ko":"나는 그 거리 표지판을 찾을 수 없었다."}
  ]'::jsonb),
  ('corner', 0, 18, '명사', '[
    {"en":"There is a bookstore on the corner.","ko":"모퉁이에 서점이 하나 있다."},
    {"en":"Turn left at the next corner.","ko":"다음 모퉁이에서 왼쪽으로 도세요."},
    {"en":"The cat was hiding in the corner of the room.","ko":"고양이가 방구석에 숨어 있었다."}
  ]'::jsonb),
  ('stop', 0, 18, '동사', '[
    {"en":"The bus stopped in front of the school.","ko":"버스가 학교 앞에서 멈췄다."},
    {"en":"Please stop talking during class.","ko":"수업 중에는 이야기를 멈춰 주세요."},
    {"en":"The car stopped at the red light.","ko":"그 차는 빨간 신호등에서 멈췄다."}
  ]'::jsonb),
  ('get on', 0, 18, '동사구', '[
    {"en":"We got on the subway at the last stop.","ko":"우리는 마지막 정류장에서 지하철을 탔다."},
    {"en":"Please get on the bus quickly.","ko":"빨리 버스에 타 주세요."},
    {"en":"He got on his bike and rode away.","ko":"그는 자전거에 올라타서 떠났다."}
  ]'::jsonb),
  ('hurry up', 0, 18, '동사구', '[
    {"en":"Hurry up, or we will miss the train.","ko":"서둘러, 안 그러면 우리는 기차를 놓칠 거야."},
    {"en":"She told her brother to hurry up.","ko":"그녀는 남동생에게 서두르라고 말했다."},
    {"en":"We hurried up to catch the bus.","ko":"우리는 버스를 잡기 위해 서둘렀다."}
  ]'::jsonb),
  ('teacher', 0, 19, '명사', '[
    {"en":"My English teacher is very kind.","ko":"나의 영어 선생님은 매우 친절하시다."},
    {"en":"The teacher explained the math problem clearly.","ko":"그 선생님은 수학 문제를 명확하게 설명해 주셨다."},
    {"en":"She wants to become a science teacher.","ko":"그녀는 과학 선생님이 되고 싶어 한다."}
  ]'::jsonb),
  ('student', 0, 19, '명사', '[
    {"en":"Every student in the class did well on the test.","ko":"반의 모든 학생이 시험을 잘 봤다."},
    {"en":"He is a new student at our school.","ko":"그는 우리 학교의 새 학생이다."},
    {"en":"The students listened carefully to the teacher.","ko":"학생들은 선생님의 말씀을 주의 깊게 들었다."}
  ]'::jsonb),
  ('test', 0, 19, '명사', '[
    {"en":"We have a math test tomorrow.","ko":"우리는 내일 수학 시험이 있다."},
    {"en":"I studied hard for the science test.","ko":"나는 과학 시험을 위해 열심히 공부했다."},
    {"en":"She passed the test with a high score.","ko":"그녀는 높은 점수로 시험에 합격했다."}
  ]'::jsonb),
  ('library', 0, 19, '명사', '[
    {"en":"I often study in the library after school.","ko":"나는 방과 후에 자주 도서관에서 공부한다."},
    {"en":"The library is quiet and comfortable.","ko":"그 도서관은 조용하고 편안하다."},
    {"en":"He borrowed two books from the library.","ko":"그는 도서관에서 책 두 권을 빌렸다."}
  ]'::jsonb),
  ('playground', 0, 19, '명사', '[
    {"en":"The children are playing on the playground.","ko":"아이들이 운동장에서 놀고 있다."},
    {"en":"We meet at the playground after class.","ko":"우리는 수업 후에 운동장에서 만난다."},
    {"en":"There is a big tree in the playground.","ko":"운동장에는 큰 나무가 한 그루 있다."}
  ]'::jsonb),
  ('gym', 0, 19, '명사', '[
    {"en":"We have P.E. class in the gym.","ko":"우리는 체육관에서 체육 수업을 한다."},
    {"en":"The students played basketball in the gym.","ko":"학생들은 체육관에서 농구를 했다."},
    {"en":"The gym is open until six o''clock.","ko":"그 체육관은 여섯 시까지 문을 연다."}
  ]'::jsonb),
  ('contest', 0, 19, '명사', '[
    {"en":"She won first prize in the writing contest.","ko":"그녀는 글쓰기 대회에서 1등을 했다."},
    {"en":"Our school held a singing contest.","ko":"우리 학교는 노래 대회를 열었다."},
    {"en":"He is preparing for the science contest.","ko":"그는 과학 대회를 준비하고 있다."}
  ]'::jsonb),
  ('follow', 0, 19, '동사', '[
    {"en":"Please follow the teacher''s instructions.","ko":"선생님의 지시를 따라 주세요."},
    {"en":"The dog followed him to school.","ko":"그 개는 그를 따라 학교까지 갔다."},
    {"en":"Follow me, and I will show you the way.","ko":"저를 따라오세요, 제가 길을 알려 드릴게요."}
  ]'::jsonb),
  ('school uniform', 0, 19, '명사구', '[
    {"en":"Students wear a school uniform every day.","ko":"학생들은 매일 교복을 입는다."},
    {"en":"The new school uniform is blue and white.","ko":"새 교복은 파란색과 흰색이다."},
    {"en":"She looked neat in her school uniform.","ko":"그녀는 교복을 입고 단정해 보였다."}
  ]'::jsonb),
  ('hall', 0, 19, '명사', '[
    {"en":"We waited in the hall before the ceremony.","ko":"우리는 행사 전에 강당에서 기다렸다."},
    {"en":"The concert was held in the school hall.","ko":"그 콘서트는 학교 강당에서 열렸다."},
    {"en":"Students hung their posters on the hall wall.","ko":"학생들은 복도 벽에 포스터를 붙였다."}
  ]'::jsonb),
  ('cafeteria', 0, 19, '명사', '[
    {"en":"We eat lunch in the cafeteria.","ko":"우리는 구내식당에서 점심을 먹는다."},
    {"en":"The cafeteria serves rice and soup today.","ko":"오늘 구내식당은 밥과 국을 제공한다."},
    {"en":"I met my friend in the cafeteria.","ko":"나는 구내식당에서 내 친구를 만났다."}
  ]'::jsonb),
  ('locker', 0, 19, '명사', '[
    {"en":"I keep my books in my locker.","ko":"나는 사물함에 책을 보관한다."},
    {"en":"He forgot the number of his locker.","ko":"그는 자신의 사물함 번호를 잊어버렸다."},
    {"en":"Please put your shoes in the locker.","ko":"신발을 사물함에 넣어 주세요."}
  ]'::jsonb),
  ('homeroom', 0, 19, '명사', '[
    {"en":"Our homeroom teacher is very friendly.","ko":"우리 담임 선생님은 매우 친절하시다."},
    {"en":"We meet in the homeroom every morning.","ko":"우리는 매일 아침 홈룸에서 만난다."},
    {"en":"The homeroom class decided to plant flowers.","ko":"그 홈룸 반은 꽃을 심기로 결정했다."}
  ]'::jsonb),
  ('grade', 0, 19, '명사', '[
    {"en":"She got a good grade on her English test.","ko":"그녀는 영어 시험에서 좋은 성적을 받았다."},
    {"en":"What grade are you in?","ko":"너는 몇 학년이니?"},
    {"en":"He is in the seventh grade.","ko":"그는 7학년이다."}
  ]'::jsonb),
  ('teach', 0, 19, '동사', '[
    {"en":"My father teaches math at a middle school.","ko":"나의 아버지는 중학교에서 수학을 가르치신다."},
    {"en":"She teaches us how to draw.","ko":"그녀는 우리에게 그림 그리는 법을 가르쳐 준다."},
    {"en":"He taught his little sister to swim.","ko":"그는 여동생에게 수영하는 법을 가르쳤다."}
  ]'::jsonb),
  ('learn', 0, 19, '동사', '[
    {"en":"We learn English at school.","ko":"우리는 학교에서 영어를 배운다."},
    {"en":"I want to learn how to play the guitar.","ko":"나는 기타 치는 법을 배우고 싶다."},
    {"en":"She learned a lot from the book.","ko":"그녀는 그 책에서 많은 것을 배웠다."}
  ]'::jsonb),
  ('subject', 0, 19, '명사', '[
    {"en":"Math is my favorite subject.","ko":"수학은 내가 가장 좋아하는 과목이다."},
    {"en":"What subject do you like best?","ko":"너는 어떤 과목을 가장 좋아하니?"},
    {"en":"History is an interesting subject.","ko":"역사는 흥미로운 과목이다."}
  ]'::jsonb),
  ('borrow', 0, 19, '동사', '[
    {"en":"Can I borrow your pencil?","ko":"네 연필을 빌려도 될까?"},
    {"en":"I borrowed a book from the library.","ko":"나는 도서관에서 책을 한 권 빌렸다."},
    {"en":"She borrowed money from her brother.","ko":"그녀는 오빠에게서 돈을 빌렸다."}
  ]'::jsonb),
  ('make friends (with)', 0, 19, '동사구', '[
    {"en":"It is easy for her to make friends.","ko":"그녀는 친구를 쉽게 사귄다."},
    {"en":"I made friends with my classmates quickly.","ko":"나는 반 친구들과 빠르게 친해졌다."},
    {"en":"He wants to make friends with the new student.","ko":"그는 새로 온 학생과 친구가 되고 싶어 한다."}
  ]'::jsonb),
  ('after school', 0, 19, '부사구', '[
    {"en":"We play basketball after school.","ko":"우리는 방과 후에 농구를 한다."},
    {"en":"She goes to the library after school.","ko":"그녀는 방과 후에 도서관에 간다."},
    {"en":"I have piano lessons after school.","ko":"나는 방과 후에 피아노 수업이 있다."}
  ]'::jsonb),
  ('homework', 0, 20, '명사', '[
    {"en":"I have a lot of homework today.","ko":"나는 오늘 숙제가 많다."},
    {"en":"She finished her homework before dinner.","ko":"그녀는 저녁 식사 전에 숙제를 끝냈다."},
    {"en":"Did you do your math homework?","ko":"너는 수학 숙제를 했니?"}
  ]'::jsonb),
  ('lesson', 0, 20, '명사', '[
    {"en":"Today''s lesson is about the water cycle.","ko":"오늘의 수업은 물의 순환에 관한 것이다."},
    {"en":"I take piano lessons every Friday.","ko":"나는 매주 금요일에 피아노 수업을 받는다."},
    {"en":"This story gives us an important lesson.","ko":"이 이야기는 우리에게 중요한 교훈을 준다."}
  ]'::jsonb),
  ('study', 0, 20, '동사', '[
    {"en":"I study English every night.","ko":"나는 매일 밤 영어를 공부한다."},
    {"en":"We studied together for the test.","ko":"우리는 시험을 위해 함께 공부했다."},
    {"en":"She studies hard to get good grades.","ko":"그녀는 좋은 성적을 받기 위해 열심히 공부한다."}
  ]'::jsonb),
  ('difficult', 0, 20, '형용사', '[
    {"en":"This math problem is very difficult.","ko":"이 수학 문제는 매우 어렵다."},
    {"en":"It was difficult to understand the question.","ko":"그 질문을 이해하는 것은 어려웠다."},
    {"en":"The test was more difficult than I expected.","ko":"그 시험은 내가 예상했던 것보다 더 어려웠다."}
  ]'::jsonb),
  ('classroom', 0, 20, '명사', '[
    {"en":"Our classroom is on the second floor.","ko":"우리 교실은 2층에 있다."},
    {"en":"The classroom was quiet during the test.","ko":"시험을 보는 동안 교실은 조용했다."},
    {"en":"We decorated the classroom for the festival.","ko":"우리는 축제를 위해 교실을 꾸몄다."}
  ]'::jsonb),
  ('review', 0, 20, '동사', '[
    {"en":"I reviewed my notes before the test.","ko":"나는 시험 전에 내 필기를 복습했다."},
    {"en":"Let''s review chapter three today.","ko":"오늘 3장을 복습하자."},
    {"en":"She reviews her lessons every evening.","ko":"그녀는 매일 저녁 수업 내용을 복습한다."}
  ]'::jsonb),
  ('write', 0, 20, '동사', '[
    {"en":"I write in my diary every night.","ko":"나는 매일 밤 일기를 쓴다."},
    {"en":"She wrote a letter to her friend.","ko":"그녀는 친구에게 편지를 썼다."},
    {"en":"We wrote our names on the paper.","ko":"우리는 종이에 이름을 썼다."}
  ]'::jsonb),
  ('solve', 0, 20, '동사', '[
    {"en":"He solved the math problem quickly.","ko":"그는 그 수학 문제를 빠르게 풀었다."},
    {"en":"We worked together to solve the puzzle.","ko":"우리는 그 퍼즐을 풀기 위해 함께 노력했다."},
    {"en":"Can you solve this question?","ko":"너는 이 문제를 풀 수 있니?"}
  ]'::jsonb),
  ('correct', 0, 20, '형용사', '[
    {"en":"Your answer is correct.","ko":"네 대답이 맞다."},
    {"en":"Please choose the correct word.","ko":"올바른 단어를 골라 주세요."},
    {"en":"She gave the correct answer to every question.","ko":"그녀는 모든 질문에 정답을 말했다."}
  ]'::jsonb),
  ('wrong', 0, 20, '형용사', '[
    {"en":"I think this answer is wrong.","ko":"나는 이 답이 틀렸다고 생각한다."},
    {"en":"He took the wrong bus by mistake.","ko":"그는 실수로 잘못된 버스를 탔다."},
    {"en":"Something is wrong with my computer.","ko":"내 컴퓨터에 뭔가 문제가 있다."}
  ]'::jsonb),
  ('diary', 0, 20, '명사', '[
    {"en":"She writes in her diary every day.","ko":"그녀는 매일 일기를 쓴다."},
    {"en":"I keep a diary about my school life.","ko":"나는 학교생활에 관한 일기를 쓴다."},
    {"en":"He read his old diary and smiled.","ko":"그는 자신의 오래된 일기를 읽고 미소지었다."}
  ]'::jsonb),
  ('report', 0, 20, '명사', '[
    {"en":"I have to write a report on my hometown.","ko":"나는 내 고향에 관한 보고서를 써야 한다."},
    {"en":"Our teacher checked our science reports.","ko":"우리 선생님은 우리의 과학 보고서를 확인하셨다."},
    {"en":"She gave a report about her trip.","ko":"그녀는 자신의 여행에 대해 보고했다."}
  ]'::jsonb),
  ('fail', 0, 20, '동사', '[
    {"en":"He failed the math test.","ko":"그는 수학 시험에서 떨어졌다."},
    {"en":"Don''t worry, you won''t fail.","ko":"걱정하지 마, 너는 실패하지 않을 거야."},
    {"en":"She studied hard so she wouldn''t fail again.","ko":"그녀는 다시 실패하지 않으려고 열심히 공부했다."}
  ]'::jsonb),
  ('note(-s)', 0, 20, '명사', '[
    {"en":"I took notes during the lesson.","ko":"나는 수업 중에 필기를 했다."},
    {"en":"She left a note on my desk.","ko":"그녀는 내 책상에 쪽지를 남겼다."},
    {"en":"Please compare your notes with mine.","ko":"네 필기를 내 것과 비교해 봐."}
  ]'::jsonb),
  ('speech', 0, 20, '명사', '[
    {"en":"He gave a speech in front of the class.","ko":"그는 반 친구들 앞에서 연설을 했다."},
    {"en":"Her speech was about protecting the environment.","ko":"그녀의 연설은 환경 보호에 관한 것이었다."},
    {"en":"I was nervous before my speech.","ko":"나는 연설 전에 긴장했다."}
  ]'::jsonb),
  ('finish', 0, 20, '동사', '[
    {"en":"I finished my homework before dinner.","ko":"나는 저녁 식사 전에 숙제를 끝냈다."},
    {"en":"She finished the race first.","ko":"그녀는 경주를 가장 먼저 끝냈다."},
    {"en":"We finished cleaning the classroom.","ko":"우리는 교실 청소를 끝냈다."}
  ]'::jsonb),
  ('mistake', 0, 20, '명사', '[
    {"en":"Everyone makes mistakes sometimes.","ko":"누구나 가끔 실수를 한다."},
    {"en":"I made a small mistake on the test.","ko":"나는 시험에서 작은 실수를 했다."},
    {"en":"He learned from his mistake.","ko":"그는 자신의 실수로부터 배웠다."}
  ]'::jsonb),
  ('absent', 0, 20, '형용사', '[
    {"en":"He was absent from school yesterday.","ko":"그는 어제 학교에 결석했다."},
    {"en":"Three students were absent today.","ko":"오늘 세 명의 학생이 결석했다."},
    {"en":"She was absent because she was sick.","ko":"그녀는 아파서 결석했다."}
  ]'::jsonb),
  ('take a break', 0, 20, '동사구', '[
    {"en":"Let''s take a break for ten minutes.","ko":"10분 동안 휴식을 취하자."},
    {"en":"We took a break after studying for two hours.","ko":"우리는 두 시간 동안 공부한 후 휴식을 취했다."},
    {"en":"She takes a break every afternoon.","ko":"그녀는 매일 오후 휴식을 취한다."}
  ]'::jsonb),
  ('get up', 0, 20, '동사구', '[
    {"en":"I get up at seven every morning.","ko":"나는 매일 아침 7시에 일어난다."},
    {"en":"He got up late today.","ko":"그는 오늘 늦게 일어났다."},
    {"en":"She always gets up early to exercise.","ko":"그녀는 운동하기 위해 항상 일찍 일어난다."}
  ]'::jsonb),
  ('date', 0, 21, '명사', '[
    {"en":"What is today''s date?","ko":"오늘 날짜가 어떻게 되나요?"},
    {"en":"Please write the date at the top of the page.","ko":"페이지 상단에 날짜를 써 주세요."},
    {"en":"We set the date for the school festival.","ko":"우리는 학교 축제 날짜를 정했다."}
  ]'::jsonb),
  ('week', 0, 21, '명사', '[
    {"en":"I have piano lessons twice a week.","ko":"나는 일주일에 두 번 피아노 수업을 받는다."},
    {"en":"Next week is my birthday.","ko":"다음 주는 내 생일이다."},
    {"en":"We will finish the project this week.","ko":"우리는 이번 주에 그 프로젝트를 끝낼 것이다."}
  ]'::jsonb),
  ('from', 0, 21, '전치사', '[
    {"en":"The store is open from nine to six.","ko":"그 가게는 9시부터 6시까지 문을 연다."},
    {"en":"She comes from Busan.","ko":"그녀는 부산 출신이다."},
    {"en":"I received a letter from my grandmother.","ko":"나는 할머니로부터 편지를 받았다."}
  ]'::jsonb),
  ('month', 0, 21, '명사', '[
    {"en":"We are going on a trip next month.","ko":"우리는 다음 달에 여행을 갈 것이다."},
    {"en":"August is the hottest month of the year.","ko":"8월은 일 년 중 가장 더운 달이다."},
    {"en":"She has lived here for six months.","ko":"그녀는 여기서 여섯 달 동안 살았다."}
  ]'::jsonb),
  ('year', 0, 21, '명사', '[
    {"en":"This year, I want to read more books.","ko":"올해 나는 더 많은 책을 읽고 싶다."},
    {"en":"We celebrate his birthday every year.","ko":"우리는 매년 그의 생일을 축하한다."},
    {"en":"She has studied English for three years.","ko":"그녀는 3년 동안 영어를 공부했다."}
  ]'::jsonb),
  ('early', 0, 21, '부사', '[
    {"en":"I woke up early this morning.","ko":"나는 오늘 아침 일찍 일어났다."},
    {"en":"We arrived early for the concert.","ko":"우리는 콘서트에 일찍 도착했다."},
    {"en":"She goes to bed early every night.","ko":"그녀는 매일 밤 일찍 잠자리에 든다."}
  ]'::jsonb),
  ('today', 0, 21, '부사', '[
    {"en":"What did you learn today?","ko":"너는 오늘 무엇을 배웠니?"},
    {"en":"Today is a special day for our class.","ko":"오늘은 우리 반에게 특별한 날이다."},
    {"en":"I feel great today.","ko":"나는 오늘 기분이 아주 좋다."}
  ]'::jsonb),
  ('yesterday', 0, 21, '부사', '[
    {"en":"It rained a lot yesterday.","ko":"어제 비가 많이 왔다."},
    {"en":"I met my old friend yesterday.","ko":"나는 어제 오랜 친구를 만났다."},
    {"en":"We had a math test yesterday.","ko":"우리는 어제 수학 시험을 봤다."}
  ]'::jsonb),
  ('tomorrow', 0, 21, '부사', '[
    {"en":"We have a field trip tomorrow.","ko":"우리는 내일 현장 학습이 있다."},
    {"en":"I will call you tomorrow.","ko":"내가 내일 너에게 전화할게."},
    {"en":"The weather will be sunny tomorrow.","ko":"내일 날씨는 화창할 것이다."}
  ]'::jsonb),
  ('past', 0, 21, '명사', '[
    {"en":"We often learn from the past.","ko":"우리는 종종 과거로부터 배운다."},
    {"en":"She talked about her past experiences.","ko":"그녀는 자신의 과거 경험에 대해 이야기했다."},
    {"en":"It is ten minutes past six.","ko":"6시 10분이다."}
  ]'::jsonb),
  ('tonight', 0, 21, '부사', '[
    {"en":"We are having pizza tonight.","ko":"우리는 오늘 밤 피자를 먹을 것이다."},
    {"en":"I have a lot of homework to do tonight.","ko":"나는 오늘 밤 해야 할 숙제가 많다."},
    {"en":"The stars are bright tonight.","ko":"오늘 밤 별이 밝다."}
  ]'::jsonb),
  ('hour', 0, 21, '명사', '[
    {"en":"I study for one hour after dinner.","ko":"나는 저녁 식사 후 한 시간 동안 공부한다."},
    {"en":"The movie lasted two hours.","ko":"그 영화는 두 시간 동안 계속되었다."},
    {"en":"We waited for an hour at the bus stop.","ko":"우리는 버스 정류장에서 한 시간 동안 기다렸다."}
  ]'::jsonb),
  ('minute', 0, 21, '명사', '[
    {"en":"Wait a minute, please.","ko":"잠깐만 기다려 주세요."},
    {"en":"It takes ten minutes to walk to school.","ko":"학교까지 걸어가는 데 10분이 걸린다."},
    {"en":"She finished the race in five minutes.","ko":"그녀는 5분 만에 경주를 끝냈다."}
  ]'::jsonb),
  ('soon', 0, 21, '부사', '[
    {"en":"The bus will arrive soon.","ko":"버스가 곧 도착할 것이다."},
    {"en":"I hope to see you soon.","ko":"곧 너를 보길 바라."},
    {"en":"She will finish her homework soon.","ko":"그녀는 곧 숙제를 끝낼 것이다."}
  ]'::jsonb),
  ('calendar', 0, 21, '명사', '[
    {"en":"I marked my birthday on the calendar.","ko":"나는 달력에 내 생일을 표시했다."},
    {"en":"Look at the calendar to check the date.","ko":"날짜를 확인하려면 달력을 봐."},
    {"en":"We hung a new calendar on the wall.","ko":"우리는 벽에 새 달력을 걸었다."}
  ]'::jsonb),
  ('during', 0, 21, '전치사', '[
    {"en":"Please be quiet during the test.","ko":"시험 중에는 조용히 해 주세요."},
    {"en":"We visited many places during our trip.","ko":"우리는 여행하는 동안 많은 곳을 방문했다."},
    {"en":"She fell asleep during the movie.","ko":"그녀는 영화를 보는 동안 잠이 들었다."}
  ]'::jsonb),
  ('until', 0, 21, '전치사', '[
    {"en":"I studied until midnight.","ko":"나는 자정까지 공부했다."},
    {"en":"We waited until the rain stopped.","ko":"우리는 비가 그칠 때까지 기다렸다."},
    {"en":"The library is open until nine.","ko":"도서관은 9시까지 문을 연다."}
  ]'::jsonb),
  ('moment', 0, 21, '명사', '[
    {"en":"Please wait a moment.","ko":"잠깐만 기다려 주세요."},
    {"en":"That was a happy moment for our family.","ko":"그것은 우리 가족에게 행복한 순간이었다."},
    {"en":"I will never forget this moment.","ko":"나는 이 순간을 절대 잊지 않을 것이다."}
  ]'::jsonb),
  ('be late for', 0, 21, '동사구', '[
    {"en":"Don''t be late for school again.","ko":"다시는 학교에 지각하지 마."},
    {"en":"He was late for the meeting.","ko":"그는 회의에 늦었다."},
    {"en":"I was late for class this morning.","ko":"나는 오늘 아침 수업에 늦었다."}
  ]'::jsonb),
  ('at the same time', 0, 21, '부사구', '[
    {"en":"We arrived at the same time.","ko":"우리는 동시에 도착했다."},
    {"en":"She can sing and dance at the same time.","ko":"그녀는 노래하면서 동시에 춤을 출 수 있다."},
    {"en":"Two buses came at the same time.","ko":"두 대의 버스가 동시에 왔다."}
  ]'::jsonb),
  ('first', 0, 22, '형용사', '[
    {"en":"She was the first student to arrive.","ko":"그녀는 가장 먼저 도착한 학생이었다."},
    {"en":"This is my first time visiting Seoul.","ko":"이번이 내가 서울을 처음 방문하는 것이다."},
    {"en":"He finished the race in first place.","ko":"그는 1등으로 경주를 끝냈다."}
  ]'::jsonb),
  ('second', 0, 22, '형용사', '[
    {"en":"This is my second year at this school.","ko":"이번이 내가 이 학교에 다니는 두 번째 해이다."},
    {"en":"She came in second place in the contest.","ko":"그녀는 대회에서 2등을 했다."},
    {"en":"Turn at the second corner.","ko":"두 번째 모퉁이에서 도세요."}
  ]'::jsonb),
  ('third', 0, 22, '형용사', '[
    {"en":"He is in the third grade.","ko":"그는 3학년이다."},
    {"en":"This is the third question on the test.","ko":"이것은 시험의 세 번째 문제이다."},
    {"en":"She finished the race in third place.","ko":"그녀는 경주를 3등으로 끝냈다."}
  ]'::jsonb),
  ('again', 0, 22, '부사', '[
    {"en":"Can you say that again, please?","ko":"다시 한번 말씀해 주시겠어요?"},
    {"en":"I want to visit this place again.","ko":"나는 이곳을 다시 방문하고 싶다."},
    {"en":"He tried again and finally succeeded.","ko":"그는 다시 시도했고 마침내 성공했다."}
  ]'::jsonb),
  ('before', 0, 22, '전치사', '[
    {"en":"Wash your hands before dinner.","ko":"저녁 식사 전에 손을 씻어라."},
    {"en":"I finished my homework before nine.","ko":"나는 9시 전에 숙제를 끝냈다."},
    {"en":"She checked her bag before leaving.","ko":"그녀는 떠나기 전에 가방을 확인했다."}
  ]'::jsonb),
  ('after', 0, 22, '전치사', '[
    {"en":"We play soccer after school.","ko":"우리는 방과 후에 축구를 한다."},
    {"en":"She washed the dishes after dinner.","ko":"그녀는 저녁 식사 후에 설거지를 했다."},
    {"en":"I felt tired after the long walk.","ko":"나는 긴 산책 후에 피곤함을 느꼈다."}
  ]'::jsonb),
  ('never', 0, 22, '부사', '[
    {"en":"I never eat breakfast late.","ko":"나는 절대 늦게 아침을 먹지 않는다."},
    {"en":"She has never been to Jeju Island.","ko":"그녀는 제주도에 가 본 적이 없다."},
    {"en":"He never gives up easily.","ko":"그는 절대 쉽게 포기하지 않는다."}
  ]'::jsonb),
  ('sometimes', 0, 22, '부사', '[
    {"en":"Sometimes I walk to school.","ko":"나는 가끔 학교에 걸어간다."},
    {"en":"She sometimes forgets her homework.","ko":"그녀는 가끔 숙제를 잊어버린다."},
    {"en":"We sometimes eat out on weekends.","ko":"우리는 주말에 가끔 외식을 한다."}
  ]'::jsonb),
  ('often', 0, 22, '부사', '[
    {"en":"I often visit my grandparents.","ko":"나는 자주 조부모님을 방문한다."},
    {"en":"She often helps her mother with housework.","ko":"그녀는 자주 어머니의 집안일을 돕는다."},
    {"en":"We often study together after school.","ko":"우리는 방과 후에 자주 함께 공부한다."}
  ]'::jsonb),
  ('usually', 0, 22, '부사', '[
    {"en":"I usually get up at seven.","ko":"나는 보통 7시에 일어난다."},
    {"en":"She usually walks to school.","ko":"그녀는 보통 학교에 걸어간다."},
    {"en":"We usually have rice for breakfast.","ko":"우리는 보통 아침으로 밥을 먹는다."}
  ]'::jsonb),
  ('always', 0, 22, '부사', '[
    {"en":"She always smiles at me.","ko":"그녀는 항상 나에게 미소를 짓는다."},
    {"en":"He always does his best.","ko":"그는 항상 최선을 다한다."},
    {"en":"I always carry an umbrella in summer.","ko":"나는 여름에 항상 우산을 가지고 다닌다."}
  ]'::jsonb),
  ('once', 0, 22, '부사', '[
    {"en":"I visited Busan once last year.","ko":"나는 작년에 부산을 한 번 방문했다."},
    {"en":"We meet once a week.","ko":"우리는 일주일에 한 번 만난다."},
    {"en":"She called me once yesterday.","ko":"그녀는 어제 나에게 한 번 전화했다."}
  ]'::jsonb),
  ('final', 0, 22, '형용사', '[
    {"en":"This is the final question of the test.","ko":"이것이 시험의 마지막 문제이다."},
    {"en":"The final match will be held tomorrow.","ko":"결승전은 내일 열릴 것이다."},
    {"en":"We are ready for the final exam.","ko":"우리는 기말고사를 준비했다."}
  ]'::jsonb),
  ('last', 0, 22, '형용사', '[
    {"en":"I saw her last week.","ko":"나는 지난주에 그녀를 보았다."},
    {"en":"This is the last chance to win.","ko":"이것이 이길 수 있는 마지막 기회이다."},
    {"en":"He was the last person to leave the classroom.","ko":"그는 교실을 마지막으로 나간 사람이었다."}
  ]'::jsonb),
  ('next', 0, 22, '형용사', '[
    {"en":"I will see you next Monday.","ko":"다음 주 월요일에 만나요."},
    {"en":"Turn right at the next street.","ko":"다음 거리에서 오른쪽으로 도세요."},
    {"en":"What is the next subject on our schedule?","ko":"우리 시간표에서 다음 과목은 무엇인가요?"}
  ]'::jsonb),
  ('step', 0, 22, '명사', '[
    {"en":"Take one step at a time.","ko":"한 번에 한 걸음씩 나아가라."},
    {"en":"Follow these steps to solve the problem.","ko":"이 단계들을 따라 문제를 풀어보세요."},
    {"en":"She took a big step forward.","ko":"그녀는 앞으로 큰 걸음을 내디뎠다."}
  ]'::jsonb),
  ('repeat', 0, 22, '동사', '[
    {"en":"Please repeat the question.","ko":"질문을 다시 말씀해 주세요."},
    {"en":"The teacher repeated the instructions.","ko":"선생님은 지시 사항을 반복하셨다."},
    {"en":"I repeated the word many times to remember it.","ko":"나는 그 단어를 기억하기 위해 여러 번 반복했다."}
  ]'::jsonb),
  ('suddenly', 0, 22, '부사', '[
    {"en":"Suddenly, it began to rain.","ko":"갑자기 비가 내리기 시작했다."},
    {"en":"The dog suddenly ran into the street.","ko":"그 개는 갑자기 거리로 뛰어들었다."},
    {"en":"She suddenly remembered her homework.","ko":"그녀는 갑자기 숙제가 생각났다."}
  ]'::jsonb),
  ('all the time', 0, 22, '부사구', '[
    {"en":"She smiles all the time.","ko":"그녀는 항상 웃는다."},
    {"en":"He listens to music all the time.","ko":"그는 항상 음악을 듣는다."},
    {"en":"We can''t play games all the time.","ko":"우리는 항상 게임만 할 수는 없다."}
  ]'::jsonb),
  ('from time to time', 0, 22, '부사구', '[
    {"en":"I visit my cousin from time to time.","ko":"나는 가끔 사촌을 방문한다."},
    {"en":"She calls her grandmother from time to time.","ko":"그녀는 가끔 할머니께 전화드린다."},
    {"en":"We eat out from time to time.","ko":"우리는 가끔 외식을 한다."}
  ]'::jsonb),
  ('clean', 0, 23, '형용사', '[
    {"en":"My room is always clean.","ko":"내 방은 항상 깨끗하다."},
    {"en":"Please keep the classroom clean.","ko":"교실을 깨끗하게 유지해 주세요."},
    {"en":"She washed the dishes until they were clean.","ko":"그녀는 접시가 깨끗해질 때까지 씻었다."}
  ]'::jsonb),
  ('dirty', 0, 23, '형용사', '[
    {"en":"My shoes are dirty from the rain.","ko":"내 신발은 비 때문에 더럽다."},
    {"en":"Please don''t touch the wall with dirty hands.","ko":"더러운 손으로 벽을 만지지 마세요."},
    {"en":"The dirty dishes are in the sink.","ko":"더러운 접시들이 싱크대에 있다."}
  ]'::jsonb),
  ('busy', 0, 23, '형용사', '[
    {"en":"I am busy with homework today.","ko":"나는 오늘 숙제로 바쁘다."},
    {"en":"She is a busy student with many activities.","ko":"그녀는 많은 활동으로 바쁜 학생이다."},
    {"en":"We were too busy to eat lunch.","ko":"우리는 너무 바빠서 점심을 먹지 못했다."}
  ]'::jsonb),
  ('poor', 0, 23, '형용사', '[
    {"en":"The poor family lived in a small house.","ko":"그 가난한 가족은 작은 집에서 살았다."},
    {"en":"He helps poor children in his town.","ko":"그는 그의 마을에 있는 가난한 아이들을 돕는다."},
    {"en":"They were poor but happy.","ko":"그들은 가난했지만 행복했다."}
  ]'::jsonb),
  ('slow', 0, 23, '형용사', '[
    {"en":"The turtle is very slow.","ko":"그 거북이는 매우 느리다."},
    {"en":"This computer is too slow.","ko":"이 컴퓨터는 너무 느리다."},
    {"en":"We took a slow walk in the park.","ko":"우리는 공원에서 느긋하게 산책했다."}
  ]'::jsonb),
  ('fast', 0, 23, '형용사', '[
    {"en":"He is a fast runner.","ko":"그는 빠른 달리기 선수이다."},
    {"en":"The train is faster than the bus.","ko":"그 기차는 버스보다 빠르다."},
    {"en":"She ate her lunch fast.","ko":"그녀는 점심을 빨리 먹었다."}
  ]'::jsonb),
  ('quickly', 0, 23, '부사', '[
    {"en":"She finished her homework quickly.","ko":"그녀는 숙제를 빨리 끝냈다."},
    {"en":"Please answer the question quickly.","ko":"질문에 빨리 대답해 주세요."},
    {"en":"He ran quickly to catch the bus.","ko":"그는 버스를 잡기 위해 빨리 뛰었다."}
  ]'::jsonb),
  ('sleepy', 0, 23, '형용사', '[
    {"en":"I feel sleepy after lunch.","ko":"나는 점심을 먹고 나면 졸린다."},
    {"en":"She looked sleepy during class.","ko":"그녀는 수업 중에 졸려 보였다."},
    {"en":"He was too sleepy to study.","ko":"그는 너무 졸려서 공부할 수 없었다."}
  ]'::jsonb),
  ('heavy', 0, 23, '형용사', '[
    {"en":"My backpack is very heavy today.","ko":"오늘 내 배낭은 매우 무겁다."},
    {"en":"This box is too heavy to carry.","ko":"이 상자는 너무 무거워서 나를 수 없다."},
    {"en":"It started to rain heavily this afternoon.","ko":"오늘 오후에 비가 세차게 내리기 시작했다."}
  ]'::jsonb),
  ('light', 0, 23, '형용사', '[
    {"en":"This bag is very light.","ko":"이 가방은 매우 가볍다."},
    {"en":"The room was full of light.","ko":"그 방은 빛으로 가득했다."},
    {"en":"She wore a light jacket in spring.","ko":"그녀는 봄에 가벼운 재킷을 입었다."}
  ]'::jsonb),
  ('safe', 0, 23, '형용사', '[
    {"en":"Wear a helmet to stay safe.","ko":"안전하게 있으려면 헬멧을 써라."},
    {"en":"This park is safe for children.","ko":"이 공원은 아이들에게 안전하다."},
    {"en":"We arrived home safe and sound.","ko":"우리는 무사히 집에 도착했다."}
  ]'::jsonb),
  ('wet', 0, 23, '형용사', '[
    {"en":"My clothes are wet from the rain.","ko":"내 옷은 비에 젖었다."},
    {"en":"Be careful, the floor is wet.","ko":"조심해, 바닥이 젖어 있어."},
    {"en":"He dried his wet hair with a towel.","ko":"그는 젖은 머리를 수건으로 말렸다."}
  ]'::jsonb),
  ('ready', 0, 23, '형용사', '[
    {"en":"Are you ready for the test?","ko":"시험 볼 준비가 되었니?"},
    {"en":"Dinner is ready.","ko":"저녁 식사가 준비되었다."},
    {"en":"We were ready to leave at eight.","ko":"우리는 8시에 떠날 준비가 되었다."}
  ]'::jsonb),
  ('dark', 0, 23, '형용사', '[
    {"en":"The sky became dark before the rain.","ko":"비가 오기 전 하늘이 어두워졌다."},
    {"en":"Turn on the light, it''s too dark.","ko":"불을 켜, 너무 어두워."},
    {"en":"She was afraid of the dark room.","ko":"그녀는 어두운 방을 무서워했다."}
  ]'::jsonb),
  ('bright', 0, 23, '형용사', '[
    {"en":"The classroom is bright and clean.","ko":"그 교실은 밝고 깨끗하다."},
    {"en":"She has a bright smile.","ko":"그녀는 밝은 미소를 가지고 있다."},
    {"en":"The stars were bright last night.","ko":"어젯밤 별이 밝았다."}
  ]'::jsonb),
  ('perfect', 0, 23, '형용사', '[
    {"en":"Today is a perfect day for a picnic.","ko":"오늘은 소풍 가기에 완벽한 날이다."},
    {"en":"Her English pronunciation is perfect.","ko":"그녀의 영어 발음은 완벽하다."},
    {"en":"No one is perfect.","ko":"완벽한 사람은 없다."}
  ]'::jsonb),
  ('different', 0, 23, '형용사', '[
    {"en":"We have different opinions about the movie.","ko":"우리는 그 영화에 대해 다른 의견을 가지고 있다."},
    {"en":"Each country has a different culture.","ko":"각 나라는 다른 문화를 가지고 있다."},
    {"en":"My sister and I look very different.","ko":"내 여동생과 나는 매우 다르게 생겼다."}
  ]'::jsonb),
  ('terrible', 0, 23, '형용사', '[
    {"en":"I had a terrible headache yesterday.","ko":"나는 어제 끔찍한 두통이 있었다."},
    {"en":"The weather was terrible during our trip.","ko":"우리 여행 동안 날씨가 끔찍했다."},
    {"en":"It was a terrible mistake.","ko":"그것은 끔찍한 실수였다."}
  ]'::jsonb),
  ('be full of', 0, 23, '동사구', '[
    {"en":"The classroom was full of laughter.","ko":"교실은 웃음소리로 가득했다."},
    {"en":"The basket is full of fresh fruit.","ko":"바구니는 신선한 과일로 가득 차 있다."},
    {"en":"Her heart was full of joy.","ko":"그녀의 마음은 기쁨으로 가득했다."}
  ]'::jsonb),
  ('for a while', 0, 23, '부사구', '[
    {"en":"Let''s rest for a while.","ko":"잠시 동안 쉬자."},
    {"en":"She waited for a while at the bus stop.","ko":"그녀는 버스 정류장에서 잠시 동안 기다렸다."},
    {"en":"We talked for a while after class.","ko":"우리는 수업 후에 잠시 동안 이야기했다."}
  ]'::jsonb),
  ('huge', 0, 24, '형용사', '[
    {"en":"The elephant is a huge animal.","ko":"코끼리는 거대한 동물이다."},
    {"en":"They live in a huge house.","ko":"그들은 거대한 집에 산다."},
    {"en":"There was a huge crowd at the festival.","ko":"축제에는 거대한 인파가 있었다."}
  ]'::jsonb),
  ('small', 0, 24, '형용사', '[
    {"en":"She lives in a small town.","ko":"그녀는 작은 마을에 산다."},
    {"en":"I have a small dog.","ko":"나는 작은 개를 키운다."},
    {"en":"This shirt is too small for me.","ko":"이 셔츠는 나에게 너무 작다."}
  ]'::jsonb),
  ('narrow', 0, 24, '형용사', '[
    {"en":"The street is very narrow.","ko":"그 거리는 매우 좁다."},
    {"en":"We walked through a narrow path in the forest.","ko":"우리는 숲속의 좁은 길을 걸었다."},
    {"en":"The room felt narrow with all the boxes.","ko":"그 방은 상자들로 가득 차서 좁게 느껴졌다."}
  ]'::jsonb),
  ('wide', 0, 24, '형용사', '[
    {"en":"The river is very wide here.","ko":"이곳의 강은 매우 넓다."},
    {"en":"She has a wide smile.","ko":"그녀는 넓은 미소를 가지고 있다."},
    {"en":"The road became wide near the city.","ko":"그 도로는 도시 근처에서 넓어졌다."}
  ]'::jsonb),
  ('round', 0, 24, '형용사', '[
    {"en":"The table in our kitchen is round.","ko":"우리 부엌의 탁자는 둥글다."},
    {"en":"She drew a round shape on the paper.","ko":"그녀는 종이에 둥근 모양을 그렸다."},
    {"en":"The moon looked perfectly round tonight.","ko":"오늘 밤 달은 완벽하게 둥글어 보였다."}
  ]'::jsonb),
  ('part', 0, 24, '명사', '[
    {"en":"This is my favorite part of the story.","ko":"이것은 그 이야기에서 내가 가장 좋아하는 부분이다."},
    {"en":"Everyone played a part in the school play.","ko":"모두가 학교 연극에서 역할을 맡았다."},
    {"en":"Which part of the city do you live in?","ko":"너는 도시의 어느 부분에 사니?"}
  ]'::jsonb),
  ('line', 0, 24, '명사', '[
    {"en":"Please stand in line for the bus.","ko":"버스를 타기 위해 줄을 서 주세요."},
    {"en":"Draw a straight line on the paper.","ko":"종이에 직선을 그리세요."},
    {"en":"There was a long line at the bakery.","ko":"빵집에는 긴 줄이 있었다."}
  ]'::jsonb),
  ('side', 0, 24, '명사', '[
    {"en":"The library is on the other side of the street.","ko":"도서관은 길 건너편에 있다."},
    {"en":"He sat by my side during the movie.","ko":"그는 영화를 보는 동안 내 옆에 앉았다."},
    {"en":"There are two sides to every story.","ko":"모든 이야기에는 두 가지 측면이 있다."}
  ]'::jsonb),
  ('shape', 0, 24, '명사', '[
    {"en":"The cookie was in the shape of a star.","ko":"그 쿠키는 별 모양이었다."},
    {"en":"Children learn different shapes at school.","ko":"아이들은 학교에서 다양한 모양을 배운다."},
    {"en":"The cloud had a strange shape.","ko":"그 구름은 이상한 모양을 하고 있었다."}
  ]'::jsonb),
  ('size', 0, 24, '명사', '[
    {"en":"What size shoes do you wear?","ko":"신발 사이즈가 어떻게 되나요?"},
    {"en":"The two boxes are the same size.","ko":"그 두 상자는 크기가 같다."},
    {"en":"She chose a bigger size for the jacket.","ko":"그녀는 재킷을 더 큰 사이즈로 골랐다."}
  ]'::jsonb),
  ('type', 0, 24, '명사', '[
    {"en":"What type of music do you like?","ko":"너는 어떤 종류의 음악을 좋아하니?"},
    {"en":"This is a new type of phone.","ko":"이것은 새로운 종류의 전화기이다."},
    {"en":"There are many types of flowers in the garden.","ko":"정원에는 많은 종류의 꽃이 있다."}
  ]'::jsonb),
  ('large', 0, 24, '형용사', '[
    {"en":"They have a large family.","ko":"그들은 대가족이다."},
    {"en":"The museum has a large collection of paintings.","ko":"그 박물관은 방대한 그림 컬렉션을 가지고 있다."},
    {"en":"We need a large box for these books.","ko":"우리는 이 책들을 위해 큰 상자가 필요하다."}
  ]'::jsonb),
  ('high', 0, 24, '형용사', '[
    {"en":"The mountain is very high.","ko":"그 산은 매우 높다."},
    {"en":"She jumped high in the air.","ko":"그녀는 공중으로 높이 뛰었다."},
    {"en":"He got a high score on the test.","ko":"그는 시험에서 높은 점수를 받았다."}
  ]'::jsonb),
  ('low', 0, 24, '형용사', '[
    {"en":"The table is quite low.","ko":"그 탁자는 꽤 낮다."},
    {"en":"She spoke in a low voice.","ko":"그녀는 낮은 목소리로 말했다."},
    {"en":"The price of the ticket is low.","ko":"그 표의 가격은 낮다."}
  ]'::jsonb),
  ('deep', 0, 24, '형용사', '[
    {"en":"The lake is very deep.","ko":"그 호수는 매우 깊다."},
    {"en":"He took a deep breath before speaking.","ko":"그는 말하기 전에 깊게 숨을 쉬었다."},
    {"en":"They walked into the deep forest.","ko":"그들은 깊은 숲속으로 걸어 들어갔다."}
  ]'::jsonb),
  ('thick', 0, 24, '형용사', '[
    {"en":"This book is very thick.","ko":"이 책은 매우 두껍다."},
    {"en":"She wore a thick coat in winter.","ko":"그녀는 겨울에 두꺼운 코트를 입었다."},
    {"en":"The soup was thick and warm.","ko":"그 수프는 걸쭉하고 따뜻했다."}
  ]'::jsonb),
  ('flat', 0, 24, '형용사', '[
    {"en":"The ground here is flat.","ko":"이곳의 땅은 평평하다."},
    {"en":"She likes flat shoes for walking.","ko":"그녀는 걷기에 편한 굽 없는 신발을 좋아한다."},
    {"en":"We found a flat rock to sit on.","ko":"우리는 앉을 평평한 바위를 발견했다."}
  ]'::jsonb),
  ('object', 0, 24, '명사', '[
    {"en":"What is that strange object on the desk?","ko":"책상 위에 있는 저 이상한 물체는 무엇이니?"},
    {"en":"She drew several objects in her notebook.","ko":"그녀는 공책에 여러 물체를 그렸다."},
    {"en":"The museum displays ancient objects.","ko":"그 박물관은 고대 물건들을 전시한다."}
  ]'::jsonb),
  ('for example', 0, 24, '부사구', '[
    {"en":"I like fruit, for example, apples and bananas.","ko":"나는 과일을 좋아한다, 예를 들어 사과와 바나나 같은 것들."},
    {"en":"You can join many clubs, for example, the art club.","ko":"너는 많은 동아리에 가입할 수 있다, 예를 들어 미술 동아리 같은 것들."},
    {"en":"Some subjects are difficult, for example, math.","ko":"어떤 과목들은 어렵다, 예를 들어 수학처럼."}
  ]'::jsonb),
  ('a kind of', 0, 24, '형용사구', '[
    {"en":"A dolphin is a kind of animal.","ko":"돌고래는 동물의 한 종류이다."},
    {"en":"This is a kind of traditional food.","ko":"이것은 전통 음식의 한 종류이다."},
    {"en":"Rugby is a kind of sport.","ko":"럭비는 스포츠의 한 종류이다."}
  ]'::jsonb),
  ('number', 0, 25, '명사', '[
    {"en":"What is your phone number?","ko":"네 전화번호가 뭐니?"},
    {"en":"A large number of students joined the club.","ko":"많은 수의 학생들이 그 동아리에 가입했다."},
    {"en":"She wrote the number on the board.","ko":"그녀는 칠판에 숫자를 썼다."}
  ]'::jsonb),
  ('some', 0, 25, '형용사', '[
    {"en":"I need some water.","ko":"나는 물이 좀 필요하다."},
    {"en":"Some students stayed late to study.","ko":"몇몇 학생들은 늦게까지 남아 공부했다."},
    {"en":"She gave me some good advice.","ko":"그녀는 나에게 좋은 조언을 좀 해주었다."}
  ]'::jsonb),
  ('each', 0, 25, '형용사', '[
    {"en":"Each student has a locker.","ko":"각 학생은 사물함을 가지고 있다."},
    {"en":"We gave a gift to each guest.","ko":"우리는 각 손님에게 선물을 주었다."},
    {"en":"Each day is a new chance.","ko":"매일매일이 새로운 기회이다."}
  ]'::jsonb),
  ('every', 0, 25, '형용사', '[
    {"en":"I brush my teeth every morning.","ko":"나는 매일 아침 이를 닦는다."},
    {"en":"Every student must wear a school uniform.","ko":"모든 학생은 교복을 입어야 한다."},
    {"en":"She calls her mother every week.","ko":"그녀는 매주 어머니께 전화한다."}
  ]'::jsonb),
  ('all', 0, 25, '형용사', '[
    {"en":"All the students passed the test.","ko":"모든 학생이 시험에 합격했다."},
    {"en":"We spent all day at the beach.","ko":"우리는 하루 종일 해변에서 보냈다."},
    {"en":"All my friends came to the party.","ko":"내 모든 친구들이 파티에 왔다."}
  ]'::jsonb),
  ('only', 0, 25, '형용사', '[
    {"en":"She is the only girl in her family.","ko":"그녀는 그녀의 가족 중 유일한 딸이다."},
    {"en":"He is the only student who finished early.","ko":"그는 일찍 끝낸 유일한 학생이다."},
    {"en":"This is the only way to solve the problem.","ko":"이것이 그 문제를 풀 수 있는 유일한 방법이다."}
  ]'::jsonb),
  ('many', 0, 25, '형용사', '[
    {"en":"Many students joined the soccer club.","ko":"많은 학생들이 축구 동아리에 가입했다."},
    {"en":"I have many books about animals.","ko":"나는 동물에 관한 책을 많이 가지고 있다."},
    {"en":"There are many flowers in the garden.","ko":"정원에는 많은 꽃이 있다."}
  ]'::jsonb),
  ('much', 0, 25, '형용사', '[
    {"en":"I don''t have much time today.","ko":"나는 오늘 시간이 많지 않다."},
    {"en":"How much water do you drink every day?","ko":"너는 매일 얼마나 많은 물을 마시니?"},
    {"en":"She doesn''t eat much meat.","ko":"그녀는 고기를 많이 먹지 않는다."}
  ]'::jsonb),
  ('half', 0, 25, '명사', '[
    {"en":"I ate half of the apple.","ko":"나는 사과의 반을 먹었다."},
    {"en":"Half the students went home early.","ko":"학생들의 절반이 일찍 집에 갔다."},
    {"en":"The movie was half over when we arrived.","ko":"우리가 도착했을 때 영화는 반쯤 끝나 있었다."}
  ]'::jsonb),
  ('add', 0, 25, '동사', '[
    {"en":"Add some sugar to the tea.","ko":"차에 설탕을 좀 넣어라."},
    {"en":"Please add your name to the list.","ko":"명단에 네 이름을 추가해 줘."},
    {"en":"She added two more sentences to her report.","ko":"그녀는 보고서에 문장 두 개를 더 추가했다."}
  ]'::jsonb),
  ('empty', 0, 25, '형용사', '[
    {"en":"The classroom was empty after school.","ko":"방과 후 교실은 비어 있었다."},
    {"en":"My water bottle is empty.","ko":"내 물병이 비어 있다."},
    {"en":"We found an empty seat on the bus.","ko":"우리는 버스에서 빈 자리를 발견했다."}
  ]'::jsonb),
  ('fill', 0, 25, '동사', '[
    {"en":"Please fill the bottle with water.","ko":"물병을 물로 채워 주세요."},
    {"en":"She filled the basket with fresh fruit.","ko":"그녀는 바구니를 신선한 과일로 채웠다."},
    {"en":"The students filled the hall for the concert.","ko":"학생들이 콘서트를 위해 강당을 가득 채웠다."}
  ]'::jsonb),
  ('count', 0, 25, '동사', '[
    {"en":"Can you count from one to ten?","ko":"너는 1부터 10까지 셀 수 있니?"},
    {"en":"She counted the number of books on the shelf.","ko":"그녀는 선반 위 책의 수를 셌다."},
    {"en":"We counted the days until vacation.","ko":"우리는 방학까지 남은 날들을 세었다."}
  ]'::jsonb),
  ('enough', 0, 25, '형용사', '[
    {"en":"We don''t have enough time.","ko":"우리는 충분한 시간이 없다."},
    {"en":"She has enough money to buy the book.","ko":"그녀는 그 책을 살 만큼 충분한 돈이 있다."},
    {"en":"Is there enough food for everyone?","ko":"모두를 위한 충분한 음식이 있나요?"}
  ]'::jsonb),
  ('total', 0, 25, '형용사', '[
    {"en":"The total number of students is two hundred.","ko":"학생 총 수는 200명이다."},
    {"en":"What is the total price of these items?","ko":"이 물건들의 총 가격은 얼마인가요?"},
    {"en":"The total score was higher than expected.","ko":"총점은 예상보다 높았다."}
  ]'::jsonb),
  ('piece', 0, 25, '명사', '[
    {"en":"Can I have a piece of cake?","ko":"케이크 한 조각 먹어도 될까?"},
    {"en":"She gave me a piece of good advice.","ko":"그녀는 나에게 좋은 조언 한 가지를 해주었다."},
    {"en":"He picked up a piece of paper from the floor.","ko":"그는 바닥에서 종이 한 장을 집어 들었다."}
  ]'::jsonb),
  ('nothing', 0, 25, '대명사', '[
    {"en":"There is nothing in the box.","ko":"상자 안에는 아무것도 없다."},
    {"en":"I have nothing to do this weekend.","ko":"나는 이번 주말에 할 일이 아무것도 없다."},
    {"en":"Nothing is more important than health.","ko":"건강보다 더 중요한 것은 없다."}
  ]'::jsonb),
  ('a lot of', 0, 25, '형용사구', '[
    {"en":"She has a lot of friends at school.","ko":"그녀는 학교에 친구가 많다."},
    {"en":"We drank a lot of water after the game.","ko":"우리는 경기 후에 물을 많이 마셨다."},
    {"en":"There is a lot of snow outside.","ko":"밖에 눈이 많이 쌓여 있다."}
  ]'::jsonb),
  ('a few', 0, 25, '형용사구', '[
    {"en":"I have a few questions for you.","ko":"너에게 몇 가지 질문이 있다."},
    {"en":"Only a few students came to school early.","ko":"몇몇 학생들만 학교에 일찍 왔다."},
    {"en":"She bought a few apples at the market.","ko":"그녀는 시장에서 사과 몇 개를 샀다."}
  ]'::jsonb),
  ('a little', 0, 25, '형용사구', '[
    {"en":"I know a little Chinese.","ko":"나는 중국어를 조금 안다."},
    {"en":"There is a little milk left in the fridge.","ko":"냉장고에 우유가 조금 남아 있다."},
    {"en":"She felt a little nervous before the test.","ko":"그녀는 시험 전에 조금 긴장했다."}
  ]'::jsonb)
) as t(word, level, study_day, pos, examples)
where v.word = t.word and v.level = t.level and v.study_day = t.study_day;
