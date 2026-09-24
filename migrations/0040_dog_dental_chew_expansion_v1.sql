PRAGMA foreign_keys = ON;

WITH new_reviews(product_id,dog_breed,dog_size,coat_type,needs,summary,source_type,source_url) AS (
VALUES
('greenies-teenie-mini','パピヨン・2歳','small',NULL,'sensitive-stomach daily','胃腸がやや弱い2歳のパピヨンに毎日与え、他製品よりお腹が落ち着いており、歯のケアにも役立っていると感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/217176_10108425/1.1/sort6/'),
('greenies-teenie-mini','犬・1.4kg','small',NULL,'tiny-size taste','1.4kgの小さな犬に選び、サイズが合いやすく、喜んで食べている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/217176_10108425/1.1/sort6/'),
('greenies-teenie-mini','多頭飼い・シニア犬を含む','small',NULL,'multi senior dental','多頭飼いで夕食後にもらうのを待つほど習慣化し、年齢を重ねても歯がきれいな状態を保てているように感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/217176_10108425/1.1/sort6/'),
('greenies-teenie-mini','犬種不明','small',NULL,'whitening repeat','続けて与えるうちに歯が白くなってきたように感じ、継続している体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/217176_10108425/1.1/sort6/'),
('greenies-teenie-mini','犬種不明','small',NULL,'reward after-brush','歯磨き後のご褒美として与え、非常に食いつきが良く、毎回楽しみにしている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/217176_10108425/1.1/sort6/'),
('greenies-teenie-mini','歯ブラシが苦手な犬','small',NULL,'vet-recommended molar-chew','歯ブラシを嫌がるため動物病院で勧められて試し、夢中で奥歯を使って噛んでくれた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/217176_10108425/1.1/sort6/'),
('greenies-teenie-mini','トイプードル・1歳','small','curly','young taste','1歳のトイプードルが大好物として喜んで食べ、日常のデンタル習慣に取り入れている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/217176_10108425/1.1/sort6/'),
('greenies-teenie-mini','犬・約4kg','small',NULL,'portion weight-control','4kgほどの犬で、おやつの食べ過ぎを避けたい中でも小さなサイズが量の調整にちょうどよいと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/217176_10108425/1.1/sort6/'),
('greenies-calorie-mini','犬種不明','small',NULL,'happy-carry taste','与えると非常に機嫌よく咥えていき、カロリーケアでも嗜好性は高いと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/review/item/1/217176_10108428/1.1/'),
('greenies-calorie-mini','犬種不明','small',NULL,'repeat favorite','愛犬が特に気に入っており、繰り返し購入している体験。','public_buyer_review_summary','https://review.rakuten.co.jp/review/item/1/217176_10108428/1.1/'),
('greenies-calorie-mini','犬種不明','small',NULL,'brush sheet support','歯ブラシや歯磨きシートも併用しながら、1日1本を補助的なデンタルケアとして続けている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/review/item/1/217176_10108428/1.1/'),
('greenies-calorie-mini','犬種不明','small',NULL,'vet-praise dental','喜んで食べ続け、動物病院で歯がきれいだと言われたことで手応えを感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/review/item/1/217176_10108428/1.1/'),
('greenies-calorie-mini','犬種不明','small',NULL,'request-button routine','食事が終わるとおやつボタンを押して要求するほど習慣化し、楽しみにしている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/review/item/1/217176_10108428/1.1/'),
('greenies-calorie-mini','犬種不明','small',NULL,'chewing enjoyment','愛犬が喜んでしっかりかじりつくため、日常の歯磨きガムとして重宝している体験。','public_buyer_review_summary','https://review.rakuten.co.jp/review/item/1/217176_10108428/1.1/'),
('greenies-calorie-mini','犬種不明','small',NULL,'cut after-brush','1本そのままだと食べないため小さく切り、歯ブラシ後のお楽しみとして与えると飽きずに食べている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/review/item/1/217176_10108428/1.1/'),
('greenies-calorie-mini','ポメラニアン','small',NULL,'odor nightly routine','毎晩1本を楽しみに催促し、口臭も気になりにくいと感じて継続している体験。','public_buyer_review_summary','https://review.rakuten.co.jp/review/item/1/217176_10108428/1.1/'),
('greenies-freshmint-teenie','犬種不明','small',NULL,'mint odor hardness','口臭対策で初めて与え、食後に少しミントの香りが残り、硬さも食べやすそうだった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/review/item/1/309015_10001788/1.1/'),
('greenies-freshmint-teenie','犬種不明','small',NULL,'fresh-breath','口臭ケア用を続け、口が以前より爽やかに感じられた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/review/item/1/309015_10001788/1.1/'),
('greenies-freshmint-teenie','犬種不明','small',NULL,'no-brush odor','歯ブラシでの歯磨きをしていない犬でも、口臭が気になりにくいと感じて継続している体験。','public_buyer_review_summary','https://review.rakuten.co.jp/review/item/1/309015_10001788/1.1/'),
('greenies-freshmint-teenie','犬種不明','small',NULL,'summer-odor','夏場に気になっていた口臭が、与え始めてから軽くなったように感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/review/item/1/309015_10001788/1.1/'),
('greenies-freshmint-teenie','犬種不明','small',NULL,'post-brush reward','歯磨き後にもらえると分かっているため、以前より歯磨きを嫌がらず受け入れやすくなった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/review/item/1/309015_10001788/1.1/'),
('greenies-freshmint-teenie','犬種不明','small',NULL,'gel molar support','歯みがきジェルをのせて与えると奥歯で噛んでくれ、ケアの補助としては使いやすい一方、これだけでは歯の黄ばみは残ると感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/review/item/1/309015_10001788/1.1/'),
('greenies-freshmint-teenie','犬・6歳','small',NULL,'scared odor','歯磨きが苦手な6歳の犬で食後の楽しみに使い、口臭が気にならないと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/review/item/1/309015_10001788/1.1/'),
('greenies-freshmint-teenie','犬種不明','small',NULL,'short-piece quality','正規品として安心して与えられた一方、袋の中に短いガムが数本混じっており、品質のばらつきが少し気になった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/review/item/1/309015_10001788/1.1/'),
('petkiss-standard-small','犬種不明','small',NULL,'twist-shape acceptance','長く与えている犬で、ねじり形状へ変わった後も特に問題なく食べ続けている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/261122_10961295/1.1/'),
('petkiss-standard-small','犬種不明','small',NULL,'long-term preference','旧形状の頃から続けており、形が変わっても比較的好んで食べてくれるため継続している体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/261122_10961295/1.1/'),
('petkiss-standard-small','好き嫌いが激しい犬','small',NULL,'picky reward','好き嫌いが激しい犬でも喜んで食べるため、歯磨きだけに頼らず歯ブラシ後のご褒美として使っている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/review/item/1/243088_10812889/1.1/'),
('petkiss-standard-small','犬種不明','small',NULL,'compare cleaning','他の歯磨きガムと比べて、食後に続けると歯がきれいになりやすいように感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/review/item/1/243088_10812889/1.1/'),
('petkiss-standard-small','犬・14歳','small',NULL,'senior long-term dental','9歳頃まで歯磨き習慣がなかった犬で、ガムとブラシを続けるようになり、14歳でも歯が丈夫だと感じた体験。','public_buyer_review_summary','https://store.shopping.yahoo.co.jp/dogworld/lionsn5792.html'),
('petkiss-standard-small','チワワ・2.5kg','small',NULL,'size soft fast','2.5kgのチワワに1本を半分にして与え、柔らかく食べやすい一方、かなり早く食べ終える体験。','public_buyer_review_summary','https://store.shopping.yahoo.co.jp/yamada-denki/7721010011.html'),
('petkiss-standard-small','小型犬4頭','small',NULL,'multi nightly half','小型犬4頭が寝る前に楽しみにしており、柔らかいため手で半分にして分けて与えている体験。','public_buyer_review_summary','https://store.shopping.yahoo.co.jp/lamd/490335100579.html'),
('petkiss-standard-small','犬種不明','small',NULL,'food-mix odor','ドライフードを嫌がる時に小さくちぎって混ぜると食べ進みやすく、食後のご褒美として続けて口臭も軽くなったように感じた体験。','public_buyer_review_summary','https://store.shopping.yahoo.co.jp/lamd/490335100579.html'),
('petkiss-puppy','チワワ・6か月','small',NULL,'puppy multi-household','6か月のチワワが喜んで食べ、先住の成犬が別の成犬用ガムを食べる時間に一緒に楽しんでいる体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/261122_11117049/1.1/'),
('petkiss-puppy','子犬・5か月','small',NULL,'puppy daily habit','5か月の子犬へ1日1本を習慣にし、毎日喜んで食べている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/261122_11117049/1.1/'),
('petkiss-puppy','ビーグル・2か月','medium',NULL,'puppy size','生後2か月のビーグルに与え、小さめで子犬用のおやつとして扱いやすかった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/261122_11117049/1.1/'),
('petkiss-puppy','子犬の多頭飼い','small',NULL,'multi puppy consumption','多頭の子犬へ与えると1回で1袋近く使うほどよく食べ、消費が早いと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/261122_11117049/1.1/'),
('petkiss-puppy','子犬','small',NULL,'puppy happy-chew','赤ちゃん犬が毎日楽しそうに噛み、味も気に入っている様子だった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/261122_11117049/1.1/'),
('petkiss-puppy','子犬2頭','small',NULL,'multi puppy repeat','パピー2頭へ継続して与え、日常用として繰り返し購入している体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/261122_11117049/1.1/'),
('petkiss-puppy','歯みがき初体験の子犬','small',NULL,'puppy beginner self-approach','歯みがきを始めたばかりの子犬が自分から近づいて噛みに来るため、ケア習慣の入口として使いやすかった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/261122_11117049/1.1/'),
('petkiss-puppy','子犬・5か月','small',NULL,'puppy availability','近所では見つけにくかったが、5か月の子犬が喜んで噛み、続けやすいと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/261122_11117049/1.1/'),
('veggident-fresh-xs','犬種不明',NULL,NULL,'compare preference effectiveness','他のガムより嗜好性は控えめと聞いて選んだが、ガム好きの愛犬は問題なく食べ、デンタル効果を重視して継続している体験。','public_buyer_review_summary','https://review.rakuten.co.jp/review/item/1/256849_10009700/1.1/'),
('veggident-fresh-xs','胃腸が弱くストルバイト歴のある犬',NULL,NULL,'sensitive-stomach training mixed','獣医から市販の安価なガムを控えるよう言われて選び、食いつきは非常に良くトレーニングにも使える一方、歯石への効果は歯磨きほど明確ではないと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/review/item/1/256849_10009700/1.1/'),
('veggident-fresh-xs','シニア犬','small',NULL,'senior size softness','若い頃は大きいサイズを分割していたが、シニアになってからXSを半分にし、手で簡単に折れる柔らかさが扱いやすいと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/review/item/1/256849_10009700/1.1/'),
('veggident-fresh-xs','犬種不明',NULL,NULL,'plaque no-brush','歯ブラシを使わずガム中心でも歯垢が減ったように感じ、繰り返し購入している体験。','public_buyer_review_summary','https://review.rakuten.co.jp/review/item/1/256849_10009700/1.1/'),
('veggident-fresh-xs','コーギー','medium',NULL,'breed size chew','コーギーがよく噛んで食べ、このXSサイズでも十分で、歯がきれいになったように感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/review/item/1/256849_10009700/1.1/'),
('veggident-fresh-xs','犬・12歳','small',NULL,'senior snack dental','12歳の犬に毎日与え、おやつ感覚で喜んで食べながらデンタルケアを続けている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/review/item/1/256849_10009700/1.1/'),
('veggident-fresh-xs','チワワ・2.7kg','small',NULL,'tiny-size weight caution','2.7kgのチワワには1本が少し大きく感じ、避妊後の体重増加も気になるため食事量とのバランスを考えながら与えている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/review/item/1/256849_10009700/1.1/'),
('veggident-fresh-xs','トイプードル・4kg','small','curly','breed grip size','他のガムでは小さく柔らかすぎた4kgのトイプードルに使い、両手で持ちやすいサイズと厚みを気に入り、食後も追加をねだるほどだった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/review/item/1/256849_10009700/1.1/'),
('veggident-fresh-xs','犬種不明',NULL,NULL,'hand-feed swallow-prevention','丸飲みしないよう飼い主が手で持ちながら少しずつ与え、効果は分からなくてもおいしそうに噛んでいる体験。','public_buyer_review_summary','https://review.rakuten.co.jp/review/item/1/256849_10009700/1.1/'),
('veggident-fresh-xs','犬種不明',NULL,NULL,'first-try repeat','初めて与えても食いつきが非常に良く、食後すぐに食べ切ったため次はまとめて購入しようと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/review/item/1/256849_10009700/1.1/')
)
INSERT INTO reviews(product_id,dog_breed,dog_size,coat_type,needs,summary,source_type,source_url)
SELECT n.product_id,n.dog_breed,n.dog_size,n.coat_type,n.needs,n.summary,n.source_type,n.source_url
FROM new_reviews n
WHERE NOT EXISTS (
  SELECT 1 FROM reviews r
  WHERE r.product_id=n.product_id
    AND r.summary=n.summary
);

SELECT COUNT(*) AS dental_chew_product_count
FROM products
WHERE category='dog-dental-chew' AND active=1;

SELECT COUNT(*) AS dental_chew_review_count
FROM reviews r
JOIN products p ON p.id=r.product_id
WHERE p.category='dog-dental-chew' AND p.active=1;
