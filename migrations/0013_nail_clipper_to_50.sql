PRAGMA foreign_keys = ON;

WITH new_reviews(product_id,dog_breed,dog_size,coat_type,needs,summary,source_type,source_url) AS (
VALUES
('petio-selftrimmer-clipper','犬種不明・音が苦手',NULL,NULL,'scared noise','以前の爪切りのパチンという音を嫌がる犬に使い、静かに切れて切れ味も良いと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/217176_10174322/1.1/'),
('petio-selftrimmer-clipper','子犬',NULL,NULL,'puppy beginner speed','初めての爪切りで、小さく細い爪でも軽い力で切れ、じっとしているのが苦手な子犬でも短時間で終えやすかった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/217176_10174322/1.1/'),
('petio-selftrimmer-clipper','犬種不明・リピーター',NULL,NULL,'repeat handling','以前のタイプから買い替え、よく切れて扱いやすいため追加購入した体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/217176_10174322/1.1/'),
('petio-selftrimmer-clipper','チワワの子犬','small',NULL,'puppy beginner','小型犬にはハサミ型が使いやすそうと選び、チワワの子犬に持ちやすくスムーズに使えた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/217176_10174322/1.1/'),
('petio-selftrimmer-clipper','犬種不明・ギロチンから変更',NULL,NULL,'quiet low-vibration','ギロチン型から替え、少ない力で切れ、振動が伝わりにくいため犬が嫌がりにくいと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/217176_10174322/1.1/'),
('petio-selftrimmer-clipper','犬種不明・数回使用',NULL,NULL,'repeat','5回ほど実際に爪を切り、切れ味の良さから愛用している体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/217176_10174322/1.1/'),
('petio-selftrimmer-clipper','犬種不明・短時間重視',NULL,NULL,'speed','爪がすばやく切れ、作業に手間がかからず重宝している体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/217176_10174322/1.1/'),
('petio-selftrimmer-clipper','犬種不明・100円品から変更',NULL,NULL,'quiet relaxed','100円ショップの爪切りから替え、切れ味がよく、犬がおとなしく切らせるようになった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/217176_10174322/1.1/'),
('petio-selftrimmer-clipper','小型犬','small',NULL,'beginner','ギロチン型よりハサミ型が合いそうと選び、自宅爪切りへ切り替えた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/217176_10174322/1.1/'),
('petio-selftrimmer-clipper','犬種不明・ガムで気をそらす',NULL,NULL,'food-motivated quiet','ガムを食べさせている間に、音を立てず切る部分を確認しながら短時間で爪切りできた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/217176_10174322/1.1/'),
('petio-selftrimmer-clipper','犬種不明・狼爪ケア',NULL,NULL,'wolf-claw','猫用の同系統では小さかったため犬用へ替え、狼爪を切るのに使いやすかった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/217176_10174322/1.1/'),
('petio-selftrimmer-clipper','犬種不明・家庭爪切り初心者',NULL,NULL,'beginner','ギロチン型を使いこなせなかった家庭で、このハサミ型に替えて自宅で爪切りできるようになった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/217176_10174322/1.1/'),
('petio-selftrimmer-clipper','5kgの小型犬','small',NULL,'clean-cut','5kgの小型犬に使用し、切れ味がよく爪の切り口もきれいに仕上がった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/217176_10174322/1.1/'),
('petio-selftrimmer-clipper','犬種不明・寝ている間にケア',NULL,NULL,'quiet scared','切断音が少なく、犬が寝ている間に気づかれにくく爪を切れた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/217176_10174322/1.1/'),
('petio-selftrimmer-clipper','犬種不明・電動やすり経験あり',NULL,NULL,'quiet beginner','電動やすりやバネ式より扱いやすく、音も少ないため犬への負担が小さいと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/217176_10174322/1.1/'),
('petio-selftrimmer-clipper','犬種不明・音に敏感',NULL,NULL,'scared noise','旧爪切りのパチン音で嫌がっていた犬に使い、音は気にならなくなったが慣らしは必要と感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/217176_10174322/1.1/'),
('petio-selftrimmer-clipper','犬種不明・他社品から変更',NULL,NULL,'low-force','以前の有名メーカー品より軽い力で切れ、犬への負荷も少ないと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/217176_10174322/1.1/'),
('petio-selftrimmer-clipper','犬種不明・パチン音が苦手',NULL,NULL,'low-impact','切断時の衝撃が少なく、犬への負担が小さいと感じ、持ち手も使いやすかった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/217176_10174322/1.1/'),
('petio-selftrimmer-clipper','犬種不明・前足は苦手',NULL,NULL,'mixed scared','切れ味自体は良く後ろ足は切れたが、前足は犬が大人しくできずトリマーへ任せることにした混合評価。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/217176_10174322/1.1/'),
('petio-selftrimmer-clipper','ゴールデンレトリバー','large','long','quiet large','従来品の音と振動を嫌がっていたゴールデンが、音の少ない切れ味の良いこの爪切りでは嫌がらず切らせた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/217176_10174322/1.1/'),
('petio-selftrimmer-clipper','柴犬','medium','double','clean-cut','柴犬の爪に使い、爪が割れずにきれいに切れた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/217176_10174322/1.1/'),
('petio-selftrimmer-clipper','犬種不明・黒い爪あり',NULL,NULL,'black-nail control','白い爪と茶色い爪が混在する犬で、少しずつ切れるハサミ型の方が血管位置を確認しやすいと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/217176_10174322/1.1/'),
('petio-selftrimmer-clipper','犬種不明・1〜3mm調整',NULL,NULL,'control','1mm程度から数mmまで少しずつ調整しながら切れ、犬も嫌がりにくかった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/217176_10174322/1.1/'),
('petio-selftrimmer-clipper','犬種不明・初めて迎えた犬',NULL,NULL,'beginner','初めて迎えた犬の自宅爪切り用に選び、持ちやすさと切れ味に満足した体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/217176_10174322/1.1/'),
('zan-nipper','犬種不明・硬い爪',NULL,NULL,'hard-nail','複数のニッパーを試した飼い主が、硬い爪でも最もスパッと切れたと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/216162_10004918/1.1/?l-id=item_SP_SeeItemReview'),
('zan-nipper','大型犬','large',NULL,'hard-nail quiet','小ぶりな本体でも大型犬の爪をよく切れ、切断時の大きな振動が少ないと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/216162_10004918/1.1/?l-id=item_SP_SeeItemReview'),
('zan-nipper','犬種不明・初心者',NULL,NULL,'beginner','自宅で初めて爪切りに挑戦し、緊張しながらでも使いやすかった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/216162_10004918/1.1/?l-id=item_SP_SeeItemReview'),
('zan-nipper','犬種不明・音に敏感',NULL,NULL,'quiet scared','パチンという音が少なく、愛犬が嫌がらず爪のお手入れを受けた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/216162_10004918/1.1/?l-id=item_SP_SeeItemReview'),
('zan-nipper','犬種不明・ギロチン併用',NULL,NULL,'versatile','ZANのギロチン型と使い分ける目的で導入し、切れ味がよく裏側のやすりも実用的と感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/216162_10004918/1.1/?l-id=item_SP_SeeItemReview'),
('zan-nipper','巻き爪の犬',NULL,NULL,'ingrown-nail','仕事で巻き爪の犬を切る場面に使い、切れ味がよく振動も少ないため扱いやすかった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/216162_10004918/1.1/?l-id=item_SP_SeeItemReview'),
('zan-nipper','大型寄り中型雑種・16歳・17kg','medium',NULL,'senior ingrown-nail','16歳17kgの雑種犬で、弱った後ろ足の巻き爪をギロチン型では切れず、ニッパー型で肉球を傷つけず切れた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/p/92215438b9'),
('zan-nipper','中型雑種・介護中','medium',NULL,'wolf-claw senior','大型犬寄りの中型雑種の介護中、触られるのを嫌う狼爪を寝ている隙に一度のチャレンジで切れた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/216162_10004918/1.1/?l-id=item_SP_SeeItemReview'),
('zan-guillotine-sm','ミニチュアダックス','small','long','scared speed','電動やすりでは時間と粉の飛散を嫌がっていたダックスが、ギロチン型なら短時間で切れて負担が減った体験。','public_buyer_review_summary','https://store.shopping.yahoo.co.jp/petrry/zan-003.html'),
('zan-guillotine-sm','犬種不明・爪切り嫌い',NULL,NULL,'scared','安価な爪切りでは痛そうに嫌がっていた犬が、切れ味の良いZANでは大人しく切らせるようになった体験。','public_buyer_review_summary','https://store.shopping.yahoo.co.jp/petrry/zan-003.html'),
('zan-guillotine-sm','犬種不明・獣医の道具を参考',NULL,NULL,'beginner','獣医が使うギロチン型を参考に初めて購入し、爪切りが苦手な犬でも切った瞬間を気にしにくかった体験。','public_buyer_review_summary','https://store.shopping.yahoo.co.jp/petrry/zan-003.html'),
('zan-guillotine-sm','犬種不明・ハサミ式から変更',NULL,NULL,'beginner low-force','ハサミ式からギロチン型へ替え、少ない力で切れ、慣れると使いやすかった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/p/92215438b9'),
('zan-guillotine-sm','犬種不明・音と振動を気にする犬',NULL,NULL,'quiet','従来品より軽い力でスパッと切れ、音や振動で犬を驚かせにくいと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/p/92215438b9'),
('zan-guillotine-large','犬種不明・初めての自宅爪切り',NULL,NULL,'beginner large','病院へ毎回行く代わりに自宅爪切りへ挑戦し、数mmずつ切って使いやすさを実感した体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/p/92215438b9'),
('zan-guillotine-large','バーニーズ','large','long','hard-nail quiet','バーニーズの硬い狼爪で、以前の爪切りでは割れて出血したが、ZANでは少ない力でスパッと切れ犬も静かだった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/p/92215438b9'),
('zan-guillotine-sm','犬種不明・長期使用',NULL,NULL,'durability','同じZANを5年以上使い、他社品よりバネや刃が長持ちすると感じて買い替えた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/266937_10000856/1.1/')
)
INSERT INTO reviews(product_id,dog_breed,dog_size,coat_type,needs,summary,source_type,source_url)
SELECT n.product_id,n.dog_breed,n.dog_size,n.coat_type,n.needs,n.summary,n.source_type,n.source_url
FROM new_reviews n
WHERE NOT EXISTS (
 SELECT 1 FROM reviews r
 WHERE r.product_id=n.product_id
 AND COALESCE(r.dog_breed,'')=COALESCE(n.dog_breed,'')
 AND r.summary=n.summary
);

SELECT
 (SELECT COUNT(*) FROM reviews r JOIN products p ON p.id=r.product_id WHERE p.category='nail-clipper') AS nail_clipper_review_count;
