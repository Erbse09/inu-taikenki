-- 毎日小記事（2026-11-29）：犬の早食い防止フードボウル（/dog-slow-feeder-guide）
-- 変更理由：小記事「犬の早食い防止フードボウルの選び方」の商品3件と、楽天市場の公開購入者レビュー16件の要約を追加する（追加のみ）。
-- 出典：各商品の楽天市場レビュー一覧ページ1ページ目。Amazonのレビューは使わない。
-- 出典ID：簡易方式（本文の指紋なし）16行すべて。形式 商品コード:投稿日:表示名ハッシュ8桁:o注文日:s星の数。表示名そのものは保存しない。
-- 想定追加件数：products 3 / reviews 16 / review_sources 16。
-- 重複回避：商品は INSERT OR IGNORE。口コミは同一商品・同一要約があれば挿入しない。review_sources は (platform, source_review_id) が一意。
-- 再確認：登録16行すべてを別の取得で開き直して照合（100%）。星の数が一致しなかった1行（アペティ・2025/02/09）は除外。
-- 原文（逐語）はどこにも保存しない。要約は生成AI（Claude）が出典ページで読めた本文から作成。

INSERT OR IGNORE INTO products (id, name, category, affiliate_url, active) VALUES ('turkey-slow-eating-bowl-10cm', 'ターキー ゆっくり食べる愛情食器 10cm（犬用）', 'dog-slow-feeder', 'https://www.amazon.co.jp/s?k=%E3%82%BF%E3%83%BC%E3%82%AD%E3%83%BC+%E3%82%86%E3%81%A3%E3%81%8F%E3%82%8A%E9%A3%9F%E3%81%B9%E3%82%8B%E6%84%9B%E6%83%85%E9%A3%9F%E5%99%A8+%E7%8A%AC%E7%94%A8&tag=100things-22', 1);
INSERT OR IGNORE INTO products (id, name, category, affiliate_url, active) VALUES ('apeti-nikukyu-slow-feeder-plate', 'フードボウル アペティ 早食い防止プレート（陶器・肉球型）', 'dog-slow-feeder', 'https://www.amazon.co.jp/s?k=%E3%82%A2%E3%83%9A%E3%83%86%E3%82%A3+%E6%97%A9%E9%A3%9F%E3%81%84%E9%98%B2%E6%AD%A2+%E3%83%95%E3%83%BC%E3%83%89%E3%83%9C%E3%82%A6%E3%83%AB+%E8%82%89%E7%90%83&tag=100things-22', 1);
INSERT OR IGNORE INTO products (id, name, category, affiliate_url, active) VALUES ('gutto-maze-slow-feeder-bowl', 'Gutto 早食い防止食器 迷路タイプ（S／M／L）', 'dog-slow-feeder', 'https://www.amazon.co.jp/s?k=%E6%97%A9%E9%A3%9F%E3%81%84%E9%98%B2%E6%AD%A2+%E9%A3%9F%E5%99%A8+%E8%BF%B7%E8%B7%AF+%E3%83%95%E3%83%BC%E3%83%89%E3%83%9C%E3%82%A6%E3%83%AB+%E7%8A%AC&tag=100things-22', 1);

