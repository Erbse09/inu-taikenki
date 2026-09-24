-- Phase 7: add verified Plush Puppy product codes and breed-specific public grooming experiences.
-- Additive/idempotent only. Never run seed.sql in production.
PRAGMA foreign_keys = ON;

-- Official Plush Puppy Japan product codes.
INSERT OR IGNORE INTO product_identifiers(namespace,identifier,product_id,evidence_url) VALUES
('manufacturer_model','plush-puppy:BPP','plush-puppy-pocket-pin','https://www.plushpuppyjapan.com/view/item/000000000176?category_page_id=all_items'),
('manufacturer_model','plush-puppy:UPIN','plush-puppy-ultimate-pin','https://plushpuppyjapan.com/view/item/000000000097?category_page_id=all_items'),
('manufacturer_model','plush-puppy:ULPIN','plush-puppy-ultimate-long-pin','https://www.plushpuppyjapan.com/view/item/000000000094');

-- Public article text is not stored. These are independently written summaries.
WITH new_reviews(product_id,dog_breed,dog_size,coat_type,needs,summary,source_type,source_url) AS (
VALUES
(
  'plush-puppy-ultimate-pin',
  'イングリッシュ・スプリンガー・スパニエル',
  'medium',
  'long',
  'feathering breakage gentle',
  'ショー前の乾燥でアルティメットピンブラシを使い、飾り毛を傷めにくいよう約4分の3まで乾かしてから仕上げ用ブラシへ切り替えるグルーミング事例。',
  'existing_article_summary',
  'https://plushpuppyamerica.com/english-springer-spaniel/'
),
(
  'plush-puppy-ultimate-pin',
  'ベルジアン・シェパード',
  'large',
  'double',
  'blow-dry coat-protection',
  'ダブルコートを乾かす際にアルティメットピンブラシを使い、被毛を上や前方向へ起こしながら7〜8割ほど乾かす手順。ピンの固定感がよく、被毛を傷めにくい道具として使っている体験。',
  'existing_article_summary',
  'https://plushpuppy.co.nz/blogs/grooming-articles/belgian-shepherd'
),
(
  'plush-puppy-ultimate-pin',
  'ビアデッド・コリー',
  NULL,
  'long',
  'blow-dry gentle',
  'ショー間の被毛ケアで、下側の長い被毛を冷風で乾かす初期段階にアルティメットピンブラシを使い、被毛に負担をかけにくく3/4程度まで乾かしてから別のブラシへ切り替える体験。',
  'existing_article_summary',
  'https://plushpuppy.co.nz/blogs/grooming-articles/bearded-collie'
),
(
  'plush-puppy-ultimate-pin',
  'アイリッシュ・ウルフハウンド',
  'large',
  'wire',
  'brushing coat-care',
  'リングサイドでグルーミングスプレーを約40倍に希釈し、アルティメットピンブラシと組み合わせて静電気を抑えながらブラッシングするグルーミング事例。',
  'existing_article_summary',
  'https://plushpuppyamerica.com/irish-wolfhound/'
),
(
  'plush-puppy-ultimate-long-pin',
  'アフガン・ハウンド',
  'large',
  'long',
  'blow-dry coat-protection',
  'ショー前の乾燥でアルティメットロングピンブラシを使い、長毛へのスリッカーは避け、ピンブラシで7〜8割ほどまでブローしてから別のブラシへ切り替える体験。',
  'existing_article_summary',
  'https://plushpuppyamerica.com/afghan-hound/'
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
-- all reviews: 876
-- brush-pin: 37 products / 176 reviews
-- brush-pin identifiers: 67
-- brush-pin listings: 40
SELECT COUNT(*) AS brush_pin_product_count
FROM products WHERE category='brush-pin' AND active=1;

SELECT COUNT(*) AS brush_pin_review_count
FROM reviews r JOIN products p ON p.id=r.product_id
WHERE p.category='brush-pin' AND p.active=1;
