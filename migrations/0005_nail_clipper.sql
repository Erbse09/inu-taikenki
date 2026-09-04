PRAGMA foreign_keys = ON;
INSERT OR IGNORE INTO products (id,name,category,asin,affiliate_url,active) VALUES
('zan-guillotine-sm','ZAN ギロチン 小型犬・中型犬用','nail-clipper',NULL,'https://www.amazon.co.jp/s?k=ZAN+%E3%82%AE%E3%83%AD%E3%83%81%E3%83%B3+%E5%B0%8F%E5%9E%8B%E7%8A%AC+%E4%B8%AD%E5%9E%8B%E7%8A%AC+%E7%88%AA%E5%88%87%E3%82%8A&tag=100things-22',1),
('zan-guillotine-large','ZAN ギロチン 大型犬用','nail-clipper',NULL,'https://www.amazon.co.jp/s?k=ZAN+%E3%82%AE%E3%83%AD%E3%83%81%E3%83%B3+%E5%A4%A7%E5%9E%8B%E7%8A%AC+%E7%88%AA%E5%88%87%E3%82%8A&tag=100things-22',1),
('zan-nipper','ZAN ニッパー式','nail-clipper',NULL,'https://www.amazon.co.jp/s?k=ZAN+%E3%83%8B%E3%83%83%E3%83%91%E3%83%BC%E5%BC%8F+%E7%88%AA%E5%88%87%E3%82%8A&tag=100things-22',1),
('petio-selftrimmer-clipper','Petio SelfTrimmer スパッと素早く切れる 犬用爪切り','nail-clipper',NULL,'https://www.amazon.co.jp/s?k=Petio+SelfTrimmer+%E3%82%B9%E3%83%91%E3%83%83%E3%81%A8+%E7%8A%AC%E7%94%A8%E7%88%AA%E5%88%87%E3%82%8A&tag=100things-22',1);

WITH new_reviews(product_id,dog_breed,dog_size,coat_type,needs,summary,source_type,source_url) AS (
VALUES
('zan-guillotine-sm','豆柴','small','double','black-nail beginner','切れ味は良いが血管が長く、少しずつ何回も切る必要があり初心者には難しく感じた体験。','existing_article_summary','/dog-nail-clipper.html'),
('zan-guillotine-sm','4kgトイプードル','small','curly','beginner speed','軽い力でスパスパ切れ、時間がかかりにくく爪切りへの怖さが減った体験。','existing_article_summary','/dog-nail-clipper.html'),
('zan-guillotine-sm','黒い爪の犬',NULL,NULL,'black-nail scared','以前のハサミ型では音と大きさに驚いたが、切断音が気になりにくく少しずつ切れた体験。','existing_article_summary','/dog-nail-clipper.html'),
('zan-guillotine-sm','3頭飼い',NULL,NULL,'multi safety','初回に1頭を深爪して一時期使えなくなったが、後に再び切れるようになった失敗例。','existing_article_summary','/dog-nail-clipper.html'),
('zan-guillotine-large','14kg柴犬','medium','double','wolf-claw hard-nail','通常サイズでは切りづらかった伸びた狼爪を大型犬用で切れた体験。','existing_article_summary','/dog-nail-clipper.html'),
('zan-guillotine-large','2歳ゴールデンレトリバー','large','long','hard-nail','以前の爪切りより指を挟みにくく、切れ味も良かった体験。','existing_article_summary','/dog-nail-clipper.html'),
('zan-guillotine-large','大型犬','large',NULL,'hard-nail power','強い力を入れなくても切れ、以前より爪切りが楽になった体験。','existing_article_summary','/dog-nail-clipper.html'),
('zan-nipper','3.5kgダックス＋4kg/5kgトイプードル','small','long curly','beginner control','ギロチンより扱いやすく微調整しやすく、爪が割れにくいと感じた体験。','existing_article_summary','/dog-nail-clipper.html'),
('petio-selftrimmer-clipper','チワワ','small',NULL,'scared noise','爪切りが大嫌いでも、音が気になりにくくどうにか我慢して切らせてくれた体験。','existing_article_summary','/dog-nail-clipper.html'),
('petio-selftrimmer-clipper','ポメラニアン','small','long','quiet beginner','切断時に大きな音が出にくく、本体サイズもちょうど良かった体験。','existing_article_summary','/dog-nail-clipper.html')
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
 (SELECT COUNT(*) FROM products WHERE category='nail-clipper') AS product_count,
 (SELECT COUNT(*) FROM reviews r JOIN products p ON p.id=r.product_id WHERE p.category='nail-clipper') AS review_count;
