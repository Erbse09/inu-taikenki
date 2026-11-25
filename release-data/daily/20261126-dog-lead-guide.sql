-- 毎日小記事（2026-11-26）：犬用リード（/dog-lead-guide）
-- 変更理由：小記事「犬用リードの選び方」の商品3件と、楽天市場の公開購入者レビュー13件の要約を追加する（追加のみ）。
-- 出典：各商品の楽天市場レビュー一覧ページ（https://review.rakuten.co.jp/item/1/<店舗ID_商品ID>/1.1/）。Amazonのレビューは使わない。
-- 出典ID：簡易方式（本文の指紋なし）。形式 商品コード:投稿日:表示名ハッシュ8桁:o注文日:s星の数。表示名そのものは保存しない。
-- 想定追加件数：products 3 / reviews 13 / review_sources 13。
-- 重複回避：商品は INSERT OR IGNORE。口コミは同一商品・同一要約があれば挿入しない。review_sources は (platform, source_review_id) が一意。
-- 原文（逐語）はどこにも保存しない。要約は生成AI（Claude）が出典ページで読めた本文から作成。

INSERT OR IGNORE INTO products (id, name, category, affiliate_url, active) VALUES ('laluca-shoulder-lead', 'LaLUCA ショルダーリード（ダブルナスカン対応）', 'dog-lead', 'https://www.amazon.co.jp/s?k=LaLUCA+%E3%82%B7%E3%83%A7%E3%83%AB%E3%83%80%E3%83%BC%E3%83%AA%E3%83%BC%E3%83%89&tag=100things-22', 1);
INSERT OR IGNORE INTO products (id, name, category, affiliate_url, active) VALUES ('flexi-neon-tape-lead', 'フレキシ ネオン（旧ニューネオン）テープ式伸縮リード', 'dog-lead', 'https://www.amazon.co.jp/s?k=%E3%83%95%E3%83%AC%E3%82%AD%E3%82%B7+%E3%83%8D%E3%82%AA%E3%83%B3+%E4%BC%B8%E7%B8%AE%E3%83%AA%E3%83%BC%E3%83%89+%E3%83%86%E3%83%BC%E3%83%97&tag=100things-22', 1);
INSERT OR IGNORE INTO products (id, name, category, affiliate_url, active) VALUES ('suzukoubou-shoulder-lead-set', 'SUZUKOUBOU（すず工房）ショルダーリードセット', 'dog-lead', 'https://www.amazon.co.jp/s?k=%E3%81%99%E3%81%9A%E5%B7%A5%E6%88%BF+%E3%82%B7%E3%83%A7%E3%83%AB%E3%83%80%E3%83%BC%E3%83%AA%E3%83%BC%E3%83%89&tag=100things-22', 1);

