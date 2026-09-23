-- Phase 5: continue brush-pin catalog coverage with verified MAXIPIN variants
-- and add further independently written public buyer experience summaries.
-- Additive/idempotent only. Never run seed.sql in production.
PRAGMA foreign_keys = ON;

INSERT OR IGNORE INTO products(id,name,category,active) VALUES
('showtech-maxipin-small','SHOW TECH MAXIPIN スモールピンブラシ','brush-pin',1),
('showtech-maxipin-regular','SHOW TECH MAXIPIN レギュラー','brush-pin',1);

INSERT OR IGNORE INTO product_identifiers(namespace,identifier,product_id,evidence_url) VALUES
('gtin','4936479007188','allsystems-white-35','https://shopping.yahoo.co.jp/product/j/4936479007188/compare.html'),
('manufacturer_model','showtech:maxipin-small','showtech-maxipin-small','https://store.shopping.yahoo.co.jp/freebirdcorp/tr24se021.html'),
('gtin','5420031901254','showtech-maxipin-small','https://store.shopping.yahoo.co.jp/freebirdcorp/tr24se021.html'),
('manufacturer_model','showtech:maxipin-regular','showtech-maxipin-regular','https://store.shopping.yahoo.co.jp/freebirdcorp/tr24se002.html'),
('gtin','5420031908093','showtech-maxipin-regular','https://store.shopping.yahoo.co.jp/freebirdcorp/tr24se002.html');

INSERT OR IGNORE INTO product_listings(marketplace,external_id,product_id,source_url) VALUES
('yahoo','aecom:4936479007188','allsystems-white-35','https://store.shopping.yahoo.co.jp/aecom/4936479007188.html'),
('rakuten','freebird:tr24se021','showtech-maxipin-small','https://item.rakuten.co.jp/freebird/tr24se021/'),
('yahoo','freebirdcorp:tr24se021','showtech-maxipin-small','https://store.shopping.yahoo.co.jp/freebirdcorp/tr24se021.html'),
('rakuten','freebird:tr24se002','showtech-maxipin-regular','https://item.rakuten.co.jp/freebird/tr24se002/'),
('yahoo','freebirdcorp:tr24se002','showtech-maxipin-regular','https://store.shopping.yahoo.co.jp/freebirdcorp/tr24se002.html');

WITH new_reviews(product_id,dog_breed,dog_size,coat_type,needs,summary,source_type,source_url) AS (
VALUES
('allsystems-white-35','コリー','large','long double','tangle daily','コリーに毎日使い、毛玉になりやすい長毛でも被毛の根元までほぐしやすく、さらさらに保ちやすいと感じた体験。耐久性は今後確認したいとしている。','public_buyer_review_summary','https://shopping.yahoo.co.jp/product/j/4936479007188/compare.html'),
('allsystems-white-35','犬種不明・スリッカーで痛がる犬',NULL,NULL,'gentle comb','スリッカーが肌へ当たると痛がっていた犬に使い、丸いピン先では痛がりにくくなった体験。ピン間隔が広いため最後はコームで仕上げている。','public_buyer_review_summary','https://shopping.yahoo.co.jp/product/j/4936479007188/compare.html'),

('showtech-maxipin-small','ビションフリーゼ','small','curly','tangle relaxed durability','ビションにスリッカー前のブラッシングとして使い、多少のもつれでも痛がりにくく、途中から仰向けで眠るほど落ち着いて受け入れた体験。長期使用でもピンが抜けず、手にもフィットすると感じている。','public_buyer_review_summary','https://item.rakuten.co.jp/freebird/tr24se021/'),
('showtech-maxipin-small','犬種不明・小型犬複数', 'small',NULL,'static relaxed handling','小さめのブラシが手に合い、静電気も起きにくく、犬たちも気持ちよさそうにブラッシングを受けた体験。','public_buyer_review_summary','https://item.rakuten.co.jp/freebird/tr24se021/'),

('showtech-maxipin-regular','ヨークシャーテリア','small','long','tangle relaxed','ヨークシャーテリアのブラッシングに使い、もつれがするっと取れやすく、犬も快適そうに受け入れた体験。','public_buyer_review_summary','https://item.rakuten.co.jp/freebird/tr24se002/'),
('showtech-maxipin-regular','シーズー','small','long','gentle handling','長毛のシーズーに使い、握力が弱くても持ちやすく重さも負担になりにくいと感じた体験。ピンの長さも合い、肌への強い刺激も感じにくかった。','public_buyer_review_summary','https://store.shopping.yahoo.co.jp/freebirdcorp/tr24se002.html'),
('showtech-maxipin-regular','ポメラニアン','small','long double','scared handling','ポメラニアンにスリッカーから替えて使うと、以前より簡単にブラッシングを受け入れるようになった体験。','public_buyer_review_summary','https://store.shopping.yahoo.co.jp/freebirdcorp/tr24se002.html'),

('kpro-groomer-pin-476','長毛犬',NULL,'long','deep-coat shedding','長毛犬に使い、被毛の奥まで自然に届き、以前のブラシより簡単に毛を取れると感じた体験。','public_buyer_review_summary','https://product.rakuten.co.jp/product/-/e9f7693965135b5c28ef387254365536/?l2-id=pdt_ranking'),
('kpro-groomer-pin-485','犬種不明・毎日使用',NULL,NULL,'durability handling','毎日使っていたところ3か月弱でゴム部が剥がれ、持ち手も短く、手が大きいと扱いにくいと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/216162_10005595/1.1/')
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
-- all products: 107
-- all reviews: 870
-- brush-pin: 37 products / 170 reviews
SELECT COUNT(*) AS brush_pin_product_count
FROM products WHERE category='brush-pin' AND active=1;

SELECT COUNT(*) AS brush_pin_review_count
FROM reviews r JOIN products p ON p.id=r.product_id
WHERE p.category='brush-pin' AND p.active=1;
