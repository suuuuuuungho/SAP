-- SAP 1기 대시보드: Study 탭 — Lv.1(중등 실력) Day 19~24 품사/예문 채우기 (180단어).
update public.vocab_words v
set part_of_speech = t.pos, example_sentences = t.examples, updated_at = now()
from (values
  ('stretch', 1, 19, '동사', '[
    {"en":"I stretch my arms before running.","ko":"나는 달리기 전에 팔을 쭉 뻗는다."},
    {"en":"She stretched her legs after sitting for a long time.","ko":"그녀는 오랫동안 앉아 있다가 다리를 쭉 뻗었다."},
    {"en":"We should stretch our bodies before exercise.","ko":"우리는 운동 전에 몸을 스트레칭해야 한다."}
  ]'::jsonb),
  ('swim', 1, 19, '동사', '[
    {"en":"He swims in the pool every morning.","ko":"그는 매일 아침 수영장에서 수영한다."},
    {"en":"Can you swim across the river?","ko":"너는 그 강을 헤엄쳐 건널 수 있니?"},
    {"en":"We swam together at the beach last summer.","ko":"우리는 지난여름 해변에서 함께 수영했다."}
  ]'::jsonb),
  ('kick', 1, 19, '명사/동사', '[
    {"en":"He kicked the ball into the goal.","ko":"그는 공을 골대 안으로 찼다."},
    {"en":"The player gave the ball a strong kick.","ko":"그 선수는 공을 세게 찼다."},
    {"en":"Don''t kick the door, please.","ko":"문을 발로 차지 마세요."}
  ]'::jsonb),
  ('outdoor', 1, 19, '형용사', '[
    {"en":"We enjoy outdoor activities on weekends.","ko":"우리는 주말에 야외 활동을 즐긴다."},
    {"en":"The school has an outdoor swimming pool.","ko":"그 학교에는 야외 수영장이 있다."},
    {"en":"Outdoor sports are good for our health.","ko":"야외 스포츠는 건강에 좋다."}
  ]'::jsonb),
  ('player', 1, 19, '명사', '[
    {"en":"He is the best player on our team.","ko":"그는 우리 팀에서 최고의 선수이다."},
    {"en":"Every player must wear a uniform.","ko":"모든 선수는 유니폼을 입어야 한다."},
    {"en":"The young player scored two goals today.","ko":"그 젊은 선수는 오늘 두 골을 넣었다."}
  ]'::jsonb),
  ('bowling', 1, 19, '명사', '[
    {"en":"We went bowling with our friends last night.","ko":"우리는 어젯밤 친구들과 볼링을 치러 갔다."},
    {"en":"Bowling is a fun indoor sport.","ko":"볼링은 재미있는 실내 스포츠이다."},
    {"en":"She scored the highest in our bowling game.","ko":"그녀는 우리 볼링 게임에서 가장 높은 점수를 받았다."}
  ]'::jsonb),
  ('prize', 1, 19, '명사', '[
    {"en":"She won first prize in the speech contest.","ko":"그녀는 말하기 대회에서 1등 상을 받았다."},
    {"en":"The winner will receive a special prize.","ko":"우승자는 특별한 상을 받을 것이다."},
    {"en":"What is the prize for this competition?","ko":"이 대회의 상품은 무엇인가요?"}
  ]'::jsonb),
  ('competition', 1, 19, '명사', '[
    {"en":"Many students joined the science competition.","ko":"많은 학생들이 과학 경진대회에 참가했다."},
    {"en":"The competition will be held next Friday.","ko":"그 대회는 다음 주 금요일에 열릴 것이다."},
    {"en":"She practiced hard for the singing competition.","ko":"그녀는 노래 경연을 위해 열심히 연습했다."}
  ]'::jsonb),
  ('goal', 1, 19, '명사', '[
    {"en":"He scored a goal in the last minute.","ko":"그는 마지막 순간에 골을 넣었다."},
    {"en":"My goal is to read one book a week.","ko":"내 목표는 일주일에 책 한 권을 읽는 것이다."},
    {"en":"The team celebrated after the winning goal.","ko":"그 팀은 승리를 결정지은 골 이후 축하했다."}
  ]'::jsonb),
  ('shoot', 1, 19, '명사/동사', '[
    {"en":"He shot the ball into the basket.","ko":"그는 공을 바구니 안으로 쏘았다."},
    {"en":"She practices her shoot every afternoon.","ko":"그녀는 매일 오후 슛 연습을 한다."},
    {"en":"The player took a shoot from far away.","ko":"그 선수는 멀리서 슛을 했다."}
  ]'::jsonb),
  ('coach', 1, 19, '명사/동사', '[
    {"en":"Our coach teaches us new skills every week.","ko":"우리 코치는 매주 새로운 기술을 가르쳐 준다."},
    {"en":"He wants to coach the school soccer team.","ko":"그는 학교 축구팀을 지도하고 싶어 한다."},
    {"en":"The coach was proud of the players.","ko":"그 코치는 선수들을 자랑스러워했다."}
  ]'::jsonb),
  ('basketball', 1, 19, '명사', '[
    {"en":"We play basketball after school.","ko":"우리는 방과 후에 농구를 한다."},
    {"en":"Basketball is popular among students.","ko":"농구는 학생들 사이에서 인기가 있다."},
    {"en":"He joined the basketball club this year.","ko":"그는 올해 농구 동아리에 가입했다."}
  ]'::jsonb),
  ('baseball', 1, 19, '명사', '[
    {"en":"My brother loves watching baseball games.","ko":"내 남동생은 야구 경기 보는 것을 좋아한다."},
    {"en":"We played baseball in the park yesterday.","ko":"우리는 어제 공원에서 야구를 했다."},
    {"en":"Baseball is a popular sport in Korea.","ko":"야구는 한국에서 인기 있는 스포츠이다."}
  ]'::jsonb),
  ('base', 1, 19, '명사', '[
    {"en":"The runner touched second base quickly.","ko":"그 주자는 2루를 빠르게 밟았다."},
    {"en":"He stood on the first base.","ko":"그는 1루에 서 있었다."},
    {"en":"This idea is the base of our project.","ko":"이 아이디어는 우리 프로젝트의 기초이다."}
  ]'::jsonb),
  ('match', 1, 19, '명사', '[
    {"en":"We watched an exciting soccer match.","ko":"우리는 흥미진진한 축구 경기를 봤다."},
    {"en":"The match starts at three o''clock.","ko":"그 경기는 3시에 시작한다."},
    {"en":"Our team lost the match yesterday.","ko":"우리 팀은 어제 경기에서 졌다."}
  ]'::jsonb),
  ('batter', 1, 19, '명사', '[
    {"en":"The batter hit the ball hard.","ko":"그 타자는 공을 세게 쳤다."},
    {"en":"He is the best batter on the team.","ko":"그는 팀에서 가장 뛰어난 타자이다."},
    {"en":"The new batter practiced every day.","ko":"새로운 타자는 매일 연습했다."}
  ]'::jsonb),
  ('throw', 1, 19, '명사/동사', '[
    {"en":"He threw the ball to his friend.","ko":"그는 친구에게 공을 던졌다."},
    {"en":"She gave the ball a quick throw.","ko":"그녀는 공을 재빠르게 던졌다."},
    {"en":"Please throw the ball gently to me.","ko":"나에게 공을 살살 던져 줘."}
  ]'::jsonb),
  ('catch', 1, 19, '동사', '[
    {"en":"He caught the ball with both hands.","ko":"그는 두 손으로 공을 잡았다."},
    {"en":"Can you catch this ball for me?","ko":"이 공을 잡아 줄 수 있니?"},
    {"en":"She always catches the bus on time.","ko":"그녀는 항상 제시간에 버스를 잡아 탄다."}
  ]'::jsonb),
  ('racket', 1, 19, '명사/동사', '[
    {"en":"I bought a new tennis racket.","ko":"나는 새 테니스 라켓을 샀다."},
    {"en":"She hit the ball with her racket.","ko":"그녀는 라켓으로 공을 쳤다."},
    {"en":"His racket broke during the game.","ko":"그의 라켓은 경기 중에 부러졌다."}
  ]'::jsonb),
  ('athlete', 1, 19, '명사', '[
    {"en":"The athlete trains every single day.","ko":"그 운동선수는 매일 훈련한다."},
    {"en":"She wants to become a famous athlete.","ko":"그녀는 유명한 운동선수가 되고 싶어 한다."},
    {"en":"Many athletes joined the school event.","ko":"많은 운동선수들이 학교 행사에 참가했다."}
  ]'::jsonb),
  ('defender', 1, 19, '명사', '[
    {"en":"The defender stopped the other team''s attack.","ko":"그 수비수는 상대 팀의 공격을 막았다."},
    {"en":"He plays as a defender on our team.","ko":"그는 우리 팀에서 수비수로 뛴다."},
    {"en":"A good defender protects the goal.","ko":"좋은 수비수는 골대를 지킨다."}
  ]'::jsonb),
  ('score', 1, 19, '명사/동사', '[
    {"en":"What is the score of the game?","ko":"경기 점수가 어떻게 되나요?"},
    {"en":"She scored the highest in the test.","ko":"그녀는 시험에서 가장 높은 점수를 받았다."},
    {"en":"He tried hard to score a goal.","ko":"그는 골을 넣기 위해 열심히 노력했다."}
  ]'::jsonb),
  ('referee', 1, 19, '명사/동사', '[
    {"en":"The referee blew the whistle loudly.","ko":"심판은 호루라기를 크게 불었다."},
    {"en":"My uncle used to referee soccer games.","ko":"삼촌은 예전에 축구 경기 심판을 봤다."},
    {"en":"The referee made a fair decision.","ko":"심판은 공정한 판정을 내렸다."}
  ]'::jsonb),
  ('champion', 1, 19, '명사', '[
    {"en":"She became the champion of the contest.","ko":"그녀는 그 대회의 챔피언이 되었다."},
    {"en":"The champion trained very hard every day.","ko":"그 챔피언은 매일 매우 열심히 훈련했다."},
    {"en":"Our school produced a national champion.","ko":"우리 학교는 전국 챔피언을 배출했다."}
  ]'::jsonb),
  ('sweat', 1, 19, '명사/동사', '[
    {"en":"He was sweating after the long run.","ko":"그는 오래 달린 후 땀을 흘리고 있었다."},
    {"en":"Sweat dripped down her face during practice.","ko":"연습하는 동안 그녀의 얼굴에 땀이 흘러내렸다."},
    {"en":"We sweat a lot in summer.","ko":"우리는 여름에 땀을 많이 흘린다."}
  ]'::jsonb),
  ('dive', 1, 19, '명사/동사', '[
    {"en":"He dove into the pool quickly.","ko":"그는 재빨리 수영장에 뛰어들었다."},
    {"en":"She practices her dive every weekend.","ko":"그녀는 주말마다 다이빙을 연습한다."},
    {"en":"The children love to dive into the water.","ko":"아이들은 물속으로 뛰어드는 것을 좋아한다."}
  ]'::jsonb),
  ('skate', 1, 19, '명사/동사', '[
    {"en":"We skate on the frozen lake in winter.","ko":"우리는 겨울에 얼어붙은 호수에서 스케이트를 탄다."},
    {"en":"She got new skates for her birthday.","ko":"그녀는 생일에 새 스케이트를 받았다."},
    {"en":"He learned to skate last year.","ko":"그는 작년에 스케이트 타는 법을 배웠다."}
  ]'::jsonb),
  ('surf', 1, 19, '명사/동사', '[
    {"en":"They surf at the beach every summer.","ko":"그들은 매년 여름 해변에서 서핑을 한다."},
    {"en":"The surf was too strong to swim.","ko":"파도가 너무 강해서 수영을 할 수 없었다."},
    {"en":"He wants to learn how to surf.","ko":"그는 서핑하는 법을 배우고 싶어 한다."}
  ]'::jsonb),
  ('warm up', 1, 19, '동사구', '[
    {"en":"We warm up before every game.","ko":"우리는 매 경기 전에 준비 운동을 한다."},
    {"en":"Please warm up your muscles first.","ko":"먼저 근육을 풀어 주세요."},
    {"en":"The players warmed up for ten minutes.","ko":"선수들은 10분 동안 몸을 풀었다."}
  ]'::jsonb),
  ('up and down', 1, 19, '부사구', '[
    {"en":"The ball bounced up and down.","ko":"공이 위아래로 튀었다."},
    {"en":"She jumped up and down with joy.","ko":"그녀는 기뻐서 위아래로 뛰었다."},
    {"en":"The boat moved up and down on the waves.","ko":"그 배는 파도 위에서 위아래로 움직였다."}
  ]'::jsonb),
  ('store', 1, 20, '명사', '[
    {"en":"We bought some bread at the store.","ko":"우리는 가게에서 빵을 좀 샀다."},
    {"en":"The store opens at nine in the morning.","ko":"그 가게는 아침 9시에 문을 연다."},
    {"en":"There is a new store near my house.","ko":"우리 집 근처에 새로운 가게가 생겼다."}
  ]'::jsonb),
  ('gift', 1, 20, '명사', '[
    {"en":"She gave me a nice gift for my birthday.","ko":"그녀는 내 생일에 멋진 선물을 주었다."},
    {"en":"I bought a gift for my mother.","ko":"나는 어머니를 위한 선물을 샀다."},
    {"en":"What gift do you want this year?","ko":"올해는 어떤 선물을 원하니?"}
  ]'::jsonb),
  ('cheap', 1, 20, '형용사', '[
    {"en":"This bag is very cheap.","ko":"이 가방은 매우 싸다."},
    {"en":"I found a cheap and nice restaurant.","ko":"나는 싸고 좋은 식당을 찾았다."},
    {"en":"The shoes were cheap but comfortable.","ko":"그 신발은 저렴했지만 편안했다."}
  ]'::jsonb),
  ('expensive', 1, 20, '형용사', '[
    {"en":"This watch looks expensive.","ko":"이 시계는 비싸 보인다."},
    {"en":"The hotel was too expensive for us.","ko":"그 호텔은 우리에게 너무 비쌌다."},
    {"en":"She bought an expensive gift for her friend.","ko":"그녀는 친구를 위해 비싼 선물을 샀다."}
  ]'::jsonb),
  ('sale', 1, 20, '명사', '[
    {"en":"The store is having a big sale today.","ko":"그 가게는 오늘 큰 세일을 하고 있다."},
    {"en":"I bought this jacket on sale.","ko":"나는 이 재킷을 할인해서 샀다."},
    {"en":"The sale ends this weekend.","ko":"그 세일은 이번 주말에 끝난다."}
  ]'::jsonb),
  ('sell', 1, 20, '동사', '[
    {"en":"The shop sells fresh fruit every day.","ko":"그 가게는 매일 신선한 과일을 판다."},
    {"en":"He sold his old bike to a friend.","ko":"그는 낡은 자전거를 친구에게 팔았다."},
    {"en":"They sell books at a low price.","ko":"그들은 책을 저렴한 가격에 판다."}
  ]'::jsonb),
  ('choose', 1, 20, '동사', '[
    {"en":"It is hard to choose the right color.","ko":"알맞은 색을 고르는 것은 어렵다."},
    {"en":"She chose a blue shirt for the party.","ko":"그녀는 파티를 위해 파란 셔츠를 골랐다."},
    {"en":"Please choose one item from the list.","ko":"목록에서 하나의 물건을 골라 주세요."}
  ]'::jsonb),
  ('pay', 1, 20, '동사', '[
    {"en":"I will pay for the lunch today.","ko":"오늘은 내가 점심값을 낼게."},
    {"en":"She paid ten dollars for the ticket.","ko":"그녀는 티켓 값으로 10달러를 지불했다."},
    {"en":"Did you pay the bill already?","ko":"너는 이미 계산서를 지불했니?"}
  ]'::jsonb),
  ('business', 1, 20, '명사', '[
    {"en":"My father runs a small business.","ko":"우리 아버지는 작은 사업을 운영하신다."},
    {"en":"She wants to start her own business.","ko":"그녀는 자신의 사업을 시작하고 싶어 한다."},
    {"en":"The business grew quickly this year.","ko":"그 사업은 올해 빠르게 성장했다."}
  ]'::jsonb),
  ('tax', 1, 20, '명사', '[
    {"en":"We have to pay tax on this item.","ko":"우리는 이 물건에 대한 세금을 내야 한다."},
    {"en":"The price includes tax.","ko":"그 가격에는 세금이 포함되어 있다."},
    {"en":"Tax rates changed this year.","ko":"세율이 올해 바뀌었다."}
  ]'::jsonb),
  ('exchange', 1, 20, '명사/동사', '[
    {"en":"I want to exchange this shirt for a bigger one.","ko":"나는 이 셔츠를 더 큰 것으로 교환하고 싶다."},
    {"en":"We had a nice exchange of ideas.","ko":"우리는 좋은 의견 교환을 했다."},
    {"en":"She exchanged her old bag for a new one.","ko":"그녀는 낡은 가방을 새 것으로 교환했다."}
  ]'::jsonb),
  ('select', 1, 20, '동사/형용사', '[
    {"en":"Please select your favorite color.","ko":"가장 좋아하는 색을 선택해 주세요."},
    {"en":"He selected a book from the shelf.","ko":"그는 선반에서 책 한 권을 골랐다."},
    {"en":"This is a select group of students.","ko":"이것은 선발된 학생들의 그룹이다."}
  ]'::jsonb),
  ('goods', 1, 20, '명사', '[
    {"en":"The store sells many kinds of goods.","ko":"그 가게는 많은 종류의 상품을 판다."},
    {"en":"These goods are made in Korea.","ko":"이 상품들은 한국에서 만들어졌다."},
    {"en":"We need to check the goods before buying.","ko":"우리는 사기 전에 상품을 확인해야 한다."}
  ]'::jsonb),
  ('tag', 1, 20, '명사', '[
    {"en":"Check the price tag before you buy it.","ko":"사기 전에 가격표를 확인해라."},
    {"en":"The tag shows the size of the shirt.","ko":"그 태그는 셔츠의 사이즈를 보여준다."},
    {"en":"She removed the tag from her new bag.","ko":"그녀는 새 가방에서 태그를 뗐다."}
  ]'::jsonb),
  ('medium', 1, 20, '명사/형용사', '[
    {"en":"I would like a medium coffee, please.","ko":"미디엄 사이즈 커피 하나 주세요."},
    {"en":"This shirt comes in small, medium, and large.","ko":"이 셔츠는 소, 중, 대 사이즈로 나온다."},
    {"en":"She chose the medium size shoes.","ko":"그녀는 중간 사이즈의 신발을 골랐다."}
  ]'::jsonb),
  ('cash', 1, 20, '명사', '[
    {"en":"I paid in cash for the snacks.","ko":"나는 간식값을 현금으로 지불했다."},
    {"en":"Do you have enough cash with you?","ko":"너는 현금을 충분히 가지고 있니?"},
    {"en":"She keeps some cash in her wallet.","ko":"그녀는 지갑에 약간의 현금을 넣어 둔다."}
  ]'::jsonb),
  ('change', 1, 20, '명사/동사', '[
    {"en":"Here is your change.","ko":"여기 거스름돈 있습니다."},
    {"en":"The weather can change quickly in spring.","ko":"봄에는 날씨가 빠르게 바뀔 수 있다."},
    {"en":"He changed his plan for the weekend.","ko":"그는 주말 계획을 바꿨다."}
  ]'::jsonb),
  ('customer', 1, 20, '명사', '[
    {"en":"The store has many customers on weekends.","ko":"그 가게는 주말에 손님이 많다."},
    {"en":"A customer asked for help finding a book.","ko":"한 손님이 책을 찾는 데 도움을 요청했다."},
    {"en":"We should be kind to every customer.","ko":"우리는 모든 손님에게 친절해야 한다."}
  ]'::jsonb),
  ('display', 1, 20, '명사/동사', '[
    {"en":"The shop has a nice display in the window.","ko":"그 가게는 창문에 멋진 진열을 해 놓았다."},
    {"en":"They displayed new shoes at the entrance.","ko":"그들은 입구에 새 신발을 진열했다."},
    {"en":"The museum has a special display this month.","ko":"박물관은 이번 달에 특별 전시를 하고 있다."}
  ]'::jsonb),
  ('stand', 1, 20, '명사', '[
    {"en":"We bought juice from a small stand.","ko":"우리는 작은 노점에서 주스를 샀다."},
    {"en":"There was a food stand near the park.","ko":"공원 근처에 음식 노점이 있었다."},
    {"en":"He set up a stand to sell flowers.","ko":"그는 꽃을 팔기 위해 노점을 차렸다."}
  ]'::jsonb),
  ('retail', 1, 20, '명사', '[
    {"en":"The retail price is higher than online.","ko":"소매 가격이 온라인보다 더 비싸다."},
    {"en":"She works in a retail store downtown.","ko":"그녀는 시내의 소매점에서 일한다."},
    {"en":"Retail sales increased last month.","ko":"지난달 소매 판매가 증가했다."}
  ]'::jsonb),
  ('discount', 1, 20, '명사/동사', '[
    {"en":"We got a ten percent discount on shoes.","ko":"우리는 신발을 10퍼센트 할인받았다."},
    {"en":"The store discounted all winter clothes.","ko":"그 가게는 모든 겨울옷을 할인했다."},
    {"en":"Ask the clerk about the student discount.","ko":"점원에게 학생 할인에 대해 물어봐라."}
  ]'::jsonb),
  ('receipt', 1, 20, '명사', '[
    {"en":"Please keep your receipt for the exchange.","ko":"교환을 위해 영수증을 보관해 주세요."},
    {"en":"I lost my receipt from the store.","ko":"나는 가게 영수증을 잃어버렸다."},
    {"en":"The receipt shows the total price.","ko":"그 영수증은 총 가격을 보여준다."}
  ]'::jsonb),
  ('brand-name', 1, 20, '형용사', '[
    {"en":"She likes wearing brand-name clothes.","ko":"그녀는 브랜드 옷을 입는 것을 좋아한다."},
    {"en":"Brand-name shoes are often expensive.","ko":"브랜드 신발은 종종 비싸다."},
    {"en":"He bought a brand-name bag for school.","ko":"그는 학교용으로 브랜드 가방을 샀다."}
  ]'::jsonb),
  ('auction', 1, 20, '명사', '[
    {"en":"The painting was sold at an auction.","ko":"그 그림은 경매에서 팔렸다."},
    {"en":"We watched an online auction for old books.","ko":"우리는 오래된 책들의 온라인 경매를 지켜봤다."},
    {"en":"The charity held an auction last weekend.","ko":"그 자선단체는 지난 주말에 경매를 열었다."}
  ]'::jsonb),
  ('reasonable', 1, 20, '형용사', '[
    {"en":"The price of this bag is reasonable.","ko":"이 가방의 가격은 합리적이다."},
    {"en":"He gave a reasonable explanation for being late.","ko":"그는 늦은 것에 대해 합당한 설명을 했다."},
    {"en":"This restaurant offers meals at reasonable prices.","ko":"이 식당은 합리적인 가격에 식사를 제공한다."}
  ]'::jsonb),
  ('catalog', 1, 20, '명사', '[
    {"en":"She looked through the clothing catalog.","ko":"그녀는 의류 카탈로그를 살펴봤다."},
    {"en":"The store sent a new catalog this month.","ko":"그 가게는 이번 달에 새 카탈로그를 보냈다."},
    {"en":"We ordered a chair from the catalog.","ko":"우리는 카탈로그에서 의자를 주문했다."}
  ]'::jsonb),
  ('quality', 1, 20, '명사', '[
    {"en":"This shirt is made of good quality material.","ko":"이 셔츠는 좋은 품질의 소재로 만들어졌다."},
    {"en":"We always check the quality before buying.","ko":"우리는 사기 전에 항상 품질을 확인한다."},
    {"en":"The quality of the food was excellent.","ko":"그 음식의 품질은 훌륭했다."}
  ]'::jsonb),
  ('look around', 1, 20, '동사구', '[
    {"en":"Let''s look around the store first.","ko":"먼저 가게를 둘러보자."},
    {"en":"She looked around before choosing a gift.","ko":"그녀는 선물을 고르기 전에 둘러봤다."},
    {"en":"We looked around the new market yesterday.","ko":"우리는 어제 새 시장을 둘러봤다."}
  ]'::jsonb),
  ('drop by', 1, 20, '동사구', '[
    {"en":"I will drop by the bakery after school.","ko":"나는 방과 후에 빵집에 잠깐 들를 것이다."},
    {"en":"She dropped by my house yesterday.","ko":"그녀는 어제 우리 집에 잠깐 들렀다."},
    {"en":"Please drop by if you have time.","ko":"시간이 되면 잠깐 들러 주세요."}
  ]'::jsonb),
  ('take', 1, 21, '동사', '[
    {"en":"I will take this blue shirt.","ko":"저는 이 파란 셔츠로 할게요."},
    {"en":"She took a photo of the mountain.","ko":"그녀는 그 산의 사진을 찍었다."},
    {"en":"Please take a seat here.","ko":"여기 앉으세요."}
  ]'::jsonb),
  ('order', 1, 21, '명사/동사', '[
    {"en":"Can I take your order now?","ko":"지금 주문을 받아도 될까요?"},
    {"en":"He ordered a bowl of soup.","ko":"그는 수프 한 그릇을 주문했다."},
    {"en":"We placed our order at the counter.","ko":"우리는 계산대에서 주문했다."}
  ]'::jsonb),
  ('cook', 1, 21, '명사/동사', '[
    {"en":"My mother is a great cook.","ko":"우리 어머니는 훌륭한 요리사이다."},
    {"en":"He cooks dinner for his family every day.","ko":"그는 매일 가족을 위해 저녁을 요리한다."},
    {"en":"We cooked pasta together last night.","ko":"우리는 어젯밤에 함께 파스타를 요리했다."}
  ]'::jsonb),
  ('chef', 1, 21, '명사', '[
    {"en":"The chef made a delicious soup.","ko":"그 주방장은 맛있는 수프를 만들었다."},
    {"en":"She wants to become a famous chef.","ko":"그녀는 유명한 요리사가 되고 싶어 한다."},
    {"en":"The chef added some pepper to the dish.","ko":"주방장은 요리에 후추를 조금 넣었다."}
  ]'::jsonb),
  ('buffet', 1, 21, '명사', '[
    {"en":"We had lunch at a buffet restaurant.","ko":"우리는 뷔페 식당에서 점심을 먹었다."},
    {"en":"The buffet had many kinds of food.","ko":"그 뷔페에는 많은 종류의 음식이 있었다."},
    {"en":"I love going to a buffet with my family.","ko":"나는 가족과 함께 뷔페에 가는 것을 좋아한다."}
  ]'::jsonb),
  ('waiter', 1, 21, '명사', '[
    {"en":"The waiter brought us some water.","ko":"웨이터가 우리에게 물을 가져다주었다."},
    {"en":"We asked the waiter for the menu.","ko":"우리는 웨이터에게 메뉴를 요청했다."},
    {"en":"The kind waiter helped us choose a dish.","ko":"친절한 웨이터는 우리가 음식을 고르는 것을 도와주었다."}
  ]'::jsonb),
  ('dessert', 1, 21, '명사', '[
    {"en":"We had ice cream for dessert.","ko":"우리는 후식으로 아이스크림을 먹었다."},
    {"en":"What kind of dessert do you like?","ko":"너는 어떤 종류의 디저트를 좋아하니?"},
    {"en":"She ordered a cake for dessert.","ko":"그녀는 후식으로 케이크를 주문했다."}
  ]'::jsonb),
  ('napkin', 1, 21, '명사', '[
    {"en":"He wiped his mouth with a napkin.","ko":"그는 냅킨으로 입을 닦았다."},
    {"en":"Please pass me a napkin.","ko":"냅킨 좀 건네주세요."},
    {"en":"There are napkins on the table.","ko":"테이블 위에 냅킨이 있다."}
  ]'::jsonb),
  ('set', 1, 21, '동사', '[
    {"en":"She set the table for dinner.","ko":"그녀는 저녁 식사를 위해 식탁을 차렸다."},
    {"en":"He set the plates carefully on the tray.","ko":"그는 접시들을 쟁반 위에 조심스럽게 놓았다."},
    {"en":"Let''s set the time for our meeting.","ko":"우리 회의 시간을 정하자."}
  ]'::jsonb),
  ('deliver', 1, 21, '동사', '[
    {"en":"The restaurant delivers food to our house.","ko":"그 식당은 우리 집으로 음식을 배달한다."},
    {"en":"He delivered the pizza in twenty minutes.","ko":"그는 20분 만에 피자를 배달했다."},
    {"en":"Can you deliver this package today?","ko":"오늘 이 소포를 배달해 줄 수 있나요?"}
  ]'::jsonb),
  ('wipe', 1, 21, '동사', '[
    {"en":"She wiped the table after dinner.","ko":"그녀는 저녁 식사 후 식탁을 닦았다."},
    {"en":"Please wipe your hands before eating.","ko":"먹기 전에 손을 닦아 주세요."},
    {"en":"He wiped the window with a cloth.","ko":"그는 천으로 창문을 닦았다."}
  ]'::jsonb),
  ('straw', 1, 21, '명사', '[
    {"en":"I drank the juice with a straw.","ko":"나는 빨대로 주스를 마셨다."},
    {"en":"Can I have a straw for my drink?","ko":"제 음료에 빨대를 주실 수 있나요?"},
    {"en":"She used a paper straw instead of plastic.","ko":"그녀는 플라스틱 대신 종이 빨대를 사용했다."}
  ]'::jsonb),
  ('bite', 1, 21, '명사/동사', '[
    {"en":"He took a big bite of the sandwich.","ko":"그는 샌드위치를 크게 한 입 베어 물었다."},
    {"en":"She bit into the apple.","ko":"그녀는 사과를 베어 물었다."},
    {"en":"Can I have a bite of your cake?","ko":"네 케이크 한 입만 먹어봐도 될까?"}
  ]'::jsonb),
  ('spill', 1, 21, '동사', '[
    {"en":"Be careful not to spill your milk.","ko":"우유를 쏟지 않도록 조심해라."},
    {"en":"He spilled juice on the table.","ko":"그는 테이블에 주스를 쏟았다."},
    {"en":"She spilled some water on the floor.","ko":"그녀는 바닥에 물을 조금 흘렸다."}
  ]'::jsonb),
  ('special', 1, 21, '명사/형용사', '[
    {"en":"Today''s special is grilled fish.","ko":"오늘의 특별 메뉴는 구운 생선이다."},
    {"en":"This is a special day for our family.","ko":"오늘은 우리 가족에게 특별한 날이다."},
    {"en":"The restaurant offers a special menu on weekends.","ko":"그 식당은 주말에 특별 메뉴를 제공한다."}
  ]'::jsonb),
  ('rare', 1, 21, '형용사', '[
    {"en":"He likes his steak rare.","ko":"그는 스테이크를 덜 익혀서 먹는 것을 좋아한다."},
    {"en":"It is rare to see snow here in April.","ko":"여기서 4월에 눈을 보는 것은 드물다."},
    {"en":"This kind of flower is very rare.","ko":"이런 종류의 꽃은 매우 희귀하다."}
  ]'::jsonb),
  ('calorie', 1, 21, '명사', '[
    {"en":"This salad has fewer calories than the burger.","ko":"이 샐러드는 버거보다 칼로리가 더 적다."},
    {"en":"She checks the calories before eating snacks.","ko":"그녀는 간식을 먹기 전에 칼로리를 확인한다."},
    {"en":"How many calories are in this drink?","ko":"이 음료에는 칼로리가 얼마나 있나요?"}
  ]'::jsonb),
  ('serve', 1, 21, '동사', '[
    {"en":"The restaurant serves breakfast until eleven.","ko":"그 식당은 11시까지 아침 식사를 제공한다."},
    {"en":"She served tea to her guests.","ko":"그녀는 손님들에게 차를 대접했다."},
    {"en":"They serve fresh food every day.","ko":"그들은 매일 신선한 음식을 제공한다."}
  ]'::jsonb),
  ('tip', 1, 21, '명사', '[
    {"en":"We left a small tip for the waiter.","ko":"우리는 웨이터에게 약간의 팁을 남겼다."},
    {"en":"It is common to leave a tip in some countries.","ko":"일부 나라에서는 팁을 남기는 것이 일반적이다."},
    {"en":"She gave the driver a tip.","ko":"그녀는 기사에게 팁을 주었다."}
  ]'::jsonb),
  ('beverage', 1, 21, '명사', '[
    {"en":"What beverage would you like to order?","ko":"어떤 음료를 주문하시겠어요?"},
    {"en":"The cafe sells many kinds of beverages.","ko":"그 카페는 많은 종류의 음료를 판다."},
    {"en":"Water is the healthiest beverage.","ko":"물은 가장 건강한 음료이다."}
  ]'::jsonb),
  ('refill', 1, 21, '명사/동사', '[
    {"en":"Can I get a refill of water, please?","ko":"물을 좀 더 채워 주실 수 있나요?"},
    {"en":"The cafe offers free refills for coffee.","ko":"그 카페는 커피를 무료로 리필해 준다."},
    {"en":"He refilled his cup with juice.","ko":"그는 컵에 주스를 다시 채웠다."}
  ]'::jsonb),
  ('wrap', 1, 21, '동사/명사', '[
    {"en":"She wrapped the gift with colorful paper.","ko":"그녀는 화려한 종이로 선물을 포장했다."},
    {"en":"Can you wrap this sandwich to go?","ko":"이 샌드위치를 포장해 줄 수 있나요?"},
    {"en":"He wrapped the leftover food carefully.","ko":"그는 남은 음식을 조심스럽게 포장했다."}
  ]'::jsonb),
  ('bill', 1, 21, '명사', '[
    {"en":"The waiter brought us the bill.","ko":"웨이터가 우리에게 계산서를 가져다주었다."},
    {"en":"Can we get the bill, please?","ko":"계산서를 주시겠어요?"},
    {"en":"We split the bill among four people.","ko":"우리는 네 명이서 계산서를 나눠 냈다."}
  ]'::jsonb),
  ('total', 1, 21, '명사/형용사', '[
    {"en":"The total was twenty dollars.","ko":"총액은 20달러였다."},
    {"en":"What is the total price of the meal?","ko":"그 식사의 총 가격은 얼마인가요?"},
    {"en":"We spent a total of two hours eating.","ko":"우리는 총 두 시간 동안 식사를 했다."}
  ]'::jsonb),
  ('ingredient', 1, 21, '명사', '[
    {"en":"Sugar is the main ingredient in this cake.","ko":"설탕은 이 케이크의 주된 재료이다."},
    {"en":"What ingredients do we need for the soup?","ko":"이 수프에는 어떤 재료가 필요하니?"},
    {"en":"She checked all the ingredients before cooking.","ko":"그녀는 요리하기 전에 모든 재료를 확인했다."}
  ]'::jsonb),
  ('recommend', 1, 21, '동사', '[
    {"en":"Can you recommend a good restaurant?","ko":"좋은 식당을 추천해 줄 수 있나요?"},
    {"en":"The waiter recommended the fish dish.","ko":"웨이터는 생선 요리를 추천했다."},
    {"en":"I recommend trying this soup.","ko":"나는 이 수프를 먹어보길 추천한다."}
  ]'::jsonb),
  ('appetite', 1, 21, '명사', '[
    {"en":"Exercise gives me a good appetite.","ko":"운동은 나에게 좋은 식욕을 준다."},
    {"en":"He lost his appetite because he was sick.","ko":"그는 아파서 식욕을 잃었다."},
    {"en":"A walk before dinner can improve your appetite.","ko":"저녁 식사 전 산책은 식욕을 좋게 할 수 있다."}
  ]'::jsonb),
  ('be ready to', 1, 21, '동사구', '[
    {"en":"We are ready to order now.","ko":"우리는 이제 주문할 준비가 되었다."},
    {"en":"She was ready to leave for school.","ko":"그녀는 학교에 갈 준비가 되어 있었다."},
    {"en":"Are you ready to eat dinner?","ko":"저녁 먹을 준비 됐니?"}
  ]'::jsonb),
  ('wait for', 1, 21, '동사구', '[
    {"en":"We waited for our food for ten minutes.","ko":"우리는 음식을 10분 동안 기다렸다."},
    {"en":"She is waiting for her friend at the cafe.","ko":"그녀는 카페에서 친구를 기다리고 있다."},
    {"en":"Please wait for the waiter to bring the menu.","ko":"웨이터가 메뉴를 가져올 때까지 기다려 주세요."}
  ]'::jsonb),
  ('either A or B', 1, 21, '접속사구', '[
    {"en":"You can order either soup or salad.","ko":"너는 수프나 샐러드 둘 중 하나를 주문할 수 있다."},
    {"en":"She will choose either the cake or the ice cream.","ko":"그녀는 케이크나 아이스크림 둘 중 하나를 고를 것이다."},
    {"en":"We can eat either at home or at a restaurant.","ko":"우리는 집이나 식당 둘 중 한 곳에서 먹을 수 있다."}
  ]'::jsonb),
  ('sand', 1, 22, '명사', '[
    {"en":"The children played in the sand.","ko":"아이들은 모래에서 놀았다."},
    {"en":"We built a castle with sand.","ko":"우리는 모래로 성을 만들었다."},
    {"en":"The sand was hot under our feet.","ko":"모래는 우리 발밑에서 뜨거웠다."}
  ]'::jsonb),
  ('wave', 1, 22, '명사', '[
    {"en":"The waves were big at the beach today.","ko":"오늘 해변의 파도는 컸다."},
    {"en":"We watched the waves from the shore.","ko":"우리는 해안가에서 파도를 지켜봤다."},
    {"en":"A big wave splashed over the rocks.","ko":"커다란 파도가 바위 위로 튀었다."}
  ]'::jsonb),
  ('shell', 1, 22, '명사', '[
    {"en":"She collected shells on the beach.","ko":"그녀는 해변에서 조개껍데기를 모았다."},
    {"en":"We found a beautiful shell near the water.","ko":"우리는 물가 근처에서 아름다운 조개껍데기를 찾았다."},
    {"en":"The shell was pink and smooth.","ko":"그 조개껍데기는 분홍색이고 매끄러웠다."}
  ]'::jsonb),
  ('suntan', 1, 22, '명사', '[
    {"en":"He got a suntan after a day at the beach.","ko":"그는 해변에서 하루를 보낸 후 선탠이 되었다."},
    {"en":"She wanted a light suntan this summer.","ko":"그녀는 이번 여름에 가벼운 선탠을 원했다."},
    {"en":"A suntan can happen if you stay in the sun too long.","ko":"햇볕 아래 너무 오래 있으면 선탠이 될 수 있다."}
  ]'::jsonb),
  ('raft', 1, 22, '명사', '[
    {"en":"We floated on a raft in the river.","ko":"우리는 강에서 뗏목을 타고 떠다녔다."},
    {"en":"The children paddled the raft across the lake.","ko":"아이들은 호수를 가로질러 뗏목을 저었다."},
    {"en":"He rented a raft for the day.","ko":"그는 그날 뗏목을 빌렸다."}
  ]'::jsonb),
  ('yacht', 1, 22, '명사', '[
    {"en":"They sailed on a yacht during their vacation.","ko":"그들은 휴가 동안 요트를 타고 항해했다."},
    {"en":"The yacht was white and very large.","ko":"그 요트는 하얗고 매우 컸다."},
    {"en":"We saw many yachts near the harbor.","ko":"우리는 항구 근처에서 많은 요트를 보았다."}
  ]'::jsonb),
  ('sunglasses', 1, 22, '명사', '[
    {"en":"She wore sunglasses at the beach.","ko":"그녀는 해변에서 선글라스를 썼다."},
    {"en":"I forgot to bring my sunglasses today.","ko":"나는 오늘 선글라스를 가져오는 것을 잊었다."},
    {"en":"These sunglasses protect my eyes from the sun.","ko":"이 선글라스는 햇빛으로부터 내 눈을 보호해 준다."}
  ]'::jsonb),
  ('parasol', 1, 22, '명사', '[
    {"en":"We sat under a parasol on the beach.","ko":"우리는 해변에서 파라솔 아래 앉았다."},
    {"en":"The parasol gave us some nice shade.","ko":"그 파라솔은 우리에게 좋은 그늘을 만들어 주었다."},
    {"en":"She opened her parasol to block the sun.","ko":"그녀는 햇빛을 막기 위해 파라솔을 폈다."}
  ]'::jsonb),
  ('mat', 1, 22, '명사', '[
    {"en":"We sat on a mat at the picnic.","ko":"우리는 소풍에서 돗자리에 앉았다."},
    {"en":"She spread a mat on the sand.","ko":"그녀는 모래 위에 돗자리를 펼쳤다."},
    {"en":"The mat was soft and comfortable.","ko":"그 매트는 부드럽고 편안했다."}
  ]'::jsonb),
  ('vacation', 1, 22, '명사', '[
    {"en":"We are going to the beach for vacation.","ko":"우리는 휴가를 위해 해변에 갈 것이다."},
    {"en":"Summer vacation starts next week.","ko":"여름 방학이 다음 주에 시작된다."},
    {"en":"She spent her vacation with her family.","ko":"그녀는 가족과 함께 방학을 보냈다."}
  ]'::jsonb),
  ('whistle', 1, 22, '명사/동사', '[
    {"en":"The lifeguard blew his whistle loudly.","ko":"인명 구조원은 호루라기를 크게 불었다."},
    {"en":"She heard a whistle from the beach.","ko":"그녀는 해변에서 호각 소리를 들었다."},
    {"en":"He whistled to call his dog.","ko":"그는 개를 부르기 위해 휘파람을 불었다."}
  ]'::jsonb),
  ('lifeboat', 1, 22, '명사', '[
    {"en":"The lifeboat rescued the swimmers quickly.","ko":"구명보트는 수영하던 사람들을 빠르게 구조했다."},
    {"en":"There is a lifeboat near the beach station.","ko":"해변 초소 근처에 구명보트가 있다."},
    {"en":"The crew checked the lifeboat before sailing.","ko":"승무원들은 항해하기 전에 구명보트를 점검했다."}
  ]'::jsonb),
  ('scuba', 1, 22, '명사', '[
    {"en":"He learned scuba diving last summer.","ko":"그는 지난여름에 스쿠버 다이빙을 배웠다."},
    {"en":"We watched fish while scuba diving.","ko":"우리는 스쿠버 다이빙을 하며 물고기를 구경했다."},
    {"en":"Scuba diving needs special equipment.","ko":"스쿠버 다이빙에는 특별한 장비가 필요하다."}
  ]'::jsonb),
  ('swimsuit', 1, 22, '명사', '[
    {"en":"She bought a new swimsuit for the trip.","ko":"그녀는 여행을 위해 새 수영복을 샀다."},
    {"en":"Don''t forget to pack your swimsuit.","ko":"수영복 챙기는 것을 잊지 마."},
    {"en":"He wore a blue swimsuit at the pool.","ko":"그는 수영장에서 파란 수영복을 입었다."}
  ]'::jsonb),
  ('sunblock', 1, 22, '명사', '[
    {"en":"Put on sunblock before going outside.","ko":"밖에 나가기 전에 자외선 차단제를 발라라."},
    {"en":"She applied sunblock to her face and arms.","ko":"그녀는 얼굴과 팔에 자외선 차단제를 발랐다."},
    {"en":"I always carry sunblock in summer.","ko":"나는 여름에 항상 자외선 차단제를 가지고 다닌다."}
  ]'::jsonb),
  ('cooler', 1, 22, '명사', '[
    {"en":"We packed drinks in a cooler.","ko":"우리는 냉장 박스에 음료를 챙겼다."},
    {"en":"The cooler kept our food fresh all day.","ko":"그 냉장 박스는 하루 종일 우리 음식을 신선하게 유지해 주었다."},
    {"en":"He carried the cooler to the beach.","ko":"그는 냉장 박스를 해변으로 옮겼다."}
  ]'::jsonb),
  ('blanket', 1, 22, '명사', '[
    {"en":"We spread a blanket on the grass.","ko":"우리는 잔디 위에 담요를 펼쳤다."},
    {"en":"She wrapped herself in a warm blanket.","ko":"그녀는 따뜻한 담요로 몸을 감쌌다."},
    {"en":"The blanket kept us warm at the beach at night.","ko":"그 담요는 밤에 해변에서 우리를 따뜻하게 해주었다."}
  ]'::jsonb),
  ('shade', 1, 22, '명사', '[
    {"en":"We rested in the shade of a tree.","ko":"우리는 나무 그늘에서 쉬었다."},
    {"en":"The shade was cool and comfortable.","ko":"그늘은 시원하고 편안했다."},
    {"en":"Let''s find some shade to sit in.","ko":"앉을 그늘을 좀 찾아보자."}
  ]'::jsonb),
  ('shore', 1, 22, '명사', '[
    {"en":"We walked along the shore in the evening.","ko":"우리는 저녁에 물가를 따라 걸었다."},
    {"en":"The boat returned to the shore.","ko":"그 배는 물가로 돌아왔다."},
    {"en":"Children played near the shore.","ko":"아이들은 물가 근처에서 놀았다."}
  ]'::jsonb),
  ('sunbath', 1, 22, '명사', '[
    {"en":"She took a sunbath on the beach.","ko":"그녀는 해변에서 일광욕을 했다."},
    {"en":"A short sunbath can be relaxing.","ko":"짧은 일광욕은 편안할 수 있다."},
    {"en":"He enjoyed a sunbath after swimming.","ko":"그는 수영 후 일광욕을 즐겼다."}
  ]'::jsonb),
  ('lifeguard', 1, 22, '명사', '[
    {"en":"The lifeguard watched the swimmers carefully.","ko":"인명 구조원은 수영하는 사람들을 주의 깊게 지켜보았다."},
    {"en":"She wants to become a lifeguard someday.","ko":"그녀는 언젠가 인명 구조원이 되고 싶어 한다."},
    {"en":"The lifeguard helped a tired swimmer.","ko":"그 인명 구조원은 지친 수영하는 사람을 도와주었다."}
  ]'::jsonb),
  ('float', 1, 22, '동사', '[
    {"en":"The boat floated calmly on the water.","ko":"그 배는 물 위에서 잔잔하게 떠 있었다."},
    {"en":"Leaves floated on the surface of the lake.","ko":"나뭇잎들이 호수 표면 위에 떠 있었다."},
    {"en":"Can you float on your back?","ko":"너는 등을 대고 물에 뜰 수 있니?"}
  ]'::jsonb),
  ('flipper', 1, 22, '명사', '[
    {"en":"He wore flippers to swim faster.","ko":"그는 더 빨리 헤엄치기 위해 물갈퀴를 신었다."},
    {"en":"The flippers helped her move easily in the water.","ko":"그 오리발은 그녀가 물속에서 쉽게 움직이도록 도와주었다."},
    {"en":"She put on her flippers before diving.","ko":"그녀는 잠수하기 전에 오리발을 착용했다."}
  ]'::jsonb),
  ('binoculars', 1, 22, '명사', '[
    {"en":"He used binoculars to see the birds.","ko":"그는 새를 보기 위해 쌍안경을 사용했다."},
    {"en":"We brought binoculars to watch the boats.","ko":"우리는 배를 보기 위해 쌍안경을 가져왔다."},
    {"en":"She looked through her binoculars at the sea.","ko":"그녀는 쌍안경으로 바다를 살펴봤다."}
  ]'::jsonb),
  ('snorkel', 1, 22, '동사', '[
    {"en":"We went snorkeling near the coral reef.","ko":"우리는 산호초 근처에서 스노클링을 했다."},
    {"en":"He learned to snorkel during the trip.","ko":"그는 여행 중에 스노클링하는 법을 배웠다."},
    {"en":"Snorkeling lets you see fish under the water.","ko":"스노클링은 물속의 물고기를 볼 수 있게 해준다."}
  ]'::jsonb),
  ('pebble', 1, 22, '명사', '[
    {"en":"She picked up a small pebble on the shore.","ko":"그녀는 물가에서 작은 조약돌을 주웠다."},
    {"en":"The pebbles were smooth and round.","ko":"그 조약돌들은 매끄럽고 둥글었다."},
    {"en":"He threw a pebble into the lake.","ko":"그는 호수에 조약돌을 던졌다."}
  ]'::jsonb),
  ('expose', 1, 22, '동사', '[
    {"en":"Don''t expose your skin to the sun for too long.","ko":"피부를 햇빛에 너무 오래 노출시키지 마라."},
    {"en":"The photo was exposed to too much light.","ko":"그 사진은 빛에 너무 많이 노출되었다."},
    {"en":"We should not expose our eyes to strong light.","ko":"우리는 눈을 강한 빛에 노출시키면 안 된다."}
  ]'::jsonb),
  ('all day long', 1, 22, '부사구', '[
    {"en":"We played on the beach all day long.","ko":"우리는 하루 종일 해변에서 놀았다."},
    {"en":"She swam all day long during the vacation.","ko":"그녀는 방학 동안 하루 종일 수영했다."},
    {"en":"It rained all day long yesterday.","ko":"어제는 하루 종일 비가 왔다."}
  ]'::jsonb),
  ('look forward to ~ing', 1, 22, '동사구', '[
    {"en":"I look forward to visiting the beach this summer.","ko":"나는 이번 여름에 해변에 가는 것을 고대한다."},
    {"en":"She looks forward to seeing her friends on vacation.","ko":"그녀는 방학에 친구들을 만나는 것을 손꼽아 기다린다."},
    {"en":"We look forward to swimming in the sea.","ko":"우리는 바다에서 수영하는 것을 고대한다."}
  ]'::jsonb),
  ('throw away', 1, 22, '동사구', '[
    {"en":"Please throw away this trash.","ko":"이 쓰레기를 버려 주세요."},
    {"en":"She threw away the empty bottle.","ko":"그녀는 빈 병을 버렸다."},
    {"en":"Don''t throw away plastic on the beach.","ko":"해변에 플라스틱을 버리지 마라."}
  ]'::jsonb),
  ('festival', 1, 23, '명사', '[
    {"en":"We enjoyed the music festival last weekend.","ko":"우리는 지난 주말에 음악 축제를 즐겼다."},
    {"en":"The town holds a festival every autumn.","ko":"그 마을은 매년 가을 축제를 연다."},
    {"en":"Many people gathered for the festival.","ko":"많은 사람들이 그 축제를 위해 모였다."}
  ]'::jsonb),
  ('Valentine', 1, 23, '명사', '[
    {"en":"She gave her friend a card on Valentine''s Day.","ko":"그녀는 밸런타인데이에 친구에게 카드를 주었다."},
    {"en":"We exchanged small gifts on Valentine''s Day.","ko":"우리는 밸런타인데이에 작은 선물을 주고받았다."},
    {"en":"Valentine''s Day is celebrated in February.","ko":"밸런타인데이는 2월에 기념된다."}
  ]'::jsonb),
  ('blow', 1, 23, '동사', '[
    {"en":"The wind blew hard yesterday.","ko":"어제 바람이 세게 불었다."},
    {"en":"She blew out the candles on her cake.","ko":"그녀는 케이크의 촛불을 불어서 껐다."},
    {"en":"He blew a whistle to start the game.","ko":"그는 게임을 시작하기 위해 호루라기를 불었다."}
  ]'::jsonb),
  ('Christmas', 1, 23, '명사', '[
    {"en":"We decorate the tree every Christmas.","ko":"우리는 매년 크리스마스마다 트리를 장식한다."},
    {"en":"Christmas is celebrated on December 25th.","ko":"크리스마스는 12월 25일에 기념된다."},
    {"en":"My family gathers together at Christmas.","ko":"우리 가족은 크리스마스에 함께 모인다."}
  ]'::jsonb),
  ('candy', 1, 23, '명사', '[
    {"en":"The children shared candy at the party.","ko":"아이들은 파티에서 사탕을 나누어 먹었다."},
    {"en":"She bought a bag of candy for the kids.","ko":"그녀는 아이들을 위해 사탕 한 봉지를 샀다."},
    {"en":"Too much candy is not good for your teeth.","ko":"너무 많은 사탕은 치아에 좋지 않다."}
  ]'::jsonb),
  ('year', 1, 23, '명사', '[
    {"en":"This year has passed very quickly.","ko":"올해는 매우 빨리 지나갔다."},
    {"en":"We celebrate this festival every year.","ko":"우리는 매년 이 축제를 기념한다."},
    {"en":"Next year, we plan to visit our grandparents.","ko":"내년에 우리는 조부모님을 방문할 계획이다."}
  ]'::jsonb),
  ('wish', 1, 23, '명사/동사', '[
    {"en":"She made a wish before blowing out the candles.","ko":"그녀는 촛불을 불어 끄기 전에 소원을 빌었다."},
    {"en":"I wish you a happy new year.","ko":"새해 복 많이 받으세요."},
    {"en":"He wished for good health and happiness.","ko":"그는 건강과 행복을 기원했다."}
  ]'::jsonb),
  ('mask', 1, 23, '명사', '[
    {"en":"The children wore colorful masks at the party.","ko":"아이들은 파티에서 화려한 가면을 썼다."},
    {"en":"She made a paper mask for the festival.","ko":"그녀는 축제를 위해 종이 가면을 만들었다."},
    {"en":"He put on a funny mask.","ko":"그는 재미있는 가면을 썼다."}
  ]'::jsonb),
  ('celebrate', 1, 23, '동사', '[
    {"en":"We celebrate my sister''s birthday every year.","ko":"우리는 매년 여동생의 생일을 축하한다."},
    {"en":"The town celebrates the harvest festival in autumn.","ko":"그 마을은 가을에 추수 축제를 기념한다."},
    {"en":"They celebrated the holiday with their family.","ko":"그들은 가족과 함께 명절을 기념했다."}
  ]'::jsonb),
  ('gather', 1, 23, '동사', '[
    {"en":"Our family gathers together on holidays.","ko":"우리 가족은 명절에 함께 모인다."},
    {"en":"Many people gathered in the park for the festival.","ko":"많은 사람들이 축제를 위해 공원에 모였다."},
    {"en":"We gathered around the table to eat dinner.","ko":"우리는 저녁을 먹기 위해 식탁에 모였다."}
  ]'::jsonb),
  ('honeymoon', 1, 23, '명사', '[
    {"en":"My aunt went to Jeju Island for her honeymoon.","ko":"이모는 신혼여행으로 제주도에 갔다."},
    {"en":"They planned a honeymoon trip abroad.","ko":"그들은 해외로 신혼여행을 계획했다."},
    {"en":"The honeymoon lasted for a week.","ko":"그 신혼여행은 일주일 동안 계속되었다."}
  ]'::jsonb),
  ('Easter', 1, 23, '명사', '[
    {"en":"We paint eggs to celebrate Easter.","ko":"우리는 부활절을 기념하기 위해 달걀을 색칠한다."},
    {"en":"Easter is celebrated in the spring.","ko":"부활절은 봄에 기념된다."},
    {"en":"The children searched for eggs on Easter.","ko":"아이들은 부활절에 달걀을 찾았다."}
  ]'::jsonb),
  ('hide', 1, 23, '동사', '[
    {"en":"The children hid behind the tree.","ko":"아이들은 나무 뒤에 숨었다."},
    {"en":"She hid the present in the closet.","ko":"그녀는 선물을 옷장에 숨겼다."},
    {"en":"We played hide and seek at the party.","ko":"우리는 파티에서 숨바꼭질을 했다."}
  ]'::jsonb),
  ('invitation', 1, 23, '명사', '[
    {"en":"She sent invitations for her birthday party.","ko":"그녀는 생일 파티 초대장을 보냈다."},
    {"en":"We received an invitation to the festival.","ko":"우리는 축제 초대장을 받았다."},
    {"en":"The invitation said the party starts at six.","ko":"그 초대장에는 파티가 6시에 시작한다고 쓰여 있었다."}
  ]'::jsonb),
  ('Eve', 1, 23, '명사', '[
    {"en":"We stayed up late on New Year''s Eve.","ko":"우리는 새해 전날 밤 늦게까지 깨어 있었다."},
    {"en":"On Christmas Eve, we decorate the tree together.","ko":"크리스마스 이브에 우리는 함께 트리를 장식한다."},
    {"en":"They watched fireworks on New Year''s Eve.","ko":"그들은 새해 전날 불꽃놀이를 보았다."}
  ]'::jsonb),
  ('decorate', 1, 23, '동사', '[
    {"en":"We decorated the classroom for the festival.","ko":"우리는 축제를 위해 교실을 장식했다."},
    {"en":"She decorated the cake with fruit.","ko":"그녀는 과일로 케이크를 장식했다."},
    {"en":"They decorated the house with lights.","ko":"그들은 조명으로 집을 장식했다."}
  ]'::jsonb),
  ('witch', 1, 23, '명사', '[
    {"en":"She dressed as a witch for Halloween.","ko":"그녀는 핼러윈을 위해 마녀로 분장했다."},
    {"en":"The children were not scared of the friendly witch.","ko":"아이들은 친절한 마녀를 무서워하지 않았다."},
    {"en":"A witch costume was popular at the party.","ko":"마녀 의상은 그 파티에서 인기가 있었다."}
  ]'::jsonb),
  ('trick', 1, 23, '동사/명사', '[
    {"en":"Children say trick-or-treat at each door on Halloween.","ko":"아이들은 핼러윈에 각 문에서 trick-or-treat라고 말한다."},
    {"en":"He played a funny trick on his friend.","ko":"그는 친구에게 재미있는 장난을 쳤다."},
    {"en":"She learned a new magic trick.","ko":"그녀는 새로운 마술을 배웠다."}
  ]'::jsonb),
  ('costume', 1, 23, '명사', '[
    {"en":"He wore a pirate costume for the party.","ko":"그는 파티를 위해 해적 의상을 입었다."},
    {"en":"She made her own costume for Halloween.","ko":"그녀는 핼러윈을 위해 직접 의상을 만들었다."},
    {"en":"The costume contest was fun to watch.","ko":"그 의상 대회는 보기에 재미있었다."}
  ]'::jsonb),
  ('turkey', 1, 23, '명사', '[
    {"en":"We eat turkey on Thanksgiving Day.","ko":"우리는 추수감사절에 칠면조를 먹는다."},
    {"en":"The turkey was cooked for three hours.","ko":"그 칠면조는 세 시간 동안 요리되었다."},
    {"en":"She helped her mother prepare the turkey.","ko":"그녀는 어머니가 칠면조 요리를 준비하는 것을 도왔다."}
  ]'::jsonb),
  ('anniversary', 1, 23, '명사', '[
    {"en":"Today is my parents'' wedding anniversary.","ko":"오늘은 우리 부모님의 결혼기념일이다."},
    {"en":"We celebrated the school''s anniversary with a concert.","ko":"우리는 콘서트로 학교 기념일을 축하했다."},
    {"en":"They had a small party for their anniversary.","ko":"그들은 기념일을 위해 작은 파티를 열었다."}
  ]'::jsonb),
  ('congratulate', 1, 23, '동사', '[
    {"en":"We congratulated her on winning the prize.","ko":"우리는 그녀가 상을 받은 것을 축하했다."},
    {"en":"He congratulated his friend on the good news.","ko":"그는 친구에게 좋은 소식을 축하해 주었다."},
    {"en":"They congratulated the graduates warmly.","ko":"그들은 졸업생들을 따뜻하게 축하했다."}
  ]'::jsonb),
  ('Thanksgiving', 1, 23, '명사', '[
    {"en":"We give thanks to our family on Thanksgiving.","ko":"우리는 추수감사절에 가족에게 감사를 표현한다."},
    {"en":"Thanksgiving is celebrated in November.","ko":"추수감사절은 11월에 기념된다."},
    {"en":"Our family gathers together for Thanksgiving dinner.","ko":"우리 가족은 추수감사절 저녁을 위해 함께 모인다."}
  ]'::jsonb),
  ('Halloween', 1, 23, '명사', '[
    {"en":"Children wear costumes on Halloween.","ko":"아이들은 핼러윈에 의상을 입는다."},
    {"en":"We carved a pumpkin for Halloween.","ko":"우리는 핼러윈을 위해 호박을 조각했다."},
    {"en":"Halloween is celebrated at the end of October.","ko":"핼러윈은 10월 말에 기념된다."}
  ]'::jsonb),
  ('reindeer', 1, 23, '명사', '[
    {"en":"The story says Santa''s sleigh is pulled by reindeer.","ko":"이야기에 따르면 산타의 썰매는 순록들이 끈다고 한다."},
    {"en":"We drew pictures of reindeer for Christmas.","ko":"우리는 크리스마스를 위해 순록 그림을 그렸다."},
    {"en":"Reindeer live in cold, snowy places.","ko":"순록은 춥고 눈이 많이 오는 곳에 산다."}
  ]'::jsonb),
  ('lantern', 1, 23, '명사', '[
    {"en":"We made a paper lantern for the festival.","ko":"우리는 축제를 위해 종이 랜턴을 만들었다."},
    {"en":"The lantern lit up the dark path.","ko":"그 랜턴은 어두운 길을 밝혀 주었다."},
    {"en":"They hung colorful lanterns in the yard.","ko":"그들은 마당에 화려한 랜턴을 걸었다."}
  ]'::jsonb),
  ('stuff', 1, 23, '동사/명사', '[
    {"en":"She stuffed the turkey with rice and vegetables.","ko":"그녀는 칠면조에 밥과 채소를 채워 넣었다."},
    {"en":"We packed all our stuff for the trip.","ko":"우리는 여행을 위해 모든 짐을 챙겼다."},
    {"en":"He put his stuff on the table.","ko":"그는 자신의 물건을 테이블 위에 놓았다."}
  ]'::jsonb),
  ('crowded', 1, 23, '형용사', '[
    {"en":"The park was crowded during the festival.","ko":"그 공원은 축제 동안 붐볐다."},
    {"en":"The market gets crowded on weekends.","ko":"그 시장은 주말에 혼잡해진다."},
    {"en":"It was too crowded to walk easily.","ko":"너무 붐벼서 걷기가 쉽지 않았다."}
  ]'::jsonb),
  ('take place', 1, 23, '동사구', '[
    {"en":"The festival takes place every October.","ko":"그 축제는 매년 10월에 열린다."},
    {"en":"The event will take place in the school gym.","ko":"그 행사는 학교 체육관에서 열릴 것이다."},
    {"en":"Where does the ceremony take place?","ko":"그 행사는 어디서 열리나요?"}
  ]'::jsonb),
  ('be similar to', 1, 23, '동사구', '[
    {"en":"This festival is similar to one in my country.","ko":"이 축제는 우리나라의 한 축제와 비슷하다."},
    {"en":"Her costume is similar to her sister''s.","ko":"그녀의 의상은 언니의 것과 비슷하다."},
    {"en":"This tradition is similar to an old custom.","ko":"이 전통은 오래된 관습과 비슷하다."}
  ]'::jsonb),
  ('seesaw', 1, 24, '명사/동사', '[
    {"en":"The children played on the seesaw.","ko":"아이들은 시소를 타고 놀았다."},
    {"en":"We took turns on the seesaw at the playground.","ko":"우리는 놀이터에서 시소를 번갈아 탔다."},
    {"en":"She likes to seesaw with her little brother.","ko":"그녀는 남동생과 시소 타는 것을 좋아한다."}
  ]'::jsonb),
  ('walk', 1, 24, '동사', '[
    {"en":"We walked around the park after lunch.","ko":"우리는 점심 식사 후 공원을 걸었다."},
    {"en":"She walks to school every morning.","ko":"그녀는 매일 아침 학교까지 걸어간다."},
    {"en":"Let''s walk along the river together.","ko":"강을 따라 함께 걷자."}
  ]'::jsonb),
  ('ride', 1, 24, '명사/동사', '[
    {"en":"We went on a fun ride at the amusement park.","ko":"우리는 놀이공원에서 재미있는 놀이기구를 탔다."},
    {"en":"He rode his bike to the park.","ko":"그는 자전거를 타고 공원에 갔다."},
    {"en":"Can I get a ride with you?","ko":"너와 함께 타고 가도 될까?"}
  ]'::jsonb),
  ('bench', 1, 24, '명사', '[
    {"en":"We sat on a bench in the park.","ko":"우리는 공원 벤치에 앉았다."},
    {"en":"There is a wooden bench under the tree.","ko":"나무 아래에 나무 벤치가 있다."},
    {"en":"She rested on the bench for a while.","ko":"그녀는 잠시 벤치에서 쉬었다."}
  ]'::jsonb),
  ('event', 1, 24, '명사', '[
    {"en":"The school held a special event today.","ko":"학교는 오늘 특별한 행사를 열었다."},
    {"en":"We are excited about the summer event.","ko":"우리는 여름 행사에 대해 기대하고 있다."},
    {"en":"Many families joined the community event.","ko":"많은 가족들이 지역 행사에 참여했다."}
  ]'::jsonb),
  ('picnic', 1, 24, '명사', '[
    {"en":"We had a picnic in the park.","ko":"우리는 공원에서 소풍을 즐겼다."},
    {"en":"Let''s go on a picnic this weekend.","ko":"이번 주말에 소풍을 가자."},
    {"en":"She packed sandwiches for the picnic.","ko":"그녀는 소풍을 위해 샌드위치를 쌌다."}
  ]'::jsonb),
  ('zoo', 1, 24, '명사', '[
    {"en":"We visited the zoo last Sunday.","ko":"우리는 지난 일요일에 동물원을 방문했다."},
    {"en":"The zoo has many kinds of animals.","ko":"그 동물원에는 많은 종류의 동물들이 있다."},
    {"en":"Children love watching the monkeys at the zoo.","ko":"아이들은 동물원에서 원숭이를 보는 것을 좋아한다."}
  ]'::jsonb),
  ('concert', 1, 24, '명사', '[
    {"en":"We went to a concert last night.","ko":"우리는 어젯밤 콘서트에 갔다."},
    {"en":"The concert started at seven o''clock.","ko":"그 콘서트는 7시에 시작했다."},
    {"en":"She enjoyed the school concert very much.","ko":"그녀는 학교 콘서트를 매우 즐겼다."}
  ]'::jsonb),
  ('visit', 1, 24, '동사', '[
    {"en":"We visited our grandparents last weekend.","ko":"우리는 지난 주말에 조부모님을 방문했다."},
    {"en":"She wants to visit the museum this month.","ko":"그녀는 이번 달에 박물관을 방문하고 싶어 한다."},
    {"en":"They visited the aquarium during vacation.","ko":"그들은 방학 동안 수족관을 방문했다."}
  ]'::jsonb),
  ('rope', 1, 24, '명사', '[
    {"en":"The children played with a jump rope.","ko":"아이들은 줄넘기를 하며 놀았다."},
    {"en":"He tied the rope tightly around the tent.","ko":"그는 텐트 주위에 밧줄을 단단히 묶었다."},
    {"en":"We used a rope to climb the hill.","ko":"우리는 언덕을 오르기 위해 밧줄을 사용했다."}
  ]'::jsonb),
  ('backpack', 1, 24, '명사/동사', '[
    {"en":"She packed her backpack for the trip.","ko":"그녀는 여행을 위해 배낭을 쌌다."},
    {"en":"He carried a heavy backpack to school.","ko":"그는 무거운 배낭을 메고 학교에 갔다."},
    {"en":"We backpacked through the forest all day.","ko":"우리는 하루 종일 숲을 배낭을 메고 걸었다."}
  ]'::jsonb),
  ('slide', 1, 24, '명사/동사', '[
    {"en":"The children slid down the slide happily.","ko":"아이들은 신나게 미끄럼틀을 타고 내려왔다."},
    {"en":"There is a tall slide at the playground.","ko":"놀이터에는 높은 미끄럼틀이 있다."},
    {"en":"She likes to slide down the hill in winter.","ko":"그녀는 겨울에 언덕을 미끄러져 내려가는 것을 좋아한다."}
  ]'::jsonb),
  ('fountain', 1, 24, '명사', '[
    {"en":"We took pictures near the fountain.","ko":"우리는 분수 근처에서 사진을 찍었다."},
    {"en":"The fountain in the park is beautiful at night.","ko":"공원에 있는 분수는 밤에 아름답다."},
    {"en":"Children played around the fountain.","ko":"아이들은 분수 주변에서 놀았다."}
  ]'::jsonb),
  ('playground', 1, 24, '명사', '[
    {"en":"The children ran to the playground after school.","ko":"아이들은 방과 후 놀이터로 뛰어갔다."},
    {"en":"There is a new playground near our house.","ko":"우리 집 근처에 새로운 놀이터가 있다."},
    {"en":"We spent the afternoon at the playground.","ko":"우리는 오후를 놀이터에서 보냈다."}
  ]'::jsonb),
  ('swing', 1, 24, '명사/동사', '[
    {"en":"She loves to swing on the swings at the park.","ko":"그녀는 공원에서 그네를 타는 것을 좋아한다."},
    {"en":"He pushed his little sister on the swing.","ko":"그는 여동생을 그네에 태우고 밀어 주었다."},
    {"en":"The children took turns on the swing.","ko":"아이들은 그네를 번갈아 탔다."}
  ]'::jsonb),
  ('sleeping bag', 1, 24, '명사', '[
    {"en":"We brought sleeping bags for camping.","ko":"우리는 캠핑을 위해 침낭을 가져왔다."},
    {"en":"He slept warmly in his sleeping bag.","ko":"그는 침낭 안에서 따뜻하게 잤다."},
    {"en":"Don''t forget your sleeping bag for the trip.","ko":"여행을 위한 침낭을 잊지 마."}
  ]'::jsonb),
  ('campfire', 1, 24, '명사', '[
    {"en":"We sat around the campfire and sang songs.","ko":"우리는 모닥불 주위에 앉아 노래를 불렀다."},
    {"en":"The campfire kept us warm at night.","ko":"그 모닥불은 밤에 우리를 따뜻하게 해 주었다."},
    {"en":"They told stories by the campfire.","ko":"그들은 모닥불 옆에서 이야기를 나눴다."}
  ]'::jsonb),
  ('fishing rod', 1, 24, '명사', '[
    {"en":"He brought his fishing rod to the lake.","ko":"그는 낚싯대를 호수로 가져왔다."},
    {"en":"My father taught me how to use a fishing rod.","ko":"아버지는 나에게 낚싯대 사용법을 가르쳐 주셨다."},
    {"en":"She bought a new fishing rod for the trip.","ko":"그녀는 여행을 위해 새 낚싯대를 샀다."}
  ]'::jsonb),
  ('sail', 1, 24, '동사', '[
    {"en":"We sailed across the lake in the morning.","ko":"우리는 아침에 호수를 가로질러 항해했다."},
    {"en":"The boat sailed smoothly on the calm sea.","ko":"그 배는 잔잔한 바다 위를 매끄럽게 항해했다."},
    {"en":"They sailed to a nearby island.","ko":"그들은 가까운 섬으로 항해했다."}
  ]'::jsonb),
  ('amusement', 1, 24, '명사', '[
    {"en":"The children screamed with amusement on the ride.","ko":"아이들은 놀이기구를 타며 즐거움에 소리쳤다."},
    {"en":"We spent the day at an amusement park.","ko":"우리는 놀이공원에서 하루를 보냈다."},
    {"en":"The show was full of amusement for the kids.","ko":"그 공연은 아이들에게 즐거움이 가득했다."}
  ]'::jsonb),
  ('merry-go-round', 1, 24, '명사', '[
    {"en":"The little kids rode the merry-go-round.","ko":"어린 아이들은 회전목마를 탔다."},
    {"en":"We watched the merry-go-round turn slowly.","ko":"우리는 회전목마가 천천히 도는 것을 지켜봤다."},
    {"en":"She loved the music from the merry-go-round.","ko":"그녀는 회전목마에서 나오는 음악을 좋아했다."}
  ]'::jsonb),
  ('flea market', 1, 24, '명사', '[
    {"en":"We found cheap toys at the flea market.","ko":"우리는 벼룩시장에서 저렴한 장난감을 찾았다."},
    {"en":"The flea market opens every Saturday.","ko":"그 벼룩시장은 매주 토요일에 열린다."},
    {"en":"She sold her old books at the flea market.","ko":"그녀는 벼룩시장에서 낡은 책을 팔았다."}
  ]'::jsonb),
  ('botanical garden', 1, 24, '명사', '[
    {"en":"We visited the botanical garden in spring.","ko":"우리는 봄에 식물원을 방문했다."},
    {"en":"The botanical garden has many kinds of flowers.","ko":"그 식물원에는 많은 종류의 꽃들이 있다."},
    {"en":"We took a walk through the botanical garden.","ko":"우리는 식물원을 걸어서 둘러봤다."}
  ]'::jsonb),
  ('aquarium', 1, 24, '명사', '[
    {"en":"We saw many fish at the aquarium.","ko":"우리는 수족관에서 많은 물고기를 보았다."},
    {"en":"The aquarium has a huge shark tank.","ko":"그 수족관에는 커다란 상어 수조가 있다."},
    {"en":"Children love watching dolphins at the aquarium.","ko":"아이들은 수족관에서 돌고래를 보는 것을 좋아한다."}
  ]'::jsonb),
  ('thermos', 1, 24, '명사', '[
    {"en":"She filled the thermos with hot tea.","ko":"그녀는 보온병에 뜨거운 차를 채웠다."},
    {"en":"He brought a thermos of coffee on the hike.","ko":"그는 하이킹에 커피가 담긴 보온병을 가져왔다."},
    {"en":"The thermos kept the soup warm all day.","ko":"그 보온병은 하루 종일 수프를 따뜻하게 유지해 주었다."}
  ]'::jsonb),
  ('peak', 1, 24, '명사', '[
    {"en":"We reached the peak of the mountain by noon.","ko":"우리는 정오까지 산 정상에 도착했다."},
    {"en":"The view from the peak was amazing.","ko":"정상에서 본 풍경은 놀라웠다."},
    {"en":"It took three hours to climb to the peak.","ko":"정상까지 오르는 데 세 시간이 걸렸다."}
  ]'::jsonb),
  ('rapids', 1, 24, '명사', '[
    {"en":"They rafted down the rapids of the river.","ko":"그들은 강의 급류를 따라 래프팅을 했다."},
    {"en":"The rapids were too dangerous to swim in.","ko":"그 급류는 수영하기에 너무 위험했다."},
    {"en":"We heard the sound of the rapids from far away.","ko":"우리는 멀리서 급류 소리를 들었다."}
  ]'::jsonb),
  ('get together', 1, 24, '동사구', '[
    {"en":"Our family gets together every holiday.","ko":"우리 가족은 매 명절마다 모인다."},
    {"en":"Let''s get together for a picnic this weekend.","ko":"이번 주말에 소풍을 위해 모이자."},
    {"en":"They got together to plan the school event.","ko":"그들은 학교 행사를 계획하기 위해 모였다."}
  ]'::jsonb),
  ('because of', 1, 24, '전치사구', '[
    {"en":"The picnic was canceled because of the rain.","ko":"소풍은 비 때문에 취소되었다."},
    {"en":"We stayed home because of the cold weather.","ko":"우리는 추운 날씨 때문에 집에 머물렀다."},
    {"en":"She was late because of the traffic.","ko":"그녀는 교통 체증 때문에 늦었다."}
  ]'::jsonb),
  ('be filled with', 1, 24, '동사구', '[
    {"en":"The park was filled with happy children.","ko":"그 공원은 행복한 아이들로 가득 차 있었다."},
    {"en":"The basket was filled with fresh fruit.","ko":"그 바구니는 신선한 과일로 가득 차 있었다."},
    {"en":"Her eyes were filled with excitement at the zoo.","ko":"동물원에서 그녀의 눈은 흥분으로 가득했다."}
  ]'::jsonb)
) as t(word, level, study_day, pos, examples)
where v.word = t.word and v.level = t.level and v.study_day = t.study_day;
