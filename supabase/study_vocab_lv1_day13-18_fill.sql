-- SAP 1기 대시보드: Study 탭 — Lv.1(중등 실력) Day 13~18 품사/예문 채우기 (180단어).
update public.vocab_words v
set part_of_speech = t.pos, example_sentences = t.examples, updated_at = now()
from (values
  ('bottle', 1, 13, '명사', '[
    {"en":"I filled the bottle with water before the hike.","ko":"나는 하이킹 전에 병에 물을 채웠다."},
    {"en":"She put the flowers in a glass bottle.","ko":"그녀는 꽃을 유리병에 꽂았다."},
    {"en":"Please recycle the empty bottle.","ko":"빈 병을 재활용해 주세요."}
  ]'::jsonb),
  ('package', 1, 13, '명사', '[
    {"en":"The mail carrier delivered a package this morning.","ko":"우편배달부가 오늘 아침 소포를 배달했다."},
    {"en":"I opened the package carefully.","ko":"나는 소포를 조심스럽게 열었다."},
    {"en":"The package contained a birthday gift for my sister.","ko":"그 소포에는 내 여동생을 위한 생일 선물이 들어 있었다."}
  ]'::jsonb),
  ('can', 1, 13, '명사/동사', '[
    {"en":"We bought a can of tomatoes for the soup.","ko":"우리는 수프를 만들기 위해 토마토 통조림 한 캔을 샀다."},
    {"en":"My grandmother cans peaches every summer.","ko":"우리 할머니는 매년 여름 복숭아를 통조림으로 만드신다."},
    {"en":"Please put the empty can in the recycling bin.","ko":"빈 깡통을 재활용 통에 넣어 주세요."}
  ]'::jsonb),
  ('item', 1, 13, '명사', '[
    {"en":"Each item in the store has a price tag.","ko":"가게의 각 품목에는 가격표가 붙어 있다."},
    {"en":"I need to buy three items from the list.","ko":"나는 목록에서 세 개의 품목을 사야 한다."},
    {"en":"This item is on sale today.","ko":"이 상품은 오늘 할인 중이다."}
  ]'::jsonb),
  ('pack', 1, 13, '명사/동사', '[
    {"en":"I need to pack my bag for the school trip.","ko":"나는 수학여행을 위해 가방을 싸야 한다."},
    {"en":"She bought a pack of pencils.","ko":"그녀는 연필 한 팩을 샀다."},
    {"en":"We packed sandwiches for the picnic.","ko":"우리는 소풍을 위해 샌드위치를 쌌다."}
  ]'::jsonb),
  ('ice', 1, 13, '명사', '[
    {"en":"Please put some ice in my drink.","ko":"제 음료에 얼음을 좀 넣어 주세요."},
    {"en":"The pond froze into ice last night.","ko":"어젯밤 연못이 얼음으로 얼었다."},
    {"en":"We slipped on the ice near the gate.","ko":"우리는 대문 근처의 얼음 위에서 미끄러졌다."}
  ]'::jsonb),
  ('bar', 1, 13, '명사', '[
    {"en":"She gave me a bar of chocolate.","ko":"그녀는 나에게 초콜릿 한 개를 주었다."},
    {"en":"The gym has metal bars for exercise.","ko":"그 체육관에는 운동용 철봉이 있다."},
    {"en":"He held onto the bar tightly.","ko":"그는 막대를 꽉 붙잡았다."}
  ]'::jsonb),
  ('piece', 1, 13, '명사', '[
    {"en":"Can I have a piece of cake?","ko":"케이크 한 조각 먹어도 될까요?"},
    {"en":"She cut the paper into small pieces.","ko":"그녀는 종이를 작은 조각들로 잘랐다."},
    {"en":"He gave me a piece of good advice.","ko":"그는 나에게 좋은 조언 한마디를 해 주었다."}
  ]'::jsonb),
  ('counter', 1, 13, '명사', '[
    {"en":"Please pay at the counter.","ko":"계산대에서 계산해 주세요."},
    {"en":"The clerk stood behind the counter.","ko":"점원은 계산대 뒤에 서 있었다."},
    {"en":"I left my umbrella on the counter.","ko":"나는 계산대 위에 우산을 두고 왔다."}
  ]'::jsonb),
  ('spray', 1, 13, '명사/동사', '[
    {"en":"She used a spray to water the plants.","ko":"그녀는 식물에 물을 주기 위해 분무기를 사용했다."},
    {"en":"Please spray some water on the flowers.","ko":"꽃에 물을 좀 뿌려 주세요."},
    {"en":"He bought a bottle of insect spray.","ko":"그는 살충 스프레이 한 병을 샀다."}
  ]'::jsonb),
  ('bin', 1, 13, '명사', '[
    {"en":"Put the paper in the recycling bin.","ko":"종이를 재활용함에 넣으세요."},
    {"en":"The bin was full of old books.","ko":"그 상자는 오래된 책들로 가득 차 있었다."},
    {"en":"We keep toys in a big bin.","ko":"우리는 큰 상자에 장난감을 보관한다."}
  ]'::jsonb),
  ('smoked', 1, 13, '형용사', '[
    {"en":"We had smoked fish for dinner.","ko":"우리는 저녁으로 훈제 생선을 먹었다."},
    {"en":"Smoked cheese has a strong flavor.","ko":"훈제 치즈는 향이 강하다."},
    {"en":"My father likes smoked chicken.","ko":"우리 아버지는 훈제 치킨을 좋아하신다."}
  ]'::jsonb),
  ('fresh', 1, 13, '형용사', '[
    {"en":"The vegetables at the market are very fresh.","ko":"시장의 채소들은 매우 신선하다."},
    {"en":"We drank fresh orange juice this morning.","ko":"우리는 오늘 아침 신선한 오렌지 주스를 마셨다."},
    {"en":"Fresh air made me feel better.","ko":"신선한 공기를 마시니 기분이 좋아졌다."}
  ]'::jsonb),
  ('grain', 1, 13, '명사', '[
    {"en":"Rice is an important grain in Korea.","ko":"쌀은 한국에서 중요한 곡물이다."},
    {"en":"Farmers store grain in large barns.","ko":"농부들은 큰 헛간에 곡물을 저장한다."},
    {"en":"This bread is made from whole grain.","ko":"이 빵은 통곡물로 만들어졌다."}
  ]'::jsonb),
  ('vegetable', 1, 13, '명사', '[
    {"en":"I eat vegetables every day for good health.","ko":"나는 건강을 위해 매일 채소를 먹는다."},
    {"en":"My mother grows vegetables in the garden.","ko":"우리 어머니는 정원에서 채소를 기르신다."},
    {"en":"Carrots are my favorite vegetable.","ko":"당근은 내가 가장 좋아하는 채소이다."}
  ]'::jsonb),
  ('cart', 1, 13, '명사', '[
    {"en":"She pushed the cart through the store.","ko":"그녀는 가게 안에서 카트를 밀었다."},
    {"en":"We filled the cart with groceries.","ko":"우리는 카트를 식료품으로 채웠다."},
    {"en":"The cart was too heavy to move.","ko":"그 카트는 너무 무거워서 움직이기 힘들었다."}
  ]'::jsonb),
  ('seafood', 1, 13, '명사', '[
    {"en":"My family enjoys seafood on weekends.","ko":"우리 가족은 주말에 해산물을 즐긴다."},
    {"en":"The restaurant near the harbor serves fresh seafood.","ko":"항구 근처의 그 식당은 신선한 해산물을 낸다."},
    {"en":"I don''t eat much seafood.","ko":"나는 해산물을 많이 먹지 않는다."}
  ]'::jsonb),
  ('cashier', 1, 13, '명사', '[
    {"en":"The cashier smiled and gave me the change.","ko":"계산원은 미소 지으며 거스름돈을 주었다."},
    {"en":"He works as a cashier at a supermarket.","ko":"그는 슈퍼마켓에서 계산원으로 일한다."},
    {"en":"I thanked the cashier before leaving.","ko":"나는 나가기 전에 계산원에게 감사 인사를 했다."}
  ]'::jsonb),
  ('freezer', 1, 13, '명사', '[
    {"en":"We keep ice cream in the freezer.","ko":"우리는 아이스크림을 냉동고에 보관한다."},
    {"en":"The freezer was full of frozen vegetables.","ko":"냉동고는 냉동 채소로 가득 차 있었다."},
    {"en":"Please put the meat in the freezer.","ko":"고기를 냉동고에 넣어 주세요."}
  ]'::jsonb),
  ('frozen food', 1, 13, '명사구', '[
    {"en":"Frozen food is easy to cook.","ko":"냉동식품은 요리하기 쉽다."},
    {"en":"We bought some frozen food for the week.","ko":"우리는 일주일 치 냉동식품을 좀 샀다."},
    {"en":"Frozen food should be stored carefully.","ko":"냉동식품은 신중하게 보관해야 한다."}
  ]'::jsonb),
  ('grocery', 1, 13, '명사', '[
    {"en":"I went to the grocery store after school.","ko":"나는 방과 후 식료품점에 갔다."},
    {"en":"My father carried the groceries into the kitchen.","ko":"아버지는 식료품을 부엌으로 옮기셨다."},
    {"en":"We need to buy groceries for dinner.","ko":"우리는 저녁을 위해 식료품을 사야 한다."}
  ]'::jsonb),
  ('container', 1, 13, '명사', '[
    {"en":"She stored the rice in a plastic container.","ko":"그녀는 쌀을 플라스틱 용기에 보관했다."},
    {"en":"The container was too small for all the food.","ko":"그 용기는 모든 음식을 담기에 너무 작았다."},
    {"en":"Put the leftovers in a container.","ko":"남은 음식을 용기에 담으세요."}
  ]'::jsonb),
  ('aisle', 1, 13, '명사', '[
    {"en":"The snacks are in the third aisle.","ko":"과자는 세 번째 통로에 있다."},
    {"en":"She walked down the aisle looking for milk.","ko":"그녀는 우유를 찾으며 통로를 걸었다."},
    {"en":"The store aisles were crowded on the weekend.","ko":"그 가게의 통로들은 주말에 붐볐다."}
  ]'::jsonb),
  ('dairy', 1, 13, '형용사', '[
    {"en":"Milk and cheese are dairy products.","ko":"우유와 치즈는 유제품이다."},
    {"en":"She avoids dairy food because of allergies.","ko":"그녀는 알레르기 때문에 유제품을 피한다."},
    {"en":"The dairy section is next to the vegetables.","ko":"유제품 코너는 채소 코너 옆에 있다."}
  ]'::jsonb),
  ('bundle', 1, 13, '명사', '[
    {"en":"He carried a bundle of newspapers.","ko":"그는 신문 한 다발을 들고 갔다."},
    {"en":"She tied the vegetables into a bundle.","ko":"그녀는 채소를 한 다발로 묶었다."},
    {"en":"We found a bundle of old letters in the box.","ko":"우리는 상자 안에서 오래된 편지 다발을 발견했다."}
  ]'::jsonb),
  ('pile', 1, 13, '명사', '[
    {"en":"There was a pile of books on the desk.","ko":"책상 위에 책 더미가 있었다."},
    {"en":"She made a pile of clean clothes.","ko":"그녀는 깨끗한 옷 더미를 만들었다."},
    {"en":"Leaves formed a pile in the yard.","ko":"낙엽이 마당에 더미를 이루었다."}
  ]'::jsonb),
  ('cash register', 1, 13, '명사구', '[
    {"en":"The clerk opened the cash register.","ko":"점원이 금전 등록기를 열었다."},
    {"en":"Money is kept in the cash register.","ko":"돈은 금전 등록기에 보관된다."},
    {"en":"The cash register beeped for each item.","ko":"금전 등록기는 물건마다 소리를 냈다."}
  ]'::jsonb),
  ('on sale', 1, 13, '형용사구', '[
    {"en":"These shoes are on sale this week.","ko":"이 신발은 이번 주에 할인 중이다."},
    {"en":"I bought a jacket that was on sale.","ko":"나는 할인 중이던 재킷을 샀다."},
    {"en":"The new book is on sale at the bookstore.","ko":"새 책이 서점에서 판매되고 있다."}
  ]'::jsonb),
  ('for free', 1, 13, '부사구', '[
    {"en":"The store gave me a bag for free.","ko":"그 가게는 나에게 가방을 공짜로 주었다."},
    {"en":"We can enter the museum for free today.","ko":"오늘은 무료로 박물관에 입장할 수 있다."},
    {"en":"She fixed my bike for free.","ko":"그녀는 내 자전거를 무료로 고쳐 주었다."}
  ]'::jsonb),
  ('line up', 1, 13, '동사구', '[
    {"en":"The students lined up before entering the classroom.","ko":"학생들은 교실에 들어가기 전에 줄을 섰다."},
    {"en":"We had to line up for tickets.","ko":"우리는 표를 사기 위해 줄을 서야 했다."},
    {"en":"Please line up quietly at the door.","ko":"문 앞에서 조용히 줄을 서 주세요."}
  ]'::jsonb),

  ('clean', 1, 14, '형용사/동사', '[
    {"en":"My room is always clean.","ko":"내 방은 항상 깨끗하다."},
    {"en":"I clean my desk every morning.","ko":"나는 매일 아침 책상을 청소한다."},
    {"en":"She keeps her clothes clean.","ko":"그녀는 옷을 깨끗하게 유지한다."}
  ]'::jsonb),
  ('high', 1, 14, '형용사', '[
    {"en":"The mountain is very high.","ko":"그 산은 매우 높다."},
    {"en":"She jumped over the high fence.","ko":"그녀는 높은 울타리를 뛰어넘었다."},
    {"en":"The building has a high roof.","ko":"그 건물은 지붕이 높다."}
  ]'::jsonb),
  ('low', 1, 14, '형용사', '[
    {"en":"The table is quite low.","ko":"그 탁자는 꽤 낮다."},
    {"en":"Birds flew low over the lake.","ko":"새들이 호수 위로 낮게 날았다."},
    {"en":"The price of the shoes was low.","ko":"그 신발의 가격은 낮았다."}
  ]'::jsonb),
  ('open', 1, 14, '형용사/동사', '[
    {"en":"The window was open all night.","ko":"창문이 밤새 열려 있었다."},
    {"en":"Please open the door for me.","ko":"문을 열어 주세요."},
    {"en":"The store opens at nine.","ko":"그 가게는 아홉 시에 문을 연다."}
  ]'::jsonb),
  ('heavy', 1, 14, '형용사', '[
    {"en":"The box was too heavy to lift.","ko":"그 상자는 너무 무거워서 들 수 없었다."},
    {"en":"She carried a heavy backpack to school.","ko":"그녀는 무거운 배낭을 메고 학교에 갔다."},
    {"en":"We had heavy rain all afternoon.","ko":"우리는 오후 내내 폭우를 만났다."}
  ]'::jsonb),
  ('full', 1, 14, '형용사', '[
    {"en":"The bottle is full of water.","ko":"그 병은 물로 가득 차 있다."},
    {"en":"I feel full after lunch.","ko":"나는 점심을 먹고 나면 배가 부르다."},
    {"en":"The bus was full of passengers.","ko":"버스는 승객들로 가득했다."}
  ]'::jsonb),
  ('flat', 1, 14, '형용사', '[
    {"en":"The land near the river is flat.","ko":"강 근처의 땅은 평평하다."},
    {"en":"She placed the book on a flat surface.","ko":"그녀는 평평한 곳에 책을 놓았다."},
    {"en":"My bike tire went flat.","ko":"내 자전거 타이어가 펑크 났다."}
  ]'::jsonb),
  ('dark', 1, 14, '형용사', '[
    {"en":"The room was dark when I entered.","ko":"내가 들어갔을 때 방은 어두웠다."},
    {"en":"She was afraid of the dark forest.","ko":"그녀는 어두운 숲을 무서워했다."},
    {"en":"It gets dark early in winter.","ko":"겨울에는 일찍 어두워진다."}
  ]'::jsonb),
  ('deep', 1, 14, '형용사', '[
    {"en":"The lake is very deep in the middle.","ko":"그 호수는 가운데가 매우 깊다."},
    {"en":"He took a deep breath before speaking.","ko":"그는 말하기 전에 깊게 숨을 들이쉬었다."},
    {"en":"The cave was dark and deep.","ko":"그 동굴은 어둡고 깊었다."}
  ]'::jsonb),
  ('round', 1, 14, '형용사', '[
    {"en":"The table in our kitchen is round.","ko":"우리 부엌의 탁자는 둥글다."},
    {"en":"She drew a round shape on the paper.","ko":"그녀는 종이에 둥근 모양을 그렸다."},
    {"en":"The earth is round.","ko":"지구는 둥글다."}
  ]'::jsonb),
  ('light', 1, 14, '형용사/명사', '[
    {"en":"My backpack feels light today.","ko":"오늘 내 배낭은 가볍게 느껴진다."},
    {"en":"We had a light lunch before the game.","ko":"우리는 경기 전에 가벼운 점심을 먹었다."},
    {"en":"The light from the window woke me up.","ko":"창문에서 들어온 빛이 나를 깨웠다."}
  ]'::jsonb),
  ('famous', 1, 14, '형용사', '[
    {"en":"She is a famous singer in Korea.","ko":"그녀는 한국에서 유명한 가수이다."},
    {"en":"The museum has a famous painting.","ko":"그 박물관에는 유명한 그림이 있다."},
    {"en":"My hometown is famous for its beautiful beach.","ko":"내 고향은 아름다운 해변으로 유명하다."}
  ]'::jsonb),
  ('colorful', 1, 14, '형용사', '[
    {"en":"The garden was full of colorful flowers.","ko":"정원은 화려한 꽃들로 가득했다."},
    {"en":"She wore a colorful scarf.","ko":"그녀는 화려한 스카프를 둘렀다."},
    {"en":"The festival had colorful decorations.","ko":"그 축제에는 화려한 장식들이 있었다."}
  ]'::jsonb),
  ('empty', 1, 14, '형용사', '[
    {"en":"The bottle is empty now.","ko":"그 병은 이제 텅 비어 있다."},
    {"en":"We found an empty seat on the bus.","ko":"우리는 버스에서 빈 좌석을 발견했다."},
    {"en":"The classroom was empty after school.","ko":"방과 후 교실은 텅 비어 있었다."}
  ]'::jsonb),
  ('metal', 1, 14, '명사', '[
    {"en":"The chair is made of metal.","ko":"그 의자는 금속으로 만들어졌다."},
    {"en":"She collects small metal toys.","ko":"그녀는 작은 금속 장난감을 수집한다."},
    {"en":"The bridge is built with strong metal.","ko":"그 다리는 튼튼한 금속으로 지어졌다."}
  ]'::jsonb),
  ('plastic', 1, 14, '형용사', '[
    {"en":"I drink water from a plastic bottle.","ko":"나는 플라스틱 병으로 물을 마신다."},
    {"en":"The toys are made of plastic.","ko":"그 장난감들은 플라스틱으로 만들어졌다."},
    {"en":"We should use less plastic.","ko":"우리는 플라스틱을 덜 사용해야 한다."}
  ]'::jsonb),
  ('wide', 1, 14, '형용사', '[
    {"en":"The river is wide near the bridge.","ko":"그 강은 다리 근처에서 넓다."},
    {"en":"She has a wide smile.","ko":"그녀는 활짝 웃는 미소를 가지고 있다."},
    {"en":"The road became wide after construction.","ko":"공사 후에 그 길은 넓어졌다."}
  ]'::jsonb),
  ('tight', 1, 14, '형용사', '[
    {"en":"These shoes feel too tight.","ko":"이 신발은 너무 꽉 낀다."},
    {"en":"He wore a tight jacket.","ko":"그는 꽉 끼는 재킷을 입었다."},
    {"en":"The rope was tied tight around the box.","ko":"그 밧줄은 상자 주위에 단단히 묶여 있었다."}
  ]'::jsonb),
  ('loose', 1, 14, '형용사', '[
    {"en":"The shirt is loose on me.","ko":"그 셔츠는 나에게 헐렁하다."},
    {"en":"One button on my coat is loose.","ko":"내 코트의 단추 하나가 헐렁하다."},
    {"en":"She likes to wear loose clothes in summer.","ko":"그녀는 여름에 헐렁한 옷을 입는 것을 좋아한다."}
  ]'::jsonb),
  ('sharp', 1, 14, '형용사', '[
    {"en":"Be careful, the knife is sharp.","ko":"조심해, 그 칼은 날카로워."},
    {"en":"The pencil has a sharp point.","ko":"그 연필은 뾰족한 끝을 가지고 있다."},
    {"en":"She has a sharp memory.","ko":"그녀는 기억력이 예리하다."}
  ]'::jsonb),
  ('shallow', 1, 14, '형용사', '[
    {"en":"The water near the shore is shallow.","ko":"물가 근처의 물은 얕다."},
    {"en":"Children can swim safely in the shallow pool.","ko":"아이들은 얕은 수영장에서 안전하게 수영할 수 있다."},
    {"en":"The stream is shallow in summer.","ko":"그 개울은 여름에 얕다."}
  ]'::jsonb),
  ('oval', 1, 14, '명사/형용사', '[
    {"en":"The mirror in my room is oval.","ko":"내 방에 있는 거울은 타원형이다."},
    {"en":"She drew an oval on the paper.","ko":"그녀는 종이에 타원을 그렸다."},
    {"en":"We sat around an oval table.","ko":"우리는 타원형 탁자에 둘러앉았다."}
  ]'::jsonb),
  ('square', 1, 14, '명사/형용사', '[
    {"en":"The classroom has a square table.","ko":"그 교실에는 정사각형 탁자가 있다."},
    {"en":"We met at the town square.","ko":"우리는 마을 광장에서 만났다."},
    {"en":"She folded the paper into a square.","ko":"그녀는 종이를 정사각형으로 접었다."}
  ]'::jsonb),
  ('triangle', 1, 14, '명사', '[
    {"en":"The teacher drew a triangle on the board.","ko":"선생님은 칠판에 삼각형을 그렸다."},
    {"en":"A triangle has three sides.","ko":"삼각형은 세 개의 변을 가지고 있다."},
    {"en":"She made a sandwich in the shape of a triangle.","ko":"그녀는 삼각형 모양의 샌드위치를 만들었다."}
  ]'::jsonb),
  ('crack', 1, 14, '명사', '[
    {"en":"There is a crack in the wall.","ko":"벽에 금이 가 있다."},
    {"en":"The glass had a small crack.","ko":"그 유리에는 작은 금이 있었다."},
    {"en":"Water leaked through the crack in the roof.","ko":"지붕의 틈으로 물이 새었다."}
  ]'::jsonb),
  ('glitter', 1, 14, '동사', '[
    {"en":"The stars glitter in the night sky.","ko":"별들이 밤하늘에 반짝인다."},
    {"en":"Her necklace glittered under the light.","ko":"그녀의 목걸이는 불빛 아래에서 반짝였다."},
    {"en":"The snow glittered in the sunlight.","ko":"눈이 햇빛 속에서 반짝였다."}
  ]'::jsonb),
  ('firm', 1, 14, '형용사/명사', '[
    {"en":"The ground was firm after the rain stopped.","ko":"비가 그친 후 땅은 단단했다."},
    {"en":"He gave a firm handshake.","ko":"그는 힘 있게 악수를 했다."},
    {"en":"His father works at a law firm.","ko":"그의 아버지는 법률 회사에서 일하신다."}
  ]'::jsonb),
  ('wooden', 1, 14, '형용사', '[
    {"en":"We sat on a wooden bench.","ko":"우리는 나무 벤치에 앉았다."},
    {"en":"The old house has a wooden floor.","ko":"그 오래된 집은 나무 바닥을 가지고 있다."},
    {"en":"She bought a small wooden box.","ko":"그녀는 작은 나무 상자를 샀다."}
  ]'::jsonb),
  ('be covered with', 1, 14, '동사구', '[
    {"en":"The mountain was covered with snow.","ko":"그 산은 눈으로 덮여 있었다."},
    {"en":"The table was covered with books.","ko":"탁자는 책들로 덮여 있었다."},
    {"en":"Her hands were covered with paint.","ko":"그녀의 손은 물감으로 덮여 있었다."}
  ]'::jsonb),
  ('prefer A to B', 1, 14, '동사구', '[
    {"en":"I prefer tea to coffee.","ko":"나는 커피보다 차를 더 좋아한다."},
    {"en":"She prefers reading to watching TV.","ko":"그녀는 TV 시청보다 독서를 더 선호한다."},
    {"en":"He prefers walking to riding the bus.","ko":"그는 버스를 타는 것보다 걷는 것을 더 선호한다."}
  ]'::jsonb),

  ('watch', 1, 15, '동사', '[
    {"en":"We watched the sunset from the hill.","ko":"우리는 언덕에서 일몰을 지켜보았다."},
    {"en":"She watches her little brother after school.","ko":"그녀는 방과 후에 남동생을 돌본다."},
    {"en":"I like to watch birds in the park.","ko":"나는 공원에서 새를 관찰하는 것을 좋아한다."}
  ]'::jsonb),
  ('look', 1, 15, '동사', '[
    {"en":"Look at the beautiful rainbow.","ko":"저 아름다운 무지개를 봐."},
    {"en":"She looked out the window.","ko":"그녀는 창밖을 바라보았다."},
    {"en":"He looked at the map carefully.","ko":"그는 지도를 주의 깊게 살펴보았다."}
  ]'::jsonb),
  ('listen', 1, 15, '동사', '[
    {"en":"Please listen to the teacher carefully.","ko":"선생님 말씀을 주의 깊게 들어 주세요."},
    {"en":"I like to listen to music before bed.","ko":"나는 자기 전에 음악 듣는 것을 좋아한다."},
    {"en":"We listened to the birds singing.","ko":"우리는 새들이 노래하는 것을 들었다."}
  ]'::jsonb),
  ('smell', 1, 15, '명사/동사', '[
    {"en":"The bread smells delicious.","ko":"그 빵은 냄새가 맛있다."},
    {"en":"I love the smell of fresh flowers.","ko":"나는 신선한 꽃 냄새를 좋아한다."},
    {"en":"She smelled the soup before tasting it.","ko":"그녀는 수프를 맛보기 전에 냄새를 맡았다."}
  ]'::jsonb),
  ('loud', 1, 15, '형용사', '[
    {"en":"The music was too loud.","ko":"음악 소리가 너무 컸다."},
    {"en":"He has a loud voice.","ko":"그는 목소리가 크다."},
    {"en":"The classroom got loud during recess.","ko":"쉬는 시간 동안 교실이 시끄러워졌다."}
  ]'::jsonb),
  ('bad', 1, 15, '형용사', '[
    {"en":"The milk went bad in the fridge.","ko":"우유가 냉장고에서 상했다."},
    {"en":"We had bad weather during the trip.","ko":"우리는 여행 중에 나쁜 날씨를 겪었다."},
    {"en":"I feel bad about missing the meeting.","ko":"나는 회의에 빠진 것에 대해 미안하게 느낀다."}
  ]'::jsonb),
  ('feel', 1, 15, '동사', '[
    {"en":"I feel happy today.","ko":"나는 오늘 기분이 좋다."},
    {"en":"She felt tired after the long walk.","ko":"그녀는 긴 산책 후 피곤함을 느꼈다."},
    {"en":"He feels nervous before the exam.","ko":"그는 시험 전에 긴장을 느낀다."}
  ]'::jsonb),
  ('hard', 1, 15, '형용사', '[
    {"en":"The bread became hard after a day.","ko":"그 빵은 하루가 지나자 딱딱해졌다."},
    {"en":"This math problem is hard.","ko":"이 수학 문제는 어렵다."},
    {"en":"The ground was too hard to dig.","ko":"땅이 너무 단단해서 팔 수 없었다."}
  ]'::jsonb),
  ('scream', 1, 15, '동사/명사', '[
    {"en":"She screamed when she saw the spider.","ko":"그녀는 거미를 보고 비명을 질렀다."},
    {"en":"We heard a scream from the playground.","ko":"우리는 놀이터에서 비명 소리를 들었다."},
    {"en":"He screamed with joy after winning the race.","ko":"그는 경주에서 이긴 후 기뻐서 소리쳤다."}
  ]'::jsonb),
  ('noise', 1, 15, '명사', '[
    {"en":"The noise from the street woke me up.","ko":"거리에서 나는 소음이 나를 깨웠다."},
    {"en":"Please don''t make so much noise.","ko":"소음을 너무 많이 내지 말아 주세요."},
    {"en":"The classroom was full of noise before class began.","ko":"수업이 시작되기 전에 교실은 시끄러웠다."}
  ]'::jsonb),
  ('bitter', 1, 15, '형용사', '[
    {"en":"The medicine tasted very bitter.","ko":"그 약은 매우 쓴맛이 났다."},
    {"en":"I don''t like bitter coffee.","ko":"나는 쓴 커피를 좋아하지 않는다."},
    {"en":"The herb has a bitter taste.","ko":"그 허브는 쓴맛이 난다."}
  ]'::jsonb),
  ('sweet', 1, 15, '형용사', '[
    {"en":"The cake tasted very sweet.","ko":"그 케이크는 매우 달콤했다."},
    {"en":"She likes sweet fruit like grapes.","ko":"그녀는 포도 같은 달콤한 과일을 좋아한다."},
    {"en":"The smell of sweet honey filled the kitchen.","ko":"달콤한 꿀 냄새가 부엌을 가득 채웠다."}
  ]'::jsonb),
  ('sour', 1, 15, '형용사', '[
    {"en":"The lemon tasted very sour.","ko":"그 레몬은 맛이 매우 셨다."},
    {"en":"She made a sour face after eating it.","ko":"그녀는 그것을 먹고 나서 시큼한 표정을 지었다."},
    {"en":"I like sour candy.","ko":"나는 신맛 나는 사탕을 좋아한다."}
  ]'::jsonb),
  ('juicy', 1, 15, '형용사', '[
    {"en":"The watermelon was sweet and juicy.","ko":"그 수박은 달고 즙이 많았다."},
    {"en":"We picked juicy peaches from the tree.","ko":"우리는 나무에서 즙이 많은 복숭아를 땄다."},
    {"en":"This orange is very juicy.","ko":"이 오렌지는 즙이 매우 많다."}
  ]'::jsonb),
  ('touch', 1, 15, '명사/동사', '[
    {"en":"Please don''t touch the wet paint.","ko":"젖은 페인트를 만지지 마세요."},
    {"en":"She touched the soft blanket gently.","ko":"그녀는 부드러운 담요를 부드럽게 만졌다."},
    {"en":"The fabric has a smooth touch.","ko":"그 천은 부드러운 촉감을 가지고 있다."}
  ]'::jsonb),
  ('rough', 1, 15, '형용사', '[
    {"en":"The tree bark felt rough.","ko":"나무껍질은 거칠게 느껴졌다."},
    {"en":"His hands were rough from working outside.","ko":"그의 손은 밖에서 일해서 거칠었다."},
    {"en":"The road was rough and full of rocks.","ko":"그 길은 거칠고 돌이 많았다."}
  ]'::jsonb),
  ('soft', 1, 15, '형용사', '[
    {"en":"The blanket felt soft and warm.","ko":"그 담요는 부드럽고 따뜻하게 느껴졌다."},
    {"en":"She spoke in a soft voice.","ko":"그녀는 부드러운 목소리로 말했다."},
    {"en":"The pillow is very soft.","ko":"그 베개는 매우 부드럽다."}
  ]'::jsonb),
  ('sense', 1, 15, '명사/동사', '[
    {"en":"Dogs have a strong sense of smell.","ko":"개는 후각이 강하다."},
    {"en":"I could sense that something was wrong.","ko":"나는 무언가 잘못되었다는 것을 느낄 수 있었다."},
    {"en":"She has a good sense of humor.","ko":"그녀는 유머 감각이 좋다."}
  ]'::jsonb),
  ('objective', 1, 15, '형용사/명사', '[
    {"en":"Try to give an objective opinion.","ko":"객관적인 의견을 주려고 노력해라."},
    {"en":"Our objective is to finish the project on time.","ko":"우리의 목표는 제시간에 프로젝트를 끝내는 것이다."},
    {"en":"The report was written in an objective way.","ko":"그 보고서는 객관적인 방식으로 쓰였다."}
  ]'::jsonb),
  ('sight', 1, 15, '명사', '[
    {"en":"His sight got worse as he grew older.","ko":"그는 나이가 들면서 시력이 나빠졌다."},
    {"en":"The mountain view was a beautiful sight.","ko":"그 산의 경치는 아름다운 광경이었다."},
    {"en":"I lost sight of my friend in the crowd.","ko":"나는 군중 속에서 친구를 시야에서 놓쳤다."}
  ]'::jsonb),
  ('stare', 1, 15, '동사', '[
    {"en":"He stared at the painting for a long time.","ko":"그는 그 그림을 오랫동안 응시했다."},
    {"en":"She stared out the window, thinking about her trip.","ko":"그녀는 여행을 생각하며 창밖을 응시했다."},
    {"en":"Don''t stare at people; it''s not polite.","ko":"사람을 빤히 쳐다보지 마라, 그것은 예의가 아니다."}
  ]'::jsonb),
  ('whisper', 1, 15, '명사/동사', '[
    {"en":"She whispered the answer to her friend.","ko":"그녀는 친구에게 답을 속삭였다."},
    {"en":"I heard a whisper behind me.","ko":"나는 뒤에서 속삭이는 소리를 들었다."},
    {"en":"He whispered so the baby wouldn''t wake up.","ko":"그는 아기가 깨지 않도록 속삭였다."}
  ]'::jsonb),
  ('audio', 1, 15, '명사/형용사', '[
    {"en":"The audio quality of the video was excellent.","ko":"그 영상의 음질은 훌륭했다."},
    {"en":"We listened to an audio book on the trip.","ko":"우리는 여행 중에 오디오북을 들었다."},
    {"en":"The teacher played an audio clip in class.","ko":"선생님은 수업 시간에 오디오 클립을 재생했다."}
  ]'::jsonb),
  ('flavor', 1, 15, '명사', '[
    {"en":"This ice cream has a strawberry flavor.","ko":"이 아이스크림은 딸기 맛이다."},
    {"en":"The soup has a rich flavor.","ko":"그 수프는 풍미가 진하다."},
    {"en":"Which flavor do you like best?","ko":"어떤 맛을 가장 좋아하니?"}
  ]'::jsonb),
  ('smooth', 1, 15, '형용사/동사', '[
    {"en":"The stone felt smooth in my hand.","ko":"그 돌은 내 손에서 부드럽게 느껴졌다."},
    {"en":"She has smooth skin.","ko":"그녀는 피부가 매끄럽다."},
    {"en":"He smoothed the wrinkles out of the paper.","ko":"그는 종이의 주름을 폈다."}
  ]'::jsonb),
  ('notice', 1, 15, '명사/동사', '[
    {"en":"I noticed a new student in our class.","ko":"나는 우리 반에 새 학생이 있는 것을 알아차렸다."},
    {"en":"She didn''t notice the sign on the door.","ko":"그녀는 문에 있는 표지판을 알아차리지 못했다."},
    {"en":"He posted a notice on the bulletin board.","ko":"그는 게시판에 공지를 붙였다."}
  ]'::jsonb),
  ('observe', 1, 15, '동사', '[
    {"en":"We observed the stars through a telescope.","ko":"우리는 망원경으로 별을 관찰했다."},
    {"en":"The scientist observed the plant growing every day.","ko":"그 과학자는 매일 식물이 자라는 것을 관찰했다."},
    {"en":"She observed that he looked tired.","ko":"그녀는 그가 피곤해 보인다는 것을 알아차렸다."}
  ]'::jsonb),
  ('discover', 1, 15, '동사', '[
    {"en":"Scientists discovered a new kind of plant.","ko":"과학자들은 새로운 종류의 식물을 발견했다."},
    {"en":"I discovered a great bookstore near my house.","ko":"나는 우리 집 근처에서 멋진 서점을 발견했다."},
    {"en":"She discovered the truth after asking questions.","ko":"그녀는 질문을 한 후 진실을 알아냈다."}
  ]'::jsonb),
  ('make sense', 1, 15, '동사구', '[
    {"en":"Her explanation didn''t make sense to me.","ko":"그녀의 설명은 나에게 이해가 되지 않았다."},
    {"en":"This sentence doesn''t make sense.","ko":"이 문장은 말이 되지 않는다."},
    {"en":"Now everything makes sense.","ko":"이제 모든 것이 이해가 된다."}
  ]'::jsonb),
  ('focus on', 1, 15, '동사구', '[
    {"en":"Please focus on your homework.","ko":"숙제에 집중해 주세요."},
    {"en":"She focused on studying for the exam.","ko":"그녀는 시험 공부에 집중했다."},
    {"en":"We need to focus on the main topic.","ko":"우리는 주요 주제에 집중할 필요가 있다."}
  ]'::jsonb),

  ('cough', 1, 16, '명사/동사', '[
    {"en":"He has a bad cough today.","ko":"그는 오늘 심한 기침을 한다."},
    {"en":"She coughed all night because of her cold.","ko":"그녀는 감기 때문에 밤새 기침을 했다."},
    {"en":"I heard him cough in the classroom.","ko":"나는 그가 교실에서 기침하는 것을 들었다."}
  ]'::jsonb),
  ('fever', 1, 16, '명사', '[
    {"en":"She had a high fever last night.","ko":"그녀는 어젯밤 높은 열이 났다."},
    {"en":"He stayed home because of a fever.","ko":"그는 열 때문에 집에 있었다."},
    {"en":"My fever went down after taking medicine.","ko":"약을 먹은 후 내 열이 내려갔다."}
  ]'::jsonb),
  ('sore', 1, 16, '형용사', '[
    {"en":"My throat feels sore this morning.","ko":"오늘 아침 목이 아프다."},
    {"en":"His legs were sore after the long run.","ko":"그는 오래 달린 후 다리가 쑤셨다."},
    {"en":"I have a sore back from sitting too long.","ko":"나는 너무 오래 앉아 있어서 등이 아프다."}
  ]'::jsonb),
  ('cut', 1, 16, '명사/동사', '[
    {"en":"She got a small cut on her finger.","ko":"그녀는 손가락에 작은 상처를 입었다."},
    {"en":"Be careful not to cut yourself with the knife.","ko":"칼에 베이지 않도록 조심해라."},
    {"en":"He cut the paper with scissors.","ko":"그는 가위로 종이를 잘랐다."}
  ]'::jsonb),
  ('pain', 1, 16, '명사', '[
    {"en":"She felt a sharp pain in her leg.","ko":"그녀는 다리에 날카로운 통증을 느꼈다."},
    {"en":"The medicine helped relieve his pain.","ko":"그 약은 그의 고통을 덜어 주는 데 도움이 되었다."},
    {"en":"I have some pain in my shoulder.","ko":"나는 어깨에 약간의 통증이 있다."}
  ]'::jsonb),
  ('medicine', 1, 16, '명사', '[
    {"en":"Take this medicine after meals.","ko":"식사 후에 이 약을 드세요."},
    {"en":"She gave her son medicine for his cold.","ko":"그녀는 아들에게 감기약을 주었다."},
    {"en":"The doctor prescribed medicine for the fever.","ko":"의사는 열을 위한 약을 처방했다."}
  ]'::jsonb),
  ('virus', 1, 16, '명사', '[
    {"en":"A virus caused his high fever.","ko":"바이러스가 그의 높은 열을 일으켰다."},
    {"en":"Washing hands helps prevent the virus from spreading.","ko":"손을 씻는 것은 바이러스가 퍼지는 것을 막는 데 도움이 된다."},
    {"en":"Many students caught the virus last winter.","ko":"지난 겨울에 많은 학생들이 그 바이러스에 걸렸다."}
  ]'::jsonb),
  ('ache', 1, 16, '명사/동사', '[
    {"en":"I have a stomach ache today.","ko":"나는 오늘 배가 아프다."},
    {"en":"My legs ache after the long walk.","ko":"오래 걸은 후 다리가 아프다."},
    {"en":"She felt an ache in her head.","ko":"그녀는 머리에 통증을 느꼈다."}
  ]'::jsonb),
  ('dizzy', 1, 16, '형용사', '[
    {"en":"I felt dizzy after standing up quickly.","ko":"나는 빨리 일어난 후 어지러움을 느꼈다."},
    {"en":"She felt dizzy because she skipped breakfast.","ko":"그녀는 아침을 걸러서 어지러웠다."},
    {"en":"He sat down when he felt dizzy.","ko":"그는 어지러움을 느꼈을 때 앉았다."}
  ]'::jsonb),
  ('disease', 1, 16, '명사', '[
    {"en":"Doctors are working to cure the disease.","ko":"의사들은 그 질병을 치료하기 위해 노력하고 있다."},
    {"en":"Eating healthy food can prevent disease.","ko":"건강한 음식을 먹는 것은 질병을 예방할 수 있다."},
    {"en":"The disease spread quickly through the school.","ko":"그 질병은 학교 전체에 빠르게 퍼졌다."}
  ]'::jsonb),
  ('cancer', 1, 16, '명사', '[
    {"en":"Scientists are researching new ways to treat cancer.","ko":"과학자들은 암을 치료하는 새로운 방법을 연구하고 있다."},
    {"en":"Regular checkups can help find cancer early.","ko":"정기 검진은 암을 조기에 발견하는 데 도움이 될 수 있다."},
    {"en":"Her grandfather recovered from cancer.","ko":"그녀의 할아버지는 암에서 회복하셨다."}
  ]'::jsonb),
  ('blind', 1, 16, '형용사', '[
    {"en":"The blind man walked with a guide dog.","ko":"그 시각 장애인은 안내견과 함께 걸었다."},
    {"en":"She volunteers to help blind students at school.","ko":"그녀는 학교에서 시각 장애 학생들을 돕기 위해 봉사한다."},
    {"en":"The old dog slowly went blind.","ko":"그 늙은 개는 서서히 눈이 멀었다."}
  ]'::jsonb),
  ('deaf', 1, 16, '형용사', '[
    {"en":"He has been deaf since childhood.","ko":"그는 어릴 때부터 청각 장애가 있었다."},
    {"en":"The teacher used sign language for the deaf student.","ko":"선생님은 청각 장애 학생을 위해 수화를 사용했다."},
    {"en":"My grandmother became deaf in one ear.","ko":"우리 할머니는 한쪽 귀가 들리지 않게 되셨다."}
  ]'::jsonb),
  ('patient', 1, 16, '명사/형용사', '[
    {"en":"The doctor examined the patient carefully.","ko":"의사는 환자를 주의 깊게 진찰했다."},
    {"en":"You need to be patient while waiting.","ko":"기다리는 동안 인내심을 가져야 한다."},
    {"en":"The nurse took care of the patient all day.","ko":"간호사는 하루 종일 환자를 돌보았다."}
  ]'::jsonb),
  ('cure', 1, 16, '명사/동사', '[
    {"en":"Scientists are searching for a cure for the disease.","ko":"과학자들은 그 병의 치료법을 찾고 있다."},
    {"en":"Rest and medicine helped cure her cold.","ko":"휴식과 약이 그녀의 감기를 낫게 하는 데 도움이 되었다."},
    {"en":"There is no cure for the common cold.","ko":"감기에는 치료법이 없다."}
  ]'::jsonb),
  ('relax', 1, 16, '동사', '[
    {"en":"I like to relax by reading books.","ko":"나는 책을 읽으며 쉬는 것을 좋아한다."},
    {"en":"Please relax and take a deep breath.","ko":"긴장을 풀고 심호흡을 하세요."},
    {"en":"We relaxed at home during the weekend.","ko":"우리는 주말 동안 집에서 편히 쉬었다."}
  ]'::jsonb),
  ('burn', 1, 16, '명사/동사', '[
    {"en":"She got a small burn from the hot pan.","ko":"그녀는 뜨거운 팬에 작은 화상을 입었다."},
    {"en":"Be careful not to burn yourself while cooking.","ko":"요리하면서 화상을 입지 않도록 조심해라."},
    {"en":"His skin burned after a day at the beach.","ko":"그의 피부는 해변에서 하루를 보낸 후 탔다."}
  ]'::jsonb),
  ('symptom', 1, 16, '명사', '[
    {"en":"A high fever is a common symptom of the flu.","ko":"높은 열은 독감의 흔한 증상이다."},
    {"en":"The doctor asked about her symptoms.","ko":"의사는 그녀의 증상에 대해 물었다."},
    {"en":"His symptoms got better after taking medicine.","ko":"약을 먹은 후 그의 증상이 나아졌다."}
  ]'::jsonb),
  ('wound', 1, 16, '명사/동사', '[
    {"en":"The nurse cleaned the wound carefully.","ko":"간호사는 상처를 조심스럽게 소독했다."},
    {"en":"His wound healed after a week.","ko":"그의 상처는 일주일 후에 나았다."},
    {"en":"She wrapped a bandage around the wound.","ko":"그녀는 상처에 붕대를 감았다."}
  ]'::jsonb),
  ('vomit', 1, 16, '동사', '[
    {"en":"He felt sick and vomited after lunch.","ko":"그는 속이 안 좋아 점심 후에 토했다."},
    {"en":"The child vomited because of the fever.","ko":"그 아이는 열 때문에 토했다."},
    {"en":"She felt like she might vomit on the bus.","ko":"그녀는 버스에서 토할 것 같았다."}
  ]'::jsonb),
  ('sneeze', 1, 16, '동사', '[
    {"en":"He sneezed several times because of the dust.","ko":"그는 먼지 때문에 여러 번 재채기를 했다."},
    {"en":"She sneezed loudly during class.","ko":"그녀는 수업 시간에 크게 재채기를 했다."},
    {"en":"I sneeze a lot in spring because of pollen.","ko":"나는 꽃가루 때문에 봄에 재채기를 많이 한다."}
  ]'::jsonb),
  ('bruise', 1, 16, '명사', '[
    {"en":"He got a bruise on his knee after falling.","ko":"그는 넘어져서 무릎에 멍이 들었다."},
    {"en":"The bruise turned purple after a day.","ko":"그 멍은 하루가 지나자 보라색으로 변했다."},
    {"en":"She had a small bruise on her arm.","ko":"그녀는 팔에 작은 멍이 들었다."}
  ]'::jsonb),
  ('examine', 1, 16, '동사', '[
    {"en":"The doctor examined the patient''s throat.","ko":"의사는 환자의 목을 진찰했다."},
    {"en":"He examined the wound closely.","ko":"그는 상처를 자세히 살펴보았다."},
    {"en":"The dentist examined my teeth.","ko":"치과의사는 내 치아를 진찰했다."}
  ]'::jsonb),
  ('recover', 1, 16, '동사', '[
    {"en":"She recovered quickly from her cold.","ko":"그녀는 감기에서 빠르게 회복했다."},
    {"en":"It took him two weeks to recover from the surgery.","ko":"그는 수술에서 회복하는 데 2주가 걸렸다."},
    {"en":"He is recovering well after the accident.","ko":"그는 사고 후 잘 회복하고 있다."}
  ]'::jsonb),
  ('prevent', 1, 16, '동사', '[
    {"en":"Washing your hands can prevent disease.","ko":"손을 씻는 것은 질병을 예방할 수 있다."},
    {"en":"Regular exercise helps prevent illness.","ko":"규칙적인 운동은 질병을 예방하는 데 도움이 된다."},
    {"en":"The fence prevents children from entering the pool area.","ko":"그 울타리는 아이들이 수영장 구역에 들어가는 것을 막는다."}
  ]'::jsonb),
  ('medical', 1, 16, '형용사', '[
    {"en":"She wants to study medical science.","ko":"그녀는 의학을 공부하고 싶어 한다."},
    {"en":"He works at a medical clinic.","ko":"그는 의료 클리닉에서 일한다."},
    {"en":"The hospital has the latest medical equipment.","ko":"그 병원은 최신 의료 장비를 갖추고 있다."}
  ]'::jsonb),
  ('operate', 1, 16, '동사', '[
    {"en":"The doctor operated on the patient for three hours.","ko":"의사는 세 시간 동안 환자를 수술했다."},
    {"en":"They decided to operate as soon as possible.","ko":"그들은 가능한 한 빨리 수술하기로 결정했다."},
    {"en":"The surgeon operates at the city hospital.","ko":"그 외과의사는 시립 병원에서 수술한다."}
  ]'::jsonb),
  ('emergency', 1, 16, '명사', '[
    {"en":"Call this number in case of an emergency.","ko":"비상시에는 이 번호로 전화하세요."},
    {"en":"The hospital has an emergency room.","ko":"그 병원에는 응급실이 있다."},
    {"en":"We practiced what to do in an emergency.","ko":"우리는 비상시에 해야 할 일을 연습했다."}
  ]'::jsonb),
  ('catch a cold', 1, 16, '동사구', '[
    {"en":"I caught a cold last week.","ko":"나는 지난주에 감기에 걸렸다."},
    {"en":"Wear a coat so you don''t catch a cold.","ko":"감기에 걸리지 않도록 코트를 입어라."},
    {"en":"She caught a cold after swimming in cold water.","ko":"그녀는 차가운 물에서 수영한 후 감기에 걸렸다."}
  ]'::jsonb),
  ('see a doctor', 1, 16, '동사구', '[
    {"en":"You should see a doctor about your cough.","ko":"너는 기침에 대해 병원에 가 봐야 한다."},
    {"en":"He went to see a doctor after the accident.","ko":"그는 사고 후 의사의 진찰을 받으러 갔다."},
    {"en":"She saw a doctor for her sore throat.","ko":"그녀는 목이 아파서 병원에 갔다."}
  ]'::jsonb),

  ('trip', 1, 17, '명사', '[
    {"en":"We had a wonderful trip to the mountains.","ko":"우리는 산으로 멋진 여행을 갔다 왔다."},
    {"en":"Our school trip is next Friday.","ko":"우리 학교 여행은 다음 주 금요일이다."},
    {"en":"She planned a trip to visit her grandparents.","ko":"그녀는 조부모님을 방문하는 여행을 계획했다."}
  ]'::jsonb),
  ('journey', 1, 17, '명사', '[
    {"en":"The journey to the countryside took five hours.","ko":"시골까지의 여정은 다섯 시간이 걸렸다."},
    {"en":"They shared stories about their journey.","ko":"그들은 여정에 대한 이야기를 나누었다."},
    {"en":"It was a long journey, but we enjoyed every moment.","ko":"긴 여정이었지만 우리는 매 순간을 즐겼다."}
  ]'::jsonb),
  ('sightseeing', 1, 17, '명사', '[
    {"en":"We went sightseeing around the old city.","ko":"우리는 오래된 도시를 관광했다."},
    {"en":"Sightseeing is my favorite part of traveling.","ko":"관광은 여행에서 내가 가장 좋아하는 부분이다."},
    {"en":"We spent the whole day sightseeing.","ko":"우리는 하루 종일 관광을 하며 보냈다."}
  ]'::jsonb),
  ('visa', 1, 17, '명사', '[
    {"en":"We need a visa to visit that country.","ko":"우리는 그 나라를 방문하려면 비자가 필요하다."},
    {"en":"She applied for a student visa.","ko":"그녀는 학생 비자를 신청했다."},
    {"en":"His visa was approved last week.","ko":"그의 비자는 지난주에 승인되었다."}
  ]'::jsonb),
  ('flight', 1, 17, '명사', '[
    {"en":"Our flight leaves at seven in the morning.","ko":"우리 비행기는 아침 일곱 시에 출발한다."},
    {"en":"The flight to Jeju takes about an hour.","ko":"제주로 가는 비행은 약 한 시간 걸린다."},
    {"en":"We enjoyed the view during the flight.","ko":"우리는 비행 중에 경치를 즐겼다."}
  ]'::jsonb),
  ('landscape', 1, 17, '명사', '[
    {"en":"The landscape from the mountain was breathtaking.","ko":"산에서 본 풍경은 숨이 멎을 듯 아름다웠다."},
    {"en":"She painted the landscape of her hometown.","ko":"그녀는 고향의 풍경을 그렸다."},
    {"en":"We took pictures of the beautiful landscape.","ko":"우리는 아름다운 풍경 사진을 찍었다."}
  ]'::jsonb),
  ('reserve', 1, 17, '동사', '[
    {"en":"We reserved a table at the restaurant.","ko":"우리는 그 식당에 테이블을 예약했다."},
    {"en":"She reserved a room for the trip.","ko":"그녀는 여행을 위해 방을 예약했다."},
    {"en":"Please reserve your seat in advance.","ko":"미리 좌석을 예약해 주세요."}
  ]'::jsonb),
  ('cancel', 1, 17, '동사', '[
    {"en":"We had to cancel our trip due to bad weather.","ko":"우리는 나쁜 날씨 때문에 여행을 취소해야 했다."},
    {"en":"She canceled the reservation.","ko":"그녀는 예약을 취소했다."},
    {"en":"He canceled his appointment with the dentist.","ko":"그는 치과 예약을 취소했다."}
  ]'::jsonb),
  ('scenery', 1, 17, '명사', '[
    {"en":"The scenery along the coast was amazing.","ko":"해안을 따라 펼쳐진 풍경은 놀라웠다."},
    {"en":"We stopped the car to enjoy the scenery.","ko":"우리는 풍경을 즐기기 위해 차를 세웠다."},
    {"en":"The scenery changed as the train moved north.","ko":"기차가 북쪽으로 이동하면서 풍경이 바뀌었다."}
  ]'::jsonb),
  ('apply', 1, 17, '동사', '[
    {"en":"She applied for a passport last month.","ko":"그녀는 지난달에 여권을 신청했다."},
    {"en":"He plans to apply for the scholarship.","ko":"그는 장학금을 신청할 계획이다."},
    {"en":"I applied for a part-time job at the library.","ko":"나는 도서관 아르바이트에 지원했다."}
  ]'::jsonb),
  ('passport', 1, 17, '명사', '[
    {"en":"Don''t forget to bring your passport.","ko":"여권을 가져오는 것을 잊지 마세요."},
    {"en":"Her passport expires next year.","ko":"그녀의 여권은 내년에 만료된다."},
    {"en":"He checked his passport before the trip.","ko":"그는 여행 전에 여권을 확인했다."}
  ]'::jsonb),
  ('insurance', 1, 17, '명사', '[
    {"en":"We bought travel insurance before the trip.","ko":"우리는 여행 전에 여행 보험에 가입했다."},
    {"en":"Insurance can help cover unexpected costs.","ko":"보험은 예상치 못한 비용을 충당하는 데 도움이 될 수 있다."},
    {"en":"She has health insurance through her school.","ko":"그녀는 학교를 통해 건강 보험에 가입되어 있다."}
  ]'::jsonb),
  ('reach', 1, 17, '동사', '[
    {"en":"We reached the airport just in time.","ko":"우리는 딱 맞춰 공항에 도착했다."},
    {"en":"It took two days to reach the island.","ko":"그 섬에 도달하는 데 이틀이 걸렸다."},
    {"en":"She reached the top of the mountain at noon.","ko":"그녀는 정오에 산 정상에 도달했다."}
  ]'::jsonb),
  ('attendant', 1, 17, '명사', '[
    {"en":"The flight attendant helped us find our seats.","ko":"승무원은 우리가 좌석을 찾는 것을 도와주었다."},
    {"en":"An attendant guided the tourists through the museum.","ko":"안내원이 관광객들을 박물관으로 안내했다."},
    {"en":"The attendant offered us some water.","ko":"그 종업원은 우리에게 물을 제공했다."}
  ]'::jsonb),
  ('board', 1, 17, '동사', '[
    {"en":"We boarded the plane at gate seven.","ko":"우리는 7번 게이트에서 비행기에 탑승했다."},
    {"en":"Passengers began to board the train.","ko":"승객들이 기차에 탑승하기 시작했다."},
    {"en":"Please board the bus quickly.","ko":"버스에 빨리 탑승해 주세요."}
  ]'::jsonb),
  ('depart', 1, 17, '동사', '[
    {"en":"The train will depart in ten minutes.","ko":"기차는 10분 후에 출발할 것이다."},
    {"en":"Our flight departs from gate twelve.","ko":"우리 비행기는 12번 게이트에서 출발한다."},
    {"en":"We departed early to avoid traffic.","ko":"우리는 교통 체증을 피하기 위해 일찍 출발했다."}
  ]'::jsonb),
  ('arrive', 1, 17, '동사', '[
    {"en":"We arrived at the hotel late at night.","ko":"우리는 밤늦게 호텔에 도착했다."},
    {"en":"The bus arrives every thirty minutes.","ko":"버스는 30분마다 도착한다."},
    {"en":"She arrived early for the meeting.","ko":"그녀는 회의에 일찍 도착했다."}
  ]'::jsonb),
  ('land', 1, 17, '명사/동사', '[
    {"en":"The plane landed safely at the airport.","ko":"비행기는 공항에 안전하게 착륙했다."},
    {"en":"Farmers use the land to grow crops.","ko":"농부들은 땅을 이용해 농작물을 기른다."},
    {"en":"We watched the plane land from the window.","ko":"우리는 창문에서 비행기가 착륙하는 것을 지켜보았다."}
  ]'::jsonb),
  ('abroad', 1, 17, '부사', '[
    {"en":"She wants to study abroad someday.","ko":"그녀는 언젠가 해외에서 공부하고 싶어 한다."},
    {"en":"My brother traveled abroad last summer.","ko":"내 형은 지난여름에 해외로 여행을 갔다."},
    {"en":"Many students dream of living abroad.","ko":"많은 학생들이 해외에서 사는 것을 꿈꾼다."}
  ]'::jsonb),
  ('itinerary', 1, 17, '명사', '[
    {"en":"She planned a detailed itinerary for the trip.","ko":"그녀는 여행을 위한 상세한 일정표를 계획했다."},
    {"en":"Our itinerary includes three cities.","ko":"우리의 여행 일정에는 세 도시가 포함된다."},
    {"en":"He checked the itinerary before packing.","ko":"그는 짐을 싸기 전에 일정표를 확인했다."}
  ]'::jsonb),
  ('baggage', 1, 17, '명사', '[
    {"en":"Please put your baggage here.","ko":"짐을 여기에 놓아 주세요."},
    {"en":"We waited for our baggage at the airport.","ko":"우리는 공항에서 짐을 기다렸다."},
    {"en":"Her baggage was heavier than expected.","ko":"그녀의 짐은 예상보다 무거웠다."}
  ]'::jsonb),
  ('claim', 1, 17, '명사/동사', '[
    {"en":"We went to the baggage claim area.","ko":"우리는 수하물 찾는 곳으로 갔다."},
    {"en":"She claimed her bag at the airport.","ko":"그녀는 공항에서 자신의 가방을 찾았다."},
    {"en":"He claimed that the train was late.","ko":"그는 기차가 늦었다고 주장했다."}
  ]'::jsonb),
  ('check', 1, 17, '명사/동사', '[
    {"en":"Please check your ticket before boarding.","ko":"탑승 전에 표를 확인해 주세요."},
    {"en":"We did a final check of our baggage.","ko":"우리는 짐을 최종 점검했다."},
    {"en":"She checked the schedule twice.","ko":"그녀는 일정을 두 번 확인했다."}
  ]'::jsonb),
  ('destination', 1, 17, '명사', '[
    {"en":"Our final destination was a small village.","ko":"우리의 최종 목적지는 작은 마을이었다."},
    {"en":"The train reached its destination on time.","ko":"기차는 제시간에 목적지에 도착했다."},
    {"en":"Paris is a popular travel destination.","ko":"파리는 인기 있는 여행지이다."}
  ]'::jsonb),
  ('security', 1, 17, '명사', '[
    {"en":"We passed through airport security quickly.","ko":"우리는 공항 보안 검색을 빠르게 통과했다."},
    {"en":"Security checked our bags at the gate.","ko":"보안 요원이 게이트에서 우리 가방을 확인했다."},
    {"en":"The airport has strong security measures.","ko":"그 공항은 강력한 보안 조치를 갖추고 있다."}
  ]'::jsonb),
  ('delay', 1, 17, '명사/동사', '[
    {"en":"Our flight had a two-hour delay.","ko":"우리 비행기는 두 시간 지연되었다."},
    {"en":"The heavy rain caused a delay.","ko":"폭우가 지연을 일으켰다."},
    {"en":"They delayed the trip because of the storm.","ko":"그들은 폭풍 때문에 여행을 연기했다."}
  ]'::jsonb),
  ('jet lag', 1, 17, '명사구', '[
    {"en":"I felt tired because of jet lag.","ko":"나는 시차증 때문에 피곤함을 느꼈다."},
    {"en":"Jet lag can last for a few days.","ko":"시차증은 며칠 동안 지속될 수 있다."},
    {"en":"She rested to recover from jet lag.","ko":"그녀는 시차증에서 회복하기 위해 쉬었다."}
  ]'::jsonb),
  ('souvenir', 1, 17, '명사', '[
    {"en":"I bought a souvenir for my sister.","ko":"나는 여동생을 위해 기념품을 샀다."},
    {"en":"We collected souvenirs from every city we visited.","ko":"우리는 방문한 모든 도시에서 기념품을 모았다."},
    {"en":"The shop sells local souvenirs.","ko":"그 가게는 지역 기념품을 판다."}
  ]'::jsonb),
  ('all over the world', 1, 17, '부사구', '[
    {"en":"People all over the world enjoy this sport.","ko":"전 세계 사람들이 이 스포츠를 즐긴다."},
    {"en":"Tourists come from all over the world to see this place.","ko":"관광객들이 이곳을 보기 위해 전 세계에서 온다."},
    {"en":"This dish is famous all over the world.","ko":"이 요리는 전 세계적으로 유명하다."}
  ]'::jsonb),
  ('have a good time', 1, 17, '동사구', '[
    {"en":"We had a good time at the beach.","ko":"우리는 해변에서 즐거운 시간을 보냈다."},
    {"en":"I hope you have a good time on your trip.","ko":"여행에서 좋은 시간을 보내길 바란다."},
    {"en":"They had a good time at the festival.","ko":"그들은 축제에서 즐거운 시간을 보냈다."}
  ]'::jsonb),

  ('movie', 1, 18, '명사', '[
    {"en":"We watched a movie together last night.","ko":"우리는 어젯밤에 함께 영화를 보았다."},
    {"en":"My favorite movie is about space travel.","ko":"내가 가장 좋아하는 영화는 우주 여행에 관한 것이다."},
    {"en":"The movie made everyone laugh.","ko":"그 영화는 모두를 웃게 만들었다."}
  ]'::jsonb),
  ('puzzle', 1, 18, '명사', '[
    {"en":"She enjoys solving jigsaw puzzles.","ko":"그녀는 직소 퍼즐 푸는 것을 즐긴다."},
    {"en":"We finished the puzzle together.","ko":"우리는 함께 퍼즐을 완성했다."},
    {"en":"The puzzle had a thousand pieces.","ko":"그 퍼즐은 천 조각으로 이루어져 있었다."}
  ]'::jsonb),
  ('game', 1, 18, '명사', '[
    {"en":"We played a fun game after school.","ko":"우리는 방과 후에 재미있는 게임을 했다."},
    {"en":"The soccer game was exciting.","ko":"그 축구 시합은 흥미진진했다."},
    {"en":"She invented a new card game.","ko":"그녀는 새로운 카드 게임을 만들었다."}
  ]'::jsonb),
  ('interest', 1, 18, '명사', '[
    {"en":"She has a strong interest in music.","ko":"그녀는 음악에 강한 관심이 있다."},
    {"en":"His interest in science grew every year.","ko":"그의 과학에 대한 관심은 매년 커졌다."},
    {"en":"I lost interest in the boring movie.","ko":"나는 지루한 영화에 흥미를 잃었다."}
  ]'::jsonb),
  ('picture', 1, 18, '명사', '[
    {"en":"She took a picture of the sunset.","ko":"그녀는 일몰 사진을 찍었다."},
    {"en":"He drew a picture of his family.","ko":"그는 자신의 가족 그림을 그렸다."},
    {"en":"We hung the picture on the wall.","ko":"우리는 그림을 벽에 걸었다."}
  ]'::jsonb),
  ('musical', 1, 18, '형용사/명사', '[
    {"en":"She has great musical talent.","ko":"그녀는 뛰어난 음악적 재능을 가지고 있다."},
    {"en":"We watched a musical at the theater.","ko":"우리는 극장에서 뮤지컬을 관람했다."},
    {"en":"His musical instrument is a violin.","ko":"그의 악기는 바이올린이다."}
  ]'::jsonb),
  ('dance', 1, 18, '명사/동사', '[
    {"en":"They danced happily at the festival.","ko":"그들은 축제에서 즐겁게 춤을 췄다."},
    {"en":"She takes dance lessons every Saturday.","ko":"그녀는 매주 토요일에 춤 수업을 받는다."},
    {"en":"The dance performance was amazing.","ko":"그 춤 공연은 놀라웠다."}
  ]'::jsonb),
  ('activity', 1, 18, '명사', '[
    {"en":"Hiking is my favorite outdoor activity.","ko":"하이킹은 내가 가장 좋아하는 야외 활동이다."},
    {"en":"The school offers many after-school activities.","ko":"그 학교는 많은 방과 후 활동을 제공한다."},
    {"en":"We joined a fun activity at the camp.","ko":"우리는 캠프에서 재미있는 활동에 참여했다."}
  ]'::jsonb),
  ('craft', 1, 18, '명사/동사', '[
    {"en":"She enjoys making crafts with paper.","ko":"그녀는 종이로 공예품을 만드는 것을 즐긴다."},
    {"en":"We crafted small gifts for our friends.","ko":"우리는 친구들을 위해 작은 선물을 만들었다."},
    {"en":"The craft fair sold handmade items.","ko":"그 공예품 박람회는 수제품을 팔았다."}
  ]'::jsonb),
  ('collect', 1, 18, '동사', '[
    {"en":"He collects stamps from different countries.","ko":"그는 여러 나라의 우표를 모은다."},
    {"en":"We collected leaves for our art project.","ko":"우리는 미술 프로젝트를 위해 나뭇잎을 모았다."},
    {"en":"She collects coins as a hobby.","ko":"그녀는 취미로 동전을 모은다."}
  ]'::jsonb),
  ('chess', 1, 18, '명사', '[
    {"en":"My father taught me how to play chess.","ko":"아버지는 나에게 체스 두는 법을 가르쳐 주셨다."},
    {"en":"We played chess during the rainy afternoon.","ko":"우리는 비 오는 오후에 체스를 두었다."},
    {"en":"She joined the school chess club.","ko":"그녀는 학교 체스 동아리에 가입했다."}
  ]'::jsonb),
  ('hike', 1, 18, '동사', '[
    {"en":"We hiked up the mountain on Saturday.","ko":"우리는 토요일에 산을 하이킹했다."},
    {"en":"They hike every weekend with their dog.","ko":"그들은 개와 함께 매 주말 하이킹을 한다."},
    {"en":"She likes to hike in the fall.","ko":"그녀는 가을에 하이킹하는 것을 좋아한다."}
  ]'::jsonb),
  ('comic', 1, 18, '형용사', '[
    {"en":"He loves reading comic books.","ko":"그는 만화책 읽는 것을 좋아한다."},
    {"en":"The show had a comic character everyone loved.","ko":"그 쇼에는 모두가 좋아하는 코믹한 캐릭터가 있었다."},
    {"en":"She drew a comic strip for the school newspaper.","ko":"그녀는 학교 신문을 위해 만화를 그렸다."}
  ]'::jsonb),
  ('camp', 1, 18, '명사/동사', '[
    {"en":"We went to summer camp last year.","ko":"우리는 작년에 여름 캠프에 갔다."},
    {"en":"They camped near the lake.","ko":"그들은 호수 근처에서 야영을 했다."},
    {"en":"The camp had many fun activities.","ko":"그 캠프에는 재미있는 활동이 많았다."}
  ]'::jsonb),
  ('pleasure', 1, 18, '명사', '[
    {"en":"Reading gives me great pleasure.","ko":"독서는 나에게 큰 기쁨을 준다."},
    {"en":"It was a pleasure to meet you.","ko":"당신을 만나서 기뻤습니다."},
    {"en":"She smiled with pleasure when she saw the gift.","ko":"그녀는 선물을 보고 기뻐서 미소지었다."}
  ]'::jsonb),
  ('stamp', 1, 18, '명사', '[
    {"en":"He collects stamps from around the world.","ko":"그는 전 세계의 우표를 수집한다."},
    {"en":"I put a stamp on the envelope.","ko":"나는 봉투에 우표를 붙였다."},
    {"en":"She stamped the document before mailing it.","ko":"그녀는 우편을 보내기 전에 서류에 도장을 찍었다."}
  ]'::jsonb),
  ('jog', 1, 18, '동사', '[
    {"en":"I jog in the park every morning.","ko":"나는 매일 아침 공원에서 조깅한다."},
    {"en":"She jogs with her mother on weekends.","ko":"그녀는 주말마다 어머니와 함께 조깅한다."},
    {"en":"We jogged along the river.","ko":"우리는 강을 따라 조깅했다."}
  ]'::jsonb),
  ('magic', 1, 18, '명사/형용사', '[
    {"en":"The magician performed amazing magic tricks.","ko":"그 마술사는 놀라운 마술을 선보였다."},
    {"en":"Children love stories about magic.","ko":"아이들은 마법에 관한 이야기를 좋아한다."},
    {"en":"She has a magic wand in the play.","ko":"그녀는 연극에서 마법 지팡이를 가지고 있다."}
  ]'::jsonb),
  ('fix', 1, 18, '동사', '[
    {"en":"My father fixed my bicycle yesterday.","ko":"아버지는 어제 내 자전거를 고치셨다."},
    {"en":"She fixed the broken chair.","ko":"그녀는 부서진 의자를 고쳤다."},
    {"en":"He fixed the shelf to the wall.","ko":"그는 선반을 벽에 고정시켰다."}
  ]'::jsonb),
  ('favorite', 1, 18, '형용사', '[
    {"en":"Pizza is my favorite food.","ko":"피자는 내가 가장 좋아하는 음식이다."},
    {"en":"What is your favorite subject at school?","ko":"학교에서 가장 좋아하는 과목이 뭐야?"},
    {"en":"Her favorite season is autumn.","ko":"그녀가 가장 좋아하는 계절은 가을이다."}
  ]'::jsonb),
  ('mania', 1, 18, '명사', '[
    {"en":"Soccer mania spread across the country.","ko":"축구 열풍이 전국에 퍼졌다."},
    {"en":"There was a mania for the new game among students.","ko":"학생들 사이에서 그 새로운 게임에 대한 열광이 있었다."},
    {"en":"The band''s fans showed real mania at the concert.","ko":"그 밴드의 팬들은 콘서트에서 진짜 열광을 보였다."}
  ]'::jsonb),
  ('volunteer', 1, 18, '명사/동사', '[
    {"en":"She works as a volunteer at the hospital.","ko":"그녀는 병원에서 자원봉사자로 일한다."},
    {"en":"He volunteered to clean the park.","ko":"그는 공원을 청소하겠다고 자원했다."},
    {"en":"Many students volunteer during summer vacation.","ko":"많은 학생들이 여름 방학 동안 봉사활동을 한다."}
  ]'::jsonb),
  ('chat', 1, 18, '동사', '[
    {"en":"We chatted about our weekend plans.","ko":"우리는 주말 계획에 대해 수다를 떨었다."},
    {"en":"She likes to chat with her friends online.","ko":"그녀는 친구들과 온라인으로 채팅하는 것을 좋아한다."},
    {"en":"They chatted happily during lunch.","ko":"그들은 점심시간 동안 즐겁게 수다를 떨었다."}
  ]'::jsonb),
  ('model', 1, 18, '명사/형용사', '[
    {"en":"He built a model airplane.","ko":"그는 모형 비행기를 만들었다."},
    {"en":"She wants to become a fashion model.","ko":"그녀는 패션 모델이 되고 싶어 한다."},
    {"en":"The teacher used a model of the earth in class.","ko":"선생님은 수업 시간에 지구 모형을 사용했다."}
  ]'::jsonb),
  ('knit', 1, 18, '동사', '[
    {"en":"My grandmother knits sweaters every winter.","ko":"우리 할머니는 매년 겨울마다 스웨터를 뜨신다."},
    {"en":"She learned how to knit last year.","ko":"그녀는 작년에 뜨개질하는 법을 배웠다."},
    {"en":"We knit scarves as gifts for our family.","ko":"우리는 가족을 위한 선물로 목도리를 떴다."}
  ]'::jsonb),
  ('leisure', 1, 18, '명사/형용사', '[
    {"en":"I spend my leisure time reading books.","ko":"나는 여가 시간을 책을 읽으며 보낸다."},
    {"en":"She enjoys painting during her leisure hours.","ko":"그녀는 여가 시간 동안 그림 그리기를 즐긴다."},
    {"en":"Leisure activities help people relax.","ko":"여가 활동은 사람들이 휴식을 취하는 데 도움이 된다."}
  ]'::jsonb),
  ('involve', 1, 18, '동사', '[
    {"en":"The project involves a lot of teamwork.","ko":"그 프로젝트는 많은 협동 작업을 필요로 한다."},
    {"en":"Playing chess involves careful thinking.","ko":"체스를 두는 것은 신중한 사고를 필요로 한다."},
    {"en":"The trip will involve a long flight.","ko":"그 여행은 긴 비행을 수반할 것이다."}
  ]'::jsonb),
  ('spend ... on ~ing', 1, 18, '동사구', '[
    {"en":"I spend an hour on reading every day.","ko":"나는 매일 독서하는 데 한 시간을 쓴다."},
    {"en":"She spends her weekends on drawing pictures.","ko":"그녀는 주말을 그림 그리는 데 쓴다."},
    {"en":"We spent the afternoon on cleaning the classroom.","ko":"우리는 오후 시간을 교실 청소하는 데 썼다."}
  ]'::jsonb),
  ('go (out) for a walk', 1, 18, '동사구', '[
    {"en":"We went for a walk after dinner.","ko":"우리는 저녁 식사 후에 산책하러 나갔다."},
    {"en":"She goes out for a walk every morning.","ko":"그녀는 매일 아침 산책하러 나간다."},
    {"en":"Let''s go for a walk in the park.","ko":"공원으로 산책하러 가자."}
  ]'::jsonb),
  ('from time to time', 1, 18, '부사구', '[
    {"en":"I visit my grandparents from time to time.","ko":"나는 때때로 조부모님을 방문한다."},
    {"en":"She calls her old friend from time to time.","ko":"그녀는 가끔 옛 친구에게 전화한다."},
    {"en":"We eat out from time to time.","ko":"우리는 가끔 외식을 한다."}
  ]'::jsonb)
) as t(word, level, study_day, pos, examples)
where v.word = t.word and v.level = t.level and v.study_day = t.study_day;
