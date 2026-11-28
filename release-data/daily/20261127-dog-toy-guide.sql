-- 毎日小記事（2026-11-27）：犬用おもちゃ（/dog-toy-guide）
-- 変更理由：小記事「犬のおもちゃの選び方」の商品3件と、楽天市場の公開購入者レビュー16件の要約を追加する（追加のみ）。
-- 出典：各商品の楽天市場レビュー一覧ページ（https://review.rakuten.co.jp/item/1/<店舗ID_商品ID>/1.1/）。Amazonのレビューは使わない。
-- 出典ID：簡易方式（本文の指紋なし）。形式 商品コード:投稿日:表示名ハッシュ8桁:o注文日:s星の数。表示名そのものは保存しない。
-- 想定追加件数：products 3 / reviews 16 / review_sources 16。
-- 重複回避：商品は INSERT OR IGNORE。口コミは同一商品・同一要約があれば挿入しない。review_sources は (platform, source_review_id) が一意。
-- 原文（逐語）はどこにも保存しない。要約は生成AI（Claude）が出典ページで読めた本文から作成。

INSERT OR IGNORE INTO products (id, name, category, affiliate_url, active) VALUES ('kong-wobbler', 'コング ワブラー（フード入り知育トイ）', 'dog-toy', 'https://www.amazon.co.jp/s?k=%E3%82%B3%E3%83%B3%E3%82%B0+%E3%83%AF%E3%83%96%E3%83%A9%E3%83%BC&tag=100things-22', 1);
INSERT OR IGNORE INTO products (id, name, category, affiliate_url, active) VALUES ('miwakura-rope-toy-5set', 'miwakura（美和蔵）コットンロープ犬用おもちゃ 5種セット', 'dog-toy', 'https://www.amazon.co.jp/s?k=miwakura+%E7%BE%8E%E5%92%8C%E8%94%B5+%E3%83%AD%E3%83%BC%E3%83%97+%E7%8A%AC+%E3%81%8A%E3%82%82%E3%81%A1%E3%82%83+5%E7%A8%AE%E3%82%BB%E3%83%83%E3%83%88&tag=100things-22', 1);
INSERT OR IGNORE INTO products (id, name, category, affiliate_url, active) VALUES ('kong-squeakair-ball-m', 'コング スクイークエアー ボール M（3個入）', 'dog-toy', 'https://www.amazon.co.jp/s?k=%E3%82%B3%E3%83%B3%E3%82%B0+%E3%82%B9%E3%82%AF%E3%82%A4%E3%83%BC%E3%82%AF%E3%82%A8%E3%82%A2%E3%83%BC+%E3%83%9C%E3%83%BC%E3%83%AB+M&tag=100things-22', 1);

