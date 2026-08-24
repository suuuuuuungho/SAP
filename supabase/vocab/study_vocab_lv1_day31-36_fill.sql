-- SAP 1기 대시보드: Study 탭 — Lv.1(중등 실력) Day 31~36 품사/예문 채우기 (180단어).
update public.vocab_words v
set part_of_speech = t.pos, example_sentences = t.examples, updated_at = now()
from (values
  ('pollution', 1, 31, '명사', '[
    {"en":"Air pollution is a serious problem in big cities.","ko":"대기 오염은 대도시에서 심각한 문제이다."},
    {"en":"We should work together to reduce pollution.","ko":"우리는 오염을 줄이기 위해 함께 노력해야 한다."},
    {"en":"The river was clean before pollution started.","ko":"그 강은 오염이 시작되기 전에는 깨끗했다."}
  ]'::jsonb),
  ('protect', 1, 31, '동사', '[
    {"en":"We must protect the environment for future generations.","ko":"우리는 미래 세대를 위해 환경을 보호해야 한다."},
    {"en":"Sunscreen can protect your skin from the sun.","ko":"자외선 차단제는 햇빛으로부터 피부를 보호해줄 수 있다."},
    {"en":"The fence protects the garden from animals.","ko":"그 울타리는 동물들로부터 정원을 보호한다."}
  ]'::jsonb),
  ('separate', 1, 31, '동사', '[
    {"en":"Please separate the plastic from the paper.","ko":"플라스틱을 종이와 분리해 주세요."},
    {"en":"We separate our trash into different bins.","ko":"우리는 쓰레기를 여러 통으로 분리한다."},
    {"en":"The teacher separated the class into two groups.","ko":"선생님은 학급을 두 그룹으로 나누었다."}
  ]'::jsonb),
  ('environment', 1, 31, '명사', '[
    {"en":"We need to take care of our environment.","ko":"우리는 우리의 환경을 돌봐야 한다."},
    {"en":"Plastic bags are bad for the environment.","ko":"비닐봉지는 환경에 좋지 않다."},
    {"en":"Our school has a project about the environment.","ko":"우리 학교는 환경에 관한 프로젝트가 있다."}
  ]'::jsonb),
  ('effect', 1, 31, '명사', '[
    {"en":"Pollution has a bad effect on our health.","ko":"오염은 우리 건강에 나쁜 영향을 미친다."},
    {"en":"Exercise has a good effect on your mood.","ko":"운동은 기분에 좋은 영향을 미친다."},
    {"en":"The medicine had no effect at all.","ko":"그 약은 아무런 효과가 없었다."}
  ]'::jsonb),
  ('resource', 1, 31, '명사', '[
    {"en":"Water is an important natural resource.","ko":"물은 중요한 천연 자원이다."},
    {"en":"We should not waste our resources.","ko":"우리는 자원을 낭비해서는 안 된다."},
    {"en":"The library is a great resource for students.","ko":"도서관은 학생들에게 훌륭한 자원이다."}
  ]'::jsonb),
  ('destroy', 1, 31, '동사', '[
    {"en":"The storm destroyed many houses in the village.","ko":"그 폭풍은 마을의 많은 집을 파괴했다."},
    {"en":"Cutting down forests can destroy animal homes.","ko":"숲을 베는 것은 동물들의 집을 파괴할 수 있다."},
    {"en":"Please do not destroy the flowers in the park.","ko":"공원에 있는 꽃들을 훼손하지 마세요."}
  ]'::jsonb),
  ('global warming', 1, 31, '명사구', '[
    {"en":"Global warming is changing our weather patterns.","ko":"지구 온난화는 우리의 날씨 패턴을 바꾸고 있다."},
    {"en":"Scientists are studying the causes of global warming.","ko":"과학자들은 지구 온난화의 원인을 연구하고 있다."},
    {"en":"We can fight global warming by saving energy.","ko":"우리는 에너지를 절약함으로써 지구 온난화에 맞설 수 있다."}
  ]'::jsonb),
  ('damage', 1, 31, '명사', '[
    {"en":"The heavy rain caused a lot of damage.","ko":"폭우는 많은 피해를 초래했다."},
    {"en":"The storm did serious damage to the farm.","ko":"그 폭풍은 농장에 심각한 피해를 입혔다."},
    {"en":"We tried to fix the damage to the roof.","ko":"우리는 지붕의 손상을 고치려고 했다."}
  ]'::jsonb),
  ('garbage', 1, 31, '명사', '[
    {"en":"Please take out the garbage after dinner.","ko":"저녁 식사 후에 쓰레기를 내다 버려 주세요."},
    {"en":"The garbage truck comes every Monday morning.","ko":"쓰레기차는 매주 월요일 아침에 온다."},
    {"en":"Don''t throw garbage on the street.","ko":"길에 쓰레기를 버리지 마라."}
  ]'::jsonb),
  ('share', 1, 31, '동사', '[
    {"en":"I like to share my lunch with my friends.","ko":"나는 친구들과 점심을 나누어 먹는 것을 좋아한다."},
    {"en":"We should share resources to help the environment.","ko":"우리는 환경을 돕기 위해 자원을 공유해야 한다."},
    {"en":"She shared her umbrella with me in the rain.","ko":"그녀는 비 오는 날 나와 우산을 나누어 썼다."}
  ]'::jsonb),
  ('cause', 1, 31, '동사', '[
    {"en":"Too much trash can cause pollution.","ko":"너무 많은 쓰레기는 오염을 일으킬 수 있다."},
    {"en":"Loud noise can cause headaches.","ko":"시끄러운 소음은 두통을 일으킬 수 있다."},
    {"en":"What caused the fire in the kitchen?","ko":"부엌에서 무엇이 화재를 일으켰나요?"}
  ]'::jsonb),
  ('ruin', 1, 31, '명사/동사', '[
    {"en":"The flood was a complete ruin for the crops.","ko":"그 홍수는 농작물에 완전한 파멸이었다."},
    {"en":"We visited ancient ruins during our trip.","ko":"우리는 여행 중에 고대 유적을 방문했다."},
    {"en":"Rain almost ruined our picnic yesterday.","ko":"비는 어제 우리의 소풍을 거의 망칠 뻔했다."}
  ]'::jsonb),
  ('raw', 1, 31, '형용사', '[
    {"en":"We should not eat raw fish without care.","ko":"우리는 조심하지 않고 날생선을 먹으면 안 된다."},
    {"en":"The factory uses raw materials to make paper.","ko":"그 공장은 종이를 만들기 위해 원자재를 사용한다."},
    {"en":"She prefers raw vegetables to cooked ones.","ko":"그녀는 익힌 채소보다 생채소를 더 좋아한다."}
  ]'::jsonb),
  ('electricity', 1, 31, '명사', '[
    {"en":"We use electricity to light our classroom.","ko":"우리는 교실을 밝히기 위해 전기를 사용한다."},
    {"en":"Please turn off the lights to save electricity.","ko":"전기를 절약하기 위해 불을 꺼 주세요."},
    {"en":"The storm cut off electricity in the town.","ko":"그 폭풍은 마을의 전기를 끊었다."}
  ]'::jsonb),
  ('pure', 1, 31, '형용사', '[
    {"en":"The mountain air was pure and fresh.","ko":"그 산의 공기는 순수하고 신선했다."},
    {"en":"We drank pure water from the spring.","ko":"우리는 샘에서 나오는 순수한 물을 마셨다."},
    {"en":"The scientist studies pure gold in the lab.","ko":"그 과학자는 실험실에서 순금을 연구한다."}
  ]'::jsonb),
  ('smog', 1, 31, '명사', '[
    {"en":"Smog covered the city this morning.","ko":"오늘 아침 스모그가 도시를 덮었다."},
    {"en":"Cars are one of the main causes of smog.","ko":"자동차는 스모그의 주요 원인 중 하나이다."},
    {"en":"We could not see the mountains because of the smog.","ko":"우리는 스모그 때문에 산을 볼 수 없었다."}
  ]'::jsonb),
  ('fuel', 1, 31, '명사', '[
    {"en":"Cars need fuel to run.","ko":"자동차는 달리기 위해 연료가 필요하다."},
    {"en":"We should use less fuel to protect the environment.","ko":"우리는 환경을 보호하기 위해 연료를 덜 사용해야 한다."},
    {"en":"The plane stopped to get more fuel.","ko":"그 비행기는 연료를 더 얻기 위해 멈췄다."}
  ]'::jsonb),
  ('fossil', 1, 31, '명사', '[
    {"en":"The museum has many fossils of old animals.","ko":"그 박물관에는 오래된 동물들의 화석이 많이 있다."},
    {"en":"Scientists found a fossil in the desert.","ko":"과학자들은 사막에서 화석을 발견했다."},
    {"en":"We learned about fossils in science class.","ko":"우리는 과학 시간에 화석에 대해 배웠다."}
  ]'::jsonb),
  ('acid', 1, 31, '명사/형용사', '[
    {"en":"Acid rain can damage trees and rivers.","ko":"산성비는 나무와 강에 피해를 줄 수 있다."},
    {"en":"The scientist mixed the acid carefully.","ko":"그 과학자는 산을 조심스럽게 섞었다."},
    {"en":"Some fruits have a mild acid taste.","ko":"어떤 과일들은 약간 신맛이 난다."}
  ]'::jsonb),
  ('toxic', 1, 31, '형용사', '[
    {"en":"The factory released toxic gas into the air.","ko":"그 공장은 유독 가스를 공기 중으로 방출했다."},
    {"en":"Some plants are toxic if you eat them.","ko":"어떤 식물은 먹으면 유독하다."},
    {"en":"Please keep toxic chemicals away from children.","ko":"유독한 화학물질을 아이들에게서 멀리 두세요."}
  ]'::jsonb),
  ('exhaust', 1, 31, '명사/동사', '[
    {"en":"Car exhaust can pollute the air.","ko":"자동차 배기가스는 공기를 오염시킬 수 있다."},
    {"en":"Playing all day exhausted the children.","ko":"하루 종일 노는 것은 아이들을 지치게 했다."},
    {"en":"The bus exhaust smelled bad.","ko":"그 버스의 배기가스는 냄새가 나빴다."}
  ]'::jsonb),
  ('shortage', 1, 31, '명사', '[
    {"en":"There was a water shortage last summer.","ko":"지난여름에 물 부족이 있었다."},
    {"en":"The town faced a shortage of food.","ko":"그 마을은 식량 부족에 직면했다."},
    {"en":"A shortage of resources worried the farmers.","ko":"자원 부족은 농부들을 걱정하게 했다."}
  ]'::jsonb),
  ('reduce', 1, 31, '동사', '[
    {"en":"We can reduce pollution by riding bikes.","ko":"우리는 자전거를 탐으로써 오염을 줄일 수 있다."},
    {"en":"Try to reduce the amount of garbage you make.","ko":"당신이 만드는 쓰레기의 양을 줄이려고 노력하세요."},
    {"en":"The school reduced the use of plastic cups.","ko":"학교는 플라스틱 컵 사용을 줄였다."}
  ]'::jsonb),
  ('endangered', 1, 31, '형용사', '[
    {"en":"The panda is an endangered animal.","ko":"판다는 멸종 위기에 처한 동물이다."},
    {"en":"We should protect endangered species.","ko":"우리는 멸종 위기종을 보호해야 한다."},
    {"en":"Many endangered animals live in the rainforest.","ko":"많은 멸종 위기 동물들이 열대 우림에 산다."}
  ]'::jsonb),
  ('leak', 1, 31, '명사/동사', '[
    {"en":"There is a small leak in the roof.","ko":"지붕에 작은 누수가 있다."},
    {"en":"The pipe leaked water onto the floor.","ko":"그 파이프는 바닥에 물이 새게 했다."},
    {"en":"We found a gas leak in the kitchen.","ko":"우리는 부엌에서 가스 누출을 발견했다."}
  ]'::jsonb),
  ('overuse', 1, 31, '명사/동사', '[
    {"en":"Overuse of plastic harms the environment.","ko":"플라스틱의 남용은 환경에 해를 끼친다."},
    {"en":"Doctors warned about the overuse of medicine.","ko":"의사들은 약의 남용에 대해 경고했다."},
    {"en":"We should avoid overusing water at home.","ko":"우리는 집에서 물을 남용하지 않도록 해야 한다."}
  ]'::jsonb),
  ('greenhouse', 1, 31, '명사', '[
    {"en":"The farmer grows tomatoes in a greenhouse.","ko":"그 농부는 온실에서 토마토를 재배한다."},
    {"en":"Greenhouse gases make the earth warmer.","ko":"온실가스는 지구를 더 따뜻하게 만든다."},
    {"en":"We visited a big greenhouse full of flowers.","ko":"우리는 꽃으로 가득한 큰 온실을 방문했다."}
  ]'::jsonb),
  ('be worried about', 1, 31, '동사구', '[
    {"en":"I am worried about the environment.","ko":"나는 환경에 대해 걱정한다."},
    {"en":"She was worried about her exam results.","ko":"그녀는 시험 결과에 대해 걱정했다."},
    {"en":"We are worried about the endangered animals.","ko":"우리는 멸종 위기 동물들에 대해 걱정한다."}
  ]'::jsonb),
  ('back and forth', 1, 31, '부사구', '[
    {"en":"The bus moves back and forth between the two towns.","ko":"그 버스는 두 마을 사이를 왔다갔다 한다."},
    {"en":"The dog ran back and forth in the yard.","ko":"그 개는 마당에서 이리저리 뛰어다녔다."},
    {"en":"She walked back and forth while thinking.","ko":"그녀는 생각하면서 앞뒤로 왔다갔다 걸었다."}
  ]'::jsonb),
  ('electric', 1, 32, '형용사', '[
    {"en":"We bought a new electric fan for summer.","ko":"우리는 여름을 위해 새 전기 선풍기를 샀다."},
    {"en":"The electric car does not use gasoline.","ko":"그 전기 자동차는 휘발유를 사용하지 않는다."},
    {"en":"An electric light filled the dark room.","ko":"전등이 어두운 방을 밝혔다."}
  ]'::jsonb),
  ('invent', 1, 32, '동사', '[
    {"en":"Who invented the telephone?","ko":"누가 전화기를 발명했나요?"},
    {"en":"Scientists invented a new machine to clean water.","ko":"과학자들은 물을 정화하는 새로운 기계를 발명했다."},
    {"en":"Students tried to invent a simple robot.","ko":"학생들은 간단한 로봇을 발명하려고 했다."}
  ]'::jsonb),
  ('machine', 1, 32, '명사', '[
    {"en":"This machine can wash clothes quickly.","ko":"이 기계는 옷을 빠르게 세탁할 수 있다."},
    {"en":"The factory uses many machines to make cars.","ko":"그 공장은 자동차를 만들기 위해 많은 기계를 사용한다."},
    {"en":"My father fixed the washing machine yesterday.","ko":"아버지는 어제 세탁기를 고치셨다."}
  ]'::jsonb),
  ('data', 1, 32, '명사', '[
    {"en":"The scientist collected data for the experiment.","ko":"그 과학자는 실험을 위해 자료를 수집했다."},
    {"en":"We need more data to prove this idea.","ko":"우리는 이 생각을 증명하기 위해 더 많은 자료가 필요하다."},
    {"en":"The computer stores a lot of data.","ko":"그 컴퓨터는 많은 자료를 저장한다."}
  ]'::jsonb),
  ('important', 1, 32, '형용사', '[
    {"en":"It is important to protect the environment.","ko":"환경을 보호하는 것은 중요하다."},
    {"en":"Sleep is important for your health.","ko":"잠은 건강에 중요하다."},
    {"en":"She gave an important speech at school.","ko":"그녀는 학교에서 중요한 연설을 했다."}
  ]'::jsonb),
  ('cell', 1, 32, '명사', '[
    {"en":"Our bodies are made up of many cells.","ko":"우리 몸은 많은 세포로 이루어져 있다."},
    {"en":"The student looked at a cell under the microscope.","ko":"그 학생은 현미경으로 세포를 관찰했다."},
    {"en":"Every living thing is made of cells.","ko":"모든 생명체는 세포로 이루어져 있다."}
  ]'::jsonb),
  ('prove', 1, 32, '동사', '[
    {"en":"The experiment proved his idea was correct.","ko":"그 실험은 그의 생각이 옳다는 것을 증명했다."},
    {"en":"Can you prove that this method works?","ko":"이 방법이 효과가 있다는 것을 증명할 수 있나요?"},
    {"en":"Scientists worked hard to prove their theory.","ko":"과학자들은 그들의 이론을 증명하기 위해 열심히 노력했다."}
  ]'::jsonb),
  ('inform', 1, 32, '동사', '[
    {"en":"The teacher informed us about the test date.","ko":"선생님은 우리에게 시험 날짜를 알려주셨다."},
    {"en":"Please inform your parents about the school trip.","ko":"학교 여행에 대해 부모님께 알려 드리세요."},
    {"en":"The sign informs visitors about the museum hours.","ko":"그 표지판은 방문객들에게 박물관 시간을 알려준다."}
  ]'::jsonb),
  ('experiment', 1, 32, '명사/동사', '[
    {"en":"We did a fun experiment in science class.","ko":"우리는 과학 시간에 재미있는 실험을 했다."},
    {"en":"The students experimented with different plants.","ko":"학생들은 여러 식물로 실험했다."},
    {"en":"Our experiment showed interesting results.","ko":"우리의 실험은 흥미로운 결과를 보여주었다."}
  ]'::jsonb),
  ('method', 1, 32, '명사', '[
    {"en":"This is a good method to learn new words.","ko":"이것은 새로운 단어를 배우는 좋은 방법이다."},
    {"en":"The teacher explained a new study method.","ko":"선생님은 새로운 공부 방법을 설명해 주셨다."},
    {"en":"Scientists tried a different method for the test.","ko":"과학자들은 그 실험을 위해 다른 방법을 시도했다."}
  ]'::jsonb),
  ('chemical', 1, 32, '형용사/명사', '[
    {"en":"The factory uses chemical materials to make plastic.","ko":"그 공장은 플라스틱을 만들기 위해 화학 물질을 사용한다."},
    {"en":"Please handle chemicals carefully in the lab.","ko":"실험실에서 화학 약품을 조심스럽게 다루세요."},
    {"en":"Water is made of a simple chemical formula.","ko":"물은 간단한 화학식으로 이루어져 있다."}
  ]'::jsonb),
  ('measure', 1, 32, '동사', '[
    {"en":"We measured the length of the desk.","ko":"우리는 책상의 길이를 측정했다."},
    {"en":"The scientist measured the temperature of the water.","ko":"그 과학자는 물의 온도를 측정했다."},
    {"en":"Can you measure how tall this tree is?","ko":"이 나무가 얼마나 큰지 측정해 줄 수 있나요?"}
  ]'::jsonb),
  ('technology', 1, 32, '명사', '[
    {"en":"Modern technology makes our lives easier.","ko":"현대 기술은 우리의 삶을 더 편리하게 만든다."},
    {"en":"Our school uses technology to teach students.","ko":"우리 학교는 학생들을 가르치기 위해 기술을 사용한다."},
    {"en":"New technology helps doctors treat patients.","ko":"새로운 기술은 의사들이 환자를 치료하는 데 도움을 준다."}
  ]'::jsonb),
  ('inspect', 1, 32, '동사', '[
    {"en":"The teacher inspected our science projects.","ko":"선생님은 우리의 과학 프로젝트를 검사하셨다."},
    {"en":"Workers inspect the machines every morning.","ko":"근로자들은 매일 아침 기계를 점검한다."},
    {"en":"We inspected the plant to see how it grew.","ko":"우리는 식물이 어떻게 자랐는지 살펴보았다."}
  ]'::jsonb),
  ('imagine', 1, 32, '동사', '[
    {"en":"Can you imagine life without electricity?","ko":"전기 없는 삶을 상상할 수 있나요?"},
    {"en":"I imagine the future will have more robots.","ko":"나는 미래에 더 많은 로봇이 있을 것이라고 상상한다."},
    {"en":"She imagined a world with clean air.","ko":"그녀는 깨끗한 공기가 있는 세상을 상상했다."}
  ]'::jsonb),
  ('visible', 1, 32, '형용사', '[
    {"en":"The stars were clearly visible last night.","ko":"어젯밤 별들이 뚜렷하게 보였다."},
    {"en":"The mountain is visible from our school.","ko":"그 산은 우리 학교에서 보인다."},
    {"en":"Under the microscope, the cells became visible.","ko":"현미경 아래에서 세포들이 보이게 되었다."}
  ]'::jsonb),
  ('vacuum', 1, 32, '명사/동사', '[
    {"en":"She used a vacuum to clean the carpet.","ko":"그녀는 카펫을 청소하기 위해 진공청소기를 사용했다."},
    {"en":"My brother vacuums his room every weekend.","ko":"내 남동생은 주말마다 자기 방을 진공청소기로 청소한다."},
    {"en":"There is no air in a vacuum.","ko":"진공 속에는 공기가 없다."}
  ]'::jsonb),
  ('react', 1, 32, '동사', '[
    {"en":"The two chemicals reacted quickly.","ko":"그 두 화학 물질은 빠르게 반응했다."},
    {"en":"How did she react to the news?","ko":"그녀는 그 소식에 어떻게 반응했나요?"},
    {"en":"Plants react to sunlight in interesting ways.","ko":"식물은 햇빛에 흥미로운 방식으로 반응한다."}
  ]'::jsonb),
  ('mobile', 1, 32, '형용사/명사', '[
    {"en":"She left her mobile phone at home.","ko":"그녀는 휴대 전화를 집에 두고 왔다."},
    {"en":"Mobile libraries visit small villages every month.","ko":"이동 도서관은 매달 작은 마을들을 방문한다."},
    {"en":"My mobile is very useful for study apps.","ko":"내 휴대전화는 학습 앱에 매우 유용하다."}
  ]'::jsonb),
  ('charge', 1, 32, '동사', '[
    {"en":"I need to charge my phone before school.","ko":"나는 학교 가기 전에 휴대전화를 충전해야 한다."},
    {"en":"Please charge the battery overnight.","ko":"밤새 배터리를 충전해 주세요."},
    {"en":"We charged our tablets at the library.","ko":"우리는 도서관에서 태블릿을 충전했다."}
  ]'::jsonb),
  ('multiply', 1, 32, '동사', '[
    {"en":"We learned how to multiply numbers in math class.","ko":"우리는 수학 시간에 숫자를 곱하는 법을 배웠다."},
    {"en":"Rabbits can multiply very quickly.","ko":"토끼는 매우 빠르게 증가할 수 있다."},
    {"en":"Multiply six by seven to get the answer.","ko":"답을 구하려면 6에 7을 곱하세요."}
  ]'::jsonb),
  ('gravity', 1, 32, '명사', '[
    {"en":"Gravity pulls objects down to the ground.","ko":"중력은 물체를 땅으로 끌어당긴다."},
    {"en":"We learned about gravity in science class.","ko":"우리는 과학 시간에 중력에 대해 배웠다."},
    {"en":"Without gravity, everything would float in the air.","ko":"중력이 없다면 모든 것이 공중에 떠다닐 것이다."}
  ]'::jsonb),
  ('browse', 1, 32, '동사', '[
    {"en":"I like to browse books at the library.","ko":"나는 도서관에서 책을 둘러보는 것을 좋아한다."},
    {"en":"She browsed the internet for her school project.","ko":"그녀는 학교 프로젝트를 위해 인터넷을 검색했다."},
    {"en":"We browsed through the museum''s collection.","ko":"우리는 박물관의 소장품을 둘러보았다."}
  ]'::jsonb),
  ('device', 1, 32, '명사', '[
    {"en":"This device helps measure temperature.","ko":"이 장치는 온도를 측정하는 데 도움을 준다."},
    {"en":"My uncle invented a small device for farmers.","ko":"삼촌은 농부들을 위한 작은 장치를 발명했다."},
    {"en":"The new device makes studying easier.","ko":"그 새 기기는 공부를 더 쉽게 만든다."}
  ]'::jsonb),
  ('delete', 1, 32, '동사', '[
    {"en":"I accidentally deleted my homework file.","ko":"나는 실수로 숙제 파일을 삭제했다."},
    {"en":"Please delete the old photos from the computer.","ko":"컴퓨터에서 오래된 사진들을 삭제해 주세요."},
    {"en":"She deleted the mistake and wrote a new sentence.","ko":"그녀는 실수를 지우고 새 문장을 썼다."}
  ]'::jsonb),
  ('wireless', 1, 32, '형용사', '[
    {"en":"We use a wireless printer at school.","ko":"우리는 학교에서 무선 프린터를 사용한다."},
    {"en":"The library has wireless internet for students.","ko":"도서관에는 학생들을 위한 무선 인터넷이 있다."},
    {"en":"My headphones are wireless and easy to carry.","ko":"내 헤드폰은 무선이고 가지고 다니기 쉽다."}
  ]'::jsonb),
  ('transmit', 1, 32, '동사', '[
    {"en":"The radio station transmits news every hour.","ko":"그 라디오 방송국은 매시간 뉴스를 전송한다."},
    {"en":"Some diseases can be transmitted through water.","ko":"어떤 질병들은 물을 통해 전염될 수 있다."},
    {"en":"The device transmits data to the computer.","ko":"그 장치는 데이터를 컴퓨터로 전송한다."}
  ]'::jsonb),
  ('formula', 1, 32, '명사', '[
    {"en":"We learned a new math formula today.","ko":"우리는 오늘 새로운 수학 공식을 배웠다."},
    {"en":"The scientist wrote the formula on the board.","ko":"그 과학자는 칠판에 공식을 적었다."},
    {"en":"This formula helps us find the area of a circle.","ko":"이 공식은 우리가 원의 넓이를 구하는 데 도움을 준다."}
  ]'::jsonb),
  ('lead to', 1, 32, '동사구', '[
    {"en":"Hard work leads to good results.","ko":"노력은 좋은 결과로 이어진다."},
    {"en":"Too much trash can lead to pollution.","ko":"너무 많은 쓰레기는 오염으로 이어질 수 있다."},
    {"en":"This road leads to the science museum.","ko":"이 길은 과학 박물관으로 이어진다."}
  ]'::jsonb),
  ('come up with', 1, 32, '동사구', '[
    {"en":"The team came up with a great idea.","ko":"그 팀은 훌륭한 아이디어를 생각해 냈다."},
    {"en":"Can you come up with a new plan?","ko":"새로운 계획을 생각해 낼 수 있나요?"},
    {"en":"She came up with a solution to the problem.","ko":"그녀는 그 문제에 대한 해결책을 생각해 냈다."}
  ]'::jsonb),
  ('earth', 1, 33, '명사', '[
    {"en":"The earth moves around the sun.","ko":"지구는 태양 주위를 돈다."},
    {"en":"We should protect the earth for future generations.","ko":"우리는 미래 세대를 위해 지구를 보호해야 한다."},
    {"en":"The earth is the third planet from the sun.","ko":"지구는 태양으로부터 세 번째 행성이다."}
  ]'::jsonb),
  ('planet', 1, 33, '명사', '[
    {"en":"Mars is a red planet.","ko":"화성은 붉은 행성이다."},
    {"en":"There are eight planets in our solar system.","ko":"우리 태양계에는 8개의 행성이 있다."},
    {"en":"Scientists study other planets to find life.","ko":"과학자들은 생명체를 찾기 위해 다른 행성들을 연구한다."}
  ]'::jsonb),
  ('universe', 1, 33, '명사', '[
    {"en":"The universe is very large and mysterious.","ko":"우주는 매우 크고 신비롭다."},
    {"en":"Scientists still have many questions about the universe.","ko":"과학자들은 여전히 우주에 대해 많은 질문을 가지고 있다."},
    {"en":"We learned about the universe in science class.","ko":"우리는 과학 시간에 우주에 대해 배웠다."}
  ]'::jsonb),
  ('solar', 1, 33, '형용사', '[
    {"en":"Our house uses solar energy for electricity.","ko":"우리 집은 전기를 위해 태양 에너지를 사용한다."},
    {"en":"The solar system has eight planets.","ko":"태양계에는 8개의 행성이 있다."},
    {"en":"Solar power is clean and safe.","ko":"태양 에너지는 깨끗하고 안전하다."}
  ]'::jsonb),
  ('lunar', 1, 33, '형용사', '[
    {"en":"The lunar surface is covered with dust.","ko":"달 표면은 먼지로 덮여 있다."},
    {"en":"We watched a lunar eclipse last night.","ko":"우리는 어젯밤 월식을 지켜보았다."},
    {"en":"The lunar calendar is different from the solar calendar.","ko":"음력은 양력과 다르다."}
  ]'::jsonb),
  ('crew', 1, 33, '명사', '[
    {"en":"The space crew trained for many months.","ko":"그 우주 승무원은 여러 달 동안 훈련했다."},
    {"en":"Six astronauts made up the crew.","ko":"6명의 우주 비행사들이 그 승무원을 구성했다."},
    {"en":"The plane''s crew helped the passengers.","ko":"그 비행기의 승무원들은 승객들을 도왔다."}
  ]'::jsonb),
  ('rocket', 1, 33, '명사/동사', '[
    {"en":"The rocket launched into space this morning.","ko":"그 로켓은 오늘 아침 우주로 발사되었다."},
    {"en":"We watched the rocket fly high into the sky.","ko":"우리는 로켓이 하늘 높이 날아가는 것을 지켜보았다."},
    {"en":"Scientists rocketed the satellite into orbit.","ko":"과학자들은 위성을 궤도로 쏘아 올렸다."}
  ]'::jsonb),
  ('outer', 1, 33, '형용사', '[
    {"en":"Outer space has no air.","ko":"외계 공간에는 공기가 없다."},
    {"en":"The outer layer of the earth is called the crust.","ko":"지구의 바깥층은 지각이라고 불린다."},
    {"en":"Astronauts explore outer space.","ko":"우주비행사들은 외계 공간을 탐험한다."}
  ]'::jsonb),
  ('surface', 1, 33, '명사', '[
    {"en":"The surface of the moon is rocky.","ko":"달의 표면은 바위투성이이다."},
    {"en":"Water covers most of the earth''s surface.","ko":"물은 지구 표면의 대부분을 덮고 있다."},
    {"en":"We studied the surface of Mars in class.","ko":"우리는 수업 시간에 화성의 표면에 대해 공부했다."}
  ]'::jsonb),
  ('Mercury', 1, 33, '명사', '[
    {"en":"Mercury is the closest planet to the sun.","ko":"수성은 태양에서 가장 가까운 행성이다."},
    {"en":"Mercury is very small and hot.","ko":"수성은 매우 작고 뜨겁다."},
    {"en":"We read a book about Mercury in class.","ko":"우리는 수업 시간에 수성에 관한 책을 읽었다."}
  ]'::jsonb),
  ('Venus', 1, 33, '명사', '[
    {"en":"Venus is the second planet from the sun.","ko":"금성은 태양으로부터 두 번째 행성이다."},
    {"en":"Venus is often called the evening star.","ko":"금성은 종종 저녁별이라고 불린다."},
    {"en":"Scientists say Venus is extremely hot.","ko":"과학자들은 금성이 매우 뜨겁다고 말한다."}
  ]'::jsonb),
  ('Mars', 1, 33, '명사', '[
    {"en":"Mars is known as the red planet.","ko":"화성은 붉은 행성으로 알려져 있다."},
    {"en":"Scientists sent a robot to explore Mars.","ko":"과학자들은 화성을 탐사하기 위해 로봇을 보냈다."},
    {"en":"We are curious about life on Mars.","ko":"우리는 화성의 생명체에 대해 궁금해한다."}
  ]'::jsonb),
  ('Jupiter', 1, 33, '명사', '[
    {"en":"Jupiter is the largest planet in our solar system.","ko":"목성은 우리 태양계에서 가장 큰 행성이다."},
    {"en":"Jupiter has many moons around it.","ko":"목성은 주위에 많은 위성을 가지고 있다."},
    {"en":"We saw pictures of Jupiter in our textbook.","ko":"우리는 교과서에서 목성의 사진을 보았다."}
  ]'::jsonb),
  ('Saturn', 1, 33, '명사', '[
    {"en":"Saturn is famous for its beautiful rings.","ko":"토성은 아름다운 고리로 유명하다."},
    {"en":"Saturn is far from the earth.","ko":"토성은 지구에서 멀리 떨어져 있다."},
    {"en":"We drew a picture of Saturn for our project.","ko":"우리는 프로젝트를 위해 토성 그림을 그렸다."}
  ]'::jsonb),
  ('ring', 1, 33, '명사', '[
    {"en":"Saturn''s rings are made of ice and rock.","ko":"토성의 고리는 얼음과 바위로 이루어져 있다."},
    {"en":"We looked at the rings through a telescope.","ko":"우리는 망원경으로 그 고리를 관찰했다."},
    {"en":"The ring around the planet was very bright.","ko":"그 행성 주위의 고리는 매우 밝았다."}
  ]'::jsonb),
  ('comet', 1, 33, '명사', '[
    {"en":"We saw a bright comet in the night sky.","ko":"우리는 밤하늘에서 밝은 혜성을 보았다."},
    {"en":"A comet passes by the earth once every few years.","ko":"혜성은 몇 년에 한 번씩 지구 곁을 지나간다."},
    {"en":"The comet had a long, bright tail.","ko":"그 혜성은 길고 밝은 꼬리를 가지고 있었다."}
  ]'::jsonb),
  ('telescope', 1, 33, '명사', '[
    {"en":"We used a telescope to look at the stars.","ko":"우리는 별을 보기 위해 망원경을 사용했다."},
    {"en":"My father bought a new telescope for our trip.","ko":"아버지는 우리 여행을 위해 새 망원경을 사셨다."},
    {"en":"Through the telescope, we could see the moon clearly.","ko":"망원경을 통해 우리는 달을 뚜렷하게 볼 수 있었다."}
  ]'::jsonb),
  ('Milky Way', 1, 33, '명사', '[
    {"en":"The Milky Way is the galaxy where the earth is located.","ko":"은하수는 지구가 위치한 은하이다."},
    {"en":"We could see the Milky Way clearly in the countryside.","ko":"우리는 시골에서 은하수를 뚜렷하게 볼 수 있었다."},
    {"en":"The Milky Way has billions of stars.","ko":"은하수는 수십억 개의 별을 가지고 있다."}
  ]'::jsonb),
  ('space shuttle', 1, 33, '명사구', '[
    {"en":"The space shuttle carried astronauts to space.","ko":"그 우주 왕복선은 우주비행사들을 우주로 실어 날랐다."},
    {"en":"We watched a video about the space shuttle.","ko":"우리는 우주 왕복선에 관한 비디오를 보았다."},
    {"en":"The space shuttle returned safely to earth.","ko":"그 우주 왕복선은 안전하게 지구로 돌아왔다."}
  ]'::jsonb),
  ('space station', 1, 33, '명사구', '[
    {"en":"Astronauts live and work at the space station.","ko":"우주비행사들은 우주 정거장에서 살고 일한다."},
    {"en":"The space station orbits the earth many times a day.","ko":"그 우주 정거장은 하루에 여러 번 지구 궤도를 돈다."},
    {"en":"Scientists do experiments at the space station.","ko":"과학자들은 우주 정거장에서 실험을 한다."}
  ]'::jsonb),
  ('eclipse', 1, 33, '명사', '[
    {"en":"We watched a solar eclipse together as a class.","ko":"우리는 학급 전체가 함께 일식을 관찰했다."},
    {"en":"An eclipse happens when the moon covers the sun.","ko":"일식은 달이 태양을 가릴 때 일어난다."},
    {"en":"The eclipse lasted for a few minutes.","ko":"그 식은 몇 분 동안 지속되었다."}
  ]'::jsonb),
  ('satellite', 1, 33, '명사', '[
    {"en":"The satellite sends weather information to earth.","ko":"그 위성은 지구로 날씨 정보를 보낸다."},
    {"en":"The moon is a natural satellite of the earth.","ko":"달은 지구의 자연 위성이다."},
    {"en":"Scientists launched a new satellite last month.","ko":"과학자들은 지난달에 새로운 위성을 발사했다."}
  ]'::jsonb),
  ('orbit', 1, 33, '명사/동사', '[
    {"en":"The earth''s orbit around the sun takes one year.","ko":"태양 주위를 도는 지구의 궤도는 일 년이 걸린다."},
    {"en":"Satellites orbit the earth many times a day.","ko":"위성들은 하루에 여러 번 지구 궤도를 돈다."},
    {"en":"We learned about the orbit of the planets.","ko":"우리는 행성들의 궤도에 대해 배웠다."}
  ]'::jsonb),
  ('galaxy', 1, 33, '명사', '[
    {"en":"Our galaxy is called the Milky Way.","ko":"우리 은하는 은하수라고 불린다."},
    {"en":"There are billions of galaxies in the universe.","ko":"우주에는 수십억 개의 은하가 있다."},
    {"en":"The telescope showed a beautiful galaxy far away.","ko":"그 망원경은 멀리 있는 아름다운 은하를 보여주었다."}
  ]'::jsonb),
  ('astronomy', 1, 33, '명사', '[
    {"en":"She is interested in astronomy and stars.","ko":"그녀는 천문학과 별에 관심이 있다."},
    {"en":"We study astronomy in science class this month.","ko":"우리는 이번 달 과학 시간에 천문학을 공부한다."},
    {"en":"Astronomy helps us understand the universe.","ko":"천문학은 우리가 우주를 이해하는 데 도움을 준다."}
  ]'::jsonb),
  ('astronomer', 1, 33, '명사', '[
    {"en":"The astronomer discovered a new star.","ko":"그 천문학자는 새로운 별을 발견했다."},
    {"en":"An astronomer uses a telescope to study space.","ko":"천문학자는 우주를 연구하기 위해 망원경을 사용한다."},
    {"en":"I want to be an astronomer in the future.","ko":"나는 미래에 천문학자가 되고 싶다."}
  ]'::jsonb),
  ('Big Bang', 1, 33, '명사', '[
    {"en":"Scientists believe the universe began with the Big Bang.","ko":"과학자들은 우주가 빅뱅으로 시작되었다고 믿는다."},
    {"en":"We watched a video about the Big Bang theory.","ko":"우리는 빅뱅 이론에 관한 비디오를 보았다."},
    {"en":"The Big Bang happened billions of years ago.","ko":"빅뱅은 수십억 년 전에 일어났다."}
  ]'::jsonb),
  ('light year', 1, 33, '명사구', '[
    {"en":"A light year measures a very long distance.","ko":"광년은 매우 긴 거리를 측정한다."},
    {"en":"The star is many light years away from earth.","ko":"그 별은 지구로부터 수많은 광년 떨어져 있다."},
    {"en":"We learned how big a light year is.","ko":"우리는 광년이 얼마나 큰지 배웠다."}
  ]'::jsonb),
  ('far from', 1, 33, '전치사구', '[
    {"en":"The library is not far from our school.","ko":"도서관은 우리 학교에서 멀지 않다."},
    {"en":"That star is far from the earth.","ko":"그 별은 지구에서 멀리 떨어져 있다."},
    {"en":"Her house is far from the city center.","ko":"그녀의 집은 시내 중심에서 멀다."}
  ]'::jsonb),
  ('by chance', 1, 33, '부사구', '[
    {"en":"I met my old friend by chance at the museum.","ko":"나는 박물관에서 우연히 옛 친구를 만났다."},
    {"en":"We found the answer by chance while studying.","ko":"우리는 공부하다가 우연히 답을 찾았다."},
    {"en":"She discovered the comet by chance one night.","ko":"그녀는 어느 날 밤 우연히 그 혜성을 발견했다."}
  ]'::jsonb),
  ('power', 1, 34, '명사', '[
    {"en":"Wind power is clean and renewable.","ko":"풍력은 깨끗하고 재생 가능하다."},
    {"en":"The town lost power during the storm.","ko":"그 마을은 폭풍 중에 전력을 잃었다."},
    {"en":"Solar power helps us save energy.","ko":"태양 에너지는 우리가 에너지를 절약하는 데 도움을 준다."}
  ]'::jsonb),
  ('produce', 1, 34, '동사', '[
    {"en":"The factory produces electricity from wind.","ko":"그 공장은 바람으로 전기를 생산한다."},
    {"en":"Farmers produce a lot of rice every year.","ko":"농부들은 매년 많은 쌀을 생산한다."},
    {"en":"This machine produces clean energy for the town.","ko":"이 기계는 마을을 위한 깨끗한 에너지를 생산한다."}
  ]'::jsonb),
  ('wind', 1, 34, '명사', '[
    {"en":"The wind was strong on the beach.","ko":"해변에서 바람이 강했다."},
    {"en":"We use wind to make electricity.","ko":"우리는 전기를 만들기 위해 바람을 이용한다."},
    {"en":"The wind blew the leaves off the trees.","ko":"바람은 나뭇잎들을 나무에서 떨어뜨렸다."}
  ]'::jsonb),
  ('coal', 1, 34, '명사', '[
    {"en":"Coal is a natural resource used for energy.","ko":"석탄은 에너지에 사용되는 천연자원이다."},
    {"en":"The factory burns coal to produce heat.","ko":"그 공장은 열을 생산하기 위해 석탄을 태운다."},
    {"en":"Coal comes from deep underground.","ko":"석탄은 땅 깊은 곳에서 나온다."}
  ]'::jsonb),
  ('mine', 1, 34, '명사/동사', '[
    {"en":"Workers dig coal from the mine.","ko":"근로자들은 광산에서 석탄을 캔다."},
    {"en":"The old mine is now closed.","ko":"그 오래된 광산은 지금 폐쇄되었다."},
    {"en":"People mine coal to make electricity.","ko":"사람들은 전기를 만들기 위해 석탄을 채굴한다."}
  ]'::jsonb),
  ('factory', 1, 34, '명사', '[
    {"en":"The factory produces cars every day.","ko":"그 공장은 매일 자동차를 생산한다."},
    {"en":"My father works at a paper factory.","ko":"아버지는 제지 공장에서 일하신다."},
    {"en":"The factory uses a lot of electricity.","ko":"그 공장은 많은 전기를 사용한다."}
  ]'::jsonb),
  ('dam', 1, 34, '명사', '[
    {"en":"The dam produces electricity from the river.","ko":"그 댐은 강으로부터 전기를 생산한다."},
    {"en":"We visited a large dam on our trip.","ko":"우리는 여행 중에 큰 댐을 방문했다."},
    {"en":"The dam controls the flow of water.","ko":"그 댐은 물의 흐름을 조절한다."}
  ]'::jsonb),
  ('heat', 1, 34, '명사/동사', '[
    {"en":"The sun gives heat and light to the earth.","ko":"태양은 지구에 열과 빛을 준다."},
    {"en":"We heat our house with natural gas.","ko":"우리는 천연가스로 집을 난방한다."},
    {"en":"The heat from the fire warmed the room.","ko":"불에서 나오는 열이 방을 따뜻하게 했다."}
  ]'::jsonb),
  ('battery', 1, 34, '명사', '[
    {"en":"My phone battery is almost empty.","ko":"내 휴대전화 배터리가 거의 다 되었다."},
    {"en":"We need new batteries for the flashlight.","ko":"손전등을 위한 새 배터리가 필요하다."},
    {"en":"The car battery stores electricity.","ko":"자동차 배터리는 전기를 저장한다."}
  ]'::jsonb),
  ('consume', 1, 34, '동사', '[
    {"en":"Old machines consume more electricity.","ko":"오래된 기계들은 더 많은 전기를 소비한다."},
    {"en":"We should not consume too much energy.","ko":"우리는 너무 많은 에너지를 소비해서는 안 된다."},
    {"en":"This device consumes very little power.","ko":"이 기기는 전력을 아주 적게 소비한다."}
  ]'::jsonb),
  ('generate', 1, 34, '동사', '[
    {"en":"Windmills generate electricity from the wind.","ko":"풍차는 바람으로부터 전기를 생성한다."},
    {"en":"The dam generates power for the whole city.","ko":"그 댐은 도시 전체를 위한 전력을 생성한다."},
    {"en":"Solar panels generate clean energy.","ko":"태양 전지판은 깨끗한 에너지를 생성한다."}
  ]'::jsonb),
  ('nuclear', 1, 34, '형용사', '[
    {"en":"Nuclear power plants produce a lot of electricity.","ko":"원자력 발전소는 많은 전기를 생산한다."},
    {"en":"Nuclear energy must be handled with great care.","ko":"원자력 에너지는 매우 신중하게 다뤄져야 한다."},
    {"en":"We learned about nuclear power in science class.","ko":"우리는 과학 시간에 원자력에 대해 배웠다."}
  ]'::jsonb),
  ('windmill', 1, 34, '명사', '[
    {"en":"The windmill turns to produce electricity.","ko":"그 풍차는 전기를 생산하기 위해 회전한다."},
    {"en":"We saw many windmills on the hill.","ko":"우리는 언덕 위에서 많은 풍차를 보았다."},
    {"en":"Old windmills were used to grind grain.","ko":"오래된 풍차는 곡물을 갈기 위해 사용되었다."}
  ]'::jsonb),
  ('tidal', 1, 34, '형용사', '[
    {"en":"Tidal power comes from the movement of the sea.","ko":"조력 에너지는 바다의 움직임에서 나온다."},
    {"en":"The tidal wave was gentle near the shore.","ko":"조수의 파도는 해안 근처에서 잔잔했다."},
    {"en":"Scientists study tidal energy as a clean power source.","ko":"과학자들은 조력 에너지를 깨끗한 에너지원으로 연구한다."}
  ]'::jsonb),
  ('careless', 1, 34, '형용사', '[
    {"en":"Being careless with fire can be dangerous.","ko":"불을 부주의하게 다루는 것은 위험할 수 있다."},
    {"en":"He made a careless mistake on the test.","ko":"그는 시험에서 부주의한 실수를 했다."},
    {"en":"Don''t be careless when you use electricity.","ko":"전기를 사용할 때 부주의하지 마라."}
  ]'::jsonb),
  ('transform', 1, 34, '동사', '[
    {"en":"Windmills transform wind into electricity.","ko":"풍차는 바람을 전기로 변환한다."},
    {"en":"The old factory was transformed into a museum.","ko":"그 오래된 공장은 박물관으로 변모되었다."},
    {"en":"Sunlight can be transformed into energy.","ko":"햇빛은 에너지로 변환될 수 있다."}
  ]'::jsonb),
  ('natural gas', 1, 34, '명사구', '[
    {"en":"Natural gas is used to heat many homes.","ko":"천연가스는 많은 가정을 난방하는 데 사용된다."},
    {"en":"We cook with natural gas in our kitchen.","ko":"우리는 부엌에서 천연가스로 요리한다."},
    {"en":"Natural gas comes from deep under the ground.","ko":"천연가스는 땅속 깊은 곳에서 나온다."}
  ]'::jsonb),
  ('abundant', 1, 34, '형용사', '[
    {"en":"Sunlight is abundant in the desert.","ko":"사막에는 햇빛이 풍부하다."},
    {"en":"Wind energy is abundant near the coast.","ko":"풍력 에너지는 해안 근처에 풍부하다."},
    {"en":"The region has abundant natural resources.","ko":"그 지역은 풍부한 천연자원을 가지고 있다."}
  ]'::jsonb),
  ('utility pole', 1, 34, '명사구', '[
    {"en":"The utility pole carries electricity to our houses.","ko":"그 전신주는 우리 집으로 전기를 전달한다."},
    {"en":"A bird built a nest on the utility pole.","ko":"새 한 마리가 전신주에 둥지를 지었다."},
    {"en":"Workers fixed the utility pole after the storm.","ko":"근로자들은 폭풍 후 전신주를 고쳤다."}
  ]'::jsonb),
  ('solar collector', 1, 34, '명사구', '[
    {"en":"The solar collector gathers energy from the sun.","ko":"태양열 집열기는 태양으로부터 에너지를 모은다."},
    {"en":"We installed a solar collector on our roof.","ko":"우리는 지붕에 태양열 집열기를 설치했다."},
    {"en":"The school uses a solar collector to heat water.","ko":"학교는 물을 데우기 위해 태양열 집열기를 사용한다."}
  ]'::jsonb),
  ('transmission tower', 1, 34, '명사구', '[
    {"en":"The transmission tower carries electricity across the country.","ko":"그 송전탑은 전국으로 전기를 전달한다."},
    {"en":"We saw a tall transmission tower near the highway.","ko":"우리는 고속도로 근처에서 높은 송전탑을 보았다."},
    {"en":"Workers checked the transmission tower for safety.","ko":"근로자들은 안전을 위해 송전탑을 점검했다."}
  ]'::jsonb),
  ('radioactive', 1, 34, '형용사', '[
    {"en":"Radioactive materials must be handled very carefully.","ko":"방사성 물질은 매우 조심스럽게 다뤄져야 한다."},
    {"en":"The scientist studied radioactive elements in the lab.","ko":"그 과학자는 실험실에서 방사성 원소를 연구했다."},
    {"en":"Some rocks contain radioactive substances.","ko":"어떤 바위들은 방사성 물질을 포함한다."}
  ]'::jsonb),
  ('power line', 1, 34, '명사구', '[
    {"en":"The power line brings electricity to our village.","ko":"그 송전선은 우리 마을로 전기를 가져온다."},
    {"en":"A tree fell on the power line during the storm.","ko":"폭풍 중에 나무 한 그루가 송전선 위로 쓰러졌다."},
    {"en":"Workers repaired the broken power line quickly.","ko":"근로자들은 끊어진 송전선을 빠르게 수리했다."}
  ]'::jsonb),
  ('conserve', 1, 34, '동사', '[
    {"en":"We should conserve energy at home.","ko":"우리는 집에서 에너지를 아껴야 한다."},
    {"en":"Turning off lights helps conserve electricity.","ko":"불을 끄는 것은 전기를 절약하는 데 도움이 된다."},
    {"en":"The town works to conserve water during summer.","ko":"그 마을은 여름 동안 물을 아끼기 위해 노력한다."}
  ]'::jsonb),
  ('efficiency', 1, 34, '명사', '[
    {"en":"The new machine has high efficiency.","ko":"그 새 기계는 효율이 높다."},
    {"en":"We improved the efficiency of our energy use.","ko":"우리는 에너지 사용의 효율을 향상시켰다."},
    {"en":"Efficiency is important when saving power.","ko":"전력을 절약할 때 효율이 중요하다."}
  ]'::jsonb),
  ('crisis', 1, 34, '명사', '[
    {"en":"The town faced a water crisis last year.","ko":"그 마을은 작년에 물 위기에 직면했다."},
    {"en":"An energy crisis can affect the whole country.","ko":"에너지 위기는 나라 전체에 영향을 줄 수 있다."},
    {"en":"We learned how to handle a crisis calmly.","ko":"우리는 위기를 침착하게 다루는 법을 배웠다."}
  ]'::jsonb),
  ('authorized', 1, 34, '형용사', '[
    {"en":"Only authorized workers can enter the power plant.","ko":"허가된 근로자만 발전소에 들어갈 수 있다."},
    {"en":"The teacher gave authorized students a special pass.","ko":"선생님은 허가받은 학생들에게 특별 출입증을 주었다."},
    {"en":"This is an authorized area for staff only.","ko":"이곳은 직원만을 위한 허가된 구역이다."}
  ]'::jsonb),
  ('be made up of', 1, 34, '동사구', '[
    {"en":"The battery is made up of several small cells.","ko":"그 배터리는 여러 개의 작은 셀들로 구성되어 있다."},
    {"en":"Our team is made up of ten students.","ko":"우리 팀은 열 명의 학생들로 이루어져 있다."},
    {"en":"The tower is made up of strong metal parts.","ko":"그 탑은 강한 금속 부품들로 구성되어 있다."}
  ]'::jsonb),
  ('turn into', 1, 34, '동사구', '[
    {"en":"Wind can turn into electricity through a windmill.","ko":"바람은 풍차를 통해 전기로 바뀔 수 있다."},
    {"en":"Water can turn into ice in winter.","ko":"물은 겨울에 얼음으로 변할 수 있다."},
    {"en":"The old factory turned into a science museum.","ko":"그 오래된 공장은 과학 박물관으로 바뀌었다."}
  ]'::jsonb),
  ('and so on', 1, 34, '부사구', '[
    {"en":"We need pens, notebooks, and so on for school.","ko":"우리는 학교를 위해 펜, 공책 등등이 필요하다."},
    {"en":"The store sells fruit, vegetables, and so on.","ko":"그 가게는 과일, 채소 등등을 판매한다."},
    {"en":"She studies math, science, English, and so on.","ko":"그녀는 수학, 과학, 영어 등등을 공부한다."}
  ]'::jsonb),
  ('exam', 1, 35, '명사', '[
    {"en":"I need to study hard for my exam.","ko":"나는 시험을 위해 열심히 공부해야 한다."},
    {"en":"The exam covers three chapters from our textbook.","ko":"그 시험은 교과서의 세 챕터를 다룬다."},
    {"en":"She felt nervous before the math exam.","ko":"그녀는 수학 시험 전에 긴장했다."}
  ]'::jsonb),
  ('college', 1, 35, '명사', '[
    {"en":"My sister wants to go to college next year.","ko":"언니는 내년에 대학에 가고 싶어 한다."},
    {"en":"He studies engineering at college.","ko":"그는 대학에서 공학을 공부한다."},
    {"en":"College life is different from high school life.","ko":"대학 생활은 고등학교 생활과 다르다."}
  ]'::jsonb),
  ('university', 1, 35, '명사', '[
    {"en":"She was accepted to a famous university.","ko":"그녀는 유명한 대학교에 합격했다."},
    {"en":"My brother studies science at a big university.","ko":"형은 큰 대학교에서 과학을 공부한다."},
    {"en":"We visited the university library last weekend.","ko":"우리는 지난 주말에 대학교 도서관을 방문했다."}
  ]'::jsonb),
  ('elementary', 1, 35, '형용사', '[
    {"en":"My little sister goes to elementary school.","ko":"내 여동생은 초등학교에 다닌다."},
    {"en":"We learned elementary math skills first.","ko":"우리는 먼저 기초적인 수학 기술을 배웠다."},
    {"en":"The elementary lesson was easy to understand.","ko":"그 기초 수업은 이해하기 쉬웠다."}
  ]'::jsonb),
  ('tutor', 1, 35, '명사', '[
    {"en":"My tutor helps me with English homework.","ko":"나의 가정교사는 영어 숙제를 도와준다."},
    {"en":"She works as a math tutor after school.","ko":"그녀는 방과 후에 수학 가정교사로 일한다."},
    {"en":"The tutor explained the lesson very clearly.","ko":"그 개인 지도 교사는 수업을 매우 명확하게 설명했다."}
  ]'::jsonb),
  ('discuss', 1, 35, '동사', '[
    {"en":"We discussed our project in class today.","ko":"우리는 오늘 수업에서 우리의 프로젝트를 토론했다."},
    {"en":"Let''s discuss this topic with our group.","ko":"이 주제를 우리 그룹과 토론해 보자."},
    {"en":"The students discussed the story with the teacher.","ko":"학생들은 선생님과 그 이야기에 대해 토론했다."}
  ]'::jsonb),
  ('explain', 1, 35, '동사', '[
    {"en":"The teacher explained the math problem carefully.","ko":"선생님은 그 수학 문제를 신중하게 설명해 주셨다."},
    {"en":"Can you explain this rule to me again?","ko":"이 규칙을 다시 설명해 줄 수 있나요?"},
    {"en":"She explained her idea to the whole class.","ko":"그녀는 반 전체에게 자신의 생각을 설명했다."}
  ]'::jsonb),
  ('memorize', 1, 35, '동사', '[
    {"en":"We need to memorize twenty new words.","ko":"우리는 새로운 단어 스무 개를 암기해야 한다."},
    {"en":"She memorized the poem for class.","ko":"그녀는 수업을 위해 그 시를 암기했다."},
    {"en":"It is hard to memorize a long list at once.","ko":"긴 목록을 한 번에 암기하는 것은 어렵다."}
  ]'::jsonb),
  ('entrance', 1, 35, '명사', '[
    {"en":"Students wait at the school entrance every morning.","ko":"학생들은 매일 아침 학교 입구에서 기다린다."},
    {"en":"The entrance exam was harder than expected.","ko":"그 입학 시험은 예상보다 어려웠다."},
    {"en":"We met at the entrance of the library.","ko":"우리는 도서관 입구에서 만났다."}
  ]'::jsonb),
  ('educate', 1, 35, '동사', '[
    {"en":"Schools educate students about many subjects.","ko":"학교는 학생들에게 여러 과목에 대해 교육한다."},
    {"en":"Parents try to educate their children well.","ko":"부모들은 자녀들을 잘 교육하려고 노력한다."},
    {"en":"The program educates people about the environment.","ko":"그 프로그램은 사람들에게 환경에 대해 교육한다."}
  ]'::jsonb),
  ('kindergarten', 1, 35, '명사', '[
    {"en":"My little brother started kindergarten this year.","ko":"내 남동생은 올해 유치원을 시작했다."},
    {"en":"Kindergarten students learn through play.","ko":"유치원 학생들은 놀이를 통해 배운다."},
    {"en":"She teaches at a small kindergarten.","ko":"그녀는 작은 유치원에서 가르친다."}
  ]'::jsonb),
  ('graduate', 1, 35, '동사', '[
    {"en":"My sister will graduate from high school next year.","ko":"언니는 내년에 고등학교를 졸업할 것이다."},
    {"en":"He graduated from college with good grades.","ko":"그는 좋은 성적으로 대학을 졸업했다."},
    {"en":"We are excited to graduate this spring.","ko":"우리는 이번 봄에 졸업하게 되어 신난다."}
  ]'::jsonb),
  ('knowledge', 1, 35, '명사', '[
    {"en":"Reading books gives us a lot of knowledge.","ko":"책을 읽는 것은 우리에게 많은 지식을 준다."},
    {"en":"The teacher shared her knowledge with the class.","ko":"그 선생님은 학급과 자신의 지식을 나누었다."},
    {"en":"Science gives us knowledge about the world.","ko":"과학은 우리에게 세상에 대한 지식을 준다."}
  ]'::jsonb),
  ('counsel', 1, 35, '명사/동사', '[
    {"en":"The school counselor gave us good counsel.","ko":"학교 상담사는 우리에게 좋은 조언을 해주었다."},
    {"en":"She counseled the student about his future plans.","ko":"그녀는 그 학생에게 미래 계획에 대해 상담해 주었다."},
    {"en":"We went to the teacher for counsel about the project.","ko":"우리는 프로젝트에 대해 상담받기 위해 선생님을 찾아갔다."}
  ]'::jsonb),
  ('admit', 1, 35, '동사', '[
    {"en":"The university admitted her this year.","ko":"그 대학은 올해 그녀를 입학시켰다."},
    {"en":"He admitted that he made a mistake.","ko":"그는 자신이 실수했다는 것을 인정했다."},
    {"en":"The school admits new students every March.","ko":"그 학교는 매년 3월에 신입생을 받아들인다."}
  ]'::jsonb),
  ('evaluate', 1, 35, '동사', '[
    {"en":"The teacher will evaluate our projects next week.","ko":"선생님은 다음 주에 우리의 프로젝트를 평가할 것이다."},
    {"en":"We evaluated our own work before the class.","ko":"우리는 수업 전에 우리 자신의 작업을 평가했다."},
    {"en":"The test evaluates how much students have learned.","ko":"그 시험은 학생들이 얼마나 배웠는지 평가한다."}
  ]'::jsonb),
  ('submit', 1, 35, '동사', '[
    {"en":"Please submit your homework by Friday.","ko":"금요일까지 숙제를 제출해 주세요."},
    {"en":"She submitted her report to the teacher.","ko":"그녀는 선생님께 보고서를 제출했다."},
    {"en":"We submitted our project on time.","ko":"우리는 제시간에 프로젝트를 제출했다."}
  ]'::jsonb),
  ('lecture', 1, 35, '명사', '[
    {"en":"The professor gave an interesting lecture today.","ko":"그 교수님은 오늘 흥미로운 강의를 했다."},
    {"en":"We took notes during the lecture.","ko":"우리는 강의 중에 필기를 했다."},
    {"en":"The lecture lasted for about an hour.","ko":"그 강의는 약 한 시간 동안 지속되었다."}
  ]'::jsonb),
  ('instruct', 1, 35, '동사', '[
    {"en":"The coach instructed us how to swim.","ko":"코치는 우리에게 수영하는 방법을 가르쳤다."},
    {"en":"The teacher instructed the students to open their books.","ko":"선생님은 학생들에게 책을 펴라고 지시했다."},
    {"en":"He instructed the new students about school rules.","ko":"그는 신입생들에게 학교 규칙에 대해 가르쳤다."}
  ]'::jsonb),
  ('absent', 1, 35, '형용사', '[
    {"en":"Three students were absent from class today.","ko":"오늘 세 명의 학생이 수업에 결석했다."},
    {"en":"She was absent because she had a cold.","ko":"그녀는 감기에 걸려서 결석했다."},
    {"en":"Being absent too often can hurt your grades.","ko":"너무 자주 결석하는 것은 성적에 해로울 수 있다."}
  ]'::jsonb),
  ('attend', 1, 35, '동사', '[
    {"en":"All students must attend the morning meeting.","ko":"모든 학생들은 아침 조회에 참석해야 한다."},
    {"en":"She attends a music class every Saturday.","ko":"그녀는 매주 토요일 음악 수업에 참석한다."},
    {"en":"We attended the school festival together.","ko":"우리는 함께 학교 축제에 참석했다."}
  ]'::jsonb),
  ('semester', 1, 35, '명사', '[
    {"en":"The new semester starts in March.","ko":"새 학기는 3월에 시작한다."},
    {"en":"We have four exams this semester.","ko":"우리는 이번 학기에 네 번의 시험이 있다."},
    {"en":"Her grades improved this semester.","ko":"그녀의 성적은 이번 학기에 향상되었다."}
  ]'::jsonb),
  ('alternative', 1, 35, '명사/형용사', '[
    {"en":"Walking is a good alternative to driving.","ko":"걷는 것은 운전에 대한 좋은 대안이다."},
    {"en":"The teacher gave us an alternative way to solve the problem.","ko":"선생님은 우리에게 그 문제를 풀 대안적인 방법을 주셨다."},
    {"en":"We chose an alternative topic for our project.","ko":"우리는 프로젝트를 위해 대안적인 주제를 선택했다."}
  ]'::jsonb),
  ('academic', 1, 35, '형용사', '[
    {"en":"She has a strong academic record.","ko":"그녀는 뛰어난 학업 성적을 가지고 있다."},
    {"en":"Our school focuses on academic success.","ko":"우리 학교는 학업적 성공에 중점을 둔다."},
    {"en":"He joined an academic club at school.","ko":"그는 학교에서 학술 동아리에 가입했다."}
  ]'::jsonb),
  ('pupil', 1, 35, '명사', '[
    {"en":"Every pupil in the class has a textbook.","ko":"학급의 모든 학생은 교과서를 가지고 있다."},
    {"en":"The teacher praised the pupil for good work.","ko":"선생님은 그 학생을 훌륭한 성과에 대해 칭찬했다."},
    {"en":"The young pupil raised her hand to answer.","ko":"그 어린 학생은 답하기 위해 손을 들었다."}
  ]'::jsonb),
  ('intelligence', 1, 35, '명사', '[
    {"en":"She showed great intelligence during the exam.","ko":"그녀는 시험 중에 뛰어난 지능을 보여주었다."},
    {"en":"Reading books can improve your intelligence.","ko":"독서는 지능을 향상시킬 수 있다."},
    {"en":"The teacher said intelligence is not the only key to success.","ko":"선생님은 지능이 성공의 유일한 열쇠는 아니라고 말씀하셨다."}
  ]'::jsonb),
  ('scholarship', 1, 35, '명사', '[
    {"en":"She received a scholarship for her good grades.","ko":"그녀는 좋은 성적으로 장학금을 받았다."},
    {"en":"Many students apply for a scholarship every year.","ko":"많은 학생들이 매년 장학금을 신청한다."},
    {"en":"The scholarship helped him pay for college.","ko":"그 장학금은 그가 대학 학비를 내는 데 도움을 주었다."}
  ]'::jsonb),
  ('encourage', 1, 35, '동사', '[
    {"en":"Our teacher always encourages us to try harder.","ko":"우리 선생님은 항상 우리가 더 열심히 노력하도록 격려하신다."},
    {"en":"She encouraged me to join the science club.","ko":"그녀는 내가 과학 동아리에 가입하도록 격려했다."},
    {"en":"Parents should encourage their children to read.","ko":"부모는 자녀들이 책을 읽도록 격려해야 한다."}
  ]'::jsonb),
  ('pay attention to', 1, 35, '동사구', '[
    {"en":"Please pay attention to the teacher during class.","ko":"수업 중에 선생님께 주의를 기울여 주세요."},
    {"en":"We should pay attention to safety rules.","ko":"우리는 안전 규칙에 주의를 기울여야 한다."},
    {"en":"She paid attention to every word of the lecture.","ko":"그녀는 강의의 모든 단어에 주의를 기울였다."}
  ]'::jsonb),
  ('play a role (in)', 1, 35, '동사구', '[
    {"en":"Reading plays an important role in learning.","ko":"독서는 학습에서 중요한 역할을 한다."},
    {"en":"Teachers play a big role in students'' lives.","ko":"선생님들은 학생들의 삶에서 큰 역할을 한다."},
    {"en":"Practice plays a role in improving your skills.","ko":"연습은 실력을 향상시키는 데 역할을 한다."}
  ]'::jsonb),
  ('classroom', 1, 36, '명사', '[
    {"en":"Our classroom has twenty-five desks.","ko":"우리 교실에는 책상이 스물다섯 개 있다."},
    {"en":"The classroom was quiet during the test.","ko":"그 교실은 시험 중에 조용했다."},
    {"en":"We decorated our classroom for the festival.","ko":"우리는 축제를 위해 교실을 장식했다."}
  ]'::jsonb),
  ('chalk', 1, 36, '명사', '[
    {"en":"The teacher wrote the answer with chalk.","ko":"선생님은 분필로 답을 쓰셨다."},
    {"en":"We ran out of white chalk today.","ko":"오늘 흰 분필이 다 떨어졌다."},
    {"en":"The chalk broke while she was writing.","ko":"그녀가 글을 쓰는 동안 분필이 부러졌다."}
  ]'::jsonb),
  ('textbook', 1, 36, '명사', '[
    {"en":"Please open your textbook to page ten.","ko":"교과서 10페이지를 펴 주세요."},
    {"en":"I forgot my English textbook at home.","ko":"나는 영어 교과서를 집에 두고 왔다."},
    {"en":"The textbook explains the lesson clearly.","ko":"그 교과서는 수업 내용을 명확하게 설명한다."}
  ]'::jsonb),
  ('partner', 1, 36, '명사', '[
    {"en":"Choose a partner for the group activity.","ko":"그룹 활동을 위해 짝을 선택하세요."},
    {"en":"My partner and I finished the project together.","ko":"나의 파트너와 나는 함께 프로젝트를 끝냈다."},
    {"en":"She was my partner during the science experiment.","ko":"그녀는 과학 실험 동안 나의 파트너였다."}
  ]'::jsonb),
  ('homework', 1, 36, '명사', '[
    {"en":"I finished my homework before dinner.","ko":"나는 저녁 식사 전에 숙제를 끝냈다."},
    {"en":"Our teacher gave us a lot of homework today.","ko":"우리 선생님은 오늘 우리에게 많은 숙제를 주셨다."},
    {"en":"She helped her brother with his homework.","ko":"그녀는 남동생의 숙제를 도와주었다."}
  ]'::jsonb),
  ('math', 1, 36, '명사', '[
    {"en":"Math is my favorite subject at school.","ko":"수학은 학교에서 내가 가장 좋아하는 과목이다."},
    {"en":"We have a math test next Monday.","ko":"우리는 다음 주 월요일에 수학 시험이 있다."},
    {"en":"He is very good at math.","ko":"그는 수학을 매우 잘한다."}
  ]'::jsonb),
  ('conversation', 1, 36, '명사', '[
    {"en":"We had a nice conversation about our hobbies.","ko":"우리는 취미에 대해 즐거운 대화를 나누었다."},
    {"en":"The teacher started a conversation about the story.","ko":"선생님은 그 이야기에 대한 대화를 시작하셨다."},
    {"en":"Practicing conversation helps improve your English.","ko":"대화 연습은 영어 실력 향상에 도움이 된다."}
  ]'::jsonb),
  ('classmate', 1, 36, '명사', '[
    {"en":"My classmate helped me find my book.","ko":"내 학급 친구는 내가 책을 찾는 것을 도와주었다."},
    {"en":"We invited all our classmates to the party.","ko":"우리는 모든 학급 친구들을 파티에 초대했다."},
    {"en":"She sat next to her classmate during lunch.","ko":"그녀는 점심시간에 학급 친구 옆에 앉았다."}
  ]'::jsonb),
  ('senior', 1, 36, '명사/형용사', '[
    {"en":"My sister is a senior in high school.","ko":"언니는 고등학교 3학년이다."},
    {"en":"Senior students helped the new students find their classrooms.","ko":"선배 학생들은 신입생들이 교실을 찾는 것을 도와주었다."},
    {"en":"He looked up to the senior members of the club.","ko":"그는 동아리의 선배들을 존경했다."}
  ]'::jsonb),
  ('locker', 1, 36, '명사', '[
    {"en":"I keep my books in my locker.","ko":"나는 사물함에 책을 보관한다."},
    {"en":"She forgot the number of her locker.","ko":"그녀는 자기 사물함 번호를 잊어버렸다."},
    {"en":"Please close your locker after class.","ko":"수업 후에 사물함을 닫아 주세요."}
  ]'::jsonb),
  ('chalk board', 1, 36, '명사구', '[
    {"en":"The teacher wrote the homework on the chalk board.","ko":"선생님은 칠판에 숙제를 쓰셨다."},
    {"en":"We copied the notes from the chalk board.","ko":"우리는 칠판에서 필기를 베꼈다."},
    {"en":"The chalk board was full of math problems.","ko":"그 칠판은 수학 문제로 가득했다."}
  ]'::jsonb),
  ('marker', 1, 36, '명사', '[
    {"en":"She used a red marker to underline the words.","ko":"그녀는 단어에 밑줄을 긋기 위해 빨간 마커펜을 사용했다."},
    {"en":"Please bring a marker for the poster project.","ko":"포스터 프로젝트를 위해 마커펜을 가져와 주세요."},
    {"en":"The marker ran out of ink.","ko":"그 마커펜은 잉크가 다 떨어졌다."}
  ]'::jsonb),
  ('club', 1, 36, '명사', '[
    {"en":"I joined the science club this semester.","ko":"나는 이번 학기에 과학 동아리에 가입했다."},
    {"en":"Our club meets every Wednesday afternoon.","ko":"우리 동아리는 매주 수요일 오후에 모인다."},
    {"en":"She is the leader of the music club.","ko":"그녀는 음악 동아리의 대표이다."}
  ]'::jsonb),
  ('hall', 1, 36, '명사', '[
    {"en":"Students gathered in the hall for the ceremony.","ko":"학생들은 행사를 위해 강당에 모였다."},
    {"en":"We practiced our play in the school hall.","ko":"우리는 학교 강당에서 연극을 연습했다."},
    {"en":"The hall was decorated for the school festival.","ko":"그 강당은 학교 축제를 위해 장식되었다."}
  ]'::jsonb),
  ('subject', 1, 36, '명사', '[
    {"en":"English is my favorite subject.","ko":"영어는 내가 가장 좋아하는 과목이다."},
    {"en":"We study six subjects every day.","ko":"우리는 매일 여섯 과목을 공부한다."},
    {"en":"Science is a difficult subject for some students.","ko":"과학은 몇몇 학생들에게 어려운 과목이다."}
  ]'::jsonb),
  ('project', 1, 36, '명사', '[
    {"en":"Our group finished the science project on time.","ko":"우리 그룹은 제시간에 과학 프로젝트를 끝냈다."},
    {"en":"The teacher gave us a new project this week.","ko":"선생님은 이번 주에 우리에게 새로운 프로젝트를 주셨다."},
    {"en":"We worked hard on our history project.","ko":"우리는 역사 프로젝트를 위해 열심히 노력했다."}
  ]'::jsonb),
  ('library', 1, 36, '명사', '[
    {"en":"I borrowed three books from the library.","ko":"나는 도서관에서 책 세 권을 빌렸다."},
    {"en":"The library is quiet, so students can study well.","ko":"도서관은 조용해서 학생들이 공부를 잘할 수 있다."},
    {"en":"We spent the afternoon reading in the library.","ko":"우리는 도서관에서 책을 읽으며 오후를 보냈다."}
  ]'::jsonb),
  ('P.E.', 1, 36, '명사', '[
    {"en":"We have P.E. class on Tuesdays and Thursdays.","ko":"우리는 화요일과 목요일에 체육 수업이 있다."},
    {"en":"I really enjoy P.E. because I like sports.","ko":"나는 스포츠를 좋아해서 체육을 정말 즐긴다."},
    {"en":"Our P.E. teacher taught us how to play basketball.","ko":"우리 체육 선생님은 우리에게 농구하는 법을 가르쳐 주셨다."}
  ]'::jsonb),
  ('hallway', 1, 36, '명사', '[
    {"en":"Please walk quietly in the hallway.","ko":"복도에서는 조용히 걸어 주세요."},
    {"en":"Students lined up in the hallway before class.","ko":"학생들은 수업 전에 복도에 줄을 섰다."},
    {"en":"The hallway was decorated with student artwork.","ko":"그 복도는 학생들의 미술 작품으로 장식되었다."}
  ]'::jsonb),
  ('principal', 1, 36, '명사', '[
    {"en":"The principal spoke to the students this morning.","ko":"교장 선생님은 오늘 아침 학생들에게 말씀하셨다."},
    {"en":"We met the new principal at the assembly.","ko":"우리는 집회에서 새 교장 선생님을 만났다."},
    {"en":"The principal welcomed the new students warmly.","ko":"교장 선생님은 신입생들을 따뜻하게 환영해 주셨다."}
  ]'::jsonb),
  ('schoolmate', 1, 36, '명사', '[
    {"en":"I ran into an old schoolmate at the park.","ko":"나는 공원에서 오래된 학교 친구를 우연히 만났다."},
    {"en":"My schoolmate and I studied together for the exam.","ko":"내 학교 친구와 나는 시험을 위해 함께 공부했다."},
    {"en":"We stayed in touch with our schoolmates after graduation.","ko":"우리는 졸업 후에도 학교 친구들과 연락을 유지했다."}
  ]'::jsonb),
  ('homeroom teacher', 1, 36, '명사구', '[
    {"en":"Our homeroom teacher checks our attendance every morning.","ko":"우리 담임 선생님은 매일 아침 출석을 확인하신다."},
    {"en":"I talked to my homeroom teacher about my grades.","ko":"나는 담임 선생님과 성적에 대해 이야기했다."},
    {"en":"The homeroom teacher organized a class trip.","ko":"담임 선생님은 학급 여행을 준비하셨다."}
  ]'::jsonb),
  ('auditorium', 1, 36, '명사', '[
    {"en":"The school concert was held in the auditorium.","ko":"학교 콘서트는 강당에서 열렸다."},
    {"en":"We watched the play in the auditorium.","ko":"우리는 강당에서 그 연극을 보았다."},
    {"en":"The auditorium was full of parents and students.","ko":"그 강당은 학부모와 학생들로 가득했다."}
  ]'::jsonb),
  ('cafeteria', 1, 36, '명사', '[
    {"en":"We eat lunch in the school cafeteria.","ko":"우리는 학교 구내식당에서 점심을 먹는다."},
    {"en":"The cafeteria serves rice and soup every day.","ko":"그 구내식당은 매일 밥과 국을 제공한다."},
    {"en":"My friends and I meet at the cafeteria before class.","ko":"내 친구들과 나는 수업 전에 구내식당에서 만난다."}
  ]'::jsonb),
  ('assignment', 1, 36, '명사', '[
    {"en":"Our teacher gave us a reading assignment.","ko":"우리 선생님은 우리에게 읽기 과제를 주셨다."},
    {"en":"I finished my assignment before the deadline.","ko":"나는 마감일 전에 과제를 끝냈다."},
    {"en":"The assignment was about our favorite animals.","ko":"그 과제는 우리가 좋아하는 동물에 관한 것이었다."}
  ]'::jsonb),
  ('laboratory', 1, 36, '명사', '[
    {"en":"We did an experiment in the science laboratory.","ko":"우리는 과학 실습실에서 실험을 했다."},
    {"en":"The laboratory has many tools for experiments.","ko":"그 실습실에는 실험을 위한 많은 도구가 있다."},
    {"en":"Students must wear safety glasses in the laboratory.","ko":"학생들은 실습실에서 안전 안경을 착용해야 한다."}
  ]'::jsonb),
  ('bulletin board', 1, 36, '명사구', '[
    {"en":"The schedule is posted on the bulletin board.","ko":"일정표는 게시판에 게시되어 있다."},
    {"en":"We put our artwork on the classroom bulletin board.","ko":"우리는 교실 게시판에 우리의 작품을 붙였다."},
    {"en":"Check the bulletin board for important school news.","ko":"중요한 학교 소식을 위해 게시판을 확인하세요."}
  ]'::jsonb),
  ('ask ~ a favor', 1, 36, '동사구', '[
    {"en":"Can I ask you a favor before class?","ko":"수업 전에 부탁 하나 해도 될까요?"},
    {"en":"She asked her friend a favor to borrow a pen.","ko":"그녀는 펜을 빌리기 위해 친구에게 부탁을 했다."},
    {"en":"I asked my teacher a favor about the assignment.","ko":"나는 선생님께 과제에 대해 부탁을 드렸다."}
  ]'::jsonb),
  ('get along with', 1, 36, '동사구', '[
    {"en":"I get along with all my classmates.","ko":"나는 모든 학급 친구들과 잘 지낸다."},
    {"en":"She gets along well with her new partner.","ko":"그녀는 새로운 파트너와 잘 지낸다."},
    {"en":"It is important to get along with your teammates.","ko":"팀원들과 잘 지내는 것은 중요하다."}
  ]'::jsonb),
  ('take part in', 1, 36, '동사구', '[
    {"en":"Many students took part in the school festival.","ko":"많은 학생들이 학교 축제에 참여했다."},
    {"en":"I want to take part in the science club activities.","ko":"나는 과학 동아리 활동에 참여하고 싶다."},
    {"en":"She took part in the singing contest last year.","ko":"그녀는 작년에 노래 대회에 참가했다."}
  ]'::jsonb)
) as t(word, level, study_day, pos, examples)
where v.word = t.word and v.level = t.level and v.study_day = t.study_day;
