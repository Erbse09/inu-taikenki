-- 毎日小記事（2026-11-28）：犬の冬服・防寒ウェア（/dog-winter-wear-guide）
-- 変更理由：小記事「犬の冬服の選び方」の商品3件と、楽天市場の公開購入者レビュー16件の要約を追加する（追加のみ）。
-- 出典：各商品の楽天市場レビュー一覧ページ（https://review.rakuten.co.jp/item/1/<店舗ID_商品ID>/1.1/）。Amazonのレビューは使わない。
-- 出典ID：簡易方式（本文の指紋なし）。形式 商品コード:投稿日:表示名ハッシュ8桁:o注文日:s星の数。表示名そのものは保存しない（ハッシュ＝表示名全体のsha256先頭8桁）。
-- 想定追加件数：products 3 / reviews 16 / review_sources 16。
-- 重複回避：商品は INSERT OR IGNORE。口コミは同一商品・同一要約があれば挿入しない。review_sources は (platform, source_review_id) が一意。
-- 原文（逐語）はどこにも保存しない。要約は生成AI（Claude）が出典ページで読めた本文から作成し、登録16件すべてを別の取得で開き直して照合した。

INSERT OR IGNORE INTO products (id, name, category, affiliate_url, active) VALUES ('petfun-boa-jacket', 'PETFUN（ペットファン）犬用ジャケット 防寒ボア・裏起毛', 'dog-winter-wear', 'https://www.amazon.co.jp/s?k=PETFUN+%E7%8A%AC%E7%94%A8%E3%82%B8%E3%83%A3%E3%82%B1%E3%83%83%E3%83%88+%E9%98%B2%E5%AF%92%E3%83%9C%E3%82%A2+%E8%A3%8F%E8%B5%B7%E6%AF%9B&tag=100things-22', 1);
INSERT OR IGNORE INTO products (id, name, category, affiliate_url, active) VALUES ('patty-knit-dogwear', 'パールパティ 犬服 ニットセーター（秋冬・ふわふわタイプ）', 'dog-winter-wear', 'https://www.amazon.co.jp/s?k=%E3%83%91%E3%83%BC%E3%83%AB%E3%83%91%E3%83%86%E3%82%A3+%E7%8A%AC%E6%9C%8D+%E3%83%8B%E3%83%83%E3%83%88+%E3%82%BB%E3%83%BC%E3%82%BF%E3%83%BC+%E7%A7%8B%E5%86%AC&tag=100things-22', 1);
INSERT OR IGNORE INTO products (id, name, category, affiliate_url, active) VALUES ('yokuya-down-vest-harness', 'ヨクヤストア 犬用ダウン風ベスト（ハーネス付き）', 'dog-winter-wear', 'https://www.amazon.co.jp/s?k=%E7%8A%AC+%E5%86%AC%E6%9C%8D+%E3%83%80%E3%82%A6%E3%83%B3%E9%A2%A8+%E3%83%99%E3%82%B9%E3%83%88+%E3%83%8F%E3%83%BC%E3%83%8D%E3%82%B9+%E3%83%A8%E3%82%AF%E3%83%A4%E3%82%B9%E3%83%88%E3%82%A2&tag=100things-22', 1);

