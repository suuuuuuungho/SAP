-- SAP 1기 대시보드: Study 탭 — Lv.0(중등 BASIC) Day 34~40 품사/예문 채우기 (140단어, 마지막 배치).
-- Supabase 대시보드 → SQL Editor에서 실행하세요.

update public.vocab_words v
set part_of_speech = t.pos, example_sentences = t.examples, updated_at = now()
from (values
  -- Day 34
  ('grass', 0, 34, '명사', '[
    {"en":"The grass in the park is very green.","ko":"공원의 잔디는 매우 푸르다."},
    {"en":"Children were playing on the grass.","ko":"아이들이 잔디밭에서 놀고 있었다."},
    {"en":"Please don''t walk on the grass.","ko":"잔디 위를 걷지 마세요."}
  ]'::jsonb),
  ('flower', 0, 34, '명사', '[
    {"en":"She gave her mother a beautiful flower.","ko":"그녀는 엄마에게 예쁜 꽃을 드렸다."},
    {"en":"The flowers in the garden smell sweet.","ko":"정원의 꽃들은 향기가 좋다."},
    {"en":"He planted a flower in the pot.","ko":"그는 화분에 꽃을 심었다."}
  ]'::jsonb),
  ('tree', 0, 34, '명사', '[
    {"en":"There is a tall tree in front of my house.","ko":"우리 집 앞에는 큰 나무가 있다."},
    {"en":"We sat under the tree and talked.","ko":"우리는 나무 아래에 앉아서 이야기했다."},
    {"en":"The children climbed the tree in the yard.","ko":"아이들은 마당에 있는 나무에 올라갔다."}
  ]'::jsonb),
  ('leaf', 0, 34, '명사', '[
    {"en":"The leaves turn red and yellow in fall.","ko":"가을에는 잎이 빨갛고 노랗게 변한다."},
    {"en":"A leaf fell onto the ground.","ko":"나뭇잎 하나가 땅에 떨어졌다."},
    {"en":"She picked up a green leaf from the tree.","ko":"그녀는 나무에서 초록색 잎을 하나 주웠다."}
  ]'::jsonb),
  ('stone', 0, 34, '명사', '[
    {"en":"He threw a small stone into the river.","ko":"그는 작은 돌을 강에 던졌다."},
    {"en":"The path was covered with stones.","ko":"그 길은 돌들로 덮여 있었다."},
    {"en":"She found an interesting stone on the beach.","ko":"그녀는 해변에서 신기한 돌을 발견했다."}
  ]'::jsonb),
  ('wood', 0, 34, '명사', '[
    {"en":"The table is made of wood.","ko":"그 탁자는 나무로 만들어졌다."},
    {"en":"They walked through the woods.","ko":"그들은 숲을 지나 걸었다."},
    {"en":"He built a chair with wood.","ko":"그는 나무로 의자를 만들었다."}
  ]'::jsonb),
  ('fruit', 0, 34, '명사', '[
    {"en":"I eat fruit every morning.","ko":"나는 매일 아침 과일을 먹는다."},
    {"en":"The tree is full of fruit.","ko":"그 나무에는 열매가 가득하다."},
    {"en":"We bought some fresh fruit at the market.","ko":"우리는 시장에서 신선한 과일을 좀 샀다."}
  ]'::jsonb),
  ('branch', 0, 34, '명사', '[
    {"en":"A bird sat on the branch.","ko":"새 한 마리가 나뭇가지에 앉았다."},
    {"en":"The wind broke a branch off the tree.","ko":"바람이 나무에서 가지 하나를 부러뜨렸다."},
    {"en":"He hung a swing on the branch.","ko":"그는 나뭇가지에 그네를 매달았다."}
  ]'::jsonb),
  ('ground', 0, 34, '명사', '[
    {"en":"The apple fell to the ground.","ko":"사과가 땅에 떨어졌다."},
    {"en":"They sat on the ground and had lunch.","ko":"그들은 땅에 앉아서 점심을 먹었다."},
    {"en":"Snow covered the ground this morning.","ko":"오늘 아침에 눈이 땅을 덮었다."}
  ]'::jsonb),
  ('soil', 0, 34, '명사', '[
    {"en":"The soil here is good for growing plants.","ko":"이곳의 토양은 식물을 기르기에 좋다."},
    {"en":"She put some soil into the pot.","ko":"그녀는 화분에 흙을 좀 넣었다."},
    {"en":"Farmers check the soil before planting seeds.","ko":"농부들은 씨를 심기 전에 흙을 확인한다."}
  ]'::jsonb),
  ('field', 0, 34, '명사', '[
    {"en":"The farmer works in the field every day.","ko":"농부는 매일 밭에서 일한다."},
    {"en":"We ran across the field.","ko":"우리는 들판을 가로질러 달렸다."},
    {"en":"The soccer field was full of students.","ko":"축구 경기장은 학생들로 가득했다."}
  ]'::jsonb),
  ('farm', 0, 34, '명사', '[
    {"en":"My grandparents live on a farm.","ko":"나의 조부모님은 농장에 사신다."},
    {"en":"We visited a farm last weekend.","ko":"우리는 지난 주말에 농장을 방문했다."},
    {"en":"There are many animals on the farm.","ko":"그 농장에는 많은 동물들이 있다."}
  ]'::jsonb),
  ('water', 0, 34, '명사/동사', '[
    {"en":"Please drink more water every day.","ko":"매일 물을 더 많이 마시세요."},
    {"en":"She waters the flowers every morning.","ko":"그녀는 매일 아침 꽃에 물을 준다."},
    {"en":"We need clean water to live.","ko":"우리는 살기 위해 깨끗한 물이 필요하다."}
  ]'::jsonb),
  ('dig', 0, 34, '동사', '[
    {"en":"The dog is digging a hole in the yard.","ko":"개가 마당에 구덩이를 파고 있다."},
    {"en":"We dug in the sand at the beach.","ko":"우리는 해변에서 모래를 팠다."},
    {"en":"Farmers dig the soil before planting.","ko":"농부들은 심기 전에 땅을 판다."}
  ]'::jsonb),
  ('grow', 0, 34, '동사', '[
    {"en":"My father grows vegetables in the garden.","ko":"아버지는 정원에서 채소를 기르신다."},
    {"en":"The plant is growing very fast.","ko":"그 식물은 매우 빠르게 자라고 있다."},
    {"en":"Children grow quickly these days.","ko":"요즘 아이들은 빠르게 자란다."}
  ]'::jsonb),
  ('plant', 0, 34, '명사/동사', '[
    {"en":"She waters the plant every day.","ko":"그녀는 매일 그 식물에 물을 준다."},
    {"en":"We planted a tree in the garden.","ko":"우리는 정원에 나무를 심었다."},
    {"en":"This plant needs a lot of sunlight.","ko":"이 식물은 햇빛이 많이 필요하다."}
  ]'::jsonb),
  ('bean', 0, 34, '명사', '[
    {"en":"I don''t like beans very much.","ko":"나는 콩을 그다지 좋아하지 않는다."},
    {"en":"She put some beans in the soup.","ko":"그녀는 수프에 콩을 좀 넣었다."},
    {"en":"We grew beans in our garden this year.","ko":"우리는 올해 정원에 콩을 길렀다."}
  ]'::jsonb),
  ('vegetable', 0, 34, '명사', '[
    {"en":"Eating vegetables is good for your health.","ko":"채소를 먹는 것은 건강에 좋다."},
    {"en":"My mom grows vegetables in the backyard.","ko":"엄마는 뒷마당에서 채소를 기르신다."},
    {"en":"We should eat more vegetables every day.","ko":"우리는 매일 채소를 더 많이 먹어야 한다."}
  ]'::jsonb),
  ('right away', 0, 34, '부사구', '[
    {"en":"Please call me back right away.","ko":"저에게 즉시 다시 전화해 주세요."},
    {"en":"She started her homework right away.","ko":"그녀는 곧바로 숙제를 시작했다."},
    {"en":"We need to leave right away.","ko":"우리는 즉시 떠나야 한다."}
  ]'::jsonb),
  ('pick up', 0, 34, '동사구', '[
    {"en":"He picked up the pencil from the floor.","ko":"그는 바닥에서 연필을 집어 들었다."},
    {"en":"My mom will pick me up after school.","ko":"엄마가 방과 후에 나를 데리러 오실 것이다."},
    {"en":"Please pick up your toys before dinner.","ko":"저녁 식사 전에 장난감을 정리해 주세요."}
  ]'::jsonb),
  -- Day 35
  ('bee', 0, 35, '명사', '[
    {"en":"The bee flew from flower to flower.","ko":"벌이 꽃에서 꽃으로 날아다녔다."},
    {"en":"Bees make honey.","ko":"벌은 꿀을 만든다."},
    {"en":"I saw a bee near the garden.","ko":"나는 정원 근처에서 벌 한 마리를 보았다."}
  ]'::jsonb),
  ('fly', 0, 35, '명사/동사', '[
    {"en":"A fly landed on the table.","ko":"파리 한 마리가 탁자에 앉았다."},
    {"en":"Birds can fly high in the sky.","ko":"새들은 하늘 높이 날 수 있다."},
    {"en":"I want to learn how to fly a kite.","ko":"나는 연을 날리는 법을 배우고 싶다."}
  ]'::jsonb),
  ('wolf', 0, 35, '명사', '[
    {"en":"The wolf howled at the moon.","ko":"늑대가 달을 향해 울부짖었다."},
    {"en":"We saw a wolf in the documentary.","ko":"우리는 다큐멘터리에서 늑대를 보았다."},
    {"en":"Wolves usually live in groups.","ko":"늑대는 보통 무리를 지어 산다."}
  ]'::jsonb),
  ('monkey', 0, 35, '명사', '[
    {"en":"The monkey climbed up the tree quickly.","ko":"그 원숭이는 나무 위로 빠르게 올라갔다."},
    {"en":"We watched the monkeys at the zoo.","ko":"우리는 동물원에서 원숭이들을 구경했다."},
    {"en":"A monkey ate a banana in the cage.","ko":"원숭이 한 마리가 우리 안에서 바나나를 먹었다."}
  ]'::jsonb),
  ('elephant', 0, 35, '명사', '[
    {"en":"The elephant is the largest land animal.","ko":"코끼리는 육지에서 가장 큰 동물이다."},
    {"en":"We fed the elephant at the zoo.","ko":"우리는 동물원에서 코끼리에게 먹이를 주었다."},
    {"en":"The baby elephant followed its mother.","ko":"아기 코끼리는 어미를 따라갔다."}
  ]'::jsonb),
  ('zebra', 0, 35, '명사', '[
    {"en":"The zebra has black and white stripes.","ko":"얼룩말은 검은색과 흰색 줄무늬가 있다."},
    {"en":"We saw zebras running across the field.","ko":"우리는 얼룩말들이 들판을 가로질러 달리는 것을 보았다."},
    {"en":"The zebra drank water at the pond.","ko":"그 얼룩말은 연못에서 물을 마셨다."}
  ]'::jsonb),
  ('whale', 0, 35, '명사', '[
    {"en":"The whale swam near our boat.","ko":"고래가 우리 배 근처에서 헤엄쳤다."},
    {"en":"Whales are the biggest animals in the ocean.","ko":"고래는 바다에서 가장 큰 동물이다."},
    {"en":"We saw a whale jump out of the water.","ko":"우리는 고래가 물 밖으로 뛰어오르는 것을 보았다."}
  ]'::jsonb),
  ('chicken', 0, 35, '명사', '[
    {"en":"The farmer feeds the chickens every morning.","ko":"농부는 매일 아침 닭들에게 먹이를 준다."},
    {"en":"We have chicken for dinner tonight.","ko":"우리는 오늘 저녁으로 닭고기를 먹는다."},
    {"en":"The chicken laid an egg this morning.","ko":"그 닭은 오늘 아침에 알을 낳았다."}
  ]'::jsonb),
  ('snake', 0, 35, '명사', '[
    {"en":"I was scared when I saw a snake in the grass.","ko":"나는 풀밭에서 뱀을 보고 무서웠다."},
    {"en":"The snake moved slowly across the ground.","ko":"그 뱀은 땅 위를 천천히 움직였다."},
    {"en":"Some snakes live in the desert.","ko":"어떤 뱀들은 사막에서 산다."}
  ]'::jsonb),
  ('mouse', 0, 35, '명사', '[
    {"en":"A little mouse ran across the kitchen floor.","ko":"작은 쥐 한 마리가 부엌 바닥을 가로질러 달렸다."},
    {"en":"The cat chased the mouse.","ko":"고양이가 쥐를 쫓았다."},
    {"en":"We found a mouse hiding under the desk.","ko":"우리는 책상 밑에 숨어 있는 쥐를 발견했다."}
  ]'::jsonb),
  ('sheep', 0, 35, '명사', '[
    {"en":"The sheep were eating grass in the field.","ko":"양들이 들판에서 풀을 먹고 있었다."},
    {"en":"We counted the sheep on the farm.","ko":"우리는 농장에서 양의 수를 세었다."},
    {"en":"A sheep followed the farmer to the barn.","ko":"양 한 마리가 농부를 따라 헛간으로 갔다."}
  ]'::jsonb),
  ('giraffe', 0, 35, '명사', '[
    {"en":"The giraffe has a very long neck.","ko":"기린은 목이 매우 길다."},
    {"en":"We saw a giraffe eating leaves from a tree.","ko":"우리는 기린이 나무에서 잎을 먹는 것을 보았다."},
    {"en":"The giraffe walked slowly across the field.","ko":"그 기린은 들판을 천천히 걸어갔다."}
  ]'::jsonb),
  ('wild', 0, 35, '형용사', '[
    {"en":"We saw many wild animals in the forest.","ko":"우리는 숲에서 많은 야생 동물을 보았다."},
    {"en":"The wild flowers grew along the road.","ko":"야생화가 길을 따라 자랐다."},
    {"en":"It is dangerous to touch wild animals.","ko":"야생 동물을 만지는 것은 위험하다."}
  ]'::jsonb),
  ('animal', 0, 35, '명사', '[
    {"en":"My favorite animal is the elephant.","ko":"내가 가장 좋아하는 동물은 코끼리이다."},
    {"en":"We should protect wild animals.","ko":"우리는 야생 동물을 보호해야 한다."},
    {"en":"The zoo has many kinds of animals.","ko":"그 동물원에는 여러 종류의 동물이 있다."}
  ]'::jsonb),
  ('hunt', 0, 35, '동사', '[
    {"en":"Lions hunt other animals for food.","ko":"사자는 먹이를 위해 다른 동물을 사냥한다."},
    {"en":"The wolf hunted at night.","ko":"그 늑대는 밤에 사냥했다."},
    {"en":"People used to hunt to survive.","ko":"사람들은 예전에 생존하기 위해 사냥을 했다."}
  ]'::jsonb),
  ('tail', 0, 35, '명사', '[
    {"en":"The dog wagged its tail happily.","ko":"개가 행복하게 꼬리를 흔들었다."},
    {"en":"The monkey has a long tail.","ko":"그 원숭이는 긴 꼬리를 가지고 있다."},
    {"en":"The cat''s tail moved slowly.","ko":"고양이의 꼬리가 천천히 움직였다."}
  ]'::jsonb),
  ('colorful', 0, 35, '형용사', '[
    {"en":"The bird has colorful feathers.","ko":"그 새는 알록달록한 깃털을 가지고 있다."},
    {"en":"She wore a colorful dress to the party.","ko":"그녀는 파티에 화려한 색의 드레스를 입고 갔다."},
    {"en":"The garden was full of colorful flowers.","ko":"정원은 알록달록한 꽃들로 가득했다."}
  ]'::jsonb),
  ('feed', 0, 35, '동사', '[
    {"en":"She feeds her dog twice a day.","ko":"그녀는 하루에 두 번 개에게 먹이를 준다."},
    {"en":"We fed the birds in the park.","ko":"우리는 공원에서 새들에게 먹이를 주었다."},
    {"en":"Please don''t feed the animals at the zoo.","ko":"동물원에서 동물들에게 먹이를 주지 마세요."}
  ]'::jsonb),
  ('by the way', 0, 35, '부사구', '[
    {"en":"By the way, did you finish your homework?","ko":"그런데, 숙제는 다 끝냈니?"},
    {"en":"By the way, what time does the movie start?","ko":"그나저나, 영화는 몇 시에 시작하니?"},
    {"en":"By the way, I saw your sister yesterday.","ko":"그런데, 나 어제 네 여동생을 봤어."}
  ]'::jsonb),
  ('look for', 0, 35, '동사구', '[
    {"en":"I am looking for my keys.","ko":"나는 내 열쇠를 찾고 있다."},
    {"en":"We looked for the lost dog all day.","ko":"우리는 하루 종일 잃어버린 개를 찾았다."},
    {"en":"She is looking for a new book to read.","ko":"그녀는 읽을 새 책을 찾고 있다."}
  ]'::jsonb),
  -- Day 36
  ('hill', 0, 36, '명사', '[
    {"en":"We climbed the hill to see the sunset.","ko":"우리는 일몰을 보기 위해 언덕을 올랐다."},
    {"en":"There is a small house on the hill.","ko":"언덕 위에 작은 집이 있다."},
    {"en":"The children rolled down the hill.","ko":"아이들은 언덕 아래로 굴러 내려갔다."}
  ]'::jsonb),
  ('land', 0, 36, '명사', '[
    {"en":"The plane finally landed on the land.","ko":"비행기는 마침내 육지에 착륙했다."},
    {"en":"Farmers use the land to grow crops.","ko":"농부들은 작물을 기르기 위해 땅을 이용한다."},
    {"en":"We could see land from the boat.","ko":"우리는 배에서 육지를 볼 수 있었다."}
  ]'::jsonb),
  ('river', 0, 36, '명사', '[
    {"en":"The river flows through the city.","ko":"그 강은 도시를 가로질러 흐른다."},
    {"en":"We had a picnic by the river.","ko":"우리는 강가에서 소풍을 즐겼다."},
    {"en":"Children were swimming in the river.","ko":"아이들이 강에서 수영하고 있었다."}
  ]'::jsonb),
  ('lake', 0, 36, '명사', '[
    {"en":"We went fishing at the lake.","ko":"우리는 호수에서 낚시를 했다."},
    {"en":"The lake was calm and clear.","ko":"그 호수는 잔잔하고 맑았다."},
    {"en":"They rowed a boat across the lake.","ko":"그들은 배를 저어 호수를 건넜다."}
  ]'::jsonb),
  ('desert', 0, 36, '명사', '[
    {"en":"It is very hot in the desert during the day.","ko":"낮에는 사막이 매우 덥다."},
    {"en":"Few plants grow in the desert.","ko":"사막에서는 식물이 거의 자라지 않는다."},
    {"en":"We traveled across the desert by camel.","ko":"우리는 낙타를 타고 사막을 가로질러 여행했다."}
  ]'::jsonb),
  ('forest', 0, 36, '명사', '[
    {"en":"We took a walk in the forest.","ko":"우리는 숲에서 산책을 했다."},
    {"en":"Many animals live in the forest.","ko":"많은 동물들이 숲에서 산다."},
    {"en":"The forest was quiet and green.","ko":"숲은 조용하고 푸르렀다."}
  ]'::jsonb),
  ('valley', 0, 36, '명사', '[
    {"en":"The village is located in a beautiful valley.","ko":"그 마을은 아름다운 계곡에 위치해 있다."},
    {"en":"We hiked down into the valley.","ko":"우리는 계곡으로 걸어 내려갔다."},
    {"en":"A river runs through the valley.","ko":"강이 계곡을 가로질러 흐른다."}
  ]'::jsonb),
  ('island', 0, 36, '명사', '[
    {"en":"We took a boat to the small island.","ko":"우리는 배를 타고 작은 섬으로 갔다."},
    {"en":"Jeju is a famous island in Korea.","ko":"제주는 한국에서 유명한 섬이다."},
    {"en":"No one lives on that island.","ko":"그 섬에는 아무도 살지 않는다."}
  ]'::jsonb),
  ('jungle', 0, 36, '명사', '[
    {"en":"Many wild animals live in the jungle.","ko":"많은 야생 동물들이 정글에 산다."},
    {"en":"The explorers walked through the thick jungle.","ko":"탐험가들은 울창한 정글을 지나 걸었다."},
    {"en":"We watched a movie about the jungle.","ko":"우리는 정글에 관한 영화를 보았다."}
  ]'::jsonb),
  ('mountain', 0, 36, '명사', '[
    {"en":"We climbed the mountain last summer.","ko":"우리는 지난 여름에 그 산을 올랐다."},
    {"en":"Snow covers the mountain in winter.","ko":"겨울에는 눈이 산을 덮는다."},
    {"en":"The view from the mountain was amazing.","ko":"산에서 본 경치는 놀라웠다."}
  ]'::jsonb),
  ('pond', 0, 36, '명사', '[
    {"en":"There are many fish in the pond.","ko":"연못에는 물고기가 많다."},
    {"en":"We fed the ducks at the pond.","ko":"우리는 연못에서 오리들에게 먹이를 주었다."},
    {"en":"A small pond is in the school garden.","ko":"작은 연못이 학교 정원에 있다."}
  ]'::jsonb),
  ('ocean', 0, 36, '명사', '[
    {"en":"The ocean covers most of the earth.","ko":"바다는 지구의 대부분을 덮고 있다."},
    {"en":"We swam in the ocean during our vacation.","ko":"우리는 방학 동안 바다에서 수영했다."},
    {"en":"The ocean looked blue and calm today.","ko":"오늘 바다는 파랗고 잔잔해 보였다."}
  ]'::jsonb),
  ('cave', 0, 36, '명사', '[
    {"en":"We explored a cave near the mountain.","ko":"우리는 산 근처의 동굴을 탐험했다."},
    {"en":"Bats live inside the dark cave.","ko":"박쥐들은 어두운 동굴 안에 산다."},
    {"en":"The cave was cold and quiet.","ko":"그 동굴은 춥고 조용했다."}
  ]'::jsonb),
  ('polar', 0, 36, '형용사', '[
    {"en":"Polar bears live in cold places.","ko":"북극곰은 추운 곳에서 산다."},
    {"en":"We learned about polar animals in class.","ko":"우리는 수업에서 극지방 동물에 대해 배웠다."},
    {"en":"The polar region is covered with ice and snow.","ko":"극지방은 얼음과 눈으로 덮여 있다."}
  ]'::jsonb),
  ('nature', 0, 36, '명사', '[
    {"en":"I love spending time in nature.","ko":"나는 자연 속에서 시간을 보내는 것을 좋아한다."},
    {"en":"We should protect nature for the future.","ko":"우리는 미래를 위해 자연을 보호해야 한다."},
    {"en":"The park is a good place to enjoy nature.","ko":"그 공원은 자연을 즐기기 좋은 곳이다."}
  ]'::jsonb),
  ('mystery', 0, 36, '명사', '[
    {"en":"The story is full of mystery.","ko":"그 이야기는 미스터리로 가득하다."},
    {"en":"We tried to solve the mystery together.","ko":"우리는 함께 그 미스터리를 풀려고 노력했다."},
    {"en":"It is still a mystery how the cave was formed.","ko":"그 동굴이 어떻게 형성되었는지는 여전히 미스터리이다."}
  ]'::jsonb),
  ('wave', 0, 36, '명사/동사', '[
    {"en":"The waves were big at the beach today.","ko":"오늘 해변에는 파도가 컸다."},
    {"en":"She waved her hand to say goodbye.","ko":"그녀는 작별 인사로 손을 흔들었다."},
    {"en":"We watched the waves from the shore.","ko":"우리는 해안에서 파도를 지켜보았다."}
  ]'::jsonb),
  ('discover', 0, 36, '동사', '[
    {"en":"Scientists discovered a new type of fish.","ko":"과학자들은 새로운 종류의 물고기를 발견했다."},
    {"en":"We discovered a hidden path in the forest.","ko":"우리는 숲에서 숨겨진 길을 발견했다."},
    {"en":"She discovered her love for painting last year.","ko":"그녀는 작년에 그림에 대한 사랑을 발견했다."}
  ]'::jsonb),
  ('look at', 0, 36, '동사구', '[
    {"en":"Look at the beautiful sunset over the ocean.","ko":"바다 위의 아름다운 일몰을 봐."},
    {"en":"She looked at the map to find the way.","ko":"그녀는 길을 찾기 위해 지도를 보았다."},
    {"en":"We looked at the stars in the night sky.","ko":"우리는 밤하늘의 별들을 보았다."}
  ]'::jsonb),
  ('take turns', 0, 36, '동사구', '[
    {"en":"The children took turns riding the bike.","ko":"아이들은 교대로 자전거를 탔다."},
    {"en":"We should take turns cleaning the classroom.","ko":"우리는 교대로 교실을 청소해야 한다."},
    {"en":"Let''s take turns reading the story aloud.","ko":"이야기를 소리 내어 읽는 것을 교대로 하자."}
  ]'::jsonb),
  -- Day 37
  ('warm', 0, 37, '형용사', '[
    {"en":"The soup is warm and delicious.","ko":"그 수프는 따뜻하고 맛있다."},
    {"en":"It was warm outside today.","ko":"오늘 밖은 따뜻했다."},
    {"en":"She wore a warm sweater in winter.","ko":"그녀는 겨울에 따뜻한 스웨터를 입었다."}
  ]'::jsonb),
  ('cold', 0, 37, '형용사', '[
    {"en":"It is very cold in winter.","ko":"겨울에는 매우 춥다."},
    {"en":"I like to drink cold water in summer.","ko":"나는 여름에 차가운 물을 마시는 것을 좋아한다."},
    {"en":"The wind was cold this morning.","ko":"오늘 아침 바람이 차가웠다."}
  ]'::jsonb),
  ('cool', 0, 37, '형용사', '[
    {"en":"The weather is cool in fall.","ko":"가을에는 날씨가 시원하다."},
    {"en":"We sat under a cool tree in summer.","ko":"우리는 여름에 시원한 나무 아래 앉았다."},
    {"en":"That is a really cool idea.","ko":"그것은 정말 멋진 생각이다."}
  ]'::jsonb),
  ('hot', 0, 37, '형용사', '[
    {"en":"It was very hot yesterday.","ko":"어제는 매우 더웠다."},
    {"en":"Be careful, the soup is hot.","ko":"조심해, 수프가 뜨거워."},
    {"en":"We drank cold water on the hot day.","ko":"우리는 더운 날에 차가운 물을 마셨다."}
  ]'::jsonb),
  ('rain', 0, 37, '동사/명사', '[
    {"en":"It rained all day yesterday.","ko":"어제는 하루 종일 비가 왔다."},
    {"en":"We stayed inside because of the rain.","ko":"우리는 비 때문에 실내에 머물렀다."},
    {"en":"Bring an umbrella; it might rain today.","ko":"오늘 비가 올지도 모르니 우산을 가져가."}
  ]'::jsonb),
  ('snow', 0, 37, '동사/명사', '[
    {"en":"It snowed a lot last night.","ko":"어젯밤에 눈이 많이 왔다."},
    {"en":"The children played in the snow.","ko":"아이들은 눈 속에서 놀았다."},
    {"en":"The mountain was covered with snow.","ko":"그 산은 눈으로 덮여 있었다."}
  ]'::jsonb),
  ('clear', 0, 37, '형용사', '[
    {"en":"The sky was clear this morning.","ko":"오늘 아침 하늘은 맑았다."},
    {"en":"We could see the stars on a clear night.","ko":"우리는 맑은 밤에 별을 볼 수 있었다."},
    {"en":"It''s a clear day, so let''s go hiking.","ko":"맑은 날이니 하이킹을 가자."}
  ]'::jsonb),
  ('sunny', 0, 37, '형용사', '[
    {"en":"It is sunny and warm today.","ko":"오늘은 화창하고 따뜻하다."},
    {"en":"We enjoyed a walk on a sunny afternoon.","ko":"우리는 화창한 오후에 산책을 즐겼다."},
    {"en":"The weather will be sunny tomorrow.","ko":"내일 날씨는 화창할 것이다."}
  ]'::jsonb),
  ('windy', 0, 37, '형용사', '[
    {"en":"It was too windy to fly a kite.","ko":"연을 날리기에는 바람이 너무 많이 불었다."},
    {"en":"The weather is windy near the beach.","ko":"해변 근처는 바람이 많이 분다."},
    {"en":"We wore jackets because it was windy.","ko":"바람이 많이 불어서 우리는 재킷을 입었다."}
  ]'::jsonb),
  ('cloudy', 0, 37, '형용사', '[
    {"en":"The sky is cloudy today.","ko":"오늘 하늘은 흐리다."},
    {"en":"It was cloudy, so we couldn''t see the mountain.","ko":"날씨가 흐려서 우리는 산을 볼 수 없었다."},
    {"en":"The weather turned cloudy in the afternoon.","ko":"오후에 날씨가 흐려졌다."}
  ]'::jsonb),
  ('spring', 0, 37, '명사', '[
    {"en":"Flowers bloom in spring.","ko":"봄에는 꽃이 핀다."},
    {"en":"We plant vegetables in spring.","ko":"우리는 봄에 채소를 심는다."},
    {"en":"Spring is my favorite season.","ko":"봄은 내가 가장 좋아하는 계절이다."}
  ]'::jsonb),
  ('summer', 0, 37, '명사', '[
    {"en":"We go swimming every summer.","ko":"우리는 매년 여름 수영을 하러 간다."},
    {"en":"Summer vacation starts next week.","ko":"여름 방학이 다음 주에 시작한다."},
    {"en":"It gets very hot in summer.","ko":"여름에는 매우 더워진다."}
  ]'::jsonb),
  ('fall', 0, 37, '명사/동사', '[
    {"en":"The leaves turn red in fall.","ko":"가을에는 나뭇잎이 빨갛게 변한다."},
    {"en":"Be careful not to fall on the stairs.","ko":"계단에서 넘어지지 않도록 조심해."},
    {"en":"We enjoy hiking in fall.","ko":"우리는 가을에 하이킹을 즐긴다."}
  ]'::jsonb),
  ('winter', 0, 37, '명사', '[
    {"en":"It snows a lot in winter.","ko":"겨울에는 눈이 많이 온다."},
    {"en":"We wear thick coats in winter.","ko":"우리는 겨울에 두꺼운 코트를 입는다."},
    {"en":"Winter is the coldest season of the year.","ko":"겨울은 일 년 중 가장 추운 계절이다."}
  ]'::jsonb),
  ('season', 0, 37, '명사', '[
    {"en":"Which season do you like best?","ko":"어느 계절을 가장 좋아하니?"},
    {"en":"Fall is the season for harvesting fruit.","ko":"가을은 과일을 수확하는 계절이다."},
    {"en":"Each season has its own beauty.","ko":"각 계절마다 저마다의 아름다움이 있다."}
  ]'::jsonb),
  ('blow', 0, 37, '동사', '[
    {"en":"The wind blew hard last night.","ko":"어젯밤 바람이 세게 불었다."},
    {"en":"A cool breeze blew through the window.","ko":"시원한 바람이 창문을 통해 불어왔다."},
    {"en":"The wind blows strongly in winter.","ko":"겨울에는 바람이 강하게 분다."}
  ]'::jsonb),
  ('weather', 0, 37, '명사', '[
    {"en":"The weather is nice today.","ko":"오늘 날씨가 좋다."},
    {"en":"How is the weather in your city?","ko":"너희 도시 날씨는 어때?"},
    {"en":"We checked the weather before the trip.","ko":"우리는 여행 전에 날씨를 확인했다."}
  ]'::jsonb),
  ('forecast', 0, 37, '명사/동사', '[
    {"en":"The weather forecast says it will rain tomorrow.","ko":"일기예보는 내일 비가 올 것이라고 한다."},
    {"en":"I watched the forecast this morning.","ko":"나는 오늘 아침 일기예보를 보았다."},
    {"en":"Experts forecast a warm spring this year.","ko":"전문가들은 올해 따뜻한 봄을 예측했다."}
  ]'::jsonb),
  ('at first', 0, 37, '부사구', '[
    {"en":"At first, I didn''t like the new school.","ko":"처음에, 나는 새 학교가 마음에 들지 않았다."},
    {"en":"At first, the movie seemed boring.","ko":"처음에는 그 영화가 지루해 보였다."},
    {"en":"At first, she was shy in front of the class.","ko":"처음에 그녀는 반 앞에서 수줍어했다."}
  ]'::jsonb),
  ('all day (long)', 0, 37, '부사구', '[
    {"en":"It rained all day long.","ko":"하루 종일 비가 왔다."},
    {"en":"We played outside all day.","ko":"우리는 하루 종일 밖에서 놀았다."},
    {"en":"She studied for the test all day long.","ko":"그녀는 하루 종일 시험공부를 했다."}
  ]'::jsonb),
  -- Day 38
  ('event', 0, 38, '명사', '[
    {"en":"The school festival is a big event.","ko":"학교 축제는 큰 행사이다."},
    {"en":"Many students joined the sports event.","ko":"많은 학생들이 그 스포츠 행사에 참여했다."},
    {"en":"We are planning a special event this weekend.","ko":"우리는 이번 주말에 특별한 행사를 계획하고 있다."}
  ]'::jsonb),
  ('start', 0, 38, '동사/명사', '[
    {"en":"The class starts at nine o''clock.","ko":"수업은 9시에 시작한다."},
    {"en":"We made a good start on the project.","ko":"우리는 그 프로젝트를 좋은 출발로 시작했다."},
    {"en":"She started to learn the guitar last month.","ko":"그녀는 지난달에 기타를 배우기 시작했다."}
  ]'::jsonb),
  ('end', 0, 38, '동사/명사', '[
    {"en":"The movie ends at ten o''clock.","ko":"그 영화는 10시에 끝난다."},
    {"en":"We were happy about the end of the story.","ko":"우리는 그 이야기의 결말이 만족스러웠다."},
    {"en":"The school year ends in December.","ko":"학년은 12월에 끝난다."}
  ]'::jsonb),
  ('enter', 0, 38, '동사', '[
    {"en":"Please enter the room quietly.","ko":"방에 조용히 들어와 주세요."},
    {"en":"She decided to enter the writing contest.","ko":"그녀는 글쓰기 대회에 참가하기로 결정했다."},
    {"en":"We entered the museum through the main gate.","ko":"우리는 정문을 통해 박물관에 들어갔다."}
  ]'::jsonb),
  ('luck', 0, 38, '명사', '[
    {"en":"Good luck on your test tomorrow.","ko":"내일 시험 잘 봐."},
    {"en":"We had good luck finding a parking spot.","ko":"우리는 운 좋게 주차 자리를 찾았다."},
    {"en":"She wished me luck before the game.","ko":"그녀는 경기 전에 나에게 행운을 빌어주었다."}
  ]'::jsonb),
  ('important', 0, 38, '형용사', '[
    {"en":"Family is important to me.","ko":"가족은 나에게 중요하다."},
    {"en":"It is important to study every day.","ko":"매일 공부하는 것은 중요하다."},
    {"en":"This is an important decision for our class.","ko":"이것은 우리 반에게 중요한 결정이다."}
  ]'::jsonb),
  ('building', 0, 38, '명사', '[
    {"en":"The school building has three floors.","ko":"그 학교 건물은 3층으로 되어 있다."},
    {"en":"A new building was built near the park.","ko":"공원 근처에 새 건물이 지어졌다."},
    {"en":"We visited a very old building in the city.","ko":"우리는 그 도시에서 매우 오래된 건물을 방문했다."}
  ]'::jsonb),
  ('law', 0, 38, '명사', '[
    {"en":"Everyone must follow the law.","ko":"모든 사람은 법을 따라야 한다."},
    {"en":"We learned about the law in social studies class.","ko":"우리는 사회 수업에서 법에 대해 배웠다."},
    {"en":"The new law protects the environment.","ko":"그 새로운 법은 환경을 보호한다."}
  ]'::jsonb),
  ('history', 0, 38, '명사', '[
    {"en":"I enjoy learning about world history.","ko":"나는 세계 역사에 대해 배우는 것을 좋아한다."},
    {"en":"Our teacher told us an interesting story about history.","ko":"선생님은 우리에게 역사에 관한 흥미로운 이야기를 들려주셨다."},
    {"en":"The museum shows the history of our city.","ko":"그 박물관은 우리 도시의 역사를 보여준다."}
  ]'::jsonb),
  ('hometown', 0, 38, '명사', '[
    {"en":"I miss my hometown very much.","ko":"나는 고향이 매우 그립다."},
    {"en":"She was born and raised in a small hometown.","ko":"그녀는 작은 고향에서 태어나고 자랐다."},
    {"en":"We visit our hometown every summer.","ko":"우리는 매년 여름 고향을 방문한다."}
  ]'::jsonb),
  ('local', 0, 38, '형용사', '[
    {"en":"We shopped at the local market.","ko":"우리는 지역 시장에서 쇼핑했다."},
    {"en":"The local news reported about the festival.","ko":"지역 뉴스가 그 축제에 대해 보도했다."},
    {"en":"He knows a lot about local history.","ko":"그는 지역 역사에 대해 많이 알고 있다."}
  ]'::jsonb),
  ('create', 0, 38, '동사', '[
    {"en":"The artist created a beautiful painting.","ko":"그 화가는 아름다운 그림을 만들었다."},
    {"en":"We created a new club at school.","ko":"우리는 학교에 새로운 동아리를 만들었다."},
    {"en":"Students worked together to create a project.","ko":"학생들은 함께 프로젝트를 만들기 위해 협력했다."}
  ]'::jsonb),
  ('project', 0, 38, '명사', '[
    {"en":"Our group finished the science project.","ko":"우리 조는 과학 프로젝트를 끝냈다."},
    {"en":"We are working on a class project together.","ko":"우리는 함께 학급 프로젝트를 진행하고 있다."},
    {"en":"The project took two weeks to complete.","ko":"그 프로젝트는 완료하는 데 2주가 걸렸다."}
  ]'::jsonb),
  ('citizen', 0, 38, '명사', '[
    {"en":"Every citizen should follow the rules.","ko":"모든 시민은 규칙을 따라야 한다."},
    {"en":"She became a citizen of that country.","ko":"그녀는 그 나라의 시민이 되었다."},
    {"en":"Good citizens help their neighbors.","ko":"좋은 시민은 이웃을 돕는다."}
  ]'::jsonb),
  ('president', 0, 38, '명사', '[
    {"en":"The president gave a speech yesterday.","ko":"대통령은 어제 연설을 했다."},
    {"en":"She was elected president of the club.","ko":"그녀는 그 동아리의 회장으로 선출되었다."},
    {"en":"We watched the news about the new president.","ko":"우리는 새 대통령에 관한 뉴스를 보았다."}
  ]'::jsonb),
  ('information', 0, 38, '명사', '[
    {"en":"The website gives useful information about the trip.","ko":"그 웹사이트는 여행에 대한 유용한 정보를 제공한다."},
    {"en":"Please give me more information about the event.","ko":"그 행사에 대한 정보를 더 알려주세요."},
    {"en":"We collected information for our report.","ko":"우리는 보고서를 위해 정보를 모았다."}
  ]'::jsonb),
  ('program', 0, 38, '명사', '[
    {"en":"I watched a science program on TV last night.","ko":"나는 어젯밤 TV에서 과학 프로그램을 보았다."},
    {"en":"The school has a special reading program.","ko":"그 학교는 특별한 독서 프로그램을 운영한다."},
    {"en":"She joined an English program this summer.","ko":"그녀는 이번 여름에 영어 프로그램에 참여했다."}
  ]'::jsonb),
  ('traditional', 0, 38, '형용사', '[
    {"en":"We wore traditional clothes for the festival.","ko":"우리는 축제를 위해 전통 옷을 입었다."},
    {"en":"She learned a traditional dance from her grandmother.","ko":"그녀는 할머니에게서 전통 춤을 배웠다."},
    {"en":"The restaurant serves traditional Korean food.","ko":"그 식당은 전통 한국 음식을 제공한다."}
  ]'::jsonb),
  ('ask for', 0, 38, '동사구', '[
    {"en":"He asked for help with his homework.","ko":"그는 숙제에 대한 도움을 요청했다."},
    {"en":"She asked for more time to finish the test.","ko":"그녀는 시험을 끝낼 시간을 더 요청했다."},
    {"en":"We asked for directions to the museum.","ko":"우리는 박물관으로 가는 길을 물었다."}
  ]'::jsonb),
  ('these days', 0, 38, '부사구', '[
    {"en":"These days, many students use smartphones.","ko":"요즘 많은 학생들이 스마트폰을 사용한다."},
    {"en":"I am very busy with school these days.","ko":"나는 요즘 학교 때문에 매우 바쁘다."},
    {"en":"These days, the weather changes a lot.","ko":"요즘 날씨가 많이 변한다."}
  ]'::jsonb),
  -- Day 39
  ('air', 0, 39, '명사', '[
    {"en":"The air in the mountains is very fresh.","ko":"산속의 공기는 매우 신선하다."},
    {"en":"We need clean air to breathe.","ko":"우리는 숨 쉬기 위해 깨끗한 공기가 필요하다."},
    {"en":"The air felt cold this morning.","ko":"오늘 아침 공기가 차갑게 느껴졌다."}
  ]'::jsonb),
  ('fire', 0, 39, '명사', '[
    {"en":"We made a fire to keep warm.","ko":"우리는 몸을 따뜻하게 하려고 불을 피웠다."},
    {"en":"The fire spread quickly through the building.","ko":"화재가 건물을 통해 빠르게 번졌다."},
    {"en":"Be careful with fire when you camp.","ko":"캠핑할 때는 불을 조심해라."}
  ]'::jsonb),
  ('sand', 0, 39, '명사', '[
    {"en":"The children built a castle with sand.","ko":"아이들은 모래로 성을 지었다."},
    {"en":"The sand was hot under our feet.","ko":"모래가 발밑에서 뜨거웠다."},
    {"en":"We played on the sand at the beach.","ko":"우리는 해변의 모래 위에서 놀았다."}
  ]'::jsonb),
  ('rock', 0, 39, '명사', '[
    {"en":"He sat on a big rock by the river.","ko":"그는 강가의 큰 바위에 앉았다."},
    {"en":"We climbed over the rocks on the trail.","ko":"우리는 등산로에 있는 바위들을 넘어갔다."},
    {"en":"The mountain is made of hard rock.","ko":"그 산은 단단한 바위로 이루어져 있다."}
  ]'::jsonb),
  ('earth', 0, 39, '명사', '[
    {"en":"The earth moves around the sun.","ko":"지구는 태양 주위를 돈다."},
    {"en":"We should take care of the earth.","ko":"우리는 지구를 소중히 여겨야 한다."},
    {"en":"Scientists study how the earth was formed.","ko":"과학자들은 지구가 어떻게 형성되었는지 연구한다."}
  ]'::jsonb),
  ('power', 0, 39, '명사', '[
    {"en":"The storm caused a power outage.","ko":"폭풍우가 정전을 일으켰다."},
    {"en":"Wind power can make electricity.","ko":"풍력은 전기를 만들 수 있다."},
    {"en":"The machine needs a lot of power to run.","ko":"그 기계는 작동하는 데 많은 동력이 필요하다."}
  ]'::jsonb),
  ('glass', 0, 39, '명사', '[
    {"en":"The window is made of glass.","ko":"그 창문은 유리로 만들어졌다."},
    {"en":"She drank a glass of milk.","ko":"그녀는 우유 한 잔을 마셨다."},
    {"en":"He wears glasses to read.","ko":"그는 책을 읽을 때 안경을 쓴다."}
  ]'::jsonb),
  ('reuse', 0, 39, '동사/명사', '[
    {"en":"We can reuse this bottle for water.","ko":"우리는 이 병을 물병으로 재사용할 수 있다."},
    {"en":"Try to reuse paper bags instead of buying new ones.","ko":"새 것을 사는 대신 종이 봉투를 재사용해 보세요."},
    {"en":"Reuse is one way to protect the environment.","ko":"재사용은 환경을 보호하는 한 가지 방법이다."}
  ]'::jsonb),
  ('recycle', 0, 39, '동사/명사', '[
    {"en":"We recycle cans and bottles at home.","ko":"우리는 집에서 캔과 병을 재활용한다."},
    {"en":"Please recycle the paper instead of throwing it away.","ko":"종이를 버리는 대신 재활용해 주세요."},
    {"en":"Our school has a recycle program.","ko":"우리 학교는 재활용 프로그램이 있다."}
  ]'::jsonb),
  ('plastic', 0, 39, '명사', '[
    {"en":"We should use less plastic every day.","ko":"우리는 매일 플라스틱을 덜 사용해야 한다."},
    {"en":"The bottle is made of plastic.","ko":"그 병은 플라스틱으로 만들어졌다."},
    {"en":"Plastic waste is harmful to the ocean.","ko":"플라스틱 쓰레기는 바다에 해롭다."}
  ]'::jsonb),
  ('trash', 0, 39, '명사', '[
    {"en":"Please put the trash in the bin.","ko":"쓰레기를 쓰레기통에 넣어 주세요."},
    {"en":"We picked up trash at the park.","ko":"우리는 공원에서 쓰레기를 주웠다."},
    {"en":"There was a lot of trash on the street.","ko":"거리에 쓰레기가 많이 있었다."}
  ]'::jsonb),
  ('save', 0, 39, '동사', '[
    {"en":"Turning off the lights can save energy.","ko":"불을 끄는 것은 에너지를 절약할 수 있다."},
    {"en":"She saves money every month.","ko":"그녀는 매달 돈을 저축한다."},
    {"en":"The firefighter saved the cat from the tree.","ko":"소방관은 나무에서 고양이를 구했다."}
  ]'::jsonb),
  ('energy', 0, 39, '명사', '[
    {"en":"We should save energy at home.","ko":"우리는 집에서 에너지를 절약해야 한다."},
    {"en":"Solar energy comes from the sun.","ko":"태양 에너지는 태양에서 나온다."},
    {"en":"I feel full of energy in the morning.","ko":"나는 아침에 에너지가 가득한 느낌이 든다."}
  ]'::jsonb),
  ('bill', 0, 39, '명사', '[
    {"en":"My father pays the electricity bill every month.","ko":"아버지는 매달 전기 요금 청구서를 지불하신다."},
    {"en":"We split the bill at the restaurant.","ko":"우리는 식당에서 계산서를 나누어 냈다."},
    {"en":"She paid with a ten-dollar bill.","ko":"그녀는 10달러 지폐로 지불했다."}
  ]'::jsonb),
  ('protect', 0, 39, '동사', '[
    {"en":"We should protect the environment.","ko":"우리는 환경을 보호해야 한다."},
    {"en":"Parents protect their children from danger.","ko":"부모는 위험으로부터 자녀를 보호한다."},
    {"en":"Wearing a helmet can protect your head.","ko":"헬멧을 쓰는 것은 머리를 보호할 수 있다."}
  ]'::jsonb),
  ('dangerous', 0, 39, '형용사', '[
    {"en":"It is dangerous to swim alone in the river.","ko":"강에서 혼자 수영하는 것은 위험하다."},
    {"en":"Crossing the street without looking is dangerous.","ko":"보지 않고 길을 건너는 것은 위험하다."},
    {"en":"Some wild animals can be dangerous.","ko":"일부 야생 동물은 위험할 수 있다."}
  ]'::jsonb),
  ('float', 0, 39, '동사', '[
    {"en":"The leaf floated on the water.","ko":"나뭇잎이 물 위에 떠 있었다."},
    {"en":"Wood floats on water.","ko":"나무는 물 위에 뜬다."},
    {"en":"We watched the boat float down the river.","ko":"우리는 배가 강을 따라 떠내려가는 것을 지켜보았다."}
  ]'::jsonb),
  ('environment', 0, 39, '명사', '[
    {"en":"We should protect the environment for future generations.","ko":"우리는 미래 세대를 위해 환경을 보호해야 한다."},
    {"en":"Plastic waste is bad for the environment.","ko":"플라스틱 쓰레기는 환경에 나쁘다."},
    {"en":"Our class learned about the environment today.","ko":"우리 반은 오늘 환경에 대해 배웠다."}
  ]'::jsonb),
  ('throw away', 0, 39, '동사구', '[
    {"en":"Please don''t throw away your old books.","ko":"낡은 책을 버리지 마세요."},
    {"en":"She threw away the broken toy.","ko":"그녀는 고장 난 장난감을 버렸다."},
    {"en":"We should not throw away plastic bottles.","ko":"우리는 플라스틱 병을 버리면 안 된다."}
  ]'::jsonb),
  ('be worried about', 0, 39, '동사구', '[
    {"en":"She is worried about her test results.","ko":"그녀는 시험 결과에 대해 걱정하고 있다."},
    {"en":"I am worried about the environment.","ko":"나는 환경에 대해 걱정하고 있다."},
    {"en":"We were worried about the heavy rain.","ko":"우리는 폭우에 대해 걱정했다."}
  ]'::jsonb),
  -- Day 40
  ('help', 0, 40, '동사/명사', '[
    {"en":"Can you help me with my homework?","ko":"내 숙제를 도와줄 수 있니?"},
    {"en":"Thank you for your help.","ko":"도와주셔서 감사합니다."},
    {"en":"She helped her friend clean the classroom.","ko":"그녀는 친구가 교실을 청소하는 것을 도왔다."}
  ]'::jsonb),
  ('human', 0, 40, '명사', '[
    {"en":"Humans need water and food to live.","ko":"인간은 살기 위해 물과 음식이 필요하다."},
    {"en":"The robot cannot feel like a human.","ko":"로봇은 인간처럼 느낄 수 없다."},
    {"en":"Every human deserves respect.","ko":"모든 인간은 존중받을 자격이 있다."}
  ]'::jsonb),
  ('country', 0, 40, '명사', '[
    {"en":"Korea is a beautiful country.","ko":"한국은 아름다운 나라이다."},
    {"en":"She grew up in the country.","ko":"그녀는 시골에서 자랐다."},
    {"en":"We learned about many countries in class.","ko":"우리는 수업에서 여러 나라에 대해 배웠다."}
  ]'::jsonb),
  ('peace', 0, 40, '명사', '[
    {"en":"People around the world wish for peace.","ko":"전 세계 사람들은 평화를 소망한다."},
    {"en":"The two countries signed a peace agreement.","ko":"두 나라는 평화 협정을 맺었다."},
    {"en":"We should work together for world peace.","ko":"우리는 세계 평화를 위해 함께 노력해야 한다."}
  ]'::jsonb),
  ('war', 0, 40, '명사', '[
    {"en":"Many people suffered during the war.","ko":"많은 사람들이 전쟁 동안 고통을 겪었다."},
    {"en":"We learned about the history of the war.","ko":"우리는 그 전쟁의 역사에 대해 배웠다."},
    {"en":"The museum shows life before and after the war.","ko":"그 박물관은 전쟁 전후의 생활을 보여준다."}
  ]'::jsonb),
  ('website', 0, 40, '명사', '[
    {"en":"I found the information on a website.","ko":"나는 웹사이트에서 그 정보를 찾았다."},
    {"en":"Our school has its own website.","ko":"우리 학교는 자체 웹사이트를 가지고 있다."},
    {"en":"She checked the weather on a website.","ko":"그녀는 웹사이트에서 날씨를 확인했다."}
  ]'::jsonb),
  ('spread', 0, 40, '동사', '[
    {"en":"The news spread quickly through the school.","ko":"그 소식은 학교 전체에 빠르게 퍼졌다."},
    {"en":"Please don''t spread rumors about your friends.","ko":"친구들에 대한 소문을 퍼뜨리지 마세요."},
    {"en":"The fire spread across the field.","ko":"불이 들판을 가로질러 번졌다."}
  ]'::jsonb),
  ('chat', 0, 40, '동사/명사', '[
    {"en":"We chatted about our weekend plans.","ko":"우리는 주말 계획에 대해 수다를 떨었다."},
    {"en":"I like to chat with my friends online.","ko":"나는 온라인으로 친구들과 채팅하는 것을 좋아한다."},
    {"en":"We had a nice chat during lunch.","ko":"우리는 점심시간에 즐거운 대화를 나눴다."}
  ]'::jsonb),
  ('post', 0, 40, '동사', '[
    {"en":"She posted a photo of her trip online.","ko":"그녀는 여행 사진을 온라인에 게시했다."},
    {"en":"He posts a new video every week.","ko":"그는 매주 새 영상을 올린다."},
    {"en":"I posted my project on the class website.","ko":"나는 학급 웹사이트에 내 프로젝트를 올렸다."}
  ]'::jsonb),
  ('online', 0, 40, '형용사/부사', '[
    {"en":"We took an online class last semester.","ko":"우리는 지난 학기에 온라인 수업을 들었다."},
    {"en":"She shops online for books.","ko":"그녀는 온라인으로 책을 산다."},
    {"en":"Many students study online these days.","ko":"요즘 많은 학생들이 온라인으로 공부한다."}
  ]'::jsonb),
  ('explore', 0, 40, '동사', '[
    {"en":"We explored the old castle during our trip.","ko":"우리는 여행 동안 오래된 성을 탐험했다."},
    {"en":"Scientists explore the ocean to learn new things.","ko":"과학자들은 새로운 것을 배우기 위해 바다를 탐험한다."},
    {"en":"The children love to explore the forest.","ko":"아이들은 숲을 탐험하는 것을 좋아한다."}
  ]'::jsonb),
  ('palace', 0, 40, '명사', '[
    {"en":"We visited an old palace in Seoul.","ko":"우리는 서울에 있는 오래된 궁전을 방문했다."},
    {"en":"The palace was built hundreds of years ago.","ko":"그 궁전은 수백 년 전에 지어졌다."},
    {"en":"Many tourists take pictures in front of the palace.","ko":"많은 관광객들이 궁전 앞에서 사진을 찍는다."}
  ]'::jsonb),
  ('actually', 0, 40, '부사', '[
    {"en":"Actually, I have never been to Jeju Island.","ko":"사실, 나는 제주도에 가본 적이 없다."},
    {"en":"She actually finished the book in one day.","ko":"그녀는 실제로 그 책을 하루 만에 다 읽었다."},
    {"en":"Actually, the test was easier than I thought.","ko":"사실, 그 시험은 내가 생각했던 것보다 쉬웠다."}
  ]'::jsonb),
  ('science', 0, 40, '명사', '[
    {"en":"Science is my favorite subject.","ko":"과학은 내가 가장 좋아하는 과목이다."},
    {"en":"We did an experiment in science class.","ko":"우리는 과학 수업에서 실험을 했다."},
    {"en":"She wants to be a science teacher.","ko":"그녀는 과학 선생님이 되고 싶어 한다."}
  ]'::jsonb),
  ('culture', 0, 40, '명사', '[
    {"en":"I am interested in different cultures.","ko":"나는 다양한 문화에 관심이 있다."},
    {"en":"We learned about Korean culture at school.","ko":"우리는 학교에서 한국 문화에 대해 배웠다."},
    {"en":"Food is an important part of culture.","ko":"음식은 문화의 중요한 부분이다."}
  ]'::jsonb),
  ('universe', 0, 40, '명사', '[
    {"en":"The universe is full of stars and planets.","ko":"우주는 별과 행성들로 가득하다."},
    {"en":"Scientists study the universe to find new planets.","ko":"과학자들은 새로운 행성을 찾기 위해 우주를 연구한다."},
    {"en":"I sometimes wonder how big the universe is.","ko":"나는 가끔 우주가 얼마나 큰지 궁금하다."}
  ]'::jsonb),
  ('language', 0, 40, '명사', '[
    {"en":"English is a useful language to learn.","ko":"영어는 배우기에 유용한 언어이다."},
    {"en":"She can speak three languages.","ko":"그녀는 세 가지 언어를 할 수 있다."},
    {"en":"Learning a new language takes time and effort.","ko":"새로운 언어를 배우는 것은 시간과 노력이 필요하다."}
  ]'::jsonb),
  ('foreigner', 0, 40, '명사', '[
    {"en":"The foreigner asked me for directions.","ko":"그 외국인은 나에게 길을 물었다."},
    {"en":"Many foreigners visit Korea every year.","ko":"매년 많은 외국인들이 한국을 방문한다."},
    {"en":"She made friends with a foreigner at school.","ko":"그녀는 학교에서 한 외국인과 친구가 되었다."}
  ]'::jsonb),
  ('believe in', 0, 40, '동사구', '[
    {"en":"I believe in you.","ko":"나는 너를 믿는다."},
    {"en":"She believes in hard work.","ko":"그녀는 노력을 믿는다."},
    {"en":"We believe in helping our neighbors.","ko":"우리는 이웃을 돕는 것을 중요하게 생각한다."}
  ]'::jsonb),
  ('around the world', 0, 40, '부사구', '[
    {"en":"People around the world celebrate this festival.","ko":"전 세계 사람들이 이 축제를 기념한다."},
    {"en":"News spreads quickly around the world.","ko":"소식은 전 세계에 빠르게 퍼진다."},
    {"en":"Students around the world use this website to study.","ko":"전 세계 학생들이 공부를 위해 이 웹사이트를 사용한다."}
  ]'::jsonb)
) as t(word, level, study_day, pos, examples)
where v.word = t.word and v.level = t.level and v.study_day = t.study_day;
