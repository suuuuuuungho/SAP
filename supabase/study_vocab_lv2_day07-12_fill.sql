-- SAP 1기 대시보드: Study 탭 — Lv.2(중등 고난도) Day 07~12 품사/예문 채우기 (180단어).
update public.vocab_words v
set part_of_speech = t.pos, example_sentences = t.examples, updated_at = now()
from (values
  ('insight', 2, 7, '명사', '[
    {"en":"The book offers valuable insight into human behavior.","ko":"그 책은 인간 행동에 대한 귀중한 통찰력을 제공한다."},
    {"en":"Her comment gave us new insight into the problem.","ko":"그녀의 의견은 우리에게 그 문제에 대한 새로운 통찰력을 주었다."},
    {"en":"Scientists gained insight into the disease through years of research.","ko":"과학자들은 수년간의 연구를 통해 그 질병에 대한 통찰력을 얻었다."}
  ]'::jsonb),
  ('academic', 2, 7, '형용사', '[
    {"en":"She has an impressive academic record.","ko":"그녀는 인상적인 학업 기록을 가지고 있다."},
    {"en":"The school focuses on academic achievement.","ko":"그 학교는 학업 성취를 중시한다."},
    {"en":"He struggled with academic pressure in high school.","ko":"그는 고등학교에서 학업 압박으로 힘들어했다."}
  ]'::jsonb),
  ('essence', 2, 7, '명사', '[
    {"en":"Honesty is the essence of a good relationship.","ko":"정직함은 좋은 관계의 본질이다."},
    {"en":"The essence of the story is about friendship.","ko":"그 이야기의 본질은 우정에 관한 것이다."},
    {"en":"Understanding the essence of a problem helps you solve it.","ko":"문제의 본질을 이해하면 그것을 해결하는 데 도움이 된다."}
  ]'::jsonb),
  ('intelligence', 2, 7, '명사', '[
    {"en":"Artificial intelligence is changing how we work.","ko":"인공지능은 우리가 일하는 방식을 바꾸고 있다."},
    {"en":"His intelligence impressed all his teachers.","ko":"그의 지능은 모든 선생님들에게 깊은 인상을 주었다."},
    {"en":"Emotional intelligence is as important as academic ability.","ko":"감성 지능은 학업 능력만큼 중요하다."}
  ]'::jsonb),
  ('solve', 2, 7, '동사', '[
    {"en":"It took her an hour to solve the math problem.","ko":"그녀가 그 수학 문제를 푸는 데 한 시간이 걸렸다."},
    {"en":"We need to solve this issue before the deadline.","ko":"우리는 마감일 전에 이 문제를 해결해야 한다."},
    {"en":"The detective solved the mystery quickly.","ko":"그 탐정은 그 미스터리를 빠르게 해결했다."}
  ]'::jsonb),
  ('inspire', 2, 7, '동사', '[
    {"en":"Her courage inspired many students.","ko":"그녀의 용기는 많은 학생들에게 영감을 주었다."},
    {"en":"The teacher inspired us to pursue our dreams.","ko":"그 선생님은 우리가 꿈을 추구하도록 격려했다."},
    {"en":"Great books can inspire readers to think differently.","ko":"훌륭한 책은 독자들이 다르게 생각하도록 영감을 줄 수 있다."}
  ]'::jsonb),
  ('refer', 2, 7, '동사', '[
    {"en":"Please refer to page 10 for more details.","ko":"더 자세한 내용은 10페이지를 참고하세요."},
    {"en":"She referred to the report during her speech.","ko":"그녀는 연설 중에 그 보고서를 언급했다."},
    {"en":"Students often refer to a dictionary when reading.","ko":"학생들은 독서할 때 종종 사전을 참고한다."}
  ]'::jsonb),
  ('review', 2, 7, '동사/명사', '[
    {"en":"We should review the lesson before the test.","ko":"우리는 시험 전에 그 수업 내용을 복습해야 한다."},
    {"en":"The movie received a positive review from critics.","ko":"그 영화는 평론가들로부터 긍정적인 평을 받았다."},
    {"en":"He reviews his notes every night after class.","ko":"그는 수업 후 매일 밤 필기를 복습한다."}
  ]'::jsonb),
  ('linguistics', 2, 7, '명사', '[
    {"en":"She is majoring in linguistics at university.","ko":"그녀는 대학에서 언어학을 전공하고 있다."},
    {"en":"Linguistics studies how languages develop and change.","ko":"언어학은 언어가 어떻게 발달하고 변화하는지 연구한다."},
    {"en":"His interest in linguistics began with learning foreign languages.","ko":"언어학에 대한 그의 관심은 외국어 학습에서 시작되었다."}
  ]'::jsonb),
  ('improve', 2, 7, '동사', '[
    {"en":"Reading every day can improve your vocabulary.","ko":"매일 독서하는 것은 어휘력을 향상시킬 수 있다."},
    {"en":"The team worked hard to improve their performance.","ko":"그 팀은 실력을 향상시키기 위해 열심히 노력했다."},
    {"en":"Her English has improved a lot this year.","ko":"그녀의 영어 실력은 올해 많이 향상되었다."}
  ]'::jsonb),
  ('content', 2, 7, '명사/형용사', '[
    {"en":"The content of the lecture was quite difficult.","ko":"그 강의의 내용은 꽤 어려웠다."},
    {"en":"She felt content with her test results.","ko":"그녀는 시험 결과에 만족했다."},
    {"en":"This website offers useful educational content.","ko":"이 웹사이트는 유용한 교육 콘텐츠를 제공한다."}
  ]'::jsonb),
  ('figure', 2, 7, '명사', '[
    {"en":"Look at Figure 2 to understand the process.","ko":"그 과정을 이해하려면 그림 2를 보세요."},
    {"en":"The report includes several important figures.","ko":"그 보고서는 몇 가지 중요한 수치를 포함하고 있다."},
    {"en":"He is considered a major figure in modern science.","ko":"그는 현대 과학의 중요한 인물로 여겨진다."}
  ]'::jsonb),
  ('scholar', 2, 7, '명사', '[
    {"en":"The scholar spent years studying ancient languages.","ko":"그 학자는 고대 언어를 연구하는 데 수년을 보냈다."},
    {"en":"She became a respected scholar in history.","ko":"그녀는 역사학 분야에서 존경받는 학자가 되었다."},
    {"en":"Many scholars attended the international conference.","ko":"많은 학자들이 그 국제 학회에 참석했다."}
  ]'::jsonb),
  ('concept', 2, 7, '명사', '[
    {"en":"The concept of gravity was explained clearly.","ko":"중력의 개념이 명확하게 설명되었다."},
    {"en":"It''s hard to grasp this concept at first.","ko":"이 개념을 처음에는 이해하기 어렵다."},
    {"en":"The teacher introduced a new concept in class today.","ko":"선생님은 오늘 수업에서 새로운 개념을 소개했다."}
  ]'::jsonb),
  ('principle', 2, 7, '명사', '[
    {"en":"He always acts according to his principles.","ko":"그는 항상 자신의 원칙에 따라 행동한다."},
    {"en":"The experiment demonstrates a basic scientific principle.","ko":"그 실험은 기본적인 과학 원리를 보여준다."},
    {"en":"Honesty is one of the most important principles in life.","ko":"정직함은 인생에서 가장 중요한 원칙 중 하나이다."}
  ]'::jsonb),
  ('expose', 2, 7, '동사', '[
    {"en":"The documentary exposed the truth about pollution.","ko":"그 다큐멘터리는 오염에 관한 진실을 드러냈다."},
    {"en":"Children should be exposed to various cultures.","ko":"아이들은 다양한 문화에 노출되어야 한다."},
    {"en":"The report exposed several errors in the plan.","ko":"그 보고서는 계획에서 여러 오류를 드러냈다."}
  ]'::jsonb),
  ('theory', 2, 7, '명사', '[
    {"en":"Scientists developed a new theory to explain the phenomenon.","ko":"과학자들은 그 현상을 설명하기 위해 새로운 이론을 개발했다."},
    {"en":"The theory of evolution is taught in biology class.","ko":"진화론은 생물학 수업에서 가르쳐진다."},
    {"en":"Her theory was later proven correct by experiments.","ko":"그녀의 이론은 나중에 실험을 통해 옳다고 증명되었다."}
  ]'::jsonb),
  ('define', 2, 7, '동사', '[
    {"en":"Please define the term before using it in your essay.","ko":"에세이에서 그 용어를 사용하기 전에 정의를 내려주세요."},
    {"en":"It''s difficult to define happiness in one sentence.","ko":"행복을 한 문장으로 정의하기는 어렵다."},
    {"en":"The dictionary defines the word clearly.","ko":"그 사전은 그 단어를 명확하게 정의하고 있다."}
  ]'::jsonb),
  ('demonstrate', 2, 7, '동사', '[
    {"en":"The teacher demonstrated how to solve the equation.","ko":"선생님은 그 방정식을 푸는 방법을 보여주었다."},
    {"en":"Her actions demonstrate great responsibility.","ko":"그녀의 행동은 대단한 책임감을 보여준다."},
    {"en":"The experiment demonstrates the importance of clean water.","ko":"그 실험은 깨끗한 물의 중요성을 증명한다."}
  ]'::jsonb),
  ('conclude', 2, 7, '동사', '[
    {"en":"The researchers concluded that the method was effective.","ko":"연구자들은 그 방법이 효과적이라고 결론 내렸다."},
    {"en":"He concluded his speech with a famous quote.","ko":"그는 유명한 명언으로 연설을 마무리했다."},
    {"en":"We concluded the meeting earlier than planned.","ko":"우리는 계획보다 일찍 회의를 끝냈다."}
  ]'::jsonb),
  ('statistics', 2, 7, '명사', '[
    {"en":"Statistics shows that reading habits are changing.","ko":"통계는 독서 습관이 변화하고 있음을 보여준다."},
    {"en":"She studies statistics to analyze social trends.","ko":"그녀는 사회적 경향을 분석하기 위해 통계학을 공부한다."},
    {"en":"The report is based on reliable statistics.","ko":"그 보고서는 신뢰할 만한 통계 자료에 근거한다."}
  ]'::jsonb),
  ('physics', 2, 7, '명사', '[
    {"en":"Physics explains how objects move and interact.","ko":"물리학은 물체가 어떻게 움직이고 상호작용하는지 설명한다."},
    {"en":"He finds physics more interesting than chemistry.","ko":"그는 화학보다 물리학이 더 흥미롭다고 생각한다."},
    {"en":"The physics exam covered motion and energy.","ko":"그 물리학 시험은 운동과 에너지를 다뤘다."}
  ]'::jsonb),
  ('geology', 2, 7, '명사', '[
    {"en":"Geology helps us understand the history of the Earth.","ko":"지질학은 우리가 지구의 역사를 이해하는 데 도움을 준다."},
    {"en":"She chose geology as her college major.","ko":"그녀는 지질학을 대학 전공으로 선택했다."},
    {"en":"The geology class visited a rocky mountain area.","ko":"그 지질학 수업은 암석이 많은 산악 지역을 방문했다."}
  ]'::jsonb),
  ('diameter', 2, 7, '명사', '[
    {"en":"The diameter of the circle is ten centimeters.","ko":"그 원의 지름은 10센티미터이다."},
    {"en":"You can find the area if you know the diameter.","ko":"지름을 알면 넓이를 구할 수 있다."},
    {"en":"The pipe has a small diameter.","ko":"그 파이프는 지름이 작다."}
  ]'::jsonb),
  ('literal', 2, 7, '형용사', '[
    {"en":"Don''t take his words in a literal sense.","ko":"그의 말을 글자 그대로 받아들이지 마세요."},
    {"en":"The literal meaning of the idiom is different from its actual meaning.","ko":"그 관용구의 문자 그대로의 의미는 실제 의미와 다르다."},
    {"en":"She gave a literal translation of the poem.","ko":"그녀는 그 시를 글자 그대로 번역했다."}
  ]'::jsonb),
  ('literate', 2, 7, '형용사', '[
    {"en":"The program aims to make more people literate.","ko":"그 프로그램은 더 많은 사람들이 읽고 쓸 줄 알게 하는 것을 목표로 한다."},
    {"en":"Being digitally literate is important nowadays.","ko":"요즘은 디지털을 다룰 줄 아는 것이 중요하다."},
    {"en":"Most adults in the country are literate.","ko":"그 나라의 대부분의 성인은 읽고 쓸 줄 안다."}
  ]'::jsonb),
  ('fluent', 2, 7, '형용사', '[
    {"en":"She speaks fluent French and Spanish.","ko":"그녀는 프랑스어와 스페인어를 유창하게 구사한다."},
    {"en":"He became fluent in English after living abroad.","ko":"그는 해외에서 살고 나서 영어에 유창해졌다."},
    {"en":"Being fluent in a language takes years of practice.","ko":"언어에 유창해지려면 수년의 연습이 필요하다."}
  ]'::jsonb),
  ('go over', 2, 7, '구동사', '[
    {"en":"Let''s go over the plan one more time.","ko":"그 계획을 한 번 더 검토해보자."},
    {"en":"The teacher went over the answers with the class.","ko":"선생님은 학급과 함께 답을 검토했다."},
    {"en":"I need to go over my notes before the exam.","ko":"나는 시험 전에 필기를 점검해야 한다."}
  ]'::jsonb),
  ('look up', 2, 7, '구동사', '[
    {"en":"You can look up the word in a dictionary.","ko":"그 단어는 사전에서 찾아볼 수 있다."},
    {"en":"She looked up the address on her phone.","ko":"그녀는 휴대폰으로 주소를 찾아보았다."},
    {"en":"I always look up unfamiliar terms while reading.","ko":"나는 독서할 때 낯선 용어를 항상 찾아본다."}
  ]'::jsonb),
  ('dwell on', 2, 7, '구동사', '[
    {"en":"Don''t dwell on your mistakes too much.","ko":"너의 실수에 대해 너무 깊이 생각하지 마라."},
    {"en":"He tends to dwell on small problems.","ko":"그는 사소한 문제를 자세히 생각하는 경향이 있다."},
    {"en":"She dwelled on the details of the report.","ko":"그녀는 그 보고서의 세부 사항에 대해 깊이 생각했다."}
  ]'::jsonb),
  ('educate', 2, 8, '동사', '[
    {"en":"Schools work to educate students about the environment.","ko":"학교는 학생들에게 환경에 대해 교육하려고 노력한다."},
    {"en":"Parents should educate their children about honesty.","ko":"부모는 자녀에게 정직함에 대해 가르쳐야 한다."},
    {"en":"The program educates people on healthy eating.","ko":"그 프로그램은 사람들에게 건강한 식습관에 대해 교육한다."}
  ]'::jsonb),
  ('instruct', 2, 8, '동사', '[
    {"en":"The coach instructed the players to warm up first.","ko":"코치는 선수들에게 먼저 준비 운동을 하라고 지시했다."},
    {"en":"She instructs beginners in basic computer skills.","ko":"그녀는 초보자들에게 기본 컴퓨터 기술을 가르친다."},
    {"en":"The manual instructs users on how to assemble the device.","ko":"그 설명서는 사용자에게 기기를 조립하는 방법을 알려준다."}
  ]'::jsonb),
  ('lecture', 2, 8, '명사/동사', '[
    {"en":"The professor gave a fascinating lecture on history.","ko":"그 교수는 역사에 관한 흥미로운 강의를 했다."},
    {"en":"My father lectured me about being late.","ko":"아버지는 나에게 늦은 것에 대해 훈계하셨다."},
    {"en":"Students took notes during the science lecture.","ko":"학생들은 과학 강의 중에 필기를 했다."}
  ]'::jsonb),
  ('due', 2, 8, '형용사', '[
    {"en":"The assignment is due next Monday.","ko":"그 과제는 다음 주 월요일이 마감이다."},
    {"en":"The train is due to arrive at noon.","ko":"그 기차는 정오에 도착할 예정이다."},
    {"en":"Her library books were due yesterday.","ko":"그녀의 도서관 책들은 어제가 반납일이었다."}
  ]'::jsonb),
  ('term', 2, 8, '명사', '[
    {"en":"The final exams take place at the end of the term.","ko":"기말고사는 학기 말에 치러진다."},
    {"en":"This scientific term is hard to understand.","ko":"이 과학 용어는 이해하기 어렵다."},
    {"en":"We studied hard throughout the spring term.","ko":"우리는 봄 학기 내내 열심히 공부했다."}
  ]'::jsonb),
  ('examine', 2, 8, '동사', '[
    {"en":"The doctor examined the patient carefully.","ko":"의사는 환자를 세심하게 진찰했다."},
    {"en":"Teachers examine students'' understanding through quizzes.","ko":"선생님들은 퀴즈를 통해 학생들의 이해도를 검사한다."},
    {"en":"Scientists examined the samples under a microscope.","ko":"과학자들은 현미경으로 그 표본들을 검사했다."}
  ]'::jsonb),
  ('award', 2, 8, '명사/동사', '[
    {"en":"She received an award for her excellent essay.","ko":"그녀는 훌륭한 에세이로 상을 받았다."},
    {"en":"The school awards prizes to top students every year.","ko":"그 학교는 매년 우수한 학생들에게 상을 준다."},
    {"en":"He won the award for best performance.","ko":"그는 최우수 연기상을 받았다."}
  ]'::jsonb),
  ('multiply', 2, 8, '동사', '[
    {"en":"Multiply six by seven to get the answer.","ko":"답을 얻으려면 6에 7을 곱하세요."},
    {"en":"The rabbits multiplied quickly in the field.","ko":"토끼들은 그 들판에서 빠르게 증식했다."},
    {"en":"Her worries seemed to multiply before the exam.","ko":"시험 전에 그녀의 걱정은 늘어나는 것 같았다."}
  ]'::jsonb),
  ('calculate', 2, 8, '동사', '[
    {"en":"Please calculate the total cost of the trip.","ko":"그 여행의 총 비용을 계산해주세요."},
    {"en":"She calculated her average score carefully.","ko":"그녀는 자신의 평균 점수를 신중하게 계산했다."},
    {"en":"It is important to calculate risks before making a decision.","ko":"결정을 내리기 전에 위험을 계산하는 것이 중요하다."}
  ]'::jsonb),
  ('memorize', 2, 8, '동사', '[
    {"en":"Students memorized the poem for class.","ko":"학생들은 수업을 위해 그 시를 암기했다."},
    {"en":"It takes practice to memorize new vocabulary.","ko":"새로운 어휘를 암기하려면 연습이 필요하다."},
    {"en":"He memorized his speech before the presentation.","ko":"그는 발표 전에 연설을 암기했다."}
  ]'::jsonb),
  ('institute', 2, 8, '명사', '[
    {"en":"She works at a research institute in Seoul.","ko":"그녀는 서울에 있는 연구소에서 일한다."},
    {"en":"He studied at a technical institute after high school.","ko":"그는 고등학교 졸업 후 기술 대학에서 공부했다."},
    {"en":"The institute publishes an academic journal every year.","ko":"그 연구소는 매년 학술지를 발행한다."}
  ]'::jsonb),
  ('laboratory', 2, 8, '명사', '[
    {"en":"The students conducted an experiment in the laboratory.","ko":"학생들은 실험실에서 실험을 수행했다."},
    {"en":"Safety rules must be followed in the laboratory.","ko":"실험실에서는 안전 규칙을 지켜야 한다."},
    {"en":"The new laboratory has advanced equipment.","ko":"그 새 실험실에는 첨단 장비가 있다."}
  ]'::jsonb),
  ('dormitory', 2, 8, '명사', '[
    {"en":"Many college students live in a dormitory.","ko":"많은 대학생들이 기숙사에서 생활한다."},
    {"en":"The dormitory has a curfew at midnight.","ko":"그 기숙사는 자정에 통금이 있다."},
    {"en":"She shares a dormitory room with two roommates.","ko":"그녀는 두 명의 룸메이트와 기숙사 방을 함께 쓴다."}
  ]'::jsonb),
  ('principal', 2, 8, '명사/형용사', '[
    {"en":"The principal gave a speech at the ceremony.","ko":"교장 선생님은 그 행사에서 연설을 하셨다."},
    {"en":"The principal reason for the delay was the weather.","ko":"지연의 주된 이유는 날씨였다."},
    {"en":"Students respect the principal for her fairness.","ko":"학생들은 공정함 때문에 교장 선생님을 존경한다."}
  ]'::jsonb),
  ('aisle', 2, 8, '명사', '[
    {"en":"She walked down the aisle to find her seat.","ko":"그녀는 자리를 찾기 위해 통로를 걸어갔다."},
    {"en":"Please keep the aisle clear during the exam.","ko":"시험 중에는 통로를 비워 두세요."},
    {"en":"He sat in an aisle seat on the bus.","ko":"그는 버스에서 통로 쪽 좌석에 앉았다."}
  ]'::jsonb),
  ('semester', 2, 8, '명사', '[
    {"en":"The new semester begins in March.","ko":"새 학기는 3월에 시작한다."},
    {"en":"She improved her grades this semester.","ko":"그녀는 이번 학기에 성적이 향상되었다."},
    {"en":"We have four subjects each semester.","ko":"우리는 매 학기마다 네 과목이 있다."}
  ]'::jsonb),
  ('absent', 2, 8, '형용사', '[
    {"en":"He was absent from school due to illness.","ko":"그는 병 때문에 학교에 결석했다."},
    {"en":"Three students were absent from class today.","ko":"오늘 세 명의 학생이 수업에 결석했다."},
    {"en":"Being absent too often can lower your grade.","ko":"너무 자주 결석하면 성적이 낮아질 수 있다."}
  ]'::jsonb),
  ('attendance', 2, 8, '명사', '[
    {"en":"Attendance is checked at the beginning of class.","ko":"출석은 수업 시작할 때 확인된다."},
    {"en":"Her perfect attendance impressed the teacher.","ko":"그녀의 개근은 선생님에게 좋은 인상을 주었다."},
    {"en":"The school requires regular attendance.","ko":"그 학교는 규칙적인 출석을 요구한다."}
  ]'::jsonb),
  ('motivate', 2, 8, '동사', '[
    {"en":"Good grades motivated her to study harder.","ko":"좋은 성적은 그녀가 더 열심히 공부하도록 동기를 부여했다."},
    {"en":"The coach motivated the team before the game.","ko":"코치는 경기 전에 팀에게 동기를 부여했다."},
    {"en":"A supportive teacher can motivate students to learn.","ko":"격려하는 선생님은 학생들이 배우도록 동기를 부여할 수 있다."}
  ]'::jsonb),
  ('attitude', 2, 8, '명사', '[
    {"en":"He has a positive attitude toward learning.","ko":"그는 배움에 대해 긍정적인 태도를 가지고 있다."},
    {"en":"Her attitude changed after the trip.","ko":"그녀의 태도는 그 여행 후에 바뀌었다."},
    {"en":"A good attitude helps you overcome difficulties.","ko":"좋은 태도는 어려움을 극복하는 데 도움이 된다."}
  ]'::jsonb),
  ('eager', 2, 8, '형용사', '[
    {"en":"The students were eager to start the experiment.","ko":"학생들은 그 실험을 시작하고 싶어 안달이었다."},
    {"en":"She is eager to learn new languages.","ko":"그녀는 새로운 언어를 배우고 싶어 한다."},
    {"en":"He seemed eager to answer the teacher''s question.","ko":"그는 선생님의 질문에 답하고 싶어 하는 것 같았다."}
  ]'::jsonb),
  ('entrance', 2, 8, '명사', '[
    {"en":"The entrance exam was more difficult than expected.","ko":"입학 시험은 예상보다 더 어려웠다."},
    {"en":"Meet me at the entrance of the library.","ko":"도서관 입구에서 만나자."},
    {"en":"He passed the entrance interview successfully.","ko":"그는 입학 면접을 성공적으로 통과했다."}
  ]'::jsonb),
  ('submit', 2, 8, '동사', '[
    {"en":"Please submit your essay by Friday.","ko":"금요일까지 에세이를 제출해주세요."},
    {"en":"She submitted her application online.","ko":"그녀는 온라인으로 지원서를 제출했다."},
    {"en":"Students must submit their homework on time.","ko":"학생들은 제시간에 숙제를 제출해야 한다."}
  ]'::jsonb),
  ('portfolio', 2, 8, '명사', '[
    {"en":"He prepared a portfolio for his art school application.","ko":"그는 미술 학교 지원을 위해 포트폴리오를 준비했다."},
    {"en":"Her portfolio included photos and paintings.","ko":"그녀의 포트폴리오는 사진과 그림을 포함했다."},
    {"en":"The design portfolio impressed the interviewers.","ko":"그 디자인 포트폴리오는 면접관들에게 깊은 인상을 주었다."}
  ]'::jsonb),
  ('peer', 2, 8, '명사', '[
    {"en":"Teenagers often care about peer opinions.","ko":"십 대들은 종종 또래의 의견에 신경을 쓴다."},
    {"en":"She learns better when working with her peers.","ko":"그녀는 또래들과 함께 작업할 때 더 잘 배운다."},
    {"en":"Peer pressure can influence students'' choices.","ko":"또래 압력은 학생들의 선택에 영향을 줄 수 있다."}
  ]'::jsonb),
  ('scholarship', 2, 8, '명사', '[
    {"en":"She won a scholarship to study abroad.","ko":"그녀는 해외에서 공부하기 위한 장학금을 받았다."},
    {"en":"The scholarship covers his full tuition.","ko":"그 장학금은 그의 등록금 전액을 충당한다."},
    {"en":"Many students apply for the scholarship every year.","ko":"많은 학생들이 매년 그 장학금에 지원한다."}
  ]'::jsonb),
  ('grant', 2, 8, '명사/동사', '[
    {"en":"He received a research grant from the university.","ko":"그는 대학으로부터 연구 지원금을 받았다."},
    {"en":"The committee granted her request for extra time.","ko":"위원회는 추가 시간에 대한 그녀의 요청을 승인했다."},
    {"en":"The government grants scholarships to talented students.","ko":"정부는 재능 있는 학생들에게 장학금을 지급한다."}
  ]'::jsonb),
  ('get along with', 2, 8, '구동사', '[
    {"en":"She gets along with all her classmates.","ko":"그녀는 모든 반 친구들과 잘 지낸다."},
    {"en":"It is important to get along with your coworkers.","ko":"동료들과 잘 지내는 것이 중요하다."},
    {"en":"He finds it easy to get along with new people.","ko":"그는 새로운 사람들과 쉽게 잘 지낸다."}
  ]'::jsonb),
  ('catch up with', 2, 8, '구동사', '[
    {"en":"She studied hard to catch up with her classmates.","ko":"그녀는 반 친구들을 따라잡기 위해 열심히 공부했다."},
    {"en":"He ran fast to catch up with his friend.","ko":"그는 친구를 따라잡기 위해 빨리 뛰었다."},
    {"en":"It is hard to catch up with new technology.","ko":"새로운 기술을 따라잡기는 어렵다."}
  ]'::jsonb),
  ('drop out (of)', 2, 8, '구동사', '[
    {"en":"He decided to drop out of the club.","ko":"그는 그 동아리를 그만두기로 결정했다."},
    {"en":"Few students drop out of this program.","ko":"이 프로그램에서 중퇴하는 학생은 거의 없다."},
    {"en":"She almost dropped out of school last year.","ko":"그녀는 작년에 학교를 거의 중퇴할 뻔했다."}
  ]'::jsonb),
  ('manufacture', 2, 9, '동사/명사', '[
    {"en":"The factory manufactures electronic devices.","ko":"그 공장은 전자 기기를 제조한다."},
    {"en":"This company manufactures cars for export.","ko":"이 회사는 수출용 자동차를 제조한다."},
    {"en":"The manufacture of the product takes several weeks.","ko":"그 제품의 제조는 몇 주가 걸린다."}
  ]'::jsonb),
  ('manage', 2, 9, '동사', '[
    {"en":"She manages a small bookstore downtown.","ko":"그녀는 시내에서 작은 서점을 운영한다."},
    {"en":"He managed to finish the project on time.","ko":"그는 그럭저럭 제시간에 프로젝트를 끝냈다."},
    {"en":"Managing a team requires good communication skills.","ko":"팀을 관리하려면 좋은 의사소통 능력이 필요하다."}
  ]'::jsonb),
  ('operate', 2, 9, '동사', '[
    {"en":"The company operates in several countries.","ko":"그 회사는 여러 나라에서 운영된다."},
    {"en":"This machine operates automatically.","ko":"이 기계는 자동으로 작동한다."},
    {"en":"He learned how to operate the new software.","ko":"그는 새 소프트웨어를 작동하는 방법을 배웠다."}
  ]'::jsonb),
  ('expert', 2, 9, '명사/형용사', '[
    {"en":"She is an expert in environmental science.","ko":"그녀는 환경 과학 전문가이다."},
    {"en":"An expert gave advice on career planning.","ko":"한 전문가가 진로 계획에 대한 조언을 해주었다."},
    {"en":"He became an expert cook after years of practice.","ko":"그는 수년간의 연습 끝에 숙련된 요리사가 되었다."}
  ]'::jsonb),
  ('senior', 2, 9, '형용사/명사', '[
    {"en":"She is a senior manager at the company.","ko":"그녀는 그 회사의 선임 관리자이다."},
    {"en":"Senior students often help new members.","ko":"선배 학생들은 종종 신입 회원들을 도와준다."},
    {"en":"He respects the opinions of his seniors.","ko":"그는 자신의 선배들의 의견을 존중한다."}
  ]'::jsonb),
  ('psychologist', 2, 9, '명사', '[
    {"en":"The psychologist studies how people make decisions.","ko":"그 심리학자는 사람들이 어떻게 결정을 내리는지 연구한다."},
    {"en":"She wants to become a psychologist in the future.","ko":"그녀는 미래에 심리학자가 되고 싶어 한다."},
    {"en":"A psychologist helped him deal with stress.","ko":"한 심리학자가 그가 스트레스를 다루도록 도와주었다."}
  ]'::jsonb),
  ('personnel', 2, 9, '명사', '[
    {"en":"The personnel department handles hiring.","ko":"인사과는 채용을 담당한다."},
    {"en":"New personnel will join the team next month.","ko":"새 직원들이 다음 달에 그 팀에 합류할 것이다."},
    {"en":"The company trains its personnel regularly.","ko":"그 회사는 직원들을 정기적으로 교육한다."}
  ]'::jsonb),
  ('barber', 2, 9, '명사', '[
    {"en":"The barber cut his hair short.","ko":"이발사는 그의 머리를 짧게 잘랐다."},
    {"en":"She recommended a good barber near the station.","ko":"그녀는 역 근처의 좋은 이발소를 추천했다."},
    {"en":"The barber shop was crowded on Saturday.","ko":"그 이발소는 토요일에 붐볐다."}
  ]'::jsonb),
  ('counselor', 2, 9, '명사', '[
    {"en":"The school counselor helped him choose his classes.","ko":"학교 상담 교사는 그가 수업을 선택하도록 도와주었다."},
    {"en":"She talked to a counselor about her future career.","ko":"그녀는 자신의 미래 진로에 대해 상담 교사와 이야기했다."},
    {"en":"Camp counselors organized fun activities for children.","ko":"캠프 지도 교사들은 아이들을 위해 재미있는 활동을 준비했다."}
  ]'::jsonb),
  ('reward', 2, 9, '명사/동사', '[
    {"en":"Hard work often brings great rewards.","ko":"노력은 종종 큰 보상을 가져다준다."},
    {"en":"The teacher rewarded students for their effort.","ko":"선생님은 학생들의 노력에 대해 보상했다."},
    {"en":"She received a reward for finding the lost dog.","ko":"그녀는 잃어버린 개를 찾아준 것에 대해 보상을 받았다."}
  ]'::jsonb),
  ('wage', 2, 9, '명사', '[
    {"en":"The company raised the minimum wage this year.","ko":"그 회사는 올해 최저 임금을 인상했다."},
    {"en":"Workers demanded a fair wage for their labor.","ko":"노동자들은 자신들의 노동에 대한 공정한 임금을 요구했다."},
    {"en":"His weekly wage covers his living expenses.","ko":"그의 주급은 생활비를 충당한다."}
  ]'::jsonb),
  ('shift', 2, 9, '명사/동사', '[
    {"en":"She works the night shift at the hospital.","ko":"그녀는 병원에서 야간 근무조로 일한다."},
    {"en":"There was a shift in public opinion.","ko":"여론에 변화가 있었다."},
    {"en":"He shifted his focus from sports to studying.","ko":"그는 관심을 운동에서 공부로 바꾸었다."}
  ]'::jsonb),
  ('retire', 2, 9, '동사', '[
    {"en":"My grandfather retired at the age of sixty-five.","ko":"할아버지는 65세에 은퇴하셨다."},
    {"en":"She plans to retire early and travel the world.","ko":"그녀는 일찍 은퇴하여 세계를 여행할 계획이다."},
    {"en":"The teacher retired after thirty years of service.","ko":"그 선생님은 30년의 근무 후에 은퇴하셨다."}
  ]'::jsonb),
  ('supervise', 2, 9, '동사', '[
    {"en":"The manager supervises the entire project.","ko":"그 관리자는 전체 프로젝트를 감독한다."},
    {"en":"Teachers supervise students during the field trip.","ko":"선생님들은 현장 학습 동안 학생들을 감독한다."},
    {"en":"She supervises a team of ten employees.","ko":"그녀는 열 명의 직원으로 구성된 팀을 감독한다."}
  ]'::jsonb),
  ('accomplish', 2, 9, '동사', '[
    {"en":"He accomplished his goal of running a marathon.","ko":"그는 마라톤을 완주하는 목표를 달성했다."},
    {"en":"The team accomplished the project ahead of schedule.","ko":"그 팀은 예정보다 일찍 프로젝트를 완수했다."},
    {"en":"She felt proud after accomplishing her task.","ko":"그녀는 자신의 임무를 완수한 후 자랑스러워했다."}
  ]'::jsonb),
  ('architect', 2, 9, '명사', '[
    {"en":"The architect designed a beautiful new library.","ko":"그 건축가는 아름다운 새 도서관을 설계했다."},
    {"en":"She wants to be an architect who builds eco-friendly homes.","ko":"그녀는 친환경 주택을 짓는 건축가가 되고 싶어 한다."},
    {"en":"The architect presented his plan to the city council.","ko":"그 건축가는 자신의 계획을 시의회에 발표했다."}
  ]'::jsonb),
  ('secretary', 2, 9, '명사', '[
    {"en":"The secretary scheduled all the meetings for the week.","ko":"비서는 그 주의 모든 회의 일정을 잡았다."},
    {"en":"He works as a secretary at a law firm.","ko":"그는 법률 회사에서 비서로 일한다."},
    {"en":"The Secretary of Education announced new school policies.","ko":"교육부 장관은 새로운 학교 정책을 발표했다."}
  ]'::jsonb),
  ('experienced', 2, 9, '형용사', '[
    {"en":"She is an experienced teacher with ten years of practice.","ko":"그녀는 10년의 경력을 가진 숙련된 교사이다."},
    {"en":"The company hired an experienced engineer.","ko":"그 회사는 경험 많은 엔지니어를 채용했다."},
    {"en":"An experienced guide led the mountain tour.","ko":"경험 많은 가이드가 그 산악 투어를 이끌었다."}
  ]'::jsonb),
  ('vend', 2, 9, '동사', '[
    {"en":"Vendors vend snacks near the stadium.","ko":"행상인들은 경기장 근처에서 간식을 판다."},
    {"en":"Ice cream is vended from small carts in summer.","ko":"여름에는 작은 수레에서 아이스크림이 팔린다."},
    {"en":"Newspapers used to be vended on street corners.","ko":"예전에는 신문이 길모퉁이에서 팔리곤 했다."}
  ]'::jsonb),
  ('requirement', 2, 9, '명사', '[
    {"en":"A high school diploma is a requirement for this job.","ko":"고등학교 졸업장은 이 직업의 필수 조건이다."},
    {"en":"The requirements for the scholarship are strict.","ko":"그 장학금의 자격 요건은 엄격하다."},
    {"en":"She met all the requirements for graduation.","ko":"그녀는 졸업을 위한 모든 요건을 충족했다."}
  ]'::jsonb),
  ('superior', 2, 9, '명사/형용사', '[
    {"en":"He reported the problem to his superior.","ko":"그는 그 문제를 상사에게 보고했다."},
    {"en":"This product is superior to the old model.","ko":"이 제품은 이전 모델보다 우수하다."},
    {"en":"She showed superior skills in the competition.","ko":"그녀는 그 대회에서 뛰어난 실력을 보였다."}
  ]'::jsonb),
  ('career', 2, 9, '명사', '[
    {"en":"She built a successful career in medicine.","ko":"그녀는 의학 분야에서 성공적인 경력을 쌓았다."},
    {"en":"He is thinking about changing his career.","ko":"그는 자신의 직업을 바꾸는 것을 고려하고 있다."},
    {"en":"Choosing the right career path takes time.","ko":"올바른 진로를 선택하는 데는 시간이 걸린다."}
  ]'::jsonb),
  ('profession', 2, 9, '명사', '[
    {"en":"Teaching is a respected profession.","ko":"가르치는 일은 존경받는 직업이다."},
    {"en":"He entered the medical profession after graduation.","ko":"그는 졸업 후 의료계에 들어갔다."},
    {"en":"Each profession requires different skills.","ko":"각 직업은 서로 다른 기술을 필요로 한다."}
  ]'::jsonb),
  ('application', 2, 9, '명사', '[
    {"en":"She submitted her college application last week.","ko":"그녀는 지난주에 대학 지원서를 제출했다."},
    {"en":"The job application requires two references.","ko":"그 취업 지원서는 추천인 두 명을 요구한다."},
    {"en":"He filled out the application form carefully.","ko":"그는 지원서 양식을 꼼꼼히 작성했다."}
  ]'::jsonb),
  ('salary', 2, 9, '명사', '[
    {"en":"Her salary increased after the promotion.","ko":"그녀의 급여는 승진 후에 인상되었다."},
    {"en":"The company offers a competitive salary.","ko":"그 회사는 경쟁력 있는 급여를 제공한다."},
    {"en":"He saves part of his salary every month.","ko":"그는 매달 급여의 일부를 저축한다."}
  ]'::jsonb),
  ('labor', 2, 9, '명사', '[
    {"en":"Manual labor requires physical strength.","ko":"육체노동은 신체적 힘을 필요로 한다."},
    {"en":"The farm depends on seasonal labor.","ko":"그 농장은 계절 노동에 의존한다."},
    {"en":"Fair labor conditions benefit both workers and companies.","ko":"공정한 노동 조건은 노동자와 회사 모두에게 이익이 된다."}
  ]'::jsonb),
  ('proficient', 2, 9, '형용사', '[
    {"en":"She is proficient in three foreign languages.","ko":"그녀는 세 가지 외국어에 능숙하다."},
    {"en":"He became proficient at using the new software.","ko":"그는 새 소프트웨어를 사용하는 데 능숙해졌다."},
    {"en":"Being proficient in math helps in many careers.","ko":"수학에 능숙한 것은 많은 직업에 도움이 된다."}
  ]'::jsonb),
  ('prompt', 2, 9, '형용사', '[
    {"en":"The company gave a prompt reply to the complaint.","ko":"그 회사는 그 항의에 신속한 답변을 했다."},
    {"en":"She is always prompt for meetings.","ko":"그녀는 항상 회의에 시간을 엄수한다."},
    {"en":"A prompt response can prevent bigger problems.","ko":"신속한 대응은 더 큰 문제를 막을 수 있다."}
  ]'::jsonb),
  ('insist on', 2, 9, '구동사', '[
    {"en":"He insisted on paying for the meal.","ko":"그는 식사비를 자신이 내겠다고 고집했다."},
    {"en":"She insisted on finishing the project alone.","ko":"그녀는 그 프로젝트를 혼자 끝내겠다고 고집했다."},
    {"en":"They insisted on checking the details again.","ko":"그들은 세부 사항을 다시 확인하겠다고 주장했다."}
  ]'::jsonb),
  ('turn down', 2, 9, '구동사', '[
    {"en":"She turned down the job offer.","ko":"그녀는 그 취업 제안을 거절했다."},
    {"en":"He turned down the invitation to the party.","ko":"그는 그 파티 초대를 거절했다."},
    {"en":"The bank turned down his loan application.","ko":"그 은행은 그의 대출 신청을 거절했다."}
  ]'::jsonb),
  ('pile', 2, 10, '명사/동사', '[
    {"en":"There was a pile of books on the desk.","ko":"책상 위에 책 더미가 있었다."},
    {"en":"He piled the boxes neatly in the corner.","ko":"그는 상자들을 구석에 깔끔하게 쌓았다."},
    {"en":"Papers piled up on her desk during the busy week.","ko":"바쁜 한 주 동안 그녀의 책상에 서류가 쌓였다."}
  ]'::jsonb),
  ('colleague', 2, 10, '명사', '[
    {"en":"She discussed the project with her colleagues.","ko":"그녀는 동료들과 그 프로젝트에 대해 논의했다."},
    {"en":"He gets along well with his colleagues.","ko":"그는 동료들과 잘 지낸다."},
    {"en":"Her colleague helped her finish the report.","ko":"그녀의 동료는 그녀가 보고서를 끝내는 것을 도와주었다."}
  ]'::jsonb),
  ('attach', 2, 10, '동사', '[
    {"en":"Please attach the file to your email.","ko":"이메일에 그 파일을 첨부해주세요."},
    {"en":"She attached a note to the gift.","ko":"그녀는 선물에 메모를 붙였다."},
    {"en":"A label was attached to each box.","ko":"각 상자에 라벨이 붙어 있었다."}
  ]'::jsonb),
  ('photocopy', 2, 10, '명사/동사', '[
    {"en":"Can you make a photocopy of this document?","ko":"이 서류를 복사해 줄 수 있나요?"},
    {"en":"She photocopied the handout for the class.","ko":"그녀는 그 수업을 위해 유인물을 복사했다."},
    {"en":"The office has a new photocopy machine.","ko":"그 사무실에는 새 복사기가 있다."}
  ]'::jsonb),
  ('appoint', 2, 10, '동사', '[
    {"en":"The board appointed a new director.","ko":"이사회는 새 이사를 임명했다."},
    {"en":"She was appointed as team leader last month.","ko":"그녀는 지난달 팀장으로 임명되었다."},
    {"en":"They appointed a time to meet next week.","ko":"그들은 다음 주에 만날 시간을 정했다."}
  ]'::jsonb),
  ('agency', 2, 10, '명사', '[
    {"en":"He works for an advertising agency.","ko":"그는 광고 대행사에서 일한다."},
    {"en":"The travel agency planned our entire trip.","ko":"그 여행사는 우리의 여행 전체를 계획했다."},
    {"en":"She booked her flight through a travel agency.","ko":"그녀는 여행사를 통해 항공편을 예약했다."}
  ]'::jsonb),
  ('basis', 2, 10, '명사', '[
    {"en":"The report is written on the basis of survey results.","ko":"그 보고서는 설문 조사 결과를 바탕으로 작성되었다."},
    {"en":"Trust is the basis of a good relationship.","ko":"신뢰는 좋은 관계의 기초이다."},
    {"en":"Employees are paid on a monthly basis.","ko":"직원들은 매달 급여를 받는다."}
  ]'::jsonb),
  ('index', 2, 10, '명사', '[
    {"en":"The book has a detailed index at the back.","ko":"그 책은 뒤쪽에 상세한 색인이 있다."},
    {"en":"The price index rose slightly last month.","ko":"물가 지수가 지난달 약간 상승했다."},
    {"en":"Use the index to find the topic quickly.","ko":"그 주제를 빨리 찾으려면 색인을 사용하세요."}
  ]'::jsonb),
  ('deny', 2, 10, '동사', '[
    {"en":"He denied breaking the window.","ko":"그는 창문을 깬 것을 부인했다."},
    {"en":"The manager denied the request for a refund.","ko":"그 관리자는 환불 요청을 거절했다."},
    {"en":"She denied any involvement in the mistake.","ko":"그녀는 그 실수에 어떤 관여도 부인했다."}
  ]'::jsonb),
  ('stationery', 2, 10, '명사', '[
    {"en":"She bought some stationery for school.","ko":"그녀는 학교를 위해 문구류를 조금 샀다."},
    {"en":"The store sells pens, notebooks, and other stationery.","ko":"그 가게는 펜, 공책, 그리고 기타 문구류를 판다."},
    {"en":"He organized his stationery neatly in a drawer.","ko":"그는 자신의 문구류를 서랍에 깔끔하게 정리했다."}
  ]'::jsonb),
  ('staple', 2, 10, '명사/동사', '[
    {"en":"She stapled the pages together.","ko":"그녀는 그 페이지들을 스테이플러로 고정했다."},
    {"en":"The office ran out of staples.","ko":"그 사무실은 스테이플러 심이 다 떨어졌다."},
    {"en":"Please staple your documents before submitting them.","ko":"제출하기 전에 서류를 스테이플러로 고정해주세요."}
  ]'::jsonb),
  ('confirm', 2, 10, '동사', '[
    {"en":"Please confirm your appointment by email.","ko":"이메일로 예약을 확인해주세요."},
    {"en":"She confirmed the meeting time with her manager.","ko":"그녀는 관리자와 회의 시간을 확인했다."},
    {"en":"The results confirmed our earlier prediction.","ko":"그 결과는 우리의 이전 예측을 확인해주었다."}
  ]'::jsonb),
  ('detail', 2, 10, '명사', '[
    {"en":"She explained the plan in detail.","ko":"그녀는 그 계획을 상세히 설명했다."},
    {"en":"Every detail of the event was carefully planned.","ko":"그 행사의 모든 세부 사항이 신중하게 계획되었다."},
    {"en":"Please check the details before signing.","ko":"서명하기 전에 세부 사항을 확인해주세요."}
  ]'::jsonb),
  ('classify', 2, 10, '동사', '[
    {"en":"The books are classified by subject.","ko":"그 책들은 주제별로 분류되어 있다."},
    {"en":"Scientists classify animals into different groups.","ko":"과학자들은 동물을 여러 집단으로 분류한다."},
    {"en":"She classified the documents by date.","ko":"그녀는 서류를 날짜별로 분류했다."}
  ]'::jsonb),
  ('document', 2, 10, '명사', '[
    {"en":"Please sign the document before Friday.","ko":"금요일 전에 그 문서에 서명해주세요."},
    {"en":"He kept all important documents in a folder.","ko":"그는 모든 중요한 문서를 폴더에 보관했다."},
    {"en":"The company requires official documents for the application.","ko":"그 회사는 지원을 위해 공식 문서를 요구한다."}
  ]'::jsonb),
  ('misplace', 2, 10, '동사', '[
    {"en":"She misplaced her keys again.","ko":"그녀는 열쇠를 또 잃어버렸다."},
    {"en":"He misplaced the important document somewhere in his office.","ko":"그는 그 중요한 서류를 사무실 어딘가에 잘못 두었다."},
    {"en":"I often misplace my glasses around the house.","ko":"나는 종종 집 안에서 안경을 잘못 둔다."}
  ]'::jsonb),
  ('procedure', 2, 10, '명사', '[
    {"en":"Follow the correct procedure to submit your form.","ko":"양식을 제출하려면 올바른 절차를 따르세요."},
    {"en":"The safety procedure must be followed carefully.","ko":"안전 절차는 신중하게 지켜져야 한다."},
    {"en":"She explained the procedure step by step.","ko":"그녀는 그 절차를 단계별로 설명했다."}
  ]'::jsonb),
  ('firm', 2, 10, '명사/형용사', '[
    {"en":"He works at a law firm downtown.","ko":"그는 시내에 있는 법률 회사에서 일한다."},
    {"en":"She gave a firm answer without hesitation.","ko":"그녀는 망설임 없이 확고한 대답을 했다."},
    {"en":"The firm hired ten new employees this year.","ko":"그 회사는 올해 열 명의 신입 직원을 채용했다."}
  ]'::jsonb),
  ('client', 2, 10, '명사', '[
    {"en":"The lawyer met with a new client this morning.","ko":"그 변호사는 오늘 아침 새 의뢰인을 만났다."},
    {"en":"She always listens carefully to her clients'' needs.","ko":"그녀는 항상 고객들의 요구를 주의 깊게 듣는다."},
    {"en":"The company values long-term relationships with its clients.","ko":"그 회사는 고객들과의 장기적인 관계를 중요시한다."}
  ]'::jsonb),
  ('frequent', 2, 10, '형용사', '[
    {"en":"Heavy traffic is a frequent problem in this city.","ko":"심한 교통 체증은 이 도시에서 흔한 문제이다."},
    {"en":"She makes frequent trips to the library.","ko":"그녀는 도서관에 자주 간다."},
    {"en":"Frequent breaks can improve concentration.","ko":"잦은 휴식은 집중력을 향상시킬 수 있다."}
  ]'::jsonb),
  ('commute', 2, 10, '동사', '[
    {"en":"He commutes to work by subway every day.","ko":"그는 매일 지하철로 통근한다."},
    {"en":"Commuting takes about an hour each way.","ko":"통근은 편도로 약 한 시간이 걸린다."},
    {"en":"She commutes between two cities for her job.","ko":"그녀는 직장 때문에 두 도시 사이를 통근한다."}
  ]'::jsonb),
  ('division', 2, 10, '명사', '[
    {"en":"He works in the marketing division.","ko":"그는 마케팅 부서에서 일한다."},
    {"en":"The division of labor increased efficiency.","ko":"노동의 분업은 효율성을 높였다."},
    {"en":"There was a division of opinion among the members.","ko":"회원들 사이에 의견의 분열이 있었다."}
  ]'::jsonb),
  ('notify', 2, 10, '동사', '[
    {"en":"The school will notify parents about the schedule change.","ko":"학교는 학부모들에게 일정 변경을 통지할 것이다."},
    {"en":"Please notify us if you cannot attend.","ko":"참석할 수 없으면 저희에게 알려주세요."},
    {"en":"She was notified of the results by email.","ko":"그녀는 이메일로 결과를 통지받았다."}
  ]'::jsonb),
  ('assign', 2, 10, '동사', '[
    {"en":"The teacher assigned homework for the weekend.","ko":"선생님은 주말 숙제를 내주었다."},
    {"en":"She was assigned to lead the new project.","ko":"그녀는 새 프로젝트를 이끌도록 임명되었다."},
    {"en":"Tasks were assigned to each team member.","ko":"각 팀원에게 업무가 할당되었다."}
  ]'::jsonb),
  ('booth', 2, 10, '명사', '[
    {"en":"The company set up a booth at the trade fair.","ko":"그 회사는 무역 박람회에 부스를 설치했다."},
    {"en":"Visitors gathered around the information booth.","ko":"방문객들이 안내 부스 주위에 모였다."},
    {"en":"She spoke to visitors from the booth all day.","ko":"그녀는 하루 종일 부스에서 방문객들과 이야기했다."}
  ]'::jsonb),
  ('brochure', 2, 10, '명사', '[
    {"en":"The travel brochure showed beautiful beach photos.","ko":"그 여행 안내 책자는 아름다운 해변 사진을 보여주었다."},
    {"en":"She picked up a brochure about the museum.","ko":"그녀는 그 박물관에 대한 안내 책자를 집었다."},
    {"en":"The company designed a new brochure for its products.","ko":"그 회사는 자사 제품을 위한 새 안내 책자를 디자인했다."}
  ]'::jsonb),
  ('distribute', 2, 10, '동사', '[
    {"en":"Volunteers distributed food to the flood victims.","ko":"자원봉사자들은 수해 피해자들에게 음식을 나눠주었다."},
    {"en":"The teacher distributed the test papers.","ko":"선생님은 시험지를 나눠주었다."},
    {"en":"The company distributes its products worldwide.","ko":"그 회사는 전 세계에 제품을 유통한다."}
  ]'::jsonb),
  ('make up for', 2, 10, '구동사', '[
    {"en":"He studied extra hours to make up for lost time.","ko":"그는 잃어버린 시간을 만회하기 위해 추가로 공부했다."},
    {"en":"She worked overtime to make up for her mistake.","ko":"그녀는 자신의 실수를 만회하기 위해 초과 근무를 했다."},
    {"en":"Nothing can make up for the missed opportunity.","ko":"그 놓친 기회를 만회할 수 있는 것은 없다."}
  ]'::jsonb),
  ('get ahead', 2, 10, '구동사', '[
    {"en":"She works hard to get ahead in her career.","ko":"그녀는 경력에서 성공하기 위해 열심히 일한다."},
    {"en":"He studies every night to get ahead of his classmates.","ko":"그는 반 친구들보다 앞서기 위해 매일 밤 공부한다."},
    {"en":"Good planning helps you get ahead at work.","ko":"좋은 계획은 직장에서 앞서 나가는 데 도움이 된다."}
  ]'::jsonb),
  ('take over', 2, 10, '구동사', '[
    {"en":"She will take over the project next week.","ko":"그녀는 다음 주에 그 프로젝트를 인계받을 것이다."},
    {"en":"He took over his father''s business.","ko":"그는 아버지의 사업을 물려받았다."},
    {"en":"The new manager took over all responsibilities smoothly.","ko":"새 관리자는 모든 책임을 순조롭게 인계받았다."}
  ]'::jsonb),
  ('report', 2, 11, '동사/명사', '[
    {"en":"The newspaper reported the story on the front page.","ko":"그 신문은 그 이야기를 1면에 보도했다."},
    {"en":"She wrote a detailed report on the survey results.","ko":"그녀는 설문 결과에 대한 상세한 보고서를 작성했다."},
    {"en":"Reporters reported live from the scene.","ko":"기자들은 현장에서 생방송으로 보도했다."}
  ]'::jsonb),
  ('press', 2, 11, '명사', '[
    {"en":"The press covered the event extensively.","ko":"언론은 그 행사를 광범위하게 다루었다."},
    {"en":"She works as a press officer for the government.","ko":"그녀는 정부의 언론 담당관으로 일한다."},
    {"en":"The new policy received criticism from the press.","ko":"그 새 정책은 언론으로부터 비판을 받았다."}
  ]'::jsonb),
  ('article', 2, 11, '명사', '[
    {"en":"She read an interesting article about climate change.","ko":"그녀는 기후 변화에 관한 흥미로운 기사를 읽었다."},
    {"en":"He wrote an article for the school newspaper.","ko":"그는 학교 신문에 기사를 썼다."},
    {"en":"The magazine published an article on healthy eating.","ko":"그 잡지는 건강한 식습관에 관한 기사를 실었다."}
  ]'::jsonb),
  ('journal', 2, 11, '명사', '[
    {"en":"The research was published in a scientific journal.","ko":"그 연구는 과학 학술지에 실렸다."},
    {"en":"She keeps a journal of her daily thoughts.","ko":"그녀는 일상적인 생각을 담은 일지를 쓴다."},
    {"en":"He subscribes to a weekly journal on technology.","ko":"그는 기술에 관한 주간 잡지를 구독한다."}
  ]'::jsonb),
  ('broadcast', 2, 11, '동사/명사', '[
    {"en":"The concert was broadcast live on television.","ko":"그 콘서트는 텔레비전으로 생중계되었다."},
    {"en":"The station broadcasts news every hour.","ko":"그 방송국은 매시간 뉴스를 방송한다."},
    {"en":"They watched the broadcast of the championship game.","ko":"그들은 챔피언십 경기의 방송을 시청했다."}
  ]'::jsonb),
  ('post', 2, 11, '동사/명사', '[
    {"en":"She posted a photo of her trip online.","ko":"그녀는 온라인에 여행 사진을 게시했다."},
    {"en":"The notice was posted on the school bulletin board.","ko":"그 공지는 학교 게시판에 게시되었다."},
    {"en":"His post received many comments.","ko":"그의 게시글은 많은 댓글을 받았다."}
  ]'::jsonb),
  ('pose', 2, 11, '동사/명사', '[
    {"en":"The students posed for a group photo.","ko":"학생들은 단체 사진을 위해 자세를 취했다."},
    {"en":"She struck a confident pose for the camera.","ko":"그녀는 카메라를 향해 자신감 있는 포즈를 취했다."},
    {"en":"He posed several questions during the meeting.","ko":"그는 회의 중에 몇 가지 질문을 제기했다."}
  ]'::jsonb),
  ('scene', 2, 11, '명사', '[
    {"en":"The final scene of the movie was very moving.","ko":"그 영화의 마지막 장면은 매우 감동적이었다."},
    {"en":"Police arrived quickly at the scene of the accident.","ko":"경찰은 그 사고 현장에 빠르게 도착했다."},
    {"en":"The play''s opening scene captured everyone''s attention.","ko":"그 연극의 첫 장면은 모두의 관심을 사로잡았다."}
  ]'::jsonb),
  ('survey', 2, 11, '명사/동사', '[
    {"en":"The survey showed that most students prefer online classes.","ko":"그 조사는 대부분의 학생들이 온라인 수업을 선호한다는 것을 보여주었다."},
    {"en":"Researchers surveyed hundreds of teenagers about their habits.","ko":"연구자들은 수백 명의 십 대들에게 그들의 습관에 대해 조사했다."},
    {"en":"She conducted a survey for her school project.","ko":"그녀는 학교 프로젝트를 위해 설문 조사를 실시했다."}
  ]'::jsonb),
  ('mass', 2, 11, '명사/형용사', '[
    {"en":"Mass media has a strong influence on society.","ko":"대중 매체는 사회에 강한 영향을 미친다."},
    {"en":"A mass of people gathered at the square.","ko":"많은 사람들이 광장에 모였다."},
    {"en":"The company launched a mass production line.","ko":"그 회사는 대량 생산 라인을 시작했다."}
  ]'::jsonb),
  ('factual', 2, 11, '형용사', '[
    {"en":"The article should be based on factual information.","ko":"그 기사는 사실에 근거해야 한다."},
    {"en":"Her report was accurate and factual.","ko":"그녀의 보고서는 정확하고 사실에 입각했다."},
    {"en":"News should remain factual rather than opinionated.","ko":"뉴스는 의견이 아니라 사실에 근거해야 한다."}
  ]'::jsonb),
  ('fame', 2, 11, '명사', '[
    {"en":"The singer gained fame after her first album.","ko":"그 가수는 첫 앨범 이후 명성을 얻었다."},
    {"en":"He achieved fame as a young scientist.","ko":"그는 젊은 과학자로 명성을 얻었다."},
    {"en":"Fame does not always bring happiness.","ko":"명성이 항상 행복을 가져다주는 것은 아니다."}
  ]'::jsonb),
  ('poll', 2, 11, '명사/동사', '[
    {"en":"The poll showed strong support for the new policy.","ko":"그 여론 조사는 새 정책에 대한 강한 지지를 보여주었다."},
    {"en":"Voters were polled outside the station.","ko":"투표소 밖에서 유권자들이 여론 조사를 받았다."},
    {"en":"A recent poll revealed changing public opinions.","ko":"최근의 여론 조사는 변화하는 대중의 의견을 보여주었다."}
  ]'::jsonb),
  ('channel', 2, 11, '명사', '[
    {"en":"She switched to a news channel.","ko":"그녀는 뉴스 채널로 채널을 바꾸었다."},
    {"en":"The documentary aired on an educational channel.","ko":"그 다큐멘터리는 교육 채널에서 방영되었다."},
    {"en":"He created his own video channel online.","ko":"그는 온라인에 자신의 비디오 채널을 만들었다."}
  ]'::jsonb),
  ('criticize', 2, 11, '동사', '[
    {"en":"Critics criticized the film for its weak story.","ko":"평론가들은 그 영화를 약한 줄거리 때문에 비판했다."},
    {"en":"She was criticized for making a hasty decision.","ko":"그녀는 성급한 결정을 내린 것에 대해 비판받았다."},
    {"en":"It is easy to criticize without offering solutions.","ko":"해결책을 제시하지 않고 비판하는 것은 쉽다."}
  ]'::jsonb),
  ('compliment', 2, 11, '명사/동사', '[
    {"en":"She received many compliments on her presentation.","ko":"그녀는 발표에 대해 많은 칭찬을 받았다."},
    {"en":"He complimented her on her excellent work.","ko":"그는 그녀의 훌륭한 작업을 칭찬했다."},
    {"en":"A sincere compliment can brighten someone''s day.","ko":"진심 어린 칭찬은 누군가의 하루를 밝게 해줄 수 있다."}
  ]'::jsonb),
  ('series', 2, 11, '명사', '[
    {"en":"She watched an entire series over the weekend.","ko":"그녀는 주말 동안 한 시리즈 전체를 시청했다."},
    {"en":"The museum held a series of lectures on history.","ko":"그 박물관은 역사에 관한 일련의 강연을 열었다."},
    {"en":"A new documentary series will begin next month.","ko":"새로운 다큐멘터리 시리즈가 다음 달에 시작될 것이다."}
  ]'::jsonb),
  ('feature', 2, 11, '명사/동사', '[
    {"en":"The magazine ran a special feature on young artists.","ko":"그 잡지는 젊은 예술가들에 관한 특집 기사를 실었다."},
    {"en":"One key feature of the phone is its long battery life.","ko":"그 휴대폰의 주요 특징 중 하나는 긴 배터리 수명이다."},
    {"en":"The newspaper featured a story about local heroes.","ko":"그 신문은 지역 영웅들에 관한 이야기를 대서특필했다."}
  ]'::jsonb),
  ('script', 2, 11, '명사', '[
    {"en":"The actor memorized the entire script.","ko":"그 배우는 대본 전체를 암기했다."},
    {"en":"She wrote the script for the school play.","ko":"그녀는 학교 연극의 대본을 썼다."},
    {"en":"The director revised the script before filming.","ko":"그 감독은 촬영 전에 대본을 수정했다."}
  ]'::jsonb),
  ('bulletin', 2, 11, '명사', '[
    {"en":"A weather bulletin warned of heavy rain.","ko":"기상 속보는 폭우를 경고했다."},
    {"en":"The news bulletin interrupted the regular program.","ko":"그 뉴스 속보는 정규 방송을 중단시켰다."},
    {"en":"The school posted a bulletin about the holiday schedule.","ko":"학교는 휴일 일정에 관한 게시문을 붙였다."}
  ]'::jsonb),
  ('preview', 2, 11, '명사/동사', '[
    {"en":"We watched a preview of the new movie.","ko":"우리는 새 영화의 예고편을 보았다."},
    {"en":"The teacher asked students to preview the chapter.","ko":"선생님은 학생들에게 그 단원을 예습하라고 했다."},
    {"en":"Critics attended the film''s preview last night.","ko":"평론가들은 어젯밤 그 영화의 시사회에 참석했다."}
  ]'::jsonb),
  ('column', 2, 11, '명사', '[
    {"en":"She writes a weekly column for the local newspaper.","ko":"그녀는 지역 신문에 주간 칼럼을 쓴다."},
    {"en":"His column focuses on environmental issues.","ko":"그의 칼럼은 환경 문제에 초점을 맞춘다."},
    {"en":"The opinion column sparked a lot of discussion.","ko":"그 오피니언 칼럼은 많은 논의를 불러일으켰다."}
  ]'::jsonb),
  ('release', 2, 11, '동사/명사', '[
    {"en":"The band released a new album last week.","ko":"그 밴드는 지난주에 새 앨범을 발매했다."},
    {"en":"The company will release the results tomorrow.","ko":"그 회사는 내일 결과를 발표할 것이다."},
    {"en":"The movie''s release was delayed by a month.","ko":"그 영화의 개봉은 한 달 연기되었다."}
  ]'::jsonb),
  ('announce', 2, 11, '동사', '[
    {"en":"The teacher announced the exam schedule.","ko":"선생님은 시험 일정을 공지했다."},
    {"en":"The company announced its new product yesterday.","ko":"그 회사는 어제 신제품을 발표했다."},
    {"en":"They announced the winner of the contest.","ko":"그들은 그 대회의 우승자를 발표했다."}
  ]'::jsonb),
  ('reveal', 2, 11, '동사', '[
    {"en":"The survey revealed surprising results.","ko":"그 조사는 놀라운 결과를 드러냈다."},
    {"en":"She revealed her plan during the meeting.","ko":"그녀는 회의 중에 자신의 계획을 밝혔다."},
    {"en":"The report reveals a growing interest in science.","ko":"그 보고서는 과학에 대한 관심이 커지고 있음을 드러낸다."}
  ]'::jsonb),
  ('audience', 2, 11, '명사', '[
    {"en":"The audience applauded loudly after the performance.","ko":"청중은 공연 후 큰 박수를 보냈다."},
    {"en":"The speaker addressed a large audience.","ko":"그 연설자는 많은 청중에게 연설했다."},
    {"en":"The show attracted a young audience.","ko":"그 프로그램은 젊은 시청자들을 끌어들였다."}
  ]'::jsonb),
  ('panel', 2, 11, '명사', '[
    {"en":"A panel of experts discussed the new policy.","ko":"전문가 패널이 새 정책에 대해 토론했다."},
    {"en":"She was invited to join the discussion panel.","ko":"그녀는 그 토론 패널에 참여하도록 초대받았다."},
    {"en":"The panel answered questions from the audience.","ko":"그 패널은 청중의 질문에 답했다."}
  ]'::jsonb),
  ('focus', 2, 11, '동사/명사', '[
    {"en":"Please focus on your studies this semester.","ko":"이번 학기에는 공부에 집중해주세요."},
    {"en":"The article focuses on climate change solutions.","ko":"그 기사는 기후 변화 해결책에 초점을 맞춘다."},
    {"en":"Her main focus is improving public health.","ko":"그녀의 주요 관심사는 공공 보건 개선이다."}
  ]'::jsonb),
  ('argue over', 2, 11, '구동사', '[
    {"en":"The two students argued over the correct answer.","ko":"두 학생은 정답을 두고 논쟁했다."},
    {"en":"They argued over who should lead the project.","ko":"그들은 누가 그 프로젝트를 이끌어야 하는지를 두고 논쟁했다."},
    {"en":"Neighbors sometimes argue over small matters.","ko":"이웃들은 때때로 사소한 일로 논쟁한다."}
  ]'::jsonb),
  ('come up with', 2, 11, '구동사', '[
    {"en":"She came up with a creative idea for the project.","ko":"그녀는 그 프로젝트를 위한 창의적인 아이디어를 생각해 냈다."},
    {"en":"The team came up with a new solution to the problem.","ko":"그 팀은 그 문제에 대한 새로운 해결책을 생각해 냈다."},
    {"en":"He could not come up with a good excuse.","ko":"그는 좋은 변명을 생각해 내지 못했다."}
  ]'::jsonb),
  ('variety', 2, 12, '명사', '[
    {"en":"The store offers a wide variety of products.","ko":"그 가게는 매우 다양한 제품을 제공한다."},
    {"en":"She enjoys a variety of hobbies.","ko":"그녀는 다양한 취미를 즐긴다."},
    {"en":"A variety of opinions were shared during the discussion.","ko":"그 토론 동안 다양한 의견이 공유되었다."}
  ]'::jsonb),
  ('square', 2, 12, '명사/형용사', '[
    {"en":"The park is located in the town square.","ko":"그 공원은 마을 광장에 위치해 있다."},
    {"en":"The table has a square shape.","ko":"그 탁자는 정사각형 모양이다."},
    {"en":"She drew a square on the paper.","ko":"그녀는 종이에 정사각형을 그렸다."}
  ]'::jsonb),
  ('delicate', 2, 12, '형용사', '[
    {"en":"The vase is delicate and easily broken.","ko":"그 꽃병은 연약해서 쉽게 깨진다."},
    {"en":"She has a delicate sense of color.","ko":"그녀는 섬세한 색감을 가지고 있다."},
    {"en":"Handle the flowers carefully because they are delicate.","ko":"그 꽃들은 연약하니 조심스럽게 다루세요."}
  ]'::jsonb),
  ('flat', 2, 12, '형용사', '[
    {"en":"The land here is flat and easy to walk on.","ko":"이곳의 땅은 평평해서 걷기 쉽다."},
    {"en":"She lives in a small flat in London.","ko":"그녀는 런던의 작은 아파트에 산다."},
    {"en":"The road became flat after the hill.","ko":"그 도로는 언덕을 지난 후 평평해졌다."}
  ]'::jsonb),
  ('broad', 2, 12, '형용사', '[
    {"en":"The teacher has broad knowledge of history.","ko":"그 선생님은 역사에 대한 폭넓은 지식을 가지고 있다."},
    {"en":"The bridge spans a broad river.","ko":"그 다리는 폭이 넓은 강을 가로지른다."},
    {"en":"The topic covers a broad range of issues.","ko":"그 주제는 광범위한 문제를 다룬다."}
  ]'::jsonb),
  ('compact', 2, 12, '형용사', '[
    {"en":"She bought a compact car for the city.","ko":"그녀는 도시용으로 소형차를 샀다."},
    {"en":"The kitchen is compact but well organized.","ko":"그 부엌은 작지만 잘 정리되어 있다."},
    {"en":"This compact device can store many files.","ko":"이 소형 장치는 많은 파일을 저장할 수 있다."}
  ]'::jsonb),
  ('brief', 2, 12, '형용사', '[
    {"en":"She gave a brief summary of the report.","ko":"그녀는 그 보고서에 대한 간단한 요약을 했다."},
    {"en":"The meeting was brief but productive.","ko":"그 회의는 짧았지만 생산적이었다."},
    {"en":"He wrote a brief message before leaving.","ko":"그는 떠나기 전에 짧은 메시지를 남겼다."}
  ]'::jsonb),
  ('sharp', 2, 12, '형용사', '[
    {"en":"Be careful with the sharp knife.","ko":"그 날카로운 칼을 조심하세요."},
    {"en":"There was a sharp increase in prices.","ko":"가격에 급격한 상승이 있었다."},
    {"en":"She has a sharp memory for details.","ko":"그녀는 세부 사항에 대해 예리한 기억력을 가지고 있다."}
  ]'::jsonb),
  ('precious', 2, 12, '형용사', '[
    {"en":"Time with family is precious to her.","ko":"가족과 함께하는 시간은 그녀에게 소중하다."},
    {"en":"The necklace is made of precious stones.","ko":"그 목걸이는 귀중한 보석으로 만들어졌다."},
    {"en":"Every precious moment should be cherished.","ko":"모든 소중한 순간은 소중히 여겨져야 한다."}
  ]'::jsonb),
  ('artificial', 2, 12, '형용사', '[
    {"en":"The lake was created by artificial means.","ko":"그 호수는 인공적인 방법으로 만들어졌다."},
    {"en":"Artificial lighting was used in the studio.","ko":"그 스튜디오에서는 인공 조명이 사용되었다."},
    {"en":"The drink contains no artificial flavors.","ko":"그 음료는 인공 향료를 포함하지 않는다."}
  ]'::jsonb),
  ('gigantic', 2, 12, '형용사', '[
    {"en":"A gigantic statue stood at the entrance.","ko":"거대한 조각상이 입구에 서 있었다."},
    {"en":"The company built a gigantic factory.","ko":"그 회사는 거대한 공장을 지었다."},
    {"en":"They were amazed by the gigantic waves.","ko":"그들은 그 거대한 파도에 놀랐다."}
  ]'::jsonb),
  ('enormous', 2, 12, '형용사', '[
    {"en":"The project required an enormous amount of effort.","ko":"그 프로젝트는 엄청난 양의 노력을 필요로 했다."},
    {"en":"She felt enormous relief after the exam.","ko":"그녀는 시험 후 엄청난 안도감을 느꼈다."},
    {"en":"The company made enormous profits last year.","ko":"그 회사는 작년에 엄청난 이익을 냈다."}
  ]'::jsonb),
  ('ultimate', 2, 12, '형용사', '[
    {"en":"Her ultimate goal is to become a doctor.","ko":"그녀의 궁극적인 목표는 의사가 되는 것이다."},
    {"en":"The ultimate decision rests with the manager.","ko":"최종 결정은 관리자에게 달려 있다."},
    {"en":"Winning the championship was the team''s ultimate dream.","ko":"챔피언십에서 우승하는 것이 그 팀의 궁극적인 꿈이었다."}
  ]'::jsonb),
  ('faint', 2, 12, '형용사/동사', '[
    {"en":"A faint light appeared in the distance.","ko":"멀리서 희미한 빛이 나타났다."},
    {"en":"She heard a faint sound from the next room.","ko":"그녀는 옆방에서 희미한 소리를 들었다."},
    {"en":"He almost fainted from the heat.","ko":"그는 더위 때문에 거의 기절할 뻔했다."}
  ]'::jsonb),
  ('steep', 2, 12, '형용사', '[
    {"en":"The path up the mountain was very steep.","ko":"그 산길은 매우 가팔랐다."},
    {"en":"There was a steep increase in energy costs.","ko":"에너지 비용에 급격한 상승이 있었다."},
    {"en":"The steep stairs made climbing difficult.","ko":"그 가파른 계단은 오르기 어렵게 만들었다."}
  ]'::jsonb),
  ('fundamental', 2, 12, '형용사/명사', '[
    {"en":"Reading is a fundamental skill for learning.","ko":"읽기는 학습을 위한 기본적인 기술이다."},
    {"en":"The two theories differ in a fundamental way.","ko":"그 두 이론은 근본적으로 다르다."},
    {"en":"Understanding the fundamentals is important before advanced study.","ko":"심화 학습 전에 기본을 이해하는 것이 중요하다."}
  ]'::jsonb),
  ('shallow', 2, 12, '형용사', '[
    {"en":"Children played in the shallow part of the pool.","ko":"아이들은 수영장의 얕은 부분에서 놀았다."},
    {"en":"The river becomes shallow near the shore.","ko":"그 강은 해안 근처에서 얕아진다."},
    {"en":"A shallow pond is safer for young swimmers.","ko":"얕은 연못이 어린 수영객들에게 더 안전하다."}
  ]'::jsonb),
  ('symbolic', 2, 12, '형용사', '[
    {"en":"The dove is symbolic of peace.","ko":"비둘기는 평화의 상징이다."},
    {"en":"The ceremony had great symbolic meaning.","ko":"그 의식은 큰 상징적 의미를 지녔다."},
    {"en":"Her gesture was symbolic of unity.","ko":"그녀의 몸짓은 단합을 상징했다."}
  ]'::jsonb),
  ('appropriate', 2, 12, '형용사', '[
    {"en":"Please wear appropriate clothes for the interview.","ko":"면접에 적합한 옷을 입어주세요."},
    {"en":"This book is appropriate for young readers.","ko":"이 책은 어린 독자들에게 적합하다."},
    {"en":"It is important to use appropriate language in class.","ko":"수업에서 적절한 언어를 사용하는 것이 중요하다."}
  ]'::jsonb),
  ('moderate', 2, 12, '형용사', '[
    {"en":"The weather today is moderate, neither too hot nor too cold.","ko":"오늘 날씨는 너무 덥지도 춥지도 않고 적당하다."},
    {"en":"She takes a moderate approach to spending.","ko":"그녀는 지출에 있어 적당한 접근 방식을 취한다."},
    {"en":"Moderate exercise can improve your health.","ko":"적당한 운동은 건강을 개선할 수 있다."}
  ]'::jsonb),
  ('flexible', 2, 12, '형용사', '[
    {"en":"The schedule is flexible, so you can choose your hours.","ko":"그 일정은 유연해서 시간을 선택할 수 있다."},
    {"en":"A flexible mind can adapt to new situations.","ko":"유연한 사고방식은 새로운 상황에 적응할 수 있다."},
    {"en":"The material is soft and flexible.","ko":"그 재료는 부드럽고 유연하다."}
  ]'::jsonb),
  ('monotonous', 2, 12, '형용사', '[
    {"en":"The lecture was monotonous and hard to focus on.","ko":"그 강의는 단조로워서 집중하기 어려웠다."},
    {"en":"Doing the same task every day can feel monotonous.","ko":"매일 같은 일을 하는 것은 단조롭게 느껴질 수 있다."},
    {"en":"She tried to make the routine less monotonous.","ko":"그녀는 그 일과를 덜 단조롭게 만들려고 노력했다."}
  ]'::jsonb),
  ('obscure', 2, 12, '형용사', '[
    {"en":"The instructions were obscure and confusing.","ko":"그 지시 사항은 애매하고 혼란스러웠다."},
    {"en":"He referred to an obscure fact from history.","ko":"그는 역사에서 잘 알려지지 않은 사실을 언급했다."},
    {"en":"The meaning of the poem remains obscure to many readers.","ko":"그 시의 의미는 많은 독자들에게 여전히 애매하다."}
  ]'::jsonb),
  ('drawback', 2, 12, '명사', '[
    {"en":"The plan has one major drawback: it is expensive.","ko":"그 계획에는 한 가지 큰 단점이 있는데, 바로 비용이 많이 든다는 것이다."},
    {"en":"Every option has its advantages and drawbacks.","ko":"모든 선택지에는 장점과 단점이 있다."},
    {"en":"The main drawback of the device is its short battery life.","ko":"그 기기의 주요 단점은 짧은 배터리 수명이다."}
  ]'::jsonb),
  ('paradox', 2, 12, '명사', '[
    {"en":"It is a paradox that working less can increase productivity.","ko":"적게 일하는 것이 생산성을 높일 수 있다는 것은 역설이다."},
    {"en":"The story presents an interesting paradox.","ko":"그 이야기는 흥미로운 역설을 제시한다."},
    {"en":"Scientists often encounter paradoxes in their research.","ko":"과학자들은 연구 중에 종종 역설과 마주친다."}
  ]'::jsonb),
  ('describe', 2, 12, '동사', '[
    {"en":"Can you describe what happened in detail?","ko":"무슨 일이 있었는지 자세히 설명해 줄 수 있나요?"},
    {"en":"The author describes the scenery beautifully.","ko":"그 작가는 풍경을 아름답게 묘사한다."},
    {"en":"She described her feelings honestly in the letter.","ko":"그녀는 편지에서 자신의 감정을 솔직하게 묘사했다."}
  ]'::jsonb),
  ('marvel', 2, 12, '동사/명사', '[
    {"en":"Visitors marveled at the ancient architecture.","ko":"방문객들은 그 고대 건축물에 감탄했다."},
    {"en":"The new bridge is a marvel of engineering.","ko":"그 새 다리는 공학의 경이로움이다."},
    {"en":"She marveled at how quickly the seasons changed.","ko":"그녀는 계절이 얼마나 빨리 바뀌는지에 감탄했다."}
  ]'::jsonb),
  ('glitter', 2, 12, '동사/명사', '[
    {"en":"The stars glittered in the night sky.","ko":"별들이 밤하늘에서 반짝였다."},
    {"en":"Snow glittered under the sunlight.","ko":"눈이 햇빛 아래 반짝였다."},
    {"en":"The glitter of the city lights amazed the tourists.","ko":"그 도시 불빛의 반짝임은 관광객들을 놀라게 했다."}
  ]'::jsonb),
  ('differ from', 2, 12, '구동사', '[
    {"en":"His opinion differs from mine.","ko":"그의 의견은 나의 의견과 다르다."},
    {"en":"This version differs from the original in several ways.","ko":"이 버전은 여러 면에서 원본과 다르다."},
    {"en":"Cultures differ from country to country.","ko":"문화는 나라마다 다르다."}
  ]'::jsonb),
  ('stand for', 2, 12, '구동사', '[
    {"en":"The letters UN stand for United Nations.","ko":"UN이라는 글자는 국제연합을 상징한다."},
    {"en":"This symbol stands for peace.","ko":"이 상징은 평화를 나타낸다."},
    {"en":"She stands for honesty and fairness.","ko":"그녀는 정직함과 공정함을 옹호한다."}
  ]'::jsonb)
) as t(word, level, study_day, pos, examples)
where v.word = t.word and v.level = t.level and v.study_day = t.study_day;
