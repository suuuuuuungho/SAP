-- SAP 1기 대시보드: Study 탭 — Lv.1(중등 실력) Day 07~12 품사/예문 채우기 (180단어).
update public.vocab_words v
set part_of_speech = t.pos, example_sentences = t.examples, updated_at = now()
from (values
  ('bake', 1, 7, '동사', '[
    {"en":"My mother likes to bake cookies on weekends.","ko":"우리 엄마는 주말에 쿠키 굽는 것을 좋아하신다."},
    {"en":"We baked bread in the kitchen together.","ko":"우리는 부엌에서 함께 빵을 구웠다."},
    {"en":"Can you bake a cake for my birthday?","ko":"내 생일을 위해 케이크를 구워 줄 수 있니?"}
  ]'::jsonb),
  ('fry', 1, 7, '동사', '[
    {"en":"She fried some eggs for breakfast.","ko":"그녀는 아침 식사로 달걀을 튀겼다."},
    {"en":"He fries potatoes in a big pan.","ko":"그는 큰 팬에 감자를 튀긴다."},
    {"en":"We fried chicken for the picnic.","ko":"우리는 소풍을 위해 치킨을 튀겼다."}
  ]'::jsonb),
  ('boil', 1, 7, '동사', '[
    {"en":"First, boil the water in the pot.","ko":"먼저 냄비에 물을 끓이세요."},
    {"en":"She boiled an egg for ten minutes.","ko":"그녀는 달걀을 10분 동안 삶았다."},
    {"en":"We boiled some noodles for dinner.","ko":"우리는 저녁으로 국수를 삶았다."}
  ]'::jsonb),
  ('glass', 1, 7, '명사', '[
    {"en":"Can I have a glass of water, please?","ko":"물 한 잔 주시겠어요?"},
    {"en":"The glass on the table is empty.","ko":"탁자 위의 유리잔은 비어 있다."},
    {"en":"He filled the glass with juice.","ko":"그는 잔에 주스를 채웠다."}
  ]'::jsonb),
  ('knife', 1, 7, '명사', '[
    {"en":"Be careful with that sharp knife.","ko":"그 날카로운 칼을 조심해라."},
    {"en":"She cut the apple with a knife.","ko":"그녀는 칼로 사과를 잘랐다."},
    {"en":"The knife is in the kitchen drawer.","ko":"칼은 부엌 서랍 안에 있다."}
  ]'::jsonb),
  ('basket', 1, 7, '명사', '[
    {"en":"She put the fruit in a basket.","ko":"그녀는 과일을 바구니에 담았다."},
    {"en":"We carried the bread in a basket.","ko":"우리는 바구니에 빵을 담아 옮겼다."},
    {"en":"There is a basket of flowers on the table.","ko":"탁자 위에 꽃 바구니가 있다."}
  ]'::jsonb),
  ('chop', 1, 7, '동사', '[
    {"en":"He chopped the onions for the soup.","ko":"그는 수프를 위해 양파를 다졌다."},
    {"en":"Please chop the vegetables into small pieces.","ko":"채소를 작은 조각으로 썰어 주세요."},
    {"en":"She chopped the carrots quickly.","ko":"그녀는 당근을 빠르게 썰었다."}
  ]'::jsonb),
  ('lid', 1, 7, '명사', '[
    {"en":"Put the lid on the pot.","ko":"냄비에 뚜껑을 덮어라."},
    {"en":"The lid of the jar is too tight.","ko":"병뚜껑이 너무 꽉 조여 있다."},
    {"en":"She opened the lid and looked inside.","ko":"그녀는 뚜껑을 열고 안을 들여다보았다."}
  ]'::jsonb),
  ('handle', 1, 7, '명사', '[
    {"en":"The handle of the door is broken.","ko":"문 손잡이가 고장 났다."},
    {"en":"Hold the handle of the pan carefully.","ko":"팬의 손잡이를 조심스럽게 잡아라."},
    {"en":"This bag has a long handle.","ko":"이 가방은 손잡이가 길다."}
  ]'::jsonb),
  ('pour', 1, 7, '동사', '[
    {"en":"She poured milk into the glass.","ko":"그녀는 잔에 우유를 부었다."},
    {"en":"He poured the soup into a bowl.","ko":"그는 그릇에 수프를 부었다."},
    {"en":"Please pour some water into the pot.","ko":"냄비에 물을 좀 부어 주세요."}
  ]'::jsonb),
  ('roll', 1, 7, '동사', '[
    {"en":"She rolled the dough with a rolling pin.","ko":"그녀는 밀대로 반죽을 밀었다."},
    {"en":"He rolled the ball across the floor.","ko":"그는 바닥에서 공을 굴렸다."},
    {"en":"We rolled the dough thin for the pizza.","ko":"우리는 피자를 위해 반죽을 얇게 밀었다."}
  ]'::jsonb),
  ('slice', 1, 7, '동사', '[
    {"en":"He sliced the bread for breakfast.","ko":"그는 아침 식사로 빵을 얇게 썰었다."},
    {"en":"She sliced the apple into pieces.","ko":"그녀는 사과를 얇게 썰었다."},
    {"en":"Please slice the cheese thinly.","ko":"치즈를 얇게 썰어 주세요."}
  ]'::jsonb),
  ('refrigerator', 1, 7, '명사', '[
    {"en":"Put the milk in the refrigerator.","ko":"냉장고에 우유를 넣어라."},
    {"en":"The refrigerator is full of vegetables.","ko":"냉장고는 채소로 가득 차 있다."},
    {"en":"She opened the refrigerator to get some juice.","ko":"그녀는 주스를 꺼내려고 냉장고를 열었다."}
  ]'::jsonb),
  ('pot', 1, 7, '명사', '[
    {"en":"She cooked soup in a big pot.","ko":"그녀는 큰 냄비에 수프를 요리했다."},
    {"en":"The pot is on the stove.","ko":"냄비가 가스레인지 위에 있다."},
    {"en":"He filled the pot with water.","ko":"그는 냄비에 물을 채웠다."}
  ]'::jsonb),
  ('bowl', 1, 7, '명사', '[
    {"en":"She put rice in a bowl.","ko":"그녀는 그릇에 밥을 담았다."},
    {"en":"The bowl is full of fruit.","ko":"그릇에 과일이 가득하다."},
    {"en":"He washed the bowl after dinner.","ko":"그는 저녁 식사 후 그릇을 씻었다."}
  ]'::jsonb),
  ('plate', 1, 7, '명사', '[
    {"en":"She put the food on a plate.","ko":"그녀는 접시에 음식을 담았다."},
    {"en":"The plate is very hot.","ko":"그 접시는 매우 뜨겁다."},
    {"en":"He washed the plates after lunch.","ko":"그는 점심 식사 후 접시를 씻었다."}
  ]'::jsonb),
  ('tray', 1, 7, '명사', '[
    {"en":"She carried the cups on a tray.","ko":"그녀는 쟁반에 컵을 담아 옮겼다."},
    {"en":"The tray is full of cookies.","ko":"쟁반에 쿠키가 가득하다."},
    {"en":"He placed the tray on the table.","ko":"그는 탁자 위에 쟁반을 놓았다."}
  ]'::jsonb),
  ('jar', 1, 7, '명사', '[
    {"en":"The jam is in a glass jar.","ko":"잼이 유리병 안에 있다."},
    {"en":"She opened the jar carefully.","ko":"그녀는 조심스럽게 병을 열었다."},
    {"en":"There are cookies in the jar.","ko":"병 안에 쿠키가 있다."}
  ]'::jsonb),
  ('pan', 1, 7, '명사', '[
    {"en":"He fried the eggs in a pan.","ko":"그는 팬에 달걀을 튀겼다."},
    {"en":"The pan is hot, so be careful.","ko":"팬이 뜨거우니 조심해라."},
    {"en":"She washed the pan after cooking.","ko":"그녀는 요리 후 팬을 씻었다."}
  ]'::jsonb),
  ('beat', 1, 7, '동사', '[
    {"en":"She beat the eggs in a bowl.","ko":"그녀는 그릇에서 달걀을 휘저었다."},
    {"en":"He beat the cream until it was soft.","ko":"그는 크림이 부드러워질 때까지 휘저었다."},
    {"en":"Beat the mixture well before baking.","ko":"굽기 전에 반죽을 잘 저어라."}
  ]'::jsonb),
  ('steam', 1, 7, '동사', '[
    {"en":"She steamed the vegetables for dinner.","ko":"그녀는 저녁을 위해 채소를 쪘다."},
    {"en":"We steamed the fish with lemon.","ko":"우리는 레몬을 곁들여 생선을 쪘다."},
    {"en":"He steams rice cakes every morning.","ko":"그는 매일 아침 떡을 찐다."}
  ]'::jsonb),
  ('scoop', 1, 7, '명사', '[
    {"en":"She used a scoop to serve the ice cream.","ko":"그녀는 국자로 아이스크림을 펐다."},
    {"en":"The scoop is next to the rice cooker.","ko":"주걱은 밥솥 옆에 있다."},
    {"en":"He gave me a scoop of rice.","ko":"그는 나에게 밥 한 주걱을 주었다."}
  ]'::jsonb),
  ('grill', 1, 7, '동사', '[
    {"en":"We grilled fish for dinner.","ko":"우리는 저녁으로 생선을 구웠다."},
    {"en":"He grills meat every weekend.","ko":"그는 매주 주말마다 고기를 굽는다."},
    {"en":"She grilled some vegetables for the picnic.","ko":"그녀는 소풍을 위해 채소를 구웠다."}
  ]'::jsonb),
  ('kettle', 1, 7, '명사', '[
    {"en":"She boiled water in the kettle.","ko":"그녀는 주전자에 물을 끓였다."},
    {"en":"The kettle is on the stove.","ko":"주전자가 가스레인지 위에 있다."},
    {"en":"He filled the kettle with water.","ko":"그는 주전자에 물을 채웠다."}
  ]'::jsonb),
  ('opener', 1, 7, '명사', '[
    {"en":"She used an opener to open the can.","ko":"그녀는 따개로 캔을 열었다."},
    {"en":"The opener is in the drawer.","ko":"따개는 서랍 안에 있다."},
    {"en":"He looked for the opener in the kitchen.","ko":"그는 부엌에서 따개를 찾았다."}
  ]'::jsonb),
  ('cabinet', 1, 7, '명사', '[
    {"en":"The cups are in the cabinet.","ko":"컵들은 찬장 안에 있다."},
    {"en":"She put the plates in the cabinet.","ko":"그녀는 접시를 찬장에 넣었다."},
    {"en":"He opened the cabinet to find a bowl.","ko":"그는 그릇을 찾으려고 찬장을 열었다."}
  ]'::jsonb),
  ('recipe', 1, 7, '명사', '[
    {"en":"She followed the recipe carefully.","ko":"그녀는 요리법을 주의 깊게 따랐다."},
    {"en":"This recipe needs three eggs.","ko":"이 요리법에는 달걀 세 개가 필요하다."},
    {"en":"He found a new recipe online.","ko":"그는 인터넷에서 새로운 요리법을 찾았다."}
  ]'::jsonb),
  ('blender', 1, 7, '명사', '[
    {"en":"She made juice with a blender.","ko":"그녀는 믹서기로 주스를 만들었다."},
    {"en":"The blender is very loud.","ko":"그 믹서기는 매우 시끄럽다."},
    {"en":"He used a blender to mix the fruit.","ko":"그는 믹서기로 과일을 섞었다."}
  ]'::jsonb),
  ('be used for', 1, 7, '동사구', '[
    {"en":"This knife is used for cutting bread.","ko":"이 칼은 빵을 자르는 데 사용된다."},
    {"en":"A blender is used for making juice.","ko":"믹서기는 주스를 만드는 데 사용된다."},
    {"en":"This tool is used for opening cans.","ko":"이 도구는 캔을 여는 데 사용된다."}
  ]'::jsonb),
  ('keep on ~ing', 1, 7, '동사구', '[
    {"en":"She kept on cooking even though she was tired.","ko":"그녀는 피곤했지만 계속 요리했다."},
    {"en":"He kept on practicing the piano.","ko":"그는 계속 피아노를 연습했다."},
    {"en":"We kept on walking until we reached home.","ko":"우리는 집에 도착할 때까지 계속 걸었다."}
  ]'::jsonb),
  ('garden', 1, 8, '명사/동사', '[
    {"en":"My grandmother has a beautiful garden.","ko":"우리 할머니는 아름다운 정원을 가지고 계신다."},
    {"en":"We planted flowers in the garden.","ko":"우리는 정원에 꽃을 심었다."},
    {"en":"He gardens every weekend.","ko":"그는 매주 주말 정원을 가꾼다."}
  ]'::jsonb),
  ('apartment', 1, 8, '명사', '[
    {"en":"They live in a small apartment.","ko":"그들은 작은 아파트에 산다."},
    {"en":"Our apartment is on the fifth floor.","ko":"우리 아파트는 5층에 있다."},
    {"en":"She moved into a new apartment.","ko":"그녀는 새 아파트로 이사했다."}
  ]'::jsonb),
  ('yard', 1, 8, '명사', '[
    {"en":"The children are playing in the yard.","ko":"아이들이 마당에서 놀고 있다."},
    {"en":"We have a big yard behind our house.","ko":"우리 집 뒤에는 큰 마당이 있다."},
    {"en":"He cleaned the yard this morning.","ko":"그는 오늘 아침 마당을 청소했다."}
  ]'::jsonb),
  ('knock', 1, 8, '동사', '[
    {"en":"Someone knocked on the door.","ko":"누군가 문을 두드렸다."},
    {"en":"Please knock before you enter.","ko":"들어오기 전에 노크해 주세요."},
    {"en":"She knocked softly on the window.","ko":"그녀는 창문을 부드럽게 두드렸다."}
  ]'::jsonb),
  ('soap', 1, 8, '명사', '[
    {"en":"Wash your hands with soap.","ko":"비누로 손을 씻어라."},
    {"en":"The soap smells like lemon.","ko":"그 비누는 레몬 향이 난다."},
    {"en":"We bought some new soap yesterday.","ko":"우리는 어제 새 비누를 샀다."}
  ]'::jsonb),
  ('towel', 1, 8, '명사', '[
    {"en":"She dried her hands with a towel.","ko":"그녀는 수건으로 손을 닦았다."},
    {"en":"The towel is hanging in the bathroom.","ko":"수건은 욕실에 걸려 있다."},
    {"en":"He used a clean towel after his shower.","ko":"그는 샤워 후 깨끗한 수건을 사용했다."}
  ]'::jsonb),
  ('curtain', 1, 8, '명사', '[
    {"en":"She opened the curtain in the morning.","ko":"그녀는 아침에 커튼을 열었다."},
    {"en":"The curtain is blue and white.","ko":"그 커튼은 파란색과 흰색이다."},
    {"en":"He closed the curtain before bed.","ko":"그는 자기 전에 커튼을 닫았다."}
  ]'::jsonb),
  ('mirror', 1, 8, '명사', '[
    {"en":"She looked at herself in the mirror.","ko":"그녀는 거울로 자신을 보았다."},
    {"en":"There is a big mirror in the bedroom.","ko":"침실에 큰 거울이 있다."},
    {"en":"He hung a new mirror on the wall.","ko":"그는 벽에 새 거울을 걸었다."}
  ]'::jsonb),
  ('neighbor', 1, 8, '명사', '[
    {"en":"Our neighbor is very kind.","ko":"우리 이웃은 매우 친절하다."},
    {"en":"I said hello to my neighbor.","ko":"나는 이웃에게 인사했다."},
    {"en":"They helped their neighbor move furniture.","ko":"그들은 이웃이 가구 옮기는 것을 도왔다."}
  ]'::jsonb),
  ('gate', 1, 8, '명사', '[
    {"en":"He opened the gate slowly.","ko":"그는 문을 천천히 열었다."},
    {"en":"The gate to the garden was locked.","ko":"정원으로 가는 문은 잠겨 있었다."},
    {"en":"She closed the gate behind her.","ko":"그녀는 뒤에서 문을 닫았다."}
  ]'::jsonb),
  ('bedroom', 1, 8, '명사', '[
    {"en":"My bedroom is upstairs.","ko":"내 침실은 위층에 있다."},
    {"en":"She cleaned her bedroom yesterday.","ko":"그녀는 어제 침실을 청소했다."},
    {"en":"There is a big bed in his bedroom.","ko":"그의 침실에는 큰 침대가 있다."}
  ]'::jsonb),
  ('roof', 1, 8, '명사', '[
    {"en":"Snow covered the roof of the house.","ko":"눈이 집 지붕을 덮었다."},
    {"en":"A bird landed on the roof.","ko":"새 한 마리가 지붕에 앉았다."},
    {"en":"They fixed the roof last week.","ko":"그들은 지난주에 지붕을 고쳤다."}
  ]'::jsonb),
  ('garage', 1, 8, '명사', '[
    {"en":"The car is parked in the garage.","ko":"차가 차고에 주차되어 있다."},
    {"en":"He keeps his bicycle in the garage.","ko":"그는 자전거를 차고에 보관한다."},
    {"en":"They cleaned the garage on Saturday.","ko":"그들은 토요일에 차고를 청소했다."}
  ]'::jsonb),
  ('laundry', 1, 8, '명사', '[
    {"en":"She is doing the laundry now.","ko":"그녀는 지금 세탁하고 있다."},
    {"en":"The laundry is hanging outside.","ko":"세탁물이 밖에 널려 있다."},
    {"en":"He put the laundry in the basket.","ko":"그는 세탁물을 바구니에 넣었다."}
  ]'::jsonb),
  ('water', 1, 8, '명사/동사', '[
    {"en":"She waters the flowers every morning.","ko":"그녀는 매일 아침 꽃에 물을 준다."},
    {"en":"Please drink more water every day.","ko":"매일 물을 더 많이 마셔라."},
    {"en":"He watered the garden after school.","ko":"그는 방과 후 정원에 물을 주었다."}
  ]'::jsonb),
  ('lawn', 1, 8, '명사', '[
    {"en":"He is cutting the lawn now.","ko":"그는 지금 잔디를 깎고 있다."},
    {"en":"The children are playing on the lawn.","ko":"아이들이 잔디밭에서 놀고 있다."},
    {"en":"We water the lawn every evening.","ko":"우리는 매일 저녁 잔디밭에 물을 준다."}
  ]'::jsonb),
  ('floor', 1, 8, '명사', '[
    {"en":"The toys are all over the floor.","ko":"장난감이 바닥 여기저기에 있다."},
    {"en":"She cleaned the floor of her room.","ko":"그녀는 자기 방 바닥을 청소했다."},
    {"en":"Our classroom is on the third floor.","ko":"우리 교실은 3층에 있다."}
  ]'::jsonb),
  ('feed', 1, 8, '동사', '[
    {"en":"She feeds her dog every morning.","ko":"그녀는 매일 아침 개에게 먹이를 준다."},
    {"en":"He fed the birds in the park.","ko":"그는 공원에서 새들에게 먹이를 주었다."},
    {"en":"We feed the fish once a day.","ko":"우리는 하루에 한 번 물고기에게 먹이를 준다."}
  ]'::jsonb),
  ('bathroom', 1, 8, '명사', '[
    {"en":"The bathroom is next to the kitchen.","ko":"욕실은 부엌 옆에 있다."},
    {"en":"She cleaned the bathroom this morning.","ko":"그녀는 오늘 아침 욕실을 청소했다."},
    {"en":"He is taking a shower in the bathroom.","ko":"그는 욕실에서 샤워를 하고 있다."}
  ]'::jsonb),
  ('ceiling', 1, 8, '명사', '[
    {"en":"There is a lamp on the ceiling.","ko":"천장에 램프가 하나 있다."},
    {"en":"The ceiling of the hall is very high.","ko":"강당의 천장은 매우 높다."},
    {"en":"He painted the ceiling white.","ko":"그는 천장을 하얗게 칠했다."}
  ]'::jsonb),
  ('shelf', 1, 8, '명사', '[
    {"en":"She put the books on the shelf.","ko":"그녀는 책을 선반에 놓았다."},
    {"en":"The shelf is full of toys.","ko":"선반은 장난감으로 가득하다."},
    {"en":"He built a new shelf for his room.","ko":"그는 자기 방에 새 선반을 만들었다."}
  ]'::jsonb),
  ('drawer', 1, 8, '명사', '[
    {"en":"She kept her socks in the drawer.","ko":"그녀는 양말을 서랍에 보관했다."},
    {"en":"He opened the drawer to find a pen.","ko":"그는 펜을 찾으려고 서랍을 열었다."},
    {"en":"The drawer under the desk is empty.","ko":"책상 아래 서랍은 비어 있다."}
  ]'::jsonb),
  ('lamp', 1, 8, '명사', '[
    {"en":"She turned on the lamp to read.","ko":"그녀는 책을 읽으려고 램프를 켰다."},
    {"en":"The lamp on the desk is bright.","ko":"책상 위의 램프는 밝다."},
    {"en":"He bought a new lamp for his room.","ko":"그는 자기 방을 위해 새 램프를 샀다."}
  ]'::jsonb),
  ('sheet', 1, 8, '명사', '[
    {"en":"She changed the sheet on the bed.","ko":"그녀는 침대 시트를 갈았다."},
    {"en":"The sheet was very soft and clean.","ko":"그 시트는 매우 부드럽고 깨끗했다."},
    {"en":"He put a new sheet on his bed.","ko":"그는 침대에 새 시트를 깔았다."}
  ]'::jsonb),
  ('stair', 1, 8, '명사', '[
    {"en":"She walked up the stairs slowly.","ko":"그녀는 계단을 천천히 올라갔다."},
    {"en":"Be careful on the stairs.","ko":"계단에서 조심해라."},
    {"en":"He ran down the stairs quickly.","ko":"그는 계단을 빠르게 뛰어 내려갔다."}
  ]'::jsonb),
  ('scale', 1, 8, '명사', '[
    {"en":"He stepped on the scale this morning.","ko":"그는 오늘 아침 체중계에 올라섰다."},
    {"en":"The scale showed her exact weight.","ko":"체중계는 그녀의 정확한 몸무게를 보여주었다."},
    {"en":"We keep the scale in the bathroom.","ko":"우리는 체중계를 욕실에 둔다."}
  ]'::jsonb),
  ('sink', 1, 8, '명사', '[
    {"en":"She washed the dishes in the sink.","ko":"그녀는 싱크대에서 설거지를 했다."},
    {"en":"The sink in the kitchen is new.","ko":"부엌의 싱크대는 새것이다."},
    {"en":"He put the dirty plates in the sink.","ko":"그는 더러운 접시를 싱크대에 넣었다."}
  ]'::jsonb),
  ('tap', 1, 8, '명사', '[
    {"en":"Turn off the tap after washing your hands.","ko":"손을 씻은 후 수도꼭지를 잠가라."},
    {"en":"Water came out of the tap.","ko":"수도꼭지에서 물이 나왔다."},
    {"en":"The tap in the bathroom is broken.","ko":"욕실의 수도꼭지가 고장 났다."}
  ]'::jsonb),
  ('turn on', 1, 8, '동사구', '[
    {"en":"She turned on the light in the room.","ko":"그녀는 방의 불을 켰다."},
    {"en":"He turned on the TV after dinner.","ko":"그는 저녁 식사 후 텔레비전을 켰다."},
    {"en":"Can you turn on the fan, please?","ko":"선풍기를 켜 주시겠어요?"}
  ]'::jsonb),
  ('in place', 1, 8, '부사구', '[
    {"en":"Everything in the kitchen is in place.","ko":"부엌의 모든 것이 제자리에 있다."},
    {"en":"Please put the books back in place.","ko":"책을 제자리에 다시 놓아라."},
    {"en":"The furniture stayed in place after the move.","ko":"이사 후에도 가구는 제자리에 있었다."}
  ]'::jsonb),
  ('park', 1, 9, '동사/명사', '[
    {"en":"He parked the car in front of the house.","ko":"그는 집 앞에 차를 주차했다."},
    {"en":"We walked to the park near school.","ko":"우리는 학교 근처 공원까지 걸어갔다."},
    {"en":"You cannot park here.","ko":"여기에 주차할 수 없다."}
  ]'::jsonb),
  ('stop', 1, 9, '명사/동사', '[
    {"en":"The bus stop is near my house.","ko":"버스 정류장은 우리 집 근처에 있다."},
    {"en":"The car stopped at the traffic light.","ko":"차가 신호등에서 멈췄다."},
    {"en":"Please stop talking during class.","ko":"수업 중에는 이야기하지 말아라."}
  ]'::jsonb),
  ('drive', 1, 9, '동사', '[
    {"en":"My father drives me to school every day.","ko":"아빠는 매일 나를 학교에 태워다 주신다."},
    {"en":"She learned how to drive last year.","ko":"그녀는 작년에 운전하는 법을 배웠다."},
    {"en":"He drives carefully in the rain.","ko":"그는 비 올 때 조심스럽게 운전한다."}
  ]'::jsonb),
  ('subway', 1, 9, '명사', '[
    {"en":"We took the subway to the museum.","ko":"우리는 박물관까지 지하철을 탔다."},
    {"en":"The subway station is very crowded.","ko":"지하철역은 매우 붐빈다."},
    {"en":"She goes to school by subway.","ko":"그녀는 지하철로 학교에 간다."}
  ]'::jsonb),
  ('seat', 1, 9, '명사', '[
    {"en":"Please take a seat.","ko":"자리에 앉으세요."},
    {"en":"He gave his seat to an old man.","ko":"그는 노인에게 자리를 양보했다."},
    {"en":"The seat next to the window is empty.","ko":"창가 자리는 비어 있다."}
  ]'::jsonb),
  ('road', 1, 9, '명사', '[
    {"en":"Be careful when you cross the road.","ko":"길을 건널 때 조심해라."},
    {"en":"The road to school is very busy.","ko":"학교로 가는 길은 매우 붐빈다."},
    {"en":"There are many cars on the road.","ko":"도로에 차가 많다."}
  ]'::jsonb),
  ('fare', 1, 9, '명사', '[
    {"en":"The bus fare is one thousand won.","ko":"버스 요금은 천 원이다."},
    {"en":"She paid the subway fare with her card.","ko":"그녀는 카드로 지하철 요금을 냈다."},
    {"en":"How much is the fare to the airport?","ko":"공항까지 요금이 얼마인가요?"}
  ]'::jsonb),
  ('bicycle', 1, 9, '명사', '[
    {"en":"He rides his bicycle to school.","ko":"그는 자전거를 타고 학교에 간다."},
    {"en":"She got a new bicycle for her birthday.","ko":"그녀는 생일에 새 자전거를 받았다."},
    {"en":"We rode our bicycles in the park.","ko":"우리는 공원에서 자전거를 탔다."}
  ]'::jsonb),
  ('limit', 1, 9, '명사/동사', '[
    {"en":"The speed limit on this road is sixty.","ko":"이 도로의 제한 속도는 60이다."},
    {"en":"You should limit the time on your phone.","ko":"너는 휴대폰 사용 시간을 제한해야 한다."},
    {"en":"There is a limit to how many books you can borrow.","ko":"빌릴 수 있는 책의 수에는 제한이 있다."}
  ]'::jsonb),
  ('route', 1, 9, '명사', '[
    {"en":"We took a different route to school.","ko":"우리는 학교까지 다른 길로 갔다."},
    {"en":"This bus route goes through the city center.","ko":"이 버스 노선은 시내 중심을 지나간다."},
    {"en":"He knows the shortest route home.","ko":"그는 집으로 가는 가장 짧은 길을 안다."}
  ]'::jsonb),
  ('cross', 1, 9, '동사', '[
    {"en":"Look both ways before you cross the street.","ko":"길을 건너기 전에 양쪽을 살펴라."},
    {"en":"We crossed the bridge together.","ko":"우리는 함께 다리를 건넜다."},
    {"en":"She crossed the road at the crosswalk.","ko":"그녀는 횡단보도에서 길을 건넜다."}
  ]'::jsonb),
  ('track', 1, 9, '명사', '[
    {"en":"The train runs on the track.","ko":"기차는 선로 위를 달린다."},
    {"en":"Do not stand near the track.","ko":"선로 근처에 서 있지 마라."},
    {"en":"The runners ran around the track.","ko":"주자들은 트랙을 돌며 달렸다."}
  ]'::jsonb),
  ('rail', 1, 9, '명사', '[
    {"en":"The train moves along the rail.","ko":"기차는 철로를 따라 움직인다."},
    {"en":"The rail was wet after the rain.","ko":"비가 온 후 철로가 젖어 있었다."},
    {"en":"Workers repaired the broken rail.","ko":"인부들이 부서진 철로를 수리했다."}
  ]'::jsonb),
  ('curve', 1, 9, '명사/동사', '[
    {"en":"The road has a sharp curve ahead.","ko":"앞쪽에 도로가 급하게 굽어 있다."},
    {"en":"The car slowed down at the curve.","ko":"차는 커브 길에서 속도를 줄였다."},
    {"en":"The path curves near the river.","ko":"그 길은 강 근처에서 구부러진다."}
  ]'::jsonb),
  ('sign', 1, 9, '명사/동사', '[
    {"en":"The sign says \"No Parking\".","ko":"표지판에는 \"주차 금지\"라고 쓰여 있다."},
    {"en":"She signed her name on the paper.","ko":"그녀는 종이에 이름을 서명했다."},
    {"en":"He read the traffic sign carefully.","ko":"그는 교통 표지판을 주의 깊게 읽었다."}
  ]'::jsonb),
  ('station', 1, 9, '명사', '[
    {"en":"We waited for the train at the station.","ko":"우리는 역에서 기차를 기다렸다."},
    {"en":"The bus station is near my house.","ko":"버스 정류장은 우리 집 근처에 있다."},
    {"en":"She met her friend at the station.","ko":"그녀는 역에서 친구를 만났다."}
  ]'::jsonb),
  ('wheel', 1, 9, '명사', '[
    {"en":"The wheel of the bicycle is broken.","ko":"자전거 바퀴가 고장 났다."},
    {"en":"He checked the car''s wheels before driving.","ko":"그는 운전하기 전에 자동차 바퀴를 확인했다."},
    {"en":"The wheel turned quickly.","ko":"바퀴가 빠르게 돌았다."}
  ]'::jsonb),
  ('license', 1, 9, '명사', '[
    {"en":"My brother got his driver''s license last month.","ko":"우리 형은 지난달에 운전면허를 땄다."},
    {"en":"You need a license to drive a car.","ko":"자동차를 운전하려면 면허증이 필요하다."},
    {"en":"She showed her license to the officer.","ko":"그녀는 경찰관에게 면허증을 보여주었다."}
  ]'::jsonb),
  ('accident', 1, 9, '명사', '[
    {"en":"There was a car accident on the road.","ko":"도로에서 자동차 사고가 있었다."},
    {"en":"He was not hurt in the accident.","ko":"그는 사고에서 다치지 않았다."},
    {"en":"Drive carefully to avoid an accident.","ko":"사고를 피하려면 조심스럽게 운전해라."}
  ]'::jsonb),
  ('traffic', 1, 9, '명사/형용사', '[
    {"en":"The traffic was heavy this morning.","ko":"오늘 아침 교통이 혼잡했다."},
    {"en":"We waited for the traffic light to change.","ko":"우리는 신호등이 바뀌기를 기다렸다."},
    {"en":"There is a lot of traffic on this street.","ko":"이 거리에는 차가 많다."}
  ]'::jsonb),
  ('forward', 1, 9, '부사', '[
    {"en":"She looked forward and smiled.","ko":"그녀는 앞을 보며 미소 지었다."},
    {"en":"The car moved forward slowly.","ko":"차가 천천히 앞으로 움직였다."},
    {"en":"Please step forward one by one.","ko":"한 명씩 앞으로 나와 주세요."}
  ]'::jsonb),
  ('transfer', 1, 9, '동사', '[
    {"en":"You need to transfer to another bus.","ko":"너는 다른 버스로 환승해야 한다."},
    {"en":"She transferred to a new school.","ko":"그녀는 새 학교로 전학했다."},
    {"en":"We transferred from the subway to a bus.","ko":"우리는 지하철에서 버스로 환승했다."}
  ]'::jsonb),
  ('passenger', 1, 9, '명사', '[
    {"en":"The bus was full of passengers.","ko":"버스는 승객들로 가득했다."},
    {"en":"All passengers must wear seat belts.","ko":"모든 승객은 안전벨트를 매야 한다."},
    {"en":"The passenger asked the driver a question.","ko":"승객이 기사에게 질문을 했다."}
  ]'::jsonb),
  ('harbor', 1, 9, '명사', '[
    {"en":"The ship arrived at the harbor.","ko":"배가 항구에 도착했다."},
    {"en":"We watched the boats in the harbor.","ko":"우리는 항구에서 배들을 구경했다."},
    {"en":"Fishermen work near the harbor.","ko":"어부들은 항구 근처에서 일한다."}
  ]'::jsonb),
  ('gas', 1, 9, '명사', '[
    {"en":"We need to buy some gas for the car.","ko":"우리는 자동차를 위한 휘발유를 사야 한다."},
    {"en":"The car ran out of gas.","ko":"차의 휘발유가 다 떨어졌다."},
    {"en":"He stopped at the gas station.","ko":"그는 주유소에 멈췄다."}
  ]'::jsonb),
  ('platform', 1, 9, '명사', '[
    {"en":"We waited on the platform for the train.","ko":"우리는 플랫폼에서 기차를 기다렸다."},
    {"en":"The train arrived at platform two.","ko":"기차가 2번 플랫폼에 도착했다."},
    {"en":"Many people stood on the platform.","ko":"많은 사람들이 승강장에 서 있었다."}
  ]'::jsonb),
  ('transport', 1, 9, '동사', '[
    {"en":"Trucks transport goods to the store.","ko":"트럭이 상점으로 물건을 운송한다."},
    {"en":"The train transports many passengers every day.","ko":"기차는 매일 많은 승객을 수송한다."},
    {"en":"They transported the boxes by ship.","ko":"그들은 배로 상자들을 운송했다."}
  ]'::jsonb),
  ('crash', 1, 9, '명사/동사', '[
    {"en":"There was a big crash on the highway.","ko":"고속도로에서 큰 충돌 사고가 있었다."},
    {"en":"The two cars crashed into each other.","ko":"두 차가 서로 충돌했다."},
    {"en":"No one was hurt in the crash.","ko":"그 충돌 사고에서 아무도 다치지 않았다."}
  ]'::jsonb),
  ('get on', 1, 9, '동사구', '[
    {"en":"We got on the bus at the station.","ko":"우리는 역에서 버스에 탔다."},
    {"en":"She got on her bicycle and rode away.","ko":"그녀는 자전거에 올라타고 떠났다."},
    {"en":"Please get on the train quickly.","ko":"빨리 기차에 타 주세요."}
  ]'::jsonb),
  ('on foot', 1, 9, '부사구', '[
    {"en":"He goes to school on foot.","ko":"그는 걸어서 학교에 간다."},
    {"en":"We traveled around the town on foot.","ko":"우리는 걸어서 마을을 돌아다녔다."},
    {"en":"It takes ten minutes to get there on foot.","ko":"그곳까지 걸어서 10분이 걸린다."}
  ]'::jsonb),
  ('glue', 1, 10, '명사/동사', '[
    {"en":"She used glue to fix the paper.","ko":"그녀는 풀을 사용해서 종이를 고쳤다."},
    {"en":"He glued the pieces together.","ko":"그는 조각들을 풀로 붙였다."},
    {"en":"The glue is on the desk.","ko":"풀은 책상 위에 있다."}
  ]'::jsonb),
  ('scissors', 1, 10, '명사', '[
    {"en":"She cut the paper with scissors.","ko":"그녀는 가위로 종이를 잘랐다."},
    {"en":"The scissors are sharp, so be careful.","ko":"가위가 날카로우니 조심해라."},
    {"en":"He used scissors to open the bag.","ko":"그는 가위로 봉지를 열었다."}
  ]'::jsonb),
  ('eraser', 1, 10, '명사', '[
    {"en":"Can I borrow your eraser?","ko":"네 지우개를 빌릴 수 있을까?"},
    {"en":"She erased the mistake with an eraser.","ko":"그녀는 지우개로 실수를 지웠다."},
    {"en":"I lost my eraser this morning.","ko":"나는 오늘 아침 지우개를 잃어버렸다."}
  ]'::jsonb),
  ('desk', 1, 10, '명사', '[
    {"en":"He put his books on the desk.","ko":"그는 책을 책상 위에 놓았다."},
    {"en":"My desk is next to the window.","ko":"내 책상은 창문 옆에 있다."},
    {"en":"She cleaned her desk before studying.","ko":"그녀는 공부하기 전에 책상을 정리했다."}
  ]'::jsonb),
  ('chair', 1, 10, '명사', '[
    {"en":"She sat on a comfortable chair.","ko":"그녀는 편안한 의자에 앉았다."},
    {"en":"There are five chairs in the room.","ko":"방에는 의자가 다섯 개 있다."},
    {"en":"He moved the chair closer to the desk.","ko":"그는 의자를 책상 쪽으로 옮겼다."}
  ]'::jsonb),
  ('room', 1, 10, '명사', '[
    {"en":"This room is very bright.","ko":"이 방은 매우 밝다."},
    {"en":"She cleaned her room yesterday.","ko":"그녀는 어제 자기 방을 청소했다."},
    {"en":"We have a meeting in this room.","ko":"우리는 이 방에서 회의를 한다."}
  ]'::jsonb),
  ('company', 1, 10, '명사', '[
    {"en":"My father works for a big company.","ko":"아빠는 큰 회사에서 일하신다."},
    {"en":"She started her own company.","ko":"그녀는 자신의 회사를 시작했다."},
    {"en":"The company hired many new workers.","ko":"그 회사는 많은 신입 직원을 고용했다."}
  ]'::jsonb),
  ('interview', 1, 10, '명사/동사', '[
    {"en":"She had a job interview yesterday.","ko":"그녀는 어제 취업 면접을 봤다."},
    {"en":"The reporter interviewed the scientist.","ko":"기자가 그 과학자를 인터뷰했다."},
    {"en":"He was nervous before the interview.","ko":"그는 면접 전에 긴장했다."}
  ]'::jsonb),
  ('calendar', 1, 10, '명사', '[
    {"en":"She wrote the date on the calendar.","ko":"그녀는 달력에 날짜를 적었다."},
    {"en":"The calendar on the wall is new.","ko":"벽에 걸린 달력은 새것이다."},
    {"en":"He checked the calendar for the meeting date.","ko":"그는 회의 날짜를 확인하려고 달력을 봤다."}
  ]'::jsonb),
  ('printer', 1, 10, '명사', '[
    {"en":"The printer is out of paper.","ko":"프린터에 종이가 없다."},
    {"en":"She printed the document on the printer.","ko":"그녀는 프린터로 문서를 출력했다."},
    {"en":"He bought a new printer for his office.","ko":"그는 사무실을 위해 새 프린터를 샀다."}
  ]'::jsonb),
  ('envelope', 1, 10, '명사', '[
    {"en":"She put the letter in an envelope.","ko":"그녀는 편지를 봉투에 넣었다."},
    {"en":"He wrote the address on the envelope.","ko":"그는 봉투에 주소를 적었다."},
    {"en":"The envelope was sealed carefully.","ko":"봉투는 조심스럽게 봉해졌다."}
  ]'::jsonb),
  ('folder', 1, 10, '명사', '[
    {"en":"She kept her papers in a folder.","ko":"그녀는 서류를 폴더에 보관했다."},
    {"en":"He organized the files into folders.","ko":"그는 파일들을 폴더별로 정리했다."},
    {"en":"The folder is on the desk.","ko":"폴더는 책상 위에 있다."}
  ]'::jsonb),
  ('call', 1, 10, '명사/동사', '[
    {"en":"She gave me a call last night.","ko":"그녀는 어젯밤 나에게 전화했다."},
    {"en":"He called his mother after school.","ko":"그는 방과 후 엄마에게 전화했다."},
    {"en":"I received an important call this morning.","ko":"나는 오늘 아침 중요한 전화를 받았다."}
  ]'::jsonb),
  ('letter', 1, 10, '명사', '[
    {"en":"She wrote a letter to her friend.","ko":"그녀는 친구에게 편지를 썼다."},
    {"en":"He received a letter from his grandmother.","ko":"그는 할머니로부터 편지를 받았다."},
    {"en":"The letter arrived yesterday.","ko":"그 편지는 어제 도착했다."}
  ]'::jsonb),
  ('seal', 1, 10, '명사/동사', '[
    {"en":"He sealed the envelope carefully.","ko":"그는 조심스럽게 봉투를 봉했다."},
    {"en":"The letter had an official seal on it.","ko":"그 편지에는 공식 도장이 찍혀 있었다."},
    {"en":"She sealed the box with tape.","ko":"그녀는 테이프로 상자를 봉했다."}
  ]'::jsonb),
  ('clip', 1, 10, '명사/동사', '[
    {"en":"She clipped the papers together.","ko":"그녀는 종이들을 클립으로 고정했다."},
    {"en":"The clip fell off the desk.","ko":"클립이 책상에서 떨어졌다."},
    {"en":"He used a clip to hold the notes.","ko":"그는 메모를 고정하려고 클립을 사용했다."}
  ]'::jsonb),
  ('pin', 1, 10, '명사/동사', '[
    {"en":"She pinned the notice on the board.","ko":"그녀는 게시판에 공지를 핀으로 고정했다."},
    {"en":"He found a small pin on the floor.","ko":"그는 바닥에서 작은 핀을 찾았다."},
    {"en":"The picture was pinned to the wall.","ko":"그 사진은 벽에 핀으로 꽂혀 있었다."}
  ]'::jsonb),
  ('message', 1, 10, '명사', '[
    {"en":"She sent a message to her friend.","ko":"그녀는 친구에게 메시지를 보냈다."},
    {"en":"I left a message on his desk.","ko":"나는 그의 책상에 메모를 남겼다."},
    {"en":"He read the message carefully.","ko":"그는 메시지를 주의 깊게 읽었다."}
  ]'::jsonb),
  ('bookcase', 1, 10, '명사', '[
    {"en":"The books are on the bookcase.","ko":"책들은 책장 위에 있다."},
    {"en":"She organized her bookcase by color.","ko":"그녀는 책장을 색깔별로 정리했다."},
    {"en":"He bought a new bookcase for his room.","ko":"그는 자기 방을 위해 새 책장을 샀다."}
  ]'::jsonb),
  ('manager', 1, 10, '명사', '[
    {"en":"The manager works very hard.","ko":"그 관리자는 매우 열심히 일한다."},
    {"en":"She became a manager last year.","ko":"그녀는 작년에 관리자가 되었다."},
    {"en":"The manager checked all the reports.","ko":"관리자는 모든 보고서를 확인했다."}
  ]'::jsonb),
  ('calculator', 1, 10, '명사', '[
    {"en":"He used a calculator to solve the problem.","ko":"그는 문제를 풀려고 계산기를 사용했다."},
    {"en":"The calculator is in my pencil case.","ko":"계산기는 내 필통 안에 있다."},
    {"en":"She borrowed a calculator from her friend.","ko":"그녀는 친구에게서 계산기를 빌렸다."}
  ]'::jsonb),
  ('stationery', 1, 10, '명사', '[
    {"en":"She bought some stationery for school.","ko":"그녀는 학교를 위해 문구류를 좀 샀다."},
    {"en":"The store sells all kinds of stationery.","ko":"그 가게는 모든 종류의 문구류를 판다."},
    {"en":"He keeps his stationery in a box.","ko":"그는 문구류를 상자에 보관한다."}
  ]'::jsonb),
  ('staple', 1, 10, '동사', '[
    {"en":"She stapled the papers together.","ko":"그녀는 종이들을 스테이플러로 고정했다."},
    {"en":"He stapled the report before the meeting.","ko":"그는 회의 전에 보고서를 스테이플러로 고정했다."},
    {"en":"Please staple these pages.","ko":"이 페이지들을 스테이플러로 고정해 주세요."}
  ]'::jsonb),
  ('punch', 1, 10, '명사/동사', '[
    {"en":"She used a punch to make holes in the paper.","ko":"그녀는 펀치로 종이에 구멍을 뚫었다."},
    {"en":"He punched a hole in the paper.","ko":"그는 종이에 구멍을 뚫었다."},
    {"en":"The punch is in the top drawer.","ko":"펀치는 맨 위 서랍에 있다."}
  ]'::jsonb),
  ('highlighter', 1, 10, '명사', '[
    {"en":"She used a highlighter to mark the words.","ko":"그녀는 형광펜으로 단어들을 표시했다."},
    {"en":"The highlighter is yellow.","ko":"그 형광펜은 노란색이다."},
    {"en":"He borrowed a highlighter from his classmate.","ko":"그는 반 친구에게서 형광펜을 빌렸다."}
  ]'::jsonb),
  ('document', 1, 10, '명사', '[
    {"en":"She read the document carefully.","ko":"그녀는 문서를 주의 깊게 읽었다."},
    {"en":"The manager signed the document.","ko":"관리자가 문서에 서명했다."},
    {"en":"He printed an important document.","ko":"그는 중요한 문서를 인쇄했다."}
  ]'::jsonb),
  ('printout', 1, 10, '명사', '[
    {"en":"She gave me a printout of the report.","ko":"그녀는 나에게 보고서 출력물을 주었다."},
    {"en":"The printout has ten pages.","ko":"그 출력물은 10페이지이다."},
    {"en":"He checked the printout for mistakes.","ko":"그는 출력물에 실수가 있는지 확인했다."}
  ]'::jsonb),
  ('photocopy', 1, 10, '명사/동사', '[
    {"en":"She made a photocopy of the letter.","ko":"그녀는 편지를 복사했다."},
    {"en":"He photocopied the document for the meeting.","ko":"그는 회의를 위해 문서를 복사했다."},
    {"en":"The photocopy was very clear.","ko":"그 복사본은 매우 선명했다."}
  ]'::jsonb),
  ('deal with', 1, 10, '동사구', '[
    {"en":"She knows how to deal with problems.","ko":"그녀는 문제를 다루는 법을 안다."},
    {"en":"He dealt with the customer kindly.","ko":"그는 고객을 친절하게 대했다."},
    {"en":"We need to deal with this issue quickly.","ko":"우리는 이 문제를 빨리 처리해야 한다."}
  ]'::jsonb),
  ('fill out', 1, 10, '동사구', '[
    {"en":"Please fill out this form.","ko":"이 양식을 작성해 주세요."},
    {"en":"She filled out the application carefully.","ko":"그녀는 신청서를 주의 깊게 작성했다."},
    {"en":"He filled out the survey in five minutes.","ko":"그는 5분 만에 설문지를 작성했다."}
  ]'::jsonb),
  ('building', 1, 11, '명사', '[
    {"en":"That building is very tall.","ko":"저 건물은 매우 높다."},
    {"en":"We live in a big building.","ko":"우리는 큰 건물에 산다."},
    {"en":"The school building has five floors.","ko":"학교 건물은 5층이다."}
  ]'::jsonb),
  ('bakery', 1, 11, '명사', '[
    {"en":"She bought bread at the bakery.","ko":"그녀는 빵집에서 빵을 샀다."},
    {"en":"The bakery smells wonderful.","ko":"그 빵집은 냄새가 정말 좋다."},
    {"en":"There is a new bakery near my house.","ko":"우리 집 근처에 새 빵집이 있다."}
  ]'::jsonb),
  ('fire station', 1, 11, '명사구', '[
    {"en":"The fire station is near the school.","ko":"소방서는 학교 근처에 있다."},
    {"en":"Firefighters work at the fire station.","ko":"소방관들은 소방서에서 일한다."},
    {"en":"We visited the fire station on a field trip.","ko":"우리는 현장 학습으로 소방서를 방문했다."}
  ]'::jsonb),
  ('hospital', 1, 11, '명사', '[
    {"en":"He went to the hospital yesterday.","ko":"그는 어제 병원에 갔다."},
    {"en":"The hospital is open all day.","ko":"그 병원은 하루 종일 문을 연다."},
    {"en":"She works as a nurse at the hospital.","ko":"그녀는 병원에서 간호사로 일한다."}
  ]'::jsonb),
  ('museum', 1, 11, '명사', '[
    {"en":"We visited the museum last weekend.","ko":"우리는 지난 주말에 박물관을 방문했다."},
    {"en":"The museum has many old paintings.","ko":"그 박물관에는 오래된 그림들이 많다."},
    {"en":"Students learn history at the museum.","ko":"학생들은 박물관에서 역사를 배운다."}
  ]'::jsonb),
  ('city hall', 1, 11, '명사구', '[
    {"en":"The city hall is in the center of town.","ko":"시청은 마을 중심에 있다."},
    {"en":"My mother works at city hall.","ko":"우리 엄마는 시청에서 일하신다."},
    {"en":"We took a picture in front of city hall.","ko":"우리는 시청 앞에서 사진을 찍었다."}
  ]'::jsonb),
  ('police station', 1, 11, '명사구', '[
    {"en":"The police station is next to the park.","ko":"경찰서는 공원 옆에 있다."},
    {"en":"He reported the accident at the police station.","ko":"그는 경찰서에 사고를 신고했다."},
    {"en":"We visited the police station for a school project.","ko":"우리는 학교 과제로 경찰서를 방문했다."}
  ]'::jsonb),
  ('left', 1, 11, '명사', '[
    {"en":"Turn left at the corner.","ko":"모퉁이에서 왼쪽으로 도세요."},
    {"en":"The library is on the left.","ko":"도서관은 왼쪽에 있다."},
    {"en":"She looked to the left before crossing.","ko":"그녀는 건너기 전에 왼쪽을 보았다."}
  ]'::jsonb),
  ('trash', 1, 11, '명사', '[
    {"en":"Please put the trash in the bin.","ko":"쓰레기를 통에 넣어 주세요."},
    {"en":"He took out the trash this morning.","ko":"그는 오늘 아침 쓰레기를 내다 버렸다."},
    {"en":"The trash can is full.","ko":"쓰레기통이 가득 찼다."}
  ]'::jsonb),
  ('village', 1, 11, '명사', '[
    {"en":"They live in a small village.","ko":"그들은 작은 마을에 산다."},
    {"en":"The village is surrounded by mountains.","ko":"그 마을은 산으로 둘러싸여 있다."},
    {"en":"We visited a quiet village last summer.","ko":"우리는 지난여름 조용한 마을을 방문했다."}
  ]'::jsonb),
  ('direction', 1, 11, '명사', '[
    {"en":"He asked for directions to the station.","ko":"그는 역으로 가는 길을 물었다."},
    {"en":"She went in the wrong direction.","ko":"그녀는 잘못된 방향으로 갔다."},
    {"en":"Follow this direction to reach the park.","ko":"공원에 가려면 이 방향을 따라가라."}
  ]'::jsonb),
  ('street', 1, 11, '명사', '[
    {"en":"Our house is on a quiet street.","ko":"우리 집은 조용한 거리에 있다."},
    {"en":"There are many shops on this street.","ko":"이 거리에는 상점이 많다."},
    {"en":"She crossed the street carefully.","ko":"그녀는 조심스럽게 거리를 건넜다."}
  ]'::jsonb),
  ('avenue', 1, 11, '명사', '[
    {"en":"The store is on Main Avenue.","ko":"그 가게는 메인 애비뉴에 있다."},
    {"en":"We walked down a wide avenue.","ko":"우리는 넓은 대로를 걸어 내려갔다."},
    {"en":"Many trees grow along the avenue.","ko":"대로를 따라 나무가 많이 자란다."}
  ]'::jsonb),
  ('block', 1, 11, '명사', '[
    {"en":"The school is two blocks away.","ko":"학교는 두 블록 떨어져 있다."},
    {"en":"Walk one block and turn right.","ko":"한 블록을 걸어가서 오른쪽으로 도세요."},
    {"en":"There is a park at the end of the block.","ko":"그 블록 끝에 공원이 있다."}
  ]'::jsonb),
  ('straight', 1, 11, '형용사/부사', '[
    {"en":"Go straight until you see the bank.","ko":"은행이 보일 때까지 곧장 가세요."},
    {"en":"She drew a straight line on the paper.","ko":"그녀는 종이에 직선을 그렸다."},
    {"en":"Walk straight and then turn left.","ko":"곧장 걸어가서 왼쪽으로 도세요."}
  ]'::jsonb),
  ('corner', 1, 11, '명사', '[
    {"en":"The store is on the corner.","ko":"그 가게는 모퉁이에 있다."},
    {"en":"He waited for her at the corner.","ko":"그는 모퉁이에서 그녀를 기다렸다."},
    {"en":"Turn right at the next corner.","ko":"다음 모퉁이에서 오른쪽으로 도세요."}
  ]'::jsonb),
  ('turn', 1, 11, '명사/동사', '[
    {"en":"Take a right turn at the light.","ko":"신호등에서 오른쪽으로 도세요."},
    {"en":"She turned the corner quickly.","ko":"그녀는 모퉁이를 빠르게 돌았다."},
    {"en":"It is your turn to answer.","ko":"이제 네가 대답할 차례야."}
  ]'::jsonb),
  ('drugstore', 1, 11, '명사', '[
    {"en":"She bought medicine at the drugstore.","ko":"그녀는 약국에서 약을 샀다."},
    {"en":"The drugstore is open until nine.","ko":"그 약국은 9시까지 문을 연다."},
    {"en":"He walked to the drugstore near his house.","ko":"그는 집 근처 약국까지 걸어갔다."}
  ]'::jsonb),
  ('pedestrian', 1, 11, '명사', '[
    {"en":"The pedestrian waited for the light to change.","ko":"그 보행자는 신호가 바뀌기를 기다렸다."},
    {"en":"Drivers should be careful of pedestrians.","ko":"운전자들은 보행자를 조심해야 한다."},
    {"en":"Many pedestrians walked along the street.","ko":"많은 보행자들이 거리를 따라 걸었다."}
  ]'::jsonb),
  ('department store', 1, 11, '명사구', '[
    {"en":"We went shopping at the department store.","ko":"우리는 백화점에 쇼핑하러 갔다."},
    {"en":"The department store has many floors.","ko":"그 백화점은 층이 많다."},
    {"en":"She bought a new coat at the department store.","ko":"그녀는 백화점에서 새 코트를 샀다."}
  ]'::jsonb),
  ('sidewalk', 1, 11, '명사', '[
    {"en":"Children were playing on the sidewalk.","ko":"아이들이 인도에서 놀고 있었다."},
    {"en":"Please walk on the sidewalk, not the road.","ko":"도로가 아니라 인도로 걸어라."},
    {"en":"The sidewalk was covered with snow.","ko":"인도는 눈으로 덮여 있었다."}
  ]'::jsonb),
  ('crosswalk', 1, 11, '명사', '[
    {"en":"Cross the street at the crosswalk.","ko":"횡단보도에서 길을 건너라."},
    {"en":"She waited at the crosswalk for the light.","ko":"그녀는 횡단보도에서 신호를 기다렸다."},
    {"en":"The crosswalk is in front of the school.","ko":"횡단보도는 학교 앞에 있다."}
  ]'::jsonb),
  ('intersection', 1, 11, '명사', '[
    {"en":"The accident happened at the intersection.","ko":"그 사고는 교차로에서 일어났다."},
    {"en":"Turn left at the next intersection.","ko":"다음 교차로에서 왼쪽으로 도세요."},
    {"en":"There is a traffic light at the intersection.","ko":"교차로에는 신호등이 있다."}
  ]'::jsonb),
  ('patrol', 1, 11, '명사', '[
    {"en":"The police patrol checked the area.","ko":"경찰 순찰대가 그 지역을 점검했다."},
    {"en":"A patrol car passed by slowly.","ko":"순찰차가 천천히 지나갔다."},
    {"en":"Officers patrol the streets at night.","ko":"경찰관들은 밤에 거리를 순찰한다."}
  ]'::jsonb),
  ('signal', 1, 11, '명사', '[
    {"en":"Wait for the signal to change.","ko":"신호가 바뀌기를 기다려라."},
    {"en":"The traffic signal turned green.","ko":"신호등이 초록불로 바뀌었다."},
    {"en":"He stopped his car at the signal.","ko":"그는 신호등에서 차를 멈췄다."}
  ]'::jsonb),
  ('highway', 1, 11, '명사', '[
    {"en":"We drove on the highway to the beach.","ko":"우리는 해변까지 고속도로로 운전했다."},
    {"en":"The highway was busy this morning.","ko":"고속도로는 오늘 아침 붐볐다."},
    {"en":"There are many cars on the highway.","ko":"고속도로에는 차가 많다."}
  ]'::jsonb),
  ('sewer', 1, 11, '명사', '[
    {"en":"The rainwater flows into the sewer.","ko":"빗물은 하수구로 흘러들어간다."},
    {"en":"Workers repaired the broken sewer.","ko":"인부들이 고장 난 하수구를 고쳤다."},
    {"en":"The sewer under the street was blocked.","ko":"거리 아래 하수구가 막혔다."}
  ]'::jsonb),
  ('give ~ a ride', 1, 11, '동사구', '[
    {"en":"My father gave me a ride to school.","ko":"아빠가 나를 학교까지 태워다 주셨다."},
    {"en":"Can you give her a ride home?","ko":"그녀를 집까지 태워다 줄 수 있니?"},
    {"en":"He gave his friend a ride to the station.","ko":"그는 친구를 역까지 태워다 주었다."}
  ]'::jsonb),
  ('be known for', 1, 11, '동사구', '[
    {"en":"This town is known for its beautiful park.","ko":"이 마을은 아름다운 공원으로 유명하다."},
    {"en":"She is known for her kindness.","ko":"그녀는 친절함으로 알려져 있다."},
    {"en":"The city is known for its old buildings.","ko":"그 도시는 오래된 건물들로 유명하다."}
  ]'::jsonb),
  ('in the middle of', 1, 11, '부사구', '[
    {"en":"The fountain is in the middle of the square.","ko":"분수는 광장 한가운데에 있다."},
    {"en":"He stopped in the middle of the street.","ko":"그는 거리 한가운데에서 멈췄다."},
    {"en":"She was in the middle of cooking dinner.","ko":"그녀는 저녁을 요리하는 도중이었다."}
  ]'::jsonb),
  ('iron', 1, 12, '명사/동사', '[
    {"en":"She irons her shirt every morning.","ko":"그녀는 매일 아침 셔츠를 다린다."},
    {"en":"The iron is very hot.","ko":"다리미가 매우 뜨겁다."},
    {"en":"He ironed his uniform before school.","ko":"그는 학교에 가기 전에 교복을 다렸다."}
  ]'::jsonb),
  ('lift', 1, 12, '동사', '[
    {"en":"He lifted the heavy box carefully.","ko":"그는 무거운 상자를 조심스럽게 들어올렸다."},
    {"en":"She lifted her bag onto the desk.","ko":"그녀는 가방을 책상 위로 들어올렸다."},
    {"en":"Can you lift this table with me?","ko":"나와 함께 이 탁자를 들어줄 수 있니?"}
  ]'::jsonb),
  ('wash', 1, 12, '명사/동사', '[
    {"en":"She washes the dishes after dinner.","ko":"그녀는 저녁 식사 후 설거지를 한다."},
    {"en":"He washed his hands before eating.","ko":"그는 먹기 전에 손을 씻었다."},
    {"en":"I need to do the wash today.","ko":"나는 오늘 빨래를 해야 한다."}
  ]'::jsonb),
  ('mop', 1, 12, '명사/동사', '[
    {"en":"She mopped the kitchen floor.","ko":"그녀는 부엌 바닥을 대걸레로 닦았다."},
    {"en":"He used a mop to clean the hallway.","ko":"그는 대걸레로 복도를 청소했다."},
    {"en":"The mop is in the closet.","ko":"대걸레는 벽장 안에 있다."}
  ]'::jsonb),
  ('daily', 1, 12, '형용사', '[
    {"en":"Reading is part of my daily routine.","ko":"독서는 나의 일상 습관의 일부이다."},
    {"en":"She writes in her daily diary.","ko":"그녀는 매일 일기를 쓴다."},
    {"en":"We do daily exercise after school.","ko":"우리는 방과 후 매일 운동을 한다."}
  ]'::jsonb),
  ('hang', 1, 12, '동사', '[
    {"en":"She hung her coat on the hook.","ko":"그녀는 옷걸이에 코트를 걸었다."},
    {"en":"He hangs the picture on the wall.","ko":"그는 벽에 그림을 건다."},
    {"en":"The towels are hanging in the bathroom.","ko":"수건들은 욕실에 걸려 있다."}
  ]'::jsonb),
  ('hammer', 1, 12, '명사', '[
    {"en":"He used a hammer to fix the chair.","ko":"그는 망치로 의자를 고쳤다."},
    {"en":"The hammer is heavy.","ko":"그 망치는 무겁다."},
    {"en":"She borrowed a hammer from her neighbor.","ko":"그녀는 이웃에게서 망치를 빌렸다."}
  ]'::jsonb),
  ('switch', 1, 12, '명사', '[
    {"en":"She turned off the switch before leaving.","ko":"그녀는 나가기 전에 스위치를 껐다."},
    {"en":"The light switch is on the wall.","ko":"전등 스위치는 벽에 있다."},
    {"en":"He pressed the switch to turn on the fan.","ko":"그는 선풍기를 켜려고 스위치를 눌렀다."}
  ]'::jsonb),
  ('dust', 1, 12, '명사/동사', '[
    {"en":"She dusted the shelves this morning.","ko":"그녀는 오늘 아침 선반의 먼지를 털었다."},
    {"en":"There is a lot of dust on the table.","ko":"탁자 위에 먼지가 많다."},
    {"en":"He dusts his room every weekend.","ko":"그는 매주 주말 자기 방의 먼지를 턴다."}
  ]'::jsonb),
  ('ladder', 1, 12, '명사', '[
    {"en":"He climbed the ladder to fix the roof.","ko":"그는 지붕을 고치려고 사다리를 올라갔다."},
    {"en":"The ladder is leaning against the wall.","ko":"사다리가 벽에 기대어 있다."},
    {"en":"Be careful when you use the ladder.","ko":"사다리를 사용할 때 조심해라."}
  ]'::jsonb),
  ('carry', 1, 12, '동사', '[
    {"en":"She carried the bag to school.","ko":"그녀는 가방을 학교까지 들고 갔다."},
    {"en":"He carries his lunch box every day.","ko":"그는 매일 도시락을 들고 다닌다."},
    {"en":"Can you carry this box for me?","ko":"이 상자를 나 대신 들어줄 수 있니?"}
  ]'::jsonb),
  ('tool', 1, 12, '명사', '[
    {"en":"He keeps his tools in the garage.","ko":"그는 도구를 차고에 보관한다."},
    {"en":"A hammer is a useful tool.","ko":"망치는 유용한 도구이다."},
    {"en":"She used the right tool for the job.","ko":"그녀는 그 일에 맞는 도구를 사용했다."}
  ]'::jsonb),
  ('drill', 1, 12, '명사/동사', '[
    {"en":"He used a drill to make a hole.","ko":"그는 드릴로 구멍을 뚫었다."},
    {"en":"The drill is very loud.","ko":"그 드릴은 매우 시끄럽다."},
    {"en":"She drilled a hole in the wood.","ko":"그녀는 나무에 구멍을 뚫었다."}
  ]'::jsonb),
  ('saw', 1, 12, '명사/동사', '[
    {"en":"He cut the wood with a saw.","ko":"그는 톱으로 나무를 잘랐다."},
    {"en":"The saw is sharp, so be careful.","ko":"그 톱은 날카로우니 조심해라."},
    {"en":"She sawed the branch off the tree.","ko":"그녀는 나무에서 가지를 톱으로 잘랐다."}
  ]'::jsonb),
  ('bucket', 1, 12, '명사', '[
    {"en":"She filled the bucket with water.","ko":"그녀는 양동이에 물을 채웠다."},
    {"en":"He carried a bucket of paint.","ko":"그는 페인트 한 통을 들고 갔다."},
    {"en":"The bucket is next to the sink.","ko":"양동이는 싱크대 옆에 있다."}
  ]'::jsonb),
  ('housework', 1, 12, '명사', '[
    {"en":"She does housework every weekend.","ko":"그녀는 매주 주말 집안일을 한다."},
    {"en":"My family shares the housework.","ko":"우리 가족은 집안일을 나눠서 한다."},
    {"en":"He helps his mother with housework.","ko":"그는 엄마의 집안일을 돕는다."}
  ]'::jsonb),
  ('dig', 1, 12, '동사', '[
    {"en":"They dug a hole in the garden.","ko":"그들은 정원에 구덩이를 팠다."},
    {"en":"The dog is digging in the yard.","ko":"개가 마당에서 땅을 파고 있다."},
    {"en":"He dug the ground to plant a tree.","ko":"그는 나무를 심으려고 땅을 팠다."}
  ]'::jsonb),
  ('sweep', 1, 12, '동사', '[
    {"en":"She swept the floor with a broom.","ko":"그녀는 빗자루로 바닥을 쓸었다."},
    {"en":"He sweeps the yard every morning.","ko":"그는 매일 아침 마당을 쓴다."},
    {"en":"They swept the leaves off the sidewalk.","ko":"그들은 인도에서 낙엽을 쓸어냈다."}
  ]'::jsonb),
  ('fold', 1, 12, '동사', '[
    {"en":"She folded the clothes neatly.","ko":"그녀는 옷을 단정하게 개었다."},
    {"en":"He folds the towels after washing them.","ko":"그는 수건을 세탁한 후 갠다."},
    {"en":"Please fold this paper in half.","ko":"이 종이를 반으로 접어 주세요."}
  ]'::jsonb),
  ('rake', 1, 12, '명사/동사', '[
    {"en":"He raked the leaves in the yard.","ko":"그는 마당의 낙엽을 갈퀴로 긁어모았다."},
    {"en":"The rake is leaning against the fence.","ko":"갈퀴가 울타리에 기대어 있다."},
    {"en":"She used a rake to clean the garden.","ko":"그녀는 정원을 청소하려고 갈퀴를 사용했다."}
  ]'::jsonb),
  ('trim', 1, 12, '동사', '[
    {"en":"He trimmed the bushes in the garden.","ko":"그는 정원의 관목을 다듬었다."},
    {"en":"She trims her hair every few months.","ko":"그녀는 몇 달마다 머리를 다듬는다."},
    {"en":"They trimmed the grass along the path.","ko":"그들은 길을 따라 잔디를 다듬었다."}
  ]'::jsonb),
  ('polish', 1, 12, '동사', '[
    {"en":"He polished his shoes before school.","ko":"그는 학교 가기 전에 신발을 닦았다."},
    {"en":"She polishes the table every week.","ko":"그녀는 매주 탁자를 닦는다."},
    {"en":"The floor was polished until it shined.","ko":"바닥은 반짝일 때까지 닦였다."}
  ]'::jsonb),
  ('screw', 1, 12, '명사/동사', '[
    {"en":"He tightened the screw with a tool.","ko":"그는 도구로 나사를 조였다."},
    {"en":"The screw fell out of the chair.","ko":"나사가 의자에서 빠졌다."},
    {"en":"She screwed the shelf onto the wall.","ko":"그녀는 벽에 선반을 나사로 고정했다."}
  ]'::jsonb),
  ('broom', 1, 12, '명사', '[
    {"en":"She swept the floor with a broom.","ko":"그녀는 빗자루로 바닥을 쓸었다."},
    {"en":"The broom is behind the door.","ko":"빗자루는 문 뒤에 있다."},
    {"en":"He used an old broom to clean the yard.","ko":"그는 낡은 빗자루로 마당을 청소했다."}
  ]'::jsonb),
  ('shovel', 1, 12, '명사', '[
    {"en":"He used a shovel to dig the ground.","ko":"그는 삽으로 땅을 팠다."},
    {"en":"The shovel is in the garage.","ko":"삽은 차고에 있다."},
    {"en":"She shoveled the snow off the path.","ko":"그녀는 삽으로 길의 눈을 치웠다."}
  ]'::jsonb),
  ('wrench', 1, 12, '명사', '[
    {"en":"He used a wrench to fix the pipe.","ko":"그는 렌치로 파이프를 고쳤다."},
    {"en":"The wrench is in the toolbox.","ko":"렌치는 공구함 안에 있다."},
    {"en":"She borrowed a wrench from her father.","ko":"그녀는 아빠에게서 렌치를 빌렸다."}
  ]'::jsonb),
  ('flashlight', 1, 12, '명사', '[
    {"en":"He used a flashlight in the dark room.","ko":"그는 어두운 방에서 손전등을 사용했다."},
    {"en":"The flashlight is very bright.","ko":"그 손전등은 매우 밝다."},
    {"en":"She carried a flashlight during the camping trip.","ko":"그녀는 캠핑 여행 동안 손전등을 들고 다녔다."}
  ]'::jsonb),
  ('outlet', 1, 12, '명사', '[
    {"en":"The lamp is plugged into the outlet.","ko":"램프는 콘센트에 꽂혀 있다."},
    {"en":"There is only one outlet in this room.","ko":"이 방에는 콘센트가 하나뿐이다."},
    {"en":"He plugged the fan into the outlet.","ko":"그는 선풍기를 콘센트에 꽂았다."}
  ]'::jsonb),
  ('set up', 1, 12, '동사구', '[
    {"en":"They set up the tent before it got dark.","ko":"그들은 어두워지기 전에 텐트를 설치했다."},
    {"en":"She set up her new computer yesterday.","ko":"그녀는 어제 새 컴퓨터를 설치했다."},
    {"en":"We need to set up the chairs for the meeting.","ko":"우리는 회의를 위해 의자를 설치해야 한다."}
  ]'::jsonb),
  ('clean up', 1, 12, '동사구', '[
    {"en":"Please clean up your room before dinner.","ko":"저녁 식사 전에 네 방을 치워라."},
    {"en":"We cleaned up the park together.","ko":"우리는 함께 공원을 청소했다."},
    {"en":"She cleaned up the kitchen after cooking.","ko":"그녀는 요리 후 부엌을 치웠다."}
  ]'::jsonb)
) as t(word, level, study_day, pos, examples)
where v.word = t.word and v.level = t.level and v.study_day = t.study_day;
