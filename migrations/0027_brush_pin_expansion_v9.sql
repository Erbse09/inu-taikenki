-- Phase 9: add Petio Porta pin brush S/M with verified identifiers, listings, and public experiences.
-- Additive/idempotent only. Never run seed.sql in production.
PRAGMA foreign_keys = ON;

INSERT OR IGNORE INTO products(id,name,category,active) VALUES
('petio-porta-pin-s','Petio Porta ポルタ ピンブラシ S','brush-pin',1),
('petio-porta-pin-m','Petio Porta ポルタ ピンブラシ M','brush-pin',1);

INSERT OR IGNORE INTO product_identifiers(namespace,identifier,product_id,evidence_url) VALUES
('manufacturer_model','petio:W25985','petio-porta-pin-s','https://www.petio.com/c/dog/dog-care/4903588259852'),
('gtin','4903588259852','petio-porta-pin-s','https://www.petio.com/c/dog/dog-care/4903588259852'),
('manufacturer_model','petio:W25986','petio-porta-pin-m','https://www.petio.com/c/dog/dog-care/4903588259869'),
('gtin','4903588259869','petio-porta-pin-m','https://www.petio.com/c/dog/dog-care/4903588259869');

INSERT OR IGNORE INTO product_listings(marketplace,external_id,product_id,source_url) VALUES
('rakuten','petio-online-shop:4903588259852','petio-porta-pin-s','https://item.rakuten.co.jp/petio-online-shop/4903588259852/'),
('yahoo','chanet:271003','petio-porta-pin-m','https://store.shopping.yahoo.co.jp/chanet/271003.html');

-- Public review text is not stored. These are independently written summaries.
WITH new_reviews(product_id,dog_breed,dog_size,coat_type,needs,summary,source_type,source_url) AS (
VALUES
(
  'petio-porta-pin-s',
  'トイプードル',
  'small',
  'curly',
  'massage gentle',
  'トイプードルの男の子に使い、毛をほぐしながらマッサージもできる点を使いやすいと感じた体験。',
  'public_buyer_review_summary',
  'https://www.min-petkenko.com/goods_petio_198.html'
),
(
  'petio-porta-pin-s',
  '犬種不明',
  NULL,
  NULL,
  'handling time-saving daily',
  '毎日のブラッシングに使いやすく、以前よりお手入れ時間を短くしやすくなったと感じた体験。',
  'public_buyer_review_summary',
  'https://shopping.yahoo.co.jp/product/j/4903588259852/compare.html'
),
(
  'petio-porta-pin-s',
  '犬種不明',
  NULL,
  NULL,
  'gentle relaxed',
  '丸みのあるピン先が皮膚に当たりにくく感じ、犬も嫌がらず気持ちよさそうにブラッシングを受け入れた体験。',
  'public_buyer_review_summary',
  'https://item.rakuten.co.jp/petio-online-shop/4903588259852/'
),
(
  'petio-porta-pin-m',
  '犬種不明',
  NULL,
  NULL,
  'sensitive-skin gentle scared',
  '普通のブラシでは痛がっていた犬に使い、ピン先の当たりがやさしく感じられ、痛がらずにしっかりブラッシングできるようになった体験。',
  'public_buyer_review_summary',
  'https://store.shopping.yahoo.co.jp/chanet/271003.html'
),
(
  'petio-porta-pin-m',
  '犬種不明',
  NULL,
  NULL,
  'repeat durability handling scared',
  '以前使って扱いやすかったため再購入し、約2年使えた耐久性とブラッシングのしやすさ、犬が嫌がりにくい点を評価した体験。',
  'public_buyer_review_summary',
  'https://store.shopping.yahoo.co.jp/chanet/271003.html'
),
(
  'petio-porta-pin-m',
  '犬種不明',
  NULL,
  NULL,
  'hair-removal mixed',
  '抜け毛は取れて実用上は使えるものの、その後もっと合うブラシを見つけたため使用頻度が下がったという混合評価の体験。',
  'public_buyer_review_summary',
  'https://store.shopping.yahoo.co.jp/chanet/271003.html'
)
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
-- all reviews: 895
-- brush-pin: 39 products / 195 reviews
-- brush-pin identifiers: 72
-- brush-pin listings: 42
SELECT COUNT(*) AS brush_pin_product_count
FROM products WHERE category='brush-pin' AND active=1;

SELECT COUNT(*) AS brush_pin_review_count
FROM reviews r JOIN products p ON p.id=r.product_id
WHERE p.category='brush-pin' AND p.active=1;
