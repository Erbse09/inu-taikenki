PRAGMA foreign_keys = ON;
INSERT OR IGNORE INTO products (id,name,category,asin,affiliate_url,active) VALUES
('apdc-teatree','A.P.D.C. ティーツリーシャンプー','dog-shampoo',NULL,'https://www.amazon.co.jp/s?k=A.P.D.C.+%E3%83%86%E3%82%A3%E3%83%BC%E3%83%84%E3%83%AA%E3%83%BC+%E3%82%B7%E3%83%A3%E3%83%B3%E3%83%97%E3%83%BC&tag=100things-22',1),
('zoic-n-short','ZOIC N ショート シャンプー','dog-shampoo',NULL,'https://www.amazon.co.jp/s?k=ZOIC+N+%E3%82%B7%E3%83%A7%E3%83%BC%E3%83%88+%E3%82%B7%E3%83%A3%E3%83%B3%E3%83%97%E3%83%BC&tag=100things-22',1),
('zoic-n-long','ZOIC N ロング シャンプー','dog-shampoo',NULL,'https://www.amazon.co.jp/s?k=ZOIC+N+%E3%83%AD%E3%83%B3%E3%82%B0+%E3%82%B7%E3%83%A3%E3%83%B3%E3%83%97%E3%83%BC&tag=100things-22',1),
('shizenryu-all','自然流 全犬種用トリートメントシャンプー','dog-shampoo',NULL,'https://www.amazon.co.jp/s?k=%E8%87%AA%E7%84%B6%E6%B5%81+%E5%85%A8%E7%8A%AC%E7%A8%AE%E7%94%A8+%E3%82%B7%E3%83%A3%E3%83%B3%E3%83%97%E3%83%BC&tag=100things-22',1);

WITH new_reviews(product_id,dog_breed,dog_size,coat_type,needs,summary,source_type,source_url) AS (
VALUES
('apdc-teatree','ヨークシャーテリア','small','long','scent smooth','天然パーマ気味の長毛で、さらさら感と香りを気に入ったという体験。','existing_article_summary','/dog-shampoo.html'),
('apdc-teatree','ゴールデンレトリバー','large','long','scent volume','強すぎない香りが好みで長期使用。大型犬のためシャンプーの減りが早いという体験。','existing_article_summary','/dog-shampoo.html'),
('apdc-teatree','ミニピン＋イタグレ','small','short','foam scent','泡立ちがよく、洗い終わりの香りも好みで継続使用している体験。','existing_article_summary','/dog-shampoo.html'),
('zoic-n-short','9歳柴犬','medium','double short','senior foam scent','泡立ちと香りを気に入り、他製品を試した後も継続している体験。','existing_article_summary','/dog-shampoo.html'),
('zoic-n-short','プードル','small','curly','long-use clean','汚れ落ちと香りの残り方を評価し、長年自宅シャンプーで使っている体験。','existing_article_summary','/dog-shampoo.html'),
('zoic-n-short','10歳フレンチブルドッグ','medium','short','senior foam fluffy','泡立ちがよく、優しい香りとふさっとした仕上がりを気に入った体験。','existing_article_summary','/dog-shampoo.html'),
('zoic-n-long','ゴールデンレトリバー2頭','large','long','multi rinse smooth','4Lを使用し、洗っている時の手通りと泡切れを評価した大型犬2頭の体験。','existing_article_summary','/dog-shampoo.html'),
('zoic-n-long','長毛犬',NULL,'long','smooth rinse','泡立ちがよく、洗い流した直後から手触りの変化を感じたという体験。','existing_article_summary','/dog-shampoo.html'),
('shizenryu-all','もうすぐ18歳の犬',NULL,NULL,'senior long-use','子犬期から長年使い続け、シニアになっても毛艶を保てていると感じている体験。','existing_article_summary','/dog-shampoo.html'),
('shizenryu-all','約30kgの犬','large',NULL,'large dilute','大型犬を屋外で洗う家庭で使用し、以前の製品よりフケが減ったと感じた体験。','existing_article_summary','/dog-shampoo.html')
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
 (SELECT COUNT(*) FROM products WHERE category='dog-shampoo') AS product_count,
 (SELECT COUNT(*) FROM reviews r JOIN products p ON p.id=r.product_id WHERE p.category='dog-shampoo') AS review_count;
