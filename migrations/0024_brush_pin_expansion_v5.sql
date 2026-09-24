-- Phase 6: close low-coverage metadata gaps and add a verified Supreme usage experience.
-- Additive/idempotent only. Never run seed.sql in production.
PRAGMA foreign_keys = ON;

-- K-pro No.475 and No.487 already have their GTINs and Yahoo listings from 0020.
-- Add only the newly verified Rakuten listings.
INSERT OR IGNORE INTO product_listings(marketplace,external_id,product_id,source_url) VALUES
('rakuten','petech:000953','kpro-groomer-pin-475','https://item.rakuten.co.jp/petech/000953/'),
('rakuten','petech:021819','kpro-groomer-pin-487','https://item.rakuten.co.jp/petech/021819/');

-- Public article text is not stored. This is an independently written summary.
WITH new_reviews(product_id,dog_breed,dog_size,coat_type,needs,summary,source_type,source_url) AS (
VALUES
(
  'supreme-stainless-pin',
  'ビションフリーゼ',
  NULL,
  NULL,
  'tangle routine',
  '定期的なお手入れでサプリームのピンブラシを最初の全体ブラッシングに使い、その後にもつれがある部分をコームとスリッカーでやさしく仕上げている体験。',
  'existing_article_summary',
  'https://ameblo.jp/lanlanleaf/entry-12388261501.html'
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
-- all products: 107
-- all reviews: 871
-- brush-pin: 37 products / 171 reviews
-- brush-pin identifiers: 64
-- brush-pin listings: 40
SELECT COUNT(*) AS brush_pin_product_count
FROM products WHERE category='brush-pin' AND active=1;

SELECT COUNT(*) AS brush_pin_review_count
FROM reviews r JOIN products p ON p.id=r.product_id
WHERE p.category='brush-pin' AND p.active=1;