WITH new_reviews(product_id,dog_breed,dog_size,coat_type,needs,summary,source_type,source_url) AS (
VALUES
('kong-wobbler',NULL,'large',NULL,'alone','大型犬の留守番のときにおやつを入れて使っている。長い時間よく遊んでくれるので、買ってよかったと感じている。犬種や体重の記載はない。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/217176_10099048/1.1/'),
('kong-wobbler','プードル','small',NULL,'puppy','2.2kg・4か月のプードルの子犬。大きくて動かしにくいという口コミも見て迷ったが、前足でじゃれながら食べていて、サイズが大きくても楽しめているという。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/217176_10099048/1.1/'),
('kong-wobbler',NULL,NULL,NULL,'puppy fast-eating','早食いが気になる生後5か月の子犬に、ケージの中での食事用として購入。最初はフードを出すのに手間取ったが、コツをつかんでからは食後も落ち着いて過ごすようになった。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/217176_10099048/1.1/'),
('kong-wobbler','柴犬',NULL,NULL,'puppy noise','柴犬のパピーは最初こそ見向きもしなかったものの、中身を入れると前足や鼻で転がして遊ぶように。転がるとゴンと響く音が大きいため、集合住宅ではカーペットの上で使うほうがよいと書いている。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/217176_10099048/1.1/'),
('kong-wobbler','ラブラドール','large',NULL,'puzzle','ラブラドールが中身を出すまでに時間をかけて取り組む。最初は思うようにいかず吠えたものの、今では楽しみにしていて、鼻で押して夢中になる。大型犬向きの大きさだという。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/217176_10099048/1.1/'),
('kong-wobbler','ポメラニアン','small',NULL,'noise','4kgのポメラニアンが喜んで遊ぶ反面、揺れるたびに床でカンカンと音が響き、賃貸だと階下に聞こえそうで気になるとのこと。評価は星4。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/217176_10099048/1.1/'),
('miwakura-rope-toy-5set',NULL,NULL,NULL,'puppy durability','生後8か月の愛犬は、ぬいぐるみなら数分、ロープ系でも数日で壊してしまうタイプ。このセットは約2週間、毎日振り回しても持ちこたえ、数をそろえて順番に遊ばせている。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/216289_10017116/1.1/'),
('miwakura-rope-toy-5set',NULL,NULL,NULL,'durability','綿入りのぬいぐるみは1日で中身が出て、音の出るゴム系は穴だらけに、にんじん型も壊された。一方で形が何種類もあるため飽きにくく、買い足す予定だという。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/216289_10017116/1.1/'),
('miwakura-rope-toy-5set','シュナ','small',NULL,'chewer','約5kgの、噛むのが好きなシュナ。量の割に値段が手頃で、作りもしっかりしているので簡単には壊れなさそうと感じ、新しいおもちゃに喜んでいる。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/216289_10017116/1.1/'),
('miwakura-rope-toy-5set','ダックスフンド',NULL,NULL,'chewer durability','大きめのダックスフンドで、何でも噛み砕くほど噛む力が強く、ロープはボロボロになった。それでも気に入ってずっと噛んでおり、種類が多いので買い足したいという。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/216289_10017116/1.1/'),
('miwakura-rope-toy-5set',NULL,'small',NULL,'sizing','超小型犬には少し大きめに感じたものの、犬は喜んで遊んでいる。評価は星4。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/216289_10017116/1.1/'),
('miwakura-rope-toy-5set','ボストンテリア',NULL,NULL,'puppy noise','ボストンテリアの子犬。価格に満足し、どれも気に入っている。ただしマンション住まいのため、ボール型は床に落ちる音が響くので渡しておらず、ロープ型も重いため夜は音に気を配っている。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/216289_10017116/1.1/'),
('kong-squeakair-ball-m','柴犬',NULL,NULL,'safety','成犬の柴犬（メス）。以前使っていたゴム製のボールより噛みやすいのか、夢中で追いかけた。遊び終わったあとに片づけないと噛み続けてしまい、少し危ないかもしれないとし、犬による差もあるとも書いている。評価は星4。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/217176_10099054/1.1/'),
('kong-squeakair-ball-m','柴犬',NULL,NULL,'chewer fetch','柴犬が鳴らしながら咥えて戻ってくる。歯が強く、厚みのあるボールでないとすぐ穴があくため、これを選んで繰り返し購入している。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/217176_10099054/1.1/'),
('kong-squeakair-ball-m','コーギー',NULL,NULL,'senior','9歳になるコーギーが、子犬のころから遊び続けているボール。取り扱いが減ってきたものの安く買い直せて満足していて、ドッグランではラブラドールも寄ってくるそう。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/217176_10099054/1.1/'),
('kong-squeakair-ball-m','コーギー',NULL,NULL,'squeaker','ボール好きのコーギーのお気に入り。ただ、ピコピコ鳴る音は数日でほとんど出なくなった。それでも音がないまま遊んでいる。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/217176_10099054/1.1/')
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
('kong-wobbler','大型犬の留守番のときにおやつを入れて使っている。長い時間よく遊んでくれるので、買ってよかったと感じている。犬種や体重の記載はない。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/217176_10099048/1.1/','rakuten','217176_10099048:20251023:482b8f69:o20251018:s5'),
('kong-wobbler','2.2kg・4か月のプードルの子犬。大きくて動かしにくいという口コミも見て迷ったが、前足でじゃれながら食べていて、サイズが大きくても楽しめているという。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/217176_10099048/1.1/','rakuten','217176_10099048:20211107:482b8f69:o20211025:s5'),
('kong-wobbler','早食いが気になる生後5か月の子犬に、ケージの中での食事用として購入。最初はフードを出すのに手間取ったが、コツをつかんでからは食後も落ち着いて過ごすようになった。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/217176_10099048/1.1/','rakuten','217176_10099048:20240123:482b8f69:o20240112:s5'),
('kong-wobbler','柴犬のパピーは最初こそ見向きもしなかったものの、中身を入れると前足や鼻で転がして遊ぶように。転がるとゴンと響く音が大きいため、集合住宅ではカーペットの上で使うほうがよいと書いている。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/217176_10099048/1.1/','rakuten','217176_10099048:20220322:482b8f69:o20220115:s5'),
('kong-wobbler','ラブラドールが中身を出すまでに時間をかけて取り組む。最初は思うようにいかず吠えたものの、今では楽しみにしていて、鼻で押して夢中になる。大型犬向きの大きさだという。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/217176_10099048/1.1/','rakuten','217176_10099048:20240524:d459fe04:o20240512:s5'),
('kong-wobbler','4kgのポメラニアンが喜んで遊ぶ反面、揺れるたびに床でカンカンと音が響き、賃貸だと階下に聞こえそうで気になるとのこと。評価は星4。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/217176_10099048/1.1/','rakuten','217176_10099048:20231213:482b8f69:o20231201:s4'),
('miwakura-rope-toy-5set','生後8か月の愛犬は、ぬいぐるみなら数分、ロープ系でも数日で壊してしまうタイプ。このセットは約2週間、毎日振り回しても持ちこたえ、数をそろえて順番に遊ばせている。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/216289_10017116/1.1/','rakuten','216289_10017116:20250107:a41f9bd2:o20241220:s5'),
('miwakura-rope-toy-5set','綿入りのぬいぐるみは1日で中身が出て、音の出るゴム系は穴だらけに、にんじん型も壊された。一方で形が何種類もあるため飽きにくく、買い足す予定だという。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/216289_10017116/1.1/','rakuten','216289_10017116:20241108:92c4bccb:o20241021:s5'),
('miwakura-rope-toy-5set','約5kgの、噛むのが好きなシュナ。量の割に値段が手頃で、作りもしっかりしているので簡単には壊れなさそうと感じ、新しいおもちゃに喜んでいる。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/216289_10017116/1.1/','rakuten','216289_10017116:20250315:74aa9070:o20250308:s5'),
('miwakura-rope-toy-5set','大きめのダックスフンドで、何でも噛み砕くほど噛む力が強く、ロープはボロボロになった。それでも気に入ってずっと噛んでおり、種類が多いので買い足したいという。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/216289_10017116/1.1/','rakuten','216289_10017116:20241220:482b8f69:o20241125:s5'),
('miwakura-rope-toy-5set','超小型犬には少し大きめに感じたものの、犬は喜んで遊んでいる。評価は星4。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/216289_10017116/1.1/','rakuten','216289_10017116:20241110:6409830c:o20241105:s4'),
('miwakura-rope-toy-5set','ボストンテリアの子犬。価格に満足し、どれも気に入っている。ただしマンション住まいのため、ボール型は床に落ちる音が響くので渡しておらず、ロープ型も重いため夜は音に気を配っている。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/216289_10017116/1.1/','rakuten','216289_10017116:20221209:e81d1fdc:o20221005:s5'),
('kong-squeakair-ball-m','成犬の柴犬（メス）。以前使っていたゴム製のボールより噛みやすいのか、夢中で追いかけた。遊び終わったあとに片づけないと噛み続けてしまい、少し危ないかもしれないとし、犬による差もあるとも書いている。評価は星4。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/217176_10099054/1.1/','rakuten','217176_10099054:20251118:66b0a816:o20251025:s4'),
('kong-squeakair-ball-m','柴犬が鳴らしながら咥えて戻ってくる。歯が強く、厚みのあるボールでないとすぐ穴があくため、これを選んで繰り返し購入している。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/217176_10099054/1.1/','rakuten','217176_10099054:20210613:4b2c4ec0:o20210607:s5'),
('kong-squeakair-ball-m','9歳になるコーギーが、子犬のころから遊び続けているボール。取り扱いが減ってきたものの安く買い直せて満足していて、ドッグランではラブラドールも寄ってくるそう。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/217176_10099054/1.1/','rakuten','217176_10099054:20210125:d1e51ed8:o20210106:s5'),
('kong-squeakair-ball-m','ボール好きのコーギーのお気に入り。ただ、ピコピコ鳴る音は数日でほとんど出なくなった。それでも音がないまま遊んでいる。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/217176_10099054/1.1/','rakuten','217176_10099054:20210922:482b8f69:o20210905:s5')
)
INSERT OR IGNORE INTO review_sources(review_id,source_type,source_url,source_platform,source_review_id)
SELECT r.id,s.source_type,s.source_url,s.source_platform,s.source_review_id
FROM new_sources s
JOIN reviews r ON r.product_id=s.product_id AND r.summary=s.summary;
