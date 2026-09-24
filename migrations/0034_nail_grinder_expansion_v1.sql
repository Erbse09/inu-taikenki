PRAGMA foreign_keys = ON;

WITH new_reviews(product_id,dog_breed,dog_size,coat_type,needs,summary,source_type,source_url) AS (
VALUES
('casfuy-6speed','犬種不明・他社グラインダーから変更',NULL,NULL,'quiet power light speed','他社品より短時間で削れ、低めの速度でも十分な研削力があり、静かさとライトの見やすさも評価した体験。','public_buyer_review_summary','https://www.chewy.com/casfuy-6-speed-dog-nail-grinder/product-reviews/751494'),
('casfuy-6speed','犬種不明・4回使用後に充電不良',NULL,NULL,'battery negative','数回の爪ケアには使えたものの、その後は充電してもすぐ電池切れになるようになり、耐久性に不満を感じた体験。','public_buyer_review_summary','https://www.chewy.com/casfuy-6-speed-dog-nail-grinder/product-reviews/751494'),
('casfuy-6speed','ゴルダドール系ミックス',NULL,NULL,'scared long-nail speed smooth','クリッパーが難しい犬に使い、伸びた爪を比較的速く滑らかに整えられ、従来よりストレスが少なかった体験。','public_buyer_review_summary','https://www.chewy.com/casfuy-6-speed-dog-nail-grinder/product-reviews/751494'),
('casfuy-6speed','爪ケアを強く嫌がる犬',NULL,NULL,'scared treats cordless light','初回は抵抗したが、おやつで慣らすと全爪を削れ、速度調整・ライト・コードレスの使いやすさを感じた体験。','public_buyer_review_summary','https://www.chewy.com/casfuy-6-speed-dog-nail-grinder/product-reviews/751494'),
('casfuy-6speed','高齢の大型犬','large',NULL,'senior hard-nail acclimation','太く硬い爪の高齢犬で、少しずつ慣らしながら爪の根元を支えて使うと、以前より落ち着いて削れた体験。','public_buyer_review_summary','https://www.chewy.com/casfuy-6-speed-dog-nail-grinder/product-reviews/751494'),
('casfuy-6speed','爪切りでパニックになる犬',NULL,NULL,'scared low-vibration','従来は補助が必要なほど暴れていた犬で、初回から一人で最後まで削れ、2回目には抵抗もさらに減った体験。','public_buyer_review_summary','https://www.chewy.com/casfuy-6-speed-dog-nail-grinder/product-reviews/751494'),
('casfuy-6speed','犬種不明・旧モデルから買い替え',NULL,NULL,'charging cable','充電できないように見えたが付属ケーブルへ替えると正常に充電でき、ケーブル相性に注意が必要と分かった体験。','public_buyer_review_summary','https://www.chewy.com/casfuy-6-speed-dog-nail-grinder/product-reviews/751494'),
('casfuy-6speed','犬複数頭・Dremelから変更',NULL,NULL,'multi quiet lightweight','ペット用Dremelより音と振動が少なく軽いため、複数頭の爪をこまめに手入れしやすくなった体験。','public_buyer_review_summary','https://www.chewy.com/casfuy-6-speed-dog-nail-grinder/product-reviews/751494'),
('casfuy-6speed','爪切りが苦手な犬',NULL,NULL,'quiet speed charging','速度を粗削りと仕上げで使い分けられ、音も比較的静かだった一方、指定電圧の充電器が必要だった体験。','public_buyer_review_summary','https://www.chewy.com/casfuy-6-speed-dog-nail-grinder/product-reviews/751494'),
('casfuy-6speed','ゴールデンレトリバー','large','long','size negative','ガイドの開口部が爪に対して小さく、ゴールデンの爪では十分に当てにくかったという否定的体験。','public_buyer_review_summary','https://www.chewy.com/casfuy-6-speed-dog-nail-grinder/product-reviews/751494'),
('casfuy-6speed','黒い爪の犬',NULL,NULL,'black-nail light quiet','クリッパーで苦労していた黒い爪に使い、静かな作動音と2灯のライトで血管位置を確認しやすいと感じた体験。','public_buyer_review_summary','https://www.chewy.com/casfuy-6-speed-dog-nail-grinder/product-reviews/751494'),
('casfuy-6speed','黒ラブ系ミックス＋ミニオーストラリアンシェパード',NULL,NULL,'multi black-nail quiet durability','硬い黒爪の犬には高回転、子犬には低回転で使い分け、3年間ヘッド交換なしで静かに使えている体験。','public_buyer_review_summary','https://www.desertcart.jp/products/602566408-casfuy-6-speed-dog-nail-grinder-newest-enhanced-pet-nail-grinder-super-quiet-rechargeable-electric-dog-nail-trimmer-painless-paws-grooming-smoothing-tool-for-large-medium-small-dogs-bright-blue'),
('casfuy-6speed','大型犬3頭・ピットブル2頭＋ローデシアンリッジバック','large',NULL,'multi hard-nail speed battery','太い爪の大型犬3頭を合計約10分で整えられ、以前の2速機よりパワーと電池持ちが良いと感じた体験。','public_buyer_review_summary','https://www.desertcart.jp/products/602566408-casfuy-6-speed-dog-nail-grinder-newest-enhanced-pet-nail-grinder-super-quiet-rechargeable-electric-dog-nail-trimmer-painless-paws-grooming-smoothing-tool-for-large-medium-small-dogs-bright-blue'),
('casfuy-6speed','爪ケアを怖がる犬を含む3頭',NULL,NULL,'multi scared relaxed','爪ケアを怖がる犬が膝の上で眠るほど落ち着いて削らせ、長く伸びた爪も整えられた体験。','public_buyer_review_summary','https://www.desertcart.jp/products/602566408-casfuy-6-speed-dog-nail-grinder-newest-enhanced-pet-nail-grinder-super-quiet-rechargeable-electric-dog-nail-trimmer-painless-paws-grooming-smoothing-tool-for-large-medium-small-dogs-bright-blue'),
('casfuy-6speed','犬・約30lb','medium',NULL,'quiet light speed','約30lbの犬に低速でも十分な研削力があり、静かでライトも白っぽい爪の確認に役立った体験。','public_buyer_review_summary','https://www.desertcart.jp/products/602566408-casfuy-6-speed-dog-nail-grinder-newest-enhanced-pet-nail-grinder-super-quiet-rechargeable-electric-dog-nail-trimmer-painless-paws-grooming-smoothing-tool-for-large-medium-small-dogs-bright-blue'),
('casfuy-led2','足先を触られるのが苦手な犬',NULL,NULL,'scared acclimation quiet','通常の爪切りを嫌がる犬でも、離れた場所で音から慣らすと逃げずに受け入れやすくなった体験。','public_buyer_review_summary','https://www.chewy.com/casfuy-2-led-light-grooming-dog-cat/dp/395329'),
('casfuy-led2','怖がりな小型犬複数頭','small',NULL,'multi scared light speed','怖がりな小型犬たちに低速で使い、2灯のライトで位置を確認しながら以前より短時間でケアできた体験。','public_buyer_review_summary','https://www.chewy.com/casfuy-2-led-light-grooming-dog-cat/dp/395329'),
('casfuy-led2','爪切りで嫌な経験がある犬',NULL,NULL,'scared treats gradual','おやつと段階的な慣らしを組み合わせ、初日から前足の爪を少しずつ削れた体験。','public_buyer_review_summary','https://www.chewy.com/casfuy-2-led-light-grooming-dog-cat/dp/395329'),
('casfuy-led2','チワワ・6か月','small',NULL,'puppy gentle','6か月のチワワの小さな爪に使い、刺激が強すぎず穏やかに削れたと感じた体験。','public_buyer_review_summary','https://www.chewy.com/casfuy-2-led-light-grooming-dog-cat/dp/395329'),
('casfuy-led2','強い不安のある犬',NULL,NULL,'scared quiet food-motivated','食べ物で気をそらしながら前後の足を分けてケアすると、比較的静かな作動音で最後まで整えやすかった体験。','public_buyer_review_summary','https://www.chewy.com/casfuy-2-led-light-grooming-dog-cat/dp/395329'),
('casfuy-led2','爪ケア嫌いの犬・旧Dremelから変更',NULL,NULL,'quiet low-vibration speed','古いDremelより音と振動が少なく短時間で削れ、切りすぎへの不安も減ったと感じた体験。','public_buyer_review_summary','https://www.chewy.com/casfuy-2-led-light-grooming-dog-cat/dp/395329'),
('casfuy-led2','グレートデーン4頭','large',NULL,'multi power battery negative','大型犬4頭では1頭ごとに充電が必要になり、強く押すと回転が止まるためパワー不足を感じた体験。','public_buyer_review_summary','https://www.chewy.com/casfuy-2-led-light-grooming-dog-cat/dp/395329'),
('casfuy-led2','血管が長めの爪の犬',NULL,NULL,'light quiet control','ライトで手元を見ながら少しずつ削れ、振動を強く嫌がらず、音も想像より静かだった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=7020230726093357&store_id=mrnsstore'),
('casfuy-led2','犬種不明・振動に敏感',NULL,NULL,'quiet vibration negative','作動音は静かでも、実際に爪へ当てた時の振動で驚き、慣れるまで時間が必要だった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=7020230726093357&store_id=mrnsstore'),
('casfuy-led2','犬種不明・旧グラインダーから買い替え',NULL,NULL,'quiet handling weight','以前の製品より静かで2段階速度とライトも便利だった一方、本体は少し重く感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=7020230726093357&store_id=mrnsstore')
)
INSERT INTO reviews(product_id,dog_breed,dog_size,coat_type,needs,summary,source_type,source_url)
SELECT n.product_id,n.dog_breed,n.dog_size,n.coat_type,n.needs,n.summary,n.source_type,n.source_url
FROM new_reviews n
WHERE NOT EXISTS (
  SELECT 1 FROM reviews r
  WHERE r.product_id=n.product_id
    AND r.summary=n.summary
);


