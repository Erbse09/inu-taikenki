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
('showtech-slicker','犬種不明・毛玉あり',NULL,NULL,'mat scared relaxed fluffy','毛玉に悩んでいた犬へ使い、以前のブラシより嫌がりにくく、むしろ気持ちよさそうに受け入れながら被毛をふわっと整えられた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=5420031910263&store_id=aecom')
)
INSERT INTO reviews(product_id,dog_breed,dog_size,coat_type,needs,summary,source_type,source_url)
SELECT n.product_id,n.dog_breed,n.dog_size,n.coat_type,n.needs,n.summary,n.source_type,n.source_url
FROM new_reviews n
WHERE NOT EXISTS (
  SELECT 1 FROM reviews r
  WHERE r.product_id=n.product_id
    AND r.summary=n.summary
);

-- Expected from the verified production baseline immediately before this migration:
-- all products: 109
-- all reviews: 920
-- brush-slicker: 4 products / 75 reviews
SELECT COUNT(*) AS brush_slicker_product_count
FROM products WHERE category='brush-slicker' AND active=1;

SELECT COUNT(*) AS brush_slicker_review_count
FROM reviews r JOIN products p ON p.id=r.product_id
WHERE p.category='brush-slicker' AND p.active=1;
