-- Phase 3: continue brush-pin coverage with additional public buyer experiences
-- and two clearly identified products that are actively sold in the category.
-- Additive/idempotent only. Never run seed.sql in production.
PRAGMA foreign_keys = ON;

INSERT OR IGNORE INTO products(id,name,category,active) VALUES
('plush-puppy-blue-pin','Plush Puppy ブルー ピンブラシ','brush-pin',1),
('truelove-pin-tlk19131','Truelove エルゴノミックハンドル ピンブラシ TLK19131','brush-pin',1);

INSERT OR IGNORE INTO product_identifiers(namespace,identifier,product_id,evidence_url) VALUES
('manufacturer_model','plush-puppy:PINREG','plush-puppy-blue-pin','https://www.plushpuppyjapan.com/view/item/000000000061'),
('manufacturer_model','truelove:TLK19131','truelove-pin-tlk19131','https://item.rakuten.co.jp/truelove-pet/tlk19131p/');

INSERT OR IGNORE INTO product_listings(marketplace,external_id,product_id,source_url) VALUES
('rakuten','petech:000952','kpro-groomer-pin-474','https://item.rakuten.co.jp/petech/000952/'),
('rakuten','petech:020688','allsystems-white-soft-s','https://item.rakuten.co.jp/petech/020688/'),
('rakuten','petech:000973','allsystems-ultimate-oblong-m2','https://item.rakuten.co.jp/petech/000973/'),
('rakuten','petech:000974','allsystems-pin-l','https://item.rakuten.co.jp/petech/000974/'),
('rakuten','petech:000976','allsystems-white-soft-27','https://item.rakuten.co.jp/petech/000976/'),
('yahoo','cap:plush-puppy-pinreg','plush-puppy-blue-pin','https://store.shopping.yahoo.co.jp/cap/plush-puppy-pinreg.html'),
('rakuten','capcap:10001378','plush-puppy-blue-pin','https://item.rakuten.co.jp/capcap/10001378/'),
('rakuten','truelove-pet:tlk19131p','truelove-pin-tlk19131','https://item.rakuten.co.jp/truelove-pet/tlk19131p/'),
('rakuten','wansuku:tlk19131p','truelove-pin-tlk19131','https://item.rakuten.co.jp/wansuku/tlk19131p/');

