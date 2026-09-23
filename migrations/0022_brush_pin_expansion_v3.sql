-- Phase 4: broaden brush-pin catalog with additional major products
-- and add further independently written public buyer experience summaries.
-- Additive/idempotent only. Never run seed.sql in production.
PRAGMA foreign_keys = ON;

INSERT OR IGNORE INTO products(id,name,category,active) VALUES
('wetbrush-smallbreed-detangler','Wetbrush for Pet スモールブリード ディタングラー','brush-pin',1),
('bass-natural-bamboo-pin','BASS ナチュラルバンブーピンブラシ','brush-pin',1),
('bass-handler-pin-s','BASS ザ・ハンドラー ピンブラシ S','brush-pin',1),
('bass-handler-pin-m','BASS ザ・ハンドラー ピンブラシ M','brush-pin',1);

INSERT OR IGNORE INTO product_identifiers(namespace,identifier,product_id,evidence_url) VALUES
('manufacturer_model','wetbrush:WB001','wetbrush-smallbreed-detangler','https://www.biccamera.com/bc/item/14104682/'),
('gtin','4904879120004','wetbrush-smallbreed-detangler','https://product.rakuten.co.jp/product/-/9409789f46c65024ffaf264b9f18af27/'),
('manufacturer_model','bass:BS09045','bass-natural-bamboo-pin','https://store.shopping.yahoo.co.jp/freebirdcorp/bs09045.html'),
('gtin','4979007090450','bass-natural-bamboo-pin','https://store.shopping.yahoo.co.jp/freebirdcorp/bs09045.html'),
('manufacturer_model','bass:BS09067','bass-handler-pin-s','https://store.shopping.yahoo.co.jp/freebirdcorp/bs09067.html'),
('gtin','4979007090672','bass-handler-pin-s','https://store.shopping.yahoo.co.jp/freebirdcorp/bs09067.html'),
('manufacturer_model','bass:BS09068','bass-handler-pin-m','https://store.shopping.yahoo.co.jp/freebirdcorp/bs09068.html'),
('gtin','4979007090689','bass-handler-pin-m','https://store.shopping.yahoo.co.jp/freebirdcorp/bs09068.html');

INSERT OR IGNORE INTO product_listings(marketplace,external_id,product_id,source_url) VALUES
('rakuten','naturelab:4904879120004','wetbrush-smallbreed-detangler','https://item.rakuten.co.jp/naturelab/4904879120004/'),
('yahoo','kurosu:33124564ku','wetbrush-smallbreed-detangler','https://store.shopping.yahoo.co.jp/kurosu/33124564ku.html'),
('yahoo','freebirdcorp:bs09045','bass-natural-bamboo-pin','https://store.shopping.yahoo.co.jp/freebirdcorp/bs09045.html'),
('yahoo','freebirdcorp:bs09067','bass-handler-pin-s','https://store.shopping.yahoo.co.jp/freebirdcorp/bs09067.html'),
('yahoo','freebirdcorp:bs09068','bass-handler-pin-m','https://store.shopping.yahoo.co.jp/freebirdcorp/bs09068.html');

