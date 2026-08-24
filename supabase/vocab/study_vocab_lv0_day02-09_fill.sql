-- SAP 1기 대시보드: Study 탭 — Lv.0(중등 BASIC) Day 02~09 품사/예문 채우기 (160단어).
-- Supabase 대시보드 → SQL Editor에서 실행하세요.

update public.vocab_words v
set part_of_speech = t.pos, example_sentences = t.examples, updated_at = now()
from (values
  ('family', 0, 2, '명사', '[
    {"en":"My family goes camping every summer.","ko":"우리 가족은 매년 여름 캠핑을 간다."},
    {"en":"She has a big family with three sisters.","ko":"그녀는 언니가 셋인 대가족이다."},
    {"en":"Family is the most important thing to him.","ko":"가족은 그에게 가장 중요한 것이다."}
  ]'::jsonb),
  ('father', 0, 2, '명사', '[
    {"en":"My father works at a hospital.","ko":"우리 아버지는 병원에서 일하신다."},
    {"en":"He looks just like his father.","ko":"그는 아버지를 꼭 닮았다."},
    {"en":"Her father taught her how to swim.","ko":"그녀의 아버지는 그녀에게 수영하는 법을 가르쳐 주셨다."}
  ]'::jsonb),
  ('mother', 0, 2, '명사', '[
    {"en":"My mother makes delicious pancakes on Sundays.","ko":"우리 어머니는 일요일마다 맛있는 팬케이크를 만드신다."},
    {"en":"His mother works as a nurse.","ko":"그의 어머니는 간호사로 일하신다."},
    {"en":"I love spending time with my mother.","ko":"나는 어머니와 시간을 보내는 것을 좋아한다."}
  ]'::jsonb),
  ('son', 0, 2, '명사', '[
    {"en":"Their son plays soccer every weekend.","ko":"그들의 아들은 주말마다 축구를 한다."},
    {"en":"The old man is proud of his son.","ko":"그 노인은 자신의 아들을 자랑스러워한다."},
    {"en":"Her son wants to be a scientist.","ko":"그녀의 아들은 과학자가 되고 싶어 한다."}
  ]'::jsonb),
  ('daughter', 0, 2, '명사', '[
    {"en":"His daughter is learning to play the piano.","ko":"그의 딸은 피아노 치는 법을 배우고 있다."},
    {"en":"The couple has one daughter and one son.","ko":"그 부부는 딸 하나와 아들 하나가 있다."},
    {"en":"Her daughter draws pictures every day.","ko":"그녀의 딸은 매일 그림을 그린다."}
  ]'::jsonb),
  ('brother', 0, 2, '명사', '[
    {"en":"My brother helps me with my homework.","ko":"우리 오빠는 내 숙제를 도와준다."},
    {"en":"He has an older brother and a younger sister.","ko":"그는 형과 여동생이 있다."},
    {"en":"Her brother is taller than her.","ko":"그녀의 오빠는 그녀보다 키가 크다."}
  ]'::jsonb),
  ('sister', 0, 2, '명사', '[
    {"en":"My sister and I share a room.","ko":"나와 내 여동생은 방을 함께 쓴다."},
    {"en":"She has two younger sisters.","ko":"그녀는 여동생이 둘 있다."},
    {"en":"His sister loves to sing.","ko":"그의 누나는 노래하는 것을 좋아한다."}
  ]'::jsonb),
  ('marry', 0, 2, '동사', '[
    {"en":"They plan to marry next spring.","ko":"그들은 내년 봄에 결혼할 계획이다."},
    {"en":"She will marry her best friend.","ko":"그녀는 가장 친한 친구와 결혼할 것이다."},
    {"en":"My uncle married a kind teacher.","ko":"우리 삼촌은 친절한 선생님과 결혼했다."}
  ]'::jsonb),
  ('husband', 0, 2, '명사', '[
    {"en":"Her husband cooks dinner every Friday.","ko":"그녀의 남편은 금요일마다 저녁을 요리한다."},
    {"en":"My husband and I met in college.","ko":"나의 남편과 나는 대학에서 만났다."},
    {"en":"The woman''s husband is a firefighter.","ko":"그 여자의 남편은 소방관이다."}
  ]'::jsonb),
  ('wife', 0, 2, '명사', '[
    {"en":"His wife teaches English at school.","ko":"그의 아내는 학교에서 영어를 가르친다."},
    {"en":"They visited the wife''s hometown last year.","ko":"그들은 작년에 아내의 고향을 방문했다."},
    {"en":"My grandfather''s wife bakes wonderful bread.","ko":"우리 할아버지의 아내는 훌륭한 빵을 굽는다."}
  ]'::jsonb),
  ('parent(-s)', 0, 2, '명사', '[
    {"en":"My parents always support my dreams.","ko":"우리 부모님은 항상 내 꿈을 응원해 주신다."},
    {"en":"Her parents live in a small village.","ko":"그녀의 부모님은 작은 마을에 사신다."},
    {"en":"The parents came to the school festival.","ko":"그 부모님들은 학교 축제에 오셨다."}
  ]'::jsonb),
  ('uncle', 0, 2, '명사', '[
    {"en":"My uncle lives in Busan.","ko":"우리 삼촌은 부산에 사신다."},
    {"en":"Her uncle gave her a nice gift.","ko":"그녀의 삼촌은 그녀에게 멋진 선물을 주었다."},
    {"en":"I visit my uncle every winter.","ko":"나는 매년 겨울에 삼촌을 방문한다."}
  ]'::jsonb),
  ('aunt', 0, 2, '명사', '[
    {"en":"My aunt is a kind librarian.","ko":"우리 이모는 친절한 사서이다."},
    {"en":"Her aunt makes delicious kimchi.","ko":"그녀의 고모는 맛있는 김치를 만든다."},
    {"en":"We had lunch with my aunt yesterday.","ko":"우리는 어제 이모와 점심을 먹었다."}
  ]'::jsonb),
  ('grandparent(-s)', 0, 2, '명사', '[
    {"en":"I visit my grandparents every weekend.","ko":"나는 주말마다 조부모님을 방문한다."},
    {"en":"My grandparents live in the countryside.","ko":"우리 조부모님은 시골에 사신다."},
    {"en":"Her grandparents told her many old stories.","ko":"그녀의 조부모님은 그녀에게 옛날 이야기를 많이 해 주셨다."}
  ]'::jsonb),
  ('cousin', 0, 2, '명사', '[
    {"en":"My cousin and I go to the same school.","ko":"내 사촌과 나는 같은 학교에 다닌다."},
    {"en":"Her cousin lives in another city.","ko":"그녀의 사촌은 다른 도시에 산다."},
    {"en":"We played games with our cousins.","ko":"우리는 사촌들과 게임을 했다."}
  ]'::jsonb),
  ('member', 0, 2, '명사', '[
    {"en":"Every member of the club helps clean the room.","ko":"동아리의 모든 구성원은 방 청소를 돕는다."},
    {"en":"She became a member of the drama club.","ko":"그녀는 연극 동아리의 회원이 되었다."},
    {"en":"Each family member has a role at home.","ko":"가족 구성원 각자가 집에서 할 역할이 있다."}
  ]'::jsonb),
  ('pet', 0, 2, '명사', '[
    {"en":"My pet is a small brown dog.","ko":"내 반려동물은 작은 갈색 개이다."},
    {"en":"He takes his pet for a walk every morning.","ko":"그는 매일 아침 반려동물을 산책시킨다."},
    {"en":"She wants to have a pet cat.","ko":"그녀는 반려 고양이를 키우고 싶어 한다."}
  ]'::jsonb),
  ('relative', 0, 2, '명사', '[
    {"en":"Many relatives came to the birthday party.","ko":"많은 친척들이 생일 파티에 왔다."},
    {"en":"We visit our relatives during the holidays.","ko":"우리는 명절 동안 친척들을 방문한다."},
    {"en":"She has relatives living in another country.","ko":"그녀는 다른 나라에 사는 친척이 있다."}
  ]'::jsonb),
  ('be born', 0, 2, '동사구', '[
    {"en":"She was born in a small town.","ko":"그녀는 작은 마을에서 태어났다."},
    {"en":"My brother was born in the spring.","ko":"내 남동생은 봄에 태어났다."},
    {"en":"He was born on a snowy day.","ko":"그는 눈 오는 날에 태어났다."}
  ]'::jsonb),
  ('take care of', 0, 2, '동사구', '[
    {"en":"She takes care of her little brother after school.","ko":"그녀는 방과 후에 남동생을 돌본다."},
    {"en":"He takes care of the plants in the garden.","ko":"그는 정원의 식물들을 돌본다."},
    {"en":"We should take care of our pets every day.","ko":"우리는 매일 반려동물을 돌봐야 한다."}
  ]'::jsonb),
  ('friend', 0, 3, '명사', '[
    {"en":"She is my best friend at school.","ko":"그녀는 학교에서 나의 가장 친한 친구이다."},
    {"en":"I made a new friend in class.","ko":"나는 반에서 새 친구를 사귀었다."},
    {"en":"My friend helped me carry the books.","ko":"내 친구는 내가 책을 나르는 것을 도와주었다."}
  ]'::jsonb),
  ('together', 0, 3, '부사', '[
    {"en":"We study together every afternoon.","ko":"우리는 매일 오후 함께 공부한다."},
    {"en":"They walked to school together.","ko":"그들은 함께 학교에 걸어갔다."},
    {"en":"Let''s clean the classroom together.","ko":"교실을 함께 청소하자."}
  ]'::jsonb),
  ('club', 0, 3, '명사', '[
    {"en":"I joined the science club this year.","ko":"나는 올해 과학 동아리에 가입했다."},
    {"en":"Our club meets every Wednesday.","ko":"우리 동아리는 매주 수요일에 모인다."},
    {"en":"She is a member of the music club.","ko":"그녀는 음악 동아리의 회원이다."}
  ]'::jsonb),
  ('join', 0, 3, '동사', '[
    {"en":"He decided to join the soccer team.","ko":"그는 축구팀에 가입하기로 결심했다."},
    {"en":"Would you like to join us for lunch?","ko":"우리와 함께 점심을 드시겠어요?"},
    {"en":"She joined the dance club last week.","ko":"그녀는 지난주에 댄스 동아리에 가입했다."}
  ]'::jsonb),
  ('fight', 0, 3, '동사', '[
    {"en":"The two brothers often fight over toys.","ko":"그 두 형제는 장난감을 두고 자주 다툰다."},
    {"en":"Friends should not fight over small things.","ko":"친구는 사소한 일로 싸우면 안 된다."},
    {"en":"They had a fight but made up quickly.","ko":"그들은 다퉜지만 금방 화해했다."}
  ]'::jsonb),
  ('group', 0, 3, '명사', '[
    {"en":"Our teacher divided the class into groups.","ko":"우리 선생님은 반을 그룹으로 나누셨다."},
    {"en":"A group of students visited the museum.","ko":"한 무리의 학생들이 박물관을 방문했다."},
    {"en":"She works well in a group.","ko":"그녀는 그룹 활동을 잘한다."}
  ]'::jsonb),
  ('classmate', 0, 3, '명사', '[
    {"en":"My classmate sits next to me in class.","ko":"내 반 친구는 수업 시간에 내 옆에 앉는다."},
    {"en":"I share notes with my classmates.","ko":"나는 반 친구들과 필기를 공유한다."},
    {"en":"Our classmates helped clean the classroom together.","ko":"우리 반 친구들은 함께 교실을 청소하는 것을 도왔다."}
  ]'::jsonb),
  ('partner', 0, 3, '명사', '[
    {"en":"Choose a partner for the science project.","ko":"과학 프로젝트를 위해 짝을 골라라."},
    {"en":"My partner and I finished the game first.","ko":"내 짝과 나는 게임을 가장 먼저 끝냈다."},
    {"en":"She was my partner in the dance class.","ko":"그녀는 댄스 수업에서 나의 파트너였다."}
  ]'::jsonb),
  ('alone', 0, 3, '부사', '[
    {"en":"He likes to read alone in his room.","ko":"그는 자기 방에서 혼자 책 읽는 것을 좋아한다."},
    {"en":"She walked home alone yesterday.","ko":"그녀는 어제 혼자 집에 걸어갔다."},
    {"en":"I don''t want to eat lunch alone.","ko":"나는 혼자 점심을 먹고 싶지 않다."}
  ]'::jsonb),
  ('friendship', 0, 3, '명사', '[
    {"en":"Their friendship began in elementary school.","ko":"그들의 우정은 초등학교에서 시작되었다."},
    {"en":"True friendship lasts a long time.","ko":"진정한 우정은 오래 지속된다."},
    {"en":"She values friendship more than money.","ko":"그녀는 돈보다 우정을 소중히 여긴다."}
  ]'::jsonb),
  ('share', 0, 3, '동사', '[
    {"en":"Please share your snacks with your friends.","ko":"친구들과 간식을 나눠 먹으렴."},
    {"en":"We share a locker at school.","ko":"우리는 학교에서 사물함을 함께 쓴다."},
    {"en":"He shared his umbrella with a classmate.","ko":"그는 반 친구와 우산을 함께 썼다."}
  ]'::jsonb),
  ('neighbor', 0, 3, '명사', '[
    {"en":"My neighbor has a friendly dog.","ko":"우리 이웃은 친근한 개를 키운다."},
    {"en":"We often help our neighbors with small tasks.","ko":"우리는 종종 이웃들의 작은 일을 도와준다."},
    {"en":"Her neighbor moved to a new house.","ko":"그녀의 이웃은 새 집으로 이사했다."}
  ]'::jsonb),
  ('favor', 0, 3, '명사', '[
    {"en":"Can I ask you a favor?","ko":"부탁 하나 해도 될까?"},
    {"en":"She did me a big favor yesterday.","ko":"그녀는 어제 나에게 큰 호의를 베풀었다."},
    {"en":"He asked his friend for a favor.","ko":"그는 친구에게 부탁을 했다."}
  ]'::jsonb),
  ('introduce', 0, 3, '동사', '[
    {"en":"Let me introduce my new friend to you.","ko":"제 새 친구를 소개할게요."},
    {"en":"She introduced herself to the class.","ko":"그녀는 반 친구들에게 자기소개를 했다."},
    {"en":"He introduced his family at the meeting.","ko":"그는 모임에서 자신의 가족을 소개했다."}
  ]'::jsonb),
  ('harmony', 0, 3, '명사', '[
    {"en":"The team works together in harmony.","ko":"그 팀은 조화롭게 함께 일한다."},
    {"en":"Music and dance created perfect harmony.","ko":"음악과 춤이 완벽한 조화를 이루었다."},
    {"en":"They live together in harmony with their neighbors.","ko":"그들은 이웃들과 화합하며 함께 산다."}
  ]'::jsonb),
  ('nickname', 0, 3, '명사', '[
    {"en":"His nickname is ''Speedy'' because he runs fast.","ko":"그는 빨리 달려서 별명이 ''스피디''이다."},
    {"en":"My friends gave me a funny nickname.","ko":"친구들이 나에게 재미있는 별명을 지어 주었다."},
    {"en":"What is your nickname at school?","ko":"학교에서 네 별명은 뭐니?"}
  ]'::jsonb),
  ('welcome', 0, 3, '동사', '[
    {"en":"The students welcomed the new teacher warmly.","ko":"학생들은 새 선생님을 따뜻하게 환영했다."},
    {"en":"We welcome new members to our club.","ko":"우리는 새로운 동아리 회원들을 환영한다."},
    {"en":"She welcomed her friend with a big smile.","ko":"그녀는 밝은 미소로 친구를 반겼다."}
  ]'::jsonb),
  ('strange', 0, 3, '형용사', '[
    {"en":"I heard a strange sound outside.","ko":"나는 밖에서 이상한 소리를 들었다."},
    {"en":"The city felt strange to the new student.","ko":"그 도시는 새로운 학생에게 낯설게 느껴졌다."},
    {"en":"He told us a strange story.","ko":"그는 우리에게 이상한 이야기를 해 주었다."}
  ]'::jsonb),
  ('hang out (with)', 0, 3, '동사구', '[
    {"en":"I like to hang out with my friends after school.","ko":"나는 방과 후에 친구들과 어울려 노는 것을 좋아한다."},
    {"en":"We hung out at the park all afternoon.","ko":"우리는 오후 내내 공원에서 시간을 보냈다."},
    {"en":"Do you want to hang out this weekend?","ko":"이번 주말에 함께 시간을 보낼래?"}
  ]'::jsonb),
  ('make fun of', 0, 3, '동사구', '[
    {"en":"You shouldn''t make fun of your classmates.","ko":"반 친구들을 놀리면 안 된다."},
    {"en":"They made fun of his funny hat.","ko":"그들은 그의 우스꽝스러운 모자를 놀렸다."},
    {"en":"She felt sad because they made fun of her.","ko":"그들이 그녀를 놀려서 그녀는 슬펐다."}
  ]'::jsonb),
  ('body', 0, 4, '명사', '[
    {"en":"Exercise keeps your body healthy.","ko":"운동은 몸을 건강하게 유지해 준다."},
    {"en":"The human body has many parts.","ko":"인체는 많은 부분으로 이루어져 있다."},
    {"en":"She stretches her body every morning.","ko":"그녀는 매일 아침 몸을 스트레칭한다."}
  ]'::jsonb),
  ('ear', 0, 4, '명사', '[
    {"en":"Rabbits have very long ears.","ko":"토끼는 귀가 매우 길다."},
    {"en":"He whispered something into her ear.","ko":"그는 그녀의 귀에 무언가를 속삭였다."},
    {"en":"My ear hurts a little today.","ko":"오늘 귀가 조금 아프다."}
  ]'::jsonb),
  ('eye', 0, 4, '명사', '[
    {"en":"She has bright brown eyes.","ko":"그녀는 밝은 갈색 눈을 가지고 있다."},
    {"en":"Close your eyes and make a wish.","ko":"눈을 감고 소원을 빌어봐."},
    {"en":"His eyes were full of excitement.","ko":"그의 눈은 흥분으로 가득했다."}
  ]'::jsonb),
  ('nose', 0, 4, '명사', '[
    {"en":"The dog has a very sensitive nose.","ko":"그 개는 매우 예민한 코를 가지고 있다."},
    {"en":"My nose feels stuffy because of the cold.","ko":"감기 때문에 코가 막힌 느낌이다."},
    {"en":"She touched her nose and laughed.","ko":"그녀는 코를 만지며 웃었다."}
  ]'::jsonb),
  ('mouth', 0, 4, '명사', '[
    {"en":"Cover your mouth when you cough.","ko":"기침할 때는 입을 가리렴."},
    {"en":"He opened his mouth wide to sing.","ko":"그는 노래하려고 입을 크게 벌렸다."},
    {"en":"She smiled with her whole mouth.","ko":"그녀는 입 전체로 활짝 웃었다."}
  ]'::jsonb),
  ('skin', 0, 4, '명사', '[
    {"en":"Wear sunscreen to protect your skin.","ko":"피부를 보호하기 위해 자외선 차단제를 발라라."},
    {"en":"Her skin turned red after the sun.","ko":"그녀의 피부는 햇볕을 쬔 후 빨개졌다."},
    {"en":"Babies have very soft skin.","ko":"아기들은 피부가 매우 부드럽다."}
  ]'::jsonb),
  ('tooth', 0, 4, '명사', '[
    {"en":"Brush your teeth twice a day.","ko":"하루에 두 번 이를 닦아라."},
    {"en":"He lost a tooth while eating an apple.","ko":"그는 사과를 먹다가 이가 빠졌다."},
    {"en":"My tooth hurts when I eat sweets.","ko":"단것을 먹으면 이가 아프다."}
  ]'::jsonb),
  ('tongue', 0, 4, '명사', '[
    {"en":"Stick out your tongue for the doctor.","ko":"의사 선생님을 위해 혀를 내밀어 보세요."},
    {"en":"The ice cream turned her tongue blue.","ko":"아이스크림 때문에 그녀의 혀가 파랗게 되었다."},
    {"en":"He burned his tongue on hot soup.","ko":"그는 뜨거운 국에 혀를 데었다."}
  ]'::jsonb),
  ('head', 0, 4, '명사', '[
    {"en":"She nodded her head in agreement.","ko":"그녀는 동의하며 고개를 끄덕였다."},
    {"en":"He hit his head on the door.","ko":"그는 문에 머리를 부딪쳤다."},
    {"en":"My head hurts after studying all day.","ko":"하루 종일 공부했더니 머리가 아프다."}
  ]'::jsonb),
  ('hair', 0, 4, '명사', '[
    {"en":"She has long black hair.","ko":"그녀는 길고 검은 머리카락을 가지고 있다."},
    {"en":"He cut his hair short this summer.","ko":"그는 이번 여름에 머리를 짧게 잘랐다."},
    {"en":"Her hair looks pretty with a ribbon.","ko":"그녀의 머리는 리본을 하니 예뻐 보인다."}
  ]'::jsonb),
  ('arm', 0, 4, '명사', '[
    {"en":"He broke his arm while skateboarding.","ko":"그는 스케이트보드를 타다가 팔이 부러졌다."},
    {"en":"She waved her arm to say hello.","ko":"그녀는 인사하려고 팔을 흔들었다."},
    {"en":"My arm feels sore after practice.","ko":"연습 후에 팔이 아프다."}
  ]'::jsonb),
  ('shoulder', 0, 4, '명사', '[
    {"en":"He carried the bag on his shoulder.","ko":"그는 가방을 어깨에 메고 다녔다."},
    {"en":"She patted her friend on the shoulder.","ko":"그녀는 친구의 어깨를 토닥였다."},
    {"en":"My shoulder hurts from carrying heavy books.","ko":"무거운 책을 들고 다녀서 어깨가 아프다."}
  ]'::jsonb),
  ('hand', 0, 4, '명사', '[
    {"en":"Raise your hand if you have a question.","ko":"질문이 있으면 손을 들어라."},
    {"en":"She held her little sister''s hand.","ko":"그녀는 여동생의 손을 잡았다."},
    {"en":"Wash your hands before you eat.","ko":"먹기 전에 손을 씻어라."}
  ]'::jsonb),
  ('finger', 0, 4, '명사', '[
    {"en":"He pointed his finger at the map.","ko":"그는 손가락으로 지도를 가리켰다."},
    {"en":"She hurt her finger while cooking.","ko":"그녀는 요리하다가 손가락을 다쳤다."},
    {"en":"Count on your fingers if it helps.","ko":"도움이 되면 손가락으로 세어 보렴."}
  ]'::jsonb),
  ('leg', 0, 4, '명사', '[
    {"en":"He has strong legs from running every day.","ko":"그는 매일 달려서 다리가 튼튼하다."},
    {"en":"She hurt her leg during the soccer game.","ko":"그녀는 축구 경기 중에 다리를 다쳤다."},
    {"en":"The dog has short legs.","ko":"그 개는 다리가 짧다."}
  ]'::jsonb),
  ('knee', 0, 4, '명사', '[
    {"en":"He fell and hurt his knee.","ko":"그는 넘어져서 무릎을 다쳤다."},
    {"en":"She knelt on one knee to tie her shoes.","ko":"그녀는 신발끈을 매려고 한쪽 무릎을 꿇었다."},
    {"en":"My knee hurts after climbing the mountain.","ko":"산을 오른 후에 무릎이 아프다."}
  ]'::jsonb),
  ('foot', 0, 4, '명사', '[
    {"en":"He has a big foot for his age.","ko":"그는 나이에 비해 발이 크다."},
    {"en":"She stepped on my foot by mistake.","ko":"그녀는 실수로 내 발을 밟았다."},
    {"en":"My foot feels tired after the long walk.","ko":"긴 산책 후에 발이 피곤하다."}
  ]'::jsonb),
  ('toe', 0, 4, '명사', '[
    {"en":"She stubbed her toe on the chair.","ko":"그녀는 의자에 발가락을 부딪쳤다."},
    {"en":"He wiggled his toes in the sand.","ko":"그는 모래 속에서 발가락을 꼼지락거렸다."},
    {"en":"My little toe hurts a bit.","ko":"새끼발가락이 조금 아프다."}
  ]'::jsonb),
  ('grow up', 0, 4, '동사구', '[
    {"en":"I want to be a doctor when I grow up.","ko":"나는 자라서 의사가 되고 싶다."},
    {"en":"She grew up in a small village.","ko":"그녀는 작은 마을에서 자랐다."},
    {"en":"Children grow up so fast.","ko":"아이들은 정말 빨리 자란다."}
  ]'::jsonb),
  ('watch out', 0, 4, '동사구', '[
    {"en":"Watch out for cars when you cross the street.","ko":"길을 건널 때 차를 조심해라."},
    {"en":"Watch out! The floor is wet.","ko":"조심해! 바닥이 젖었어."},
    {"en":"He told his little brother to watch out for the dog.","ko":"그는 남동생에게 개를 조심하라고 말했다."}
  ]'::jsonb),
  ('old', 0, 5, '형용사', '[
    {"en":"My grandfather is seventy years old.","ko":"우리 할아버지는 일흔 살이시다."},
    {"en":"This is an old book from the library.","ko":"이것은 도서관에서 빌린 오래된 책이다."},
    {"en":"The old house has a big garden.","ko":"그 오래된 집에는 큰 정원이 있다."}
  ]'::jsonb),
  ('young', 0, 5, '형용사', '[
    {"en":"She looks young for her age.","ko":"그녀는 나이에 비해 어려 보인다."},
    {"en":"Young students learn languages quickly.","ko":"어린 학생들은 언어를 빨리 배운다."},
    {"en":"He was very young when he started playing piano.","ko":"그는 피아노를 시작했을 때 매우 어렸다."}
  ]'::jsonb),
  ('short', 0, 5, '형용사', '[
    {"en":"My little brother is quite short.","ko":"내 남동생은 키가 꽤 작다."},
    {"en":"She wrote a short story for class.","ko":"그녀는 수업을 위해 짧은 이야기를 썼다."},
    {"en":"The trip was short but fun.","ko":"그 여행은 짧았지만 즐거웠다."}
  ]'::jsonb),
  ('tall', 0, 5, '형용사', '[
    {"en":"He is the tallest student in our class.","ko":"그는 우리 반에서 가장 키가 큰 학생이다."},
    {"en":"The tall tree gives us nice shade.","ko":"그 키 큰 나무는 좋은 그늘을 만들어 준다."},
    {"en":"She grew tall over the summer.","ko":"그녀는 여름 동안 키가 컸다."}
  ]'::jsonb),
  ('long', 0, 5, '형용사', '[
    {"en":"She has long, curly hair.","ko":"그녀는 길고 곱슬곱슬한 머리를 가지고 있다."},
    {"en":"It was a long day at school.","ko":"학교에서 긴 하루였다."},
    {"en":"The river is very long.","ko":"그 강은 매우 길다."}
  ]'::jsonb),
  ('pretty', 0, 5, '형용사', '[
    {"en":"The garden looks pretty in spring.","ko":"그 정원은 봄에 예뻐 보인다."},
    {"en":"She wore a pretty dress to the party.","ko":"그녀는 파티에 예쁜 드레스를 입고 왔다."},
    {"en":"That is a pretty flower.","ko":"저것은 예쁜 꽃이다."}
  ]'::jsonb),
  ('ugly', 0, 5, '형용사', '[
    {"en":"He thought the painting was ugly.","ko":"그는 그 그림이 못생겼다고 생각했다."},
    {"en":"The old shoes looked ugly but felt comfortable.","ko":"그 낡은 신발은 보기 흉했지만 편안했다."},
    {"en":"Don''t say a drawing is ugly.","ko":"그림이 못생겼다고 말하지 마라."}
  ]'::jsonb),
  ('handsome', 0, 5, '형용사', '[
    {"en":"The actor looked very handsome on stage.","ko":"그 배우는 무대 위에서 매우 잘생겨 보였다."},
    {"en":"Her brother is tall and handsome.","ko":"그녀의 오빠는 키가 크고 잘생겼다."},
    {"en":"He wore a handsome suit for the photo.","ko":"그는 사진을 위해 멋진 정장을 입었다."}
  ]'::jsonb),
  ('face', 0, 5, '명사', '[
    {"en":"She washed her face before breakfast.","ko":"그녀는 아침 식사 전에 세수를 했다."},
    {"en":"His face turned red with excitement.","ko":"그의 얼굴은 흥분으로 빨개졌다."},
    {"en":"I can see happiness on her face.","ko":"나는 그녀의 얼굴에서 행복을 볼 수 있다."}
  ]'::jsonb),
  ('thin', 0, 5, '형용사', '[
    {"en":"The paper is very thin.","ko":"그 종이는 매우 얇다."},
    {"en":"He became thin after being sick.","ko":"그는 아파서 말랐다."},
    {"en":"She cut the bread into thin slices.","ko":"그녀는 빵을 얇게 썰었다."}
  ]'::jsonb),
  ('fat', 0, 5, '형용사', '[
    {"en":"The cat looks fat and lazy.","ko":"그 고양이는 뚱뚱하고 게을러 보인다."},
    {"en":"Eating too much fast food can make you fat.","ko":"패스트푸드를 너무 많이 먹으면 살이 찔 수 있다."},
    {"en":"The fat book took a week to finish.","ko":"그 두꺼운 책은 다 읽는 데 일주일이 걸렸다."}
  ]'::jsonb),
  ('curly', 0, 5, '형용사', '[
    {"en":"She has curly brown hair.","ko":"그녀는 곱슬곱슬한 갈색 머리를 가지고 있다."},
    {"en":"My little sister wants curly hair like mine.","ko":"내 여동생은 내 머리처럼 곱슬머리를 원한다."},
    {"en":"His curly hair gets messy in the wind.","ko":"그의 곱슬머리는 바람이 불면 헝클어진다."}
  ]'::jsonb),
  ('blond', 0, 5, '형용사', '[
    {"en":"The little girl has blond hair.","ko":"그 어린 소녀는 금발 머리를 가지고 있다."},
    {"en":"Her blond hair shines in the sunlight.","ko":"그녀의 금발 머리는 햇빛에 빛난다."},
    {"en":"He dyed his hair blond last month.","ko":"그는 지난달에 머리를 금발로 염색했다."}
  ]'::jsonb),
  ('change', 0, 5, '동사', '[
    {"en":"She wants to change her hairstyle.","ko":"그녀는 헤어스타일을 바꾸고 싶어 한다."},
    {"en":"The weather can change quickly in spring.","ko":"봄에는 날씨가 빠르게 변할 수 있다."},
    {"en":"He changed his mind about the trip.","ko":"그는 여행에 대한 마음을 바꾸었다."}
  ]'::jsonb),
  ('lovely', 0, 5, '형용사', '[
    {"en":"What a lovely garden this is!","ko":"정말 사랑스러운 정원이구나!"},
    {"en":"She has a lovely smile.","ko":"그녀는 사랑스러운 미소를 가지고 있다."},
    {"en":"We had a lovely time at the picnic.","ko":"우리는 소풍에서 사랑스러운 시간을 보냈다."}
  ]'::jsonb),
  ('cute', 0, 5, '형용사', '[
    {"en":"The puppy looks so cute.","ko":"그 강아지는 정말 귀여워 보인다."},
    {"en":"She wore a cute hat today.","ko":"그녀는 오늘 귀여운 모자를 썼다."},
    {"en":"His little sister is very cute.","ko":"그의 여동생은 매우 귀엽다."}
  ]'::jsonb),
  ('normal', 0, 5, '형용사', '[
    {"en":"It is normal to feel nervous before a test.","ko":"시험 전에 긴장하는 것은 정상이다."},
    {"en":"Everything seems normal at school today.","ko":"오늘 학교는 모든 것이 평소와 같아 보인다."},
    {"en":"He has a normal daily routine.","ko":"그는 평범한 일상을 보낸다."}
  ]'::jsonb),
  ('beautiful', 0, 5, '형용사', '[
    {"en":"The sunset looked beautiful over the ocean.","ko":"바다 위로 지는 노을이 아름다웠다."},
    {"en":"She sang a beautiful song at the concert.","ko":"그녀는 콘서트에서 아름다운 노래를 불렀다."},
    {"en":"The garden is full of beautiful flowers.","ko":"그 정원은 아름다운 꽃들로 가득하다."}
  ]'::jsonb),
  ('look like', 0, 5, '동사구', '[
    {"en":"She looks like her mother.","ko":"그녀는 자신의 어머니를 닮았다."},
    {"en":"That cloud looks like a rabbit.","ko":"저 구름은 토끼처럼 생겼다."},
    {"en":"He looks like he is tired today.","ko":"그는 오늘 피곤해 보인다."}
  ]'::jsonb),
  ('show up', 0, 5, '동사구', '[
    {"en":"He didn''t show up for practice yesterday.","ko":"그는 어제 연습에 나타나지 않았다."},
    {"en":"She showed up late for the meeting.","ko":"그녀는 모임에 늦게 나타났다."},
    {"en":"All the students showed up early for the trip.","ko":"모든 학생들이 여행을 위해 일찍 나타났다."}
  ]'::jsonb),
  ('kind', 0, 6, '형용사/명사', '[
    {"en":"She is kind to everyone at school.","ko":"그녀는 학교에서 모두에게 친절하다."},
    {"en":"Thank you for your kind words.","ko":"친절한 말씀 감사합니다."},
    {"en":"He is a kind and gentle person.","ko":"그는 친절하고 온화한 사람이다."}
  ]'::jsonb),
  ('funny', 0, 6, '형용사', '[
    {"en":"He told a funny joke in class.","ko":"그는 수업 시간에 재미있는 농담을 했다."},
    {"en":"The movie was really funny.","ko":"그 영화는 정말 재미있었다."},
    {"en":"She has a funny way of talking.","ko":"그녀는 재미있는 말투를 가지고 있다."}
  ]'::jsonb),
  ('quiet', 0, 6, '형용사', '[
    {"en":"The library is always quiet.","ko":"도서관은 항상 조용하다."},
    {"en":"He is a quiet boy who likes to read.","ko":"그는 책 읽기를 좋아하는 조용한 소년이다."},
    {"en":"Please be quiet during the test.","ko":"시험 시간에는 조용히 해 주세요."}
  ]'::jsonb),
  ('careful', 0, 6, '형용사', '[
    {"en":"Be careful when you cross the street.","ko":"길을 건널 때 조심해라."},
    {"en":"She is careful with her homework.","ko":"그녀는 숙제를 할 때 꼼꼼하다."},
    {"en":"He gave careful directions to the museum.","ko":"그는 박물관으로 가는 길을 신중하게 알려 주었다."}
  ]'::jsonb),
  ('shy', 0, 6, '형용사', '[
    {"en":"The shy boy didn''t speak in class.","ko":"그 수줍은 소년은 수업 시간에 말을 하지 않았다."},
    {"en":"She felt shy in front of new people.","ko":"그녀는 새로운 사람들 앞에서 부끄러움을 느꼈다."},
    {"en":"He is shy but very kind.","ko":"그는 수줍음이 많지만 매우 친절하다."}
  ]'::jsonb),
  ('stupid', 0, 6, '형용사', '[
    {"en":"It was stupid to forget my umbrella.","ko":"우산을 잊어버리다니 어리석었다."},
    {"en":"He felt stupid after making the mistake.","ko":"그는 실수를 한 후 스스로가 바보 같다고 느꼈다."},
    {"en":"Don''t call your friend stupid.","ko":"친구에게 멍청하다고 말하지 마라."}
  ]'::jsonb),
  ('lazy', 0, 6, '형용사', '[
    {"en":"The lazy cat sleeps all day.","ko":"그 게으른 고양이는 하루 종일 잔다."},
    {"en":"He felt too lazy to do his homework.","ko":"그는 숙제를 하기에 너무 게을렀다."},
    {"en":"Don''t be lazy about cleaning your room.","ko":"방 청소하는 것을 게을리하지 마라."}
  ]'::jsonb),
  ('calm', 0, 6, '형용사', '[
    {"en":"She stayed calm during the test.","ko":"그녀는 시험 중에 침착함을 유지했다."},
    {"en":"The sea was calm this morning.","ko":"오늘 아침 바다는 잔잔했다."},
    {"en":"He spoke in a calm voice.","ko":"그는 차분한 목소리로 말했다."}
  ]'::jsonb),
  ('smart', 0, 6, '형용사', '[
    {"en":"She is a smart student who studies hard.","ko":"그녀는 열심히 공부하는 똑똑한 학생이다."},
    {"en":"He gave a smart answer to the question.","ko":"그는 그 질문에 영리한 답을 했다."},
    {"en":"My smart dog can open the door.","ko":"우리 똑똑한 개는 문을 열 수 있다."}
  ]'::jsonb),
  ('clever', 0, 6, '형용사', '[
    {"en":"The clever fox found a way out.","ko":"그 영리한 여우는 나갈 길을 찾았다."},
    {"en":"She is clever at solving math problems.","ko":"그녀는 수학 문제를 잘 푸는 영리한 아이다."},
    {"en":"He came up with a clever idea.","ko":"그는 영리한 아이디어를 생각해 냈다."}
  ]'::jsonb),
  ('wise', 0, 6, '형용사', '[
    {"en":"My grandmother gave me wise advice.","ko":"우리 할머니는 나에게 현명한 조언을 해 주셨다."},
    {"en":"The wise teacher always listens carefully.","ko":"그 지혜로운 선생님은 항상 주의 깊게 듣는다."},
    {"en":"It was a wise decision to study early.","ko":"일찍 공부한 것은 현명한 결정이었다."}
  ]'::jsonb),
  ('honest', 0, 6, '형용사', '[
    {"en":"He is always honest with his friends.","ko":"그는 항상 친구들에게 정직하다."},
    {"en":"Please give me an honest answer.","ko":"정직한 대답을 해 주세요."},
    {"en":"She was honest about her mistake.","ko":"그녀는 자신의 실수에 대해 솔직했다."}
  ]'::jsonb),
  ('polite', 0, 6, '형용사', '[
    {"en":"He is always polite to his teachers.","ko":"그는 항상 선생님들께 예의 바르다."},
    {"en":"She gave a polite answer to the guest.","ko":"그녀는 손님에게 공손한 대답을 했다."},
    {"en":"It is polite to say thank you.","ko":"감사하다고 말하는 것은 예의 바른 것이다."}
  ]'::jsonb),
  ('friendly', 0, 6, '형용사', '[
    {"en":"The new student is very friendly.","ko":"그 새로운 학생은 매우 친절하다."},
    {"en":"Our neighbor is always friendly to us.","ko":"우리 이웃은 우리에게 항상 우호적이다."},
    {"en":"She gave a friendly smile to everyone.","ko":"그녀는 모두에게 친근한 미소를 지었다."}
  ]'::jsonb),
  ('active', 0, 6, '형용사', '[
    {"en":"He is an active member of the soccer club.","ko":"그는 축구 동아리의 활동적인 회원이다."},
    {"en":"She stays active by riding her bike.","ko":"그녀는 자전거를 타며 활동적으로 지낸다."},
    {"en":"The children are active during recess.","ko":"아이들은 쉬는 시간에 활발하다."}
  ]'::jsonb),
  ('brave', 0, 6, '형용사', '[
    {"en":"The firefighter was very brave during the fire.","ko":"그 소방관은 화재 중에 매우 용감했다."},
    {"en":"It was brave of him to speak first.","ko":"먼저 말하다니 그는 용감했다."},
    {"en":"She felt brave enough to try something new.","ko":"그녀는 새로운 것을 시도할 만큼 용감함을 느꼈다."}
  ]'::jsonb),
  ('curious', 0, 6, '형용사', '[
    {"en":"She is curious about how plants grow.","ko":"그녀는 식물이 어떻게 자라는지 궁금해한다."},
    {"en":"The curious student asked many questions.","ko":"그 호기심 많은 학생은 많은 질문을 했다."},
    {"en":"He was curious about the old museum.","ko":"그는 그 오래된 박물관에 대해 궁금해했다."}
  ]'::jsonb),
  ('character', 0, 6, '명사', '[
    {"en":"The main character in the story is very brave.","ko":"이야기의 주인공은 매우 용감하다."},
    {"en":"He has a strong character.","ko":"그는 강한 성격을 가지고 있다."},
    {"en":"Her kind character makes her popular.","ko":"그녀의 친절한 성격은 그녀를 인기 있게 만든다."}
  ]'::jsonb),
  ('on time', 0, 6, '부사구', '[
    {"en":"Please arrive on time for the meeting.","ko":"모임에 제시간에 도착해 주세요."},
    {"en":"The bus came on time this morning.","ko":"오늘 아침 버스는 정시에 왔다."},
    {"en":"She always finishes her homework on time.","ko":"그녀는 항상 숙제를 제시간에 끝낸다."}
  ]'::jsonb),
  ('on one''s own', 0, 6, '부사구', '[
    {"en":"He finished the project on his own.","ko":"그는 혼자 힘으로 그 프로젝트를 끝냈다."},
    {"en":"She learned to cook on her own.","ko":"그녀는 혼자서 요리하는 법을 배웠다."},
    {"en":"The child cleaned his room on his own.","ko":"그 아이는 혼자 힘으로 방을 청소했다."}
  ]'::jsonb),
  ('job', 0, 7, '명사', '[
    {"en":"My father has a busy job.","ko":"우리 아버지는 바쁜 직업을 가지고 계신다."},
    {"en":"She wants a job that helps people.","ko":"그녀는 사람들을 돕는 직업을 원한다."},
    {"en":"He found a part-time job at the bakery.","ko":"그는 빵집에서 아르바이트 일자리를 구했다."}
  ]'::jsonb),
  ('firefighter', 0, 7, '명사', '[
    {"en":"The firefighter saved the family from the fire.","ko":"그 소방관은 화재에서 그 가족을 구했다."},
    {"en":"My uncle is a brave firefighter.","ko":"우리 삼촌은 용감한 소방관이다."},
    {"en":"She wants to become a firefighter.","ko":"그녀는 소방관이 되고 싶어 한다."}
  ]'::jsonb),
  ('librarian', 0, 7, '명사', '[
    {"en":"The librarian helped me find a good book.","ko":"그 사서는 내가 좋은 책을 찾도록 도와주었다."},
    {"en":"She works as a librarian at our school.","ko":"그녀는 우리 학교에서 사서로 일한다."},
    {"en":"The kind librarian recommended a new novel.","ko":"그 친절한 사서는 새로운 소설을 추천해 주었다."}
  ]'::jsonb),
  ('pilot', 0, 7, '명사', '[
    {"en":"The pilot flew the plane safely.","ko":"그 조종사는 비행기를 안전하게 조종했다."},
    {"en":"He dreams of becoming a pilot.","ko":"그는 조종사가 되는 것을 꿈꾼다."},
    {"en":"The pilot greeted the passengers before takeoff.","ko":"그 조종사는 이륙 전에 승객들에게 인사했다."}
  ]'::jsonb),
  ('want', 0, 7, '동사', '[
    {"en":"I want to visit my grandparents this weekend.","ko":"나는 이번 주말에 조부모님을 방문하고 싶다."},
    {"en":"She wants a new bike for her birthday.","ko":"그녀는 생일 선물로 새 자전거를 원한다."},
    {"en":"He wants to become a scientist.","ko":"그는 과학자가 되고 싶어 한다."}
  ]'::jsonb),
  ('police officer', 0, 7, '명사', '[
    {"en":"The police officer helped the lost child.","ko":"그 경찰관은 길을 잃은 아이를 도와주었다."},
    {"en":"She wants to be a police officer someday.","ko":"그녀는 언젠가 경찰관이 되고 싶어 한다."},
    {"en":"The police officer stood at the corner.","ko":"그 경찰관은 모퉁이에 서 있었다."}
  ]'::jsonb),
  ('scientist', 0, 7, '명사', '[
    {"en":"The scientist discovered a new kind of plant.","ko":"그 과학자는 새로운 종류의 식물을 발견했다."},
    {"en":"She wants to be a scientist in the future.","ko":"그녀는 미래에 과학자가 되고 싶어 한다."},
    {"en":"Scientists work carefully in the lab.","ko":"과학자들은 실험실에서 신중하게 일한다."}
  ]'::jsonb),
  ('worker', 0, 7, '명사', '[
    {"en":"The workers built the new library quickly.","ko":"그 노동자들은 새 도서관을 빠르게 지었다."},
    {"en":"My father is a hard worker.","ko":"우리 아버지는 열심히 일하는 사람이다."},
    {"en":"The factory workers start early in the morning.","ko":"그 공장 근로자들은 아침 일찍 일을 시작한다."}
  ]'::jsonb),
  ('become', 0, 7, '동사', '[
    {"en":"She wants to become a writer.","ko":"그녀는 작가가 되고 싶어 한다."},
    {"en":"He became a doctor after years of study.","ko":"그는 몇 년의 공부 끝에 의사가 되었다."},
    {"en":"The sky became dark before the storm.","ko":"폭풍 전에 하늘이 어두워졌다."}
  ]'::jsonb),
  ('reporter', 0, 7, '명사', '[
    {"en":"The reporter asked the mayor many questions.","ko":"그 기자는 시장에게 많은 질문을 했다."},
    {"en":"She works as a reporter for a news show.","ko":"그녀는 뉴스 프로그램의 기자로 일한다."},
    {"en":"The reporter wrote a story about the festival.","ko":"그 기자는 축제에 대한 기사를 썼다."}
  ]'::jsonb),
  ('farmer', 0, 7, '명사', '[
    {"en":"The farmer grows vegetables and fruit.","ko":"그 농부는 채소와 과일을 재배한다."},
    {"en":"My grandfather was a farmer in the countryside.","ko":"우리 할아버지는 시골에서 농부였다."},
    {"en":"The farmer wakes up early every day.","ko":"그 농부는 매일 일찍 일어난다."}
  ]'::jsonb),
  ('writer', 0, 7, '명사', '[
    {"en":"She became a famous writer.","ko":"그녀는 유명한 작가가 되었다."},
    {"en":"The writer visited our school last week.","ko":"그 작가는 지난주에 우리 학교를 방문했다."},
    {"en":"He wants to be a writer someday.","ko":"그는 언젠가 작가가 되고 싶어 한다."}
  ]'::jsonb),
  ('engineer', 0, 7, '명사', '[
    {"en":"My sister works as an engineer.","ko":"우리 언니는 기술자로 일한다."},
    {"en":"The engineer designed a new bridge.","ko":"그 기술자는 새로운 다리를 설계했다."},
    {"en":"He wants to become an engineer like his father.","ko":"그는 아버지처럼 기술자가 되고 싶어 한다."}
  ]'::jsonb),
  ('work', 0, 7, '동사', '[
    {"en":"My father works at a big company.","ko":"우리 아버지는 큰 회사에서 일하신다."},
    {"en":"She worked hard on her science project.","ko":"그녀는 과학 프로젝트를 위해 열심히 노력했다."},
    {"en":"They work together every afternoon.","ko":"그들은 매일 오후 함께 일한다."}
  ]'::jsonb),
  ('company', 0, 7, '명사', '[
    {"en":"He works for a small company.","ko":"그는 작은 회사에서 일한다."},
    {"en":"The company makes toys for children.","ko":"그 회사는 어린이용 장난감을 만든다."},
    {"en":"She started her own company last year.","ko":"그녀는 작년에 자신의 회사를 창업했다."}
  ]'::jsonb),
  ('director', 0, 7, '명사', '[
    {"en":"The director gave clear directions to the actors.","ko":"그 감독은 배우들에게 명확한 지시를 했다."},
    {"en":"She wants to be a movie director.","ko":"그녀는 영화 감독이 되고 싶어 한다."},
    {"en":"The director praised the young actor.","ko":"그 감독은 그 젊은 배우를 칭찬했다."}
  ]'::jsonb),
  ('future', 0, 7, '명사', '[
    {"en":"She often thinks about her future job.","ko":"그녀는 자신의 미래 직업에 대해 자주 생각한다."},
    {"en":"We should protect the environment for the future.","ko":"우리는 미래를 위해 환경을 보호해야 한다."},
    {"en":"He has big dreams for the future.","ko":"그는 미래에 대한 큰 꿈을 가지고 있다."}
  ]'::jsonb),
  ('experience', 0, 7, '명사', '[
    {"en":"Traveling is a good experience for students.","ko":"여행은 학생들에게 좋은 경험이다."},
    {"en":"She shared her experience at the science camp.","ko":"그녀는 과학 캠프에서의 경험을 나누었다."},
    {"en":"He experienced many new things on the trip.","ko":"그는 여행에서 많은 새로운 것들을 경험했다."}
  ]'::jsonb),
  ('be interested in', 0, 7, '동사구', '[
    {"en":"I am interested in learning new languages.","ko":"나는 새로운 언어를 배우는 것에 관심이 있다."},
    {"en":"She is interested in science and math.","ko":"그녀는 과학과 수학에 흥미가 있다."},
    {"en":"He became interested in playing the guitar.","ko":"그는 기타 치는 것에 관심을 갖게 되었다."}
  ]'::jsonb),
  ('come true', 0, 7, '동사구', '[
    {"en":"Her dream finally came true.","ko":"그녀의 꿈이 마침내 이루어졌다."},
    {"en":"I hope your wish comes true.","ko":"네 소원이 이루어지길 바란다."},
    {"en":"His dream of becoming a pilot came true.","ko":"조종사가 되고 싶다는 그의 꿈이 이루어졌다."}
  ]'::jsonb),
  ('play', 0, 8, '동사', '[
    {"en":"The children play in the park after school.","ko":"아이들은 방과 후에 공원에서 논다."},
    {"en":"She plays the piano every evening.","ko":"그녀는 매일 저녁 피아노를 연주한다."},
    {"en":"They played soccer together yesterday.","ko":"그들은 어제 함께 축구를 했다."}
  ]'::jsonb),
  ('walk', 0, 8, '동사', '[
    {"en":"I walk to school every morning.","ko":"나는 매일 아침 학교까지 걸어간다."},
    {"en":"She walks her dog in the park.","ko":"그녀는 공원에서 개를 산책시킨다."},
    {"en":"We took a walk along the river.","ko":"우리는 강을 따라 산책을 했다."}
  ]'::jsonb),
  ('run', 0, 8, '동사', '[
    {"en":"He runs every morning before school.","ko":"그는 학교 가기 전에 매일 아침 달린다."},
    {"en":"The children ran across the playground.","ko":"아이들은 운동장을 가로질러 뛰었다."},
    {"en":"She can run very fast.","ko":"그녀는 매우 빨리 달릴 수 있다."}
  ]'::jsonb),
  ('kick', 0, 8, '동사', '[
    {"en":"He kicked the ball into the goal.","ko":"그는 공을 골대 안으로 찼다."},
    {"en":"She kicked the door open by accident.","ko":"그녀는 실수로 문을 발로 차서 열었다."},
    {"en":"The player kicked the ball hard.","ko":"그 선수는 공을 세게 찼다."}
  ]'::jsonb),
  ('jump', 0, 8, '동사', '[
    {"en":"The children jumped over the puddle.","ko":"아이들은 물웅덩이를 뛰어넘었다."},
    {"en":"She jumped with joy when she heard the news.","ko":"그녀는 그 소식을 듣고 기뻐서 뛰었다."},
    {"en":"He jumped high to catch the ball.","ko":"그는 공을 잡으려고 높이 뛰었다."}
  ]'::jsonb),
  ('throw', 0, 8, '동사', '[
    {"en":"He threw the ball to his friend.","ko":"그는 친구에게 공을 던졌다."},
    {"en":"Don''t throw trash on the ground.","ko":"바닥에 쓰레기를 버리지 마라."},
    {"en":"She threw the paper into the bin.","ko":"그녀는 종이를 쓰레기통에 던져 넣었다."}
  ]'::jsonb),
  ('use', 0, 8, '동사', '[
    {"en":"You can use my pencil if you need one.","ko":"필요하면 내 연필을 써도 돼."},
    {"en":"We use computers in class every day.","ko":"우리는 수업 시간에 매일 컴퓨터를 사용한다."},
    {"en":"She used a map to find the museum.","ko":"그녀는 박물관을 찾기 위해 지도를 사용했다."}
  ]'::jsonb),
  ('close', 0, 8, '동사', '[
    {"en":"Please close the window; it''s cold.","ko":"추우니까 창문을 닫아 주세요."},
    {"en":"She closed her book and went to bed.","ko":"그녀는 책을 덮고 잠자리에 들었다."},
    {"en":"He closed the door quietly.","ko":"그는 조용히 문을 닫았다."}
  ]'::jsonb),
  ('cry', 0, 8, '동사', '[
    {"en":"The baby cried all night.","ko":"아기는 밤새 울었다."},
    {"en":"She cried when she watched the sad movie.","ko":"그녀는 슬픈 영화를 보고 울었다."},
    {"en":"Don''t cry over small mistakes.","ko":"작은 실수에 울지 마라."}
  ]'::jsonb),
  ('act', 0, 8, '동사', '[
    {"en":"He acted well in the school play.","ko":"그는 학교 연극에서 연기를 잘했다."},
    {"en":"She acted kindly toward the new student.","ko":"그녀는 새로운 학생에게 친절하게 행동했다."},
    {"en":"They acted quickly during the fire drill.","ko":"그들은 화재 훈련 중에 빠르게 행동했다."}
  ]'::jsonb),
  ('move', 0, 8, '동사', '[
    {"en":"We moved to a new house last year.","ko":"우리는 작년에 새 집으로 이사했다."},
    {"en":"Please move your bike out of the way.","ko":"네 자전거를 길에서 좀 치워 줘."},
    {"en":"The dancer moved gracefully on stage.","ko":"그 무용수는 무대에서 우아하게 움직였다."}
  ]'::jsonb),
  ('shout', 0, 8, '동사', '[
    {"en":"He shouted for help when he got lost.","ko":"그는 길을 잃었을 때 도와달라고 소리쳤다."},
    {"en":"Don''t shout in the library.","ko":"도서관에서 소리치지 마라."},
    {"en":"She shouted his name across the field.","ko":"그녀는 들판 건너로 그의 이름을 외쳤다."}
  ]'::jsonb),
  ('carry', 0, 8, '동사', '[
    {"en":"He carried the heavy bag for his mother.","ko":"그는 어머니를 위해 무거운 가방을 날랐다."},
    {"en":"She carries an umbrella every rainy day.","ko":"그녀는 비 오는 날마다 우산을 가지고 다닌다."},
    {"en":"They carried the boxes into the classroom.","ko":"그들은 상자들을 교실 안으로 옮겼다."}
  ]'::jsonb),
  ('drop', 0, 8, '동사', '[
    {"en":"He dropped his phone on the floor.","ko":"그는 바닥에 휴대폰을 떨어뜨렸다."},
    {"en":"She dropped a cup and it broke.","ko":"그녀는 컵을 떨어뜨려서 깨졌다."},
    {"en":"Don''t drop your books in the hallway.","ko":"복도에서 책을 떨어뜨리지 마라."}
  ]'::jsonb),
  ('try', 0, 8, '동사', '[
    {"en":"Try your best on the test.","ko":"시험에서 최선을 다해 봐."},
    {"en":"She tried a new recipe for dinner.","ko":"그녀는 저녁으로 새로운 요리법을 시도했다."},
    {"en":"He tried to fix his bike alone.","ko":"그는 혼자서 자전거를 고치려고 애썼다."}
  ]'::jsonb),
  ('check', 0, 8, '동사', '[
    {"en":"Please check your homework before class.","ko":"수업 전에 숙제를 확인해 주세요."},
    {"en":"She checked the weather before the trip.","ko":"그녀는 여행 전에 날씨를 확인했다."},
    {"en":"He checked his answers twice.","ko":"그는 답을 두 번 확인했다."}
  ]'::jsonb),
  ('bring', 0, 8, '동사', '[
    {"en":"Please bring your book to class tomorrow.","ko":"내일 수업에 책을 가져오세요."},
    {"en":"She brought snacks for the picnic.","ko":"그녀는 소풍을 위해 간식을 가져왔다."},
    {"en":"He brought his little sister to the park.","ko":"그는 여동생을 공원에 데려왔다."}
  ]'::jsonb),
  ('laugh', 0, 8, '동사', '[
    {"en":"We laughed a lot at his jokes.","ko":"우리는 그의 농담에 많이 웃었다."},
    {"en":"She laughed when she saw the funny video.","ko":"그녀는 그 재미있는 영상을 보고 웃었다."},
    {"en":"The children laughed together during recess.","ko":"아이들은 쉬는 시간에 함께 웃었다."}
  ]'::jsonb),
  ('have[take] a seat', 0, 8, '동사구', '[
    {"en":"Please have a seat and wait a moment.","ko":"자리에 앉아서 잠시 기다려 주세요."},
    {"en":"She took a seat near the window.","ko":"그녀는 창가 자리에 앉았다."},
    {"en":"He asked the guest to have a seat.","ko":"그는 손님에게 자리에 앉으라고 권했다."}
  ]'::jsonb),
  ('get out of', 0, 8, '동사구', '[
    {"en":"He got out of the car quickly.","ko":"그는 재빨리 차에서 내렸다."},
    {"en":"She got out of bed early this morning.","ko":"그녀는 오늘 아침 일찍 침대에서 일어났다."},
    {"en":"They got out of the classroom after the bell rang.","ko":"그들은 종이 울린 후 교실에서 나갔다."}
  ]'::jsonb),
  ('sad', 0, 9, '형용사', '[
    {"en":"She felt sad when her friend moved away.","ko":"그녀는 친구가 이사 가서 슬펐다."},
    {"en":"The sad movie made everyone cry.","ko":"그 슬픈 영화는 모두를 울렸다."},
    {"en":"He looked sad after losing the game.","ko":"그는 경기에서 진 후 슬퍼 보였다."}
  ]'::jsonb),
  ('happy', 0, 9, '형용사', '[
    {"en":"She felt happy on her birthday.","ko":"그녀는 생일에 행복했다."},
    {"en":"We are happy to see you again.","ko":"우리는 너를 다시 보게 되어 기쁘다."},
    {"en":"The children looked happy at the festival.","ko":"아이들은 축제에서 행복해 보였다."}
  ]'::jsonb),
  ('afraid', 0, 9, '형용사', '[
    {"en":"She is afraid of the dark.","ko":"그녀는 어둠을 무서워한다."},
    {"en":"He was afraid to speak in front of the class.","ko":"그는 반 친구들 앞에서 말하는 것을 두려워했다."},
    {"en":"Don''t be afraid to ask questions.","ko":"질문하는 것을 두려워하지 마라."}
  ]'::jsonb),
  ('angry', 0, 9, '형용사', '[
    {"en":"He got angry when he lost his book.","ko":"그는 책을 잃어버려서 화가 났다."},
    {"en":"She was angry about the broken toy.","ko":"그녀는 부서진 장난감 때문에 화가 났다."},
    {"en":"Don''t be angry with your brother.","ko":"네 남동생에게 화내지 마라."}
  ]'::jsonb),
  ('glad', 0, 9, '형용사', '[
    {"en":"I am glad to see you at the party.","ko":"파티에서 너를 보게 되어 기쁘다."},
    {"en":"She was glad about her good grade.","ko":"그녀는 좋은 성적을 받아서 반가웠다."},
    {"en":"We are glad you could join us.","ko":"우리는 네가 함께해서 기쁘다."}
  ]'::jsonb),
  ('lonely', 0, 9, '형용사', '[
    {"en":"He felt lonely after his friend moved away.","ko":"그는 친구가 이사 간 후 외로움을 느꼈다."},
    {"en":"She was lonely on her first day at school.","ko":"그녀는 학교 첫날 외로웠다."},
    {"en":"The old dog looked lonely in the yard.","ko":"그 늙은 개는 마당에서 외로워 보였다."}
  ]'::jsonb),
  ('serious', 0, 9, '형용사', '[
    {"en":"He looked serious about the test results.","ko":"그는 시험 결과에 대해 진지해 보였다."},
    {"en":"This is a serious problem for our club.","ko":"이것은 우리 동아리의 심각한 문제이다."},
    {"en":"She spoke in a serious voice.","ko":"그녀는 진지한 목소리로 말했다."}
  ]'::jsonb),
  ('nervous', 0, 9, '형용사', '[
    {"en":"She felt nervous before the speech.","ko":"그녀는 연설 전에 긴장했다."},
    {"en":"He was nervous about the math test.","ko":"그는 수학 시험에 대해 불안해했다."},
    {"en":"Many students feel nervous on the first day.","ko":"많은 학생들이 첫날에 긴장한다."}
  ]'::jsonb),
  ('scared', 0, 9, '형용사', '[
    {"en":"The little boy was scared of the loud thunder.","ko":"그 어린 소년은 큰 천둥소리를 무서워했다."},
    {"en":"She felt scared during the horror story.","ko":"그녀는 무서운 이야기를 들으며 겁이 났다."},
    {"en":"He was scared to climb the tall tree.","ko":"그는 높은 나무에 오르는 것이 무서웠다."}
  ]'::jsonb),
  ('upset', 0, 9, '형용사', '[
    {"en":"She was upset about losing her pencil case.","ko":"그녀는 필통을 잃어버려서 속상했다."},
    {"en":"He felt upset after the argument with his friend.","ko":"그는 친구와 다툰 후 속상했다."},
    {"en":"Don''t be upset over small mistakes.","ko":"작은 실수에 속상해하지 마라."}
  ]'::jsonb),
  ('surprised', 0, 9, '형용사', '[
    {"en":"She was surprised by the birthday party.","ko":"그녀는 생일 파티에 놀랐다."},
    {"en":"He looked surprised when he saw the gift.","ko":"그는 선물을 보고 놀란 표정을 지었다."},
    {"en":"We were surprised at the good news.","ko":"우리는 그 좋은 소식에 놀랐다."}
  ]'::jsonb),
  ('bored', 0, 9, '형용사', '[
    {"en":"He felt bored during the long class.","ko":"그는 긴 수업 시간 동안 지루했다."},
    {"en":"She was bored on the rainy afternoon.","ko":"그녀는 비 오는 오후에 지루했다."},
    {"en":"The students looked bored after the long lecture.","ko":"학생들은 긴 강의 후에 지루해 보였다."}
  ]'::jsonb),
  ('pleased', 0, 9, '형용사', '[
    {"en":"She was pleased with her test score.","ko":"그녀는 자신의 시험 점수에 만족했다."},
    {"en":"He looked pleased with the new bike.","ko":"그는 새 자전거에 만족스러워 보였다."},
    {"en":"The teacher was pleased with our homework.","ko":"선생님은 우리 숙제에 만족하셨다."}
  ]'::jsonb),
  ('excited', 0, 9, '형용사', '[
    {"en":"The children were excited about the field trip.","ko":"아이들은 현장 학습에 신이 났다."},
    {"en":"She felt excited before the concert.","ko":"그녀는 콘서트 전에 흥분했다."},
    {"en":"He is excited to see his cousins this weekend.","ko":"그는 이번 주말에 사촌들을 만나서 신이 난다."}
  ]'::jsonb),
  ('worry', 0, 9, '동사', '[
    {"en":"Don''t worry about the test too much.","ko":"시험에 대해 너무 걱정하지 마라."},
    {"en":"She worries about her little brother.","ko":"그녀는 남동생을 걱정한다."},
    {"en":"He worried about being late for school.","ko":"그는 학교에 늦을까 봐 걱정했다."}
  ]'::jsonb),
  ('miss', 0, 9, '동사', '[
    {"en":"I miss my grandparents a lot.","ko":"나는 조부모님이 많이 그립다."},
    {"en":"She missed the bus this morning.","ko":"그녀는 오늘 아침 버스를 놓쳤다."},
    {"en":"He misses his old friends from elementary school.","ko":"그는 초등학교 시절 옛 친구들을 그리워한다."}
  ]'::jsonb),
  ('excuse', 0, 9, '동사', '[
    {"en":"Please excuse me for being late.","ko":"늦어서 죄송합니다."},
    {"en":"She excused herself from the table.","ko":"그녀는 자리에서 양해를 구하고 일어났다."},
    {"en":"He made an excuse for not doing his homework.","ko":"그는 숙제를 하지 않은 것에 대해 변명을 했다."}
  ]'::jsonb),
  ('complain', 0, 9, '동사', '[
    {"en":"He complained about the noisy classroom.","ko":"그는 시끄러운 교실에 대해 불평했다."},
    {"en":"She never complains about her homework.","ko":"그녀는 숙제에 대해 절대 불평하지 않는다."},
    {"en":"They complained about the cold weather.","ko":"그들은 추운 날씨에 대해 불평했다."}
  ]'::jsonb),
  ('be proud of', 0, 9, '동사구', '[
    {"en":"My parents are proud of my grades.","ko":"우리 부모님은 내 성적을 자랑스러워하신다."},
    {"en":"She is proud of her little brother''s drawing.","ko":"그녀는 남동생의 그림을 자랑스러워한다."},
    {"en":"He is proud of his hard work.","ko":"그는 자신의 노력을 자랑스러워한다."}
  ]'::jsonb),
  ('would like to-v', 0, 9, '동사구', '[
    {"en":"I would like to visit the science museum.","ko":"나는 과학 박물관을 방문하고 싶다."},
    {"en":"She would like to learn how to swim.","ko":"그녀는 수영하는 법을 배우고 싶어 한다."},
    {"en":"He would like to join the art club.","ko":"그는 미술 동아리에 가입하고 싶어 한다."}
  ]'::jsonb)
) as t(word, level, study_day, pos, examples)
where v.word = t.word and v.level = t.level and v.study_day = t.study_day;
