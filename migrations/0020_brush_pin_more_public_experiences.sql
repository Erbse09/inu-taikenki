-- Phase 2 of the first brush-pin expansion batch.
-- Additive/idempotent only. Never run seed.sql in production.
PRAGMA foreign_keys = ON;

-- Add newly verified identifiers/listings. No product rows are duplicated across marketplaces.
INSERT OR IGNORE INTO product_identifiers(namespace,identifier,product_id,evidence_url) VALUES
('gtin','4964658242006','dog-groomer-pin-200','https://item.rakuten.co.jp/petech/000960/'),
('gtin','4964658242044','dog-groomer-pin-204','https://store.shopping.yahoo.co.jp/aecom/4964658242044.html'),
('gtin','4964658245007','dog-groomer-pin-500','https://store.shopping.yahoo.co.jp/petech/000965.html'),
('gtin','4560124957001','kpro-groomer-pin-474','https://shopping.yahoo.co.jp/products/z44mua1ka9'),
('gtin','4560124957087','kpro-groomer-pin-475','https://store.shopping.yahoo.co.jp/petech/000953.html'),
('gtin','4560124957490','kpro-groomer-pin-485','https://store.shopping.yahoo.co.jp/petech/000956.html'),
('gtin','4560124957506','kpro-groomer-pin-486','https://store.shopping.yahoo.co.jp/petech/000957.html'),
('gtin','4560124957513','kpro-groomer-pin-487','https://store.shopping.yahoo.co.jp/petech/021819.html');

INSERT OR IGNORE INTO product_listings(marketplace,external_id,product_id,source_url) VALUES
('rakuten','petech:000960','dog-groomer-pin-200','https://item.rakuten.co.jp/petech/000960/'),
('yahoo','aecom:4964658242044','dog-groomer-pin-204','https://store.shopping.yahoo.co.jp/aecom/4964658242044.html'),
('yahoo','petech:000965','dog-groomer-pin-500','https://store.shopping.yahoo.co.jp/petech/000965.html'),
('yahoo','petech:000953','kpro-groomer-pin-475','https://store.shopping.yahoo.co.jp/petech/000953.html'),
('yahoo','petech:000956','kpro-groomer-pin-485','https://store.shopping.yahoo.co.jp/petech/000956.html'),
('yahoo','petech:000957','kpro-groomer-pin-486','https://store.shopping.yahoo.co.jp/petech/000957.html'),
('yahoo','petech:021819','kpro-groomer-pin-487','https://store.shopping.yahoo.co.jp/petech/021819.html'),
('rakuten','freebird:tr24se016','showtech-ultrapro-l','https://item.rakuten.co.jp/freebird/tr24se016/');

