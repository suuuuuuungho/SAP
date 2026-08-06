-- SAP 1기 대시보드: Study 탭 — Lv.0(중등 BASIC) Day 10~17 품사/예문 채우기 (160단어).
-- Supabase 대시보드 → SQL Editor에서 실행하세요.

update public.vocab_words v
set part_of_speech = t.pos, example_sentences = t.examples, updated_at = now()
from (values
  ('idea', 0, 10, '명사', '[
    {"en":"I have a good idea for the school festival.","ko":"나는 학교 축제를 위한 좋은 생각이 있다."},
    {"en":"That''s a great idea!","ko":"그거 정말 좋은 생각이야!"},
    {"en":"She shared her idea with the class.","ko":"그녀는 자신의 생각을 반 친구들과 나누었다."}
  ]'::jsonb),
  ('dream', 0, 10, '명사', '[
    {"en":"I had a strange dream last night.","ko":"나는 어젯밤에 이상한 꿈을 꾸었다."},
    {"en":"Her dream is to become a doctor.","ko":"그녀의 꿈은 의사가 되는 것이다."},
    {"en":"Never give up on your dream.","ko":"네 꿈을 절대 포기하지 마."}
  ]'::jsonb),
  ('believe', 0, 10, '동사', '[
    {"en":"I believe you can do it.","ko":"나는 네가 할 수 있다고 믿어."},
    {"en":"Do you believe in ghosts?","ko":"너는 귀신을 믿니?"},
    {"en":"She believed his story.","ko":"그녀는 그의 이야기를 믿었다."}
  ]'::jsonb),
  ('think', 0, 10, '동사', '[
    {"en":"What do you think about this idea?","ko":"이 생각에 대해 어떻게 생각해?"},
    {"en":"I think it will rain tomorrow.","ko":"나는 내일 비가 올 것이라고 생각해."},
    {"en":"She thought about her future.","ko":"그녀는 자신의 미래에 대해 생각했다."}
  ]'::jsonb),
  ('know', 0, 10, '동사', '[
    {"en":"I know your sister.","ko":"나는 네 여동생을 알아."},
    {"en":"Do you know the answer?","ko":"너는 답을 알고 있니?"},
    {"en":"He knows a lot about history.","ko":"그는 역사에 대해 많이 알고 있다."}
  ]'::jsonb),
  ('need', 0, 10, '동사', '[
    {"en":"I need your help.","ko":"나는 네 도움이 필요해."},
    {"en":"We need more time to finish this.","ko":"우리는 이것을 끝내기 위해 더 많은 시간이 필요하다."},
    {"en":"Do you need a pencil?","ko":"연필이 필요하니?"}
  ]'::jsonb),
  ('hope', 0, 10, '동사', '[
    {"en":"I hope you feel better soon.","ko":"나는 네가 곧 나아지길 바라."},
    {"en":"We hope to visit Jeju Island this summer.","ko":"우리는 이번 여름에 제주도를 방문하길 바란다."},
    {"en":"She hopes for good weather tomorrow.","ko":"그녀는 내일 날씨가 좋기를 바란다."}
  ]'::jsonb),
  ('wish', 0, 10, '동사', '[
    {"en":"I wish you a happy birthday.","ko":"생일 축하해."},
    {"en":"He wished for a new bike.","ko":"그는 새 자전거를 소원했다."},
    {"en":"They wish for sunny weather on their trip.","ko":"그들은 여행에서 화창한 날씨를 소원한다."}
  ]'::jsonb),
  ('decide', 0, 10, '동사', '[
    {"en":"We decided to go hiking this weekend.","ko":"우리는 이번 주말에 하이킹을 가기로 결정했다."},
    {"en":"She decided to study science.","ko":"그녀는 과학을 공부하기로 결심했다."},
    {"en":"It is hard to decide what to eat.","ko":"무엇을 먹을지 결정하는 것은 어렵다."}
  ]'::jsonb),
  ('guess', 0, 10, '동사', '[
    {"en":"Can you guess my age?","ko":"내 나이를 맞혀볼 수 있어?"},
    {"en":"I guess it will be sunny tomorrow.","ko":"내일은 화창할 것 같아."},
    {"en":"She guessed the correct answer.","ko":"그녀는 정답을 맞혔다."}
  ]'::jsonb),
  ('forget', 0, 10, '동사', '[
    {"en":"Do not forget your umbrella.","ko":"네 우산을 잊지 마."},
    {"en":"I forgot his phone number.","ko":"나는 그의 전화번호를 잊어버렸다."},
    {"en":"She never forgets a birthday.","ko":"그녀는 생일을 절대 잊지 않는다."}
  ]'::jsonb),
  ('remember', 0, 10, '동사', '[
    {"en":"I remember my first day of school.","ko":"나는 학교 첫날을 기억한다."},
    {"en":"Do you remember her name?","ko":"그녀의 이름이 기억나니?"},
    {"en":"He remembered to bring his notebook.","ko":"그는 공책을 가져오는 것을 기억했다."}
  ]'::jsonb),
  ('wonder', 0, 10, '동사', '[
    {"en":"I wonder what the future will be like.","ko":"나는 미래가 어떨지 궁금하다."},
    {"en":"She wondered why he was late.","ko":"그녀는 그가 왜 늦었는지 궁금해했다."},
    {"en":"We wonder how the movie ends.","ko":"우리는 그 영화가 어떻게 끝나는지 궁금하다."}
  ]'::jsonb),
  ('keep', 0, 10, '동사', '[
    {"en":"Please keep this secret.","ko":"이 비밀을 지켜 주세요."},
    {"en":"He keeps his room clean.","ko":"그는 자신의 방을 깨끗하게 유지한다."},
    {"en":"She kept the letter for years.","ko":"그녀는 그 편지를 여러 해 동안 간직했다."}
  ]'::jsonb),
  ('understand', 0, 10, '동사', '[
    {"en":"I don''t understand this question.","ko":"나는 이 질문을 이해하지 못하겠다."},
    {"en":"Do you understand what she means?","ko":"그녀가 무슨 뜻인지 이해하니?"},
    {"en":"He understood the lesson quickly.","ko":"그는 그 수업을 빠르게 이해했다."}
  ]'::jsonb),
  ('plan', 0, 10, '명사', '[
    {"en":"What is your plan for the weekend?","ko":"이번 주말 계획이 뭐야?"},
    {"en":"We made a plan to clean the classroom.","ko":"우리는 교실을 청소할 계획을 세웠다."},
    {"en":"She has a plan to learn Chinese.","ko":"그녀는 중국어를 배울 계획이 있다."}
  ]'::jsonb),
  ('mind', 0, 10, '명사', '[
    {"en":"Keep your mind on your studies.","ko":"공부에 집중해."},
    {"en":"A healthy body makes a healthy mind.","ko":"건강한 신체가 건강한 정신을 만든다."},
    {"en":"Her mind was full of questions.","ko":"그녀의 마음은 질문으로 가득했다."}
  ]'::jsonb),
  ('question', 0, 10, '명사', '[
    {"en":"I have a question for you.","ko":"너에게 질문이 있어."},
    {"en":"The teacher asked a difficult question.","ko":"선생님은 어려운 질문을 하셨다."},
    {"en":"Please raise your hand if you have a question.","ko":"질문이 있으면 손을 들어 주세요."}
  ]'::jsonb),
  ('feel like -ing', 0, 10, '동사구', '[
    {"en":"I feel like eating pizza tonight.","ko":"나는 오늘 밤 피자가 먹고 싶다."},
    {"en":"She felt like dancing at the party.","ko":"그녀는 파티에서 춤을 추고 싶었다."},
    {"en":"Do you feel like going for a walk?","ko":"산책하러 가고 싶니?"}
  ]'::jsonb),
  ('give up', 0, 10, '동사구', '[
    {"en":"She never gives up, even in tough times.","ko":"그녀는 힘든 상황에서도 절대 포기하지 않는다."},
    {"en":"He didn''t give up even when it was hard.","ko":"그는 힘들 때도 포기하지 않았다."},
    {"en":"Don''t give up after just one try.","ko":"단 한 번의 시도 후에 포기하지 마."}
  ]'::jsonb),
  ('talk', 0, 11, '동사', '[
    {"en":"Can we talk for a minute?","ko":"우리 잠깐 이야기할 수 있을까?"},
    {"en":"She likes to talk about her hobbies.","ko":"그녀는 자신의 취미에 대해 이야기하는 것을 좋아한다."},
    {"en":"They talked about the school trip all day.","ko":"그들은 하루 종일 수학여행에 대해 이야기했다."}
  ]'::jsonb),
  ('speak', 0, 11, '동사', '[
    {"en":"She can speak three languages.","ko":"그녀는 세 개의 언어를 말할 수 있다."},
    {"en":"Please speak more slowly.","ko":"더 천천히 말씀해 주세요."},
    {"en":"He spoke to the class about his trip.","ko":"그는 반 친구들에게 자신의 여행에 대해 이야기했다."}
  ]'::jsonb),
  ('call', 0, 11, '동사', '[
    {"en":"I will call you tonight.","ko":"오늘 밤에 전화할게."},
    {"en":"She called her mother after school.","ko":"그녀는 방과 후에 엄마에게 전화했다."},
    {"en":"Please call me if you need help.","ko":"도움이 필요하면 나에게 전화해 줘."}
  ]'::jsonb),
  ('tell', 0, 11, '동사', '[
    {"en":"Can you tell me the way to the library?","ko":"도서관 가는 길을 알려줄 수 있어?"},
    {"en":"She told us an interesting story.","ko":"그녀는 우리에게 흥미로운 이야기를 해주었다."},
    {"en":"He told the truth about the broken window.","ko":"그는 깨진 창문에 대해 진실을 말했다."}
  ]'::jsonb),
  ('say', 0, 11, '동사', '[
    {"en":"What did she say to you?","ko":"그녀가 너에게 뭐라고 말했어?"},
    {"en":"He said hello to his new classmate.","ko":"그는 새 반 친구에게 인사했다."},
    {"en":"I don''t know what to say.","ko":"나는 무슨 말을 해야 할지 모르겠다."}
  ]'::jsonb),
  ('ask', 0, 11, '동사', '[
    {"en":"Can I ask you a question?","ko":"질문 하나 해도 될까요?"},
    {"en":"She asked the teacher for help.","ko":"그녀는 선생님께 도움을 요청했다."},
    {"en":"He asked me about my weekend.","ko":"그는 나에게 주말에 대해 물어보았다."}
  ]'::jsonb),
  ('answer', 0, 11, '동사', '[
    {"en":"Please answer the question.","ko":"질문에 답해 주세요."},
    {"en":"She answered the phone quickly.","ko":"그녀는 전화를 빠르게 받았다."},
    {"en":"He couldn''t answer the difficult question.","ko":"그는 그 어려운 질문에 답할 수 없었다."}
  ]'::jsonb),
  ('show', 0, 11, '동사', '[
    {"en":"Can you show me your notebook?","ko":"네 공책을 보여줄 수 있어?"},
    {"en":"She showed her paintings at the school fair.","ko":"그녀는 학교 축제에서 자신의 그림을 보여주었다."},
    {"en":"He showed great interest in science.","ko":"그는 과학에 큰 관심을 보였다."}
  ]'::jsonb),
  ('express', 0, 11, '동사', '[
    {"en":"It is important to express your feelings.","ko":"감정을 표현하는 것은 중요하다."},
    {"en":"She expressed her thanks to the volunteers.","ko":"그녀는 자원봉사자들에게 감사를 표현했다."},
    {"en":"He expressed his opinion during the discussion.","ko":"그는 토론 중에 자신의 의견을 표현했다."}
  ]'::jsonb),
  ('message', 0, 11, '명사', '[
    {"en":"I sent her a message this morning.","ko":"나는 오늘 아침 그녀에게 메시지를 보냈다."},
    {"en":"Did you get my message?","ko":"내 메시지 받았어?"},
    {"en":"The teacher left a message on the board.","ko":"선생님이 칠판에 메시지를 남기셨다."}
  ]'::jsonb),
  ('mean', 0, 11, '동사', '[
    {"en":"What does this word mean?","ko":"이 단어는 무슨 뜻이야?"},
    {"en":"I didn''t mean to hurt your feelings.","ko":"나는 네 기분을 상하게 할 의도는 없었어."},
    {"en":"She means what she says.","ko":"그녀는 자신이 하는 말을 진심으로 한다."}
  ]'::jsonb),
  ('discuss', 0, 11, '동사', '[
    {"en":"Let''s discuss the plan for the school trip.","ko":"수학여행 계획에 대해 논의해 보자."},
    {"en":"They discussed the problem for an hour.","ko":"그들은 한 시간 동안 그 문제에 대해 상의했다."},
    {"en":"We will discuss this topic in class.","ko":"우리는 수업 시간에 이 주제에 대해 논의할 것이다."}
  ]'::jsonb),
  ('explain', 0, 11, '동사', '[
    {"en":"Can you explain this math problem to me?","ko":"이 수학 문제를 나에게 설명해 줄 수 있어?"},
    {"en":"The teacher explained the rules clearly.","ko":"선생님은 규칙을 명확하게 설명해 주셨다."},
    {"en":"She explained why she was late.","ko":"그녀는 왜 늦었는지 설명했다."}
  ]'::jsonb),
  ('problem', 0, 11, '명사', '[
    {"en":"I have a problem with my computer.","ko":"내 컴퓨터에 문제가 있다."},
    {"en":"Let''s solve this problem together.","ko":"이 문제를 함께 해결하자."},
    {"en":"She has no problem making new friends.","ko":"그녀는 새 친구를 사귀는 데 아무 문제가 없다."}
  ]'::jsonb),
  ('agree', 0, 11, '동사', '[
    {"en":"I agree with your idea.","ko":"나는 네 생각에 동의해."},
    {"en":"We all agreed to meet at noon.","ko":"우리는 모두 정오에 만나기로 동의했다."},
    {"en":"She agreed to help clean the classroom.","ko":"그녀는 교실을 청소하는 것을 돕기로 동의했다."}
  ]'::jsonb),
  ('allow', 0, 11, '동사', '[
    {"en":"My parents allow me to use the computer on weekends.","ko":"부모님은 주말에 내가 컴퓨터를 사용하도록 허락하신다."},
    {"en":"Photos are not allowed in the museum.","ko":"박물관에서는 사진 촬영이 허용되지 않는다."},
    {"en":"The teacher allowed us to leave early.","ko":"선생님은 우리가 일찍 가는 것을 허락하셨다."}
  ]'::jsonb),
  ('accept', 0, 11, '동사', '[
    {"en":"She happily accepted the invitation.","ko":"그녀는 기쁘게 초대를 수락했다."},
    {"en":"He accepted his mistake and apologized.","ko":"그는 자신의 실수를 인정하고 사과했다."},
    {"en":"I accept your advice.","ko":"나는 네 조언을 받아들일게."}
  ]'::jsonb),
  ('promise', 0, 11, '동사', '[
    {"en":"I promise to call you tomorrow.","ko":"내일 전화할게 약속해."},
    {"en":"She promised to help her brother with his homework.","ko":"그녀는 남동생의 숙제를 도와주기로 약속했다."},
    {"en":"He promised not to be late again.","ko":"그는 다시는 늦지 않겠다고 약속했다."}
  ]'::jsonb),
  ('find out', 0, 11, '동사구', '[
    {"en":"I found out the truth about the mistake.","ko":"나는 그 실수에 대한 진실을 알아냈다."},
    {"en":"She found out that the museum was closed.","ko":"그녀는 박물관이 문을 닫았다는 것을 알아냈다."},
    {"en":"Let''s find out more about this topic.","ko":"이 주제에 대해 더 알아보자."}
  ]'::jsonb),
  ('say hello to', 0, 11, '동사구', '[
    {"en":"Please say hello to your family for me.","ko":"네 가족에게 안부 전해줘."},
    {"en":"She said hello to her new neighbor.","ko":"그녀는 새 이웃에게 인사했다."},
    {"en":"Say hello to your teacher when you see her.","ko":"선생님을 보면 인사드려."}
  ]'::jsonb),
  ('hear', 0, 12, '동사', '[
    {"en":"Did you hear that noise?","ko":"그 소리 들었어?"},
    {"en":"I heard good news today.","ko":"나는 오늘 좋은 소식을 들었다."},
    {"en":"She couldn''t hear him from across the room.","ko":"그녀는 방 건너편에서 그의 말을 들을 수 없었다."}
  ]'::jsonb),
  ('listen', 0, 12, '동사', '[
    {"en":"Listen to the music carefully.","ko":"음악을 주의 깊게 들어 봐."},
    {"en":"He listened to his teacher''s advice.","ko":"그는 선생님의 조언을 들었다."},
    {"en":"We listened to the birds singing in the garden.","ko":"우리는 정원에서 새들이 노래하는 것을 들었다."}
  ]'::jsonb),
  ('see', 0, 12, '동사', '[
    {"en":"I can see the mountain from my window.","ko":"나는 창문에서 산을 볼 수 있다."},
    {"en":"Did you see that movie?","ko":"그 영화 봤어?"},
    {"en":"She saw her friend at the park.","ko":"그녀는 공원에서 친구를 보았다."}
  ]'::jsonb),
  ('watch', 0, 12, '동사', '[
    {"en":"We watched a movie together last night.","ko":"우리는 어젯밤 함께 영화를 보았다."},
    {"en":"She likes to watch the stars at night.","ko":"그녀는 밤에 별을 보는 것을 좋아한다."},
    {"en":"Watch out for cars when you cross the street.","ko":"길을 건널 때 차를 조심해."}
  ]'::jsonb),
  ('look', 0, 12, '동사', '[
    {"en":"You look happy today.","ko":"너 오늘 행복해 보여."},
    {"en":"Look at the beautiful sunset.","ko":"아름다운 노을을 봐."},
    {"en":"She looked tired after the long walk.","ko":"그녀는 긴 산책 후 피곤해 보였다."}
  ]'::jsonb),
  ('voice', 0, 12, '명사', '[
    {"en":"She has a beautiful singing voice.","ko":"그녀는 아름다운 노래 목소리를 가지고 있다."},
    {"en":"I heard his voice from the hallway.","ko":"나는 복도에서 그의 목소리를 들었다."},
    {"en":"Please speak in a quiet voice in the library.","ko":"도서관에서는 조용한 목소리로 말해 주세요."}
  ]'::jsonb),
  ('feel', 0, 12, '동사', '[
    {"en":"I feel happy today.","ko":"나는 오늘 행복하다."},
    {"en":"She felt nervous before the test.","ko":"그녀는 시험 전에 긴장했다."},
    {"en":"How do you feel about the trip?","ko":"그 여행에 대해 어떻게 느끼니?"}
  ]'::jsonb),
  ('smell', 0, 12, '동사', '[
    {"en":"The soup smells delicious.","ko":"그 수프는 맛있는 냄새가 난다."},
    {"en":"The flowers smell sweet in the garden.","ko":"정원의 꽃들은 달콤한 냄새가 난다."},
    {"en":"I smelled fresh bread from the bakery.","ko":"나는 빵집에서 갓 구운 빵 냄새를 맡았다."}
  ]'::jsonb),
  ('sound', 0, 12, '동사', '[
    {"en":"That sounds like a great plan.","ko":"그거 좋은 계획처럼 들린다."},
    {"en":"The music sounded beautiful.","ko":"그 음악은 아름답게 들렸다."},
    {"en":"I heard a strange sound outside.","ko":"나는 밖에서 이상한 소리를 들었다."}
  ]'::jsonb),
  ('taste', 0, 12, '동사', '[
    {"en":"This cake tastes sweet.","ko":"이 케이크는 달콤한 맛이 난다."},
    {"en":"The soup tastes a little salty.","ko":"그 수프는 약간 짠맛이 난다."},
    {"en":"Can I taste your dessert?","ko":"네 디저트를 맛봐도 될까?"}
  ]'::jsonb),
  ('loud', 0, 12, '형용사', '[
    {"en":"The music was too loud.","ko":"음악이 너무 시끄러웠다."},
    {"en":"Please don''t talk in a loud voice in class.","ko":"수업 중에 큰 목소리로 이야기하지 마세요."},
    {"en":"The concert was loud but exciting.","ko":"그 콘서트는 시끄러웠지만 신났다."}
  ]'::jsonb),
  ('touch', 0, 12, '동사', '[
    {"en":"Don''t touch the wet paint.","ko":"젖은 페인트를 만지지 마."},
    {"en":"She gently touched the baby''s hand.","ko":"그녀는 아기의 손을 부드럽게 만졌다."},
    {"en":"Please don''t touch the paintings in the gallery.","ko":"미술관에서 그림을 만지지 마세요."}
  ]'::jsonb),
  ('soft', 0, 12, '형용사', '[
    {"en":"The blanket feels very soft.","ko":"그 담요는 매우 부드럽게 느껴진다."},
    {"en":"She spoke in a soft voice.","ko":"그녀는 부드러운 목소리로 말했다."},
    {"en":"The cat has soft fur.","ko":"그 고양이는 부드러운 털을 가지고 있다."}
  ]'::jsonb),
  ('hard', 0, 12, '형용사/부사', '[
    {"en":"The rock felt hard and cold.","ko":"그 바위는 단단하고 차가웠다."},
    {"en":"This math problem is really hard.","ko":"이 수학 문제는 정말 어렵다."},
    {"en":"He studies hard every day.","ko":"그는 매일 열심히 공부한다."}
  ]'::jsonb),
  ('sweet', 0, 12, '형용사', '[
    {"en":"The cake tastes very sweet.","ko":"그 케이크는 매우 달콤한 맛이 난다."},
    {"en":"She has a sweet smile.","ko":"그녀는 달콤한 미소를 가지고 있다."},
    {"en":"He said some sweet words to his grandmother.","ko":"그는 할머니께 다정한 말을 했다."}
  ]'::jsonb),
  ('sharp', 0, 12, '형용사', '[
    {"en":"Be careful, the knife is very sharp.","ko":"조심해, 그 칼은 매우 날카로워."},
    {"en":"The pencil has a sharp point.","ko":"그 연필은 뾰족한 끝을 가지고 있다."},
    {"en":"She has sharp eyes and notices everything.","ko":"그녀는 날카로운 눈을 가지고 있어서 모든 것을 알아챈다."}
  ]'::jsonb),
  ('same', 0, 12, '형용사', '[
    {"en":"We wear the same school uniform.","ko":"우리는 같은 교복을 입는다."},
    {"en":"They have the same birthday.","ko":"그들은 같은 생일이다."},
    {"en":"I feel the same way about this movie.","ko":"나도 이 영화에 대해 같은 생각이다."}
  ]'::jsonb),
  ('color', 0, 12, '명사', '[
    {"en":"What is your favorite color?","ko":"네가 가장 좋아하는 색깔은 뭐야?"},
    {"en":"The sky changed color at sunset.","ko":"하늘은 노을이 질 때 색이 변했다."},
    {"en":"She painted the wall a bright color.","ko":"그녀는 벽을 밝은 색으로 칠했다."}
  ]'::jsonb),
  ('be good at', 0, 12, '동사구', '[
    {"en":"He is good at playing basketball.","ko":"그는 농구를 잘한다."},
    {"en":"She is good at drawing.","ko":"그녀는 그림을 잘 그린다."},
    {"en":"I am good at math.","ko":"나는 수학을 잘한다."}
  ]'::jsonb),
  ('make a noise', 0, 12, '동사구', '[
    {"en":"Please don''t make a noise in the library.","ko":"도서관에서 소란을 피우지 마세요."},
    {"en":"The children were making a noise in the hallway.","ko":"아이들이 복도에서 시끄럽게 하고 있었다."},
    {"en":"Try not to make a noise when you come home late.","ko":"늦게 집에 올 때는 소리를 내지 않도록 해."}
  ]'::jsonb),
  ('visit', 0, 13, '동사', '[
    {"en":"We visited our grandparents last weekend.","ko":"우리는 지난 주말에 조부모님을 방문했다."},
    {"en":"I want to visit Jeju Island someday.","ko":"나는 언젠가 제주도를 방문하고 싶다."},
    {"en":"She visits the library every Saturday.","ko":"그녀는 매주 토요일 도서관을 방문한다."}
  ]'::jsonb),
  ('zoo', 0, 13, '명사', '[
    {"en":"We went to the zoo last Sunday.","ko":"우리는 지난 일요일에 동물원에 갔다."},
    {"en":"The zoo has many kinds of animals.","ko":"그 동물원에는 다양한 종류의 동물들이 있다."},
    {"en":"I saw a giraffe at the zoo.","ko":"나는 동물원에서 기린을 보았다."}
  ]'::jsonb),
  ('bank', 0, 13, '명사', '[
    {"en":"My father works at a bank.","ko":"우리 아빠는 은행에서 일하신다."},
    {"en":"She went to the bank to save her money.","ko":"그녀는 돈을 저금하러 은행에 갔다."},
    {"en":"The bank is next to the bookstore.","ko":"그 은행은 서점 옆에 있다."}
  ]'::jsonb),
  ('park', 0, 13, '명사', '[
    {"en":"We had a picnic in the park.","ko":"우리는 공원에서 소풍을 즐겼다."},
    {"en":"The children are playing in the park.","ko":"아이들이 공원에서 놀고 있다."},
    {"en":"There is a beautiful park near my house.","ko":"우리 집 근처에 아름다운 공원이 있다."}
  ]'::jsonb),
  ('airport', 0, 13, '명사', '[
    {"en":"We arrived at the airport early in the morning.","ko":"우리는 아침 일찍 공항에 도착했다."},
    {"en":"My uncle picked us up from the airport.","ko":"삼촌이 공항에서 우리를 데리러 오셨다."},
    {"en":"The airport was very crowded during the vacation.","ko":"방학 동안 공항은 매우 붐볐다."}
  ]'::jsonb),
  ('place', 0, 13, '명사', '[
    {"en":"This is a good place to relax.","ko":"이곳은 쉬기 좋은 장소이다."},
    {"en":"We visited many places during our trip.","ko":"우리는 여행 중에 많은 장소를 방문했다."},
    {"en":"The library is a quiet place to study.","ko":"도서관은 공부하기에 조용한 장소이다."}
  ]'::jsonb),
  ('town', 0, 13, '명사', '[
    {"en":"My grandmother lives in a small town.","ko":"우리 할머니는 작은 마을에 사신다."},
    {"en":"The whole town joined the festival.","ko":"온 마을 사람들이 축제에 참여했다."},
    {"en":"There is a nice bakery in our town.","ko":"우리 마을에는 멋진 빵집이 있다."}
  ]'::jsonb),
  ('village', 0, 13, '명사', '[
    {"en":"They live in a quiet village near the mountains.","ko":"그들은 산 근처의 조용한 마을에 산다."},
    {"en":"The village has a beautiful garden.","ko":"그 마을에는 아름다운 정원이 있다."},
    {"en":"We visited a small fishing village.","ko":"우리는 작은 어촌 마을을 방문했다."}
  ]'::jsonb),
  ('city', 0, 13, '명사', '[
    {"en":"Seoul is a big city.","ko":"서울은 큰 도시이다."},
    {"en":"I want to live in a large city someday.","ko":"나는 언젠가 큰 도시에서 살고 싶다."},
    {"en":"The city was full of tall buildings.","ko":"그 도시는 높은 건물들로 가득했다."}
  ]'::jsonb),
  ('bookstore', 0, 13, '명사', '[
    {"en":"I bought a novel at the bookstore.","ko":"나는 서점에서 소설을 샀다."},
    {"en":"There is a new bookstore near the station.","ko":"역 근처에 새로운 서점이 있다."},
    {"en":"She spends her weekends at the bookstore.","ko":"그녀는 주말을 서점에서 보낸다."}
  ]'::jsonb),
  ('market', 0, 13, '명사', '[
    {"en":"We bought fresh vegetables at the market.","ko":"우리는 시장에서 신선한 채소를 샀다."},
    {"en":"The market is open every morning.","ko":"그 시장은 매일 아침 문을 연다."},
    {"en":"My mother goes to the market twice a week.","ko":"우리 엄마는 일주일에 두 번 시장에 가신다."}
  ]'::jsonb),
  ('square', 0, 13, '명사', '[
    {"en":"People gathered in the square for the festival.","ko":"사람들이 축제를 위해 광장에 모였다."},
    {"en":"There is a fountain in the city square.","ko":"도시 광장에는 분수가 있다."},
    {"en":"We took a photo in front of the square.","ko":"우리는 광장 앞에서 사진을 찍었다."}
  ]'::jsonb),
  ('theater', 0, 13, '명사', '[
    {"en":"We watched a play at the theater.","ko":"우리는 극장에서 연극을 보았다."},
    {"en":"The theater was full of people.","ko":"그 극장은 사람들로 가득했다."},
    {"en":"My family goes to the theater every month.","ko":"우리 가족은 매달 극장에 간다."}
  ]'::jsonb),
  ('bakery', 0, 13, '명사', '[
    {"en":"The bakery sells fresh bread every morning.","ko":"그 빵집은 매일 아침 신선한 빵을 판다."},
    {"en":"I smelled sweet bread from the bakery.","ko":"나는 빵집에서 달콤한 빵 냄새를 맡았다."},
    {"en":"We stopped by the bakery after school.","ko":"우리는 방과 후에 빵집에 들렀다."}
  ]'::jsonb),
  ('space', 0, 13, '명사', '[
    {"en":"There isn''t much space in this room.","ko":"이 방에는 공간이 많지 않다."},
    {"en":"Scientists study space and the stars.","ko":"과학자들은 우주와 별을 연구한다."},
    {"en":"We need more space for the books.","ko":"우리는 책을 위한 더 많은 공간이 필요하다."}
  ]'::jsonb),
  ('station', 0, 13, '명사', '[
    {"en":"The bus station is near my school.","ko":"버스 정류장은 우리 학교 근처에 있다."},
    {"en":"We waited for the train at the station.","ko":"우리는 역에서 기차를 기다렸다."},
    {"en":"My father takes the subway from this station.","ko":"우리 아빠는 이 역에서 지하철을 타신다."}
  ]'::jsonb),
  ('museum', 0, 13, '명사', '[
    {"en":"We visited a history museum last weekend.","ko":"우리는 지난 주말에 역사 박물관을 방문했다."},
    {"en":"The museum has many interesting exhibits.","ko":"그 박물관에는 흥미로운 전시물이 많다."},
    {"en":"Photos are not allowed inside the museum.","ko":"박물관 내부에서는 사진 촬영이 허용되지 않는다."}
  ]'::jsonb),
  ('gallery', 0, 13, '명사', '[
    {"en":"We saw beautiful paintings at the gallery.","ko":"우리는 미술관에서 아름다운 그림들을 보았다."},
    {"en":"The art gallery is open on weekends.","ko":"그 미술관은 주말에 문을 연다."},
    {"en":"She wants to be an artist and show her work in a gallery.","ko":"그녀는 화가가 되어 미술관에서 자신의 작품을 보여주고 싶어 한다."}
  ]'::jsonb),
  ('line up', 0, 13, '동사구', '[
    {"en":"Please line up for the school bus.","ko":"스쿨버스를 타기 위해 줄을 서 주세요."},
    {"en":"The students lined up in front of the gym.","ko":"학생들은 체육관 앞에 줄을 섰다."},
    {"en":"We lined up to buy tickets for the movie.","ko":"우리는 영화표를 사기 위해 줄을 섰다."}
  ]'::jsonb),
  ('stop by', 0, 13, '동사구', '[
    {"en":"Let''s stop by the bakery on our way home.","ko":"집에 가는 길에 빵집에 들르자."},
    {"en":"She stopped by my house yesterday.","ko":"그녀는 어제 우리 집에 잠시 들렀다."},
    {"en":"I will stop by the library after school.","ko":"나는 방과 후에 도서관에 잠시 들를 것이다."}
  ]'::jsonb),
  ('wall', 0, 14, '명사', '[
    {"en":"There is a big clock on the wall.","ko":"벽에 큰 시계가 걸려 있다."},
    {"en":"She hung her paintings on the wall.","ko":"그녀는 벽에 그림을 걸었다."},
    {"en":"The children drew pictures on the classroom wall.","ko":"아이들은 교실 벽에 그림을 그렸다."}
  ]'::jsonb),
  ('garden', 0, 14, '명사', '[
    {"en":"My grandmother grows flowers in her garden.","ko":"우리 할머니는 정원에서 꽃을 기르신다."},
    {"en":"She reads books in the garden every afternoon.","ko":"그녀는 매일 오후 정원에서 책을 읽는다."},
    {"en":"There are many trees in the garden.","ko":"정원에는 나무가 많다."}
  ]'::jsonb),
  ('bathroom', 0, 14, '명사', '[
    {"en":"Please clean the bathroom before dinner.","ko":"저녁 식사 전에 화장실을 청소해 주세요."},
    {"en":"The bathroom is at the end of the hall.","ko":"화장실은 복도 끝에 있다."},
    {"en":"He washed his hands in the bathroom.","ko":"그는 화장실에서 손을 씻었다."}
  ]'::jsonb),
  ('stair', 0, 14, '명사', '[
    {"en":"Be careful on the stairs.","ko":"계단에서 조심하세요."},
    {"en":"She ran up the stairs to her room.","ko":"그녀는 자신의 방으로 계단을 뛰어 올라갔다."},
    {"en":"The stairs lead to the second floor.","ko":"그 계단은 2층으로 이어진다."}
  ]'::jsonb),
  ('wash', 0, 14, '동사', '[
    {"en":"I wash my hands before every meal.","ko":"나는 매 식사 전에 손을 씻는다."},
    {"en":"She washed the dishes after dinner.","ko":"그녀는 저녁 식사 후 설거지를 했다."},
    {"en":"Please wash your face in the morning.","ko":"아침에 세수를 하세요."}
  ]'::jsonb),
  ('gate', 0, 14, '명사', '[
    {"en":"The school gate opens at eight.","ko":"학교 정문은 8시에 열린다."},
    {"en":"We met in front of the gate.","ko":"우리는 문 앞에서 만났다."},
    {"en":"He closed the garden gate carefully.","ko":"그는 정원 문을 조심스럽게 닫았다."}
  ]'::jsonb),
  ('umbrella', 0, 14, '명사', '[
    {"en":"Don''t forget your umbrella; it might rain.","ko":"우산 챙기는 거 잊지 마, 비가 올지도 몰라."},
    {"en":"She shared her umbrella with her friend.","ko":"그녀는 친구와 우산을 함께 썼다."},
    {"en":"I left my umbrella on the bus.","ko":"나는 버스에 우산을 두고 내렸다."}
  ]'::jsonb),
  ('roof', 0, 14, '명사', '[
    {"en":"Snow covered the roof of the house.","ko":"눈이 집 지붕을 덮었다."},
    {"en":"We watched the stars from the roof.","ko":"우리는 지붕에서 별을 보았다."},
    {"en":"The roof was painted blue.","ko":"그 지붕은 파란색으로 칠해져 있었다."}
  ]'::jsonb),
  ('kitchen', 0, 14, '명사', '[
    {"en":"My mother is cooking in the kitchen.","ko":"우리 엄마는 부엌에서 요리를 하고 계신다."},
    {"en":"The kitchen smells like fresh bread.","ko":"부엌에서 갓 구운 빵 냄새가 난다."},
    {"en":"We cleaned the kitchen together after dinner.","ko":"우리는 저녁 식사 후 함께 부엌을 청소했다."}
  ]'::jsonb),
  ('refrigerator', 0, 14, '명사', '[
    {"en":"There is some juice in the refrigerator.","ko":"냉장고에 주스가 좀 있다."},
    {"en":"Please put the milk back in the refrigerator.","ko":"우유를 냉장고에 다시 넣어 주세요."},
    {"en":"The refrigerator was full of fresh vegetables.","ko":"냉장고는 신선한 채소로 가득했다."}
  ]'::jsonb),
  ('floor', 0, 14, '명사', '[
    {"en":"My classroom is on the third floor.","ko":"우리 교실은 3층에 있다."},
    {"en":"The cat is sleeping on the floor.","ko":"고양이가 바닥에서 자고 있다."},
    {"en":"She dropped her pencil on the floor.","ko":"그녀는 연필을 바닥에 떨어뜨렸다."}
  ]'::jsonb),
  ('living room', 0, 14, '명사구', '[
    {"en":"We watch TV together in the living room.","ko":"우리는 거실에서 함께 TV를 본다."},
    {"en":"The living room was decorated for the party.","ko":"거실은 파티를 위해 장식되어 있었다."},
    {"en":"My cat likes to sleep in the living room.","ko":"우리 고양이는 거실에서 자는 것을 좋아한다."}
  ]'::jsonb),
  ('bedroom', 0, 14, '명사', '[
    {"en":"My bedroom is small but cozy.","ko":"내 침실은 작지만 아늑하다."},
    {"en":"She cleaned her bedroom on Saturday.","ko":"그녀는 토요일에 자신의 침실을 청소했다."},
    {"en":"There are two beds in my bedroom.","ko":"내 침실에는 침대가 두 개 있다."}
  ]'::jsonb),
  ('address', 0, 14, '명사', '[
    {"en":"Can you tell me your address?","ko":"네 주소를 알려줄 수 있어?"},
    {"en":"She wrote her address on the letter.","ko":"그녀는 편지에 자신의 주소를 적었다."},
    {"en":"I don''t remember his new address.","ko":"나는 그의 새 주소가 기억나지 않는다."}
  ]'::jsonb),
  ('stay', 0, 14, '동사', '[
    {"en":"We stayed at my aunt''s house last weekend.","ko":"우리는 지난 주말에 이모 댁에 머물렀다."},
    {"en":"Please stay calm during the fire drill.","ko":"화재 훈련 중에는 침착하게 있어 주세요."},
    {"en":"She stayed home because she felt sick.","ko":"그녀는 몸이 아파서 집에 있었다."}
  ]'::jsonb),
  ('garbage', 0, 14, '명사', '[
    {"en":"Please take out the garbage.","ko":"쓰레기를 좀 내다 놓아 줘."},
    {"en":"The garbage can was full.","ko":"쓰레기통이 가득 찼다."},
    {"en":"We should not throw garbage on the street.","ko":"우리는 거리에 쓰레기를 버리면 안 된다."}
  ]'::jsonb),
  ('housework', 0, 14, '명사', '[
    {"en":"My family shares the housework.","ko":"우리 가족은 집안일을 나누어 한다."},
    {"en":"She helps her mother with the housework every day.","ko":"그녀는 매일 엄마의 집안일을 돕는다."},
    {"en":"Doing housework can be tiring.","ko":"집안일을 하는 것은 힘들 수 있다."}
  ]'::jsonb),
  ('comfortable', 0, 14, '형용사', '[
    {"en":"This chair is very comfortable.","ko":"이 의자는 매우 편안하다."},
    {"en":"I feel comfortable in my own room.","ko":"나는 내 방에서 편안함을 느낀다."},
    {"en":"She wore comfortable shoes for the walk.","ko":"그녀는 산책을 위해 편안한 신발을 신었다."}
  ]'::jsonb),
  ('turn off', 0, 14, '동사구', '[
    {"en":"Please turn off the light before you leave.","ko":"나가기 전에 불을 꺼 주세요."},
    {"en":"He turned off the TV and went to bed.","ko":"그는 TV를 끄고 잠자리에 들었다."},
    {"en":"Don''t forget to turn off the computer.","ko":"컴퓨터 끄는 것을 잊지 마."}
  ]'::jsonb),
  ('go to bed', 0, 14, '동사구', '[
    {"en":"I go to bed at ten every night.","ko":"나는 매일 밤 10시에 잠자리에 든다."},
    {"en":"She went to bed early because she was tired.","ko":"그녀는 피곤해서 일찍 잠자리에 들었다."},
    {"en":"It''s late; you should go to bed now.","ko":"늦었어, 이제 자러 가야 해."}
  ]'::jsonb),
  ('salt', 0, 15, '명사', '[
    {"en":"Please pass me the salt.","ko":"소금 좀 건네줘."},
    {"en":"The soup needs a little more salt.","ko":"그 수프는 소금이 좀 더 필요하다."},
    {"en":"She added a pinch of salt to the sauce.","ko":"그녀는 소스에 소금 한 꼬집을 넣었다."}
  ]'::jsonb),
  ('sugar', 0, 15, '명사', '[
    {"en":"I don''t take sugar in my tea.","ko":"나는 차에 설탕을 넣지 않는다."},
    {"en":"The recipe needs two spoons of sugar.","ko":"그 요리법에는 설탕 두 스푼이 필요하다."},
    {"en":"Too much sugar isn''t good for your health.","ko":"설탕을 너무 많이 먹는 것은 건강에 좋지 않다."}
  ]'::jsonb),
  ('meat', 0, 15, '명사', '[
    {"en":"She doesn''t eat meat.","ko":"그녀는 고기를 먹지 않는다."},
    {"en":"We had meat and rice for dinner.","ko":"우리는 저녁으로 고기와 밥을 먹었다."},
    {"en":"The chef cooked the meat carefully.","ko":"그 요리사는 고기를 정성껏 요리했다."}
  ]'::jsonb),
  ('snack', 0, 15, '명사', '[
    {"en":"I usually have a snack after school.","ko":"나는 보통 방과 후에 간식을 먹는다."},
    {"en":"She packed some snacks for the trip.","ko":"그녀는 여행을 위해 간식을 좀 챙겼다."},
    {"en":"Fruit is a healthy snack.","ko":"과일은 건강한 간식이다."}
  ]'::jsonb),
  ('fresh', 0, 15, '형용사', '[
    {"en":"These vegetables are very fresh.","ko":"이 채소들은 매우 신선하다."},
    {"en":"We bought fresh fruit at the market.","ko":"우리는 시장에서 신선한 과일을 샀다."},
    {"en":"The morning air felt fresh.","ko":"아침 공기는 상쾌했다."}
  ]'::jsonb),
  ('sauce', 0, 15, '명사', '[
    {"en":"This sauce tastes a little spicy.","ko":"이 소스는 조금 매운맛이 난다."},
    {"en":"She poured sauce over the pasta.","ko":"그녀는 파스타에 소스를 부었다."},
    {"en":"My mother made a sweet sauce for the salad.","ko":"우리 엄마는 샐러드용 달콤한 소스를 만드셨다."}
  ]'::jsonb),
  ('rice', 0, 15, '명사', '[
    {"en":"We eat rice almost every day.","ko":"우리는 거의 매일 밥을 먹는다."},
    {"en":"She cooked rice for dinner.","ko":"그녀는 저녁으로 밥을 지었다."},
    {"en":"Rice is grown in the field near our town.","ko":"쌀은 우리 마을 근처 논에서 재배된다."}
  ]'::jsonb),
  ('bottle', 0, 15, '명사', '[
    {"en":"Please bring a bottle of water.","ko":"물 한 병을 가져와 줘."},
    {"en":"He filled the bottle with juice.","ko":"그는 그 병을 주스로 채웠다."},
    {"en":"She recycled the empty bottle.","ko":"그녀는 빈 병을 재활용했다."}
  ]'::jsonb),
  ('heat', 0, 15, '동사', '[
    {"en":"Heat the soup before you eat it.","ko":"먹기 전에 수프를 데워라."},
    {"en":"She heated the milk in a pot.","ko":"그녀는 냄비에 우유를 데웠다."},
    {"en":"We felt the heat from the oven.","ko":"우리는 오븐에서 나오는 열기를 느꼈다."}
  ]'::jsonb),
  ('bake', 0, 15, '동사', '[
    {"en":"My mother baked cookies for us.","ko":"우리 엄마는 우리를 위해 쿠키를 구워 주셨다."},
    {"en":"We baked bread together on the weekend.","ko":"우리는 주말에 함께 빵을 구웠다."},
    {"en":"She loves to bake cakes for her friends.","ko":"그녀는 친구들을 위해 케이크를 굽는 것을 좋아한다."}
  ]'::jsonb),
  ('meal', 0, 15, '명사', '[
    {"en":"Breakfast is the most important meal of the day.","ko":"아침 식사는 하루 중 가장 중요한 식사이다."},
    {"en":"We had a delicious meal together.","ko":"우리는 함께 맛있는 식사를 했다."},
    {"en":"She cooks a healthy meal every evening.","ko":"그녀는 매일 저녁 건강한 식사를 요리한다."}
  ]'::jsonb),
  ('cook', 0, 15, '동사', '[
    {"en":"My father cooks dinner on Sundays.","ko":"우리 아빠는 일요일마다 저녁을 요리하신다."},
    {"en":"She learned how to cook from her grandmother.","ko":"그녀는 할머니에게서 요리하는 법을 배웠다."},
    {"en":"We cooked pasta for the party.","ko":"우리는 파티를 위해 파스타를 요리했다."}
  ]'::jsonb),
  ('mix', 0, 15, '동사', '[
    {"en":"Mix the flour and sugar together.","ko":"밀가루와 설탕을 함께 섞어라."},
    {"en":"She mixed the salad with her hands.","ko":"그녀는 손으로 샐러드를 섞었다."},
    {"en":"Don''t mix these two colors.","ko":"이 두 색깔을 섞지 마."}
  ]'::jsonb),
  ('pour', 0, 15, '동사', '[
    {"en":"Please pour some juice for me.","ko":"저에게 주스 좀 따라 주세요."},
    {"en":"She poured water into the cup.","ko":"그녀는 컵에 물을 부었다."},
    {"en":"He poured the sauce over the rice.","ko":"그는 밥 위에 소스를 부었다."}
  ]'::jsonb),
  ('melt', 0, 15, '동사', '[
    {"en":"The ice cream melted in the sun.","ko":"아이스크림이 햇빛에 녹았다."},
    {"en":"She melted the butter in a pan.","ko":"그녀는 팬에 버터를 녹였다."},
    {"en":"The snow began to melt in spring.","ko":"눈은 봄이 되자 녹기 시작했다."}
  ]'::jsonb),
  ('delicious', 0, 15, '형용사', '[
    {"en":"This soup is really delicious.","ko":"이 수프는 정말 맛있다."},
    {"en":"My grandmother makes delicious rice cakes.","ko":"우리 할머니는 맛있는 떡을 만드신다."},
    {"en":"The cake smelled delicious.","ko":"그 케이크는 맛있는 냄새가 났다."}
  ]'::jsonb),
  ('freeze', 0, 15, '동사', '[
    {"en":"We froze the juice to make ice pops.","ko":"우리는 아이스바를 만들기 위해 주스를 얼렸다."},
    {"en":"The lake freezes every winter.","ko":"그 호수는 매년 겨울 언다."},
    {"en":"Don''t forget to freeze the meat.","ko":"그 고기를 얼리는 것을 잊지 마."}
  ]'::jsonb),
  ('recipe', 0, 15, '명사', '[
    {"en":"She shared her recipe for chocolate cake.","ko":"그녀는 초콜릿 케이크 요리법을 공유했다."},
    {"en":"This recipe is easy to follow.","ko":"이 요리법은 따라 하기 쉽다."},
    {"en":"My mother has a special recipe for soup.","ko":"우리 엄마는 수프에 대한 특별한 요리법을 가지고 계신다."}
  ]'::jsonb),
  ('such as', 0, 15, '전치사구', '[
    {"en":"I like fruits such as apples and bananas.","ko":"나는 사과와 바나나 같은 과일을 좋아한다."},
    {"en":"You can bring snacks such as cookies or chips.","ko":"쿠키나 과자 같은 간식을 가져와도 된다."},
    {"en":"We visited several countries, such as Korea and Japan.","ko":"우리는 한국과 일본 같은 여러 나라를 방문했다."}
  ]'::jsonb),
  ('do the dishes', 0, 15, '동사구', '[
    {"en":"I do the dishes after dinner every day.","ko":"나는 매일 저녁 식사 후 설거지를 한다."},
    {"en":"Can you do the dishes tonight?","ko":"오늘 밤 설거지를 해줄 수 있어?"},
    {"en":"He helped his mother do the dishes.","ko":"그는 엄마가 설거지하는 것을 도왔다."}
  ]'::jsonb),
  ('eat', 0, 16, '동사', '[
    {"en":"We eat breakfast together every morning.","ko":"우리는 매일 아침 함께 아침 식사를 한다."},
    {"en":"She eats a healthy lunch at school.","ko":"그녀는 학교에서 건강한 점심을 먹는다."},
    {"en":"They ate dinner at a nice restaurant.","ko":"그들은 멋진 식당에서 저녁을 먹었다."}
  ]'::jsonb),
  ('drink', 0, 16, '동사', '[
    {"en":"I drink a glass of milk every morning.","ko":"나는 매일 아침 우유 한 잔을 마신다."},
    {"en":"She drank some water after exercising.","ko":"그녀는 운동 후 물을 좀 마셨다."},
    {"en":"Please drink plenty of water in summer.","ko":"여름에는 물을 충분히 마셔라."}
  ]'::jsonb),
  ('knife', 0, 16, '명사', '[
    {"en":"Be careful with that knife.","ko":"그 칼을 조심해."},
    {"en":"She cut the bread with a knife.","ko":"그녀는 칼로 빵을 잘랐다."},
    {"en":"The chef used a sharp knife to cut the vegetables.","ko":"요리사는 날카로운 칼로 채소를 잘랐다."}
  ]'::jsonb),
  ('cup', 0, 16, '명사', '[
    {"en":"Can I have a cup of tea?","ko":"차 한 잔 마실 수 있을까?"},
    {"en":"She washed the cups after breakfast.","ko":"그녀는 아침 식사 후 컵을 씻었다."},
    {"en":"He filled the cup with juice.","ko":"그는 컵을 주스로 채웠다."}
  ]'::jsonb),
  ('dish', 0, 16, '명사', '[
    {"en":"This is my favorite dish.","ko":"이것은 내가 가장 좋아하는 요리이다."},
    {"en":"Please put the dishes on the table.","ko":"접시를 식탁에 놓아 주세요."},
    {"en":"The chef prepared a special dish for us.","ko":"요리사는 우리를 위해 특별한 요리를 준비했다."}
  ]'::jsonb),
  ('juice', 0, 16, '명사', '[
    {"en":"I drink orange juice every morning.","ko":"나는 매일 아침 오렌지 주스를 마신다."},
    {"en":"She made fresh apple juice.","ko":"그녀는 신선한 사과 주스를 만들었다."},
    {"en":"Can I have a glass of juice?","ko":"주스 한 잔 마실 수 있을까?"}
  ]'::jsonb),
  ('soup', 0, 16, '명사', '[
    {"en":"My mother made vegetable soup for dinner.","ko":"우리 엄마는 저녁으로 채소 수프를 만드셨다."},
    {"en":"The soup was too hot to eat.","ko":"그 수프는 먹기에 너무 뜨거웠다."},
    {"en":"We had soup and bread for lunch.","ko":"우리는 점심으로 수프와 빵을 먹었다."}
  ]'::jsonb),
  ('salad', 0, 16, '명사', '[
    {"en":"She made a fresh salad for lunch.","ko":"그녀는 점심으로 신선한 샐러드를 만들었다."},
    {"en":"I like salad with fruit in it.","ko":"나는 과일이 들어간 샐러드를 좋아한다."},
    {"en":"He ordered a salad instead of fries.","ko":"그는 감자튀김 대신 샐러드를 주문했다."}
  ]'::jsonb),
  ('seafood', 0, 16, '명사', '[
    {"en":"My family loves seafood.","ko":"우리 가족은 해산물을 좋아한다."},
    {"en":"The restaurant serves fresh seafood.","ko":"그 식당은 신선한 해산물을 제공한다."},
    {"en":"We had seafood soup at the beach.","ko":"우리는 해변에서 해산물 수프를 먹었다."}
  ]'::jsonb),
  ('menu', 0, 16, '명사', '[
    {"en":"Can I see the menu, please?","ko":"메뉴판을 볼 수 있을까요?"},
    {"en":"The restaurant has a new menu this month.","ko":"그 식당은 이번 달에 새 메뉴가 있다."},
    {"en":"She chose a salad from the menu.","ko":"그녀는 메뉴에서 샐러드를 골랐다."}
  ]'::jsonb),
  ('hungry', 0, 16, '형용사', '[
    {"en":"I''m really hungry right now.","ko":"나는 지금 정말 배고프다."},
    {"en":"The children were hungry after playing outside.","ko":"아이들은 밖에서 논 후 배고팠다."},
    {"en":"Are you hungry? Let''s have lunch.","ko":"배고프니? 점심 먹자."}
  ]'::jsonb),
  ('thirsty', 0, 16, '형용사', '[
    {"en":"I''m thirsty after running.","ko":"나는 달리고 나서 목이 마르다."},
    {"en":"She felt thirsty in the hot weather.","ko":"그녀는 더운 날씨에 목이 말랐다."},
    {"en":"Drink some water if you feel thirsty.","ko":"목이 마르면 물을 좀 마셔."}
  ]'::jsonb),
  ('open', 0, 16, '동사', '[
    {"en":"Please open the window.","ko":"창문을 열어 주세요."},
    {"en":"The store opens at nine.","ko":"그 가게는 9시에 문을 연다."},
    {"en":"She opened her book and started reading.","ko":"그녀는 책을 펴고 읽기 시작했다."}
  ]'::jsonb),
  ('order', 0, 16, '동사', '[
    {"en":"What would you like to order?","ko":"무엇을 주문하시겠어요?"},
    {"en":"We ordered pizza for dinner.","ko":"우리는 저녁으로 피자를 주문했다."},
    {"en":"She ordered a salad and juice.","ko":"그녀는 샐러드와 주스를 주문했다."}
  ]'::jsonb),
  ('chef', 0, 16, '명사', '[
    {"en":"The chef cooked a delicious meal.","ko":"그 요리사는 맛있는 식사를 요리했다."},
    {"en":"My uncle wants to be a chef.","ko":"우리 삼촌은 요리사가 되고 싶어 한다."},
    {"en":"The chef added fresh herbs to the soup.","ko":"요리사는 수프에 신선한 허브를 넣었다."}
  ]'::jsonb),
  ('serve', 0, 16, '동사', '[
    {"en":"The restaurant serves breakfast until eleven.","ko":"그 식당은 11시까지 아침 식사를 제공한다."},
    {"en":"She served tea to her guests.","ko":"그녀는 손님들에게 차를 대접했다."},
    {"en":"They serve delicious noodles here.","ko":"이곳은 맛있는 국수를 제공한다."}
  ]'::jsonb),
  ('dessert', 0, 16, '명사', '[
    {"en":"What''s for dessert tonight?","ko":"오늘 밤 디저트는 뭐야?"},
    {"en":"She ordered ice cream for dessert.","ko":"그녀는 디저트로 아이스크림을 주문했다."},
    {"en":"We shared a piece of cake for dessert.","ko":"우리는 디저트로 케이크 한 조각을 나누어 먹었다."}
  ]'::jsonb),
  ('restaurant', 0, 16, '명사', '[
    {"en":"We ate dinner at a new restaurant.","ko":"우리는 새로운 식당에서 저녁을 먹었다."},
    {"en":"The restaurant near my house serves great noodles.","ko":"우리 집 근처 식당은 훌륭한 국수를 제공한다."},
    {"en":"My family visits this restaurant every birthday.","ko":"우리 가족은 생일마다 이 식당을 방문한다."}
  ]'::jsonb),
  ('eat out', 0, 16, '동사구', '[
    {"en":"We eat out once a week.","ko":"우리는 일주일에 한 번 외식을 한다."},
    {"en":"Let''s eat out for your birthday.","ko":"네 생일에 외식하자."},
    {"en":"They decided to eat out instead of cooking.","ko":"그들은 요리 대신 외식하기로 결정했다."}
  ]'::jsonb),
  ('wait for', 0, 16, '동사구', '[
    {"en":"I''m waiting for my friend at the station.","ko":"나는 역에서 친구를 기다리고 있다."},
    {"en":"She waited for the bus in the rain.","ko":"그녀는 빗속에서 버스를 기다렸다."},
    {"en":"Please wait for me at the gate.","ko":"정문에서 나를 기다려 줘."}
  ]'::jsonb),
  ('pants', 0, 17, '명사', '[
    {"en":"These pants are too long for me.","ko":"이 바지는 나에게 너무 길다."},
    {"en":"He bought a new pair of pants.","ko":"그는 새 바지 한 벌을 샀다."},
    {"en":"She wore blue pants to school.","ko":"그녀는 학교에 파란 바지를 입고 갔다."}
  ]'::jsonb),
  ('belt', 0, 17, '명사', '[
    {"en":"He wore a brown belt with his pants.","ko":"그는 바지에 갈색 벨트를 착용했다."},
    {"en":"She bought a new belt for her jacket.","ko":"그녀는 재킷을 위해 새 벨트를 샀다."},
    {"en":"The belt was too big for him.","ko":"그 벨트는 그에게 너무 컸다."}
  ]'::jsonb),
  ('shirt', 0, 17, '명사', '[
    {"en":"He is wearing a white shirt today.","ko":"그는 오늘 흰색 셔츠를 입고 있다."},
    {"en":"She bought a new shirt for the party.","ko":"그녀는 파티를 위해 새 셔츠를 샀다."},
    {"en":"My shirt got dirty during PE class.","ko":"체육 수업 중에 내 셔츠가 더러워졌다."}
  ]'::jsonb),
  ('skirt', 0, 17, '명사', '[
    {"en":"She wore a red skirt to the festival.","ko":"그녀는 축제에 빨간 치마를 입고 갔다."},
    {"en":"The skirt matches her shoes.","ko":"그 치마는 그녀의 신발과 잘 어울린다."},
    {"en":"I bought a new skirt for school.","ko":"나는 학교를 위해 새 치마를 샀다."}
  ]'::jsonb),
  ('socks', 0, 17, '명사', '[
    {"en":"He wore two different socks by mistake.","ko":"그는 실수로 서로 다른 양말 두 짝을 신었다."},
    {"en":"She put on warm socks in winter.","ko":"그녀는 겨울에 따뜻한 양말을 신었다."},
    {"en":"I need to buy new socks.","ko":"나는 새 양말을 사야 한다."}
  ]'::jsonb),
  ('shoes', 0, 17, '명사', '[
    {"en":"Please take off your shoes at the door.","ko":"문 앞에서 신발을 벗어 주세요."},
    {"en":"She bought new running shoes.","ko":"그녀는 새 운동화를 샀다."},
    {"en":"His shoes were covered in mud.","ko":"그의 신발은 진흙으로 뒤덮여 있었다."}
  ]'::jsonb),
  ('hat', 0, 17, '명사', '[
    {"en":"He wore a hat to protect himself from the sun.","ko":"그는 햇빛을 막기 위해 모자를 썼다."},
    {"en":"She bought a straw hat for summer.","ko":"그녀는 여름을 위해 밀짚모자를 샀다."},
    {"en":"The wind blew his hat away.","ko":"바람이 그의 모자를 날려버렸다."}
  ]'::jsonb),
  ('cap', 0, 17, '명사', '[
    {"en":"He always wears a baseball cap.","ko":"그는 항상 야구 모자를 쓴다."},
    {"en":"She gave him a cap as a birthday gift.","ko":"그녀는 그에게 생일 선물로 모자를 주었다."},
    {"en":"I lost my cap at the park.","ko":"나는 공원에서 모자를 잃어버렸다."}
  ]'::jsonb),
  ('sweater', 0, 17, '명사', '[
    {"en":"She knitted a sweater for her grandfather.","ko":"그녀는 할아버지를 위해 스웨터를 짰다."},
    {"en":"He wore a warm sweater in winter.","ko":"그는 겨울에 따뜻한 스웨터를 입었다."},
    {"en":"This sweater is too small for me now.","ko":"이 스웨터는 이제 나에게 너무 작다."}
  ]'::jsonb),
  ('jacket', 0, 17, '명사', '[
    {"en":"Take your jacket; it''s cold outside.","ko":"재킷을 챙겨, 밖이 추워."},
    {"en":"He hung his jacket on the chair.","ko":"그는 자신의 재킷을 의자에 걸었다."},
    {"en":"She bought a new jacket for the trip.","ko":"그녀는 여행을 위해 새 재킷을 샀다."}
  ]'::jsonb),
  ('gloves', 0, 17, '명사', '[
    {"en":"Wear your gloves; it''s snowing outside.","ko":"장갑을 껴, 밖에 눈이 오고 있어."},
    {"en":"She lost one of her gloves.","ko":"그녀는 장갑 한 짝을 잃어버렸다."},
    {"en":"He put on his gloves before going out.","ko":"그는 나가기 전에 장갑을 꼈다."}
  ]'::jsonb),
  ('pocket', 0, 17, '명사', '[
    {"en":"He put his hands in his pockets.","ko":"그는 주머니에 손을 넣었다."},
    {"en":"She keeps her phone in her pocket.","ko":"그녀는 휴대폰을 주머니에 넣어 둔다."},
    {"en":"I found a coin in my jacket pocket.","ko":"나는 재킷 주머니에서 동전을 발견했다."}
  ]'::jsonb),
  ('clothes', 0, 17, '명사', '[
    {"en":"She washed her clothes on Sunday.","ko":"그녀는 일요일에 옷을 세탁했다."},
    {"en":"Please put your clothes in the closet.","ko":"옷을 옷장에 넣어 주세요."},
    {"en":"He bought new clothes for the new school year.","ko":"그는 새 학년을 위해 새 옷을 샀다."}
  ]'::jsonb),
  ('wear', 0, 17, '동사', '[
    {"en":"What are you going to wear to the party?","ko":"파티에 뭘 입을 거야?"},
    {"en":"She wears glasses for reading.","ko":"그녀는 독서를 위해 안경을 쓴다."},
    {"en":"He wore a warm coat in winter.","ko":"그는 겨울에 따뜻한 코트를 입었다."}
  ]'::jsonb),
  ('fashion', 0, 17, '명사', '[
    {"en":"She is interested in fashion.","ko":"그녀는 패션에 관심이 있다."},
    {"en":"My sister reads fashion magazines every month.","ko":"우리 언니는 매달 패션 잡지를 읽는다."},
    {"en":"Fashion trends change every season.","ko":"패션 트렌드는 계절마다 바뀐다."}
  ]'::jsonb),
  ('design', 0, 17, '동사', '[
    {"en":"She designed her own T-shirt for the festival.","ko":"그녀는 축제를 위해 자신만의 티셔츠를 디자인했다."},
    {"en":"He wants to design video games in the future.","ko":"그는 미래에 비디오 게임을 디자인하고 싶어 한다."},
    {"en":"The building was designed by a famous architect.","ko":"그 건물은 유명한 건축가에 의해 설계되었다."}
  ]'::jsonb),
  ('popular', 0, 17, '형용사', '[
    {"en":"This song is very popular among teenagers.","ko":"이 노래는 십대들 사이에서 매우 인기가 있다."},
    {"en":"She is a popular student in her class.","ko":"그녀는 반에서 인기 있는 학생이다."},
    {"en":"That restaurant is popular for its noodles.","ko":"그 식당은 국수로 인기가 있다."}
  ]'::jsonb),
  ('style', 0, 17, '명사', '[
    {"en":"I like your style of clothes.","ko":"나는 네 옷 스타일이 마음에 들어."},
    {"en":"Everyone has their own style.","ko":"모두는 자신만의 스타일을 가지고 있다."},
    {"en":"Her writing style is simple and clear.","ko":"그녀의 글쓰기 스타일은 간결하고 명확하다."}
  ]'::jsonb),
  ('put on', 0, 17, '동사구', '[
    {"en":"Put on your jacket before you go outside.","ko":"밖에 나가기 전에 재킷을 입어."},
    {"en":"She put on her shoes quickly.","ko":"그녀는 신발을 빨리 신었다."},
    {"en":"He put on his cap and left the house.","ko":"그는 모자를 쓰고 집을 나섰다."}
  ]'::jsonb),
  ('take off', 0, 17, '동사구', '[
    {"en":"Please take off your shoes before entering the room.","ko":"방에 들어가기 전에 신발을 벗어 주세요."},
    {"en":"He took off his jacket because it was warm.","ko":"그는 더워서 재킷을 벗었다."},
    {"en":"The plane will take off in ten minutes.","ko":"비행기는 10분 후에 이륙할 것이다."}
  ]'::jsonb)
) as t(word, level, study_day, pos, examples)
where v.word = t.word and v.level = t.level and v.study_day = t.study_day;
