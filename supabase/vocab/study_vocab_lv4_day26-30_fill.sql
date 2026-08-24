-- SAP 1기 대시보드: Study 탭 — Lv.4(고등 Basic) Day 26~30 품사/예문 채우기 (150단어, 마지막 배치).
update public.vocab_words v
set part_of_speech = t.pos, example_sentences = t.examples, updated_at = now()
from (values
  ('account', 4, 26, '명사/동사', '[
    {"en":"She opened a new bank account last week.","ko":"그녀는 지난주에 새 은행 계좌를 개설했다."},
    {"en":"He couldn''t account for the missing money.","ko":"그는 없어진 돈에 대해 설명할 수 없었다."},
    {"en":"Please take his age into account when you judge him.","ko":"그를 판단할 때 그의 나이를 고려해 주세요."}
  ]'::jsonb),
  ('correct', 4, 26, '형용사/동사', '[
    {"en":"Please choose the correct answer from the list.","ko":"목록에서 올바른 답을 고르세요."},
    {"en":"The teacher corrected our grammar mistakes.","ko":"선생님은 우리의 문법 실수를 고쳐주셨다."},
    {"en":"Your assumption is correct.","ko":"당신의 추측은 맞다."}
  ]'::jsonb),
  ('charge', 4, 26, '동사/명사', '[
    {"en":"The hotel charges an extra fee for breakfast.","ko":"그 호텔은 아침 식사에 추가 요금을 청구한다."},
    {"en":"I need to charge my phone before we leave.","ko":"우리가 떠나기 전에 휴대전화를 충전해야 한다."},
    {"en":"She is in charge of the school festival this year.","ko":"그녀는 올해 학교 축제를 책임지고 있다."}
  ]'::jsonb),
  ('check', 4, 26, '동사/명사', '[
    {"en":"Please check your answers before submitting the test.","ko":"시험지를 제출하기 전에 답을 확인하세요."},
    {"en":"He paid the bill by check.","ko":"그는 수표로 계산을 했다."},
    {"en":"The doctor gave him a thorough check.","ko":"의사는 그에게 철저한 검사를 해주었다."}
  ]'::jsonb),
  ('air', 4, 26, '명사/동사', '[
    {"en":"Fresh air helps you think more clearly.","ko":"신선한 공기는 생각을 더 맑게 해준다."},
    {"en":"The plane rose slowly into the air.","ko":"비행기는 천천히 공중으로 떠올랐다."},
    {"en":"The show will air next Monday night.","ko":"그 프로그램은 다음 월요일 밤에 방송될 것이다."}
  ]'::jsonb),
  ('tip', 4, 26, '명사', '[
    {"en":"She gave me a useful tip for studying English.","ko":"그녀는 나에게 영어 공부에 유용한 조언을 해주었다."},
    {"en":"We left a generous tip for the waiter.","ko":"우리는 웨이터에게 후한 팁을 남겼다."},
    {"en":"He touched the tip of the pencil to the paper.","ko":"그는 연필 끝을 종이에 댔다."}
  ]'::jsonb),
  ('still', 4, 26, '형용사/부사', '[
    {"en":"The lake was perfectly still in the early morning.","ko":"이른 아침 호수는 완전히 고요했다."},
    {"en":"She is still studying for the exam.","ko":"그녀는 여전히 시험공부를 하고 있다."},
    {"en":"This method is still more effective than the old one.","ko":"이 방법이 예전 방법보다 훨씬 더 효과적이다."}
  ]'::jsonb),
  ('custom', 4, 26, '명사/형용사', '[
    {"en":"It is a local custom to remove your shoes indoors.","ko":"실내에서 신발을 벗는 것은 그 지역의 관습이다."},
    {"en":"The desk was made to custom specifications.","ko":"그 책상은 맞춤 사양으로 제작되었다."},
    {"en":"Bowing is a traditional custom in many Asian countries.","ko":"절하는 것은 많은 아시아 국가들의 전통적인 관습이다."}
  ]'::jsonb),
  ('regard', 4, 26, '명사/동사', '[
    {"en":"She is highly regarded by her colleagues.","ko":"그녀는 동료들에게 높이 평가받는다."},
    {"en":"Please give my regards to your parents.","ko":"부모님께 안부 전해 주세요."},
    {"en":"With regard to the schedule, nothing has changed.","ko":"일정에 관해서는 아무것도 바뀌지 않았다."}
  ]'::jsonb),
  ('develop', 4, 26, '동사', '[
    {"en":"Children develop language skills quickly at a young age.","ko":"아이들은 어린 나이에 언어 능력을 빠르게 발달시킨다."},
    {"en":"The company is developing a new mobile application.","ko":"그 회사는 새로운 모바일 애플리케이션을 개발하고 있다."},
    {"en":"Reading habits developed in childhood often last a lifetime.","ko":"어린 시절에 형성된 독서 습관은 평생 지속되는 경우가 많다."}
  ]'::jsonb),
  ('sacred', 4, 26, '형용사', '[
    {"en":"The temple is considered a sacred place by many people.","ko":"그 사원은 많은 사람들에게 신성한 장소로 여겨진다."},
    {"en":"They treated the ancient book as a sacred object.","ko":"그들은 그 고대 책을 신성한 물건으로 취급했다."},
    {"en":"Family time is sacred to her, and she never misses it.","ko":"가족과의 시간은 그녀에게 신성해서 그녀는 절대 거르지 않는다."}
  ]'::jsonb),
  ('scared', 4, 26, '형용사', '[
    {"en":"The little boy was scared of the dark.","ko":"그 어린 소년은 어둠을 무서워했다."},
    {"en":"She felt scared when she heard the strange noise.","ko":"그녀는 이상한 소리를 들었을 때 무서웠다."},
    {"en":"Don''t be scared; the exam is not as hard as you think.","ko":"무서워하지 마세요; 시험은 생각보다 어렵지 않아요."}
  ]'::jsonb),
  ('vain', 4, 26, '형용사', '[
    {"en":"All his efforts to persuade her were in vain.","ko":"그녀를 설득하려는 그의 모든 노력은 헛되었다."},
    {"en":"He is too vain to admit his mistakes.","ko":"그는 너무 허영심이 많아서 실수를 인정하지 못한다."},
    {"en":"She made a vain attempt to fix the broken machine.","ko":"그녀는 고장 난 기계를 고치려는 헛된 시도를 했다."}
  ]'::jsonb),
  ('vein', 4, 26, '명사', '[
    {"en":"Blood flows back to the heart through the veins.","ko":"혈액은 정맥을 통해 심장으로 되돌아간다."},
    {"en":"The doctor found a vein to draw blood from.","ko":"의사는 채혈할 정맥을 찾았다."},
    {"en":"The essay continues in the same vein as the introduction.","ko":"그 에세이는 서론과 같은 맥락으로 이어진다."}
  ]'::jsonb),
  ('cite', 4, 26, '동사', '[
    {"en":"The professor cited several studies to support her theory.","ko":"교수는 자신의 이론을 뒷받침하기 위해 여러 연구를 인용했다."},
    {"en":"You must cite your sources in the research paper.","ko":"연구 논문에서는 출처를 인용해야 한다."},
    {"en":"He cited a famous poem in his speech.","ko":"그는 연설에서 유명한 시를 인용했다."}
  ]'::jsonb),
  ('site', 4, 26, '명사', '[
    {"en":"The construction site was surrounded by a tall fence.","ko":"건설 현장은 높은 울타리로 둘러싸여 있었다."},
    {"en":"They chose a quiet site for the new library.","ko":"그들은 새 도서관을 위해 조용한 부지를 선택했다."},
    {"en":"Archaeologists discovered ancient tools at the dig site.","ko":"고고학자들은 발굴 현장에서 고대 도구를 발견했다."}
  ]'::jsonb),
  ('expand', 4, 26, '동사', '[
    {"en":"The company plans to expand into overseas markets.","ko":"그 회사는 해외 시장으로 확장할 계획이다."},
    {"en":"Metal expands when it is heated.","ko":"금속은 열을 받으면 팽창한다."},
    {"en":"Reading widely helps expand your vocabulary.","ko":"폭넓게 독서하는 것은 어휘를 확장하는 데 도움이 된다."}
  ]'::jsonb),
  ('expend', 4, 26, '동사', '[
    {"en":"He expended a great deal of energy finishing the project.","ko":"그는 프로젝트를 끝내는 데 많은 에너지를 소비했다."},
    {"en":"The team expended all its resources on the final match.","ko":"그 팀은 결승전에 모든 자원을 소비했다."},
    {"en":"Try not to expend too much time on minor details.","ko":"사소한 세부 사항에 너무 많은 시간을 쓰지 않도록 하세요."}
  ]'::jsonb),
  ('bald', 4, 26, '형용사', '[
    {"en":"The man in the photo is completely bald.","ko":"사진 속 남자는 완전히 대머리이다."},
    {"en":"He started going bald in his early thirties.","ko":"그는 30대 초반에 머리가 빠지기 시작했다."},
    {"en":"The bald eagle is a symbol of the United States.","ko":"흰머리수리는 미국의 상징이다."}
  ]'::jsonb),
  ('bold', 4, 26, '형용사', '[
    {"en":"She made a bold decision to study abroad alone.","ko":"그녀는 혼자 유학을 가겠다는 대담한 결정을 내렸다."},
    {"en":"The important words are printed in bold letters.","ko":"중요한 단어들은 굵은 글씨로 인쇄되어 있다."},
    {"en":"It was a bold move to challenge the champion.","ko":"챔피언에게 도전한 것은 대담한 행동이었다."}
  ]'::jsonb),
  ('considerable', 4, 26, '형용사', '[
    {"en":"The new policy brought about considerable change in the office.","ko":"새 정책은 사무실에 상당한 변화를 가져왔다."},
    {"en":"It takes a considerable amount of time to master a language.","ko":"언어를 완전히 익히는 데는 상당한 시간이 걸린다."},
    {"en":"She has considerable experience in teaching young children.","ko":"그녀는 어린아이들을 가르친 상당한 경험이 있다."}
  ]'::jsonb),
  ('considerate', 4, 26, '형용사', '[
    {"en":"He is always considerate of other people''s feelings.","ko":"그는 항상 다른 사람의 감정을 배려한다."},
    {"en":"It was considerate of you to help the elderly neighbor.","ko":"나이 든 이웃을 도와준 것은 사려 깊은 행동이었다."},
    {"en":"A considerate leader listens carefully to the team.","ko":"사려 깊은 리더는 팀의 말을 주의 깊게 듣는다."}
  ]'::jsonb),
  ('famine', 4, 26, '명사', '[
    {"en":"The drought led to a severe famine in the region.","ko":"가뭄은 그 지역에 심각한 기근을 초래했다."},
    {"en":"Many countries sent food aid during the famine.","ko":"많은 나라들이 기근 동안 식량 원조를 보냈다."},
    {"en":"The novel describes a family struggling through a famine.","ko":"그 소설은 기근 속에서 고군분투하는 한 가족을 묘사한다."}
  ]'::jsonb),
  ('feminine', 4, 26, '형용사', '[
    {"en":"She prefers wearing soft, feminine colors.","ko":"그녀는 부드럽고 여성스러운 색을 즐겨 입는다."},
    {"en":"The dress has a very feminine design.","ko":"그 드레스는 매우 여성스러운 디자인이다."},
    {"en":"In some languages, nouns are classified as masculine or feminine.","ko":"일부 언어에서는 명사가 남성형이나 여성형으로 분류된다."}
  ]'::jsonb),
  ('pray', 4, 26, '동사', '[
    {"en":"They prayed for good weather on the day of the trip.","ko":"그들은 여행 가는 날 좋은 날씨를 기도했다."},
    {"en":"She prays every morning before school.","ko":"그녀는 학교 가기 전 매일 아침 기도한다."},
    {"en":"We pray that everyone stays safe during the storm.","ko":"우리는 폭풍우 동안 모두가 안전하기를 기도한다."}
  ]'::jsonb),
  ('prey', 4, 26, '명사', '[
    {"en":"The eagle swooped down to catch its prey.","ko":"독수리는 먹이를 잡기 위해 급강하했다."},
    {"en":"Small animals often fall prey to larger predators.","ko":"작은 동물들은 종종 더 큰 포식자의 먹이가 된다."},
    {"en":"The lion patiently waited for its prey to approach.","ko":"사자는 먹이가 다가오기를 참을성 있게 기다렸다."}
  ]'::jsonb),
  ('vague', 4, 26, '형용사', '[
    {"en":"His explanation was too vague to understand clearly.","ko":"그의 설명은 너무 모호해서 명확히 이해할 수 없었다."},
    {"en":"She gave a vague answer to avoid the question.","ko":"그녀는 그 질문을 피하려고 모호한 대답을 했다."},
    {"en":"I only have a vague memory of that day.","ko":"나는 그날에 대해 희미한 기억만 있다."}
  ]'::jsonb),
  ('vogue', 4, 26, '명사', '[
    {"en":"Long skirts are back in vogue this season.","ko":"긴 치마가 이번 시즌에 다시 유행하고 있다."},
    {"en":"That style of music was in vogue in the 1980s.","ko":"그 음악 스타일은 1980년대에 유행했다."},
    {"en":"Minimalist design has come into vogue recently.","ko":"최소주의 디자인이 최근에 유행하게 되었다."}
  ]'::jsonb),
  ('sometime', 4, 26, '부사', '[
    {"en":"Let us have lunch together sometime next week.","ko":"다음 주 언젠가 함께 점심을 먹자."},
    {"en":"I hope to visit Europe sometime in the future.","ko":"나는 미래의 언젠가 유럽을 방문하고 싶다."},
    {"en":"The report was published sometime last spring.","ko":"그 보고서는 지난봄 언젠가 발행되었다."}
  ]'::jsonb),
  ('sometimes', 4, 26, '부사', '[
    {"en":"Sometimes it is better to stay silent.","ko":"때때로 침묵을 지키는 것이 더 낫다."},
    {"en":"She sometimes walks to school instead of taking the bus.","ko":"그녀는 가끔 버스를 타는 대신 학교까지 걸어간다."},
    {"en":"Sometimes the simplest solution is the best one.","ko":"때때로 가장 간단한 해결책이 최선이다."}
  ]'::jsonb),
  ('bear', 4, 27, '명사/동사', '[
    {"en":"A brown bear wandered near the campsite.","ko":"갈색 곰 한 마리가 캠프장 근처를 돌아다녔다."},
    {"en":"I can''t bear this noise any longer.","ko":"나는 이 소음을 더 이상 참을 수 없다."},
    {"en":"The tree bears fruit every autumn.","ko":"그 나무는 매년 가을에 열매를 맺는다."}
  ]'::jsonb),
  ('contract', 4, 27, '명사/동사', '[
    {"en":"Both companies signed the contract yesterday.","ko":"양사는 어제 계약서에 서명했다."},
    {"en":"The metal pipe will contract in cold weather.","ko":"그 금속 파이프는 추운 날씨에 수축할 것이다."},
    {"en":"The company plans to contract with a new supplier next month.","ko":"그 회사는 다음 달에 새로운 공급업체와 계약할 계획이다."}
  ]'::jsonb),
  ('bill', 4, 27, '명사', '[
    {"en":"He forgot to pay the electricity bill.","ko":"그는 전기 요금 청구서를 내는 것을 잊었다."},
    {"en":"She paid for the coffee with a ten-dollar bill.","ko":"그녀는 10달러 지폐로 커피값을 냈다."},
    {"en":"The new bill was passed by the parliament.","ko":"새 법안이 의회에서 통과되었다."}
  ]'::jsonb),
  ('count', 4, 27, '동사/명사', '[
    {"en":"The teacher asked the students to count the pages.","ko":"선생님은 학생들에게 페이지 수를 세라고 했다."},
    {"en":"Every vote counts in an election.","ko":"선거에서는 모든 표가 중요하다."},
    {"en":"He lost count of how many times he had read the book.","ko":"그는 그 책을 몇 번이나 읽었는지 셈을 놓쳤다."}
  ]'::jsonb),
  ('present', 4, 27, '형용사/명사', '[
    {"en":"All the students were present for the class.","ko":"모든 학생이 수업에 출석했다."},
    {"en":"At present, she is working on a new project.","ko":"현재 그녀는 새 프로젝트를 진행하고 있다."},
    {"en":"He gave a small present to his friend on her birthday.","ko":"그는 친구 생일에 작은 선물을 주었다."}
  ]'::jsonb),
  ('grave', 4, 27, '명사/형용사', '[
    {"en":"They laid flowers on the grave every year.","ko":"그들은 매년 무덤에 꽃을 놓았다."},
    {"en":"The doctor warned that the situation was grave.","ko":"의사는 상황이 심각하다고 경고했다."},
    {"en":"He made a grave mistake by ignoring the warning.","ko":"그는 경고를 무시하는 중대한 실수를 저질렀다."}
  ]'::jsonb),
  ('subject', 4, 27, '명사', '[
    {"en":"Math is her favorite subject at school.","ko":"수학은 그녀가 학교에서 가장 좋아하는 과목이다."},
    {"en":"The article covers the subject of climate change.","ko":"그 기사는 기후 변화라는 주제를 다룬다."},
    {"en":"Each subject in the study was asked the same questions.","ko":"그 연구의 각 피실험자는 같은 질문을 받았다."}
  ]'::jsonb),
  ('draw', 4, 27, '동사', '[
    {"en":"She drew a picture of the mountain village.","ko":"그녀는 산골 마을 그림을 그렸다."},
    {"en":"The magnet drew the metal pieces toward it.","ko":"자석은 금속 조각들을 자기 쪽으로 끌어당겼다."},
    {"en":"He drew a large crowd with his speech.","ko":"그는 연설로 많은 관중을 끌어모았다."}
  ]'::jsonb),
  ('sound', 4, 27, '동사/형용사/명사', '[
    {"en":"The bell made a loud sound.","ko":"종이 큰 소리를 냈다."},
    {"en":"That sounds like a good idea.","ko":"그거 좋은 생각처럼 들린다."},
    {"en":"He gave sound advice based on years of experience.","ko":"그는 수년간의 경험을 바탕으로 건전한 조언을 해주었다."}
  ]'::jsonb),
  ('hold', 4, 27, '동사', '[
    {"en":"She held her little brother''s hand tightly.","ko":"그녀는 남동생의 손을 꽉 잡았다."},
    {"en":"The school will hold a sports day next month.","ko":"학교는 다음 달에 체육 대회를 개최할 것이다."},
    {"en":"This bottle holds about two liters of water.","ko":"이 병은 약 2리터의 물을 담을 수 있다."}
  ]'::jsonb),
  ('absorb', 4, 27, '동사', '[
    {"en":"Plants absorb water through their roots.","ko":"식물은 뿌리를 통해 물을 흡수한다."},
    {"en":"She was completely absorbed in her book.","ko":"그녀는 완전히 책에 몰두해 있었다."},
    {"en":"The towel quickly absorbed the spilled juice.","ko":"그 수건은 엎질러진 주스를 빠르게 흡수했다."}
  ]'::jsonb),
  ('absurd', 4, 27, '형용사', '[
    {"en":"It seemed absurd to cancel the trip over a small mistake.","ko":"작은 실수 때문에 여행을 취소하는 것은 터무니없어 보였다."},
    {"en":"His excuse for being late was completely absurd.","ko":"그가 지각한 이유는 완전히 터무니없었다."},
    {"en":"The idea of finishing the project in one day is absurd.","ko":"하루 만에 프로젝트를 끝낸다는 생각은 불합리하다."}
  ]'::jsonb),
  ('carve', 4, 27, '동사', '[
    {"en":"He carved a small wooden bird for his daughter.","ko":"그는 딸을 위해 작은 나무 새를 조각했다."},
    {"en":"The artist carved the statue out of marble.","ko":"그 예술가는 대리석으로 조각상을 만들었다."},
    {"en":"Someone had carved their initials into the old tree.","ko":"누군가 오래된 나무에 자신의 이니셜을 새겨 놓았다."}
  ]'::jsonb),
  ('curve', 4, 27, '명사', '[
    {"en":"The road has a sharp curve near the bridge.","ko":"그 도로는 다리 근처에서 급커브를 이룬다."},
    {"en":"She drew a smooth curve on the graph.","ko":"그녀는 그래프에 부드러운 곡선을 그렸다."},
    {"en":"The driver slowed down before the curve.","ko":"운전자는 커브 앞에서 속도를 줄였다."}
  ]'::jsonb),
  ('complement', 4, 27, '명사/동사', '[
    {"en":"The scarf complements her blue coat perfectly.","ko":"그 스카프는 그녀의 파란 코트와 완벽하게 어울린다."},
    {"en":"Good teamwork means each member''s skills complement one another.","ko":"좋은 팀워크는 각 구성원의 기술이 서로를 보완하는 것을 의미한다."},
    {"en":"The side dish served as a nice complement to the main course.","ko":"그 반찬은 주요리에 좋은 보완이 되었다."}
  ]'::jsonb),
  ('compliment', 4, 27, '명사/동사', '[
    {"en":"She thanked him for the kind compliment.","ko":"그녀는 그의 친절한 칭찬에 대해 감사했다."},
    {"en":"He complimented her on her excellent presentation.","ko":"그는 그녀의 훌륭한 발표를 칭찬했다."},
    {"en":"Receiving a compliment from the teacher made him proud.","ko":"선생님으로부터 칭찬을 받자 그는 자랑스러워했다."}
  ]'::jsonb),
  ('dairy', 4, 27, '명사/형용사', '[
    {"en":"The farm produces a variety of dairy products.","ko":"그 농장은 다양한 유제품을 생산한다."},
    {"en":"He grew up on a dairy farm in the countryside.","ko":"그는 시골의 낙농장에서 자랐다."},
    {"en":"Milk and cheese are common dairy foods.","ko":"우유와 치즈는 흔한 유제품 식품이다."}
  ]'::jsonb),
  ('diary', 4, 27, '명사', '[
    {"en":"She writes in her diary every night before bed.","ko":"그녀는 자기 전 매일 밤 일기를 쓴다."},
    {"en":"He kept a detailed diary during his trip to India.","ko":"그는 인도 여행 중 상세한 일기를 썼다."},
    {"en":"The old diary revealed many family secrets.","ko":"그 오래된 일기는 많은 가족의 비밀을 드러냈다."}
  ]'::jsonb),
  ('respectable', 4, 27, '형용사', '[
    {"en":"He comes from a respectable family in the town.","ko":"그는 그 마을에서 존경할 만한 가문 출신이다."},
    {"en":"She earned a respectable score on the exam.","ko":"그녀는 시험에서 존경할 만한 점수를 받았다."},
    {"en":"The company has built a respectable reputation over the years.","ko":"그 회사는 수년에 걸쳐 존경할 만한 평판을 쌓았다."}
  ]'::jsonb),
  ('respective', 4, 27, '형용사', '[
    {"en":"The students returned to their respective classrooms.","ko":"학생들은 각자의 교실로 돌아갔다."},
    {"en":"Each team member has respective duties to complete.","ko":"각 팀원은 각자 맡은 임무가 있다."},
    {"en":"The two leaders spoke on behalf of their respective countries.","ko":"두 지도자는 각자 자기 나라를 대표해서 발언했다."}
  ]'::jsonb),
  ('defeat', 4, 27, '동사/명사', '[
    {"en":"The home team defeated their rivals in the final match.","ko":"홈팀은 결승전에서 라이벌 팀을 물리쳤다."},
    {"en":"She accepted the defeat gracefully.","ko":"그녀는 패배를 의연하게 받아들였다."},
    {"en":"Losing the game was a bitter defeat for the young players.","ko":"그 경기에서 진 것은 어린 선수들에게 쓰라린 패배였다."}
  ]'::jsonb),
  ('defect', 4, 27, '명사', '[
    {"en":"The car was recalled because of a design defect.","ko":"그 자동차는 설계 결함 때문에 리콜되었다."},
    {"en":"Engineers found a small defect in the machine.","ko":"엔지니어들은 그 기계에서 작은 결함을 발견했다."},
    {"en":"Every person has strengths and defects.","ko":"모든 사람은 장점과 단점을 가지고 있다."}
  ]'::jsonb),
  ('principal', 4, 27, '명사/형용사', '[
    {"en":"The principal gave a speech at the graduation ceremony.","ko":"교장 선생님은 졸업식에서 연설했다."},
    {"en":"Improving public health was the principal goal of the project.","ko":"공중 보건 개선이 그 프로젝트의 주요 목표였다."},
    {"en":"She plays the principal role in the school play.","ko":"그녀는 학교 연극에서 주연을 맡는다."}
  ]'::jsonb),
  ('principle', 4, 27, '명사', '[
    {"en":"He always acts according to his own principles.","ko":"그는 항상 자신의 원칙에 따라 행동한다."},
    {"en":"The teacher explained the basic principle of gravity.","ko":"선생님은 중력의 기본 원리를 설명했다."},
    {"en":"Honesty is one of the most important principles in life.","ko":"정직함은 인생에서 가장 중요한 신념 중 하나다."}
  ]'::jsonb),
  ('acquire', 4, 27, '동사', '[
    {"en":"It takes years to acquire a new language fluently.","ko":"새로운 언어를 유창하게 습득하는 데는 몇 년이 걸린다."},
    {"en":"The museum recently acquired a rare painting.","ko":"그 박물관은 최근 희귀한 그림을 입수했다."},
    {"en":"Children acquire social skills by playing with others.","ko":"아이들은 다른 사람들과 놀면서 사회성을 습득한다."}
  ]'::jsonb),
  ('inquire', 4, 27, '동사', '[
    {"en":"She inquired about the price of the ticket.","ko":"그녀는 표 가격에 대해 물었다."},
    {"en":"He inquired whether the office was open on weekends.","ko":"그는 사무실이 주말에도 여는지 물었다."},
    {"en":"Please inquire at the front desk for more information.","ko":"자세한 정보는 안내 데스크에 문의해 주세요."}
  ]'::jsonb),
  ('require', 4, 27, '동사', '[
    {"en":"This job requires strong communication skills.","ko":"이 일은 강한 의사소통 능력을 필요로 한다."},
    {"en":"The school requires all students to wear uniforms.","ko":"그 학교는 모든 학생에게 교복 착용을 요구한다."},
    {"en":"Learning a musical instrument requires patience and practice.","ko":"악기를 배우는 것은 인내와 연습을 필요로 한다."}
  ]'::jsonb),
  ('lie-lay-lain', 4, 27, '동사', '[
    {"en":"She lay on the grass and watched the clouds.","ko":"그녀는 잔디에 누워 구름을 바라보았다."},
    {"en":"He has lain in bed all morning because he is sick.","ko":"그는 아파서 아침 내내 침대에 누워 있었다."},
    {"en":"The dog likes to lie by the fireplace in winter.","ko":"그 개는 겨울에 벽난로 옆에 눕는 것을 좋아한다."}
  ]'::jsonb),
  ('lie-lied-lied', 4, 27, '동사/명사', '[
    {"en":"He lied about his age to enter the contest.","ko":"그는 대회에 참가하려고 나이를 속였다."},
    {"en":"It is never a good idea to lie to your parents.","ko":"부모님께 거짓말을 하는 것은 절대 좋은 생각이 아니다."},
    {"en":"She admitted that she had lied to protect her friend.","ko":"그녀는 친구를 보호하려고 거짓말을 했다고 인정했다."}
  ]'::jsonb),
  ('lay-laid-laid', 4, 27, '동사', '[
    {"en":"She laid the baby gently in the crib.","ko":"그녀는 아기를 아기 침대에 조심스럽게 눕혔다."},
    {"en":"The hen laid five eggs this morning.","ko":"그 암탉은 오늘 아침 알을 다섯 개 낳았다."},
    {"en":"He laid the book on the table before leaving.","ko":"그는 떠나기 전에 책을 탁자 위에 놓았다."}
  ]'::jsonb),
  ('rate', 4, 28, '명사', '[
    {"en":"The unemployment rate has dropped this year.","ko":"올해 실업률이 떨어졌다."},
    {"en":"The hotel offers a special rate for students.","ko":"그 호텔은 학생들에게 특별 요금을 제공한다."},
    {"en":"The car was traveling at a high rate of speed.","ko":"그 차는 빠른 속도로 달리고 있었다."}
  ]'::jsonb),
  ('fine', 4, 28, '동사/형용사', '[
    {"en":"He was fined for parking illegally.","ko":"그는 불법 주차로 벌금을 부과받았다."},
    {"en":"The sand on this beach is very fine.","ko":"이 해변의 모래는 매우 곱다."},
    {"en":"She felt fine after a good night''s sleep.","ko":"그녀는 숙면을 취한 후 컨디션이 좋았다."}
  ]'::jsonb),
  ('term', 4, 28, '명사', '[
    {"en":"The president serves a four-year term.","ko":"대통령은 4년 임기를 지낸다."},
    {"en":"We will start the new term next Monday.","ko":"우리는 다음 주 월요일에 새 학기를 시작한다."},
    {"en":"The scientific term was unfamiliar to most students.","ko":"그 과학 용어는 대부분의 학생들에게 낯설었다."}
  ]'::jsonb),
  ('press', 4, 28, '동사/명사', '[
    {"en":"Please press the button to open the door.","ko":"문을 열려면 버튼을 눌러 주세요."},
    {"en":"The press gathered outside the building for the interview.","ko":"언론은 인터뷰를 위해 건물 밖에 모였다."},
    {"en":"Her parents pressed her to choose a practical major.","ko":"그녀의 부모님은 그녀에게 실용적인 전공을 선택하라고 강요했다."}
  ]'::jsonb),
  ('condition', 4, 28, '명사', '[
    {"en":"The old car is still in good condition.","ko":"그 오래된 차는 여전히 상태가 좋다."},
    {"en":"Workers demanded better working conditions.","ko":"노동자들은 더 나은 근무 조건을 요구했다."},
    {"en":"You may join the club on one condition.","ko":"한 가지 조건으로 그 동아리에 가입할 수 있다."}
  ]'::jsonb),
  ('solution', 4, 28, '명사', '[
    {"en":"They finally found a solution to the problem.","ko":"그들은 마침내 그 문제에 대한 해결책을 찾았다."},
    {"en":"The scientist mixed the chemical into a solution.","ko":"과학자는 그 화학 물질을 용액에 섞었다."},
    {"en":"There is no simple solution to climate change.","ko":"기후 변화에는 간단한 해결책이 없다."}
  ]'::jsonb),
  ('conduct', 4, 28, '동사/명사', '[
    {"en":"The scientists conducted an experiment to test the theory.","ko":"과학자들은 그 이론을 검증하기 위해 실험을 수행했다."},
    {"en":"He was chosen to conduct the school orchestra.","ko":"그는 학교 오케스트라를 지휘하도록 선택되었다."},
    {"en":"The students were praised for their good conduct.","ko":"학생들은 훌륭한 행동으로 칭찬받았다."}
  ]'::jsonb),
  ('fair', 4, 28, '형용사/명사', '[
    {"en":"The teacher tried to be fair to every student.","ko":"선생님은 모든 학생에게 공평하려고 노력했다."},
    {"en":"We visited the science fair at the community center.","ko":"우리는 지역 센터에서 열린 과학 박람회를 방문했다."},
    {"en":"It took a fair amount of effort to finish the project.","ko":"그 프로젝트를 끝내는 데 상당한 노력이 들었다."}
  ]'::jsonb),
  ('book', 4, 28, '명사/동사', '[
    {"en":"She borrowed three books from the library.","ko":"그녀는 도서관에서 책 세 권을 빌렸다."},
    {"en":"We booked a table at the restaurant for dinner.","ko":"우리는 저녁 식사를 위해 식당에 자리를 예약했다."},
    {"en":"He booked his flight two months in advance.","ko":"그는 두 달 전에 미리 항공편을 예약했다."}
  ]'::jsonb),
  ('current', 4, 28, '형용사/명사', '[
    {"en":"The current situation requires immediate action.","ko":"현재 상황은 즉각적인 조치를 필요로 한다."},
    {"en":"The swimmer was swept away by the strong current.","ko":"그 수영하는 사람은 강한 물살에 휩쓸렸다."},
    {"en":"Electric current flows through the wire.","ko":"전류는 전선을 통해 흐른다."}
  ]'::jsonb),
  ('expire', 4, 28, '동사', '[
    {"en":"My passport will expire next year.","ko":"내 여권은 내년에 만료된다."},
    {"en":"The coupon expires at the end of this month.","ko":"그 쿠폰은 이번 달 말에 만료된다."},
    {"en":"You should renew your license before it expires.","ko":"면허가 만료되기 전에 갱신해야 한다."}
  ]'::jsonb),
  ('inspire', 4, 28, '동사', '[
    {"en":"Her courage inspired everyone in the room.","ko":"그녀의 용기는 방 안의 모든 사람에게 영감을 주었다."},
    {"en":"The teacher inspired students to pursue their dreams.","ko":"그 선생님은 학생들이 꿈을 좇도록 격려했다."},
    {"en":"The beautiful scenery inspired the painter to create a new work.","ko":"아름다운 경치는 그 화가에게 새로운 작품을 만들도록 영감을 주었다."}
  ]'::jsonb),
  ('globe', 4, 28, '명사', '[
    {"en":"Students traveled around the globe for the exchange program.","ko":"학생들은 교환 프로그램을 위해 전 세계를 돌아다녔다."},
    {"en":"A globe sat on the teacher''s desk.","ko":"지구본이 선생님 책상 위에 놓여 있었다."},
    {"en":"News of the event spread across the globe.","ko":"그 사건 소식은 전 세계로 퍼졌다."}
  ]'::jsonb),
  ('glove', 4, 28, '명사', '[
    {"en":"She wore warm gloves to protect her hands from the cold.","ko":"그녀는 추위로부터 손을 보호하기 위해 따뜻한 장갑을 꼈다."},
    {"en":"The doctor put on a pair of gloves before the exam.","ko":"의사는 검사 전에 장갑 한 켤레를 착용했다."},
    {"en":"He lost one glove on his way home.","ko":"그는 집에 오는 길에 장갑 한 짝을 잃어버렸다."}
  ]'::jsonb),
  ('loyal', 4, 28, '형용사', '[
    {"en":"The dog remained loyal to its owner for years.","ko":"그 개는 몇 년 동안 주인에게 충실했다."},
    {"en":"She has always been a loyal friend to me.","ko":"그녀는 항상 나에게 충실한 친구였다."},
    {"en":"The company rewards its loyal customers with special discounts.","ko":"그 회사는 충성 고객에게 특별 할인으로 보답한다."}
  ]'::jsonb),
  ('royal', 4, 28, '형용사', '[
    {"en":"The royal family attended the ceremony.","ko":"왕실 가족이 그 행사에 참석했다."},
    {"en":"Tourists visited the royal palace in the old city.","ko":"관광객들은 옛 도시의 왕궁을 방문했다."},
    {"en":"The museum displays royal treasures from centuries ago.","ko":"그 박물관은 수 세기 전의 왕실 보물들을 전시한다."}
  ]'::jsonb),
  ('desert', 4, 28, '명사', '[
    {"en":"Very few plants can survive in the desert.","ko":"사막에서는 아주 적은 수의 식물만이 살아남을 수 있다."},
    {"en":"The camel is well adapted to life in the desert.","ko":"낙타는 사막 생활에 잘 적응되어 있다."},
    {"en":"They crossed the desert during the cool hours of the night.","ko":"그들은 밤의 서늘한 시간 동안 사막을 건넜다."}
  ]'::jsonb),
  ('dessert', 4, 28, '명사', '[
    {"en":"We ordered chocolate cake for dessert.","ko":"우리는 후식으로 초콜릿 케이크를 주문했다."},
    {"en":"She always saves room for dessert after dinner.","ko":"그녀는 항상 저녁 식사 후 디저트를 위한 자리를 남겨둔다."},
    {"en":"The restaurant serves a delicious fruit dessert.","ko":"그 식당은 맛있는 과일 디저트를 제공한다."}
  ]'::jsonb),
  ('emergency', 4, 28, '명사', '[
    {"en":"In case of emergency, call this number immediately.","ko":"비상시에는 즉시 이 번호로 전화하세요."},
    {"en":"The hospital has a separate entrance for emergencies.","ko":"그 병원은 응급 상황을 위한 별도의 입구가 있다."},
    {"en":"The pilot made an emergency landing due to bad weather.","ko":"조종사는 악천후 때문에 비상 착륙을 했다."}
  ]'::jsonb),
  ('emergence', 4, 28, '명사', '[
    {"en":"The emergence of new technology changed the way we work.","ko":"새로운 기술의 출현은 우리가 일하는 방식을 바꾸었다."},
    {"en":"Scientists studied the emergence of the disease in the region.","ko":"과학자들은 그 지역에서 그 질병의 발생을 연구했다."},
    {"en":"The emergence of social media transformed communication.","ko":"소셜 미디어의 출현은 의사소통 방식을 변화시켰다."}
  ]'::jsonb),
  ('terrible', 4, 28, '형용사', '[
    {"en":"The storm caused terrible damage to the town.","ko":"그 폭풍은 마을에 끔찍한 피해를 입혔다."},
    {"en":"I have a terrible headache today.","ko":"나는 오늘 심한 두통이 있다."},
    {"en":"It was a terrible mistake to leave the door unlocked.","ko":"문을 잠그지 않고 나간 것은 끔찍한 실수였다."}
  ]'::jsonb),
  ('terrific', 4, 28, '형용사', '[
    {"en":"She did a terrific job on her presentation.","ko":"그녀는 발표를 아주 훌륭하게 해냈다."},
    {"en":"We had a terrific time at the beach.","ko":"우리는 해변에서 아주 멋진 시간을 보냈다."},
    {"en":"The view from the mountain top was terrific.","ko":"산 정상에서 본 경치는 정말 멋졌다."}
  ]'::jsonb),
  ('personal', 4, 28, '형용사', '[
    {"en":"She kept her personal opinions to herself during the meeting.","ko":"그녀는 회의 중에 개인적인 의견을 드러내지 않았다."},
    {"en":"That is a personal matter I would rather not discuss.","ko":"그것은 내가 논의하고 싶지 않은 개인적인 문제이다."},
    {"en":"He gave the letter a personal touch by writing it by hand.","ko":"그는 손으로 편지를 써서 개인적인 느낌을 더했다."}
  ]'::jsonb),
  ('personnel', 4, 28, '명사', '[
    {"en":"The company hired additional personnel for the busy season.","ko":"그 회사는 성수기를 위해 추가 인력을 고용했다."},
    {"en":"All military personnel must follow strict rules.","ko":"모든 군 인력은 엄격한 규칙을 따라야 한다."},
    {"en":"She works in the personnel department of the firm.","ko":"그녀는 그 회사의 인사부에서 일한다."}
  ]'::jsonb),
  ('conscience', 4, 28, '명사', '[
    {"en":"His conscience wouldn''t let him ignore the mistake.","ko":"그의 양심이 그 실수를 못 본 척하게 두지 않았다."},
    {"en":"She followed her conscience and told the truth.","ko":"그녀는 양심에 따라 진실을 말했다."},
    {"en":"It is important to act according to your conscience.","ko":"자신의 양심에 따라 행동하는 것은 중요하다."}
  ]'::jsonb),
  ('conscious', 4, 28, '형용사', '[
    {"en":"The patient became conscious a few hours after the surgery.","ko":"환자는 수술 몇 시간 후 의식을 되찾았다."},
    {"en":"She is very conscious of how others see her.","ko":"그녀는 다른 사람들이 자신을 어떻게 보는지 매우 의식한다."},
    {"en":"He made a conscious effort to speak more slowly.","ko":"그는 더 천천히 말하려고 의식적인 노력을 기울였다."}
  ]'::jsonb),
  ('calculate', 4, 28, '동사', '[
    {"en":"Please calculate the total cost of the trip.","ko":"여행의 총비용을 계산해 주세요."},
    {"en":"The engineer calculated the exact weight of the bridge.","ko":"엔지니어는 그 다리의 정확한 무게를 계산했다."},
    {"en":"It is hard to calculate how much time we will need.","ko":"우리에게 얼마나 많은 시간이 필요할지 계산하기 어렵다."}
  ]'::jsonb),
  ('circulate', 4, 28, '동사', '[
    {"en":"Blood circulates throughout the body.","ko":"혈액은 몸 전체를 순환한다."},
    {"en":"Rumors began to circulate around the school.","ko":"소문이 학교 곳곳에 퍼지기 시작했다."},
    {"en":"Fresh air circulated through the open windows.","ko":"신선한 공기가 열린 창문을 통해 순환했다."}
  ]'::jsonb),
  ('raise', 4, 28, '동사', '[
    {"en":"She raised her hand to ask a question.","ko":"그녀는 질문을 하기 위해 손을 들었다."},
    {"en":"The company decided to raise the prices of its products.","ko":"그 회사는 제품 가격을 인상하기로 결정했다."},
    {"en":"They raised money for the local charity.","ko":"그들은 지역 자선 단체를 위해 모금했다."}
  ]'::jsonb),
  ('rise', 4, 28, '동사', '[
    {"en":"The sun rises in the east every morning.","ko":"태양은 매일 아침 동쪽에서 뜬다."},
    {"en":"Prices have risen sharply over the past year.","ko":"지난 한 해 동안 물가가 급격히 올랐다."},
    {"en":"Smoke rose slowly from the chimney.","ko":"연기가 굴뚝에서 천천히 피어올랐다."}
  ]'::jsonb),
  ('company', 4, 29, '명사', '[
    {"en":"He works for a large technology company.","ko":"그는 큰 기술 회사에서 일한다."},
    {"en":"I enjoyed her company during the long trip.","ko":"나는 긴 여행 동안 그녀와 함께 있는 것이 즐거웠다."},
    {"en":"She invited some friends over for company on the weekend.","ko":"그녀는 주말에 함께할 친구들을 초대했다."}
  ]'::jsonb),
  ('article', 4, 29, '명사', '[
    {"en":"I read an interesting article about renewable energy.","ko":"나는 재생 에너지에 관한 흥미로운 기사를 읽었다."},
    {"en":"Each article of the contract was carefully reviewed.","ko":"계약서의 각 조항은 신중하게 검토되었다."},
    {"en":"She lost several articles of clothing during the move.","ko":"그녀는 이사 중에 옷 몇 벌을 잃어버렸다."}
  ]'::jsonb),
  ('correspond', 4, 29, '동사', '[
    {"en":"Her actions did not correspond with her words.","ko":"그녀의 행동은 말과 일치하지 않았다."},
    {"en":"The two maps correspond closely to each other.","ko":"그 두 지도는 서로 매우 일치한다."},
    {"en":"They have corresponded by letter for many years.","ko":"그들은 여러 해 동안 편지로 연락을 주고받았다."}
  ]'::jsonb),
  ('reflect', 4, 29, '동사', '[
    {"en":"The lake reflected the bright colors of the sunset.","ko":"그 호수는 노을의 밝은 색을 반사했다."},
    {"en":"Her grades reflect her hard work this semester.","ko":"그녀의 성적은 이번 학기의 노력을 반영한다."},
    {"en":"He took a moment to reflect on his choices.","ko":"그는 잠시 자신의 선택을 되돌아보았다."}
  ]'::jsonb),
  ('post', 4, 29, '명사/동사', '[
    {"en":"She posted the notice on the bulletin board.","ko":"그녀는 게시판에 공지문을 붙였다."},
    {"en":"He sent the package by post last week.","ko":"그는 지난주에 소포를 우편으로 보냈다."},
    {"en":"A wooden post marked the boundary of the field.","ko":"나무 기둥이 그 밭의 경계를 표시했다."}
  ]'::jsonb),
  ('decline', 4, 29, '동사', '[
    {"en":"Sales have declined sharply since last year.","ko":"매출이 작년 이후 급격히 감소했다."},
    {"en":"She politely declined the invitation to the party.","ko":"그녀는 파티 초대를 정중히 거절했다."},
    {"en":"The population of the small town has been declining for years.","ko":"그 작은 마을의 인구는 몇 년 동안 감소해왔다."}
  ]'::jsonb),
  ('suit', 4, 29, '명사/동사', '[
    {"en":"He wore a dark suit to the interview.","ko":"그는 면접에 어두운 색 정장을 입고 갔다."},
    {"en":"That color suits you very well.","ko":"그 색깔은 당신에게 아주 잘 어울린다."},
    {"en":"The company faced a lawsuit over the faulty product.","ko":"그 회사는 결함 있는 제품 때문에 소송에 직면했다."}
  ]'::jsonb),
  ('figure', 4, 29, '명사', '[
    {"en":"The sales figures were higher than expected this quarter.","ko":"이번 분기 매출 수치는 예상보다 높았다."},
    {"en":"She is a well-known figure in the fashion industry.","ko":"그녀는 패션 업계에서 잘 알려진 인물이다."},
    {"en":"He tried to figure out the answer to the puzzle.","ko":"그는 그 퍼즐의 답을 알아내려 했다."}
  ]'::jsonb),
  ('case', 4, 29, '명사', '[
    {"en":"In this case, we need to act quickly.","ko":"이 경우에는 빨리 행동할 필요가 있다."},
    {"en":"The lawyer studied the case carefully before the trial.","ko":"그 변호사는 재판 전에 그 사건을 신중히 검토했다."},
    {"en":"Bring an umbrella just in case it rains.","ko":"혹시 비가 올 경우를 대비해 우산을 가져가라."}
  ]'::jsonb),
  ('dismiss', 4, 29, '동사', '[
    {"en":"The teacher dismissed the class early today.","ko":"선생님은 오늘 수업을 일찍 마쳤다."},
    {"en":"He was dismissed from his job for repeated absences.","ko":"그는 잦은 결근으로 해고되었다."},
    {"en":"The judge dismissed the case due to lack of evidence.","ko":"판사는 증거 부족으로 그 사건을 기각했다."}
  ]'::jsonb),
  ('hospitality', 4, 29, '명사', '[
    {"en":"We were grateful for the warm hospitality of our hosts.","ko":"우리는 주최자들의 따뜻한 환대에 감사했다."},
    {"en":"The hotel is known for its excellent hospitality.","ko":"그 호텔은 훌륭한 접대로 유명하다."},
    {"en":"Thank you for your kind hospitality during our stay.","ko":"저희가 머무는 동안 베풀어주신 친절한 환대에 감사드립니다."}
  ]'::jsonb),
  ('hostility', 4, 29, '명사', '[
    {"en":"There was a sense of hostility between the two teams.","ko":"두 팀 사이에 적대감이 감돌았다."},
    {"en":"He tried to overcome the hostility of his coworkers.","ko":"그는 동료들의 적대감을 극복하려고 노력했다."},
    {"en":"The negotiations ended without any hostility.","ko":"그 협상은 어떠한 적대감도 없이 끝났다."}
  ]'::jsonb),
  ('state', 4, 29, '명사/동사', '[
    {"en":"The old building is in a poor state of repair.","ko":"그 오래된 건물은 수리 상태가 좋지 않다."},
    {"en":"Each state has its own laws.","ko":"각 주는 자체 법률을 가지고 있다."},
    {"en":"Please state your name and address clearly.","ko":"이름과 주소를 명확히 말씀해 주세요."}
  ]'::jsonb),
  ('statue', 4, 29, '명사', '[
    {"en":"A large statue stands in the center of the park.","ko":"큰 조각상이 공원 중앙에 서 있다."},
    {"en":"Tourists often take photos next to the famous statue.","ko":"관광객들은 종종 그 유명한 조각상 옆에서 사진을 찍는다."},
    {"en":"The artist spent a year creating the bronze statue.","ko":"그 예술가는 청동 조각상을 만드는 데 일 년을 보냈다."}
  ]'::jsonb),
  ('status', 4, 29, '명사', '[
    {"en":"Her social status changed after she became a doctor.","ko":"그녀는 의사가 된 후 사회적 지위가 바뀌었다."},
    {"en":"Please check the status of your order online.","ko":"온라인으로 주문 상태를 확인해 주세요."},
    {"en":"He achieved a high status in his field.","ko":"그는 자신의 분야에서 높은 지위를 얻었다."}
  ]'::jsonb),
  ('vacation', 4, 29, '명사', '[
    {"en":"The family went to the beach for their summer vacation.","ko":"그 가족은 여름 방학을 맞아 해변에 갔다."},
    {"en":"She took a two-week vacation from work.","ko":"그녀는 직장에서 2주간의 휴가를 냈다."},
    {"en":"During winter vacation, students often travel with their families.","ko":"겨울 방학 동안 학생들은 종종 가족과 함께 여행한다."}
  ]'::jsonb),
  ('vocation', 4, 29, '명사', '[
    {"en":"Teaching is more than a job to her; it is her vocation.","ko":"가르치는 일은 그녀에게 단순한 직업 이상, 즉 천직이다."},
    {"en":"He felt that helping others was his true vocation.","ko":"그는 다른 사람들을 돕는 것이 자신의 진정한 소명이라고 느꼈다."},
    {"en":"She chose nursing as her vocation after volunteering at a hospital.","ko":"그녀는 병원에서 자원봉사를 한 후 간호를 자신의 천직으로 선택했다."}
  ]'::jsonb),
  ('explode', 4, 29, '동사', '[
    {"en":"The old boiler exploded, but no one was hurt.","ko":"그 오래된 보일러가 폭발했지만 다친 사람은 없었다."},
    {"en":"The balloon exploded with a loud bang.","ko":"그 풍선은 큰 소리와 함께 터졌다."},
    {"en":"The population of the city exploded over the past decade.","ko":"그 도시의 인구는 지난 10년 동안 폭발적으로 증가했다."}
  ]'::jsonb),
  ('explore', 4, 29, '동사', '[
    {"en":"They explored the old castle during their vacation.","ko":"그들은 휴가 동안 오래된 성을 탐험했다."},
    {"en":"Scientists continue to explore the depths of the ocean.","ko":"과학자들은 계속해서 심해를 탐험한다."},
    {"en":"The book encourages readers to explore new ideas.","ko":"그 책은 독자들이 새로운 아이디어를 탐구하도록 격려한다."}
  ]'::jsonb),
  ('ethical', 4, 29, '형용사', '[
    {"en":"Doctors must follow strict ethical guidelines.","ko":"의사들은 엄격한 윤리 지침을 따라야 한다."},
    {"en":"It raises an ethical question about how the data was collected.","ko":"그것은 데이터가 어떻게 수집되었는지에 대한 윤리적 문제를 제기한다."},
    {"en":"The company promotes ethical business practices.","ko":"그 회사는 윤리적인 사업 관행을 장려한다."}
  ]'::jsonb),
  ('ethnic', 4, 29, '형용사', '[
    {"en":"The city is home to many different ethnic groups.","ko":"그 도시는 다양한 민족 집단의 고향이다."},
    {"en":"The festival celebrates the region''s ethnic diversity.","ko":"그 축제는 그 지역의 민족적 다양성을 기념한다."},
    {"en":"Ethnic food from around the world is sold at the market.","ko":"세계 각국의 민족 음식이 그 시장에서 판매된다."}
  ]'::jsonb),
  ('waist', 4, 29, '명사', '[
    {"en":"She tied the belt tightly around her waist.","ko":"그녀는 허리에 벨트를 단단히 묶었다."},
    {"en":"He measured his waist before buying new pants.","ko":"그는 새 바지를 사기 전에 허리 치수를 쟀다."},
    {"en":"The water reached up to his waist.","ko":"물이 그의 허리까지 차올랐다."}
  ]'::jsonb),
  ('waste', 4, 29, '명사/동사', '[
    {"en":"Don''t waste your time on things that don''t matter.","ko":"중요하지 않은 일에 시간을 낭비하지 마라."},
    {"en":"The factory produces a large amount of waste.","ko":"그 공장은 많은 양의 폐기물을 생산한다."},
    {"en":"It would be a waste to throw away good food.","ko":"좋은 음식을 버리는 것은 낭비일 것이다."}
  ]'::jsonb),
  ('precede', 4, 29, '동사', '[
    {"en":"A brief introduction preceded the main speech.","ko":"짧은 소개가 본 연설에 앞서 진행되었다."},
    {"en":"Dark clouds often precede a storm.","ko":"먹구름은 종종 폭풍에 앞서 나타난다."},
    {"en":"The appetizer preceded the main course.","ko":"애피타이저가 주요리보다 먼저 나왔다."}
  ]'::jsonb),
  ('proceed', 4, 29, '동사', '[
    {"en":"Please proceed to the next step once you are ready.","ko":"준비가 되면 다음 단계로 진행해 주세요."},
    {"en":"The meeting proceeded smoothly despite the delay.","ko":"그 회의는 지연에도 불구하고 순조롭게 진행되었다."},
    {"en":"They proceeded with the plan even though it rained.","ko":"그들은 비가 왔음에도 불구하고 계획을 진행했다."}
  ]'::jsonb),
  ('brake', 4, 29, '명사', '[
    {"en":"The driver hit the brake to avoid the dog.","ko":"운전자는 개를 피하려고 브레이크를 밟았다."},
    {"en":"The brakes on his bicycle need to be repaired.","ko":"그의 자전거 브레이크는 수리가 필요하다."},
    {"en":"She pressed the brake gently as she approached the corner.","ko":"그녀는 모퉁이에 다가가면서 브레이크를 부드럽게 밟았다."}
  ]'::jsonb),
  ('break', 4, 29, '명사/동사', '[
    {"en":"Let''s take a short break before continuing the meeting.","ko":"회의를 계속하기 전에 짧은 휴식을 취하자."},
    {"en":"The glass broke when it fell off the table.","ko":"그 유리는 탁자에서 떨어졌을 때 깨졌다."},
    {"en":"She decided to break from her usual routine and travel alone.","ko":"그녀는 평소의 일상에서 벗어나 혼자 여행하기로 했다."}
  ]'::jsonb),
  ('saw', 4, 29, '명사/동사', '[
    {"en":"He used a saw to cut the wooden plank.","ko":"그는 나무 판자를 자르기 위해 톱을 사용했다."},
    {"en":"The carpenter sawed the log into smaller pieces.","ko":"목수는 통나무를 더 작은 조각으로 톱질했다."},
    {"en":"Be careful when using an electric saw.","ko":"전기톱을 사용할 때는 조심하세요."}
  ]'::jsonb),
  ('sew', 4, 29, '동사', '[
    {"en":"My grandmother taught me how to sew a button.","ko":"할머니는 나에게 단추를 꿰매는 법을 가르쳐 주셨다."},
    {"en":"She sewed a small hole in her jacket.","ko":"그녀는 재킷의 작은 구멍을 꿰맸다."},
    {"en":"He sews his own clothes as a hobby.","ko":"그는 취미로 자신의 옷을 직접 만든다."}
  ]'::jsonb),
  ('sow', 4, 29, '동사', '[
    {"en":"Farmers sow seeds in the spring.","ko":"농부들은 봄에 씨앗을 뿌린다."},
    {"en":"They sowed wheat across the wide field.","ko":"그들은 넓은 밭에 밀을 뿌렸다."},
    {"en":"It is important to sow seeds at the right depth.","ko":"씨앗을 적절한 깊이로 심는 것이 중요하다."}
  ]'::jsonb),
  ('address', 4, 30, '명사/동사', '[
    {"en":"Please write your home address on the form.","ko":"양식에 집 주소를 적어 주세요."},
    {"en":"The president will address the nation tonight.","ko":"대통령은 오늘 밤 국민에게 연설할 것이다."},
    {"en":"We need to address this problem as soon as possible.","ko":"우리는 이 문제를 가능한 한 빨리 다뤄야 한다."}
  ]'::jsonb),
  ('spring', 4, 30, '명사', '[
    {"en":"Flowers begin to bloom in spring.","ko":"봄에는 꽃이 피기 시작한다."},
    {"en":"Cool water flowed from the mountain spring.","ko":"시원한 물이 산속 샘에서 흘러나왔다."},
    {"en":"The spring inside the clock had worn out.","ko":"시계 안의 용수철이 닳아 있었다."}
  ]'::jsonb),
  ('board', 4, 30, '명사/동사', '[
    {"en":"The teacher wrote the assignment on the board.","ko":"선생님은 칠판에 과제를 적었다."},
    {"en":"The board of directors will meet next week.","ko":"이사회는 다음 주에 회의를 할 것이다."},
    {"en":"Passengers began to board the plane at gate seven.","ko":"승객들은 7번 게이트에서 비행기에 탑승하기 시작했다."}
  ]'::jsonb),
  ('block', 4, 30, '명사/동사', '[
    {"en":"The library is two blocks away from here.","ko":"도서관은 여기서 두 블록 떨어져 있다."},
    {"en":"A fallen tree blocked the road after the storm.","ko":"폭풍 후 쓰러진 나무가 도로를 막았다."},
    {"en":"He tried to block the sunlight with his hand.","ko":"그는 손으로 햇빛을 가리려고 했다."}
  ]'::jsonb),
  ('reason', 4, 30, '명사/동사', '[
    {"en":"She explained the reason for her absence.","ko":"그녀는 결석한 이유를 설명했다."},
    {"en":"Humans are able to reason and make decisions.","ko":"인간은 이성적으로 사고하고 결정을 내릴 수 있다."},
    {"en":"There is no reason to worry about the test.","ko":"그 시험에 대해 걱정할 이유가 없다."}
  ]'::jsonb),
  ('cover', 4, 30, '동사/명사', '[
    {"en":"She covered the table with a clean cloth.","ko":"그녀는 탁자를 깨끗한 천으로 덮었다."},
    {"en":"The reporter covered the story from the scene.","ko":"그 기자는 현장에서 그 사건을 취재했다."},
    {"en":"The book has a colorful cover.","ko":"그 책은 화려한 표지를 가지고 있다."}
  ]'::jsonb),
  ('flat', 4, 30, '형용사/명사', '[
    {"en":"The land here is completely flat.","ko":"이곳의 땅은 완전히 평평하다."},
    {"en":"He noticed that one of the tires was flat.","ko":"그는 타이어 하나가 펑크 난 것을 알아챘다."},
    {"en":"They rented a small flat near the city center.","ko":"그들은 도심 근처의 작은 아파트를 세냈다."}
  ]'::jsonb),
  ('margin', 4, 30, '명사', '[
    {"en":"The team won the game by a narrow margin.","ko":"그 팀은 근소한 차이로 경기에서 승리했다."},
    {"en":"Write your notes in the margin of the page.","ko":"페이지 여백에 메모를 적으세요."},
    {"en":"The company''s profit margin increased this year.","ko":"그 회사의 이익률은 올해 증가했다."}
  ]'::jsonb),
  ('issue', 4, 30, '명사/동사', '[
    {"en":"Pollution is a serious issue in many cities.","ko":"오염은 많은 도시에서 심각한 문제이다."},
    {"en":"The government issued a new set of guidelines.","ko":"정부는 새로운 지침을 발표했다."},
    {"en":"I bought the latest issue of the magazine.","ko":"나는 그 잡지의 최신호를 구입했다."}
  ]'::jsonb),
  ('even', 4, 30, '형용사/부사', '[
    {"en":"Four and eight are even numbers.","ko":"4와 8은 짝수이다."},
    {"en":"Make sure the surface is even before you paint it.","ko":"페인트칠하기 전에 표면이 평평한지 확인하세요."},
    {"en":"Even a small mistake can cause big problems.","ko":"작은 실수조차도 큰 문제를 일으킬 수 있다."}
  ]'::jsonb),
  ('altitude', 4, 30, '명사', '[
    {"en":"The plane cruised at an altitude of ten kilometers.","ko":"그 비행기는 고도 10킬로미터에서 순항했다."},
    {"en":"It gets colder as the altitude increases.","ko":"고도가 높아질수록 더 추워진다."},
    {"en":"Climbers must adjust to the high altitude slowly.","ko":"등반가들은 높은 고도에 천천히 적응해야 한다."}
  ]'::jsonb),
  ('aptitude', 4, 30, '명사', '[
    {"en":"She has a natural aptitude for mathematics.","ko":"그녀는 수학에 타고난 소질이 있다."},
    {"en":"The test measures a student''s aptitude for science.","ko":"그 시험은 학생의 과학 적성을 측정한다."},
    {"en":"He showed great aptitude for learning languages at a young age.","ko":"그는 어린 나이에 언어 학습에 뛰어난 소질을 보였다."}
  ]'::jsonb),
  ('attitude', 4, 30, '명사', '[
    {"en":"Her positive attitude helped the whole team stay motivated.","ko":"그녀의 긍정적인 태도는 팀 전체가 의욕을 유지하도록 도왔다."},
    {"en":"He always has a respectful attitude toward his teachers.","ko":"그는 항상 선생님들에게 공손한 태도를 보인다."},
    {"en":"A change in attitude can lead to a change in behavior.","ko":"태도의 변화는 행동의 변화로 이어질 수 있다."}
  ]'::jsonb),
  ('adapt', 4, 30, '동사', '[
    {"en":"It took her a while to adapt to the new school.","ko":"그녀가 새 학교에 적응하는 데는 시간이 좀 걸렸다."},
    {"en":"Animals must adapt to survive in changing environments.","ko":"동물들은 변화하는 환경에서 살아남기 위해 적응해야 한다."},
    {"en":"The recipe was adapted to use fewer ingredients.","ko":"그 조리법은 재료를 더 적게 사용하도록 수정되었다."}
  ]'::jsonb),
  ('adopt', 4, 30, '동사', '[
    {"en":"The school decided to adopt a new teaching method.","ko":"그 학교는 새로운 교수법을 채택하기로 결정했다."},
    {"en":"The family adopted a puppy from the shelter.","ko":"그 가족은 보호소에서 강아지를 입양했다."},
    {"en":"Many companies have adopted flexible working hours.","ko":"많은 회사들이 유연 근무 시간을 채택했다."}
  ]'::jsonb),
  ('simultaneously', 4, 30, '부사', '[
    {"en":"She can speak on the phone and type simultaneously.","ko":"그녀는 전화 통화를 하면서 동시에 타이핑을 할 수 있다."},
    {"en":"The two events happened simultaneously.","ko":"그 두 사건은 동시에 발생했다."},
    {"en":"The team worked on several tasks simultaneously to save time.","ko":"그 팀은 시간을 절약하기 위해 여러 작업을 동시에 진행했다."}
  ]'::jsonb),
  ('spontaneously', 4, 30, '부사', '[
    {"en":"The crowd began to cheer spontaneously.","ko":"관중은 자발적으로 환호하기 시작했다."},
    {"en":"She spontaneously decided to visit her grandmother.","ko":"그녀는 즉흥적으로 할머니를 방문하기로 결정했다."},
    {"en":"The plants grew spontaneously without any special care.","ko":"그 식물들은 특별한 관리 없이 저절로 자랐다."}
  ]'::jsonb),
  ('council', 4, 30, '명사', '[
    {"en":"The city council approved the new park plan.","ko":"시의회는 새로운 공원 계획을 승인했다."},
    {"en":"She was elected to the student council last year.","ko":"그녀는 작년에 학생회 위원으로 선출되었다."},
    {"en":"The council will meet to discuss the budget.","ko":"의회는 예산을 논의하기 위해 모일 것이다."}
  ]'::jsonb),
  ('counsel', 4, 30, '명사/동사', '[
    {"en":"The teacher offered wise counsel to the worried student.","ko":"선생님은 걱정하는 학생에게 현명한 조언을 해주었다."},
    {"en":"She sought legal counsel before signing the contract.","ko":"그녀는 계약서에 서명하기 전에 법률 상담을 받았다."},
    {"en":"He counseled the young athlete to rest before the game.","ko":"그는 어린 운동선수에게 경기 전에 쉬라고 조언했다."}
  ]'::jsonb),
  ('flight', 4, 30, '명사', '[
    {"en":"Our flight was delayed by two hours.","ko":"우리 항공편은 두 시간 지연되었다."},
    {"en":"She booked a direct flight to London.","ko":"그녀는 런던행 직항편을 예약했다."},
    {"en":"The flight attendants greeted the passengers warmly.","ko":"승무원들은 승객들을 따뜻하게 맞이했다."}
  ]'::jsonb),
  ('fright', 4, 30, '명사', '[
    {"en":"The sudden noise gave her quite a fright.","ko":"갑작스러운 소음이 그녀를 상당히 놀라게 했다."},
    {"en":"He let out a cry of fright when the lights went out.","ko":"불이 꺼졌을 때 그는 놀라서 소리를 질렀다."},
    {"en":"The movie was full of frights and surprises.","ko":"그 영화는 놀람과 반전으로 가득했다."}
  ]'::jsonb),
  ('phase', 4, 30, '명사', '[
    {"en":"The project is now entering its final phase.","ko":"그 프로젝트는 이제 마지막 단계에 접어들고 있다."},
    {"en":"Learning a language happens in several phases.","ko":"언어 학습은 여러 단계에 걸쳐 이루어진다."},
    {"en":"The moon goes through different phases each month.","ko":"달은 매달 여러 단계를 거친다."}
  ]'::jsonb),
  ('phrase', 4, 30, '명사', '[
    {"en":"She learned a new phrase in English class today.","ko":"그녀는 오늘 영어 수업에서 새로운 표현을 배웠다."},
    {"en":"The speaker repeated the same phrase for emphasis.","ko":"연설자는 강조를 위해 같은 어구를 반복했다."},
    {"en":"Try to use the phrase in a complete sentence.","ko":"그 어구를 완전한 문장으로 사용해 보세요."}
  ]'::jsonb),
  ('mediate', 4, 30, '동사', '[
    {"en":"A neutral party was asked to mediate the dispute.","ko":"중립적인 제삼자가 그 분쟁을 중재해 달라고 요청받았다."},
    {"en":"The teacher mediated the disagreement between the two students.","ko":"선생님은 두 학생 사이의 의견 차이를 중재했다."},
    {"en":"The organization mediates conflicts between countries.","ko":"그 기구는 국가 간의 갈등을 중재한다."}
  ]'::jsonb),
  ('meditate', 4, 30, '동사', '[
    {"en":"She meditates for ten minutes every morning.","ko":"그녀는 매일 아침 10분씩 명상한다."},
    {"en":"He likes to meditate quietly before making an important decision.","ko":"그는 중요한 결정을 내리기 전에 조용히 명상하는 것을 좋아한다."},
    {"en":"Meditating regularly can help reduce stress.","ko":"규칙적으로 명상하는 것은 스트레스를 줄이는 데 도움이 될 수 있다."}
  ]'::jsonb),
  ('moral', 4, 30, '형용사/명사', '[
    {"en":"The story teaches an important moral lesson.","ko":"그 이야기는 중요한 도덕적 교훈을 가르쳐 준다."},
    {"en":"She always tries to make moral choices.","ko":"그녀는 항상 도덕적인 선택을 하려고 노력한다."},
    {"en":"The fable ends with a clear moral.","ko":"그 우화는 분명한 교훈으로 끝난다."}
  ]'::jsonb),
  ('morale', 4, 30, '명사', '[
    {"en":"The coach''s speech boosted the team''s morale before the game.","ko":"코치의 연설은 경기 전에 팀의 사기를 북돋았다."},
    {"en":"Low morale can affect the quality of work.","ko":"낮은 사기는 업무의 질에 영향을 줄 수 있다."},
    {"en":"The company organized events to improve employee morale.","ko":"그 회사는 직원 사기를 높이기 위해 행사를 마련했다."}
  ]'::jsonb),
  ('mortal', 4, 30, '형용사/명사', '[
    {"en":"All human beings are mortal.","ko":"모든 인간은 죽을 운명이다."},
    {"en":"The soldier suffered a mortal wound in battle.","ko":"그 군인은 전투에서 치명적인 부상을 입었다."},
    {"en":"The story reminds us that even heroes are mortal.","ko":"그 이야기는 영웅들조차도 죽을 운명이라는 것을 상기시켜 준다."}
  ]'::jsonb),
  ('affect', 4, 30, '동사', '[
    {"en":"The weather can affect our mood.","ko":"날씨는 우리의 기분에 영향을 줄 수 있다."},
    {"en":"Lack of sleep affects concentration in class.","ko":"수면 부족은 수업 중 집중력에 영향을 미친다."},
    {"en":"The new policy will affect thousands of workers.","ko":"그 새로운 정책은 수천 명의 근로자들에게 영향을 미칠 것이다."}
  ]'::jsonb),
  ('effect', 4, 30, '명사', '[
    {"en":"The medicine had an immediate effect on her headache.","ko":"그 약은 그녀의 두통에 즉각적인 효과가 있었다."},
    {"en":"Regular exercise has a positive effect on health.","ko":"규칙적인 운동은 건강에 긍정적인 영향을 미친다."},
    {"en":"The new law will take effect next month.","ko":"그 새 법은 다음 달부터 시행될 것이다."}
  ]'::jsonb)
) as t(word, level, study_day, pos, examples)
where v.word = t.word and v.level = t.level and v.study_day = t.study_day;
