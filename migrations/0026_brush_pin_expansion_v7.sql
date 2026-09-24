-- Phase 8: expand K-pro No.486 public buyer experiences and strengthen Pocket Pin identity.
-- Additive/idempotent only. Never run seed.sql in production.
PRAGMA foreign_keys = ON;

-- Official Plush Puppy Pocket Pin EAN/GTIN.
INSERT OR IGNORE INTO product_identifiers(namespace,identifier,product_id,evidence_url) VALUES
(
  'gtin',
  '9335030008018',
  'plush-puppy-pocket-pin',
  'https://plushpuppyamerica.com/product/blue-pin-brush-regular-round-tipped-pin/'
);

-- Public review text is not stored. These are independently written summaries.
WITH new_reviews(product_id,dog_breed,dog_size,coat_type,needs,summary,source_type,source_url) AS (
VALUES
(
  'kpro-groomer-pin-486',
  '犬種不明',
  NULL,
  NULL,
  'handling odor',
  '握りやすく梳かしやすいと感じた一方、開封時のにおいがかなり強く、においが落ち着くまで使用を控えた体験。',
  'public_buyer_review_summary',
  'https://review.rakuten.co.jp/item/1/216162_10005596/1.1/'
),
(
  'kpro-groomer-pin-486',
  'ビションフリーゼ',
  'small',
  'curly',
  'scared gentle',
  'ブラッシングがあまり得意ではないビションに使い、肌当たりが合ったのか気持ちよさそうに受け入れた体験。',
  'public_buyer_review_summary',
  'https://review.rakuten.co.jp/item/1/216162_10005596/1.1/'
),
(
  'kpro-groomer-pin-486',
  '小型犬5頭',
  'small',
  NULL,
  'repeat durability handling',
  '小型犬5頭の家庭で使い、約4年使えた後に同じブラシを再購入。手にフィットし、重さも扱いやすいと感じた体験。',
  'public_buyer_review_summary',
  'https://review.rakuten.co.jp/item/1/216162_10005596/1.1/'
),
(
  'kpro-groomer-pin-486',
  'ビションフリーゼ',
  'small',
  'curly',
  'fluffy tangle scared size',
  'ビションに使い、毛玉をほぐしながらふわっとした仕上がりになり、犬も嫌がりにくかった体験。体には少し大きく感じ、小さめブラシも併用している。',
  'public_buyer_review_summary',
  'https://review.rakuten.co.jp/item/1/216162_10005596/1.1/'
),
(
  'kpro-groomer-pin-486',
  'トイプードル2頭',
  'small',
  'curly',
  'gentle relaxed daily',
  '柔らかいクッションを活かして力を入れすぎずに使うと、トイプードル2頭が気持ちよさそうに受け入れ、日常の軽いお手入れに使いやすかった体験。',
  'public_buyer_review_summary',
  'https://review.rakuten.co.jp/item/1/216162_10005596/1.1/'
),
(
  'kpro-groomer-pin-486',
  '犬種不明',
  NULL,
  NULL,
  'handling long-pin value',
  '以前のピンブラシと比べて長めのピンと扱いやすさを高く評価し、価格に見合う使い心地だと感じた体験。',
  'public_buyer_review_summary',
  'https://review.rakuten.co.jp/item/1/216162_10005596/1.1/'
),
(
  'kpro-groomer-pin-486',
  'シーズー',
  'small',
  'long',
  'handling weight maintenance',
  'シーズー用に木製柄の旧ブラシから買い替え。適度な重さがあり使いやすい一方、黒いクッションは汚れが目立ちやすいと感じた体験。',
  'public_buyer_review_summary',
  'https://review.rakuten.co.jp/item/1/216162_10005596/1.1/'
),
(
  'kpro-groomer-pin-486',
  '長毛犬',
  NULL,
  'long',
  'scared fatigue gentle',
  '長毛犬にスリッカーから切り替えて使い、手首への負担が軽くなり、犬も以前より嫌がらずブラッシングを受け入れた体験。',
  'public_buyer_review_summary',
  'https://review.rakuten.co.jp/item/1/216162_10005596/1.1/'
),
(
  'kpro-groomer-pin-486',
  '犬種不明',
  NULL,
  NULL,
  'scared relaxed',
  'スリッカーを嫌がる犬でも、このピンブラシでは比較的おとなしくブラッシングを受け入れ、別の犬にも同じように使いやすかった体験。',
  'public_buyer_review_summary',
  'https://review.rakuten.co.jp/item/1/216162_10005596/1.1/'
),
(
  'kpro-groomer-pin-486',
  'トイプードル',
  'small',
  'curly',
  'scared fluffy value',
  'ブラッシングを嫌がるトイプードルに使い、柔らかさのおかげか受け入れやすく、被毛もふわっと仕上がった体験。価格はやや高く感じている。',
  'public_buyer_review_summary',
  'https://review.rakuten.co.jp/item/1/216162_10005596/1.1/'
),
(
  'kpro-groomer-pin-486',
  'ペキニーズ',
  'small',
  'long',
  'tangle breakage gentle',
  '長毛のペキニーズに使い、もつれをほぐしやすく、表面の毛も切れにくく感じ、引っ張られる痛みも少なそうだった体験。',
  'public_buyer_review_summary',
  'https://review.rakuten.co.jp/item/1/216162_10005596/1.1/'
),
(
  'kpro-groomer-pin-486',
  'パピヨン',
  'small',
  'long',
  'gentle cushion',
  'パピヨン用に買い替えて使い、クッションが非常に柔らかく、被毛のお手入れに使いやすそうだと感じた体験。',
  'public_buyer_review_summary',
  'https://review.rakuten.co.jp/item/1/216162_10005596/1.1/'
),
(
  'kpro-groomer-pin-486',
  '犬種不明',
  NULL,
  NULL,
  'gentle size odor quality',
  '柔らかいクッションでブラッシング時の負担は抑えやすそうと感じた一方、ブラシ本体はやや大きめで、ゴムの強いにおいと柄の小傷が気になった体験。',
  'public_buyer_review_summary',
  'https://review.rakuten.co.jp/item/1/216162_10005596/1.1/'
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
-- all reviews: 889
-- brush-pin: 37 products / 189 reviews
-- brush-pin identifiers: 68
-- brush-pin listings: 40
SELECT COUNT(*) AS brush_pin_product_count
FROM products WHERE category='brush-pin' AND active=1;

SELECT COUNT(*) AS brush_pin_review_count
FROM reviews r JOIN products p ON p.id=r.product_id
WHERE p.category='brush-pin' AND p.active=1;
