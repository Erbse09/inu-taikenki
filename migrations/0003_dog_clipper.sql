-- Dog clipper article data
PRAGMA foreign_keys = ON;

INSERT OR IGNORE INTO products (id, name, category, asin, affiliate_url, active) VALUES
('panasonic-er807pp', 'Panasonic ER807PP-A', 'dog-clipper', NULL, NULL, 1),
('pateker-p6', 'Pateker P-6 / P6-GD', 'dog-clipper', 'B0D8F5PVKP', 'https://www.amazon.co.jp/dp/B0D8F5PVKP?tag=100things-22', 1),
('pateker-lg4', 'Pateker LG4 ミニバリカン', 'dog-clipper', NULL, NULL, 1),
('speedik-peace', 'SPEEDIK PEACE', 'dog-clipper', NULL, NULL, 1);

WITH new_reviews(product_id,dog_breed,dog_size,coat_type,needs,summary,source_type,source_url) AS (
VALUES
('panasonic-er807pp','12歳トイプードル','small','long curly','senior beginner quiet fullbody','足を痛めてサロンに行けず自宅カットへ。初めてでも体は嫌がりにくく、音が小さくスムーズに刈れたという体験。','existing_article_summary','/dog-clipper.html'),
('panasonic-er807pp','2頭の犬',NULL,NULL,'quiet beginner','軽く手になじみ、作動音が静かで2頭とも嫌がりにくかったという体験。','existing_article_summary','/dog-clipper.html'),
('panasonic-er807pp','ミニチュアダックス','small','long','fullbody beginner','自宅で全身を短く整え、犬も強く怖がらずカットできたという例。','existing_article_summary','/dog-clipper.html'),
('panasonic-er807pp','超小型犬','small',NULL,'attachment fullbody','9mmアタッチメントで短くしすぎず整えられたという体験。','existing_article_summary','/dog-clipper.html'),
('pateker-p6','ミニチュアダックス','small','long','quiet fullbody cordless','音が比較的静かで切れ味にも満足したという全身ケアの体験。','existing_article_summary','/dog-clipper.html'),
('pateker-p6','トイプードル','small','long curly','beginner attachment fullbody','アタッチメントを付けた方が好みの長さに整えやすかったというセルフトリミング体験。','existing_article_summary','/dog-clipper.html'),
('pateker-lg4','毛量の多いトイプードル','small','long curly','partial paw','肛門周りをカットできた一方、刃に毛が絡むため途中で取り除きながら進めたという体験。','existing_article_summary','/dog-clipper.html'),
('pateker-lg4','ビビりな犬',NULL,NULL,'scared beginner partial','犬は機械を警戒したが、飼い主は初めてでも扱いやすいと感じたという例。','existing_article_summary','/dog-clipper.html'),
('speedik-peace','シュナウザー多頭','medium','wire','multi fullbody cordless','耳・顔・足はコードレス、ボディはコード接続で使い分け、ボディではよりパワーを感じたという体験。','existing_article_summary','/dog-clipper.html'),
('speedik-peace','犬種不明',NULL,NULL,'multi sound weight','コードレスの便利さは評価しつつ、本体の大きさ・重さと高めの作動音が気になったという混合評価。','existing_article_summary','/dog-clipper.html')
)
INSERT INTO reviews(product_id,dog_breed,dog_size,coat_type,needs,summary,source_type,source_url)
SELECT n.product_id,n.dog_breed,n.dog_size,n.coat_type,n.needs,n.summary,n.source_type,n.source_url
FROM new_reviews n
WHERE NOT EXISTS(
 SELECT 1 FROM reviews r
 WHERE r.product_id=n.product_id
 AND COALESCE(r.dog_breed,'')=COALESCE(n.dog_breed,'')
 AND r.summary=n.summary
);

SELECT
 (SELECT COUNT(*) FROM products WHERE category='dog-clipper') AS product_count,
 (SELECT COUNT(*) FROM reviews r JOIN products p ON p.id=r.product_id WHERE p.category='dog-clipper') AS review_count;
