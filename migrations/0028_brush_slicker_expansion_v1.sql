-- Phase 1: expand brush-slicker public experiences without changing existing rows.
-- Additive/idempotent only. Never run seed.sql in production.
-- Public review text is not stored; summaries below are independently written.
PRAGMA foreign_keys = ON;

WITH new_reviews(product_id,dog_breed,dog_size,coat_type,needs,summary,source_type,source_url) AS (
VALUES
-- 岡野製作所 スリッカー 武蔵 ソフト
('okano-musashi-soft','トイプードル',NULL,'curly','mat scared relaxed fluffy','足首に毛玉ができやすくブラッシングを嫌がっていたトイプードルで、毛先からやさしく梳かすと絡まりをほぐしやすく、途中で眠るほど落ち着き、ふわっと仕上がった体験。','public_buyer_review_summary','https://store.shopping.yahoo.co.jp/zunzunpetsupply/4907733146202.html'),
('okano-musashi-soft','トイプードル・1歳',NULL,'curly','gentle scared fluffy','玉付きピンのブラシから替えたところ毛通りが良くなり、皮膚を傷つけずに使えて、以前よりブラッシングを嫌がりにくくなりふわっと仕上がった体験。','public_buyer_review_summary','https://store.shopping.yahoo.co.jp/zunzunpetsupply/4907733146202.html'),
('okano-musashi-soft','プードル',NULL,'curly','handling fluffy','密なピンに最初は引っかかりを感じたものの、数日使って慣れると縮れた被毛を整えやすく、以前のブラシよりふわっと仕上がった体験。','public_buyer_review_summary','https://store.shopping.yahoo.co.jp/zunzunpetsupply/4907733146202.html'),
('okano-musashi-soft','小柄な犬',NULL,NULL,'size mat daily fluffy','小柄な犬にSサイズを選び、手の付け根にできた毛玉を整えやすく、朝晩のブラッシングでふわっと仕上げられた体験。','public_buyer_review_summary','https://store.shopping.yahoo.co.jp/zunzunpetsupply/4907733146202.html'),
('okano-musashi-soft','トイプードル',NULL,'curly','handling fluffy','古くなったスリッカーから買い替え、少しコツは必要だが、自宅でもトリミング後のようにふわっと仕上がると感じた体験。','public_buyer_review_summary','https://store.shopping.yahoo.co.jp/zunzunpetsupply/4907733146202.html'),
('okano-musashi-soft','コーギー・2歳',NULL,NULL,'shedding sensitive-area relaxed','ファーミネーターから替えて約1か月半使用。毛の薄い部分やお尻は嫌がる一方、背中の毛量が多い部分は気持ちよさそうに受け入れ、部位ごとに力加減を変えて使っている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/333995_10224588/1.1/'),
('okano-musashi-soft','ポメラニアン',NULL,NULL,'fluffy','ポメラニアンに使い、ブラッシング後の被毛が大きくふわっと立ち上がる仕上がりを実感した体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/333995_10224588/1.1/'),
('okano-musashi-soft','犬種不明・毛玉あり',NULL,NULL,'mat time gentle','以前のブラシでは取れなかった毛玉が短時間でほぐれ、長く引っ張らずに済むため痛みも少なそうに感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/333995_10224588/1.1/'),
('okano-musashi-soft','犬種不明・抜け毛あり',NULL,NULL,'shedding scared negative','抜け毛はよく取れたものの、このブラシでは犬が嫌がり、他のスリッカーでは同じ反応がなかったという相性の合わない体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/333995_10224588/1.1/'),
('okano-musashi-soft','トイプードル',NULL,'curly','face mat scared size fluffy','エリザベスカラー装着中に顔まわりへできた毛玉のケアに使い、以前の玉付きブラシより引っかかりが少なく嫌がり方も軽く、ふわっと仕上がった一方、中サイズは小型犬には大きく感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/333995_10224588/1.1/'),
('okano-musashi-soft','小型のプードル',NULL,'curly','professional gentle handling','トリマーが小型プードルの施術用に導入し、手のひらで当たりを確認しても痛く感じにくく、適度なしなりがあって扱いやすいと評価した使用体験。','public_buyer_review_summary','https://store.shopping.yahoo.co.jp/zunzunpetsupply/4907733146202.html'),

-- ローレンス ソフトスリッカー
('lawrence-soft-slicker','ポメラニアン・3kg台',NULL,NULL,'size detail body','SとMを使い分け、Sは耳の後ろや後頭部など細かな場所に小回りが利き、Mは背中へ使いやすいと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/216162_10005674/1.1/'),
('lawrence-soft-slicker','トイプードル2頭',NULL,'curly','multi scared fluffy','2頭のトイプードルに使い、どちらも嫌がらずブラッシングでき、被毛がかなりふわっと仕上がった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/216162_10005674/1.1/'),
('lawrence-soft-slicker','トイプードル・2か月',NULL,'curly','puppy caution','生後2か月のトイプードルに使い始め、まだピンを鋭く感じるため本格的なブラッシングは控えめにし、成長しながら慣らしている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/216162_10005674/1.1/'),
('lawrence-soft-slicker','マルチーズ',NULL,NULL,'size scared gentle','マルチーズ用にSサイズを選び、小さく扱いやすい一方、やさしく使っても犬が少し痛そうに嫌がる様子があり、慣らしながら使っている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/216162_10005674/1.1/'),
('lawrence-soft-slicker','ポメラニアン・2.6kg',NULL,NULL,'repeat shedding fluffy handling','同じブラシを紛失後に安価なスリッカーで代用したが使用感が合わず再購入。抜け毛を取りやすくふわっと仕上がり、普段のブラッシングやブローでも疲れにくいと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/216162_10005674/1.1/'),
('lawrence-soft-slicker','ヨークシャーテリア・3.5kg',NULL,NULL,'mat relaxed shine size','細い被毛で1日手入れを休むと毛玉ができやすいヨーキーに使い、犬が落ち着いて受け入れ、サイズも扱いやすく、少ない回数でも毛並みがつややかに整った体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/216162_10005674/1.1/'),
('lawrence-soft-slicker','柴犬＋ポメラニアンと柴のミックス',NULL,NULL,'multi size daily durability','柴犬にはS、ポメラニアンと柴のミックスにはMを使い分けて毎日ブラッシング。使いやすくリピートしている一方、ピンが乱れてきたら早めに交換している体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/216162_10005674/1.1/'),
('lawrence-soft-slicker','柴犬',NULL,NULL,'size handling','柴犬にSサイズを使い、体の細かな部分にちょうどよいと感じた一方、持ち手にはもう少し握りやすさが欲しいと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/216162_10005674/1.1/'),
('lawrence-soft-slicker','犬種不明',NULL,NULL,'gentle scared fluffy','スリッカーは痛そうという印象から獣毛ブラシを使っていた家庭で試したところ、犬が痛がらず受け入れ、想像以上にふわっと仕上がった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/216162_10005674/1.1/'),
('lawrence-soft-slicker','犬種不明・毛量多め',NULL,NULL,'lightweight gentle fluffy mat','武蔵からローレンスへ替え、軽さと柔らかいピンで犬が嫌がりにくく、表面はふわっと仕上がった一方、毛量が多いため奥まで梳けているかは分かりにくく、毛玉には武蔵も併用している体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/216162_10005674/1.1/'),

-- SHOWTECH スリッカー
('showtech-slicker','犬種不明',NULL,NULL,'handling shedding gentle','100円ショップのスリッカーから替え、カーブした形と丸みのあるピン先が扱いやすく、毛も取りやすいと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=5420031910263&store_id=aecom'),
('showtech-slicker','プードル',NULL,'curly','size scared negative quality','カーブ形状で実際に当たる面が狭く感じ、体格にも合わず、ブラッシングすると逃げてしまった体験。裏面の作りも価格に対して簡素に感じたという低評価。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=5420031910263&store_id=aecom'),
('showtech-slicker','トイプードル・1歳',NULL,'curly','mat scared time size','複数のブラシを嫌がっていたトイプードルで、力を入れず毛玉をほぐしやすくなり、ブラッシング時間も短縮。顔まわりには少し大きく感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=5420031910263&store_id=aecom'),
('showtech-slicker','犬種不明・毛玉あり',NULL,NULL,'mat scared relaxed fluffy','毛玉に悩んでいた犬へ使い、以前のブラシより嫌がりにくく、むしろ気持ちよさそうに受け入れながら被毛をふわっと整えられた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=5420031910263&store_id=aecom'),

-- 追加調査：岡野製作所 スリッカー 武蔵 ソフト
('okano-musashi-soft','犬種不明',NULL,NULL,'fluffy handling maintenance','ピンの並びや本体のバランスが扱いやすく、梳かした後は被毛がふわっと整った一方、ブラシに残った毛を外す作業は少し手間に感じた体験。','public_buyer_review_summary','https://store.shopping.yahoo.co.jp/zunzunpetsupply/4907733146202.html'),
('okano-musashi-soft','犬種不明',NULL,NULL,'time fluffy blow-dry','ブラッシングだけでも被毛がふわっと立ち上がり、仕上げのために毎回ブローしなくても整えやすく、手入れ時間を短くできたと感じた体験。','public_buyer_review_summary','https://store.shopping.yahoo.co.jp/zunzunpetsupply/4907733146202.html'),
('okano-musashi-soft','シニア犬・15歳',NULL,NULL,'long-use durability repeat','長年使っていた同じ武蔵のピンが曲がってきたため買い替え、15歳の犬の手入れでも同じモデルを継続して使っている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/333995_10224588/1.1/'),
('okano-musashi-soft','バーニードゥードル',NULL,NULL,'size handling','以前は小型犬のシーズーに小さいサイズを使っていた家庭で、現在のバーニードゥードルには中サイズを選び、体格に合って扱いやすいと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/333995_10224588/1.1/'),
('okano-musashi-soft','犬種不明',NULL,NULL,'shedding repeat quality','以前使っていた岡野製作所のスリッカーが壊れ、プラスチック製など別の商品も試した後に戻り、抜け毛の取れ方が最も良いと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/333995_10224588/1.1/'),

-- 追加調査：ローレンス ソフトスリッカー
('lawrence-soft-slicker','犬種不明・ブラッシング嫌い',NULL,NULL,'scared gentle','武蔵ではブラッシングを嫌がっていた犬にローレンスを試したところ、以前より抵抗が少なく手入れを受け入れやすくなった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/216162_10005674/1.1/'),
('lawrence-soft-slicker','犬種不明・長期使用',NULL,NULL,'long-use repeat','長年にわたり犬のスリッカーはローレンスを使い続け、買い替えながら同じシリーズを選んでいるという継続使用の体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/216162_10005674/1.1/'),
('lawrence-soft-slicker','小型犬', 'small',NULL,'size repeat handling','小型犬にSサイズを使い、体格にちょうどよく扱いやすかったため、同じサイズを繰り返し選んでいる体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/216162_10005674/1.1/'),
('lawrence-soft-slicker','犬種不明',NULL,NULL,'lightweight handling size','軽くて動かしやすく日常の手入れには使いやすい一方、広い範囲を梳かすならMサイズでもよかったと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/216162_10005674/1.1/'),
('lawrence-soft-slicker','犬種不明・複数頭',NULL,NULL,'gentle daily durability','柔らかめのピンで複数の犬の日常ケアに使いやすく、使用頻度が高いため消耗を見ながら継続して使っている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/216162_10005674/1.1/'),
('lawrence-soft-slicker','犬種不明',NULL,NULL,'handling fluffy maintenance','梳かしやすく被毛がふわっと整うため気に入って使い、ピンを傷めないよう保管にも気を配っている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/216162_10005674/1.1/'),
('lawrence-soft-slicker','犬種不明・長期使用',NULL,NULL,'long-use gentle relaxed fluffy','以前飼っていた犬の頃からローレンスを使い、軽さと柔らかさを気に入って現在の犬にも継続。ブラッシング中にうとうとするほど落ち着き、ふわっと仕上がる体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/216162_10005674/1.1/'),
('lawrence-soft-slicker','柔らかい毛で毛玉ができやすい犬',NULL,NULL,'mat gentle fluffy handling','柔らかく絡まりやすい被毛に使い、引っかかりが少なく毛玉を整えやすく、ふわっと仕上がるため日常ケアが楽になった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/216162_10005674/1.1/'),
('lawrence-soft-slicker','トイプードル・3kg', 'small','curly','size handling','3kgのトイプードルの体にSサイズを使い、細かな部分には扱いやすい一方、全身にはもう少し大きいサイズでもよく、持ち手も短めに感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/216162_10005674/1.1/'),
('lawrence-soft-slicker','ヨークシャーテリア・3か月', 'small','long','puppy scared fluffy shine','生後3か月のヨークシャーテリアはまだブラッシングに抵抗するものの、梳かせた部分はさらっとふわっと整い、被毛の仕上がりを実感した体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/216162_10005674/1.1/'),
('lawrence-soft-slicker','犬種不明',NULL,NULL,'lightweight smooth mat-prevention','軽く滑らかに動かせて日常的に使いやすく、こまめに梳かすことで絡まりを作りにくくできると感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/216162_10005674/1.1/'),
('lawrence-soft-slicker','犬種不明',NULL,NULL,'face legs gentle repeat','顔や足など細かな場所に小さいサイズを使い、皮膚へ強く当たりにくく扱いやすいため、買い替えでも同じ商品を選んだ体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/216162_10005674/1.1/'),
('lawrence-soft-slicker','犬種不明',NULL,NULL,'relaxed fluffy mixed-shedding','周囲が気になる状況でも比較的落ち着いてブラッシングを受け、抜け毛量は期待ほど多くなかったものの被毛はふわっと整った体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/216162_10005674/1.1/'),
('lawrence-soft-slicker','チワワ×トイプードル・子犬', 'small','curly','puppy size fluffy handling','チワワとトイプードルのミックスの子犬に使い、軽く梳かしやすくふわっと仕上がった一方、子犬の時点ではSサイズでも少し大きく、成長後にちょうどよくなりそうと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/216162_10005674/1.1/'),
('lawrence-soft-slicker','犬種不明・頑固なもつれ',NULL,NULL,'mat','なかなか取れなかった頑固なもつれに使い、少しずつ梳かすことでほぐせた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/216162_10005674/1.1/'),

-- 追加調査：SHOWTECH スリッカー
('showtech-slicker','秋田犬・5歳', 'large','double','shedding scared daily','以前のブラシを紛失して買い替え、抜け毛を取りやすく犬も強く嫌がらないため、換毛期の日常ケアに使いやすいと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list/2/?page_key=5420031910263&store_id=aecom'),
('showtech-slicker','マルチプー＋ビションフリーゼ', 'small','curly','multi fluffy repeat','複数頭に使い、特にビションのブラッシングでは仕上がりの違いを感じて欠かせず、消耗に合わせて定期的に買い替えている体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list/2/?page_key=5420031910263&store_id=aecom'),
('showtech-slicker','ゴールデンドゥードル',NULL,'curly','daily mat handling','軽くカールした被毛でもつれやすいため毎日のブラッシングに使い、カーブした形状で全身を梳かしやすいと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list/2/?page_key=5420031910263&store_id=aecom'),
('showtech-slicker','スタンダードプードル', 'large','curly','recommend fluffy','以前のブラシから、勧められてSHOWTECHへ替え、スタンダードプードルの被毛がよりふわっと仕上がると感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list/2/?page_key=5420031910263&store_id=aecom'),
('showtech-slicker','シェルティ2頭', 'medium','long double','multi shedding blow-dry fluffy','シェルティ2頭の抜け毛ケアとドライ後の仕上げに使い、下毛を整えながら被毛がふわっと滑らかになると感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list/2/?page_key=5420031910263&store_id=aecom')
)
INSERT INTO reviews(product_id,dog_breed,dog_size,coat_type,needs,summary,source_type,source_url)
SELECT n.product_id,n.dog_breed,n.dog_size,n.coat_type,n.needs,n.summary,n.source_type,n.source_url
FROM new_reviews n
WHERE NOT EXISTS (
  SELECT 1 FROM reviews r
  WHERE r.product_id=n.product_id
    AND r.summary=n.summary
);

-- Verified production baseline before this migration:
-- all products: 109
-- all reviews: 895
-- brush-slicker: 4 products / 50 reviews
--
-- Expected after this migration:
-- all products: 109
-- all reviews: 945
-- brush-slicker: 4 products / 100 reviews
SELECT COUNT(*) AS brush_slicker_product_count
FROM products WHERE category='brush-slicker' AND active=1;

SELECT COUNT(*) AS brush_slicker_review_count
FROM reviews r JOIN products p ON p.id=r.product_id
WHERE p.category='brush-slicker' AND p.active=1;
