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
  '耳や脚の飾り毛では、スリッカーによる切れ毛を避けるため、21mmピンのアルティメットピンブラシで根元から毛先まで整える使い方をしている体験。',
  'existing_article_summary',
  'https://www.thedoggroomingstore.com.au/blogs/blog/english-springer-spaniel-grooming'
),
(
  'plush-puppy-ultimate-pin',
  'ベルジアン・シェパード',
  'large',
  'double',
  'blow-dry coat-protection',
  'ダブルコートを乾かす際にアルティメットピンブラシを使い、被毛を上や前方向へ起こしながら7〜8割ほど乾かす手順。ピンの固定感がよく、被毛を傷めにくい道具として使っている体験。',
  'existing_article_summary',
  'https://showmanagerservice.blob.core.windows.net/public-files/events/42877/BelgianShepherdDogClubofNSWInc_25-Apr-2025_SP_42877_Catalogue_d7d08516-9e89-4413-9f91-86f3f0d3a917.pdf'
),
(
  'plush-puppy-ultimate-pin',
  'ビアデッド・コリー',
  NULL,
  'long',
  'blow-dry gentle',
  'ショー間の被毛ケアで、下側の長い被毛を冷風で乾かす初期段階にアルティメットピンブラシを使い、被毛に負担をかけにくく3/4程度まで乾かしてから別のブラシへ切り替える体験。',
  'existing_article_summary',
  'https://plushpuppy.co.uk/wp-content/uploads/2022/03/Breed-Grooming-Article_Bearded-Collie.pdf'
),
(
  'plush-puppy-ultimate-pin',
  'アイリッシュ・ウルフハウンド',
  'large',
  'wire',
  'brushing coat-care',
  '希釈したグルーミング剤を被毛へ行き渡らせたあと、アルティメットピンブラシを使ってブラッシングする手順として取り入れている体験。',
  'existing_article_summary',
  'https://plushpuppy.co.uk/wp-content/uploads/2022/04/Breed-Grooming-Article_Irish-Wolfhound-1.pdf'
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