WITH new_reviews(product_id,dog_breed,dog_size,coat_type,needs,summary,source_type,source_url) AS (
VALUES
('dog-groomer-pin-200','スタンダードプードル＋ゴールデンレトリバー','large','long','tangle durability','30年以上同じブランドを使い、スタンダードプードルとゴールデンに使用。軽い毛玉なら何度か梳かすうちにほぐれやすく、約1年でクッションゴムの劣化を買い替え目安にしている体験。','public_buyer_review_summary','https://item.rakuten.co.jp/petech/000960/'),
('dog-groomer-pin-200','代々の愛犬',NULL,NULL,'long-use gentle','代々の愛犬で同メーカーを使い続け、他の安価なブラシも試したが、毛通り・手入れのしやすさ・犬への負担の少なさからこのブラシへ戻っている体験。','public_buyer_review_summary','https://item.rakuten.co.jp/petech/000960/'),
('dog-groomer-pin-200','シベリアンハスキー','large','double','shedding undercoat','シベリアンハスキーの換毛期に使い、アンダーコートが大量に取れて役立った体験。毛をブラシから外す際にピンで指を傷つけないよう注意している。','public_buyer_review_summary','https://item.rakuten.co.jp/petech/000960/'),
('dog-groomer-pin-204','トイプードル','small','curly','tangle gentle','カールが強めのトイプードルに使い、引っかかりにくく犬も痛がらず、扱いやすいと感じた体験。','public_buyer_review_summary','https://item.rakuten.co.jp/petech/000964/'),
('dog-groomer-pin-204','トイプードル','small','curly','size travel','トイプードル用に大きすぎない角型を選び、スリッカーより梳かしやすく、持ち歩きもしやすそうと感じた体験。','public_buyer_review_summary','https://item.rakuten.co.jp/petech/000964/'),
('dog-groomer-pin-204','小型犬・約3kg','small',NULL,'tangle size','約3kgの犬に使い、サイズがちょうどよく、少し絡んだ毛にもスリッカーより入りやすいと感じた体験。','public_buyer_review_summary','https://item.rakuten.co.jp/petech/000964/'),
('dog-groomer-pin-500','犬種不明・ブラッシング重視',NULL,NULL,'handling','これまで使ったブラシの中でも上位に感じ、ピン数が多く、扱いやすくしっかりブラッシングできた体験。','public_buyer_review_summary','https://store.shopping.yahoo.co.jp/petech/000965.html'),
('showtech-ultrapro-l','長毛犬',NULL,'long','handling long-coat','軽量でピンの長さとしなり具合がちょうどよく、長毛犬に使いやすいと感じた体験。','public_buyer_review_summary','https://item.rakuten.co.jp/freebird/tr24se016/'),
('showtech-ultrapro-l','ダブルコート犬',NULL,'double','durability','スリッカーでは物足りず導入し、ダブルコート犬に使って耐久性にも問題を感じず継続している体験。','public_buyer_review_summary','https://item.rakuten.co.jp/freebird/tr24se016/'),
('allsystems-white-soft-27','ビションフリーゼ','small','curly','scared tangle gentle','以前のブラシから替えると当たりがやさしいのか嫌がりにくくなり、使い始めてから毛玉も減ったと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/product/j/4936479007201/compare.html'),
('allsystems-white-soft-27','犬種不明・サロン推奨',NULL,NULL,'pro-recommend handling','サロン関係者に勧められて選び、以前の安価なピンブラシと比べて非常に使いやすいと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/product/j/4936479007201/compare.html'),
('sharr-2in1-pin-brush','ビションフリーゼ','small','curly','fluffy','柔らかい毛質のビションに使い、被毛がふわっと立ち上がる仕上がりを感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/370173_10001542/1.1/'),
('sharr-2in1-pin-brush','犬種不明・他ブラシ比較',NULL,NULL,'scared','他の犬のようにうっとりする反応まではなかったものの、他のブラシより嫌がりにくいと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/370173_10001542/1.1/'),
('kpro-groomer-pin-486','犬種不明・リピート使用',NULL,NULL,'repeat durability','以前は別ブランドでピンが沈み込むことに悩んでいたが、このモデルへ替えて気に入り、数年後に2本目を購入している体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/216162_10005596/1.1/'),
('kpro-groomer-pin-486','トイプードルなど6kg未満の犬','small','curly','relaxed size','トイプードルなど6kg未満の犬に使い、ブラッシング中は気持ちよさそう。ブラシ自体はやや大きく感じるが握りやすいという体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/216162_10005596/1.1/')
)
INSERT INTO reviews(product_id,dog_breed,dog_size,coat_type,needs,summary,source_type,source_url)
SELECT n.product_id,n.dog_breed,n.dog_size,n.coat_type,n.needs,n.summary,n.source_type,n.source_url
FROM new_reviews n
WHERE NOT EXISTS (
  SELECT 1 FROM reviews r
  WHERE r.product_id=n.product_id
    AND r.summary=n.summary
);

-- Verification after 0019 + 0020 from the original baseline: 29 products / 115 reviews.
SELECT COUNT(*) AS brush_pin_product_count
FROM products WHERE category='brush-pin' AND active=1;

SELECT COUNT(*) AS brush_pin_review_count
FROM reviews r JOIN products p ON p.id=r.product_id
WHERE p.category='brush-pin' AND p.active=1;