WITH new_reviews(product_id,dog_breed,dog_size,coat_type,needs,summary,source_type,source_url) AS (
VALUES
('turkey-slow-eating-bowl-10cm','カニヘンダックスフンド',NULL,NULL,'puppy sizing','生後3か月のカニヘンダックスの子犬に使用。以前は10秒ほどで空になっていた食事が30秒以上かかるようになった。ただ本人の印象は「ゆっくり食べる」というより「食べにくい器」で、成犬になると小さすぎるかもしれないと心配している。丸飲みが減ることには期待している。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/211165_10220135/1.1/'),
('turkey-slow-eating-bowl-10cm',NULL,NULL,NULL,'puppy','生後3か月のパピーに使い、普通の皿では一瞬で終わっていた食事が分単位に延びた。滑り止めもきちんと効いている。突起の裏がへこんでいて洗いにくそうに見えたが、実際は気にならなかったという。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/211165_10220135/1.1/'),
('turkey-slow-eating-bowl-10cm','トイプードル','small',NULL,'choke speed','体重3.5kgのトイプードルは、いつも勢いよく食べてむせていた。この器にしてから食べる勢いが少し落ち着いたとのこと。サイズもちょうどよいと書いている。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/211165_10220135/1.1/'),
('turkey-slow-eating-bowl-10cm',NULL,'small',NULL,'choke sizing','フードを丸呑みして喉に詰まらせることがあった小型犬のために購入。一気に食べ込めなくなり、安心して見ていられるようになった。一方で小型犬にはやや大きく感じ、もうひと回り小さい器があればと望んでいる。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/211165_10220135/1.1/'),
('turkey-slow-eating-bowl-10cm','チワワ',NULL,NULL,'speed','チワワには効果が出ず、結局これまでどおりあっという間に食べきってしまったという星2の投稿。期待したほどの変化がなく、残念な結果に終わっている。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/211165_10220135/1.1/'),
('turkey-slow-eating-bowl-10cm','チワックス',NULL,NULL,'speed durability','1歳半のオスのチワックスで、約1か月半使った例。最初はカリカリと音を立てながらゆっくり食べていたが、そのうち舌ですくって飲み込む元の食べ方に戻り、結局は早食いのままに。気休め程度だったと受け止めている。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/211165_10220135/1.1/'),
('apeti-nikukyu-slow-feeder-plate',NULL,NULL,NULL,'dry wet','ドライフードを一瞬で平らげていた犬には効果があった。ただウェットフードは舌でかき集められてしまい、ペースが少し落ちる程度にとどまる。フードの硬さや大きさで工夫していくつもりだという。','public_buyer_review_summary','https://review.rakuten.co.jp/review/item/1/309659_10146878/1.1/'),
('apeti-nikukyu-slow-feeder-plate','トイプードル',NULL,NULL,'multi','トイプードル2匹に色違いで購入。見た目がかわいく、ずっしりした重みにも満足している。ただ肝心の早食いを防ぐ効果は、うちの子たちにはあまり感じられなかったと書いている。','public_buyer_review_summary','https://review.rakuten.co.jp/review/item/1/309659_10146878/1.1/'),
('apeti-nikukyu-slow-feeder-plate','ポメラニアン',NULL,NULL,'multi height','先に白を買い、別の早食いの犬のためにピンクを買い足したポメラニアンの飼い主。高さがちょうどよく、早食いも前よりましになったという。','public_buyer_review_summary','https://review.rakuten.co.jp/review/item/1/309659_10146878/1.1/'),
('apeti-nikukyu-slow-feeder-plate',NULL,NULL,NULL,'multi ceramic','早食い防止に加えて電子レンジが使え、洗いやすく丈夫なことから、妹犬の分も色違いで追加した。陶器なのでアレルギーの心配もなく安心だと書いている。','public_buyer_review_summary','https://review.rakuten.co.jp/review/item/1/309659_10146878/1.1/'),
('apeti-nikukyu-slow-feeder-plate','柴犬',NULL,NULL,'speed','以前から食べるのが早く、暴食でお腹が膨れて救急病院に行ったこともある柴犬の食事を見直すために購入。思ったとおりゆっくり食べるようになり、よかったと感じている。','public_buyer_review_summary','https://review.rakuten.co.jp/review/item/1/309659_10146878/1.1/'),
('gutto-maze-slow-feeder-bowl',NULL,NULL,NULL,'spill sizing','口コミを見てSサイズを選んだが、届いたものは思ったより大きめだった。それでも、勢いよく食べこぼしていた犬が食べにくそうにゆっくり食べるようになり、こぼれも減ったという。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/330654_10001034/1.1/'),
('gutto-maze-slow-feeder-bowl',NULL,NULL,NULL,'chew durability','犬が噛んで器が傷つくため、定期的な買い替えが必要だと感じている。それでも食べ終わるまでの時間は以前より長くなり、早食い防止の効果は認めている。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/330654_10001034/1.1/'),
('gutto-maze-slow-feeder-bowl',NULL,'large',NULL,'speed washable','2歳・27kgの犬は食べるのが極端に速かったが、この器にしてゆっくり食べるようになった。凹凸のつき方がほどよく、丸洗いできて衛生的な点も評価している。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/330654_10001034/1.1/'),
('gutto-maze-slow-feeder-bowl','ジャック・ラッセル・テリア','small',NULL,'choke speed','5kgのジャック・ラッセル・テリアにMサイズ。以前は30秒ほどで食べ、喉に詰まったりゲップが出たりしていた。初日は10分ほどかかり、その後も5分前後。食べにくそうではあるが、詰まりはなくなって満足している。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/330654_10001034/1.1/'),
('gutto-maze-slow-feeder-bowl','柴犬',NULL,NULL,'puppy speed','生後3か月の柴犬にMサイズを購入。早食いに困っていたが、食べ終わるまでかなり時間がかかるようになったという。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/330654_10001034/1.1/')
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
('turkey-slow-eating-bowl-10cm','生後3か月のカニヘンダックスの子犬に使用。以前は10秒ほどで空になっていた食事が30秒以上かかるようになった。ただ本人の印象は「ゆっくり食べる」というより「食べにくい器」で、成犬になると小さすぎるかもしれないと心配している。丸飲みが減ることには期待している。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/211165_10220135/1.1/','rakuten','211165_10220135:20130206:472cc427:o20130202:s4'),
('turkey-slow-eating-bowl-10cm','生後3か月のパピーに使い、普通の皿では一瞬で終わっていた食事が分単位に延びた。滑り止めもきちんと効いている。突起の裏がへこんでいて洗いにくそうに見えたが、実際は気にならなかったという。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/211165_10220135/1.1/','rakuten','211165_10220135:20221007:482b8f69:o20221002:s5'),
('turkey-slow-eating-bowl-10cm','体重3.5kgのトイプードルは、いつも勢いよく食べてむせていた。この器にしてから食べる勢いが少し落ち着いたとのこと。サイズもちょうどよいと書いている。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/211165_10220135/1.1/','rakuten','211165_10220135:20150518:482b8f69:o20150516:s5'),
('turkey-slow-eating-bowl-10cm','フードを丸呑みして喉に詰まらせることがあった小型犬のために購入。一気に食べ込めなくなり、安心して見ていられるようになった。一方で小型犬にはやや大きく感じ、もうひと回り小さい器があればと望んでいる。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/211165_10220135/1.1/','rakuten','211165_10220135:20210207:57fd2cc1:o20201127:s3'),
('turkey-slow-eating-bowl-10cm','チワワには効果が出ず、結局これまでどおりあっという間に食べきってしまったという星2の投稿。期待したほどの変化がなく、残念な結果に終わっている。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/211165_10220135/1.1/','rakuten','211165_10220135:20210108:a17cb9c8:o20201031:s2'),
('turkey-slow-eating-bowl-10cm','1歳半のオスのチワックスで、約1か月半使った例。最初はカリカリと音を立てながらゆっくり食べていたが、そのうち舌ですくって飲み込む元の食べ方に戻り、結局は早食いのままに。気休め程度だったと受け止めている。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/211165_10220135/1.1/','rakuten','211165_10220135:20161112:16ee5943:o20160927:s3'),
('apeti-nikukyu-slow-feeder-plate','ドライフードを一瞬で平らげていた犬には効果があった。ただウェットフードは舌でかき集められてしまい、ペースが少し落ちる程度にとどまる。フードの硬さや大きさで工夫していくつもりだという。','public_buyer_review_summary','https://review.rakuten.co.jp/review/item/1/309659_10146878/1.1/','rakuten','309659_10146878:20241016:482b8f69:o20241004:s3'),
('apeti-nikukyu-slow-feeder-plate','トイプードル2匹に色違いで購入。見た目がかわいく、ずっしりした重みにも満足している。ただ肝心の早食いを防ぐ効果は、うちの子たちにはあまり感じられなかったと書いている。','public_buyer_review_summary','https://review.rakuten.co.jp/review/item/1/309659_10146878/1.1/','rakuten','309659_10146878:20240228:482b8f69:o20240220:s3'),
('apeti-nikukyu-slow-feeder-plate','先に白を買い、別の早食いの犬のためにピンクを買い足したポメラニアンの飼い主。高さがちょうどよく、早食いも前よりましになったという。','public_buyer_review_summary','https://review.rakuten.co.jp/review/item/1/309659_10146878/1.1/','rakuten','309659_10146878:20260303:14b9fa87:o20260218:s4'),
('apeti-nikukyu-slow-feeder-plate','早食い防止に加えて電子レンジが使え、洗いやすく丈夫なことから、妹犬の分も色違いで追加した。陶器なのでアレルギーの心配もなく安心だと書いている。','public_buyer_review_summary','https://review.rakuten.co.jp/review/item/1/309659_10146878/1.1/','rakuten','309659_10146878:20250308:c48f0b45:o20250306:s5'),
('apeti-nikukyu-slow-feeder-plate','以前から食べるのが早く、暴食でお腹が膨れて救急病院に行ったこともある柴犬の食事を見直すために購入。思ったとおりゆっくり食べるようになり、よかったと感じている。','public_buyer_review_summary','https://review.rakuten.co.jp/review/item/1/309659_10146878/1.1/','rakuten','309659_10146878:20251002:482b8f69:o20250921:s5'),
('gutto-maze-slow-feeder-bowl','口コミを見てSサイズを選んだが、届いたものは思ったより大きめだった。それでも、勢いよく食べこぼしていた犬が食べにくそうにゆっくり食べるようになり、こぼれも減ったという。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/330654_10001034/1.1/','rakuten','330654_10001034:20261001:10cb82a7:o20260927:s4'),
('gutto-maze-slow-feeder-bowl','犬が噛んで器が傷つくため、定期的な買い替えが必要だと感じている。それでも食べ終わるまでの時間は以前より長くなり、早食い防止の効果は認めている。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/330654_10001034/1.1/','rakuten','330654_10001034:20260809:912ba672:o20260125:s4'),
('gutto-maze-slow-feeder-bowl','2歳・27kgの犬は食べるのが極端に速かったが、この器にしてゆっくり食べるようになった。凹凸のつき方がほどよく、丸洗いできて衛生的な点も評価している。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/330654_10001034/1.1/','rakuten','330654_10001034:20260729:4aa8b082:o20260716:s5'),
('gutto-maze-slow-feeder-bowl','5kgのジャック・ラッセル・テリアにMサイズ。以前は30秒ほどで食べ、喉に詰まったりゲップが出たりしていた。初日は10分ほどかかり、その後も5分前後。食べにくそうではあるが、詰まりはなくなって満足している。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/330654_10001034/1.1/','rakuten','330654_10001034:20260601:dabfe78a:o20260523:s5'),
('gutto-maze-slow-feeder-bowl','生後3か月の柴犬にMサイズを購入。早食いに困っていたが、食べ終わるまでかなり時間がかかるようになったという。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/330654_10001034/1.1/','rakuten','330654_10001034:20260522:8d7b59eb:o20260516:s4')
)
INSERT OR IGNORE INTO review_sources(review_id,source_type,source_url,source_platform,source_review_id)
SELECT r.id,s.source_type,s.source_url,s.source_platform,s.source_review_id
FROM new_sources s
JOIN reviews r ON r.product_id=s.product_id AND r.summary=s.summary;
