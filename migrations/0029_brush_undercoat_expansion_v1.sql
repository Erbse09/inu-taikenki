PRAGMA foreign_keys = ON;

WITH new_reviews(product_id,dog_breed,dog_size,coat_type,needs,summary,source_type,source_url) AS (
VALUES
('showtech-duopin-undercoat','トイプードル','small','curly','scared shedding fluffy lightweight','スリッカーを嫌がりやすいトイプードルで、以前のブラシより抵抗が軽く、抜け毛を取りながらふわっと仕上げやすく、軽さも扱いやすいと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=tr25se007&store_id=freebirdcorp'),
('showtech-duopin-undercoat','マルチーズ＋トイプードル','small','long curly','multi size long-pin handling','2〜3kg台の小型犬にSサイズを使い、やや長めのピンで長い被毛へ入りやすく、握りやすいグリップで日常ケアに使いやすいと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=tr25se007&store_id=freebirdcorp'),
('showtech-duopin-undercoat','コーギー・13kg','medium','double','shedding size detail relaxed','13kgのコーギーにSサイズを使い、全身には小さめでも細かな部分を梳かしやすく、換毛期の抜け毛が多く取れて犬も痛がらなかった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=tr25se007&store_id=freebirdcorp'),
('showtech-duopin-undercoat','ダブルコート犬',NULL,'double','shedding scared','従来のスリッカーより抜け毛が多く取れ、ブラッシングを嫌がっていた犬が比較的素直に受け入れた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=tr25se007&store_id=freebirdcorp'),
('showtech-duopin-undercoat','トイプードル','small','curly','fluffy relaxed','同ブランドの別タイプも使っている家庭で、トイプードルが落ち着いてブラッシングを受け、被毛がふわっと整った体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=tr25se007&store_id=freebirdcorp'),
('showtech-duopin-undercoat','ポメラニアン','small','long','long-coat negative tangle','毛量が多く長いポメラニアンでは、ピンの密さとカーブで被毛が引っかかりやすく、短〜中毛の犬の方が使いやすそうと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=tr25se007&store_id=freebirdcorp'),
('showtech-duopin-undercoat','黒柴・1歳3か月','medium','double short','scared','1歳3か月の黒柴に使い、初回から強く嫌がることなくブラッシングできた体験。','public_buyer_review_summary','https://item.rakuten.co.jp/freebird/tr25se007/'),
('showtech-duopin-undercoat','イングリッシュコッカースパニエル','medium','long','long-pin gentle fluffy','少し長めのピンで長毛をやさしく梳かしやすく、以前のブラシより負担を抑えながらふわっと仕上げやすいと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=tr25se007&store_id=freebirdcorp'),
('showtech-duopin-undercoat','トイプードル','small','curly','mat handling','ソフトタイプでは取りにくかった絡まりに使い、小さめのブラシとしっかりしたピンで細かな部分を整えやすかった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=tr25se007&store_id=freebirdcorp'),
('showtech-duopin-undercoat','ブラッシング嫌いの犬',NULL,NULL,'scared gentle','市販のスリッカーでは痛がって時間がかかっていた犬が、このブラシでは強く嫌がらず最後まで手入れでき、ブラッシングが楽になった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=tr25se007&store_id=freebirdcorp'),
('showtech-duopin-undercoat','ポメックス','small','long double','shedding fluffy lightweight','軽くて扱いやすく、玉付きピンのブラシより下毛が取れやすく、仕上がりのふわふわ感も増したと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=tr25se007&store_id=freebirdcorp'),
('showtech-duopin-undercoat','犬種不明・顔まわり','small',NULL,'face detail handling','顔や細かな部分をブラッシングするために小さいサイズを使い、狭い場所へ当てやすく手入れがしやすくなった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=tr25se007&store_id=freebirdcorp'),
('showtech-duopin-undercoat','子犬',NULL,NULL,'puppy handling','子犬を迎えたタイミングで新調し、以前のブラシよりグリップが持ちやすく、日常のブラッシングに使いやすいと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=tr25se007&store_id=freebirdcorp'),
('showtech-duopin-undercoat','秋田犬','large','double','shedding time','秋田犬の換毛期に軽くブラシを通すだけで毛を絡め取りやすく、長時間かけずに手入れできた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=tr25se007&store_id=freebirdcorp'),
('showtech-duopin-undercoat','トイプードル・6kg','small','curly','size scared','6kgのトイプードルに小さいサイズを使っても問題なく、犬が強く嫌がることなくブラッシングできた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=tr25se007&store_id=freebirdcorp'),
('showtech-duopin-undercoat','犬種不明',NULL,NULL,'smooth relaxed','別のブラシと併用すると被毛がさらっと整い、犬も気持ちよさそうに受け入れた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=tr25se007&store_id=freebirdcorp'),
('showtech-duopin-undercoat','犬種不明・買い替え',NULL,NULL,'repeat shedding','以前使っていたブラシの破損をきっかけに買い替え、撫でやすく抜け毛もきちんと取れるため概ね満足した体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=tr25se007&store_id=freebirdcorp'),
('showtech-duopin-undercoat','犬種不明',NULL,NULL,'handling grip','しっかりしたピンとカーブしたブラシ面、握りやすいラバーグリップで手入れしやすいと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=tr25se007&store_id=freebirdcorp'),
('showtech-duopin-undercoat','毛玉ができやすい犬',NULL,NULL,'mat gentle pro-recommend','毛玉ができやすい部分にも使いやすいとトリマーから勧められ、皮膚へ強く当てないよう使いながら日常ケアに取り入れた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=tr25se007&store_id=freebirdcorp'),
('showtech-duopin-undercoat','小型犬','small',NULL,'size shine','小型犬に使いやすい大きさで、毛通りが良くなり被毛につやが出たと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=tr25se007&store_id=freebirdcorp'),

('furminator-deshedding','ポメラニアン・10kg','medium','long double','shedding time','コームやピンブラシなど複数の道具を毎日使っていた10kgのポメラニアンで、1本でも抜け毛を効率よく回収でき、手入れがかなり簡単になった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=10022678&store_id=kurosu'),
('furminator-deshedding','柴犬','medium','double short','long-use shedding skin','子犬の頃から継続して使っている柴犬で、皮膚への負担を抑えながら換毛期の余分な毛を多く取れると感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=10022675&store_id=kurosu'),
('furminator-deshedding','ボーダーコリー','medium','long double','undercoat','ボーダーコリーのアンダーコートを取る目的で長毛中型犬用を選び、下毛ケア用として使った体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=10022678&store_id=kurosu'),
('furminator-deshedding','保護犬の雑種・13kg','medium','long double','shedding time gentle','ハスキーのような毛並みの13kgの保護犬に使い、10分ほどでも抜け毛が大きく減り、スリッカーより短時間で済んで負担も少なく感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=10022678&store_id=kurosu'),
('furminator-deshedding','柴系雑種・15歳','medium','long double','senior shedding time caution','柔らかく少し長い毛の15歳の柴系雑種に使い、軽い力で抜け毛を多く回収でき、手入れ時間を短くできた一方、皮膚がたるむ部分は深く当てないよう注意した体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=10022678&store_id=kurosu'),
('furminator-deshedding','高齢のダブルコート犬','medium','long double','senior shedding maintenance','毎月のトリミングが難しくなった高齢のダブルコート犬に使い、ひとなでするだけでも毛を取りやすく、ブラシに付いた毛も外しやすかった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=10022678&store_id=kurosu'),
('furminator-deshedding','甲斐犬','medium','double','shedding daily scared','安価なブラシでは毛が取りにくく犬も嫌がっていたが、換毛期の甲斐犬に使うと抜け毛が多く取れ、毎日の散歩時に10〜15分ほど使えるようになった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=10022678&store_id=kurosu'),
('furminator-deshedding','長毛のダブルコート犬',NULL,'long double','shedding relaxed smooth','換毛期に使うと毎回多くの下毛が取れ、最初は警戒していた犬も慣れると落ち着いて受け入れ、被毛がさらっと整った体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=10022678&store_id=kurosu'),
('furminator-deshedding','柴犬','medium','double short','negative topcoat caution','換毛期の柴犬に使って大量に毛が取れた後、被毛の先端が切れていると指摘され、トップコートへの影響を気にして使用を見直したという否定的体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=10022675&store_id=kurosu'),
('furminator-deshedding','柴犬','medium','double','shedding legs relaxed','換毛期の柴犬に使い、一度撫でるだけでも下毛が多く取れ、普段は嫌がる足まわりも比較的じっとしてブラッシングを受けた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list/2/?page_key=10022678&store_id=kurosu'),
('furminator-deshedding','ダブルコート犬',NULL,'double','shedding weight','アンダーコート用として軽く当てるだけでも大量に毛を回収できた一方、本体の重さで長時間は手が疲れると感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list/2/?page_key=10022678&store_id=kurosu'),
('furminator-deshedding','犬種不明',NULL,NULL,'gentle handling','以前の毛すきでは引っ張る感じがあったが、ファーミネーターでは滑らかに梳かしやすく、犬も痛がる様子が少なかった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list/2/?page_key=10022678&store_id=kurosu'),
('furminator-deshedding','犬種不明',NULL,NULL,'maintenance relaxed','ブラシについた毛をワンタッチで押し出しやすく、反対の手で犬に触れながら手入れできる点を便利に感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list/2/?page_key=10022678&store_id=kurosu'),
('furminator-deshedding','犬種不明','medium','long','static caution shedding','抜け毛は非常によく取れた一方、乾燥時に静電気が起きることがあり、犬への刺激を気にしながら使った体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list/2/?page_key=10022678&store_id=kurosu'),
('furminator-deshedding','柴犬','medium','double','undercoat repeat','他のブラシでは残りやすかった内側の下毛まで取れ、価格は高めでも長く使えそうと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list/2/?page_key=10022678&store_id=kurosu'),
('furminator-deshedding','中型の長毛犬','medium','long','shedding value','長毛中型犬用を使い、安価なブラシと比べて回収できる毛量が大きく違い、価格に見合うと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list/2/?page_key=10022678&store_id=kurosu'),
('furminator-deshedding','シェットランドシープドッグ','medium','long double','shedding scared','サマーカット後のシェルティに使い、毛を多く回収でき、犬も強く嫌がらずブラッシングできた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list/2/?page_key=10022678&store_id=kurosu'),
('furminator-deshedding','犬種不明','medium','long','shedding shine','レビューで見た通り毛玉ができるほど抜け毛を回収でき、ブラッシング後は毛艶も良くなったように感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list/2/?page_key=10022678&store_id=kurosu'),
('furminator-deshedding','犬種不明','medium','long','undercoat relaxed','犬用のアンダーコートケアに使い、毛をきれいに取りやすく、犬も強く嫌がらず受け入れた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list/2/?page_key=10022678&store_id=kurosu'),
('furminator-deshedding','イングリッシュコッカースパニエル','medium','long','size negative detail','中型犬用を選んだが、足の付け根など狭い部分にはヘッドがやや大きく感じ、細かな場所では扱いにくかった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list/2/?page_key=10022678&store_id=kurosu'),
('furminator-deshedding','コーギー','medium','double','shedding size','コーギーの抜け毛対策に使い、非常によく毛を回収できた一方、体格によっては大型犬用でもよかったかもしれないと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list/2/?page_key=10022678&store_id=kurosu'),
('furminator-deshedding','柴犬','medium','double','shedding','散歩時に使うとアンダーコートが驚くほど取れ、以前のブラシとの違いを強く感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list/2/?page_key=10022678&store_id=kurosu'),
('furminator-deshedding','ゴールデンレトリバーの子犬','large','long double','puppy shedding home','長毛大型犬用を使うと大量の下毛が取れ、犬も嫌がらず、室内へ落ちる毛が減ったと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=10022680&store_id=kurosu'),
('furminator-deshedding','ゴールデンレトリバー','large','long double','weekly shedding','ゴールデンの抜け毛対策として週1回ほど使い、短時間でも下毛を効率よく減らせると感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=10022680&store_id=kurosu'),
('furminator-deshedding','チャウチャウ・1歳','large','long double','scared relaxed','1歳のチャウチャウに使い、長毛大型犬用でも嫌がらずブラッシングを受け入れた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=10022680&store_id=kurosu'),
('furminator-deshedding','シベリアンハスキー','large','long double','shedding','ハスキーに軽くブラッシングするだけでも抜け毛を回収でき、換毛期の本格的な手入れに備えて使い始めた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=10022680&store_id=kurosu'),
('furminator-deshedding','バーニーズ','large','long','size negative','Lサイズを使ったところバーニーズには大きく感じ、Mサイズの方が取り回しやすかったかもしれないと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=10022680&store_id=kurosu'),
('furminator-deshedding','シベリアンハスキー','large','long double','vet-recommend shedding','獣医師に勧められて大型犬長毛用を選び、ハスキーの抜け毛がよく取れて購入して良かったと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=fur72008&store_id=aries0417'),
('furminator-deshedding','ゴールデンレトリバー','large','long double','repeat shedding','以前使っていた本体の刃が傷んだため買い替え、引き続きゴールデンの抜け毛をしっかり回収できた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=fur72008&store_id=aries0417'),
('furminator-deshedding','シベリアンハスキー','large','long double','scared relaxed shedding','普段はブラッシングを嫌がるハスキーが、シャンプー後でも残っていた毛を取る際にこのブラシでは嫌がりにくかった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=fur72008&store_id=aries0417')
)
INSERT INTO reviews(product_id,dog_breed,dog_size,coat_type,needs,summary,source_type,source_url)
SELECT n.product_id,n.dog_breed,n.dog_size,n.coat_type,n.needs,n.summary,n.source_type,n.source_url
FROM new_reviews n
WHERE NOT EXISTS (
  SELECT 1 FROM reviews r
  WHERE r.product_id = n.product_id
    AND r.summary = n.summary
);

SELECT COUNT(*) AS brush_undercoat_product_count
FROM products
WHERE category='brush-undercoat' AND active=1;

SELECT COUNT(*) AS brush_undercoat_review_count
FROM reviews r
JOIN products p ON p.id=r.product_id
WHERE p.category='brush-undercoat' AND p.active=1;