WITH new_reviews(product_id,dog_breed,dog_size,coat_type,needs,summary,source_type,source_url) AS (
VALUES
('wetbrush-smallbreed-detangler','トイプードル','small','curly','scared relaxed','トイプードルに使うとブラッシング中にうとうとするほど落ち着いて受け入れた体験。顔まわりなど細かい部分は別のブラシと使い分けている。','public_buyer_review_summary','https://product.rakuten.co.jp/product/-/9409789f46c65024ffaf264b9f18af27/review/'),
('wetbrush-smallbreed-detangler','犬種不明・ブラッシング好き','small',NULL,'relaxed shine','普段のブラシより肌当たりが合うのか、じっとして気持ちよさそうに受け入れ、終わった後も催促した体験。毛並みもなめらかになったと感じた。','public_buyer_review_summary','https://product.rakuten.co.jp/product/-/9409789f46c65024ffaf264b9f18af27/review/'),
('wetbrush-smallbreed-detangler','犬種不明・ブラシ嫌い','small',NULL,'scared fluffy daily','ブラッシングが苦手な犬でも一定時間は受け入れやすく、毎日使うことでふわっとした状態を保ちやすいと感じた体験。','public_buyer_review_summary','https://product.rakuten.co.jp/product/-/9409789f46c65024ffaf264b9f18af27/review/'),
('wetbrush-smallbreed-detangler','小型犬2頭','small',NULL,'scared handling','2頭の犬に使い、どちらも強く嫌がらず、飼い主側もブラッシングしやすいと感じた体験。','public_buyer_review_summary','https://product.rakuten.co.jp/product/-/9409789f46c65024ffaf264b9f18af27/review/'),
('wetbrush-smallbreed-detangler','マルチーズ','small','long','gentle wet tangle','マルチーズに普段のお手入れやシャンプー後の濡れた被毛で使い、痛がりにくく負担が少ないと感じた体験。','public_buyer_review_summary','https://item.rakuten.co.jp/sweet-pet/wet0001sb/'),
('wetbrush-smallbreed-detangler','ペキニーズ','small','long','fluffy handling','ペキニーズに使うと櫛通りが軽く、ブラッシング後にシャンプー後のようなふわっとした仕上がりを感じた体験。抜けた毛もブラシから外しやすかった。','public_buyer_review_summary','https://item.rakuten.co.jp/sweet-pet/wet0001sb/'),
('wetbrush-smallbreed-detangler','マルチーズ×トイプードル／チワワ×トイプードル','small','curly','relaxed handling','小型のミックス犬2頭に使い、ブラシがスムーズに通り、犬たちも気持ちよさそうに受け入れた体験。','public_buyer_review_summary','https://product.rakuten.co.jp/product/-/9409789f46c65024ffaf264b9f18af27/review/'),
('wetbrush-smallbreed-detangler','犬種不明・痛がり','small',NULL,'gentle relaxed','以前のブラッシングでは痛がる様子があった犬に使い、今回は痛がりにくく気持ちよさそうに受け入れた体験。','public_buyer_review_summary','https://product.rakuten.co.jp/product/-/9409789f46c65024ffaf264b9f18af27/review/'),
('wetbrush-smallbreed-detangler','トイプードル・4kg','small','curly','handling face','4kgのトイプードルでは体全体を大まかに梳かす用途に使いやすく、顔まわりや細かな部分は目の細かいコームを併用している体験。','public_buyer_review_summary','https://product.rakuten.co.jp/product/-/9409789f46c65024ffaf264b9f18af27/review/'),
('wetbrush-smallbreed-detangler','老犬・皮膚が敏感な犬',NULL,NULL,'gentle blow-dry','トリマーがブロー時に使用し、当たりが柔らかいため老犬や皮膚が敏感な犬にも使いやすいと感じた体験。毛量が多い犬ではスリッカーとの使い分けが必要と感じている。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/349802_10006221/1.1/'),

('showtech-ultrapro-l','大型の長毛子犬','large','long','relaxed size','将来の長毛ケア用に大きめサイズを選び、子犬の段階で使ってみると気持ちよさそうに受け入れた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=tr24se016&store_id=freebirdcorp'),
('showtech-ultrapro-l','皮膚が敏感な犬',NULL,NULL,'gentle finish','長めのピンと柔らかいクッションで、皮膚が敏感な犬の日々の仕上げブラッシングに使いやすいと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=tr24se016&store_id=freebirdcorp'),
('showtech-ultrapro-l','シーズー3頭','small','long','size handling','フルコートやセミコートなど長さの違うシーズーに使い、ブラシの大きさがちょうどよく扱いやすかった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=tr24se016&store_id=freebirdcorp'),
('showtech-ultrapro-l','ポメラニアン','small','long double','handling fatigue','毛量が増えたポメラニアンに使い、以前のピンブラシより毛へ通しやすく、軽量で手首が疲れにくいと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=tr24se016&store_id=freebirdcorp'),
('showtech-ultrapro-l','ラフコリー','large','long double','long-coat handling','ラフコリーに使い、長めでしっかりしたピンが被毛に入りやすく、木製ブラシより軽く握りやすいと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=tr24se016&store_id=freebirdcorp'),
('showtech-ultrapro-l','ボーダーコリー','medium','long double','handling fatigue durability','ボーダーコリーの長いブラッシング時間でも、軽量で手への負担が少なく、ピンが台座へ沈み込みにくいと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=tr24se016&store_id=freebirdcorp'),
('showtech-ultrapro-l','シェルティ','medium','long double','size long-coat','シェルティに使い、ピンの長さとブラシ本体の大きさが被毛にちょうどよいと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=tr24se016&store_id=freebirdcorp'),
('showtech-ultrapro-l','シェパード／シェルティ','large','double','handling durability','シェパードに使い、以前シェルティで使っていたブラシとの比較でも使用感は良好と感じた一方、ピンがもう少し長ければさらに使いやすいと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=tr24se016&store_id=freebirdcorp'),

('showtech-ultrapro-s','ビションフリーゼ','small','curly','tangle gentle daily','ビションの日常ケアに使い、軽い絡まりをやさしく梳かしやすく、犬も嫌がりにくかった体験。強いもつれではスリッカーも併用している。','public_buyer_review_summary','https://store.shopping.yahoo.co.jp/aecom/5420031936843.html'),

('kpro-groomer-pin-485','半長毛で一部くせ毛の犬',NULL,'long curly','tangle handling','半長毛で一部くせ毛の犬に使い、お尻の毛や手足の飾り毛へ引っかかりにくく通しやすかった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/216162_10005595/1.1/')
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
-- brush-pin: 35 products / 161 reviews
SELECT COUNT(*) AS brush_pin_product_count
FROM products WHERE category='brush-pin' AND active=1;

SELECT COUNT(*) AS brush_pin_review_count
FROM reviews r JOIN products p ON p.id=r.product_id
WHERE p.category='brush-pin' AND p.active=1;