WITH new_reviews(product_id,dog_breed,dog_size,coat_type,needs,summary,source_type,source_url) AS (
VALUES
('laluca-shoulder-lead','ウエスティ',NULL,NULL,'handle','強く引くウエスティに使い、肩掛けにしたことで安心感は高いと評価。一方でダブルナスカンが重く、首輪が回って使いにくいと感じ、リード側の持ち手も咄嗟に握りにくいため、滑りにくいゴム素材だとよいという要望が出ていた。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/395228_10000251/1.1/'),
('laluca-shoulder-lead',NULL,'large',NULL,'durability','成長して30kgになった愛犬の力にも耐えるため愛用しているとのこと。大型犬向けならナスカンをもう少し大きく、ストラップも幅広にしてほしいという希望が添えられていた。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/395228_10000251/1.1/'),
('laluca-shoulder-lead','マルプー','small',NULL,'escape','4kgのマルプーにSサイズを使用。古いリードの買い替えで、以前ハーネスが抜けた経験からダブルリードをすすめたいと感じた。発送が早く、色も気に入って散歩が楽しみになったそう。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/395228_10000251/1.1/'),
('laluca-shoulder-lead','スタンダードプードル',NULL,NULL,'scared escape','怖がりで小ぶりな女の子のスタンダードプードルが、ハーネスから抜けて走り去ったことがあり購入。抜けにくそうで使いやすいと感じる反面、束ねるとかさばって保管しにくい点が気になっている。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/395228_10000251/1.1/'),
('laluca-shoulder-lead','コーギー','medium',NULL,'sizing','12kgのコーギーにSサイズのダブルナスカンを合わせ、よく考えられた作りだと満足している。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/395228_10000251/1.1/'),
('flexi-neon-tape-lead','柴犬',NULL,NULL,'light chew','8kgの柴犬の飼い主が、普段使いの8mのリードは重いと感じ、近所の散歩用に軽いSサイズを買い足した。テープは細く薄いため、噛む癖のある犬には向かないと見ている。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/347200_10000097/1.1/'),
('flexi-neon-tape-lead','黒柴',NULL,NULL,'handling','黒柴に使用。第一希望の青が欠品でグリーンを選んだ。反射のおかげで夜の散歩も安心感があり、握りやすく重さも気にならないという。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/347200_10000097/1.1/'),
('flexi-neon-tape-lead','プードル',NULL,NULL,'pull','2歳の男の子のプードルは引っ張りが強く、飼い主が前かがみで早歩きになりがちだったが、伸縮リードに替えて散歩がかなり楽になった。オレンジの色味も鮮やかで気に入っている。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/347200_10000097/1.1/'),
('suzukoubou-shoulder-lead-set','柴犬',NULL,NULL,'pull multi','2頭を連れた散歩で強く引かれて体を振られていたが、手元の持ち手があることで抑えやすくなった。単品のリードや補助ナスカンも買い足し、散歩が楽しくなったとのこと。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/278852_10002254/1.1/'),
('suzukoubou-shoulder-lead-set',NULL,NULL,NULL,'durability handle','丈夫で安定感があり、肩側のクッションが良いと評価。リードの持ち手側にもクッションがあれば、という希望も挙げている。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/278852_10002254/1.1/'),
('suzukoubou-shoulder-lead-set','ミニチュアダックスフンド','small',NULL,'handle','5.8kgのミニチュアダックスでも重さは気にならず、色も好評。一方、Sサイズではサブハンドルは不要と感じたほか、肩のバックルがなくなった点が残念で、復活を望んでいる。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/278852_10002254/1.1/'),
('suzukoubou-shoulder-lead-set','柴犬',NULL,NULL,'sizing','柴犬用にハーネスとリードのセットを購入。サイズ選びで迷い、ハーネスは1つ上、リードは1つ小さめにすればよかったと振り返る。重いという声には、普通の重さに感じたと書いている。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/278852_10002254/1.1/'),
('suzukoubou-shoulder-lead-set',NULL,'medium',NULL,'durability','元野犬の保護犬（約15kg）に使い、引く力にも耐える頑丈な作りを評価。ただし届いた時に外装と個包装が破れていて残念で、店の交換対応は早く丁寧だったという。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/278852_10002254/1.1/')
)
INSERT INTO reviews(product_id,dog_breed,dog_size,coat_type,needs,summary,source_type,source_url)
SELECT n.product_id,n.dog_breed,n.dog_size,n.coat_type,n.needs,n.summary,n.source_type,n.source_url
FROM new_reviews n
WHERE NOT EXISTS (
  SELECT 1 FROM reviews r
  WHERE r.product_id=n.product_id
    AND r.summary=n.summary
);

