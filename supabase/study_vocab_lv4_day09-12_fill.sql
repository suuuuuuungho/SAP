-- SAP 1기 대시보드: Study 탭 — Lv.4(고등 Basic) Day 09~12 품사/예문 채우기 (160단어).
update public.vocab_words v
set part_of_speech = t.pos, example_sentences = t.examples, updated_at = now()
from (values
  ('punish', 4, 9, '동사', '[
    {"en":"The teacher decided to punish the students who broke the rule.","ko":"선생님은 규칙을 어긴 학생들을 처벌하기로 결정했다."},
    {"en":"Parents should not punish children too harshly for small mistakes.","ko":"부모는 작은 실수에 대해 아이들을 너무 가혹하게 벌해서는 안 된다."},
    {"en":"The law punishes those who commit serious crimes.","ko":"법은 중대한 범죄를 저지른 사람들을 처벌한다."}
  ]'::jsonb),
  ('civilization', 4, 9, '명사', '[
    {"en":"Ancient Egyptian civilization built impressive pyramids along the Nile.","ko":"고대 이집트 문명은 나일강을 따라 인상적인 피라미드를 세웠다."},
    {"en":"Historians study how civilizations rise and fall over time.","ko":"역사학자들은 문명이 시간이 지나면서 어떻게 흥망성쇠를 겪는지 연구한다."},
    {"en":"Writing was one of the greatest achievements of early civilization.","ko":"문자는 초기 문명의 가장 위대한 업적 중 하나였다."}
  ]'::jsonb),
  ('construct', 4, 9, '동사', '[
    {"en":"Workers will construct a new bridge across the river.","ko":"인부들은 강을 가로지르는 새 다리를 건설할 것이다."},
    {"en":"The engineers constructed the model carefully according to the plan.","ko":"기술자들은 계획에 따라 모형을 꼼꼼하게 만들었다."},
    {"en":"It took two years to construct the entire building.","ko":"건물 전체를 짓는 데 2년이 걸렸다."}
  ]'::jsonb),
  ('remind', 4, 9, '동사', '[
    {"en":"Please remind me to bring my textbook tomorrow.","ko":"내일 교과서를 가져오도록 제게 상기시켜 주세요."},
    {"en":"This photo reminds her of her childhood home.","ko":"이 사진은 그녀에게 어린 시절 집을 생각나게 한다."},
    {"en":"The teacher reminded the class about the upcoming exam.","ko":"선생님은 반 학생들에게 다가오는 시험에 대해 상기시켰다."}
  ]'::jsonb),
  ('recall', 4, 9, '동사', '[
    {"en":"I can''t recall exactly where I left my umbrella.","ko":"우산을 어디에 두었는지 정확히 기억이 나지 않는다."},
    {"en":"She recalled her first day at the new school clearly.","ko":"그녀는 새 학교에서의 첫날을 또렷하게 회상했다."},
    {"en":"The company decided to recall the defective products.","ko":"그 회사는 결함 있는 제품을 회수하기로 결정했다."}
  ]'::jsonb),
  ('gradually', 4, 9, '부사', '[
    {"en":"The weather gradually improved throughout the weekend.","ko":"날씨는 주말 내내 점차적으로 좋아졌다."},
    {"en":"Her English skills gradually got better after months of practice.","ko":"몇 달간의 연습 끝에 그녀의 영어 실력은 서서히 향상되었다."},
    {"en":"The population of the small town gradually increased over the decades.","ko":"그 작은 마을의 인구는 수십 년에 걸쳐 점차 증가했다."}
  ]'::jsonb),
  ('delay', 4, 9, '명사/동사', '[
    {"en":"The flight was delayed due to bad weather.","ko":"그 비행기는 악천후 때문에 지연되었다."},
    {"en":"A short delay in the schedule will not cause a big problem.","ko":"일정에서의 짧은 지연은 큰 문제를 일으키지 않을 것이다."},
    {"en":"We should not delay making an important decision.","ko":"우리는 중요한 결정을 내리는 것을 미루어서는 안 된다."}
  ]'::jsonb),
  ('genetic', 4, 9, '형용사', '[
    {"en":"Genetic factors can influence a person''s height.","ko":"유전적 요인은 사람의 키에 영향을 줄 수 있다."},
    {"en":"Scientists are studying the genetic causes of the disease.","ko":"과학자들은 그 질병의 유전적 원인을 연구하고 있다."},
    {"en":"Genetic information is stored in every cell of the body.","ko":"유전 정보는 신체의 모든 세포에 저장되어 있다."}
  ]'::jsonb),
  ('sustainable', 4, 9, '형용사', '[
    {"en":"The city is promoting sustainable transportation like bicycles and buses.","ko":"그 도시는 자전거와 버스 같은 지속 가능한 교통수단을 장려하고 있다."},
    {"en":"Sustainable farming methods protect the soil for future generations.","ko":"지속 가능한 농업 방식은 미래 세대를 위해 토양을 보호한다."},
    {"en":"Companies are looking for more sustainable ways to produce energy.","ko":"기업들은 에너지를 생산하는 더 지속 가능한 방법을 찾고 있다."}
  ]'::jsonb),
  ('register', 4, 9, '동사/명사', '[
    {"en":"Students must register for the class before the deadline.","ko":"학생들은 마감일 전에 그 수업에 등록해야 한다."},
    {"en":"She registered her new address at the town office.","ko":"그녀는 동사무소에 새 주소를 등록했다."},
    {"en":"The number of visitors is recorded in the register at the entrance.","ko":"방문객 수는 입구에 있는 등록부에 기록된다."}
  ]'::jsonb),
  ('rotation', 4, 9, '명사', '[
    {"en":"The Earth''s rotation causes day and night.","ko":"지구의 자전은 낮과 밤을 만들어 낸다."},
    {"en":"Workers take turns in rotation to cover every shift.","ko":"근로자들은 모든 교대 시간을 채우기 위해 돌아가며 순환 근무를 한다."},
    {"en":"The rotation of the wheel gradually slowed down.","ko":"바퀴의 회전은 점점 느려졌다."}
  ]'::jsonb),
  ('declare', 4, 9, '동사', '[
    {"en":"The government declared a national holiday for the festival.","ko":"정부는 그 축제를 위해 국경일을 선포했다."},
    {"en":"She declared that she would never give up her dream.","ko":"그녀는 자신의 꿈을 결코 포기하지 않겠다고 선언했다."},
    {"en":"Travelers must declare certain items at customs.","ko":"여행객들은 세관에서 특정 물품을 신고해야 한다."}
  ]'::jsonb),
  ('reputation', 4, 9, '명사', '[
    {"en":"The restaurant has a good reputation for fresh seafood.","ko":"그 식당은 신선한 해산물로 좋은 평판을 가지고 있다."},
    {"en":"One mistake can damage a company''s reputation quickly.","ko":"실수 하나가 회사의 평판을 빠르게 손상시킬 수 있다."},
    {"en":"He earned a reputation as a hardworking student.","ko":"그는 성실한 학생이라는 평판을 얻었다."}
  ]'::jsonb),
  ('settle', 4, 9, '동사', '[
    {"en":"The two neighbors settled their disagreement peacefully.","ko":"두 이웃은 그들의 의견 차이를 평화롭게 해결했다."},
    {"en":"The family decided to settle in a quiet countryside town.","ko":"그 가족은 조용한 시골 마을에 정착하기로 결정했다."},
    {"en":"They finally settled on a date for the school trip.","ko":"그들은 마침내 수학여행 날짜를 정했다."}
  ]'::jsonb),
  ('agent', 4, 9, '명사', '[
    {"en":"A travel agent helped us plan our trip to Jeju.","ko":"여행사 직원이 우리의 제주도 여행 계획을 도와주었다."},
    {"en":"The real estate agent showed us three apartments.","ko":"그 부동산 중개인은 우리에게 아파트 세 곳을 보여 주었다."},
    {"en":"He works as an agent for several young athletes.","ko":"그는 여러 젊은 운동선수들의 대리인으로 일한다."}
  ]'::jsonb),
  ('guilty', 4, 9, '형용사', '[
    {"en":"The jury found the man guilty of the crime.","ko":"배심원단은 그 남자가 유죄라고 판결했다."},
    {"en":"She felt guilty for forgetting her friend''s birthday.","ko":"그녀는 친구의 생일을 잊어버려서 죄책감을 느꼈다."},
    {"en":"He looked guilty when the teacher asked who broke the window.","ko":"선생님이 누가 창문을 깼는지 물었을 때 그는 죄책감이 있어 보였다."}
  ]'::jsonb),
  ('innocent', 4, 9, '형용사', '[
    {"en":"The accused man was proven innocent in court.","ko":"그 피고인은 법정에서 무죄임이 입증되었다."},
    {"en":"Children often have an innocent way of viewing the world.","ko":"아이들은 종종 세상을 순수한 시각으로 바라본다."},
    {"en":"She gave an innocent smile when asked about the surprise party.","ko":"그녀는 깜짝 파티에 대해 질문받자 악의 없는 미소를 지었다."}
  ]'::jsonb),
  ('analyze', 4, 9, '동사', '[
    {"en":"Scientists analyze data to find patterns.","ko":"과학자들은 패턴을 찾기 위해 데이터를 분석한다."},
    {"en":"The teacher asked us to analyze the poem''s meaning.","ko":"선생님은 우리에게 그 시의 의미를 분석하라고 했다."},
    {"en":"Doctors analyzed the test results carefully.","ko":"의사들은 검사 결과를 꼼꼼하게 분석했다."}
  ]'::jsonb),
  ('crisis', 4, 9, '명사', '[
    {"en":"The country is facing an economic crisis.","ko":"그 나라는 경제 위기에 직면해 있다."},
    {"en":"Leaders met to discuss solutions to the water crisis.","ko":"지도자들은 물 부족 위기에 대한 해결책을 논의하기 위해 모였다."},
    {"en":"A sudden health crisis changed her plans completely.","ko":"갑작스러운 건강 위기가 그녀의 계획을 완전히 바꾸어 놓았다."}
  ]'::jsonb),
  ('revolution', 4, 9, '명사', '[
    {"en":"The Industrial Revolution changed the way people worked and lived.","ko":"산업 혁명은 사람들이 일하고 사는 방식을 바꾸어 놓았다."},
    {"en":"Smartphones started a revolution in how we communicate.","ko":"스마트폰은 우리가 소통하는 방식에 혁명을 일으켰다."},
    {"en":"The revolution brought major political change to the nation.","ko":"그 혁명은 그 나라에 커다란 정치적 변화를 가져왔다."}
  ]'::jsonb),
  ('commit', 4, 9, '동사', '[
    {"en":"He committed himself to studying two hours every day.","ko":"그는 매일 두 시간씩 공부하는 데 전념했다."},
    {"en":"The suspect was accused of committing a crime.","ko":"그 용의자는 범죄를 저지른 혐의를 받았다."},
    {"en":"She committed to finishing the project by Friday.","ko":"그녀는 금요일까지 그 프로젝트를 끝내기로 전념했다."}
  ]'::jsonb),
  ('comment', 4, 9, '명사/동사', '[
    {"en":"He made a positive comment about her presentation.","ko":"그는 그녀의 발표에 대해 긍정적인 의견을 말했다."},
    {"en":"The teacher commented on each student''s essay.","ko":"선생님은 각 학생의 에세이에 대해 논평했다."},
    {"en":"Please leave a comment if you have any questions.","ko":"질문이 있으면 댓글을 남겨 주세요."}
  ]'::jsonb),
  ('edit', 4, 9, '동사/명사', '[
    {"en":"She edited the article before it was published.","ko":"그녀는 기사가 게재되기 전에 그것을 편집했다."},
    {"en":"He asked his friend to edit his essay for grammar mistakes.","ko":"그는 친구에게 문법 오류를 위해 에세이를 교정해 달라고 부탁했다."},
    {"en":"The video needs some editing before we upload it.","ko":"그 영상은 업로드하기 전에 약간의 편집이 필요하다."}
  ]'::jsonb),
  ('equip', 4, 9, '동사', '[
    {"en":"The school equipped every classroom with new computers.","ko":"그 학교는 모든 교실에 새 컴퓨터를 갖추었다."},
    {"en":"Hikers should equip themselves with proper gear before climbing.","ko":"등산객들은 오르기 전에 적절한 장비를 갖추어야 한다."},
    {"en":"The course is designed to equip students with practical skills.","ko":"그 과정은 학생들에게 실용적인 기술을 갖추게 하도록 설계되었다."}
  ]'::jsonb),
  ('genius', 4, 9, '명사', '[
    {"en":"Einstein is often described as a scientific genius.","ko":"아인슈타인은 흔히 과학적 천재로 묘사된다."},
    {"en":"Her ability to solve problems quickly shows her genius.","ko":"문제를 빠르게 해결하는 그녀의 능력은 그녀의 천재성을 보여준다."},
    {"en":"It doesn''t take a genius to understand this simple rule.","ko":"이 간단한 규칙을 이해하는 데 천재가 필요하지는 않다."}
  ]'::jsonb),
  ('adequate', 4, 9, '형용사', '[
    {"en":"The hotel room was small but adequate for one night.","ko":"그 호텔 방은 작았지만 하룻밤 지내기에는 충분했다."},
    {"en":"Make sure you get adequate sleep before the exam.","ko":"시험 전에 충분한 수면을 취하도록 하세요."},
    {"en":"The budget was not adequate to cover all the expenses.","ko":"그 예산은 모든 비용을 충당하기에 충분하지 않았다."}
  ]'::jsonb),
  ('aggressive', 4, 9, '형용사', '[
    {"en":"The dog became aggressive when strangers approached.","ko":"낯선 사람들이 다가오자 그 개는 공격적으로 변했다."},
    {"en":"The company launched an aggressive marketing campaign.","ko":"그 회사는 공격적인 마케팅 캠페인을 시작했다."},
    {"en":"He apologized for being too aggressive during the discussion.","ko":"그는 토론 중에 너무 공격적이었던 것에 대해 사과했다."}
  ]'::jsonb),
  ('load', 4, 9, '명사/동사', '[
    {"en":"The truck carried a heavy load of boxes.","ko":"그 트럭은 상자로 이루어진 무거운 짐을 실었다."},
    {"en":"Please load the dishwasher before you leave.","ko":"나가기 전에 식기세척기에 그릇을 넣어 주세요."},
    {"en":"A heavy workload can cause stress if not managed well.","ko":"무거운 업무 부담은 잘 관리되지 않으면 스트레스를 유발할 수 있다."}
  ]'::jsonb),
  ('manufacture', 4, 9, '동사/명사', '[
    {"en":"The factory manufactures thousands of cars every year.","ko":"그 공장은 매년 수천 대의 자동차를 제조한다."},
    {"en":"The company changed its manufacturing process to reduce waste.","ko":"그 회사는 폐기물을 줄이기 위해 제조 공정을 바꾸었다."},
    {"en":"This product is manufactured using recycled materials.","ko":"이 제품은 재활용된 재료를 사용하여 제조된다."}
  ]'::jsonb),
  ('acknowledge', 4, 9, '동사', '[
    {"en":"He acknowledged his mistake and apologized to his friend.","ko":"그는 자신의 실수를 인정하고 친구에게 사과했다."},
    {"en":"The teacher acknowledged the students'' hard work on the project.","ko":"선생님은 그 프로젝트에 대한 학생들의 노고를 인정했다."},
    {"en":"She acknowledged receiving the letter last week.","ko":"그녀는 지난주에 편지를 받았음을 인정했다."}
  ]'::jsonb),
  ('deny', 4, 9, '동사', '[
    {"en":"He denied breaking the window, but no one believed him.","ko":"그는 창문을 깬 것을 부인했지만 아무도 그를 믿지 않았다."},
    {"en":"The company denied any responsibility for the accident.","ko":"그 회사는 그 사고에 대한 어떠한 책임도 부인했다."},
    {"en":"She couldn''t deny that she was nervous before the exam.","ko":"그녀는 시험 전에 긴장했다는 것을 부인할 수 없었다."}
  ]'::jsonb),
  ('behavior', 4, 9, '명사', '[
    {"en":"The teacher praised the students for their good behavior.","ko":"선생님은 학생들의 바른 행동을 칭찬했다."},
    {"en":"Scientists study animal behavior in the wild.","ko":"과학자들은 야생에서 동물의 행동을 연구한다."},
    {"en":"His sudden change in behavior worried his friends.","ko":"그의 갑작스러운 행동 변화는 친구들을 걱정하게 만들었다."}
  ]'::jsonb),
  ('mature', 4, 9, '형용사/동사', '[
    {"en":"She is very mature for her age.","ko":"그녀는 나이에 비해 매우 성숙하다."},
    {"en":"The fruit takes several weeks to mature fully.","ko":"그 과일은 완전히 익는 데 몇 주가 걸린다."},
    {"en":"His writing has matured a lot since last year.","ko":"그의 글쓰기는 작년 이후로 많이 성숙해졌다."}
  ]'::jsonb),
  ('thrust', 4, 9, '동사', '[
    {"en":"He thrust his hands into his pockets to keep warm.","ko":"그는 따뜻하게 있기 위해 손을 주머니에 찔러 넣었다."},
    {"en":"The rocket''s engine produced enough thrust to leave the ground.","ko":"로켓의 엔진은 지면을 떠날 만큼 충분한 추진력을 만들어냈다."},
    {"en":"She thrust the papers into his hands and walked away.","ko":"그녀는 서류를 그의 손에 밀어 넣고 걸어가 버렸다."}
  ]'::jsonb),
  ('corporate', 4, 9, '형용사', '[
    {"en":"The company has a strict corporate dress code.","ko":"그 회사는 엄격한 기업 복장 규정을 가지고 있다."},
    {"en":"Corporate profits increased significantly this year.","ko":"기업 이익이 올해 크게 증가했다."},
    {"en":"He works in the corporate office downtown.","ko":"그는 시내에 있는 회사 사무실에서 일한다."}
  ]'::jsonb),
  ('severe', 4, 9, '형용사', '[
    {"en":"The region suffered severe damage from the storm.","ko":"그 지역은 폭풍으로 심각한 피해를 입었다."},
    {"en":"The teacher was severe but fair with the students.","ko":"그 선생님은 엄격했지만 학생들에게 공정했다."},
    {"en":"He experienced severe pain after the injury.","ko":"그는 부상 이후 심한 통증을 겪었다."}
  ]'::jsonb),
  ('alert', 4, 9, '형용사/동사', '[
    {"en":"The lifeguard stayed alert while watching the swimmers.","ko":"안전요원은 수영하는 사람들을 지켜보는 동안 계속 기민한 상태를 유지했다."},
    {"en":"Officials alerted the public about the coming storm.","ko":"당국은 다가오는 폭풍에 대해 대중에게 알렸다."},
    {"en":"A good driver remains alert at all times.","ko":"훌륭한 운전자는 항상 경계 상태를 유지한다."}
  ]'::jsonb),
  ('violent', 4, 9, '형용사', '[
    {"en":"The movie contains no violent scenes.","ko":"그 영화에는 폭력적인 장면이 없다."},
    {"en":"A violent storm hit the coast last night.","ko":"어젯밤 격렬한 폭풍이 해안을 강타했다."},
    {"en":"The debate suddenly became violent in tone.","ko":"그 토론은 갑자기 격렬한 어조로 변했다."}
  ]'::jsonb),
  ('glow', 4, 9, '동사/명사', '[
    {"en":"The candle glowed softly in the dark room.","ko":"촛불이 어두운 방에서 부드럽게 빛났다."},
    {"en":"Her face glowed with happiness after the good news.","ko":"좋은 소식을 들은 후 그녀의 얼굴은 행복으로 빛났다."},
    {"en":"The warm glow of the sunset filled the sky.","ko":"노을의 따뜻한 빛이 하늘을 가득 채웠다."}
  ]'::jsonb),
  ('guarantee', 4, 9, '동사/명사', '[
    {"en":"The store guarantees a full refund within 30 days.","ko":"그 가게는 30일 이내에 전액 환불을 보증한다."},
    {"en":"There is no guarantee that the plan will succeed.","ko":"그 계획이 성공할 것이라는 보장은 없다."},
    {"en":"He guaranteed that the product would last for years.","ko":"그는 그 제품이 여러 해 동안 오래갈 것이라고 보증했다."}
  ]'::jsonb),
  ('obvious', 4, 10, '형용사', '[
    {"en":"It was obvious that she was tired after the long trip.","ko":"긴 여행 후에 그녀가 피곤하다는 것은 명백했다."},
    {"en":"The answer to the question was quite obvious.","ko":"그 질문에 대한 답은 꽤 명백했다."},
    {"en":"There is an obvious difference between the two paintings.","ko":"두 그림 사이에는 명백한 차이가 있다."}
  ]'::jsonb),
  ('apparent', 4, 10, '형용사', '[
    {"en":"It soon became apparent that the plan would not work.","ko":"그 계획이 성공하지 않을 것이라는 점이 곧 분명해졌다."},
    {"en":"There was no apparent reason for the sudden delay.","ko":"갑작스러운 지연에 대한 뚜렷한 이유는 없었다."},
    {"en":"Her apparent confidence surprised everyone in the room.","ko":"그녀의 겉으로 드러난 자신감은 방 안의 모든 사람을 놀라게 했다."}
  ]'::jsonb),
  ('persist', 4, 10, '동사', '[
    {"en":"Despite many failures, she persisted in pursuing her dream.","ko":"많은 실패에도 불구하고 그녀는 자신의 꿈을 추구하는 것을 고집했다."},
    {"en":"If the symptoms persist, you should see a doctor.","ko":"증상이 지속되면 의사의 진찰을 받아야 한다."},
    {"en":"The cold weather is expected to persist through the weekend.","ko":"추운 날씨가 주말 내내 지속될 것으로 예상된다."}
  ]'::jsonb),
  ('temporary', 4, 10, '형용사', '[
    {"en":"She took a temporary job while looking for a permanent one.","ko":"그녀는 정규직을 구하는 동안 임시직을 얻었다."},
    {"en":"The bridge repair caused a temporary road closure.","ko":"다리 보수 공사는 일시적인 도로 폐쇄를 초래했다."},
    {"en":"His memory loss was only temporary after the accident.","ko":"사고 후 그의 기억 상실은 일시적인 것에 불과했다."}
  ]'::jsonb),
  ('permanent', 4, 10, '형용사', '[
    {"en":"They are looking for a permanent solution to the problem.","ko":"그들은 그 문제에 대한 영구적인 해결책을 찾고 있다."},
    {"en":"The accident left a permanent mark on his leg.","ko":"그 사고는 그의 다리에 영구적인 흔적을 남겼다."},
    {"en":"She finally got a permanent position at the company.","ko":"그녀는 마침내 그 회사에서 정규직을 얻었다."}
  ]'::jsonb),
  ('rescue', 4, 10, '동사/명사', '[
    {"en":"Firefighters rescued the cat from the tall tree.","ko":"소방관들은 높은 나무에서 고양이를 구조했다."},
    {"en":"The rescue team arrived quickly after the accident.","ko":"구조팀은 사고 직후 신속하게 도착했다."},
    {"en":"He was rescued from the flooded building just in time.","ko":"그는 물에 잠긴 건물에서 때마침 구조되었다."}
  ]'::jsonb),
  ('embrace', 4, 10, '동사', '[
    {"en":"She embraced the new challenge with confidence.","ko":"그녀는 새로운 도전을 자신 있게 받아들였다."},
    {"en":"The company decided to embrace new technology to stay competitive.","ko":"그 회사는 경쟁력을 유지하기 위해 새로운 기술을 받아들이기로 했다."},
    {"en":"They embraced each other warmly at the airport.","ko":"그들은 공항에서 따뜻하게 서로를 껴안았다."}
  ]'::jsonb),
  ('tremble', 4, 10, '동사', '[
    {"en":"Her hands trembled slightly as she opened the letter.","ko":"편지를 열 때 그녀의 손이 약간 떨렸다."},
    {"en":"The ground seemed to tremble during the earthquake.","ko":"지진이 나는 동안 땅이 흔들리는 것 같았다."},
    {"en":"He trembled with excitement before the final match.","ko":"그는 결승전 전에 흥분으로 떨었다."}
  ]'::jsonb),
  ('ancestor', 4, 10, '명사', '[
    {"en":"Her ancestors came from a small village in the countryside.","ko":"그녀의 조상들은 시골의 작은 마을 출신이었다."},
    {"en":"We should respect the traditions passed down from our ancestors.","ko":"우리는 조상으로부터 전해 내려온 전통을 존중해야 한다."},
    {"en":"Scientists study fossils to learn about human ancestors.","ko":"과학자들은 인류 조상에 대해 알아보기 위해 화석을 연구한다."}
  ]'::jsonb),
  ('cautious', 4, 10, '형용사', '[
    {"en":"Be cautious when crossing the busy street.","ko":"번잡한 거리를 건널 때는 조심하세요."},
    {"en":"The investor was cautious about spending too much money.","ko":"그 투자자는 너무 많은 돈을 쓰는 것에 대해 신중했다."},
    {"en":"She gave a cautious answer to avoid any misunderstanding.","ko":"그녀는 오해를 피하기 위해 신중한 답변을 했다."}
  ]'::jsonb),
  ('clarify', 4, 10, '동사', '[
    {"en":"Could you clarify what you mean by that statement?","ko":"그 말이 무슨 뜻인지 명확히 해 주시겠어요?"},
    {"en":"The teacher clarified the instructions before the test began.","ko":"선생님은 시험이 시작되기 전에 지시 사항을 명확히 설명했다."},
    {"en":"He asked a question to clarify his understanding of the topic.","ko":"그는 그 주제에 대한 이해를 명확히 하기 위해 질문을 했다."}
  ]'::jsonb),
  ('drag', 4, 10, '동사', '[
    {"en":"He dragged the heavy box across the floor.","ko":"그는 무거운 상자를 바닥에 끌었다."},
    {"en":"The meeting seemed to drag on for hours.","ko":"그 회의는 몇 시간 동안 질질 끄는 것 같았다."},
    {"en":"She dragged her suitcase up the stairs.","ko":"그녀는 여행 가방을 계단 위로 끌고 올라갔다."}
  ]'::jsonb),
  ('horizontal', 4, 10, '형용사', '[
    {"en":"Draw a horizontal line across the middle of the page.","ko":"페이지 중간에 수평선을 그으세요."},
    {"en":"The shelves were arranged in a horizontal position.","ko":"선반들은 수평 위치로 배열되어 있었다."},
    {"en":"The chart shows time on the horizontal axis.","ko":"그 도표는 가로축에 시간을 나타낸다."}
  ]'::jsonb),
  ('vertical', 4, 10, '형용사', '[
    {"en":"The building has a striking vertical design.","ko":"그 건물은 인상적인 수직 디자인을 가지고 있다."},
    {"en":"A vertical line divides the graph into two parts.","ko":"수직선이 그래프를 두 부분으로 나눈다."},
    {"en":"They installed a vertical garden on the wall.","ko":"그들은 벽에 수직 정원을 설치했다."}
  ]'::jsonb),
  ('remarkable', 4, 10, '형용사', '[
    {"en":"She made remarkable progress in just a few months.","ko":"그녀는 불과 몇 달 만에 놀랄 만한 발전을 이루었다."},
    {"en":"The city has a remarkable history dating back centuries.","ko":"그 도시는 수 세기를 거슬러 올라가는 주목할 만한 역사를 가지고 있다."},
    {"en":"It is remarkable how quickly children learn new languages.","ko":"아이들이 새로운 언어를 얼마나 빨리 배우는지는 놀랍다."}
  ]'::jsonb),
  ('individual', 4, 10, '명사/형용사', '[
    {"en":"Every individual has the right to express their opinion.","ko":"모든 개인은 자신의 의견을 표현할 권리가 있다."},
    {"en":"The teacher gave individual attention to each student.","ko":"선생님은 각 학생에게 개별적인 관심을 기울였다."},
    {"en":"People have different tastes as individuals.","ko":"사람들은 개개인으로서 서로 다른 취향을 가지고 있다."}
  ]'::jsonb),
  ('memorize', 4, 10, '동사', '[
    {"en":"Students had to memorize the poem for class.","ko":"학생들은 수업을 위해 그 시를 암기해야 했다."},
    {"en":"She memorized the speech before the presentation.","ko":"그녀는 발표 전에 연설문을 외웠다."},
    {"en":"It takes practice to memorize a long list of words.","ko":"긴 단어 목록을 암기하는 데는 연습이 필요하다."}
  ]'::jsonb),
  ('retire', 4, 10, '동사', '[
    {"en":"My grandfather retired from teaching after thirty years.","ko":"나의 할아버지는 30년 후 교직에서 은퇴하셨다."},
    {"en":"She plans to retire early and travel the world.","ko":"그녀는 일찍 은퇴하여 세계를 여행할 계획이다."},
    {"en":"The athlete decided to retire after winning the championship.","ko":"그 운동선수는 우승한 후 은퇴하기로 결정했다."}
  ]'::jsonb),
  ('athlete', 4, 10, '명사', '[
    {"en":"The young athlete trained hard every morning.","ko":"그 젊은 운동선수는 매일 아침 열심히 훈련했다."},
    {"en":"Professional athletes need a balanced diet to perform well.","ko":"프로 운동선수들은 좋은 경기력을 위해 균형 잡힌 식단이 필요하다."},
    {"en":"She became a national athlete after years of practice.","ko":"그녀는 수년간의 연습 끝에 국가대표 선수가 되었다."}
  ]'::jsonb),
  ('victim', 4, 10, '명사', '[
    {"en":"The charity provides support for victims of natural disasters.","ko":"그 자선 단체는 자연재해 피해자들을 지원한다."},
    {"en":"The victim was rescued and taken to the hospital.","ko":"그 피해자는 구조되어 병원으로 이송되었다."},
    {"en":"Many people became victims of the flood last summer.","ko":"지난여름 많은 사람들이 홍수의 피해자가 되었다."}
  ]'::jsonb),
  ('aboard', 4, 10, '부사', '[
    {"en":"Passengers were welcomed aboard the ship by the crew.","ko":"승객들은 승무원들에게 배에 오르며 환영받았다."},
    {"en":"All passengers must be aboard before the plane departs.","ko":"모든 승객은 비행기가 출발하기 전에 탑승해 있어야 한다."},
    {"en":"He climbed aboard the train just before it left.","ko":"그는 기차가 출발하기 직전에 올라탔다."}
  ]'::jsonb),
  ('departure', 4, 10, '명사', '[
    {"en":"The departure time was delayed by two hours.","ko":"출발 시각이 두 시간 지연되었다."},
    {"en":"We arrived at the airport well before departure.","ko":"우리는 출발 훨씬 전에 공항에 도착했다."},
    {"en":"Her sudden departure surprised all her coworkers.","ko":"그녀의 갑작스러운 떠남은 모든 동료들을 놀라게 했다."}
  ]'::jsonb),
  ('broaden', 4, 10, '동사', '[
    {"en":"Traveling abroad can broaden your view of the world.","ko":"해외여행은 세상을 보는 시야를 넓혀 줄 수 있다."},
    {"en":"The university added new courses to broaden students'' knowledge.","ko":"그 대학교는 학생들의 지식을 넓히기 위해 새로운 강좌를 추가했다."},
    {"en":"Reading various books helps broaden your perspective.","ko":"다양한 책을 읽는 것은 관점을 넓히는 데 도움이 된다."}
  ]'::jsonb),
  ('extend', 4, 10, '동사', '[
    {"en":"The library decided to extend its opening hours.","ko":"도서관은 개관 시간을 연장하기로 결정했다."},
    {"en":"She extended her arm to shake his hand.","ko":"그녀는 그와 악수하기 위해 팔을 뻗었다."},
    {"en":"The company extended the deadline for the application.","ko":"그 회사는 지원 마감일을 연장했다."}
  ]'::jsonb),
  ('sacrifice', 4, 10, '명사/동사', '[
    {"en":"Her parents made many sacrifices for her education.","ko":"그녀의 부모님은 그녀의 교육을 위해 많은 희생을 치렀다."},
    {"en":"He sacrificed his free time to help his classmates study.","ko":"그는 반 친구들의 공부를 돕기 위해 자신의 자유 시간을 희생했다."},
    {"en":"Success often requires hard work and sacrifice.","ko":"성공은 흔히 노력과 희생을 필요로 한다."}
  ]'::jsonb),
  ('devise', 4, 10, '동사', '[
    {"en":"The scientists devised a new method to test the theory.","ko":"과학자들은 그 이론을 검증할 새로운 방법을 고안했다."},
    {"en":"She devised a clever plan to solve the problem.","ko":"그녀는 그 문제를 해결하기 위한 영리한 계획을 고안했다."},
    {"en":"Engineers devised a device to save energy at home.","ko":"기술자들은 가정에서 에너지를 절약할 장치를 고안했다."}
  ]'::jsonb),
  ('electricity', 4, 10, '명사', '[
    {"en":"The storm cut off electricity to the whole neighborhood.","ko":"그 폭풍은 동네 전체의 전기를 끊어 놓았다."},
    {"en":"Solar panels generate electricity from sunlight.","ko":"태양광 패널은 햇빛으로부터 전기를 만들어 낸다."},
    {"en":"We should use electricity wisely to save energy.","ko":"우리는 에너지를 절약하기 위해 전기를 현명하게 사용해야 한다."}
  ]'::jsonb),
  ('extinct', 4, 10, '형용사', '[
    {"en":"Dinosaurs became extinct millions of years ago.","ko":"공룡은 수백만 년 전에 멸종했다."},
    {"en":"Many species are at risk of becoming extinct.","ko":"많은 종들이 멸종될 위험에 처해 있다."},
    {"en":"The organization works to protect nearly extinct animals.","ko":"그 단체는 거의 멸종된 동물들을 보호하기 위해 노력한다."}
  ]'::jsonb),
  ('fix', 4, 10, '동사', '[
    {"en":"He fixed the broken chair with some glue.","ko":"그는 접착제로 부서진 의자를 고쳤다."},
    {"en":"Can you fix my computer? It won''t turn on.","ko":"제 컴퓨터를 고쳐 주실 수 있나요? 켜지지가 않아요."},
    {"en":"They fixed a date for the next meeting.","ko":"그들은 다음 회의 날짜를 정했다."}
  ]'::jsonb),
  ('logical', 4, 10, '형용사', '[
    {"en":"Her argument was clear and logical.","ko":"그녀의 주장은 명확하고 논리적이었다."},
    {"en":"It is only logical to save money before buying something expensive.","ko":"비싼 것을 사기 전에 돈을 모으는 것은 당연한 일이다."},
    {"en":"The detective followed a logical process to solve the case.","ko":"그 탐정은 사건을 해결하기 위해 논리적인 과정을 따랐다."}
  ]'::jsonb),
  ('inherit', 4, 10, '동사', '[
    {"en":"She inherited her mother''s love of music.","ko":"그녀는 어머니의 음악에 대한 사랑을 물려받았다."},
    {"en":"He inherited a small house from his grandfather.","ko":"그는 할아버지로부터 작은 집을 물려받았다."},
    {"en":"Children often inherit certain traits from their parents.","ko":"아이들은 종종 부모로부터 특정한 특성을 물려받는다."}
  ]'::jsonb),
  ('length', 4, 10, '명사', '[
    {"en":"The length of the bridge is about two kilometers.","ko":"그 다리의 길이는 약 2킬로미터이다."},
    {"en":"They discussed the plan at great length.","ko":"그들은 그 계획에 대해 아주 상세하게 논의했다."},
    {"en":"The teacher measured the length of the classroom.","ko":"선생님은 교실의 길이를 측정했다."}
  ]'::jsonb),
  ('initial', 4, 10, '형용사/명사', '[
    {"en":"My initial reaction was one of surprise.","ko":"나의 처음 반응은 놀라움이었다."},
    {"en":"The initial results of the experiment looked promising.","ko":"그 실험의 초기 결과는 유망해 보였다."},
    {"en":"He signed the document with his initials.","ko":"그는 자신의 머리글자로 그 문서에 서명했다."}
  ]'::jsonb),
  ('qualification', 4, 10, '명사', '[
    {"en":"She has the qualifications needed for the job.","ko":"그녀는 그 일에 필요한 자격을 갖추고 있다."},
    {"en":"A teaching qualification is required for this position.","ko":"이 직위에는 교사 자격증이 요구된다."},
    {"en":"His qualification in engineering helped him get hired quickly.","ko":"공학 분야에서의 그의 자격은 그가 빨리 채용되는 데 도움이 되었다."}
  ]'::jsonb),
  ('reform', 4, 10, '동사/명사', '[
    {"en":"The government proposed a reform of the education system.","ko":"정부는 교육 제도의 개혁을 제안했다."},
    {"en":"They reformed the old law to make it fairer.","ko":"그들은 오래된 법을 더 공정하게 만들기 위해 개정했다."},
    {"en":"The new policy aims to reform the tax system.","ko":"그 새로운 정책은 세금 제도를 개혁하는 것을 목표로 한다."}
  ]'::jsonb),
  ('regulate', 4, 10, '동사', '[
    {"en":"The government regulates the price of basic goods.","ko":"정부는 기본 상품의 가격을 규제한다."},
    {"en":"This device helps regulate room temperature automatically.","ko":"이 장치는 실내 온도를 자동으로 조절하는 데 도움을 준다."},
    {"en":"Strict rules regulate how the factory disposes of waste.","ko":"엄격한 규칙이 그 공장이 폐기물을 처리하는 방식을 규제한다."}
  ]'::jsonb),
  ('delicate', 4, 10, '형용사', '[
    {"en":"Handle the glass vase carefully because it is delicate.","ko":"그 유리 꽃병은 섬세하니 조심스럽게 다루세요."},
    {"en":"The situation required a delicate approach.","ko":"그 상황은 신중한 접근을 필요로 했다."},
    {"en":"Butterflies have delicate wings that can be easily damaged.","ko":"나비는 쉽게 손상될 수 있는 섬세한 날개를 가지고 있다."}
  ]'::jsonb),
  ('resist', 4, 10, '동사', '[
    {"en":"It was hard to resist the smell of fresh bread.","ko":"갓 구운 빵 냄새를 참기는 어려웠다."},
    {"en":"The old building was built to resist earthquakes.","ko":"그 오래된 건물은 지진에 견디도록 지어졌다."},
    {"en":"She resisted the temptation to skip her homework.","ko":"그녀는 숙제를 건너뛰고 싶은 유혹에 저항했다."}
  ]'::jsonb),
  ('restrict', 4, 10, '동사', '[
    {"en":"The new rule restricts the use of phones in class.","ko":"새로운 규칙은 수업 중 휴대전화 사용을 제한한다."},
    {"en":"Heavy traffic restricted our movement through the city.","ko":"심한 교통 체증이 도시를 통과하는 우리의 이동을 제한했다."},
    {"en":"The doctor restricted his diet after the surgery.","ko":"의사는 수술 후 그의 식단을 제한했다."}
  ]'::jsonb),
  ('possess', 4, 10, '동사', '[
    {"en":"She possesses a rare talent for painting.","ko":"그녀는 그림에 대한 보기 드문 재능을 지니고 있다."},
    {"en":"He possesses great patience when teaching young children.","ko":"그는 어린아이들을 가르칠 때 대단한 인내심을 지니고 있다."},
    {"en":"The old house is said to be possessed by strange energy.","ko":"그 오래된 집은 이상한 기운에 사로잡혀 있다고 전해진다."}
  ]'::jsonb),
  ('tend to do', 4, 11, '숙어', '[
    {"en":"People tend to eat more during the holiday season.","ko":"사람들은 명절 기간에 더 많이 먹는 경향이 있다."},
    {"en":"Students tend to study harder right before exams.","ko":"학생들은 시험 직전에 더 열심히 공부하는 경향이 있다."},
    {"en":"He tends to forget names when he first meets people.","ko":"그는 사람들을 처음 만날 때 이름을 잊어버리는 경향이 있다."}
  ]'::jsonb),
  ('deal with', 4, 11, '숙어', '[
    {"en":"She knows how to deal with stress calmly.","ko":"그녀는 스트레스를 침착하게 다루는 법을 안다."},
    {"en":"The manager had to deal with several customer complaints.","ko":"그 관리자는 여러 고객 불만을 처리해야 했다."},
    {"en":"We need a better system to deal with the traffic problem.","ko":"우리는 교통 문제를 처리할 더 나은 시스템이 필요하다."}
  ]'::jsonb),
  ('refer to', 4, 11, '숙어', '[
    {"en":"Please refer to the manual if you have any questions.","ko":"질문이 있으면 설명서를 참고하세요."},
    {"en":"The word \"it\" refers to the dog mentioned earlier.","ko":"\"it\"이라는 단어는 앞서 언급된 개를 가리킨다."},
    {"en":"In her speech, she referred to several historical events.","ko":"그녀는 연설에서 여러 역사적 사건들을 언급했다."}
  ]'::jsonb),
  ('be about to do', 4, 11, '숙어', '[
    {"en":"The movie was about to start when we arrived.","ko":"우리가 도착했을 때 영화가 막 시작하려던 참이었다."},
    {"en":"I was about to call you when the phone rang.","ko":"전화가 울렸을 때 나는 막 너에게 전화하려던 참이었다."},
    {"en":"She was about to leave the house when it began to rain.","ko":"그녀가 막 집을 나서려던 참에 비가 내리기 시작했다."}
  ]'::jsonb),
  ('come up with', 4, 11, '숙어', '[
    {"en":"The team came up with a creative solution to the problem.","ko":"그 팀은 그 문제에 대한 창의적인 해결책을 생각해냈다."},
    {"en":"Can you come up with a better title for this essay?","ko":"이 에세이에 더 나은 제목을 생각해 낼 수 있니?"},
    {"en":"She came up with a new idea for the science project.","ko":"그녀는 과학 프로젝트를 위한 새로운 아이디어를 생각해냈다."}
  ]'::jsonb),
  ('have difficulty ~ing', 4, 11, '숙어', '[
    {"en":"He had difficulty understanding the complicated instructions.","ko":"그는 복잡한 지시 사항을 이해하는 데 어려움을 겪었다."},
    {"en":"Many students have difficulty focusing late at night.","ko":"많은 학생들이 밤늦게 집중하는 데 어려움을 겪는다."},
    {"en":"She had difficulty finding her way in the new city.","ko":"그녀는 새로운 도시에서 길을 찾는 데 어려움을 겪었다."}
  ]'::jsonb),
  ('keep ~in mind', 4, 11, '숙어', '[
    {"en":"Please keep in mind that the museum closes at five.","ko":"박물관이 5시에 문을 닫는다는 것을 명심하세요."},
    {"en":"Keep in mind the safety rules while hiking.","ko":"등산하는 동안 안전 수칙을 명심하세요."},
    {"en":"I will keep your advice in mind for next time.","ko":"다음번을 위해 당신의 조언을 명심하겠습니다."}
  ]'::jsonb),
  ('lead to', 4, 11, '숙어', '[
    {"en":"Regular exercise can lead to better health.","ko":"규칙적인 운동은 더 나은 건강으로 이어질 수 있다."},
    {"en":"A small mistake led to a big misunderstanding.","ko":"작은 실수가 큰 오해로 이어졌다."},
    {"en":"This road leads to the city center.","ko":"이 길은 도심으로 이어진다."}
  ]'::jsonb),
  ('at the same time', 4, 11, '숙어', '[
    {"en":"You cannot study and watch television at the same time.","ko":"공부와 텔레비전 시청을 동시에 할 수는 없다."},
    {"en":"The two runners crossed the finish line at the same time.","ko":"두 주자는 동시에 결승선을 통과했다."},
    {"en":"She felt excited and nervous at the same time.","ko":"그녀는 동시에 흥분되고 긴장되는 것을 느꼈다."}
  ]'::jsonb),
  ('due to', 4, 11, '숙어', '[
    {"en":"The game was canceled due to heavy rain.","ko":"그 경기는 폭우 때문에 취소되었다."},
    {"en":"Due to a technical problem, the website was down for an hour.","ko":"기술적 문제로 인해 그 웹사이트가 한 시간 동안 다운되었다."},
    {"en":"The delay was due to a shortage of staff.","ko":"그 지연은 인력 부족에 기인했다."}
  ]'::jsonb),
  ('in terms of', 4, 11, '숙어', '[
    {"en":"The two products are similar in terms of price.","ko":"그 두 제품은 가격 면에서 비슷하다."},
    {"en":"In terms of quality, this option is much better.","ko":"품질의 관점에서 보면 이 선택이 훨씬 낫다."},
    {"en":"We should evaluate the plan in terms of its long-term effects.","ko":"우리는 그 계획을 장기적 영향의 관점에서 평가해야 한다."}
  ]'::jsonb),
  ('throw away', 4, 11, '숙어', '[
    {"en":"Don''t throw away the box; we might need it later.","ko":"그 상자를 버리지 마세요. 나중에 필요할지도 몰라요."},
    {"en":"He threw away his old notebooks after the semester ended.","ko":"그는 학기가 끝난 후 오래된 공책들을 버렸다."},
    {"en":"You shouldn''t throw away this opportunity.","ko":"너는 이 기회를 버려서는 안 된다."}
  ]'::jsonb),
  ('go through', 4, 11, '숙어', '[
    {"en":"She went through a difficult time after moving to a new school.","ko":"그녀는 새 학교로 전학한 후 힘든 시기를 겪었다."},
    {"en":"Please go through the report before the meeting.","ko":"회의 전에 그 보고서를 검토해 주세요."},
    {"en":"The company went through many changes last year.","ko":"그 회사는 작년에 많은 변화를 겪었다."}
  ]'::jsonb),
  ('instead of', 4, 11, '숙어', '[
    {"en":"She chose tea instead of coffee this morning.","ko":"그녀는 오늘 아침 커피 대신 차를 선택했다."},
    {"en":"Instead of complaining, try to find a solution.","ko":"불평하는 대신 해결책을 찾으려고 노력해라."},
    {"en":"He walked to school instead of taking the bus.","ko":"그는 버스를 타는 대신 학교까지 걸어갔다."}
  ]'::jsonb),
  ('make sense of', 4, 11, '숙어', '[
    {"en":"It took her a while to make sense of the complicated map.","ko":"그녀가 그 복잡한 지도를 이해하는 데는 시간이 좀 걸렸다."},
    {"en":"I couldn''t make sense of his explanation at first.","ko":"나는 처음에 그의 설명을 이해할 수 없었다."},
    {"en":"Try to make sense of the data before drawing a conclusion.","ko":"결론을 내리기 전에 그 데이터를 이해하려고 노력해라."}
  ]'::jsonb),
  ('in person', 4, 11, '숙어', '[
    {"en":"I would rather discuss this matter in person.","ko":"나는 이 문제를 직접 만나서 논의하고 싶다."},
    {"en":"She applied for the job in person instead of online.","ko":"그녀는 온라인 대신 직접 방문하여 그 일자리에 지원했다."},
    {"en":"It''s better to apologize in person than by text.","ko":"문자보다는 직접 만나서 사과하는 것이 낫다."}
  ]'::jsonb),
  ('take over', 4, 11, '숙어', '[
    {"en":"His son will take over the family business next year.","ko":"그의 아들이 내년에 가업을 물려받을 것이다."},
    {"en":"The new manager took over the project halfway through.","ko":"새 관리자가 그 프로젝트를 중간에 넘겨받았다."},
    {"en":"Robots are starting to take over some factory jobs.","ko":"로봇들이 일부 공장 일자리를 차지하기 시작하고 있다."}
  ]'::jsonb),
  ('take on', 4, 11, '숙어', '[
    {"en":"She decided to take on more responsibility at work.","ko":"그녀는 직장에서 더 많은 책임을 떠맡기로 결정했다."},
    {"en":"He took on a part-time job to earn extra money.","ko":"그는 추가 수입을 벌기 위해 아르바이트를 떠맡았다."},
    {"en":"The company is taking on new employees this month.","ko":"그 회사는 이번 달에 신입 사원을 채용하고 있다."}
  ]'::jsonb),
  ('be aware of', 4, 11, '숙어', '[
    {"en":"Drivers should be aware of pedestrians near schools.","ko":"운전자들은 학교 근처의 보행자들을 알아야 한다."},
    {"en":"She wasn''t aware of the changes to the schedule.","ko":"그녀는 일정 변경을 알지 못했다."},
    {"en":"We must be aware of the risks before starting the project.","ko":"우리는 그 프로젝트를 시작하기 전에 위험을 알아야 한다."}
  ]'::jsonb),
  ('be proud of', 4, 11, '숙어', '[
    {"en":"Her parents are very proud of her achievements.","ko":"그녀의 부모님은 그녀의 성취를 매우 자랑스러워한다."},
    {"en":"I am proud of how hard the team worked.","ko":"나는 그 팀이 얼마나 열심히 노력했는지 자랑스럽다."},
    {"en":"He was proud of finishing the marathon.","ko":"그는 마라톤을 완주한 것을 자랑스러워했다."}
  ]'::jsonb),
  ('depend on', 4, 11, '숙어', '[
    {"en":"The outcome depends on how well we prepare.","ko":"그 결과는 우리가 얼마나 잘 준비하느냐에 달려 있다."},
    {"en":"Children often depend on their parents for guidance.","ko":"아이들은 종종 지도를 위해 부모에게 의존한다."},
    {"en":"Whether we go hiking depends on the weather.","ko":"우리가 등산을 갈지는 날씨에 달려 있다."}
  ]'::jsonb),
  ('participate in', 4, 11, '숙어', '[
    {"en":"All students are encouraged to participate in the school festival.","ko":"모든 학생들은 학교 축제에 참여하도록 권장된다."},
    {"en":"She participated in a volunteer program last summer.","ko":"그녀는 지난여름 자원봉사 프로그램에 참여했다."},
    {"en":"More people are participating in the survey this year.","ko":"올해 더 많은 사람들이 그 설문조사에 참여하고 있다."}
  ]'::jsonb),
  ('pay attention to', 4, 11, '숙어', '[
    {"en":"Please pay attention to the teacher during the lesson.","ko":"수업 중에는 선생님께 주의를 기울여 주세요."},
    {"en":"Drivers must pay attention to road signs.","ko":"운전자들은 도로 표지판에 유의해야 한다."},
    {"en":"She paid close attention to every detail in the report.","ko":"그녀는 보고서의 모든 세부 사항에 세심한 주의를 기울였다."}
  ]'::jsonb),
  ('concentrate on', 4, 11, '숙어', '[
    {"en":"He tried to concentrate on his homework despite the noise.","ko":"그는 소음에도 불구하고 숙제에 집중하려고 노력했다."},
    {"en":"We should concentrate on solving the main problem first.","ko":"우리는 먼저 주된 문제를 해결하는 데 집중해야 한다."},
    {"en":"She concentrated on her breathing to stay calm.","ko":"그녀는 침착함을 유지하기 위해 호흡에 집중했다."}
  ]'::jsonb),
  ('get along with', 4, 11, '숙어', '[
    {"en":"She gets along well with all of her classmates.","ko":"그녀는 반 친구들 모두와 잘 지낸다."},
    {"en":"It''s important to get along with your coworkers.","ko":"동료들과 잘 지내는 것은 중요하다."},
    {"en":"The new student is getting along with everyone in class.","ko":"그 새 학생은 반 모든 사람과 잘 지내고 있다."}
  ]'::jsonb),
  ('come true', 4, 11, '숙어', '[
    {"en":"Her dream of becoming a doctor finally came true.","ko":"의사가 되고 싶다는 그녀의 꿈이 마침내 이루어졌다."},
    {"en":"He hoped his wish would come true one day.","ko":"그는 언젠가 자신의 소원이 이루어지기를 바랐다."},
    {"en":"With hard work, your goals can come true.","ko":"노력하면 너의 목표는 이루어질 수 있다."}
  ]'::jsonb),
  ('contribute to', 4, 11, '숙어', '[
    {"en":"Regular exercise contributes to a healthy lifestyle.","ko":"규칙적인 운동은 건강한 생활방식에 기여한다."},
    {"en":"Every member contributed to the success of the project.","ko":"모든 구성원이 그 프로젝트의 성공에 기여했다."},
    {"en":"Pollution contributes to climate change.","ko":"오염은 기후 변화에 기여한다."}
  ]'::jsonb),
  ('keep ~from -ing', 4, 11, '숙어', '[
    {"en":"The heavy rain kept us from going outside.","ko":"폭우가 우리가 밖에 나가는 것을 막았다."},
    {"en":"Nothing could keep her from achieving her goal.","ko":"그 무엇도 그녀가 목표를 이루는 것을 막을 수 없었다."},
    {"en":"Loud noise kept the baby from falling asleep.","ko":"시끄러운 소음이 아기가 잠드는 것을 막았다."}
  ]'::jsonb),
  ('take off', 4, 11, '숙어', '[
    {"en":"The plane will take off in ten minutes.","ko":"비행기는 10분 후에 이륙할 것이다."},
    {"en":"He took off his shoes before entering the house.","ko":"그는 집에 들어가기 전에 신발을 벗었다."},
    {"en":"She took off early to catch her train.","ko":"그녀는 기차를 타기 위해 일찍 떠났다."}
  ]'::jsonb),
  ('in addition (to)', 4, 11, '숙어', '[
    {"en":"In addition to English, she speaks French and Spanish.","ko":"영어에 덧붙여, 그녀는 프랑스어와 스페인어를 한다."},
    {"en":"In addition, the store offers free delivery.","ko":"게다가, 그 가게는 무료 배송을 제공한다."},
    {"en":"In addition to homework, students had a group project.","ko":"숙제에 더하여, 학생들에게는 조별 과제도 있었다."}
  ]'::jsonb),
  ('have an effect on', 4, 11, '숙어', '[
    {"en":"Sleep has a big effect on your concentration.","ko":"수면은 집중력에 큰 영향을 미친다."},
    {"en":"The new policy had a positive effect on sales.","ko":"그 새로운 정책은 매출에 긍정적인 영향을 미쳤다."},
    {"en":"Music can have a calming effect on people.","ko":"음악은 사람들에게 진정 효과를 줄 수 있다."}
  ]'::jsonb),
  ('make up', 4, 11, '숙어', '[
    {"en":"Ten members make up the school band.","ko":"열 명의 부원이 그 학교 밴드를 구성한다."},
    {"en":"She made up a story to explain why she was late.","ko":"그녀는 왜 늦었는지 설명하기 위해 이야기를 지어냈다."},
    {"en":"They made up after their small argument.","ko":"그들은 작은 말다툼 후에 화해했다."}
  ]'::jsonb),
  ('calm down', 4, 11, '숙어', '[
    {"en":"Take a deep breath and calm down before you speak.","ko":"말하기 전에 숨을 깊이 쉬고 진정하세요."},
    {"en":"The teacher helped the crying child calm down.","ko":"선생님은 우는 아이가 진정하도록 도와주었다."},
    {"en":"It took a while for the excited crowd to calm down.","ko":"흥분한 군중이 진정하는 데 시간이 좀 걸렸다."}
  ]'::jsonb),
  ('be regarded as', 4, 11, '숙어', '[
    {"en":"She is regarded as one of the best writers of her time.","ko":"그녀는 그 시대 최고의 작가 중 한 명으로 여겨진다."},
    {"en":"The plan was regarded as too risky by the committee.","ko":"그 계획은 위원회에 의해 너무 위험한 것으로 여겨졌다."},
    {"en":"He is widely regarded as an honest leader.","ko":"그는 정직한 지도자로 널리 여겨진다."}
  ]'::jsonb),
  ('take ~for granted', 4, 11, '숙어', '[
    {"en":"We often take clean water for granted.","ko":"우리는 종종 깨끗한 물을 당연하게 여긴다."},
    {"en":"Don''t take your friends for granted.","ko":"네 친구들을 당연하게 여기지 마라."},
    {"en":"She realized she had taken her health for granted.","ko":"그녀는 자신이 건강을 당연하게 여겼다는 것을 깨달았다."}
  ]'::jsonb),
  ('take ~into account', 4, 11, '숙어', '[
    {"en":"You should take the weather into account when planning the trip.","ko":"여행을 계획할 때 날씨를 고려해야 한다."},
    {"en":"The teacher took the students'' effort into account when grading.","ko":"선생님은 채점할 때 학생들의 노력을 고려했다."},
    {"en":"We need to take the cost into account before buying it.","ko":"그것을 사기 전에 우리는 비용을 고려해야 한다."}
  ]'::jsonb),
  ('pick up', 4, 11, '숙어', '[
    {"en":"She picked up the pen that had fallen on the floor.","ko":"그녀는 바닥에 떨어진 펜을 집어 들었다."},
    {"en":"I will pick you up at the station at six.","ko":"6시에 역에서 너를 태우러 갈게."},
    {"en":"He picked up a new hobby during the vacation.","ko":"그는 방학 동안 새로운 취미를 갖게 되었다."}
  ]'::jsonb),
  ('bring about', 4, 11, '숙어', '[
    {"en":"The new law brought about a major change in society.","ko":"그 새로운 법은 사회에 큰 변화를 가져왔다."},
    {"en":"Technology has brought about many improvements in daily life.","ko":"기술은 일상생활에 많은 개선을 가져왔다."},
    {"en":"Her hard work brought about impressive results.","ko":"그녀의 노력은 인상적인 결과를 가져왔다."}
  ]'::jsonb),
  ('plenty of', 4, 11, '숙어', '[
    {"en":"There is plenty of time before the meeting starts.","ko":"회의가 시작되기 전까지 충분한 시간이 있다."},
    {"en":"We have plenty of food for the party.","ko":"우리는 파티를 위한 충분한 음식을 가지고 있다."},
    {"en":"She gave plenty of advice to the new students.","ko":"그녀는 신입생들에게 많은 조언을 해 주었다."}
  ]'::jsonb),
  ('take advantage of', 4, 11, '숙어', '[
    {"en":"You should take advantage of this opportunity to study abroad.","ko":"너는 해외에서 공부할 이 기회를 활용해야 한다."},
    {"en":"The company took advantage of new technology to increase efficiency.","ko":"그 회사는 효율성을 높이기 위해 새로운 기술을 활용했다."},
    {"en":"Take advantage of the free trial before it ends.","ko":"무료 체험이 끝나기 전에 그것을 활용해라."}
  ]'::jsonb),
  ('in charge of', 4, 12, '숙어', '[
    {"en":"She is in charge of the school newspaper this year.","ko":"그녀는 올해 학교 신문을 책임지고 있다."},
    {"en":"Who is in charge of organizing the event?","ko":"그 행사를 준비하는 책임을 맡은 사람은 누구인가요?"},
    {"en":"He was put in charge of the new project.","ko":"그는 새 프로젝트의 책임을 맡게 되었다."}
  ]'::jsonb),
  ('make one''s way to', 4, 12, '숙어', '[
    {"en":"We made our way to the exit through the crowd.","ko":"우리는 사람들 사이를 뚫고 출구로 나아갔다."},
    {"en":"She slowly made her way to the front of the line.","ko":"그녀는 천천히 줄 앞쪽으로 나아갔다."},
    {"en":"They made their way to the mountain peak before sunset.","ko":"그들은 해가 지기 전에 산 정상으로 나아갔다."}
  ]'::jsonb),
  ('remind ~of -', 4, 12, '숙어', '[
    {"en":"This song reminds me of my childhood.","ko":"이 노래는 내게 어린 시절을 떠올리게 한다."},
    {"en":"Her smile reminds him of his sister.","ko":"그녀의 미소는 그에게 여동생을 떠올리게 한다."},
    {"en":"The old photo reminded her of a happy summer.","ko":"그 오래된 사진은 그녀에게 행복했던 여름을 상기시켰다."}
  ]'::jsonb),
  ('run out of', 4, 12, '숙어', '[
    {"en":"We ran out of milk this morning.","ko":"우리는 오늘 아침 우유가 다 떨어졌다."},
    {"en":"The car ran out of gas on the highway.","ko":"그 차는 고속도로에서 기름이 다 떨어졌다."},
    {"en":"She ran out of time before finishing the test.","ko":"그녀는 시험을 끝내기 전에 시간이 다 떨어졌다."}
  ]'::jsonb),
  ('look into', 4, 12, '숙어', '[
    {"en":"The police are looking into the cause of the accident.","ko":"경찰은 그 사고의 원인을 조사하고 있다."},
    {"en":"We need to look into this matter more carefully.","ko":"우리는 이 문제를 더 신중하게 조사해야 한다."},
    {"en":"The teacher promised to look into the students'' concerns.","ko":"선생님은 학생들의 걱정거리를 조사해 보겠다고 약속했다."}
  ]'::jsonb),
  ('put up with', 4, 12, '숙어', '[
    {"en":"I can''t put up with his rude comments anymore.","ko":"나는 더 이상 그의 무례한 발언을 참을 수 없다."},
    {"en":"She had to put up with the noisy construction next door.","ko":"그녀는 옆집의 시끄러운 공사를 참아야 했다."},
    {"en":"We put up with the long wait because the food was good.","ko":"음식이 맛있었기 때문에 우리는 긴 기다림을 참았다."}
  ]'::jsonb),
  ('regardless of', 4, 12, '숙어', '[
    {"en":"Everyone can join the club regardless of age.","ko":"나이에 상관없이 누구나 그 동아리에 가입할 수 있다."},
    {"en":"She continued practicing regardless of the weather.","ko":"그녀는 날씨에 상관없이 계속 연습했다."},
    {"en":"The rule applies to all students regardless of grade.","ko":"그 규칙은 학년에 상관없이 모든 학생에게 적용된다."}
  ]'::jsonb),
  ('suffer from', 4, 12, '숙어', '[
    {"en":"Many people suffer from allergies in the spring.","ko":"많은 사람들이 봄에 알레르기로 고통받는다."},
    {"en":"The region has been suffering from a severe drought.","ko":"그 지역은 심각한 가뭄으로 고통받고 있다."},
    {"en":"He suffered from a headache after studying all night.","ko":"그는 밤새 공부한 후 두통으로 고생했다."}
  ]'::jsonb),
  ('come upon', 4, 12, '숙어', '[
    {"en":"While hiking, we came upon a beautiful waterfall.","ko":"등산하는 동안 우리는 아름다운 폭포를 우연히 만났다."},
    {"en":"She came upon an old letter while cleaning the attic.","ko":"그녀는 다락방을 청소하다가 오래된 편지를 우연히 발견했다."},
    {"en":"They came upon a small village on their journey.","ko":"그들은 여행 중에 작은 마을을 우연히 만났다."}
  ]'::jsonb),
  ('carry out', 4, 12, '숙어', '[
    {"en":"The team carried out the plan without any problems.","ko":"그 팀은 아무 문제 없이 그 계획을 실행했다."},
    {"en":"Scientists carried out several experiments to test the theory.","ko":"과학자들은 그 이론을 검증하기 위해 여러 실험을 수행했다."},
    {"en":"The government will carry out new safety inspections.","ko":"정부는 새로운 안전 점검을 실시할 것이다."}
  ]'::jsonb),
  ('make a fortune', 4, 12, '숙어', '[
    {"en":"He made a fortune by starting his own company.","ko":"그는 자신의 회사를 창업하여 큰돈을 벌었다."},
    {"en":"She hopes to make a fortune from her invention someday.","ko":"그녀는 언젠가 자신의 발명품으로 큰돈을 벌기를 바란다."},
    {"en":"Few people actually make a fortune overnight.","ko":"실제로 하룻밤 사이에 큰돈을 버는 사람은 거의 없다."}
  ]'::jsonb),
  ('be associated with', 4, 12, '숙어', '[
    {"en":"High stress is often associated with poor sleep.","ko":"높은 스트레스는 흔히 나쁜 수면과 관련이 있다."},
    {"en":"This symbol is associated with peace around the world.","ko":"이 상징은 전 세계적으로 평화와 관련이 있다."},
    {"en":"He doesn''t want to be associated with that controversy.","ko":"그는 그 논란과 관련되고 싶어 하지 않는다."}
  ]'::jsonb),
  ('catch up with', 4, 12, '숙어', '[
    {"en":"She studied hard to catch up with her classmates.","ko":"그녀는 반 친구들을 따라잡기 위해 열심히 공부했다."},
    {"en":"I need to catch up with the news after my vacation.","ko":"휴가 후에 나는 뉴스를 따라잡아야 한다."},
    {"en":"He ran fast to catch up with his friends.","ko":"그는 친구들을 따라잡기 위해 빨리 달렸다."}
  ]'::jsonb),
  ('after all', 4, 12, '숙어', '[
    {"en":"After all, honesty is the best policy.","ko":"결국, 정직이 최선의 방책이다."},
    {"en":"We decided not to go to the beach after all.","ko":"우리는 결국 해변에 가지 않기로 결정했다."},
    {"en":"He passed the exam after all his hard work.","ko":"그는 모든 노력 끝에 결국 시험에 합격했다."}
  ]'::jsonb),
  ('stand up to', 4, 12, '숙어', '[
    {"en":"She stood up to the bully in her class.","ko":"그녀는 반에 있는 괴롭히는 아이에게 맞섰다."},
    {"en":"It takes courage to stand up to unfair treatment.","ko":"부당한 대우에 맞서는 데는 용기가 필요하다."},
    {"en":"The small company stood up to its much larger competitor.","ko":"그 작은 회사는 훨씬 더 큰 경쟁사에 맞섰다."}
  ]'::jsonb),
  ('end up', 4, 12, '숙어', '[
    {"en":"If you don''t plan carefully, you might end up lost.","ko":"신중하게 계획하지 않으면 길을 잃게 될지도 모른다."},
    {"en":"They ended up staying at home because of the rain.","ko":"그들은 비 때문에 결국 집에 머무르게 되었다."},
    {"en":"She ended up becoming a doctor like her mother.","ko":"그녀는 결국 어머니처럼 의사가 되었다."}
  ]'::jsonb),
  ('catch one''s eye', 4, 12, '숙어', '[
    {"en":"A bright red dress caught her eye in the shop window.","ko":"밝은 빨간색 드레스가 상점 진열창에서 그녀의 눈길을 끌었다."},
    {"en":"The unusual painting caught the visitor''s eye immediately.","ko":"그 특이한 그림은 즉시 방문객의 눈길을 끌었다."},
    {"en":"His talent for drawing caught the teacher''s eye.","ko":"그림에 대한 그의 재능이 선생님의 눈길을 끌었다."}
  ]'::jsonb),
  ('dig out', 4, 12, '숙어', '[
    {"en":"He dug out an old photo album from the closet.","ko":"그는 벽장에서 오래된 사진 앨범을 파냈다."},
    {"en":"Workers dug out the buried pipe carefully.","ko":"인부들은 매설된 파이프를 조심스럽게 파냈다."},
    {"en":"She dug out her winter coat when the weather turned cold.","ko":"날씨가 추워지자 그녀는 겨울 코트를 꺼냈다."}
  ]'::jsonb),
  ('pay off', 4, 12, '숙어', '[
    {"en":"All her hard work finally paid off.","ko":"그녀의 모든 노력이 마침내 성과를 거두었다."},
    {"en":"He hopes his investment in the business will pay off.","ko":"그는 그 사업에 대한 투자가 성과를 올리기를 바란다."},
    {"en":"Studying every day paid off when she passed the exam.","ko":"매일 공부한 것이 그녀가 시험에 합격했을 때 성과를 거두었다."}
  ]'::jsonb),
  ('head to', 4, 12, '숙어', '[
    {"en":"After school, they headed to the library to study.","ko":"방과 후에 그들은 공부하기 위해 도서관으로 향했다."},
    {"en":"We are heading to the beach this weekend.","ko":"우리는 이번 주말에 해변으로 향할 것이다."},
    {"en":"The team headed to the stadium for practice.","ko":"그 팀은 연습을 위해 경기장으로 향했다."}
  ]'::jsonb),
  ('chances are that~', 4, 12, '숙어', '[
    {"en":"Chances are that it will rain tomorrow.","ko":"아마 내일 비가 올 것이다."},
    {"en":"Chances are that she already knows the news.","ko":"아마 그녀는 이미 그 소식을 알고 있을 것이다."},
    {"en":"Chances are that the shop will be closed on Sunday.","ko":"아마 그 가게는 일요일에 문을 닫을 것이다."}
  ]'::jsonb),
  ('go over', 4, 12, '숙어', '[
    {"en":"Let''s go over the plan before the meeting starts.","ko":"회의가 시작되기 전에 계획을 검토해 보자."},
    {"en":"The teacher went over the answers with the class.","ko":"선생님은 학급과 함께 답을 검토했다."},
    {"en":"She went over her notes one more time before the test.","ko":"그녀는 시험 전에 필기를 한 번 더 검토했다."}
  ]'::jsonb),
  ('catch sight of', 4, 12, '숙어', '[
    {"en":"We caught sight of a rainbow after the storm.","ko":"우리는 폭풍 후에 무지개를 힐끗 보았다."},
    {"en":"She caught sight of her friend across the crowded street.","ko":"그녀는 붐비는 거리 건너편에서 친구를 힐끗 보았다."},
    {"en":"He caught sight of a deer near the forest trail.","ko":"그는 숲길 근처에서 사슴을 힐끗 보았다."}
  ]'::jsonb),
  ('play a role in', 4, 12, '숙어', '[
    {"en":"Diet plays a role in maintaining good health.","ko":"식단은 건강을 유지하는 데 역할을 한다."},
    {"en":"Teachers play an important role in shaping students'' futures.","ko":"교사는 학생들의 미래를 형성하는 데 중요한 역할을 한다."},
    {"en":"Luck can also play a role in success.","ko":"운도 성공에 역할을 할 수 있다."}
  ]'::jsonb),
  ('can(not) afford to', 4, 12, '숙어', '[
    {"en":"We cannot afford to waste any more time.","ko":"우리는 더 이상 시간을 낭비할 여유가 없다."},
    {"en":"She can afford to buy a new laptop this year.","ko":"그녀는 올해 새 노트북을 살 여유가 있다."},
    {"en":"The team cannot afford to lose the next game.","ko":"그 팀은 다음 경기에서 질 여유가 없다."}
  ]'::jsonb),
  ('have ~ in common', 4, 12, '숙어', '[
    {"en":"The two friends have a lot in common.","ko":"그 두 친구는 공통점이 많다."},
    {"en":"We have little in common except our love of music.","ko":"우리는 음악에 대한 사랑을 제외하고는 공통점이 거의 없다."},
    {"en":"Successful people often have several habits in common.","ko":"성공한 사람들은 종종 몇 가지 습관을 공통으로 가지고 있다."}
  ]'::jsonb),
  ('get used to', 4, 12, '숙어', '[
    {"en":"It took her a while to get used to the new school.","ko":"그녀가 새 학교에 익숙해지는 데는 시간이 좀 걸렸다."},
    {"en":"He is slowly getting used to living alone.","ko":"그는 혼자 사는 것에 서서히 익숙해지고 있다."},
    {"en":"You will get used to the cold weather eventually.","ko":"결국 너는 추운 날씨에 익숙해질 것이다."}
  ]'::jsonb),
  ('consist of', 4, 12, '숙어', '[
    {"en":"The committee consists of ten members.","ko":"그 위원회는 열 명의 위원으로 구성되어 있다."},
    {"en":"The exam consists of two parts: writing and speaking.","ko":"그 시험은 쓰기와 말하기 두 부분으로 이루어져 있다."},
    {"en":"The team consists of students from different grades.","ko":"그 팀은 여러 학년의 학생들로 구성되어 있다."}
  ]'::jsonb),
  ('keep up with', 4, 12, '숙어', '[
    {"en":"She reads the news daily to keep up with current events.","ko":"그녀는 시사에 뒤지지 않기 위해 매일 뉴스를 읽는다."},
    {"en":"It''s hard to keep up with all the new technology.","ko":"모든 새로운 기술에 뒤지지 않기는 어렵다."},
    {"en":"He jogged faster to keep up with his friends.","ko":"그는 친구들에게 뒤지지 않기 위해 더 빨리 조깅했다."}
  ]'::jsonb),
  ('feel free to do', 4, 12, '숙어', '[
    {"en":"Feel free to ask any questions during the lecture.","ko":"강의 중에 자유롭게 질문해 주세요."},
    {"en":"Please feel free to contact us if you need help.","ko":"도움이 필요하면 언제든지 자유롭게 연락해 주세요."},
    {"en":"Feel free to share your opinion in the discussion.","ko":"토론에서 자유롭게 의견을 나눠 주세요."}
  ]'::jsonb),
  ('figure out', 4, 12, '숙어', '[
    {"en":"It took a while to figure out how the machine worked.","ko":"그 기계가 어떻게 작동하는지 알아내는 데 시간이 좀 걸렸다."},
    {"en":"She finally figured out the answer to the puzzle.","ko":"그녀는 마침내 그 퍼즐의 답을 알아냈다."},
    {"en":"We need to figure out a way to solve this issue.","ko":"우리는 이 문제를 해결할 방법을 알아내야 한다."}
  ]'::jsonb),
  ('call on', 4, 12, '숙어', '[
    {"en":"The teacher called on a student to answer the question.","ko":"선생님은 한 학생을 지목해 그 질문에 답하게 했다."},
    {"en":"The mayor called on citizens to save water during the drought.","ko":"시장은 가뭄 동안 물을 절약하도록 시민들에게 요청했다."},
    {"en":"She called on her friend for help with the project.","ko":"그녀는 그 프로젝트 도움을 위해 친구에게 부탁했다."}
  ]'::jsonb),
  ('make the most of', 4, 12, '숙어', '[
    {"en":"Try to make the most of your time at university.","ko":"대학에서의 시간을 최대한 활용하도록 노력해라."},
    {"en":"She made the most of the sunny weather by going hiking.","ko":"그녀는 화창한 날씨를 최대한 활용해 등산을 갔다."},
    {"en":"We should make the most of every opportunity we get.","ko":"우리는 얻는 모든 기회를 최대한 활용해야 한다."}
  ]'::jsonb),
  ('get in touch with', 4, 12, '숙어', '[
    {"en":"Please get in touch with me if you have any questions.","ko":"질문이 있으면 저에게 연락해 주세요."},
    {"en":"She got in touch with her old friend after many years.","ko":"그녀는 여러 해가 지난 후 옛 친구와 연락이 닿았다."},
    {"en":"I will get in touch with the customer service team.","ko":"저는 고객 서비스팀에 연락할 것입니다."}
  ]'::jsonb),
  ('be tempted to do', 4, 12, '숙어', '[
    {"en":"I was tempted to buy the new phone, but I saved my money instead.","ko":"나는 새 휴대전화를 사고 싶은 유혹을 느꼈지만 대신 돈을 아꼈다."},
    {"en":"She was tempted to skip her homework and watch a movie.","ko":"그녀는 숙제를 건너뛰고 영화를 보고 싶은 유혹을 느꼈다."},
    {"en":"He was tempted to give up but kept trying.","ko":"그는 포기하고 싶은 유혹을 느꼈지만 계속 노력했다."}
  ]'::jsonb),
  ('a handful of', 4, 12, '숙어', '[
    {"en":"Only a handful of students finished the difficult test.","ko":"극소수의 학생들만이 그 어려운 시험을 끝마쳤다."},
    {"en":"A handful of people gathered to watch the sunset.","ko":"소수의 사람들이 노을을 보기 위해 모였다."},
    {"en":"She kept a handful of coins in her pocket.","ko":"그녀는 한 줌의 동전을 주머니에 넣어 두었다."}
  ]'::jsonb),
  ('out of place', 4, 12, '숙어', '[
    {"en":"He felt out of place at the fancy dinner party.","ko":"그는 화려한 저녁 파티에서 어울리지 않는다고 느꼈다."},
    {"en":"The old furniture looked out of place in the modern room.","ko":"그 낡은 가구는 현대적인 방에 어울리지 않아 보였다."},
    {"en":"Her casual clothes seemed out of place at the formal event.","ko":"그녀의 캐주얼한 옷은 그 격식 있는 행사에 어울리지 않아 보였다."}
  ]'::jsonb),
  ('turn ~into -', 4, 12, '숙어', '[
    {"en":"The magician turned water into ice in seconds.","ko":"마술사는 순식간에 물을 얼음으로 바꾸었다."},
    {"en":"They turned the old warehouse into a library.","ko":"그들은 오래된 창고를 도서관으로 바꾸었다."},
    {"en":"Hard work can turn a small idea into a great success.","ko":"노력은 작은 아이디어를 큰 성공으로 바꿀 수 있다."}
  ]'::jsonb),
  ('take turns', 4, 12, '숙어', '[
    {"en":"The children took turns riding the bicycle.","ko":"아이들은 교대로 자전거를 탔다."},
    {"en":"We took turns reading the story aloud.","ko":"우리는 교대로 그 이야기를 소리 내어 읽었다."},
    {"en":"The drivers took turns during the long journey.","ko":"운전자들은 긴 여정 동안 교대로 운전했다."}
  ]'::jsonb),
  ('dispose of', 4, 12, '숙어', '[
    {"en":"The factory must dispose of its waste safely.","ko":"그 공장은 폐기물을 안전하게 처리해야 한다."},
    {"en":"Please dispose of the trash in the correct bin.","ko":"쓰레기를 올바른 통에 버려 주세요."},
    {"en":"They disposed of the old furniture before moving.","ko":"그들은 이사하기 전에 낡은 가구를 처분했다."}
  ]'::jsonb)
) as t(word, level, study_day, pos, examples)
where v.word = t.word and v.level = t.level and v.study_day = t.study_day;
