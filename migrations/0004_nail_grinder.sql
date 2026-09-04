PRAGMA foreign_keys = ON;

INSERT OR IGNORE INTO products (id,name,category,asin,affiliate_url,active) VALUES
('casfuy-6speed','Casfuy 6スピード 犬用ネイルグラインダー','nail-grinder',NULL,'https://www.amazon.co.jp/s?k=Casfuy+6%E3%82%B9%E3%83%94%E3%83%BC%E3%83%89+%E7%8A%AC+%E7%88%AA%E3%82%84%E3%81%99%E3%82%8A&tag=100things-22',1),
('casfuy-led2','Casfuy LED 2スピード','nail-grinder',NULL,'https://www.amazon.co.jp/s?k=Casfuy+LED+%E7%8A%AC+%E7%88%AA%E3%82%84%E3%81%99%E3%82%8A&tag=100things-22',1),
('petio-selftrimmer-nail','Petio Self Trimmer スモール ネイルケア 2WAY','nail-grinder',NULL,'https://www.amazon.co.jp/s?k=Petio+Self+Trimmer+%E3%83%8D%E3%82%A4%E3%83%AB%E3%82%B1%E3%82%A2+2WAY&tag=100things-22',1),
('dremel-7350-pet','Dremel 7350-PET','nail-grinder',NULL,'https://www.amazon.co.jp/s?k=Dremel+7350-PET&tag=100things-22',1);

WITH new_reviews(product_id,dog_breed,dog_size,coat_type,needs,summary,source_type,source_url) AS (
VALUES
('casfuy-6speed','ミニチュアダックス','small',NULL,'speed power','以前の電池式よりパワーがあり、削る時間が短くなったという体験。','existing_article_summary','/dog-nail-grinder.html'),
('casfuy-6speed','約30lbの犬','medium',NULL,'quiet speed','一般的なロータリーツールより静かに感じ、想像より速く削れたという体験。','existing_article_summary','/dog-nail-grinder.html'),
('casfuy-led2','神経質な小型犬','small',NULL,'scared beginner','音を事前に聞かせ、おやつで気をそらしながら2人で少しずつ削ったという体験。','existing_article_summary','/dog-nail-grinder.html'),
('casfuy-led2','子犬','small',NULL,'puppy gentle','子犬に使っても強く嫌がらず、少しずつ削れたという体験。','existing_article_summary','/dog-nail-grinder.html'),
('casfuy-led2','音が苦手な犬',NULL,NULL,'scared noise','飼い主には十分静かとは感じられず、犬が音を嫌がって使えなかったという体験。','existing_article_summary','/dog-nail-grinder.html'),
('petio-selftrimmer-nail','コーギー','medium','double','scared acclimation','爪切りが苦手で購入し、やすりタイプに少しずつ慣らしている体験。','existing_article_summary','/dog-nail-grinder.html'),
('petio-selftrimmer-nail','小型犬','small',NULL,'paw scared','足裏バリカンは使いやすかったが、爪やすりの振動には抵抗され慣れが必要だった体験。','existing_article_summary','/dog-nail-grinder.html'),
('petio-selftrimmer-nail','3か月トイプードル','small','curly','puppy finish','爪切り後の仕上げにやすりを使い、子犬も頑張って耐えられたという体験。','existing_article_summary','/dog-nail-grinder.html'),
('dremel-7350-pet','ラブラドール','large','short','black-nail beginner','爪切りより少しずつ削れることで、深く切る不安を減らせたという体験。','existing_article_summary','/dog-nail-grinder.html'),
('dremel-7350-pet','大型犬','large',NULL,'thick-nail power','太い爪では1速だと時間がかかり、パワー不足に感じたという購入者レビュー。','existing_article_summary','/dog-nail-grinder.html')
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
 (SELECT COUNT(*) FROM products WHERE category='nail-grinder') AS product_count,
 (SELECT COUNT(*) FROM reviews r JOIN products p ON p.id=r.product_id WHERE p.category='nail-grinder') AS review_count;
