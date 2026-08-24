-- SAP 1기 대시보드: Study 탭 — Lv.2(중등 고난도) Day 25~30 품사/예문 채우기 (180단어, 마지막 배치).
update public.vocab_words v
set part_of_speech = t.pos, example_sentences = t.examples, updated_at = now()
from (values
  ('suggest', 2, 25, '동사', '[
    {"en":"She suggested a new approach to solving the problem.","ko":"그녀는 그 문제를 해결하는 새로운 접근법을 제안했다."},
    {"en":"His nervous behavior suggested that something was wrong.","ko":"그의 초조한 행동은 뭔가 잘못되었음을 시사했다."},
    {"en":"Can you suggest a good book on world history?","ko":"세계사에 관한 좋은 책을 추천해 줄 수 있니?"}
  ]'::jsonb),
  ('propose', 2, 25, '동사', '[
    {"en":"The committee proposed a new plan to reduce traffic.","ko":"위원회는 교통량을 줄이기 위한 새로운 계획을 제안했다."},
    {"en":"He proposed several changes to the school schedule.","ko":"그는 학교 일정에 몇 가지 변경 사항을 제안했다."},
    {"en":"The mayor proposed building a new library downtown.","ko":"시장은 도심에 새 도서관을 짓자고 제안했다."}
  ]'::jsonb),
  ('universal', 2, 25, '형용사', '[
    {"en":"Access to clean water should be a universal right.","ko":"깨끗한 물에 대한 접근은 보편적인 권리여야 한다."},
    {"en":"The love of music seems to be a universal human trait.","ko":"음악에 대한 사랑은 인간의 보편적인 특성인 듯하다."},
    {"en":"Scientists searched for a universal law that explains gravity.","ko":"과학자들은 중력을 설명하는 보편적인 법칙을 찾았다."}
  ]'::jsonb),
  ('vary', 2, 25, '동사', '[
    {"en":"Opinions on the new policy vary widely among students.","ko":"새 정책에 대한 의견은 학생들 사이에서 크게 다르다."},
    {"en":"The temperature can vary greatly between day and night.","ko":"기온은 낮과 밤 사이에 크게 달라질 수 있다."},
    {"en":"Teachers should vary their methods to keep students interested.","ko":"교사들은 학생들의 흥미를 유지하기 위해 방법을 다양하게 해야 한다."}
  ]'::jsonb),
  ('conflict', 2, 25, '명사/동사', '[
    {"en":"The two nations reached an agreement to end the conflict.","ko":"두 나라는 갈등을 끝내기 위한 합의에 도달했다."},
    {"en":"Her opinion seemed to conflict with the official report.","ko":"그녀의 의견은 공식 보고서와 충돌하는 것처럼 보였다."},
    {"en":"Family conflicts can often be resolved through open conversation.","ko":"가족 간의 갈등은 흔히 솔직한 대화를 통해 해결될 수 있다."}
  ]'::jsonb),
  ('aware', 2, 25, '형용사', '[
    {"en":"Students should be aware of the risks of skipping breakfast.","ko":"학생들은 아침을 거르는 것의 위험성을 알고 있어야 한다."},
    {"en":"She was not aware that the meeting had been rescheduled.","ko":"그녀는 회의 일정이 변경된 것을 알지 못했다."},
    {"en":"Being aware of cultural differences helps avoid misunderstandings.","ko":"문화적 차이를 인식하는 것은 오해를 피하는 데 도움이 된다."}
  ]'::jsonb),
  ('approach', 2, 25, '동사/명사', '[
    {"en":"The teacher approached the problem from a different angle.","ko":"선생님은 그 문제에 다른 각도로 접근했다."},
    {"en":"As winter approached, the days grew shorter.","ko":"겨울이 다가오면서 낮이 짧아졌다."},
    {"en":"This textbook takes a practical approach to grammar.","ko":"이 교과서는 문법에 대해 실용적인 접근법을 취한다."}
  ]'::jsonb),
  ('urge', 2, 25, '동사', '[
    {"en":"Doctors urge people to exercise regularly for good health.","ko":"의사들은 건강을 위해 규칙적으로 운동하라고 사람들에게 촉구한다."},
    {"en":"The coach urged the team to keep practicing every day.","ko":"코치는 팀에게 매일 계속 연습하라고 재촉했다."},
    {"en":"Her parents urged her to apply for the scholarship.","ko":"그녀의 부모님은 그녀에게 장학금을 신청하라고 강력히 권했다."}
  ]'::jsonb),
  ('associate', 2, 25, '동사/명사', '[
    {"en":"Many people associate the color red with danger or energy.","ko":"많은 사람들은 빨간색을 위험이나 에너지와 연관 짓는다."},
    {"en":"He works as a research associate at the university.","ko":"그는 대학교에서 연구원으로 일한다."},
    {"en":"She began to associate with students from other countries.","ko":"그녀는 다른 나라 학생들과 어울리기 시작했다."}
  ]'::jsonb),
  ('interpret', 2, 25, '동사', '[
    {"en":"The teacher asked us to interpret the deeper meaning of the poem.","ko":"선생님은 우리에게 그 시의 더 깊은 의미를 해석해 보라고 했다."},
    {"en":"He was hired to interpret for foreign visitors at the conference.","ko":"그는 회의에서 외국인 방문객을 위해 통역하도록 고용되었다."},
    {"en":"Different readers may interpret the same novel in different ways.","ko":"서로 다른 독자들은 같은 소설을 다르게 해석할 수 있다."}
  ]'::jsonb),
  ('alternative', 2, 25, '명사/형용사', '[
    {"en":"Riding a bicycle is a healthy alternative to driving a car.","ko":"자전거를 타는 것은 자동차 운전에 대한 건강한 대안이다."},
    {"en":"We need to find an alternative solution to this problem.","ko":"우리는 이 문제에 대한 대안적인 해결책을 찾아야 한다."},
    {"en":"Solar power is becoming a popular alternative energy source.","ko":"태양광 발전은 인기 있는 대체 에너지원이 되고 있다."}
  ]'::jsonb),
  ('assist', 2, 25, '동사', '[
    {"en":"Volunteers assisted the elderly residents with their groceries.","ko":"자원봉사자들은 노인 주민들이 장 본 것을 옮기는 것을 도왔다."},
    {"en":"This app is designed to assist students with their homework.","ko":"이 앱은 학생들이 숙제하는 것을 돕도록 설계되었다."},
    {"en":"The nurse assisted the doctor during the operation.","ko":"간호사는 수술 중 의사를 도왔다."}
  ]'::jsonb),
  ('affair', 2, 25, '명사', '[
    {"en":"The school festival was a lively and colorful affair.","ko":"학교 축제는 활기차고 다채로운 행사였다."},
    {"en":"She handled the whole affair with great calm and patience.","ko":"그녀는 그 모든 일을 매우 침착하고 인내심 있게 처리했다."},
    {"en":"International affairs are discussed in his political science class.","ko":"국제 문제는 그의 정치학 수업에서 다루어진다."}
  ]'::jsonb),
  ('widespread', 2, 25, '형용사', '[
    {"en":"The new smartphone gained widespread popularity within months.","ko":"그 새 스마트폰은 몇 달 만에 폭넓은 인기를 얻었다."},
    {"en":"There is widespread concern about air pollution in big cities.","ko":"대도시의 대기 오염에 대한 광범위한 우려가 있다."},
    {"en":"The drought caused widespread damage to local farms.","ko":"가뭄은 지역 농장들에 광범위한 피해를 입혔다."}
  ]'::jsonb),
  ('external', 2, 25, '형용사', '[
    {"en":"The company hired an external consultant to review its policies.","ko":"그 회사는 정책을 검토하기 위해 외부 컨설턴트를 고용했다."},
    {"en":"External factors such as weather can affect crop production.","ko":"날씨와 같은 외부 요인은 작물 생산에 영향을 줄 수 있다."},
    {"en":"The device has an external battery pack for extra power.","ko":"그 기기는 추가 전력을 위한 외장 배터리 팩을 가지고 있다."}
  ]'::jsonb),
  ('alien', 2, 25, '형용사', '[
    {"en":"The customs were completely alien to the young exchange student.","ko":"그 관습은 어린 교환학생에게 완전히 낯설었다."},
    {"en":"Scientists study how alien species can affect local ecosystems.","ko":"과학자들은 외래종이 지역 생태계에 어떻게 영향을 미치는지 연구한다."},
    {"en":"The idea of eating insects seemed alien to most classmates.","ko":"곤충을 먹는다는 생각은 대부분의 급우들에게 낯설게 느껴졌다."}
  ]'::jsonb),
  ('famine', 2, 25, '명사', '[
    {"en":"The severe drought led to a widespread famine in the region.","ko":"극심한 가뭄은 그 지역에 광범위한 기근을 초래했다."},
    {"en":"Relief organizations sent food supplies to areas hit by famine.","ko":"구호 단체들은 기근이 발생한 지역에 식량을 보냈다."},
    {"en":"Historians studied how the famine changed the country's population.","ko":"역사학자들은 그 기근이 그 나라의 인구를 어떻게 변화시켰는지 연구했다."}
  ]'::jsonb),
  ('refuge', 2, 25, '명사', '[
    {"en":"The travelers sought refuge from the storm in a small cabin.","ko":"여행자들은 작은 오두막에서 폭풍을 피할 피난처를 찾았다."},
    {"en":"The wildlife refuge protects hundreds of rare bird species.","ko":"그 야생 동물 보호구역은 수백 종의 희귀 조류를 보호한다."},
    {"en":"Many families took refuge in the community center during the flood.","ko":"홍수 동안 많은 가족들이 주민센터로 피신했다."}
  ]'::jsonb),
  ('shortage', 2, 25, '명사', '[
    {"en":"The city is facing a serious water shortage this summer.","ko":"그 도시는 이번 여름 심각한 물 부족에 직면해 있다."},
    {"en":"A shortage of teachers has affected several rural schools.","ko":"교사 부족은 여러 시골 학교에 영향을 미쳤다."},
    {"en":"Farmers worried about a shortage of rain during the dry season.","ko":"농부들은 건기 동안 강우 부족을 걱정했다."}
  ]'::jsonb),
  ('endanger', 2, 25, '동사', '[
    {"en":"Pollution continues to endanger many species of marine life.","ko":"오염은 계속해서 많은 해양 생물 종을 위험에 빠뜨리고 있다."},
    {"en":"Careless driving can endanger both the driver and pedestrians.","ko":"부주의한 운전은 운전자와 보행자 모두를 위험에 빠뜨릴 수 있다."},
    {"en":"Deforestation endangers the habitats of countless animals.","ko":"삼림 벌채는 수많은 동물들의 서식지를 위험에 빠뜨린다."}
  ]'::jsonb),
  ('contaminate', 2, 25, '동사', '[
    {"en":"Chemical waste can contaminate rivers and drinking water.","ko":"화학 폐기물은 강과 식수를 오염시킬 수 있다."},
    {"en":"The factory was fined for contaminating the nearby soil.","ko":"그 공장은 인근 토양을 오염시켜 벌금을 부과받았다."},
    {"en":"Unwashed hands can easily contaminate food during cooking.","ko":"씻지 않은 손은 요리하는 동안 음식을 쉽게 오염시킬 수 있다."}
  ]'::jsonb),
  ('preserve', 2, 25, '동사', '[
    {"en":"The museum works hard to preserve historical artifacts.","ko":"그 박물관은 역사적 유물을 보존하기 위해 애쓴다."},
    {"en":"Local farmers preserve vegetables by pickling them in jars.","ko":"현지 농부들은 채소를 병에 절여서 보존한다."},
    {"en":"We should preserve the forest for future generations.","ko":"우리는 미래 세대를 위해 숲을 보존해야 한다."}
  ]'::jsonb),
  ('explode', 2, 25, '동사', '[
    {"en":"The chemistry experiment nearly caused the flask to explode.","ko":"그 화학 실험은 플라스크가 폭발할 뻔하게 만들었다."},
    {"en":"Fireworks exploded brightly in the night sky during the festival.","ko":"축제 동안 밤하늘에 불꽃이 밝게 터졌다."},
    {"en":"Sales of the new product exploded after the advertisement aired.","ko":"광고가 방영된 후 그 신제품의 판매량이 급증했다."}
  ]'::jsonb),
  ('integrate', 2, 25, '동사', '[
    {"en":"The new student quickly integrated into the class community.","ko":"그 새로운 학생은 학급 공동체에 빠르게 통합되었다."},
    {"en":"The company plans to integrate two departments into one team.","ko":"그 회사는 두 부서를 하나의 팀으로 통합할 계획이다."},
    {"en":"Schools try to integrate technology into everyday lessons.","ko":"학교들은 일상 수업에 기술을 통합하려고 노력한다."}
  ]'::jsonb),
  ('guard', 2, 25, '동사/명사', '[
    {"en":"Soldiers guarded the entrance to the historic palace.","ko":"군인들은 그 유서 깊은 궁전의 입구를 지켰다."},
    {"en":"The museum hired extra guards during the special exhibition.","ko":"그 박물관은 특별 전시회 동안 추가 경비원을 고용했다."},
    {"en":"Sunscreen helps guard your skin against harmful sunlight.","ko":"자외선 차단제는 해로운 햇빛으로부터 피부를 보호하는 데 도움을 준다."}
  ]'::jsonb),
  ('remark', 2, 25, '명사/동사', '[
    {"en":"The teacher made a kind remark about her essay.","ko":"선생님은 그녀의 에세이에 대해 친절한 말을 했다."},
    {"en":"He remarked that the weather had improved greatly this week.","ko":"그는 이번 주에 날씨가 크게 좋아졌다고 언급했다."},
    {"en":"Her thoughtful remarks impressed everyone at the meeting.","ko":"그녀의 사려 깊은 발언은 회의에 참석한 모든 사람에게 감명을 주었다."}
  ]'::jsonb),
  ('accord', 2, 25, '명사/동사', '[
    {"en":"The two countries signed a peace accord after years of talks.","ko":"두 나라는 몇 년간의 협상 끝에 평화 협정을 체결했다."},
    {"en":"Her actions did not accord with her earlier statements.","ko":"그녀의 행동은 이전 발언과 일치하지 않았다."},
    {"en":"The plan was carried out in accord with the new guidelines.","ko":"그 계획은 새 지침에 따라 실행되었다."}
  ]'::jsonb),
  ('interfere in', 2, 25, '동사구', '[
    {"en":"Parents should avoid interfering in their teenager''s every decision.","ko":"부모는 십 대 자녀의 모든 결정에 간섭하는 것을 피해야 한다."},
    {"en":"The teacher tried not to interfere in the students'' group project.","ko":"선생님은 학생들의 조별 과제에 간섭하지 않으려고 했다."},
    {"en":"He was warned not to interfere in matters that did not concern him.","ko":"그는 자신과 관계없는 일에 간섭하지 말라는 경고를 받았다."}
  ]'::jsonb),
  ('keep up with', 2, 25, '동사구', '[
    {"en":"She reads the newspaper daily to keep up with current events.","ko":"그녀는 시사에 뒤떨어지지 않기 위해 매일 신문을 읽는다."},
    {"en":"It is hard to keep up with all the new technology trends.","ko":"모든 새로운 기술 동향을 따라가는 것은 어렵다."},
    {"en":"He jogged faster to keep up with his older brother.","ko":"그는 형을 따라잡기 위해 더 빨리 조깅했다."}
  ]'::jsonb),
  ('break off', 2, 25, '동사구', '[
    {"en":"The two companies broke off their business partnership.","ko":"두 회사는 사업 제휴 관계를 단절했다."},
    {"en":"Negotiations broke off after the two sides failed to agree.","ko":"양측이 합의에 실패한 후 협상이 결렬되었다."},
    {"en":"She broke off in the middle of her sentence to answer the phone.","ko":"그녀는 전화를 받기 위해 말을 하다가 갑자기 멈췄다."}
  ]'::jsonb),
  ('previous', 2, 26, '형용사', '[
    {"en":"Please review the previous chapter before starting this lesson.","ko":"이 수업을 시작하기 전에 이전 장을 복습하세요."},
    {"en":"She had no previous experience working as a tour guide.","ko":"그녀는 관광 가이드로 일한 이전 경험이 없었다."},
    {"en":"The results were better than those of the previous test.","ko":"그 결과는 이전 시험의 결과보다 더 좋았다."}
  ]'::jsonb),
  ('prior', 2, 26, '형용사', '[
    {"en":"Students must complete the prior assignment before moving on.","ko":"학생들은 다음으로 넘어가기 전에 이전 과제를 끝내야 한다."},
    {"en":"He had no prior knowledge of the surprise event.","ko":"그는 그 깜짝 행사에 대해 사전 지식이 전혀 없었다."},
    {"en":"Prior approval is required before using the school gym.","ko":"학교 체육관을 사용하기 전에 사전 승인이 필요하다."}
  ]'::jsonb),
  ('decade', 2, 26, '명사', '[
    {"en":"The town has changed a great deal over the past decade.","ko":"그 마을은 지난 10년 동안 많이 변했다."},
    {"en":"She has been teaching English for more than a decade.","ko":"그녀는 10년 넘게 영어를 가르쳐 왔다."},
    {"en":"Technology has advanced rapidly in the last decade.","ko":"지난 10년 동안 기술은 빠르게 발전했다."}
  ]'::jsonb),
  ('biography', 2, 26, '명사', '[
    {"en":"The library added a new biography of a famous scientist.","ko":"도서관은 유명한 과학자의 새로운 전기를 추가했다."},
    {"en":"Our class read a biography about a courageous explorer.","ko":"우리 반은 용감한 탐험가에 관한 전기를 읽었다."},
    {"en":"The author spent five years writing the biography.","ko":"그 저자는 그 전기를 쓰는 데 5년을 보냈다."}
  ]'::jsonb),
  ('devote', 2, 26, '동사', '[
    {"en":"She devotes most of her free time to studying music.","ko":"그녀는 여가 시간 대부분을 음악 공부에 바친다."},
    {"en":"He decided to devote his career to medical research.","ko":"그는 자신의 경력을 의학 연구에 바치기로 결심했다."},
    {"en":"The teacher devoted extra hours to helping struggling students.","ko":"선생님은 어려움을 겪는 학생들을 돕는 데 추가 시간을 쏟았다."}
  ]'::jsonb),
  ('faith', 2, 26, '명사', '[
    {"en":"The coach had great faith in her team''s ability to win.","ko":"코치는 자기 팀이 이길 능력이 있다고 굳게 믿었다."},
    {"en":"He kept his faith even during difficult times.","ko":"그는 어려운 시기에도 믿음을 잃지 않았다."},
    {"en":"Their friendship was built on trust and faith.","ko":"그들의 우정은 신뢰와 믿음 위에 세워졌다."}
  ]'::jsonb),
  ('minority', 2, 26, '명사', '[
    {"en":"Only a small minority of students disagreed with the plan.","ko":"오직 소수의 학생들만이 그 계획에 반대했다."},
    {"en":"The novel tells the story of a minority community.","ko":"그 소설은 소수 집단 공동체의 이야기를 다룬다."},
    {"en":"Minority opinions were also discussed during the debate.","ko":"토론 중에 소수 의견도 논의되었다."}
  ]'::jsonb),
  ('mummy', 2, 26, '명사', '[
    {"en":"The museum displayed an ancient Egyptian mummy.","ko":"박물관은 고대 이집트 미라를 전시했다."},
    {"en":"Scientists used X-rays to study the mummy without damaging it.","ko":"과학자들은 미라를 손상시키지 않고 연구하기 위해 엑스레이를 사용했다."},
    {"en":"The children were fascinated by the wrapped mummy in the exhibit.","ko":"아이들은 전시된 감싸진 미라에 매료되었다."}
  ]'::jsonb),
  ('remains', 2, 26, '명사', '[
    {"en":"Archaeologists discovered the remains of an ancient city.","ko":"고고학자들은 고대 도시의 유적을 발견했다."},
    {"en":"The remains of the old castle still stand on the hill.","ko":"그 오래된 성의 잔해는 여전히 언덕 위에 서 있다."},
    {"en":"Researchers carefully studied the ancient remains found underground.","ko":"연구자들은 지하에서 발견된 고대 유해를 조심스럽게 연구했다."}
  ]'::jsonb),
  ('rid', 2, 26, '동사', '[
    {"en":"The new filter helps rid the water of impurities.","ko":"새 필터는 물에서 불순물을 제거하는 데 도움을 준다."},
    {"en":"She wanted to rid her room of unnecessary clutter.","ko":"그녀는 방에서 불필요한 잡동사니를 없애고 싶어 했다."},
    {"en":"Farmers used natural methods to rid the field of pests.","ko":"농부들은 밭에서 해충을 없애기 위해 자연적인 방법을 사용했다."}
  ]'::jsonb),
  ('origin', 2, 26, '명사', '[
    {"en":"The origin of the tradition dates back centuries.","ko":"그 전통의 기원은 수백 년 전으로 거슬러 올라간다."},
    {"en":"Scientists are still studying the origin of the universe.","ko":"과학자들은 여전히 우주의 기원을 연구하고 있다."},
    {"en":"The word has its origin in an ancient language.","ko":"그 단어는 고대 언어에 기원을 두고 있다."}
  ]'::jsonb),
  ('civilization', 2, 26, '명사', '[
    {"en":"Ancient civilizations left behind remarkable works of art.","ko":"고대 문명들은 놀라운 예술 작품들을 남겼다."},
    {"en":"The museum exhibit traces the rise of early civilizations.","ko":"그 박물관 전시는 초기 문명의 발흥을 추적한다."},
    {"en":"Historians study how civilizations developed writing systems.","ko":"역사학자들은 문명이 어떻게 문자 체계를 발전시켰는지 연구한다."}
  ]'::jsonb),
  ('revolution', 2, 26, '명사', '[
    {"en":"The invention of the internet caused a technological revolution.","ko":"인터넷의 발명은 기술 혁명을 일으켰다."},
    {"en":"Students learned about the causes of the industrial revolution.","ko":"학생들은 산업 혁명의 원인에 대해 배웠다."},
    {"en":"The revolution brought major political changes to the country.","ko":"그 혁명은 그 나라에 커다란 정치적 변화를 가져왔다."}
  ]'::jsonb),
  ('royal', 2, 26, '형용사', '[
    {"en":"Tourists gathered to see the royal palace in the capital.","ko":"관광객들은 수도의 왕궁을 보기 위해 모여들었다."},
    {"en":"The royal family attended the opening ceremony.","ko":"왕실 가족이 개막식에 참석했다."},
    {"en":"The museum displayed jewelry once owned by royal families.","ko":"박물관은 한때 왕족이 소유했던 보석을 전시했다."}
  ]'::jsonb),
  ('heritage', 2, 26, '명사', '[
    {"en":"The old temple is an important part of the nation''s heritage.","ko":"그 오래된 사원은 그 나라의 유산 중 중요한 부분이다."},
    {"en":"Students learned to appreciate their cultural heritage.","ko":"학생들은 자신의 문화유산을 소중히 여기는 법을 배웠다."},
    {"en":"The festival celebrates the region''s rich heritage.","ko":"그 축제는 그 지역의 풍부한 유산을 기념한다."}
  ]'::jsonb),
  ('missionary', 2, 26, '명사', '[
    {"en":"The missionary built a school in the small village.","ko":"그 선교사는 그 작은 마을에 학교를 세웠다."},
    {"en":"Historians studied the influence of missionaries on local education.","ko":"역사학자들은 선교사들이 지역 교육에 미친 영향을 연구했다."},
    {"en":"The missionary spent decades helping the community.","ko":"그 선교사는 수십 년을 그 공동체를 돕는 데 보냈다."}
  ]'::jsonb),
  ('sermon', 2, 26, '명사', '[
    {"en":"The priest gave a sermon about kindness and honesty.","ko":"신부는 친절과 정직에 관한 설교를 했다."},
    {"en":"Many visitors listened quietly to the sermon.","ko":"많은 방문객들이 조용히 설교를 들었다."},
    {"en":"Her speech felt more like a sermon than a lecture.","ko":"그녀의 연설은 강의라기보다 설교처럼 느껴졌다."}
  ]'::jsonb),
  ('settle', 2, 26, '동사', '[
    {"en":"The family decided to settle in a small countryside town.","ko":"그 가족은 작은 시골 마을에 정착하기로 결정했다."},
    {"en":"The two friends settled their disagreement calmly.","ko":"두 친구는 차분하게 의견 차이를 해결했다."},
    {"en":"It took several meetings to settle the details of the plan.","ko":"그 계획의 세부 사항을 정하는 데 여러 번의 회의가 필요했다."}
  ]'::jsonb),
  ('replace', 2, 26, '동사', '[
    {"en":"The school plans to replace the old computers next year.","ko":"학교는 내년에 오래된 컴퓨터를 교체할 계획이다."},
    {"en":"Nothing can replace the value of a good education.","ko":"좋은 교육의 가치를 대신할 수 있는 것은 없다."},
    {"en":"The broken window was quickly replaced.","ko":"깨진 창문은 신속하게 교체되었다."}
  ]'::jsonb),
  ('signify', 2, 26, '동사', '[
    {"en":"A red light usually signifies danger or a warning.","ko":"빨간불은 보통 위험이나 경고를 나타낸다."},
    {"en":"Her smile seemed to signify approval of the plan.","ko":"그녀의 미소는 그 계획에 대한 찬성을 의미하는 듯했다."},
    {"en":"The ceremony signifies the beginning of a new school year.","ko":"그 의식은 새 학년의 시작을 의미한다."}
  ]'::jsonb),
  ('conserve', 2, 26, '동사', '[
    {"en":"Turning off lights helps conserve electricity at home.","ko":"불을 끄는 것은 집에서 전기를 절약하는 데 도움이 된다."},
    {"en":"The park was created to conserve the local wildlife.","ko":"그 공원은 지역 야생 동물을 보존하기 위해 조성되었다."},
    {"en":"Farmers used new techniques to conserve water during the drought.","ko":"농부들은 가뭄 동안 물을 절약하기 위해 새로운 기술을 사용했다."}
  ]'::jsonb),
  ('evaluate', 2, 26, '동사', '[
    {"en":"Teachers evaluate students'' progress through regular tests.","ko":"교사들은 정기적인 시험을 통해 학생들의 발전을 평가한다."},
    {"en":"The committee will evaluate each proposal carefully.","ko":"위원회는 각 제안을 신중하게 평가할 것이다."},
    {"en":"It is important to evaluate the results before drawing conclusions.","ko":"결론을 내리기 전에 결과를 평가하는 것이 중요하다."}
  ]'::jsonb),
  ('descend', 2, 26, '동사', '[
    {"en":"The hikers slowly descended the steep mountain trail.","ko":"등산객들은 가파른 산길을 천천히 내려갔다."},
    {"en":"Many English words descend from Latin roots.","ko":"많은 영어 단어들은 라틴어 어근에서 유래한다."},
    {"en":"The plane began to descend as it approached the airport.","ko":"비행기는 공항에 접근하면서 하강하기 시작했다."}
  ]'::jsonb),
  ('disappear', 2, 26, '동사', '[
    {"en":"The morning fog disappeared as the sun rose higher.","ko":"해가 더 높이 뜨면서 아침 안개가 사라졌다."},
    {"en":"Many traditional customs have gradually disappeared over time.","ko":"많은 전통 풍습들이 시간이 지나면서 점차 사라져 왔다."},
    {"en":"The magician made the coin disappear in an instant.","ko":"마술사는 순식간에 동전을 사라지게 했다."}
  ]'::jsonb),
  ('sequence', 2, 26, '명사', '[
    {"en":"Please arrange the events in the correct sequence.","ko":"그 사건들을 올바른 순서대로 배열해 주세요."},
    {"en":"The scientist explained the sequence of chemical reactions.","ko":"과학자는 화학 반응의 순서를 설명했다."},
    {"en":"Students practiced the dance sequence several times.","ko":"학생들은 그 춤 동작 순서를 여러 번 연습했다."}
  ]'::jsonb),
  ('gradual', 2, 26, '형용사', '[
    {"en":"The city experienced a gradual increase in population.","ko":"그 도시는 인구의 점진적인 증가를 경험했다."},
    {"en":"Learning a language requires gradual and steady practice.","ko":"언어를 배우는 것은 점진적이고 꾸준한 연습을 필요로 한다."},
    {"en":"There was a gradual change in the weather throughout the week.","ko":"그 주 내내 날씨에 점진적인 변화가 있었다."}
  ]'::jsonb),
  ('sacred', 2, 26, '형용사', '[
    {"en":"The mountain is considered sacred by the local people.","ko":"그 산은 지역 주민들에 의해 신성하게 여겨진다."},
    {"en":"Visitors were asked to respect the sacred temple grounds.","ko":"방문객들은 신성한 사원 경내를 존중하도록 요청받았다."},
    {"en":"The ancient text is regarded as a sacred document.","ko":"그 고대 문서는 신성한 문서로 여겨진다."}
  ]'::jsonb),
  ('break out', 2, 26, '동사구', '[
    {"en":"A small fire broke out in the school kitchen.","ko":"학교 주방에서 작은 화재가 발생했다."},
    {"en":"Historians studied why the conflict broke out between the two nations.","ko":"역사학자들은 두 나라 사이에 갈등이 왜 발발했는지 연구했다."},
    {"en":"An argument broke out during the class debate.","ko":"수업 토론 중에 논쟁이 벌어졌다."}
  ]'::jsonb),
  ('derive from', 2, 26, '동사구', '[
    {"en":"Many English words derive from Latin and Greek.","ko":"많은 영어 단어들은 라틴어와 그리스어에서 유래한다."},
    {"en":"The custom derives from an old religious tradition.","ko":"그 풍습은 오래된 종교 전통에서 유래한다."},
    {"en":"Her confidence derives from years of hard practice.","ko":"그녀의 자신감은 수년간의 각고의 연습에서 나온다."}
  ]'::jsonb),
  ('hand down', 2, 26, '동사구', '[
    {"en":"The recipe has been handed down through generations.","ko":"그 조리법은 여러 세대를 거쳐 전해져 왔다."},
    {"en":"Grandparents often hand down family stories to their grandchildren.","ko":"조부모는 종종 가족 이야기를 손주들에게 전해 준다."},
    {"en":"The traditional skill was handed down from teacher to student.","ko":"그 전통 기술은 스승에게서 제자에게로 전수되었다."}
  ]'::jsonb),
  ('biology', 2, 27, '명사', '[
    {"en":"She is taking an advanced biology class this semester.","ko":"그녀는 이번 학기에 심화 생물학 수업을 듣고 있다."},
    {"en":"Biology helps us understand how living things function.","ko":"생물학은 생명체가 어떻게 기능하는지 이해하는 데 도움을 준다."},
    {"en":"The biology teacher explained how cells divide.","ko":"생물 선생님은 세포가 어떻게 분열하는지 설명했다."}
  ]'::jsonb),
  ('chemistry', 2, 27, '명사', '[
    {"en":"Chemistry class taught us how to mix compounds safely.","ko":"화학 수업은 우리에게 화합물을 안전하게 섞는 방법을 가르쳐 주었다."},
    {"en":"He scored the highest grade in the chemistry exam.","ko":"그는 화학 시험에서 가장 높은 점수를 받았다."},
    {"en":"Understanding chemistry helps explain everyday reactions like rust.","ko":"화학을 이해하는 것은 녹과 같은 일상적인 반응을 설명하는 데 도움이 된다."}
  ]'::jsonb),
  ('element', 2, 27, '명사', '[
    {"en":"Oxygen is an essential element for human survival.","ko":"산소는 인간 생존에 필수적인 요소이다."},
    {"en":"Teamwork is a key element of a successful project.","ko":"팀워크는 성공적인 프로젝트의 핵심 요소이다."},
    {"en":"The periodic table lists every known chemical element.","ko":"주기율표는 알려진 모든 화학 원소를 나열한다."}
  ]'::jsonb),
  ('acid', 2, 27, '명사/형용사', '[
    {"en":"The scientist carefully mixed the acid in the laboratory.","ko":"그 과학자는 실험실에서 산을 조심스럽게 섞었다."},
    {"en":"Lemon juice contains a mild acid that gives it a sour taste.","ko":"레몬즙에는 신맛을 내는 약한 산이 들어 있다."},
    {"en":"Acid rain can damage forests and buildings over time.","ko":"산성비는 시간이 지나면서 숲과 건물에 피해를 줄 수 있다."}
  ]'::jsonb),
  ('storage', 2, 27, '명사', '[
    {"en":"The school built a new storage room for sports equipment.","ko":"학교는 운동 기구를 위한 새로운 창고를 지었다."},
    {"en":"Cloud storage allows users to save files online.","ko":"클라우드 저장소는 사용자가 온라인에 파일을 저장할 수 있게 해 준다."},
    {"en":"Proper storage keeps food fresh for a longer time.","ko":"적절한 저장은 음식을 더 오래 신선하게 유지해 준다."}
  ]'::jsonb),
  ('steam', 2, 27, '명사', '[
    {"en":"Steam rose from the pot of boiling water.","ko":"끓는 물이 담긴 냄비에서 김이 피어올랐다."},
    {"en":"The old train was powered by steam.","ko":"그 오래된 기차는 증기로 동력을 얻었다."},
    {"en":"Steam can be used to generate electricity in power plants.","ko":"증기는 발전소에서 전기를 만드는 데 사용될 수 있다."}
  ]'::jsonb),
  ('gene', 2, 27, '명사', '[
    {"en":"Scientists study how genes are passed from parents to children.","ko":"과학자들은 유전자가 부모에게서 자녀에게 어떻게 전달되는지 연구한다."},
    {"en":"A single gene can affect eye color.","ko":"하나의 유전자가 눈 색깔에 영향을 줄 수 있다."},
    {"en":"Researchers identified the gene responsible for the trait.","ko":"연구자들은 그 형질을 담당하는 유전자를 확인했다."}
  ]'::jsonb),
  ('mammal', 2, 27, '명사', '[
    {"en":"Whales are mammals even though they live in the ocean.","ko":"고래는 바다에 살지만 포유류이다."},
    {"en":"The zoo has an exhibit dedicated to small mammals.","ko":"그 동물원에는 작은 포유동물을 위한 전시관이 있다."},
    {"en":"Unlike birds, mammals give birth to live young.","ko":"새와 달리 포유류는 살아 있는 새끼를 낳는다."}
  ]'::jsonb),
  ('melt', 2, 27, '동사', '[
    {"en":"The ice cream began to melt quickly in the summer heat.","ko":"아이스크림은 여름 더위 속에서 빠르게 녹기 시작했다."},
    {"en":"Heat the butter until it melts completely.","ko":"버터가 완전히 녹을 때까지 가열하세요."},
    {"en":"Rising temperatures cause glaciers to melt faster.","ko":"기온 상승은 빙하가 더 빨리 녹게 만든다."}
  ]'::jsonb),
  ('cell', 2, 27, '명사', '[
    {"en":"Every living organism is made up of tiny cells.","ko":"모든 생명체는 작은 세포들로 이루어져 있다."},
    {"en":"Students observed plant cells under the microscope.","ko":"학생들은 현미경으로 식물 세포를 관찰했다."},
    {"en":"The human body contains trillions of cells.","ko":"인간의 몸은 수조 개의 세포를 포함하고 있다."}
  ]'::jsonb),
  ('microscope', 2, 27, '명사', '[
    {"en":"We examined the sample closely under a microscope.","ko":"우리는 현미경으로 시료를 자세히 관찰했다."},
    {"en":"The biology lab has several powerful microscopes.","ko":"그 생물학 실험실에는 성능 좋은 현미경이 여러 대 있다."},
    {"en":"She adjusted the microscope to get a clearer image.","ko":"그녀는 더 선명한 이미지를 얻기 위해 현미경을 조정했다."}
  ]'::jsonb),
  ('reproduce', 2, 27, '동사', '[
    {"en":"Many plants reproduce by releasing seeds into the wind.","ko":"많은 식물들은 바람에 씨앗을 날려 보내 번식한다."},
    {"en":"The artist tried to reproduce the painting''s exact colors.","ko":"그 화가는 그 그림의 정확한 색을 재현하려고 애썼다."},
    {"en":"Bacteria can reproduce rapidly under the right conditions.","ko":"박테리아는 알맞은 조건에서 빠르게 번식할 수 있다."}
  ]'::jsonb),
  ('evolution', 2, 27, '명사', '[
    {"en":"The theory of evolution explains how species change over time.","ko":"진화론은 종이 시간에 따라 어떻게 변화하는지 설명한다."},
    {"en":"Students discussed the evolution of language throughout history.","ko":"학생들은 역사에 걸친 언어의 진화에 대해 토론했다."},
    {"en":"The museum has an exhibit on human evolution.","ko":"그 박물관에는 인류 진화에 관한 전시가 있다."}
  ]'::jsonb),
  ('extinct', 2, 27, '형용사', '[
    {"en":"Dinosaurs became extinct millions of years ago.","ko":"공룡은 수백만 년 전에 멸종했다."},
    {"en":"Several species are at risk of becoming extinct.","ko":"여러 종이 멸종될 위험에 처해 있다."},
    {"en":"The volcano has been extinct for centuries.","ko":"그 화산은 수 세기 동안 활동을 멈춘 상태이다."}
  ]'::jsonb),
  ('clone', 2, 27, '동사/명사', '[
    {"en":"Scientists successfully cloned a sheep in the 1990s.","ko":"과학자들은 1990년대에 양을 성공적으로 복제했다."},
    {"en":"The lab created a clone to study genetic traits.","ko":"그 연구실은 유전적 형질을 연구하기 위해 복제 생물을 만들었다."},
    {"en":"Researchers debated the ethics of cloning animals.","ko":"연구자들은 동물 복제의 윤리성에 대해 논쟁했다."}
  ]'::jsonb),
  ('identical', 2, 27, '형용사', '[
    {"en":"The twins looked so identical that even friends confused them.","ko":"그 쌍둥이는 너무 똑같아 보여서 친구들조차 헷갈려 했다."},
    {"en":"Both reports contained almost identical information.","ko":"두 보고서는 거의 동일한 정보를 담고 있었다."},
    {"en":"The two paintings appeared nearly identical at first glance.","ko":"그 두 그림은 언뜻 보기에 거의 동일해 보였다."}
  ]'::jsonb),
  ('animate', 2, 27, '형용사', '[
    {"en":"The story distinguishes between animate and inanimate objects.","ko":"그 이야기는 생물과 무생물을 구별한다."},
    {"en":"Children learn to identify animate beings in science class.","ko":"아이들은 과학 수업에서 생물을 식별하는 법을 배운다."},
    {"en":"The sculpture seemed almost animate in the dim light.","ko":"그 조각상은 어스름한 빛 속에서 거의 살아 있는 것처럼 보였다."}
  ]'::jsonb),
  ('carbon', 2, 27, '명사', '[
    {"en":"Carbon is a basic element found in all living things.","ko":"탄소는 모든 생명체에서 발견되는 기본 원소이다."},
    {"en":"The company aims to reduce its carbon emissions.","ko":"그 회사는 탄소 배출을 줄이는 것을 목표로 한다."},
    {"en":"Diamonds are made of pure carbon.","ko":"다이아몬드는 순수한 탄소로 이루어져 있다."}
  ]'::jsonb),
  ('mixture', 2, 27, '명사', '[
    {"en":"The teacher prepared a mixture of salt and water for the experiment.","ko":"선생님은 실험을 위해 소금과 물의 혼합물을 준비했다."},
    {"en":"The cake batter is a mixture of flour, eggs, and sugar.","ko":"케이크 반죽은 밀가루, 달걀, 설탕의 혼합물이다."},
    {"en":"The air we breathe is a mixture of several gases.","ko":"우리가 숨 쉬는 공기는 여러 기체의 혼합물이다."}
  ]'::jsonb),
  ('substance', 2, 27, '명사', '[
    {"en":"The chemist identified an unknown substance in the sample.","ko":"화학자는 시료에서 미지의 물질을 확인했다."},
    {"en":"Water is a substance made of hydrogen and oxygen.","ko":"물은 수소와 산소로 이루어진 물질이다."},
    {"en":"The label listed every substance used in the product.","ko":"라벨에는 그 제품에 사용된 모든 물질이 표시되어 있었다."}
  ]'::jsonb),
  ('liquid', 2, 27, '명사/형용사', '[
    {"en":"Water changes from a liquid to a solid when it freezes.","ko":"물은 얼면 액체에서 고체로 변한다."},
    {"en":"The bottle contained a clear liquid.","ko":"그 병에는 투명한 액체가 들어 있었다."},
    {"en":"Students measured the liquid carefully during the experiment.","ko":"학생들은 실험 중 액체를 조심스럽게 측정했다."}
  ]'::jsonb),
  ('filter', 2, 27, '동사/명사', '[
    {"en":"The machine filters impurities out of the drinking water.","ko":"그 기계는 식수에서 불순물을 걸러낸다."},
    {"en":"She replaced the old filter in the air purifier.","ko":"그녀는 공기 청정기의 낡은 필터를 교체했다."},
    {"en":"Sunlight is filtered through the leaves of the trees.","ko":"햇빛은 나뭇잎을 통해 여과된다."}
  ]'::jsonb),
  ('absorb', 2, 27, '동사', '[
    {"en":"Plants absorb sunlight to produce energy through photosynthesis.","ko":"식물은 광합성을 통해 에너지를 만들기 위해 햇빛을 흡수한다."},
    {"en":"The sponge quickly absorbed the spilled water.","ko":"스펀지는 쏟아진 물을 빠르게 흡수했다."},
    {"en":"She was completely absorbed in her science project.","ko":"그녀는 자신의 과학 프로젝트에 완전히 몰두해 있었다."}
  ]'::jsonb),
  ('toxic', 2, 27, '형용사', '[
    {"en":"The factory was fined for releasing toxic chemicals.","ko":"그 공장은 유독한 화학 물질을 배출해 벌금을 부과받았다."},
    {"en":"Some household cleaners contain toxic substances.","ko":"일부 가정용 세제에는 유독한 물질이 포함되어 있다."},
    {"en":"Workers wore protective gear to avoid the toxic fumes.","ko":"작업자들은 유독한 연기를 피하기 위해 보호 장비를 착용했다."}
  ]'::jsonb),
  ('ray', 2, 27, '명사', '[
    {"en":"A single ray of sunlight came through the window.","ko":"한 줄기 햇살이 창문을 통해 들어왔다."},
    {"en":"Scientists study how ultraviolet rays affect the skin.","ko":"과학자들은 자외선이 피부에 어떤 영향을 미치는지 연구한다."},
    {"en":"The laser produced a thin, focused ray of light.","ko":"그 레이저는 가늘고 집중된 광선을 만들어 냈다."}
  ]'::jsonb),
  ('compound', 2, 27, '명사', '[
    {"en":"Water is a compound made of hydrogen and oxygen.","ko":"물은 수소와 산소로 이루어진 화합물이다."},
    {"en":"The chemist created a new compound in the laboratory.","ko":"그 화학자는 실험실에서 새로운 화합물을 만들었다."},
    {"en":"Salt is a common compound used in everyday cooking.","ko":"소금은 일상 요리에 사용되는 흔한 화합물이다."}
  ]'::jsonb),
  ('detach', 2, 27, '동사', '[
    {"en":"Please detach the form along the dotted line.","ko":"점선을 따라 양식을 떼어내 주세요."},
    {"en":"The mechanic detached the broken part from the machine.","ko":"정비사는 기계에서 고장 난 부품을 분리했다."},
    {"en":"She detached the price tag before wrapping the gift.","ko":"그녀는 선물을 포장하기 전에 가격표를 떼어냈다."}
  ]'::jsonb),
  ('turn A into B', 2, 27, '동사구', '[
    {"en":"The heat turned the ice into water.","ko":"열이 얼음을 물로 바꾸었다."},
    {"en":"The teacher turned a boring lesson into an exciting game.","ko":"선생님은 지루한 수업을 신나는 게임으로 바꾸었다."},
    {"en":"New technology can turn ordinary classrooms into digital ones.","ko":"새로운 기술은 평범한 교실을 디지털 교실로 바꿀 수 있다."}
  ]'::jsonb),
  ('tell from', 2, 27, '동사구', '[
    {"en":"It was hard to tell the twins from each other.","ko":"그 쌍둥이를 서로 구별하기가 어려웠다."},
    {"en":"You can tell a ripe fruit from an unripe one by its color.","ko":"익은 과일과 익지 않은 과일은 색깔로 구별할 수 있다."},
    {"en":"Experts can tell a real diamond from a fake one.","ko":"전문가들은 진짜 다이아몬드와 가짜를 구별할 수 있다."}
  ]'::jsonb),
  ('give off', 2, 27, '동사구', '[
    {"en":"The candle gave off a soft, warm light.","ko":"그 양초는 부드럽고 따뜻한 빛을 냈다."},
    {"en":"Certain flowers give off a strong, pleasant scent.","ko":"어떤 꽃들은 강하고 좋은 향기를 낸다."},
    {"en":"The engine gave off a lot of heat during the test.","ko":"그 엔진은 시험 중 많은 열을 방출했다."}
  ]'::jsonb),
  ('temperature', 2, 28, '명사', '[
    {"en":"The temperature dropped sharply after sunset.","ko":"해가 진 후 기온이 급격히 떨어졌다."},
    {"en":"Please check the temperature before going outside today.","ko":"오늘 밖에 나가기 전에 기온을 확인하세요."},
    {"en":"The scientist recorded the temperature every hour during the experiment.","ko":"과학자는 실험 동안 매시간 온도를 기록했다."}
  ]'::jsonb),
  ('forecast', 2, 28, '명사/동사', '[
    {"en":"The weather forecast predicts rain for the weekend.","ko":"일기 예보는 주말에 비가 올 것으로 예측한다."},
    {"en":"Experts forecast a mild winter this year.","ko":"전문가들은 올해 온화한 겨울을 예상한다."},
    {"en":"According to the forecast, tomorrow will be sunny.","ko":"예보에 따르면 내일은 화창할 것이다."}
  ]'::jsonb),
  ('climate', 2, 28, '명사', '[
    {"en":"The region has a mild climate throughout the year.","ko":"그 지역은 일 년 내내 온화한 기후를 가지고 있다."},
    {"en":"Scientists are studying how climate change affects sea levels.","ko":"과학자들은 기후 변화가 해수면에 어떤 영향을 미치는지 연구하고 있다."},
    {"en":"Plants grow differently depending on the local climate.","ko":"식물은 지역 기후에 따라 다르게 자란다."}
  ]'::jsonb),
  ('rubber', 2, 28, '명사/형용사', '[
    {"en":"The tires are made of durable rubber.","ko":"그 타이어들은 내구성 있는 고무로 만들어졌다."},
    {"en":"She wore rubber boots to walk through the muddy field.","ko":"그녀는 진흙 밭을 걷기 위해 고무 장화를 신었다."},
    {"en":"The factory produces rubber products for cars.","ko":"그 공장은 자동차용 고무 제품을 생산한다."}
  ]'::jsonb),
  ('severe', 2, 28, '형용사', '[
    {"en":"The region suffered from a severe drought last summer.","ko":"그 지역은 지난여름 극심한 가뭄을 겪었다."},
    {"en":"He received a severe warning for breaking the rule.","ko":"그는 규칙을 어겨 엄중한 경고를 받았다."},
    {"en":"The storm caused severe damage to the coastal town.","ko":"그 폭풍은 해안 마을에 심각한 피해를 입혔다."}
  ]'::jsonb),
  ('resource', 2, 28, '명사', '[
    {"en":"Water is a valuable natural resource that must be protected.","ko":"물은 보호되어야 할 귀중한 천연자원이다."},
    {"en":"The library offers many resources for students to study.","ko":"도서관은 학생들이 공부할 수 있는 많은 자료를 제공한다."},
    {"en":"The country''s economy depends heavily on natural resources.","ko":"그 나라의 경제는 천연자원에 크게 의존한다."}
  ]'::jsonb),
  ('spark', 2, 28, '동사/명사', '[
    {"en":"The new policy sparked a lively debate among students.","ko":"그 새로운 정책은 학생들 사이에서 활발한 논쟁을 촉발시켰다."},
    {"en":"A single spark from the wire caused the machine to stop.","ko":"전선에서 나온 작은 불꽃 하나가 기계를 멈추게 했다."},
    {"en":"Her curiosity was sparked by the fascinating documentary.","ko":"그녀의 호기심은 그 흥미로운 다큐멘터리로 촉발되었다."}
  ]'::jsonb),
  ('Arctic', 2, 28, '명사/형용사', '[
    {"en":"Polar bears live in the cold Arctic region.","ko":"북극곰은 추운 북극 지역에 산다."},
    {"en":"Scientists study how ice is melting in the Arctic.","ko":"과학자들은 북극에서 얼음이 어떻게 녹고 있는지 연구한다."},
    {"en":"The documentary showed stunning footage of Arctic wildlife.","ko":"그 다큐멘터리는 북극 야생 동물의 놀라운 영상을 보여주었다."}
  ]'::jsonb),
  ('depth (the -s)', 2, 28, '명사', '[
    {"en":"The submarine explored the depths of the ocean.","ko":"그 잠수함은 심해를 탐사했다."},
    {"en":"Scientists measured the depth of the lake.","ko":"과학자들은 그 호수의 깊이를 측정했다."},
    {"en":"The novel explores the depths of human emotion.","ko":"그 소설은 인간 감정의 깊이를 탐구한다."}
  ]'::jsonb),
  ('shield', 2, 28, '동사/명사', '[
    {"en":"Sunscreen helps shield your skin from harmful rays.","ko":"자외선 차단제는 해로운 광선으로부터 피부를 보호하는 데 도움을 준다."},
    {"en":"The umbrella shielded them from the heavy rain.","ko":"우산은 그들을 폭우로부터 막아 주었다."},
    {"en":"Ancient warriors carried shields for protection in battle.","ko":"고대 전사들은 전투에서 보호를 위해 방패를 들고 다녔다."}
  ]'::jsonb),
  ('wildlife', 2, 28, '명사', '[
    {"en":"The national park protects a wide variety of wildlife.","ko":"그 국립공원은 다양한 야생 생물을 보호한다."},
    {"en":"Pollution threatens the wildlife living near the river.","ko":"오염은 강 근처에 사는 야생 생물을 위협한다."},
    {"en":"Visitors are asked not to disturb the local wildlife.","ko":"방문객들은 지역 야생 생물을 방해하지 말아 달라는 요청을 받는다."}
  ]'::jsonb),
  ('disaster', 2, 28, '명사', '[
    {"en":"The flood was the worst natural disaster in the town''s history.","ko":"그 홍수는 그 마을 역사상 최악의 자연재해였다."},
    {"en":"Communities worked together to recover after the disaster.","ko":"지역 사회는 재난 이후 회복하기 위해 힘을 모았다."},
    {"en":"Emergency teams prepared for possible natural disasters.","ko":"긴급 구조팀은 발생 가능한 자연재해에 대비했다."}
  ]'::jsonb),
  ('occur', 2, 28, '동사', '[
    {"en":"Earthquakes often occur along fault lines.","ko":"지진은 흔히 단층선을 따라 발생한다."},
    {"en":"It never occurred to her that the plan might fail.","ko":"그녀는 그 계획이 실패할 수도 있다는 생각을 전혀 하지 못했다."},
    {"en":"Sudden changes in weather can occur without warning.","ko":"날씨의 갑작스러운 변화는 예고 없이 일어날 수 있다."}
  ]'::jsonb),
  ('Atlantic', 2, 28, '명사/형용사', '[
    {"en":"The ship crossed the Atlantic Ocean in ten days.","ko":"그 배는 열흘 만에 대서양을 건넜다."},
    {"en":"Fishermen along the Atlantic coast depend on the sea for a living.","ko":"대서양 연안의 어부들은 생계를 바다에 의존한다."},
    {"en":"The Atlantic hurricane season begins in early summer.","ko":"대서양 허리케인 시즌은 초여름에 시작된다."}
  ]'::jsonb),
  ('canyon', 2, 28, '명사', '[
    {"en":"The hikers admired the deep canyon carved by the river.","ko":"등산객들은 강이 깎아 만든 깊은 협곡에 감탄했다."},
    {"en":"Wind and water slowly shaped the canyon over centuries.","ko":"바람과 물은 수 세기에 걸쳐 그 협곡을 서서히 만들었다."},
    {"en":"Tourists take photos of the enormous canyon at sunset.","ko":"관광객들은 일몰 때 그 거대한 협곡의 사진을 찍는다."}
  ]'::jsonb),
  ('swamp', 2, 28, '명사/동사', '[
    {"en":"The swamp is home to many unique species of plants.","ko":"그 늪은 많은 독특한 식물 종의 서식지이다."},
    {"en":"Heavy rain swamped the low-lying fields near the river.","ko":"폭우는 강 근처의 저지대 밭을 물에 잠기게 했다."},
    {"en":"Explorers carefully navigated through the thick swamp.","ko":"탐험가들은 울창한 늪을 조심스럽게 헤쳐 나갔다."}
  ]'::jsonb),
  ('moisture', 2, 28, '명사', '[
    {"en":"The plants need enough moisture to grow properly.","ko":"그 식물들은 제대로 자라기 위해 충분한 수분이 필요하다."},
    {"en":"High moisture in the air made the room feel humid.","ko":"공기 중의 높은 습기는 방을 눅눅하게 느껴지게 했다."},
    {"en":"The lotion helps keep the skin''s moisture locked in.","ko":"그 로션은 피부의 수분을 유지하는 데 도움을 준다."}
  ]'::jsonb),
  ('reflect', 2, 28, '동사', '[
    {"en":"The calm lake reflected the mountains perfectly.","ko":"잔잔한 호수는 산을 완벽하게 비추었다."},
    {"en":"Her essay reflects her strong interest in science.","ko":"그녀의 에세이는 과학에 대한 강한 관심을 반영한다."},
    {"en":"He took a moment to reflect on his choices.","ko":"그는 자신의 선택에 대해 잠시 곰곰이 생각해 보았다."}
  ]'::jsonb),
  ('Celsius', 2, 28, '명사', '[
    {"en":"The temperature today is twenty degrees Celsius.","ko":"오늘 기온은 섭씨 20도이다."},
    {"en":"Water freezes at zero degrees Celsius.","ko":"물은 섭씨 0도에서 언다."},
    {"en":"Most countries use the Celsius scale to measure temperature.","ko":"대부분의 나라는 온도를 측정하는 데 섭씨 척도를 사용한다."}
  ]'::jsonb),
  ('thermometer', 2, 28, '명사', '[
    {"en":"The nurse used a thermometer to check his temperature.","ko":"간호사는 그의 체온을 재기 위해 온도계를 사용했다."},
    {"en":"The thermometer showed that it was unusually cold outside.","ko":"온도계는 밖이 유난히 춥다는 것을 보여주었다."},
    {"en":"She placed the thermometer in the water to measure its heat.","ko":"그녀는 물의 온도를 재기 위해 온도계를 물속에 넣었다."}
  ]'::jsonb),
  ('destructive', 2, 28, '형용사', '[
    {"en":"The storm was one of the most destructive in years.","ko":"그 폭풍은 수년 만에 가장 파괴적인 것 중 하나였다."},
    {"en":"Careless habits can be destructive to the environment.","ko":"부주의한 습관은 환경에 해로울 수 있다."},
    {"en":"The report described the destructive effects of pollution.","ko":"그 보고서는 오염의 파괴적인 영향을 설명했다."}
  ]'::jsonb),
  ('wreck', 2, 28, '명사/동사', '[
    {"en":"Divers discovered an old shipwreck near the coast.","ko":"잠수부들은 해안 근처에서 오래된 난파선을 발견했다."},
    {"en":"The storm wrecked several small boats in the harbor.","ko":"그 폭풍은 항구에 있던 여러 소형 선박을 파괴했다."},
    {"en":"The old car looked like a complete wreck.","ko":"그 오래된 차는 완전히 망가진 것처럼 보였다."}
  ]'::jsonb),
  ('peak', 2, 28, '명사/형용사', '[
    {"en":"The climbers finally reached the mountain''s peak.","ko":"등반가들은 마침내 그 산의 정상에 도달했다."},
    {"en":"Tourist season reaches its peak during the summer.","ko":"관광 시즌은 여름에 절정에 이른다."},
    {"en":"The stadium was at peak capacity for the final match.","ko":"그 경기장은 결승전 동안 최대 수용 인원에 도달했다."}
  ]'::jsonb),
  ('erupt', 2, 28, '동사', '[
    {"en":"The volcano erupted after years of being dormant.","ko":"그 화산은 수년간 휴면 상태였다가 분출했다."},
    {"en":"The crowd erupted in cheers when the team scored.","ko":"그 팀이 득점하자 관중들은 환호성을 터뜨렸다."},
    {"en":"Scientists monitor the mountain closely in case it erupts again.","ko":"과학자들은 그 산이 다시 분출할 경우를 대비해 면밀히 관찰한다."}
  ]'::jsonb),
  ('eject', 2, 28, '동사', '[
    {"en":"The machine ejected the tray automatically once finished.","ko":"그 기계는 작업이 끝나자 자동으로 트레이를 배출했다."},
    {"en":"Hot gases are ejected from the rocket during launch.","ko":"발사 중 로켓에서 뜨거운 가스가 배출된다."},
    {"en":"The pilot was trained to eject safely in an emergency.","ko":"조종사는 비상시 안전하게 탈출하도록 훈련받았다."}
  ]'::jsonb),
  ('purify', 2, 28, '동사', '[
    {"en":"The new system helps purify the city''s drinking water.","ko":"새로운 시스템은 도시의 식수를 정화하는 데 도움을 준다."},
    {"en":"Plants naturally purify the air around them.","ko":"식물은 자연스럽게 주변 공기를 정화한다."},
    {"en":"The factory installed filters to purify its wastewater.","ko":"그 공장은 폐수를 정화하기 위해 필터를 설치했다."}
  ]'::jsonb),
  ('surround', 2, 28, '동사', '[
    {"en":"Tall mountains surround the small village.","ko":"높은 산들이 그 작은 마을을 둘러싸고 있다."},
    {"en":"A high fence surrounds the school playground.","ko":"높은 울타리가 학교 운동장을 둘러싸고 있다."},
    {"en":"Thick forests surround the quiet lake.","ko":"울창한 숲이 그 고요한 호수를 둘러싸고 있다."}
  ]'::jsonb),
  ('wash away', 2, 28, '동사구', '[
    {"en":"The heavy rain washed away part of the road.","ko":"폭우로 도로 일부가 유실되었다."},
    {"en":"Strong waves washed away the sandcastle within minutes.","ko":"강한 파도가 몇 분 만에 모래성을 쓸어가 버렸다."},
    {"en":"Floodwaters washed away several bridges in the valley.","ko":"홍수는 계곡의 여러 다리를 유실시켰다."}
  ]'::jsonb),
  ('wipe out', 2, 28, '동사구', '[
    {"en":"The disease nearly wiped out the entire crop.","ko":"그 병은 작물 전체를 거의 전멸시킬 뻔했다."},
    {"en":"A sudden flood wiped out the small coastal village.","ko":"갑작스러운 홍수가 그 작은 해안 마을을 완전히 파괴했다."},
    {"en":"Years of hard work were wiped out by a single mistake.","ko":"수년간의 노력이 단 한 번의 실수로 물거품이 되었다."}
  ]'::jsonb),
  ('use up', 2, 28, '동사구', '[
    {"en":"The long trip used up most of their fuel.","ko":"그 긴 여행은 그들의 연료 대부분을 소모했다."},
    {"en":"She used up all her savings buying new equipment.","ko":"그녀는 새 장비를 사는 데 저축한 돈을 다 써 버렸다."},
    {"en":"The printer used up its ink much faster than expected.","ko":"그 프린터는 예상보다 훨씬 빨리 잉크를 다 써 버렸다."}
  ]'::jsonb),
  ('astronaut', 2, 29, '명사', '[
    {"en":"The astronaut spent six months aboard the space station.","ko":"그 우주 비행사는 우주 정거장에서 6개월을 보냈다."},
    {"en":"She dreamed of becoming an astronaut since childhood.","ko":"그녀는 어릴 때부터 우주 비행사가 되기를 꿈꿔 왔다."},
    {"en":"Astronauts must complete years of rigorous training.","ko":"우주 비행사들은 수년간의 혹독한 훈련을 마쳐야 한다."}
  ]'::jsonb),
  ('solar', 2, 29, '형용사', '[
    {"en":"The house is powered entirely by solar energy.","ko":"그 집은 전적으로 태양 에너지로 전력을 공급받는다."},
    {"en":"Scientists study the sun as part of solar research.","ko":"과학자들은 태양 연구의 일환으로 태양을 연구한다."},
    {"en":"The school installed solar panels on its roof.","ko":"그 학교는 지붕에 태양광 패널을 설치했다."}
  ]'::jsonb),
  ('remote', 2, 29, '형용사', '[
    {"en":"The village is located in a remote mountain area.","ko":"그 마을은 외진 산악 지역에 위치해 있다."},
    {"en":"Scientists studied wildlife in a remote part of the forest.","ko":"과학자들은 숲의 외딴 지역에서 야생 생물을 연구했다."},
    {"en":"It seemed remote that the plan would ever succeed.","ko":"그 계획이 성공할 가능성은 희박해 보였다."}
  ]'::jsonb),
  ('benefit', 2, 29, '명사', '[
    {"en":"Regular exercise has many benefits for your health.","ko":"규칙적인 운동은 건강에 많은 이점이 있다."},
    {"en":"The new policy will bring benefits to local farmers.","ko":"그 새 정책은 지역 농부들에게 이익을 가져다줄 것이다."},
    {"en":"Reading widely offers great benefits for young students.","ko":"폭넓게 독서하는 것은 어린 학생들에게 큰 이점을 준다."}
  ]'::jsonb),
  ('efficiency', 2, 29, '명사', '[
    {"en":"The new engine improves fuel efficiency significantly.","ko":"새 엔진은 연료 효율을 크게 향상시킨다."},
    {"en":"The factory increased its efficiency by updating old equipment.","ko":"그 공장은 낡은 장비를 교체하여 효율을 높였다."},
    {"en":"Better time management can improve a student''s efficiency.","ko":"더 나은 시간 관리는 학생의 능률을 향상시킬 수 있다."}
  ]'::jsonb),
  ('enable', 2, 29, '동사', '[
    {"en":"The scholarship enabled her to study abroad.","ko":"그 장학금은 그녀가 해외에서 공부할 수 있게 해 주었다."},
    {"en":"New technology enables students to learn remotely.","ko":"새로운 기술은 학생들이 원격으로 배울 수 있게 해 준다."},
    {"en":"Practice enables athletes to perform at their best.","ko":"연습은 선수들이 최고의 기량을 발휘할 수 있게 해 준다."}
  ]'::jsonb),
  ('discover', 2, 29, '동사', '[
    {"en":"Scientists discovered a new species of fish in the deep sea.","ko":"과학자들은 심해에서 새로운 어종을 발견했다."},
    {"en":"She discovered an old letter hidden in the attic.","ko":"그녀는 다락방에 숨겨져 있던 오래된 편지를 발견했다."},
    {"en":"Researchers hope to discover a cure for the disease.","ko":"연구자들은 그 병의 치료법을 발견하기를 희망한다."}
  ]'::jsonb),
  ('observe', 2, 29, '동사', '[
    {"en":"Students observed the stars through a telescope.","ko":"학생들은 망원경으로 별을 관찰했다."},
    {"en":"Drivers must observe traffic laws at all times.","ko":"운전자들은 항상 교통 법규를 준수해야 한다."},
    {"en":"The scientist observed the reaction closely and took notes.","ko":"과학자는 반응을 자세히 관찰하고 기록했다."}
  ]'::jsonb),
  ('digital', 2, 29, '형용사', '[
    {"en":"Most students now submit their homework in digital form.","ko":"오늘날 대부분의 학생들은 디지털 형식으로 숙제를 제출한다."},
    {"en":"The library replaced its old catalog with a digital system.","ko":"도서관은 낡은 목록을 디지털 시스템으로 교체했다."},
    {"en":"Digital cameras have largely replaced film cameras.","ko":"디지털 카메라는 필름 카메라를 상당 부분 대체했다."}
  ]'::jsonb),
  ('shuttle', 2, 29, '명사/동사', '[
    {"en":"The space shuttle launched successfully into orbit.","ko":"그 우주 왕복선은 성공적으로 궤도에 발사되었다."},
    {"en":"A free shuttle bus runs between the airport and the hotel.","ko":"공항과 호텔 사이를 무료 셔틀버스가 운행한다."},
    {"en":"Workers shuttle back and forth between the two buildings.","ko":"직원들은 두 건물 사이를 오간다."}
  ]'::jsonb),
  ('astronomer', 2, 29, '명사', '[
    {"en":"The astronomer discovered a new comet last year.","ko":"그 천문학자는 작년에 새로운 혜성을 발견했다."},
    {"en":"Astronomers use powerful telescopes to study distant galaxies.","ko":"천문학자들은 먼 은하를 연구하기 위해 성능 좋은 망원경을 사용한다."},
    {"en":"She became an astronomer after years of studying physics.","ko":"그녀는 수년간 물리학을 공부한 후 천문학자가 되었다."}
  ]'::jsonb),
  ('orbit', 2, 29, '명사', '[
    {"en":"The satellite remains in orbit around the Earth.","ko":"그 위성은 지구 궤도를 계속 돌고 있다."},
    {"en":"The spacecraft entered the moon''s orbit successfully.","ko":"그 우주선은 성공적으로 달의 궤도에 진입했다."},
    {"en":"Scientists calculated the planet''s orbit around the sun.","ko":"과학자들은 태양 주위를 도는 그 행성의 궤도를 계산했다."}
  ]'::jsonb),
  ('galaxy', 2, 29, '명사', '[
    {"en":"Our solar system is part of the Milky Way galaxy.","ko":"우리 태양계는 은하수 은하의 일부이다."},
    {"en":"Telescopes allow scientists to observe distant galaxies.","ko":"망원경은 과학자들이 먼 은하를 관찰할 수 있게 해 준다."},
    {"en":"The universe contains billions of galaxies.","ko":"우주에는 수십억 개의 은하가 있다."}
  ]'::jsonb),
  ('rotate', 2, 29, '동사', '[
    {"en":"The Earth rotates once every twenty-four hours.","ko":"지구는 24시간마다 한 번씩 자전한다."},
    {"en":"Employees rotate shifts to keep the store open all day.","ko":"직원들은 상점을 하루 종일 열어 두기 위해 교대 근무를 한다."},
    {"en":"The wheel rotates smoothly on its axis.","ko":"그 바퀴는 축을 중심으로 부드럽게 회전한다."}
  ]'::jsonb),
  ('satellite', 2, 29, '명사', '[
    {"en":"The satellite transmits weather data back to Earth.","ko":"그 위성은 기상 자료를 지구로 전송한다."},
    {"en":"Communication satellites orbit the Earth continuously.","ko":"통신 위성들은 지구를 계속해서 돈다."},
    {"en":"Scientists launched a new satellite to study climate change.","ko":"과학자들은 기후 변화를 연구하기 위해 새로운 위성을 발사했다."}
  ]'::jsonb),
  ('launch', 2, 29, '동사', '[
    {"en":"The rocket was launched successfully into space.","ko":"그 로켓은 성공적으로 우주로 발사되었다."},
    {"en":"The company plans to launch a new product next month.","ko":"그 회사는 다음 달에 신제품을 출시할 계획이다."},
    {"en":"Engineers carefully prepared to launch the satellite.","ko":"엔지니어들은 위성 발사를 신중하게 준비했다."}
  ]'::jsonb),
  ('lunar', 2, 29, '형용사', '[
    {"en":"The lunar surface is covered with craters.","ko":"달 표면은 분화구로 덮여 있다."},
    {"en":"Scientists study lunar rocks brought back from missions.","ko":"과학자들은 임무를 통해 가져온 달의 암석을 연구한다."},
    {"en":"The festival follows the lunar calendar.","ko":"그 축제는 음력을 따른다."}
  ]'::jsonb),
  ('electronic', 2, 29, '형용사', '[
    {"en":"Most students carry electronic devices to school.","ko":"대부분의 학생들은 전자 기기를 학교에 가지고 온다."},
    {"en":"The library now offers many electronic books.","ko":"도서관은 이제 많은 전자책을 제공한다."},
    {"en":"The factory produces small electronic components.","ko":"그 공장은 작은 전자 부품을 생산한다."}
  ]'::jsonb),
  ('eclipse', 2, 29, '명사/동사', '[
    {"en":"Thousands gathered to watch the solar eclipse.","ko":"수천 명의 사람들이 일식을 보기 위해 모였다."},
    {"en":"The eclipse lasted only a few minutes.","ko":"그 일식은 단 몇 분 동안만 지속되었다."},
    {"en":"Her achievement was eclipsed by an even greater discovery.","ko":"그녀의 업적은 훨씬 더 위대한 발견에 가려졌다."}
  ]'::jsonb),
  ('gravity', 2, 29, '명사', '[
    {"en":"Gravity keeps the planets in orbit around the sun.","ko":"중력은 행성들이 태양 주위 궤도를 돌게 유지시킨다."},
    {"en":"Astronauts experience very little gravity in space.","ko":"우주 비행사들은 우주에서 중력을 거의 느끼지 못한다."},
    {"en":"The apple fell to the ground because of gravity.","ko":"그 사과는 중력 때문에 땅으로 떨어졌다."}
  ]'::jsonb),
  ('automatic', 2, 29, '형용사', '[
    {"en":"The door opens automatically when someone approaches.","ko":"누군가 다가오면 그 문은 자동으로 열린다."},
    {"en":"She bought a car with an automatic transmission.","ko":"그녀는 자동 변속기가 있는 차를 샀다."},
    {"en":"The automatic system adjusts the room temperature by itself.","ko":"그 자동 시스템은 스스로 실내 온도를 조절한다."}
  ]'::jsonb),
  ('device', 2, 29, '명사', '[
    {"en":"The new device measures heart rate accurately.","ko":"그 새로운 기기는 심박수를 정확하게 측정한다."},
    {"en":"Students used a digital device to record their data.","ko":"학생들은 데이터를 기록하기 위해 디지털 기기를 사용했다."},
    {"en":"The safety device shuts off the machine automatically.","ko":"그 안전 장치는 기계를 자동으로 정지시킨다."}
  ]'::jsonb),
  ('manual', 2, 29, '형용사/명사', '[
    {"en":"The old machine required manual operation.","ko":"그 낡은 기계는 수동 조작이 필요했다."},
    {"en":"Please read the manual before using the equipment.","ko":"장비를 사용하기 전에 안내서를 읽어 주세요."},
    {"en":"He preferred manual labor over office work.","ko":"그는 사무직보다 육체노동을 선호했다."}
  ]'::jsonb),
  ('accurate', 2, 29, '형용사', '[
    {"en":"The weather forecast turned out to be accurate.","ko":"그 일기 예보는 정확한 것으로 드러났다."},
    {"en":"Scientists rely on accurate measurements for their experiments.","ko":"과학자들은 실험을 위해 정확한 측정에 의존한다."},
    {"en":"Please provide accurate information on the application form.","ko":"신청서에 정확한 정보를 기재해 주세요."}
  ]'::jsonb),
  ('analyze', 2, 29, '동사', '[
    {"en":"Researchers analyzed the data collected over five years.","ko":"연구자들은 5년에 걸쳐 수집된 데이터를 분석했다."},
    {"en":"Students learned to analyze poems for hidden meaning.","ko":"학생들은 숨겨진 의미를 찾기 위해 시를 분석하는 법을 배웠다."},
    {"en":"The team analyzed the results before writing a report.","ko":"그 팀은 보고서를 작성하기 전에 결과를 분석했다."}
  ]'::jsonb),
  ('adjust', 2, 29, '동사', '[
    {"en":"Please adjust the temperature before the meeting starts.","ko":"회의가 시작되기 전에 온도를 조절해 주세요."},
    {"en":"It took her a while to adjust to the new school.","ko":"그녀가 새 학교에 적응하는 데는 시간이 좀 걸렸다."},
    {"en":"The scientist adjusted the equipment for greater accuracy.","ko":"과학자는 더 높은 정확도를 위해 장비를 조정했다."}
  ]'::jsonb),
  ('accelerate', 2, 29, '동사', '[
    {"en":"The car accelerated quickly as it merged onto the highway.","ko":"그 차는 고속도로에 합류하면서 빠르게 가속했다."},
    {"en":"New technology has accelerated progress in medicine.","ko":"새로운 기술은 의학의 발전을 가속화했다."},
    {"en":"The runner accelerated during the final lap of the race.","ko":"그 주자는 경주의 마지막 바퀴에서 속도를 높였다."}
  ]'::jsonb),
  ('bring about', 2, 29, '동사구', '[
    {"en":"The invention brought about major changes in daily life.","ko":"그 발명은 일상생활에 커다란 변화를 가져왔다."},
    {"en":"Careful planning can bring about great improvements in efficiency.","ko":"신중한 계획은 효율성에 큰 개선을 가져올 수 있다."},
    {"en":"The new law brought about positive changes in the community.","ko":"그 새 법은 지역 사회에 긍정적인 변화를 가져왔다."}
  ]'::jsonb),
  ('sort out', 2, 29, '동사구', '[
    {"en":"She sorted out the documents by date.","ko":"그녀는 서류를 날짜별로 분류했다."},
    {"en":"It took hours to sort out the tangled wires.","ko":"엉킨 전선을 정리하는 데 몇 시간이 걸렸다."},
    {"en":"The teacher helped students sort out their confusing notes.","ko":"선생님은 학생들이 헷갈리는 필기를 정리하도록 도와주었다."}
  ]'::jsonb),
  ('substitute for', 2, 29, '동사구', '[
    {"en":"Honey can substitute for sugar in most recipes.","ko":"꿀은 대부분의 조리법에서 설탕을 대신할 수 있다."},
    {"en":"No machine can fully substitute for human creativity.","ko":"어떤 기계도 인간의 창의성을 완전히 대신할 수는 없다."},
    {"en":"The assistant coach substituted for the head coach during the game.","ko":"부코치가 경기 동안 수석 코치를 대신했다."}
  ]'::jsonb),
  ('online', 2, 30, '형용사/부사', '[
    {"en":"Many students now take online classes.","ko":"많은 학생들이 이제 온라인 수업을 듣는다."},
    {"en":"She ordered the textbook online last night.","ko":"그녀는 어젯밤 교과서를 온라인으로 주문했다."},
    {"en":"The library offers an online catalog for easy searching.","ko":"도서관은 쉬운 검색을 위한 온라인 목록을 제공한다."}
  ]'::jsonb),
  ('database', 2, 30, '명사', '[
    {"en":"The company stores customer information in a large database.","ko":"그 회사는 고객 정보를 대형 데이터베이스에 저장한다."},
    {"en":"Researchers created a database of historical documents.","ko":"연구자들은 역사 문서 데이터베이스를 만들었다."},
    {"en":"The library''s database allows students to search for articles.","ko":"도서관의 데이터베이스는 학생들이 논문을 검색할 수 있게 해 준다."}
  ]'::jsonb),
  ('capture', 2, 30, '동사', '[
    {"en":"The photographer captured a stunning image of the sunset.","ko":"그 사진작가는 멋진 노을 사진을 포착했다."},
    {"en":"The camera captured every detail of the event.","ko":"그 카메라는 행사의 모든 세부 사항을 포착했다."},
    {"en":"Her essay captures the excitement of the festival perfectly.","ko":"그녀의 에세이는 그 축제의 흥분을 완벽하게 담아낸다."}
  ]'::jsonb),
  ('tool', 2, 30, '명사', '[
    {"en":"This app is a useful tool for learning vocabulary.","ko":"이 앱은 어휘를 배우는 데 유용한 도구이다."},
    {"en":"He kept his tools organized in the garage.","ko":"그는 차고에 도구들을 정리해 두었다."},
    {"en":"Teachers use various tools to make lessons more engaging.","ko":"교사들은 수업을 더 흥미롭게 만들기 위해 다양한 도구를 사용한다."}
  ]'::jsonb),
  ('junk', 2, 30, '명사', '[
    {"en":"The garage was filled with old junk from years ago.","ko":"차고는 오래전의 낡은 잡동사니로 가득 차 있었다."},
    {"en":"She cleaned out the junk from her desk drawer.","ko":"그녀는 책상 서랍의 잡동사니를 치웠다."},
    {"en":"Most of the items in the sale were just junk.","ko":"그 판매 물건들 대부분은 그냥 폐물이었다."}
  ]'::jsonb),
  ('delete', 2, 30, '동사', '[
    {"en":"He accidentally deleted an important file from his computer.","ko":"그는 실수로 컴퓨터에서 중요한 파일을 삭제했다."},
    {"en":"Please delete any outdated information from the report.","ko":"보고서에서 오래된 정보를 삭제해 주세요."},
    {"en":"She deleted the old photos to make more storage space.","ko":"그녀는 저장 공간을 늘리기 위해 오래된 사진을 삭제했다."}
  ]'::jsonb),
  ('communicate', 2, 30, '동사', '[
    {"en":"Good leaders communicate clearly with their team members.","ko":"훌륭한 리더는 팀원들과 명확하게 소통한다."},
    {"en":"The two scientists communicated regularly by email.","ko":"두 과학자는 이메일로 정기적으로 연락을 주고받았다."},
    {"en":"Students learn to communicate effectively in group projects.","ko":"학생들은 조별 과제에서 효과적으로 소통하는 법을 배운다."}
  ]'::jsonb),
  ('browse', 2, 30, '동사', '[
    {"en":"She likes to browse the library shelves for new books.","ko":"그녀는 새 책을 찾기 위해 도서관 서가를 둘러보는 것을 좋아한다."},
    {"en":"He spent an hour browsing websites for research material.","ko":"그는 연구 자료를 찾기 위해 한 시간 동안 웹사이트를 검색했다."},
    {"en":"Customers are welcome to browse the store before buying anything.","ko":"고객들은 무엇을 사기 전에 매장을 둘러볼 수 있다."}
  ]'::jsonb),
  ('link', 2, 30, '명사/동사', '[
    {"en":"She sent a link to the article in her email.","ko":"그녀는 이메일로 그 기사 링크를 보냈다."},
    {"en":"Researchers found a link between exercise and better focus.","ko":"연구자들은 운동과 더 나은 집중력 사이의 연관성을 발견했다."},
    {"en":"The two topics are closely linked in the textbook.","ko":"그 두 주제는 교과서에서 밀접하게 연결되어 있다."}
  ]'::jsonb),
  ('oral', 2, 30, '형용사', '[
    {"en":"Students must pass both a written and an oral exam.","ko":"학생들은 필기시험과 구술시험을 모두 통과해야 한다."},
    {"en":"The teacher gave an oral presentation about ancient history.","ko":"선생님은 고대 역사에 관해 구두 발표를 했다."},
    {"en":"Oral traditions have preserved many old folk stories.","ko":"구전 전통은 많은 옛 민담을 보존해 왔다."}
  ]'::jsonb),
  ('edit', 2, 30, '동사', '[
    {"en":"She edited the essay carefully before submitting it.","ko":"그녀는 에세이를 제출하기 전에 꼼꼼하게 편집했다."},
    {"en":"The teacher asked students to edit their partner''s writing.","ko":"선생님은 학생들에게 짝의 글을 교정해 보라고 했다."},
    {"en":"He spent the afternoon editing the video for class.","ko":"그는 오후 시간을 수업용 영상을 편집하는 데 보냈다."}
  ]'::jsonb),
  ('warn', 2, 30, '동사', '[
    {"en":"The sign warns visitors about the slippery floor.","ko":"그 표지판은 방문객들에게 미끄러운 바닥에 대해 경고한다."},
    {"en":"Scientists warned about the dangers of rising temperatures.","ko":"과학자들은 기온 상승의 위험성에 대해 경고했다."},
    {"en":"She warned her brother not to touch the hot pan.","ko":"그녀는 남동생에게 뜨거운 팬을 만지지 말라고 주의를 주었다."}
  ]'::jsonb),
  ('dot', 2, 30, '명사', '[
    {"en":"The website address includes a dot before \"com.\"","ko":"그 웹사이트 주소는 \"com\" 앞에 점을 포함한다."},
    {"en":"He drew a small dot at the center of the page.","ko":"그는 페이지 중앙에 작은 점을 그렸다."},
    {"en":"The map used a red dot to mark the location.","ko":"그 지도는 위치를 표시하기 위해 빨간 점을 사용했다."}
  ]'::jsonb),
  ('visual', 2, 30, '형용사', '[
    {"en":"The presentation included several helpful visual aids.","ko":"그 발표는 도움이 되는 몇 가지 시각 자료를 포함했다."},
    {"en":"Visual learners often benefit from charts and diagrams.","ko":"시각적으로 학습하는 사람들은 도표와 그림에서 도움을 받는 경우가 많다."},
    {"en":"The teacher used visual examples to explain the concept.","ko":"선생님은 개념을 설명하기 위해 시각적 예시를 사용했다."}
  ]'::jsonb),
  ('profile', 2, 30, '명사', '[
    {"en":"She updated her profile with a new photo.","ko":"그녀는 새 사진으로 프로필을 업데이트했다."},
    {"en":"The magazine published a profile of the young scientist.","ko":"그 잡지는 그 젊은 과학자의 인물 소개를 실었다."},
    {"en":"Students created an online profile for the class project.","ko":"학생들은 수업 프로젝트를 위해 온라인 프로필을 만들었다."}
  ]'::jsonb),
  ('access', 2, 30, '명사/동사', '[
    {"en":"Students can access the library database from home.","ko":"학생들은 집에서 도서관 데이터베이스에 접근할 수 있다."},
    {"en":"The new policy gives everyone equal access to education.","ko":"그 새 정책은 모두에게 교육에 대한 평등한 접근을 제공한다."},
    {"en":"She accessed the files using her school account.","ko":"그녀는 학교 계정을 이용해 파일에 접근했다."}
  ]'::jsonb),
  ('circulate', 2, 30, '동사', '[
    {"en":"The teacher circulated the handout among the students.","ko":"선생님은 학생들에게 유인물을 돌렸다."},
    {"en":"News of the event circulated quickly around the school.","ko":"그 행사 소식은 학교 안에 빠르게 퍼졌다."},
    {"en":"Fresh air circulates through the building''s ventilation system.","ko":"신선한 공기가 그 건물의 환기 시스템을 통해 순환한다."}
  ]'::jsonb),
  ('activate', 2, 30, '동사', '[
    {"en":"Press the button to activate the device.","ko":"기기를 작동시키려면 버튼을 누르세요."},
    {"en":"The alarm system activates automatically at night.","ko":"그 경보 시스템은 밤에 자동으로 활성화된다."},
    {"en":"Sunlight activates the solar panels on the roof.","ko":"햇빛은 지붕의 태양광 패널을 작동시킨다."}
  ]'::jsonb),
  ('surf', 2, 30, '동사', '[
    {"en":"He likes to surf the internet for interesting articles.","ko":"그는 흥미로운 기사를 찾아 인터넷을 검색하는 것을 좋아한다."},
    {"en":"She spent the afternoon surfing waves at the beach.","ko":"그녀는 해변에서 오후 내내 파도타기를 했다."},
    {"en":"Students should be careful when surfing unfamiliar websites.","ko":"학생들은 낯선 웹사이트를 탐색할 때 주의해야 한다."}
  ]'::jsonb),
  ('request', 2, 30, '명사/동사', '[
    {"en":"She made a request for extra study materials.","ko":"그녀는 추가 학습 자료를 요청했다."},
    {"en":"The teacher requested that students submit their essays online.","ko":"선생님은 학생들에게 에세이를 온라인으로 제출하라고 요청했다."},
    {"en":"His request for help was answered right away.","ko":"그의 도움 요청은 즉시 응답을 받았다."}
  ]'::jsonb),
  ('interrupt', 2, 30, '동사', '[
    {"en":"Please do not interrupt while someone else is speaking.","ko":"다른 사람이 말하고 있을 때 끼어들지 마세요."},
    {"en":"The meeting was interrupted by a sudden power outage.","ko":"그 회의는 갑작스러운 정전으로 중단되었다."},
    {"en":"She apologized for interrupting the teacher''s explanation.","ko":"그녀는 선생님의 설명을 방해한 것에 대해 사과했다."}
  ]'::jsonb),
  ('pause', 2, 30, '명사/동사', '[
    {"en":"He paused for a moment before answering the question.","ko":"그는 질문에 답하기 전에 잠시 멈췄다."},
    {"en":"There was a brief pause before the music started again.","ko":"음악이 다시 시작되기 전에 짧은 멈춤이 있었다."},
    {"en":"She paused the video to take notes.","ko":"그녀는 필기를 하기 위해 영상을 일시 정지했다."}
  ]'::jsonb),
  ('response', 2, 30, '명사', '[
    {"en":"The survey received hundreds of responses from students.","ko":"그 설문 조사는 학생들로부터 수백 건의 응답을 받았다."},
    {"en":"Her quick response impressed the interviewer.","ko":"그녀의 빠른 반응은 면접관에게 좋은 인상을 주었다."},
    {"en":"The company issued an official response to the complaint.","ko":"그 회사는 그 항의에 대해 공식적인 답변을 내놓았다."}
  ]'::jsonb),
  ('debate', 2, 30, '명사/동사', '[
    {"en":"The class held a debate about environmental policies.","ko":"그 학급은 환경 정책에 관한 토론을 열었다."},
    {"en":"Students debated the pros and cons of online learning.","ko":"학생들은 온라인 학습의 장단점에 대해 토론했다."},
    {"en":"The debate lasted almost an hour.","ko":"그 토론은 거의 한 시간 동안 계속되었다."}
  ]'::jsonb),
  ('illogical', 2, 30, '형용사', '[
    {"en":"His argument seemed illogical to most of the audience.","ko":"그의 주장은 대부분의 청중에게 비논리적으로 보였다."},
    {"en":"It would be illogical to ignore the clear evidence.","ko":"명백한 증거를 무시하는 것은 불합리할 것이다."},
    {"en":"The teacher pointed out the illogical steps in her reasoning.","ko":"선생님은 그녀의 추론에서 비논리적인 단계를 지적했다."}
  ]'::jsonb),
  ('hesitate', 2, 30, '동사', '[
    {"en":"She hesitated before answering the difficult question.","ko":"그녀는 그 어려운 질문에 답하기 전에 망설였다."},
    {"en":"Do not hesitate to ask if you need any help.","ko":"도움이 필요하면 주저하지 말고 물어보세요."},
    {"en":"He hesitated for a moment before signing the form.","ko":"그는 양식에 서명하기 전에 잠시 망설였다."}
  ]'::jsonb),
  ('suppose', 2, 30, '동사', '[
    {"en":"Suppose you had unlimited time to study any subject.","ko":"어떤 과목이든 공부할 시간이 무한하다고 가정해 보라."},
    {"en":"I suppose the meeting will start on time.","ko":"나는 회의가 제시간에 시작될 것이라고 생각한다."},
    {"en":"Scientists supposed that the theory would eventually be proven.","ko":"과학자들은 그 이론이 결국 증명될 것이라고 생각했다."}
  ]'::jsonb),
  ('combine', 2, 30, '동사', '[
    {"en":"The recipe combines several simple ingredients.","ko":"그 조리법은 몇 가지 간단한 재료를 결합한다."},
    {"en":"The two schools combined their resources for the event.","ko":"두 학교는 그 행사를 위해 자원을 합쳤다."},
    {"en":"She combined creativity with logic to solve the problem.","ko":"그녀는 창의성과 논리를 결합해 그 문제를 해결했다."}
  ]'::jsonb),
  ('keep in touch with', 2, 30, '동사구', '[
    {"en":"They promised to keep in touch with each other after graduation.","ko":"그들은 졸업 후에도 서로 연락을 유지하기로 약속했다."},
    {"en":"It is important to keep in touch with old friends.","ko":"옛 친구들과 계속 연락하는 것은 중요하다."},
    {"en":"She keeps in touch with her mentor through regular emails.","ko":"그녀는 정기적인 이메일을 통해 멘토와 연락을 유지한다."}
  ]'::jsonb),
  ('cut in', 2, 30, '동사구', '[
    {"en":"He cut in before she could finish her sentence.","ko":"그녀가 문장을 끝내기도 전에 그가 끼어들었다."},
    {"en":"It is rude to cut in while someone is speaking.","ko":"누군가 말하고 있을 때 끼어드는 것은 무례하다."},
    {"en":"The driver cut in suddenly without signaling.","ko":"그 운전자는 신호도 없이 갑자기 끼어들었다."}
  ]'::jsonb)
) as t(word, level, study_day, pos, examples)
where v.word = t.word and v.level = t.level and v.study_day = t.study_day;
