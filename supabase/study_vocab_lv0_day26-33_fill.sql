-- SAP 1기 대시보드: Study 탭 — Lv.0(중등 BASIC) Day 26~33 품사/예문 채우기 (160단어).
-- Supabase 대시보드 → SQL Editor에서 실행하세요.

update public.vocab_words v
set part_of_speech = t.pos, example_sentences = t.examples, updated_at = now()
from (values
  ('south', 0, 26, '명사', '[
    {"en":"Busan is in the south of Korea.","ko":"부산은 한국의 남쪽에 있다."},
    {"en":"We drove to the south for our vacation.","ko":"우리는 방학 동안 남쪽으로 차를 몰았다."},
    {"en":"The wind is blowing from the south today.","ko":"오늘은 남쪽에서 바람이 불고 있다."}
  ]'::jsonb),
  ('east', 0, 26, '명사', '[
    {"en":"The sun rises in the east.","ko":"해는 동쪽에서 뜬다."},
    {"en":"Our school is located to the east of the park.","ko":"우리 학교는 공원의 동쪽에 위치해 있다."},
    {"en":"They traveled east to visit their grandparents.","ko":"그들은 조부모님을 방문하기 위해 동쪽으로 여행했다."}
  ]'::jsonb),
  ('west', 0, 26, '명사', '[
    {"en":"The sun sets in the west.","ko":"해는 서쪽으로 진다."},
    {"en":"My uncle lives in the west of the city.","ko":"삼촌은 도시의 서쪽에 사신다."},
    {"en":"We watched the sunset from the west side of the beach.","ko":"우리는 해변의 서쪽에서 노을을 봤다."}
  ]'::jsonb),
  ('north', 0, 26, '명사', '[
    {"en":"Seoul is in the north of Korea.","ko":"서울은 한국의 북쪽에 있다."},
    {"en":"Cold wind comes from the north in winter.","ko":"겨울에는 북쪽에서 찬바람이 분다."},
    {"en":"The birds fly to the north in spring.","ko":"봄에는 새들이 북쪽으로 날아간다."}
  ]'::jsonb),
  ('under', 0, 26, '전치사', '[
    {"en":"The cat is sleeping under the table.","ko":"고양이가 탁자 아래에서 자고 있다."},
    {"en":"We sat under a big tree for lunch.","ko":"우리는 점심을 먹기 위해 큰 나무 아래에 앉았다."},
    {"en":"She put her bag under the chair.","ko":"그녀는 가방을 의자 아래에 두었다."}
  ]'::jsonb),
  ('below', 0, 26, '전치사', '[
    {"en":"The fish swim below the surface of the lake.","ko":"물고기들은 호수 표면 아래에서 헤엄친다."},
    {"en":"Write your name below the title.","ko":"제목 아래에 이름을 쓰세요."},
    {"en":"The temperature dropped below zero last night.","ko":"어젯밤 기온이 영하로 떨어졌다."}
  ]'::jsonb),
  ('behind', 0, 26, '전치사', '[
    {"en":"The dog is hiding behind the sofa.","ko":"개가 소파 뒤에 숨어 있다."},
    {"en":"He parked his car behind the school.","ko":"그는 학교 뒤에 차를 주차했다."},
    {"en":"There is a small garden behind our house.","ko":"우리 집 뒤에는 작은 정원이 있다."}
  ]'::jsonb),
  ('between', 0, 26, '전치사', '[
    {"en":"The park is between the library and the school.","ko":"공원은 도서관과 학교 사이에 있다."},
    {"en":"She sat between her two friends.","ko":"그녀는 두 친구 사이에 앉았다."},
    {"en":"There is a strong friendship between them.","ko":"그들 사이에는 강한 우정이 있다."}
  ]'::jsonb),
  ('center', 0, 26, '명사', '[
    {"en":"The fountain stands in the center of the square.","ko":"분수는 광장 중앙에 서 있다."},
    {"en":"Put the flowers in the center of the table.","ko":"꽃을 탁자 중앙에 놓아라."},
    {"en":"Our school is near the center of the town.","ko":"우리 학교는 마을 중심 근처에 있다."}
  ]'::jsonb),
  ('around', 0, 26, '전치사', '[
    {"en":"The students sat around the campfire.","ko":"학생들은 모닥불 주위에 앉았다."},
    {"en":"We walked around the lake before dinner.","ko":"우리는 저녁 식사 전에 호수 주위를 걸었다."},
    {"en":"There are many shops around the station.","ko":"역 주위에는 많은 가게가 있다."}
  ]'::jsonb),
  ('toward', 0, 26, '전치사', '[
    {"en":"He walked toward the school gate.","ko":"그는 학교 정문을 향해 걸어갔다."},
    {"en":"The ship sailed toward the island.","ko":"배가 그 섬을 향해 항해했다."},
    {"en":"She smiled and ran toward her mother.","ko":"그녀는 미소를 지으며 엄마를 향해 뛰어갔다."}
  ]'::jsonb),
  ('above', 0, 26, '전치사', '[
    {"en":"The plane flew above the clouds.","ko":"비행기가 구름 위로 날았다."},
    {"en":"Hang the picture above the sofa.","ko":"소파 위에 그림을 걸어라."},
    {"en":"The temperature rose above thirty degrees today.","ko":"오늘 기온이 30도 위로 올라갔다."}
  ]'::jsonb),
  ('over', 0, 26, '전치사', '[
    {"en":"The bridge is built over the river.","ko":"다리는 강 위에 건설되어 있다."},
    {"en":"A bird flew over the mountain.","ko":"새 한 마리가 산 위로 날아갔다."},
    {"en":"She threw the ball over the fence.","ko":"그녀는 공을 울타리 너머로 던졌다."}
  ]'::jsonb),
  ('far', 0, 26, '형용사/부사', '[
    {"en":"The museum is not far from here.","ko":"그 박물관은 여기서 멀지 않다."},
    {"en":"How far is it to the airport?","ko":"공항까지 얼마나 먼가요?"},
    {"en":"We don''t live far from school.","ko":"우리는 학교에서 멀지 않은 곳에 산다."}
  ]'::jsonb),
  ('inside', 0, 26, '전치사', '[
    {"en":"The children played inside the house because of the rain.","ko":"아이들은 비 때문에 집 안에서 놀았다."},
    {"en":"There is a small note inside the box.","ko":"상자 안에 작은 쪽지가 있다."},
    {"en":"Let''s wait inside the station.","ko":"역 안에서 기다리자."}
  ]'::jsonb),
  ('outside', 0, 26, '전치사', '[
    {"en":"The kids are playing outside the classroom.","ko":"아이들이 교실 밖에서 놀고 있다."},
    {"en":"It was raining outside all day.","ko":"밖에는 하루 종일 비가 내리고 있었다."},
    {"en":"We left our shoes outside the door.","ko":"우리는 신발을 문 밖에 두었다."}
  ]'::jsonb),
  ('top', 0, 26, '명사', '[
    {"en":"We climbed to the top of the mountain.","ko":"우리는 산 정상까지 올라갔다."},
    {"en":"Write your name at the top of the page.","ko":"페이지 맨 위에 이름을 써라."},
    {"en":"There is a flag on top of the building.","ko":"건물 꼭대기에 깃발이 있다."}
  ]'::jsonb),
  ('bottom', 0, 26, '명사', '[
    {"en":"The key is at the bottom of my bag.","ko":"열쇠는 내 가방 맨 아래에 있다."},
    {"en":"Fish swim near the bottom of the lake.","ko":"물고기는 호수 바닥 근처에서 헤엄친다."},
    {"en":"Sign your name at the bottom of the form.","ko":"양식 맨 아래에 서명하세요."}
  ]'::jsonb),
  ('next to', 0, 26, '전치사구', '[
    {"en":"The bank is next to the bookstore.","ko":"은행은 서점 옆에 있다."},
    {"en":"She sat next to her best friend.","ko":"그녀는 가장 친한 친구 옆에 앉았다."},
    {"en":"There is a small park next to my house.","ko":"우리 집 옆에는 작은 공원이 있다."}
  ]'::jsonb),
  ('in front of', 0, 26, '전치사구', '[
    {"en":"Let''s meet in front of the school.","ko":"학교 앞에서 만나자."},
    {"en":"A tall tree stands in front of the library.","ko":"도서관 앞에는 큰 나무가 서 있다."},
    {"en":"He was waiting in front of the station.","ko":"그는 역 앞에서 기다리고 있었다."}
  ]'::jsonb),
  ('map', 0, 27, '명사', '[
    {"en":"Can you show me on the map?","ko":"지도에서 보여줄 수 있나요?"},
    {"en":"We used a map to find the museum.","ko":"우리는 박물관을 찾기 위해 지도를 사용했다."},
    {"en":"The teacher drew a map of the school.","ko":"선생님은 학교 지도를 그렸다."}
  ]'::jsonb),
  ('vacation', 0, 27, '명사', '[
    {"en":"We are going to Jeju Island for our vacation.","ko":"우리는 방학 동안 제주도에 갈 것이다."},
    {"en":"How was your summer vacation?","ko":"여름 방학은 어땠니?"},
    {"en":"I read many books during the vacation.","ko":"나는 방학 동안 많은 책을 읽었다."}
  ]'::jsonb),
  ('beach', 0, 27, '명사', '[
    {"en":"We built a sandcastle on the beach.","ko":"우리는 해변에서 모래성을 쌓았다."},
    {"en":"The beach was crowded in the summer.","ko":"여름에는 해변이 붐볐다."},
    {"en":"They walked along the beach at sunset.","ko":"그들은 노을 질 때 해변을 따라 걸었다."}
  ]'::jsonb),
  ('trip', 0, 27, '명사', '[
    {"en":"Our class trip to the science museum was fun.","ko":"우리 반의 과학 박물관 견학은 재미있었다."},
    {"en":"We are planning a trip to the mountains.","ko":"우리는 산으로 여행을 계획하고 있다."},
    {"en":"The trip took about three hours.","ko":"그 여행은 약 세 시간이 걸렸다."}
  ]'::jsonb),
  ('tour', 0, 27, '명사', '[
    {"en":"We went on a tour of the old palace.","ko":"우리는 옛 궁전을 관광했다."},
    {"en":"The guide gave us a tour of the city.","ko":"안내원이 우리에게 도시를 관광시켜 주었다."},
    {"en":"The school offers a tour for new students.","ko":"학교는 신입생을 위한 투어를 제공한다."}
  ]'::jsonb),
  ('travel', 0, 27, '동사', '[
    {"en":"My family loves to travel in summer.","ko":"우리 가족은 여름에 여행하는 것을 좋아한다."},
    {"en":"We traveled by train to the countryside.","ko":"우리는 기차를 타고 시골로 여행했다."},
    {"en":"She wants to travel around the world someday.","ko":"그녀는 언젠가 세계를 여행하고 싶어 한다."}
  ]'::jsonb),
  ('backpack', 0, 27, '명사', '[
    {"en":"He packed his backpack for the trip.","ko":"그는 여행을 위해 배낭을 쌌다."},
    {"en":"My backpack is full of books.","ko":"내 배낭은 책으로 가득 차 있다."},
    {"en":"She carried a small backpack to school.","ko":"그녀는 작은 배낭을 메고 학교에 갔다."}
  ]'::jsonb),
  ('climb', 0, 27, '동사', '[
    {"en":"We climbed the hill behind our school.","ko":"우리는 학교 뒤의 언덕을 올라갔다."},
    {"en":"He loves to climb mountains on weekends.","ko":"그는 주말에 산에 오르는 것을 좋아한다."},
    {"en":"The children climbed up the tree.","ko":"아이들은 나무 위로 올라갔다."}
  ]'::jsonb),
  ('leave', 0, 27, '동사', '[
    {"en":"We will leave for the airport at six.","ko":"우리는 6시에 공항으로 떠날 것이다."},
    {"en":"She left her umbrella at school.","ko":"그녀는 학교에 우산을 놓고 갔다."},
    {"en":"The bus leaves every hour.","ko":"버스는 매시간 떠난다."}
  ]'::jsonb),
  ('arrive', 0, 27, '동사', '[
    {"en":"We arrived at the hotel late at night.","ko":"우리는 밤 늦게 호텔에 도착했다."},
    {"en":"The train will arrive in ten minutes.","ko":"기차는 10분 후에 도착할 것이다."},
    {"en":"She arrived early for the meeting.","ko":"그녀는 회의에 일찍 도착했다."}
  ]'::jsonb),
  ('return', 0, 27, '동사', '[
    {"en":"We will return home next Sunday.","ko":"우리는 다음 주 일요일에 집으로 돌아올 것이다."},
    {"en":"He returned the book to the library.","ko":"그는 도서관에 책을 반납했다."},
    {"en":"She returned from her trip with many photos.","ko":"그녀는 많은 사진을 가지고 여행에서 돌아왔다."}
  ]'::jsonb),
  ('guide', 0, 27, '명사', '[
    {"en":"The guide showed us around the museum.","ko":"안내원이 우리에게 박물관을 안내해 주었다."},
    {"en":"We followed the guide''s instructions carefully.","ko":"우리는 안내원의 지시를 주의 깊게 따랐다."},
    {"en":"This guide book is very helpful for tourists.","ko":"이 안내서는 관광객들에게 매우 도움이 된다."}
  ]'::jsonb),
  ('tourist', 0, 27, '명사', '[
    {"en":"Many tourists visit this beach every summer.","ko":"매년 여름 많은 관광객이 이 해변을 방문한다."},
    {"en":"The tourist asked me for directions.","ko":"그 관광객은 나에게 길을 물었다."},
    {"en":"This small town is popular among tourists.","ko":"이 작은 마을은 관광객들 사이에서 인기가 있다."}
  ]'::jsonb),
  ('view', 0, 27, '명사', '[
    {"en":"We enjoyed the beautiful view from the mountain.","ko":"우리는 산에서 아름다운 전망을 즐겼다."},
    {"en":"The hotel room has a nice view of the sea.","ko":"그 호텔 방은 바다 전망이 좋다."},
    {"en":"Everyone has a different view on the plan.","ko":"모두가 그 계획에 대해 다른 견해를 가지고 있다."}
  ]'::jsonb),
  ('memory', 0, 27, '명사', '[
    {"en":"This photo brings back happy memories.","ko":"이 사진은 행복한 추억을 떠올리게 한다."},
    {"en":"I have good memories of my childhood.","ko":"나는 어린 시절의 좋은 추억을 가지고 있다."},
    {"en":"We made great memories on our trip.","ko":"우리는 여행에서 멋진 추억을 만들었다."}
  ]'::jsonb),
  ('exciting', 0, 27, '형용사', '[
    {"en":"The soccer match was really exciting.","ko":"그 축구 경기는 정말 흥미진진했다."},
    {"en":"We had an exciting adventure in the forest.","ko":"우리는 숲에서 신나는 모험을 했다."},
    {"en":"It was an exciting day for the students.","ko":"학생들에게 신나는 하루였다."}
  ]'::jsonb),
  ('adventure', 0, 27, '명사', '[
    {"en":"The book is about a boy''s trip and his adventure in the jungle.","ko":"그 책은 한 소년의 여행과 정글 모험에 관한 것이다."},
    {"en":"We went on an adventure in the mountains.","ko":"우리는 산에서 모험을 했다."},
    {"en":"Life is full of small adventures.","ko":"인생은 작은 모험들로 가득하다."}
  ]'::jsonb),
  ('pack', 0, 27, '동사', '[
    {"en":"She packed her bag the night before the trip.","ko":"그녀는 여행 전날 밤 가방을 쌌다."},
    {"en":"Don''t forget to pack your camera.","ko":"카메라 챙기는 것을 잊지 마라."},
    {"en":"We packed some snacks for the hike.","ko":"우리는 하이킹을 위해 간식을 좀 챙겼다."}
  ]'::jsonb),
  ('get to', 0, 27, '동사구', '[
    {"en":"How do we get to the museum?","ko":"박물관까지 어떻게 가나요?"},
    {"en":"We got to the station just in time.","ko":"우리는 딱 맞춰 역에 도착했다."},
    {"en":"It took two hours to get to the beach.","ko":"해변까지 가는 데 두 시간이 걸렸다."}
  ]'::jsonb),
  ('take a walk', 0, 27, '동사구', '[
    {"en":"Let''s take a walk in the park.","ko":"공원에서 산책을 하자."},
    {"en":"We took a walk along the river.","ko":"우리는 강을 따라 산책을 했다."},
    {"en":"She takes a walk every morning.","ko":"그녀는 매일 아침 산책을 한다."}
  ]'::jsonb),
  ('sport', 0, 28, '명사', '[
    {"en":"Soccer is my favorite sport.","ko":"축구는 내가 가장 좋아하는 스포츠이다."},
    {"en":"He plays many kinds of sports.","ko":"그는 여러 종류의 스포츠를 한다."},
    {"en":"Swimming is a good sport for your health.","ko":"수영은 건강에 좋은 운동이다."}
  ]'::jsonb),
  ('race', 0, 28, '명사', '[
    {"en":"She won first place in the race.","ko":"그녀는 경주에서 1등을 했다."},
    {"en":"The runners lined up for the race.","ko":"주자들이 경주를 위해 줄을 섰다."},
    {"en":"We watched an exciting bike race yesterday.","ko":"우리는 어제 흥미진진한 자전거 경주를 봤다."}
  ]'::jsonb),
  ('baseball', 0, 28, '명사', '[
    {"en":"He plays baseball every Saturday.","ko":"그는 매주 토요일에 야구를 한다."},
    {"en":"Our school has a baseball team.","ko":"우리 학교는 야구팀이 있다."},
    {"en":"We watched a baseball game at the stadium.","ko":"우리는 경기장에서 야구 경기를 봤다."}
  ]'::jsonb),
  ('basketball', 0, 28, '명사', '[
    {"en":"They are playing basketball in the gym.","ko":"그들은 체육관에서 농구를 하고 있다."},
    {"en":"My brother is good at basketball.","ko":"내 남동생은 농구를 잘한다."},
    {"en":"We practice basketball after school.","ko":"우리는 방과 후에 농구를 연습한다."}
  ]'::jsonb),
  ('soccer', 0, 28, '명사', '[
    {"en":"The boys are playing soccer in the playground.","ko":"소년들이 운동장에서 축구를 하고 있다."},
    {"en":"She scored a goal in the soccer match.","ko":"그녀는 축구 경기에서 골을 넣었다."},
    {"en":"Soccer is popular all around the world.","ko":"축구는 전 세계적으로 인기가 있다."}
  ]'::jsonb),
  ('catch', 0, 28, '동사', '[
    {"en":"He caught the ball with one hand.","ko":"그는 한 손으로 공을 잡았다."},
    {"en":"Try to catch the frisbee.","ko":"프리스비를 잡아 봐."},
    {"en":"The dog caught the flying disc.","ko":"개가 날아오는 원반을 잡았다."}
  ]'::jsonb),
  ('win', 0, 28, '동사', '[
    {"en":"Our team won the game yesterday.","ko":"우리 팀은 어제 경기에서 이겼다."},
    {"en":"She trained hard to win the race.","ko":"그녀는 경주에서 이기기 위해 열심히 훈련했다."},
    {"en":"They hope to win the contest this year.","ko":"그들은 올해 대회에서 우승하기를 바란다."}
  ]'::jsonb),
  ('lose', 0, 28, '동사', '[
    {"en":"We don''t want to lose this match.","ko":"우리는 이 경기에서 지고 싶지 않다."},
    {"en":"He lost his ticket on the way to school.","ko":"그는 학교 가는 길에 표를 잃어버렸다."},
    {"en":"Our team lost the game by one point.","ko":"우리 팀은 1점 차로 경기에서 졌다."}
  ]'::jsonb),
  ('stadium', 0, 28, '명사', '[
    {"en":"The stadium was full of cheering fans.","ko":"경기장은 응원하는 팬들로 가득 찼다."},
    {"en":"We took the subway to the stadium.","ko":"우리는 지하철을 타고 경기장에 갔다."},
    {"en":"The new stadium can hold thousands of people.","ko":"그 새 경기장은 수천 명을 수용할 수 있다."}
  ]'::jsonb),
  ('cheer', 0, 28, '동사', '[
    {"en":"We cheered for our school team.","ko":"우리는 우리 학교 팀을 응원했다."},
    {"en":"The fans cheered loudly when he scored.","ko":"그가 득점했을 때 팬들은 크게 환호했다."},
    {"en":"Everyone cheered for the runners.","ko":"모두가 주자들을 응원했다."}
  ]'::jsonb),
  ('practice', 0, 28, '동사', '[
    {"en":"She practices the piano every evening.","ko":"그녀는 매일 저녁 피아노를 연습한다."},
    {"en":"We need to practice more before the match.","ko":"우리는 경기 전에 더 연습해야 한다."},
    {"en":"He practices soccer with his friends on weekends.","ko":"그는 주말마다 친구들과 축구 연습을 한다."}
  ]'::jsonb),
  ('rule', 0, 28, '명사', '[
    {"en":"Please follow the rules of the game.","ko":"게임의 규칙을 따라 주세요."},
    {"en":"The teacher explained the classroom rules.","ko":"선생님은 교실 규칙을 설명했다."},
    {"en":"It is against the rules to be late.","ko":"지각하는 것은 규칙에 어긋난다."}
  ]'::jsonb),
  ('player', 0, 28, '명사', '[
    {"en":"He is the best player on the team.","ko":"그는 팀에서 최고의 선수이다."},
    {"en":"Each player wore a different number.","ko":"각 선수는 다른 번호를 달았다."},
    {"en":"The young player scored two goals.","ko":"그 어린 선수는 두 골을 넣었다."}
  ]'::jsonb),
  ('teamwork', 0, 28, '명사', '[
    {"en":"Good teamwork helped us win the game.","ko":"좋은 팀워크가 우리가 경기에서 이기도록 도왔다."},
    {"en":"Teamwork is important in group projects.","ko":"팀워크는 그룹 프로젝트에서 중요하다."},
    {"en":"The coach always talks about teamwork.","ko":"코치는 항상 팀워크에 대해 이야기한다."}
  ]'::jsonb),
  ('match', 0, 28, '명사', '[
    {"en":"The soccer match starts at four o''clock.","ko":"축구 경기는 4시에 시작한다."},
    {"en":"We watched an exciting basketball match.","ko":"우리는 흥미진진한 농구 경기를 봤다."},
    {"en":"The two teams will play a match tomorrow.","ko":"두 팀은 내일 경기를 할 것이다."}
  ]'::jsonb),
  ('hold', 0, 28, '동사', '[
    {"en":"The school holds a sports day every fall.","ko":"학교는 매년 가을 운동회를 개최한다."},
    {"en":"She held her little brother''s hand.","ko":"그녀는 남동생의 손을 잡았다."},
    {"en":"They will hold the contest next week.","ko":"그들은 다음 주에 대회를 개최할 것이다."}
  ]'::jsonb),
  ('score', 0, 28, '명사', '[
    {"en":"What was the final score of the game?","ko":"경기의 최종 점수는 몇 대 몇이었나요?"},
    {"en":"He got a high score on the test.","ko":"그는 시험에서 높은 점수를 받았다."},
    {"en":"The score was tied until the last minute.","ko":"점수는 마지막 순간까지 동점이었다."}
  ]'::jsonb),
  ('possible', 0, 28, '형용사', '[
    {"en":"Is it possible to finish this today?","ko":"오늘 이것을 끝내는 게 가능할까요?"},
    {"en":"We will do our best if possible.","ko":"가능하다면 우리는 최선을 다할 것이다."},
    {"en":"It is possible to win if we practice hard.","ko":"열심히 연습하면 이길 수 있다."}
  ]'::jsonb),
  ('work out', 0, 28, '동사구', '[
    {"en":"He works out at the gym every morning.","ko":"그는 매일 아침 체육관에서 운동한다."},
    {"en":"I try to work out three times a week.","ko":"나는 일주일에 세 번 운동하려고 노력한다."},
    {"en":"She works out to stay healthy.","ko":"그녀는 건강을 유지하기 위해 운동한다."}
  ]'::jsonb),
  ('do one''s best', 0, 28, '동사구', '[
    {"en":"Just do your best on the test.","ko":"시험에서 그저 최선을 다해라."},
    {"en":"We did our best but lost the game.","ko":"우리는 최선을 다했지만 경기에서 졌다."},
    {"en":"He always does his best in class.","ko":"그는 항상 수업에서 최선을 다한다."}
  ]'::jsonb),
  ('gift', 0, 29, '명사', '[
    {"en":"She gave me a nice gift for my birthday.","ko":"그녀는 내 생일에 멋진 선물을 주었다."},
    {"en":"We prepared a small gift for our teacher.","ko":"우리는 선생님을 위해 작은 선물을 준비했다."},
    {"en":"Thank you for the wonderful gift.","ko":"멋진 선물 감사합니다."}
  ]'::jsonb),
  ('weekend', 0, 29, '명사', '[
    {"en":"What are you doing this weekend?","ko":"이번 주말에 뭐 할 거니?"},
    {"en":"We usually visit our grandparents on weekends.","ko":"우리는 보통 주말에 조부모님을 방문한다."},
    {"en":"I relaxed at home last weekend.","ko":"나는 지난 주말에 집에서 쉬었다."}
  ]'::jsonb),
  ('birthday', 0, 29, '명사', '[
    {"en":"Happy birthday to you!","ko":"생일 축하해!"},
    {"en":"We had a party for her birthday.","ko":"우리는 그녀의 생일을 위해 파티를 열었다."},
    {"en":"My birthday is in October.","ko":"내 생일은 10월이다."}
  ]'::jsonb),
  ('photo', 0, 29, '명사', '[
    {"en":"Let''s take a photo together.","ko":"함께 사진을 찍자."},
    {"en":"She showed me photos of her trip.","ko":"그녀는 나에게 여행 사진을 보여주었다."},
    {"en":"This is my favorite photo of my family.","ko":"이것은 우리 가족 사진 중 내가 가장 좋아하는 것이다."}
  ]'::jsonb),
  ('special', 0, 29, '형용사', '[
    {"en":"Today is a special day for our school.","ko":"오늘은 우리 학교에 특별한 날이다."},
    {"en":"She made a special cake for the party.","ko":"그녀는 파티를 위해 특별한 케이크를 만들었다."},
    {"en":"He has a special talent for drawing.","ko":"그는 그림 그리는 데 특별한 재능이 있다."}
  ]'::jsonb),
  ('prize', 0, 29, '명사', '[
    {"en":"He won the first prize in the contest.","ko":"그는 대회에서 1등 상을 받았다."},
    {"en":"What is the prize for the winner?","ko":"우승자를 위한 상은 무엇인가요?"},
    {"en":"She received a prize for her essay.","ko":"그녀는 자신의 에세이로 상을 받았다."}
  ]'::jsonb),
  ('festival', 0, 29, '명사', '[
    {"en":"The town festival is held every spring.","ko":"마을 축제는 매년 봄에 열린다."},
    {"en":"We enjoyed the food at the festival.","ko":"우리는 축제에서 음식을 즐겼다."},
    {"en":"Many people gathered for the school festival.","ko":"많은 사람들이 학교 축제를 위해 모였다."}
  ]'::jsonb),
  ('firework', 0, 29, '명사', '[
    {"en":"We watched the fireworks at the festival.","ko":"우리는 축제에서 불꽃놀이를 봤다."},
    {"en":"The fireworks lit up the night sky.","ko":"불꽃놀이가 밤하늘을 밝혔다."},
    {"en":"Everyone cheered when the fireworks began.","ko":"불꽃놀이가 시작되자 모두가 환호했다."}
  ]'::jsonb),
  ('wonderful', 0, 29, '형용사', '[
    {"en":"We had a wonderful time at the beach.","ko":"우리는 해변에서 멋진 시간을 보냈다."},
    {"en":"It was a wonderful surprise for my mom.","ko":"그것은 엄마에게 멋진 깜짝 선물이었다."},
    {"en":"The view from the mountain was wonderful.","ko":"산에서 본 경치는 멋졌다."}
  ]'::jsonb),
  ('holiday', 0, 29, '명사', '[
    {"en":"Chuseok is a special holiday in Korea.","ko":"추석은 한국의 특별한 명절이다."},
    {"en":"We visited our relatives during the holiday.","ko":"우리는 휴일 동안 친척들을 방문했다."},
    {"en":"Schools are closed on national holidays.","ko":"국경일에는 학교가 문을 닫는다."}
  ]'::jsonb),
  ('fair', 0, 29, '명사/형용사', '[
    {"en":"We went to the school fair last week.","ko":"우리는 지난주에 학교 박람회에 갔다."},
    {"en":"There were many booths at the science fair.","ko":"과학 박람회에는 많은 부스가 있었다."},
    {"en":"The town holds a food fair every autumn.","ko":"마을은 매년 가을 음식 박람회를 연다."}
  ]'::jsonb),
  ('party', 0, 29, '명사', '[
    {"en":"We are having a party this Friday.","ko":"우리는 이번 금요일에 파티를 열 것이다."},
    {"en":"She invited her classmates to the party.","ko":"그녀는 반 친구들을 파티에 초대했다."},
    {"en":"The birthday party was a lot of fun.","ko":"생일 파티는 정말 재미있었다."}
  ]'::jsonb),
  ('guest', 0, 29, '명사', '[
    {"en":"We welcomed our guests with a big smile.","ko":"우리는 큰 미소로 손님들을 맞이했다."},
    {"en":"Many guests came to the wedding.","ko":"많은 손님들이 결혼식에 왔다."},
    {"en":"Please treat our guest kindly.","ko":"우리 손님을 친절하게 대해 주세요."}
  ]'::jsonb),
  ('invite', 0, 29, '동사', '[
    {"en":"She invited all her friends to the party.","ko":"그녀는 모든 친구를 파티에 초대했다."},
    {"en":"We will invite our teacher to the event.","ko":"우리는 선생님을 그 행사에 초대할 것이다."},
    {"en":"He was invited to the school festival.","ko":"그는 학교 축제에 초대받았다."}
  ]'::jsonb),
  ('meeting', 0, 29, '명사', '[
    {"en":"We have a class meeting after lunch.","ko":"우리는 점심 식사 후에 학급 회의가 있다."},
    {"en":"The teachers had a meeting this morning.","ko":"선생님들은 오늘 아침 회의를 했다."},
    {"en":"The meeting will start at three.","ko":"회의는 3시에 시작할 것이다."}
  ]'::jsonb),
  ('present', 0, 29, '명사', '[
    {"en":"I bought a present for my father.","ko":"나는 아버지를 위해 선물을 샀다."},
    {"en":"She opened her presents happily.","ko":"그녀는 행복하게 선물을 열었다."},
    {"en":"What present did you get for Christmas?","ko":"크리스마스에 무슨 선물을 받았니?"}
  ]'::jsonb),
  ('volunteer', 0, 29, '명사', '[
    {"en":"He works as a volunteer at the hospital.","ko":"그는 병원에서 자원봉사자로 일한다."},
    {"en":"Many volunteers helped clean the park.","ko":"많은 자원봉사자들이 공원을 청소하는 것을 도왔다."},
    {"en":"She became a volunteer at the animal shelter.","ko":"그녀는 동물 보호소에서 자원봉사자가 되었다."}
  ]'::jsonb),
  ('interview', 0, 29, '명사', '[
    {"en":"The reporter did an interview with the scientist.","ko":"그 기자는 과학자와 인터뷰를 했다."},
    {"en":"I was nervous before my job interview.","ko":"나는 면접 전에 긴장했다."},
    {"en":"The interview lasted about twenty minutes.","ko":"그 인터뷰는 약 20분간 지속되었다."}
  ]'::jsonb),
  ('be going to-v', 0, 29, '동사구', '[
    {"en":"We are going to visit the museum tomorrow.","ko":"우리는 내일 박물관을 방문할 것이다."},
    {"en":"She is going to study English this evening.","ko":"그녀는 오늘 저녁에 영어를 공부할 것이다."},
    {"en":"They are going to hold a party next week.","ko":"그들은 다음 주에 파티를 열 것이다."}
  ]'::jsonb),
  ('take place', 0, 29, '동사구', '[
    {"en":"The festival takes place every October.","ko":"그 축제는 매년 10월에 열린다."},
    {"en":"The meeting will take place in the classroom.","ko":"회의는 교실에서 열릴 것이다."},
    {"en":"The event took place at the stadium.","ko":"그 행사는 경기장에서 열렸다."}
  ]'::jsonb),
  ('swim', 0, 30, '동사', '[
    {"en":"We swim in the pool every summer.","ko":"우리는 매년 여름 수영장에서 수영한다."},
    {"en":"She learned to swim when she was five.","ko":"그녀는 다섯 살 때 수영하는 법을 배웠다."},
    {"en":"He swims fast for his age.","ko":"그는 나이에 비해 수영을 빨리 한다."}
  ]'::jsonb),
  ('read', 0, 30, '동사', '[
    {"en":"I like to read books before bed.","ko":"나는 자기 전에 책 읽는 것을 좋아한다."},
    {"en":"She reads the newspaper every morning.","ko":"그녀는 매일 아침 신문을 읽는다."},
    {"en":"We read a story about a brave dog.","ko":"우리는 용감한 개에 관한 이야기를 읽었다."}
  ]'::jsonb),
  ('draw', 0, 30, '동사', '[
    {"en":"He draws pictures of animals in his notebook.","ko":"그는 공책에 동물 그림을 그린다."},
    {"en":"She loves to draw flowers.","ko":"그녀는 꽃을 그리는 것을 좋아한다."},
    {"en":"We drew a map of our town.","ko":"우리는 우리 마을 지도를 그렸다."}
  ]'::jsonb),
  ('hobby', 0, 30, '명사', '[
    {"en":"My hobby is playing the guitar.","ko":"내 취미는 기타를 치는 것이다."},
    {"en":"What is your favorite hobby?","ko":"네가 가장 좋아하는 취미는 뭐니?"},
    {"en":"Collecting stamps is an interesting hobby.","ko":"우표 수집은 흥미로운 취미이다."}
  ]'::jsonb),
  ('dance', 0, 30, '동사', '[
    {"en":"They danced together at the party.","ko":"그들은 파티에서 함께 춤을 췄다."},
    {"en":"She dances every Saturday afternoon.","ko":"그녀는 매주 토요일 오후에 춤을 춘다."},
    {"en":"We learned to dance in music class.","ko":"우리는 음악 시간에 춤추는 법을 배웠다."}
  ]'::jsonb),
  ('free', 0, 30, '형용사', '[
    {"en":"Are you free this weekend?","ko":"이번 주말에 시간 있니?"},
    {"en":"The concert tickets are free for students.","ko":"학생들에게는 콘서트 표가 무료이다."},
    {"en":"I feel free when I go hiking.","ko":"나는 하이킹을 갈 때 자유로움을 느낀다."}
  ]'::jsonb),
  ('collect', 0, 30, '동사', '[
    {"en":"He collects coins from other countries.","ko":"그는 다른 나라의 동전을 수집한다."},
    {"en":"We collected leaves in the park.","ko":"우리는 공원에서 나뭇잎을 모았다."},
    {"en":"She likes to collect stickers.","ko":"그녀는 스티커를 모으는 것을 좋아한다."}
  ]'::jsonb),
  ('paint', 0, 30, '동사', '[
    {"en":"She painted a picture of the mountains.","ko":"그녀는 산 그림을 그렸다."},
    {"en":"We painted the fence white.","ko":"우리는 울타리를 하얗게 칠했다."},
    {"en":"He paints every weekend as a hobby.","ko":"그는 취미로 매주 주말에 그림을 그린다."}
  ]'::jsonb),
  ('game', 0, 30, '명사', '[
    {"en":"Let''s play a board game.","ko":"보드게임을 하자."},
    {"en":"The children enjoyed the game in the yard.","ko":"아이들은 마당에서 게임을 즐겼다."},
    {"en":"We watched an exciting baseball game.","ko":"우리는 흥미진진한 야구 경기를 봤다."}
  ]'::jsonb),
  ('favorite', 0, 30, '형용사', '[
    {"en":"Pizza is my favorite food.","ko":"피자는 내가 가장 좋아하는 음식이다."},
    {"en":"Who is your favorite singer?","ko":"네가 가장 좋아하는 가수는 누구니?"},
    {"en":"This is my favorite book of all time.","ko":"이것은 내가 지금까지 가장 좋아하는 책이다."}
  ]'::jsonb),
  ('enjoy', 0, 30, '동사', '[
    {"en":"We enjoyed our trip to the countryside.","ko":"우리는 시골 여행을 즐겼다."},
    {"en":"She enjoys reading in her free time.","ko":"그녀는 여가 시간에 책 읽는 것을 즐긴다."},
    {"en":"The kids enjoyed playing in the snow.","ko":"아이들은 눈 속에서 노는 것을 즐겼다."}
  ]'::jsonb),
  ('exercise', 0, 30, '동사', '[
    {"en":"It is important to exercise every day.","ko":"매일 운동하는 것은 중요하다."},
    {"en":"He exercises in the morning before school.","ko":"그는 학교 가기 전 아침에 운동한다."},
    {"en":"We exercise together at the park.","ko":"우리는 공원에서 함께 운동한다."}
  ]'::jsonb),
  ('activity', 0, 30, '명사', '[
    {"en":"Swimming is a good summer activity.","ko":"수영은 좋은 여름 활동이다."},
    {"en":"The school offers many after-school activities.","ko":"학교는 많은 방과 후 활동을 제공한다."},
    {"en":"We planned a fun activity for the weekend.","ko":"우리는 주말을 위한 재미있는 활동을 계획했다."}
  ]'::jsonb),
  ('hiking', 0, 30, '명사', '[
    {"en":"We went hiking in the mountains last fall.","ko":"우리는 지난가을에 산으로 하이킹을 갔다."},
    {"en":"Hiking is a great way to enjoy nature.","ko":"하이킹은 자연을 즐기는 좋은 방법이다."},
    {"en":"My family enjoys hiking on weekends.","ko":"우리 가족은 주말마다 하이킹을 즐긴다."}
  ]'::jsonb),
  ('fishing', 0, 30, '명사', '[
    {"en":"My father and I go fishing every summer.","ko":"아빠와 나는 매년 여름 낚시를 하러 간다."},
    {"en":"Fishing requires a lot of patience.","ko":"낚시는 많은 인내심을 필요로 한다."},
    {"en":"We caught three fish while fishing at the lake.","ko":"우리는 호수에서 낚시하다가 물고기 세 마리를 잡았다."}
  ]'::jsonb),
  ('camping', 0, 30, '명사', '[
    {"en":"We went camping by the river last weekend.","ko":"우리는 지난 주말 강가에서 캠핑을 했다."},
    {"en":"Camping in the mountains is a lot of fun.","ko":"산에서 캠핑하는 것은 아주 재미있다."},
    {"en":"My family goes camping every summer vacation.","ko":"우리 가족은 매년 여름방학에 캠핑을 간다."}
  ]'::jsonb),
  ('outdoor', 0, 30, '형용사', '[
    {"en":"Soccer is a popular outdoor activity.","ko":"축구는 인기 있는 야외 활동이다."},
    {"en":"We enjoy outdoor games in the park.","ko":"우리는 공원에서 야외 게임을 즐긴다."},
    {"en":"The school held an outdoor concert last spring.","ko":"학교는 지난봄에 야외 콘서트를 열었다."}
  ]'::jsonb),
  ('interesting', 0, 30, '형용사', '[
    {"en":"The science class was very interesting today.","ko":"오늘 과학 수업은 매우 흥미로웠다."},
    {"en":"She told us an interesting story about her trip.","ko":"그녀는 우리에게 여행에 관한 흥미로운 이야기를 해주었다."},
    {"en":"This is an interesting book about animals.","ko":"이것은 동물에 관한 흥미로운 책이다."}
  ]'::jsonb),
  ('have fun', 0, 30, '동사구', '[
    {"en":"We had fun at the school festival.","ko":"우리는 학교 축제에서 즐거운 시간을 보냈다."},
    {"en":"The kids are having fun in the pool.","ko":"아이들은 수영장에서 즐거운 시간을 보내고 있다."},
    {"en":"Let''s have fun on our field trip.","ko":"현장 학습에서 즐거운 시간을 보내자."}
  ]'::jsonb),
  ('take a picture of', 0, 30, '동사구', '[
    {"en":"Can you take a picture of us?","ko":"우리 사진 좀 찍어 주시겠어요?"},
    {"en":"She took a picture of the sunset.","ko":"그녀는 노을 사진을 찍었다."},
    {"en":"We took a picture of the whole family.","ko":"우리는 온 가족의 사진을 찍었다."}
  ]'::jsonb),
  ('art', 0, 31, '명사', '[
    {"en":"She is good at art.","ko":"그녀는 미술을 잘한다."},
    {"en":"We have an art class on Mondays.","ko":"우리는 월요일마다 미술 수업이 있다."},
    {"en":"The museum has many pieces of modern art.","ko":"그 박물관에는 많은 현대 미술 작품이 있다."}
  ]'::jsonb),
  ('music', 0, 31, '명사', '[
    {"en":"I love listening to music after school.","ko":"나는 방과 후에 음악 듣는 것을 좋아한다."},
    {"en":"She plays music on the piano every day.","ko":"그녀는 매일 피아노로 음악을 연주한다."},
    {"en":"The music at the festival was wonderful.","ko":"축제의 음악은 훌륭했다."}
  ]'::jsonb),
  ('singer', 0, 31, '명사', '[
    {"en":"She wants to become a famous singer.","ko":"그녀는 유명한 가수가 되고 싶어 한다."},
    {"en":"The singer performed on stage last night.","ko":"그 가수는 어젯밤 무대에서 공연했다."},
    {"en":"My favorite singer released a new song.","ko":"내가 가장 좋아하는 가수가 새 노래를 발표했다."}
  ]'::jsonb),
  ('ticket', 0, 31, '명사', '[
    {"en":"I bought two tickets for the concert.","ko":"나는 콘서트 표 두 장을 샀다."},
    {"en":"Please show your ticket at the door.","ko":"문에서 표를 보여 주세요."},
    {"en":"The movie tickets were cheap this weekend.","ko":"이번 주말 영화표는 저렴했다."}
  ]'::jsonb),
  ('film', 0, 31, '명사', '[
    {"en":"We watched an interesting film last night.","ko":"우리는 어젯밤 흥미로운 영화를 봤다."},
    {"en":"The film is about a young artist.","ko":"그 영화는 한 젊은 예술가에 관한 것이다."},
    {"en":"This film won an award last year.","ko":"이 영화는 작년에 상을 받았다."}
  ]'::jsonb),
  ('story', 0, 31, '명사', '[
    {"en":"She told us a funny story.","ko":"그녀는 우리에게 재미있는 이야기를 해주었다."},
    {"en":"The book has an exciting story.","ko":"그 책은 흥미진진한 이야기를 담고 있다."},
    {"en":"My grandfather tells great stories about his childhood.","ko":"할아버지는 어린 시절에 대한 멋진 이야기를 해주신다."}
  ]'::jsonb),
  ('famous', 0, 31, '형용사', '[
    {"en":"He is a famous artist in Korea.","ko":"그는 한국에서 유명한 화가이다."},
    {"en":"This restaurant is famous for its noodles.","ko":"이 식당은 국수로 유명하다."},
    {"en":"She became famous after the movie came out.","ko":"그녀는 그 영화가 나온 후 유명해졌다."}
  ]'::jsonb),
  ('band', 0, 31, '명사', '[
    {"en":"He plays the guitar in a school band.","ko":"그는 학교 밴드에서 기타를 연주한다."},
    {"en":"The band played three songs at the festival.","ko":"그 밴드는 축제에서 세 곡을 연주했다."},
    {"en":"We started a band with our classmates.","ko":"우리는 반 친구들과 밴드를 결성했다."}
  ]'::jsonb),
  ('actor', 0, 31, '명사', '[
    {"en":"My favorite actor starred in the new film.","ko":"내가 가장 좋아하는 배우가 새 영화에 출연했다."},
    {"en":"He wants to become an actor someday.","ko":"그는 언젠가 배우가 되고 싶어 한다."},
    {"en":"The actor practiced his lines every day.","ko":"그 배우는 매일 대사를 연습했다."}
  ]'::jsonb),
  ('actress', 0, 31, '명사', '[
    {"en":"The actress gave a wonderful performance.","ko":"그 여배우는 훌륭한 연기를 펼쳤다."},
    {"en":"She is my favorite actress.","ko":"그녀는 내가 가장 좋아하는 여배우이다."},
    {"en":"The young actress won an award for her role.","ko":"그 젊은 여배우는 자신의 역할로 상을 받았다."}
  ]'::jsonb),
  ('painting', 0, 31, '명사', '[
    {"en":"This painting shows a quiet village.","ko":"이 그림은 조용한 마을을 보여준다."},
    {"en":"She hung the painting on the wall.","ko":"그녀는 그 그림을 벽에 걸었다."},
    {"en":"We saw many beautiful paintings at the gallery.","ko":"우리는 미술관에서 많은 아름다운 그림을 보았다."}
  ]'::jsonb),
  ('stage', 0, 31, '명사', '[
    {"en":"The singer walked onto the stage.","ko":"가수가 무대 위로 걸어 나왔다."},
    {"en":"She was nervous before going on stage.","ko":"그녀는 무대에 오르기 전에 긴장했다."},
    {"en":"The band performed on a big stage.","ko":"그 밴드는 큰 무대에서 공연했다."}
  ]'::jsonb),
  ('artist', 0, 31, '명사', '[
    {"en":"She wants to be an artist when she grows up.","ko":"그녀는 자라서 화가가 되고 싶어 한다."},
    {"en":"The artist painted a picture of the sea.","ko":"그 화가는 바다 그림을 그렸다."},
    {"en":"My uncle is a talented artist.","ko":"우리 삼촌은 재능 있는 화가이다."}
  ]'::jsonb),
  ('magic', 0, 31, '명사/형용사', '[
    {"en":"The children watched the magic show with wide eyes.","ko":"아이들은 눈을 크게 뜨고 마술 쇼를 봤다."},
    {"en":"He performed magic tricks at the party.","ko":"그는 파티에서 마술을 선보였다."},
    {"en":"There is something magic about the old castle.","ko":"그 오래된 성에는 뭔가 마법 같은 것이 있다."}
  ]'::jsonb),
  ('novel', 0, 31, '명사', '[
    {"en":"She is reading a novel about a young detective.","ko":"그녀는 어린 탐정에 관한 소설을 읽고 있다."},
    {"en":"He wrote his first novel at the age of twenty.","ko":"그는 스무 살에 첫 소설을 썼다."},
    {"en":"This novel is popular among teenagers.","ko":"이 소설은 십대들 사이에서 인기가 있다."}
  ]'::jsonb),
  ('concert', 0, 31, '명사', '[
    {"en":"We went to a concert last Saturday.","ko":"우리는 지난 토요일에 콘서트에 갔다."},
    {"en":"The concert hall was full of fans.","ko":"콘서트홀은 팬들로 가득 찼다."},
    {"en":"She sang at the school concert.","ko":"그녀는 학교 콘서트에서 노래했다."}
  ]'::jsonb),
  ('role', 0, 31, '명사', '[
    {"en":"She played the main role in the school play.","ko":"그녀는 학교 연극에서 주연을 맡았다."},
    {"en":"Teachers play an important role in our lives.","ko":"선생님들은 우리 삶에서 중요한 역할을 한다."},
    {"en":"He got a small role in the movie.","ko":"그는 그 영화에서 작은 역할을 맡았다."}
  ]'::jsonb),
  ('main', 0, 31, '형용사', '[
    {"en":"The main character in the story is a young girl.","ko":"그 이야기의 주인공은 어린 소녀이다."},
    {"en":"What is the main idea of this book?","ko":"이 책의 주된 생각은 무엇인가요?"},
    {"en":"The main event will start at seven.","ko":"주된 행사는 7시에 시작할 것이다."}
  ]'::jsonb),
  ('be over', 0, 31, '동사구', '[
    {"en":"The concert was over by nine o''clock.","ko":"콘서트는 9시에 끝났다."},
    {"en":"The movie will be over soon.","ko":"영화는 곧 끝날 것이다."},
    {"en":"Summer vacation is almost over.","ko":"여름 방학이 거의 끝나간다."}
  ]'::jsonb),
  ('go to the movies', 0, 31, '동사구', '[
    {"en":"Let''s go to the movies this weekend.","ko":"이번 주말에 영화를 보러 가자."},
    {"en":"We go to the movies once a month.","ko":"우리는 한 달에 한 번 영화를 보러 간다."},
    {"en":"She went to the movies with her sister.","ko":"그녀는 언니와 함께 영화를 보러 갔다."}
  ]'::jsonb),
  ('buy', 0, 32, '동사', '[
    {"en":"I want to buy a new backpack.","ko":"나는 새 배낭을 사고 싶다."},
    {"en":"She bought some fruit at the market.","ko":"그녀는 시장에서 과일을 좀 샀다."},
    {"en":"We bought tickets for the concert.","ko":"우리는 콘서트 표를 샀다."}
  ]'::jsonb),
  ('sell', 0, 32, '동사', '[
    {"en":"The store sells fresh bread every morning.","ko":"그 가게는 매일 아침 신선한 빵을 판다."},
    {"en":"He sold his old bike to a friend.","ko":"그는 친구에게 낡은 자전거를 팔았다."},
    {"en":"They sell fruit at the market.","ko":"그들은 시장에서 과일을 판다."}
  ]'::jsonb),
  ('spend', 0, 32, '동사', '[
    {"en":"I spent all my money on books.","ko":"나는 모든 돈을 책에 썼다."},
    {"en":"We spend a lot of time together on weekends.","ko":"우리는 주말마다 함께 많은 시간을 보낸다."},
    {"en":"She spends her allowance carefully.","ko":"그녀는 용돈을 신중하게 쓴다."}
  ]'::jsonb),
  ('list', 0, 32, '명사', '[
    {"en":"She made a shopping list before going to the store.","ko":"그녀는 가게에 가기 전에 쇼핑 목록을 만들었다."},
    {"en":"Check the list before you leave.","ko":"떠나기 전에 목록을 확인해라."},
    {"en":"My name is on the list.","ko":"내 이름이 목록에 있다."}
  ]'::jsonb),
  ('item', 0, 32, '명사', '[
    {"en":"This store has many useful items.","ko":"이 가게에는 유용한 물품이 많다."},
    {"en":"Please put each item in a bag.","ko":"각 물품을 봉투에 넣어 주세요."},
    {"en":"There are ten items on sale today.","ko":"오늘은 열 가지 물품이 할인 중이다."}
  ]'::jsonb),
  ('sale', 0, 32, '명사', '[
    {"en":"The store is having a big sale this week.","ko":"그 가게는 이번 주에 큰 할인 판매를 하고 있다."},
    {"en":"I bought this jacket on sale.","ko":"나는 이 재킷을 할인 판매로 샀다."},
    {"en":"The sale ends this Sunday.","ko":"그 할인 판매는 이번 주 일요일에 끝난다."}
  ]'::jsonb),
  ('store', 0, 32, '명사', '[
    {"en":"We went to the store to buy some snacks.","ko":"우리는 간식을 사러 가게에 갔다."},
    {"en":"The store opens at nine in the morning.","ko":"그 가게는 아침 9시에 문을 연다."},
    {"en":"There is a new store near my house.","ko":"우리 집 근처에 새로운 가게가 있다."}
  ]'::jsonb),
  ('mall', 0, 32, '명사', '[
    {"en":"We went shopping at the mall on Saturday.","ko":"우리는 토요일에 쇼핑몰에서 쇼핑했다."},
    {"en":"The mall has many clothing stores.","ko":"그 쇼핑몰에는 많은 옷 가게가 있다."},
    {"en":"We met our friends at the mall.","ko":"우리는 쇼핑몰에서 친구들을 만났다."}
  ]'::jsonb),
  ('choose', 0, 32, '동사', '[
    {"en":"It''s hard to choose the right gift.","ko":"알맞은 선물을 고르는 것은 어렵다."},
    {"en":"She chose a blue dress for the party.","ko":"그녀는 파티를 위해 파란 드레스를 골랐다."},
    {"en":"You can choose any book you like.","ko":"네가 좋아하는 어떤 책이든 골라도 된다."}
  ]'::jsonb),
  ('pay', 0, 32, '동사', '[
    {"en":"I paid for the movie tickets.","ko":"나는 영화표 값을 지불했다."},
    {"en":"She pays for her lunch every day.","ko":"그녀는 매일 점심값을 지불한다."},
    {"en":"We will pay in cash.","ko":"우리는 현금으로 지불할 것이다."}
  ]'::jsonb),
  ('coupon', 0, 32, '명사', '[
    {"en":"I used a coupon to buy the shoes cheaper.","ko":"나는 신발을 더 싸게 사기 위해 쿠폰을 사용했다."},
    {"en":"She has a coupon for a free drink.","ko":"그녀는 무료 음료 쿠폰을 가지고 있다."},
    {"en":"The store gave us a discount coupon.","ko":"그 가게는 우리에게 할인 쿠폰을 주었다."}
  ]'::jsonb),
  ('waste', 0, 32, '동사', '[
    {"en":"Don''t waste your money on things you don''t need.","ko":"필요 없는 물건에 돈을 낭비하지 마라."},
    {"en":"We should not waste food.","ko":"우리는 음식을 낭비해서는 안 된다."},
    {"en":"He wasted a lot of time looking for his key.","ko":"그는 열쇠를 찾느라 많은 시간을 낭비했다."}
  ]'::jsonb),
  ('price', 0, 32, '명사', '[
    {"en":"The price of the shoes was too high.","ko":"그 신발의 가격은 너무 비쌌다."},
    {"en":"What is the price of this bag?","ko":"이 가방의 가격은 얼마인가요?"},
    {"en":"The price went down during the sale.","ko":"할인 기간 동안 가격이 내려갔다."}
  ]'::jsonb),
  ('expensive', 0, 32, '형용사', '[
    {"en":"This watch is too expensive for me.","ko":"이 시계는 나에게 너무 비싸다."},
    {"en":"The restaurant near the station is expensive.","ko":"역 근처의 그 식당은 비싸다."},
    {"en":"She bought an expensive gift for her mother.","ko":"그녀는 엄마를 위해 비싼 선물을 샀다."}
  ]'::jsonb),
  ('cheap', 0, 32, '형용사', '[
    {"en":"The shoes at this store are cheap.","ko":"이 가게의 신발은 저렴하다."},
    {"en":"We found a cheap and delicious restaurant.","ko":"우리는 저렴하고 맛있는 식당을 찾았다."},
    {"en":"This bag is cheap but good quality.","ko":"이 가방은 저렴하지만 품질이 좋다."}
  ]'::jsonb),
  ('customer', 0, 32, '명사', '[
    {"en":"The store was full of customers.","ko":"그 가게는 손님들로 가득 찼다."},
    {"en":"The clerk was kind to every customer.","ko":"그 점원은 모든 손님에게 친절했다."},
    {"en":"Many customers wait in line during the sale.","ko":"할인 판매 기간에는 많은 손님이 줄을 서서 기다린다."}
  ]'::jsonb),
  ('discount', 0, 32, '명사', '[
    {"en":"We got a discount on our lunch.","ko":"우리는 점심 식사에서 할인을 받았다."},
    {"en":"The store offers a discount for students.","ko":"그 가게는 학생들에게 할인을 제공한다."},
    {"en":"There is a big discount on winter clothes.","ko":"겨울 옷에 큰 할인이 있다."}
  ]'::jsonb),
  ('useful', 0, 32, '형용사', '[
    {"en":"This dictionary is very useful for students.","ko":"이 사전은 학생들에게 매우 유용하다."},
    {"en":"She gave me some useful advice.","ko":"그녀는 나에게 유용한 조언을 해주었다."},
    {"en":"The map was useful during our trip.","ko":"그 지도는 우리 여행 동안 유용했다."}
  ]'::jsonb),
  ('try on', 0, 32, '동사구', '[
    {"en":"Can I try on these shoes?","ko":"이 신발을 신어 봐도 될까요?"},
    {"en":"She tried on several dresses at the store.","ko":"그녀는 가게에서 여러 벌의 드레스를 입어 보았다."},
    {"en":"He tried on the jacket before buying it.","ko":"그는 사기 전에 그 재킷을 입어 보았다."}
  ]'::jsonb),
  ('look around', 0, 32, '동사구', '[
    {"en":"We looked around the market before buying anything.","ko":"우리는 무언가를 사기 전에 시장을 둘러보았다."},
    {"en":"Let''s look around the store first.","ko":"먼저 가게를 둘러보자."},
    {"en":"They looked around the museum for an hour.","ko":"그들은 한 시간 동안 박물관을 둘러보았다."}
  ]'::jsonb),
  ('nurse', 0, 33, '명사', '[
    {"en":"The nurse took care of the patients kindly.","ko":"그 간호사는 환자들을 친절하게 돌보았다."},
    {"en":"My aunt works as a nurse at the hospital.","ko":"우리 이모는 병원에서 간호사로 일한다."},
    {"en":"The nurse checked my temperature.","ko":"간호사가 내 체온을 확인했다."}
  ]'::jsonb),
  ('sick', 0, 33, '형용사', '[
    {"en":"He is sick today and stayed home.","ko":"그는 오늘 아파서 집에 있었다."},
    {"en":"She felt sick after eating too much.","ko":"그녀는 너무 많이 먹은 후에 속이 안 좋았다."},
    {"en":"Many students were sick last week.","ko":"지난주에 많은 학생들이 아팠다."}
  ]'::jsonb),
  ('weak', 0, 33, '형용사', '[
    {"en":"He felt weak after his long illness.","ko":"그는 오랜 병 후에 힘이 없다고 느꼈다."},
    {"en":"The tea was too weak for my taste.","ko":"그 차는 내 입맛에 너무 연했다."},
    {"en":"She was weak from not eating enough.","ko":"그녀는 충분히 먹지 않아서 힘이 없었다."}
  ]'::jsonb),
  ('strong', 0, 33, '형용사', '[
    {"en":"He is strong enough to carry the box.","ko":"그는 그 상자를 들 만큼 힘이 세다."},
    {"en":"Exercise makes your body strong.","ko":"운동은 몸을 튼튼하게 만든다."},
    {"en":"She has a strong will to succeed.","ko":"그녀는 성공하려는 강한 의지가 있다."}
  ]'::jsonb),
  ('fever', 0, 33, '명사', '[
    {"en":"He had a high fever last night.","ko":"그는 어젯밤 고열이 났다."},
    {"en":"The doctor gave her medicine for the fever.","ko":"의사는 그녀에게 열을 위한 약을 주었다."},
    {"en":"I stayed home because of a fever.","ko":"나는 열 때문에 집에 있었다."}
  ]'::jsonb),
  ('cough', 0, 33, '명사/동사', '[
    {"en":"She has a bad cough today.","ko":"그녀는 오늘 심한 기침을 한다."},
    {"en":"He couldn''t sleep because of his cough.","ko":"그는 기침 때문에 잠을 잘 수 없었다."},
    {"en":"The medicine helped stop my cough.","ko":"그 약은 내 기침을 멈추는 데 도움이 되었다."}
  ]'::jsonb),
  ('pain', 0, 33, '명사', '[
    {"en":"She felt a sharp pain in her leg.","ko":"그녀는 다리에 날카로운 통증을 느꼈다."},
    {"en":"He went to the hospital because of the pain.","ko":"그는 통증 때문에 병원에 갔다."},
    {"en":"The medicine eased his pain.","ko":"그 약은 그의 고통을 덜어주었다."}
  ]'::jsonb),
  ('hospital', 0, 33, '명사', '[
    {"en":"My mother works at a hospital.","ko":"우리 엄마는 병원에서 일하신다."},
    {"en":"We visited my grandfather in the hospital.","ko":"우리는 병원에 계신 할아버지를 방문했다."},
    {"en":"The hospital is near the school.","ko":"그 병원은 학교 근처에 있다."}
  ]'::jsonb),
  ('headache', 0, 33, '명사', '[
    {"en":"I have a headache today.","ko":"나는 오늘 두통이 있다."},
    {"en":"She took some medicine for her headache.","ko":"그녀는 두통 때문에 약을 먹었다."},
    {"en":"Loud noise gave him a headache.","ko":"시끄러운 소음이 그에게 두통을 일으켰다."}
  ]'::jsonb),
  ('medicine', 0, 33, '명사', '[
    {"en":"Take this medicine after every meal.","ko":"매 식사 후에 이 약을 드세요."},
    {"en":"The doctor gave me some medicine for my cold.","ko":"의사는 내 감기를 위해 약을 주었다."},
    {"en":"She keeps the medicine in the kitchen.","ko":"그녀는 부엌에 약을 보관한다."}
  ]'::jsonb),
  ('weight', 0, 33, '명사', '[
    {"en":"He lost some weight after exercising every day.","ko":"그는 매일 운동한 후 체중이 좀 줄었다."},
    {"en":"The doctor checked her weight and height.","ko":"의사는 그녀의 체중과 키를 확인했다."},
    {"en":"Try not to worry about your weight too much.","ko":"체중에 대해 너무 걱정하지 않도록 해라."}
  ]'::jsonb),
  ('tired', 0, 33, '형용사', '[
    {"en":"I feel tired after a long day at school.","ko":"나는 학교에서 긴 하루를 보낸 후 피곤함을 느낀다."},
    {"en":"She looked tired after the trip.","ko":"그녀는 여행 후에 피곤해 보였다."},
    {"en":"He was too tired to finish his homework.","ko":"그는 너무 피곤해서 숙제를 끝낼 수 없었다."}
  ]'::jsonb),
  ('hurt', 0, 33, '동사', '[
    {"en":"My foot hurts after the long walk.","ko":"오랫동안 걸은 후 내 발이 아프다."},
    {"en":"She hurt her arm while playing basketball.","ko":"그녀는 농구를 하다가 팔을 다쳤다."},
    {"en":"Does your stomach still hurt?","ko":"아직도 배가 아프니?"}
  ]'::jsonb),
  ('treat', 0, 33, '동사', '[
    {"en":"The doctor treated his cold with medicine.","ko":"의사는 약으로 그의 감기를 치료했다."},
    {"en":"She always treats her friends kindly.","ko":"그녀는 항상 친구들을 친절하게 대한다."},
    {"en":"The nurse treated the small cut on his hand.","ko":"간호사는 그의 손에 난 작은 상처를 치료했다."}
  ]'::jsonb),
  ('relax', 0, 33, '동사', '[
    {"en":"I like to relax by listening to music.","ko":"나는 음악을 들으며 쉬는 것을 좋아한다."},
    {"en":"We relaxed at home during the vacation.","ko":"우리는 방학 동안 집에서 쉬었다."},
    {"en":"Take a deep breath and relax.","ko":"심호흡을 하고 긴장을 풀어라."}
  ]'::jsonb),
  ('advice', 0, 33, '명사', '[
    {"en":"My teacher gave me good advice about studying.","ko":"선생님은 나에게 공부에 대한 좋은 조언을 해주셨다."},
    {"en":"She asked her mother for advice.","ko":"그녀는 엄마에게 조언을 구했다."},
    {"en":"Thank you for your advice.","ko":"조언해 주셔서 감사합니다."}
  ]'::jsonb),
  ('health', 0, 33, '명사', '[
    {"en":"Good sleep is important for your health.","ko":"좋은 수면은 건강에 중요하다."},
    {"en":"He exercises every day to improve his health.","ko":"그는 건강을 향상시키기 위해 매일 운동한다."},
    {"en":"Eating vegetables is good for your health.","ko":"채소를 먹는 것은 건강에 좋다."}
  ]'::jsonb),
  ('stomach', 0, 33, '명사', '[
    {"en":"My stomach hurts after eating too fast.","ko":"너무 빨리 먹은 후에 배가 아프다."},
    {"en":"She has a strong stomach and never gets sick.","ko":"그녀는 위가 튼튼해서 절대 탈이 나지 않는다."},
    {"en":"He held his stomach in pain.","ko":"그는 아파서 배를 움켜쥐었다."}
  ]'::jsonb),
  ('see a doctor', 0, 33, '동사구', '[
    {"en":"You should see a doctor if the fever continues.","ko":"열이 계속되면 병원에 가야 한다."},
    {"en":"He went to see a doctor about his cough.","ko":"그는 기침 때문에 병원에 갔다."},
    {"en":"I need to see a doctor about my headache.","ko":"나는 두통 때문에 병원에 가야 한다."}
  ]'::jsonb),
  ('catch a cold', 0, 33, '동사구', '[
    {"en":"Wear a coat so you don''t catch a cold.","ko":"감기에 걸리지 않도록 코트를 입어라."},
    {"en":"She caught a cold last week.","ko":"그녀는 지난주에 감기에 걸렸다."},
    {"en":"Many students catch a cold in winter.","ko":"많은 학생들이 겨울에 감기에 걸린다."}
  ]'::jsonb)
) as t(word, level, study_day, pos, examples)
where v.word = t.word and v.level = t.level and v.study_day = t.study_day;
