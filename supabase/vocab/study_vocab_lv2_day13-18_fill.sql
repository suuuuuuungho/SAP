-- SAP 1기 대시보드: Study 탭 — Lv.2(중등 고난도) Day 13~18 품사/예문 채우기 (180단어).
update public.vocab_words v
set part_of_speech = t.pos, example_sentences = t.examples, updated_at = now()
from (values
  ('goods', 2, 13, '명사', '[
    {"en":"The store sells a wide variety of goods.","ko":"그 가게는 다양한 상품을 판매한다."},
    {"en":"These goods were imported from overseas.","ko":"이 상품들은 해외에서 수입되었다."},
    {"en":"The goods arrived in perfect condition.","ko":"상품은 완벽한 상태로 도착했다."}
  ]'::jsonb),
  ('label', 2, 13, '명사', '[
    {"en":"Check the label before you buy the product.","ko":"제품을 사기 전에 라벨을 확인해라."},
    {"en":"The label shows the price and size.","ko":"라벨에는 가격과 사이즈가 표시되어 있다."},
    {"en":"She read the nutrition label carefully.","ko":"그녀는 영양 성분표를 꼼꼼히 읽었다."}
  ]'::jsonb),
  ('tag', 2, 13, '명사', '[
    {"en":"The price tag was still attached to the shirt.","ko":"셔츠에는 가격표가 여전히 붙어 있었다."},
    {"en":"He removed the tag before wearing the jacket.","ko":"그는 재킷을 입기 전에 태그를 제거했다."},
    {"en":"Each item has a tag with its size.","ko":"각 물건에는 사이즈가 적힌 태그가 있다."}
  ]'::jsonb),
  ('wrap', 2, 13, '동사', '[
    {"en":"She wrapped the gift in colorful paper.","ko":"그녀는 화려한 종이로 선물을 포장했다."},
    {"en":"Please wrap the fragile items carefully.","ko":"깨지기 쉬운 물건들은 조심스럽게 포장해 주세요."},
    {"en":"He wrapped the sandwich in foil.","ko":"그는 샌드위치를 호일로 쌌다."}
  ]'::jsonb),
  ('bargain', 2, 13, '명사', '[
    {"en":"This laptop is a real bargain at that price.","ko":"이 노트북은 그 가격에 정말 싼 물건이다."},
    {"en":"She found a bargain at the flea market.","ko":"그녀는 벼룩시장에서 싼 물건을 발견했다."},
    {"en":"It is hard to find a bargain during the holiday season.","ko":"연휴 기간에는 싼 물건을 찾기가 어렵다."}
  ]'::jsonb),
  ('purchase', 2, 13, '동사/명사', '[
    {"en":"She purchased a new phone yesterday.","ko":"그녀는 어제 새 휴대폰을 구입했다."},
    {"en":"Keep the receipt for every purchase.","ko":"모든 구매에 대해 영수증을 보관해라."},
    {"en":"The company purchased new equipment for the factory.","ko":"그 회사는 공장을 위해 새 장비를 구입했다."}
  ]'::jsonb),
  ('total', 2, 13, '명사/형용사', '[
    {"en":"The total cost of the trip was higher than expected.","ko":"여행의 총비용은 예상보다 많이 나왔다."},
    {"en":"Add up all the items to get the total.","ko":"합계를 내려면 모든 항목을 더해라."},
    {"en":"The total number of students increased this year.","ko":"올해 전체 학생 수가 증가했다."}
  ]'::jsonb),
  ('quality', 2, 13, '명사', '[
    {"en":"The store is known for its high quality products.","ko":"그 가게는 품질 좋은 제품으로 유명하다."},
    {"en":"Quality matters more than price to many shoppers.","ko":"많은 쇼핑객들에게 품질은 가격보다 중요하다."},
    {"en":"They checked the quality of each item before shipping.","ko":"그들은 배송 전에 각 제품의 품질을 확인했다."}
  ]'::jsonb),
  ('value', 2, 13, '동사/명사', '[
    {"en":"This bag offers great value for the price.","ko":"이 가방은 가격 대비 훌륭한 가치를 제공한다."},
    {"en":"He values honesty more than anything else.","ko":"그는 무엇보다도 정직을 소중히 여긴다."},
    {"en":"The value of the antique increased over time.","ko":"그 골동품의 가치는 시간이 지나면서 올랐다."}
  ]'::jsonb),
  ('reduce', 2, 13, '동사', '[
    {"en":"The shop reduced prices for the summer sale.","ko":"그 가게는 여름 세일을 위해 가격을 낮췄다."},
    {"en":"We should reduce waste whenever possible.","ko":"우리는 가능한 한 낭비를 줄여야 한다."},
    {"en":"The company reduced its production costs.","ko":"그 회사는 생산 비용을 줄였다."}
  ]'::jsonb),
  ('trend', 2, 13, '명사', '[
    {"en":"Online shopping has become a growing trend.","ko":"온라인 쇼핑은 점점 커지는 추세가 되었다."},
    {"en":"She always follows the latest fashion trends.","ko":"그녀는 항상 최신 패션 유행을 따른다."},
    {"en":"This trend is likely to continue next year.","ko":"이 흐름은 내년에도 계속될 가능성이 크다."}
  ]'::jsonb),
  ('quantity', 2, 13, '명사', '[
    {"en":"The factory produces a large quantity of goods each day.","ko":"그 공장은 매일 많은 양의 상품을 생산한다."},
    {"en":"Buying in large quantity can save money.","ko":"대량으로 구매하면 돈을 절약할 수 있다."},
    {"en":"The recipe requires a small quantity of salt.","ko":"그 조리법은 소량의 소금을 필요로 한다."}
  ]'::jsonb),
  ('retail', 2, 13, '명사/형용사', '[
    {"en":"The retail price is higher than the wholesale price.","ko":"소매가는 도매가보다 높다."},
    {"en":"She works in the retail industry.","ko":"그녀는 소매업계에서 일한다."},
    {"en":"Retail stores were crowded during the holiday sale.","ko":"연휴 세일 기간에 소매점들은 붐볐다."}
  ]'::jsonb),
  ('merchandise', 2, 13, '명사', '[
    {"en":"The store displayed its merchandise near the entrance.","ko":"그 가게는 입구 근처에 상품을 진열했다."},
    {"en":"New merchandise arrives every week.","ko":"매주 새로운 상품이 들어온다."},
    {"en":"They sell official merchandise related to the movie.","ko":"그들은 그 영화와 관련된 공식 상품을 판매한다."}
  ]'::jsonb),
  ('insert', 2, 13, '동사', '[
    {"en":"Insert your card to make a payment.","ko":"결제를 하려면 카드를 삽입해라."},
    {"en":"Please insert the coupon code at checkout.","ko":"결제 시 쿠폰 코드를 입력해 주세요."},
    {"en":"He inserted a note inside the package.","ko":"그는 소포 안에 메모를 넣었다."}
  ]'::jsonb),
  ('necessity', 2, 13, '명사', '[
    {"en":"Food and water are basic necessities.","ko":"음식과 물은 기본적인 필수품이다."},
    {"en":"A good internet connection has become a necessity.","ko":"좋은 인터넷 연결은 필수적인 것이 되었다."},
    {"en":"She only buys items of necessity.","ko":"그녀는 꼭 필요한 물건만 산다."}
  ]'::jsonb),
  ('luxury', 2, 13, '명사/형용사', '[
    {"en":"They stayed at a luxury hotel during their trip.","ko":"그들은 여행 중에 고급 호텔에 묵었다."},
    {"en":"Owning a car was once considered a luxury.","ko":"차를 소유하는 것은 한때 사치로 여겨졌다."},
    {"en":"The store sells luxury items like watches and jewelry.","ko":"그 가게는 시계와 보석 같은 명품을 판매한다."}
  ]'::jsonb),
  ('auction', 2, 13, '동사/명사', '[
    {"en":"The painting was sold at an auction.","ko":"그 그림은 경매에서 팔렸다."},
    {"en":"She bought the antique clock at an online auction.","ko":"그녀는 온라인 경매에서 그 골동품 시계를 샀다."},
    {"en":"The charity auctioned off several items to raise money.","ko":"그 자선 단체는 모금을 위해 여러 물건을 경매에 부쳤다."}
  ]'::jsonb),
  ('receipt', 2, 13, '명사', '[
    {"en":"Keep your receipt in case you need a refund.","ko":"환불이 필요할 경우를 대비해 영수증을 보관해라."},
    {"en":"He checked the receipt to make sure the price was correct.","ko":"그는 가격이 맞는지 확인하려고 영수증을 확인했다."},
    {"en":"The store emailed her the receipt.","ko":"그 가게는 그녀에게 영수증을 이메일로 보냈다."}
  ]'::jsonb),
  ('refund', 2, 13, '명사/동사', '[
    {"en":"She asked for a refund because the shirt did not fit.","ko":"그녀는 셔츠가 맞지 않아서 환불을 요청했다."},
    {"en":"The company refunded the full amount.","ko":"그 회사는 전액을 환불해 주었다."},
    {"en":"You can get a refund within thirty days of purchase.","ko":"구매 후 30일 이내에 환불을 받을 수 있다."}
  ]'::jsonb),
  ('exchange', 2, 13, '동사/명사', '[
    {"en":"He exchanged the shoes for a larger size.","ko":"그는 신발을 더 큰 사이즈로 교환했다."},
    {"en":"The store offers a free exchange within a week.","ko":"그 가게는 일주일 이내에 무료 교환을 제공한다."},
    {"en":"She exchanged the gift for something else.","ko":"그녀는 그 선물을 다른 것으로 교환했다."}
  ]'::jsonb),
  ('claim', 2, 13, '동사/명사', '[
    {"en":"He claimed that the product was defective.","ko":"그는 그 제품이 결함이 있다고 주장했다."},
    {"en":"She filed a claim for the damaged package.","ko":"그녀는 파손된 소포에 대해 청구를 신청했다."},
    {"en":"The company denied the customer''s claim.","ko":"그 회사는 고객의 요구를 거절했다."}
  ]'::jsonb),
  ('satisfy', 2, 13, '동사', '[
    {"en":"The new product satisfied most customers.","ko":"그 신제품은 대부분의 고객을 만족시켰다."},
    {"en":"Nothing seemed to satisfy him about the service.","ko":"그 서비스에 대해 그를 만족시키는 것은 아무것도 없어 보였다."},
    {"en":"The store aims to satisfy every customer''s needs.","ko":"그 가게는 모든 고객의 요구를 충족시키는 것을 목표로 한다."}
  ]'::jsonb),
  ('guarantee', 2, 13, '명사/동사', '[
    {"en":"The product comes with a one-year guarantee.","ko":"그 제품에는 1년 보증이 딸려 있다."},
    {"en":"The company guarantees a full refund if you are not satisfied.","ko":"그 회사는 만족하지 않으면 전액 환불을 보증한다."},
    {"en":"There is no guarantee that the price will stay the same.","ko":"가격이 그대로 유지될 것이라는 보장은 없다."}
  ]'::jsonb),
  ('exclude', 2, 13, '동사', '[
    {"en":"The price excludes tax and shipping fees.","ko":"그 가격에는 세금과 배송비가 포함되지 않는다."},
    {"en":"Some items are excluded from the sale.","ko":"일부 품목은 세일에서 제외된다."},
    {"en":"The discount excludes electronics.","ko":"그 할인은 전자제품을 제외한다."}
  ]'::jsonb),
  ('reasonable', 2, 13, '형용사', '[
    {"en":"The prices at this store are quite reasonable.","ko":"이 가게의 가격은 꽤 합리적이다."},
    {"en":"She made a reasonable offer for the used car.","ko":"그녀는 그 중고차에 대해 합리적인 제안을 했다."},
    {"en":"It is reasonable to compare prices before buying.","ko":"구매하기 전에 가격을 비교하는 것은 합당하다."}
  ]'::jsonb),
  ('steady', 2, 13, '형용사', '[
    {"en":"Sales have remained steady this year.","ko":"올해 매출은 꾸준히 유지되었다."},
    {"en":"The company reported a steady increase in customers.","ko":"그 회사는 고객 수의 꾸준한 증가를 보고했다."},
    {"en":"Prices stayed steady despite the economic changes.","ko":"경제 변화에도 불구하고 가격은 안정적으로 유지되었다."}
  ]'::jsonb),
  ('pay for', 2, 13, '동사구', '[
    {"en":"He paid for the groceries with a credit card.","ko":"그는 신용카드로 식료품 값을 지불했다."},
    {"en":"She paid for her mistake by working overtime.","ko":"그녀는 초과 근무를 함으로써 자신의 실수에 대한 대가를 치렀다."},
    {"en":"They paid for the tickets in advance.","ko":"그들은 미리 표값을 지불했다."}
  ]'::jsonb),
  ('leave out', 2, 13, '동사구', '[
    {"en":"Do not leave out the shipping cost when calculating the total.","ko":"총액을 계산할 때 배송비를 빠뜨리지 마라."},
    {"en":"The clerk left out one item from the receipt.","ko":"점원이 영수증에서 한 항목을 빠뜨렸다."},
    {"en":"Make sure not to leave out any details in the report.","ko":"보고서에서 어떤 세부 사항도 빠뜨리지 않도록 해라."}
  ]'::jsonb),
  ('add up', 2, 13, '동사구', '[
    {"en":"The cashier added up all the items on the receipt.","ko":"계산원은 영수증의 모든 항목을 합산했다."},
    {"en":"Small expenses can add up quickly over time.","ko":"작은 지출들도 시간이 지나면 빠르게 쌓일 수 있다."},
    {"en":"Please add up the total before you pay.","ko":"지불하기 전에 합계를 계산해 주세요."}
  ]'::jsonb),

  ('champion', 2, 14, '명사', '[
    {"en":"She became the national champion in swimming.","ko":"그녀는 수영 국가대표 챔피언이 되었다."},
    {"en":"The team celebrated after being crowned champions.","ko":"그 팀은 챔피언 자리에 오른 후 축하했다."},
    {"en":"He trained hard to become a champion.","ko":"그는 챔피언이 되기 위해 열심히 훈련했다."}
  ]'::jsonb),
  ('match', 2, 14, '명사/동사', '[
    {"en":"The soccer match ended in a tie.","ko":"그 축구 경기는 무승부로 끝났다."},
    {"en":"Her skills matched those of a professional player.","ko":"그녀의 실력은 프로 선수와 맞먹었다."},
    {"en":"Thousands of fans watched the match live.","ko":"수천 명의 팬들이 그 경기를 생중계로 지켜보았다."}
  ]'::jsonb),
  ('tournament', 2, 14, '명사', '[
    {"en":"Our school will host a basketball tournament next month.","ko":"우리 학교는 다음 달에 농구 토너먼트를 개최할 것이다."},
    {"en":"She won first place in the chess tournament.","ko":"그녀는 체스 대회에서 1등을 했다."},
    {"en":"The tournament attracted teams from all over the country.","ko":"그 대회에는 전국 각지에서 팀들이 모였다."}
  ]'::jsonb),
  ('rival', 2, 14, '명사/동사', '[
    {"en":"The two teams have been rivals for years.","ko":"그 두 팀은 수년 동안 라이벌이었다."},
    {"en":"No other player could rival his speed.","ko":"어떤 선수도 그의 속도에 필적할 수 없었다."},
    {"en":"Their rival school beat them in the final game.","ko":"그들의 라이벌 학교가 결승전에서 그들을 이겼다."}
  ]'::jsonb),
  ('rank', 2, 14, '동사/명사', '[
    {"en":"She ranks among the top players in the country.","ko":"그녀는 국내 최고 선수 중 하나로 꼽힌다."},
    {"en":"His rank improved after the tournament.","ko":"그의 순위는 대회 후에 올라갔다."},
    {"en":"The coach ranked the players based on their performance.","ko":"코치는 성적에 따라 선수들의 순위를 매겼다."}
  ]'::jsonb),
  ('coach', 2, 14, '명사/동사', '[
    {"en":"The coach encouraged the team before the game.","ko":"코치는 경기 전에 팀을 격려했다."},
    {"en":"He has coached the swim team for ten years.","ko":"그는 10년 동안 수영팀을 지도해 왔다."},
    {"en":"Her coach taught her a new technique.","ko":"그녀의 코치는 그녀에게 새로운 기술을 가르쳐 주었다."}
  ]'::jsonb),
  ('serve', 2, 14, '동사', '[
    {"en":"She served the ball perfectly to win the point.","ko":"그녀는 점수를 따기 위해 완벽하게 서브를 넣었다."},
    {"en":"It was his turn to serve in the match.","ko":"경기에서 그가 서브할 차례였다."},
    {"en":"The player served five times without a fault.","ko":"그 선수는 실수 없이 다섯 번 서브를 넣었다."}
  ]'::jsonb),
  ('glide', 2, 14, '동사/명사', '[
    {"en":"The skater glided smoothly across the ice.","ko":"스케이트 선수는 얼음 위를 부드럽게 미끄러져 갔다."},
    {"en":"Birds glide gracefully through the sky.","ko":"새들은 하늘을 우아하게 활공한다."},
    {"en":"The gymnast''s glide impressed the judges.","ko":"그 체조 선수의 활주는 심사위원들에게 깊은 인상을 남겼다."}
  ]'::jsonb),
  ('beat', 2, 14, '동사', '[
    {"en":"Our team beat the rivals by two points.","ko":"우리 팀은 라이벌을 2점 차로 이겼다."},
    {"en":"She trains every day to beat her personal record.","ko":"그녀는 자신의 개인 기록을 깨기 위해 매일 훈련한다."},
    {"en":"They beat the defending champions in the final round.","ko":"그들은 결승전에서 전 대회 우승팀을 이겼다."}
  ]'::jsonb),
  ('compete', 2, 14, '동사', '[
    {"en":"Athletes from many countries compete in the Olympics.","ko":"많은 나라의 선수들이 올림픽에서 경쟁한다."},
    {"en":"She competed in her first tournament last year.","ko":"그녀는 작년에 첫 대회에 참가했다."},
    {"en":"The two teams competed fiercely for the title.","ko":"그 두 팀은 우승을 두고 치열하게 경쟁했다."}
  ]'::jsonb),
  ('ability', 2, 14, '명사', '[
    {"en":"He has the ability to run very fast.","ko":"그는 매우 빨리 달릴 수 있는 능력이 있다."},
    {"en":"Her athletic ability improved with practice.","ko":"그녀의 운동 능력은 연습을 통해 향상되었다."},
    {"en":"The coach recognized his natural ability early on.","ko":"코치는 일찍부터 그의 타고난 재능을 알아보았다."}
  ]'::jsonb),
  ('leisure', 2, 14, '명사', '[
    {"en":"He spends his leisure time playing tennis.","ko":"그는 여가 시간을 테니스를 치며 보낸다."},
    {"en":"Sports are a popular leisure activity.","ko":"스포츠는 인기 있는 여가 활동이다."},
    {"en":"She reads books during her leisure hours.","ko":"그녀는 여가 시간에 책을 읽는다."}
  ]'::jsonb),
  ('pastime', 2, 14, '명사', '[
    {"en":"Baseball is a favorite pastime in many countries.","ko":"야구는 많은 나라에서 인기 있는 취미 활동이다."},
    {"en":"Hiking became his favorite pastime after retirement.","ko":"등산은 은퇴 후 그가 가장 좋아하는 취미가 되었다."},
    {"en":"Fishing is a relaxing pastime for many people.","ko":"낚시는 많은 사람들에게 편안한 취미이다."}
  ]'::jsonb),
  ('outdoor', 2, 14, '형용사', '[
    {"en":"Outdoor sports like soccer require good weather.","ko":"축구 같은 야외 스포츠는 좋은 날씨를 필요로 한다."},
    {"en":"They enjoy outdoor activities such as cycling and hiking.","ko":"그들은 자전거 타기와 등산 같은 야외 활동을 즐긴다."},
    {"en":"The school organized an outdoor sports day.","ko":"학교는 야외 체육대회를 열었다."}
  ]'::jsonb),
  ('defeat', 2, 14, '명사/동사', '[
    {"en":"The team suffered a narrow defeat in the final.","ko":"그 팀은 결승전에서 아깝게 패배했다."},
    {"en":"They defeated their rivals in an exciting match.","ko":"그들은 흥미진진한 경기에서 라이벌을 물리쳤다."},
    {"en":"It was a tough defeat, but they learned from it.","ko":"힘든 패배였지만 그들은 그것에서 배웠다."}
  ]'::jsonb),
  ('amateur', 2, 14, '명사/형용사', '[
    {"en":"He started as an amateur before turning professional.","ko":"그는 프로가 되기 전에 아마추어로 시작했다."},
    {"en":"The amateur team surprised everyone with their victory.","ko":"그 아마추어 팀은 승리로 모두를 놀라게 했다."},
    {"en":"She still plays golf as an amateur.","ko":"그녀는 여전히 아마추어로 골프를 친다."}
  ]'::jsonb),
  ('mound', 2, 14, '명사', '[
    {"en":"The pitcher stood confidently on the mound.","ko":"투수는 마운드 위에서 자신 있게 서 있었다."},
    {"en":"He walked to the mound to begin the inning.","ko":"그는 이닝을 시작하기 위해 마운드로 걸어갔다."},
    {"en":"The coach visited the mound to talk to the pitcher.","ko":"코치는 투수와 이야기하기 위해 마운드를 방문했다."}
  ]'::jsonb),
  ('athletic', 2, 14, '형용사', '[
    {"en":"She has always been very athletic.","ko":"그녀는 항상 운동신경이 매우 좋았다."},
    {"en":"The school built a new athletic facility.","ko":"그 학교는 새로운 체육 시설을 지었다."},
    {"en":"His athletic ability made him a great sprinter.","ko":"그의 운동 능력은 그를 훌륭한 단거리 선수로 만들었다."}
  ]'::jsonb),
  ('opponent', 2, 14, '명사', '[
    {"en":"She studied her opponent''s playing style carefully.","ko":"그녀는 상대의 경기 스타일을 신중하게 연구했다."},
    {"en":"The boxer respected his opponent after the match.","ko":"그 복서는 경기 후 상대 선수를 존중했다."},
    {"en":"Their opponent was much stronger this time.","ko":"이번에는 그들의 상대가 훨씬 강했다."}
  ]'::jsonb),
  ('referee', 2, 14, '명사', '[
    {"en":"The referee blew the whistle to stop the game.","ko":"심판은 경기를 멈추기 위해 호루라기를 불었다."},
    {"en":"Players must respect the referee''s decisions.","ko":"선수들은 심판의 판정을 존중해야 한다."},
    {"en":"The referee gave a yellow card for the foul.","ko":"심판은 그 반칙에 대해 경고 카드를 주었다."}
  ]'::jsonb),
  ('fair', 2, 14, '형용사', '[
    {"en":"The referee made sure the game was fair.","ko":"심판은 경기가 공정하게 진행되도록 했다."},
    {"en":"It is important to compete in a fair manner.","ko":"공정한 방식으로 경쟁하는 것이 중요하다."},
    {"en":"The judges gave a fair score to every performer.","ko":"심사위원들은 모든 참가자에게 공정한 점수를 주었다."}
  ]'::jsonb),
  ('penalty', 2, 14, '명사', '[
    {"en":"The team was given a penalty for the foul.","ko":"그 팀은 반칙에 대해 벌칙을 받았다."},
    {"en":"He scored from the penalty kick.","ko":"그는 페널티킥으로 득점했다."},
    {"en":"A penalty shot decided the outcome of the game.","ko":"페널티 슛으로 경기의 결과가 결정되었다."}
  ]'::jsonb),
  ('foul', 2, 14, '동사/형용사', '[
    {"en":"He fouled the opposing player during the match.","ko":"그는 경기 중에 상대 선수에게 반칙을 범했다."},
    {"en":"The referee called a foul on the defender.","ko":"심판은 수비수에게 반칙을 선언했다."},
    {"en":"It was a clear foul that cost them the point.","ko":"그것은 그들에게 점수를 잃게 한 명백한 반칙이었다."}
  ]'::jsonb),
  ('outstanding', 2, 14, '형용사', '[
    {"en":"She gave an outstanding performance in the finals.","ko":"그녀는 결승전에서 뛰어난 경기력을 보여주었다."},
    {"en":"His outstanding skills earned him a place on the national team.","ko":"그의 뛰어난 실력은 그를 국가대표팀에 들게 했다."},
    {"en":"The coach praised the outstanding teamwork.","ko":"코치는 뛰어난 팀워크를 칭찬했다."}
  ]'::jsonb),
  ('participate', 2, 14, '동사', '[
    {"en":"Every student is encouraged to participate in sports day.","ko":"모든 학생은 체육대회에 참가하도록 권장된다."},
    {"en":"She participated in three events this year.","ko":"그녀는 올해 세 종목에 참가했다."},
    {"en":"Many athletes participated in the international competition.","ko":"많은 선수들이 그 국제 대회에 참가했다."}
  ]'::jsonb),
  ('applaud', 2, 14, '동사', '[
    {"en":"The crowd applauded loudly after the winning goal.","ko":"관중들은 결승골이 터진 후 큰 박수를 보냈다."},
    {"en":"Fans applauded the players as they left the field.","ko":"팬들은 선수들이 경기장을 떠날 때 박수를 쳤다."},
    {"en":"Everyone applauded her outstanding performance.","ko":"모두가 그녀의 뛰어난 활약에 박수를 보냈다."}
  ]'::jsonb),
  ('encourage', 2, 14, '동사', '[
    {"en":"The coach encouraged the team to keep trying.","ko":"코치는 팀에게 계속 노력하라고 격려했다."},
    {"en":"Her family encouraged her to pursue athletics.","ko":"그녀의 가족은 그녀가 운동을 계속하도록 격려했다."},
    {"en":"Fans encouraged the runners throughout the marathon.","ko":"팬들은 마라톤 내내 주자들을 응원했다."}
  ]'::jsonb),
  ('extreme', 2, 14, '형용사', '[
    {"en":"Extreme sports like rock climbing require special training.","ko":"암벽 등반 같은 극한 스포츠는 특별한 훈련이 필요하다."},
    {"en":"He trains under extreme conditions to build endurance.","ko":"그는 지구력을 기르기 위해 극한의 환경에서 훈련한다."},
    {"en":"The weather made extreme demands on the athletes.","ko":"날씨는 선수들에게 극심한 부담을 주었다."}
  ]'::jsonb),
  ('call off', 2, 14, '동사구', '[
    {"en":"The match was called off due to heavy rain.","ko":"경기는 폭우로 인해 취소되었다."},
    {"en":"Organizers called off the tournament at the last minute.","ko":"주최측은 마지막 순간에 대회를 취소했다."},
    {"en":"They had to call off the outdoor event because of the storm.","ko":"그들은 폭풍 때문에 야외 행사를 취소해야 했다."}
  ]'::jsonb),
  ('take place', 2, 14, '동사구', '[
    {"en":"The championship will take place next weekend.","ko":"선수권 대회는 다음 주말에 열릴 것이다."},
    {"en":"The tournament takes place every two years.","ko":"그 대회는 2년마다 열린다."},
    {"en":"Where will the final match take place?","ko":"결승전은 어디에서 열리나요?"}
  ]'::jsonb),

  ('transport', 2, 15, '명사/동사', '[
    {"en":"Public transport is convenient in this city.","ko":"이 도시에서는 대중교통이 편리하다."},
    {"en":"The goods were transported by ship.","ko":"그 물품들은 배로 운송되었다."},
    {"en":"They use buses for transport to school.","ko":"그들은 학교까지 버스로 이동한다."}
  ]'::jsonb),
  ('passenger', 2, 15, '명사', '[
    {"en":"The plane carried over two hundred passengers.","ko":"그 비행기는 200명이 넘는 승객을 태웠다."},
    {"en":"Passengers must fasten their seatbelts during takeoff.","ko":"승객들은 이륙 중에 안전벨트를 매야 한다."},
    {"en":"The train was full of passengers heading downtown.","ko":"그 기차는 시내로 향하는 승객들로 가득했다."}
  ]'::jsonb),
  ('underground', 2, 15, '명사/형용사', '[
    {"en":"We took the underground to reach the airport.","ko":"우리는 공항에 가기 위해 지하철을 탔다."},
    {"en":"The underground station was crowded during rush hour.","ko":"출퇴근 시간에 지하철역은 붐볐다."},
    {"en":"London''s underground system is famous worldwide.","ko":"런던의 지하철 시스템은 전 세계적으로 유명하다."}
  ]'::jsonb),
  ('aboard', 2, 15, '부사/형용사', '[
    {"en":"All passengers are now aboard the ship.","ko":"모든 승객이 이제 배에 탑승했다."},
    {"en":"She welcomed everyone aboard the flight.","ko":"그녀는 비행기에 탑승한 모든 사람을 환영했다."},
    {"en":"He stepped aboard the train just before it left.","ko":"그는 기차가 떠나기 직전에 올라탔다."}
  ]'::jsonb),
  ('depart', 2, 15, '동사', '[
    {"en":"The flight will depart at nine in the morning.","ko":"그 항공편은 오전 9시에 출발할 것이다."},
    {"en":"The train departs from platform three.","ko":"그 기차는 3번 승강장에서 출발한다."},
    {"en":"We depart for our trip tomorrow.","ko":"우리는 내일 여행을 떠난다."}
  ]'::jsonb),
  ('sightseeing', 2, 15, '명사/형용사', '[
    {"en":"They went sightseeing around the old city.","ko":"그들은 구시가지를 관광했다."},
    {"en":"Sightseeing tours are popular among tourists.","ko":"관광 투어는 여행객들 사이에서 인기가 많다."},
    {"en":"We spent the afternoon sightseeing near the harbor.","ko":"우리는 항구 근처에서 오후 시간을 관광하며 보냈다."}
  ]'::jsonb),
  ('downtown', 2, 15, '형용사/부사', '[
    {"en":"The hotel is located downtown near the station.","ko":"그 호텔은 역 근처 도심에 위치해 있다."},
    {"en":"We walked downtown to visit the museum.","ko":"우리는 박물관을 방문하러 시내로 걸어갔다."},
    {"en":"Downtown traffic can be heavy during the day.","ko":"낮 동안 도심의 교통은 혼잡할 수 있다."}
  ]'::jsonb),
  ('ride', 2, 15, '명사/동사', '[
    {"en":"She rode her bike to school every morning.","ko":"그녀는 매일 아침 자전거를 타고 학교에 갔다."},
    {"en":"It was a long ride to the airport.","ko":"공항까지는 긴 이동이었다."},
    {"en":"He offered his friend a ride home.","ko":"그는 친구에게 집까지 태워주겠다고 했다."}
  ]'::jsonb),
  ('abroad', 2, 15, '부사', '[
    {"en":"She studied abroad for a year.","ko":"그녀는 1년 동안 해외에서 공부했다."},
    {"en":"Many students dream of traveling abroad.","ko":"많은 학생들이 해외여행을 꿈꾼다."},
    {"en":"He works abroad most of the year.","ko":"그는 일 년 중 대부분을 해외에서 일한다."}
  ]'::jsonb),
  ('baggage', 2, 15, '명사', '[
    {"en":"Please label your baggage before checking in.","ko":"체크인하기 전에 수하물에 이름표를 붙여 주세요."},
    {"en":"Her baggage was lost during the flight.","ko":"그녀의 수하물이 비행 중에 분실되었다."},
    {"en":"The airline allows two pieces of baggage per passenger.","ko":"그 항공사는 승객 한 명당 수하물 두 개를 허용한다."}
  ]'::jsonb),
  ('cabin', 2, 15, '명사', '[
    {"en":"They booked a cabin with an ocean view.","ko":"그들은 바다가 보이는 객실을 예약했다."},
    {"en":"The plane''s cabin was quiet during the flight.","ko":"비행 중 비행기 객실은 조용했다."},
    {"en":"We stayed in a small cabin in the mountains.","ko":"우리는 산속 작은 오두막에서 머물렀다."}
  ]'::jsonb),
  ('check-out', 2, 15, '명사', '[
    {"en":"Check-out time at the hotel is eleven o''clock.","ko":"그 호텔의 체크아웃 시간은 11시이다."},
    {"en":"The airport check-out process was quick.","ko":"공항 수속 절차는 빨랐다."},
    {"en":"We finished check-out before heading to the airport.","ko":"우리는 공항으로 향하기 전에 체크아웃을 마쳤다."}
  ]'::jsonb),
  ('tip', 2, 15, '명사/동사', '[
    {"en":"He left a tip for the waiter.","ko":"그는 웨이터에게 팁을 남겼다."},
    {"en":"It is common to tip taxi drivers in some countries.","ko":"어떤 나라에서는 택시 기사에게 팁을 주는 것이 흔하다."},
    {"en":"She gave the guide a generous tip.","ko":"그녀는 가이드에게 넉넉한 팁을 주었다."}
  ]'::jsonb),
  ('destination', 2, 15, '명사', '[
    {"en":"Our final destination was a small coastal town.","ko":"우리의 최종 목적지는 작은 해안 마을이었다."},
    {"en":"The flight''s destination was changed due to the weather.","ko":"그 항공편의 목적지는 날씨 때문에 변경되었다."},
    {"en":"Choosing the right destination made the trip memorable.","ko":"올바른 목적지를 선택한 것이 여행을 기억에 남게 했다."}
  ]'::jsonb),
  ('available', 2, 15, '형용사', '[
    {"en":"There were no seats available on the earlier flight.","ko":"더 이른 항공편에는 이용 가능한 좌석이 없었다."},
    {"en":"Rooms are available at the hotel for the weekend.","ko":"주말에 그 호텔에는 이용 가능한 객실이 있다."},
    {"en":"Check whether tickets are still available online.","ko":"표가 아직 온라인에서 구매 가능한지 확인해라."}
  ]'::jsonb),
  ('delay', 2, 15, '명사/동사', '[
    {"en":"The flight was delayed due to bad weather.","ko":"그 항공편은 악천후로 지연되었다."},
    {"en":"There was a long delay at the border.","ko":"국경에서 오랜 지연이 있었다."},
    {"en":"Heavy traffic delayed our arrival by an hour.","ko":"극심한 교통 정체로 우리의 도착이 한 시간 지연되었다."}
  ]'::jsonb),
  ('transfer', 2, 15, '동사', '[
    {"en":"Passengers must transfer to another train at the next station.","ko":"승객들은 다음 역에서 다른 기차로 갈아타야 한다."},
    {"en":"We transferred flights in Tokyo.","ko":"우리는 도쿄에서 비행기를 환승했다."},
    {"en":"She transferred to a different bus halfway through the trip.","ko":"그녀는 여행 도중에 다른 버스로 갈아탔다."}
  ]'::jsonb),
  ('vehicle', 2, 15, '명사', '[
    {"en":"The rental vehicle was comfortable for the long trip.","ko":"렌터카는 장거리 여행에 편안했다."},
    {"en":"Only authorized vehicles are allowed in this area.","ko":"이 구역에는 허가된 차량만 출입할 수 있다."},
    {"en":"The company provides vehicles for tours.","ko":"그 회사는 투어를 위한 차량을 제공한다."}
  ]'::jsonb),
  ('highway', 2, 15, '명사', '[
    {"en":"We drove along the highway to reach the coast.","ko":"우리는 해안에 도달하기 위해 고속도로를 따라 운전했다."},
    {"en":"The highway was busy during the holiday season.","ko":"연휴 기간에 고속도로는 혼잡했다."},
    {"en":"A new highway connects the two cities.","ko":"새로운 고속도로가 두 도시를 연결한다."}
  ]'::jsonb),
  ('convey', 2, 15, '동사', '[
    {"en":"The ferry conveys passengers across the river.","ko":"그 여객선은 강 건너로 승객들을 실어 나른다."},
    {"en":"Buses convey tourists to the historic site.","ko":"버스들이 관광객들을 유적지로 실어 나른다."},
    {"en":"The train conveys goods as well as people.","ko":"그 기차는 사람뿐만 아니라 물자도 운반한다."}
  ]'::jsonb),
  ('accommodate', 2, 15, '동사', '[
    {"en":"The hotel can accommodate up to two hundred guests.","ko":"그 호텔은 최대 200명의 손님을 수용할 수 있다."},
    {"en":"The bus was too small to accommodate all the tourists.","ko":"그 버스는 모든 관광객을 태우기에는 너무 작았다."},
    {"en":"The resort accommodates families with children.","ko":"그 리조트는 아이가 있는 가족을 수용한다."}
  ]'::jsonb),
  ('cruise', 2, 15, '명사/동사', '[
    {"en":"They went on a cruise around the islands.","ko":"그들은 섬들을 도는 크루즈 여행을 떠났다."},
    {"en":"The ship cruised along the coast for a week.","ko":"그 배는 일주일 동안 해안을 따라 순항했다."},
    {"en":"A cruise is a relaxing way to see many places.","ko":"크루즈 여행은 여러 곳을 편안하게 볼 수 있는 방법이다."}
  ]'::jsonb),
  ('crew', 2, 15, '명사', '[
    {"en":"The flight crew welcomed the passengers warmly.","ko":"승무원들은 승객들을 따뜻하게 맞이했다."},
    {"en":"The ship''s crew worked through the night.","ko":"그 배의 승무원들은 밤새 일했다."},
    {"en":"The cabin crew explained the safety instructions.","ko":"객실 승무원이 안전 수칙을 설명했다."}
  ]'::jsonb),
  ('navigate', 2, 15, '동사', '[
    {"en":"The captain navigated the ship through the storm.","ko":"선장은 폭풍우 속에서 배를 조종했다."},
    {"en":"We used a map to navigate the unfamiliar city.","ko":"우리는 낯선 도시를 다니기 위해 지도를 사용했다."},
    {"en":"The pilot navigated around the bad weather.","ko":"조종사는 악천후를 피해 항로를 잡았다."}
  ]'::jsonb),
  ('locate', 2, 15, '동사', '[
    {"en":"The hotel is located near the train station.","ko":"그 호텔은 기차역 근처에 위치해 있다."},
    {"en":"We used an app to locate the nearest bus stop.","ko":"우리는 가장 가까운 버스 정류장을 찾기 위해 앱을 사용했다."},
    {"en":"The tourist office is located downtown.","ko":"관광 안내소는 시내 중심가에 있다."}
  ]'::jsonb),
  ('journey', 2, 15, '명사/동사', '[
    {"en":"It was a long journey across the country.","ko":"그것은 나라를 가로지르는 긴 여정이었다."},
    {"en":"Their journey took them through several small towns.","ko":"그들의 여정은 여러 작은 마을을 거쳤다."},
    {"en":"We journeyed by train through the mountains.","ko":"우리는 산을 가로질러 기차로 여행했다."}
  ]'::jsonb),
  ('spectacle', 2, 15, '명사', '[
    {"en":"The sunset over the ocean was an amazing spectacle.","ko":"바다 위로 지는 노을은 놀라운 광경이었다."},
    {"en":"Tourists gathered to watch the spectacle of the fireworks.","ko":"관광객들은 불꽃놀이라는 장관을 보기 위해 모였다."},
    {"en":"The parade was quite a spectacle for visitors.","ko":"그 퍼레이드는 방문객들에게 정말 볼만한 광경이었다."}
  ]'::jsonb),
  ('come across', 2, 15, '동사구', '[
    {"en":"We came across a beautiful village during our trip.","ko":"우리는 여행 중에 아름다운 마을을 우연히 발견했다."},
    {"en":"She came across an old map in the museum.","ko":"그녀는 박물관에서 오래된 지도를 우연히 보게 되었다."},
    {"en":"They came across a friendly local who gave them directions.","ko":"그들은 길을 알려준 친절한 현지인을 우연히 만났다."}
  ]'::jsonb),
  ('head for', 2, 15, '동사구', '[
    {"en":"The ship headed for the nearest port.","ko":"그 배는 가장 가까운 항구로 향했다."},
    {"en":"We headed for the airport early to avoid traffic.","ko":"우리는 교통 혼잡을 피하기 위해 일찍 공항으로 향했다."},
    {"en":"The tour group headed for the mountains at dawn.","ko":"그 여행단은 새벽에 산으로 향했다."}
  ]'::jsonb),
  ('pull over', 2, 15, '동사구', '[
    {"en":"The driver pulled over to check the map.","ko":"운전자는 지도를 확인하기 위해 차를 세웠다."},
    {"en":"Please pull over at the next rest area.","ko":"다음 휴게소에서 차를 세워 주세요."},
    {"en":"The bus pulled over to let passengers get off.","ko":"버스는 승객들이 내릴 수 있도록 정차했다."}
  ]'::jsonb),

  ('appreciate', 2, 16, '동사', '[
    {"en":"She learned to appreciate classical music at a young age.","ko":"그녀는 어릴 때부터 클래식 음악을 감상하는 법을 배웠다."},
    {"en":"Visitors can appreciate the artist''s skill in every painting.","ko":"방문객들은 모든 그림에서 그 화가의 기량을 느낄 수 있다."},
    {"en":"He appreciates good literature.","ko":"그는 좋은 문학 작품의 가치를 안다."}
  ]'::jsonb),
  ('craft', 2, 16, '명사', '[
    {"en":"The museum displayed traditional crafts from the region.","ko":"그 박물관은 그 지역의 전통 공예품을 전시했다."},
    {"en":"She learned the craft of pottery from her grandmother.","ko":"그녀는 할머니로부터 도자기 공예를 배웠다."},
    {"en":"Every piece shows the artist''s craft and patience.","ko":"모든 작품이 그 예술가의 기술과 인내를 보여준다."}
  ]'::jsonb),
  ('exhibit', 2, 16, '동사/명사', '[
    {"en":"The gallery exhibited paintings from local artists.","ko":"그 갤러리는 지역 예술가들의 그림을 전시했다."},
    {"en":"We visited an exhibit of ancient sculptures.","ko":"우리는 고대 조각품 전시회를 방문했다."},
    {"en":"Her work was exhibited at the national museum.","ko":"그녀의 작품은 국립 박물관에 전시되었다."}
  ]'::jsonb),
  ('literature', 2, 16, '명사', '[
    {"en":"She studies English literature at university.","ko":"그녀는 대학에서 영문학을 공부한다."},
    {"en":"Classic literature often explores universal themes.","ko":"고전 문학은 흔히 보편적인 주제를 탐구한다."},
    {"en":"The teacher assigned a famous piece of literature.","ko":"선생님은 유명한 문학 작품을 과제로 내주셨다."}
  ]'::jsonb),
  ('version', 2, 16, '명사', '[
    {"en":"This is a modern version of an old folk tale.","ko":"이것은 오래된 전래 동화의 현대판이다."},
    {"en":"The movie is based on a different version of the story.","ko":"그 영화는 이야기의 다른 버전을 바탕으로 한다."},
    {"en":"He prefers the original version of the song.","ko":"그는 그 노래의 원곡 버전을 더 좋아한다."}
  ]'::jsonb),
  ('copyright', 2, 16, '명사/동사', '[
    {"en":"The copyright of the book belongs to the author.","ko":"그 책의 저작권은 저자에게 있다."},
    {"en":"You cannot copy the artwork without permission because of copyright.","ko":"저작권 때문에 허락 없이 그 작품을 복제할 수 없다."},
    {"en":"The song was copyrighted before it was released.","ko":"그 노래는 발매되기 전에 저작권 등록이 되었다."}
  ]'::jsonb),
  ('tone', 2, 16, '명사', '[
    {"en":"The painting has a calm and peaceful tone.","ko":"그 그림은 차분하고 평화로운 색조를 띠고 있다."},
    {"en":"The author''s tone changes throughout the novel.","ko":"작가의 어조는 소설 전반에 걸쳐 변화한다."},
    {"en":"The singer''s tone was gentle and warm.","ko":"그 가수의 음색은 부드럽고 따뜻했다."}
  ]'::jsonb),
  ('noble', 2, 16, '형용사', '[
    {"en":"The story tells of a noble knight and his quest.","ko":"그 이야기는 고귀한 기사와 그의 모험에 관한 것이다."},
    {"en":"The character showed noble qualities like honesty and courage.","ko":"그 등장인물은 정직과 용기 같은 고결한 자질을 보여주었다."},
    {"en":"The novel is set in a noble family''s estate.","ko":"그 소설은 귀족 가문의 저택을 배경으로 한다."}
  ]'::jsonb),
  ('conduct', 2, 16, '동사', '[
    {"en":"She conducted the orchestra during the concert.","ko":"그녀는 콘서트에서 오케스트라를 지휘했다."},
    {"en":"He was chosen to conduct the school choir.","ko":"그는 학교 합창단을 지휘하도록 선택되었다."},
    {"en":"The famous conductor led the performance with great energy.","ko":"그 유명한 지휘자는 넘치는 에너지로 공연을 이끌었다."}
  ]'::jsonb),
  ('tune', 2, 16, '명사/동사', '[
    {"en":"The song had a catchy tune.","ko":"그 노래는 귀에 쏙 들어오는 곡조를 가지고 있었다."},
    {"en":"He tuned his guitar before the performance.","ko":"그는 공연 전에 기타를 조율했다."},
    {"en":"She hummed the tune from the movie.","ko":"그녀는 그 영화의 멜로디를 흥얼거렸다."}
  ]'::jsonb),
  ('director', 2, 16, '명사', '[
    {"en":"The director praised the actors'' performance.","ko":"감독은 배우들의 연기를 칭찬했다."},
    {"en":"She became a film director after years of study.","ko":"그녀는 오랜 공부 끝에 영화감독이 되었다."},
    {"en":"The theater director chose an unusual setting for the play.","ko":"그 연극 감독은 독특한 배경을 그 연극에 선택했다."}
  ]'::jsonb),
  ('theme', 2, 16, '명사', '[
    {"en":"The main theme of the novel is friendship.","ko":"그 소설의 주된 주제는 우정이다."},
    {"en":"Each painting in the exhibit shares a common theme.","ko":"전시회의 각 그림은 공통된 주제를 공유한다."},
    {"en":"The movie explores the theme of courage.","ko":"그 영화는 용기라는 주제를 탐구한다."}
  ]'::jsonb),
  ('chorus', 2, 16, '명사', '[
    {"en":"The chorus sang beautifully during the concert.","ko":"합창단은 콘서트에서 아름답게 노래했다."},
    {"en":"Everyone joined in for the chorus of the song.","ko":"모두가 그 노래의 후렴구를 함께 불렀다."},
    {"en":"The school chorus performed at the festival.","ko":"학교 합창단이 축제에서 공연했다."}
  ]'::jsonb),
  ('interval', 2, 16, '명사', '[
    {"en":"There was a short interval between the two acts.","ko":"두 막 사이에 짧은 휴식 시간이 있었다."},
    {"en":"During the interval, the audience discussed the performance.","ko":"휴식 시간 동안 관객들은 공연에 대해 이야기를 나누었다."},
    {"en":"The orchestra took a brief interval before the final piece.","ko":"오케스트라는 마지막 곡 전에 짧은 휴식을 가졌다."}
  ]'::jsonb),
  ('rehearse', 2, 16, '동사', '[
    {"en":"The actors rehearsed their lines every day before the show.","ko":"배우들은 공연 전에 매일 대사를 연습했다."},
    {"en":"The band rehearsed for hours before the concert.","ko":"그 밴드는 콘서트 전에 몇 시간 동안 연습했다."},
    {"en":"They rehearsed the play until every scene was perfect.","ko":"그들은 모든 장면이 완벽해질 때까지 연극을 연습했다."}
  ]'::jsonb),
  ('compose', 2, 16, '동사', '[
    {"en":"The musician composed a new symphony for the festival.","ko":"그 음악가는 축제를 위해 새로운 교향곡을 작곡했다."},
    {"en":"She composed a poem about the changing seasons.","ko":"그녀는 변화하는 계절에 관한 시를 지었다."},
    {"en":"He composed the soundtrack for the film.","ko":"그는 그 영화의 삽입곡을 작곡했다."}
  ]'::jsonb),
  ('sculpture', 2, 16, '명사', '[
    {"en":"The sculpture in the park was carved from marble.","ko":"공원에 있는 그 조각상은 대리석으로 조각되었다."},
    {"en":"She studies sculpture at the art academy.","ko":"그녀는 미술 학원에서 조각을 공부한다."},
    {"en":"The museum''s collection includes ancient sculptures.","ko":"그 박물관의 소장품에는 고대 조각품들이 포함되어 있다."}
  ]'::jsonb),
  ('masterpiece', 2, 16, '명사', '[
    {"en":"The painting is considered a masterpiece of the era.","ko":"그 그림은 그 시대의 걸작으로 여겨진다."},
    {"en":"Critics called the novel a literary masterpiece.","ko":"평론가들은 그 소설을 문학의 걸작이라고 불렀다."},
    {"en":"The film is regarded as the director''s masterpiece.","ko":"그 영화는 감독의 대표작으로 여겨진다."}
  ]'::jsonb),
  ('classic', 2, 16, '명사/형용사', '[
    {"en":"This novel is considered a classic of world literature.","ko":"이 소설은 세계 문학의 고전으로 여겨진다."},
    {"en":"They performed a classic piece by a famous composer.","ko":"그들은 유명 작곡가의 고전 작품을 연주했다."},
    {"en":"The movie has become a classic over the years.","ko":"그 영화는 세월이 흐르며 명작이 되었다."}
  ]'::jsonb),
  ('imitate', 2, 16, '동사', '[
    {"en":"Young artists often imitate the style of famous painters.","ko":"젊은 화가들은 종종 유명 화가들의 화풍을 모방한다."},
    {"en":"The actor imitated the character''s voice perfectly.","ko":"그 배우는 그 캐릭터의 목소리를 완벽하게 흉내 냈다."},
    {"en":"She imitated the melody she heard on the radio.","ko":"그녀는 라디오에서 들은 선율을 흉내 냈다."}
  ]'::jsonb),
  ('tradition', 2, 16, '명사', '[
    {"en":"The festival is part of a long-standing tradition.","ko":"그 축제는 오랜 전통의 일부이다."},
    {"en":"This dance has been passed down through tradition.","ko":"이 춤은 전통을 통해 전해져 내려왔다."},
    {"en":"The play follows a tradition of storytelling.","ko":"그 연극은 이야기 전달의 전통을 따른다."}
  ]'::jsonb),
  ('exclaim', 2, 16, '동사', '[
    {"en":"The audience exclaimed with joy at the final scene.","ko":"관객들은 마지막 장면에서 기쁨의 탄성을 질렀다."},
    {"en":"What a wonderful performance she exclaimed.","ko":"그녀는 정말 멋진 공연이라고 외쳤다."},
    {"en":"He exclaimed in surprise when the curtain rose.","ko":"그는 막이 오르자 놀라서 소리쳤다."}
  ]'::jsonb),
  ('creature', 2, 16, '명사', '[
    {"en":"The fantasy novel is filled with strange creatures.","ko":"그 판타지 소설은 기이한 생명체들로 가득하다."},
    {"en":"The artist painted a mythical creature on the wall.","ko":"그 화가는 벽에 신화 속 생명체를 그렸다."},
    {"en":"The film features creatures created with special effects.","ko":"그 영화는 특수 효과로 만들어진 생명체들을 등장시킨다."}
  ]'::jsonb),
  ('distinct', 2, 16, '형용사', '[
    {"en":"Each character in the play has a distinct personality.","ko":"그 연극의 각 등장인물은 뚜렷한 개성을 지니고 있다."},
    {"en":"The painting has a distinct style unlike any other.","ko":"그 그림은 다른 어떤 것과도 다른 독특한 화풍을 지니고 있다."},
    {"en":"The two versions of the story are quite distinct.","ko":"그 이야기의 두 버전은 상당히 다르다."}
  ]'::jsonb),
  ('context', 2, 16, '명사', '[
    {"en":"Understanding the historical context helps explain the novel''s themes.","ko":"역사적 맥락을 이해하면 그 소설의 주제를 설명하는 데 도움이 된다."},
    {"en":"The poem makes more sense in the context of the war.","ko":"그 시는 전쟁이라는 맥락에서 더 잘 이해된다."},
    {"en":"The teacher explained the cultural context of the artwork.","ko":"선생님은 그 작품의 문화적 배경을 설명해 주었다."}
  ]'::jsonb),
  ('monologue', 2, 16, '명사', '[
    {"en":"The actor delivered a powerful monologue in the final scene.","ko":"그 배우는 마지막 장면에서 강렬한 독백을 했다."},
    {"en":"She wrote a monologue for her drama class.","ko":"그녀는 연극 수업을 위해 독백을 썼다."},
    {"en":"The play opens with a short monologue.","ko":"그 연극은 짧은 독백으로 시작한다."}
  ]'::jsonb),
  ('tragedy', 2, 16, '명사', '[
    {"en":"The play is a classic tragedy about fate and loss.","ko":"그 연극은 운명과 상실에 관한 고전 비극이다."},
    {"en":"The story ends in tragedy for the main character.","ko":"그 이야기는 주인공에게 비극으로 끝난다."},
    {"en":"Shakespeare wrote many famous tragedies.","ko":"셰익스피어는 많은 유명한 비극 작품을 썼다."}
  ]'::jsonb),
  ('line up', 2, 16, '동사구', '[
    {"en":"Fans lined up early to buy concert tickets.","ko":"팬들은 콘서트 표를 사기 위해 일찍부터 줄을 섰다."},
    {"en":"The actors lined up on stage for the final bow.","ko":"배우들은 마지막 인사를 위해 무대에 줄지어 섰다."},
    {"en":"People lined up outside the gallery to see the exhibit.","ko":"사람들은 전시를 보기 위해 갤러리 밖에 줄을 섰다."}
  ]'::jsonb),
  ('live up to', 2, 16, '동사구', '[
    {"en":"The movie lived up to everyone''s high expectations.","ko":"그 영화는 모두의 높은 기대에 부응했다."},
    {"en":"The performance failed to live up to its reputation.","ko":"그 공연은 명성에 걸맞은 수준에 미치지 못했다."},
    {"en":"She worked hard to live up to her mentor''s advice.","ko":"그녀는 스승의 조언에 부응하기 위해 열심히 노력했다."}
  ]'::jsonb),
  ('be into', 2, 16, '동사구', '[
    {"en":"He has been into painting since he was a child.","ko":"그는 어릴 때부터 그림에 푹 빠져 있었다."},
    {"en":"She is really into classical music these days.","ko":"그녀는 요즘 클래식 음악에 푹 빠져 있다."},
    {"en":"Many students are into modern art.","ko":"많은 학생들이 현대 미술에 관심이 많다."}
  ]'::jsonb),

  ('condition', 2, 17, '명사', '[
    {"en":"The patient''s condition improved after treatment.","ko":"환자의 상태는 치료 후 호전되었다."},
    {"en":"He exercises daily to stay in good condition.","ko":"그는 좋은 컨디션을 유지하기 위해 매일 운동한다."},
    {"en":"The doctor asked about her medical condition.","ko":"의사는 그녀의 건강 상태에 대해 물었다."}
  ]'::jsonb),
  ('chemical', 2, 17, '명사/형용사', '[
    {"en":"The medicine contains several chemical ingredients.","ko":"그 약에는 여러 화학 성분이 들어 있다."},
    {"en":"Scientists study chemical reactions in the body.","ko":"과학자들은 신체 내의 화학 반응을 연구한다."},
    {"en":"The hospital handles chemical substances carefully.","ko":"그 병원은 화학 물질을 조심스럽게 다룬다."}
  ]'::jsonb),
  ('digest', 2, 17, '동사', '[
    {"en":"It takes time for the body to digest food.","ko":"몸이 음식을 소화하는 데는 시간이 걸린다."},
    {"en":"Some foods are harder to digest than others.","ko":"어떤 음식들은 다른 음식보다 소화시키기 어렵다."},
    {"en":"Eating slowly helps you digest your meal properly.","ko":"천천히 먹는 것은 음식을 제대로 소화하는 데 도움이 된다."}
  ]'::jsonb),
  ('disorder', 2, 17, '명사', '[
    {"en":"The doctor diagnosed him with a sleep disorder.","ko":"의사는 그에게 수면 장애를 진단했다."},
    {"en":"Stress can lead to various health disorders.","ko":"스트레스는 다양한 건강 장애로 이어질 수 있다."},
    {"en":"She was treated for a mild eating disorder.","ko":"그녀는 경미한 섭식 장애로 치료를 받았다."}
  ]'::jsonb),
  ('worsen', 2, 17, '동사', '[
    {"en":"His condition worsened despite the treatment.","ko":"치료에도 불구하고 그의 상태는 악화되었다."},
    {"en":"The symptoms worsened during the night.","ko":"증상은 밤사이에 악화되었다."},
    {"en":"Doctors warned that the illness could worsen without rest.","ko":"의사들은 휴식을 취하지 않으면 병이 악화될 수 있다고 경고했다."}
  ]'::jsonb),
  ('dental', 2, 17, '형용사', '[
    {"en":"Regular dental checkups keep your teeth healthy.","ko":"정기적인 치과 검진은 치아를 건강하게 유지시켜 준다."},
    {"en":"She visited the dental clinic for a checkup.","ko":"그녀는 검진을 받기 위해 치과에 방문했다."},
    {"en":"Good dental hygiene prevents cavities.","ko":"좋은 치아 위생은 충치를 예방한다."}
  ]'::jsonb),
  ('medical', 2, 17, '형용사', '[
    {"en":"He received medical treatment right away.","ko":"그는 즉시 의료 치료를 받았다."},
    {"en":"The hospital provides medical care for all patients.","ko":"그 병원은 모든 환자에게 의료 서비스를 제공한다."},
    {"en":"She works in the medical field as a nurse.","ko":"그녀는 간호사로 의료 분야에서 일한다."}
  ]'::jsonb),
  ('mental', 2, 17, '형용사', '[
    {"en":"Mental health is just as important as physical health.","ko":"정신 건강은 신체 건강만큼이나 중요하다."},
    {"en":"Regular exercise can improve your mental well-being.","ko":"규칙적인 운동은 정신적 웰빙을 향상시킬 수 있다."},
    {"en":"The counselor specializes in mental health issues.","ko":"그 상담사는 정신 건강 문제를 전문으로 다룬다."}
  ]'::jsonb),
  ('recover', 2, 17, '동사', '[
    {"en":"It took her a few weeks to recover from the flu.","ko":"그녀가 독감에서 회복하는 데 몇 주가 걸렸다."},
    {"en":"He is recovering well after the surgery.","ko":"그는 수술 후 잘 회복하고 있다."},
    {"en":"Patients need rest to recover quickly.","ko":"환자들은 빨리 회복하기 위해 휴식이 필요하다."}
  ]'::jsonb),
  ('emergency', 2, 17, '명사', '[
    {"en":"Call the hospital immediately in case of an emergency.","ko":"응급 상황이 발생하면 즉시 병원에 전화해라."},
    {"en":"The emergency room was full of patients.","ko":"응급실은 환자들로 가득했다."},
    {"en":"She knew what to do in a medical emergency.","ko":"그녀는 의료 응급 상황에서 무엇을 해야 할지 알고 있었다."}
  ]'::jsonb),
  ('allergy', 2, 17, '명사', '[
    {"en":"He has an allergy to peanuts.","ko":"그는 땅콩 알레르기가 있다."},
    {"en":"Many people suffer from seasonal allergies.","ko":"많은 사람들이 계절성 알레르기로 고생한다."},
    {"en":"The doctor tested her for food allergies.","ko":"의사는 그녀에게 음식 알레르기 검사를 했다."}
  ]'::jsonb),
  ('joint', 2, 17, '명사', '[
    {"en":"Her knee joint was injured during the game.","ko":"그녀의 무릎 관절은 경기 중에 다쳤다."},
    {"en":"Arthritis affects the joints in older people.","ko":"관절염은 노인들의 관절에 영향을 미친다."},
    {"en":"He felt pain in his shoulder joint.","ko":"그는 어깨 관절에서 통증을 느꼈다."}
  ]'::jsonb),
  ('spine', 2, 17, '명사', '[
    {"en":"The doctor examined his spine after the accident.","ko":"의사는 사고 후 그의 척추를 검사했다."},
    {"en":"Sitting incorrectly can harm your spine.","ko":"잘못된 자세로 앉는 것은 척추에 해로울 수 있다."},
    {"en":"The surgery repaired a damaged spine.","ko":"그 수술은 손상된 척추를 복구했다."}
  ]'::jsonb),
  ('sight', 2, 17, '명사', '[
    {"en":"Her sight improved after the eye surgery.","ko":"그녀의 시력은 눈 수술 후 좋아졌다."},
    {"en":"He lost his sight in one eye due to the injury.","ko":"그는 부상으로 한쪽 눈의 시력을 잃었다."},
    {"en":"Regular checkups can protect your sight.","ko":"정기 검진은 시력을 보호하는 데 도움이 된다."}
  ]'::jsonb),
  ('pulse', 2, 17, '명사', '[
    {"en":"The nurse checked his pulse before the exam.","ko":"간호사는 검사 전에 그의 맥박을 확인했다."},
    {"en":"Her pulse was faster than normal.","ko":"그녀의 맥박은 평소보다 빨랐다."},
    {"en":"The doctor measured the patient''s pulse rate.","ko":"의사는 환자의 맥박수를 측정했다."}
  ]'::jsonb),
  ('infection', 2, 17, '명사', '[
    {"en":"The wound became infected after a few days.","ko":"그 상처는 며칠 후 감염되었다."},
    {"en":"Doctors treated the infection with antibiotics.","ko":"의사들은 항생제로 감염을 치료했다."},
    {"en":"She developed an ear infection last week.","ko":"그녀는 지난주에 귀 감염이 생겼다."}
  ]'::jsonb),
  ('sanitary', 2, 17, '형용사', '[
    {"en":"The hospital maintains strict sanitary conditions.","ko":"그 병원은 엄격한 위생 상태를 유지한다."},
    {"en":"It is important to keep the kitchen sanitary.","ko":"주방을 위생적으로 유지하는 것은 중요하다."},
    {"en":"The clinic follows sanitary guidelines carefully.","ko":"그 병원은 위생 지침을 철저히 준수한다."}
  ]'::jsonb),
  ('symptom', 2, 17, '명사', '[
    {"en":"A high fever is a common symptom of the flu.","ko":"고열은 독감의 흔한 증상이다."},
    {"en":"The doctor asked about his symptoms.","ko":"의사는 그의 증상에 대해 물었다."},
    {"en":"Early symptoms of the illness were mild.","ko":"그 병의 초기 증상은 가벼웠다."}
  ]'::jsonb),
  ('disabled', 2, 17, '형용사', '[
    {"en":"The building has ramps for disabled visitors.","ko":"그 건물에는 장애가 있는 방문객을 위한 경사로가 있다."},
    {"en":"She works to support disabled students.","ko":"그녀는 장애가 있는 학생들을 지원하는 일을 한다."},
    {"en":"The park offers facilities for disabled athletes.","ko":"그 공원은 장애인 선수들을 위한 시설을 제공한다."}
  ]'::jsonb),
  ('inject', 2, 17, '동사', '[
    {"en":"The nurse injected the medicine into his arm.","ko":"간호사는 그의 팔에 약을 주사했다."},
    {"en":"Doctors inject vaccines to prevent disease.","ko":"의사들은 질병을 예방하기 위해 백신을 주사한다."},
    {"en":"The patient was injected with a painkiller.","ko":"그 환자는 진통제를 주사 맞았다."}
  ]'::jsonb),
  ('prescribe', 2, 17, '동사', '[
    {"en":"The doctor prescribed antibiotics for the infection.","ko":"의사는 감염에 대해 항생제를 처방했다."},
    {"en":"She was prescribed medicine for her allergy.","ko":"그녀는 알레르기 약을 처방받았다."},
    {"en":"The physician prescribed rest and plenty of water.","ko":"의사는 휴식과 충분한 수분 섭취를 처방했다."}
  ]'::jsonb),
  ('tablet', 2, 17, '명사', '[
    {"en":"He took a tablet to relieve his headache.","ko":"그는 두통을 완화하기 위해 알약을 먹었다."},
    {"en":"The pharmacist gave her tablets for the cold.","ko":"약사는 그녀에게 감기약 알약을 주었다."},
    {"en":"Take one tablet after each meal.","ko":"매 식사 후 알약 하나를 복용해라."}
  ]'::jsonb),
  ('wound', 2, 17, '명사', '[
    {"en":"The nurse cleaned the wound carefully.","ko":"간호사는 상처를 조심스럽게 소독했다."},
    {"en":"His wound healed within a week.","ko":"그의 상처는 일주일 만에 나았다."},
    {"en":"The doctor treated the small wound on her arm.","ko":"의사는 그녀 팔의 작은 상처를 치료했다."}
  ]'::jsonb),
  ('injure', 2, 17, '동사', '[
    {"en":"He injured his ankle while playing soccer.","ko":"그는 축구를 하다가 발목을 다쳤다."},
    {"en":"The accident injured several passengers.","ko":"그 사고로 여러 승객이 다쳤다."},
    {"en":"She was slightly injured during the hike.","ko":"그녀는 하이킹 중에 가벼운 부상을 입었다."}
  ]'::jsonb),
  ('heal', 2, 17, '동사', '[
    {"en":"The cut on his hand healed quickly.","ko":"그의 손에 난 상처는 빨리 나았다."},
    {"en":"Rest allows the body to heal properly.","ko":"휴식은 몸이 제대로 회복하도록 해준다."},
    {"en":"The doctor said the wound would heal in a few days.","ko":"의사는 상처가 며칠 안에 나을 것이라고 말했다."}
  ]'::jsonb),
  ('immune', 2, 17, '형용사', '[
    {"en":"Vaccines help the body become immune to certain diseases.","ko":"백신은 몸이 특정 질병에 면역이 되도록 돕는다."},
    {"en":"A healthy diet strengthens your immune system.","ko":"건강한 식단은 면역 체계를 강화한다."},
    {"en":"He seemed immune to the common cold this winter.","ko":"그는 이번 겨울에 감기에 면역이 된 것처럼 보였다."}
  ]'::jsonb),
  ('strain', 2, 17, '명사/동사', '[
    {"en":"She strained her back while lifting a heavy box.","ko":"그녀는 무거운 상자를 들다가 허리를 삐끗했다."},
    {"en":"Too much exercise can strain your muscles.","ko":"지나친 운동은 근육에 무리를 줄 수 있다."},
    {"en":"The doctor recommended rest to reduce the strain.","ko":"의사는 부담을 줄이기 위해 휴식을 권했다."}
  ]'::jsonb),
  ('bruise', 2, 17, '명사/동사', '[
    {"en":"He got a bruise on his leg after the fall.","ko":"그는 넘어진 후 다리에 멍이 들었다."},
    {"en":"The bruise disappeared after a few days.","ko":"그 멍은 며칠 후 사라졌다."},
    {"en":"She bruised her arm during the game.","ko":"그녀는 경기 중에 팔에 멍이 들었다."}
  ]'::jsonb),
  ('come down with', 2, 17, '동사구', '[
    {"en":"He came down with a cold last week.","ko":"그는 지난주에 감기에 걸렸다."},
    {"en":"She came down with the flu during winter break.","ko":"그녀는 겨울 방학 동안 독감에 걸렸다."},
    {"en":"Many students came down with a fever after the trip.","ko":"많은 학생들이 여행 후 열병에 걸렸다."}
  ]'::jsonb),
  ('ease off', 2, 17, '동사구', '[
    {"en":"The pain began to ease off after taking medicine.","ko":"약을 먹은 후 통증이 완화되기 시작했다."},
    {"en":"The doctor advised him to ease off intense exercise.","ko":"의사는 그에게 격렬한 운동을 줄이라고 권했다."},
    {"en":"Her cough eased off after a few days of rest.","ko":"그녀의 기침은 며칠간의 휴식 후에 잦아들었다."}
  ]'::jsonb),

  ('enrich', 2, 18, '동사', '[
    {"en":"Reading books can enrich your knowledge.","ko":"책을 읽는 것은 지식을 풍부하게 해줄 수 있다."},
    {"en":"The fertilizer enriches the soil for better crops.","ko":"그 비료는 더 좋은 작물을 위해 토양을 비옥하게 한다."},
    {"en":"Travel experiences enrich one''s understanding of other cultures.","ko":"여행 경험은 다른 문화에 대한 이해를 풍부하게 해준다."}
  ]'::jsonb),
  ('barrel', 2, 18, '명사', '[
    {"en":"The price of oil rose to over eighty dollars a barrel.","ko":"기름값이 배럴당 80달러 넘게 올랐다."},
    {"en":"The farm stored apples in wooden barrels.","ko":"그 농장은 사과를 나무통에 보관했다."},
    {"en":"A barrel of oil is a common unit in trade.","ko":"석유 1배럴은 무역에서 흔히 쓰이는 단위이다."}
  ]'::jsonb),
  ('herd', 2, 18, '명사', '[
    {"en":"A herd of cattle grazed in the field.","ko":"소 떼가 들판에서 풀을 뜯고 있었다."},
    {"en":"The farmer moved the herd to a new pasture.","ko":"농부는 가축 떼를 새로운 목초지로 옮겼다."},
    {"en":"A large herd of sheep crossed the road.","ko":"큰 양 떼가 길을 건넜다."}
  ]'::jsonb),
  ('crisis', 2, 18, '명사', '[
    {"en":"The country faced an economic crisis last year.","ko":"그 나라는 작년에 경제 위기에 직면했다."},
    {"en":"The company took steps to avoid a financial crisis.","ko":"그 회사는 재정 위기를 피하기 위한 조치를 취했다."},
    {"en":"Experts discussed ways to solve the energy crisis.","ko":"전문가들은 에너지 위기를 해결할 방법을 논의했다."}
  ]'::jsonb),
  ('provide', 2, 18, '동사', '[
    {"en":"The factory provides jobs for many local workers.","ko":"그 공장은 많은 지역 노동자들에게 일자리를 제공한다."},
    {"en":"Farmers provide food for the entire region.","ko":"농부들은 그 지역 전체에 식량을 공급한다."},
    {"en":"The government provides support for small businesses.","ko":"정부는 소규모 사업체를 지원한다."}
  ]'::jsonb),
  ('material', 2, 18, '명사/형용사', '[
    {"en":"The factory uses recycled material to make products.","ko":"그 공장은 제품을 만드는 데 재활용 재료를 사용한다."},
    {"en":"Raw materials are shipped from overseas.","ko":"원자재는 해외에서 배로 들어온다."},
    {"en":"The company focuses on material rather than design.","ko":"그 회사는 디자인보다 재질에 중점을 둔다."}
  ]'::jsonb),
  ('export', 2, 18, '동사/명사', '[
    {"en":"The country exports large amounts of grain each year.","ko":"그 나라는 매년 대량의 곡물을 수출한다."},
    {"en":"Exports increased due to strong demand overseas.","ko":"해외 수요 증가로 수출이 늘었다."},
    {"en":"They export electronics to many countries.","ko":"그들은 여러 나라에 전자제품을 수출한다."}
  ]'::jsonb),
  ('construct', 2, 18, '동사', '[
    {"en":"The company plans to construct a new factory.","ko":"그 회사는 새 공장을 건설할 계획이다."},
    {"en":"Workers constructed the bridge in less than a year.","ko":"노동자들은 1년도 안 되어 그 다리를 건설했다."},
    {"en":"The government is constructing new roads in rural areas.","ko":"정부는 농촌 지역에 새 도로를 건설하고 있다."}
  ]'::jsonb),
  ('pollution', 2, 18, '명사', '[
    {"en":"Air pollution is a serious problem in big cities.","ko":"대기 오염은 대도시에서 심각한 문제이다."},
    {"en":"The factory reduced pollution by using cleaner energy.","ko":"그 공장은 더 깨끗한 에너지를 사용해 오염을 줄였다."},
    {"en":"Water pollution affects both farms and wildlife.","ko":"수질 오염은 농장과 야생 동물 모두에 영향을 미친다."}
  ]'::jsonb),
  ('agriculture', 2, 18, '명사', '[
    {"en":"Agriculture remains an important part of the economy.","ko":"농업은 여전히 경제의 중요한 부분이다."},
    {"en":"Modern agriculture relies heavily on technology.","ko":"현대 농업은 기술에 크게 의존한다."},
    {"en":"The region is known for its agriculture and farming.","ko":"그 지역은 농업과 경작으로 유명하다."}
  ]'::jsonb),
  ('graze', 2, 18, '동사', '[
    {"en":"The cows grazed peacefully in the field.","ko":"소들은 들판에서 평화롭게 풀을 뜯었다."},
    {"en":"Sheep grazed on the hillside all afternoon.","ko":"양들은 오후 내내 언덕에서 풀을 뜯었다."},
    {"en":"The farmer let the cattle graze near the river.","ko":"농부는 소들이 강 근처에서 풀을 뜯게 했다."}
  ]'::jsonb),
  ('pasture', 2, 18, '명사', '[
    {"en":"The cattle were moved to a fresh pasture.","ko":"소들은 새로운 목초지로 옮겨졌다."},
    {"en":"The farm has wide pastures for grazing animals.","ko":"그 농장에는 가축을 방목할 넓은 목초지가 있다."},
    {"en":"Sheep spent the day in the green pasture.","ko":"양들은 푸른 목초지에서 하루를 보냈다."}
  ]'::jsonb),
  ('cattle', 2, 18, '명사', '[
    {"en":"The farmer raises cattle for milk and meat.","ko":"그 농부는 우유와 고기를 위해 소를 기른다."},
    {"en":"A large number of cattle grazed on the farm.","ko":"많은 수의 소들이 농장에서 풀을 뜯었다."},
    {"en":"Cattle farming is common in this region.","ko":"이 지역에서는 축산업이 흔하다."}
  ]'::jsonb),
  ('cultivate', 2, 18, '동사', '[
    {"en":"Farmers cultivate rice in the fertile valley.","ko":"농부들은 비옥한 계곡에서 벼를 경작한다."},
    {"en":"The land was cultivated for growing vegetables.","ko":"그 땅은 채소를 재배하기 위해 경작되었다."},
    {"en":"They cultivate crops using modern farming methods.","ko":"그들은 현대적인 농법을 이용해 작물을 재배한다."}
  ]'::jsonb),
  ('concrete', 2, 18, '명사/형용사', '[
    {"en":"The building was made of concrete and steel.","ko":"그 건물은 콘크리트와 철강으로 지어졌다."},
    {"en":"Workers poured concrete for the new road.","ko":"노동자들은 새 도로를 위해 콘크리트를 부었다."},
    {"en":"The factory floor is made of solid concrete.","ko":"그 공장 바닥은 단단한 콘크리트로 되어 있다."}
  ]'::jsonb),
  ('crane', 2, 18, '명사', '[
    {"en":"A large crane lifted the steel beams onto the building.","ko":"큰 기중기가 철제 대들보를 건물 위로 들어 올렸다."},
    {"en":"The construction site used two cranes for the project.","ko":"그 공사 현장은 그 프로젝트에 두 대의 기중기를 사용했다."},
    {"en":"The crane moved heavy materials across the yard.","ko":"그 기중기는 무거운 자재를 마당 건너로 옮겼다."}
  ]'::jsonb),
  ('invest', 2, 18, '동사', '[
    {"en":"The company invested heavily in new technology.","ko":"그 회사는 신기술에 많은 투자를 했다."},
    {"en":"Farmers invested in modern equipment to boost production.","ko":"농부들은 생산량을 늘리기 위해 현대적인 장비에 투자했다."},
    {"en":"The government invested in rural infrastructure.","ko":"정부는 농촌 기반 시설에 투자했다."}
  ]'::jsonb),
  ('expand', 2, 18, '동사', '[
    {"en":"The company plans to expand its business overseas.","ko":"그 회사는 해외로 사업을 확장할 계획이다."},
    {"en":"Agriculture expanded rapidly with new farming techniques.","ko":"새로운 농업 기술로 농업이 빠르게 확대되었다."},
    {"en":"The factory expanded its facilities to meet demand.","ko":"그 공장은 수요를 충족시키기 위해 시설을 확장했다."}
  ]'::jsonb),
  ('scale', 2, 18, '명사', '[
    {"en":"The farm operates on a large scale.","ko":"그 농장은 대규모로 운영된다."},
    {"en":"The factory increased production on a massive scale.","ko":"그 공장은 대규모로 생산을 늘렸다."},
    {"en":"They measured the crops on a small scale first.","ko":"그들은 먼저 소규모로 작물을 측정했다."}
  ]'::jsonb),
  ('proportion', 2, 18, '명사', '[
    {"en":"A large proportion of the land is used for farming.","ko":"그 땅의 상당 부분이 농사에 사용된다."},
    {"en":"The proportion of exports to total production grew steadily.","ko":"총생산 대비 수출 비율이 꾸준히 증가했다."},
    {"en":"Only a small proportion of workers are in agriculture.","ko":"노동자 중 극히 일부만이 농업에 종사한다."}
  ]'::jsonb),
  ('surpass', 2, 18, '동사', '[
    {"en":"This year''s harvest surpassed last year''s total.","ko":"올해 수확량은 작년 총량을 넘어섰다."},
    {"en":"The company''s exports surpassed expectations.","ko":"그 회사의 수출은 기대치를 뛰어넘었다."},
    {"en":"Production levels surpassed the previous record.","ko":"생산량은 이전 기록을 넘어섰다."}
  ]'::jsonb),
  ('generate', 2, 18, '동사', '[
    {"en":"The factory generates hundreds of jobs in the area.","ko":"그 공장은 그 지역에 수백 개의 일자리를 창출한다."},
    {"en":"Solar panels generate electricity for the farm.","ko":"태양광 패널은 농장을 위한 전기를 생산한다."},
    {"en":"The industry generates significant income for the country.","ko":"그 산업은 그 나라에 상당한 수입을 창출한다."}
  ]'::jsonb),
  ('constant', 2, 18, '형용사', '[
    {"en":"The factory maintains a constant level of production.","ko":"그 공장은 일정한 생산 수준을 유지한다."},
    {"en":"Farmers need a constant supply of water for their crops.","ko":"농부들은 작물을 위해 지속적인 물 공급이 필요하다."},
    {"en":"Prices remained constant throughout the year.","ko":"가격은 한 해 내내 일정하게 유지되었다."}
  ]'::jsonb),
  ('optimistic', 2, 18, '형용사', '[
    {"en":"Farmers are optimistic about this year''s harvest.","ko":"농부들은 올해 수확에 대해 낙관적이다."},
    {"en":"The company remains optimistic despite the crisis.","ko":"그 회사는 위기 속에서도 낙관적인 태도를 유지하고 있다."},
    {"en":"Experts are optimistic about future economic growth.","ko":"전문가들은 향후 경제 성장에 대해 낙관하고 있다."}
  ]'::jsonb),
  ('undertake', 2, 18, '동사', '[
    {"en":"The company undertook a major construction project.","ko":"그 회사는 대규모 건설 프로젝트를 맡았다."},
    {"en":"Farmers undertook new methods to improve their yield.","ko":"농부들은 수확량을 높이기 위해 새로운 방법을 시도했다."},
    {"en":"The government undertook reforms to support agriculture.","ko":"정부는 농업을 지원하기 위한 개혁에 착수했다."}
  ]'::jsonb),
  ('assemble', 2, 18, '동사', '[
    {"en":"Workers assembled the machines on the factory line.","ko":"노동자들은 공장 생산 라인에서 기계를 조립했다."},
    {"en":"The parts were assembled quickly by skilled workers.","ko":"그 부품들은 숙련된 노동자들에 의해 빠르게 조립되었다."},
    {"en":"They assembled the equipment needed for the harvest.","ko":"그들은 수확에 필요한 장비를 조립했다."}
  ]'::jsonb),
  ('innovative', 2, 18, '형용사', '[
    {"en":"The farm adopted innovative techniques to increase production.","ko":"그 농장은 생산량을 늘리기 위해 혁신적인 기술을 도입했다."},
    {"en":"The company is known for its innovative products.","ko":"그 회사는 혁신적인 제품으로 유명하다."},
    {"en":"Innovative methods helped reduce pollution in the factory.","ko":"혁신적인 방법이 공장의 오염을 줄이는 데 도움이 되었다."}
  ]'::jsonb),
  ('enterprise', 2, 18, '명사', '[
    {"en":"The family runs a small farming enterprise.","ko":"그 가족은 작은 농업 기업을 운영한다."},
    {"en":"The government supports new business enterprises.","ko":"정부는 새로운 사업체를 지원한다."},
    {"en":"The construction enterprise grew rapidly over the years.","ko":"그 건설 기업은 수년에 걸쳐 빠르게 성장했다."}
  ]'::jsonb),
  ('shut down', 2, 18, '동사구', '[
    {"en":"The factory had to shut down due to the crisis.","ko":"그 공장은 위기 때문에 문을 닫아야 했다."},
    {"en":"They shut down the old plant to build a new one.","ko":"그들은 새 공장을 짓기 위해 낡은 공장을 폐쇄했다."},
    {"en":"The company shut down several branches last year.","ko":"그 회사는 작년에 여러 지점을 폐쇄했다."}
  ]'::jsonb),
  ('set up', 2, 18, '동사구', '[
    {"en":"They set up a new factory in the countryside.","ko":"그들은 시골에 새 공장을 세웠다."},
    {"en":"The farmer set up a small business selling vegetables.","ko":"그 농부는 채소를 파는 작은 사업체를 차렸다."},
    {"en":"The company set up new offices overseas.","ko":"그 회사는 해외에 새로운 사무소를 설립했다."}
  ]'::jsonb)
) as t(word, level, study_day, pos, examples)
where v.word = t.word and v.level = t.level and v.study_day = t.study_day;