WITH new_reviews(product_id,dog_breed,dog_size,coat_type,needs,summary,source_type,source_url) AS (
VALUES
('petfun-boa-jacket','トイプードル','small',NULL,'sizing','1歳・7kgの大きめトイプードルにXXLを購入。採寸して選んだものの、胸まわりが合わずボタンが閉まらなかったという。見た目はかわいいが、これ以上大きい展開がないのが残念な様子。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/415921_10000274/1.1/'),
('petfun-boa-jacket','トイプードル','small',NULL,'hood','2kgのトイプードルに着せて満足している。作りがしっかりしていて、フードなど外せる部分があるのも便利。値段のわりに高級感があると書いていた。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/415921_10000274/1.1/'),
('petfun-boa-jacket','ミニチュアシュナウザー','small',NULL,'walk','寒くなってきたため、7kgのミニチュアシュナウザーの散歩用に購入。大きいかもしれないと思ってXXLを選んだところ、ちょうどよく収まった。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/415921_10000274/1.1/'),
('petfun-boa-jacket','テリア','small',NULL,'sizing','5kg弱のテリアにサイズ表を確認してLを頼んだが、届いたものは小さくて着せられなかった。かわいいだけにがっかりで、作りが小さめなので1つ上のサイズを選ぶのがよさそうと振り返っている。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/415921_10000274/1.1/'),
('patty-knit-dogwear','トイプードル',NULL,NULL,'easy-dressing','首回り23cm・胴回り36cm・着丈27cmのトイプードルにLを着用。毛糸素材がよく伸びて脱ぎ着しやすい。Lはやや大きめだが問題なく、Mでも着られそうだと感じている。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/260247_10001462/1.1/'),
('patty-knit-dogwear','トイプードル','small',NULL,'sizing','3kgの女の子のトイプードル用に最初はMを買ったが、丈が短く感じたのでLを買い直した。Lは少しゆったりめでも満足していて、別の柄も買う予定だという。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/260247_10001462/1.1/'),
('patty-knit-dogwear','トイプードル','small',NULL,'sizing','1.8kgの小柄なトイプードルにS。ニットの縁が丸まるせいか、丈は思ったより短くお腹あたりまでだった。ただ伸縮性があって着せやすく、柄もかわいいと評価している。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/260247_10001462/1.1/'),
('patty-knit-dogwear','チワプー','small',NULL,'easy-dressing','胴がやや長めの5kgのチワプーにLを着せてぴったり。首まわりがよく伸びて着せやすく、また買うつもりとのこと。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/260247_10001462/1.1/'),
('patty-knit-dogwear','チワワ','small',NULL,'sizing','2.3kgのチワワにSを選び、ちょうどよく着られた。気に入ったので再購入も考えている。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/260247_10001462/1.1/'),
('patty-knit-dogwear','チワワ','small',NULL,'sizing','2.4kgのチワワの飼い主。他社で買った服が小さくなったために購入し、デザインのかわいさと届く早さが助かったと書いている。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/260247_10001462/1.1/'),
('yokuya-down-vest-harness','トイプードル','small',NULL,'multi','3.8kgと3.3kgのトイプードル2頭にMを着せ、どちらもゆとりがあった。ただ薄手のニットを中に着せたオスは首から胸が窮屈で、ファスナーを開けて着用。ファスナーの裏に当て布があり毛が絡みにくい反面、丈がお尻近くまであるため、オスにはマナーベルトを併用している。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/405583_10000048/1.1/'),
('yokuya-down-vest-harness','ヨークシャーテリア','small',NULL,'zipper','4kgのヨークシャーテリアにMがちょうどよく、ハーネスより着せやすいと評価。生地が薄めで、防寒というよりウインドブレーカー感覚で使っている。ファスナーが裏地を噛みやすい点だけが惜しく、星を1つ減らしたという。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/405583_10000048/1.1/'),
('yokuya-down-vest-harness','チワワ','small',NULL,'fit','服が苦手な2.8kgのチワワに、ゆとりのあるMを選んだ。サイズ感は問題なかった一方、金具が少し重そうに見える点が気になったとのこと。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/405583_10000048/1.1/'),
('yokuya-down-vest-harness','ジャックラッセルテリア','small',NULL,'easy-dressing','4.2kgのジャックラッセルテリアにM。背中のファスナーで脱ぎ着が楽で、首まわりは余るが胴回りと着丈はちょうどよい。色はもっとオレンジを想像していたため落ち着いた色味に感じたが、柄は許容範囲と書いている。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/405583_10000048/1.1/'),
('yokuya-down-vest-harness','シーズー','small',NULL,'lining','5.4kgのシーズーに黄色のLを購入。おしゃれでかわいく、縫製もしっかりしている。裏地がもっと温かい素材なら言うことなし、という一言が添えられていた。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/405583_10000048/1.1/'),
('yokuya-down-vest-harness','ダックスフンド','small',NULL,'sizing','4kgのオスのダックスにMがぴったり。青の犬柄が気に入り、クーポンで安く買えた点も満足。太ると着られなくなるのが心配で、メス用に黄色も検討中だがSとMで迷っている。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/405583_10000048/1.1/')
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
('petfun-boa-jacket','1歳・7kgの大きめトイプードルにXXLを購入。採寸して選んだものの、胸まわりが合わずボタンが閉まらなかったという。見た目はかわいいが、これ以上大きい展開がないのが残念な様子。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/415921_10000274/1.1/','rakuten','415921_10000274:20231017:482b8f69:o20231012:s4'),
('petfun-boa-jacket','2kgのトイプードルに着せて満足している。作りがしっかりしていて、フードなど外せる部分があるのも便利。値段のわりに高級感があると書いていた。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/415921_10000274/1.1/','rakuten','415921_10000274:20231214:fad30eb2:o20231201:s5'),
('petfun-boa-jacket','寒くなってきたため、7kgのミニチュアシュナウザーの散歩用に購入。大きいかもしれないと思ってXXLを選んだところ、ちょうどよく収まった。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/415921_10000274/1.1/','rakuten','415921_10000274:20231130:482b8f69:o20231109:s4'),
('petfun-boa-jacket','5kg弱のテリアにサイズ表を確認してLを頼んだが、届いたものは小さくて着せられなかった。かわいいだけにがっかりで、作りが小さめなので1つ上のサイズを選ぶのがよさそうと振り返っている。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/415921_10000274/1.1/','rakuten','415921_10000274:20240917:482b8f69:o20240911:s2'),
('patty-knit-dogwear','首回り23cm・胴回り36cm・着丈27cmのトイプードルにLを着用。毛糸素材がよく伸びて脱ぎ着しやすい。Lはやや大きめだが問題なく、Mでも着られそうだと感じている。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/260247_10001462/1.1/','rakuten','260247_10001462:20251121:6c0859ab:o20251117:s5'),
('patty-knit-dogwear','3kgの女の子のトイプードル用に最初はMを買ったが、丈が短く感じたのでLを買い直した。Lは少しゆったりめでも満足していて、別の柄も買う予定だという。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/260247_10001462/1.1/','rakuten','260247_10001462:20241227:0df86110:o20241217:s5'),
('patty-knit-dogwear','1.8kgの小柄なトイプードルにS。ニットの縁が丸まるせいか、丈は思ったより短くお腹あたりまでだった。ただ伸縮性があって着せやすく、柄もかわいいと評価している。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/260247_10001462/1.1/','rakuten','260247_10001462:20240124:482b8f69:o20240122:s4'),
('patty-knit-dogwear','胴がやや長めの5kgのチワプーにLを着せてぴったり。首まわりがよく伸びて着せやすく、また買うつもりとのこと。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/260247_10001462/1.1/','rakuten','260247_10001462:20240208:40751010:o20240129:s5'),
('patty-knit-dogwear','2.3kgのチワワにSを選び、ちょうどよく着られた。気に入ったので再購入も考えている。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/260247_10001462/1.1/','rakuten','260247_10001462:20260116:482b8f69:o20260111:s5'),
('patty-knit-dogwear','2.4kgのチワワの飼い主。他社で買った服が小さくなったために購入し、デザインのかわいさと届く早さが助かったと書いている。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/260247_10001462/1.1/','rakuten','260247_10001462:20230122:482b8f69:o20230118:s5'),
('yokuya-down-vest-harness','3.8kgと3.3kgのトイプードル2頭にMを着せ、どちらもゆとりがあった。ただ薄手のニットを中に着せたオスは首から胸が窮屈で、ファスナーを開けて着用。ファスナーの裏に当て布があり毛が絡みにくい反面、丈がお尻近くまであるため、オスにはマナーベルトを併用している。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/405583_10000048/1.1/','rakuten','405583_10000048:20221204:5a4f8e83:o20221130:s4'),
('yokuya-down-vest-harness','4kgのヨークシャーテリアにMがちょうどよく、ハーネスより着せやすいと評価。生地が薄めで、防寒というよりウインドブレーカー感覚で使っている。ファスナーが裏地を噛みやすい点だけが惜しく、星を1つ減らしたという。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/405583_10000048/1.1/','rakuten','405583_10000048:20240221:dcc0a59c:o20231114:s4'),
('yokuya-down-vest-harness','服が苦手な2.8kgのチワワに、ゆとりのあるMを選んだ。サイズ感は問題なかった一方、金具が少し重そうに見える点が気になったとのこと。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/405583_10000048/1.1/','rakuten','405583_10000048:20231210:76b5d528:o20231204:s4'),
('yokuya-down-vest-harness','4.2kgのジャックラッセルテリアにM。背中のファスナーで脱ぎ着が楽で、首まわりは余るが胴回りと着丈はちょうどよい。色はもっとオレンジを想像していたため落ち着いた色味に感じたが、柄は許容範囲と書いている。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/405583_10000048/1.1/','rakuten','405583_10000048:20230109:482b8f69:o20230107:s5'),
('yokuya-down-vest-harness','5.4kgのシーズーに黄色のLを購入。おしゃれでかわいく、縫製もしっかりしている。裏地がもっと温かい素材なら言うことなし、という一言が添えられていた。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/405583_10000048/1.1/','rakuten','405583_10000048:20221225:c5045a33:o20221215:s5'),
('yokuya-down-vest-harness','4kgのオスのダックスにMがぴったり。青の犬柄が気に入り、クーポンで安く買えた点も満足。太ると着られなくなるのが心配で、メス用に黄色も検討中だがSとMで迷っている。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/405583_10000048/1.1/','rakuten','405583_10000048:20230722:482b8f69:o20230715:s5')
)
INSERT OR IGNORE INTO review_sources(review_id,source_type,source_url,source_platform,source_review_id)
SELECT r.id,s.source_type,s.source_url,s.source_platform,s.source_review_id
FROM new_sources s
JOIN reviews r ON r.product_id=s.product_id AND r.summary=s.summary;
