-- SAP 1기 대시보드: Study 탭 — Lv.1(중등 실력) Day 01~06 품사/예문 채우기 (180단어).
update public.vocab_words v
set part_of_speech = t.pos, example_sentences = t.examples, updated_at = now()
from (values
  ('wise', 1, 1, '형용사', '[
    {"en":"My grandmother always gives me wise advice.","ko":"할머니는 항상 나에게 지혜로운 조언을 해 주신다."},
    {"en":"It is wise to save some money every month.","ko":"매달 약간의 돈을 저축하는 것은 현명하다."},
    {"en":"The old man in the village is known as a wise person.","ko":"그 마을의 노인은 지혜로운 사람으로 알려져 있다."}
  ]'::jsonb),
  ('foolish', 1, 1, '형용사', '[
    {"en":"It was foolish of me to forget my umbrella.","ko":"우산을 잊어버린 것은 나의 어리석은 행동이었다."},
    {"en":"Don''t make a foolish mistake on the test.","ko":"시험에서 어리석은 실수를 하지 마라."},
    {"en":"He felt foolish after telling a silly joke.","ko":"그는 어리석은 농담을 한 후 바보 같다고 느꼈다."}
  ]'::jsonb),
  ('proud', 1, 1, '형용사', '[
    {"en":"My parents are proud of my grades.","ko":"부모님은 내 성적을 자랑스러워하신다."},
    {"en":"She felt proud after finishing the marathon.","ko":"그녀는 마라톤을 완주한 후 자랑스러움을 느꼈다."},
    {"en":"He is too proud to ask for help.","ko":"그는 너무 거만해서 도움을 요청하지 않는다."}
  ]'::jsonb),
  ('honest', 1, 1, '형용사', '[
    {"en":"Please give me your honest opinion about my essay.","ko":"내 에세이에 대한 솔직한 의견을 말해 줘."},
    {"en":"She is known for being honest with her friends.","ko":"그녀는 친구들에게 정직한 것으로 알려져 있다."},
    {"en":"Being honest is more important than being perfect.","ko":"정직한 것이 완벽한 것보다 더 중요하다."}
  ]'::jsonb),
  ('careful', 1, 1, '형용사', '[
    {"en":"Be careful when you cross the street.","ko":"길을 건널 때 조심해라."},
    {"en":"She is careful about her health these days.","ko":"그녀는 요즘 건강에 신경을 쓴다."},
    {"en":"We should be careful with our words.","ko":"우리는 말을 조심해야 한다."}
  ]'::jsonb),
  ('brave', 1, 1, '형용사', '[
    {"en":"The firefighter was very brave during the rescue.","ko":"그 소방관은 구조 중에 매우 용감했다."},
    {"en":"It was brave of you to speak in front of the class.","ko":"반 앞에서 발표한 것은 용감한 행동이었다."},
    {"en":"My little brother is brave enough to try new foods.","ko":"내 남동생은 새로운 음식을 시도할 만큼 용감하다."}
  ]'::jsonb),
  ('lazy', 1, 1, '형용사', '[
    {"en":"Don''t be lazy about your homework.","ko":"숙제에 게으름 피우지 마라."},
    {"en":"He felt lazy on the rainy afternoon.","ko":"그는 비 오는 오후에 게으름을 느꼈다."},
    {"en":"A lazy habit can affect your grades.","ko":"게으른 습관은 성적에 영향을 줄 수 있다."}
  ]'::jsonb),
  ('calm', 1, 1, '형용사', '[
    {"en":"Stay calm during the fire drill.","ko":"화재 훈련 중에는 침착함을 유지해라."},
    {"en":"The lake was calm in the early morning.","ko":"이른 아침 호수는 잔잔했다."},
    {"en":"She spoke in a calm voice.","ko":"그녀는 차분한 목소리로 말했다."}
  ]'::jsonb),
  ('rude', 1, 1, '형용사', '[
    {"en":"It is rude to interrupt when someone is talking.","ko":"다른 사람이 말할 때 끼어드는 것은 무례하다."},
    {"en":"He apologized for being rude to his teacher.","ko":"그는 선생님께 무례했던 것에 대해 사과했다."},
    {"en":"Don''t be rude to your classmates.","ko":"반 친구들에게 무례하게 굴지 마라."}
  ]'::jsonb),
  ('active', 1, 1, '형용사', '[
    {"en":"She is an active member of the school club.","ko":"그녀는 학교 동아리의 활동적인 회원이다."},
    {"en":"Playing sports keeps you active and healthy.","ko":"운동을 하면 활동적이고 건강하게 지낼 수 있다."},
    {"en":"My grandfather is still active at eighty.","ko":"우리 할아버지는 여든 살에도 여전히 활동적이시다."}
  ]'::jsonb),
  ('character', 1, 1, '명사', '[
    {"en":"The main character in the story is a young girl.","ko":"그 이야기의 주인공은 어린 소녀이다."},
    {"en":"His character changed after he joined the team.","ko":"그의 성격은 팀에 합류한 후 바뀌었다."},
    {"en":"Honesty is an important part of her character.","ko":"정직함은 그녀 성격의 중요한 부분이다."}
  ]'::jsonb),
  ('serious', 1, 1, '형용사', '[
    {"en":"He looked serious when he talked about the exam.","ko":"그는 시험에 대해 이야기할 때 진지해 보였다."},
    {"en":"This is a serious problem for our school.","ko":"이것은 우리 학교의 심각한 문제이다."},
    {"en":"She gave a serious answer to the question.","ko":"그녀는 그 질문에 진지한 답을 했다."}
  ]'::jsonb),
  ('strict', 1, 1, '형용사', '[
    {"en":"Our math teacher is very strict about homework.","ko":"우리 수학 선생님은 숙제에 매우 엄격하시다."},
    {"en":"My parents are strict about bedtime.","ko":"우리 부모님은 취침 시간에 엄격하시다."},
    {"en":"The coach is strict but fair.","ko":"그 코치는 엄격하지만 공정하다."}
  ]'::jsonb),
  ('cruel', 1, 1, '형용사', '[
    {"en":"It is cruel to laugh at someone''s mistake.","ko":"누군가의 실수를 비웃는 것은 잔인하다."},
    {"en":"The story describes a cruel king.","ko":"그 이야기는 잔인한 왕을 묘사한다."},
    {"en":"Never be cruel to animals.","ko":"동물에게 절대 잔인하게 굴지 마라."}
  ]'::jsonb),
  ('mean', 1, 1, '형용사', '[
    {"en":"He was mean to his younger sister.","ko":"그는 여동생에게 못되게 굴었다."},
    {"en":"Some students think the new rule is mean.","ko":"몇몇 학생들은 새 규칙이 심술궂다고 생각한다."},
    {"en":"Don''t be mean to your classmates.","ko":"반 친구들에게 못되게 굴지 마라."}
  ]'::jsonb),
  ('selfish', 1, 1, '형용사', '[
    {"en":"It is selfish to keep all the snacks for yourself.","ko":"간식을 혼자 다 가지는 것은 이기적이다."},
    {"en":"He never acts selfish with his friends.","ko":"그는 친구들에게 이기적으로 행동하지 않는다."},
    {"en":"Sharing is better than being selfish.","ko":"나누는 것이 이기적인 것보다 낫다."}
  ]'::jsonb),
  ('evil', 1, 1, '형용사/명사', '[
    {"en":"The story is about a fight between good and evil.","ko":"그 이야기는 선과 악의 싸움에 관한 것이다."},
    {"en":"The villain in the movie has an evil plan.","ko":"영화 속 악당은 사악한 계획을 가지고 있다."},
    {"en":"People should stand against evil.","ko":"사람들은 악에 맞서야 한다."}
  ]'::jsonb),
  ('curious', 1, 1, '형용사', '[
    {"en":"She is curious about how plants grow.","ko":"그녀는 식물이 어떻게 자라는지 호기심이 많다."},
    {"en":"He asked a curious question in science class.","ko":"그는 과학 시간에 호기심 어린 질문을 했다."},
    {"en":"Children are naturally curious about the world.","ko":"아이들은 본래 세상에 대해 호기심이 많다."}
  ]'::jsonb),
  ('cheerful', 1, 1, '형용사', '[
    {"en":"Her cheerful smile makes everyone happy.","ko":"그녀의 명랑한 미소는 모두를 행복하게 한다."},
    {"en":"He is a cheerful person even on rainy days.","ko":"그는 비 오는 날에도 쾌활한 사람이다."},
    {"en":"The classroom felt cheerful during the festival.","ko":"축제 기간 동안 교실은 명랑한 분위기였다."}
  ]'::jsonb),
  ('friendly', 1, 1, '형용사', '[
    {"en":"Our new neighbor is very friendly.","ko":"우리 새 이웃은 매우 친절하다."},
    {"en":"She gave a friendly wave to us.","ko":"그녀는 우리에게 다정하게 손을 흔들었다."},
    {"en":"The dog is friendly with children.","ko":"그 개는 아이들에게 친화적이다."}
  ]'::jsonb),
  ('modest', 1, 1, '형용사', '[
    {"en":"He is modest about his high score.","ko":"그는 자신의 높은 점수에 대해 겸손하다."},
    {"en":"She gave a modest answer about her success.","ko":"그녀는 자신의 성공에 대해 겸손하게 대답했다."},
    {"en":"Being modest is a good quality.","ko":"겸손한 것은 좋은 자질이다."}
  ]'::jsonb),
  ('generous', 1, 1, '형용사', '[
    {"en":"My uncle is generous with his time and money.","ko":"우리 삼촌은 시간과 돈에 관대하시다."},
    {"en":"She was generous enough to share her lunch.","ko":"그녀는 자신의 점심을 나눌 만큼 인심이 후했다."},
    {"en":"Thank you for your generous help.","ko":"후한 도움에 감사드립니다."}
  ]'::jsonb),
  ('sensitive', 1, 1, '형용사', '[
    {"en":"He is sensitive to loud noises.","ko":"그는 큰 소음에 민감하다."},
    {"en":"She gave a sensitive response to her friend''s problem.","ko":"그녀는 친구의 문제에 민감하게 반응했다."},
    {"en":"My skin is sensitive in winter.","ko":"내 피부는 겨울에 민감하다."}
  ]'::jsonb),
  ('confident', 1, 1, '형용사', '[
    {"en":"She felt confident before the speech contest.","ko":"그녀는 말하기 대회 전에 자신감을 느꼈다."},
    {"en":"He is confident about passing the exam.","ko":"그는 시험에 합격할 것이라고 확신한다."},
    {"en":"Practicing every day made her more confident.","ko":"매일 연습한 것이 그녀를 더 자신감 있게 만들었다."}
  ]'::jsonb),
  ('positive', 1, 1, '형용사', '[
    {"en":"Try to think in a positive way.","ko":"긍정적으로 생각하려고 노력해라."},
    {"en":"Her positive attitude helped the whole team.","ko":"그녀의 긍정적인 태도는 팀 전체에 도움이 되었다."},
    {"en":"He gave positive feedback on my project.","ko":"그는 내 프로젝트에 긍정적인 피드백을 주었다."}
  ]'::jsonb),
  ('negative', 1, 1, '형용사', '[
    {"en":"Don''t focus only on the negative side.","ko":"부정적인 면에만 집중하지 마라."},
    {"en":"A negative attitude can make things harder.","ko":"부정적인 태도는 상황을 더 어렵게 만들 수 있다."},
    {"en":"He received negative comments on his first try.","ko":"그는 첫 시도에서 부정적인 의견을 받았다."}
  ]'::jsonb),
  ('optimistic', 1, 1, '형용사', '[
    {"en":"She stays optimistic even during hard times.","ko":"그녀는 힘든 시기에도 낙관적인 태도를 유지한다."},
    {"en":"He is optimistic about the school festival.","ko":"그는 학교 축제에 대해 낙관적이다."},
    {"en":"Being optimistic helps you solve problems.","ko":"낙관적인 것은 문제를 해결하는 데 도움이 된다."}
  ]'::jsonb),
  ('cautious', 1, 1, '형용사', '[
    {"en":"Be cautious when you ride your bike near the road.","ko":"도로 근처에서 자전거를 탈 때는 조심해라."},
    {"en":"She is cautious about sharing personal information online.","ko":"그녀는 온라인에 개인 정보를 공유하는 것에 신중하다."},
    {"en":"He walked in a cautious way on the icy path.","ko":"그는 얼어붙은 길에서 조심스럽게 걸었다."}
  ]'::jsonb),
  ('make fun of', 1, 1, '동사구', '[
    {"en":"Don''t make fun of your classmates'' mistakes.","ko":"반 친구들의 실수를 놀리지 마라."},
    {"en":"The boys stopped making fun of the new student.","ko":"그 남학생들은 새로운 학생을 놀리는 것을 멈췄다."},
    {"en":"It hurts when people make fun of you.","ko":"사람들이 너를 놀릴 때 상처가 된다."}
  ]'::jsonb),
  ('cheer up', 1, 1, '동사구', '[
    {"en":"I brought some flowers to cheer up my sister.","ko":"나는 여동생을 기운 나게 하려고 꽃을 좀 가져왔다."},
    {"en":"She tried to cheer up her friend after the test.","ko":"그녀는 시험 후에 친구를 격려하려고 했다."},
    {"en":"Listening to music helps me cheer up.","ko":"음악을 들으면 기운이 난다."}
  ]'::jsonb),
  ('cute', 1, 2, '형용사', '[
    {"en":"The puppy next door is really cute.","ko":"옆집 강아지는 정말 귀엽다."},
    {"en":"She has a cute smile.","ko":"그녀는 귀여운 미소를 가지고 있다."},
    {"en":"Everyone thinks the baby panda is cute.","ko":"모두가 그 새끼 판다가 귀엽다고 생각한다."}
  ]'::jsonb),
  ('pretty', 1, 2, '형용사/부사', '[
    {"en":"The garden looks pretty in the spring.","ko":"그 정원은 봄에 예뻐 보인다."},
    {"en":"She wore a pretty dress to the party.","ko":"그녀는 파티에 예쁜 드레스를 입고 갔다."},
    {"en":"The movie was pretty interesting.","ko":"그 영화는 꽤 흥미로웠다."}
  ]'::jsonb),
  ('beautiful', 1, 2, '형용사', '[
    {"en":"The sunset over the mountain was beautiful.","ko":"산 위의 노을은 아름다웠다."},
    {"en":"She sang a beautiful song at the concert.","ko":"그녀는 콘서트에서 아름다운 노래를 불렀다."},
    {"en":"We visited a beautiful lake last summer.","ko":"우리는 지난여름에 아름다운 호수를 방문했다."}
  ]'::jsonb),
  ('ugly', 1, 2, '형용사', '[
    {"en":"He drew an ugly monster for his art project.","ko":"그는 미술 과제로 못생긴 괴물을 그렸다."},
    {"en":"The old building looked ugly next to the new one.","ko":"그 오래된 건물은 새 건물 옆에서 못생겨 보였다."},
    {"en":"Don''t call anything ugly just because it looks different.","ko":"단지 달라 보인다고 해서 무언가를 못생겼다고 부르지 마라."}
  ]'::jsonb),
  ('overweight', 1, 2, '형용사', '[
    {"en":"The doctor said the cat was slightly overweight.","ko":"의사는 그 고양이가 약간 과체중이라고 말했다."},
    {"en":"Eating too much fast food can make you overweight.","ko":"패스트푸드를 너무 많이 먹으면 과체중이 될 수 있다."},
    {"en":"He started exercising because he felt overweight.","ko":"그는 과체중이라고 느껴서 운동을 시작했다."}
  ]'::jsonb),
  ('young', 1, 2, '형용사', '[
    {"en":"My grandmother was a teacher when she was young.","ko":"우리 할머니는 젊었을 때 선생님이셨다."},
    {"en":"The young boy asked many questions.","ko":"그 어린 소년은 많은 질문을 했다."},
    {"en":"We should respect both young and old people.","ko":"우리는 젊은 사람과 나이 든 사람 모두를 존중해야 한다."}
  ]'::jsonb),
  ('handsome', 1, 2, '형용사', '[
    {"en":"Everyone said the actor was handsome.","ko":"모두가 그 배우가 잘생겼다고 말했다."},
    {"en":"My older brother looks handsome in his uniform.","ko":"우리 형은 교복을 입으면 잘생겨 보인다."},
    {"en":"The handsome man in the photo is my uncle.","ko":"사진 속 잘생긴 남자는 우리 삼촌이다."}
  ]'::jsonb),
  ('slim', 1, 2, '형용사', '[
    {"en":"She stays slim by walking every day.","ko":"그녀는 매일 걸어서 날씬함을 유지한다."},
    {"en":"He looked slim after playing soccer all summer.","ko":"그는 여름 내내 축구를 한 후 날씬해 보였다."},
    {"en":"The slim vase fits nicely on the shelf.","ko":"그 호리호리한 꽃병은 선반에 잘 어울린다."}
  ]'::jsonb),
  ('beard', 1, 2, '명사', '[
    {"en":"My father grew a beard during the vacation.","ko":"아버지는 방학 동안 턱수염을 기르셨다."},
    {"en":"The man with the long beard is our neighbor.","ko":"긴 턱수염을 가진 남자는 우리 이웃이다."},
    {"en":"He decided to shave off his beard.","ko":"그는 턱수염을 깎기로 결심했다."}
  ]'::jsonb),
  ('lovely', 1, 2, '형용사', '[
    {"en":"We had a lovely time at the beach.","ko":"우리는 해변에서 사랑스러운 시간을 보냈다."},
    {"en":"She wore a lovely scarf to school.","ko":"그녀는 학교에 사랑스러운 스카프를 하고 갔다."},
    {"en":"What a lovely garden this is!","ko":"정말 사랑스러운 정원이구나!"}
  ]'::jsonb),
  ('neat', 1, 2, '형용사', '[
    {"en":"Keep your desk neat and clean.","ko":"책상을 단정하고 깨끗하게 유지해라."},
    {"en":"Her handwriting is always neat.","ko":"그녀의 글씨체는 항상 단정하다."},
    {"en":"He wore a neat uniform for the interview.","ko":"그는 면접을 위해 단정한 유니폼을 입었다."}
  ]'::jsonb),
  ('plain', 1, 2, '형용사', '[
    {"en":"He wore a plain white shirt to school.","ko":"그는 학교에 평범한 흰 셔츠를 입고 갔다."},
    {"en":"The room had plain walls without any pictures.","ko":"그 방은 그림 없이 꾸밈없는 벽으로 되어 있었다."},
    {"en":"She likes plain food without much spice.","ko":"그녀는 향신료가 많지 않은 담백한 음식을 좋아한다."}
  ]'::jsonb),
  ('good-looking', 1, 2, '형용사', '[
    {"en":"The good-looking singer is popular among students.","ko":"그 잘생긴 가수는 학생들 사이에서 인기가 많다."},
    {"en":"He is good-looking and kind at the same time.","ko":"그는 잘생겼고 동시에 친절하다."},
    {"en":"My classmates think the new teacher is good-looking.","ko":"반 친구들은 새 선생님이 잘생겼다고 생각한다."}
  ]'::jsonb),
  ('skinny', 1, 2, '형용사', '[
    {"en":"The skinny cat needed more food.","ko":"그 깡마른 고양이는 음식이 더 필요했다."},
    {"en":"He was skinny before he started exercising.","ko":"그는 운동을 시작하기 전에는 말랐었다."},
    {"en":"She wore skinny jeans to the party.","ko":"그녀는 파티에 스키니 진을 입고 갔다."}
  ]'::jsonb),
  ('fit', 1, 2, '형용사/동사', '[
    {"en":"Running every morning keeps him fit.","ko":"매일 아침 달리기가 그를 건강하게 유지시킨다."},
    {"en":"These shoes fit me perfectly.","ko":"이 신발은 나에게 완벽하게 맞는다."},
    {"en":"She stays fit by playing badminton.","ko":"그녀는 배드민턴을 쳐서 건강을 유지한다."}
  ]'::jsonb),
  ('muscular', 1, 2, '형용사', '[
    {"en":"The swimmer has muscular arms.","ko":"그 수영 선수는 근육질의 팔을 가지고 있다."},
    {"en":"He became muscular after training all year.","ko":"그는 일 년 내내 훈련한 후 근육질이 되었다."},
    {"en":"The muscular horse pulled the heavy cart.","ko":"그 건장한 말은 무거운 수레를 끌었다."}
  ]'::jsonb),
  ('thin', 1, 2, '형용사', '[
    {"en":"The thin book was easy to carry.","ko":"그 얇은 책은 들고 다니기 쉬웠다."},
    {"en":"He looked thin after being sick for a week.","ko":"그는 일주일 동안 아픈 후 수척해 보였다."},
    {"en":"Her hair is thin but shiny.","ko":"그녀의 머리카락은 숱이 적지만 윤기가 있다."}
  ]'::jsonb),
  ('bald', 1, 2, '형용사', '[
    {"en":"My grandfather is bald and always wears a hat.","ko":"우리 할아버지는 대머리이셔서 항상 모자를 쓰신다."},
    {"en":"The bald eagle is a symbol of freedom.","ko":"대머리수리는 자유의 상징이다."},
    {"en":"He worried about going bald one day.","ko":"그는 언젠가 대머리가 될까 봐 걱정했다."}
  ]'::jsonb),
  ('curly', 1, 2, '형용사', '[
    {"en":"She has curly brown hair.","ko":"그녀는 곱슬거리는 갈색 머리를 가지고 있다."},
    {"en":"His curly hair gets messy in the rain.","ko":"그의 곱슬머리는 비가 오면 헝클어진다."},
    {"en":"I want to try a curly hairstyle.","ko":"나는 곱슬머리 스타일을 시도해 보고 싶다."}
  ]'::jsonb),
  ('dye', 1, 2, '동사', '[
    {"en":"She wants to dye her hair a different color.","ko":"그녀는 머리를 다른 색으로 염색하고 싶어 한다."},
    {"en":"He dyed the old T-shirt blue.","ko":"그는 오래된 티셔츠를 파란색으로 염색했다."},
    {"en":"My sister dyed her hair last weekend.","ko":"언니는 지난 주말에 머리를 염색했다."}
  ]'::jsonb),
  ('appearance', 1, 2, '명사', '[
    {"en":"Her appearance changed a lot after the haircut.","ko":"그녀의 외모는 머리를 자른 후 많이 바뀌었다."},
    {"en":"People shouldn''t judge others by their appearance.","ko":"사람들은 외모로 다른 사람을 판단해서는 안 된다."},
    {"en":"He was nervous about his appearance before the interview.","ko":"그는 면접 전에 자신의 외모에 대해 긴장했다."}
  ]'::jsonb),
  ('attractive', 1, 2, '형용사', '[
    {"en":"The park looks attractive in the autumn.","ko":"그 공원은 가을에 매력적으로 보인다."},
    {"en":"She has an attractive smile.","ko":"그녀는 매력적인 미소를 가지고 있다."},
    {"en":"The new design is attractive to students.","ko":"새로운 디자인은 학생들에게 매력적이다."}
  ]'::jsonb),
  ('charming', 1, 2, '형용사', '[
    {"en":"The small village is charming and peaceful.","ko":"그 작은 마을은 매력적이고 평화롭다."},
    {"en":"He has a charming personality.","ko":"그는 매력적인 성격을 가지고 있다."},
    {"en":"The charming cafe is popular with tourists.","ko":"그 매력적인 카페는 관광객들에게 인기가 있다."}
  ]'::jsonb),
  ('mustache', 1, 2, '명사', '[
    {"en":"My uncle has a thick mustache.","ko":"우리 삼촌은 짙은 콧수염을 가지고 있다."},
    {"en":"He grew a mustache for the school play.","ko":"그는 학교 연극을 위해 콧수염을 길렀다."},
    {"en":"The man with the mustache waved at us.","ko":"콧수염이 있는 남자가 우리에게 손을 흔들었다."}
  ]'::jsonb),
  ('sideburns', 1, 2, '명사', '[
    {"en":"The actor grew long sideburns for the movie role.","ko":"그 배우는 영화 배역을 위해 긴 구레나룻을 길렀다."},
    {"en":"His sideburns made him look older.","ko":"그의 구레나룻은 그를 더 나이 들어 보이게 했다."},
    {"en":"She thought the sideburns looked funny.","ko":"그녀는 그 구레나룻이 우스꽝스럽다고 생각했다."}
  ]'::jsonb),
  ('middle-aged', 1, 2, '형용사', '[
    {"en":"A middle-aged man was reading a newspaper on the bench.","ko":"중년 남자가 벤치에서 신문을 읽고 있었다."},
    {"en":"The middle-aged woman jogs every morning.","ko":"그 중년 여성은 매일 아침 조깅을 한다."},
    {"en":"Many middle-aged people enjoy hiking on weekends.","ko":"많은 중년들이 주말에 등산을 즐긴다."}
  ]'::jsonb),
  ('build', 1, 2, '명사/동사', '[
    {"en":"He has a strong build from playing sports.","ko":"그는 운동을 해서 체격이 좋다."},
    {"en":"They plan to build a new library next year.","ko":"그들은 내년에 새 도서관을 지을 계획이다."},
    {"en":"The workers will build a bridge over the river.","ko":"인부들은 강 위에 다리를 건설할 것이다."}
  ]'::jsonb),
  ('image', 1, 2, '명사', '[
    {"en":"The photo shows a clear image of the mountain.","ko":"그 사진은 산의 선명한 이미지를 보여 준다."},
    {"en":"She wants to improve her image at school.","ko":"그녀는 학교에서의 이미지를 개선하고 싶어 한다."},
    {"en":"The company changed its image with a new logo.","ko":"그 회사는 새 로고로 이미지를 바꿨다."}
  ]'::jsonb),
  ('grow up', 1, 2, '동사구', '[
    {"en":"I want to be a doctor when I grow up.","ko":"나는 자라면 의사가 되고 싶다."},
    {"en":"She grew up in a small town near the sea.","ko":"그녀는 바닷가 근처의 작은 마을에서 자랐다."},
    {"en":"Children grow up quickly.","ko":"아이들은 빠르게 자란다."}
  ]'::jsonb),
  ('both A and B', 1, 2, '접속사구', '[
    {"en":"Both my mother and my father like hiking.","ko":"어머니와 아버지 두 분 다 등산을 좋아하신다."},
    {"en":"She is good at both math and science.","ko":"그녀는 수학과 과학 둘 다 잘한다."},
    {"en":"Both my sister and I enjoy reading books.","ko":"언니와 나 둘 다 책 읽는 것을 좋아한다."}
  ]'::jsonb),
  ('enjoy', 1, 3, '동사', '[
    {"en":"I enjoy reading books on weekends.","ko":"나는 주말에 책 읽는 것을 즐긴다."},
    {"en":"She enjoys playing the piano after school.","ko":"그녀는 방과 후 피아노 치는 것을 즐긴다."},
    {"en":"We enjoyed the picnic in the park.","ko":"우리는 공원에서의 소풍을 즐겼다."}
  ]'::jsonb),
  ('cry', 1, 3, '동사', '[
    {"en":"The baby began to cry loudly.","ko":"아기가 크게 울기 시작했다."},
    {"en":"She tried not to cry during the movie.","ko":"그녀는 영화를 보는 동안 울지 않으려고 애썼다."},
    {"en":"He cried with joy when he won the prize.","ko":"그는 상을 받았을 때 기뻐서 울었다."}
  ]'::jsonb),
  ('glad', 1, 3, '형용사', '[
    {"en":"I am glad to see you again.","ko":"다시 만나서 기쁘다."},
    {"en":"She was glad about the good news.","ko":"그녀는 좋은 소식에 기뻐했다."},
    {"en":"We are glad that the weather is sunny today.","ko":"오늘 날씨가 화창해서 우리는 기쁘다."}
  ]'::jsonb),
  ('fear', 1, 3, '명사', '[
    {"en":"He has a fear of heights.","ko":"그는 높은 곳에 대한 공포가 있다."},
    {"en":"She overcame her fear of speaking in public.","ko":"그녀는 대중 앞에서 말하는 것에 대한 두려움을 극복했다."},
    {"en":"Fear kept him from trying new things.","ko":"두려움 때문에 그는 새로운 것을 시도하지 못했다."}
  ]'::jsonb),
  ('joy', 1, 3, '명사', '[
    {"en":"Playing with my dog brings me great joy.","ko":"강아지와 노는 것은 나에게 큰 기쁨을 준다."},
    {"en":"The children shouted with joy at the festival.","ko":"아이들은 축제에서 기쁨에 소리쳤다."},
    {"en":"Her face was full of joy after the trip.","ko":"여행 후 그녀의 얼굴은 기쁨으로 가득했다."}
  ]'::jsonb),
  ('miss', 1, 3, '동사', '[
    {"en":"I miss my grandmother who lives far away.","ko":"나는 멀리 사는 할머니가 그립다."},
    {"en":"Don''t miss the school bus this morning.","ko":"오늘 아침 스쿨버스를 놓치지 마라."},
    {"en":"She missed her hometown after moving to the city.","ko":"그녀는 도시로 이사한 후 고향을 그리워했다."}
  ]'::jsonb),
  ('laugh', 1, 3, '동사', '[
    {"en":"We laughed a lot during the comedy show.","ko":"우리는 코미디 쇼를 보는 동안 많이 웃었다."},
    {"en":"He laughs whenever he hears that joke.","ko":"그는 그 농담을 들을 때마다 웃는다."},
    {"en":"The whole class laughed at the funny video.","ko":"반 전체가 그 재미있는 영상을 보고 웃었다."}
  ]'::jsonb),
  ('mad', 1, 3, '형용사', '[
    {"en":"My mom got mad when I forgot my homework.","ko":"내가 숙제를 잊어버렸을 때 엄마는 몹시 화나셨다."},
    {"en":"He was mad about losing the game.","ko":"그는 경기에서 진 것에 몹시 화가 났다."},
    {"en":"Don''t get mad over small things.","ko":"사소한 일에 화내지 마라."}
  ]'::jsonb),
  ('annoyed', 1, 3, '형용사', '[
    {"en":"She felt annoyed by the loud noise.","ko":"그녀는 시끄러운 소음에 짜증이 났다."},
    {"en":"He looked annoyed when the bus was late.","ko":"그는 버스가 늦었을 때 짜증 난 표정이었다."},
    {"en":"I get annoyed when people are late.","ko":"나는 사람들이 늦을 때 짜증이 난다."}
  ]'::jsonb),
  ('upset', 1, 3, '형용사', '[
    {"en":"She was upset about losing her pencil case.","ko":"그녀는 필통을 잃어버려서 속상했다."},
    {"en":"He felt upset after the argument with his friend.","ko":"그는 친구와의 다툼 후 기분이 상했다."},
    {"en":"Don''t be upset over a small mistake.","ko":"작은 실수에 속상해하지 마라."}
  ]'::jsonb),
  ('worried', 1, 3, '형용사', '[
    {"en":"I am worried about the science exam.","ko":"나는 과학 시험이 걱정된다."},
    {"en":"She looked worried about her sick dog.","ko":"그녀는 아픈 강아지 때문에 걱정스러워 보였다."},
    {"en":"My parents were worried when I came home late.","ko":"내가 늦게 집에 왔을 때 부모님은 걱정하셨다."}
  ]'::jsonb),
  ('regret', 1, 3, '명사/동사', '[
    {"en":"He felt regret for not studying harder.","ko":"그는 더 열심히 공부하지 않은 것을 후회했다."},
    {"en":"I regret missing the school trip.","ko":"나는 학교 여행을 놓친 것을 후회한다."},
    {"en":"She has no regret about her decision.","ko":"그녀는 자신의 결정에 대해 후회가 없다."}
  ]'::jsonb),
  ('bother', 1, 3, '동사', '[
    {"en":"Please don''t bother your sister while she studies.","ko":"언니가 공부할 때 방해하지 마라."},
    {"en":"The noise from outside bothers me.","ko":"밖에서 나는 소음이 나를 괴롭힌다."},
    {"en":"He didn''t bother to explain the rules.","ko":"그는 규칙을 설명하는 수고를 하지 않았다."}
  ]'::jsonb),
  ('excited', 1, 3, '형용사', '[
    {"en":"We are excited about the field trip tomorrow.","ko":"우리는 내일 있을 현장 학습에 신이 난다."},
    {"en":"She was excited to see her old friend.","ko":"그녀는 오랜 친구를 만나게 되어 흥분했다."},
    {"en":"The kids got excited when it started to snow.","ko":"눈이 오기 시작하자 아이들은 신이 났다."}
  ]'::jsonb),
  ('surprised', 1, 3, '형용사', '[
    {"en":"I was surprised by the birthday party.","ko":"나는 생일 파티에 놀랐다."},
    {"en":"She looked surprised when she heard the news.","ko":"그녀는 그 소식을 들었을 때 놀란 표정이었다."},
    {"en":"He was surprised to get a perfect score.","ko":"그는 만점을 받아서 놀랐다."}
  ]'::jsonb),
  ('pleased', 1, 3, '형용사', '[
    {"en":"My teacher was pleased with my project.","ko":"선생님은 내 과제에 만족해하셨다."},
    {"en":"She seemed pleased with the gift.","ko":"그녀는 선물에 기뻐하는 것 같았다."},
    {"en":"We are pleased to welcome the new student.","ko":"우리는 새로운 학생을 반갑게 맞이한다."}
  ]'::jsonb),
  ('horrible', 1, 3, '형용사', '[
    {"en":"The weather was horrible during our trip.","ko":"여행하는 동안 날씨가 끔찍했다."},
    {"en":"He had a horrible headache yesterday.","ko":"그는 어제 끔찍한 두통이 있었다."},
    {"en":"It was a horrible experience to lose my bag.","ko":"가방을 잃어버린 것은 끔찍한 경험이었다."}
  ]'::jsonb),
  ('grateful', 1, 3, '형용사', '[
    {"en":"I am grateful for my family''s support.","ko":"나는 가족의 응원에 감사한다."},
    {"en":"She was grateful to her teacher for the advice.","ko":"그녀는 조언을 해 준 선생님께 감사했다."},
    {"en":"We felt grateful for the sunny weather during the picnic.","ko":"우리는 소풍 동안 화창한 날씨에 감사함을 느꼈다."}
  ]'::jsonb),
  ('anxious', 1, 3, '형용사', '[
    {"en":"He felt anxious before the piano recital.","ko":"그는 피아노 발표회 전에 걱정이 되었다."},
    {"en":"She was anxious about her test results.","ko":"그녀는 시험 결과에 대해 근심이 되었다."},
    {"en":"I get anxious when I speak in front of others.","ko":"나는 다른 사람들 앞에서 말할 때 불안해진다."}
  ]'::jsonb),
  ('delighted', 1, 3, '형용사', '[
    {"en":"She was delighted to receive the award.","ko":"그녀는 상을 받아서 매우 기뻐했다."},
    {"en":"We were delighted with the surprise party.","ko":"우리는 깜짝 파티에 매우 기뻐했다."},
    {"en":"He looked delighted when he saw the puppy.","ko":"그는 강아지를 보았을 때 매우 기뻐 보였다."}
  ]'::jsonb),
  ('depressed', 1, 3, '형용사', '[
    {"en":"He felt depressed after losing the match.","ko":"그는 경기에서 진 후 의기소침해졌다."},
    {"en":"She was depressed about the rainy weekend.","ko":"그녀는 비 오는 주말에 우울해했다."},
    {"en":"Talking with friends can help when you feel depressed.","ko":"우울할 때 친구들과 이야기하는 것이 도움이 될 수 있다."}
  ]'::jsonb),
  ('frightened', 1, 3, '형용사', '[
    {"en":"The child was frightened by the thunder.","ko":"그 아이는 천둥소리에 겁이 났다."},
    {"en":"She looked frightened during the scary story.","ko":"그녀는 무서운 이야기를 듣는 동안 겁먹은 표정이었다."},
    {"en":"The cat was frightened by the loud vacuum cleaner.","ko":"그 고양이는 시끄러운 진공청소기 소리에 놀랐다."}
  ]'::jsonb),
  ('ashamed', 1, 3, '형용사', '[
    {"en":"He felt ashamed of forgetting his friend''s birthday.","ko":"그는 친구의 생일을 잊어버린 것을 부끄러워했다."},
    {"en":"She was ashamed about her messy room.","ko":"그녀는 지저분한 방을 부끄러워했다."},
    {"en":"Don''t be ashamed of asking questions in class.","ko":"수업 중에 질문하는 것을 부끄러워하지 마라."}
  ]'::jsonb),
  ('emotion', 1, 3, '명사', '[
    {"en":"It is normal to show your emotion sometimes.","ko":"가끔 감정을 표현하는 것은 정상이다."},
    {"en":"The song expresses deep emotion.","ko":"그 노래는 깊은 감정을 표현한다."},
    {"en":"She controlled her emotion during the speech.","ko":"그녀는 연설 중에 감정을 조절했다."}
  ]'::jsonb),
  ('sympathy', 1, 3, '명사', '[
    {"en":"We showed sympathy for our injured classmate.","ko":"우리는 다친 반 친구에게 동정을 표했다."},
    {"en":"She felt sympathy for the lost puppy.","ko":"그녀는 길 잃은 강아지에게 동정심을 느꼈다."},
    {"en":"His kind words gave me sympathy and comfort.","ko":"그의 따뜻한 말은 나에게 동정과 위로를 주었다."}
  ]'::jsonb),
  ('satisfied', 1, 3, '형용사', '[
    {"en":"I am satisfied with my test score.","ko":"나는 내 시험 점수에 만족한다."},
    {"en":"She looked satisfied after finishing her project.","ko":"그녀는 프로젝트를 끝낸 후 만족스러워 보였다."},
    {"en":"He was satisfied with the delicious meal.","ko":"그는 맛있는 식사에 만족했다."}
  ]'::jsonb),
  ('disappointed', 1, 3, '형용사', '[
    {"en":"I was disappointed when the trip was canceled.","ko":"여행이 취소되어서 나는 실망했다."},
    {"en":"She felt disappointed about her low score.","ko":"그녀는 낮은 점수에 실망감을 느꼈다."},
    {"en":"Don''t be too disappointed if you lose the game.","ko":"경기에서 지더라도 너무 실망하지 마라."}
  ]'::jsonb),
  ('amused', 1, 3, '형용사', '[
    {"en":"The children were amused by the magic show.","ko":"아이들은 마술 쇼를 즐거워했다."},
    {"en":"She looked amused at his funny story.","ko":"그녀는 그의 재미있는 이야기에 즐거워 보였다."},
    {"en":"He was amused by the puppy''s playful behavior.","ko":"그는 강아지의 장난스러운 행동에 즐거워했다."}
  ]'::jsonb),
  ('calm down', 1, 3, '동사구', '[
    {"en":"Take a deep breath and calm down.","ko":"심호흡을 하고 진정해라."},
    {"en":"She helped her little brother calm down after he cried.","ko":"그녀는 남동생이 운 후 진정하도록 도왔다."},
    {"en":"It took him a few minutes to calm down.","ko":"그가 진정하는 데 몇 분이 걸렸다."}
  ]'::jsonb),
  ('feel sorry for', 1, 3, '동사구', '[
    {"en":"I feel sorry for the stray cat in the rain.","ko":"나는 빗속의 길고양이가 안쓰럽다."},
    {"en":"She felt sorry for her friend who was sick.","ko":"그녀는 아픈 친구를 안쓰럽게 여겼다."},
    {"en":"We feel sorry for people who lost their homes in the flood.","ko":"우리는 홍수로 집을 잃은 사람들을 안쓰럽게 여긴다."}
  ]'::jsonb),
  ('baker', 1, 4, '명사', '[
    {"en":"The baker makes fresh bread every morning.","ko":"그 제빵사는 매일 아침 신선한 빵을 만든다."},
    {"en":"My aunt works as a baker in town.","ko":"우리 이모는 마을에서 제빵사로 일하신다."},
    {"en":"The baker gave us a free cookie.","ko":"그 제빵사는 우리에게 무료 쿠키를 주었다."}
  ]'::jsonb),
  ('reporter', 1, 4, '명사', '[
    {"en":"The reporter interviewed the school principal.","ko":"그 기자는 교장 선생님을 인터뷰했다."},
    {"en":"She wants to become a reporter in the future.","ko":"그녀는 앞으로 기자가 되고 싶어 한다."},
    {"en":"A reporter wrote an article about our festival.","ko":"한 기자가 우리 축제에 관한 기사를 썼다."}
  ]'::jsonb),
  ('engineer', 1, 4, '명사', '[
    {"en":"My father is an engineer at a car company.","ko":"우리 아버지는 자동차 회사의 기술자이시다."},
    {"en":"She dreams of becoming an engineer someday.","ko":"그녀는 언젠가 기술자가 되기를 꿈꾼다."},
    {"en":"The engineer fixed the broken machine.","ko":"그 기사는 고장 난 기계를 고쳤다."}
  ]'::jsonb),
  ('scientist', 1, 4, '명사', '[
    {"en":"The scientist studies how plants grow.","ko":"그 과학자는 식물이 어떻게 자라는지 연구한다."},
    {"en":"She wants to be a scientist and discover new things.","ko":"그녀는 과학자가 되어 새로운 것을 발견하고 싶어 한다."},
    {"en":"A famous scientist visited our school.","ko":"유명한 과학자가 우리 학교를 방문했다."}
  ]'::jsonb),
  ('lawyer', 1, 4, '명사', '[
    {"en":"My cousin is studying to become a lawyer.","ko":"내 사촌은 변호사가 되기 위해 공부하고 있다."},
    {"en":"The lawyer explained the rules clearly.","ko":"그 변호사는 규칙을 명확히 설명했다."},
    {"en":"He works as a lawyer in the city.","ko":"그는 도시에서 변호사로 일한다."}
  ]'::jsonb),
  ('dentist', 1, 4, '명사', '[
    {"en":"I visited the dentist for a checkup.","ko":"나는 검진을 받으러 치과의사에게 방문했다."},
    {"en":"The dentist told me to brush twice a day.","ko":"치과의사는 나에게 하루에 두 번 양치질을 하라고 말했다."},
    {"en":"She works as a dentist near my house.","ko":"그녀는 우리 집 근처에서 치과의사로 일한다."}
  ]'::jsonb),
  ('mechanic', 1, 4, '명사', '[
    {"en":"The mechanic fixed our car quickly.","ko":"그 정비공은 우리 차를 빠르게 고쳤다."},
    {"en":"My uncle is a mechanic at a bicycle shop.","ko":"우리 삼촌은 자전거 가게의 정비공이다."},
    {"en":"The mechanic checked the engine carefully.","ko":"그 정비공은 엔진을 꼼꼼히 점검했다."}
  ]'::jsonb),
  ('architect', 1, 4, '명사', '[
    {"en":"The architect designed a beautiful library.","ko":"그 건축가는 아름다운 도서관을 설계했다."},
    {"en":"She wants to be an architect and design houses.","ko":"그녀는 건축가가 되어 집을 설계하고 싶어 한다."},
    {"en":"The architect showed us the plan for the new school.","ko":"그 건축가는 우리에게 새 학교의 설계도를 보여 주었다."}
  ]'::jsonb),
  ('officer', 1, 4, '명사', '[
    {"en":"The officer helped the lost child find his parents.","ko":"그 공무원은 길 잃은 아이가 부모를 찾도록 도왔다."},
    {"en":"My neighbor works as a government officer.","ko":"우리 이웃은 정부 공무원으로 일한다."},
    {"en":"The officer explained the new safety rules.","ko":"그 관리는 새로운 안전 규칙을 설명했다."}
  ]'::jsonb),
  ('gardener', 1, 4, '명사', '[
    {"en":"The gardener waters the flowers every day.","ko":"그 정원사는 매일 꽃에 물을 준다."},
    {"en":"My grandfather is a skilled gardener.","ko":"우리 할아버지는 숙련된 정원사이시다."},
    {"en":"The gardener planted new trees in the park.","ko":"그 정원사는 공원에 새 나무를 심었다."}
  ]'::jsonb),
  ('photographer', 1, 4, '명사', '[
    {"en":"The photographer took pictures of the school festival.","ko":"그 사진사는 학교 축제 사진을 찍었다."},
    {"en":"She wants to be a photographer and travel the world.","ko":"그녀는 사진작가가 되어 세계를 여행하고 싶어 한다."},
    {"en":"A photographer captured the beautiful sunset.","ko":"한 사진작가가 아름다운 노을을 사진에 담았다."}
  ]'::jsonb),
  ('president', 1, 4, '명사', '[
    {"en":"The president gave a speech about education.","ko":"대통령은 교육에 관한 연설을 했다."},
    {"en":"She was elected president of the student council.","ko":"그녀는 학생회장으로 선출되었다."},
    {"en":"The president visited our city last week.","ko":"대통령은 지난주에 우리 도시를 방문했다."}
  ]'::jsonb),
  ('salesperson', 1, 4, '명사', '[
    {"en":"The salesperson helped me choose new shoes.","ko":"그 판매원은 내가 새 신발을 고르는 것을 도와주었다."},
    {"en":"My mother works as a salesperson at a store.","ko":"우리 어머니는 가게에서 판매원으로 일하신다."},
    {"en":"The kind salesperson explained the product well.","ko":"그 친절한 판매원은 제품을 잘 설명해 주었다."}
  ]'::jsonb),
  ('carpenter', 1, 4, '명사', '[
    {"en":"The carpenter built a wooden table for us.","ko":"그 목수는 우리를 위해 나무 탁자를 만들었다."},
    {"en":"My grandfather used to work as a carpenter.","ko":"우리 할아버지는 예전에 목수로 일하셨다."},
    {"en":"The carpenter fixed the broken chair.","ko":"그 목수는 부서진 의자를 고쳤다."}
  ]'::jsonb),
  ('businessman', 1, 4, '명사', '[
    {"en":"The businessman started a small company.","ko":"그 사업가는 작은 회사를 시작했다."},
    {"en":"She admires her father, who is a successful businessman.","ko":"그녀는 성공한 사업가인 아버지를 존경한다."},
    {"en":"The businessman traveled to many countries for work.","ko":"그 사업가는 일 때문에 여러 나라를 여행했다."}
  ]'::jsonb),
  ('fisherman', 1, 4, '명사', '[
    {"en":"The fisherman goes out to sea every morning.","ko":"그 어부는 매일 아침 바다로 나간다."},
    {"en":"We met a friendly fisherman at the harbor.","ko":"우리는 항구에서 친절한 어부를 만났다."},
    {"en":"The fisherman caught many fish that day.","ko":"그 어부는 그날 많은 물고기를 잡았다."}
  ]'::jsonb),
  ('soldier', 1, 4, '명사', '[
    {"en":"The soldier protects our country.","ko":"그 군인은 우리나라를 지킨다."},
    {"en":"My grandfather was a soldier when he was young.","ko":"우리 할아버지는 젊었을 때 군인이셨다."},
    {"en":"The soldier helped villagers during the flood.","ko":"그 군인은 홍수 동안 마을 사람들을 도왔다."}
  ]'::jsonb),
  ('professor', 1, 4, '명사', '[
    {"en":"The professor teaches history at the university.","ko":"그 교수는 대학에서 역사를 가르친다."},
    {"en":"She wants to become a professor someday.","ko":"그녀는 언젠가 교수가 되고 싶어 한다."},
    {"en":"The professor gave an interesting lecture.","ko":"그 교수는 흥미로운 강의를 했다."}
  ]'::jsonb),
  ('judge', 1, 4, '명사/동사', '[
    {"en":"The judge listened carefully to both sides.","ko":"그 판사는 양쪽의 말을 주의 깊게 들었다."},
    {"en":"My aunt works as a judge in the city court.","ko":"우리 이모는 시 법원에서 판사로 일하신다."},
    {"en":"Please don''t judge people by their appearance.","ko":"사람들을 외모로 판단하지 마라."}
  ]'::jsonb),
  ('announcer', 1, 4, '명사', '[
    {"en":"The announcer read the news clearly.","ko":"그 아나운서는 뉴스를 또렷하게 읽었다."},
    {"en":"She dreams of becoming a sports announcer.","ko":"그녀는 스포츠 아나운서가 되기를 꿈꾼다."},
    {"en":"The announcer welcomed the guests to the event.","ko":"그 방송 진행자는 행사에 온 손님들을 환영했다."}
  ]'::jsonb),
  ('hairdresser', 1, 4, '명사', '[
    {"en":"The hairdresser cut my hair short.","ko":"그 미용사는 내 머리를 짧게 잘랐다."},
    {"en":"My sister works as a hairdresser downtown.","ko":"우리 언니는 시내에서 미용사로 일한다."},
    {"en":"The hairdresser gave me some tips for healthy hair.","ko":"그 미용사는 나에게 건강한 머리를 위한 조언을 해 주었다."}
  ]'::jsonb),
  ('accountant', 1, 4, '명사', '[
    {"en":"The accountant checks the company''s money carefully.","ko":"그 회계사는 회사의 돈을 꼼꼼히 점검한다."},
    {"en":"My father works as an accountant.","ko":"우리 아버지는 회계사로 일하신다."},
    {"en":"The accountant explained the budget to the team.","ko":"그 회계사는 팀에게 예산을 설명했다."}
  ]'::jsonb),
  ('novelist', 1, 4, '명사', '[
    {"en":"The novelist wrote a story about a young hero.","ko":"그 소설가는 어린 영웅에 관한 이야기를 썼다."},
    {"en":"She hopes to become a novelist someday.","ko":"그녀는 언젠가 소설가가 되기를 바란다."},
    {"en":"The famous novelist visited our library.","ko":"그 유명한 소설가는 우리 도서관을 방문했다."}
  ]'::jsonb),
  ('security guard', 1, 4, '명사구', '[
    {"en":"The security guard checks the gate every night.","ko":"그 경비원은 매일 밤 정문을 점검한다."},
    {"en":"My uncle works as a security guard at the museum.","ko":"우리 삼촌은 박물관에서 경비원으로 일하신다."},
    {"en":"The security guard helped us find the exit.","ko":"그 경비원은 우리가 출구를 찾도록 도와주었다."}
  ]'::jsonb),
  ('astronaut', 1, 4, '명사', '[
    {"en":"The astronaut talked about life in space.","ko":"그 우주비행사는 우주에서의 생활에 대해 이야기했다."},
    {"en":"She dreams of becoming an astronaut.","ko":"그녀는 우주비행사가 되기를 꿈꾼다."},
    {"en":"The astronaut trained for many years before the mission.","ko":"그 우주비행사는 임무 전에 여러 해 동안 훈련했다."}
  ]'::jsonb),
  ('detective', 1, 4, '명사', '[
    {"en":"The detective solved the mystery quickly.","ko":"그 탐정은 그 미스터리를 빠르게 해결했다."},
    {"en":"He likes to read detective stories.","ko":"그는 탐정 이야기를 읽는 것을 좋아한다."},
    {"en":"The detective asked careful questions.","ko":"그 탐정은 신중하게 질문했다."}
  ]'::jsonb),
  ('secretary', 1, 4, '명사', '[
    {"en":"The secretary organized the meeting schedule.","ko":"그 비서는 회의 일정을 정리했다."},
    {"en":"She works as a secretary at a school office.","ko":"그녀는 학교 사무실에서 비서로 일한다."},
    {"en":"The secretary answered the phone calls all day.","ko":"그 비서는 하루 종일 전화를 받았다."}
  ]'::jsonb),
  ('illustrator', 1, 4, '명사', '[
    {"en":"The illustrator drew pictures for the children''s book.","ko":"그 삽화가는 그 동화책을 위한 그림을 그렸다."},
    {"en":"She wants to be an illustrator when she grows up.","ko":"그녀는 자라서 삽화가가 되고 싶어 한다."},
    {"en":"The illustrator used bright colors in her drawings.","ko":"그 삽화가는 그림에 밝은 색을 사용했다."}
  ]'::jsonb),
  ('be good at', 1, 4, '동사구', '[
    {"en":"She is good at drawing pictures.","ko":"그녀는 그림 그리기를 잘한다."},
    {"en":"He is good at solving math problems.","ko":"그는 수학 문제 푸는 것을 잘한다."},
    {"en":"I am good at playing the guitar.","ko":"나는 기타 연주를 잘한다."}
  ]'::jsonb),
  ('be[become] interested in', 1, 4, '동사구', '[
    {"en":"I became interested in science after the class trip.","ko":"나는 현장 학습 후 과학에 흥미가 생겼다."},
    {"en":"She is interested in learning new languages.","ko":"그녀는 새로운 언어를 배우는 것에 관심이 있다."},
    {"en":"He became interested in cooking last year.","ko":"그는 작년에 요리에 관심을 가지게 되었다."}
  ]'::jsonb),
  ('pants', 1, 5, '명사', '[
    {"en":"He wore blue pants to school.","ko":"그는 학교에 파란색 바지를 입고 갔다."},
    {"en":"These pants are too long for me.","ko":"이 바지는 나에게 너무 길다."},
    {"en":"She bought new pants for the winter.","ko":"그녀는 겨울을 위해 새 바지를 샀다."}
  ]'::jsonb),
  ('sweater', 1, 5, '명사', '[
    {"en":"I wear a warm sweater in winter.","ko":"나는 겨울에 따뜻한 스웨터를 입는다."},
    {"en":"My grandmother knitted this sweater for me.","ko":"우리 할머니가 이 스웨터를 나에게 떠 주셨다."},
    {"en":"He put on a gray sweater this morning.","ko":"그는 오늘 아침 회색 스웨터를 입었다."}
  ]'::jsonb),
  ('skirt', 1, 5, '명사', '[
    {"en":"She wore a blue skirt to the party.","ko":"그녀는 파티에 파란색 치마를 입고 갔다."},
    {"en":"The skirt is part of our school uniform.","ko":"그 치마는 우리 교복의 일부이다."},
    {"en":"My mom bought a new skirt for the wedding.","ko":"우리 엄마는 결혼식을 위해 새 치마를 사셨다."}
  ]'::jsonb),
  ('tie', 1, 5, '명사/동사', '[
    {"en":"My father wears a tie to work every day.","ko":"우리 아버지는 매일 회사에 넥타이를 매고 가신다."},
    {"en":"Can you help me tie my shoes?","ko":"내 신발 끈 매는 것을 도와줄 수 있니?"},
    {"en":"He tied the rope tightly.","ko":"그는 밧줄을 단단히 묶었다."}
  ]'::jsonb),
  ('belt', 1, 5, '명사', '[
    {"en":"He wore a brown belt with his pants.","ko":"그는 바지에 갈색 벨트를 매고 있었다."},
    {"en":"The belt was too tight around his waist.","ko":"그 벨트는 허리에 너무 꽉 조였다."},
    {"en":"She bought a new belt for her uniform.","ko":"그녀는 교복을 위해 새 벨트를 샀다."}
  ]'::jsonb),
  ('uniform', 1, 5, '명사', '[
    {"en":"Students wear a uniform at our school.","ko":"우리 학교 학생들은 교복을 입는다."},
    {"en":"The soccer team has a new uniform this year.","ko":"그 축구팀은 올해 새 유니폼을 가지고 있다."},
    {"en":"He looked neat in his school uniform.","ko":"그는 교복을 입으니 단정해 보였다."}
  ]'::jsonb),
  ('socks', 1, 5, '명사', '[
    {"en":"I wear thick socks in winter.","ko":"나는 겨울에 두꺼운 양말을 신는다."},
    {"en":"She bought colorful socks at the market.","ko":"그녀는 시장에서 알록달록한 양말을 샀다."},
    {"en":"My socks got wet in the rain.","ko":"내 양말이 빗속에서 젖었다."}
  ]'::jsonb),
  ('material', 1, 5, '명사', '[
    {"en":"This jacket is made of soft material.","ko":"이 재킷은 부드러운 천으로 만들어져 있다."},
    {"en":"We collected material for our science project.","ko":"우리는 과학 과제를 위해 재료를 모았다."},
    {"en":"The bag is made of strong material.","ko":"그 가방은 튼튼한 재질로 만들어졌다."}
  ]'::jsonb),
  ('gloves', 1, 5, '명사', '[
    {"en":"Wear your gloves when it snows.","ko":"눈이 올 때는 장갑을 껴라."},
    {"en":"She lost one of her winter gloves.","ko":"그녀는 겨울 장갑 한 짝을 잃어버렸다."},
    {"en":"I bought warm gloves for the trip.","ko":"나는 여행을 위해 따뜻한 장갑을 샀다."}
  ]'::jsonb),
  ('boots', 1, 5, '명사', '[
    {"en":"He wore boots to walk in the snow.","ko":"그는 눈길을 걷기 위해 부츠를 신었다."},
    {"en":"She bought new boots for the winter hike.","ko":"그녀는 겨울 등산을 위해 새 부츠를 샀다."},
    {"en":"My boots got muddy after the walk.","ko":"산책 후 내 부츠가 진흙투성이가 되었다."}
  ]'::jsonb),
  ('dress', 1, 5, '명사/동사', '[
    {"en":"She wore a yellow dress to the festival.","ko":"그녀는 축제에 노란색 원피스를 입고 갔다."},
    {"en":"The children dress quickly before school.","ko":"아이들은 등교 전에 빠르게 옷을 입는다."},
    {"en":"My mother made a dress for my sister.","ko":"우리 어머니는 언니를 위해 원피스를 만드셨다."}
  ]'::jsonb),
  ('scarf', 1, 5, '명사', '[
    {"en":"He wore a scarf around his neck.","ko":"그는 목에 스카프를 둘렀다."},
    {"en":"She knitted a warm scarf for her mother.","ko":"그녀는 어머니를 위해 따뜻한 목도리를 떴다."},
    {"en":"I lost my scarf on the bus.","ko":"나는 버스에서 목도리를 잃어버렸다."}
  ]'::jsonb),
  ('jacket', 1, 5, '명사', '[
    {"en":"Wear your jacket because it is cold outside.","ko":"밖이 추우니 재킷을 입어라."},
    {"en":"He left his jacket at school.","ko":"그는 학교에 재킷을 두고 왔다."},
    {"en":"She bought a new jacket for the trip.","ko":"그녀는 여행을 위해 새 재킷을 샀다."}
  ]'::jsonb),
  ('shorts', 1, 5, '명사', '[
    {"en":"He wore shorts to play basketball.","ko":"그는 농구를 하기 위해 반바지를 입었다."},
    {"en":"These shorts are comfortable for running.","ko":"이 반바지는 달리기에 편하다."},
    {"en":"She packed shorts for the beach trip.","ko":"그녀는 해변 여행을 위해 반바지를 챙겼다."}
  ]'::jsonb),
  ('button', 1, 5, '명사/동사', '[
    {"en":"One button on his shirt was missing.","ko":"그의 셔츠 단추 하나가 없었다."},
    {"en":"Please button your coat before going outside.","ko":"밖에 나가기 전에 코트 단추를 채워라."},
    {"en":"She sewed a new button onto the jacket.","ko":"그녀는 재킷에 새 단추를 달았다."}
  ]'::jsonb),
  ('jeans', 1, 5, '명사', '[
    {"en":"He wore jeans and a T-shirt to the park.","ko":"그는 공원에 청바지와 티셔츠를 입고 갔다."},
    {"en":"These jeans fit me well.","ko":"이 청바지는 나에게 잘 맞는다."},
    {"en":"She bought a new pair of jeans.","ko":"그녀는 새 청바지를 샀다."}
  ]'::jsonb),
  ('suit', 1, 5, '명사/동사', '[
    {"en":"My father wore a suit to the meeting.","ko":"우리 아버지는 회의에 정장을 입고 가셨다."},
    {"en":"This color suits you very well.","ko":"이 색깔은 너에게 아주 잘 어울린다."},
    {"en":"He rented a suit for the graduation ceremony.","ko":"그는 졸업식을 위해 정장을 빌렸다."}
  ]'::jsonb),
  ('pocket', 1, 5, '명사', '[
    {"en":"She put her key in her pocket.","ko":"그녀는 열쇠를 주머니에 넣었다."},
    {"en":"He found a coin in his jacket pocket.","ko":"그는 재킷 주머니에서 동전을 발견했다."},
    {"en":"The bag has a small pocket for pens.","ko":"그 가방은 펜을 넣을 작은 주머니가 있다."}
  ]'::jsonb),
  ('bow tie', 1, 5, '명사구', '[
    {"en":"He wore a bow tie for the school concert.","ko":"그는 학교 음악회를 위해 나비넥타이를 맸다."},
    {"en":"The bow tie made him look formal.","ko":"그 나비넥타이는 그를 격식 있어 보이게 했다."},
    {"en":"She helped her brother put on his bow tie.","ko":"그녀는 남동생이 나비넥타이를 매는 것을 도와주었다."}
  ]'::jsonb),
  ('heels', 1, 5, '명사', '[
    {"en":"My mother wore heels to the wedding.","ko":"우리 어머니는 결혼식에 굽 높은 구두를 신으셨다."},
    {"en":"Walking in heels can be difficult at first.","ko":"굽 높은 구두를 신고 걷는 것은 처음에는 어려울 수 있다."},
    {"en":"She kept a pair of heels in her closet.","ko":"그녀는 옷장에 굽 높은 구두 한 켤레를 보관했다."}
  ]'::jsonb),
  ('stockings', 1, 5, '명사', '[
    {"en":"She wore white stockings with her school shoes.","ko":"그녀는 학교 신발과 흰색 스타킹을 신었다."},
    {"en":"The dancer''s stockings were bright pink.","ko":"그 무용수의 스타킹은 밝은 분홍색이었다."},
    {"en":"My grandmother knitted a pair of warm stockings.","ko":"우리 할머니는 따뜻한 스타킹 한 켤레를 떠 주셨다."}
  ]'::jsonb),
  ('sandals', 1, 5, '명사', '[
    {"en":"He wore sandals to the beach.","ko":"그는 해변에 샌들을 신고 갔다."},
    {"en":"These sandals are comfortable in summer.","ko":"이 샌들은 여름에 편하다."},
    {"en":"She bought new sandals for the trip.","ko":"그녀는 여행을 위해 새 샌들을 샀다."}
  ]'::jsonb),
  ('wallet', 1, 5, '명사', '[
    {"en":"He keeps his money in his wallet.","ko":"그는 지갑에 돈을 넣어 둔다."},
    {"en":"She lost her wallet at the market.","ko":"그녀는 시장에서 지갑을 잃어버렸다."},
    {"en":"My father bought a new leather wallet.","ko":"우리 아버지는 새 가죽 지갑을 사셨다."}
  ]'::jsonb),
  ('purse', 1, 5, '명사', '[
    {"en":"She carried a small purse to school.","ko":"그녀는 학교에 작은 지갑을 가지고 갔다."},
    {"en":"My grandmother keeps coins in her purse.","ko":"우리 할머니는 지갑에 동전을 넣어 두신다."},
    {"en":"She found her keys inside her purse.","ko":"그녀는 지갑 안에서 열쇠를 찾았다."}
  ]'::jsonb),
  ('vest', 1, 5, '명사', '[
    {"en":"He wore a vest over his shirt.","ko":"그는 셔츠 위에 조끼를 입었다."},
    {"en":"The safety vest is bright orange.","ko":"그 안전 조끼는 밝은 주황색이다."},
    {"en":"She knitted a warm vest for winter.","ko":"그녀는 겨울을 위해 따뜻한 조끼를 떴다."}
  ]'::jsonb),
  ('overalls', 1, 5, '명사', '[
    {"en":"The farmer wore overalls while working.","ko":"그 농부는 일하는 동안 멜빵 바지를 입었다."},
    {"en":"My little brother likes wearing overalls.","ko":"내 남동생은 멜빵 바지 입는 것을 좋아한다."},
    {"en":"She bought overalls for the garden work.","ko":"그녀는 정원 일을 위해 멜빵 바지를 샀다."}
  ]'::jsonb),
  ('athletic shoes', 1, 5, '명사구', '[
    {"en":"He wore athletic shoes for the race.","ko":"그는 경주를 위해 운동화를 신었다."},
    {"en":"These athletic shoes are light and comfortable.","ko":"이 운동화는 가볍고 편하다."},
    {"en":"She bought new athletic shoes for P.E. class.","ko":"그녀는 체육 수업을 위해 새 운동화를 샀다."}
  ]'::jsonb),
  ('put on', 1, 5, '동사구', '[
    {"en":"Put on your coat before you go outside.","ko":"밖에 나가기 전에 코트를 입어라."},
    {"en":"She put on her glasses to read the book.","ko":"그녀는 책을 읽기 위해 안경을 썼다."},
    {"en":"He put on his shoes quickly.","ko":"그는 신발을 빠르게 신었다."}
  ]'::jsonb),
  ('try on', 1, 5, '동사구', '[
    {"en":"Can I try on these shoes?","ko":"이 신발을 신어 봐도 될까요?"},
    {"en":"She tried on several dresses before choosing one.","ko":"그녀는 하나를 고르기 전에 여러 드레스를 입어 보았다."},
    {"en":"He tried on the jacket in the store.","ko":"그는 가게에서 재킷을 입어 보았다."}
  ]'::jsonb),
  ('take off', 1, 5, '동사구', '[
    {"en":"Please take off your shoes at the door.","ko":"문에서 신발을 벗어 주세요."},
    {"en":"The plane will take off soon.","ko":"비행기는 곧 이륙할 것이다."},
    {"en":"She took off her jacket because it was warm.","ko":"그녀는 따뜻해서 재킷을 벗었다."}
  ]'::jsonb),
  ('butter', 1, 6, '명사', '[
    {"en":"She spread butter on the toast.","ko":"그녀는 토스트에 버터를 발랐다."},
    {"en":"We need butter to bake the cookies.","ko":"우리는 쿠키를 굽기 위해 버터가 필요하다."},
    {"en":"The bread tastes better with butter.","ko":"그 빵은 버터를 바르면 더 맛있다."}
  ]'::jsonb),
  ('bread', 1, 6, '명사', '[
    {"en":"My mother bakes fresh bread every weekend.","ko":"우리 어머니는 주말마다 신선한 빵을 구우신다."},
    {"en":"He ate a slice of bread for breakfast.","ko":"그는 아침으로 빵 한 조각을 먹었다."},
    {"en":"The bakery sells warm bread every morning.","ko":"그 빵집은 매일 아침 따뜻한 빵을 판다."}
  ]'::jsonb),
  ('jam', 1, 6, '명사', '[
    {"en":"She made strawberry jam with her grandmother.","ko":"그녀는 할머니와 함께 딸기잼을 만들었다."},
    {"en":"I like jam on my toast.","ko":"나는 토스트에 잼을 발라 먹는 것을 좋아한다."},
    {"en":"We bought a jar of apple jam.","ko":"우리는 사과잼 한 병을 샀다."}
  ]'::jsonb),
  ('meat', 1, 6, '명사', '[
    {"en":"We had grilled meat for dinner.","ko":"우리는 저녁으로 구운 고기를 먹었다."},
    {"en":"She doesn''t eat meat on Mondays.","ko":"그녀는 월요일에는 고기를 먹지 않는다."},
    {"en":"The soup has small pieces of meat in it.","ko":"그 수프에는 작은 고기 조각들이 들어 있다."}
  ]'::jsonb),
  ('sugar', 1, 6, '명사', '[
    {"en":"Don''t add too much sugar to your tea.","ko":"차에 설탕을 너무 많이 넣지 마라."},
    {"en":"The recipe needs two cups of sugar.","ko":"그 조리법에는 설탕 두 컵이 필요하다."},
    {"en":"Too much sugar is not good for your health.","ko":"설탕을 너무 많이 먹는 것은 건강에 좋지 않다."}
  ]'::jsonb),
  ('salt', 1, 6, '명사', '[
    {"en":"Add a little salt to the soup.","ko":"수프에 소금을 조금 넣어라."},
    {"en":"She used salt to season the fish.","ko":"그녀는 생선에 간을 하기 위해 소금을 사용했다."},
    {"en":"Too much salt is bad for your health.","ko":"소금을 너무 많이 섭취하는 것은 건강에 나쁘다."}
  ]'::jsonb),
  ('soup', 1, 6, '명사', '[
    {"en":"My mother made warm soup for dinner.","ko":"우리 어머니는 저녁으로 따뜻한 수프를 만드셨다."},
    {"en":"I like vegetable soup in winter.","ko":"나는 겨울에 채소 수프를 좋아한다."},
    {"en":"We had soup and bread for lunch.","ko":"우리는 점심으로 수프와 빵을 먹었다."}
  ]'::jsonb),
  ('fish', 1, 6, '명사', '[
    {"en":"We had grilled fish for dinner.","ko":"우리는 저녁으로 구운 생선을 먹었다."},
    {"en":"He caught a fish at the lake.","ko":"그는 호수에서 물고기를 잡았다."},
    {"en":"My grandmother cooks fish every Friday.","ko":"우리 할머니는 매주 금요일 생선을 요리하신다."}
  ]'::jsonb),
  ('grab', 1, 6, '동사', '[
    {"en":"I grabbed a snack before leaving for school.","ko":"나는 학교에 가기 전에 간식을 간단히 먹었다."},
    {"en":"He grabbed his bag and ran to the bus stop.","ko":"그는 가방을 잡고 버스 정류장으로 뛰어갔다."},
    {"en":"She grabbed an apple on her way out.","ko":"그녀는 나가는 길에 사과를 하나 집었다."}
  ]'::jsonb),
  ('beef', 1, 6, '명사', '[
    {"en":"We cooked beef for the family dinner.","ko":"우리는 가족 저녁 식사를 위해 소고기를 요리했다."},
    {"en":"She doesn''t eat beef often.","ko":"그녀는 소고기를 자주 먹지 않는다."},
    {"en":"The soup was made with beef and vegetables.","ko":"그 수프는 소고기와 채소로 만들어졌다."}
  ]'::jsonb),
  ('steak', 1, 6, '명사', '[
    {"en":"My father grilled steak for our birthday dinner.","ko":"우리 아버지는 우리 생일 저녁을 위해 스테이크를 구우셨다."},
    {"en":"She ordered steak at the restaurant.","ko":"그녀는 식당에서 스테이크를 주문했다."},
    {"en":"The steak was cooked perfectly.","ko":"그 스테이크는 완벽하게 조리되었다."}
  ]'::jsonb),
  ('pork', 1, 6, '명사', '[
    {"en":"We had pork for dinner last night.","ko":"우리는 어젯밤 저녁으로 돼지고기를 먹었다."},
    {"en":"She doesn''t like the taste of pork.","ko":"그녀는 돼지고기 맛을 좋아하지 않는다."},
    {"en":"The chef grilled pork with vegetables.","ko":"요리사는 채소와 함께 돼지고기를 구웠다."}
  ]'::jsonb),
  ('pepper', 1, 6, '명사', '[
    {"en":"Add some pepper to the soup.","ko":"수프에 후추를 조금 넣어라."},
    {"en":"She grows pepper plants in her garden.","ko":"그녀는 정원에서 고추를 기른다."},
    {"en":"He sprinkled pepper on his eggs.","ko":"그는 달걀에 후추를 뿌렸다."}
  ]'::jsonb),
  ('diet', 1, 6, '명사', '[
    {"en":"A balanced diet is important for health.","ko":"균형 잡힌 식단은 건강에 중요하다."},
    {"en":"She started a healthy diet last month.","ko":"그녀는 지난달에 건강한 식이요법을 시작했다."},
    {"en":"Eating vegetables is part of a good diet.","ko":"채소를 먹는 것은 좋은 식단의 일부이다."}
  ]'::jsonb),
  ('snack', 1, 6, '명사', '[
    {"en":"I had a small snack after school.","ko":"나는 방과 후에 작은 간식을 먹었다."},
    {"en":"She packed a snack for the field trip.","ko":"그녀는 현장 학습을 위해 간식을 챙겼다."},
    {"en":"Fruit makes a healthy snack.","ko":"과일은 건강한 간식이 된다."}
  ]'::jsonb),
  ('egg', 1, 6, '명사', '[
    {"en":"She cooked an egg for breakfast.","ko":"그녀는 아침으로 달걀을 요리했다."},
    {"en":"We collected eggs from the henhouse.","ko":"우리는 닭장에서 달걀을 모았다."},
    {"en":"He likes to eat a boiled egg every morning.","ko":"그는 매일 아침 삶은 달걀을 먹는 것을 좋아한다."}
  ]'::jsonb),
  ('rice', 1, 6, '명사', '[
    {"en":"We eat rice with almost every meal.","ko":"우리는 거의 모든 식사에 밥을 먹는다."},
    {"en":"My grandmother cooks rice perfectly.","ko":"우리 할머니는 밥을 완벽하게 지으신다."},
    {"en":"She added vegetables to the fried rice.","ko":"그녀는 볶음밥에 채소를 넣었다."}
  ]'::jsonb),
  ('flour', 1, 6, '명사', '[
    {"en":"We mixed flour and water to make dough.","ko":"우리는 반죽을 만들기 위해 밀가루와 물을 섞었다."},
    {"en":"She bought a bag of flour for baking.","ko":"그녀는 제빵을 위해 밀가루 한 봉지를 샀다."},
    {"en":"The recipe calls for two cups of flour.","ko":"그 조리법에는 밀가루 두 컵이 필요하다."}
  ]'::jsonb),
  ('honey', 1, 6, '명사', '[
    {"en":"She put honey in her tea.","ko":"그녀는 차에 꿀을 넣었다."},
    {"en":"Bees make honey from flowers.","ko":"벌은 꽃에서 꿀을 만든다."},
    {"en":"I like honey on my toast.","ko":"나는 토스트에 꿀을 발라 먹는 것을 좋아한다."}
  ]'::jsonb),
  ('mustard', 1, 6, '명사', '[
    {"en":"He put mustard on his sandwich.","ko":"그는 샌드위치에 겨자를 발랐다."},
    {"en":"She doesn''t like the taste of mustard.","ko":"그녀는 겨자 맛을 좋아하지 않는다."},
    {"en":"We bought a small bottle of mustard.","ko":"우리는 겨자 작은 병을 하나 샀다."}
  ]'::jsonb),
  ('noodle', 1, 6, '명사', '[
    {"en":"We had noodle soup for lunch.","ko":"우리는 점심으로 국수 수프를 먹었다."},
    {"en":"She makes noodles by hand at home.","ko":"그녀는 집에서 손으로 국수를 만든다."},
    {"en":"I enjoy cold noodles in summer.","ko":"나는 여름에 차가운 국수를 즐긴다."}
  ]'::jsonb),
  ('pickle', 1, 6, '명사/동사', '[
    {"en":"She served pickles with the sandwich.","ko":"그녀는 샌드위치와 함께 피클을 냈다."},
    {"en":"My grandmother pickles cucumbers every summer.","ko":"우리 할머니는 매년 여름 오이를 절이신다."},
    {"en":"I like the sour taste of pickles.","ko":"나는 피클의 새콤한 맛을 좋아한다."}
  ]'::jsonb),
  ('stew', 1, 6, '명사', '[
    {"en":"We had warm stew on the cold day.","ko":"우리는 추운 날 따뜻한 스튜를 먹었다."},
    {"en":"My mother cooks vegetable stew every winter.","ko":"우리 어머니는 매년 겨울 채소 스튜를 요리하신다."},
    {"en":"The stew smelled delicious.","ko":"그 스튜는 맛있는 냄새가 났다."}
  ]'::jsonb),
  ('cereal', 1, 6, '명사/형용사', '[
    {"en":"He eats cereal with milk every morning.","ko":"그는 매일 아침 우유와 함께 시리얼을 먹는다."},
    {"en":"We bought a box of cereal at the store.","ko":"우리는 가게에서 시리얼 한 상자를 샀다."},
    {"en":"She prefers cereal grains for breakfast.","ko":"그녀는 아침으로 곡물 시리얼을 선호한다."}
  ]'::jsonb),
  ('meal', 1, 6, '명사', '[
    {"en":"We had a healthy meal together.","ko":"우리는 함께 건강한 식사를 했다."},
    {"en":"Breakfast is the most important meal of the day.","ko":"아침 식사는 하루 중 가장 중요한 식사이다."},
    {"en":"She prepared a simple meal for her family.","ko":"그녀는 가족을 위해 간단한 식사를 준비했다."}
  ]'::jsonb),
  ('side dish', 1, 6, '명사구', '[
    {"en":"We had rice with a few side dishes.","ko":"우리는 밥과 몇 가지 반찬을 먹었다."},
    {"en":"My mother made a new side dish for dinner.","ko":"우리 어머니는 저녁을 위해 새로운 반찬을 만드셨다."},
    {"en":"The restaurant serves many side dishes with the main meal.","ko":"그 식당은 주 요리와 함께 많은 반찬을 제공한다."}
  ]'::jsonb),
  ('appetizer', 1, 6, '명사', '[
    {"en":"We ordered soup as an appetizer.","ko":"우리는 애피타이저로 수프를 주문했다."},
    {"en":"The restaurant served a small appetizer first.","ko":"그 식당은 먼저 작은 애피타이저를 제공했다."},
    {"en":"She likes to try a new appetizer each time.","ko":"그녀는 매번 새로운 애피타이저를 시도해 보는 것을 좋아한다."}
  ]'::jsonb),
  ('powder', 1, 6, '명사', '[
    {"en":"She added powder to the cake mix.","ko":"그녀는 케이크 반죽에 가루를 넣었다."},
    {"en":"The recipe needs a spoon of baking powder.","ko":"그 조리법에는 베이킹파우더 한 스푼이 필요하다."},
    {"en":"He mixed the powder with water.","ko":"그는 가루를 물과 섞었다."}
  ]'::jsonb),
  ('set the table', 1, 6, '동사구', '[
    {"en":"Can you set the table before dinner?","ko":"저녁 식사 전에 상 좀 차려 줄래?"},
    {"en":"She set the table with plates and spoons.","ko":"그녀는 접시와 숟가락으로 식탁을 차렸다."},
    {"en":"We set the table together every evening.","ko":"우리는 매일 저녁 함께 식탁을 차린다."}
  ]'::jsonb),
  ('eat out', 1, 6, '동사구', '[
    {"en":"My family eats out once a month.","ko":"우리 가족은 한 달에 한 번 외식을 한다."},
    {"en":"We decided to eat out for my birthday.","ko":"우리는 내 생일에 외식을 하기로 결정했다."},
    {"en":"They eat out at a small restaurant near their house.","ko":"그들은 집 근처의 작은 식당에서 외식을 한다."}
  ]'::jsonb)
) as t(word, level, study_day, pos, examples)
where v.word = t.word and v.level = t.level and v.study_day = t.study_day;