WITH new_sources(product_id,summary,source_type,source_url,source_platform,source_review_id) AS (
VALUES
('laluca-shoulder-lead','強く引くウエスティに使い、肩掛けにしたことで安心感は高いと評価。一方でダブルナスカンが重く、首輪が回って使いにくいと感じ、リード側の持ち手も咄嗟に握りにくいため、滑りにくいゴム素材だとよいという要望が出ていた。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/395228_10000251/1.1/','rakuten','395228_10000251:20260916:482b8f69:o20260906:s4'),
('laluca-shoulder-lead','成長して30kgになった愛犬の力にも耐えるため愛用しているとのこと。大型犬向けならナスカンをもう少し大きく、ストラップも幅広にしてほしいという希望が添えられていた。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/395228_10000251/1.1/','rakuten','395228_10000251:20251105:7d982c91:o20251028:s4'),
('laluca-shoulder-lead','4kgのマルプーにSサイズを使用。古いリードの買い替えで、以前ハーネスが抜けた経験からダブルリードをすすめたいと感じた。発送が早く、色も気に入って散歩が楽しみになったそう。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/395228_10000251/1.1/','rakuten','395228_10000251:20260321:482b8f69:o20260318:s5'),
('laluca-shoulder-lead','怖がりで小ぶりな女の子のスタンダードプードルが、ハーネスから抜けて走り去ったことがあり購入。抜けにくそうで使いやすいと感じる反面、束ねるとかさばって保管しにくい点が気になっている。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/395228_10000251/1.1/','rakuten','395228_10000251:20260207:490447a4:o20260112:s5'),
('laluca-shoulder-lead','12kgのコーギーにSサイズのダブルナスカンを合わせ、よく考えられた作りだと満足している。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/395228_10000251/1.1/','rakuten','395228_10000251:20251213:e6826070:o20251210:s5'),
('flexi-neon-tape-lead','8kgの柴犬の飼い主が、普段使いの8mのリードは重いと感じ、近所の散歩用に軽いSサイズを買い足した。テープは細く薄いため、噛む癖のある犬には向かないと見ている。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/347200_10000097/1.1/','rakuten','347200_10000097:20261018:482b8f69:o20260928:s5'),
('flexi-neon-tape-lead','黒柴に使用。第一希望の青が欠品でグリーンを選んだ。反射のおかげで夜の散歩も安心感があり、握りやすく重さも気にならないという。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/347200_10000097/1.1/','rakuten','347200_10000097:20261028:7a792767:o20261025:s5'),
('flexi-neon-tape-lead','2歳の男の子のプードルは引っ張りが強く、飼い主が前かがみで早歩きになりがちだったが、伸縮リードに替えて散歩がかなり楽になった。オレンジの色味も鮮やかで気に入っている。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/347200_10000097/1.1/','rakuten','347200_10000097:20261005:e8ce478a:o20261001:s5'),
('suzukoubou-shoulder-lead-set','2頭を連れた散歩で強く引かれて体を振られていたが、手元の持ち手があることで抑えやすくなった。単品のリードや補助ナスカンも買い足し、散歩が楽しくなったとのこと。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/278852_10002254/1.1/','rakuten','278852_10002254:20251217:482b8f69:o20251211:s5'),
('suzukoubou-shoulder-lead-set','丈夫で安定感があり、肩側のクッションが良いと評価。リードの持ち手側にもクッションがあれば、という希望も挙げている。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/278852_10002254/1.1/','rakuten','278852_10002254:20260411:771004aa:o20260410:s5'),
('suzukoubou-shoulder-lead-set','5.8kgのミニチュアダックスでも重さは気にならず、色も好評。一方、Sサイズではサブハンドルは不要と感じたほか、肩のバックルがなくなった点が残念で、復活を望んでいる。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/278852_10002254/1.1/','rakuten','278852_10002254:20260823:011c6675:o20260811:s4'),
('suzukoubou-shoulder-lead-set','柴犬用にハーネスとリードのセットを購入。サイズ選びで迷い、ハーネスは1つ上、リードは1つ小さめにすればよかったと振り返る。重いという声には、普通の重さに感じたと書いている。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/278852_10002254/1.1/','rakuten','278852_10002254:20260425:cfe6ca55:o20260409:s5'),
('suzukoubou-shoulder-lead-set','元野犬の保護犬（約15kg）に使い、引く力にも耐える頑丈な作りを評価。ただし届いた時に外装と個包装が破れていて残念で、店の交換対応は早く丁寧だったという。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/278852_10002254/1.1/','rakuten','278852_10002254:20260311:540799d5:o20260305:s4')
)
INSERT OR IGNORE INTO review_sources(review_id,source_type,source_url,source_platform,source_review_id)
SELECT r.id,s.source_type,s.source_url,s.source_platform,s.source_review_id
FROM new_sources s
JOIN reviews r ON r.product_id=s.product_id AND r.summary=s.summary;