WITH new_reviews(product_id,dog_breed,dog_size,coat_type,needs,summary,source_type,source_url) AS (
VALUES
('dremel-7350-pet','足先を触られるのが苦手な犬',NULL,NULL,'finish scared','獣医が爪切り後の仕上げに使うのを参考にし、足先を嫌がる犬でも角を滑らかにする用途なら受け入れやすかった体験。','public_buyer_review_summary','https://www.lowes.com/reviews/dremel-7350-pet-rotary-tools/5001939579?offset=60'),
('dremel-7350-pet','ジャーマンシェパード＋ダックスフンド',NULL,NULL,'multi size','大型のシェパードと小型のダックスフンドの両方に同じ本体を使いやすかった体験。','public_buyer_review_summary','https://www.lowes.com/reviews/dremel-7350-pet-rotary-tools/5001939579?offset=60'),
('dremel-7350-pet','大型の保護ピットブル2頭','large','short','multi handling','大型の保護犬2頭の日常グルーミングに使い、家庭での爪ケアが以前より簡単になった体験。','public_buyer_review_summary','https://www.lowes.com/reviews/dremel-7350-pet-rotary-tools/5001939579?offset=60'),
('dremel-7350-pet','チワワ','small',NULL,'quiet relaxed','初回使用でもチワワが低い作動音をあまり気にせず、飼い主も扱いやすいと感じた体験。','public_buyer_review_summary','https://www.lowes.com/reviews/dremel-7350-pet-rotary-tools/5001939579?offset=60'),
('dremel-7350-pet','ゴールデンレトリバー系の大型犬','large',NULL,'home-care value','サロンへ行く間の自宅ケアに使い、扱いやすく爪のお手入れ費用を抑えられたと感じた体験。','public_buyer_review_summary','https://www.lowes.com/reviews/dremel-7350-pet-rotary-tools/5001939579?offset=60'),
('dremel-7350-pet','グレートデーン','large',NULL,'scared speed','爪切りを嫌がるグレートデーンでも短時間で削れ、操作も簡単だった体験。','public_buyer_review_summary','https://www.lowes.com/reviews/dremel-7350-pet-rotary-tools/5001939579?offset=60'),
('dremel-7350-pet','犬種不明・旧Dremelも所有',NULL,NULL,'safe handling','少しずつ削れるため切りすぎへの不安が少なく、操作も簡単で旧Dremelと併用している体験。','public_buyer_review_summary','https://www.lowes.com/reviews/dremel-7350-pet-rotary-tools/5001939579?offset=60'),
('dremel-7350-pet','犬種不明・静音と電池持ち重視',NULL,NULL,'quiet battery','犬の爪を整える用途で、一般用Dremelより静かに感じ、電池持ちも良いと評価した体験。','public_buyer_review_summary','https://www.lowes.com/reviews/dremel-7350-pet-rotary-tools/5001939579?offset=60'),
('dremel-7350-pet','犬種不明・家庭用',NULL,NULL,'quiet cordless battery','静かでバランスがよく、コードレスで扱いやすく、家庭の爪ケアには十分な電池持ちだと感じた体験。','public_buyer_review_summary','https://www.lowes.com/reviews/dremel-7350-pet-rotary-tools-oscillating-tools/5001939579?offset=180'),
('dremel-7350-pet','ジャーマンシェパード・4歳','large',NULL,'quiet speed','子犬の頃からDremel系を使っている4歳のシェパードで、静かに短時間で爪を整えられた体験。','public_buyer_review_summary','https://www.lowes.com/reviews/dremel-7350-pet-rotary-tools-oscillating-tools/5001939579?offset=180'),
('dremel-7350-pet','犬2頭',NULL,NULL,'multi quiet battery','2頭とも作動音を強く気にせず、1回の充電で両方の爪を整えられた体験。','public_buyer_review_summary','https://www.lowes.com/reviews/dremel-7350-pet-rotary-tools-oscillating-tools/5001939579?offset=180'),
('dremel-7350-pet','過去に深爪した犬',NULL,NULL,'scared acclimation quiet','過去の深爪経験後、音と振動へ段階的に慣らすと驚かせにくく、安全に削りやすかった体験。','public_buyer_review_summary','https://www.lowes.com/reviews/dremel-7350-pet-rotary-tools-oscillating-tools/5001939579?offset=180'),
('dremel-7350-pet','犬複数頭',NULL,NULL,'multi quiet battery single-speed','複数頭に使い、静かで電池も長持ちする一方、1速だけなので仕上げまで少し時間がかかった体験。','public_buyer_review_summary','https://www.lowes.com/reviews/dremel-7350-pet-rotary-tools-oscillating-tools/5001939579?offset=180'),
('dremel-7350-pet','若い犬',NULL,NULL,'puppy handling','若い犬をじっとさせる難しさはあったが、本体サイズが持ちやすく爪を短く整えやすかった体験。','public_buyer_review_summary','https://www.lowes.com/reviews/dremel-7350-pet-rotary-tools-oscillating-tools/5001939579?offset=180'),
('dremel-7350-pet','犬種不明・一人でケア',NULL,NULL,'beginner single-speed','補助なしで一人でも爪を整えられ、扱いやすかった一方、速度調整があればさらに便利と感じた体験。','public_buyer_review_summary','https://www.lowes.com/reviews/dremel-7350-pet-rotary-tools-oscillating-tools/5001939579?offset=180'),
('dremel-7350-pet','犬種不明・サロン代節約',NULL,NULL,'value home-care','自宅で使いやすく、サロンへ爪切りに行く費用と手間を減らせたと感じた体験。','public_buyer_review_summary','https://www.lowes.com/reviews/dremel-7350-pet-rotary-tools-oscillating-tools/5001939579?offset=180'),
('dremel-7350-pet','犬種不明・ペット用電動やすり初心者',NULL,NULL,'quiet easy safety','従来の爪切りより安全に感じ、静かで扱いやすいため犬も受け入れやすかった体験。','public_buyer_review_summary','https://www.lowes.com/reviews/dremel-7350-pet-rotary-tools/5001939579?offset=40'),
('dremel-7350-pet','犬種不明・ギフトで使用開始',NULL,NULL,'beginner control','贈り物でもらって使い始め、操作が簡単で深く切りすぎる不安を減らせた体験。','public_buyer_review_summary','https://www.lowes.com/reviews/dremel-7350-pet-rotary-tools/5001939579?offset=40'),
('dremel-7350-pet','犬種不明・爪切りから変更',NULL,NULL,'easy quiet','従来の爪切りより犬が嫌がりにくく、家庭で爪を整えやすくなったと感じた体験。','public_buyer_review_summary','https://www.ebay.com/p/3052014346'),
('dremel-7350-pet','犬種不明・長年爪切りを使用',NULL,NULL,'easy repeat','犬の爪ケアが大幅に簡単になり、もっと早く電動グラインダーを選べばよかったと感じた体験。','public_buyer_review_summary','https://www.ebay.com/p/3052014346'),
('dremel-7350-pet','犬種不明・パワー重視',NULL,NULL,'power','犬の爪をしっかり削れるだけの出力があり、用途には十分と感じた体験。','public_buyer_review_summary','https://www.ebay.com/p/3052014346'),
('dremel-7350-pet','犬種不明・製品は使えるが犬が苦手',NULL,NULL,'scared negative','製品自体は問題なく使えたものの、犬が作動を嫌がったため家庭では継続しにくかった体験。','public_buyer_review_summary','https://www.canadiantire.ca/en/pdp/dremel-7350-pet-rechargeable-rotary-tool-for-pet-grooming-0541100p.html'),
('dremel-7350-pet','犬3頭',NULL,NULL,'multi compatibility caution','爪切りを嫌う3頭が7350なら比較的受け入れた一方、一部の別売りビットはそのまま装着できなかった体験。','public_buyer_review_summary','https://www.reddit.com/r/doggrooming/comments/wm2ltt'),
('dremel-7350-pet','犬種不明・家庭用',NULL,NULL,'single-speed durability caution','家庭用では使えた一方、1速しかない点と落下への弱さが気になったという体験。','public_buyer_review_summary','https://www.reddit.com/r/grooming/comments/1mltcgh/dog_nail_clipper_recommendations/'),
('dremel-7350-pet','大型犬・太い爪','large',NULL,'power negative','大型犬の太い爪では出力不足に感じ、全爪を終えるまで時間がかかるというグルーマーの体験。','public_buyer_review_summary','https://www.reddit.com/r/doggrooming/comments/1d82837')
)
INSERT INTO reviews(product_id,dog_breed,dog_size,coat_type,needs,summary,source_type,source_url)
SELECT n.product_id,n.dog_breed,n.dog_size,n.coat_type,n.needs,n.summary,n.source_type,n.source_url
FROM new_reviews n
WHERE NOT EXISTS (
  SELECT 1 FROM reviews r
  WHERE r.product_id=n.product_id
    AND r.summary=n.summary
);

SELECT COUNT(*) AS nail_grinder_product_count
FROM products
WHERE category='nail-grinder' AND active=1;

SELECT COUNT(*) AS nail_grinder_review_count
FROM reviews r
JOIN products p ON p.id=r.product_id
WHERE p.category='nail-grinder' AND p.active=1;
