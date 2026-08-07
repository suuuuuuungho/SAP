-- SAP 1기 대시보드: Study 탭 — Lv.1(중등 실력) Day 37~40 품사/예문 채우기 (120단어, 마지막 배치).
update public.vocab_words v
set part_of_speech = t.pos, example_sentences = t.examples, updated_at = now()
from (values
  ('value', 1, 37, '명사/동사', '[
    {"en":"Honesty is an important value in our family.","ko":"정직은 우리 가족에게 중요한 가치이다."},
    {"en":"We should value our time with friends.","ko":"우리는 친구들과 보내는 시간을 소중히 여겨야 한다."},
    {"en":"The old book has great value to my grandfather.","ko":"그 오래된 책은 할아버지에게 큰 가치가 있다."}
  ]'::jsonb),
  ('local', 1, 37, '형용사', '[
    {"en":"We often shop at the local market on weekends.","ko":"우리는 주말마다 지역 시장에서 자주 쇼핑한다."},
    {"en":"The local library holds a book fair every spring.","ko":"지역 도서관은 매년 봄에 도서 전시회를 연다."},
    {"en":"My uncle works for a local newspaper.","ko":"삼촌은 지역 신문사에서 일하신다."}
  ]'::jsonb),
  ('crowd', 1, 37, '명사', '[
    {"en":"A large crowd gathered to watch the school festival.","ko":"많은 군중이 학교 축제를 보기 위해 모였다."},
    {"en":"She got lost in the crowd at the concert.","ko":"그녀는 콘서트에서 군중 속에서 길을 잃었다."},
    {"en":"The crowd cheered when the team scored a goal.","ko":"팀이 골을 넣자 군중이 환호했다."}
  ]'::jsonb),
  ('debt', 1, 37, '명사', '[
    {"en":"My father paid off his debt last year.","ko":"아버지는 작년에 빚을 다 갚으셨다."},
    {"en":"It is important to avoid unnecessary debt.","ko":"불필요한 빚을 피하는 것이 중요하다."},
    {"en":"The company reduced its debt by saving money.","ko":"그 회사는 돈을 절약해서 부채를 줄였다."}
  ]'::jsonb),
  ('salary', 1, 37, '명사', '[
    {"en":"My mother receives her salary at the end of the month.","ko":"어머니는 매달 말에 급여를 받으신다."},
    {"en":"He saves part of his salary every month.","ko":"그는 매달 급여의 일부를 저축한다."},
    {"en":"The new job offers a higher salary.","ko":"그 새 일자리는 더 높은 급여를 제공한다."}
  ]'::jsonb),
  ('invest', 1, 37, '동사', '[
    {"en":"Many people invest in stocks to save for the future.","ko":"많은 사람들이 미래를 위해 주식에 투자한다."},
    {"en":"The school invested in new computers for students.","ko":"학교는 학생들을 위해 새 컴퓨터에 투자했다."},
    {"en":"She decided to invest her time in learning music.","ko":"그녀는 음악을 배우는 데 시간을 투자하기로 했다."}
  ]'::jsonb),
  ('duty', 1, 37, '명사', '[
    {"en":"It is our duty to keep the classroom clean.","ko":"교실을 깨끗하게 유지하는 것은 우리의 의무이다."},
    {"en":"The soldier performed his duty with pride.","ko":"그 군인은 자랑스럽게 임무를 수행했다."},
    {"en":"Travelers must pay duty on some imported goods.","ko":"여행자들은 일부 수입 물품에 세금을 내야 한다."}
  ]'::jsonb),
  ('status', 1, 37, '명사', '[
    {"en":"He checked the status of his online order.","ko":"그는 온라인 주문의 상태를 확인했다."},
    {"en":"Her social status changed after she became a doctor.","ko":"그녀는 의사가 된 후 사회적 지위가 바뀌었다."},
    {"en":"The teacher explained the current status of the project.","ko":"선생님은 프로젝트의 현재 상태를 설명하셨다."}
  ]'::jsonb),
  ('culture', 1, 37, '명사', '[
    {"en":"We learned about Korean culture in social studies class.","ko":"우리는 사회 시간에 한국 문화에 대해 배웠다."},
    {"en":"Every country has its own unique culture.","ko":"모든 나라는 저마다 독특한 문화를 가지고 있다."},
    {"en":"The museum shows the history of local culture.","ko":"그 박물관은 지역 문화의 역사를 보여 준다."}
  ]'::jsonb),
  ('citizen', 1, 37, '명사', '[
    {"en":"Every citizen has the right to vote.","ko":"모든 시민은 투표할 권리가 있다."},
    {"en":"Good citizens follow the rules of their community.","ko":"좋은 시민은 지역 사회의 규칙을 따른다."},
    {"en":"She became a citizen of Canada last year.","ko":"그녀는 작년에 캐나다 시민이 되었다."}
  ]'::jsonb),
  ('public', 1, 37, '형용사', '[
    {"en":"The park is open to the public every day.","ko":"그 공원은 매일 대중에게 개방되어 있다."},
    {"en":"We take the public bus to school.","ko":"우리는 학교에 공공 버스를 타고 간다."},
    {"en":"The mayor gave a public speech about the new library.","ko":"시장은 새 도서관에 대해 공개 연설을 했다."}
  ]'::jsonb),
  ('supply', 1, 37, '명사/동사', '[
    {"en":"The store has a large supply of school notebooks.","ko":"그 가게는 학교 공책을 많이 공급받고 있다."},
    {"en":"Farmers supply fresh vegetables to the market.","ko":"농부들은 시장에 신선한 채소를 공급한다."},
    {"en":"The city increased its water supply during summer.","ko":"그 도시는 여름 동안 물 공급을 늘렸다."}
  ]'::jsonb),
  ('demand', 1, 37, '명사/동사', '[
    {"en":"There is a high demand for fresh fruit in summer.","ko":"여름에는 신선한 과일에 대한 수요가 높다."},
    {"en":"The students demanded more time to finish the test.","ko":"학생들은 시험을 끝낼 시간을 더 요구했다."},
    {"en":"Demand for bicycles rises every spring.","ko":"봄마다 자전거에 대한 수요가 늘어난다."}
  ]'::jsonb),
  ('import', 1, 37, '명사/동사', '[
    {"en":"Korea imports a lot of oil from other countries.","ko":"한국은 다른 나라에서 많은 석유를 수입한다."},
    {"en":"The store sells imported chocolate from Europe.","ko":"그 가게는 유럽에서 수입한 초콜릿을 판다."},
    {"en":"The import of fresh fruit increased this year.","ko":"올해 신선한 과일 수입이 증가했다."}
  ]'::jsonb),
  ('export', 1, 37, '명사/동사', '[
    {"en":"Korea exports many cars to other countries.","ko":"한국은 다른 나라들로 많은 자동차를 수출한다."},
    {"en":"The farm exports rice to nearby regions.","ko":"그 농장은 인근 지역으로 쌀을 수출한다."},
    {"en":"The export of electronics grew rapidly last year.","ko":"작년에 전자 제품 수출이 빠르게 증가했다."}
  ]'::jsonb),
  ('account', 1, 37, '명사', '[
    {"en":"I opened a bank account to save my allowance.","ko":"나는 용돈을 저축하기 위해 은행 계좌를 개설했다."},
    {"en":"She checks her account balance every week.","ko":"그녀는 매주 계좌 잔액을 확인한다."},
    {"en":"My parents helped me set up a savings account.","ko":"부모님은 내가 저축 계좌를 만드는 것을 도와주셨다."}
  ]'::jsonb),
  ('employ', 1, 37, '동사', '[
    {"en":"The restaurant employs many students during vacation.","ko":"그 식당은 방학 동안 많은 학생들을 고용한다."},
    {"en":"The company decided to employ more workers.","ko":"그 회사는 더 많은 직원을 고용하기로 했다."},
    {"en":"My father''s company employs about two hundred people.","ko":"아버지의 회사는 약 200명을 고용하고 있다."}
  ]'::jsonb),
  ('individual', 1, 37, '명사/형용사', '[
    {"en":"Each individual in our class has a different talent.","ko":"우리 반의 각 개인은 저마다 다른 재능을 가지고 있다."},
    {"en":"The teacher gave us individual feedback on our essays.","ko":"선생님은 우리에게 개별 피드백을 주셨다."},
    {"en":"Every individual has the right to express an opinion.","ko":"모든 개인은 의견을 표현할 권리가 있다."}
  ]'::jsonb),
  ('relationship', 1, 37, '명사', '[
    {"en":"She has a close relationship with her sister.","ko":"그녀는 언니와 가까운 관계를 맺고 있다."},
    {"en":"Good communication builds a strong relationship.","ko":"좋은 의사소통은 튼튼한 관계를 만든다."},
    {"en":"Our class studied the relationship between plants and sunlight.","ko":"우리 반은 식물과 햇빛의 관계를 공부했다."}
  ]'::jsonb),
  ('tradition', 1, 37, '명사', '[
    {"en":"It is a family tradition to visit grandparents on holidays.","ko":"명절에 조부모님을 방문하는 것은 가족의 전통이다."},
    {"en":"Many countries have unique traditions for New Year''s Day.","ko":"많은 나라들은 새해 첫날을 위한 독특한 전통을 가지고 있다."},
    {"en":"Students learned about the tradition of tea ceremony.","ko":"학생들은 다도의 전통에 대해 배웠다."}
  ]'::jsonb),
  ('consumer', 1, 37, '명사', '[
    {"en":"Consumers can choose from many kinds of products.","ko":"소비자들은 여러 종류의 제품 중에서 선택할 수 있다."},
    {"en":"The company asked consumers what they wanted.","ko":"그 회사는 소비자들에게 무엇을 원하는지 물었다."},
    {"en":"Smart consumers compare prices before buying.","ko":"현명한 소비자는 사기 전에 가격을 비교한다."}
  ]'::jsonb),
  ('responsibility', 1, 37, '명사', '[
    {"en":"Cleaning the classroom is our responsibility.","ko":"교실을 청소하는 것은 우리의 책임이다."},
    {"en":"Taking care of a pet is a big responsibility.","ko":"애완동물을 돌보는 것은 큰 책임이다."},
    {"en":"Each student has a responsibility to finish homework.","ko":"각 학생은 숙제를 끝낼 책임이 있다."}
  ]'::jsonb),
  ('influence', 1, 37, '명사/동사', '[
    {"en":"Good friends can have a positive influence on us.","ko":"좋은 친구들은 우리에게 긍정적인 영향을 줄 수 있다."},
    {"en":"Weather can influence how we feel.","ko":"날씨는 우리의 기분에 영향을 줄 수 있다."},
    {"en":"Her teacher had a great influence on her life.","ko":"그녀의 선생님은 그녀의 삶에 큰 영향을 주었다."}
  ]'::jsonb),
  ('obstacle', 1, 37, '명사', '[
    {"en":"She overcame every obstacle to finish the race.","ko":"그녀는 경주를 끝내기 위해 모든 장애물을 극복했다."},
    {"en":"Lack of time was a big obstacle for the project.","ko":"시간 부족은 그 프로젝트의 큰 장애물이었다."},
    {"en":"The hikers removed the obstacle blocking the trail.","ko":"등산객들은 길을 막고 있던 장애물을 치웠다."}
  ]'::jsonb),
  ('property', 1, 37, '명사', '[
    {"en":"Please take care of school property.","ko":"학교 재산을 소중히 다루어 주세요."},
    {"en":"The lost bag was returned to its owner''s property.","ko":"잃어버린 가방이 주인의 소유물로 돌아왔다."},
    {"en":"The family sold their old property in the countryside.","ko":"그 가족은 시골에 있는 오래된 재산을 팔았다."}
  ]'::jsonb),
  ('moral', 1, 37, '명사/형용사', '[
    {"en":"The story teaches a good moral about honesty.","ko":"그 이야기는 정직에 관한 좋은 교훈을 가르쳐 준다."},
    {"en":"It is important to make moral choices.","ko":"도덕적인 선택을 하는 것은 중요하다."},
    {"en":"Our teacher talked about moral values in class.","ko":"선생님은 수업 시간에 도덕적 가치에 대해 말씀하셨다."}
  ]'::jsonb),
  ('donate', 1, 37, '동사', '[
    {"en":"We donated our old clothes to charity.","ko":"우리는 헌 옷을 자선단체에 기부했다."},
    {"en":"Students donated books to the school library.","ko":"학생들은 학교 도서관에 책을 기부했다."},
    {"en":"My family donates money to help sick children every year.","ko":"우리 가족은 매년 아픈 아이들을 돕기 위해 돈을 기부한다."}
  ]'::jsonb),
  ('predict', 1, 37, '동사', '[
    {"en":"The weather forecaster predicted rain for tomorrow.","ko":"기상 캐스터는 내일 비가 올 것이라고 예측했다."},
    {"en":"No one can predict exactly what will happen.","ko":"누구도 정확히 무슨 일이 일어날지 예측할 수 없다."},
    {"en":"Scientists try to predict future climate changes.","ko":"과학자들은 미래의 기후 변화를 예측하려고 노력한다."}
  ]'::jsonb),
  ('show off', 1, 37, '동사구', '[
    {"en":"He likes to show off his new bicycle.","ko":"그는 새 자전거를 자랑하는 것을 좋아한다."},
    {"en":"She showed off her painting to her classmates.","ko":"그녀는 반 친구들에게 자신의 그림을 자랑했다."},
    {"en":"Don''t show off too much in front of your friends.","ko":"친구들 앞에서 너무 자랑하지 마라."}
  ]'::jsonb),
  ('look for', 1, 37, '동사구', '[
    {"en":"I am looking for my lost pencil case.","ko":"나는 잃어버린 필통을 찾고 있다."},
    {"en":"We looked for a good restaurant near the station.","ko":"우리는 역 근처에서 좋은 식당을 찾았다."},
    {"en":"She is looking for a part-time job this summer.","ko":"그녀는 이번 여름에 아르바이트 자리를 구하고 있다."}
  ]'::jsonb),
  ('vote', 1, 38, '명사/동사', '[
    {"en":"We voted for our class president this morning.","ko":"우리는 오늘 아침에 반장 선거에 투표했다."},
    {"en":"Every member gets one vote in the club.","ko":"동아리에서는 회원마다 한 표씩 투표권을 갖는다."},
    {"en":"Citizens vote to choose their leaders.","ko":"시민들은 지도자를 선택하기 위해 투표한다."}
  ]'::jsonb),
  ('party', 1, 38, '명사', '[
    {"en":"The two political parties disagreed about the new policy.","ko":"두 정당은 새 정책에 대해 의견이 달랐다."},
    {"en":"He joined a political party after college.","ko":"그는 대학교를 졸업한 후 정당에 가입했다."},
    {"en":"Each party presented its plan to the citizens.","ko":"각 정당은 시민들에게 자신들의 계획을 제시했다."}
  ]'::jsonb),
  ('gap', 1, 38, '명사', '[
    {"en":"There is a large gap between the two test scores.","ko":"두 시험 점수 사이에 큰 차이가 있다."},
    {"en":"The teacher tried to close the gap between students.","ko":"선생님은 학생들 간의 격차를 줄이려고 노력했다."},
    {"en":"A generation gap can make communication difficult.","ko":"세대 차이는 의사소통을 어렵게 만들 수 있다."}
  ]'::jsonb),
  ('justice', 1, 38, '명사', '[
    {"en":"We learned about justice and fairness in social studies.","ko":"우리는 사회 시간에 정의와 공정함에 대해 배웠다."},
    {"en":"The judge worked hard to bring justice to the case.","ko":"그 판사는 사건에 정의를 실현하기 위해 노력했다."},
    {"en":"Justice means treating everyone fairly.","ko":"정의는 모든 사람을 공정하게 대하는 것을 의미한다."}
  ]'::jsonb),
  ('crime', 1, 38, '명사', '[
    {"en":"Our town has a very low crime rate.","ko":"우리 마을은 범죄율이 매우 낮다."},
    {"en":"The city installed cameras to prevent crime.","ko":"그 도시는 범죄를 예방하기 위해 카메라를 설치했다."},
    {"en":"Students discussed ways to reduce crime in the community.","ko":"학생들은 지역 사회의 범죄를 줄이는 방법을 논의했다."}
  ]'::jsonb),
  ('murder', 1, 38, '명사', '[
    {"en":"The novel is a famous murder mystery.","ko":"그 소설은 유명한 살인 미스터리 이야기이다."},
    {"en":"The detective in the movie solved the murder case.","ko":"영화 속 탐정은 그 살인 사건을 해결했다."},
    {"en":"The class read a mystery story about a murder investigation.","ko":"그 반은 살인 사건 수사에 관한 추리 소설을 읽었다."}
  ]'::jsonb),
  ('victim', 1, 38, '명사', '[
    {"en":"Volunteers brought food to the flood victims.","ko":"자원봉사자들은 홍수 피해자들에게 음식을 가져다주었다."},
    {"en":"The charity helps victims of natural disasters.","ko":"그 자선단체는 자연재해 피해자들을 돕는다."},
    {"en":"People donated clothes for the earthquake victims.","ko":"사람들은 지진 피해자들을 위해 옷을 기부했다."}
  ]'::jsonb),
  ('argue', 1, 38, '동사', '[
    {"en":"The students argued about which book was better.","ko":"학생들은 어느 책이 더 좋은지에 대해 논쟁했다."},
    {"en":"She argued that recycling is important for the environment.","ko":"그녀는 재활용이 환경에 중요하다고 주장했다."},
    {"en":"In the debate class, we learn how to argue politely.","ko":"토론 수업에서 우리는 정중하게 주장하는 법을 배운다."}
  ]'::jsonb),
  ('punish', 1, 38, '동사', '[
    {"en":"The teacher punished the students for being late.","ko":"선생님은 지각한 학생들을 벌주었다."},
    {"en":"Parents sometimes punish children by taking away their phones.","ko":"부모님은 때때로 아이들의 휴대폰을 빼앗는 것으로 벌을 준다."},
    {"en":"The rule punishes anyone who breaks school regulations.","ko":"그 규칙은 교칙을 어기는 사람은 누구든 처벌한다."}
  ]'::jsonb),
  ('policy', 1, 38, '명사', '[
    {"en":"The school introduced a new policy about cell phones.","ko":"학교는 휴대폰에 관한 새로운 정책을 도입했다."},
    {"en":"The government announced a policy to protect the environment.","ko":"정부는 환경을 보호하기 위한 정책을 발표했다."},
    {"en":"Our library has a policy of returning books within two weeks.","ko":"우리 도서관은 책을 2주 안에 반납하는 정책을 가지고 있다."}
  ]'::jsonb),
  ('illegal', 1, 38, '형용사', '[
    {"en":"It is illegal to litter in the park.","ko":"공원에 쓰레기를 버리는 것은 불법이다."},
    {"en":"Riding a bicycle without a helmet is illegal in some places.","ko":"일부 지역에서는 헬멧 없이 자전거를 타는 것이 불법이다."},
    {"en":"The sign warned that parking here is illegal.","ko":"표지판은 이곳에 주차하는 것이 불법이라고 경고했다."}
  ]'::jsonb),
  ('guilty', 1, 38, '형용사', '[
    {"en":"He felt guilty for forgetting his friend''s birthday.","ko":"그는 친구의 생일을 잊어버려서 죄책감을 느꼈다."},
    {"en":"The jury found the man guilty in the story.","ko":"이야기 속에서 배심원단은 그 남자를 유죄로 판단했다."},
    {"en":"She looked guilty when she broke the vase.","ko":"그녀는 꽃병을 깼을 때 죄책감을 느끼는 표정이었다."}
  ]'::jsonb),
  ('innocent', 1, 38, '형용사', '[
    {"en":"The lawyer proved that her client was innocent.","ko":"그 변호사는 의뢰인이 결백하다는 것을 증명했다."},
    {"en":"The children looked innocent when asked about the noise.","ko":"아이들은 그 소음에 대해 질문받았을 때 순진한 표정을 지었다."},
    {"en":"In the end, the innocent man was set free.","ko":"결국 그 무죄인 남자는 풀려났다."}
  ]'::jsonb),
  ('majority', 1, 38, '명사/형용사', '[
    {"en":"The majority of the class agreed with the new schedule.","ko":"학급의 대다수가 새로운 일정에 동의했다."},
    {"en":"A majority vote decided the winner of the contest.","ko":"다수결 투표가 대회의 우승자를 결정했다."},
    {"en":"The majority of students walk to school.","ko":"대다수의 학생들이 걸어서 학교에 간다."}
  ]'::jsonb),
  ('minority', 1, 38, '명사/형용사', '[
    {"en":"Only a minority of students chose the science club.","ko":"오직 소수의 학생들만 과학 동아리를 선택했다."},
    {"en":"We should respect the opinions of the minority.","ko":"우리는 소수의 의견도 존중해야 한다."},
    {"en":"A minority group in the class prefers reading over sports.","ko":"학급의 소수 그룹은 운동보다 독서를 선호한다."}
  ]'::jsonb),
  ('suspect', 1, 38, '명사/동사', '[
    {"en":"In the story, the police questioned the suspect.","ko":"이야기 속에서 경찰은 용의자를 심문했다."},
    {"en":"I suspect that it will rain later today.","ko":"나는 오늘 늦게 비가 올 것 같다고 생각한다."},
    {"en":"The detective in the movie found an important clue about the suspect.","ko":"영화 속 탐정은 용의자에 대한 중요한 단서를 찾았다."}
  ]'::jsonb),
  ('witness', 1, 38, '명사/동사', '[
    {"en":"She was a witness to the small car accident.","ko":"그녀는 작은 자동차 사고의 목격자였다."},
    {"en":"Many people witnessed the beautiful sunset over the sea.","ko":"많은 사람들이 바다 위로 지는 아름다운 노을을 목격했다."},
    {"en":"The witness described what she saw to the police officer.","ko":"그 목격자는 자신이 본 것을 경찰관에게 설명했다."}
  ]'::jsonb),
  ('arrest', 1, 38, '명사/동사', '[
    {"en":"In the movie, the police made an arrest at the airport.","ko":"영화에서 경찰은 공항에서 체포를 했다."},
    {"en":"The officer explained how an arrest is carried out.","ko":"그 경찰관은 체포가 어떻게 이루어지는지 설명했다."},
    {"en":"The news reported an arrest downtown last night.","ko":"뉴스는 어젯밤 시내에서 있었던 체포 소식을 보도했다."}
  ]'::jsonb),
  ('candidate', 1, 38, '명사', '[
    {"en":"Three candidates ran for class president.","ko":"세 명의 후보자가 반장 선거에 출마했다."},
    {"en":"Each candidate gave a short speech before the election.","ko":"각 후보자는 선거 전에 짧은 연설을 했다."},
    {"en":"She was chosen as the best candidate for the scholarship.","ko":"그녀는 장학금의 최적의 후보자로 선정되었다."}
  ]'::jsonb),
  ('government', 1, 38, '명사', '[
    {"en":"The government built a new library in our town.","ko":"정부는 우리 마을에 새 도서관을 지었다."},
    {"en":"Students learned how the government makes laws.","ko":"학생들은 정부가 어떻게 법을 만드는지 배웠다."},
    {"en":"The local government planted trees along the street.","ko":"지방 정부는 거리를 따라 나무를 심었다."}
  ]'::jsonb),
  ('elect', 1, 38, '동사', '[
    {"en":"We elected a new class leader yesterday.","ko":"우리는 어제 새로운 학급 대표를 선출했다."},
    {"en":"Citizens elect their representatives every few years.","ko":"시민들은 몇 년마다 대표자를 선출한다."},
    {"en":"The club members elected her as the club captain.","ko":"동아리 회원들은 그녀를 동아리 대표로 선출했다."}
  ]'::jsonb),
  ('trial', 1, 38, '명사', '[
    {"en":"The class watched a video about a court trial.","ko":"그 반은 법정 재판에 관한 영상을 시청했다."},
    {"en":"The new program is still in a trial period.","ko":"그 새 프로그램은 아직 시행 기간 중이다."},
    {"en":"The teacher gave the students a trial test before the real exam.","ko":"선생님은 실제 시험 전에 학생들에게 시범 시험을 보게 했다."}
  ]'::jsonb),
  ('sentence', 1, 38, '명사/동사', '[
    {"en":"Please write a sentence using the new vocabulary word.","ko":"새 단어를 사용해서 문장을 하나 써 보세요."},
    {"en":"The judge in the story gave a fair sentence.","ko":"이야기 속 판사는 공정한 판결을 내렸다."},
    {"en":"Our teacher asked us to make five sentences for homework.","ko":"선생님은 숙제로 다섯 문장을 만들라고 하셨다."}
  ]'::jsonb),
  ('protest', 1, 38, '명사/동사', '[
    {"en":"Students held a peaceful protest about the cafeteria menu.","ko":"학생들은 급식 메뉴에 대해 평화로운 항의 시위를 벌였다."},
    {"en":"She protested against the unfair rule.","ko":"그녀는 불공평한 규칙에 대해 항의했다."},
    {"en":"The protest ended peacefully after the meeting.","ko":"그 항의 시위는 회의 후에 평화롭게 끝났다."}
  ]'::jsonb),
  ('compensate', 1, 38, '동사', '[
    {"en":"The store compensated the customer for the broken item.","ko":"그 가게는 고객에게 파손된 물건에 대해 보상했다."},
    {"en":"He worked extra hours to compensate for his mistake.","ko":"그는 자신의 실수를 만회하기 위해 추가 시간 일했다."},
    {"en":"The company compensated workers for their overtime.","ko":"그 회사는 직원들에게 초과 근무에 대해 보상했다."}
  ]'::jsonb),
  ('diplomat', 1, 38, '명사', '[
    {"en":"Her father works as a diplomat in another country.","ko":"그녀의 아버지는 다른 나라에서 외교관으로 일하신다."},
    {"en":"The diplomat visited many countries for his job.","ko":"그 외교관은 업무 때문에 여러 나라를 방문했다."},
    {"en":"Diplomats help countries communicate peacefully with each other.","ko":"외교관들은 나라들이 서로 평화롭게 소통하도록 돕는다."}
  ]'::jsonb),
  ('represent', 1, 38, '동사', '[
    {"en":"She will represent our school at the speech contest.","ko":"그녀는 말하기 대회에서 우리 학교를 대표할 것이다."},
    {"en":"The flag represents our country''s history.","ko":"그 깃발은 우리나라의 역사를 나타낸다."},
    {"en":"He was chosen to represent his class in the debate.","ko":"그는 토론에서 자기 반을 대표하도록 선정되었다."}
  ]'::jsonb),
  ('democracy', 1, 38, '명사', '[
    {"en":"We studied how democracy works in social studies class.","ko":"우리는 사회 시간에 민주주의가 어떻게 작동하는지 공부했다."},
    {"en":"In a democracy, citizens choose their leaders.","ko":"민주주의에서는 시민들이 지도자를 선택한다."},
    {"en":"Voting is an important part of democracy.","ko":"투표는 민주주의의 중요한 부분이다."}
  ]'::jsonb),
  ('be supposed to', 1, 38, '동사구', '[
    {"en":"We are supposed to finish our homework before dinner.","ko":"우리는 저녁 식사 전에 숙제를 끝내기로 되어 있다."},
    {"en":"She was supposed to meet her friend at three.","ko":"그녀는 3시에 친구를 만나기로 되어 있었다."},
    {"en":"Students are supposed to wear their uniforms to school.","ko":"학생들은 학교에 교복을 입고 오기로 되어 있다."}
  ]'::jsonb),
  ('look into', 1, 38, '동사구', '[
    {"en":"The teacher looked into why the students were late.","ko":"선생님은 학생들이 왜 늦었는지 조사했다."},
    {"en":"We looked into the history of our school.","ko":"우리는 우리 학교의 역사를 살펴보았다."},
    {"en":"The principal looked into the problem with the heater.","ko":"교장 선생님은 난방기 문제를 조사했다."}
  ]'::jsonb),
  ('peace', 1, 39, '명사', '[
    {"en":"The two countries finally made peace.","ko":"두 나라는 마침내 평화를 이루었다."},
    {"en":"We learned about the importance of peace in history class.","ko":"우리는 역사 시간에 평화의 중요성에 대해 배웠다."},
    {"en":"The garden gave her a feeling of peace.","ko":"그 정원은 그녀에게 평화로운 느낌을 주었다."}
  ]'::jsonb),
  ('war', 1, 39, '명사', '[
    {"en":"The museum has exhibits about an old war.","ko":"그 박물관에는 오래된 전쟁에 관한 전시물이 있다."},
    {"en":"Students learned the causes of the war in history class.","ko":"학생들은 역사 시간에 그 전쟁의 원인을 배웠다."},
    {"en":"The novel is set during a war a long time ago.","ko":"그 소설은 오래전 전쟁 시기를 배경으로 한다."}
  ]'::jsonb),
  ('century', 1, 39, '명사', '[
    {"en":"This castle was built in the fifteenth century.","ko":"이 성은 15세기에 지어졌다."},
    {"en":"Technology has changed a lot over the last century.","ko":"지난 세기 동안 기술은 많이 변화했다."},
    {"en":"The painting is more than a century old.","ko":"그 그림은 백 년이 넘은 것이다."}
  ]'::jsonb),
  ('age', 1, 39, '명사', '[
    {"en":"My grandmother is eighty years of age.","ko":"우리 할머니는 나이가 여든이시다."},
    {"en":"Students studied the Ice Age in science class.","ko":"학생들은 과학 시간에 빙하기에 대해 공부했다."},
    {"en":"Children of every age enjoy the school festival.","ko":"모든 나이의 아이들이 학교 축제를 즐긴다."}
  ]'::jsonb),
  ('battle', 1, 39, '명사', '[
    {"en":"We read about a famous battle in history class.","ko":"우리는 역사 시간에 유명한 전투에 대해 읽었다."},
    {"en":"The museum shows a map of an old battle.","ko":"그 박물관은 오래된 전투의 지도를 보여 준다."},
    {"en":"The story describes the battle between two ancient kingdoms.","ko":"그 이야기는 두 고대 왕국 사이의 전투를 묘사한다."}
  ]'::jsonb),
  ('pray', 1, 39, '동사', '[
    {"en":"She prayed for her grandmother''s health.","ko":"그녀는 할머니의 건강을 위해 기도했다."},
    {"en":"People pray in many different ways around the world.","ko":"전 세계 사람들은 여러 다른 방식으로 기도한다."},
    {"en":"He prayed for good weather before the school trip.","ko":"그는 수학여행 전에 좋은 날씨를 기원했다."}
  ]'::jsonb),
  ('soul', 1, 39, '명사', '[
    {"en":"Music brings peace to the soul.","ko":"음악은 영혼에 평화를 가져다준다."},
    {"en":"Some people believe every living thing has a soul.","ko":"어떤 사람들은 모든 살아있는 것에 영혼이 있다고 믿는다."},
    {"en":"Reading a good book can refresh your soul.","ko":"좋은 책을 읽는 것은 정신을 새롭게 해 줄 수 있다."}
  ]'::jsonb),
  ('belief', 1, 39, '명사', '[
    {"en":"It is her belief that kindness matters most.","ko":"친절이 가장 중요하다는 것이 그녀의 신념이다."},
    {"en":"Different cultures have different beliefs and customs.","ko":"서로 다른 문화는 서로 다른 믿음과 관습을 가지고 있다."},
    {"en":"He shared his belief that hard work leads to success.","ko":"그는 노력이 성공으로 이어진다는 신념을 나누었다."}
  ]'::jsonb),
  ('invade', 1, 39, '동사', '[
    {"en":"The history book describes how the army invaded the region.","ko":"그 역사책은 군대가 그 지역을 침략한 과정을 설명한다."},
    {"en":"Weeds began to invade the school garden.","ko":"잡초가 학교 정원을 침범하기 시작했다."},
    {"en":"Ants sometimes invade the kitchen in summer.","ko":"여름에는 개미가 종종 부엌에 침입한다."}
  ]'::jsonb),
  ('attack', 1, 39, '명사/동사', '[
    {"en":"In the video game, players attack with imaginary weapons.","ko":"그 비디오 게임에서 플레이어들은 가상의 무기로 공격한다."},
    {"en":"The history lesson covered a famous attack from long ago.","ko":"그 역사 수업은 오래전 유명한 공격을 다루었다."},
    {"en":"The documentary explained the attack in a calm, factual way.","ko":"그 다큐멘터리는 그 공격을 차분하고 사실적으로 설명했다."}
  ]'::jsonb),
  ('weapon', 1, 39, '명사', '[
    {"en":"The museum displays weapons used long ago in history.","ko":"그 박물관은 오래전 역사에서 사용된 무기들을 전시한다."},
    {"en":"Ancient people made weapons from stone and wood.","ko":"고대 사람들은 돌과 나무로 무기를 만들었다."},
    {"en":"The history teacher showed a picture of an old weapon.","ko":"역사 선생님은 오래된 무기의 사진을 보여 주셨다."}
  ]'::jsonb),
  ('empire', 1, 39, '명사', '[
    {"en":"The empire once covered a huge area of land.","ko":"그 제국은 한때 넓은 땅을 차지했다."},
    {"en":"We studied the history of an ancient empire.","ko":"우리는 고대 제국의 역사를 공부했다."},
    {"en":"The empire built many roads to connect its cities.","ko":"그 제국은 도시들을 연결하기 위해 많은 도로를 건설했다."}
  ]'::jsonb),
  ('rule', 1, 39, '명사/동사', '[
    {"en":"The king ruled the country for forty years.","ko":"그 왕은 40년 동안 그 나라를 통치했다."},
    {"en":"Please follow the classroom rules.","ko":"교실 규칙을 따라 주세요."},
    {"en":"The old kingdom was under the rule of a wise queen.","ko":"그 옛 왕국은 현명한 여왕의 통치 아래 있었다."}
  ]'::jsonb),
  ('religious', 1, 39, '형용사', '[
    {"en":"The festival has both cultural and religious meaning.","ko":"그 축제는 문화적 의미와 종교적 의미를 모두 가지고 있다."},
    {"en":"Many old buildings in the city are religious sites.","ko":"그 도시의 많은 오래된 건물들은 종교적 장소이다."},
    {"en":"Students learned about various religious traditions in class.","ko":"학생들은 수업에서 다양한 종교적 전통에 대해 배웠다."}
  ]'::jsonb),
  ('charity', 1, 39, '명사', '[
    {"en":"Our school held a charity event to help sick children.","ko":"우리 학교는 아픈 아이들을 돕기 위한 자선 행사를 열었다."},
    {"en":"She volunteers at a local charity every weekend.","ko":"그녀는 주말마다 지역 자선단체에서 봉사한다."},
    {"en":"The class donated books to a charity for children.","ko":"그 반은 아동을 위한 자선단체에 책을 기부했다."}
  ]'::jsonb),
  ('faithful', 1, 39, '형용사', '[
    {"en":"The dog is faithful to its owner.","ko":"그 개는 주인에게 충실하다."},
    {"en":"She has been a faithful friend for many years.","ko":"그녀는 여러 해 동안 신실한 친구였다."},
    {"en":"He remained faithful to his promise.","ko":"그는 자신의 약속에 끝까지 성실했다."}
  ]'::jsonb),
  ('independence', 1, 39, '명사', '[
    {"en":"Our country celebrates Independence Day every August.","ko":"우리나라는 매년 8월에 독립기념일을 기념한다."},
    {"en":"Learning to cook gave her a sense of independence.","ko":"요리를 배우는 것은 그녀에게 독립심을 주었다."},
    {"en":"The nation gained independence after a long struggle.","ko":"그 나라는 오랜 노력 끝에 독립을 얻었다."}
  ]'::jsonb),
  ('revolution', 1, 39, '명사', '[
    {"en":"We studied a famous revolution in history class.","ko":"우리는 역사 시간에 유명한 혁명에 대해 공부했다."},
    {"en":"The invention of computers caused a technology revolution.","ko":"컴퓨터의 발명은 기술 혁명을 일으켰다."},
    {"en":"The revolution changed how people lived and worked.","ko":"그 혁명은 사람들이 살고 일하는 방식을 바꾸었다."}
  ]'::jsonb),
  ('ancient', 1, 39, '형용사', '[
    {"en":"We visited an ancient temple during our trip.","ko":"우리는 여행 중에 고대 사원을 방문했다."},
    {"en":"Ancient people used stars to find their way.","ko":"고대 사람들은 길을 찾기 위해 별을 이용했다."},
    {"en":"The museum has many ancient pots and tools.","ko":"그 박물관에는 많은 고대 항아리와 도구들이 있다."}
  ]'::jsonb),
  ('Buddhism', 1, 39, '명사', '[
    {"en":"Buddhism began in ancient India.","ko":"불교는 고대 인도에서 시작되었다."},
    {"en":"We visited a temple to learn about Buddhism.","ko":"우리는 불교에 대해 배우기 위해 절을 방문했다."},
    {"en":"Buddhism teaches kindness and calmness.","ko":"불교는 친절함과 평온함을 가르친다."}
  ]'::jsonb),
  ('Christianity', 1, 39, '명사', '[
    {"en":"Christianity is one of the major religions in the world.","ko":"기독교는 세계 주요 종교 중 하나이다."},
    {"en":"The old church shows the history of Christianity in the town.","ko":"그 오래된 교회는 마을의 기독교 역사를 보여 준다."},
    {"en":"Students learned about Christianity in world history class.","ko":"학생들은 세계사 시간에 기독교에 대해 배웠다."}
  ]'::jsonb),
  ('Hinduism', 1, 39, '명사', '[
    {"en":"Hinduism is practiced by many people in India.","ko":"힌두교는 인도의 많은 사람들이 믿고 있다."},
    {"en":"We read a book about the history of Hinduism.","ko":"우리는 힌두교의 역사에 관한 책을 읽었다."},
    {"en":"Hinduism has many festivals throughout the year.","ko":"힌두교는 일 년 내내 많은 축제를 가지고 있다."}
  ]'::jsonb),
  ('Islam', 1, 39, '명사', '[
    {"en":"Islam is followed by many people around the world.","ko":"이슬람교는 전 세계 많은 사람들이 믿고 있다."},
    {"en":"We learned about Islam in our world religion class.","ko":"우리는 세계 종교 수업에서 이슬람교에 대해 배웠다."},
    {"en":"Islam has a long and rich history.","ko":"이슬람교는 길고 풍부한 역사를 가지고 있다."}
  ]'::jsonb),
  ('Judaism', 1, 39, '명사', '[
    {"en":"Judaism is one of the oldest religions in the world.","ko":"유대교는 세계에서 가장 오래된 종교 중 하나이다."},
    {"en":"We studied the history of Judaism in class.","ko":"우리는 수업에서 유대교의 역사를 공부했다."},
    {"en":"Judaism has its own special holidays and customs.","ko":"유대교는 고유한 특별한 명절과 관습을 가지고 있다."}
  ]'::jsonb),
  ('colony', 1, 39, '명사', '[
    {"en":"The country was once a colony of another nation.","ko":"그 나라는 한때 다른 나라의 식민지였다."},
    {"en":"We studied how the colony gained independence.","ko":"우리는 그 식민지가 어떻게 독립을 얻었는지 공부했다."},
    {"en":"Many colonies became independent countries in the last century.","ko":"지난 세기에 많은 식민지들이 독립국이 되었다."}
  ]'::jsonb),
  ('civilization', 1, 39, '명사', '[
    {"en":"The ancient civilization built huge stone structures.","ko":"그 고대 문명은 거대한 석조 건축물을 세웠다."},
    {"en":"We learned about an early civilization in history class.","ko":"우리는 역사 시간에 초기 문명에 대해 배웠다."},
    {"en":"The river helped the civilization grow and prosper.","ko":"그 강은 그 문명이 성장하고 번영하는 데 도움을 주었다."}
  ]'::jsonb),
  ('spiritual', 1, 39, '형용사', '[
    {"en":"Walking in nature gives her spiritual peace.","ko":"자연 속을 걷는 것은 그녀에게 정신적인 평화를 준다."},
    {"en":"The temple is an important spiritual place for many people.","ko":"그 사원은 많은 사람들에게 중요한 영적인 장소이다."},
    {"en":"Music can be a spiritual experience for some people.","ko":"음악은 어떤 사람들에게는 영적인 경험이 될 수 있다."}
  ]'::jsonb),
  ('ceremony', 1, 39, '명사', '[
    {"en":"We attended the graduation ceremony last week.","ko":"우리는 지난주에 졸업식에 참석했다."},
    {"en":"The opening ceremony of the festival was colorful and fun.","ko":"그 축제의 개막식은 화려하고 즐거웠다."},
    {"en":"The tea ceremony follows many traditional steps.","ko":"다도 의식은 여러 전통적인 절차를 따른다."}
  ]'::jsonb),
  ('date back', 1, 39, '동사구', '[
    {"en":"This temple dates back to the seventh century.","ko":"이 사원은 7세기까지 거슬러 올라간다."},
    {"en":"The tradition dates back hundreds of years.","ko":"그 전통은 수백 년 전으로 거슬러 올라간다."},
    {"en":"This old bridge dates back to ancient times.","ko":"이 오래된 다리는 고대로 거슬러 올라간다."}
  ]'::jsonb),
  ('be based on', 1, 39, '동사구', '[
    {"en":"The movie is based on a true story.","ko":"그 영화는 실화에 기초하고 있다."},
    {"en":"Our project is based on careful research.","ko":"우리의 프로젝트는 꼼꼼한 조사에 근거하고 있다."},
    {"en":"The novel is based on ancient legends.","ko":"그 소설은 고대 전설에 기초하고 있다."}
  ]'::jsonb),
  ('different', 1, 40, '형용사', '[
    {"en":"My brother and I have very different hobbies.","ko":"나와 내 남동생은 취미가 매우 다르다."},
    {"en":"Each country has a different culture and language.","ko":"각 나라는 서로 다른 문화와 언어를 가지고 있다."},
    {"en":"We tried a different way to solve the problem.","ko":"우리는 그 문제를 풀기 위해 다른 방법을 시도했다."}
  ]'::jsonb),
  ('global', 1, 40, '형용사', '[
    {"en":"Global warming is an important topic in science class.","ko":"지구 온난화는 과학 시간의 중요한 주제이다."},
    {"en":"The internet connects people on a global scale.","ko":"인터넷은 세계적인 규모로 사람들을 연결한다."},
    {"en":"The festival attracted visitors from a global audience.","ko":"그 축제는 전 세계 관람객들을 끌어모았다."}
  ]'::jsonb),
  ('race', 1, 40, '명사', '[
    {"en":"People of every race can be friends.","ko":"모든 인종의 사람들은 친구가 될 수 있다."},
    {"en":"We should respect people of all races equally.","ko":"우리는 모든 인종의 사람들을 동등하게 존중해야 한다."},
    {"en":"He won first place in the school running race.","ko":"그는 학교 달리기 경주에서 1등을 했다."}
  ]'::jsonb),
  ('national', 1, 40, '형용사', '[
    {"en":"We visited a national park during summer vacation.","ko":"우리는 여름 방학 동안 국립공원을 방문했다."},
    {"en":"The national anthem was sung before the game.","ko":"경기 전에 애국가가 불렸다."},
    {"en":"Today is a national holiday, so school is closed.","ko":"오늘은 국경일이라서 학교가 쉰다."}
  ]'::jsonb),
  ('fund', 1, 40, '명사', '[
    {"en":"The school set up a fund to help poor students.","ko":"학교는 어려운 학생들을 돕기 위해 기금을 마련했다."},
    {"en":"Students raised a fund for the animal shelter.","ko":"학생들은 동물 보호소를 위한 기금을 모았다."},
    {"en":"The fund was used to build a new playground.","ko":"그 기금은 새로운 놀이터를 짓는 데 사용되었다."}
  ]'::jsonb),
  ('foreign', 1, 40, '형용사', '[
    {"en":"She wants to learn a foreign language next year.","ko":"그녀는 내년에 외국어를 배우고 싶어 한다."},
    {"en":"We met some foreign students at the exchange program.","ko":"우리는 교환 프로그램에서 몇몇 외국인 학생들을 만났다."},
    {"en":"He collects foreign coins as a hobby.","ko":"그는 취미로 외국 동전을 수집한다."}
  ]'::jsonb),
  ('international', 1, 40, '형용사', '[
    {"en":"Our school held an international food festival.","ko":"우리 학교는 국제 음식 축제를 열었다."},
    {"en":"She dreams of working for an international organization.","ko":"그녀는 국제기구에서 일하는 것을 꿈꾼다."},
    {"en":"The city hosted an international sports competition.","ko":"그 도시는 국제 스포츠 대회를 개최했다."}
  ]'::jsonb),
  ('community', 1, 40, '명사', '[
    {"en":"Our community cleaned up the local park together.","ko":"우리 지역 사회는 함께 동네 공원을 청소했다."},
    {"en":"The library is an important place for our community.","ko":"도서관은 우리 지역 사회에 중요한 장소이다."},
    {"en":"She volunteers to help her local community.","ko":"그녀는 지역 사회를 돕기 위해 봉사한다."}
  ]'::jsonb),
  ('population', 1, 40, '명사', '[
    {"en":"The population of our city has grown quickly.","ko":"우리 도시의 인구는 빠르게 증가했다."},
    {"en":"Seoul has a large population.","ko":"서울은 인구가 많다."},
    {"en":"We studied how population affects the environment.","ko":"우리는 인구가 환경에 어떤 영향을 미치는지 공부했다."}
  ]'::jsonb),
  ('increase', 1, 40, '명사/동사', '[
    {"en":"The number of students increased this year.","ko":"올해 학생 수가 증가했다."},
    {"en":"There was a sudden increase in temperature.","ko":"기온이 갑자기 상승했다."},
    {"en":"Regular exercise can increase your energy.","ko":"규칙적인 운동은 에너지를 증가시킬 수 있다."}
  ]'::jsonb),
  ('decrease', 1, 40, '명사/동사', '[
    {"en":"The population of the small town decreased slowly.","ko":"그 작은 마을의 인구는 서서히 감소했다."},
    {"en":"There was a decrease in rainfall this year.","ko":"올해는 강우량이 감소했다."},
    {"en":"Recycling can decrease the amount of waste.","ko":"재활용은 쓰레기의 양을 줄일 수 있다."}
  ]'::jsonb),
  ('urban', 1, 40, '형용사', '[
    {"en":"Urban areas usually have more traffic than rural areas.","ko":"도시 지역은 보통 시골 지역보다 교통량이 많다."},
    {"en":"We studied the differences between urban and rural life.","ko":"우리는 도시 생활과 시골 생활의 차이점을 공부했다."},
    {"en":"Many people move to urban areas for work.","ko":"많은 사람들이 일 때문에 도시 지역으로 이사한다."}
  ]'::jsonb),
  ('rural', 1, 40, '형용사', '[
    {"en":"My grandparents live in a rural area.","ko":"우리 조부모님은 시골 지역에 사신다."},
    {"en":"Rural life is quieter than city life.","ko":"시골 생활은 도시 생활보다 조용하다."},
    {"en":"We visited a rural village during our trip.","ko":"우리는 여행 중에 시골 마을을 방문했다."}
  ]'::jsonb),
  ('region', 1, 40, '명사', '[
    {"en":"This region is known for its fresh fruit.","ko":"이 지역은 신선한 과일로 유명하다."},
    {"en":"Each region of the country has its own dialect.","ko":"그 나라의 각 지역은 고유한 사투리를 가지고 있다."},
    {"en":"We studied the climate of the southern region.","ko":"우리는 남부 지역의 기후를 공부했다."}
  ]'::jsonb),
  ('border', 1, 40, '명사', '[
    {"en":"The two countries share a long border.","ko":"그 두 나라는 긴 국경을 공유한다."},
    {"en":"We looked at the border between the two regions on the map.","ko":"우리는 지도에서 두 지역 사이의 경계를 살펴보았다."},
    {"en":"The river forms a natural border between the towns.","ko":"그 강은 마을들 사이의 자연적인 경계를 이룬다."}
  ]'::jsonb),
  ('aid', 1, 40, '명사', '[
    {"en":"The country sent aid to help flood victims.","ko":"그 나라는 홍수 피해자들을 돕기 위해 원조를 보냈다."},
    {"en":"Volunteers gave first aid to the injured hiker.","ko":"자원봉사자들은 다친 등산객에게 응급 처치를 해 주었다."},
    {"en":"International aid helped rebuild the school after the storm.","ko":"국제 원조는 폭풍 후에 학교를 재건하는 데 도움을 주었다."}
  ]'::jsonb),
  ('suffer', 1, 40, '동사', '[
    {"en":"Many farmers suffered from the long drought.","ko":"많은 농부들이 긴 가뭄으로 고통을 겪었다."},
    {"en":"She suffered from a bad cold last week.","ko":"그녀는 지난주에 심한 감기로 고생했다."},
    {"en":"The town suffered damage from the heavy storm.","ko":"그 마을은 강한 폭풍으로 피해를 입었다."}
  ]'::jsonb),
  ('native', 1, 40, '명사/형용사', '[
    {"en":"English is not her native language.","ko":"영어는 그녀의 모국어가 아니다."},
    {"en":"He is a native of a small village in the mountains.","ko":"그는 산속의 작은 마을 출신이다."},
    {"en":"This plant is native to warm regions.","ko":"이 식물은 따뜻한 지역이 원산지이다."}
  ]'::jsonb),
  ('orphan', 1, 40, '명사', '[
    {"en":"The charity built a home for orphans.","ko":"그 자선단체는 고아들을 위한 집을 지었다."},
    {"en":"Volunteers read stories to the orphans every weekend.","ko":"자원봉사자들은 주말마다 고아들에게 이야기를 읽어 준다."},
    {"en":"The organization helps orphans go to school.","ko":"그 단체는 고아들이 학교에 다닐 수 있도록 돕는다."}
  ]'::jsonb),
  ('support', 1, 40, '명사/동사', '[
    {"en":"My parents always support my dreams.","ko":"부모님은 항상 내 꿈을 지지해 주신다."},
    {"en":"The team gave each other support during the game.","ko":"그 팀은 경기 동안 서로를 지지했다."},
    {"en":"The organization provides support to families in need.","ko":"그 단체는 어려움에 처한 가족들을 지원한다."}
  ]'::jsonb),
  ('rescue', 1, 40, '동사', '[
    {"en":"The lifeguard rescued a swimmer from the strong waves.","ko":"인명 구조원은 거센 파도에서 수영하던 사람을 구했다."},
    {"en":"Firefighters rescued the cat stuck in the tree.","ko":"소방관들은 나무에 걸린 고양이를 구했다."},
    {"en":"Volunteers worked together to rescue the stranded hikers.","ko":"자원봉사자들은 고립된 등산객들을 구하기 위해 함께 일했다."}
  ]'::jsonb),
  ('immigrate', 1, 40, '동사', '[
    {"en":"Her family immigrated to Canada ten years ago.","ko":"그녀의 가족은 10년 전에 캐나다로 이민을 왔다."},
    {"en":"Many people immigrate to find better opportunities.","ko":"많은 사람들이 더 나은 기회를 찾아 이민을 온다."},
    {"en":"They immigrated from a small town to a big city.","ko":"그들은 작은 마을에서 대도시로 이주해 왔다."}
  ]'::jsonb),
  ('hunger', 1, 40, '명사', '[
    {"en":"The organization works to end hunger around the world.","ko":"그 단체는 전 세계의 기아를 없애기 위해 노력한다."},
    {"en":"Students collected food to fight hunger in their community.","ko":"학생들은 지역 사회의 기아 문제를 해결하기 위해 음식을 모았다."},
    {"en":"After the long hike, he felt real hunger.","ko":"긴 하이킹 후에 그는 정말로 배고픔을 느꼈다."}
  ]'::jsonb),
  ('ethnic', 1, 40, '형용사', '[
    {"en":"The festival celebrates many different ethnic traditions.","ko":"그 축제는 다양한 민족 전통을 기념한다."},
    {"en":"Our city has people from many ethnic backgrounds.","ko":"우리 도시에는 다양한 민족 배경을 가진 사람들이 있다."},
    {"en":"We tried ethnic food from several countries at the fair.","ko":"우리는 박람회에서 여러 나라의 민족 음식을 맛보았다."}
  ]'::jsonb),
  ('organization', 1, 40, '명사', '[
    {"en":"The organization helps children get an education.","ko":"그 기구는 아이들이 교육을 받을 수 있도록 돕는다."},
    {"en":"She works for an international organization.","ko":"그녀는 국제기구에서 일한다."},
    {"en":"Our club is a small organization that protects local animals.","ko":"우리 동아리는 지역 동물을 보호하는 작은 단체이다."}
  ]'::jsonb),
  ('statistic', 1, 40, '명사', '[
    {"en":"The statistic showed that reading habits are improving.","ko":"그 통계는 독서 습관이 개선되고 있음을 보여 주었다."},
    {"en":"Our teacher used a statistic to explain the survey results.","ko":"선생님은 통계치를 사용해서 설문 결과를 설명하셨다."},
    {"en":"The report included a statistic about student attendance.","ko":"그 보고서는 학생 출석에 관한 통계치를 포함했다."}
  ]'::jsonb),
  ('agreement', 1, 40, '명사', '[
    {"en":"The two classes reached an agreement about the schedule.","ko":"두 학급은 일정에 관해 합의에 도달했다."},
    {"en":"The countries signed an agreement to protect the ocean.","ko":"그 나라들은 바다를 보호하기 위한 협정에 서명했다."},
    {"en":"We came to an agreement after a long discussion.","ko":"우리는 긴 토론 끝에 합의에 이르렀다."}
  ]'::jsonb),
  ('mutual', 1, 40, '형용사', '[
    {"en":"The two friends have a mutual love of music.","ko":"그 두 친구는 음악에 대한 서로의 애정을 공유한다."},
    {"en":"Their friendship is based on mutual respect.","ko":"그들의 우정은 상호 존중에 기초하고 있다."},
    {"en":"The two schools have a mutual agreement to share books.","ko":"그 두 학교는 책을 공유하기로 상호 합의했다."}
  ]'::jsonb),
  ('break out', 1, 40, '동사구', '[
    {"en":"A fire broke out in the old building.","ko":"그 오래된 건물에서 화재가 발생했다."},
    {"en":"The history book explains why the war broke out.","ko":"그 역사책은 그 전쟁이 왜 발발했는지 설명한다."},
    {"en":"A sudden storm broke out during the picnic.","ko":"소풍 중에 갑자기 폭풍이 발생했다."}
  ]'::jsonb),
  ('consist of', 1, 40, '동사구', '[
    {"en":"Our team consists of five members.","ko":"우리 팀은 다섯 명의 구성원으로 이루어져 있다."},
    {"en":"The book consists of ten short chapters.","ko":"그 책은 열 개의 짧은 장으로 구성되어 있다."},
    {"en":"The salad consists of fresh vegetables and fruit.","ko":"그 샐러드는 신선한 채소와 과일로 이루어져 있다."}
  ]'::jsonb)
) as t(word, level, study_day, pos, examples)
where v.word = t.word and v.level = t.level and v.study_day = t.study_day;