WITH new_reviews(product_id,dog_breed,dog_size,coat_type,needs,summary,source_type,source_url) AS (
VALUES
('kpro-groomer-pin-474','イングリッシュスプリンガースパニエル','medium','long','gentle daily','長毛のイングリッシュスプリンガースパニエルに朝晩使い、肌当たりがやさしく毛へ通しやすいと感じ、同シリーズのブラシを継続して使っている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/216162_10005591/1.1/'),
('kpro-groomer-pin-474','犬種不明・同製品リピート',NULL,NULL,'repeat handling','以前と同じモデルへの買い替えで選び、扱いやすさを理由にリピートしている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/216162_10005591/1.1/'),

('allsystems-white-soft-s','犬種不明・リピート使用',NULL,NULL,'repeat relaxed','自宅で使うと犬がリラックスして気持ちよさそうにするため、同じブラシをプレゼント用にもリピートした体験。','public_buyer_review_summary','https://item.rakuten.co.jp/petech/020688/'),
('allsystems-white-soft-s','トイプードル','small','curly','scared gentle','撫でられることやブラッシングが苦手で以前のブラシを噛んでいたトイプードルが、このブラシへ替えると嫌がりにくくなった体験。','public_buyer_review_summary','https://item.rakuten.co.jp/petech/020688/'),

('allsystems-pin-l','シーズー','small','long','handling fatigue','シーズーに使い、持ち手が手にフィットして軽く、長時間のお手入れでも手首が疲れにくいと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/216162_10005611/1.1/'),
('allsystems-pin-l','長毛ダブルコート犬',NULL,'long double','long-use durability','子犬期から10年以上同じモデルを使い、長いダブルコートをスムーズに梳かせたため、ピンの劣化を機に同製品へ買い替えた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/216162_10005611/1.1/'),
('allsystems-pin-l','長毛犬',NULL,'long','tangle shine','長毛犬に使い、ブラッシング後の艶を感じ、軽い毛玉もほぐしやすかった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/216162_10005611/1.1/'),
('allsystems-pin-l','犬種不明・耐久性重視',NULL,NULL,'durability','使用中にピンが落ちやすいと感じ、耐久性の面ではリピートしないと判断した体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/216162_10005611/1.1/'),
('allsystems-pin-l','犬種不明・柔らかさ重視',NULL,NULL,'gentle handling','期待していたよりクッションが硬く、中央部のような柔らかさが全体にあれば使いやすいと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/216162_10005611/1.1/'),

('allsystems-ultimate-oblong-m2','シーズー・4.5kg','small','long','static tangle','4.5kgのフルコートのシーズーに使い、静電気が起きにくく持ちやすい一方、小さな毛玉はコームで仕上げ直している体験。','public_buyer_review_summary','https://item.rakuten.co.jp/petech/000973/'),
('allsystems-ultimate-oblong-m2','犬種不明・耐久性重視',NULL,NULL,'gentle durability','肌当たりはやさしく感じたものの、使い始めて早い段階でピンが開いてきたため耐久性を気にした体験。','public_buyer_review_summary','https://item.rakuten.co.jp/petech/000973/'),

('allsystems-white-soft-27','ボロニーズ','small','long curly','tangle fluffy breakage','もつれやすいボロニーズに使い、以前のブラシより毛を抜きすぎず、さらさら・ふわふわに整えやすいと感じた体験。','public_buyer_review_summary','https://item.rakuten.co.jp/petech/000976/'),
('allsystems-white-soft-27','犬種不明・ブラッシング苦手',NULL,NULL,'scared relaxed','ブラッシングが苦手な犬が、使用中に寝転がって気持ちよさそうに受け入れた体験。','public_buyer_review_summary','https://item.rakuten.co.jp/petech/000976/'),
('allsystems-white-soft-27','犬種不明・ブラッシング嫌い',NULL,NULL,'scared relaxed','普段はブラッシングを嫌がる犬が、このブラシを見せると自分から寄って来て落ち着いて受け入れた体験。','public_buyer_review_summary','https://item.rakuten.co.jp/petech/000976/'),

('sharr-2in1-pin-brush','犬種不明・ブラシ嫌い',NULL,NULL,'scared relaxed','ブラッシングが大嫌いな犬が、このブラシでは気持ちよさそうに寝転がってケアを受け入れた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/370173_10001542/1.1/'),
('sharr-2in1-pin-brush','犬種不明・ブラシを噛む',NULL,NULL,'scared handling','ブラシを見ると噛もうとする犬でも、トリミング台の上ではブラッシングを受け入れたため、少しずつ慣らしている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/370173_10001542/1.1/'),
('sharr-2in1-pin-brush','ゴールデンレトリバー','large','long double','relaxed','ゴールデンレトリバーに使い、嫌がらず気持ちよさそうにブラッシングを受け入れた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/370173_10001542/1.1/'),

('plush-puppy-blue-pin','マルチーズ','small','long','fluffy relaxed','マルチーズに使うと被毛がふわふわに整い、犬自身もブラシを見ると寄って来るほど受け入れやすかった体験。','public_buyer_review_summary','https://store.shopping.yahoo.co.jp/cap/plush-puppy-pinreg.html'),
('plush-puppy-blue-pin','犬種不明・肌当たり重視',NULL,NULL,'gentle handling','軽くて持ちやすく、クッションの動きで肌へやさしく当てやすく、毛通りも滑らかだと感じた体験。','public_buyer_review_summary','https://store.shopping.yahoo.co.jp/cap/plush-puppy-pinreg.html'),
('plush-puppy-blue-pin','犬種不明・仕上がり重視',NULL,NULL,'fluffy gentle','扱いやすく、犬も気持ちよさそうに受け入れ、ブラッシング後はふわっと仕上がった体験。','public_buyer_review_summary','https://store.shopping.yahoo.co.jp/cap/plush-puppy-pinreg.html'),
('plush-puppy-blue-pin','犬種不明・同メーカー買い替え',NULL,NULL,'repeat handling','古くなった同メーカーのピンブラシから買い替え、以前のモデルよりブラッシング時の使用感が良くなったと感じた体験。','public_buyer_review_summary','https://store.shopping.yahoo.co.jp/cap/plush-puppy-pinreg.html'),
('plush-puppy-blue-pin','犬種不明・トリマー推奨',NULL,NULL,'pro-recommend handling','トリマーが使用していることをきっかけに選び、クッション性があり以前のブラシより使いやすいと感じた体験。','public_buyer_review_summary','https://store.shopping.yahoo.co.jp/cap/plush-puppy-pinreg.html'),
('plush-puppy-blue-pin','シェルティ','medium','long double','scared handling','ブラッシングを嫌がるシェルティでも、以前のブラシより嫌がりにくく、お手入れがしやすくなった体験。','public_buyer_review_summary','https://store.shopping.yahoo.co.jp/cap/plush-puppy-pinreg.html'),

('truelove-pin-tlk19131','犬種不明・使いやすさ重視',NULL,NULL,'handling','見た目より軽く手に収まりやすく、使用感は良かった一方、竹製の本体に目立つ傷があり外観面は気になった体験。','public_buyer_review_summary','https://item.rakuten.co.jp/truelove-pet/tlk19131p/'),
('truelove-pin-tlk19131','オールドイングリッシュシープドッグ','large','long double','gentle relaxed','オールドイングリッシュシープドッグに使い、丸いピン先で安心してブラッシングでき、犬も落ち着いて受け入れた体験。','public_buyer_review_summary','https://item.rakuten.co.jp/wansuku/tlk19131p/'),
('truelove-pin-tlk19131','犬種不明・肌当たり重視',NULL,NULL,'gentle handling','程よいクッション性で皮膚へやさしく当てやすく、持ちやすい形状だと感じた体験。','public_buyer_review_summary','https://item.rakuten.co.jp/wansuku/tlk19131p/')
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
-- brush-pin: 31 products / 141 reviews
SELECT COUNT(*) AS brush_pin_product_count
FROM products WHERE category='brush-pin' AND active=1;

SELECT COUNT(*) AS brush_pin_review_count
FROM reviews r JOIN products p ON p.id=r.product_id
WHERE p.category='brush-pin' AND p.active=1;
