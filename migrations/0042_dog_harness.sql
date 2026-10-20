-- 犬用ハーネス（dog-harness）カテゴリの新規追加。追加のみ（既存の商品・口コミは変更しない）。
-- 口コミは楽天市場・Yahoo!ショッピングの購入者レビューを要約したもの（原文の転載なし）。Amazonレビューは使用していない。動画(YouTube)由来の4件は確認できなかったため含めない。
-- 出典監査(audit/review-source-20261018-harness/): 689件中677件について対応する公開投稿を確認し、確認できた行だけを追加する。投稿の識別情報は review_sources に登録する。販売先は楽天市場・Yahoo!ショッピング・Amazonのいずれかで確認できた商品。
-- 犬種・サイズ・毛の長さ・性格は出典に書かれている場合のみ記録し、不明な項目は NULL のままにしている。
-- 再実行しても重複しない（商品は INSERT OR IGNORE、口コミは同一商品・同一要約があれば挿入しない、review_sources は (platform, source_review_id) が一意）。D1の1文の上限に収まるよう口コミは50件ずつ挿入する。
PRAGMA foreign_keys = ON;

INSERT OR IGNORE INTO products (id, name, category, affiliate_url, active) VALUES ('julius-k9-idc-power', 'Julius-K9 IDCパワーハーネス', 'dog-harness', 'https://www.amazon.co.jp/s?k=Julius-K9+IDCパワーハーネス&tag=100things-22', 1);
INSERT OR IGNORE INTO products (id, name, category, affiliate_url, active) VALUES ('ruffwear-front-range', 'ラフウェア フロントレンジハーネス', 'dog-harness', 'https://www.amazon.co.jp/s?k=ラフウェア+フロントレンジハーネス&tag=100things-22', 1);
INSERT OR IGNORE INTO products (id, name, category, affiliate_url, active) VALUES ('puppia-soft-vest', 'PUPPIA ソフトベストハーネス', 'dog-harness', 'https://www.amazon.co.jp/s?k=パピア+ソフトベストハーネス&tag=100things-22', 1);
INSERT OR IGNORE INTO products (id, name, category, affiliate_url, active) VALUES ('petsafe-easy-walk', 'PetSafe イージーウォークハーネス', 'dog-harness', 'https://www.amazon.co.jp/s?k=イージーウォークハーネス+PetSafe&tag=100things-22', 1);
INSERT OR IGNORE INTO products (id, name, category, affiliate_url, active) VALUES ('curli-vest-air-mesh', 'Curli ベストエアメッシュハーネス', 'dog-harness', 'https://www.amazon.co.jp/s?k=curli+ベストエアメッシュハーネス&tag=100things-22', 1);
INSERT OR IGNORE INTO products (id, name, category, affiliate_url, active) VALUES ('hakusan-zero-harness', 'Hakusan ゼロハーネス', 'dog-harness', 'https://www.amazon.co.jp/s?k=Hakusan+ゼロハーネス&tag=100things-22', 1);
INSERT OR IGNORE INTO products (id, name, category, affiliate_url, active) VALUES ('petsafe-easy-walk-deluxe', 'PetSafe デラックス イージーウォークハーネス', 'dog-harness', 'https://www.amazon.co.jp/s?k=デラックス+イージーウォークハーネス+PetSafe&tag=100things-22', 1);
INSERT OR IGNORE INTO products (id, name, category, affiliate_url, active) VALUES ('buddy-belt', 'BUDDY BELT（バディーベルト）', 'dog-harness', 'https://www.amazon.co.jp/s?k=バディーベルト+ハーネス&tag=100things-22', 1);
INSERT OR IGNORE INTO products (id, name, category, affiliate_url, active) VALUES ('dogcopenhagen-comfort-walk-pro', 'DOG Copenhagen コンフォートウォークプロハーネス', 'dog-harness', NULL, 1);
INSERT OR IGNORE INTO products (id, name, category, affiliate_url, active) VALUES ('dogcopenhagen-comfort-walk-air', 'DOG Copenhagen コンフォートウォークエアハーネス', 'dog-harness', NULL, 1);
INSERT OR IGNORE INTO products (id, name, category, affiliate_url, active) VALUES ('hakusan-zero4-harness', 'Hakusan ゼロフォー（ZERO4）ハーネス', 'dog-harness', NULL, 1);
INSERT OR IGNORE INTO products (id, name, category, affiliate_url, active) VALUES ('ironbaron-honeycomb', 'アイアンバロン ハニカム胴着・アシスタントバンド（介護用）', 'dog-harness', NULL, 1);
INSERT OR IGNORE INTO products (id, name, category, affiliate_url, active) VALUES ('terubell-wonderfit', 'てるべる ワンダーフィットハーネス', 'dog-harness', NULL, 1);
INSERT OR IGNORE INTO products (id, name, category, affiliate_url, active) VALUES ('radica-cordura-harness', 'RADICA コーデュラ クラシックハーネス＆リード', 'dog-harness', NULL, 1);
INSERT OR IGNORE INTO products (id, name, category, affiliate_url, active) VALUES ('suzukoubou-standard', 'SUZUKOUBOU（すず工房）スタンダードハーネス', 'dog-harness', NULL, 1);
INSERT OR IGNORE INTO products (id, name, category, affiliate_url, active) VALUES ('happy-heel-harness', 'ラロック ハッピーヒールハーネス', 'dog-harness', NULL, 1);
INSERT OR IGNORE INTO products (id, name, category, affiliate_url, active) VALUES ('truelove-handle-harness', 'TRUELOVE ハンドル付きハーネス（前リング付き）', 'dog-harness', NULL, 1);
INSERT OR IGNORE INTO products (id, name, category, affiliate_url, active) VALUES ('funcoma-harness-lead', 'ファンコマ ハーネス＆リードセット（ベスト型）', 'dog-harness', NULL, 1);
INSERT OR IGNORE INTO products (id, name, category, affiliate_url, active) VALUES ('laluca-wear-harness', 'LaLUCA ウェアハーネス＆リード', 'dog-harness', NULL, 1);
INSERT OR IGNORE INTO products (id, name, category, affiliate_url, active) VALUES ('moncheri-harness', 'moncheri（モンシェリ）ハーネス', 'dog-harness', NULL, 1);
INSERT OR IGNORE INTO products (id, name, category, affiliate_url, active) VALUES ('thebestday-walking-belt', 'TheBestDay 犬用歩行サポートベルト（介護用）', 'dog-harness', NULL, 1);
INSERT OR IGNORE INTO products (id, name, category, affiliate_url, active) VALUES ('ruffwear-flagline', 'ラフウェア フラッグラインハーネス', 'dog-harness', NULL, 1);
INSERT OR IGNORE INTO products (id, name, category, affiliate_url, active) VALUES ('ruffwear-hi-light', 'ラフウェア ハイ＆ライトハーネス', 'dog-harness', NULL, 1);
INSERT OR IGNORE INTO products (id, name, category, affiliate_url, active) VALUES ('perros-harness', 'PERROS（ペルロス）ハーネス', 'dog-harness', NULL, 1);
INSERT OR IGNORE INTO products (id, name, category, affiliate_url, active) VALUES ('petparadise-disney-vest', 'ペットパラダイス ディズニー ベストハーネス', 'dog-harness', NULL, 1);
INSERT OR IGNORE INTO products (id, name, category, affiliate_url, active) VALUES ('petparadise-strawberry-harness', 'ペットパラダイス 苺 スカラップ襟 ハーネス＆リード', 'dog-harness', NULL, 1);
INSERT OR IGNORE INTO products (id, name, category, affiliate_url, active) VALUES ('ezydog-quick-harness', 'EzyDog（イージードッグ）クイックハーネス', 'dog-harness', NULL, 1);
INSERT OR IGNORE INTO products (id, name, category, affiliate_url, active) VALUES ('petio-zuttone-walking-hind', 'ペティオ ずっとね 老犬介護用 歩行補助ハーネス 後足用', 'dog-harness', NULL, 1);
INSERT OR IGNORE INTO products (id, name, category, affiliate_url, active) VALUES ('anisapo-harest', 'アニサポ ハーレスト（気管にやさしいハーネス）', 'dog-harness', NULL, 1);
INSERT OR IGNORE INTO products (id, name, category, affiliate_url, active) VALUES ('truelove-soft-harness', 'TRUELOVE ソフトハーネス（ハンドル付き）', 'dog-harness', NULL, 1);
INSERT OR IGNORE INTO products (id, name, category, affiliate_url, active) VALUES ('sevenbridge-dress-harness', 'セブンブリッジ ドレス ウェアハーネス＆リード', 'dog-harness', NULL, 1);
INSERT OR IGNORE INTO products (id, name, category, affiliate_url, active) VALUES ('pomporis-3way-care-harness', 'ポンポリース 3WAYケアハーネス（介護用）', 'dog-harness', NULL, 1);

WITH new_reviews(product_id,dog_breed,dog_size,coat_type,needs,summary,source_type,source_url) AS (
VALUES
('julius-k9-idc-power','柴犬',NULL,NULL,'sizing','体重12kg台後半で胴が長めの柴犬にMiniを選び、ベルトを調整してぴったり合わせられた。リードを付ける部分の強度だけは少し気になったという体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208747_10000922/1.1/'),
('julius-k9-idc-power','柴犬',NULL,NULL,'escape sizing','首輪だけだと抜けやすい柴犬（9kg）にMiniがちょうど合い、歩き方に癖があっても問題なく散歩できている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208747_10000922/1.1/'),
('julius-k9-idc-power','柴犬',NULL,NULL,'durability easy-on','8歳の柴犬で、迎えた時から同じシリーズを使い続けている。着脱が簡単で不具合もなく、気づくと数年使えているという長期使用の体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208747_10000922/1.1/'),
('julius-k9-idc-power','豆柴',NULL,NULL,'easy-on sizing','頭からかぶせるだけで着けられるので嫌がらずに装着できたが、7kg弱の豆柴にはMiniが少し大きかったという体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208747_10000922/1.1/'),
('julius-k9-idc-power',NULL,NULL,NULL,'puppy chew durability','子犬の頃に1本目を噛んで壊してしまったが、買い直した2本目は約6年使えたというリピート購入の体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208747_10000922/1.1/'),
('julius-k9-idc-power','フレンチブルドッグ2頭',NULL,NULL,'multi escape','9kgと10kgのフレブル2頭ともMiniで合ったが、調整部分が緩んでいた時に散歩中に引っ張られて抜けたことがあり、こまめな確認が必要と感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208747_10000922/2.1/'),
('julius-k9-idc-power','柴犬',NULL,NULL,'pull trachea','首輪では引っ張った時にゼイゼイと苦しそうだった5歳の柴犬（9kg弱）が、このハーネスに替えてからは苦しそうな様子がなくなった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208747_10000922/2.1/'),
('julius-k9-idc-power','ジャックラッセルテリア',NULL,NULL,'trachea','気管が細く首輪も一般的なハーネスでも咳き込んでいたジャックラッセルで、前側に少し余裕を持たせて胸下を合わせたところ、抜けずに咳もほとんど出なかった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208747_10000922/2.1/'),
('julius-k9-idc-power','トイプードル',NULL,NULL,'pull trachea sizing','引っ張り癖と軽い気管虚脱がある4.8kgのトイプードルにMiniMiniを最小に調整して使用。胸側のベルトは余り気味だが、最初は気にしていたベルトにもすぐ慣れた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208747_10000922/3.1/'),
('julius-k9-idc-power','雑種',NULL,NULL,'escape durability','洗濯機で洗っても留め具やほつれの問題は出ていないが、犬が急に後ろへ下がると簡単に抜けることがあり、先代犬（雑種14kg）は一度抜けたため首輪との併用を考えた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208747_10000922/3.1/'),
('julius-k9-idc-power','柴犬',NULL,NULL,'escape','2歳の柴犬（10kg）で3本目になるほど丈夫だと感じている一方、後ずさりすると抜けてしまうため首輪と連結して使っている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208747_10000922/3.1/'),
('julius-k9-idc-power',NULL,NULL,NULL,'durability skin','約1年半でリード金具をつなぐ部分が半分近く裂け、擦れる部分の毛も抜けてきたが、夏に別のハーネスへ替えると犬が全く歩かず、結局これに戻した体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208747_10000922/3.1/'),
('julius-k9-idc-power','ジャックラッセルテリア2頭',NULL,NULL,'senior multi trachea','シニアになり興奮して首輪で喉を締めるのを避けたくて、6kgのジャックラッセル2頭に購入。別売りのチェストパッドの付け方は分かりにくかったが、一度付ければ装着は簡単だった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208747_10000922/3.1/'),
('julius-k9-idc-power',NULL,NULL,NULL,'mobility handle','後ろ足が弱い犬で、リードの位置が背中寄りのため引いた時の前足への負担が減ったように感じ、排泄時にふらつく時は持ち手で体を支えられて便利だった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208747_10000922/2.1/'),
('julius-k9-idc-power',NULL,'large',NULL,'skin durability','40kgの大型犬で約3年使えている。脇が少し擦れるのは他のハーネスでも避けにくいと感じつつ、夜は大きな反射部分が見やすいという体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208747_10000923/1.1/'),
('julius-k9-idc-power','ラブラドールレトリバー',NULL,NULL,'scared escape sizing','首輪が外れて逃げたことがある怖がりのラブラドール（26kg）に、体重表を基準にサイズ1を選んでぴったり合い、抜ける心配がなさそうだと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208747_10000923/1.1/'),
('julius-k9-idc-power',NULL,'medium',NULL,'pull trachea','引っ張りの強い中型犬で、首輪やY字型のハーネスでもゼイゼイしていたが、このハーネスでは喉元に当たらず苦しそうな音がしなくなった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208747_10000923/1.1/'),
('julius-k9-idc-power','ダルメシアン',NULL,NULL,'pull trachea','力が強く引っ張る30kgのダルメシアンで、コントロールしやすくなり、首の締め付けがなくなってゼイゼイ言わなくなった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208747_10000923/1.1/'),
('julius-k9-idc-power','ボーダーコリー',NULL,NULL,'pull easy-on','訓練所では首輪だけだった15.8kgのボーダーコリーが、自分から頭を出して着けさせるほど気に入り、引っ張り癖もほとんど出なくなった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208747_10000923/1.1/'),
('julius-k9-idc-power','ラブラドール',NULL,NULL,'mobility','足腰が弱り首輪で足を滑らせることがあった13歳のラブラドールに使い、本人も快適そうで、もっと早く替えればよかったと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208747_10000923/2.1/'),
('julius-k9-idc-power','ラブラドール',NULL,NULL,'dislike-on sizing','1歳のラブラドールにサイズ2を選んだら首のストラップが余った。重さと大きさがあるためか装着時はテーブルの下に隠れて固まるが、着ければ散歩を喜ぶという体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208747_10000923/2.1/'),
('julius-k9-idc-power',NULL,NULL,NULL,'escape skin','装着は1か所留めるだけで簡単だが、後ろに引っ張られると抜けたことがあり、脇の下が擦れて毛玉ができたという体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208747_10000923/2.1/'),
('julius-k9-idc-power','コーギー',NULL,NULL,'skin','前のハーネスで脇や胸が赤くなっていた16kgのコーギーに使い、説明書どおりに着けると脇とベルトが離れて擦れず、引っ張られた時も安定している体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208747_10000923/2.1/'),
('julius-k9-idc-power','ラブラドールハーフ',NULL,NULL,'escape','やせ型22kgのラブラドールハーフにサイズ1。胸のベルトを一番短くしてちょうど良いが、前にまっすぐ引かれた時に抜けるのが不安で首輪と2本のリードで使っている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208747_10000923/2.1/'),
('julius-k9-idc-power','ジャーマン・シェパード',NULL,NULL,'puppy handle','9か月・30kgのシェパードで、持ち手のおかげで飛びつきや急な引っ張りを抑えやすくなった。一方、むき出しのバックルが塀に擦れて壊れないか心配という体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208747_10000923/2.1/'),
('julius-k9-idc-power','甲斐犬',NULL,NULL,'sizing dislike-on','胸だけが大きい甲斐犬でサイズ選びに苦労したが、サイズ0で合い、足を通すタイプと違って嫌がらずに着けられている体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?store_id=tsumugu-design-goods&page_key=harness-03'),
('julius-k9-idc-power',NULL,NULL,NULL,'pull escape','引っ張り癖のある犬で喉元への食い込みは減ったと感じる一方、思い切り後ろに下がると簡単に抜けること、雨上がりはお腹側が乾きにくいことが気になった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?store_id=tsumugu-design-goods&page_key=harness-03'),
('julius-k9-idc-power','柴犬',NULL,NULL,'handle escape','3.9kgの柴犬でも緩くならずに使え、ドッグランで捕まえる時に持ち手が便利。ただし強く引かれた時や持ち手で抱き上げた時に抜けることがあると注意している体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?store_id=flaner-y&page_key=f10021127'),
('ruffwear-front-range','ラブラドール',NULL,NULL,'pull trachea','興奮すると強く引っ張り首輪だけでは喉を圧迫していた2歳のラブラドール（21kg）で、体をしっかり支えつつ当たりが柔らかく、価格に見合うと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/266503_10000952/1.1/'),
('ruffwear-front-range',NULL,NULL,NULL,'puppy pull','生後6か月ほどの元野犬（15.5kg）にSサイズを合わせ、胸側のループにリードを付けると引っ張りが少し軽くなったと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/266503_10000952/1.1/'),
('ruffwear-front-range','トイプードル',NULL,NULL,'escape clothes','まだ若く散歩中にちょろちょろ動く4.7kgのトイプードルにXXSがぴったりで、調整して冬服の上からでも着けられた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/266503_10000952/1.1/'),
('ruffwear-front-range','パグ',NULL,NULL,'stiff','9kgちょっとのパグにXSを選び、サイズにはまだ余裕があるがパッド部分が硬く感じたという体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/266503_10000952/1.1/'),
('ruffwear-front-range','ビションフリーゼ',NULL,NULL,'puppy easy-on','6.5か月のビションで丈夫さには安心したが、頭を通す前にアジャスターを緩め、通した後に締め直す作業が毎回面倒だったという体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/266503_10000952/1.1/'),
('ruffwear-front-range','柴犬',NULL,NULL,'dislike-on','3.4kgの柴犬にXXSを着けたところ、前のハーネスより重く感じたのか固まって動けず、少しずつ慣らしているという体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/266503_10000952/1.1/'),
('ruffwear-front-range','ボーダーコリー',NULL,NULL,'escape sizing outdoor','山歩きで何度使っても抜けたことがない。同じ17kgでも、毛量が少なく細身の子はS、胸ががっしりした子はMと、体格でサイズが分かれた多頭飼いの体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/266503_10000952/1.1/'),
('ruffwear-front-range','パグ',NULL,NULL,'skin','劣化したハーネスで皮膚が赤くなったパグ（8.7kg）に替え、当たりが柔らかく、名前欄や迷子札入れ、ライト用の輪など機能が多くて便利だった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/266503_10000952/1.1/'),
('ruffwear-front-range','柴犬',NULL,NULL,'escape','前足が細長く頭が小さいため首輪もひも状のハーネスも抜けやすかった10kgの柴犬で、探した末にこれに落ち着きリピートしている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/266503_10000952/1.1/'),
('ruffwear-front-range','ミニチュアシュナウザー',NULL,NULL,'puppy pull trachea dislike-on','引っ張り癖でいつもゼーゼーしていた9か月のシュナウザー。人気の別製品は断固拒否したが、これは怪訝な顔をしつつも散歩に行け、引っ張る回数も減った体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/266503_10000952/2.1/'),
('ruffwear-front-range','柴犬',NULL,NULL,'puppy escape','引っ張りと後ずさりがあり他のハーネスでは何度も抜けた7か月の柴犬（9.6kg）で、何度後ずさりしても抜けなかった。首回りの調整が毎回必要な点は面倒という体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/266503_10000952/2.1/'),
('ruffwear-front-range','豆柴',NULL,NULL,'puppy sensitive','いつもと違うことに敏感な9か月の豆柴で、ハーネスだけならドッグランで楽しく走れたが、リードを付けると転げ回って鳴き、リードの金具音も気にしていた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/266503_10000952/2.1/'),
('ruffwear-front-range','ゴールデンレトリバー',NULL,NULL,'pull skin','胸毛が多い34kgのゴールデンにL/XLを選び、引っ張り抑制用の前側ループにリードを付けると引っ張りがかなり減り、パッドのおかげで擦れの心配もない体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/266503_10000952/2.1/'),
('ruffwear-front-range',NULL,NULL,NULL,'stiff escape','8kg弱の小型犬にはコルセットのように硬く、特に肩まわりがごわつくため一部を外して工夫したが、その硬さのおかげで急にバックしても抜けないと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/266503_10000952/2.1/'),
('ruffwear-front-range','秋田犬',NULL,NULL,'outdoor','顔が大きい40kgの秋田犬で、肩まわりを合わせると頭が入りにくいが少し緩めても抜けなさそう。キャンプで数日着けっぱなしでも当たりが優しいという体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/266503_10000952/2.1/'),
('ruffwear-front-range',NULL,NULL,NULL,'escape','着けた初日は戸惑った顔だったが翌日には慣れた。ただ前足を踏ん張った状態で前に引いたら抜けてしまい、ベルトを合わせ直したという体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/266503_10000952/2.1/'),
('ruffwear-front-range',NULL,NULL,NULL,'scared escape outdoor','人慣れしない元野犬（14kg）に使い、びっくりして後ずさりしても抜けず、迎えて2年でようやく野山を楽しめるようになった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/266503_10000952/2.1/'),
('ruffwear-front-range',NULL,NULL,NULL,'escape sizing','トリミングで毛が短くなりJulius-K9が抜けやすくなったため替えたところ、H型で抜けにくく喉も締めないが、止まった状態で合わせても歩くと緩むなどサイズ調整は難しかった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/266503_10000952/3.1/'),
('ruffwear-front-range','トイプードル2頭',NULL,NULL,'multi escape','3.5kgと5.2kgのトイプードルにXXSとXSを使い、首回りが少し大きくても後ろに引かれて抜けることはなく、迷子札入れや名前欄も便利だった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/266503_10000952/3.1/'),
('ruffwear-front-range','フレンチブルドッグ',NULL,NULL,'neck pull','頸椎のヘルニアがあり首に負担をかけたくない8.6kgのフレブルで、前側の引っ張り防止リングも使える一方、首が太く毎回サイズ調整が必要で価格も高めと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?store_id=torusdogmartyokohama&page_key=ruffwear-frontrange-harness'),
('ruffwear-front-range','ジャックラッセルテリア',NULL,NULL,'skin pull','以前のハーネスで引っ張ると首の下が赤くなり毛も抜けた5.6kgのジャックラッセルに替え、安定感があると感じたが、バックルは硬めで慣れるまで扱いにくかった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?store_id=torusdogmartyokohama&page_key=ruffwear-frontrange-harness'),
('ruffwear-front-range','柴犬',NULL,NULL,'senior trachea','シニアになり首輪だけでは喉に負担がかかると考えて10歳の柴犬（11kg）に使用。頭を通す部分はやや狭いが、その分抜けにくいと感じている体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?store_id=torusdogmartyokohama&page_key=ruffwear-frontrange-harness')
)
INSERT INTO reviews(product_id,dog_breed,dog_size,coat_type,needs,summary,source_type,source_url)
SELECT n.product_id,n.dog_breed,n.dog_size,n.coat_type,n.needs,n.summary,n.source_type,n.source_url
FROM new_reviews n
WHERE NOT EXISTS (
  SELECT 1 FROM reviews r
  WHERE r.product_id=n.product_id
    AND r.summary=n.summary
);

WITH new_reviews(product_id,dog_breed,dog_size,coat_type,needs,summary,source_type,source_url) AS (
VALUES
('ruffwear-front-range','アメリカンコッカースパニエル',NULL,NULL,'pull','気になる犬や鳥を見ると突然ダッシュし、前年に引っ張られて大けがをした11kgのアメリカンコッカーで、ようやく合うハーネスが見つかったと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?store_id=torusdogmartyokohama&page_key=ruffwear-frontrange-harness'),
('puppia-soft-vest','ミニチュアダックスフンド',NULL,NULL,'mobility easy-on','足元が少しふらつく17歳・3.7kgのミニチュアダックスで、着脱が簡単なのが助かった。Mでは少し大きかったという体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/230805_10000752/1.1/'),
('puppia-soft-vest','カニンヘンダックスフンド',NULL,NULL,'sizing clothes','胴回り36cm・4.5kgのカニンヘンダックスで、服の上から用のLは大きすぎ、服なし用のMはベルトに余裕がなくマジックテープで緩められなかった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/230805_10000752/1.1/'),
('puppia-soft-vest',NULL,NULL,NULL,'trachea','気管虚脱があり、メガネ型のハーネスではえずいていたが、気管に当たる布地が広いこのタイプに替えて少し楽になった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/230805_10000752/1.1/'),
('puppia-soft-vest','ミニチュアシュナウザー',NULL,NULL,'puppy escape sizing','7か月・7.3kgのシュナウザーにXLを選んだら一番締めても胸が浮き、トリミング後はさらに緩く、自転車に興奮した時に脱げてしまった。Lにすべきだったという体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/230805_10000752/1.1/'),
('puppia-soft-vest','チワワ・日本テリア',NULL,NULL,'multi chew','チワワは経年劣化で買い替える程度に長持ちした一方、日本テリアは少し噛んだだけで噛み破ってしまったという体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/230805_10000752/1.1/'),
('puppia-soft-vest','ポメラニアン×チワワ',NULL,NULL,'puppy escape','4か月・2kg未満の子犬にSを着けたところ、1週間で何度か脱げてしまい、XSの買い足しを考えている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/230805_10000752/1.1/'),
('puppia-soft-vest','ボストンテリア',NULL,NULL,'pull','かなり引っ張る3歳のボストンテリアでも外れたことはなく洗えて便利だが、抜け毛がよく付き、においも付きやすいという体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/230805_10000752/1.1/'),
('puppia-soft-vest','シュナプー',NULL,NULL,'escape','6.5kgのシュナプーにXL。前足を入れる穴が大きく散歩中に一度抜けたが、マジックテープをきつめに調整し直してからは抜けていない体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/230805_10000752/1.1/'),
('puppia-soft-vest',NULL,NULL,NULL,'escape','色違いで4つ目のリピート。サイズが大きいと踏ん張った時に首から抜けるので、苦しくない範囲できつめに着けている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/230805_10000752/1.1/'),
('puppia-soft-vest',NULL,NULL,NULL,'pull noise sensitive','グイグイ歩く12kgの犬でXLは小さくXXLに交換。首元の圧迫が少ない一方、強力なマジックテープを外す音に音に敏感な犬が少し驚くという体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/230805_10000752/1.1/'),
('puppia-soft-vest','トイプードル',NULL,NULL,'noise sizing','7kgのトイプードルにXLは少し大きかった。マジックテープのバリバリ音を嫌がって暴れたが、ゆっくり少しずつはがすと大丈夫になった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/230805_10000752/1.1/'),
('puppia-soft-vest','パピヨン',NULL,NULL,'puppy noise','5か月・2.8kgのパピヨンにSがちょうど良く、マジックテープを外す音には一瞬驚いていたという体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/230805_10000752/2.1/'),
('puppia-soft-vest',NULL,NULL,NULL,'neck','首のヘルニアになった犬で、首に負担がかかりにくい形として選び、治療で散歩に行けるようになってからも嫌がらずに使えている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/230805_10000752/2.1/'),
('puppia-soft-vest',NULL,NULL,NULL,'chew','ひも状のハーネスはどうしても噛んでしまう3.2kgの犬で、体にフィットするベストタイプにしたらすんなり散歩に行けた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/230805_10000752/2.1/'),
('puppia-soft-vest',NULL,NULL,NULL,'durability','体にぴったり合って抜けずに使えているが、使ううちにマジックテープが効きにくくなるので消耗品として買い替えているという体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/230805_10000752/2.1/'),
('puppia-soft-vest','トイプードル',NULL,NULL,'sizing','首回り21cm・胴回り36cmの華奢なトイプードルで、Sは胴がきつくMにしたらあご下に余裕ができた。背中のマジックテープで首回りを詰めて使っている体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?store_id=best-friends&page_key=puppia-harness002'),
('puppia-soft-vest',NULL,NULL,NULL,'puppy scared escape noise','人や音に怯える3〜4か月の元野犬の子犬でLは大きく、マジックテープの音にも怖がる。一度すり抜けたので、ハーネスだけの散歩は避けた方がよいと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?store_id=best-friends&page_key=puppia-harness002'),
('puppia-soft-vest','ポメラニアン',NULL,NULL,'sizing','4歳・4kgのポメラニアンで、トリミング前の毛量が多い時期用のLは抜けないか少し不安、Mはきつめだが安心感があるという体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?store_id=best-friends&page_key=puppia-harness002'),
('puppia-soft-vest','ミニチュアダックスフンド',NULL,'long',NULL,'胸が前に張っていない4.6kgのロングのミニチュアダックスに合い、軽くて洗ってもすぐ乾くので色違いで買い足した体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?store_id=best-friends&page_key=puppia-harness002'),
('puppia-soft-vest','ロングコートチワワ2頭',NULL,'long','multi dislike-on','2.2kgと1.6kgのロングコートチワワにSとXS。軽く、着脱を嫌がる犬でも着けやすく、首への負担も少ないと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?store_id=best-friends&page_key=puppia-harness002'),
('puppia-soft-vest','ミニチュアピンシャー',NULL,NULL,'clothes sizing','2.8kgのミニピンにM。首回りは大きいが脱げることはなさそうで、冬のアウターの上からも使えそうだという体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?store_id=best-friends&page_key=puppia-harness002'),
('petsafe-easy-walk',NULL,NULL,NULL,'pull skin','以前使っていたデラックス版より肌当たりが気になり、服を着せずに使うと赤くなる。ただ他のものに替えると引っ張ってしまうので使い続けているという体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/284187_10031274/1.1/'),
('petsafe-easy-walk','シベリアンハスキー',NULL,NULL,'pull skin','チョーカーで散歩していた23kgのハスキーで、引っ張る力が半分ほどになった一方、脇が擦れて血が出たため当て布を考えたという体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/284187_10031274/1.1/'),
('petsafe-easy-walk','ラブラドール4頭',NULL,NULL,'pull multi','引っ張られて捻挫や転倒を繰り返していたラブラドール4頭の家庭で、着けると引っ張らなくなり、1人で4頭の散歩もできそうだと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/284187_10031274/1.1/'),
('petsafe-easy-walk','ダックスフンド',NULL,NULL,'pull','しつけ教室でも直らなかった4.3kgのダックスの引っ張りが、着けた途端に止まり驚いたという体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/284187_10031274/1.1/'),
('petsafe-easy-walk','柴犬',NULL,NULL,'pull','トレーナーに勧められて使っている10kgの柴犬で、引っ張り癖自体は直らないが散歩はしやすくなったという体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/284187_10031274/1.1/'),
('petsafe-easy-walk','ゴールデンドゥードル',NULL,NULL,'pull reactive','8歳になりほとんど引っ張らなくなったが、吠えられると向かっていってしまう42kgのゴールデンドゥードルのため手放せないという体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/284187_10031274/1.1/'),
('petsafe-easy-walk','コーギー',NULL,NULL,'pull sizing','引っ張りの強い9kgのコーギーで、持っているJulius-K9より引っ張り対策には効果がありそうと感じた。サイズの境目で小さい方を選び、少し小さかった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/284187_10031274/1.1/'),
('petsafe-easy-walk',NULL,'small',NULL,'pull escape scared','腰の手術後の家族と歩くために購入し、引く力がほとんどかからなくなった。ただ4kgの小型犬で、胸下のひもを短くしないと臆病で興奮した時に片足が抜けてしまう体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/284187_10031274/1.1/'),
('petsafe-easy-walk','セントバーナード・バーニーズ・ミックス犬',NULL,NULL,'pull multi','普段はおとなしいが興奮すると引っ張るセントバーナードとバーニーズ、ミックスの子犬にそれぞれ使い、どの子にも合ったという体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/284187_10031274/1.1/'),
('petsafe-easy-walk','トイプードル',NULL,NULL,'pull','3.3kgのトイプードルで、引っ張ると止まるようになったが、そこから前に進まなくなることもあり慣れを待っている体験。頭を通さずに着けられる点は楽だった。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/284187_10031274/1.1/'),
('petsafe-easy-walk',NULL,NULL,NULL,'pull','使い始めの勢いよく走った時に派手に転んだが、その後は注意して歩くようになり、少し前を歩くもののグイグイ引くことはおさまった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/284187_10031274/1.1/'),
('petsafe-easy-walk',NULL,NULL,NULL,'scared pull skin','ビビりで引っ張りの強い保護犬で、引く力が半分になった一方、脇が赤くなったためフェルトのカバーを付け、緩む胸の部分は縫い留めた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/284187_10031274/1.1/'),
('petsafe-easy-walk','グレートピレニーズ',NULL,NULL,'puppy pull','人や自転車を見ると走り出す7か月・33kgのピレニーズで、最初は着けるのに苦労したが、引っ張りが8割ほど減り片手でも制御できるようになった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/284187_10031274/1.1/'),
('petsafe-easy-walk','雑種',NULL,NULL,'pull sizing','15kgの雑種で、前側を一番小さくしてもまだ少し大きい。引き返す力は半分ほどで済むが、胸にリードを付けるのでたるむと地面に付きやすいという体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/284187_10031274/1.1/'),
('petsafe-easy-walk','ゴールデンレトリバー','large',NULL,'pull skin','しつけ教室でも直らなかった1歳・31kgの大型犬（ゴールデン）が片手で持てるほどになったが、脇の下が擦れて赤くなるため当て布などの工夫が必要な体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?store_id=countryfield&page_key=ps-ewhbulk'),
('petsafe-easy-walk','ミニチュアピンシャー',NULL,NULL,'pull skin durability','ハーフチョークで首の毛が薄くなった6歳のミニピンで、興奮時以外は引っ張らなくなった。脇が赤くなる時があり、半年で胸の調整金具が緩みやすくなった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?store_id=countryfield&page_key=ps-ewhbulk'),
('petsafe-easy-walk',NULL,'large',NULL,'escape','後ろに引いてハーネスを脱いでしまう30kgの大型犬の保護犬で、胴回りがしっかり固定され脱げることはなかった。緩みやすいという声を見て調整部を縫い留めた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?store_id=countryfield&page_key=ps-ewhbulk'),
('petsafe-easy-walk',NULL,NULL,NULL,'pull skin','脇にかなり食い込んでいるように見え、引っ張れない分いら立つのか歩くのをやめてじゃれついてくるようになり、うちの犬には合わないかもしれないと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?store_id=countryfield&page_key=ps-ewhbulk'),
('petsafe-easy-walk','ゴールデンレトリバー',NULL,NULL,'puppy trachea','上の2頭は引っ張り癖がすぐ直ったが、5か月の子犬では引っ張らないのに咳き込むことが多く、小さな体には合わないかもしれないと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?store_id=glv&page_key=pts-90'),
('petsafe-easy-walk',NULL,NULL,NULL,'pull','引っ張りの強さはハーフチョークを10とすると4ほど。胸にリードがあるので散歩中にリードを噛まれることがあり、長い散歩には別の道具と使い分けている体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?store_id=glv&page_key=pts-90'),
('petsafe-easy-walk','キャバリア',NULL,NULL,'pull','爪が削れて出血するほど引っ張っていた1歳・8.8kgのキャバリアで、動物病院で勧められて使うと引っ張りがほとんどなくなった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?store_id=glv&page_key=pts-90'),
('petsafe-easy-walk',NULL,NULL,NULL,'skin','引っ張りは抑えられたが、服を着せても脇が擦れて赤くなり痛々しいため使用をやめたという体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?store_id=glv&page_key=pts-90'),
('curli-vest-air-mesh','ミニチュアダックスフンド',NULL,NULL,'escape trachea','以前のハーネスは抜けやすく、興奮して引くとむせていた6.7kgのミニチュアダックスで、Mがぴったり合い生地も丈夫だった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000879/1.1/'),
('curli-vest-air-mesh','チワックス・ポメックス',NULL,NULL,'puppy multi','2〜3kgの子犬2頭に2XSがちょうど良く、作りもしっかりしていたという体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000879/1.1/'),
('curli-vest-air-mesh','チワワ',NULL,NULL,'escape pull','首抜けしやすいチワワで、このハーネスにしてから抜けたことがなく、引っ張り癖があっても苦しそうにしないため5回リピートしている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000879/1.1/'),
('curli-vest-air-mesh','黒豆柴',NULL,NULL,NULL,'体に当たる部分が柔らかい素材だけのものを探していた7.8kgの黒豆柴で、預け先で一日中着けっぱなしになることが多くても使いやすいと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000879/1.1/'),
('curli-vest-air-mesh','チワワ',NULL,'short','escape','スムースのチワワで、体にフィットしマジックテープで調整でき、抜けにくく軽いので繰り返し購入している体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000879/1.1/'),
('curli-vest-air-mesh','トイプードル',NULL,NULL,'sizing clothes','9kgのプードルで、新しいタイプのMは旧タイプのSと同じくらいきつくLに交換。新しいものは伸縮性が少ないように感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000879/1.1/')
)
INSERT INTO reviews(product_id,dog_breed,dog_size,coat_type,needs,summary,source_type,source_url)
SELECT n.product_id,n.dog_breed,n.dog_size,n.coat_type,n.needs,n.summary,n.source_type,n.source_url
FROM new_reviews n
WHERE NOT EXISTS (
  SELECT 1 FROM reviews r
  WHERE r.product_id=n.product_id
    AND r.summary=n.summary
);

WITH new_reviews(product_id,dog_breed,dog_size,coat_type,needs,summary,source_type,source_url) AS (
VALUES
('curli-vest-air-mesh',NULL,NULL,NULL,'durability','サイズ調整部分がマジックテープのため、ベルトとマジックテープが当たって擦れるところが少し気になったという体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000879/1.1/'),
('curli-vest-air-mesh','チワワ',NULL,NULL,'sizing clothes','胸回り36cmのチワワにXSでマジックテープの範囲ぎりぎり。冬に厚手の服を着るときつく、マジックテープの持ちも気になるという体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000879/1.1/'),
('curli-vest-air-mesh','マルチーズ×チワワ',NULL,NULL,'clothes','冬服の上から使えるものを探していた3.4kgのマルチワにSがちょうど良く、ごわつかずしなやかだが丈夫で色違いでも購入した体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000879/1.1/'),
('curli-vest-air-mesh','ポメラニアン×チワワ',NULL,NULL,'sizing','毛が多く胸板が厚い3.1kgのポメチワにXS。調整幅は広くないので、胸板が厚い犬は1サイズ上も検討するとよいと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000879/1.1/'),
('curli-vest-air-mesh',NULL,NULL,NULL,'sizing','旧タイプと同じSを選んだが新しいものは全体に少し小さく、生地も硬く薄くなったように感じたという体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000879/1.1/'),
('curli-vest-air-mesh','トイプードル',NULL,NULL,'sizing','肩ががっしりし胸板の厚い1.9kgのトイプードルで、3XSではマジックテープがほぼ留まらず2XSに交換。着脱がとても楽だった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000879/1.1/'),
('curli-vest-air-mesh','スピッツ',NULL,NULL,'durability','8kgのスピッツにL。柔らかく、濡らしてクールベストのようにも使え、約1年使って少し伸びてきたため買い替えた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000879/2.1/'),
('curli-vest-air-mesh','トイプードル',NULL,NULL,'sizing','3.6kgのトイプードルにXSは胸がきつそうでSに交換。胸のマジックテープ以外はあまり調整がきかないのでサイズ選びが大事だと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000879/2.1/'),
('curli-vest-air-mesh','ポメラニアン',NULL,NULL,'easy-on','3.5kgのポメラニアンにS。他のハーネスより毛が付きにくく、これまで手こずっていた着脱が簡単になった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000879/2.1/'),
('curli-vest-air-mesh','チワワ×スピッツ',NULL,NULL,'puppy escape','4か月の子犬にXS。マジックテープが弱めで気づくと浮いており、後ずさりした時に抜けて危なかったため、強いテープに付け替えると決めた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?store_id=1stdogcafe&page_key=10000879'),
('curli-vest-air-mesh','チワワ2頭',NULL,NULL,'multi escape','胴囲38〜39cmのチワワ2頭にS。装着時に強く引いて試しても抜けず、引いた時の負担も少ないと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?store_id=1stdogcafe&page_key=10000879'),
('curli-vest-air-mesh','トイプードル',NULL,NULL,'puppy','4か月・1.6kgの子犬で、外れて事故にならないよう軽くて頑丈なものを探し、サイズがぴったり合ったという体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?store_id=1stdogcafe&page_key=10000879'),
('hakusan-zero-harness','トイプードル',NULL,NULL,'sizing clothes easy-on','首が細く胴回り40cmほどの5.8kgのトイプードルにXXSがぴったり。首と胴を別々に調整でき、頭を通して両脇のバックルを留めるだけなので楽な体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000685/1.1/'),
('hakusan-zero-harness','ミニチュアダックスフンド',NULL,NULL,'clothes escape','5kgのミニチュアダックスにXXS。冬服の上からでも調整の余裕があり、抜けることもなく、裏のクッションも良かった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000685/1.1/'),
('hakusan-zero-harness','トイプードル',NULL,NULL,'trachea easy-on','3.3kgのトイプードルで散歩時のむせがなくなり、足を上げずに着脱できるので嫌がらず、散歩も楽しそうになった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000685/1.1/'),
('hakusan-zero-harness','柴犬',NULL,NULL,'dislike-on','9kgの柴犬で、最初はとても嫌がったが今では慣れてすんなり歩けているという体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000685/1.1/'),
('hakusan-zero-harness','イタリアングレーハウンド',NULL,NULL,'sizing skin','首が細いイタグレで首回りは一番細くしても余裕があるが、そこそこ引っ張っても左右にずれず脇にも当たらない。心配なので首輪と併用している体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000685/1.1/'),
('hakusan-zero-harness','柴犬',NULL,NULL,'trachea','気管支炎で咳が出るため獣医師に胸元がY字のものを勧められ、11.5kgの柴犬にS。クッションで負担は少なそうだが、思ったよりごつさを感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000685/1.1/'),
('hakusan-zero-harness','柴犬',NULL,NULL,'puppy dislike-on','ハーネス嫌いで困っていた6か月の柴犬が、ようやく嫌がらずに着けてくれるようになった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000685/1.1/'),
('hakusan-zero-harness',NULL,NULL,NULL,'durability','柔らかく肩の動きを妨げない作りで子犬やシニアにも向きそうだと感じた一方、半年を目安に買い替えるよう案内されており、素材からもそのくらいの強度だと思った体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000685/1.1/'),
('hakusan-zero-harness','サモエド',NULL,NULL,'sizing','21kgのサモエドに胸囲からLを選んだら大きく、Mに交換してちょうど良くなった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000685/2.1/'),
('hakusan-zero-harness','ジャックラッセルテリア',NULL,NULL,'escape sizing','8.5kgのジャックラッセルで、XSを一番きつくしても緩めになり、しばらくすると抜けるようになったためXXSに買い替えた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000685/2.1/'),
('hakusan-zero-harness','トイプードル',NULL,NULL,'escape trachea','2.8kgのトイプードルにTinyを一番きつく調整して使用。着脱のたびにベルト調整が必要で面倒だが、後ずさりしても外れなさそうで、以前のようなむせも減った体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000685/2.1/'),
('hakusan-zero-harness','フレンチブルドッグ',NULL,NULL,'sizing clothes','12kg弱のフレブルにXSを最大に伸ばしてぴったり。薄い服ならぎりぎりで、冬のもこもこ服の上からは無理だった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000685/2.1/'),
('hakusan-zero-harness','ミニチュアピンシャー',NULL,NULL,'puppy escape skin','服を上手に脱いでしまう10か月・3kg弱のミニピンで、肌も弱いためハーネスを色々試しており、初日の散歩では良さそうだと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000685/2.1/'),
('hakusan-zero-harness','フレンチブルドッグ',NULL,NULL,'skin','前のハーネスで皮膚が荒れた8.5kgのフレブルにXS。体側の素材が柔らかく擦れもなく、外れる心配もないと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000685/2.1/'),
('hakusan-zero-harness','ゴールデンレトリバー',NULL,NULL,'escape','32kgのゴールデンで、首を調整しても少し緩いが抜けることはなく安心して使えている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000685/2.1/'),
('hakusan-zero-harness',NULL,NULL,NULL,'sizing escape','首と胴の差が大きい16kgのハウンド系の犬で首はぶかぶかになり、背中の持ち手も手を通しにくいため、首輪と併用している体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000685/2.1/'),
('hakusan-zero-harness',NULL,NULL,NULL,'escape','突然の後ずさりで首抜け事故があった11kg弱の犬にXS。後ずさりした時にリードの付け根がめくれ上がりひやっとしたが、首と胴をぴったり合わせていれば抜けないと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?store_id=1stdogcafe&page_key=10000685'),
('hakusan-zero-harness',NULL,NULL,NULL,'scared escape trachea','車や物音に驚いて急に引いたり後ずさりしたりする1歳・14kgの保護犬で、前のハーネスのようにむせることがなく、体に沿うので後ずさりしても抜けなかった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?store_id=1stdogcafe&page_key=10000685'),
('hakusan-zero-harness','フレンチブルドッグ',NULL,NULL,'skin','脇の下に帯が来るハーネスで毛が擦れて剥げたフレブルに替え、脇に帯が来ず短毛にも優しい一方、飼い主が前に出て促す時にリードの付け根がめくれて安定しにくいと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?store_id=1stdogcafe&page_key=10000685'),
('hakusan-zero-harness','コーギー',NULL,NULL,'durability','短足でお腹側が汚れやすく頻繁に洗う10kg弱のコーギーで、半年過ぎから擦り洗いする部分の生地が薄くなったが、切れたり外れたりはなかった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?store_id=1stdogcafe&page_key=10000685'),
('hakusan-zero-harness','シーズー',NULL,NULL,'trachea clothes','気道の圧迫が気になっていた9.5kg以上のシーズーで、冬は服の上から着けるためSを選び、圧迫感が軽くなった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?store_id=1stdogcafe&page_key=10000685'),
('hakusan-zero-harness','ヨークシャーテリア',NULL,NULL,'puppy escape','体が柔らかく服もすぐ脱いでしまう11か月のヨーキーが、前のハーネスを原っぱで脱いでしまったため探し、このハーネスは良かったという体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?store_id=1stdogcafe&page_key=10000685'),
('hakusan-zero-harness',NULL,'large',NULL,'neck','年齢が上がってきたため首輪から切り替えた27kgの大型犬にLがぴったり。素材が柔らかく、スムーズに歩いてくれた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?store_id=1stdogcafe&page_key=10000685'),
('hakusan-zero-harness',NULL,'small',NULL,'trachea sizing','気管虚脱と心臓病があり気管に優しく抜けにくいものを探した小型犬で、一番小さいサイズでも少し大きく、リードを付けると首まわりがもたつくと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?store_id=1stdogcafe&page_key=10000685'),
('julius-k9-idc-power','柴犬',NULL,NULL,'dislike-on','ハーネス嫌いで2人がかりでも噛みつかれそうになっていた9.6kgの柴犬で、頭を通すだけで首輪並みに簡単に着けられ、散歩前のストレスが減った体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000348/1.1/'),
('julius-k9-idc-power','トイマンチェスターテリア',NULL,NULL,'scared clothes easy-on','普段はあまり引かないが怖がりで急に強く引くことがある5kgのトイマンチェスターに、冬服を考えてMiniMiniを選び、着脱がとても簡単だった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000348/1.1/'),
('julius-k9-idc-power','ビーグル',NULL,NULL,'sizing','胸囲49cm・9kgのビーグルでMiniMiniとMiniに迷い、ジャストより少し大きい方が使いやすいという助言を受けて選んだ体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000348/1.1/'),
('julius-k9-idc-power','柴犬',NULL,NULL,'pull trachea dislike-on','首輪も嫌がり、引っ張ると気管が締まるような音がしていた1歳前の柴犬で、首と胴にバックルがある胴輪は着けるのが大変だったため、このハーネスに替えた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000348/1.1/'),
('julius-k9-idc-power',NULL,NULL,NULL,'puppy handle easy-on','胸のマジックテープを一度合わせれば、かぶせて前足の後ろで留めるだけで数秒。暴れ回る子犬を止める時に背中の持ち手が便利だった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000348/1.1/'),
('julius-k9-idc-power','パグ・トイプードル',NULL,NULL,'multi easy-on','7kgのパグにMiniMini、4kgのトイプードルにBaby2を選び、どちらもサイズが合い、最初に調整すれば着脱は簡単で軽いと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000348/2.1/'),
('julius-k9-idc-power','柴犬',NULL,NULL,'easy-on sizing','胸囲約40cm・6.5kgの小柄な柴犬にMiniMiniがぴったりで、前足を通すタイプのハーネスから替えた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000348/2.1/'),
('julius-k9-idc-power','柴犬',NULL,NULL,'pull trachea','以前のハーネスは引くと喉に当たり、散歩後に喘息のような息をしていた8か月・12kg弱の白柴で、喉に当たりにくいものとしてMiniに替えた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000348/2.1/'),
('julius-k9-idc-power','アメリカンコッカースパニエル',NULL,NULL,'escape sizing','8kgのアメリカンコッカーにMini。脇下のベルトを一番小さくしても少し緩く、引くとハーネスが動き、頭側に引いた時に抜けることも気にしている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000348/2.1/'),
('julius-k9-idc-power','フレンチブルドッグ',NULL,NULL,'pull easy-on','引く力が強い12kgのフレブルで、作りが頑丈そうなうえ、脚を持ち上げずに着けられるので、散歩前に興奮していても手早く装着できる体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000348/3.1/'),
('julius-k9-idc-power','ミックス',NULL,NULL,'sizing clothes','首が細く胴が太いミックス犬で、サイズ調整できることが必須条件だったが、ぴったり合わせられ、服を着た時と脱いだ時でも調整できる体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208747_10001359/1.1/'),
('julius-k9-idc-power','柴犬',NULL,NULL,'pull trachea','引っ張りがひどく喉をゼイゼイ鳴らしていた10か月の柴犬で、着けやすく、リードの引きもほとんど感じなくなり、犬も楽そうに歩くようになった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208747_10001359/1.1/'),
('julius-k9-idc-power',NULL,NULL,NULL,'trachea dislike-on','冬毛で首回りが苦しいのか首輪で咳き込むようになったため替えたところ、散歩中の咳はなくなったが、まだ慣れず着けたがらないという体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208747_10001359/2.1/'),
('julius-k9-idc-power','日本スピッツ',NULL,NULL,'sizing','毛量が多くサイズ表や参考犬種どおりでは合いにくい12kgの日本スピッツで、価格は高いがようやく安心して使えるものが見つかったと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208747_10001359/2.1/')
)
INSERT INTO reviews(product_id,dog_breed,dog_size,coat_type,needs,summary,source_type,source_url)
SELECT n.product_id,n.dog_breed,n.dog_size,n.coat_type,n.needs,n.summary,n.source_type,n.source_url
FROM new_reviews n
WHERE NOT EXISTS (
  SELECT 1 FROM reviews r
  WHERE r.product_id=n.product_id
    AND r.summary=n.summary
);

WITH new_reviews(product_id,dog_breed,dog_size,coat_type,needs,summary,source_type,source_url) AS (
VALUES
('julius-k9-idc-power','ビションプー',NULL,NULL,'puppy sizing clothes','生後5か月・4.4kgのビションプーにMiniMini。一番小さくしても少し大きいが、これからの成長や冬服を考えるとちょうど良いと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208747_10001359/2.1/'),
('julius-k9-idc-power','黒柴',NULL,NULL,'escape sizing','顔が細く首輪も抜けやすい、10歳を迎える7.4kgの黒柴で、周りの柴犬と同じサイズにするか迷い、ショップに相談してサイズを決めた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208747_10001359/2.1/'),
('julius-k9-idc-power','ボーダーコリー',NULL,NULL,'pull handle','車や人に向かって引くことが多い13kgの小さめのボーダーコリーで、制止しやすくなり、犬もあまり苦しくなさそうな体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208747_10001359/2.1/'),
('julius-k9-idc-power','コーギー',NULL,NULL,'sizing skin','8.3kgのコーギーにMiniMiniを選んだが、胴回りが少しきつく脇が擦れる不安があったためMiniに交換した体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208747_10001359/3.1/'),
('julius-k9-idc-power','キャバリア2頭',NULL,NULL,'multi durability','10kgと6kgのキャバリアに使い、やんちゃな下の子では4年半ほどでリード金具が付いた布部分が取れてしまったため買い替えた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208747_10001359/3.1/'),
('petsafe-easy-walk-deluxe','ゴールデンレトリバー',NULL,NULL,'puppy pull','急に走り出す引っ張りで飼い主が肩と膝を痛めた9か月・30kgのゴールデン。初めてのハーネスで最初は噛んでいたが、散歩に出ると気にせず歩けた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/202898_10088682/1.1/'),
('petsafe-easy-walk-deluxe','ラブラドール',NULL,NULL,'pull chew','引っ張りの強い24kgのラブラドールで3本目。他の犬が近づくと引くがそれ以外はゆっくり歩く。外でつないで待たせると首の下のたるみを噛みちぎってしまう体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/202898_10088682/1.1/'),
('petsafe-easy-walk-deluxe','ミニチュアピンシャー',NULL,NULL,'pull trachea','ぐいぐい進んで苦しそうにガハガハ言ったり二足歩行になったりしていたミニピンで、他の犬を見ると引くものの驚くほど引かなくなり、ガハガハもほぼしなくなった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/202898_10088682/1.1/'),
('petsafe-easy-walk-deluxe','ピットブル',NULL,NULL,'pull','人や犬が大好きで、見つけると引っ張る25kgの筋肉質なピットブルにM。少し大きい気もするが問題なく使えている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/202898_10088682/1.1/'),
('petsafe-easy-walk-deluxe','ゴールデンレトリバー',NULL,NULL,'pull chew','散歩が憂うつになるほど引っ張る1歳・27kgのゴールデン。引くと歩きにくいようで効果はあったが、胸のベルトを気にして噛み、2回で切れてしまい使用を断念した体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/202898_10088682/2.1/'),
('petsafe-easy-walk-deluxe','レトリバー',NULL,NULL,'pull escape','普段は横を歩くが1歳で時々はじけ、突然引かれて飼い主が転倒・けがをした31kgのレトリバーで、合図に気付きやすくなった。後ずさりで抜けようとすることもある体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/202898_10088682/2.1/'),
('petsafe-easy-walk-deluxe','ゴールデンレトリバー',NULL,NULL,'pull','引っ張りで何度か転んだこともある35kgのゴールデンで、着けたら全く引っ張らずに歩け、リードを軽く握るだけで済むようになった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/202898_10088682/2.1/'),
('petsafe-easy-walk-deluxe','ラブラドール',NULL,NULL,'pull trachea','散歩が苦行だった25kgのラブラドールで、最初は癖で引いて咳き込んでいたが、最近は引いても咳き込まなくなり、引っ張りはかなり減った体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/202898_10088682/2.1/'),
('petsafe-easy-walk-deluxe','ボーダーコリー',NULL,NULL,'pull','車を追いかけ力も強い19kgのボーダーコリーで、最初の数日は歩き方がぎこちなかったが、その後はスムーズに歩けて驚くほど引っ張らなくなった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/202898_10088682/2.1/'),
('petsafe-easy-walk-deluxe',NULL,NULL,NULL,'pull sizing','6.6kgの犬でSサイズでも少し大きいが、突進しても首が締まらず、首輪だけの時より止めやすいと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/202898_10088682/2.1/'),
('petsafe-easy-walk-deluxe','スタンダードプードル',NULL,NULL,'puppy pull','11か月・21kgのスタンダードプードルで、ベルトを一番短くしてちょうど良く、引っ張りが2割ほどに減り散歩の疲れが大きく軽減した体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/202898_10088682/2.1/'),
('petsafe-easy-walk-deluxe','シベリアンハスキー',NULL,NULL,'puppy pull','力が強い5か月のハスキーで、心配になるほど引っ張りが弱くなった。正面のベルトは調整しても歩くうちに戻ってしまうという体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/202898_10088682/2.1/'),
('petsafe-easy-walk-deluxe',NULL,NULL,NULL,'pull sizing','細身の18kgの犬にMでもかなり余裕があり、胸のベルトを一番短くしてもだぶつく。引くと体がこちらへ向くので、その時に褒めてトレーニングしている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/202898_10088682/2.1/'),
('petsafe-easy-walk-deluxe','キャバリア',NULL,NULL,'pull sizing','ドッグトレーナーの動画で知り、5.5kgのキャバリアにS。推奨の指の入り具合に合わせようとしても一番小さくして指4本入るほど余った体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/202898_10088682/2.1/'),
('petsafe-easy-walk-deluxe','ゴールデンレトリバー',NULL,NULL,'puppy pull','成長途中のゴールデンで少し大きめ。引くと体の向きが変わり前に行かなくなるが、肩や前足の付け根が締まる感じで少し歩きにくそうな体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/202898_10088682/3.1/'),
('petsafe-easy-walk-deluxe','ビーグル×柴',NULL,NULL,'pull','10kgのミックスにS。犬が動くので長さ調整は難しく説明書も英語だったが、以前より引っ張りが弱くなった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/202898_10088682/3.1/'),
('buddy-belt','トイプードル',NULL,NULL,'sizing','胴囲33cm・2.6kgのトイプードルで、3.5号は大きくベルトが余って前足に触れるため、3号の方が使いやすかった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/230805_10000712/1.1/'),
('buddy-belt',NULL,NULL,NULL,'senior','12歳のシニア犬のために体に優しいハーネスを探して選んだ、体重2.7kgの犬での体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/230805_10000712/1.1/'),
('buddy-belt',NULL,NULL,NULL,'sizing','お下がりで使っていた同じ3号を買い直したが、ベルト穴の位置が少し違い、新しい方がやや大きかったという体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/230805_10000712/1.1/'),
('buddy-belt','トイプードル',NULL,NULL,'trachea','子犬の頃から使っている2kgのトイプードルで、布製のように食い込まず、胸がしっかり固定されるのに柔らかい革で負担が少ないと感じている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/230805_10000712/1.1/'),
('buddy-belt',NULL,NULL,NULL,'clothes sizing','体重2.5kg・胴回り32cmで3号。違和感なく歩けた。冬の厚手の服の上から着けることも考えてサイズを選んだ体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/230805_10000712/1.1/'),
('buddy-belt','ロングコートチワワ',NULL,'long','escape','公園で遊んでいる時にほかのハーネスがするっと抜けてしまい、毛への当たりを心配して避けていたこのハーネスを使い始めたロングコートチワワの体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/230805_10000712/1.1/'),
('buddy-belt','トイプードル',NULL,NULL,'easy-on','2kg弱のトイプードルで、最初は固まったがすぐ歩き回るようになり、小型犬には見た目がごつくても犬は気にしていない体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/230805_10000712/1.1/'),
('buddy-belt','トイプードル',NULL,NULL,'trachea','首輪では散歩中にゲホゲホしていた骨格の細い3kgのトイプードルで、3号がぴったり合い、咳をしなくなった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/230805_10000712/2.1/'),
('buddy-belt',NULL,NULL,NULL,'mobility sensitive','生まれつきの背骨の異常で時々歩けなくなる、服も嫌がる神経質な犬で、少し気にしつつも使えている。ワンタッチの首輪より着脱は手間という体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/230805_10000712/2.1/'),
('buddy-belt',NULL,NULL,NULL,'trachea dislike-on','普通の首輪では喉の負担が気になっていた、服嫌いの犬で、嫌がらずにあっさり着けさせてくれた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/230805_10000712/3.1/'),
('buddy-belt','ヨークシャーテリア',NULL,NULL,'puppy escape','バイクを見ると猛ダッシュする7か月・3kgのヨーキーで、これまでのハーネスは全部脱げてしまったが、これでようやく脱げずに散歩できた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/230805_10000712/3.1/'),
('buddy-belt','トイプードル',NULL,NULL,'skin sizing clothes','2.6kgのトイプードルで3号を選び、脇への当たりが心配なため袖ありのTシャツの上から一番ゆるい穴で着けている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/230805_10000712/3.1/'),
('buddy-belt','ポメラニアン2頭',NULL,NULL,'multi trachea','あまり引いていないのにカァッと言うことがあった2kg台のポメラニアン2頭で、首に負担の少ない形として2.5号と3号を選んだ体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/230805_10000712/3.1/'),
('ruffwear-front-range','雑種',NULL,NULL,'pull trachea','喉が弱いのに引っ張り癖があり咳き込みが多い19kgの雑種で、獣医師に胸で支えるタイプを勧められていたが、そういう形はさらに引っ張るのではと迷った末にSを選んだ体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/266503_10000952/4.1/'),
('ruffwear-front-range','ミックス',NULL,NULL,'puppy escape','まだやんちゃで、後ろに下がる時にハーネスが抜けそうで不安だった7か月・10kgのミックスで、丈夫で犬にも良いと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/266503_10000952/4.1/'),
('ruffwear-front-range','柴犬',NULL,NULL,'pull dislike-on trachea','子犬の頃にハーネスを強く拒否して首輪にしたが、引っ張り癖で苦しそうだった1歳・8kgの柴犬で、XSは抵抗せずに着け、お互い散歩が楽になった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/266503_10000952/4.1/'),
('ruffwear-front-range',NULL,NULL,NULL,'scared escape','元野犬でとても俊敏な保護犬のため、抜けにくいものとしてJulius-K9と迷ってこれを選び、バックルがスムーズで静かなので怖がらせずに着けられる体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/266503_10000952/4.1/'),
('ruffwear-front-range','トイプードル',NULL,NULL,'pull clothes','引っ張り癖がありいろいろ試した5.8kgの大きめのトイプードルで、散歩時に服を着せるためXSにし、今までで一番良いが調整は難しいと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/266503_10000952/4.1/'),
('ruffwear-front-range','甲斐犬',NULL,NULL,'puppy trachea','首輪だけで引っ張ってゴホゴホしていた4か月・12kgの甲斐犬にS。初めてで家の中では気にしたが、外に出ると気にしなくなった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/266503_10000952/4.1/'),
('ruffwear-front-range','豆柴',NULL,NULL,'trachea','いろいろな首輪やハーネスでむせることが多かった気管の弱い6kgの豆柴で、ベルト調整に手間取ったが、説明書どおりに合わせられた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/266503_10000952/4.1/'),
('ruffwear-front-range','柴犬',NULL,NULL,'puppy pull dislike-on','引く力が強い7か月・10kg弱の柴犬にS。頭を入れるタイプは初めてで最初は嫌がったが、着けると散歩に行けると分かって慣れた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/266503_10000952/4.1/'),
('ruffwear-front-range','パグ',NULL,NULL,'pull trachea','引っ張り癖があり散歩で必ず一度は咳き込んでいた3歳の黒パグで、このハーネスにしてから咳がなくなった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/266503_10000952/4.1/'),
('ruffwear-front-range','ビーグル',NULL,NULL,'escape','散歩中に何度か抜けてひやひやしたビーグルで、前のものは時間が経つと緩んだが、これはフィット感があり調整部分も安定している体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/266503_10000952/5.1/'),
('ruffwear-front-range','シベリアンハスキー',NULL,NULL,'escape durability','何年も使って一度も抜けたことがなく破れやほつれもないハスキーで、汚れやくたびれが出たため買い直した体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/266503_10000952/5.1/'),
('ruffwear-front-range','チワワ',NULL,NULL,'stiff','細かく調整でき抜けにくそうだが、3.5kgのチワワには少し硬いかもしれないと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/266503_10000952/5.1/'),
('ruffwear-front-range','キャバリア',NULL,NULL,'sizing clothes','成犬としては小さめの6kgのキャバリアにXS。首も胴も一番小さくして少し余裕があるが、散歩中は服を着せるので気にならない体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/266503_10000952/5.1/'),
('ruffwear-front-range',NULL,NULL,NULL,'easy-on','頭を入れて脇の2か所を留めるだけなのにしっかり固定され、軽いと感じた16kgの細身の犬の体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/266503_10000952/6.1/'),
('ruffwear-front-range','黒柴',NULL,NULL,'pull multi','引っ張る力が強くなりEzyDogのクイックハーネスから替えた8.4kgの黒柴で、前当てが柔らかく支えるので引く力が弱くなった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/266503_10000952/6.1/'),
('ruffwear-front-range','豆柴',NULL,NULL,'puppy dislike-on chew','足を入れるタイプをとても嫌がる6か月・7kgの豆柴で、このタイプはかなり着せやすいが、一部を噛んでしまった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/266503_10000952/6.1/')
)
INSERT INTO reviews(product_id,dog_breed,dog_size,coat_type,needs,summary,source_type,source_url)
SELECT n.product_id,n.dog_breed,n.dog_size,n.coat_type,n.needs,n.summary,n.source_type,n.source_url
FROM new_reviews n
WHERE NOT EXISTS (
  SELECT 1 FROM reviews r
  WHERE r.product_id=n.product_id
    AND r.summary=n.summary
);

WITH new_reviews(product_id,dog_breed,dog_size,coat_type,needs,summary,source_type,source_url) AS (
VALUES
('ruffwear-front-range','ビションフリーゼ',NULL,NULL,'escape sizing','犬も人も大好きで元気な1歳・10kgの大きめのビションで、旧型が小さくなり買い替えた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/266503_10000952/6.1/'),
('ruffwear-front-range',NULL,NULL,NULL,'sizing clothes','胸囲50cm・8kgの犬に服の上からも着けられると思ってXSを選んだが、胸囲を最大にしてもぱつぱつで苦しそうに固まり、服の上からはとても無理だった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/266503_10000952/6.1/'),
('puppia-soft-vest','トイプードル',NULL,NULL,'escape sizing','7kgのトイプードルにXL。腕を通す部分が広いためか、マジックテープをしっかり締めても脱げてしまい、散歩中に脱走して焦った体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/230805_10000752/4.1/'),
('puppia-soft-vest','マルチーズ',NULL,NULL,'escape sizing','前のハーネスが散歩中にすぽっと抜けて怖い思いをした2.7kgのマルチーズにM。ぴったりで、Lでも行けたかもしれない体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/230805_10000752/4.1/'),
('puppia-soft-vest','チワプー',NULL,NULL,'dislike-on','服を嫌がる2.5kgのチワプーにS。サイズがぴったりで、初めてでも抵抗なく着けてくれた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/230805_10000752/4.1/'),
('puppia-soft-vest','ミニチュアダックスフンド',NULL,NULL,'clothes sizing','5kgのミニチュアダックスにLは一回り大きかったが、冬の厚めの服の上ならちょうど良さそうで、ホールド感も良い体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/230805_10000752/4.1/'),
('puppia-soft-vest','マルシュナ',NULL,NULL,'trachea sizing','7kgのマルシュナにXLでかなり余裕があったが、大きめのマジックテープで調整でき、気管に負担がかからない点が良い体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/230805_10000752/4.1/'),
('puppia-soft-vest','トイプードル',NULL,NULL,'pull trachea','引っ張りや急な走り出しが多く、ゼロゼロ・ヒューヒューという苦しい息遣いが心配だった3.6kgのトイプードルで、その息遣いがなくなった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/230805_10000752/4.1/'),
('puppia-soft-vest','ビーグル',NULL,NULL,'senior escape','帰りたくないと首に力を入れると前のものは脱げそうになっていた10歳のビーグルで、その点は安心だが、まだ着けるのに慣れていない体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/230805_10000752/4.1/'),
('puppia-soft-vest','トイプードル',NULL,NULL,'sizing','4.6kgのトイプードルで、Mは少しぱつぱつ、Lはかなりぶかぶか。抜けることはなく縁に少し毛玉ができる程度で、中間のサイズが欲しいと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/230805_10000752/6.1/'),
('puppia-soft-vest','柴犬',NULL,NULL,'sizing','10kgの柴犬にXXL。気持ち緩いが、装着を嫌がらず問題なく使えている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/230805_10000752/6.1/'),
('puppia-soft-vest','カニンヘンダックスフンド',NULL,NULL,'escape','3.7〜3.8kgのカニンヘンダックスにM。服を着なければジャストサイズで、嫌がってバックしても抜けることはなさそうな体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/230805_10000752/6.1/'),
('puppia-soft-vest','パグ',NULL,NULL,'puppy sizing','6か月・8kgのむちむちしたパグで、毛が抜けやすいので毛色に合わせた色を選び、成長を考えてXLにした体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/230805_10000752/6.1/'),
('puppia-soft-vest','チワワ',NULL,NULL,'senior','避妊手術後に少し太り前のものが入らなくなった2.8kgの老犬のチワワにM。長くは歩けなくなった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/230805_10000752/6.1/'),
('puppia-soft-vest','トイプードル',NULL,NULL,'trachea','首の負担を減らすため初めてハーネスにした7kgのトイプードルにXL。少し余裕があるので、抜けた時に備えて首輪と2本のリードで使う予定の体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/230805_10000752/6.1/'),
('puppia-soft-vest','キャバリア',NULL,NULL,'sizing','1歳のキャバリアに使ってきて、着脱が楽でクッション性もある。もう1頭のキャバリアに3XLを選んだら大きすぎた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/230805_10000752/6.1/'),
('puppia-soft-vest','パピヨン',NULL,NULL,'senior mobility easy-on','後ろ足が弱った3.8kgの老犬のパピヨンで、前足を通すだけなので簡単に着けられ、背中のマジックテープで体重の増減にも合わせられる体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/230805_10000752/6.1/'),
('puppia-soft-vest','柴犬',NULL,NULL,'durability','約15kgの柴犬にXXLを愛用しており、柔らかく着けやすく嫌がらない。最初のものが2年ほどでぼろぼろになり買い替えた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/230805_10000752/6.1/'),
('puppia-soft-vest','トイプードル',NULL,NULL,'skin dislike-on','首輪から替えた3kgのトイプードルにMがジャストサイズで、脇にも当たらなそうで、初日から機嫌よく散歩できた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/230805_10000752/6.1/'),
('curli-vest-air-mesh','ジャックラッセルテリア',NULL,NULL,'escape','体格のしっかりした7kgのジャックラッセルにMがぴったり。ぴったりのサイズだと緩みがなくすっぽ抜けもほとんどなく、動きも妨げないのでドッグランでも着けている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000879/4.1/'),
('curli-vest-air-mesh','ミニチュアシュナウザー',NULL,NULL,'durability sizing','旧モデルを2年使いマジックテープが弱くなった7kgのシュナウザーで、新しいものは少し小さめだが、旧型では首が大きかったのでかえってジャストサイズになった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000879/4.1/'),
('curli-vest-air-mesh','トイプードル',NULL,NULL,'sizing','4.3kgのトイプードルにSがぴったり。体に直接当たる金具がなく、着け心地が良さそうな体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000879/4.1/'),
('curli-vest-air-mesh','トイプードル',NULL,NULL,'clothes sizing','冬の厚手の服を考えて5kgのトイプードルのSをMに交換。装着が簡単で前足の付け根にも当たらない体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000879/4.1/'),
('curli-vest-air-mesh','トイプードル×ミニチュアダックスフンド',NULL,NULL,'pull','散歩中にぐいぐい引くため、ひもタイプでは食い込みが心配だった4〜5kgのミックスで、軽くひもが食い込むこともない体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000879/4.1/'),
('curli-vest-air-mesh','チワワ',NULL,NULL,'sizing','2.8kgのチワワに2XSを選んだら服なしでもきつめで、XSに交換して少し余裕ができた。リードの留め具がプラスチックで軽いのも助かる体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000879/4.1/'),
('curli-vest-air-mesh','イタリアングレーハウンド',NULL,NULL,'multi','合うハーネスがなかなか見つからないイタグレで、柔らかくしっかりしたマジックテープで調整できるため2頭目にも買った体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000879/4.1/'),
('curli-vest-air-mesh','トイプードル',NULL,NULL,'sizing durability','胴回り50cm・7.7kgのトイプードルで、2年使ったMが古くなりLに上げて問題なかった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000879/4.1/'),
('curli-vest-air-mesh','トイプードル',NULL,NULL,'sizing','よく走る胸囲37cm・3.3kgのトイプードルにS。抜けない程度に余裕があり、軽くて動きやすそうな体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000879/4.1/'),
('curli-vest-air-mesh','ペキニーズ',NULL,NULL,'easy-on','4.7kgのペキニーズにXSがジャストサイズ。マジックテープとバックルでしっかり留まり、着脱も簡単な体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000879/5.1/'),
('curli-vest-air-mesh','トイプードル',NULL,NULL,'easy-on','改良版はさらに軽く着脱も簡単になったと感じた3.2kgのトイプードルで、XSがぴったりな体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000879/5.1/'),
('curli-vest-air-mesh','チワワ×シーズー',NULL,NULL,'sizing','6.5kgのチワワとシーズーのミックスにL。とても軽く、前のハーネスより動きやすそうな体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000879/5.1/'),
('curli-vest-air-mesh','チワワ',NULL,NULL,'chew','3.5kgのチワワに合っていたが、ロゴ部分をかじって飲み込んでしまい壊れたという体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000879/5.1/'),
('curli-vest-air-mesh','豆柴',NULL,NULL,'senior durability','16歳近い痩せた豆柴に負担の少ないものとして選び、柔らかく一日中着けていても良かったが、3か月でリング一体型の部品が壊れたという体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000879/5.1/'),
('hakusan-zero-harness','ウィペット',NULL,NULL,'trachea','10kgのウィペットにS。首回りはやや緩いが胴でしっかり合い抜けない。前のハーネスでは気道が締まるのかガハッとしていたが、苦しそうでなくなった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000685/4.1/'),
('hakusan-zero-harness','ビションフリーゼ',NULL,NULL,'escape','おしゃれ重視のハーネスから散歩中に前足が抜けたことがある4.3kgのビションで、着け心地重視で信頼できるものとして選んだ体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000685/4.1/'),
('hakusan-zero-harness','フレンチブルドッグ',NULL,NULL,'pull skin','引っ張り癖があり気管を圧迫しないハーネスを使っていたら前足の脇が擦れて毛が抜けた12kgのフレブルで、バックルが脇に当たらず擦れの心配がない体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000685/4.1/'),
('hakusan-zero-harness',NULL,NULL,NULL,'skin','首回りも胴回りも調整でき、胴のベルトが前足の脇に引っかからない位置にあるため、ほかのハーネスをほとんど使わなくなった5kgの犬の体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000685/4.1/'),
('hakusan-zero-harness','ポメラニアン',NULL,NULL,'sizing','3.1kgのポメラニアンにXXSがちょうど良かった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000685/4.1/'),
('hakusan-zero-harness','ミニチュアダックスフンド',NULL,NULL,'skin','首と胴に通すタイプで擦れてお腹の毛が抜けていたダックスで、小型犬にはごつく見えるが、肌に当たる部分にクッション性があり負担が少なそうな体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000685/4.1/'),
('hakusan-zero-harness','ゴールデンレトリバー2頭',NULL,NULL,'multi sizing','43kgと42kgのゴールデン2頭にXL。届いた時はぴちぴちに見えたが、助言どおりきちんと合わせたら合った体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000685/4.1/'),
('hakusan-zero-harness',NULL,NULL,NULL,'sizing','いろいろなメーカーを試してきたが、首も胴も調整でき、柔らかいのにホールド感があり、見た目もごつすぎず理想的だと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000685/4.1/'),
('hakusan-zero-harness','ボーダーコリー',NULL,NULL,'clothes','首回り35cm・胸囲60cm・15.5kgのボーダーコリーにS。普段使うJulius-K9は夏に熱がこもり重そうなので、軽いこちらを使っている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000685/5.1/'),
('hakusan-zero-harness','チワワミックス',NULL,NULL,'sizing','首や体に触れる部分が痛くないY字のものを探していた8kgのチワワミックスにS。少しゆとりがあるがちょうど良かった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000685/5.1/'),
('hakusan-zero-harness','キャバリア',NULL,NULL,'handle','5.5kgのキャバリアにXXSがジャスト。持ち手はないが上部をつかんで持ち上げられ、小さいサイズでは持ち手がテープで留まっているJulius-K9より緊急時に対応しやすいと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000685/5.1/'),
('hakusan-zero-harness','ミニチュアシュナウザー2頭',NULL,NULL,'multi easy-on','足から入れるタイプを2年使い毎回着けにくかった9kgと7.5kgのシュナウザー2頭で、着けやすくしっかりしたものに替えた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000685/5.1/'),
('hakusan-zero-harness',NULL,NULL,NULL,'senior trachea sizing','シニアに近づき首への負担を減らしたくてY型を探した胴回り58cm・11kgの犬にS。初めてのハーネスでどのくらいのフィット感にすべきか迷った体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000685/5.1/'),
('hakusan-zero-harness','キャバリア',NULL,NULL,'puppy','服もハーネスも初めての8か月のキャバリアに、胴回りに合わせて一番小さくしてぴったり。見た目より軽く柔らかい体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000685/5.1/'),
('hakusan-zero-harness','ミニチュアシュナウザー',NULL,NULL,'chew','首の後ろにリードを付けるタイプだとリードを噛んでしまう5.6kgのシュナウザーで、腰の金具にリードを付けられるのが良い体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000685/5.1/'),
('hakusan-zero-harness',NULL,'medium',NULL,'scared handle','時々怖がって動揺する13kgの中型犬で、以前も同じ形を使っていたが、クッション性と持ち手がある点でこれを選んだ体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000685/6.1/'),
('petsafe-easy-walk',NULL,NULL,NULL,'pull escape','嘘のように引っ張らなくなり、猫を見て弾丸のように走り出した時も制御できた。胸のベルトをぴったり締めないとハーネス自体が脱げそうになる体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/284187_10031274/2.1/')
)
INSERT INTO reviews(product_id,dog_breed,dog_size,coat_type,needs,summary,source_type,source_url)
SELECT n.product_id,n.dog_breed,n.dog_size,n.coat_type,n.needs,n.summary,n.source_type,n.source_url
FROM new_reviews n
WHERE NOT EXISTS (
  SELECT 1 FROM reviews r
  WHERE r.product_id=n.product_id
    AND r.summary=n.summary
);

WITH new_reviews(product_id,dog_breed,dog_size,coat_type,needs,summary,source_type,source_url) AS (
VALUES
('petsafe-easy-walk',NULL,NULL,NULL,'escape','トレーナーに勧められて3本目。今は引っ張り癖はないが、何より抜ける心配がないので使い続けている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/284187_10031274/2.1/'),
('petsafe-easy-walk',NULL,NULL,NULL,'pull','SNSで知って使い始め、最初は違和感があり飼い主もリードの扱いに慣れるまで時間がかかったが、慣れると快適に散歩できた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/284187_10031274/2.1/'),
('petsafe-easy-walk','ゴールデンドゥードル',NULL,NULL,'pull','もともとぐいぐい引くわけではない1歳のゴールデンドゥードルが、飼い主の速さに合わせて歩くようになった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/284187_10031274/2.1/'),
('petsafe-easy-walk',NULL,NULL,NULL,'pull','手にまめができるほど引っ張っていたがだいぶ軽減した。使ううちに少し緩むのでこまめに確認している体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/284187_10031274/2.1/'),
('petsafe-easy-walk',NULL,NULL,NULL,'pull','獣医師に勧められて使い始め、しつけができていないと感じていた飼い主でも、前へぐいぐい引っ張られることがなくなった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/284187_10031274/2.1/'),
('petsafe-easy-walk','ラブラドール',NULL,NULL,'pull','引っ張る40kgのラブラドールで、使っていたものがぼろぼろになり買い直した。引っ張ることが減り、ハーネスを手にすると散歩だと寄ってくる体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/284187_10031274/2.1/'),
('petsafe-easy-walk','ラブラドール',NULL,NULL,'pull','21kgのメスのラブラドールにピンクのM。引っ張り防止にはこれが一番だと感じている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/284187_10031274/3.1/'),
('petsafe-easy-walk',NULL,NULL,NULL,'pull escape','いつもより引っ張りが弱くゆっくり歩いてくれたが、一度だけお腹側のひもから前足が抜けたことがあった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/284187_10031274/3.1/'),
('petsafe-easy-walk','ゴールデンレトリバー',NULL,NULL,'pull trachea','ハーフチョークから替えた25kgのゴールデンで、首が締まらないので安心でき、引かれても前より力が要らない体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/284187_10031274/3.1/'),
('petsafe-easy-walk','ラブラドール',NULL,NULL,'puppy pull','散歩が大変だった5か月のラブラドールで、歩きにくそうで少し申し訳ない気もするが、小学生の女の子でも余裕で散歩できるようになった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/284187_10031274/3.1/'),
('petsafe-easy-walk','ゴールデンレトリバー',NULL,NULL,'scared pull','とても怖がりで、ものすごい勢いで引っ張り肉球や爪から出血するほどだった40kgのゴールデンにXL。少し引き戻すだけで前に出られず、片手で抑えられるようになった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/284187_10031274/3.1/'),
('petsafe-easy-walk',NULL,NULL,NULL,'pull dislike-on multi','ジェントルリーダーを嫌がって散歩にならなかった多頭飼いの1頭に使い、首輪より引っ張らなくなったが、全く引かなくなるわけではない体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/284187_10031274/3.1/'),
('petsafe-easy-walk',NULL,NULL,NULL,'durability','それほど引っ張らない犬で、前のハーネスが小さくなり購入したが、届いて使った日にちぎれたという体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/284187_10031274/3.1/'),
('petsafe-easy-walk','ポメプー',NULL,NULL,'dislike-on escape','家に近づくと強く引く5kgのポメプーで、付け方をいろいろ試したが嫌がって暴れ、すぐに外れてしまい合わなかった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/284187_10031274/3.1/'),
('moncheri-harness','チワワ',NULL,NULL,'sizing clothes','1.7kgの小柄なチワワで、首・胴・胸元の3か所を調整でき、胸元以外はまだ余裕があり服の有無どちらでも使えそうな体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/406105_10001780/1.1/'),
('moncheri-harness',NULL,NULL,NULL,'puppy sizing','調整できる箇所が多いが、3kgの子犬にはまだ大きく、成長してから使う予定の体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/406105_10001780/1.1/'),
('moncheri-harness','トイプードル',NULL,NULL,'escape','1.8kgのトイプードルにSを短めに調整してちょうど良く、抜けにくそうで安心できる体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/406105_10001780/1.1/'),
('moncheri-harness','ポメラニアン',NULL,NULL,'pull escape','引っ張りの強い2.3kgのポメラニアンで、ほぼ毎日使って一度も抜けておらず、気になっていた重さもそれほど感じない体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/406105_10001780/2.1/'),
('moncheri-harness','トイプードル',NULL,NULL,'clothes sizing','2.5kgのトイプードルで、Sを服の上から付けるときつくなってきたためMに替えてちょうど良かった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/406105_10001780/2.1/'),
('moncheri-harness','チワワ2頭',NULL,NULL,'multi pull escape','引っ張り癖や急に止まる癖があり抜けそうだったチワワ2頭に使い、抜けそうな感じがなく安心な体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/406105_10001780/2.1/'),
('moncheri-harness',NULL,NULL,NULL,'puppy sizing','毛量のある2.7kgの子犬にSは少し小さく、Mに交換した体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/406105_10001780/2.1/'),
('moncheri-harness','ポメラニアン',NULL,NULL,'dislike-on','3.1kgのポメラニアンにMで使え、嫌がる子なので着けにくいのが難点という体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/406105_10001780/2.1/'),
('moncheri-harness',NULL,NULL,NULL,'sizing clothes','採寸して明らかにSだった2.5kg弱の犬で、思ったよりゆとりがなく、薄手のTシャツや裸ならちょうど良いがMでも良かったかもしれない体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/406105_10001780/3.1/'),
('moncheri-harness','チワワ2頭',NULL,NULL,'multi pull clothes','引っ張りが気になっていた3kgと2.3kgのチワワで、冬に服を着るためMにし、服なしだと小さい方は少し大きい体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/406105_10001780/3.1/'),
('moncheri-harness','チワワ',NULL,NULL,'escape','以前ハーネスが抜けて焦ったことがある2.6kgのチワワで、試着では抜ける恐れはなさそうだった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/406105_10001780/3.1/'),
('moncheri-harness','チワプー',NULL,NULL,'puppy sizing','散歩デビュー前に慣らすため3か月・1kgのチワプーに用意し、お腹の下を通るひもは一番短くしても少し長かった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/406105_10001780/3.1/'),
('moncheri-harness','ポメラニアン',NULL,NULL,'dislike-on','締め付けを嫌がりハーネスが苦手な3.7kgのポメラニアンで、散歩中はずっと楽しそうで、調整幅もあり長く使えそうな体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/406105_10001780/3.1/'),
('laluca-wear-harness','トイプードル',NULL,NULL,'sizing','2.8kgのトイプードルにSがぴったりだったが、金具部分がもう少し長いと頭を入れる時にきつくないと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/395228_10000031/1.1/'),
('laluca-wear-harness','チワワ',NULL,NULL,'puppy sizing','5か月のチワワにXS。今は着けられるが、まだ大きくなりそうなので成長しきったらSを買う予定の体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/395228_10000031/1.1/'),
('laluca-wear-harness','トイプードル',NULL,NULL,'clothes','寒がりで冬はもこもこのコートを着る2.6kgのトイプードルで、サイズを調整できて良かったが、付属のリードは薄いので手持ちのものを使っている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/395228_10000031/2.1/'),
('laluca-wear-harness','トイプードル',NULL,NULL,'clothes sizing','がっしりした3.6kgのトイプードルにS。とても軽く裏がメッシュで夏も涼しそう。厚い服を着ない時はSでちょうど良い体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/395228_10000031/2.1/'),
('laluca-wear-harness','シーズー',NULL,NULL,'easy-on','5.7kgのシーズーにM。着けるのが楽で生地も柔らかい体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/395228_10000031/2.1/'),
('laluca-wear-harness',NULL,NULL,NULL,'multi sizing','使い勝手が良かったのでもう1頭にも購入し、ぽっちゃりした4kgの子はMでは大きくSに交換してぴったりだった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/395228_10000031/2.1/'),
('laluca-wear-harness','トイプードル',NULL,NULL,'puppy multi durability','生後2か月の子犬と4kgの母犬のトイプードルにおそろいで使い、サイズは合ったが簡素な作りで安全性が少し不安という体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/395228_10000031/3.1/'),
('laluca-wear-harness','ポメラニアン',NULL,NULL,'easy-on','1.5kgのポメラニアンにXSがちょうど良かったが、背中をマジックテープで留めるタイプの方が使いやすいかもしれないと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/395228_10000031/3.1/'),
('laluca-wear-harness','カニンヘンダックスフンド',NULL,NULL,'puppy easy-on','5か月のカニンヘンダックスで、頭を入れて前足を通すだけなので簡単に着けられる体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/395228_10000031/3.1/'),
('funcoma-harness-lead',NULL,NULL,NULL,'escape easy-on','いくつものハーネスがすっぽ抜けて不安だったが、マジックテープと留め具の二重で安心で、足を通さずに着けられる体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/392151_10000004/1.1/'),
('funcoma-harness-lead','ポメラニアン・ミニチュアダックスフンド',NULL,NULL,'multi senior','ポメラニアン用に買い、19歳のダックスにも着せたら、2頭とも合った体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/392151_10000004/1.1/'),
('funcoma-harness-lead','ヨークシャーテリア',NULL,NULL,'senior','高齢の約3kgのヨーキーにM。しっかりした作りで、軽いのも高齢犬には良い体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/392151_10000004/1.1/'),
('funcoma-harness-lead','ミニチュアシュナウザー',NULL,NULL,'sizing','首に比べて胸がしっかりした5.5kgのシュナウザーにXL。他のハーネスでは首がゆるゆるだったが、マジックテープとバックルで調整できた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/392151_10000004/1.1/'),
('funcoma-harness-lead','ミニチュアダックスフンド',NULL,NULL,'escape sizing','これで毎日散歩するうちにかなりスリムになったミニチュアダックスで、XLがぶかぶかになり自分で脱いでしまうようになった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/392151_10000004/1.1/'),
('funcoma-harness-lead','ビションフリーゼ',NULL,NULL,'sizing','大きめの7kgのビションにXLがちょうど良かった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/392151_10000004/2.1/'),
('funcoma-harness-lead','シーズー',NULL,NULL,'sizing','採寸ではMだった5kgのシーズーが試着できつく、Lに交換してもらった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/392151_10000004/2.1/'),
('funcoma-harness-lead','ウエストハイランドホワイトテリア',NULL,NULL,'sizing','約7kgのウエスティにXLがちょうど良かった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/392151_10000004/3.1/'),
('funcoma-harness-lead','トイプードル',NULL,NULL,'durability','前に買ったものがよれてきて2回目の購入。1.7kgのトイプードルにSがぴったりで、着心地も良いらしい体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/392151_10000004/3.1/'),
('ironbaron-honeycomb','バーニーズ・マウンテン・ドッグ',NULL,NULL,'senior mobility sizing','寝たきりに近くなり25kgほどまで痩せた13歳のバーニーズで、Mでも中にベストを着て少し大きいくらい、何も着ないとぶかぶかな体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/195679_10000490/1.1/'),
('ironbaron-honeycomb','アラスカン・マラミュート',NULL,NULL,'senior mobility','足腰が弱りがんの介護も必要になった14歳のマラミュートにM。着せるのに手間取ったが慣れ、着たままでも蒸れにくい体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/195679_10000490/1.1/'),
('ironbaron-honeycomb',NULL,NULL,NULL,'senior mobility sizing','10kgから9kgに痩せて足腰が弱った16歳の老犬にSS。ウエストはだぶだぶで、頭が下がってくるので首に当たるベルトが少し苦しそうな体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/195679_10000490/2.1/'),
('ironbaron-honeycomb','サモエド',NULL,NULL,'senior mobility','悪性リンパ腫の闘病中で一人で立てなくなってきた13歳のサモエドで、抱き起こすのが難しくなり使い始め、もっと早く買えば良かったと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/195679_10000490/2.1/'),
('ironbaron-honeycomb','ラブラドール',NULL,NULL,'senior mobility','玄関の段差でつまずき後ろ足を痛めた、胸回り88cm・40kgの骨格の大きい12歳のラブラドールにL。急いで必要だったので翌日に届いて助かった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/195679_10000490/2.1/')
)
INSERT INTO reviews(product_id,dog_breed,dog_size,coat_type,needs,summary,source_type,source_url)
SELECT n.product_id,n.dog_breed,n.dog_size,n.coat_type,n.needs,n.summary,n.source_type,n.source_url
FROM new_reviews n
WHERE NOT EXISTS (
  SELECT 1 FROM reviews r
  WHERE r.product_id=n.product_id
    AND r.summary=n.summary
);

WITH new_reviews(product_id,dog_breed,dog_size,coat_type,needs,summary,source_type,source_url) AS (
VALUES
('ironbaron-honeycomb','シベリアンハスキー',NULL,NULL,'mobility sizing','自力で立てなくなった25kgのハスキーで、毛を剃っていたためMは少し大きく洗い替えにSを購入。持ち手の位置が良く最後まで立って排泄できた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/195679_10000490/2.1/'),
('ironbaron-honeycomb','柴犬',NULL,NULL,'mobility sizing','急に動けなくなった8歳・15.5kgの柴犬で、大型犬の情報しかなくサイズに迷い、SSを内側のファスナーで使っている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/195679_10000490/2.1/'),
('ironbaron-honeycomb','ラブラドール',NULL,NULL,'sizing','28kgのラブラドールにSを外側のファスナーでぴったり。34kgあった頃はMがややきつめでぴったりだった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/195679_10000490/2.1/'),
('ironbaron-honeycomb',NULL,NULL,NULL,'mobility','10歳で突然てんかんの発作が起き、投薬で足腰が立たなくなった21kgの細身のメスで、毎日の介護で飼い主の足腰も限界になり急いで購入した体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/195679_10000490/3.1/'),
('ironbaron-honeycomb','ラブラドール',NULL,NULL,'senior mobility','肩回りに大きな脂肪腫があり、ヘルニアで左脚が完全にナックリングしている15歳・24kgのラブラドールで、発送前にサイズ確認の電話をもらえた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/195679_10000490/3.1/'),
('ironbaron-honeycomb','ラブラドール',NULL,NULL,'senior mobility','後ろ脚が弱くなった14歳・35kgのラブラドールにMを外側のファスナーで使い、階段の上り下りが目に見えて楽になった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/195679_10000490/3.1/'),
('dogcopenhagen-comfort-walk-pro',NULL,NULL,NULL,'sizing','同ブランドの別シリーズの洗い替えとして購入した15kgの犬で、生地も作りもとても頑丈だが、胴回りはぎりぎりだった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?store_id=glv&page_key=dog-93'),
('dogcopenhagen-comfort-walk-pro','アフガン・ハウンド',NULL,NULL,'escape neck','頭が小さく胸板が厚いのに幅が薄く、たいていのハーネスがするりと抜けるアフガン・ハウンドで、チェーンの首輪で首を痛めたこともあったが、安定して歩けて抜けなくなった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?store_id=glv&page_key=dog-93'),
('dogcopenhagen-comfort-walk-pro',NULL,NULL,NULL,'scared pull escape','人や外が怖く、外に出るとパニックになって常に逃げる体勢で引きも強い11.5kgの犬で、2年で6個買った末にようやく満足できるハーネスに出会えた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?store_id=glv&page_key=dog-93'),
('dogcopenhagen-comfort-walk-pro','コーギー',NULL,NULL,'pull trachea handle','Julius-K9では引っ張りが強く首が締まってゼーゼーしていた細身の12kgのコーギーで、前側にリードを付けると引っ張りが減り、背中の持ち手でドッグランでも安心な体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?store_id=glv&page_key=dog-93'),
('dogcopenhagen-comfort-walk-pro','ミニチュアブルテリア',NULL,NULL,'skin','肌が弱くイージーウォークでは当たる所が赤くなった1歳・16kgのミニブルで、引っ張り抑制はイージーウォークの方が強いが、皮膚への負担が軽くバックルの装着も楽な体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?store_id=glv&page_key=dog-93'),
('dogcopenhagen-comfort-walk-pro',NULL,NULL,NULL,'senior trachea','ハーフチョークを使っていたがシニアになり逆くしゃみをするようになったため、気管に負担の少ないものとして選んだ30kgの犬で、Lでかつかつだが抜けないことを考えればぴったりな体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?store_id=glv&page_key=dog-93'),
('dogcopenhagen-comfort-walk-pro','ブルドッグ',NULL,NULL,'puppy sizing','体重22kgの若いブルドッグにL。届いた時はきついかと思ったが、アジャスターで調整して問題なく使えている体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?store_id=glv&page_key=dog-93'),
('dogcopenhagen-comfort-walk-pro','シェルティ',NULL,NULL,NULL,'Julius-K9、Curli、Hurttaと使ってきた10kgのシェルティで、Hurttaは背中下部のよれが気になり、今回は良さそうだと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?store_id=glv&page_key=dog-93'),
('dogcopenhagen-comfort-walk-pro','バーニーズ・マウンテン・ドッグ',NULL,NULL,'sizing','45kgのがっちりしたバーニーズで、採寸してLを選んだが思ったより小さくXLに交換した体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?store_id=glv&page_key=dog-93'),
('dogcopenhagen-comfort-walk-pro','ミックス',NULL,NULL,'sizing','体重40kgのミックスにXLを調整ベルト最小でちょうど良く使っている体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?store_id=glv&page_key=dog-93'),
('dogcopenhagen-comfort-walk-pro','シェルティ',NULL,NULL,'pull','17kgの大きめのシェルティにM。フロント部分にもフックがあり、引っ張る子に向いていると感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?store_id=glv&page_key=dog-93'),
('dogcopenhagen-comfort-walk-pro','ゴールデンレトリバー',NULL,NULL,'sizing','28kgのゴールデンにLがぴったりで、4か所で調整できる点が良い体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?store_id=glv&page_key=dog-93'),
('dogcopenhagen-comfort-walk-pro',NULL,'large',NULL,'pull escape handle','ドッグトレーナーに勧められて選び、首から胴まで一体化していて抜けず、引きの強い大型犬には前のリングにリードを付けるのがおすすめだと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?store_id=murol&page_key=154220242-M'),
('dogcopenhagen-comfort-walk-pro',NULL,NULL,NULL,'skin pull handle','イージーウォークで脇が擦れて炎症を起こし、引っ張りで首も苦しそうだった犬で、胸の部分が広く体全体を包み込むので苦しくなさそうな体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?store_id=murol&page_key=154220242-M'),
('dogcopenhagen-comfort-walk-pro','柴犬',NULL,NULL,'handle durability','体にフィットして安定し強度もあり、ドッグランで捕まえる時に合皮で覆われた持ち手がつかみやすい柴犬の体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?store_id=murol&page_key=154220242-M'),
('dogcopenhagen-comfort-walk-pro','ラブラドール',NULL,NULL,'sizing','25kgの黒ラブでLが品切れのためMを選び、調整して収まったが、首回りの調整にバックルがないので余裕を持たせる必要があった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?store_id=murol&page_key=154220242-M'),
('dogcopenhagen-comfort-walk-pro','ボーダーコリー',NULL,NULL,'puppy durability','10か月のボーダーコリーで、1日2回2〜3時間使って2か月たってもほつれやへたりがなく、首への負担も軽くなった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?store_id=murol&page_key=154220242-M'),
('dogcopenhagen-comfort-walk-pro','ラブラドール',NULL,NULL,'skin','前のハーネスで脇の下が擦れて嫌がっていた27kgのラブラドールにL。これは不快ではなさそうな体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?store_id=murol&page_key=154220242-M'),
('dogcopenhagen-comfort-walk-pro','フレンチブルドッグ',NULL,NULL,'skin','皮膚が弱く脇が擦れないことを条件に探した15kgのフレブルで、首と胸はクッションが効き、胴の留め具が脇から少し離れているので擦れない体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?store_id=murol&page_key=154220242-M'),
('dogcopenhagen-comfort-walk-pro','コーギー・甲斐犬ミックス',NULL,NULL,'multi skin','コーギーと甲斐犬ミックスに使い、胸の辺りが広く体をしっかり包み、軽くて擦れたり当たったりする場所も見当たらない体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?store_id=murol&page_key=154220242-M'),
('dogcopenhagen-comfort-walk-pro','紀州犬',NULL,NULL,'sizing','18kgの紀州犬にぴったりで、真っ白な犬にブルーがよく似合った体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?store_id=murol&page_key=154220242-M'),
('dogcopenhagen-comfort-walk-air',NULL,NULL,NULL,'pull escape sizing','首回り35cm・胸囲53cm・10kgでSとMの境目に迷いSを最大にしてぴったり。がっちりホールドされ、引っ張り癖があっても抜けない体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?store_id=starry&page_key=dog8-002-200923'),
('dogcopenhagen-comfort-walk-air',NULL,NULL,NULL,'skin clothes','メガネ形のハーネスで脇が擦れていた胴囲43cmの犬で、服も考えてSに。メガネ形よりがっちりして抜ける心配がないが、慣れるまで着脱に少し手間取る体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?store_id=starry&page_key=dog8-002-200923'),
('dogcopenhagen-comfort-walk-air','パグ',NULL,NULL,'stiff','暑がりのため使っていたラフウェアは体を覆う面積と硬さが気になり、こちらに替えて3本目になったパグの体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?store_id=starry&page_key=dog8-002-200923'),
('dogcopenhagen-comfort-walk-air','柴犬',NULL,NULL,'dislike-on easy-on','頭を通すタイプを嫌がり毎回着けるのが大変だった胴回り54cm・10kgの柴犬で、首回りにバックルがあるのですんなり着けられ、散歩の準備が短くなった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?store_id=starry&page_key=dog8-002-200923'),
('dogcopenhagen-comfort-walk-air','ジャックラッセルテリア',NULL,NULL,'clothes','胸周り42cm・5.5kgのジャックラッセルにXSがぴったり。薄手の服なら大丈夫だが、厚手の服ならSが良さそうな体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?store_id=starry&page_key=dog8-002-200923'),
('dogcopenhagen-comfort-walk-air',NULL,NULL,'long',NULL,'長毛の10kgの犬にSでまだ余裕があり、少し毛玉になるがハーネスなら仕方ないと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?store_id=starry&page_key=dog8-002-200923'),
('dogcopenhagen-comfort-walk-air','イングリッシュ・コッカー・スパニエル',NULL,NULL,'pull','引っ張りが強い8kgのイングリッシュ・コッカーにS。着けて散歩するとあまり引っ張らなくなった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?store_id=starry&page_key=dog8-002-200923'),
('dogcopenhagen-comfort-walk-air','ボーダーコリー',NULL,NULL,'puppy sizing','生後半年のボーダーコリーにMを買ったがまだ大きく、色違いでSを追加した体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?store_id=starry&page_key=dog8-002-200923'),
('dogcopenhagen-comfort-walk-air',NULL,NULL,NULL,'pull','引っ張り防止にはわりと効果がありそうで安心感はあるが、少し重く夏は暑いかもしれないと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?store_id=starry&page_key=dog8-002-200923'),
('dogcopenhagen-comfort-walk-air','ミニチュアシュナウザー',NULL,NULL,'sizing','アジャスターが4か所ある点で選び、首回り30cm・胴回り46cm・7.4kgのシュナウザーにSがぴったりだった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?store_id=goodslabo&page_key=dch-walkair-s'),
('hakusan-zero4-harness',NULL,NULL,NULL,'pull trachea','帰りたくなると引っ張り、喉がヒューヒュー鳴るのが悩みだったが、このハーネスではならなくなった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?store_id=1stdogcafe&page_key=10000913'),
('hakusan-zero4-harness',NULL,NULL,NULL,'sizing','別ブランドのハーネスを参考にMを選んだら窮屈で、XLに交換。少し余裕はあるが脱げず、クッションもふかふかで負担がかからなそうな体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?store_id=1stdogcafe&page_key=10000913'),
('hakusan-zero4-harness','ミックス',NULL,NULL,'trachea sizing','気管に負担がかかりにくいものとして選んだ5kgの小型のミックスで、咳き込みは減ったが、首から腹側の調整が難しくがばがばで、小型犬には身幅が大きいかもしれないと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?store_id=1stdogcafe&page_key=10000913'),
('hakusan-zero4-harness',NULL,NULL,NULL,'sizing','胴回りが太い38kgの犬にXLで余裕があるが、首回りは細いのでもう少し詰められると良かった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?store_id=1stdogcafe&page_key=10000913'),
('anisapo-harest','柴犬',NULL,NULL,'pull trachea','前のハーネスで前に進まれるたびにゼェゼェし、水を飲む時もむせることが増えた11kgの柴犬で、コントロールしやすくなったが、歩くたびに首側がぱかぱかする体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/352568_10020523/1.1/'),
('anisapo-harest','柴犬',NULL,NULL,'senior trachea','15歳半で気管虚脱のグレード3と診断され、首輪からハーネスへの変更を勧められた13kgの柴犬で、首輪の時のゲホゲホがこのハーネスでは出なかった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/352568_10020523/1.1/'),
('ironbaron-honeycomb',NULL,NULL,NULL,'senior mobility','16歳近くなり立ち上がりや歩行に介助が必要になった犬で、中腰で胴を持ち上げる負担を減らすために購入し、4か月使った体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/195679_10000490/1.1/'),
('ironbaron-honeycomb','ブルマスチフ',NULL,NULL,'senior mobility','平均寿命を越えようとする高齢のブルマスチフが自力で立ち上がれなくなり、評判を調べてこの介助用ハーネスを選んだ体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/195679_10000490/1.1/'),
('ironbaron-honeycomb','ジャーマン・シェパード',NULL,NULL,'senior mobility sizing','13歳で足腰が弱ったシェパードに、胴の最も太い部分を測って購入。胴はきつく寝る時は少し緩めるが、介助はとても楽になった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/195679_10000490/1.1/'),
('ironbaron-honeycomb',NULL,'large',NULL,'senior mobility','もともと後ろ足が弱っていた大型の老犬が、急に前足にも力が入らず立てなくなったため購入し、ふらつきが残る時期の歩行介助に使った体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/195679_10000490/1.1/'),
('ironbaron-honeycomb','柴系ミックス',NULL,NULL,'senior mobility','後ろ足が弱った17歳・12〜13kgの柴系ミックスにSS。少し大きかったが使え、亡くなる前日まで3か月間毎日の介助に役立った体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/195679_10000490/1.1/'),
('ironbaron-honeycomb','ゴールデンレトリバー',NULL,NULL,'senior mobility','後ろ足が弱り、玄関の段差でつまずいたり廊下でずり落ちたりするようになった14歳のゴールデンのために選んだ体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/195679_10000490/1.1/'),
('ironbaron-honeycomb','ゴールデンレトリバー',NULL,NULL,'senior mobility sizing','体重32kg・胴回り85cm前後の13歳のゴールデンで、サイズに悩みショップの助言でMを選択。ファスナーが2か所あり状態に合わせて使い分けられる体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/195679_10000490/1.1/')
)
INSERT INTO reviews(product_id,dog_breed,dog_size,coat_type,needs,summary,source_type,source_url)
SELECT n.product_id,n.dog_breed,n.dog_size,n.coat_type,n.needs,n.summary,n.source_type,n.source_url
FROM new_reviews n
WHERE NOT EXISTS (
  SELECT 1 FROM reviews r
  WHERE r.product_id=n.product_id
    AND r.summary=n.summary
);

WITH new_reviews(product_id,dog_breed,dog_size,coat_type,needs,summary,source_type,source_url) AS (
VALUES
('ironbaron-honeycomb',NULL,NULL,NULL,'mobility','階段の上り下りができなくなり、抱えて外へ排泄に連れ出すのに限界を感じて購入。抱える時は不安がっていたが、2日ほどで大人しく着るようになった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/195679_10000490/1.1/'),
('ironbaron-honeycomb','ラブラドール',NULL,NULL,'senior mobility sizing','自力で立つのが難しくなった16歳の大柄なラブラドールで、前回のMは腹回りがぶかぶかで、留守番中に前足が片方の穴に両方入って動けなくなったことがあった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/195679_10000490/2.1/'),
('ironbaron-honeycomb','ラブラドール',NULL,NULL,'mobility','骨肉腫で断脚した12歳のラブラドールで、3本脚になってから持ち手で体を少し支えながら歩く介助に使った体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/195679_10000490/2.1/'),
('ironbaron-honeycomb','シェルティ×コリー',NULL,NULL,'senior mobility','美容室で靭帯を損傷し片足が着かなくなった17歳・14kgのミックスにSS。外でしか排泄しないため朝夕夜に着けて少し歩いている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/195679_10000490/2.1/'),
('ironbaron-honeycomb',NULL,'large',NULL,'mobility','急に自力で立てなくなった25kgの大型犬で、女性が起き上がらせるのは大変だったため購入し、外での排泄の介助に使っている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/195679_10000490/2.1/'),
('ironbaron-honeycomb','ゴールデンミックス',NULL,NULL,'mobility','4年前に関節を痛めた時に持ち手1つのタイプが役立ち、ふらつきや段差・溝の乗り越えに介助が必要になった16歳・19kgのゴールデンミックスに持ち手2つのタイプを買った体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/195679_10000490/2.1/'),
('ironbaron-honeycomb','ゴールデンレトリバー',NULL,NULL,'sizing','13歳・25kgの標準体型のゴールデンにS。狭い方のファスナーでぴったりだが、横になる時は胸が苦しそうなので広い方を使っている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/195679_10000490/2.1/'),
('terubell-wonderfit','柴犬',NULL,NULL,'escape sizing','体重が同じでも採寸がコーギーとまったく違った9kgの柴犬にXL。散歩の終盤に歩くのを拒否して踏ん張るとよく抜けていたが、抜けなくなった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/255000_10000657/1.1/'),
('terubell-wonderfit',NULL,NULL,NULL,'escape','すっぽ抜け防止をうたうハーネスはいろいろあるが、これは一度も抜けたことがない。散歩中は引かれて中心線がずれるが、犬は嫌がっていないという体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/255000_10000657/1.1/'),
('terubell-wonderfit',NULL,NULL,NULL,'puppy escape','着ける時に暴れるわんぱくな子犬で、簡単装着のハーネスはどれも散歩中に抜けてしまったため、すがる思いで選んだ体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/255000_10000657/1.1/'),
('terubell-wonderfit','ミニチュアダックスフンド',NULL,'short','skin sizing','5.2kgのスムースのダックスに20mm幅のMを選んだら、交差部分が浮いて毛の少ない脇が痛そうだったため、15mm幅のSに交換した体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/255000_10000657/1.1/'),
('terubell-wonderfit','チワックス',NULL,NULL,'sizing','4.3kgのチワックスに採寸して大きめのMを選んだらぶかぶかで、幅も思ったより広かったためSに交換した体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/255000_10000657/1.1/'),
('terubell-wonderfit','チワックス',NULL,NULL,'escape clothes','前のハーネスは首がぶかぶかで、犬同士で遊ぶと抜けることがあった3.3kgのチワックスで、装着とサイズ調整が簡単なものとして選び、冬のコートの上からも使えそうな体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/255000_10000657/1.1/'),
('terubell-wonderfit','黒柴',NULL,NULL,'sizing','1歳10か月・12kgの黒柴で、LとXLに迷い大きめのXLにしてちょうど良く、太めの幅の方が安心だと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/255000_10000657/2.1/'),
('terubell-wonderfit','トイプードル',NULL,NULL,'pull escape chew','引きが強くすっぽ抜けが気になってきた6.3kgのトイプードルで、抜ける心配がなくなった。噛み癖があり首を通す時は一苦労という体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/255000_10000657/2.1/'),
('terubell-wonderfit','チワワ2頭',NULL,NULL,'multi escape scared','チワワ2頭を1人で散歩中、子犬が他の犬を怖がっている間にもう1頭が後ずさりしてハーネスが抜けたことがあり、このショップのハーネスに替えた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/255000_10000657/2.1/'),
('terubell-wonderfit','ポメラニアン×ハスキー',NULL,NULL,'sizing','体はハスキー寄りで毛はポメラニアン寄りの20kg弱のミックスで、前のハーネスの金具にひびが入ったため替え、サイズを選び直した体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/255000_10000657/2.1/'),
('terubell-wonderfit',NULL,NULL,NULL,'escape clothes','レインコートやアウターの上から使える薄手で抜けにくいものを探し、手持ちの薄手ハーネスは飛びかかられて後ずさりした時に抜けたことがあった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/255000_10000657/2.1/'),
('terubell-wonderfit','柴犬',NULL,NULL,'easy-on sizing','首回りが変えられないハーネスで位置がずれていた14kgのむっちりした柴犬で、首と胴を簡単に調整でき、前足に触らずに着脱できる体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/255000_10000657/2.1/'),
('terubell-wonderfit','柴犬',NULL,NULL,'sensitive dislike-on','服もマジックテープも前足を通すのも受け付けない過敏な7.9kgの柴犬で、初めて着けた時は噛みつかれそうになったが、布の少ないこの形を選んだ体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/255000_10000657/2.1/'),
('terubell-wonderfit','コーギー',NULL,NULL,'escape easy-on','抜けにくいものを探した11.5kgのコーギーで、留める場所が1か所なので着脱しやすいが、最初は調整部分が硬く手間取った体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/255000_10000657/3.1/'),
('radica-cordura-harness',NULL,NULL,NULL,'easy-on dislike-on','顔を通すのが苦手な犬で、留め具を外して足を入れてからでも余裕があり、すんなり着けられた。調整し直さなくても毎回ぴったり合う体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/255378_10021956/1.1/'),
('radica-cordura-harness',NULL,NULL,NULL,'clothes','サイズ調整がとても簡単で、裸の時も厚い冬服の時もさっと着けられ、軽く薄く洗ってもすぐ乾く。リードをつなぐ布が長く、走ると金具が体に当たって痛そうという体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/255378_10021956/1.1/'),
('radica-cordura-harness',NULL,NULL,NULL,'trachea','誤嚥性肺炎で入院したことがあり、首輪からハーネスへ替えた3kgの犬で、撥水で軽く、胸のクッション性も良いと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/255378_10021956/1.1/'),
('radica-cordura-harness','ミニチュアダックスフンド2頭',NULL,NULL,'multi easy-on','ミニチュアダックス2頭にM。マジックテープ式から替え、簡単に着けられて2頭とも嫌がらなかった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/255378_10021956/1.1/'),
('radica-cordura-harness','ミニチュアダックスフンド',NULL,NULL,'puppy','5か月のミニチュアダックスで、足が短くてもハーネスで大丈夫か心配だったが、数日使って問題なさそう。前足の穴の裏にもう少しクッションが欲しいという体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/255378_10021956/1.1/'),
('radica-cordura-harness','トイプードル',NULL,NULL,'senior sizing','15歳のトイプードルのため軽くて着けやすいものを探し、胸板が厚く胴回りで合わせると中心が少し首寄りになるが、問題なく散歩できる体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/255378_10021956/1.1/'),
('radica-cordura-harness','ミニチュアダックスフンド',NULL,NULL,'sizing clothes','体格の良いダックスでLLは大きすぎる気がしてLにしたらしっくりきた。裸でも服の上でも合い、首や胸の一点に圧がかからないと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/255378_10021956/1.1/'),
('radica-cordura-harness','チワワ',NULL,NULL,'puppy','なかなか散歩したがらない1.95kgのチワワの子犬に使い、着けやすく便利だった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/255378_10021956/2.1/'),
('radica-cordura-harness','マルプー',NULL,NULL,'escape easy-on','4.5kgのマルプーで、装着が簡単で後ずさりしても抜けることはないという体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/255378_10021956/2.1/'),
('radica-cordura-harness','マルチーズ×チワワ',NULL,NULL,'clothes sizing','2.8〜2.9kgのマルチワにSがぴったり。服を着ると難しいので冬はMにする予定という体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/255378_10021956/3.1/'),
('radica-cordura-harness','チワワ',NULL,NULL,'puppy escape','縦横無尽に動き回るやんちゃな1kgのチワワの子犬で、抜けたりせず安心して散歩でき、調整できるので成長しても使えそうな体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/255378_10021956/3.1/'),
('radica-cordura-harness',NULL,NULL,NULL,'sizing skin','モデル犬の豆柴を参考にLLを選んだが、6kgの弟犬にLを試すと着丈が短く脇が擦れそうだったという体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/255378_10021956/3.1/'),
('suzukoubou-standard','パグ',NULL,NULL,'escape sizing','首と胴に合わせると胴の長さが合わず、きつめのものを使うしかなかったパグで、パグ・フレブル向けの形のため胴回りに余裕を持ちつつ合わせられた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/278852_10001829/1.1/'),
('suzukoubou-standard','柴犬',NULL,NULL,'escape','散歩中に歩くのを拒否して踏ん張ることが多い11kgの柴犬にL。生地がまだ硬いためか、脱ぐ時に頭が引っかかるという体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/278852_10001829/1.1/'),
('suzukoubou-standard',NULL,NULL,NULL,'escape','散歩中にハーネスが抜けてひやっとしたことがあり、抜けにくいものを急いで探して選び、装着も簡単だった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/278852_10001829/1.1/'),
('suzukoubou-standard','マルプー',NULL,NULL,'sizing','5.5kgの大きめのマルプーで、サイズを上げるか迷ったが体重からSのままを勧められ、首輪と2本のリードで使っている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/278852_10001829/1.1/'),
('suzukoubou-standard','パグ2頭',NULL,NULL,'multi easy-on','6kgと7kgのパグ2頭に使い、服を着られる子なら片方の前足を通すだけなので簡単。頭を通すのを嫌がる犬はいるかもしれないという体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/278852_10001829/1.1/'),
('suzukoubou-standard','黒柴',NULL,NULL,'skin sizing','皮膚が弱く脇の擦れが気になっていた6kg台の黒柴で、少し小さく感じたS+からゆとりのあるMに替えて良かったという体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/278852_10001829/2.1/'),
('suzukoubou-standard','チワワ×トイプードル',NULL,NULL,'puppy sizing','6か月前・約2.8kgのチワプーで、SとSS+に迷いショップに相談して勧められたSS+を選んだ体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/278852_10001829/2.1/'),
('suzukoubou-standard','トイプードル',NULL,NULL,'escape sizing','ベスト一体型のハーネスで抜けた経験がある胴の太い4kgのトイプードルで、届いた時は小さいと焦ったが、同封の冊子の手順で合わせられた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/278852_10001829/3.1/'),
('suzukoubou-standard','ポメラニアン',NULL,NULL,'sizing','胴回り約35cm・3.7kgのポメラニアンに胴回りに合わせてSを選んだら、首回りは一番小さくしてもぶかぶかだったという体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/278852_10001829/3.1/'),
('suzukoubou-standard','ペキニーズ',NULL,NULL,'escape','体に負担が少なく抜けにくいものを探していた7歳の大きめのペキニーズで、とてもしっかりした作りだと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/278852_10001829/3.1/'),
('suzukoubou-standard',NULL,'small',NULL,'scared escape','怖がりの小型犬のため抜けにくいH型を探して選び、サイズを細かく調整でき中央のクッションも優しい。それでも心配で首輪と2本のリードにしている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/278852_10001829/3.1/'),
('suzukoubou-standard','マルチーズ',NULL,NULL,'escape stiff','胴回り45cm・5.6kgのマルチーズにM。しっかりしていて抜けにくいが、素材が硬く馴染むまで時間がかかりそうで、片前足を通す着脱に少し手間取る体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/278852_10001829/3.1/'),
('happy-heel-harness','スタンダードプードル',NULL,NULL,'pull','訓練所に通っても飛びつきと引っ張りがひどく、人や犬のいない時間にしか散歩できなかった1歳のスタンダードプードルで、引っ張りがかなり収まった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/309454_10000259/1.1/'),
('happy-heel-harness','雑種',NULL,NULL,'pull','ジグザグ歩きと強い引っ張りがあり猫やキツネを見ると興奮する1歳半の筋肉質な中型の雑種で、すぐ直ったわけではないが付属DVDのとおり辛抱強く取り組み改善してきた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/309454_10000259/1.1/'),
('happy-heel-harness',NULL,NULL,NULL,'pull','とても元気で引っ張りがすごい20kgほどの保護犬で、坂道の多い散歩で膝や腕が痛かったが、本当に引っ張らなくなったという体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/309454_10000259/1.1/'),
('happy-heel-harness','豆柴',NULL,NULL,'escape sizing','5kgの豆柴にSで少し大きめだが、引くと締まる仕組みのため抜けることはなさそうだと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/309454_10000259/1.1/'),
('happy-heel-harness','ボストンテリア',NULL,NULL,'skin pull','引っ張りがあり、擦れにくいとされるハーネスでも脇の下が擦れていた6kgのボストンテリアで、前のバンドは緩いが抜けることはなかった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/309454_10000259/1.1/')
)
INSERT INTO reviews(product_id,dog_breed,dog_size,coat_type,needs,summary,source_type,source_url)
SELECT n.product_id,n.dog_breed,n.dog_size,n.coat_type,n.needs,n.summary,n.source_type,n.source_url
FROM new_reviews n
WHERE NOT EXISTS (
  SELECT 1 FROM reviews r
  WHERE r.product_id=n.product_id
    AND r.summary=n.summary
);

WITH new_reviews(product_id,dog_breed,dog_size,coat_type,needs,summary,source_type,source_url) AS (
VALUES
('happy-heel-harness','トイプードル',NULL,NULL,'pull multi','4頭のうち1頭だけ引っ張りが強かった8kgの大きめのトイプードルで、使い始めた日から引っ張らず腕が疲れなくなった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/309454_10000259/1.1/'),
('happy-heel-harness','ペキニーズ',NULL,NULL,'pull','引っ張り癖のある4.5kgのペキニーズで、最初は装着に戸惑ったが付属DVDを見て着け、帰り道にはリードが張らなくなった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/309454_10000259/1.1/'),
('happy-heel-harness',NULL,NULL,NULL,'puppy sizing','胴回り51cmの4か月の子犬に成長を見越してMを選んだら大きすぎ、胸前のベルトは一番小さくしても垂れ下がったという体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/309454_10000259/1.1/'),
('happy-heel-harness','トイプードル・ヨークシャーテリア',NULL,NULL,'pull multi','暴走しがちな6歳・7.5kgのトイプードルと3kg弱のヨーキーを一緒に散歩するのが大変だったが、無理なくゆっくり歩くようになった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/309454_10000259/2.1/'),
('happy-heel-harness','ミニチュアダックスフンド',NULL,NULL,'dislike-on sizing','チョークタイプの首輪を強く嫌がった7kg近い大きめのミニチュアダックスで、ハーネス型なら嫌がらないと考えて選び、Sを一番締めても少し余裕がある体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/309454_10000259/2.1/'),
('happy-heel-harness',NULL,NULL,NULL,'pull sizing','胸板が厚い10kgほどの犬で、玄関を出た途端に引っ張るが、先に行ってもすぐ振り向かせられるので車や拾い食いの危険からも安心できる体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/309454_10000259/2.1/'),
('happy-heel-harness',NULL,NULL,NULL,'pull','猟犬系の保護犬を預かることが多く、走りたがる犬が多いため引っ張り防止ハーネスが欠かせない。以前の製品よりサイズを合わせやすいと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/309454_10000259/2.1/'),
('happy-heel-harness','スタンダードプードル',NULL,NULL,'pull trachea','ハーフチョークで首への負担が心配だった1歳半のスタンダードプードルで、普通のハーネスだとさらに引くのではと迷ったが、引っ張りを止める用途で選んだ体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/309454_10000259/2.1/'),
('happy-heel-harness','スタンダードプードル',NULL,NULL,'pull','ハーフチョークでは効かず、突然のダッシュや後ろ足立ちで散歩が苦痛だったスタンダードプードルで、まず引っ張らなくなったことに驚いた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/309454_10000259/2.1/'),
('truelove-handle-harness','フレンチブルドッグ',NULL,NULL,'sizing','9kgのフレブルで、同じ型のSを使っていたが頭を抜く時に耳が引っかかるため、胴回りを測り直してMに替えた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/378148_10000034/1.1/'),
('truelove-handle-harness','フレンチブルドッグ',NULL,NULL,'puppy escape','8か月・12kgのフレブルにM。首回りも胴回りも調整でき、この形でよくある首からのすっぽ抜けも起きそうにないと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/378148_10000034/1.1/'),
('truelove-handle-harness','ラブラドール',NULL,NULL,'sizing','胸囲90cmで胸板の厚い35kgの黒ラブにXL。まだ余裕はあるが、大型犬用としては少し小さめに感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/378148_10000034/1.1/'),
('truelove-handle-harness','ウェルシュ・コーギー・カーディガン',NULL,NULL,'sizing','1歳8か月・12kgのコーギー・カーディガンで、SとMに迷い問い合わせたうえでMにして良かったと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/378148_10000034/2.1/'),
('truelove-handle-harness','ゴールデンレトリバー',NULL,NULL,'puppy sizing','8か月・30kgのゴールデンでMが小さくなりLを購入。途中で試した別のハーネスは安っぽく体に沿わず、犬が気にして散歩に集中できなかった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/378148_10000034/2.1/'),
('truelove-handle-harness','雑種2頭',NULL,NULL,'multi pull trachea','どちらも引っ張り癖がひどい22kgの雑種2頭にL。首を通すだけで着けられ、首輪の時より喉の負担が減ったようでゼーゼー言わなくなった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/378148_10000034/2.1/'),
('truelove-handle-harness','フレンチブルドッグ',NULL,NULL,'puppy sizing','胸幅が広く一般的な体重別のハーネスが合わなかった5か月・4.5kgのフレブルに、Sをかなり小さく調整して使っている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/378148_10000034/2.1/'),
('truelove-handle-harness','ボストンテリア',NULL,NULL,'sizing clothes','首と胴のバランスが合うものがなかった11kgのボストンテリアにM。冬に服を着て胴回りが大きくなっても合わせられる体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/378148_10000034/2.1/'),
('truelove-handle-harness','ボーダーコリー',NULL,NULL,'pull','18kgのボーダーコリーにM。前に付いた引っ張り防止のリングが散歩で大活躍している体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/378148_10000034/2.1/'),
('truelove-handle-harness','ラブラドール',NULL,NULL,'trachea sizing','喉が弱くフィットするものを探していた27kgのラブラドールにL。胴回りは最大にしてぴったりで、太るときつくなりそうな体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/378148_10000034/2.1/'),
('truelove-handle-harness','雑種',NULL,'long','escape','長毛で首輪だとすっぽ抜けてしまう4歳・13kgの雑種で、サイズ表ではSだがレビューを参考にMにしてちょうど良かった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/378148_10000034/2.1/'),
('truelove-handle-harness',NULL,'large',NULL,'senior','横について歩きほとんど引かない12歳・25kgの大型のミックスで、高齢で首輪は首に負担と聞き、初めてハーネスにした体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/378148_10000034/2.1/'),
('truelove-handle-harness','ドーベルマン',NULL,NULL,'senior','首への負担を考えて前からもリードを付けられるものを探した、37kgのシニアのドーベルマンで、前・後ろ・背中の3点で誘導でき、当たりも優しい体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/378148_10000034/2.1/'),
('truelove-handle-harness','柴犬',NULL,NULL,'pull multi','2頭のうち引っ張り癖が抜けない8kgの柴犬にS。首輪より引かなくなった気がするが、体が細く頭が大きいため着脱時に頭を通すのが少しきつい体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/378148_10000034/3.1/'),
('truelove-handle-harness',NULL,NULL,NULL,'pull sizing','引っ張り癖がある3.5kgの犬で、胸にリングがあるタイプが一番効果があると感じた。首回りを合わせると頭が入らなくなるため少し緩めにしている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/378148_10000034/3.1/'),
('funcoma-harness-lead','トイプードル',NULL,NULL,'puppy sizing','2.1kgのトイプードルの子犬にはサイズが小さくて留まらず、首の下とお腹のバックルを留めるのも、ハーネスで遊んでしまい大変だった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/392151_10000004/1.1/'),
('funcoma-harness-lead',NULL,NULL,NULL,'sizing','4.2kgの犬にMがきつく、胴のベルトは使わずマジックテープだけでぎりぎり留めている。引っ張らない犬なので何とか使えているという体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/392151_10000004/1.1/'),
('funcoma-harness-lead',NULL,NULL,NULL,'dislike-on','前の高いハーネスは嫌がって、見せるたびに逃げていた犬で、マジックテープとバックルの二重で留まる安価なこのタイプにした体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/392151_10000004/1.1/'),
('funcoma-harness-lead','トイプードル',NULL,NULL,'chew','2.3kgの細めのトイプードルでサイズは合ったが、つないで離れている間に首元のバックルをつなぐテープを噛みちぎられた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/392151_10000004/1.1/'),
('funcoma-harness-lead','トイプードル2頭',NULL,NULL,'multi sizing','胸回り30cm・4kgのトイプードルにM、胸回り47cm・6kgのトイプードルにXLを選び、大きい子にもサイズが合うか心配していた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/392151_10000004/1.1/'),
('funcoma-harness-lead','ミニチュアダックスフンド',NULL,NULL,'puppy escape','迎えたばかりの4か月・3.3kgの暴れん坊のミニチュアダックスで、抜けると事故につながるためぴったりのサイズを探し、ジャストフィットした体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/392151_10000004/1.1/'),
('funcoma-harness-lead','トイプードル・ミニチュアダックスフンド',NULL,NULL,'multi puppy','3歳半のトイプードルにL、散歩デビューの4か月のダックスにSを選び、ダックスは5か月半でサイズアウトしてMを買い直した体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/392151_10000004/2.1/'),
('funcoma-harness-lead','シーズー',NULL,NULL,'sizing','6kgのシーズーでLとXLに悩みLでジャスト。毛が伸びると窮屈になるかもしれないと心配している体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/392151_10000004/2.1/'),
('funcoma-harness-lead','チワワ',NULL,NULL,'durability','激しい散歩はしないチワワで物は良かったが、リード側の金具が緩く、ハーネス側の金具周りの縫製も甘いため、力の強い犬では心配で補強を考えた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/392151_10000004/2.1/'),
('funcoma-harness-lead','ヨークシャーテリア',NULL,NULL,'sizing','服のような見た目のハーネスが欲しかった3kgのヨーキーで、胴回りは合ったが首回りが大きく少し直した体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/392151_10000004/2.1/'),
('funcoma-harness-lead',NULL,NULL,NULL,'senior clothes','4kgの高齢の犬に服の上から着け、マジックテープとバックルの二重で調整できる安心感がある。付属のナイロンリードは滑りやすいという体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/392151_10000004/3.1/'),
('laluca-wear-harness','トイプードル',NULL,NULL,'puppy','1.2kgのトイプードルの子犬にXS。背中の金具はつまんでスライドさせる方式で、カチッとはめるタイプより使いやすかった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/395228_10000031/1.1/'),
('laluca-wear-harness','コッカースパニエル',NULL,NULL,'escape','首が細く力が強くせわしなく動くため、何個買っても首から抜けていた7kgのコッカーで、背中のひもは薄く不安だったが、ひもで体格に合わせて調整でき今までより安心な体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/395228_10000031/1.1/'),
('laluca-wear-harness','トイプードル',NULL,NULL,'clothes multi','4kg弱のトイプードルにM。服を着てもゆとりがあり、冬の厚い服でも使えそう。2頭いるので価格が安いのが助かる体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/395228_10000031/1.1/'),
('laluca-wear-harness','チワックス',NULL,NULL,'escape skin','胴長でやせ形のため、これまでのハーネスは抜けたり脇が擦れたりしていた4.2kgのチワックスで、Sがぴったりで抜けず脇も大丈夫だった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/395228_10000031/2.1/'),
('laluca-wear-harness','チワプー',NULL,NULL,'puppy sizing','1.5kgの小柄なチワプーの子犬で、成長を見越してSにしたら少し大きめだが、余裕があって着けやすかった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/395228_10000031/2.1/'),
('laluca-wear-harness',NULL,NULL,NULL,'puppy escape','抱っこから飛び降りたことがあり、首輪では不安だった3か月・1.5kgの子犬で、着けても嫌がらず走っていた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/395228_10000031/2.1/'),
('laluca-wear-harness','カニンヘンダックスフンド',NULL,NULL,'clothes','4kgのカニンヘンダックスで、夏は軽く薄いので良く、服を着せてもベルトのストッパーで調整できた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/395228_10000031/2.1/'),
('laluca-wear-harness','トイプードル',NULL,NULL,'puppy pull','3か月・2kgのトイプードルにXS。散歩中に引いても抜けなかったが、首から通すので暴れる子には少し手こずった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/395228_10000031/2.1/'),
('laluca-wear-harness','ミニチュアシュナウザー',NULL,NULL,'puppy sizing','初めてのハーネスとして選んだシュナウザーの子犬で、5kgの頃はぴったり、7kgを超えた今は少しきつく感じる体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/395228_10000031/3.1/'),
('laluca-wear-harness','チワプー',NULL,NULL,'puppy chew','1.3kgのチワプーの子犬にXS。リード部分を噛んでしまうので、すぐ傷まないか心配な体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/395228_10000031/3.1/'),
('laluca-wear-harness','ポメラニアン',NULL,NULL,'dislike-on easy-on','服嫌いの4kgのポメラニアンにS。着脱しやすい金具なので嫌がらずに着けられる体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/395228_10000031/3.1/'),
('moncheri-harness','チワワ',NULL,NULL,'scared escape','とても怖がりで、散歩中に怖がって後ずさりしY型のハーネスから抜け、猛ダッシュで逃げたことがある4.1kgの大きめのチワワで、抜けにくいものとして選んだ体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/406105_10001780/1.1/'),
('moncheri-harness','ミニチュアシュナウザー',NULL,NULL,'puppy pull trachea','首輪で引っ張ってゼーゼー言うのが気になっていた4か月・4kgのシュナウザーで、すっぽ抜け防止と、成長に合わせて各部を調整できる点で選んだ体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/406105_10001780/1.1/'),
('moncheri-harness','ポメラニアン',NULL,NULL,'escape clothes','ベスト型のハーネスで、他の犬に興奮して飛びかかろうとした時に何度か抜けた4kgのポメラニアンで、服を着たままでも調整でき着けるのも簡単な体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/406105_10001780/1.1/'),
('moncheri-harness',NULL,NULL,NULL,'puppy','落ち着きのない4か月・2kgの子犬に一番きつくしてぴったり。装着には手間取るが、抜けにくそうだと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/406105_10001780/1.1/')
)
INSERT INTO reviews(product_id,dog_breed,dog_size,coat_type,needs,summary,source_type,source_url)
SELECT n.product_id,n.dog_breed,n.dog_size,n.coat_type,n.needs,n.summary,n.source_type,n.source_url
FROM new_reviews n
WHERE NOT EXISTS (
  SELECT 1 FROM reviews r
  WHERE r.product_id=n.product_id
    AND r.summary=n.summary
);

WITH new_reviews(product_id,dog_breed,dog_size,coat_type,needs,summary,source_type,source_url) AS (
VALUES
('moncheri-harness','マルプー',NULL,NULL,'puppy dislike-on','足を通すタイプが苦手な7か月・2.1kgのマルプーで、頭を通して胴回りで留めるだけなので慣れやすかった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/406105_10001780/3.1/'),
('moncheri-harness','トイプードル',NULL,NULL,'easy-on','5kgのトイプードルにM。抜けにくい形を探していて、嫌がることなく着脱できる体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/406105_10001780/3.1/'),
('moncheri-harness','ポメラニアン',NULL,NULL,'chew sizing','3.9kgのポメラニアンにM。少しゆったり着けると噛んでしまうので、一番小さくして着けている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/406105_10001780/3.1/'),
('moncheri-harness','チワワ',NULL,'short','escape','1.6kgのスムースチワワに一番小さく調整してぴったり。バックルが2か所でひもも太く頑丈そうだが、コットン素材で体に当たっても痛くなさそうな体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/406105_10001780/3.1/'),
('moncheri-harness','マルプー',NULL,NULL,'pull trachea clothes','引っ張りが強く首輪から気管に負担の少ないものへ替えた4.9kgのマルプーで、冬服を着ても余裕があり、前足を触られるのが嫌いなので首から通せるのが良い体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/406105_10001780/3.1/'),
('moncheri-harness','マルプー',NULL,NULL,'chew easy-on','前のハーネスを噛んで3か月ほどで壊した3kgのマルプーで、首を通すだけで着けられ、リードを付けたまま着脱できる体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/406105_10001780/3.1/'),
('moncheri-harness','トイプードル',NULL,NULL,'senior trachea','散歩好きな11歳・5kgのシニアのトイプードルで、首輪から首に負担のかからないハーネスに替えた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/406105_10001780/3.1/'),
('thebestday-walking-belt','コーギー',NULL,NULL,'senior mobility','高齢で後ろ足が立たなくなった大柄なコーギーで、体重で生地にしわが寄り少し苦しそうに見えるが、試した中では一番使いやすく本人も歩きやすそうな体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/408415_10000514/1.1/'),
('thebestday-walking-belt','トイプードル',NULL,NULL,'mobility','最近左脚がよろけるようになった15歳・4.7kgのトイプードルにS。補助ベルトでサイズを合わせられ、肌触りも良さそうな体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/408415_10000514/1.1/'),
('thebestday-walking-belt','カニンヘンダックスフンド',NULL,NULL,'mobility','後ろ足の点滴の管を外した後うまく歩けなかった17歳のカニンヘンダックスに急いで使い、嫌がらずに着けて数日でなんとか歩けるようになった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/408415_10000514/1.1/'),
('thebestday-walking-belt','柴犬',NULL,NULL,'mobility sizing','足の踏ん張りが弱くなった15歳の柴犬で、SとLしかなくLを選んだが、胴回りはマジックテープで、持ち手の長さも調整できた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/408415_10000514/1.1/'),
('thebestday-walking-belt','トイプードル',NULL,NULL,'mobility','後ろ足が悪い15歳のトイプードルにS。装着が簡単でマジックテープで調整でき、まだ散歩に連れて行ってあげたいと思える体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/408415_10000514/1.1/'),
('thebestday-walking-belt','ミニチュアピンシャー',NULL,NULL,'mobility','脳腫瘍で平衡感覚がなくなり排泄に介助が必要になった4kgのミニピンで、装着が簡単で持ち手の長さを調整できるので飼い主の腰も痛くならない。長時間のリハビリでは体型のせいか少し気になる点もあった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/408415_10000514/1.1/'),
('thebestday-walking-belt','柴犬',NULL,NULL,'mobility sizing','右後ろ足を断脚した柴犬で、普段は3本足で頑張ってもらい、外で排泄する時だけ使っている。Lは少し大きくマジックテープで調整している体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/408415_10000514/1.1/'),
('thebestday-walking-belt','トイプードル',NULL,NULL,'mobility','前脚用・後ろ脚用で迷い、使いやすそうなこれを選んだ18歳のトイプードルで、簡単に着けられ何も使わないより安定する体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/408415_10000514/1.1/'),
('thebestday-walking-belt','パピヨン',NULL,NULL,'senior mobility','ヘルニアが悪化したシニアのパピヨンにS。散歩好きだった犬がだいぶ歩きやすくなり嬉しそうにしている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/408415_10000514/1.1/'),
('thebestday-walking-belt','トイプードル',NULL,NULL,'mobility sizing','脊髄梗塞で右の手足に麻痺が出た7kgのトイプードルで、胴回りが大きいためLを選び、少し大きいがマジックテープで調整して使えた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/408415_10000514/1.1/'),
('thebestday-walking-belt','トイプードル',NULL,NULL,'mobility','突然後ろ足が立たなくなった13歳のトイプードルで、使ってみても最初は全く歩かず、少し歩けるようになってから訓練用に使うことにした体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/408415_10000514/2.1/'),
('ruffwear-flagline','柴犬',NULL,NULL,'senior mobility','高齢の10kgの柴犬の介護用にXS。腹当てがあるのでお腹への負担が少なそうで、夏場用に前のウェブマスターから替えた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/266503_10001045/1.1/'),
('ruffwear-flagline','ゴールデンレトリバー',NULL,NULL,'puppy escape','安いハーネスは抜けやすかったため替え、15kgのゴールデンの子犬にM。抜ける気配がなく、やんちゃな子犬でも安心して散歩できる体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/266503_10001045/1.1/'),
('ruffwear-flagline','ミニチュアピンシャー',NULL,NULL,'escape','興奮するとぴょんぴょん跳ねてひやっとするミニピンに、ベルトが3本あるこのハーネスを選びXS。首回りは緩く、余ったひもを縫って詰めた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/266503_10001045/1.1/'),
('ruffwear-flagline',NULL,NULL,NULL,'escape sizing','XXSを使っていて、抜けにくく生地が薄めで体にフィットする。少し小さくなりワンサイズ上げたら、首回りだけ少し大きかった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/266503_10001045/1.1/'),
('ruffwear-flagline','ミックス',NULL,NULL,'senior mobility','17歳・12.5kgのミックスで、ふらついた時に力が一か所にかからないよう支えられるものを探して選び、軽くしっかりした作りだった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/266503_10001045/1.1/'),
('ruffwear-flagline','シベリアンハスキー2頭',NULL,NULL,'multi escape handle','ハスキー2頭の散歩で、後ずさりしても抜けないので安心。すっぽ抜けの怖さからハーネス選びに神経質になっていたが不安がなくなった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/266503_10001045/1.1/'),
('ruffwear-flagline','ミックス',NULL,'short','senior sizing','15歳・20kg前後の短毛のミックスで、筋肉が落ちて胸の張りや胴囲が細くなってきたため、これからを考えてSにした体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/266503_10001045/1.1/'),
('ruffwear-flagline','ラブラドール',NULL,NULL,'mobility sizing','段差を降りる時の補助をしたい10歳・32kgのラブラドールで、胸囲からサイズに迷い、問い合わせてL/XLを勧められた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/266503_10001045/1.1/'),
('ruffwear-flagline','雑種',NULL,NULL,'escape','散歩中に胴輪も首輪も何度か抜けて大変だった23kgの中型の雑種にM。今度こそ抜けないでほしいと選んだ体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/266503_10001045/1.1/'),
('ruffwear-flagline','雑種',NULL,NULL,'escape','このタイプのハーネスは後ずさりしても抜けたことがなく、ベルトも緩んでこないので安心して散歩しているという雑種の体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/266503_10001045/1.1/'),
('ruffwear-flagline','ミックス',NULL,NULL,'pull escape','引っ張りが強い6.3kgの小型のミックスにXS。下側のベルトが股ぎりぎりで尿がかかることもあるが、抜ける心配がなくなった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/266503_10001045/1.1/'),
('ruffwear-flagline','ゴールデンレトリバー',NULL,NULL,'handle escape','36kgのゴールデンにL/XL。胸側・背中・腰にリードを付けられ持ち手もあり、抜けることもないので他のハーネスが使えなくなった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/266503_10001045/1.1/'),
('ruffwear-hi-light','柴犬',NULL,NULL,'sizing','換毛期で胸囲55cmある4歳・13kgの柴犬に、冬毛の時期を考えてSを選択。届いた時は最小の設定で首も胸もきつく、少し伸ばした体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/266503_10001048/1.1/'),
('ruffwear-hi-light','柴犬',NULL,NULL,'puppy','初めてのハーネスとして10か月・10kg弱の柴犬にS。とても軽く、着けていることに気付いていないようだった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/266503_10001048/1.1/'),
('ruffwear-hi-light','ミニチュアダックスフンド',NULL,NULL,'escape','体格の良いミニチュアダックスで、バックルが2か所あるのは少し面倒だが、抜けず軽い体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/266503_10001048/1.1/'),
('ruffwear-hi-light','豆柴',NULL,NULL,'sizing','保護犬出身でしっかりしたハーネスを使っていた6.4kgの豆柴に、夏に向けて軽いものとして選んだ体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/266503_10001048/1.1/'),
('ruffwear-hi-light','トイプードルミックス',NULL,NULL,'sizing dislike-on','服が苦手な9.6kgのトイプードル系ミックスにXS。サイズ表どおりでジャストフィットした体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/266503_10001048/1.1/'),
('ruffwear-hi-light','パグ',NULL,NULL,'escape','首が太く頭と同じくらいのため、後ずさりで抜けやすかった1歳・8kgのパグで、ベルトで微調整できて良さそうだと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/266503_10001048/1.1/'),
('ruffwear-hi-light','ミニチュアピンシャー',NULL,NULL,'sizing','細いのに胸囲はしっかりある3.9kgのミニピンにXXSがぴったりで、フロントレンジハーネスから替えた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/266503_10001048/1.1/'),
('ruffwear-hi-light','ミックス',NULL,NULL,'escape multi','4kgのミックス犬に少しゆとりはあるが、引っ張っても抜けない。先住犬も同じものを使い、鑑札を入れるポケットも安心な体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/266503_10001048/1.1/'),
('ruffwear-hi-light','ミックス',NULL,NULL,'sizing','首回りが細い3.9kgのミックス犬で、XXSでは首が大きくXXXSに交換。軽くハーネスが動く感じはあるが外れることはなさそうな体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/266503_10001048/1.1/'),
('ruffwear-hi-light','トイプードル',NULL,NULL,'sizing','3.5kgのトイプードルにXXS。首回りは最大限締めても少し緩いが、胴回りできちんと調整できる体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/266503_10001048/1.1/'),
('ruffwear-hi-light',NULL,NULL,NULL,'senior','若い頃はフロントレンジを気に入っていたが、老犬になり軽いこちらに替え、痩せて4.3kgになったのでXSからXXSにした体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/266503_10001048/1.1/'),
('ruffwear-hi-light','シュナウザー',NULL,NULL,'pull sizing','引っ張りが強いシュナウザーで、腹囲はぴったりだが首は調整しても緩く、まだ使えていない。小さいサイズだと腹囲がきつくなると考え交換もあきらめた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/266503_10001048/1.1/'),
('perros-harness','ヨークシャーテリア',NULL,NULL,'sizing','2.25kgのヨーキーにXS。留め具の小ささは心配したほどではなかったが、首回りは構造上、ベルトの最短までは締められないという体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/410733_10000216/1.1/'),
('perros-harness','チワワ',NULL,NULL,'escape','ほかのハーネスで抜けてしまい冷や汗をかいたことがある2.5kgのチワワで、高価だが抜ける危険より良いと選び、ぴったりだった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/410733_10000216/1.1/'),
('perros-harness',NULL,'small',NULL,'escape trachea','体が小さくても抜けることがなく、咳き込みもなかった。留め具が関節に当たらないか心配だったが、内側は滑らかな素材だった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/410733_10000216/1.1/'),
('perros-harness',NULL,NULL,NULL,'escape dislike-on','似た形のハーネスから替え、首を通さずバックルで着けられるのでハーネスが苦手な犬も使いやすい。ごついハーネスより抜けにくいと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/410733_10000216/1.1/'),
('perros-harness','トイプードル',NULL,NULL,'puppy trachea','先住犬のハーネスの最小サイズでも大きかった1.6kgのトイプードルの子犬で、子犬の動きでも外れず、気管に優しいと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/410733_10000216/1.1/'),
('perros-harness','パグ',NULL,NULL,'skin','前のハーネスで脇擦れが起きた10kg強のパグにM。脇に当たらないので擦れなくなった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/410733_10000216/1.1/'),
('perros-harness','チワワ',NULL,NULL,'clothes','3kgのチワワにXS。調整の幅があり、そのままでも厚い服の上からでも使えそうな体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/410733_10000216/1.1/'),
('perros-harness','柴犬',NULL,NULL,'pull trachea','引っ張り癖のある柴犬で、ほかのハーネスより気管への負担が少ないことが呼吸の様子で分かり、引っ張りも軽減された印象の体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/410733_10000216/1.1/')
)
INSERT INTO reviews(product_id,dog_breed,dog_size,coat_type,needs,summary,source_type,source_url)
SELECT n.product_id,n.dog_breed,n.dog_size,n.coat_type,n.needs,n.summary,n.source_type,n.source_url
FROM new_reviews n
WHERE NOT EXISTS (
  SELECT 1 FROM reviews r
  WHERE r.product_id=n.product_id
    AND r.summary=n.summary
);

WITH new_reviews(product_id,dog_breed,dog_size,coat_type,needs,summary,source_type,source_url) AS (
VALUES
('perros-harness',NULL,NULL,NULL,'stiff','頭を通さず着けられる点で選んだが、柔らかいテープとの説明ほど柔らかくなく、ごつくて頑丈な作りだと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/410733_10000216/1.1/'),
('perros-harness',NULL,NULL,NULL,'multi sizing','5.3kgと6.3kgの2頭にXS。商品写真の大きいサイズに比べ、届いたものが思ったより細かったことに驚いた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/410733_10000216/1.1/'),
('perros-harness','ジャックラッセルテリア',NULL,NULL,'pull trachea','7kgのジャックラッセルで、強く引っ張ってもむせなくなった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/410733_10000194/1.1/'),
('perros-harness','ジャックラッセルテリア',NULL,NULL,'escape','時々踏ん張って後ずさりし、ハーネスが抜けそうになるのが怖かった9歳のジャックラッセルで、高額だがサイズ交換できることもあり思い切って選んだ体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/410733_10000194/1.1/'),
('perros-harness',NULL,NULL,NULL,'dislike-on','頭を通すのは平気だが抜く時にパニックになる犬で、首にバックルがあるタイプは少ないため助かっている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/410733_10000194/1.1/'),
('perros-harness',NULL,NULL,'long','mobility skin','肩関節のリハビリ中の長毛の犬で、前足と胸に負担がかからず自由に動け、背中の長さがあり脇が擦れないと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/410733_10000194/1.1/'),
('perros-harness','コッカースパニエル',NULL,'long','easy-on','耳が長く、頭を入れるタイプでは毎回耳の出し入れが負担だったコッカーで、細くなっても問題なく使えた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/410733_10000194/1.1/'),
('perros-harness','柴犬',NULL,NULL,'easy-on','11kgの柴犬にS。前足を通して背中で留めるタイプからこちらに替え、犬のストレスが少なそうな体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/410733_10000194/1.1/'),
('perros-harness',NULL,NULL,NULL,'trachea','生まれつき気管が少し狭く首輪ではなくハーネスを使っている犬で、サイズも良く楽そうな体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/410733_10000194/1.1/'),
('perros-harness','ミニチュアダックスフンド',NULL,NULL,'easy-on','がっしりした6.5kgのミニチュアダックスにS。調整できる部分が多いのに軽く柔らかく、首と胴どちらのバックルも外せて脱がせやすいが、クッションは付いていない体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/410733_10000194/1.1/'),
('perros-harness',NULL,NULL,NULL,NULL,'気管に良さそうと思って選んだが、値段の割に良さはあまり分からなかったという体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/410733_10000194/1.1/'),
('petparadise-disney-vest',NULL,NULL,NULL,'durability','3年ほど愛用して傷んできたため同じものを探して買い直した。犬も着け心地が良いのか嫌がらずに着けさせてくれる体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/206746_10076924/1.1/'),
('petparadise-disney-vest','トイプードル',NULL,NULL,'sizing clothes','4kgのトイプードルで、3Sは服を着せるときつかったためSSに替え、ぴったりだった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/206746_10076924/1.1/'),
('petparadise-disney-vest','チワワ',NULL,NULL,'puppy sizing','散歩デビュー前の3か月のチワワに4Sを選んだら大きく、3kg強の上の子に着せると入ったが歩くときつそうだった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/206746_10076924/1.1/'),
('petparadise-disney-vest','ミニチュアダックスフンド',NULL,NULL,'sizing','5kgのミニチュアダックスで、胴回りがひもタイプのものが多い中、同じ形状を探して洗い替え用に選んだ体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/206746_10076924/1.1/'),
('petparadise-disney-vest','柴犬',NULL,NULL,'sizing','サイズ表ではぎりぎりと思った8kgの柴犬でも着られ、まだ余裕がある。内側のメッシュも通気が良さそうな体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/206746_10076924/1.1/'),
('petparadise-disney-vest','シーズー',NULL,NULL,'sizing','5.2kgのシーズーで少し大きいが、背中のマジックテープで調整でき、胸のカーブでフィットする体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/206746_10076924/1.1/'),
('petparadise-disney-vest','ポメラニアン',NULL,NULL,'sizing','5.3kgのポメラニアンでSSが少しきつくなりSにしたら大きすぎ、サイズ選びの難しさを感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/206746_10076924/1.1/'),
('petparadise-disney-vest','トイプードル',NULL,NULL,'sizing','胴回り35cm・3.5kgのトイプードルで、サイズ表とモデル犬を見てSSにしたが、面ファスナーを一番締めても余るほど大きく、リード留めの部分も緩かった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/206746_10076924/1.1/'),
('petparadise-strawberry-harness','カニンヘンダックスフンド',NULL,NULL,'puppy escape','4か月・2.2kgのカニンヘンダックスに3S。前足を入れる部分が少し大きく、抜けたら怖いと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/206746_10080812/1.1/'),
('petparadise-strawberry-harness','トイプードル',NULL,NULL,'puppy sizing','生後3か月・1.1kgのタイニープードルで4Sでも大きいが、室内の散歩練習には使えそうな体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/206746_10080812/1.1/'),
('petparadise-strawberry-harness','トイプードル',NULL,NULL,'sizing','3kgのトイプードルにSSがちょうど良く、軽いのにしっかりしていて反射板もある体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/206746_10080812/1.1/'),
('petparadise-strawberry-harness',NULL,NULL,NULL,'escape durability','サイズ調整の金具が弱いのか散歩中に少しずつ緩み、10日ほどの間に2回頭から抜けて脱走しかけたため、怖くて使えなくなった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/206746_10080812/1.1/'),
('petparadise-strawberry-harness','シュナウザー',NULL,NULL,'sizing','シュナウザーでSは大きく、一つ下はぴちぴちで、サイズ展開がもう少し欲しいと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/206746_10080812/1.1/'),
('ezydog-quick-harness',NULL,NULL,NULL,'escape','マジックテープで微調整でき体型にぴったり合うが、胴輪部分が緩いと引っ張り方によっては頭からすぐ抜けるので注意が必要だと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/211165_10186796/1.1/'),
('ezydog-quick-harness',NULL,NULL,NULL,'chew easy-on','前のハーネスを噛みちぎられて替えた。足を通すタイプは嫌がる時があったが、首をくぐらせてワンタッチで留めるので素早く着けられる体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/211165_10186796/1.1/'),
('ezydog-quick-harness','ラブラドール',NULL,NULL,'senior easy-on','最初にサイズを合わせれば毎回の装着がとても簡単で、両足を通さなくて済むので老犬のラブラドールに助かっている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/211165_10186796/1.1/'),
('ezydog-quick-harness','秋田犬',NULL,NULL,'sizing','25kgの秋田犬に合ったが、首のマジックテープの伸ばし方が分かりにくく30分ほどかかった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/211165_10186796/1.1/'),
('ezydog-quick-harness','ゴールデンレトリバー',NULL,NULL,'easy-on','2歳のゴールデンで、サイズ合わせに少し手こずったが、その後は1か所を留めるだけでワンタッチで着けられる体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/211165_10186796/1.1/'),
('ezydog-quick-harness',NULL,NULL,NULL,'easy-on','足を穴に通さなくてよいので落ち着きのない子でも簡単に着けられ、汚れても洗ってすぐ乾くという体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/211165_10186796/1.1/'),
('ezydog-quick-harness',NULL,NULL,NULL,'puppy skin','首輪を気にする子犬のためハーネスに替えたが、正しい付け方がよく分からず、調整しても足の付け根に当たって皮膚が擦れたという体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/211165_10186796/1.1/'),
('petio-zuttone-walking-hind',NULL,NULL,NULL,'senior mobility','体重31kg台の犬で、コルクマットや屋外では歩けるがフローリングでは難しい状態。立てなくなってから嫌がられると困るので、今のうちから練習している体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/261122_10223746/1.1/'),
('petio-zuttone-walking-hind','ラブラドール',NULL,NULL,'senior mobility','14歳のラブラドールの介護用に、まだ必須ではないが、あると安心なので用意した体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/261122_10223746/1.1/'),
('petio-zuttone-walking-hind',NULL,NULL,NULL,'mobility','9歳で椎間板ヘルニアの手術後も後ろ足が立たないオスの犬で、きつく着けると排尿しにくく、緩めるといつの間にか外れるが、歩行補助として大助かりしている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/261122_10223746/1.1/'),
('petio-zuttone-walking-hind',NULL,'large',NULL,'mobility','後ろ足から悪くなった大型犬の介護で、前足もリードで持ち上げながらリハビリのように歩かせている。もっと早く買えばよかったと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/261122_10223746/1.1/'),
('petio-zuttone-walking-hind',NULL,'large',NULL,'mobility','大型犬用の3Lサイズがなかなか見つからずこれを選び、嫌がらずに着けてくれた。メッシュで手洗いできる点も良い体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/261122_10223746/1.1/'),
('petio-zuttone-walking-hind',NULL,NULL,NULL,'mobility skin','後ろ足が全く動かない犬を持ち上げて歩かせると、お尻周りが狭くなって排便が引っかかり、足の付け根も赤くなるため1日1回にしている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/261122_10223746/1.1/'),
('petio-zuttone-walking-hind','ラブラドール',NULL,NULL,'senior mobility','後ろ足の股関節を痛めた13歳の小柄なラブラドールで、着けやすいが少し大きく、持ち方が悪いと排尿で汚れる。洗ってすぐ乾く体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/261122_10223746/1.1/'),
('petio-zuttone-walking-hind',NULL,NULL,NULL,'mobility','体重がある程度あり腰が全く上がらない状態ではあまり効果的に使えず、前足用と合わせた方が安定しそうだと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/261122_10223746/1.1/'),
('petio-zuttone-walking-hind','紀州犬ミックス',NULL,NULL,'mobility sizing','脊椎症で時々後ろ足が上がらなくなる紀州犬ミックスで、足回りに合わせると腰回りが緩くなるため工夫して使う予定の体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/261122_10223746/1.1/'),
('anisapo-harest','ポメラニアン×チワワ',NULL,NULL,'pull trachea','引っ張り癖が直らずゲホゲホしていたポメチワで、別の人気のハーネスから替えてみた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/352568_10017498/1.1/'),
('anisapo-harest','チワワ',NULL,NULL,'senior trachea clothes','気管虚脱が進みつつある16歳のチワワで、散歩中とても楽そうに歩き、手に伝わる感触も柔らかい。構造上少しごわつき冬服を着せにくい体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/352568_10017498/1.1/'),
('anisapo-harest','マルプー',NULL,NULL,'pull trachea','引っ張るとゼイゼイし、水を飲む時もむせることがある5.3kgのマルプーで、ぐいぐい引いても楽そうな体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/352568_10017498/1.1/'),
('anisapo-harest','トイプードル',NULL,NULL,'pull trachea','散歩が好きではなく早く帰ろうと引っ張ってゼェゼェしていたトイプードルで、帰宅後に咳や音が出たため受診し、喉に負担の少ないものとして選んだ体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/352568_10017498/1.1/'),
('anisapo-harest','シーズー',NULL,NULL,'puppy trachea','短頭種気道症候群の手術後で気道が細めの10か月・5.5kgのシーズーにM。引いて走っても苦しくなさそうで元気に遊んでいる体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/352568_10017498/1.1/'),
('anisapo-harest','ミニチュアシュナウザー×シーズー',NULL,NULL,'pull trachea','引っ張りや吠えた時の引き戻しで首輪だと咳き込んでいた7.5kgのミックスで、首が締まらないので引き戻す時も気にしなくてよくなった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/352568_10017498/1.1/'),
('anisapo-harest','シェルティ',NULL,NULL,'senior trachea','老犬でたまに咳が出る14歳のシェルティに負担の少ないものとして選び、元気に散歩している体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/352568_10017498/1.1/'),
('anisapo-harest','豆柴',NULL,NULL,'sizing','6.7kgの豆柴にM。ベルトでサイズは合わせたが、歩くと胸当て部分がぱかぱかし、別売りのカバーを付けると中でよれるという体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/352568_10017498/1.1/'),
('anisapo-harest','フレンチブルドッグ',NULL,NULL,'sizing trachea','首回り35cm・胴回り46cmと体型が変則的なフレブルで、問い合わせてMにしたらぴったりで、これまでより着け心地が良さそうな体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/352568_10017498/1.1/'),
('anisapo-harest','トイプードル',NULL,NULL,'senior trachea','咳が増えてきたシニア期の6kgのトイプードルで、興奮して引く時のために首に触れないものへ替えた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/352568_10017498/1.1/')
)
INSERT INTO reviews(product_id,dog_breed,dog_size,coat_type,needs,summary,source_type,source_url)
SELECT n.product_id,n.dog_breed,n.dog_size,n.coat_type,n.needs,n.summary,n.source_type,n.source_url
FROM new_reviews n
WHERE NOT EXISTS (
  SELECT 1 FROM reviews r
  WHERE r.product_id=n.product_id
    AND r.summary=n.summary
);

WITH new_reviews(product_id,dog_breed,dog_size,coat_type,needs,summary,source_type,source_url) AS (
VALUES
('truelove-soft-harness',NULL,NULL,NULL,'durability','しつけ用に使っているが、留め具はあまり丈夫ではなさそうでリード接続部もプラスチックなので、2本のリードで使うのが良いと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/374082_10000221/1.1/'),
('truelove-soft-harness','ゴールデンレトリバー',NULL,NULL,'handle','28kgのゴールデンで、ロングリードやプールで使い、背中の持ち手が飛びつきの制止やプールからの引き上げに役立つ体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/374082_10000221/1.1/'),
('truelove-soft-harness','柴犬',NULL,NULL,'chew escape','いたずら好きでアジャスターを噛んで壊した2歳の柴犬で3本目。引いても簡単には抜けず、作りもしっかりしている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/374082_10000221/1.1/'),
('truelove-soft-harness',NULL,'medium',NULL,'pull','力強く引っ張る中型犬で、ベルトがしっかりしているので安心してリピートしている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/374082_10000221/1.1/'),
('truelove-soft-harness','豆柴',NULL,NULL,'sizing','太めの豆柴にM。これまでで一番フィットし、犬も動きやすそうでリピートしている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/374082_10000221/1.1/'),
('truelove-soft-harness',NULL,NULL,NULL,'puppy pull','引っ張りがちな子犬期の中・大型犬で、胸側のフックにリードを付けるととてもコントロールしやすいと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/374082_10000221/1.1/'),
('sevenbridge-dress-harness','キャバリア',NULL,NULL,'sizing','細めの5kgのキャバリアにL。着丈はちょうど良いが肩回りがぶかぶかで、少し縫い縮めてぴったりにした体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/383415_10000218/1.1/'),
('sevenbridge-dress-harness','チワワ',NULL,NULL,'escape','3.4kgのチワワにMがぴったり。マジックテープとバックルの二重で留まるので安心な体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/383415_10000218/1.1/'),
('sevenbridge-dress-harness','マルチーズ',NULL,NULL,'puppy sizing','4か月・2.3kgのマルチーズにMは少し大きいが、もう少し成長すればちょうど良くなりそうな体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/383415_10000218/1.1/'),
('sevenbridge-dress-harness','マルチーズ',NULL,NULL,'puppy sizing','6か月・1.7kgのマルチーズにS。作りや縫製はしっかりしているが、まだぶかぶかだった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/383415_10000218/1.1/'),
('pomporis-3way-care-harness',NULL,NULL,NULL,'senior mobility sizing','まっすぐ立ち続けるのが難しい老犬で、足の間の採寸が2サイズにまたがり、大きいと後ろ足に生地が当たると考えて小さい方を選んだ体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/226723_10010551/1.1/'),
('pomporis-3way-care-harness',NULL,'large',NULL,'mobility','大型犬用の介助ハーネスをいくつか試して合わなかったが、前後の足から体全体を包む形でサイズ表記も細かく、ぴったり合い車の乗り降りにも使えそうな体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/226723_10010551/1.1/'),
('petsafe-easy-walk-deluxe','スタンダードプードル',NULL,NULL,'neck','生まれつき首の骨の病気がある25kgのスタンダードプードルで、首輪ではなくこれをメインに使い、もともと少ない引っ張りもひどくなっていない体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/202898_10088682/1.1/'),
('petsafe-easy-walk-deluxe','ゴールデンレトリバー',NULL,NULL,'pull','引っ張り癖で散歩が大変だった24kgのゴールデンにML。使った初日からほとんど引っ張らなくなり、高いので迷ったが買って良かったと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/202898_10088682/1.1/'),
('petsafe-easy-walk-deluxe','ラブラドール',NULL,NULL,'pull durability','同じものを長く使って古くなってきたため予備を買ったラブラドールで、使いやすく丈夫で引っ張り対策にも良いという体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/202898_10088682/1.1/'),
('petsafe-easy-walk-deluxe','ゴールデンレトリバー',NULL,NULL,'pull','ものすごい力で引くゴールデンで、しつけのスクールの勧めで試したら、同じ犬とは思えないほど落ち着いて歩いた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/202898_10088682/2.1/'),
('petsafe-easy-walk-deluxe','ゴールデンレトリバー',NULL,NULL,'puppy pull','引っ張り癖がひどかった5か月のゴールデンにM。装着後は引っ張りがほとんどなくなった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/202898_10088682/2.1/'),
('petsafe-easy-walk-deluxe','ラブラドール',NULL,NULL,'pull','いつも下を向いてにおい嗅ぎに夢中で引っ張るラブラドールが、横について顔を上げて歩くようになった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/202898_10088682/2.1/'),
('petsafe-easy-walk-deluxe','ミックス',NULL,NULL,'sizing','胴回り63cm・22kgの小さめのミックスにMLを一番短くしてぴったり。従来品より作りがしっかりしていて安心な体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/202898_10088682/2.1/'),
('petsafe-easy-walk-deluxe','スタンダードプードル・ボーダーコリー',NULL,NULL,'pull multi','24kgのスタンダードプードルとボーダーコリーに使い、引っ張りが8割ほど減ったが、どうしても緩むので毎回調整が必要な体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/202898_10088682/2.1/'),
('petsafe-easy-walk-deluxe','ゴールデンレトリバー',NULL,NULL,'puppy pull','5か月・19kgのゴールデンにMLを一番小さくしてぴったり。初日で慣れて全然引っ張らなくなったが、耐久性は少し心配な体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/202898_10088682/2.1/'),
('petsafe-easy-walk-deluxe','ゴールデンレトリバー',NULL,NULL,'puppy pull trachea','首輪ではゼーゼー言いながら引っ張っていた9か月のゴールデンで、1週間使ってお互いストレスなく散歩できている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/202898_10088682/2.1/'),
('petsafe-easy-walk-deluxe','ゴールデンレトリバー',NULL,NULL,'puppy pull skin','10か月のゴールデンで、一人でも散歩に行けるほど楽になったが、脇の下に毛玉ができるのが難点という体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/202898_10088682/3.1/'),
('petsafe-easy-walk-deluxe','ゴールデンレトリバー',NULL,NULL,'puppy pull chew','6か月・20kgのゴールデンで2本目。ほぼ引っ張らなくなるので手放せないが、1本目は噛みちぎられた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/202898_10088682/3.1/'),
('petsafe-easy-walk-deluxe','ゴールデンレトリバー',NULL,NULL,'pull durability','生後半年頃の強い引きがこれでずいぶん楽になり、2歳の今も使っている32kgのゴールデンで、色あせたので買い替えた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/202898_10088682/3.1/'),
('petsafe-easy-walk-deluxe','ゴールデンレトリバー',NULL,NULL,'puppy pull escape','8か月のゴールデンで前への引っ張りにはとても効くが、飛び上がったり後ろへ強く引いたりすると抜けることがあり、首輪も併用している体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/202898_10088682/3.1/'),
('buddy-belt','トイプードル',NULL,NULL,'clothes','3kg弱のトイプードルに3号。普段は一番小さい穴、冬はダウンを着て散歩するので大きめにしている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/230805_10000712/1.1/'),
('buddy-belt','チワワ',NULL,'short','trachea clothes','腹囲34cm・3kgのスムースチワワに3号。薄手の服なら真ん中の穴でちょうど良く、高価だが気管に優しいので2本目を買った体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/230805_10000712/1.1/'),
('buddy-belt','トイプードル',NULL,NULL,'sizing','首囲20cm・胴囲33cm・2.7kgのトイプードルに3号で、ベルトの穴がちょうど真ん中。犬も嫌がらない体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/230805_10000712/1.1/'),
('buddy-belt',NULL,'small',NULL,'multi clothes','2.3kgと3kgの体格が違う小型犬2頭とも3号がちょうど良く、服を着ても脱いでも使える。革にオイルを塗ってさらに柔らかくしている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/230805_10000712/1.1/'),
('buddy-belt','チワワ',NULL,NULL,'puppy trachea','首回りにハーネスが当たらず気管に優しいと感じ、チワワの子犬にも購入した。高価だが革がしっとりしている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/230805_10000712/1.1/'),
('buddy-belt',NULL,NULL,NULL,'durability','胸囲32cm・1.8kgの犬に3号で3本目。最初に買ったものは5年ほど使えている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/230805_10000712/2.1/'),
('buddy-belt','チワワ',NULL,NULL,'clothes','胴回り30cmのチワワに3号を一番きつい穴で使い、薄手の服なら同じ穴で大丈夫な体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/230805_10000712/2.1/'),
('buddy-belt','マルチーズ',NULL,NULL,'trachea','トリミングサロンで勧められて使い続けている8歳のマルチーズで、引っ張っても喉を圧迫しない体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/230805_10000712/2.1/'),
('buddy-belt','チワワ',NULL,NULL,'puppy clothes','首輪の跡が毛並みに残ってしまった8か月のチワワに替え、厚めの服の上からも着けられる体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/230805_10000712/2.1/'),
('buddy-belt','トイプードル',NULL,NULL,'trachea sizing','気管虚脱と診断された2.4kg・胴回り34cmのタイニープードルに3号。レビューを参考に選びサイズもちょうど良かった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/230805_10000712/2.1/'),
('buddy-belt','チワワ',NULL,NULL,'durability','3個目のチワワで、サイズが小さくなったり革が少し伸びたりしたので買い替えた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/230805_10000712/3.1/'),
('buddy-belt','チワワ',NULL,NULL,'puppy clothes sizing','6か月・1.8kgのチワワで、服なしは2号、冬服用に3号を買ったら大きく感じたが、もこもこの服やダウンの上からならちょうど良い体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/230805_10000712/3.1/'),
('buddy-belt','チワワ',NULL,NULL,'sizing dislike-on','前のものが小さくなって着けるのを嫌がっていた2.3kgのチワワで、3号に買い替えたらすんなり着けさせてくれた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/230805_10000712/3.1/'),
('buddy-belt','ヨークシャーテリア',NULL,NULL,'sizing skin','胴が太い2.8kgのヨーキーで3号は小さく4号に交換。最初は革が硬く脇の擦れが気になったため揉んで柔らかくした体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/230805_10000712/3.1/'),
('terubell-wonderfit','豆柴',NULL,NULL,'escape','頭と胴が細く、暴れた時にすっぽ抜けたことがある2歳・6.3kgの豆柴でリピート。使い始めてから全く心配がなくなった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/255000_10000657/1.1/'),
('terubell-wonderfit',NULL,NULL,NULL,'puppy scared escape','いろいろ怖がって後ずさりする5か月・9kgの元野犬の子犬に、調整を短めにしてちょうど良く、当分使えそうな体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/255000_10000657/1.1/'),
('terubell-wonderfit',NULL,'medium',NULL,'escape durability','脱走防止が重要な元野犬の14kgの中型犬にXL。前年に買ったものも今も使えている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/255000_10000657/1.1/'),
('terubell-wonderfit',NULL,NULL,NULL,'escape skin','首輪のすっぽ抜けを経験し、頑丈だが硬いハーネスでは当たる部分の毛が薄くなったため、柔らかいがしっかりした素材のこれを選んだ体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/255000_10000657/1.1/'),
('terubell-wonderfit','チワワ',NULL,NULL,'scared escape','怖いと逃げようとして別のハーネスから抜けたことがある、保護犬で怖がりな5歳・4kgのチワワにM。不器用でも簡単に着けられ、抜けずに助かっている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/255000_10000657/1.1/'),
('terubell-wonderfit','柴犬',NULL,NULL,'scared escape','1歳・12.2kgの柴犬で3回目の購入。怖がりで後ずさりしたり暴れたりしても抜けたことがなく、締め付けもきつくない体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/255000_10000657/1.1/'),
('terubell-wonderfit','トイプードル',NULL,NULL,'scared escape','怖がりで後ずさりし、ハーネスが抜けていた1歳・5kgのトイプードルにS。しっかり保持されて今のところ抜けていない体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/255000_10000657/2.1/'),
('terubell-wonderfit','柴犬',NULL,NULL,'senior trachea dislike-on','気管虚脱と診断された15歳・15kgの柴犬で、前足を通すのも首を通すのも嫌がったが、首の部分を大きく広げられるので着脱が楽になった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/255000_10000657/3.1/'),
('terubell-wonderfit','豆柴',NULL,NULL,'puppy dislike-on','首輪類を見せると逃げ回る7か月・4.3kgの豆柴で、追いかけっこはなくならないが、足を通すタイプより頭を通すだけで楽になった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/255000_10000657/3.1/'),
('terubell-wonderfit','パピヨン',NULL,NULL,'stiff','胸元全体を覆うタイプが苦手な2歳・4.5kgのパピヨンで、最初は戸惑ったがすぐ慣れた。布製に比べ少し硬さが気になる体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/255000_10000657/3.1/')
)
INSERT INTO reviews(product_id,dog_breed,dog_size,coat_type,needs,summary,source_type,source_url)
SELECT n.product_id,n.dog_breed,n.dog_size,n.coat_type,n.needs,n.summary,n.source_type,n.source_url
FROM new_reviews n
WHERE NOT EXISTS (
  SELECT 1 FROM reviews r
  WHERE r.product_id=n.product_id
    AND r.summary=n.summary
);

WITH new_reviews(product_id,dog_breed,dog_size,coat_type,needs,summary,source_type,source_url) AS (
VALUES
('terubell-wonderfit',NULL,NULL,NULL,'escape','細身でハーネスが抜けることがあった犬で、替えてからはそのはらはらがなくなり、装着もしやすい体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/255000_10000657/3.1/'),
('terubell-wonderfit','ビーグル',NULL,NULL,'escape','頑丈さ重視で150g以上のH型を使っていた9.8kgのビーグルで、59gと軽いのに抜けず、柔らかく着けやすい体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/255000_10000657/3.1/'),
('terubell-wonderfit',NULL,'medium',NULL,'dislike-on','新しいハーネスを着けるとハウスから出てこなくなるほどハーネス嫌いな16kgの中型犬が、これは比較的早く慣れて歩いてくれた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/255000_10000657/3.1/'),
('radica-cordura-harness','ポメラニアン',NULL,NULL,'sizing','毛量の多い5kgのポメラニアンで、少し大きすぎた気もするが毛が多いのでちょうど良いかもしれないと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/255378_10021956/1.1/'),
('radica-cordura-harness','チワワ',NULL,'short','dislike-on','鳩胸で合うハーネスがなく、マジックテープも苦手で着けると動かなくなっていたスムースチワワで、着けやすく柔らかいこれは使えた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/255378_10021956/1.1/'),
('radica-cordura-harness','トイプードル',NULL,NULL,NULL,'首回り29cm・胴回り44cm・6kgのトイプードルにぴったり。撥水加工で清潔に保てるが、前のものより生地のクッション性は少ない体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/255378_10021956/1.1/'),
('radica-cordura-harness','チワワ',NULL,NULL,'puppy durability','金具が少なく体に当たりにくく、胸周りの太さにも調整が効くので、子犬で迎えた時から成犬になるまで使えたチワワの体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/255378_10021956/2.1/'),
('radica-cordura-harness','チワワ',NULL,NULL,'clothes','2.5kgのチワワにS。生地は硬めだが丈夫そうで、リードのバックルでショルダーバッグにも付けられる。厚手の服ならMでも良かった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/255378_10021956/2.1/'),
('radica-cordura-harness','キャバリア',NULL,NULL,'durability','がっちりした9.3kgのキャバリアにLLがちょうど良く、いくつ買ったか分からないほどずっと使い続けている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/255378_10021956/2.1/'),
('radica-cordura-harness','ミニチュアダックスフンド',NULL,NULL,'clothes easy-on','5kg弱で鳩胸のダックスを包み込み、服に関係なくサイズ調整せずにクリップを留めるだけで使える体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/255378_10021956/3.1/'),
('radica-cordura-harness','チワワ',NULL,NULL,'clothes','2.4kgのチワワにSがぴったりで、裸でも厚めの服でも調整して使える体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/255378_10021956/3.1/'),
('suzukoubou-standard','サモエド・ミックス',NULL,NULL,'multi puppy','28kgのサモエドにLL、6kgのミックスの子犬にMをおそろいで使い、子犬も動きやすそうに走っている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/278852_10001829/1.1/'),
('suzukoubou-standard','豆柴',NULL,NULL,'sizing clothes','太めで首はM、体はLという豆柴で、寒くなり服を着るようになったのでLにして良かった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/278852_10001829/1.1/'),
('suzukoubou-standard','フラットコーテッドレトリバー',NULL,NULL,'puppy sizing','胴回り71cmの10か月のフラットコーテッドにLL。まだ大きくなりそうだが調整で成犬まで使えそうで、大型犬でもしっかりフィットする体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/278852_10001829/2.1/'),
('suzukoubou-standard','ミニチュアダックスフンド',NULL,NULL,'pull escape durability','引っ張りが強くても抜けない、胴回り54cmのダックスにL。6〜7年前に買ったものもまだ使えるが、汚れが気になって新調した体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/278852_10001829/2.1/'),
('suzukoubou-standard','ビーグル',NULL,NULL,'escape','7.8kgのビーグルで、頑丈な作りで後ずさりで抜けたり切れたりする心配がない体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/278852_10001829/2.1/'),
('suzukoubou-standard','フレンチブルドッグ',NULL,NULL,'sizing','胴の短いフレブルで、胴回り64cmほどになりこれまでのサイズがきつくなったため、ショップに相談してサイズを選び直した体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/278852_10001829/2.1/'),
('suzukoubou-standard','柴犬2頭',NULL,NULL,'multi pull escape','引っ張り癖のある11kgと8kgの柴犬に使い、しっかりした作りで抜けないが、頭と脚を毎回通すのが面倒という体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/278852_10001829/3.1/'),
('suzukoubou-standard','チワワ',NULL,NULL,'puppy escape','10か月・2kg未満のチワワで、後ずさりしても抜けにくく、着け心地も良さそうで楽しく散歩できている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/278852_10001829/3.1/'),
('suzukoubou-standard','トイプードル',NULL,NULL,'puppy escape','これまで3つのハーネスがどれもするっと抜けて怖い思いをした9か月・3kgのトイプードルにSS。体にぴたっと合い全く抜けない体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/278852_10001829/3.1/'),
('happy-heel-harness','柴犬',NULL,NULL,'pull','柴犬で使い、引っ張らなくなるというより引っ張れなくなる仕組みで、早く行きたい時は歩きにくそうだが、飼い主の負担は減った体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/309454_10000259/1.1/'),
('happy-heel-harness','レトリバー',NULL,NULL,'pull','前足を通すタイプでは子どもが散歩させられないほど引いた1歳のレトリバーで、強く引くと立ち止まりこちらを向く姿勢になる体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/309454_10000259/1.1/'),
('happy-heel-harness','ゴールデンレトリバー',NULL,NULL,'pull','しつけはしていても外では興奮しやすく、すれ違う犬や猫で制御が大変だった3歳・30kgのゴールデンで、引っ張りが激減した体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/309454_10000259/1.1/'),
('happy-heel-harness','ビーグル',NULL,NULL,'pull trachea','前足が宙づりになるほど進もうとし、ハーハー言っていた13か月・10.5kgのビーグルにM。そうした歩き方がなくなり散歩がかなり楽になった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/309454_10000259/1.1/'),
('happy-heel-harness','ジャックラッセルテリア',NULL,NULL,'pull','引っ張り癖の強い1歳・8kgのジャックラッセルで、部屋を出る前に落ち着かせる練習と組み合わせて効果があった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/309454_10000259/1.1/'),
('happy-heel-harness','ラブラドール',NULL,NULL,'pull sizing','胴回り71cmの小柄なラブラドールにLを最小にして使用。まだ2回目だが前より引っ張らなくなったように感じ、慣れれば装着も簡単な体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/309454_10000259/1.1/'),
('happy-heel-harness',NULL,NULL,NULL,'pull','引っ張り癖がひどい保護犬で、半信半疑だったが、引かれた時の力のかかり方がまるで違うと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/309454_10000259/2.1/'),
('happy-heel-harness','ボーダーコリー',NULL,NULL,'puppy pull','成長とともに引っ張りが強くなり、1日2回2時間の散歩で手足腰が痛かった7か月のボーダーコリーで、1週間足らずで驚くほど引っ張らなくなった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/309454_10000259/2.1/'),
('happy-heel-harness','プーダックス',NULL,NULL,'escape','足が短く細いため似たハーネスでは足がすぐ抜けた4kgのプーダックスで、最初は調整が悪く暴れた時に足が抜けたが、合わせ直して使えている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/309454_10000259/2.1/'),
('happy-heel-harness','ラブラドール',NULL,NULL,'pull','29kgの黒ラブにL。いろいろな道具で失敗してきたが、意外に良く、力を入れなくても簡単に抑えられた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/309454_10000259/2.1/'),
('happy-heel-harness','柴系ミックス',NULL,NULL,'pull','引っ張りがかなり強い1歳の柴風ミックスで、散歩が劇的に楽になり、力比べをせずゆっくり歩けるようになった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/309454_10000259/2.1/'),
('happy-heel-harness','ビーグル',NULL,NULL,'pull sizing','引っ張りが強い1歳のビーグルで、胸筋が発達しているためMを選択。最初の装着は悪戦苦闘したが慣れれば大丈夫な体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/309454_10000259/2.1/'),
('happy-heel-harness','ラブラドール',NULL,NULL,'pull','脱臼しそうなほど引っ張っていた1歳の黒ラブで、付属のDVDどおりに着けたところ効果に驚いた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/309454_10000259/3.1/'),
('happy-heel-harness','雑種',NULL,NULL,'puppy pull trachea','ゼーゼーするほど引っ張っていた5か月の雑種で、トレーニング中だが前よりは引かなくなり、リードを引くとこちらを見るようになった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/309454_10000259/3.1/'),
('happy-heel-harness','ポメラニアン',NULL,NULL,'pull','外に出ると嬉しくて飼い主を引っ張り回す大きめのポメラニアンで、勝手な方向へ行くとテンションがかかってこちらを見るが、まだ「早く行こう」という様子の体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/309454_10000259/3.1/'),
('truelove-handle-harness','シベリアンハスキー',NULL,NULL,'escape sizing','前に使っていたXLが色あせ、大きくて脱げそうになっていた25kgのハスキーにL。ひもを最大まで伸ばしてぴったりだった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/378148_10000034/1.1/'),
('truelove-handle-harness','ラブラドール',NULL,NULL,'senior','11歳の老犬のラブラドールで、同じハーネスの方が体に負担がないと思い2本目を購入。胴のベルトがいつも裏返ってしまう点は気になる体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/378148_10000034/1.1/'),
('truelove-handle-harness','柴犬',NULL,NULL,'escape pull durability','後ずさりも引っ張りもある13kg弱の柴犬で3年使っても劣化はほとんどなく、バックルがプラスチックなので念のため早めに買い替えた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/378148_10000034/1.1/'),
('truelove-handle-harness',NULL,NULL,NULL,'escape','帰るのを嫌がって踏ん張ることが多い11kgの犬で、踏ん張っても抜けたことはない体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/378148_10000034/2.1/'),
('truelove-handle-harness','柴犬',NULL,NULL,'pull escape','首輪だと引っ張り回す細身の9kgの柴犬に、すっぽ抜けしない頑丈なものとしてSを選び、胴回りは最大に伸ばしてぴったりだった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/378148_10000034/2.1/'),
('truelove-handle-harness','ミックス',NULL,NULL,'senior mobility','まだ自分で歩けるが加齢で足を痛めた15歳・20kgのミックスで、段差を補助する時に面で支えられるのが良いと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/378148_10000034/2.1/'),
('truelove-handle-harness','ボーダーコリー',NULL,NULL,'sizing','骨太で背が高い23kgのボーダーコリーにL。届いたままではきつく感じたが、長さを調整したらぴったりだった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/378148_10000034/2.1/'),
('truelove-handle-harness',NULL,NULL,NULL,'dislike-on sizing','頭が大きく、先にサイズを合わせると頭が通らないため毎回調整が必要。初めて着けた時は大暴れしたが、2回目から上手に散歩できた10kgほどの犬の体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/378148_10000034/2.1/'),
('truelove-handle-harness','豆柴',NULL,NULL,'escape','顔が小さく胸板が厚い豆柴で、他のハーネスは踏ん張った時に頭から抜けたが、これと首輪を併用すると全く抜けない体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/378148_10000034/3.1/'),
('truelove-handle-harness','ボーダーコリー',NULL,NULL,'sizing skin','胴長で胴回り60cmのボーダーコリーにM。脇の下が少し窮屈そうで、前の丈がもう数センチ長ければと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/378148_10000034/3.1/'),
('truelove-handle-harness','ビーグル',NULL,NULL,'pull trachea','引っ張り癖があり首輪では首の負担が気になっていた胴回り56cm・10.5kgのビーグルで、相談してMにして正解だった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/378148_10000034/3.1/'),
('truelove-handle-harness','ミニチュアダックスフンド・シェルティ',NULL,NULL,'multi pull','5kgほどの成犬のダックスと5か月のシェルティにS。首輪では引っ張り癖があったが、ハーネスだと少し落ち着く体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/378148_10000034/3.1/'),
('truelove-handle-harness','柴×シェパード',NULL,NULL,'sizing','胸囲70cm・24kgの柴とシェパードのミックスで、調整したらぴったりになり、ハーフチョークと2本のリードで散歩している体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/378148_10000034/3.1/'),
('julius-k9-idc-power','黒柴',NULL,NULL,'easy-on sizing','引っ越し後の散歩を楽しくするため初めてハーネスにした10歳・10kgの黒柴で、最初は前後を間違えて着けたが、動画を見直して付け直したら合った体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208747_10000922/4.1/'),
('julius-k9-idc-power','黒柴',NULL,NULL,'clothes','軽いのにしっかりした作りで、サイズ調整の幅も広く服の上からでも着けられそう。黒柴が最初から嫌がらずに着けてくれた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208747_10000922/4.1/')
)
INSERT INTO reviews(product_id,dog_breed,dog_size,coat_type,needs,summary,source_type,source_url)
SELECT n.product_id,n.dog_breed,n.dog_size,n.coat_type,n.needs,n.summary,n.source_type,n.source_url
FROM new_reviews n
WHERE NOT EXISTS (
  SELECT 1 FROM reviews r
  WHERE r.product_id=n.product_id
    AND r.summary=n.summary
);

WITH new_reviews(product_id,dog_breed,dog_size,coat_type,needs,summary,source_type,source_url) AS (
VALUES
('julius-k9-idc-power',NULL,NULL,NULL,'scared escape easy-on','元野犬の保護犬でとても怖がりで、怖がると後ずさりしてハーネスを抜く。前のものは抜け方を覚えてしまい、首を通すだけで着けやすいこれに替えた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208747_10000922/4.1/'),
('julius-k9-idc-power','柴犬',NULL,NULL,'escape','他の犬と遊んでいる時に首輪が抜けたことがあり、ハーネスはあまり好きではなかったが9.7kgの柴犬にMini。最初にサイズを合わせれば頭からくぐらせて留めるだけで楽な体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208747_10000922/5.1/'),
('julius-k9-idc-power','パグ',NULL,NULL,'pull','ぐんぐん引っ張る7kgのパグに頑丈なものとしてMini。頭にかぶせてお腹で留めるだけで、引いてもしっかり支えてくれる体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208747_10000922/5.1/'),
('julius-k9-idc-power','ジャックラッセルテリア',NULL,NULL,'skin','7.4kgのジャックラッセルにぴったり。引いた時に首から抜けそうに見えるが脇でしっかり固定されている。使い始めは脇が少し擦れるようだった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208747_10000922/5.1/'),
('julius-k9-idc-power','柴プー',NULL,NULL,'pull trachea','引っ張り癖がひどく首輪ではゼェゼェしていた1歳・10kgの柴プーで、高いので迷ったが、首に負担の少ないものとして選んだ体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208747_10000922/5.1/'),
('julius-k9-idc-power','ミニチュアシュナウザー',NULL,NULL,'durability','前のハーネスの継ぎ目の金具が壊れて危ない目に遭った1歳・9kgのシュナウザーで、頑丈で安全なものとしてMiniを選んだ体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208747_10000922/5.1/'),
('julius-k9-idc-power','イタリアングレーハウンド',NULL,NULL,'chew handle','前のものを噛み砕いたイタグレでワンサイズ上を買い直し、背中の持ち手でドッグランでもさっと引き寄せられ、抱っこの補助にもなる体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208747_10000922/5.1/'),
('julius-k9-idc-power',NULL,NULL,NULL,'sizing','首回り28cm・胸囲46cm・8kgの犬でMiniと迷い、体重よりフィット感を優先するよう助言されてMiniMiniを最大幅で使っている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208747_10000922/6.1/'),
('julius-k9-idc-power','トイプードル×ヨークシャーテリア',NULL,NULL,'handle dislike-on','外は好きだがハーネスを嫌がる6.4kgのミックスで、頭からかぶせて胸で留めるだけと簡単。ドッグランや車の乗り降りで背中の持ち手が活躍している体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208747_10000922/6.1/'),
('julius-k9-idc-power','ビーグル',NULL,NULL,'pull trachea','自分からぐんぐん進むため首輪だと首が締まるのが気になっていた8歳のビーグルにMini。ハーネスを見せると喜んで飛び跳ねた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208747_10000922/6.1/'),
('julius-k9-idc-power','豆柴',NULL,NULL,'sizing clothes','7kgの少し大きめの豆柴で、体はぴったりでも首回りが苦しそうだったため、ワンサイズ大きいものに交換した体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208747_10000922/6.1/'),
('julius-k9-idc-power','コーイケルホンディエ',NULL,NULL,'pull sizing','飛び出し癖があり四方八方に力いっぱい引っ張る4歳・11kgのコーイケルホンディエで、採寸ではMiniMiniだったが合わずMiniに交換してぴったりだった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208747_10000922/6.1/'),
('julius-k9-idc-power',NULL,NULL,NULL,'escape','首回りを調整できないハーネスで3回逃げられたことがあり、価格より安全を優先して選んだ。ショップからは形状上絶対に抜けないとは言えないと説明を受けた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208747_10000923/4.1/'),
('julius-k9-idc-power','ゴールデンレトリバー',NULL,NULL,'durability','長年使った旧型のベルトがくたびれた7歳のゴールデンで、買い替えたこのモデルの方が良いと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208747_10000923/4.1/'),
('julius-k9-idc-power','ジャーマン・シェパード・ラブラドール・ジャックラッセルテリア',NULL,NULL,'multi','28kgのシェパード、22kgと25kgのラブラドール、6.5kgのジャックラッセルの4頭すべてで色違いを使っている。ベルトは少し硬めに感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208747_10000923/4.1/'),
('julius-k9-idc-power','ラブラドール',NULL,NULL,'puppy sizing','6か月・20kgのラブラドールの子犬にサイズ0。やや大きかったが胴と首を調整でき抜けることはなく、成長しても長く使えそうな体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208747_10000923/4.1/'),
('julius-k9-idc-power','ゴールデンレトリバー2頭',NULL,NULL,'multi sizing','胸囲75cm・25kgと胸囲78cm・29kgのゴールデン2頭にサイズ1。胴ベルトを最大から2〜3cm短くした状態でぴったりだった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208747_10000923/4.1/'),
('julius-k9-idc-power',NULL,NULL,NULL,'trachea','細いハーネスでは少し引いただけでゲホゲホしていた犬で、胸に太いベルトがかかるこれではゲホゲホ言わなくなった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208747_10000923/4.1/'),
('julius-k9-idc-power','バーニーズ・マウンテン・ドッグ',NULL,NULL,'durability','旧型では胴ベルトが前足の付け根に食い込みよれてきたが、改良されたこのモデルは丈夫で、40kgのバーニーズにも安心して使える体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208747_10000923/4.1/'),
('julius-k9-idc-power','コーギー',NULL,NULL,'sizing','15kgの大きめのコーギーにサイズ0。脇の方は合ったが首側が大きく歩くとずれるため、余ったマジックテープを切って縫い留めようとしている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208747_10000923/4.1/'),
('julius-k9-idc-power','ゴールデンレトリバー',NULL,NULL,'senior trachea','あまり引かないが、首輪では気道が心配な年齢になってきた10歳・30kgのゴールデンにサイズ1。調子が良いので、引っ張り癖のあるもう1頭にも使うことにした体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208747_10000923/4.1/'),
('julius-k9-idc-power','シベリアンハスキー',NULL,NULL,'sizing','少しむちむちした1歳・20kg弱のハスキーにサイズ0。首回りはいっぱいに絞り、胸回りは半分ほど伸ばしてちょうど良かった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208747_10000923/5.1/'),
('julius-k9-idc-power','ラブラドール・ボーダーコリー',NULL,NULL,'multi pull','ラブラドールとボーダーコリー2頭の3頭散歩で、ぐいぐい引くボーダーコリーの引っ張り癖がおさまっていった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208747_10000923/5.1/'),
('julius-k9-idc-power','ラブラドール',NULL,NULL,'puppy pull trachea','リードをぐいぐい引いて息切れがひどかった5か月の黒ラブで、一番締めた状態でぴったり。以前ほど息切れしなくなった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208747_10000923/5.1/'),
('julius-k9-idc-power','サモエド',NULL,NULL,'pull sizing','体重22kgと小さめだが毛量の多いサモエドにサイズ1。引っ張った時に左手でリードを引くと体に伝わるらしく、引くのをやめる体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208747_10000923/5.1/'),
('julius-k9-idc-power','ジャーマン・シェパード',NULL,NULL,'escape','首輪で後ずさりした時に3度ほど抜けて怖い思いをしたシェパードで、このハーネスなら簡単には抜けないと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208747_10000923/5.1/'),
('julius-k9-idc-power','ホワイトシェパード',NULL,NULL,'sizing','ワンサイズ小さめに買い直したホワイトシェパードにぴったりで、ライトホルダーに懐中電灯を付けると夜の散歩でも足元がよく見える体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208747_10000923/5.1/')
)
INSERT INTO reviews(product_id,dog_breed,dog_size,coat_type,needs,summary,source_type,source_url)
SELECT n.product_id,n.dog_breed,n.dog_size,n.coat_type,n.needs,n.summary,n.source_type,n.source_url
FROM new_reviews n
WHERE NOT EXISTS (
  SELECT 1 FROM reviews r
  WHERE r.product_id=n.product_id
    AND r.summary=n.summary
);

-- 投稿の識別情報(review_sources)。review_id は (product_id, summary) で上の口コミに結び付ける。追加のみ。
WITH new_sources(product_id,summary,source_type,source_url,source_platform,source_review_id) AS (
VALUES
('julius-k9-idc-power','体重12kg台後半で胴が長めの柴犬にMiniを選び、ベルトを調整してぴったり合わせられた。リードを付ける部分の強度だけは少し気になったという体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208747_10000922/1.1/','rakuten','208747_10000922:20260906:482b8f69:979c2c28f8'),
('julius-k9-idc-power','首輪だけだと抜けやすい柴犬（9kg）にMiniがちょうど合い、歩き方に癖があっても問題なく散歩できている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208747_10000922/1.1/','rakuten','208747_10000922:20260814:a79aedfa:fc5dc07e6b'),
('julius-k9-idc-power','8歳の柴犬で、迎えた時から同じシリーズを使い続けている。着脱が簡単で不具合もなく、気づくと数年使えているという長期使用の体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208747_10000922/1.1/','rakuten','208747_10000922:20260920:482b8f69:35b6481af5'),
('julius-k9-idc-power','頭からかぶせるだけで着けられるので嫌がらずに装着できたが、7kg弱の豆柴にはMiniが少し大きかったという体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208747_10000922/1.1/','rakuten','208747_10000922:20251019:482b8f69:4bf7f498cc'),
('julius-k9-idc-power','子犬の頃に1本目を噛んで壊してしまったが、買い直した2本目は約6年使えたというリピート購入の体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208747_10000922/3.1/','rakuten','208747_10000922:20170309:fb26255b:648f6c7018'),
('julius-k9-idc-power','9kgと10kgのフレブル2頭ともMiniで合ったが、調整部分が緩んでいた時に散歩中に引っ張られて抜けたことがあり、こまめな確認が必要と感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208747_10000922/2.1/','rakuten','208747_10000922:20250704:482b8f69:7edd75c20c'),
('julius-k9-idc-power','首輪では引っ張った時にゼイゼイと苦しそうだった5歳の柴犬（9kg弱）が、このハーネスに替えてからは苦しそうな様子がなくなった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208747_10000922/2.1/','rakuten','208747_10000922:20250604:482b8f69:c686a1b1e4'),
('julius-k9-idc-power','気管が細く首輪も一般的なハーネスでも咳き込んでいたジャックラッセルで、前側に少し余裕を持たせて胸下を合わせたところ、抜けずに咳もほとんど出なかった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208747_10000922/2.1/','rakuten','208747_10000922:20160414:f2fa1668:081cfefce0'),
('julius-k9-idc-power','引っ張り癖と軽い気管虚脱がある4.8kgのトイプードルにMiniMiniを最小に調整して使用。胸側のベルトは余り気味だが、最初は気にしていたベルトにもすぐ慣れた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208747_10000922/3.1/','rakuten','208747_10000922:20200911:ad6c7f54:39a9d4168b'),
('julius-k9-idc-power','洗濯機で洗っても留め具やほつれの問題は出ていないが、犬が急に後ろへ下がると簡単に抜けることがあり、先代犬（雑種14kg）は一度抜けたため首輪との併用を考えた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208747_10000922/3.1/','rakuten','208747_10000922:20191031:f271cbf7:5303b9a9de'),
('julius-k9-idc-power','2歳の柴犬（10kg）で3本目になるほど丈夫だと感じている一方、後ずさりすると抜けてしまうため首輪と連結して使っている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208747_10000922/3.1/','rakuten','208747_10000922:20230316:482b8f69:92aefac04a'),
('julius-k9-idc-power','約1年半でリード金具をつなぐ部分が半分近く裂け、擦れる部分の毛も抜けてきたが、夏に別のハーネスへ替えると犬が全く歩かず、結局これに戻した体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208747_10000922/3.1/','rakuten','208747_10000922:20171111:ff9b7801:fd07626ed9'),
('julius-k9-idc-power','シニアになり興奮して首輪で喉を締めるのを避けたくて、6kgのジャックラッセル2頭に購入。別売りのチェストパッドの付け方は分かりにくかったが、一度付ければ装着は簡単だった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208747_10000922/3.1/','rakuten','208747_10000922:20151102:482b8f69:66cd34dc28'),
('julius-k9-idc-power','後ろ足が弱い犬で、リードの位置が背中寄りのため引いた時の前足への負担が減ったように感じ、排泄時にふらつく時は持ち手で体を支えられて便利だった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208747_10000922/2.1/','rakuten','208747_10000922:20141229:59a99857:a02cbb6f17'),
('julius-k9-idc-power','40kgの大型犬で約3年使えている。脇が少し擦れるのは他のハーネスでも避けにくいと感じつつ、夜は大きな反射部分が見やすいという体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208747_10000923/1.1/','rakuten','208747_10000923:20251205:1f0ba542:16c0c04b0b'),
('julius-k9-idc-power','首輪が外れて逃げたことがある怖がりのラブラドール（26kg）に、体重表を基準にサイズ1を選んでぴったり合い、抜ける心配がなさそうだと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208747_10000923/1.1/','rakuten','208747_10000923:20250701:d8fb404e:5306beecf8'),
('julius-k9-idc-power','引っ張りの強い中型犬で、首輪やY字型のハーネスでもゼイゼイしていたが、このハーネスでは喉元に当たらず苦しそうな音がしなくなった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208747_10000923/1.1/','rakuten','208747_10000923:20140702:549124fa:48f921b0c4'),
('julius-k9-idc-power','力が強く引っ張る30kgのダルメシアンで、コントロールしやすくなり、首の締め付けがなくなってゼイゼイ言わなくなった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208747_10000923/1.1/','rakuten','208747_10000923:20150324:482b8f69:6a92d47ca1'),
('julius-k9-idc-power','訓練所では首輪だけだった15.8kgのボーダーコリーが、自分から頭を出して着けさせるほど気に入り、引っ張り癖もほとんど出なくなった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208747_10000923/1.1/','rakuten','208747_10000923:20220811:52658676:a43a4e4f8b'),
('julius-k9-idc-power','足腰が弱り首輪で足を滑らせることがあった13歳のラブラドールに使い、本人も快適そうで、もっと早く替えればよかったと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208747_10000923/2.1/','rakuten','208747_10000923:20141205:482b8f69:354b66c724'),
('julius-k9-idc-power','1歳のラブラドールにサイズ2を選んだら首のストラップが余った。重さと大きさがあるためか装着時はテーブルの下に隠れて固まるが、着ければ散歩を喜ぶという体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208747_10000923/2.1/','rakuten','208747_10000923:20151030:482b8f69:a81fbae55c'),
('julius-k9-idc-power','装着は1か所留めるだけで簡単だが、後ろに引っ張られると抜けたことがあり、脇の下が擦れて毛玉ができたという体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208747_10000923/2.1/','rakuten','208747_10000923:20151031:751f6314:6821a2773b'),
('julius-k9-idc-power','前のハーネスで脇や胸が赤くなっていた16kgのコーギーに使い、説明書どおりに着けると脇とベルトが離れて擦れず、引っ張られた時も安定している体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208747_10000923/2.1/','rakuten','208747_10000923:20220125:482b8f69:fa31cbe85c'),
('julius-k9-idc-power','やせ型22kgのラブラドールハーフにサイズ1。胸のベルトを一番短くしてちょうど良いが、前にまっすぐ引かれた時に抜けるのが不安で首輪と2本のリードで使っている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208747_10000923/2.1/','rakuten','208747_10000923:20221007:c50941ad:d0e0b6f626'),
('julius-k9-idc-power','9か月・30kgのシェパードで、持ち手のおかげで飛びつきや急な引っ張りを抑えやすくなった。一方、むき出しのバックルが塀に擦れて壊れないか心配という体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208747_10000923/2.1/','rakuten','208747_10000923:20220629:219f0968:ce51168bbd'),
('julius-k9-idc-power','胸だけが大きい甲斐犬でサイズ選びに苦労したが、サイズ0で合い、足を通すタイプと違って嫌がらずに着けられている体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?store_id=tsumugu-design-goods&page_key=harness-03','yahoo','a37407a5-b62c-455f-9ea4-431c294d2fc6'),
('julius-k9-idc-power','引っ張り癖のある犬で喉元への食い込みは減ったと感じる一方、思い切り後ろに下がると簡単に抜けること、雨上がりはお腹側が乾きにくいことが気になった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?store_id=tsumugu-design-goods&page_key=harness-03','yahoo','66bf700c-a086-4d29-8c29-14a03b933327'),
('julius-k9-idc-power','3.9kgの柴犬でも緩くならずに使え、ドッグランで捕まえる時に持ち手が便利。ただし強く引かれた時や持ち手で抱き上げた時に抜けることがあると注意している体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?store_id=flaner-y&page_key=f10021127','yahoo','9b14b7eb-730d-4c2c-9275-c6ebd0bc5632'),
('ruffwear-front-range','興奮すると強く引っ張り首輪だけでは喉を圧迫していた2歳のラブラドール（21kg）で、体をしっかり支えつつ当たりが柔らかく、価格に見合うと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/266503_10000952/1.1/','rakuten','266503_10000952:20260722:482b8f69:edda9bc3e6'),
('ruffwear-front-range','生後6か月ほどの元野犬（15.5kg）にSサイズを合わせ、胸側のループにリードを付けると引っ張りが少し軽くなったと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/266503_10000952/1.1/','rakuten','266503_10000952:20260626:dd49050b:75fd703744'),
('ruffwear-front-range','まだ若く散歩中にちょろちょろ動く4.7kgのトイプードルにXXSがぴったりで、調整して冬服の上からでも着けられた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/266503_10000952/1.1/','rakuten','266503_10000952:20251211:482b8f69:897094ccb3'),
('ruffwear-front-range','9kgちょっとのパグにXSを選び、サイズにはまだ余裕があるがパッド部分が硬く感じたという体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/266503_10000952/1.1/','rakuten','266503_10000952:20260415:ad08c7e5:5abe466e98'),
('ruffwear-front-range','6.5か月のビションで丈夫さには安心したが、頭を通す前にアジャスターを緩め、通した後に締め直す作業が毎回面倒だったという体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/266503_10000952/1.1/','rakuten','266503_10000952:20260306:3921384c:c4d67e7762'),
('ruffwear-front-range','3.4kgの柴犬にXXSを着けたところ、前のハーネスより重く感じたのか固まって動けず、少しずつ慣らしているという体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/266503_10000952/1.1/','rakuten','266503_10000952:20260614:482b8f69:b7f6340b7f'),
('ruffwear-front-range','山歩きで何度使っても抜けたことがない。同じ17kgでも、毛量が少なく細身の子はS、胸ががっしりした子はMと、体格でサイズが分かれた多頭飼いの体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/266503_10000952/3.1/','rakuten','266503_10000952:20241011:482b8f69:e79caf0125'),
('ruffwear-front-range','劣化したハーネスで皮膚が赤くなったパグ（8.7kg）に替え、当たりが柔らかく、名前欄や迷子札入れ、ライト用の輪など機能が多くて便利だった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/266503_10000952/1.1/','rakuten','266503_10000952:20250909:d597e07f:d700e5ed83'),
('ruffwear-front-range','前足が細長く頭が小さいため首輪もひも状のハーネスも抜けやすかった10kgの柴犬で、探した末にこれに落ち着きリピートしている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/266503_10000952/1.1/','rakuten','266503_10000952:20241111:8e9815eb:932f1fc4ee'),
('ruffwear-front-range','引っ張り癖でいつもゼーゼーしていた9か月のシュナウザー。人気の別製品は断固拒否したが、これは怪訝な顔をしつつも散歩に行け、引っ張る回数も減った体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/266503_10000952/2.1/','rakuten','266503_10000952:20230710:482b8f69:58582aa53e'),
('ruffwear-front-range','引っ張りと後ずさりがあり他のハーネスでは何度も抜けた7か月の柴犬（9.6kg）で、何度後ずさりしても抜けなかった。首回りの調整が毎回必要な点は面倒という体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/266503_10000952/2.1/','rakuten','266503_10000952:20210213:482b8f69:8f93e4cfaf'),
('ruffwear-front-range','いつもと違うことに敏感な9か月の豆柴で、ハーネスだけならドッグランで楽しく走れたが、リードを付けると転げ回って鳴き、リードの金具音も気にしていた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/266503_10000952/2.1/','rakuten','266503_10000952:20221025:482b8f69:e484b34a93'),
('ruffwear-front-range','胸毛が多い34kgのゴールデンにL/XLを選び、引っ張り抑制用の前側ループにリードを付けると引っ張りがかなり減り、パッドのおかげで擦れの心配もない体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/266503_10000952/2.1/','rakuten','266503_10000952:20231117:482b8f69:d0449d0ace'),
('ruffwear-front-range','8kg弱の小型犬にはコルセットのように硬く、特に肩まわりがごわつくため一部を外して工夫したが、その硬さのおかげで急にバックしても抜けないと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/266503_10000952/2.1/','rakuten','266503_10000952:20210131:3a5ea663:78a5545715'),
('ruffwear-front-range','顔が大きい40kgの秋田犬で、肩まわりを合わせると頭が入りにくいが少し緩めても抜けなさそう。キャンプで数日着けっぱなしでも当たりが優しいという体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/266503_10000952/2.1/','rakuten','266503_10000952:20200804:482b8f69:c9f5258b7e'),
('ruffwear-front-range','着けた初日は戸惑った顔だったが翌日には慣れた。ただ前足を踏ん張った状態で前に引いたら抜けてしまい、ベルトを合わせ直したという体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/266503_10000952/2.1/','rakuten','266503_10000952:20210421:9fac6972:0f4e8db8f9'),
('ruffwear-front-range','人慣れしない元野犬（14kg）に使い、びっくりして後ずさりしても抜けず、迎えて2年でようやく野山を楽しめるようになった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/266503_10000952/2.1/','rakuten','266503_10000952:20200322:785612e7:1cbeb35efc'),
('ruffwear-front-range','トリミングで毛が短くなりJulius-K9が抜けやすくなったため替えたところ、H型で抜けにくく喉も締めないが、止まった状態で合わせても歩くと緩むなどサイズ調整は難しかった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/266503_10000952/3.1/','rakuten','266503_10000952:20230701:fe4ae0d5:101713e188'),
('ruffwear-front-range','3.5kgと5.2kgのトイプードルにXXSとXSを使い、首回りが少し大きくても後ろに引かれて抜けることはなく、迷子札入れや名前欄も便利だった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/266503_10000952/3.1/','rakuten','266503_10000952:20201222:482b8f69:8a1f12b777'),
('ruffwear-front-range','頸椎のヘルニアがあり首に負担をかけたくない8.6kgのフレブルで、前側の引っ張り防止リングも使える一方、首が太く毎回サイズ調整が必要で価格も高めと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?store_id=torusdogmartyokohama&page_key=ruffwear-frontrange-harness','yahoo','7f5f9b98-0811-484f-8e68-63749672b40e'),
('ruffwear-front-range','以前のハーネスで引っ張ると首の下が赤くなり毛も抜けた5.6kgのジャックラッセルに替え、安定感があると感じたが、バックルは硬めで慣れるまで扱いにくかった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?store_id=torusdogmartyokohama&page_key=ruffwear-frontrange-harness','yahoo','198c8b72-d5c1-46eb-9fb8-dd63fd7bcfaa'),
('ruffwear-front-range','シニアになり首輪だけでは喉に負担がかかると考えて10歳の柴犬（11kg）に使用。頭を通す部分はやや狭いが、その分抜けにくいと感じている体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?store_id=torusdogmartyokohama&page_key=ruffwear-frontrange-harness','yahoo','0e43b833-e48f-4f22-a1a9-4fe2e9159032')
)
INSERT OR IGNORE INTO review_sources(review_id,source_type,source_url,source_platform,source_review_id)
SELECT r.id,s.source_type,s.source_url,s.source_platform,s.source_review_id
FROM new_sources s
JOIN reviews r ON r.product_id=s.product_id AND r.summary=s.summary;

WITH new_sources(product_id,summary,source_type,source_url,source_platform,source_review_id) AS (
VALUES
('ruffwear-front-range','気になる犬や鳥を見ると突然ダッシュし、前年に引っ張られて大けがをした11kgのアメリカンコッカーで、ようやく合うハーネスが見つかったと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?store_id=torusdogmartyokohama&page_key=ruffwear-frontrange-harness','yahoo','0f658d60-78ed-441e-9272-711a1900bdc6'),
('puppia-soft-vest','足元が少しふらつく17歳・3.7kgのミニチュアダックスで、着脱が簡単なのが助かった。Mでは少し大きかったという体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/230805_10000752/1.1/','rakuten','230805_10000752:20260516:4ff15333:03880860b7'),
('puppia-soft-vest','胴回り36cm・4.5kgのカニンヘンダックスで、服の上から用のLは大きすぎ、服なし用のMはベルトに余裕がなくマジックテープで緩められなかった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/230805_10000752/1.1/','rakuten','230805_10000752:20251213:536a489e:87ef17ba61'),
('puppia-soft-vest','気管虚脱があり、メガネ型のハーネスではえずいていたが、気管に当たる布地が広いこのタイプに替えて少し楽になった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/230805_10000752/1.1/','rakuten','230805_10000752:20260810:e37817ea:0b0d4d6d6e'),
('puppia-soft-vest','7か月・7.3kgのシュナウザーにXLを選んだら一番締めても胸が浮き、トリミング後はさらに緩く、自転車に興奮した時に脱げてしまった。Lにすべきだったという体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/230805_10000752/1.1/','rakuten','230805_10000752:20260810:482b8f69:b25218879e'),
('puppia-soft-vest','チワワは経年劣化で買い替える程度に長持ちした一方、日本テリアは少し噛んだだけで噛み破ってしまったという体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/230805_10000752/1.1/','rakuten','230805_10000752:20251202:7c033ab4:e649c3b03a'),
('puppia-soft-vest','4か月・2kg未満の子犬にSを着けたところ、1週間で何度か脱げてしまい、XSの買い足しを考えている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/230805_10000752/1.1/','rakuten','230805_10000752:20260808:aeeada0d:6a44795bb7'),
('puppia-soft-vest','かなり引っ張る3歳のボストンテリアでも外れたことはなく洗えて便利だが、抜け毛がよく付き、においも付きやすいという体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/230805_10000752/1.1/','rakuten','230805_10000752:20260609:482b8f69:551a674e9b'),
('puppia-soft-vest','6.5kgのシュナプーにXL。前足を入れる穴が大きく散歩中に一度抜けたが、マジックテープをきつめに調整し直してからは抜けていない体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/230805_10000752/1.1/','rakuten','230805_10000752:20260402:482b8f69:9d772f1613'),
('puppia-soft-vest','色違いで4つ目のリピート。サイズが大きいと踏ん張った時に首から抜けるので、苦しくない範囲できつめに着けている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/230805_10000752/1.1/','rakuten','230805_10000752:20251126:d91076f3:dfaf516925'),
('puppia-soft-vest','グイグイ歩く12kgの犬でXLは小さくXXLに交換。首元の圧迫が少ない一方、強力なマジックテープを外す音に音に敏感な犬が少し驚くという体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/230805_10000752/1.1/','rakuten','230805_10000752:20260521:482b8f69:99a4ae81e2'),
('puppia-soft-vest','7kgのトイプードルにXLは少し大きかった。マジックテープのバリバリ音を嫌がって暴れたが、ゆっくり少しずつはがすと大丈夫になった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/230805_10000752/1.1/','rakuten','230805_10000752:20260329:af547b77:2748ae082f'),
('puppia-soft-vest','5か月・2.8kgのパピヨンにSがちょうど良く、マジックテープを外す音には一瞬驚いていたという体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/230805_10000752/2.1/','rakuten','230805_10000752:20260828:482b8f69:37391db060'),
('puppia-soft-vest','首のヘルニアになった犬で、首に負担がかかりにくい形として選び、治療で散歩に行けるようになってからも嫌がらずに使えている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/230805_10000752/2.1/','rakuten','230805_10000752:20260716:589c2a26:a0385d2a27'),
('puppia-soft-vest','ひも状のハーネスはどうしても噛んでしまう3.2kgの犬で、体にフィットするベストタイプにしたらすんなり散歩に行けた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/230805_10000752/2.1/','rakuten','230805_10000752:20260304:b61d4b49:8b209df745'),
('puppia-soft-vest','体にぴったり合って抜けずに使えているが、使ううちにマジックテープが効きにくくなるので消耗品として買い替えているという体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/230805_10000752/2.1/','rakuten','230805_10000752:20260224:91421e18:d3a03644a4'),
('puppia-soft-vest','首回り21cm・胴回り36cmの華奢なトイプードルで、Sは胴がきつくMにしたらあご下に余裕ができた。背中のマジックテープで首回りを詰めて使っている体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?store_id=best-friends&page_key=puppia-harness002','yahoo','a83da537-8054-4fb8-bd0d-c22e2386d5a2'),
('puppia-soft-vest','人や音に怯える3〜4か月の元野犬の子犬でLは大きく、マジックテープの音にも怖がる。一度すり抜けたので、ハーネスだけの散歩は避けた方がよいと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?store_id=best-friends&page_key=puppia-harness002','yahoo','399e6fb5-daca-43b8-a44b-3b176747265e'),
('puppia-soft-vest','4歳・4kgのポメラニアンで、トリミング前の毛量が多い時期用のLは抜けないか少し不安、Mはきつめだが安心感があるという体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?store_id=best-friends&page_key=puppia-harness002','yahoo','93a3d85a-bd26-464a-bfca-5c878a08e53a'),
('puppia-soft-vest','胸が前に張っていない4.6kgのロングのミニチュアダックスに合い、軽くて洗ってもすぐ乾くので色違いで買い足した体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?store_id=best-friends&page_key=puppia-harness002','yahoo','6d8537e7-fa2f-40f0-b7aa-7c46bcb9d9a4'),
('puppia-soft-vest','2.2kgと1.6kgのロングコートチワワにSとXS。軽く、着脱を嫌がる犬でも着けやすく、首への負担も少ないと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?store_id=best-friends&page_key=puppia-harness002','yahoo','c87ab3f8-c56e-471f-9986-6cf718c84d08'),
('puppia-soft-vest','2.8kgのミニピンにM。首回りは大きいが脱げることはなさそうで、冬のアウターの上からも使えそうだという体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?store_id=best-friends&page_key=puppia-harness002','yahoo','145dde29-b7a7-4dc1-9311-aa3f08a0310d'),
('petsafe-easy-walk','以前使っていたデラックス版より肌当たりが気になり、服を着せずに使うと赤くなる。ただ他のものに替えると引っ張ってしまうので使い続けているという体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/284187_10031274/1.1/','rakuten','284187_10031274:20251221:276755bb:04537b7e1f'),
('petsafe-easy-walk','チョーカーで散歩していた23kgのハスキーで、引っ張る力が半分ほどになった一方、脇が擦れて血が出たため当て布を考えたという体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/284187_10031274/1.1/','rakuten','284187_10031274:20180918:bd927d37:93878c54aa'),
('petsafe-easy-walk','引っ張られて捻挫や転倒を繰り返していたラブラドール4頭の家庭で、着けると引っ張らなくなり、1人で4頭の散歩もできそうだと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/284187_10031274/1.1/','rakuten','284187_10031274:20220922:d4311917:5242eae697'),
('petsafe-easy-walk','しつけ教室でも直らなかった4.3kgのダックスの引っ張りが、着けた途端に止まり驚いたという体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/284187_10031274/1.1/','rakuten','284187_10031274:20230911:482b8f69:fe833230f2'),
('petsafe-easy-walk','トレーナーに勧められて使っている10kgの柴犬で、引っ張り癖自体は直らないが散歩はしやすくなったという体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/284187_10031274/1.1/','rakuten','284187_10031274:20220719:482b8f69:2cea8ff30f'),
('petsafe-easy-walk','8歳になりほとんど引っ張らなくなったが、吠えられると向かっていってしまう42kgのゴールデンドゥードルのため手放せないという体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/284187_10031274/1.1/','rakuten','284187_10031274:20220711:37dbb86a:1d08e34548'),
('petsafe-easy-walk','引っ張りの強い9kgのコーギーで、持っているJulius-K9より引っ張り対策には効果がありそうと感じた。サイズの境目で小さい方を選び、少し小さかった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/284187_10031274/1.1/','rakuten','284187_10031274:20211129:128202ce:dc57db9af8'),
('petsafe-easy-walk','腰の手術後の家族と歩くために購入し、引く力がほとんどかからなくなった。ただ4kgの小型犬で、胸下のひもを短くしないと臆病で興奮した時に片足が抜けてしまう体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/284187_10031274/1.1/','rakuten','284187_10031274:20190904:188a4dd6:5c321df761'),
('petsafe-easy-walk','普段はおとなしいが興奮すると引っ張るセントバーナードとバーニーズ、ミックスの子犬にそれぞれ使い、どの子にも合ったという体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/284187_10031274/1.1/','rakuten','284187_10031274:20221214:482b8f69:78966630a4'),
('petsafe-easy-walk','3.3kgのトイプードルで、引っ張ると止まるようになったが、そこから前に進まなくなることもあり慣れを待っている体験。頭を通さずに着けられる点は楽だった。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/284187_10031274/1.1/','rakuten','284187_10031274:20221225:482b8f69:6b54db8a9e'),
('petsafe-easy-walk','使い始めの勢いよく走った時に派手に転んだが、その後は注意して歩くようになり、少し前を歩くもののグイグイ引くことはおさまった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/284187_10031274/1.1/','rakuten','284187_10031274:20221027:ff90014e:bf724b70aa'),
('petsafe-easy-walk','ビビりで引っ張りの強い保護犬で、引く力が半分になった一方、脇が赤くなったためフェルトのカバーを付け、緩む胸の部分は縫い留めた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/284187_10031274/1.1/','rakuten','284187_10031274:20221013:482b8f69:e4a1d6821e'),
('petsafe-easy-walk','人や自転車を見ると走り出す7か月・33kgのピレニーズで、最初は着けるのに苦労したが、引っ張りが8割ほど減り片手でも制御できるようになった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/284187_10031274/2.1/','rakuten','284187_10031274:20220614:482b8f69:317d49240f'),
('petsafe-easy-walk','15kgの雑種で、前側を一番小さくしてもまだ少し大きい。引き返す力は半分ほどで済むが、胸にリードを付けるのでたるむと地面に付きやすいという体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/284187_10031274/1.1/','rakuten','284187_10031274:20220705:482b8f69:7a4c0fb959'),
('petsafe-easy-walk','しつけ教室でも直らなかった1歳・31kgの大型犬（ゴールデン）が片手で持てるほどになったが、脇の下が擦れて赤くなるため当て布などの工夫が必要な体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?store_id=countryfield&page_key=ps-ewhbulk','yahoo','d63e880e-1af9-4b82-9dfc-65bfbb460c9b'),
('petsafe-easy-walk','ハーフチョークで首の毛が薄くなった6歳のミニピンで、興奮時以外は引っ張らなくなった。脇が赤くなる時があり、半年で胸の調整金具が緩みやすくなった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?store_id=countryfield&page_key=ps-ewhbulk','yahoo','0d88abea-4159-41ea-9311-4bd620c0b25f'),
('petsafe-easy-walk','後ろに引いてハーネスを脱いでしまう30kgの大型犬の保護犬で、胴回りがしっかり固定され脱げることはなかった。緩みやすいという声を見て調整部を縫い留めた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?store_id=countryfield&page_key=ps-ewhbulk','yahoo','85aeb4e4-102e-40a7-a643-603777d3173b'),
('petsafe-easy-walk','脇にかなり食い込んでいるように見え、引っ張れない分いら立つのか歩くのをやめてじゃれついてくるようになり、うちの犬には合わないかもしれないと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?store_id=countryfield&page_key=ps-ewhbulk','yahoo','502f2ab4-dbba-4794-a7e9-7d6a47042216'),
('petsafe-easy-walk','上の2頭は引っ張り癖がすぐ直ったが、5か月の子犬では引っ張らないのに咳き込むことが多く、小さな体には合わないかもしれないと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?store_id=glv&page_key=pts-90','yahoo','fbd8fa94-ea86-466f-afd1-2ef76be21f58'),
('petsafe-easy-walk','引っ張りの強さはハーフチョークを10とすると4ほど。胸にリードがあるので散歩中にリードを噛まれることがあり、長い散歩には別の道具と使い分けている体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?store_id=glv&page_key=pts-90','yahoo','05f1de8d-8a90-4ad4-ae8b-0da0b2cce472'),
('petsafe-easy-walk','爪が削れて出血するほど引っ張っていた1歳・8.8kgのキャバリアで、動物病院で勧められて使うと引っ張りがほとんどなくなった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?store_id=glv&page_key=pts-90','yahoo','95acbd35-24d2-4a27-9085-3fdf1554b1ac'),
('petsafe-easy-walk','引っ張りは抑えられたが、服を着せても脇が擦れて赤くなり痛々しいため使用をやめたという体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?store_id=glv&page_key=pts-90','yahoo','ca409873-700a-48cd-b54d-1201bd696d87'),
('curli-vest-air-mesh','以前のハーネスは抜けやすく、興奮して引くとむせていた6.7kgのミニチュアダックスで、Mがぴったり合い生地も丈夫だった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000879/1.1/','rakuten','212247_10000879:20260909:cea40da7:892cb20d90'),
('curli-vest-air-mesh','2〜3kgの子犬2頭に2XSがちょうど良く、作りもしっかりしていたという体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000879/1.1/','rakuten','212247_10000879:20260510:01aa4dbb:e3aaaafdda'),
('curli-vest-air-mesh','首抜けしやすいチワワで、このハーネスにしてから抜けたことがなく、引っ張り癖があっても苦しそうにしないため5回リピートしている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000879/1.1/','rakuten','212247_10000879:20251225:64852aef:07a3ecebcc'),
('curli-vest-air-mesh','体に当たる部分が柔らかい素材だけのものを探していた7.8kgの黒豆柴で、預け先で一日中着けっぱなしになることが多くても使いやすいと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000879/1.1/','rakuten','212247_10000879:20260702:482b8f69:30807d4f8c'),
('curli-vest-air-mesh','スムースのチワワで、体にフィットしマジックテープで調整でき、抜けにくく軽いので繰り返し購入している体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000879/1.1/','rakuten','212247_10000879:20260530:976eb9e5:26ce068738'),
('curli-vest-air-mesh','9kgのプードルで、新しいタイプのMは旧タイプのSと同じくらいきつくLに交換。新しいものは伸縮性が少ないように感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000879/1.1/','rakuten','212247_10000879:20251211:482b8f69:783ba91f78')
)
INSERT OR IGNORE INTO review_sources(review_id,source_type,source_url,source_platform,source_review_id)
SELECT r.id,s.source_type,s.source_url,s.source_platform,s.source_review_id
FROM new_sources s
JOIN reviews r ON r.product_id=s.product_id AND r.summary=s.summary;

WITH new_sources(product_id,summary,source_type,source_url,source_platform,source_review_id) AS (
VALUES
('curli-vest-air-mesh','サイズ調整部分がマジックテープのため、ベルトとマジックテープが当たって擦れるところが少し気になったという体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000879/1.1/','rakuten','212247_10000879:20260619:482b8f69:d09180cae6'),
('curli-vest-air-mesh','胸回り36cmのチワワにXSでマジックテープの範囲ぎりぎり。冬に厚手の服を着るときつく、マジックテープの持ちも気になるという体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000879/1.1/','rakuten','212247_10000879:20260315:ca91439c:876d5f3895'),
('curli-vest-air-mesh','冬服の上から使えるものを探していた3.4kgのマルチワにSがちょうど良く、ごわつかずしなやかだが丈夫で色違いでも購入した体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000879/1.1/','rakuten','212247_10000879:20260101:afb49661:6cf6b0d42b'),
('curli-vest-air-mesh','毛が多く胸板が厚い3.1kgのポメチワにXS。調整幅は広くないので、胸板が厚い犬は1サイズ上も検討するとよいと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000879/1.1/','rakuten','212247_10000879:20250521:b2059711:6470172e81'),
('curli-vest-air-mesh','旧タイプと同じSを選んだが新しいものは全体に少し小さく、生地も硬く薄くなったように感じたという体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000879/1.1/','rakuten','212247_10000879:20250601:482b8f69:d3c500e80f'),
('curli-vest-air-mesh','肩ががっしりし胸板の厚い1.9kgのトイプードルで、3XSではマジックテープがほぼ留まらず2XSに交換。着脱がとても楽だった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000879/1.1/','rakuten','212247_10000879:20250521:b2059711:cabd199127'),
('curli-vest-air-mesh','8kgのスピッツにL。柔らかく、濡らしてクールベストのようにも使え、約1年使って少し伸びてきたため買い替えた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000879/2.1/','rakuten','212247_10000879:20250702:363dd912:1a427f39a2'),
('curli-vest-air-mesh','3.6kgのトイプードルにXSは胸がきつそうでSに交換。胸のマジックテープ以外はあまり調整がきかないのでサイズ選びが大事だと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000879/2.1/','rakuten','212247_10000879:20250610:482b8f69:6811197a0d'),
('curli-vest-air-mesh','3.5kgのポメラニアンにS。他のハーネスより毛が付きにくく、これまで手こずっていた着脱が簡単になった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000879/2.1/','rakuten','212247_10000879:20250524:482b8f69:7477afa30a'),
('curli-vest-air-mesh','4か月の子犬にXS。マジックテープが弱めで気づくと浮いており、後ずさりした時に抜けて危なかったため、強いテープに付け替えると決めた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?store_id=1stdogcafe&page_key=10000879','yahoo','6ea29ac4-8ed6-466c-aff6-2fe352992ab1'),
('curli-vest-air-mesh','胴囲38〜39cmのチワワ2頭にS。装着時に強く引いて試しても抜けず、引いた時の負担も少ないと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?store_id=1stdogcafe&page_key=10000879','yahoo','65c2d312-5948-43ea-85d7-d792a74cee61'),
('curli-vest-air-mesh','4か月・1.6kgの子犬で、外れて事故にならないよう軽くて頑丈なものを探し、サイズがぴったり合ったという体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?store_id=1stdogcafe&page_key=10000879','yahoo','008467a4-5477-4e1e-880d-e44ade54448c'),
('hakusan-zero-harness','首が細く胴回り40cmほどの5.8kgのトイプードルにXXSがぴったり。首と胴を別々に調整でき、頭を通して両脇のバックルを留めるだけなので楽な体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000685/1.1/','rakuten','212247_10000685:20260927:986c8c5b:047b4cbf46'),
('hakusan-zero-harness','5kgのミニチュアダックスにXXS。冬服の上からでも調整の余裕があり、抜けることもなく、裏のクッションも良かった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000685/4.1/','rakuten','212247_10000685:20230517:482b8f69:2af24d6491'),
('hakusan-zero-harness','3.3kgのトイプードルで散歩時のむせがなくなり、足を上げずに着脱できるので嫌がらず、散歩も楽しそうになった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000685/1.1/','rakuten','212247_10000685:20260901:0dde146c:cfafb0b442'),
('hakusan-zero-harness','9kgの柴犬で、最初はとても嫌がったが今では慣れてすんなり歩けているという体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000685/1.1/','rakuten','212247_10000685:20260314:482b8f69:7773bb178d'),
('hakusan-zero-harness','首が細いイタグレで首回りは一番細くしても余裕があるが、そこそこ引っ張っても左右にずれず脇にも当たらない。心配なので首輪と併用している体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000685/1.1/','rakuten','212247_10000685:20260902:482b8f69:cc5cce2274'),
('hakusan-zero-harness','気管支炎で咳が出るため獣医師に胸元がY字のものを勧められ、11.5kgの柴犬にS。クッションで負担は少なそうだが、思ったよりごつさを感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000685/1.1/','rakuten','212247_10000685:20260901:482b8f69:ff9e9209ae'),
('hakusan-zero-harness','ハーネス嫌いで困っていた6か月の柴犬が、ようやく嫌がらずに着けてくれるようになった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000685/1.1/','rakuten','212247_10000685:20260606:dbfdee30:a052c3a0b5'),
('hakusan-zero-harness','柔らかく肩の動きを妨げない作りで子犬やシニアにも向きそうだと感じた一方、半年を目安に買い替えるよう案内されており、素材からもそのくらいの強度だと思った体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000685/1.1/','rakuten','212247_10000685:20260324:482b8f69:d001cb4c19'),
('hakusan-zero-harness','21kgのサモエドに胸囲からLを選んだら大きく、Mに交換してちょうど良くなった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000685/2.1/','rakuten','212247_10000685:20260617:482b8f69:c9cb39d231'),
('hakusan-zero-harness','8.5kgのジャックラッセルで、XSを一番きつくしても緩めになり、しばらくすると抜けるようになったためXXSに買い替えた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000685/2.1/','rakuten','212247_10000685:20250716:482b8f69:fb73333a0a'),
('hakusan-zero-harness','2.8kgのトイプードルにTinyを一番きつく調整して使用。着脱のたびにベルト調整が必要で面倒だが、後ずさりしても外れなさそうで、以前のようなむせも減った体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000685/2.1/','rakuten','212247_10000685:20241114:482b8f69:1278f9a20d'),
('hakusan-zero-harness','12kg弱のフレブルにXSを最大に伸ばしてぴったり。薄い服ならぎりぎりで、冬のもこもこ服の上からは無理だった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000685/2.1/','rakuten','212247_10000685:20250410:17ad558b:68455e5be4'),
('hakusan-zero-harness','服を上手に脱いでしまう10か月・3kg弱のミニピンで、肌も弱いためハーネスを色々試しており、初日の散歩では良さそうだと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000685/2.1/','rakuten','212247_10000685:20250201:5caa3b04:2c5b327405'),
('hakusan-zero-harness','前のハーネスで皮膚が荒れた8.5kgのフレブルにXS。体側の素材が柔らかく擦れもなく、外れる心配もないと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000685/2.1/','rakuten','212247_10000685:20250226:5a724d03:975e20cdd5'),
('hakusan-zero-harness','32kgのゴールデンで、首を調整しても少し緩いが抜けることはなく安心して使えている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000685/2.1/','rakuten','212247_10000685:20241211:4af3495f:f2a2d43ace'),
('hakusan-zero-harness','首と胴の差が大きい16kgのハウンド系の犬で首はぶかぶかになり、背中の持ち手も手を通しにくいため、首輪と併用している体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000685/5.1/','rakuten','212247_10000685:20241011:353712e7:45c6a378e2'),
('hakusan-zero-harness','突然の後ずさりで首抜け事故があった11kg弱の犬にXS。後ずさりした時にリードの付け根がめくれ上がりひやっとしたが、首と胴をぴったり合わせていれば抜けないと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?store_id=1stdogcafe&page_key=10000685','yahoo','daf5d369-4a18-4ac7-b809-5fea881c5dd5'),
('hakusan-zero-harness','車や物音に驚いて急に引いたり後ずさりしたりする1歳・14kgの保護犬で、前のハーネスのようにむせることがなく、体に沿うので後ずさりしても抜けなかった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?store_id=1stdogcafe&page_key=10000685','yahoo','2752063f-1816-4322-8d1b-db8b41958389'),
('hakusan-zero-harness','脇の下に帯が来るハーネスで毛が擦れて剥げたフレブルに替え、脇に帯が来ず短毛にも優しい一方、飼い主が前に出て促す時にリードの付け根がめくれて安定しにくいと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?store_id=1stdogcafe&page_key=10000685','yahoo','2957e1cb-e030-43a5-bdfc-9273332af03b'),
('hakusan-zero-harness','短足でお腹側が汚れやすく頻繁に洗う10kg弱のコーギーで、半年過ぎから擦り洗いする部分の生地が薄くなったが、切れたり外れたりはなかった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?store_id=1stdogcafe&page_key=10000685','yahoo','72f182ea-001d-47e0-8744-b4ff87d6296d'),
('hakusan-zero-harness','気道の圧迫が気になっていた9.5kg以上のシーズーで、冬は服の上から着けるためSを選び、圧迫感が軽くなった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?store_id=1stdogcafe&page_key=10000685','yahoo','18edc52a-eadb-4fe5-9f44-7079d618a1fd'),
('hakusan-zero-harness','体が柔らかく服もすぐ脱いでしまう11か月のヨーキーが、前のハーネスを原っぱで脱いでしまったため探し、このハーネスは良かったという体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?store_id=1stdogcafe&page_key=10000685','yahoo','74ea28b2-901d-4de4-bb09-d04317c14f97'),
('hakusan-zero-harness','年齢が上がってきたため首輪から切り替えた27kgの大型犬にLがぴったり。素材が柔らかく、スムーズに歩いてくれた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?store_id=1stdogcafe&page_key=10000685','yahoo','519fb220-fac5-4a6a-a64b-24cb83196676'),
('hakusan-zero-harness','気管虚脱と心臓病があり気管に優しく抜けにくいものを探した小型犬で、一番小さいサイズでも少し大きく、リードを付けると首まわりがもたつくと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?store_id=1stdogcafe&page_key=10000685','yahoo','579aba31-f7b7-4011-b772-4a1ebdc01efa'),
('julius-k9-idc-power','ハーネス嫌いで2人がかりでも噛みつかれそうになっていた9.6kgの柴犬で、頭を通すだけで首輪並みに簡単に着けられ、散歩前のストレスが減った体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000348/1.1/','rakuten','212247_10000348:20241126:482b8f69:0e75654d6d'),
('julius-k9-idc-power','普段はあまり引かないが怖がりで急に強く引くことがある5kgのトイマンチェスターに、冬服を考えてMiniMiniを選び、着脱がとても簡単だった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000348/1.1/','rakuten','212247_10000348:20120901:482b8f69:575f37eade'),
('julius-k9-idc-power','胸囲49cm・9kgのビーグルでMiniMiniとMiniに迷い、ジャストより少し大きい方が使いやすいという助言を受けて選んだ体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000348/1.1/','rakuten','212247_10000348:20160518:482b8f69:98b31535a7'),
('julius-k9-idc-power','首輪も嫌がり、引っ張ると気管が締まるような音がしていた1歳前の柴犬で、首と胴にバックルがある胴輪は着けるのが大変だったため、このハーネスに替えた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000348/1.1/','rakuten','212247_10000348:20160927:482b8f69:aea750191e'),
('julius-k9-idc-power','胸のマジックテープを一度合わせれば、かぶせて前足の後ろで留めるだけで数秒。暴れ回る子犬を止める時に背中の持ち手が便利だった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000348/1.1/','rakuten','212247_10000348:20190901:482b8f69:e539353b29'),
('julius-k9-idc-power','7kgのパグにMiniMini、4kgのトイプードルにBaby2を選び、どちらもサイズが合い、最初に調整すれば着脱は簡単で軽いと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000348/2.1/','rakuten','212247_10000348:20210118:482b8f69:90124d8416'),
('julius-k9-idc-power','胸囲約40cm・6.5kgの小柄な柴犬にMiniMiniがぴったりで、前足を通すタイプのハーネスから替えた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000348/2.1/','rakuten','212247_10000348:20230922:3fa8a4f2:fe0e0b65f0'),
('julius-k9-idc-power','以前のハーネスは引くと喉に当たり、散歩後に喘息のような息をしていた8か月・12kg弱の白柴で、喉に当たりにくいものとしてMiniに替えた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000348/2.1/','rakuten','212247_10000348:20160527:482b8f69:3d2ce46d99'),
('julius-k9-idc-power','8kgのアメリカンコッカーにMini。脇下のベルトを一番小さくしても少し緩く、引くとハーネスが動き、頭側に引いた時に抜けることも気にしている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000348/2.1/','rakuten','212247_10000348:20190911:482b8f69:95d0f48392'),
('julius-k9-idc-power','引く力が強い12kgのフレブルで、作りが頑丈そうなうえ、脚を持ち上げずに着けられるので、散歩前に興奮していても手早く装着できる体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000348/3.1/','rakuten','212247_10000348:20150926:78b0e29b:e78de6296b'),
('julius-k9-idc-power','首が細く胴が太いミックス犬で、サイズ調整できることが必須条件だったが、ぴったり合わせられ、服を着た時と脱いだ時でも調整できる体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208747_10001359/1.1/','rakuten','208747_10001359:20220317:1d48af0c:901f27736d'),
('julius-k9-idc-power','引っ張りがひどく喉をゼイゼイ鳴らしていた10か月の柴犬で、着けやすく、リードの引きもほとんど感じなくなり、犬も楽そうに歩くようになった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208747_10001359/1.1/','rakuten','208747_10001359:20210616:4936c0bb:0eeaec9479'),
('julius-k9-idc-power','冬毛で首回りが苦しいのか首輪で咳き込むようになったため替えたところ、散歩中の咳はなくなったが、まだ慣れず着けたがらないという体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208747_10001359/2.1/','rakuten','208747_10001359:20181126:482b8f69:05727d17ff'),
('julius-k9-idc-power','毛量が多くサイズ表や参考犬種どおりでは合いにくい12kgの日本スピッツで、価格は高いがようやく安心して使えるものが見つかったと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208747_10001359/2.1/','rakuten','208747_10001359:20201103:5251ab77:e0c17bcd30')
)
INSERT OR IGNORE INTO review_sources(review_id,source_type,source_url,source_platform,source_review_id)
SELECT r.id,s.source_type,s.source_url,s.source_platform,s.source_review_id
FROM new_sources s
JOIN reviews r ON r.product_id=s.product_id AND r.summary=s.summary;

WITH new_sources(product_id,summary,source_type,source_url,source_platform,source_review_id) AS (
VALUES
('julius-k9-idc-power','生後5か月・4.4kgのビションプーにMiniMini。一番小さくしても少し大きいが、これからの成長や冬服を考えるとちょうど良いと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208747_10001359/2.1/','rakuten','208747_10001359:20240420:34e14233:60f39deb86'),
('julius-k9-idc-power','顔が細く首輪も抜けやすい、10歳を迎える7.4kgの黒柴で、周りの柴犬と同じサイズにするか迷い、ショップに相談してサイズを決めた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208747_10001359/2.1/','rakuten','208747_10001359:20230614:d875b412:ee5a362513'),
('julius-k9-idc-power','車や人に向かって引くことが多い13kgの小さめのボーダーコリーで、制止しやすくなり、犬もあまり苦しくなさそうな体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208747_10001359/2.1/','rakuten','208747_10001359:20220104:482b8f69:d49e41a420'),
('julius-k9-idc-power','8.3kgのコーギーにMiniMiniを選んだが、胴回りが少しきつく脇が擦れる不安があったためMiniに交換した体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208747_10001359/3.1/','rakuten','208747_10001359:20230616:bdf6e511:b3a0423685'),
('julius-k9-idc-power','10kgと6kgのキャバリアに使い、やんちゃな下の子では4年半ほどでリード金具が付いた布部分が取れてしまったため買い替えた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208747_10001359/3.1/','rakuten','208747_10001359:20171115:bbeeb3d2:1d2603b816'),
('petsafe-easy-walk-deluxe','急に走り出す引っ張りで飼い主が肩と膝を痛めた9か月・30kgのゴールデン。初めてのハーネスで最初は噛んでいたが、散歩に出ると気にせず歩けた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/202898_10088682/1.1/','rakuten','202898_10088682:20260628:482b8f69:9fe77d5bf4'),
('petsafe-easy-walk-deluxe','引っ張りの強い24kgのラブラドールで3本目。他の犬が近づくと引くがそれ以外はゆっくり歩く。外でつないで待たせると首の下のたるみを噛みちぎってしまう体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/202898_10088682/1.1/','rakuten','202898_10088682:20250423:d2a811dc:4d4c404847'),
('petsafe-easy-walk-deluxe','ぐいぐい進んで苦しそうにガハガハ言ったり二足歩行になったりしていたミニピンで、他の犬を見ると引くものの驚くほど引かなくなり、ガハガハもほぼしなくなった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/202898_10088682/1.1/','rakuten','202898_10088682:20240722:7e67d4b9:5dc1d17f73'),
('petsafe-easy-walk-deluxe','人や犬が大好きで、見つけると引っ張る25kgの筋肉質なピットブルにM。少し大きい気もするが問題なく使えている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/202898_10088682/1.1/','rakuten','202898_10088682:20240321:482b8f69:7d4b14082c'),
('petsafe-easy-walk-deluxe','散歩が憂うつになるほど引っ張る1歳・27kgのゴールデン。引くと歩きにくいようで効果はあったが、胸のベルトを気にして噛み、2回で切れてしまい使用を断念した体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/202898_10088682/2.1/','rakuten','202898_10088682:20220927:d75c81f9:2732bc9293'),
('petsafe-easy-walk-deluxe','普段は横を歩くが1歳で時々はじけ、突然引かれて飼い主が転倒・けがをした31kgのレトリバーで、合図に気付きやすくなった。後ずさりで抜けようとすることもある体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/202898_10088682/2.1/','rakuten','202898_10088682:20220606:482b8f69:2f6a6057c0'),
('petsafe-easy-walk-deluxe','引っ張りで何度か転んだこともある35kgのゴールデンで、着けたら全く引っ張らずに歩け、リードを軽く握るだけで済むようになった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/202898_10088682/2.1/','rakuten','202898_10088682:20231116:bab28cc5:9a9e930d88'),
('petsafe-easy-walk-deluxe','散歩が苦行だった25kgのラブラドールで、最初は癖で引いて咳き込んでいたが、最近は引いても咳き込まなくなり、引っ張りはかなり減った体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/202898_10088682/2.1/','rakuten','202898_10088682:20230514:d2a811dc:2531d30920'),
('petsafe-easy-walk-deluxe','車を追いかけ力も強い19kgのボーダーコリーで、最初の数日は歩き方がぎこちなかったが、その後はスムーズに歩けて驚くほど引っ張らなくなった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/202898_10088682/2.1/','rakuten','202898_10088682:20230613:482b8f69:28ef296f08'),
('petsafe-easy-walk-deluxe','6.6kgの犬でSサイズでも少し大きいが、突進しても首が締まらず、首輪だけの時より止めやすいと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/202898_10088682/2.1/','rakuten','202898_10088682:20190530:482b8f69:2df167a859'),
('petsafe-easy-walk-deluxe','11か月・21kgのスタンダードプードルで、ベルトを一番短くしてちょうど良く、引っ張りが2割ほどに減り散歩の疲れが大きく軽減した体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/202898_10088682/2.1/','rakuten','202898_10088682:20231209:bbf5a230:18be091be9'),
('petsafe-easy-walk-deluxe','力が強い5か月のハスキーで、心配になるほど引っ張りが弱くなった。正面のベルトは調整しても歩くうちに戻ってしまうという体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/202898_10088682/2.1/','rakuten','202898_10088682:20230502:482b8f69:7f1c88f728'),
('petsafe-easy-walk-deluxe','細身の18kgの犬にMでもかなり余裕があり、胸のベルトを一番短くしてもだぶつく。引くと体がこちらへ向くので、その時に褒めてトレーニングしている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/202898_10088682/2.1/','rakuten','202898_10088682:20220510:1f15f554:ee660f1df7'),
('petsafe-easy-walk-deluxe','ドッグトレーナーの動画で知り、5.5kgのキャバリアにS。推奨の指の入り具合に合わせようとしても一番小さくして指4本入るほど余った体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/202898_10088682/2.1/','rakuten','202898_10088682:20210922:482b8f69:e2f89f7bd8'),
('petsafe-easy-walk-deluxe','成長途中のゴールデンで少し大きめ。引くと体の向きが変わり前に行かなくなるが、肩や前足の付け根が締まる感じで少し歩きにくそうな体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/202898_10088682/3.1/','rakuten','202898_10088682:20191120:543879f9:145de30846'),
('petsafe-easy-walk-deluxe','10kgのミックスにS。犬が動くので長さ調整は難しく説明書も英語だったが、以前より引っ張りが弱くなった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/202898_10088682/3.1/','rakuten','202898_10088682:20190727:482b8f69:8fb84fa16c'),
('buddy-belt','胴囲33cm・2.6kgのトイプードルで、3.5号は大きくベルトが余って前足に触れるため、3号の方が使いやすかった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/230805_10000712/1.1/','rakuten','230805_10000712:20101213:482b8f69:371827b78f'),
('buddy-belt','12歳のシニア犬のために体に優しいハーネスを探して選んだ、体重2.7kgの犬での体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/230805_10000712/1.1/','rakuten','230805_10000712:20111009:aa623fcc:d6bb86813e'),
('buddy-belt','お下がりで使っていた同じ3号を買い直したが、ベルト穴の位置が少し違い、新しい方がやや大きかったという体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/230805_10000712/1.1/','rakuten','230805_10000712:20200501:482b8f69:5ad2f48621'),
('buddy-belt','子犬の頃から使っている2kgのトイプードルで、布製のように食い込まず、胸がしっかり固定されるのに柔らかい革で負担が少ないと感じている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/230805_10000712/1.1/','rakuten','230805_10000712:20120720:482b8f69:2608592e0c'),
('buddy-belt','体重2.5kg・胴回り32cmで3号。違和感なく歩けた。冬の厚手の服の上から着けることも考えてサイズを選んだ体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/230805_10000712/1.1/','rakuten','230805_10000712:20100805:482b8f69:e3d0c5af7d'),
('buddy-belt','公園で遊んでいる時にほかのハーネスがするっと抜けてしまい、毛への当たりを心配して避けていたこのハーネスを使い始めたロングコートチワワの体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/230805_10000712/1.1/','rakuten','230805_10000712:20090709:376d8be4:6a532def67'),
('buddy-belt','2kg弱のトイプードルで、最初は固まったがすぐ歩き回るようになり、小型犬には見た目がごつくても犬は気にしていない体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/230805_10000712/1.1/','rakuten','230805_10000712:20110530:482b8f69:ec0605e153'),
('buddy-belt','首輪では散歩中にゲホゲホしていた骨格の細い3kgのトイプードルで、3号がぴったり合い、咳をしなくなった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/230805_10000712/2.1/','rakuten','230805_10000712:20201105:bccf13c5:8715539887'),
('buddy-belt','生まれつきの背骨の異常で時々歩けなくなる、服も嫌がる神経質な犬で、少し気にしつつも使えている。ワンタッチの首輪より着脱は手間という体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/230805_10000712/2.1/','rakuten','230805_10000712:20231203:a53978b9:07a54923cd'),
('buddy-belt','普通の首輪では喉の負担が気になっていた、服嫌いの犬で、嫌がらずにあっさり着けさせてくれた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/230805_10000712/3.1/','rakuten','230805_10000712:20140509:b20b0d9c:2a605450fb'),
('buddy-belt','バイクを見ると猛ダッシュする7か月・3kgのヨーキーで、これまでのハーネスは全部脱げてしまったが、これでようやく脱げずに散歩できた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/230805_10000712/3.1/','rakuten','230805_10000712:20210626:c885da58:bb624b3bd0'),
('buddy-belt','2.6kgのトイプードルで3号を選び、脇への当たりが心配なため袖ありのTシャツの上から一番ゆるい穴で着けている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/230805_10000712/3.1/','rakuten','230805_10000712:20180305:e97f08b5:73d8e6645f'),
('buddy-belt','あまり引いていないのにカァッと言うことがあった2kg台のポメラニアン2頭で、首に負担の少ない形として2.5号と3号を選んだ体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/230805_10000712/3.1/','rakuten','230805_10000712:20190724:482b8f69:79fc0ee95a'),
('ruffwear-front-range','喉が弱いのに引っ張り癖があり咳き込みが多い19kgの雑種で、獣医師に胸で支えるタイプを勧められていたが、そういう形はさらに引っ張るのではと迷った末にSを選んだ体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/266503_10000952/4.1/','rakuten','266503_10000952:20210124:482b8f69:89e3b0ec4b'),
('ruffwear-front-range','まだやんちゃで、後ろに下がる時にハーネスが抜けそうで不安だった7か月・10kgのミックスで、丈夫で犬にも良いと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/266503_10000952/4.1/','rakuten','266503_10000952:20200609:ef00f03a:124db0647e'),
('ruffwear-front-range','子犬の頃にハーネスを強く拒否して首輪にしたが、引っ張り癖で苦しそうだった1歳・8kgの柴犬で、XSは抵抗せずに着け、お互い散歩が楽になった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/266503_10000952/4.1/','rakuten','266503_10000952:20230514:553cc983:042d1f280b'),
('ruffwear-front-range','元野犬でとても俊敏な保護犬のため、抜けにくいものとしてJulius-K9と迷ってこれを選び、バックルがスムーズで静かなので怖がらせずに着けられる体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/266503_10000952/4.1/','rakuten','266503_10000952:20220421:a2a93d21:757979568b'),
('ruffwear-front-range','引っ張り癖がありいろいろ試した5.8kgの大きめのトイプードルで、散歩時に服を着せるためXSにし、今までで一番良いが調整は難しいと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/266503_10000952/4.1/','rakuten','266503_10000952:20211024:2a1a52a1:474a0ccd70'),
('ruffwear-front-range','首輪だけで引っ張ってゴホゴホしていた4か月・12kgの甲斐犬にS。初めてで家の中では気にしたが、外に出ると気にしなくなった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/266503_10000952/4.1/','rakuten','266503_10000952:20210128:482b8f69:b90b34e3e6'),
('ruffwear-front-range','いろいろな首輪やハーネスでむせることが多かった気管の弱い6kgの豆柴で、ベルト調整に手間取ったが、説明書どおりに合わせられた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/266503_10000952/4.1/','rakuten','266503_10000952:20210126:482b8f69:166929fb54'),
('ruffwear-front-range','引く力が強い7か月・10kg弱の柴犬にS。頭を入れるタイプは初めてで最初は嫌がったが、着けると散歩に行けると分かって慣れた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/266503_10000952/4.1/','rakuten','266503_10000952:20210119:482b8f69:c846a5cedb'),
('ruffwear-front-range','引っ張り癖があり散歩で必ず一度は咳き込んでいた3歳の黒パグで、このハーネスにしてから咳がなくなった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/266503_10000952/5.1/','rakuten','266503_10000952:20200614:c7592511:498cb5e1a7'),
('ruffwear-front-range','散歩中に何度か抜けてひやひやしたビーグルで、前のものは時間が経つと緩んだが、これはフィット感があり調整部分も安定している体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/266503_10000952/5.1/','rakuten','266503_10000952:20200607:c88adb18:3a6a99d6ce'),
('ruffwear-front-range','何年も使って一度も抜けたことがなく破れやほつれもないハスキーで、汚れやくたびれが出たため買い直した体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/266503_10000952/5.1/','rakuten','266503_10000952:20230421:482b8f69:a82dc2bd87'),
('ruffwear-front-range','細かく調整でき抜けにくそうだが、3.5kgのチワワには少し硬いかもしれないと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/266503_10000952/5.1/','rakuten','266503_10000952:20211016:482b8f69:407914da4c'),
('ruffwear-front-range','成犬としては小さめの6kgのキャバリアにXS。首も胴も一番小さくして少し余裕があるが、散歩中は服を着せるので気にならない体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/266503_10000952/5.1/','rakuten','266503_10000952:20210912:f9890a7b:2584b52830'),
('ruffwear-front-range','頭を入れて脇の2か所を留めるだけなのにしっかり固定され、軽いと感じた16kgの細身の犬の体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/266503_10000952/6.1/','rakuten','266503_10000952:20210314:482b8f69:8e8020e15d'),
('ruffwear-front-range','引っ張る力が強くなりEzyDogのクイックハーネスから替えた8.4kgの黒柴で、前当てが柔らかく支えるので引く力が弱くなった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/266503_10000952/6.1/','rakuten','266503_10000952:20210216:482b8f69:fbaf865d6a'),
('ruffwear-front-range','足を入れるタイプをとても嫌がる6か月・7kgの豆柴で、このタイプはかなり着せやすいが、一部を噛んでしまった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/266503_10000952/6.1/','rakuten','266503_10000952:20210118:482b8f69:0275ece348')
)
INSERT OR IGNORE INTO review_sources(review_id,source_type,source_url,source_platform,source_review_id)
SELECT r.id,s.source_type,s.source_url,s.source_platform,s.source_review_id
FROM new_sources s
JOIN reviews r ON r.product_id=s.product_id AND r.summary=s.summary;

WITH new_sources(product_id,summary,source_type,source_url,source_platform,source_review_id) AS (
VALUES
('ruffwear-front-range','犬も人も大好きで元気な1歳・10kgの大きめのビションで、旧型が小さくなり買い替えた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/266503_10000952/6.1/','rakuten','266503_10000952:20201017:618e1159:7d4c6b6e33'),
('ruffwear-front-range','胸囲50cm・8kgの犬に服の上からも着けられると思ってXSを選んだが、胸囲を最大にしてもぱつぱつで苦しそうに固まり、服の上からはとても無理だった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/266503_10000952/6.1/','rakuten','266503_10000952:20240203:482b8f69:b84e57d241'),
('puppia-soft-vest','7kgのトイプードルにXL。腕を通す部分が広いためか、マジックテープをしっかり締めても脱げてしまい、散歩中に脱走して焦った体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/230805_10000752/4.1/','rakuten','230805_10000752:20260703:482b8f69:f033e927af'),
('puppia-soft-vest','前のハーネスが散歩中にすぽっと抜けて怖い思いをした2.7kgのマルチーズにM。ぴったりで、Lでも行けたかもしれない体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/230805_10000752/4.1/','rakuten','230805_10000752:20260620:e8e09e96:c71fa534e2'),
('puppia-soft-vest','服を嫌がる2.5kgのチワプーにS。サイズがぴったりで、初めてでも抵抗なく着けてくれた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/230805_10000752/4.1/','rakuten','230805_10000752:20260620:482b8f69:1d38c8e838'),
('puppia-soft-vest','5kgのミニチュアダックスにLは一回り大きかったが、冬の厚めの服の上ならちょうど良さそうで、ホールド感も良い体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/230805_10000752/4.1/','rakuten','230805_10000752:20260611:9c645685:f1cf6f094b'),
('puppia-soft-vest','7kgのマルシュナにXLでかなり余裕があったが、大きめのマジックテープで調整でき、気管に負担がかからない点が良い体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/230805_10000752/4.1/','rakuten','230805_10000752:20260525:482b8f69:1b06ba32f1'),
('puppia-soft-vest','引っ張りや急な走り出しが多く、ゼロゼロ・ヒューヒューという苦しい息遣いが心配だった3.6kgのトイプードルで、その息遣いがなくなった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/230805_10000752/4.1/','rakuten','230805_10000752:20260516:d2fba821:6257205098'),
('puppia-soft-vest','帰りたくないと首に力を入れると前のものは脱げそうになっていた10歳のビーグルで、その点は安心だが、まだ着けるのに慣れていない体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/230805_10000752/4.1/','rakuten','230805_10000752:20260425:482b8f69:62efa98f7d'),
('puppia-soft-vest','4.6kgのトイプードルで、Mは少しぱつぱつ、Lはかなりぶかぶか。抜けることはなく縁に少し毛玉ができる程度で、中間のサイズが欲しいと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/230805_10000752/6.1/','rakuten','230805_10000752:20251124:482b8f69:6e73d7a35f'),
('puppia-soft-vest','10kgの柴犬にXXL。気持ち緩いが、装着を嫌がらず問題なく使えている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/230805_10000752/6.1/','rakuten','230805_10000752:20251103:482b8f69:36919948b2'),
('puppia-soft-vest','3.7〜3.8kgのカニンヘンダックスにM。服を着なければジャストサイズで、嫌がってバックしても抜けることはなさそうな体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/230805_10000752/8.1/','rakuten','230805_10000752:20251009:482b8f69:8ae885b605'),
('puppia-soft-vest','6か月・8kgのむちむちしたパグで、毛が抜けやすいので毛色に合わせた色を選び、成長を考えてXLにした体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/230805_10000752/6.1/','rakuten','230805_10000752:20250911:482b8f69:bcb2b27f80'),
('puppia-soft-vest','避妊手術後に少し太り前のものが入らなくなった2.8kgの老犬のチワワにM。長くは歩けなくなった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/230805_10000752/6.1/','rakuten','230805_10000752:20241206:3254c54a:3217c4ddee'),
('puppia-soft-vest','首の負担を減らすため初めてハーネスにした7kgのトイプードルにXL。少し余裕があるので、抜けた時に備えて首輪と2本のリードで使う予定の体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/230805_10000752/6.1/','rakuten','230805_10000752:20250617:538513ae:18c8cc895b'),
('puppia-soft-vest','1歳のキャバリアに使ってきて、着脱が楽でクッション性もある。もう1頭のキャバリアに3XLを選んだら大きすぎた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/230805_10000752/6.1/','rakuten','230805_10000752:20250612:867764fd:4ebb615790'),
('puppia-soft-vest','後ろ足が弱った3.8kgの老犬のパピヨンで、前足を通すだけなので簡単に着けられ、背中のマジックテープで体重の増減にも合わせられる体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/230805_10000752/6.1/','rakuten','230805_10000752:20250624:e325436b:f8fb7b65b2'),
('puppia-soft-vest','約15kgの柴犬にXXLを愛用しており、柔らかく着けやすく嫌がらない。最初のものが2年ほどでぼろぼろになり買い替えた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/230805_10000752/6.1/','rakuten','230805_10000752:20250607:482b8f69:8d549672f6'),
('puppia-soft-vest','首輪から替えた3kgのトイプードルにMがジャストサイズで、脇にも当たらなそうで、初日から機嫌よく散歩できた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/230805_10000752/6.1/','rakuten','230805_10000752:20250421:482b8f69:caaeab0852'),
('curli-vest-air-mesh','体格のしっかりした7kgのジャックラッセルにMがぴったり。ぴったりのサイズだと緩みがなくすっぽ抜けもほとんどなく、動きも妨げないのでドッグランでも着けている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000879/3.1/','rakuten','212247_10000879:20230516:482b8f69:7c133cda4f'),
('curli-vest-air-mesh','旧モデルを2年使いマジックテープが弱くなった7kgのシュナウザーで、新しいものは少し小さめだが、旧型では首が大きかったのでかえってジャストサイズになった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000879/4.1/','rakuten','212247_10000879:20230413:482b8f69:e14ec7f5ed'),
('curli-vest-air-mesh','4.3kgのトイプードルにSがぴったり。体に直接当たる金具がなく、着け心地が良さそうな体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000879/4.1/','rakuten','212247_10000879:20221008:482b8f69:d47a549664'),
('curli-vest-air-mesh','冬の厚手の服を考えて5kgのトイプードルのSをMに交換。装着が簡単で前足の付け根にも当たらない体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000879/4.1/','rakuten','212247_10000879:20220703:482b8f69:f493bf1546'),
('curli-vest-air-mesh','散歩中にぐいぐい引くため、ひもタイプでは食い込みが心配だった4〜5kgのミックスで、軽くひもが食い込むこともない体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000879/4.1/','rakuten','212247_10000879:20220515:278cc6c3:9bb67bf6ad'),
('curli-vest-air-mesh','2.8kgのチワワに2XSを選んだら服なしでもきつめで、XSに交換して少し余裕ができた。リードの留め具がプラスチックで軽いのも助かる体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000879/4.1/','rakuten','212247_10000879:20240612:482b8f69:9418284112'),
('curli-vest-air-mesh','合うハーネスがなかなか見つからないイタグレで、柔らかくしっかりしたマジックテープで調整できるため2頭目にも買った体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000879/4.1/','rakuten','212247_10000879:20231118:482b8f69:15e4ccc09f'),
('curli-vest-air-mesh','胴回り50cm・7.7kgのトイプードルで、2年使ったMが古くなりLに上げて問題なかった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000879/4.1/','rakuten','212247_10000879:20230720:482b8f69:6251f67321'),
('curli-vest-air-mesh','よく走る胸囲37cm・3.3kgのトイプードルにS。抜けない程度に余裕があり、軽くて動きやすそうな体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000879/4.1/','rakuten','212247_10000879:20230608:482b8f69:c267aed0b0'),
('curli-vest-air-mesh','4.7kgのペキニーズにXSがジャストサイズ。マジックテープとバックルでしっかり留まり、着脱も簡単な体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000879/5.1/','rakuten','212247_10000879:20220617:df77ee5a:e76e6250d8'),
('curli-vest-air-mesh','改良版はさらに軽く着脱も簡単になったと感じた3.2kgのトイプードルで、XSがぴったりな体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000879/5.1/','rakuten','212247_10000879:20220607:482b8f69:816f710e92'),
('curli-vest-air-mesh','6.5kgのチワワとシーズーのミックスにL。とても軽く、前のハーネスより動きやすそうな体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000879/5.1/','rakuten','212247_10000879:20220521:482b8f69:ba014fed22'),
('curli-vest-air-mesh','3.5kgのチワワに合っていたが、ロゴ部分をかじって飲み込んでしまい壊れたという体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000879/5.1/','rakuten','212247_10000879:20250530:7051831c:cbd5aa1fe2'),
('curli-vest-air-mesh','16歳近い痩せた豆柴に負担の少ないものとして選び、柔らかく一日中着けていても良かったが、3か月でリング一体型の部品が壊れたという体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000879/5.1/','rakuten','212247_10000879:20220610:e5466f4f:3aee38e8d7'),
('hakusan-zero-harness','10kgのウィペットにS。首回りはやや緩いが胴でしっかり合い抜けない。前のハーネスでは気道が締まるのかガハッとしていたが、苦しそうでなくなった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000685/4.1/','rakuten','212247_10000685:20240714:482b8f69:d2730c9ce7'),
('hakusan-zero-harness','おしゃれ重視のハーネスから散歩中に前足が抜けたことがある4.3kgのビションで、着け心地重視で信頼できるものとして選んだ体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000685/4.1/','rakuten','212247_10000685:20231213:b8e004d6:70ce1d70d4'),
('hakusan-zero-harness','引っ張り癖があり気管を圧迫しないハーネスを使っていたら前足の脇が擦れて毛が抜けた12kgのフレブルで、バックルが脇に当たらず擦れの心配がない体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000685/4.1/','rakuten','212247_10000685:20220214:929d4db4:2361c8315c'),
('hakusan-zero-harness','首回りも胴回りも調整でき、胴のベルトが前足の脇に引っかからない位置にあるため、ほかのハーネスをほとんど使わなくなった5kgの犬の体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000685/4.1/','rakuten','212247_10000685:20210115:482b8f69:fc9b5503e8'),
('hakusan-zero-harness','3.1kgのポメラニアンにXXSがちょうど良かった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000685/4.1/','rakuten','212247_10000685:20240101:482b8f69:9152e7297b'),
('hakusan-zero-harness','首と胴に通すタイプで擦れてお腹の毛が抜けていたダックスで、小型犬にはごつく見えるが、肌に当たる部分にクッション性があり負担が少なそうな体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000685/4.1/','rakuten','212247_10000685:20211012:669ba8f9:92cd8dcea3'),
('hakusan-zero-harness','43kgと42kgのゴールデン2頭にXL。届いた時はぴちぴちに見えたが、助言どおりきちんと合わせたら合った体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000685/4.1/','rakuten','212247_10000685:20200508:482b8f69:7c75281c8e'),
('hakusan-zero-harness','いろいろなメーカーを試してきたが、首も胴も調整でき、柔らかいのにホールド感があり、見た目もごつすぎず理想的だと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000685/4.1/','rakuten','212247_10000685:20191126:894b4d77:1aefe2b055'),
('hakusan-zero-harness','首回り35cm・胸囲60cm・15.5kgのボーダーコリーにS。普段使うJulius-K9は夏に熱がこもり重そうなので、軽いこちらを使っている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000685/5.1/','rakuten','212247_10000685:20240327:482b8f69:897276e9b4'),
('hakusan-zero-harness','首や体に触れる部分が痛くないY字のものを探していた8kgのチワワミックスにS。少しゆとりがあるがちょうど良かった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000685/5.1/','rakuten','212247_10000685:20230801:c8c17069:7f1cf49dd6'),
('hakusan-zero-harness','5.5kgのキャバリアにXXSがジャスト。持ち手はないが上部をつかんで持ち上げられ、小さいサイズでは持ち手がテープで留まっているJulius-K9より緊急時に対応しやすいと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000685/5.1/','rakuten','212247_10000685:20220619:482b8f69:0cde17179e'),
('hakusan-zero-harness','足から入れるタイプを2年使い毎回着けにくかった9kgと7.5kgのシュナウザー2頭で、着けやすくしっかりしたものに替えた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000685/5.1/','rakuten','212247_10000685:20240306:5f864a2c:bbdf986637'),
('hakusan-zero-harness','シニアに近づき首への負担を減らしたくてY型を探した胴回り58cm・11kgの犬にS。初めてのハーネスでどのくらいのフィット感にすべきか迷った体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000685/5.1/','rakuten','212247_10000685:20211218:482b8f69:1b86812537'),
('hakusan-zero-harness','服もハーネスも初めての8か月のキャバリアに、胴回りに合わせて一番小さくしてぴったり。見た目より軽く柔らかい体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000685/5.1/','rakuten','212247_10000685:20201116:d4c277b7:0fde9f17d5'),
('hakusan-zero-harness','首の後ろにリードを付けるタイプだとリードを噛んでしまう5.6kgのシュナウザーで、腰の金具にリードを付けられるのが良い体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000685/5.1/','rakuten','212247_10000685:20200507:482b8f69:3b9cc45579'),
('hakusan-zero-harness','時々怖がって動揺する13kgの中型犬で、以前も同じ形を使っていたが、クッション性と持ち手がある点でこれを選んだ体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212247_10000685/6.1/','rakuten','212247_10000685:20230207:482b8f69:920e55d0b6'),
('petsafe-easy-walk','嘘のように引っ張らなくなり、猫を見て弾丸のように走り出した時も制御できた。胸のベルトをぴったり締めないとハーネス自体が脱げそうになる体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/284187_10031274/1.1/','rakuten','284187_10031274:20220813:da8a417a:de4aaf5859')
)
INSERT OR IGNORE INTO review_sources(review_id,source_type,source_url,source_platform,source_review_id)
SELECT r.id,s.source_type,s.source_url,s.source_platform,s.source_review_id
FROM new_sources s
JOIN reviews r ON r.product_id=s.product_id AND r.summary=s.summary;

WITH new_sources(product_id,summary,source_type,source_url,source_platform,source_review_id) AS (
VALUES
('petsafe-easy-walk','トレーナーに勧められて3本目。今は引っ張り癖はないが、何より抜ける心配がないので使い続けている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/284187_10031274/2.1/','rakuten','284187_10031274:20210724:72b5b76c:c230d0a5e9'),
('petsafe-easy-walk','SNSで知って使い始め、最初は違和感があり飼い主もリードの扱いに慣れるまで時間がかかったが、慣れると快適に散歩できた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/284187_10031274/2.1/','rakuten','284187_10031274:20210606:482b8f69:c278b9656e'),
('petsafe-easy-walk','もともとぐいぐい引くわけではない1歳のゴールデンドゥードルが、飼い主の速さに合わせて歩くようになった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/284187_10031274/2.1/','rakuten','284187_10031274:20201016:a56a5d77:1036dcfcaa'),
('petsafe-easy-walk','手にまめができるほど引っ張っていたがだいぶ軽減した。使ううちに少し緩むのでこまめに確認している体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/284187_10031274/2.1/','rakuten','284187_10031274:20200715:482b8f69:158008bc4f'),
('petsafe-easy-walk','獣医師に勧められて使い始め、しつけができていないと感じていた飼い主でも、前へぐいぐい引っ張られることがなくなった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/284187_10031274/2.1/','rakuten','284187_10031274:20200425:f74aa54b:daa3a16a48'),
('petsafe-easy-walk','引っ張る40kgのラブラドールで、使っていたものがぼろぼろになり買い直した。引っ張ることが減り、ハーネスを手にすると散歩だと寄ってくる体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/284187_10031274/2.1/','rakuten','284187_10031274:20200212:482b8f69:78f11954d0'),
('petsafe-easy-walk','21kgのメスのラブラドールにピンクのM。引っ張り防止にはこれが一番だと感じている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/284187_10031274/3.1/','rakuten','284187_10031274:20190930:482b8f69:eec050122f'),
('petsafe-easy-walk','いつもより引っ張りが弱くゆっくり歩いてくれたが、一度だけお腹側のひもから前足が抜けたことがあった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/284187_10031274/3.1/','rakuten','284187_10031274:20190615:482b8f69:db02188f45'),
('petsafe-easy-walk','ハーフチョークから替えた25kgのゴールデンで、首が締まらないので安心でき、引かれても前より力が要らない体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/284187_10031274/3.1/','rakuten','284187_10031274:20190521:83fef5a6:bb13b7f0c8'),
('petsafe-easy-walk','散歩が大変だった5か月のラブラドールで、歩きにくそうで少し申し訳ない気もするが、小学生の女の子でも余裕で散歩できるようになった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/284187_10031274/3.1/','rakuten','284187_10031274:20190503:3af10af9:ca3aa55f1b'),
('petsafe-easy-walk','とても怖がりで、ものすごい勢いで引っ張り肉球や爪から出血するほどだった40kgのゴールデンにXL。少し引き戻すだけで前に出られず、片手で抑えられるようになった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/284187_10031274/3.1/','rakuten','284187_10031274:20190330:482b8f69:286eeb175e'),
('petsafe-easy-walk','ジェントルリーダーを嫌がって散歩にならなかった多頭飼いの1頭に使い、首輪より引っ張らなくなったが、全く引かなくなるわけではない体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/284187_10031274/3.1/','rakuten','284187_10031274:20180927:bd927d37:8a2c3e20f0'),
('petsafe-easy-walk','それほど引っ張らない犬で、前のハーネスが小さくなり購入したが、届いて使った日にちぎれたという体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/284187_10031274/3.1/','rakuten','284187_10031274:20250823:6ef822fd:f3c99f7eb9'),
('petsafe-easy-walk','家に近づくと強く引く5kgのポメプーで、付け方をいろいろ試したが嫌がって暴れ、すぐに外れてしまい合わなかった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/284187_10031274/3.1/','rakuten','284187_10031274:20230829:482b8f69:42fa25efd4'),
('moncheri-harness','1.7kgの小柄なチワワで、首・胴・胸元の3か所を調整でき、胸元以外はまだ余裕があり服の有無どちらでも使えそうな体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/406105_10001780/1.1/','rakuten','406105_10001780:20260405:482b8f69:5e069b9815'),
('moncheri-harness','調整できる箇所が多いが、3kgの子犬にはまだ大きく、成長してから使う予定の体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/406105_10001780/1.1/','rakuten','406105_10001780:20260623:cdbc87bd:523d793682'),
('moncheri-harness','1.8kgのトイプードルにSを短めに調整してちょうど良く、抜けにくそうで安心できる体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/406105_10001780/1.1/','rakuten','406105_10001780:20260908:482b8f69:e0f2359eba'),
('moncheri-harness','引っ張りの強い2.3kgのポメラニアンで、ほぼ毎日使って一度も抜けておらず、気になっていた重さもそれほど感じない体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/406105_10001780/2.1/','rakuten','406105_10001780:20260521:482b8f69:d80070b473'),
('moncheri-harness','2.5kgのトイプードルで、Sを服の上から付けるときつくなってきたためMに替えてちょうど良かった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/406105_10001780/2.1/','rakuten','406105_10001780:20260326:bf74b9da:4f2ca624be'),
('moncheri-harness','引っ張り癖や急に止まる癖があり抜けそうだったチワワ2頭に使い、抜けそうな感じがなく安心な体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/406105_10001780/2.1/','rakuten','406105_10001780:20260311:65d7a845:64041b3aba'),
('moncheri-harness','毛量のある2.7kgの子犬にSは少し小さく、Mに交換した体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/406105_10001780/2.1/','rakuten','406105_10001780:20260109:482b8f69:9109f46cb5'),
('moncheri-harness','3.1kgのポメラニアンにMで使え、嫌がる子なので着けにくいのが難点という体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/406105_10001780/2.1/','rakuten','406105_10001780:20251228:482b8f69:fd7b93d011'),
('moncheri-harness','採寸して明らかにSだった2.5kg弱の犬で、思ったよりゆとりがなく、薄手のTシャツや裸ならちょうど良いがMでも良かったかもしれない体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/406105_10001780/3.1/','rakuten','406105_10001780:20250419:29e6d577:cfc01d3f41'),
('moncheri-harness','引っ張りが気になっていた3kgと2.3kgのチワワで、冬に服を着るためMにし、服なしだと小さい方は少し大きい体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/406105_10001780/3.1/','rakuten','406105_10001780:20241129:3cae96b6:f9496c5d0d'),
('moncheri-harness','以前ハーネスが抜けて焦ったことがある2.6kgのチワワで、試着では抜ける恐れはなさそうだった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/406105_10001780/3.1/','rakuten','406105_10001780:20250508:234dc396:1cfe224f6f'),
('moncheri-harness','散歩デビュー前に慣らすため3か月・1kgのチワプーに用意し、お腹の下を通るひもは一番短くしても少し長かった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/406105_10001780/3.1/','rakuten','406105_10001780:20250131:5c7cebcb:245192bd92'),
('moncheri-harness','締め付けを嫌がりハーネスが苦手な3.7kgのポメラニアンで、散歩中はずっと楽しそうで、調整幅もあり長く使えそうな体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/406105_10001780/3.1/','rakuten','406105_10001780:20250125:cdc2c1a5:fbc44af515'),
('laluca-wear-harness','2.8kgのトイプードルにSがぴったりだったが、金具部分がもう少し長いと頭を入れる時にきつくないと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/395228_10000031/1.1/','rakuten','395228_10000031:20260227:c333e14a:9cc22a33d8'),
('laluca-wear-harness','5か月のチワワにXS。今は着けられるが、まだ大きくなりそうなので成長しきったらSを買う予定の体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/395228_10000031/2.1/','rakuten','395228_10000031:20251024:482b8f69:f6f9369aac'),
('laluca-wear-harness','寒がりで冬はもこもこのコートを着る2.6kgのトイプードルで、サイズを調整できて良かったが、付属のリードは薄いので手持ちのものを使っている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/395228_10000031/2.1/','rakuten','395228_10000031:20241207:482b8f69:4be417c564'),
('laluca-wear-harness','がっしりした3.6kgのトイプードルにS。とても軽く裏がメッシュで夏も涼しそう。厚い服を着ない時はSでちょうど良い体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/395228_10000031/2.1/','rakuten','395228_10000031:20250524:dede59c5:aca30857a2'),
('laluca-wear-harness','5.7kgのシーズーにM。着けるのが楽で生地も柔らかい体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/395228_10000031/2.1/','rakuten','395228_10000031:20250826:0456ec76:adbb39ac64'),
('laluca-wear-harness','使い勝手が良かったのでもう1頭にも購入し、ぽっちゃりした4kgの子はMでは大きくSに交換してぴったりだった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/395228_10000031/2.1/','rakuten','395228_10000031:20250412:50494e1a:a94d6e5db6'),
('laluca-wear-harness','生後2か月の子犬と4kgの母犬のトイプードルにおそろいで使い、サイズは合ったが簡素な作りで安全性が少し不安という体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/395228_10000031/6.1/','rakuten','395228_10000031:20241018:733adf9b:f1a4d9599b'),
('laluca-wear-harness','1.5kgのポメラニアンにXSがちょうど良かったが、背中をマジックテープで留めるタイプの方が使いやすいかもしれないと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/395228_10000031/3.1/','rakuten','395228_10000031:20250927:8a8050af:2722cf9789'),
('laluca-wear-harness','5か月のカニンヘンダックスで、頭を入れて前足を通すだけなので簡単に着けられる体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/395228_10000031/3.1/','rakuten','395228_10000031:20250817:482b8f69:f8c5edb5dd'),
('funcoma-harness-lead','いくつものハーネスがすっぽ抜けて不安だったが、マジックテープと留め具の二重で安心で、足を通さずに着けられる体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/392151_10000004/3.1/','rakuten','392151_10000004:20241002:482b8f69:c90d1b85f1'),
('funcoma-harness-lead','ポメラニアン用に買い、19歳のダックスにも着せたら、2頭とも合った体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/392151_10000004/1.1/','rakuten','392151_10000004:20230108:6df1dd71:49e6d4b908'),
('funcoma-harness-lead','高齢の約3kgのヨーキーにM。しっかりした作りで、軽いのも高齢犬には良い体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/392151_10000004/1.1/','rakuten','392151_10000004:20230911:55c1bb2c:2670ef9478'),
('funcoma-harness-lead','首に比べて胸がしっかりした5.5kgのシュナウザーにXL。他のハーネスでは首がゆるゆるだったが、マジックテープとバックルで調整できた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/392151_10000004/1.1/','rakuten','392151_10000004:20230527:482b8f69:8f4dec7365'),
('funcoma-harness-lead','これで毎日散歩するうちにかなりスリムになったミニチュアダックスで、XLがぶかぶかになり自分で脱いでしまうようになった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/392151_10000004/1.1/','rakuten','392151_10000004:20210909:83f50911:8d76a72b45'),
('funcoma-harness-lead','大きめの7kgのビションにXLがちょうど良かった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/392151_10000004/1.1/','rakuten','392151_10000004:20230321:29ade461:06a80fa993'),
('funcoma-harness-lead','採寸ではMだった5kgのシーズーが試着できつく、Lに交換してもらった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/392151_10000004/2.1/','rakuten','392151_10000004:20240925:b4b18fff:b1b554d777'),
('funcoma-harness-lead','約7kgのウエスティにXLがちょうど良かった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/392151_10000004/3.1/','rakuten','392151_10000004:20240703:482b8f69:5041d63a6c'),
('funcoma-harness-lead','前に買ったものがよれてきて2回目の購入。1.7kgのトイプードルにSがぴったりで、着心地も良いらしい体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/392151_10000004/3.1/','rakuten','392151_10000004:20240326:482b8f69:fd394a343b'),
('ironbaron-honeycomb','寝たきりに近くなり25kgほどまで痩せた13歳のバーニーズで、Mでも中にベストを着て少し大きいくらい、何も着ないとぶかぶかな体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/195679_10000490/1.1/','rakuten','195679_10000490:20260211:482b8f69:c15e1a2af0'),
('ironbaron-honeycomb','足腰が弱りがんの介護も必要になった14歳のマラミュートにM。着せるのに手間取ったが慣れ、着たままでも蒸れにくい体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/195679_10000490/1.1/','rakuten','195679_10000490:20090130:482b8f69:36fe155547'),
('ironbaron-honeycomb','10kgから9kgに痩せて足腰が弱った16歳の老犬にSS。ウエストはだぶだぶで、頭が下がってくるので首に当たるベルトが少し苦しそうな体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/195679_10000490/2.1/','rakuten','195679_10000490:20210108:a9802b65:4409bee385'),
('ironbaron-honeycomb','悪性リンパ腫の闘病中で一人で立てなくなってきた13歳のサモエドで、抱き起こすのが難しくなり使い始め、もっと早く買えば良かったと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/195679_10000490/2.1/','rakuten','195679_10000490:20200528:b9a0f2b9:a266d8fd3f'),
('ironbaron-honeycomb','玄関の段差でつまずき後ろ足を痛めた、胸回り88cm・40kgの骨格の大きい12歳のラブラドールにL。急いで必要だったので翌日に届いて助かった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/195679_10000490/2.1/','rakuten','195679_10000490:20171128:f72efde8:75a49fbf85')
)
INSERT OR IGNORE INTO review_sources(review_id,source_type,source_url,source_platform,source_review_id)
SELECT r.id,s.source_type,s.source_url,s.source_platform,s.source_review_id
FROM new_sources s
JOIN reviews r ON r.product_id=s.product_id AND r.summary=s.summary;

WITH new_sources(product_id,summary,source_type,source_url,source_platform,source_review_id) AS (
VALUES
('ironbaron-honeycomb','自力で立てなくなった25kgのハスキーで、毛を剃っていたためMは少し大きく洗い替えにSを購入。持ち手の位置が良く最後まで立って排泄できた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/195679_10000490/2.1/','rakuten','195679_10000490:20160414:482b8f69:8e2cfc2677'),
('ironbaron-honeycomb','急に動けなくなった8歳・15.5kgの柴犬で、大型犬の情報しかなくサイズに迷い、SSを内側のファスナーで使っている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/195679_10000490/2.1/','rakuten','195679_10000490:20130414:1f6e69a5:d12f835c9d'),
('ironbaron-honeycomb','28kgのラブラドールにSを外側のファスナーでぴったり。34kgあった頃はMがややきつめでぴったりだった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/195679_10000490/2.1/','rakuten','195679_10000490:20120904:f319c9a6:dfd6fb079c'),
('ironbaron-honeycomb','10歳で突然てんかんの発作が起き、投薬で足腰が立たなくなった21kgの細身のメスで、毎日の介護で飼い主の足腰も限界になり急いで購入した体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/195679_10000490/3.1/','rakuten','195679_10000490:20110609:45121a32:4c7e4589e4'),
('ironbaron-honeycomb','肩回りに大きな脂肪腫があり、ヘルニアで左脚が完全にナックリングしている15歳・24kgのラブラドールで、発送前にサイズ確認の電話をもらえた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/195679_10000490/3.1/','rakuten','195679_10000490:20110517:482b8f69:211a04c8b6'),
('ironbaron-honeycomb','後ろ脚が弱くなった14歳・35kgのラブラドールにMを外側のファスナーで使い、階段の上り下りが目に見えて楽になった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/195679_10000490/3.1/','rakuten','195679_10000490:20110220:482b8f69:0105cf301b'),
('dogcopenhagen-comfort-walk-pro','同ブランドの別シリーズの洗い替えとして購入した15kgの犬で、生地も作りもとても頑丈だが、胴回りはぎりぎりだった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?store_id=glv&page_key=dog-93','yahoo','9c37598c-ee10-4557-a0d0-7986194e292b'),
('dogcopenhagen-comfort-walk-pro','頭が小さく胸板が厚いのに幅が薄く、たいていのハーネスがするりと抜けるアフガン・ハウンドで、チェーンの首輪で首を痛めたこともあったが、安定して歩けて抜けなくなった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?store_id=glv&page_key=dog-93','yahoo','b58eb7a8-dbdf-46bc-acf6-e73317f5a4f5'),
('dogcopenhagen-comfort-walk-pro','人や外が怖く、外に出るとパニックになって常に逃げる体勢で引きも強い11.5kgの犬で、2年で6個買った末にようやく満足できるハーネスに出会えた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?store_id=glv&page_key=dog-93','yahoo','49ffb3f3-66b7-4512-bb56-5fc3f3c6d03d'),
('dogcopenhagen-comfort-walk-pro','Julius-K9では引っ張りが強く首が締まってゼーゼーしていた細身の12kgのコーギーで、前側にリードを付けると引っ張りが減り、背中の持ち手でドッグランでも安心な体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?store_id=glv&page_key=dog-93','yahoo','38873429-aca9-43cd-bb6c-d8310b251a7f'),
('dogcopenhagen-comfort-walk-pro','肌が弱くイージーウォークでは当たる所が赤くなった1歳・16kgのミニブルで、引っ張り抑制はイージーウォークの方が強いが、皮膚への負担が軽くバックルの装着も楽な体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?store_id=glv&page_key=dog-93','yahoo','77b5f72f-12d6-476e-9351-91fc82fee3f2'),
('dogcopenhagen-comfort-walk-pro','ハーフチョークを使っていたがシニアになり逆くしゃみをするようになったため、気管に負担の少ないものとして選んだ30kgの犬で、Lでかつかつだが抜けないことを考えればぴったりな体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?store_id=glv&page_key=dog-93','yahoo','839c4929-2b49-420f-a340-e10b78ab34ab'),
('dogcopenhagen-comfort-walk-pro','体重22kgの若いブルドッグにL。届いた時はきついかと思ったが、アジャスターで調整して問題なく使えている体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?store_id=glv&page_key=dog-93','yahoo','c776fe6b-f7d2-4ec9-8c00-a38587996a0a'),
('dogcopenhagen-comfort-walk-pro','Julius-K9、Curli、Hurttaと使ってきた10kgのシェルティで、Hurttaは背中下部のよれが気になり、今回は良さそうだと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?store_id=glv&page_key=dog-93','yahoo','73ed1d92-6c06-453b-bcca-7b7f6188aca6'),
('dogcopenhagen-comfort-walk-pro','45kgのがっちりしたバーニーズで、採寸してLを選んだが思ったより小さくXLに交換した体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?store_id=glv&page_key=dog-93','yahoo','9362979e-a1fd-47ba-998d-b95aeba4afa1'),
('dogcopenhagen-comfort-walk-pro','体重40kgのミックスにXLを調整ベルト最小でちょうど良く使っている体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?store_id=glv&page_key=dog-93','yahoo','a2e06df4-4dea-490b-871b-6bddcee2d845'),
('dogcopenhagen-comfort-walk-pro','17kgの大きめのシェルティにM。フロント部分にもフックがあり、引っ張る子に向いていると感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?store_id=glv&page_key=dog-93','yahoo','9f8dac6e-0f08-4367-9fcc-b706589c836d'),
('dogcopenhagen-comfort-walk-pro','28kgのゴールデンにLがぴったりで、4か所で調整できる点が良い体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?store_id=glv&page_key=dog-93','yahoo','7e9fe355-a987-4588-8257-79078213af19'),
('dogcopenhagen-comfort-walk-pro','ドッグトレーナーに勧められて選び、首から胴まで一体化していて抜けず、引きの強い大型犬には前のリングにリードを付けるのがおすすめだと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?store_id=murol&page_key=154220242-M','yahoo','8db7a826-cf4b-425f-878d-7bbe4018a103'),
('dogcopenhagen-comfort-walk-pro','イージーウォークで脇が擦れて炎症を起こし、引っ張りで首も苦しそうだった犬で、胸の部分が広く体全体を包み込むので苦しくなさそうな体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?store_id=murol&page_key=154220242-M','yahoo','73dbcff3-9abb-4d7c-9bc7-c382afc08bfd'),
('dogcopenhagen-comfort-walk-pro','体にフィットして安定し強度もあり、ドッグランで捕まえる時に合皮で覆われた持ち手がつかみやすい柴犬の体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?store_id=murol&page_key=154220242-M','yahoo','1f0fe318-dd75-4ace-b50b-615ef1791e87'),
('dogcopenhagen-comfort-walk-pro','25kgの黒ラブでLが品切れのためMを選び、調整して収まったが、首回りの調整にバックルがないので余裕を持たせる必要があった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?store_id=murol&page_key=154220242-M','yahoo','bfe79056-d3c8-4e48-bfc6-4faca0c3f8d5'),
('dogcopenhagen-comfort-walk-pro','10か月のボーダーコリーで、1日2回2〜3時間使って2か月たってもほつれやへたりがなく、首への負担も軽くなった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?store_id=murol&page_key=154220242-M','yahoo','e5868a93-28c8-40d9-ab20-0ca9c650a04c'),
('dogcopenhagen-comfort-walk-pro','前のハーネスで脇の下が擦れて嫌がっていた27kgのラブラドールにL。これは不快ではなさそうな体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?store_id=murol&page_key=154220242-M','yahoo','5fec922e-6e45-4fab-a849-799fcfbca3e0'),
('dogcopenhagen-comfort-walk-pro','皮膚が弱く脇が擦れないことを条件に探した15kgのフレブルで、首と胸はクッションが効き、胴の留め具が脇から少し離れているので擦れない体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?store_id=murol&page_key=154220242-M','yahoo','2cff525a-8c0c-46e0-acfe-1e57f0137f59'),
('dogcopenhagen-comfort-walk-pro','コーギーと甲斐犬ミックスに使い、胸の辺りが広く体をしっかり包み、軽くて擦れたり当たったりする場所も見当たらない体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?store_id=murol&page_key=154220242-M','yahoo','d3c6ad9e-1546-48ff-a9cc-e24135e8e48a'),
('dogcopenhagen-comfort-walk-pro','18kgの紀州犬にぴったりで、真っ白な犬にブルーがよく似合った体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?store_id=murol&page_key=154220242-M','yahoo','101f1479-158e-4672-a8e1-bada2c188bd7'),
('dogcopenhagen-comfort-walk-air','首回り35cm・胸囲53cm・10kgでSとMの境目に迷いSを最大にしてぴったり。がっちりホールドされ、引っ張り癖があっても抜けない体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?store_id=starry&page_key=dog8-002-200923','yahoo','147912f0-28af-4942-8199-ca52fcf32e69'),
('dogcopenhagen-comfort-walk-air','メガネ形のハーネスで脇が擦れていた胴囲43cmの犬で、服も考えてSに。メガネ形よりがっちりして抜ける心配がないが、慣れるまで着脱に少し手間取る体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?store_id=starry&page_key=dog8-002-200923','yahoo','f52cde61-2e59-41f1-8774-9b41f9abbf3b'),
('dogcopenhagen-comfort-walk-air','暑がりのため使っていたラフウェアは体を覆う面積と硬さが気になり、こちらに替えて3本目になったパグの体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?store_id=starry&page_key=dog8-002-200923','yahoo','fe5018f0-90a5-4bfc-99b4-636ddbcbd6df'),
('dogcopenhagen-comfort-walk-air','頭を通すタイプを嫌がり毎回着けるのが大変だった胴回り54cm・10kgの柴犬で、首回りにバックルがあるのですんなり着けられ、散歩の準備が短くなった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?store_id=starry&page_key=dog8-002-200923','yahoo','b87237cb-ac08-42e0-89d2-14edc2061d62'),
('dogcopenhagen-comfort-walk-air','胸周り42cm・5.5kgのジャックラッセルにXSがぴったり。薄手の服なら大丈夫だが、厚手の服ならSが良さそうな体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?store_id=starry&page_key=dog8-002-200923','yahoo','ff4a40bd-0c8c-494b-9fdc-b962f6e483d7'),
('dogcopenhagen-comfort-walk-air','長毛の10kgの犬にSでまだ余裕があり、少し毛玉になるがハーネスなら仕方ないと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?store_id=starry&page_key=dog8-002-200923','yahoo','a3969569-f52b-4672-8a89-437644acf33a'),
('dogcopenhagen-comfort-walk-air','引っ張りが強い8kgのイングリッシュ・コッカーにS。着けて散歩するとあまり引っ張らなくなった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?store_id=starry&page_key=dog8-002-200923','yahoo','bb813d71-6b06-4224-ad27-c966174126c8'),
('dogcopenhagen-comfort-walk-air','生後半年のボーダーコリーにMを買ったがまだ大きく、色違いでSを追加した体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?store_id=starry&page_key=dog8-002-200923','yahoo','36ef550b-67e5-4828-b3fe-5497beb00c30'),
('dogcopenhagen-comfort-walk-air','引っ張り防止にはわりと効果がありそうで安心感はあるが、少し重く夏は暑いかもしれないと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?store_id=starry&page_key=dog8-002-200923','yahoo','cafe17d6-fda5-4f1c-81aa-08573e10bd56'),
('dogcopenhagen-comfort-walk-air','アジャスターが4か所ある点で選び、首回り30cm・胴回り46cm・7.4kgのシュナウザーにSがぴったりだった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?store_id=goodslabo&page_key=dch-walkair-s','yahoo','d0d8520d-50df-47fc-ac40-a7e50c607ae3'),
('hakusan-zero4-harness','帰りたくなると引っ張り、喉がヒューヒュー鳴るのが悩みだったが、このハーネスではならなくなった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?store_id=1stdogcafe&page_key=10000913','yahoo','8ef46f83-4799-40c2-adae-c0f7df08180b'),
('hakusan-zero4-harness','別ブランドのハーネスを参考にMを選んだら窮屈で、XLに交換。少し余裕はあるが脱げず、クッションもふかふかで負担がかからなそうな体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?store_id=1stdogcafe&page_key=10000913','yahoo','685a7216-559e-468c-aaa8-06fde35e9b63'),
('hakusan-zero4-harness','気管に負担がかかりにくいものとして選んだ5kgの小型のミックスで、咳き込みは減ったが、首から腹側の調整が難しくがばがばで、小型犬には身幅が大きいかもしれないと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?store_id=1stdogcafe&page_key=10000913','yahoo','af2cbaa3-ec5e-467b-8d46-66d2b8cc8b13'),
('hakusan-zero4-harness','胴回りが太い38kgの犬にXLで余裕があるが、首回りは細いのでもう少し詰められると良かった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?store_id=1stdogcafe&page_key=10000913','yahoo','450f8426-56cb-46ba-b5ac-ff941493d5ff'),
('anisapo-harest','前のハーネスで前に進まれるたびにゼェゼェし、水を飲む時もむせることが増えた11kgの柴犬で、コントロールしやすくなったが、歩くたびに首側がぱかぱかする体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/352568_10020523/1.1/','rakuten','352568_10020523:20230720:482b8f69:7d201c4910'),
('anisapo-harest','15歳半で気管虚脱のグレード3と診断され、首輪からハーネスへの変更を勧められた13kgの柴犬で、首輪の時のゲホゲホがこのハーネスでは出なかった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/352568_10020523/1.1/','rakuten','352568_10020523:20220729:04538f77:bd9d5fedf5'),
('ironbaron-honeycomb','16歳近くなり立ち上がりや歩行に介助が必要になった犬で、中腰で胴を持ち上げる負担を減らすために購入し、4か月使った体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/195679_10000490/1.1/','rakuten','195679_10000490:20171219:1dbb5cc0:00e7420714'),
('ironbaron-honeycomb','平均寿命を越えようとする高齢のブルマスチフが自力で立ち上がれなくなり、評判を調べてこの介助用ハーネスを選んだ体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/195679_10000490/1.1/','rakuten','195679_10000490:20141130:482b8f69:593f7b1747'),
('ironbaron-honeycomb','13歳で足腰が弱ったシェパードに、胴の最も太い部分を測って購入。胴はきつく寝る時は少し緩めるが、介助はとても楽になった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/195679_10000490/1.1/','rakuten','195679_10000490:20080427:747e7125:00700ee512'),
('ironbaron-honeycomb','もともと後ろ足が弱っていた大型の老犬が、急に前足にも力が入らず立てなくなったため購入し、ふらつきが残る時期の歩行介助に使った体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/195679_10000490/1.1/','rakuten','195679_10000490:20170918:482b8f69:cb1890f64d'),
('ironbaron-honeycomb','後ろ足が弱った17歳・12〜13kgの柴系ミックスにSS。少し大きかったが使え、亡くなる前日まで3か月間毎日の介助に役立った体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/195679_10000490/1.1/','rakuten','195679_10000490:20140411:5fca8276:c0afff261c'),
('ironbaron-honeycomb','後ろ足が弱り、玄関の段差でつまずいたり廊下でずり落ちたりするようになった14歳のゴールデンのために選んだ体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/195679_10000490/1.1/','rakuten','195679_10000490:20091011:bc6a2472:c081515f3a'),
('ironbaron-honeycomb','体重32kg・胴回り85cm前後の13歳のゴールデンで、サイズに悩みショップの助言でMを選択。ファスナーが2か所あり状態に合わせて使い分けられる体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/195679_10000490/1.1/','rakuten','195679_10000490:20090222:482b8f69:c67941c029')
)
INSERT OR IGNORE INTO review_sources(review_id,source_type,source_url,source_platform,source_review_id)
SELECT r.id,s.source_type,s.source_url,s.source_platform,s.source_review_id
FROM new_sources s
JOIN reviews r ON r.product_id=s.product_id AND r.summary=s.summary;

WITH new_sources(product_id,summary,source_type,source_url,source_platform,source_review_id) AS (
VALUES
('ironbaron-honeycomb','階段の上り下りができなくなり、抱えて外へ排泄に連れ出すのに限界を感じて購入。抱える時は不安がっていたが、2日ほどで大人しく着るようになった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/195679_10000490/1.1/','rakuten','195679_10000490:20180630:b2a6487d:b9a39f0a5d'),
('ironbaron-honeycomb','自力で立つのが難しくなった16歳の大柄なラブラドールで、前回のMは腹回りがぶかぶかで、留守番中に前足が片方の穴に両方入って動けなくなったことがあった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/195679_10000490/2.1/','rakuten','195679_10000490:20130901:482b8f69:ed397d861f'),
('ironbaron-honeycomb','骨肉腫で断脚した12歳のラブラドールで、3本脚になってから持ち手で体を少し支えながら歩く介助に使った体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/195679_10000490/2.1/','rakuten','195679_10000490:20200420:8909c834:173086e75b'),
('ironbaron-honeycomb','美容室で靭帯を損傷し片足が着かなくなった17歳・14kgのミックスにSS。外でしか排泄しないため朝夕夜に着けて少し歩いている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/195679_10000490/2.1/','rakuten','195679_10000490:20151012:482b8f69:7c219dfd8f'),
('ironbaron-honeycomb','急に自力で立てなくなった25kgの大型犬で、女性が起き上がらせるのは大変だったため購入し、外での排泄の介助に使っている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/195679_10000490/2.1/','rakuten','195679_10000490:20150927:482b8f69:9359506d25'),
('ironbaron-honeycomb','4年前に関節を痛めた時に持ち手1つのタイプが役立ち、ふらつきや段差・溝の乗り越えに介助が必要になった16歳・19kgのゴールデンミックスに持ち手2つのタイプを買った体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/195679_10000490/2.1/','rakuten','195679_10000490:20141209:0503e8d8:8dfd2e2b0d'),
('ironbaron-honeycomb','13歳・25kgの標準体型のゴールデンにS。狭い方のファスナーでぴったりだが、横になる時は胸が苦しそうなので広い方を使っている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/195679_10000490/1.1/','rakuten','195679_10000490:20131005:482b8f69:d9d2aa49c5'),
('terubell-wonderfit','体重が同じでも採寸がコーギーとまったく違った9kgの柴犬にXL。散歩の終盤に歩くのを拒否して踏ん張るとよく抜けていたが、抜けなくなった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/255000_10000657/1.1/','rakuten','255000_10000657:20260523:482b8f69:df97d50113'),
('terubell-wonderfit','すっぽ抜け防止をうたうハーネスはいろいろあるが、これは一度も抜けたことがない。散歩中は引かれて中心線がずれるが、犬は嫌がっていないという体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/255000_10000657/1.1/','rakuten','255000_10000657:20260602:482b8f69:7f298b9615'),
('terubell-wonderfit','着ける時に暴れるわんぱくな子犬で、簡単装着のハーネスはどれも散歩中に抜けてしまったため、すがる思いで選んだ体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/255000_10000657/1.1/','rakuten','255000_10000657:20260614:fd9ab4e1:691d005b57'),
('terubell-wonderfit','5.2kgのスムースのダックスに20mm幅のMを選んだら、交差部分が浮いて毛の少ない脇が痛そうだったため、15mm幅のSに交換した体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/255000_10000657/1.1/','rakuten','255000_10000657:20260131:482b8f69:70c7eaa697'),
('terubell-wonderfit','4.3kgのチワックスに採寸して大きめのMを選んだらぶかぶかで、幅も思ったより広かったためSに交換した体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/255000_10000657/1.1/','rakuten','255000_10000657:20260122:482b8f69:9350b727bc'),
('terubell-wonderfit','前のハーネスは首がぶかぶかで、犬同士で遊ぶと抜けることがあった3.3kgのチワックスで、装着とサイズ調整が簡単なものとして選び、冬のコートの上からも使えそうな体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/255000_10000657/10.1/','rakuten','255000_10000657:20251005:80fed5c6:1403076db4'),
('terubell-wonderfit','1歳10か月・12kgの黒柴で、LとXLに迷い大きめのXLにしてちょうど良く、太めの幅の方が安心だと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/255000_10000657/2.1/','rakuten','255000_10000657:20260116:d5bc4d47:66a6e6852f'),
('terubell-wonderfit','引きが強くすっぽ抜けが気になってきた6.3kgのトイプードルで、抜ける心配がなくなった。噛み癖があり首を通す時は一苦労という体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/255000_10000657/2.1/','rakuten','255000_10000657:20260616:92a3d82d:7fc243bb49'),
('terubell-wonderfit','チワワ2頭を1人で散歩中、子犬が他の犬を怖がっている間にもう1頭が後ずさりしてハーネスが抜けたことがあり、このショップのハーネスに替えた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/255000_10000657/2.1/','rakuten','255000_10000657:20260512:482b8f69:3c5763172d'),
('terubell-wonderfit','体はハスキー寄りで毛はポメラニアン寄りの20kg弱のミックスで、前のハーネスの金具にひびが入ったため替え、サイズを選び直した体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/255000_10000657/2.1/','rakuten','255000_10000657:20260212:84fdc7bb:08fdb25c15'),
('terubell-wonderfit','レインコートやアウターの上から使える薄手で抜けにくいものを探し、手持ちの薄手ハーネスは飛びかかられて後ずさりした時に抜けたことがあった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/255000_10000657/2.1/','rakuten','255000_10000657:20260126:482b8f69:f68fbf05d3'),
('terubell-wonderfit','首回りが変えられないハーネスで位置がずれていた14kgのむっちりした柴犬で、首と胴を簡単に調整でき、前足に触らずに着脱できる体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/255000_10000657/2.1/','rakuten','255000_10000657:20251212:482b8f69:ce31612eae'),
('terubell-wonderfit','服もマジックテープも前足を通すのも受け付けない過敏な7.9kgの柴犬で、初めて着けた時は噛みつかれそうになったが、布の少ないこの形を選んだ体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/255000_10000657/2.1/','rakuten','255000_10000657:20251029:1620c948:beb223f219'),
('terubell-wonderfit','抜けにくいものを探した11.5kgのコーギーで、留める場所が1か所なので着脱しやすいが、最初は調整部分が硬く手間取った体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/255000_10000657/3.1/','rakuten','255000_10000657:20260531:482b8f69:fddefe1aae'),
('radica-cordura-harness','顔を通すのが苦手な犬で、留め具を外して足を入れてからでも余裕があり、すんなり着けられた。調整し直さなくても毎回ぴったり合う体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/255378_10021956/1.1/','rakuten','255378_10021956:20260612:09cfcc37:a119ff0b04'),
('radica-cordura-harness','サイズ調整がとても簡単で、裸の時も厚い冬服の時もさっと着けられ、軽く薄く洗ってもすぐ乾く。リードをつなぐ布が長く、走ると金具が体に当たって痛そうという体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/255378_10021956/1.1/','rakuten','255378_10021956:20260209:482b8f69:9aefd9bef8'),
('radica-cordura-harness','誤嚥性肺炎で入院したことがあり、首輪からハーネスへ替えた3kgの犬で、撥水で軽く、胸のクッション性も良いと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/255378_10021956/1.1/','rakuten','255378_10021956:20251030:8f05459c:f89c0ffc89'),
('radica-cordura-harness','ミニチュアダックス2頭にM。マジックテープ式から替え、簡単に着けられて2頭とも嫌がらなかった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/255378_10021956/1.1/','rakuten','255378_10021956:20260602:353c7b4f:714778a9f1'),
('radica-cordura-harness','5か月のミニチュアダックスで、足が短くてもハーネスで大丈夫か心配だったが、数日使って問題なさそう。前足の穴の裏にもう少しクッションが欲しいという体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/255378_10021956/1.1/','rakuten','255378_10021956:20260528:482b8f69:6af21d01b1'),
('radica-cordura-harness','15歳のトイプードルのため軽くて着けやすいものを探し、胸板が厚く胴回りで合わせると中心が少し首寄りになるが、問題なく散歩できる体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/255378_10021956/1.1/','rakuten','255378_10021956:20260313:e2f76e55:52af7ae33f'),
('radica-cordura-harness','体格の良いダックスでLLは大きすぎる気がしてLにしたらしっくりきた。裸でも服の上でも合い、首や胸の一点に圧がかからないと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/255378_10021956/2.1/','rakuten','255378_10021956:20251223:482b8f69:453499eb18'),
('radica-cordura-harness','なかなか散歩したがらない1.95kgのチワワの子犬に使い、着けやすく便利だった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/255378_10021956/2.1/','rakuten','255378_10021956:20260910:f8f5696d:25e5aae147'),
('radica-cordura-harness','4.5kgのマルプーで、装着が簡単で後ずさりしても抜けることはないという体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/255378_10021956/3.1/','rakuten','255378_10021956:20260423:85aa747b:51ee213abd'),
('radica-cordura-harness','2.8〜2.9kgのマルチワにSがぴったり。服を着ると難しいので冬はMにする予定という体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/255378_10021956/3.1/','rakuten','255378_10021956:20260402:482b8f69:1a6a9ebf75'),
('radica-cordura-harness','縦横無尽に動き回るやんちゃな1kgのチワワの子犬で、抜けたりせず安心して散歩でき、調整できるので成長しても使えそうな体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/255378_10021956/3.1/','rakuten','255378_10021956:20251227:482b8f69:dc833d6b38'),
('radica-cordura-harness','モデル犬の豆柴を参考にLLを選んだが、6kgの弟犬にLを試すと着丈が短く脇が擦れそうだったという体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/255378_10021956/3.1/','rakuten','255378_10021956:20260403:482b8f69:bc42b964f7'),
('suzukoubou-standard','首と胴に合わせると胴の長さが合わず、きつめのものを使うしかなかったパグで、パグ・フレブル向けの形のため胴回りに余裕を持ちつつ合わせられた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/278852_10001829/1.1/','rakuten','278852_10001829:20260623:482b8f69:c228385c48'),
('suzukoubou-standard','散歩中に歩くのを拒否して踏ん張ることが多い11kgの柴犬にL。生地がまだ硬いためか、脱ぐ時に頭が引っかかるという体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/278852_10001829/1.1/','rakuten','278852_10001829:20260825:23e217ed:e191f1fe2c'),
('suzukoubou-standard','散歩中にハーネスが抜けてひやっとしたことがあり、抜けにくいものを急いで探して選び、装着も簡単だった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/278852_10001829/1.1/','rakuten','278852_10001829:20260218:ba226667:4c336bf230'),
('suzukoubou-standard','5.5kgの大きめのマルプーで、サイズを上げるか迷ったが体重からSのままを勧められ、首輪と2本のリードで使っている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/278852_10001829/1.1/','rakuten','278852_10001829:20260315:482b8f69:e32172fed0'),
('suzukoubou-standard','6kgと7kgのパグ2頭に使い、服を着られる子なら片方の前足を通すだけなので簡単。頭を通すのを嫌がる犬はいるかもしれないという体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/278852_10001829/1.1/','rakuten','278852_10001829:20251021:ec0f5ec4:b6460f759e'),
('suzukoubou-standard','皮膚が弱く脇の擦れが気になっていた6kg台の黒柴で、少し小さく感じたS+からゆとりのあるMに替えて良かったという体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/278852_10001829/2.1/','rakuten','278852_10001829:20260428:482b8f69:d0b3c290b7'),
('suzukoubou-standard','6か月前・約2.8kgのチワプーで、SとSS+に迷いショップに相談して勧められたSS+を選んだ体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/278852_10001829/2.1/','rakuten','278852_10001829:20250910:1d5ad6b7:917c0c8d38'),
('suzukoubou-standard','ベスト一体型のハーネスで抜けた経験がある胴の太い4kgのトイプードルで、届いた時は小さいと焦ったが、同封の冊子の手順で合わせられた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/278852_10001829/3.1/','rakuten','278852_10001829:20250220:5f873863:237acb6a66'),
('suzukoubou-standard','胴回り約35cm・3.7kgのポメラニアンに胴回りに合わせてSを選んだら、首回りは一番小さくしてもぶかぶかだったという体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/278852_10001829/3.1/','rakuten','278852_10001829:20241028:482b8f69:9cc5f98a70'),
('suzukoubou-standard','体に負担が少なく抜けにくいものを探していた7歳の大きめのペキニーズで、とてもしっかりした作りだと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/278852_10001829/3.1/','rakuten','278852_10001829:20250215:848e2035:565fb70773'),
('suzukoubou-standard','怖がりの小型犬のため抜けにくいH型を探して選び、サイズを細かく調整でき中央のクッションも優しい。それでも心配で首輪と2本のリードにしている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/278852_10001829/3.1/','rakuten','278852_10001829:20241106:482b8f69:2a01dcfc93'),
('suzukoubou-standard','胴回り45cm・5.6kgのマルチーズにM。しっかりしていて抜けにくいが、素材が硬く馴染むまで時間がかかりそうで、片前足を通す着脱に少し手間取る体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/278852_10001829/7.1/','rakuten','278852_10001829:20241004:0996124e:571bbc3e6c'),
('happy-heel-harness','訓練所に通っても飛びつきと引っ張りがひどく、人や犬のいない時間にしか散歩できなかった1歳のスタンダードプードルで、引っ張りがかなり収まった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/309454_10000259/1.1/','rakuten','309454_10000259:20251125:482b8f69:f118af067e'),
('happy-heel-harness','ジグザグ歩きと強い引っ張りがあり猫やキツネを見ると興奮する1歳半の筋肉質な中型の雑種で、すぐ直ったわけではないが付属DVDのとおり辛抱強く取り組み改善してきた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/309454_10000259/1.1/','rakuten','309454_10000259:20160318:e3b6e842:421393ca34'),
('happy-heel-harness','とても元気で引っ張りがすごい20kgほどの保護犬で、坂道の多い散歩で膝や腕が痛かったが、本当に引っ張らなくなったという体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/309454_10000259/1.1/','rakuten','309454_10000259:20210102:158db58c:d56f4be8ef'),
('happy-heel-harness','5kgの豆柴にSで少し大きめだが、引くと締まる仕組みのため抜けることはなさそうだと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/309454_10000259/1.1/','rakuten','309454_10000259:20221222:482b8f69:7a203c5bb1'),
('happy-heel-harness','引っ張りがあり、擦れにくいとされるハーネスでも脇の下が擦れていた6kgのボストンテリアで、前のバンドは緩いが抜けることはなかった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/309454_10000259/1.1/','rakuten','309454_10000259:20150602:482b8f69:0f7c3d4f3e')
)
INSERT OR IGNORE INTO review_sources(review_id,source_type,source_url,source_platform,source_review_id)
SELECT r.id,s.source_type,s.source_url,s.source_platform,s.source_review_id
FROM new_sources s
JOIN reviews r ON r.product_id=s.product_id AND r.summary=s.summary;

WITH new_sources(product_id,summary,source_type,source_url,source_platform,source_review_id) AS (
VALUES
('happy-heel-harness','4頭のうち1頭だけ引っ張りが強かった8kgの大きめのトイプードルで、使い始めた日から引っ張らず腕が疲れなくなった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/309454_10000259/1.1/','rakuten','309454_10000259:20230218:136066e3:af9e06adad'),
('happy-heel-harness','引っ張り癖のある4.5kgのペキニーズで、最初は装着に戸惑ったが付属DVDを見て着け、帰り道にはリードが張らなくなった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/309454_10000259/1.1/','rakuten','309454_10000259:20150424:ee517722:82a2a6e099'),
('happy-heel-harness','胴回り51cmの4か月の子犬に成長を見越してMを選んだら大きすぎ、胸前のベルトは一番小さくしても垂れ下がったという体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/309454_10000259/1.1/','rakuten','309454_10000259:20240219:d4d68119:9813097477'),
('happy-heel-harness','暴走しがちな6歳・7.5kgのトイプードルと3kg弱のヨーキーを一緒に散歩するのが大変だったが、無理なくゆっくり歩くようになった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/309454_10000259/2.1/','rakuten','309454_10000259:20231207:c131fb2c:301f1a78f8'),
('happy-heel-harness','チョークタイプの首輪を強く嫌がった7kg近い大きめのミニチュアダックスで、ハーネス型なら嫌がらないと考えて選び、Sを一番締めても少し余裕がある体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/309454_10000259/2.1/','rakuten','309454_10000259:20221220:482b8f69:c250db0195'),
('happy-heel-harness','胸板が厚い10kgほどの犬で、玄関を出た途端に引っ張るが、先に行ってもすぐ振り向かせられるので車や拾い食いの危険からも安心できる体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/309454_10000259/2.1/','rakuten','309454_10000259:20201018:482b8f69:bb929b2b01'),
('happy-heel-harness','猟犬系の保護犬を預かることが多く、走りたがる犬が多いため引っ張り防止ハーネスが欠かせない。以前の製品よりサイズを合わせやすいと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/309454_10000259/2.1/','rakuten','309454_10000259:20150916:c1e1b706:9b7a88d002'),
('happy-heel-harness','ハーフチョークで首への負担が心配だった1歳半のスタンダードプードルで、普通のハーネスだとさらに引くのではと迷ったが、引っ張りを止める用途で選んだ体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/309454_10000259/2.1/','rakuten','309454_10000259:20150305:7ebaddc8:024a4f00c8'),
('happy-heel-harness','ハーフチョークでは効かず、突然のダッシュや後ろ足立ちで散歩が苦痛だったスタンダードプードルで、まず引っ張らなくなったことに驚いた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/309454_10000259/2.1/','rakuten','309454_10000259:20240317:df223dc1:349fdc602c'),
('truelove-handle-harness','9kgのフレブルで、同じ型のSを使っていたが頭を抜く時に耳が引っかかるため、胴回りを測り直してMに替えた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/378148_10000034/1.1/','rakuten','378148_10000034:20250203:5972c885:6ca9de8f90'),
('truelove-handle-harness','8か月・12kgのフレブルにM。首回りも胴回りも調整でき、この形でよくある首からのすっぽ抜けも起きそうにないと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/378148_10000034/1.1/','rakuten','378148_10000034:20220330:482b8f69:90d2e93c49'),
('truelove-handle-harness','胸囲90cmで胸板の厚い35kgの黒ラブにXL。まだ余裕はあるが、大型犬用としては少し小さめに感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/378148_10000034/1.1/','rakuten','378148_10000034:20210418:482b8f69:73722b7851'),
('truelove-handle-harness','1歳8か月・12kgのコーギー・カーディガンで、SとMに迷い問い合わせたうえでMにして良かったと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/378148_10000034/2.1/','rakuten','378148_10000034:20211128:482b8f69:a476368b31'),
('truelove-handle-harness','8か月・30kgのゴールデンでMが小さくなりLを購入。途中で試した別のハーネスは安っぽく体に沿わず、犬が気にして散歩に集中できなかった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/378148_10000034/2.1/','rakuten','378148_10000034:20230207:482b8f69:2f95a9eb62'),
('truelove-handle-harness','どちらも引っ張り癖がひどい22kgの雑種2頭にL。首を通すだけで着けられ、首輪の時より喉の負担が減ったようでゼーゼー言わなくなった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/378148_10000034/2.1/','rakuten','378148_10000034:20220418:482b8f69:b274538196'),
('truelove-handle-harness','胸幅が広く一般的な体重別のハーネスが合わなかった5か月・4.5kgのフレブルに、Sをかなり小さく調整して使っている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/378148_10000034/2.1/','rakuten','378148_10000034:20220314:5972c885:8fba718482'),
('truelove-handle-harness','首と胴のバランスが合うものがなかった11kgのボストンテリアにM。冬に服を着て胴回りが大きくなっても合わせられる体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/378148_10000034/2.1/','rakuten','378148_10000034:20220112:e3696301:e100c7687b'),
('truelove-handle-harness','18kgのボーダーコリーにM。前に付いた引っ張り防止のリングが散歩で大活躍している体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/378148_10000034/2.1/','rakuten','378148_10000034:20210709:5bd3a7e7:484f1ef423'),
('truelove-handle-harness','喉が弱くフィットするものを探していた27kgのラブラドールにL。胴回りは最大にしてぴったりで、太るときつくなりそうな体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/378148_10000034/2.1/','rakuten','378148_10000034:20200508:482b8f69:1f44032067'),
('truelove-handle-harness','長毛で首輪だとすっぽ抜けてしまう4歳・13kgの雑種で、サイズ表ではSだがレビューを参考にMにしてちょうど良かった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/378148_10000034/2.1/','rakuten','378148_10000034:20240218:6fb2f5ab:210d20ca0b'),
('truelove-handle-harness','横について歩きほとんど引かない12歳・25kgの大型のミックスで、高齢で首輪は首に負担と聞き、初めてハーネスにした体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/378148_10000034/2.1/','rakuten','378148_10000034:20220315:0483234f:ed623c6f2b'),
('truelove-handle-harness','首への負担を考えて前からもリードを付けられるものを探した、37kgのシニアのドーベルマンで、前・後ろ・背中の3点で誘導でき、当たりも優しい体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/378148_10000034/2.1/','rakuten','378148_10000034:20210321:482b8f69:0f7fc9c986'),
('truelove-handle-harness','2頭のうち引っ張り癖が抜けない8kgの柴犬にS。首輪より引かなくなった気がするが、体が細く頭が大きいため着脱時に頭を通すのが少しきつい体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/378148_10000034/3.1/','rakuten','378148_10000034:20210919:88851619:d92c23bc7b'),
('truelove-handle-harness','引っ張り癖がある3.5kgの犬で、胸にリングがあるタイプが一番効果があると感じた。首回りを合わせると頭が入らなくなるため少し緩めにしている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/378148_10000034/3.1/','rakuten','378148_10000034:20210910:482b8f69:f54ee618f2'),
('funcoma-harness-lead','2.1kgのトイプードルの子犬にはサイズが小さくて留まらず、首の下とお腹のバックルを留めるのも、ハーネスで遊んでしまい大変だった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/392151_10000004/2.1/','rakuten','392151_10000004:20241007:83ed8e66:801763e4d7'),
('funcoma-harness-lead','4.2kgの犬にMがきつく、胴のベルトは使わずマジックテープだけでぎりぎり留めている。引っ張らない犬なので何とか使えているという体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/392151_10000004/1.1/','rakuten','392151_10000004:20250413:d7cc9dc0:e5fea93efd'),
('funcoma-harness-lead','前の高いハーネスは嫌がって、見せるたびに逃げていた犬で、マジックテープとバックルの二重で留まる安価なこのタイプにした体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/392151_10000004/1.1/','rakuten','392151_10000004:20230623:42ad2216:9d2cd05776'),
('funcoma-harness-lead','2.3kgの細めのトイプードルでサイズは合ったが、つないで離れている間に首元のバックルをつなぐテープを噛みちぎられた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/392151_10000004/1.1/','rakuten','392151_10000004:20240825:7d51f202:50e125e47a'),
('funcoma-harness-lead','胸回り30cm・4kgのトイプードルにM、胸回り47cm・6kgのトイプードルにXLを選び、大きい子にもサイズが合うか心配していた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/392151_10000004/1.1/','rakuten','392151_10000004:20240428:482b8f69:ccd0896513'),
('funcoma-harness-lead','迎えたばかりの4か月・3.3kgの暴れん坊のミニチュアダックスで、抜けると事故につながるためぴったりのサイズを探し、ジャストフィットした体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/392151_10000004/1.1/','rakuten','392151_10000004:20240119:64c30e85:b0600de559'),
('funcoma-harness-lead','3歳半のトイプードルにL、散歩デビューの4か月のダックスにSを選び、ダックスは5か月半でサイズアウトしてMを買い直した体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/392151_10000004/1.1/','rakuten','392151_10000004:20221016:482b8f69:7a9a32a01e'),
('funcoma-harness-lead','6kgのシーズーでLとXLに悩みLでジャスト。毛が伸びると窮屈になるかもしれないと心配している体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/392151_10000004/2.1/','rakuten','392151_10000004:20240922:b4b18fff:3130ef25c4'),
('funcoma-harness-lead','激しい散歩はしないチワワで物は良かったが、リード側の金具が緩く、ハーネス側の金具周りの縫製も甘いため、力の強い犬では心配で補強を考えた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/392151_10000004/2.1/','rakuten','392151_10000004:20230309:482b8f69:cf1d7ec6bb'),
('funcoma-harness-lead','服のような見た目のハーネスが欲しかった3kgのヨーキーで、胴回りは合ったが首回りが大きく少し直した体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/392151_10000004/2.1/','rakuten','392151_10000004:20220328:ce4c8d61:df4134f76e'),
('funcoma-harness-lead','4kgの高齢の犬に服の上から着け、マジックテープとバックルの二重で調整できる安心感がある。付属のナイロンリードは滑りやすいという体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/392151_10000004/3.1/','rakuten','392151_10000004:20240615:a310f621:f847c5a478'),
('laluca-wear-harness','1.2kgのトイプードルの子犬にXS。背中の金具はつまんでスライドさせる方式で、カチッとはめるタイプより使いやすかった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/395228_10000031/1.1/','rakuten','395228_10000031:20251113:482b8f69:4d310f54a3'),
('laluca-wear-harness','首が細く力が強くせわしなく動くため、何個買っても首から抜けていた7kgのコッカーで、背中のひもは薄く不安だったが、ひもで体格に合わせて調整でき今までより安心な体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/395228_10000031/1.1/','rakuten','395228_10000031:20260518:cab64e72:fef26089a0'),
('laluca-wear-harness','4kg弱のトイプードルにM。服を着てもゆとりがあり、冬の厚い服でも使えそう。2頭いるので価格が安いのが助かる体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/395228_10000031/1.1/','rakuten','395228_10000031:20260611:c9c3b511:3c5aa1ad48'),
('laluca-wear-harness','胴長でやせ形のため、これまでのハーネスは抜けたり脇が擦れたりしていた4.2kgのチワックスで、Sがぴったりで抜けず脇も大丈夫だった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/395228_10000031/2.1/','rakuten','395228_10000031:20251009:482b8f69:c1f8a222f3'),
('laluca-wear-harness','1.5kgの小柄なチワプーの子犬で、成長を見越してSにしたら少し大きめだが、余裕があって着けやすかった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/395228_10000031/2.1/','rakuten','395228_10000031:20250704:01b2bef7:5c0f459e5e'),
('laluca-wear-harness','抱っこから飛び降りたことがあり、首輪では不安だった3か月・1.5kgの子犬で、着けても嫌がらず走っていた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/395228_10000031/2.1/','rakuten','395228_10000031:20250502:76f217ba:71f01194f8'),
('laluca-wear-harness','4kgのカニンヘンダックスで、夏は軽く薄いので良く、服を着せてもベルトのストッパーで調整できた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/395228_10000031/2.1/','rakuten','395228_10000031:20250725:536a489e:1d603e8485'),
('laluca-wear-harness','3か月・2kgのトイプードルにXS。散歩中に引いても抜けなかったが、首から通すので暴れる子には少し手こずった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/395228_10000031/2.1/','rakuten','395228_10000031:20250103:473cd385:deee69ca1f'),
('laluca-wear-harness','初めてのハーネスとして選んだシュナウザーの子犬で、5kgの頃はぴったり、7kgを超えた今は少しきつく感じる体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/395228_10000031/2.1/','rakuten','395228_10000031:20241027:39db1e85:1792c55a93'),
('laluca-wear-harness','1.3kgのチワプーの子犬にXS。リード部分を噛んでしまうので、すぐ傷まないか心配な体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/395228_10000031/3.1/','rakuten','395228_10000031:20250919:88243627:3396ce8eec'),
('laluca-wear-harness','服嫌いの4kgのポメラニアンにS。着脱しやすい金具なので嫌がらずに着けられる体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/395228_10000031/3.1/','rakuten','395228_10000031:20250723:8b5c5ea2:9c41367c96'),
('moncheri-harness','とても怖がりで、散歩中に怖がって後ずさりしY型のハーネスから抜け、猛ダッシュで逃げたことがある4.1kgの大きめのチワワで、抜けにくいものとして選んだ体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/406105_10001780/3.1/','rakuten','406105_10001780:20251016:482b8f69:7ba70fa889'),
('moncheri-harness','首輪で引っ張ってゼーゼー言うのが気になっていた4か月・4kgのシュナウザーで、すっぽ抜け防止と、成長に合わせて各部を調整できる点で選んだ体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/406105_10001780/3.1/','rakuten','406105_10001780:20251002:482b8f69:c84a2ab000'),
('moncheri-harness','ベスト型のハーネスで、他の犬に興奮して飛びかかろうとした時に何度か抜けた4kgのポメラニアンで、服を着たままでも調整でき着けるのも簡単な体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/406105_10001780/1.1/','rakuten','406105_10001780:20260122:482b8f69:b1485d3ed7'),
('moncheri-harness','落ち着きのない4か月・2kgの子犬に一番きつくしてぴったり。装着には手間取るが、抜けにくそうだと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/406105_10001780/1.1/','rakuten','406105_10001780:20260904:482b8f69:53f64f491d')
)
INSERT OR IGNORE INTO review_sources(review_id,source_type,source_url,source_platform,source_review_id)
SELECT r.id,s.source_type,s.source_url,s.source_platform,s.source_review_id
FROM new_sources s
JOIN reviews r ON r.product_id=s.product_id AND r.summary=s.summary;

WITH new_sources(product_id,summary,source_type,source_url,source_platform,source_review_id) AS (
VALUES
('moncheri-harness','足を通すタイプが苦手な7か月・2.1kgのマルプーで、頭を通して胴回りで留めるだけなので慣れやすかった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/406105_10001780/3.1/','rakuten','406105_10001780:20250125:482b8f69:e6adaaeb3b'),
('moncheri-harness','5kgのトイプードルにM。抜けにくい形を探していて、嫌がることなく着脱できる体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/406105_10001780/3.1/','rakuten','406105_10001780:20250517:cce39142:6a6055a193'),
('moncheri-harness','3.9kgのポメラニアンにM。少しゆったり着けると噛んでしまうので、一番小さくして着けている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/406105_10001780/3.1/','rakuten','406105_10001780:20250421:49b6ee68:60154b9cea'),
('moncheri-harness','1.6kgのスムースチワワに一番小さく調整してぴったり。バックルが2か所でひもも太く頑丈そうだが、コットン素材で体に当たっても痛くなさそうな体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/406105_10001780/3.1/','rakuten','406105_10001780:20250325:c5a15a0f:a53f6b4f82'),
('moncheri-harness','引っ張りが強く首輪から気管に負担の少ないものへ替えた4.9kgのマルプーで、冬服を着ても余裕があり、前足を触られるのが嫌いなので首から通せるのが良い体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/406105_10001780/3.1/','rakuten','406105_10001780:20250131:65c11ebd:d499988846'),
('moncheri-harness','前のハーネスを噛んで3か月ほどで壊した3kgのマルプーで、首を通すだけで着けられ、リードを付けたまま着脱できる体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/406105_10001780/3.1/','rakuten','406105_10001780:20241208:006cd655:705aeb8e71'),
('moncheri-harness','散歩好きな11歳・5kgのシニアのトイプードルで、首輪から首に負担のかからないハーネスに替えた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/406105_10001780/3.1/','rakuten','406105_10001780:20241103:d228be16:3c9b833912'),
('thebestday-walking-belt','高齢で後ろ足が立たなくなった大柄なコーギーで、体重で生地にしわが寄り少し苦しそうに見えるが、試した中では一番使いやすく本人も歩きやすそうな体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/408415_10000514/1.1/','rakuten','408415_10000514:20251126:482b8f69:ba9727aaee'),
('thebestday-walking-belt','最近左脚がよろけるようになった15歳・4.7kgのトイプードルにS。補助ベルトでサイズを合わせられ、肌触りも良さそうな体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/408415_10000514/1.1/','rakuten','408415_10000514:20250613:a784fee9:8cd96de3f2'),
('thebestday-walking-belt','後ろ足の点滴の管を外した後うまく歩けなかった17歳のカニンヘンダックスに急いで使い、嫌がらずに着けて数日でなんとか歩けるようになった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/408415_10000514/1.1/','rakuten','408415_10000514:20250529:b3c40e5a:36ca3d7d0f'),
('thebestday-walking-belt','足の踏ん張りが弱くなった15歳の柴犬で、SとLしかなくLを選んだが、胴回りはマジックテープで、持ち手の長さも調整できた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/408415_10000514/1.1/','rakuten','408415_10000514:20241011:dcf31bdb:82c3829551'),
('thebestday-walking-belt','後ろ足が悪い15歳のトイプードルにS。装着が簡単でマジックテープで調整でき、まだ散歩に連れて行ってあげたいと思える体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/408415_10000514/1.1/','rakuten','408415_10000514:20240812:eb8d36fe:011e12636b'),
('thebestday-walking-belt','脳腫瘍で平衡感覚がなくなり排泄に介助が必要になった4kgのミニピンで、装着が簡単で持ち手の長さを調整できるので飼い主の腰も痛くならない。長時間のリハビリでは体型のせいか少し気になる点もあった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/408415_10000514/1.1/','rakuten','408415_10000514:20240215:53ec17fb:cd4fc6d579'),
('thebestday-walking-belt','右後ろ足を断脚した柴犬で、普段は3本足で頑張ってもらい、外で排泄する時だけ使っている。Lは少し大きくマジックテープで調整している体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/408415_10000514/1.1/','rakuten','408415_10000514:20240729:982f93f6:0bd58fa346'),
('thebestday-walking-belt','前脚用・後ろ脚用で迷い、使いやすそうなこれを選んだ18歳のトイプードルで、簡単に着けられ何も使わないより安定する体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/408415_10000514/1.1/','rakuten','408415_10000514:20240703:482b8f69:6b6a2fb523'),
('thebestday-walking-belt','ヘルニアが悪化したシニアのパピヨンにS。散歩好きだった犬がだいぶ歩きやすくなり嬉しそうにしている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/408415_10000514/1.1/','rakuten','408415_10000514:20240424:482b8f69:020e2c8f8f'),
('thebestday-walking-belt','脊髄梗塞で右の手足に麻痺が出た7kgのトイプードルで、胴回りが大きいためLを選び、少し大きいがマジックテープで調整して使えた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/408415_10000514/1.1/','rakuten','408415_10000514:20240319:f846abfb:2e1ed817c6'),
('thebestday-walking-belt','突然後ろ足が立たなくなった13歳のトイプードルで、使ってみても最初は全く歩かず、少し歩けるようになってから訓練用に使うことにした体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/408415_10000514/2.1/','rakuten','408415_10000514:20240901:ce622511:1cb2dc1b25'),
('ruffwear-flagline','高齢の10kgの柴犬の介護用にXS。腹当てがあるのでお腹への負担が少なそうで、夏場用に前のウェブマスターから替えた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/266503_10001045/1.1/','rakuten','266503_10001045:20260626:2558274e:2d156b2453'),
('ruffwear-flagline','安いハーネスは抜けやすかったため替え、15kgのゴールデンの子犬にM。抜ける気配がなく、やんちゃな子犬でも安心して散歩できる体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/266503_10001045/1.1/','rakuten','266503_10001045:20260114:c53d88d2:8cfd3d06d4'),
('ruffwear-flagline','興奮するとぴょんぴょん跳ねてひやっとするミニピンに、ベルトが3本あるこのハーネスを選びXS。首回りは緩く、余ったひもを縫って詰めた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/266503_10001045/1.1/','rakuten','266503_10001045:20260704:8a480433:c6439ec646'),
('ruffwear-flagline','XXSを使っていて、抜けにくく生地が薄めで体にフィットする。少し小さくなりワンサイズ上げたら、首回りだけ少し大きかった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/266503_10001045/1.1/','rakuten','266503_10001045:20260516:482b8f69:aad1bc9c6c'),
('ruffwear-flagline','17歳・12.5kgのミックスで、ふらついた時に力が一か所にかからないよう支えられるものを探して選び、軽くしっかりした作りだった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/266503_10001045/1.1/','rakuten','266503_10001045:20241102:482b8f69:690621f893'),
('ruffwear-flagline','ハスキー2頭の散歩で、後ずさりしても抜けないので安心。すっぽ抜けの怖さからハーネス選びに神経質になっていたが不安がなくなった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/266503_10001045/1.1/','rakuten','266503_10001045:20220725:52ba8a0c:9fe1cd47aa'),
('ruffwear-flagline','15歳・20kg前後の短毛のミックスで、筋肉が落ちて胸の張りや胴囲が細くなってきたため、これからを考えてSにした体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/266503_10001045/1.1/','rakuten','266503_10001045:20240505:482b8f69:8d70c57c95'),
('ruffwear-flagline','段差を降りる時の補助をしたい10歳・32kgのラブラドールで、胸囲からサイズに迷い、問い合わせてL/XLを勧められた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/266503_10001045/1.1/','rakuten','266503_10001045:20220614:5111956e:2945112ecc'),
('ruffwear-flagline','散歩中に胴輪も首輪も何度か抜けて大変だった23kgの中型の雑種にM。今度こそ抜けないでほしいと選んだ体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/266503_10001045/1.1/','rakuten','266503_10001045:20240517:8ee9f6b8:6e00a04488'),
('ruffwear-flagline','このタイプのハーネスは後ずさりしても抜けたことがなく、ベルトも緩んでこないので安心して散歩しているという雑種の体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/266503_10001045/1.1/','rakuten','266503_10001045:20220817:482b8f69:e9d4546188'),
('ruffwear-flagline','引っ張りが強い6.3kgの小型のミックスにXS。下側のベルトが股ぎりぎりで尿がかかることもあるが、抜ける心配がなくなった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/266503_10001045/1.1/','rakuten','266503_10001045:20231203:2742ab32:5159709d08'),
('ruffwear-flagline','36kgのゴールデンにL/XL。胸側・背中・腰にリードを付けられ持ち手もあり、抜けることもないので他のハーネスが使えなくなった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/266503_10001045/1.1/','rakuten','266503_10001045:20240501:482b8f69:0ad2f57d57'),
('ruffwear-hi-light','換毛期で胸囲55cmある4歳・13kgの柴犬に、冬毛の時期を考えてSを選択。届いた時は最小の設定で首も胸もきつく、少し伸ばした体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/266503_10001048/1.1/','rakuten','266503_10001048:20251231:ece612da:5d4923a116'),
('ruffwear-hi-light','初めてのハーネスとして10か月・10kg弱の柴犬にS。とても軽く、着けていることに気付いていないようだった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/266503_10001048/1.1/','rakuten','266503_10001048:20260314:482b8f69:987afa86c7'),
('ruffwear-hi-light','体格の良いミニチュアダックスで、バックルが2か所あるのは少し面倒だが、抜けず軽い体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/266503_10001048/1.1/','rakuten','266503_10001048:20260312:482b8f69:f7365c41b2'),
('ruffwear-hi-light','保護犬出身でしっかりしたハーネスを使っていた6.4kgの豆柴に、夏に向けて軽いものとして選んだ体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/266503_10001048/1.1/','rakuten','266503_10001048:20250527:482b8f69:e52a16c473'),
('ruffwear-hi-light','服が苦手な9.6kgのトイプードル系ミックスにXS。サイズ表どおりでジャストフィットした体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/266503_10001048/1.1/','rakuten','266503_10001048:20241208:482b8f69:b0b8485b56'),
('ruffwear-hi-light','首が太く頭と同じくらいのため、後ずさりで抜けやすかった1歳・8kgのパグで、ベルトで微調整できて良さそうだと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/266503_10001048/1.1/','rakuten','266503_10001048:20250410:ff03945b:31811e65a4'),
('ruffwear-hi-light','細いのに胸囲はしっかりある3.9kgのミニピンにXXSがぴったりで、フロントレンジハーネスから替えた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/266503_10001048/1.1/','rakuten','266503_10001048:20250401:482b8f69:c7072a6042'),
('ruffwear-hi-light','4kgのミックス犬に少しゆとりはあるが、引っ張っても抜けない。先住犬も同じものを使い、鑑札を入れるポケットも安心な体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/266503_10001048/1.1/','rakuten','266503_10001048:20221013:81208f6b:13b8077c29'),
('ruffwear-hi-light','首回りが細い3.9kgのミックス犬で、XXSでは首が大きくXXXSに交換。軽くハーネスが動く感じはあるが外れることはなさそうな体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/266503_10001048/1.1/','rakuten','266503_10001048:20240412:482b8f69:c2be9979ca'),
('ruffwear-hi-light','3.5kgのトイプードルにXXS。首回りは最大限締めても少し緩いが、胴回りできちんと調整できる体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/266503_10001048/1.1/','rakuten','266503_10001048:20231030:75a49c79:47d84e064b'),
('ruffwear-hi-light','若い頃はフロントレンジを気に入っていたが、老犬になり軽いこちらに替え、痩せて4.3kgになったのでXSからXXSにした体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/266503_10001048/1.1/','rakuten','266503_10001048:20230331:1afdebb5:ea4ab3962f'),
('ruffwear-hi-light','引っ張りが強いシュナウザーで、腹囲はぴったりだが首は調整しても緩く、まだ使えていない。小さいサイズだと腹囲がきつくなると考え交換もあきらめた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/266503_10001048/1.1/','rakuten','266503_10001048:20250814:482b8f69:113768f9c7'),
('perros-harness','2.25kgのヨーキーにXS。留め具の小ささは心配したほどではなかったが、首回りは構造上、ベルトの最短までは締められないという体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/410733_10000216/1.1/','rakuten','410733_10000216:20260706:482b8f69:e349dbb7df'),
('perros-harness','ほかのハーネスで抜けてしまい冷や汗をかいたことがある2.5kgのチワワで、高価だが抜ける危険より良いと選び、ぴったりだった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/410733_10000216/1.1/','rakuten','410733_10000216:20260808:f75eecb0:fe24b5a275'),
('perros-harness','体が小さくても抜けることがなく、咳き込みもなかった。留め具が関節に当たらないか心配だったが、内側は滑らかな素材だった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/410733_10000216/1.1/','rakuten','410733_10000216:20251120:482b8f69:4ca2e48f14'),
('perros-harness','似た形のハーネスから替え、首を通さずバックルで着けられるのでハーネスが苦手な犬も使いやすい。ごついハーネスより抜けにくいと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/410733_10000216/1.1/','rakuten','410733_10000216:20250508:9317b0e2:9f53267bd5'),
('perros-harness','先住犬のハーネスの最小サイズでも大きかった1.6kgのトイプードルの子犬で、子犬の動きでも外れず、気管に優しいと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/410733_10000216/1.1/','rakuten','410733_10000216:20240622:61d599f1:82ba48ea73'),
('perros-harness','前のハーネスで脇擦れが起きた10kg強のパグにM。脇に当たらないので擦れなくなった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/410733_10000216/1.1/','rakuten','410733_10000216:20240203:ad08c7e5:3f1d26bdf6'),
('perros-harness','3kgのチワワにXS。調整の幅があり、そのままでも厚い服の上からでも使えそうな体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/410733_10000216/1.1/','rakuten','410733_10000216:20240608:dd2b105c:4e7edc7056'),
('perros-harness','引っ張り癖のある柴犬で、ほかのハーネスより気管への負担が少ないことが呼吸の様子で分かり、引っ張りも軽減された印象の体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/410733_10000216/1.1/','rakuten','410733_10000216:20240512:28b7eef3:d6e7e691ad')
)
INSERT OR IGNORE INTO review_sources(review_id,source_type,source_url,source_platform,source_review_id)
SELECT r.id,s.source_type,s.source_url,s.source_platform,s.source_review_id
FROM new_sources s
JOIN reviews r ON r.product_id=s.product_id AND r.summary=s.summary;

WITH new_sources(product_id,summary,source_type,source_url,source_platform,source_review_id) AS (
VALUES
('perros-harness','頭を通さず着けられる点で選んだが、柔らかいテープとの説明ほど柔らかくなく、ごつくて頑丈な作りだと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/410733_10000216/1.1/','rakuten','410733_10000216:20250215:482b8f69:3caa4c7680'),
('perros-harness','5.3kgと6.3kgの2頭にXS。商品写真の大きいサイズに比べ、届いたものが思ったより細かったことに驚いた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/410733_10000216/1.1/','rakuten','410733_10000216:20240801:710512f8:c2e2f0227d'),
('perros-harness','7kgのジャックラッセルで、強く引っ張ってもむせなくなった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/410733_10000194/1.1/','rakuten','410733_10000194:20241221:482b8f69:6992aecd9c'),
('perros-harness','時々踏ん張って後ずさりし、ハーネスが抜けそうになるのが怖かった9歳のジャックラッセルで、高額だがサイズ交換できることもあり思い切って選んだ体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/410733_10000194/1.1/','rakuten','410733_10000194:20230825:7c2d70e4:86c76c96a0'),
('perros-harness','頭を通すのは平気だが抜く時にパニックになる犬で、首にバックルがあるタイプは少ないため助かっている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/410733_10000194/1.1/','rakuten','410733_10000194:20230602:8713df64:074c6a6e64'),
('perros-harness','肩関節のリハビリ中の長毛の犬で、前足と胸に負担がかからず自由に動け、背中の長さがあり脇が擦れないと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/410733_10000194/1.1/','rakuten','410733_10000194:20240627:fdfcef68:c2c7533cd1'),
('perros-harness','耳が長く、頭を入れるタイプでは毎回耳の出し入れが負担だったコッカーで、細くなっても問題なく使えた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/410733_10000194/1.1/','rakuten','410733_10000194:20231223:482b8f69:b5aac0bc02'),
('perros-harness','11kgの柴犬にS。前足を通して背中で留めるタイプからこちらに替え、犬のストレスが少なそうな体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/410733_10000194/1.1/','rakuten','410733_10000194:20240617:6bdf320b:4a374d377e'),
('perros-harness','生まれつき気管が少し狭く首輪ではなくハーネスを使っている犬で、サイズも良く楽そうな体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/410733_10000194/1.1/','rakuten','410733_10000194:20230917:7f259ea8:c8d24da53a'),
('perros-harness','がっしりした6.5kgのミニチュアダックスにS。調整できる部分が多いのに軽く柔らかく、首と胴どちらのバックルも外せて脱がせやすいが、クッションは付いていない体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/410733_10000194/1.1/','rakuten','410733_10000194:20230807:674a5e34:49c730e62a'),
('perros-harness','気管に良さそうと思って選んだが、値段の割に良さはあまり分からなかったという体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/410733_10000194/1.1/','rakuten','410733_10000194:20250711:addeac25:7a24563c9e'),
('petparadise-disney-vest','3年ほど愛用して傷んできたため同じものを探して買い直した。犬も着け心地が良いのか嫌がらずに着けさせてくれる体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/206746_10076924/1.1/','rakuten','206746_10076924:20251119:9e738ff9:3acc2ce3aa'),
('petparadise-disney-vest','4kgのトイプードルで、3Sは服を着せるときつかったためSSに替え、ぴったりだった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/206746_10076924/1.1/','rakuten','206746_10076924:20210507:628cab74:863595ca3e'),
('petparadise-disney-vest','散歩デビュー前の3か月のチワワに4Sを選んだら大きく、3kg強の上の子に着せると入ったが歩くときつそうだった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/206746_10076924/1.1/','rakuten','206746_10076924:20210924:482b8f69:be70b74a08'),
('petparadise-disney-vest','5kgのミニチュアダックスで、胴回りがひもタイプのものが多い中、同じ形状を探して洗い替え用に選んだ体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/206746_10076924/1.1/','rakuten','206746_10076924:20220428:24e6e67d:6b6e49bf8a'),
('petparadise-disney-vest','サイズ表ではぎりぎりと思った8kgの柴犬でも着られ、まだ余裕がある。内側のメッシュも通気が良さそうな体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/206746_10076924/1.1/','rakuten','206746_10076924:20231020:482b8f69:5fc1f99a6e'),
('petparadise-disney-vest','5.2kgのシーズーで少し大きいが、背中のマジックテープで調整でき、胸のカーブでフィットする体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/206746_10076924/1.1/','rakuten','206746_10076924:20220310:d799bc9b:11ca22b887'),
('petparadise-disney-vest','5.3kgのポメラニアンでSSが少しきつくなりSにしたら大きすぎ、サイズ選びの難しさを感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/206746_10076924/1.1/','rakuten','206746_10076924:20221105:b68bc0d5:bd8b642886'),
('petparadise-disney-vest','胴回り35cm・3.5kgのトイプードルで、サイズ表とモデル犬を見てSSにしたが、面ファスナーを一番締めても余るほど大きく、リード留めの部分も緩かった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/206746_10076924/1.1/','rakuten','206746_10076924:20210420:25289a0c:9a0198fbce'),
('petparadise-strawberry-harness','4か月・2.2kgのカニンヘンダックスに3S。前足を入れる部分が少し大きく、抜けたら怖いと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/206746_10080812/1.1/','rakuten','206746_10080812:20260920:482b8f69:3e4b727d60'),
('petparadise-strawberry-harness','生後3か月・1.1kgのタイニープードルで4Sでも大きいが、室内の散歩練習には使えそうな体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/206746_10080812/1.1/','rakuten','206746_10080812:20241219:97fc360b:811243b8ec'),
('petparadise-strawberry-harness','3kgのトイプードルにSSがちょうど良く、軽いのにしっかりしていて反射板もある体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/206746_10080812/1.1/','rakuten','206746_10080812:20240604:28f49d39:44727333db'),
('petparadise-strawberry-harness','サイズ調整の金具が弱いのか散歩中に少しずつ緩み、10日ほどの間に2回頭から抜けて脱走しかけたため、怖くて使えなくなった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/206746_10080812/1.1/','rakuten','206746_10080812:20250301:482b8f69:95b4a1d232'),
('petparadise-strawberry-harness','シュナウザーでSは大きく、一つ下はぴちぴちで、サイズ展開がもう少し欲しいと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/206746_10080812/1.1/','rakuten','206746_10080812:20240412:19cac532:3b8355068f'),
('ezydog-quick-harness','マジックテープで微調整でき体型にぴったり合うが、胴輪部分が緩いと引っ張り方によっては頭からすぐ抜けるので注意が必要だと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/211165_10186796/1.1/','rakuten','211165_10186796:20120517:1c0ab7dd:d04c246cc2'),
('ezydog-quick-harness','前のハーネスを噛みちぎられて替えた。足を通すタイプは嫌がる時があったが、首をくぐらせてワンタッチで留めるので素早く着けられる体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/211165_10186796/1.1/','rakuten','211165_10186796:20120903:4d324ee8:b8c9e4105d'),
('ezydog-quick-harness','最初にサイズを合わせれば毎回の装着がとても簡単で、両足を通さなくて済むので老犬のラブラドールに助かっている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/211165_10186796/1.1/','rakuten','211165_10186796:20130321:482b8f69:8b3ed8c622'),
('ezydog-quick-harness','25kgの秋田犬に合ったが、首のマジックテープの伸ばし方が分かりにくく30分ほどかかった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/211165_10186796/1.1/','rakuten','211165_10186796:20190703:9c19786d:ecdfdc753a'),
('ezydog-quick-harness','2歳のゴールデンで、サイズ合わせに少し手こずったが、その後は1か所を留めるだけでワンタッチで着けられる体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/211165_10186796/1.1/','rakuten','211165_10186796:20190616:f41e5512:0cfd4d4b27'),
('ezydog-quick-harness','足を穴に通さなくてよいので落ち着きのない子でも簡単に着けられ、汚れても洗ってすぐ乾くという体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/211165_10186796/1.1/','rakuten','211165_10186796:20141003:482b8f69:564488e617'),
('ezydog-quick-harness','首輪を気にする子犬のためハーネスに替えたが、正しい付け方がよく分からず、調整しても足の付け根に当たって皮膚が擦れたという体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/211165_10186796/1.1/','rakuten','211165_10186796:20171023:76ba3a9a:06b8ca351d'),
('petio-zuttone-walking-hind','体重31kg台の犬で、コルクマットや屋外では歩けるがフローリングでは難しい状態。立てなくなってから嫌がられると困るので、今のうちから練習している体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/261122_10223746/1.1/','rakuten','261122_10223746:20161007:530e1bf9:4561bbf50a'),
('petio-zuttone-walking-hind','14歳のラブラドールの介護用に、まだ必須ではないが、あると安心なので用意した体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/261122_10223746/1.1/','rakuten','261122_10223746:20141215:482b8f69:ba95336025'),
('petio-zuttone-walking-hind','9歳で椎間板ヘルニアの手術後も後ろ足が立たないオスの犬で、きつく着けると排尿しにくく、緩めるといつの間にか外れるが、歩行補助として大助かりしている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/261122_10223746/1.1/','rakuten','261122_10223746:20190804:314e87a7:8eaf5d9227'),
('petio-zuttone-walking-hind','後ろ足から悪くなった大型犬の介護で、前足もリードで持ち上げながらリハビリのように歩かせている。もっと早く買えばよかったと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/261122_10223746/1.1/','rakuten','261122_10223746:20181111:05a22625:afea40641f'),
('petio-zuttone-walking-hind','大型犬用の3Lサイズがなかなか見つからずこれを選び、嫌がらずに着けてくれた。メッシュで手洗いできる点も良い体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/261122_10223746/1.1/','rakuten','261122_10223746:20200425:482b8f69:21545d97a6'),
('petio-zuttone-walking-hind','後ろ足が全く動かない犬を持ち上げて歩かせると、お尻周りが狭くなって排便が引っかかり、足の付け根も赤くなるため1日1回にしている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/261122_10223746/1.1/','rakuten','261122_10223746:20190116:d070f44f:3ec58a6fb5'),
('petio-zuttone-walking-hind','後ろ足の股関節を痛めた13歳の小柄なラブラドールで、着けやすいが少し大きく、持ち方が悪いと排尿で汚れる。洗ってすぐ乾く体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/261122_10223746/1.1/','rakuten','261122_10223746:20160316:482b8f69:1a4b1c43dd'),
('petio-zuttone-walking-hind','体重がある程度あり腰が全く上がらない状態ではあまり効果的に使えず、前足用と合わせた方が安定しそうだと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/261122_10223746/1.1/','rakuten','261122_10223746:20150715:db9eb927:bf6c3176ee'),
('petio-zuttone-walking-hind','脊椎症で時々後ろ足が上がらなくなる紀州犬ミックスで、足回りに合わせると腰回りが緩くなるため工夫して使う予定の体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/261122_10223746/1.1/','rakuten','261122_10223746:20210718:482b8f69:cd9c973811'),
('anisapo-harest','引っ張り癖が直らずゲホゲホしていたポメチワで、別の人気のハーネスから替えてみた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/352568_10017498/1.1/','rakuten','352568_10017498:20241104:dd1c9fed:7b1210594d'),
('anisapo-harest','気管虚脱が進みつつある16歳のチワワで、散歩中とても楽そうに歩き、手に伝わる感触も柔らかい。構造上少しごわつき冬服を着せにくい体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/352568_10017498/1.1/','rakuten','352568_10017498:20241223:482b8f69:fbd80b3eb3'),
('anisapo-harest','引っ張るとゼイゼイし、水を飲む時もむせることがある5.3kgのマルプーで、ぐいぐい引いても楽そうな体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/352568_10017498/1.1/','rakuten','352568_10017498:20240725:6522d742:85c9488e7f'),
('anisapo-harest','散歩が好きではなく早く帰ろうと引っ張ってゼェゼェしていたトイプードルで、帰宅後に咳や音が出たため受診し、喉に負担の少ないものとして選んだ体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/352568_10017498/1.1/','rakuten','352568_10017498:20211105:482b8f69:25de1fecd8'),
('anisapo-harest','短頭種気道症候群の手術後で気道が細めの10か月・5.5kgのシーズーにM。引いて走っても苦しくなさそうで元気に遊んでいる体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/352568_10017498/1.1/','rakuten','352568_10017498:20231216:482b8f69:df32b764a0'),
('anisapo-harest','引っ張りや吠えた時の引き戻しで首輪だと咳き込んでいた7.5kgのミックスで、首が締まらないので引き戻す時も気にしなくてよくなった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/352568_10017498/1.1/','rakuten','352568_10017498:20240823:482b8f69:0c8d6084d4'),
('anisapo-harest','老犬でたまに咳が出る14歳のシェルティに負担の少ないものとして選び、元気に散歩している体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/352568_10017498/1.1/','rakuten','352568_10017498:20240420:482b8f69:2a17fb73e6'),
('anisapo-harest','6.7kgの豆柴にM。ベルトでサイズは合わせたが、歩くと胸当て部分がぱかぱかし、別売りのカバーを付けると中でよれるという体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/352568_10017498/1.1/','rakuten','352568_10017498:20231109:482b8f69:aaa4d3b740'),
('anisapo-harest','首回り35cm・胴回り46cmと体型が変則的なフレブルで、問い合わせてMにしたらぴったりで、これまでより着け心地が良さそうな体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/352568_10017498/1.1/','rakuten','352568_10017498:20211019:482b8f69:c7e092411f'),
('anisapo-harest','咳が増えてきたシニア期の6kgのトイプードルで、興奮して引く時のために首に触れないものへ替えた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/352568_10017498/1.1/','rakuten','352568_10017498:20210608:c722b188:8e6669747e')
)
INSERT OR IGNORE INTO review_sources(review_id,source_type,source_url,source_platform,source_review_id)
SELECT r.id,s.source_type,s.source_url,s.source_platform,s.source_review_id
FROM new_sources s
JOIN reviews r ON r.product_id=s.product_id AND r.summary=s.summary;

WITH new_sources(product_id,summary,source_type,source_url,source_platform,source_review_id) AS (
VALUES
('truelove-soft-harness','しつけ用に使っているが、留め具はあまり丈夫ではなさそうでリード接続部もプラスチックなので、2本のリードで使うのが良いと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/374082_10000221/1.1/','rakuten','374082_10000221:20200315:1ae91b61:f9b05c4afd'),
('truelove-soft-harness','28kgのゴールデンで、ロングリードやプールで使い、背中の持ち手が飛びつきの制止やプールからの引き上げに役立つ体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/374082_10000221/1.1/','rakuten','374082_10000221:20200616:482b8f69:6e29c9331b'),
('truelove-soft-harness','いたずら好きでアジャスターを噛んで壊した2歳の柴犬で3本目。引いても簡単には抜けず、作りもしっかりしている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/374082_10000221/1.1/','rakuten','374082_10000221:20240713:1eb761cb:080c413a81'),
('truelove-soft-harness','力強く引っ張る中型犬で、ベルトがしっかりしているので安心してリピートしている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/374082_10000221/1.1/','rakuten','374082_10000221:20240319:37950cfc:0aa177bccc'),
('truelove-soft-harness','太めの豆柴にM。これまでで一番フィットし、犬も動きやすそうでリピートしている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/374082_10000221/1.1/','rakuten','374082_10000221:20230928:1eb761cb:37f8457082'),
('truelove-soft-harness','引っ張りがちな子犬期の中・大型犬で、胸側のフックにリードを付けるととてもコントロールしやすいと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/374082_10000221/1.1/','rakuten','374082_10000221:20191204:482b8f69:114b2ee934'),
('sevenbridge-dress-harness','細めの5kgのキャバリアにL。着丈はちょうど良いが肩回りがぶかぶかで、少し縫い縮めてぴったりにした体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/383415_10000218/1.1/','rakuten','383415_10000218:20230513:981f1287:80b36b42a5'),
('sevenbridge-dress-harness','3.4kgのチワワにMがぴったり。マジックテープとバックルの二重で留まるので安心な体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/383415_10000218/1.1/','rakuten','383415_10000218:20230605:482b8f69:be493268e9'),
('sevenbridge-dress-harness','4か月・2.3kgのマルチーズにMは少し大きいが、もう少し成長すればちょうど良くなりそうな体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/383415_10000218/1.1/','rakuten','383415_10000218:20230501:482b8f69:06dfbdb558'),
('sevenbridge-dress-harness','6か月・1.7kgのマルチーズにS。作りや縫製はしっかりしているが、まだぶかぶかだった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/383415_10000218/1.1/','rakuten','383415_10000218:20230814:482b8f69:f415a89461'),
('pomporis-3way-care-harness','まっすぐ立ち続けるのが難しい老犬で、足の間の採寸が2サイズにまたがり、大きいと後ろ足に生地が当たると考えて小さい方を選んだ体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/226723_10010551/1.1/','rakuten','226723_10010551:20240606:482b8f69:ba7aac3962'),
('pomporis-3way-care-harness','大型犬用の介助ハーネスをいくつか試して合わなかったが、前後の足から体全体を包む形でサイズ表記も細かく、ぴったり合い車の乗り降りにも使えそうな体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/226723_10010551/1.1/','rakuten','226723_10010551:20240329:eaea568b:00a9cf197d'),
('petsafe-easy-walk-deluxe','生まれつき首の骨の病気がある25kgのスタンダードプードルで、首輪ではなくこれをメインに使い、もともと少ない引っ張りもひどくなっていない体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/202898_10088682/1.1/','rakuten','202898_10088682:20260726:482b8f69:2389e142bf'),
('petsafe-easy-walk-deluxe','引っ張り癖で散歩が大変だった24kgのゴールデンにML。使った初日からほとんど引っ張らなくなり、高いので迷ったが買って良かったと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/202898_10088682/1.1/','rakuten','202898_10088682:20260619:482b8f69:c0cb9858a2'),
('petsafe-easy-walk-deluxe','同じものを長く使って古くなってきたため予備を買ったラブラドールで、使いやすく丈夫で引っ張り対策にも良いという体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/202898_10088682/1.1/','rakuten','202898_10088682:20260615:482b8f69:737611379b'),
('petsafe-easy-walk-deluxe','ものすごい力で引くゴールデンで、しつけのスクールの勧めで試したら、同じ犬とは思えないほど落ち着いて歩いた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/202898_10088682/2.1/','rakuten','202898_10088682:20231020:cd5479ae:dcceed94fb'),
('petsafe-easy-walk-deluxe','引っ張り癖がひどかった5か月のゴールデンにM。装着後は引っ張りがほとんどなくなった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/202898_10088682/2.1/','rakuten','202898_10088682:20221013:b30dca1c:7b466938de'),
('petsafe-easy-walk-deluxe','いつも下を向いてにおい嗅ぎに夢中で引っ張るラブラドールが、横について顔を上げて歩くようになった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/202898_10088682/2.1/','rakuten','202898_10088682:20211202:482b8f69:30d3b3645d'),
('petsafe-easy-walk-deluxe','胴回り63cm・22kgの小さめのミックスにMLを一番短くしてぴったり。従来品より作りがしっかりしていて安心な体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/202898_10088682/2.1/','rakuten','202898_10088682:20210825:ce9d1ad5:0643fcc3ca'),
('petsafe-easy-walk-deluxe','24kgのスタンダードプードルとボーダーコリーに使い、引っ張りが8割ほど減ったが、どうしても緩むので毎回調整が必要な体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/202898_10088682/2.1/','rakuten','202898_10088682:20201107:d128a216:e13902f7aa'),
('petsafe-easy-walk-deluxe','5か月・19kgのゴールデンにMLを一番小さくしてぴったり。初日で慣れて全然引っ張らなくなったが、耐久性は少し心配な体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/202898_10088682/2.1/','rakuten','202898_10088682:20240708:d26eeb02:6ab0b54cf2'),
('petsafe-easy-walk-deluxe','首輪ではゼーゼー言いながら引っ張っていた9か月のゴールデンで、1週間使ってお互いストレスなく散歩できている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/202898_10088682/2.1/','rakuten','202898_10088682:20211024:abb1469f:d075b7a562'),
('petsafe-easy-walk-deluxe','10か月のゴールデンで、一人でも散歩に行けるほど楽になったが、脇の下に毛玉ができるのが難点という体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/202898_10088682/3.1/','rakuten','202898_10088682:20240809:482b8f69:cebe2ce88e'),
('petsafe-easy-walk-deluxe','6か月・20kgのゴールデンで2本目。ほぼ引っ張らなくなるので手放せないが、1本目は噛みちぎられた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/202898_10088682/3.1/','rakuten','202898_10088682:20240201:336d7d45:734193e2cc'),
('petsafe-easy-walk-deluxe','生後半年頃の強い引きがこれでずいぶん楽になり、2歳の今も使っている32kgのゴールデンで、色あせたので買い替えた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/202898_10088682/3.1/','rakuten','202898_10088682:20230804:c1b07139:70a4e7774d'),
('petsafe-easy-walk-deluxe','8か月のゴールデンで前への引っ張りにはとても効くが、飛び上がったり後ろへ強く引いたりすると抜けることがあり、首輪も併用している体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/202898_10088682/3.1/','rakuten','202898_10088682:20220504:482b8f69:257a7dd2ca'),
('buddy-belt','3kg弱のトイプードルに3号。普段は一番小さい穴、冬はダウンを着て散歩するので大きめにしている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/230805_10000712/1.1/','rakuten','230805_10000712:20251023:576a1ad7:1bcd3a7233'),
('buddy-belt','腹囲34cm・3kgのスムースチワワに3号。薄手の服なら真ん中の穴でちょうど良く、高価だが気管に優しいので2本目を買った体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/230805_10000712/1.1/','rakuten','230805_10000712:20250613:482b8f69:8d4a94fe0b'),
('buddy-belt','首囲20cm・胴囲33cm・2.7kgのトイプードルに3号で、ベルトの穴がちょうど真ん中。犬も嫌がらない体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/230805_10000712/1.1/','rakuten','230805_10000712:20091022:482b8f69:1df4ce5bda'),
('buddy-belt','2.3kgと3kgの体格が違う小型犬2頭とも3号がちょうど良く、服を着ても脱いでも使える。革にオイルを塗ってさらに柔らかくしている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/230805_10000712/1.1/','rakuten','230805_10000712:20120821:bec8e378:4b3809b52b'),
('buddy-belt','首回りにハーネスが当たらず気管に優しいと感じ、チワワの子犬にも購入した。高価だが革がしっとりしている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/230805_10000712/1.1/','rakuten','230805_10000712:20100214:482b8f69:43093e332d'),
('buddy-belt','胸囲32cm・1.8kgの犬に3号で3本目。最初に買ったものは5年ほど使えている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/230805_10000712/2.1/','rakuten','230805_10000712:20210905:482b8f69:c1c10a6bd6'),
('buddy-belt','胴回り30cmのチワワに3号を一番きつい穴で使い、薄手の服なら同じ穴で大丈夫な体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/230805_10000712/1.1/','rakuten','230805_10000712:20090510:482b8f69:00ce0e4419'),
('buddy-belt','トリミングサロンで勧められて使い続けている8歳のマルチーズで、引っ張っても喉を圧迫しない体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/230805_10000712/2.1/','rakuten','230805_10000712:20230810:482b8f69:2665cf06fc'),
('buddy-belt','首輪の跡が毛並みに残ってしまった8か月のチワワに替え、厚めの服の上からも着けられる体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/230805_10000712/2.1/','rakuten','230805_10000712:20100826:107ba5b5:e57677469c'),
('buddy-belt','気管虚脱と診断された2.4kg・胴回り34cmのタイニープードルに3号。レビューを参考に選びサイズもちょうど良かった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/230805_10000712/2.1/','rakuten','230805_10000712:20230425:482b8f69:1f7f29465a'),
('buddy-belt','3個目のチワワで、サイズが小さくなったり革が少し伸びたりしたので買い替えた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/230805_10000712/3.1/','rakuten','230805_10000712:20230120:6b0b18db:ea7da2cc1b'),
('buddy-belt','6か月・1.8kgのチワワで、服なしは2号、冬服用に3号を買ったら大きく感じたが、もこもこの服やダウンの上からならちょうど良い体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/230805_10000712/3.1/','rakuten','230805_10000712:20221118:482b8f69:0b9092e560'),
('buddy-belt','前のものが小さくなって着けるのを嫌がっていた2.3kgのチワワで、3号に買い替えたらすんなり着けさせてくれた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/230805_10000712/3.1/','rakuten','230805_10000712:20190716:f5678a68:55debe0703'),
('buddy-belt','胴が太い2.8kgのヨーキーで3号は小さく4号に交換。最初は革が硬く脇の擦れが気になったため揉んで柔らかくした体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/230805_10000712/3.1/','rakuten','230805_10000712:20150912:83269105:0d95c97ed7'),
('terubell-wonderfit','頭と胴が細く、暴れた時にすっぽ抜けたことがある2歳・6.3kgの豆柴でリピート。使い始めてから全く心配がなくなった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/255000_10000657/1.1/','rakuten','255000_10000657:20260317:7fcef847:f765a3c66e'),
('terubell-wonderfit','いろいろ怖がって後ずさりする5か月・9kgの元野犬の子犬に、調整を短めにしてちょうど良く、当分使えそうな体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/255000_10000657/1.1/','rakuten','255000_10000657:20260909:57fa3743:858aa7cd90'),
('terubell-wonderfit','脱走防止が重要な元野犬の14kgの中型犬にXL。前年に買ったものも今も使えている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/255000_10000657/1.1/','rakuten','255000_10000657:20260808:482b8f69:804a80aeec'),
('terubell-wonderfit','首輪のすっぽ抜けを経験し、頑丈だが硬いハーネスでは当たる部分の毛が薄くなったため、柔らかいがしっかりした素材のこれを選んだ体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/255000_10000657/1.1/','rakuten','255000_10000657:20260120:992cd9e0:7d8b4f2638'),
('terubell-wonderfit','怖いと逃げようとして別のハーネスから抜けたことがある、保護犬で怖がりな5歳・4kgのチワワにM。不器用でも簡単に着けられ、抜けずに助かっている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/255000_10000657/1.1/','rakuten','255000_10000657:20251127:482b8f69:712ceba38b'),
('terubell-wonderfit','1歳・12.2kgの柴犬で3回目の購入。怖がりで後ずさりしたり暴れたりしても抜けたことがなく、締め付けもきつくない体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/255000_10000657/1.1/','rakuten','255000_10000657:20251102:482b8f69:5c4c979ad0'),
('terubell-wonderfit','怖がりで後ずさりし、ハーネスが抜けていた1歳・5kgのトイプードルにS。しっかり保持されて今のところ抜けていない体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/255000_10000657/2.1/','rakuten','255000_10000657:20251110:a26ebc6e:e1ca9a9dee'),
('terubell-wonderfit','気管虚脱と診断された15歳・15kgの柴犬で、前足を通すのも首を通すのも嫌がったが、首の部分を大きく広げられるので着脱が楽になった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/255000_10000657/3.1/','rakuten','255000_10000657:20260725:59f0197f:07296b3ee9'),
('terubell-wonderfit','首輪類を見せると逃げ回る7か月・4.3kgの豆柴で、追いかけっこはなくならないが、足を通すタイプより頭を通すだけで楽になった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/255000_10000657/3.1/','rakuten','255000_10000657:20260721:482b8f69:c805893924'),
('terubell-wonderfit','胸元全体を覆うタイプが苦手な2歳・4.5kgのパピヨンで、最初は戸惑ったがすぐ慣れた。布製に比べ少し硬さが気になる体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/255000_10000657/3.1/','rakuten','255000_10000657:20260516:cc2f7e4b:b4553d985f')
)
INSERT OR IGNORE INTO review_sources(review_id,source_type,source_url,source_platform,source_review_id)
SELECT r.id,s.source_type,s.source_url,s.source_platform,s.source_review_id
FROM new_sources s
JOIN reviews r ON r.product_id=s.product_id AND r.summary=s.summary;

WITH new_sources(product_id,summary,source_type,source_url,source_platform,source_review_id) AS (
VALUES
('terubell-wonderfit','細身でハーネスが抜けることがあった犬で、替えてからはそのはらはらがなくなり、装着もしやすい体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/255000_10000657/3.1/','rakuten','255000_10000657:20260508:482b8f69:98ea32c2ed'),
('terubell-wonderfit','頑丈さ重視で150g以上のH型を使っていた9.8kgのビーグルで、59gと軽いのに抜けず、柔らかく着けやすい体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/255000_10000657/3.1/','rakuten','255000_10000657:20260406:482b8f69:69e0d09a71'),
('terubell-wonderfit','新しいハーネスを着けるとハウスから出てこなくなるほどハーネス嫌いな16kgの中型犬が、これは比較的早く慣れて歩いてくれた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/255000_10000657/3.1/','rakuten','255000_10000657:20260321:482b8f69:df3c4a7a7b'),
('radica-cordura-harness','毛量の多い5kgのポメラニアンで、少し大きすぎた気もするが毛が多いのでちょうど良いかもしれないと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/255378_10021956/1.1/','rakuten','255378_10021956:20260304:77e545ac:ec750b62ee'),
('radica-cordura-harness','鳩胸で合うハーネスがなく、マジックテープも苦手で着けると動かなくなっていたスムースチワワで、着けやすく柔らかいこれは使えた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/255378_10021956/1.1/','rakuten','255378_10021956:20260905:872e5f90:1af6d99c24'),
('radica-cordura-harness','首回り29cm・胴回り44cm・6kgのトイプードルにぴったり。撥水加工で清潔に保てるが、前のものより生地のクッション性は少ない体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/255378_10021956/1.1/','rakuten','255378_10021956:20260822:c3f62c21:ed35c2eaa4'),
('radica-cordura-harness','金具が少なく体に当たりにくく、胸周りの太さにも調整が効くので、子犬で迎えた時から成犬になるまで使えたチワワの体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/255378_10021956/2.1/','rakuten','255378_10021956:20251104:cce09daa:6f18fdf8a8'),
('radica-cordura-harness','2.5kgのチワワにS。生地は硬めだが丈夫そうで、リードのバックルでショルダーバッグにも付けられる。厚手の服ならMでも良かった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/255378_10021956/2.1/','rakuten','255378_10021956:20251030:482b8f69:955f91871c'),
('radica-cordura-harness','がっちりした9.3kgのキャバリアにLLがちょうど良く、いくつ買ったか分からないほどずっと使い続けている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/255378_10021956/2.1/','rakuten','255378_10021956:20260728:f8fdcb2a:7ad947f7e7'),
('radica-cordura-harness','5kg弱で鳩胸のダックスを包み込み、服に関係なくサイズ調整せずにクリップを留めるだけで使える体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/255378_10021956/3.1/','rakuten','255378_10021956:20251223:482b8f69:a15419d611'),
('radica-cordura-harness','2.4kgのチワワにSがぴったりで、裸でも厚めの服でも調整して使える体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/255378_10021956/3.1/','rakuten','255378_10021956:20251203:482b8f69:eab22d1799'),
('suzukoubou-standard','28kgのサモエドにLL、6kgのミックスの子犬にMをおそろいで使い、子犬も動きやすそうに走っている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/278852_10001829/1.1/','rakuten','278852_10001829:20251112:482b8f69:95122cd647'),
('suzukoubou-standard','太めで首はM、体はLという豆柴で、寒くなり服を着るようになったのでLにして良かった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/278852_10001829/1.1/','rakuten','278852_10001829:20251204:7a88a67d:2ab7a50104'),
('suzukoubou-standard','胴回り71cmの10か月のフラットコーテッドにLL。まだ大きくなりそうだが調整で成犬まで使えそうで、大型犬でもしっかりフィットする体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/278852_10001829/2.1/','rakuten','278852_10001829:20260609:a31f8fd4:b94fbd7990'),
('suzukoubou-standard','引っ張りが強くても抜けない、胴回り54cmのダックスにL。6〜7年前に買ったものもまだ使えるが、汚れが気になって新調した体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/278852_10001829/2.1/','rakuten','278852_10001829:20260506:d8acb207:0fd97093ef'),
('suzukoubou-standard','7.8kgのビーグルで、頑丈な作りで後ずさりで抜けたり切れたりする心配がない体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/278852_10001829/2.1/','rakuten','278852_10001829:20250504:f54df42e:93e279da59'),
('suzukoubou-standard','胴の短いフレブルで、胴回り64cmほどになりこれまでのサイズがきつくなったため、ショップに相談してサイズを選び直した体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/278852_10001829/2.1/','rakuten','278852_10001829:20241031:482b8f69:aa62a3d499'),
('suzukoubou-standard','引っ張り癖のある11kgと8kgの柴犬に使い、しっかりした作りで抜けないが、頭と脚を毎回通すのが面倒という体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/278852_10001829/2.1/','rakuten','278852_10001829:20250115:f7f07371:bdc46421d6'),
('suzukoubou-standard','10か月・2kg未満のチワワで、後ずさりしても抜けにくく、着け心地も良さそうで楽しく散歩できている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/278852_10001829/3.1/','rakuten','278852_10001829:20250726:5d4f061f:125d175d4a'),
('suzukoubou-standard','これまで3つのハーネスがどれもするっと抜けて怖い思いをした9か月・3kgのトイプードルにSS。体にぴたっと合い全く抜けない体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/278852_10001829/3.1/','rakuten','278852_10001829:20250310:c3b5eebf:f1740486a0'),
('happy-heel-harness','柴犬で使い、引っ張らなくなるというより引っ張れなくなる仕組みで、早く行きたい時は歩きにくそうだが、飼い主の負担は減った体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/309454_10000259/1.1/','rakuten','309454_10000259:20200311:482b8f69:5cd8538265'),
('happy-heel-harness','前足を通すタイプでは子どもが散歩させられないほど引いた1歳のレトリバーで、強く引くと立ち止まりこちらを向く姿勢になる体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/309454_10000259/1.1/','rakuten','309454_10000259:20150222:0f719a87:bf7ea3d5c9'),
('happy-heel-harness','しつけはしていても外では興奮しやすく、すれ違う犬や猫で制御が大変だった3歳・30kgのゴールデンで、引っ張りが激減した体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/309454_10000259/1.1/','rakuten','309454_10000259:20240815:2d1d419a:31255ca4ba'),
('happy-heel-harness','前足が宙づりになるほど進もうとし、ハーハー言っていた13か月・10.5kgのビーグルにM。そうした歩き方がなくなり散歩がかなり楽になった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/309454_10000259/1.1/','rakuten','309454_10000259:20210618:384b8e37:b797018836'),
('happy-heel-harness','引っ張り癖の強い1歳・8kgのジャックラッセルで、部屋を出る前に落ち着かせる練習と組み合わせて効果があった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/309454_10000259/1.1/','rakuten','309454_10000259:20200402:482b8f69:679027d3ce'),
('happy-heel-harness','胴回り71cmの小柄なラブラドールにLを最小にして使用。まだ2回目だが前より引っ張らなくなったように感じ、慣れれば装着も簡単な体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/309454_10000259/1.1/','rakuten','309454_10000259:20150607:5975e732:c097700244'),
('happy-heel-harness','引っ張り癖がひどい保護犬で、半信半疑だったが、引かれた時の力のかかり方がまるで違うと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/309454_10000259/2.1/','rakuten','309454_10000259:20190726:482b8f69:6cd0a10068'),
('happy-heel-harness','成長とともに引っ張りが強くなり、1日2回2時間の散歩で手足腰が痛かった7か月のボーダーコリーで、1週間足らずで驚くほど引っ張らなくなった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/309454_10000259/2.1/','rakuten','309454_10000259:20201115:482b8f69:111e321cf7'),
('happy-heel-harness','足が短く細いため似たハーネスでは足がすぐ抜けた4kgのプーダックスで、最初は調整が悪く暴れた時に足が抜けたが、合わせ直して使えている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/309454_10000259/2.1/','rakuten','309454_10000259:20150625:a74bf1aa:1acad6fa60'),
('happy-heel-harness','29kgの黒ラブにL。いろいろな道具で失敗してきたが、意外に良く、力を入れなくても簡単に抑えられた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/309454_10000259/2.1/','rakuten','309454_10000259:20200802:8d339861:7e474769c4'),
('happy-heel-harness','引っ張りがかなり強い1歳の柴風ミックスで、散歩が劇的に楽になり、力比べをせずゆっくり歩けるようになった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/309454_10000259/2.1/','rakuten','309454_10000259:20200728:482b8f69:ad28f94cdd'),
('happy-heel-harness','引っ張りが強い1歳のビーグルで、胸筋が発達しているためMを選択。最初の装着は悪戦苦闘したが慣れれば大丈夫な体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/309454_10000259/2.1/','rakuten','309454_10000259:20151004:482b8f69:44ea85c949'),
('happy-heel-harness','脱臼しそうなほど引っ張っていた1歳の黒ラブで、付属のDVDどおりに着けたところ効果に驚いた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/309454_10000259/3.1/','rakuten','309454_10000259:20150724:d84d7d38:54546426eb'),
('happy-heel-harness','ゼーゼーするほど引っ張っていた5か月の雑種で、トレーニング中だが前よりは引かなくなり、リードを引くとこちらを見るようになった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/309454_10000259/3.1/','rakuten','309454_10000259:20150412:482b8f69:4e31e27054'),
('happy-heel-harness','外に出ると嬉しくて飼い主を引っ張り回す大きめのポメラニアンで、勝手な方向へ行くとテンションがかかってこちらを見るが、まだ「早く行こう」という様子の体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/309454_10000259/3.1/','rakuten','309454_10000259:20150322:482b8f69:445c5620c3'),
('truelove-handle-harness','前に使っていたXLが色あせ、大きくて脱げそうになっていた25kgのハスキーにL。ひもを最大まで伸ばしてぴったりだった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/378148_10000034/1.1/','rakuten','378148_10000034:20251222:0358ecbb:2f7f47cc9e'),
('truelove-handle-harness','11歳の老犬のラブラドールで、同じハーネスの方が体に負担がないと思い2本目を購入。胴のベルトがいつも裏返ってしまう点は気になる体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/378148_10000034/1.1/','rakuten','378148_10000034:20251118:8e228ba8:6a48f498aa'),
('truelove-handle-harness','後ずさりも引っ張りもある13kg弱の柴犬で3年使っても劣化はほとんどなく、バックルがプラスチックなので念のため早めに買い替えた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/378148_10000034/1.1/','rakuten','378148_10000034:20241104:482b8f69:98effd9f97'),
('truelove-handle-harness','帰るのを嫌がって踏ん張ることが多い11kgの犬で、踏ん張っても抜けたことはない体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/378148_10000034/2.1/','rakuten','378148_10000034:20220424:482b8f69:c0cf6e31ce'),
('truelove-handle-harness','首輪だと引っ張り回す細身の9kgの柴犬に、すっぽ抜けしない頑丈なものとしてSを選び、胴回りは最大に伸ばしてぴったりだった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/378148_10000034/2.1/','rakuten','378148_10000034:20210416:482b8f69:b7150ff677'),
('truelove-handle-harness','まだ自分で歩けるが加齢で足を痛めた15歳・20kgのミックスで、段差を補助する時に面で支えられるのが良いと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/378148_10000034/2.1/','rakuten','378148_10000034:20230508:482b8f69:0caa8d5fdc'),
('truelove-handle-harness','骨太で背が高い23kgのボーダーコリーにL。届いたままではきつく感じたが、長さを調整したらぴったりだった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/378148_10000034/2.1/','rakuten','378148_10000034:20210809:482b8f69:bc1f3c5b34'),
('truelove-handle-harness','頭が大きく、先にサイズを合わせると頭が通らないため毎回調整が必要。初めて着けた時は大暴れしたが、2回目から上手に散歩できた10kgほどの犬の体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/378148_10000034/2.1/','rakuten','378148_10000034:20210430:b027fb84:9498b0998f'),
('truelove-handle-harness','顔が小さく胸板が厚い豆柴で、他のハーネスは踏ん張った時に頭から抜けたが、これと首輪を併用すると全く抜けない体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/378148_10000034/3.1/','rakuten','378148_10000034:20221218:996144a6:cfba90947f'),
('truelove-handle-harness','胴長で胴回り60cmのボーダーコリーにM。脇の下が少し窮屈そうで、前の丈がもう数センチ長ければと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/378148_10000034/3.1/','rakuten','378148_10000034:20211018:86ee3ec6:364041697b'),
('truelove-handle-harness','引っ張り癖があり首輪では首の負担が気になっていた胴回り56cm・10.5kgのビーグルで、相談してMにして正解だった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/378148_10000034/3.1/','rakuten','378148_10000034:20210913:482b8f69:fc5fe556df'),
('truelove-handle-harness','5kgほどの成犬のダックスと5か月のシェルティにS。首輪では引っ張り癖があったが、ハーネスだと少し落ち着く体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/378148_10000034/3.1/','rakuten','378148_10000034:20200428:bf2c4b12:8111420259'),
('truelove-handle-harness','胸囲70cm・24kgの柴とシェパードのミックスで、調整したらぴったりになり、ハーフチョークと2本のリードで散歩している体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/378148_10000034/3.1/','rakuten','378148_10000034:20210928:4545b141:80942f037d'),
('julius-k9-idc-power','引っ越し後の散歩を楽しくするため初めてハーネスにした10歳・10kgの黒柴で、最初は前後を間違えて着けたが、動画を見直して付け直したら合った体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208747_10000922/4.1/','rakuten','208747_10000922:20201028:482b8f69:b8ee832fb0'),
('julius-k9-idc-power','軽いのにしっかりした作りで、サイズ調整の幅も広く服の上からでも着けられそう。黒柴が最初から嫌がらずに着けてくれた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208747_10000922/4.1/','rakuten','208747_10000922:20231126:3c1d5290:9e19cbc7ad')
)
INSERT OR IGNORE INTO review_sources(review_id,source_type,source_url,source_platform,source_review_id)
SELECT r.id,s.source_type,s.source_url,s.source_platform,s.source_review_id
FROM new_sources s
JOIN reviews r ON r.product_id=s.product_id AND r.summary=s.summary;

WITH new_sources(product_id,summary,source_type,source_url,source_platform,source_review_id) AS (
VALUES
('julius-k9-idc-power','元野犬の保護犬でとても怖がりで、怖がると後ずさりしてハーネスを抜く。前のものは抜け方を覚えてしまい、首を通すだけで着けやすいこれに替えた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208747_10000922/4.1/','rakuten','208747_10000922:20161023:0118b328:631e0c5589'),
('julius-k9-idc-power','他の犬と遊んでいる時に首輪が抜けたことがあり、ハーネスはあまり好きではなかったが9.7kgの柴犬にMini。最初にサイズを合わせれば頭からくぐらせて留めるだけで楽な体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208747_10000922/5.1/','rakuten','208747_10000922:20180220:4321520a:a5bbc08cd7'),
('julius-k9-idc-power','ぐんぐん引っ張る7kgのパグに頑丈なものとしてMini。頭にかぶせてお腹で留めるだけで、引いてもしっかり支えてくれる体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208747_10000922/5.1/','rakuten','208747_10000922:20180104:4bbaada0:eb629700c7'),
('julius-k9-idc-power','7.4kgのジャックラッセルにぴったり。引いた時に首から抜けそうに見えるが脇でしっかり固定されている。使い始めは脇が少し擦れるようだった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208747_10000922/5.1/','rakuten','208747_10000922:20210729:887f8f45:98effdbca1'),
('julius-k9-idc-power','引っ張り癖がひどく首輪ではゼェゼェしていた1歳・10kgの柴プーで、高いので迷ったが、首に負担の少ないものとして選んだ体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208747_10000922/5.1/','rakuten','208747_10000922:20201212:29357db2:9d91ac3df6'),
('julius-k9-idc-power','前のハーネスの継ぎ目の金具が壊れて危ない目に遭った1歳・9kgのシュナウザーで、頑丈で安全なものとしてMiniを選んだ体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208747_10000922/5.1/','rakuten','208747_10000922:20190523:482b8f69:da342d08cc'),
('julius-k9-idc-power','前のものを噛み砕いたイタグレでワンサイズ上を買い直し、背中の持ち手でドッグランでもさっと引き寄せられ、抱っこの補助にもなる体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208747_10000922/5.1/','rakuten','208747_10000922:20181119:482b8f69:9ddff09ce7'),
('julius-k9-idc-power','首回り28cm・胸囲46cm・8kgの犬でMiniと迷い、体重よりフィット感を優先するよう助言されてMiniMiniを最大幅で使っている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208747_10000922/6.1/','rakuten','208747_10000922:20151015:df1098a4:bb0591345b'),
('julius-k9-idc-power','外は好きだがハーネスを嫌がる6.4kgのミックスで、頭からかぶせて胸で留めるだけと簡単。ドッグランや車の乗り降りで背中の持ち手が活躍している体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208747_10000922/6.1/','rakuten','208747_10000922:20150119:ae642420:35fd4013f2'),
('julius-k9-idc-power','自分からぐんぐん進むため首輪だと首が締まるのが気になっていた8歳のビーグルにMini。ハーネスを見せると喜んで飛び跳ねた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208747_10000922/6.1/','rakuten','208747_10000922:20240714:104e398f:52588800e3'),
('julius-k9-idc-power','7kgの少し大きめの豆柴で、体はぴったりでも首回りが苦しそうだったため、ワンサイズ大きいものに交換した体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208747_10000922/6.1/','rakuten','208747_10000922:20220122:482b8f69:3abb776928'),
('julius-k9-idc-power','飛び出し癖があり四方八方に力いっぱい引っ張る4歳・11kgのコーイケルホンディエで、採寸ではMiniMiniだったが合わずMiniに交換してぴったりだった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208747_10000922/6.1/','rakuten','208747_10000922:20211225:8b0b50eb:d5a79f5a42'),
('julius-k9-idc-power','首回りを調整できないハーネスで3回逃げられたことがあり、価格より安全を優先して選んだ。ショップからは形状上絶対に抜けないとは言えないと説明を受けた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208747_10000923/4.1/','rakuten','208747_10000923:20161117:8cbfdcaf:4ece753df2'),
('julius-k9-idc-power','長年使った旧型のベルトがくたびれた7歳のゴールデンで、買い替えたこのモデルの方が良いと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208747_10000923/4.1/','rakuten','208747_10000923:20150702:099fa8cb:f9c99a6ab2'),
('julius-k9-idc-power','28kgのシェパード、22kgと25kgのラブラドール、6.5kgのジャックラッセルの4頭すべてで色違いを使っている。ベルトは少し硬めに感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208747_10000923/4.1/','rakuten','208747_10000923:20211023:482b8f69:777c222cd8'),
('julius-k9-idc-power','6か月・20kgのラブラドールの子犬にサイズ0。やや大きかったが胴と首を調整でき抜けることはなく、成長しても長く使えそうな体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208747_10000923/4.1/','rakuten','208747_10000923:20200917:1670332a:de70dd5d80'),
('julius-k9-idc-power','胸囲75cm・25kgと胸囲78cm・29kgのゴールデン2頭にサイズ1。胴ベルトを最大から2〜3cm短くした状態でぴったりだった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208747_10000923/4.1/','rakuten','208747_10000923:20190425:482b8f69:efb82eda68'),
('julius-k9-idc-power','細いハーネスでは少し引いただけでゲホゲホしていた犬で、胸に太いベルトがかかるこれではゲホゲホ言わなくなった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208747_10000923/4.1/','rakuten','208747_10000923:20190419:12846f56:039e0dc90c'),
('julius-k9-idc-power','旧型では胴ベルトが前足の付け根に食い込みよれてきたが、改良されたこのモデルは丈夫で、40kgのバーニーズにも安心して使える体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208747_10000923/4.1/','rakuten','208747_10000923:20130502:482b8f69:58080be7ee'),
('julius-k9-idc-power','15kgの大きめのコーギーにサイズ0。脇の方は合ったが首側が大きく歩くとずれるため、余ったマジックテープを切って縫い留めようとしている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208747_10000923/4.1/','rakuten','208747_10000923:20230630:482b8f69:15b4c56b5c'),
('julius-k9-idc-power','あまり引かないが、首輪では気道が心配な年齢になってきた10歳・30kgのゴールデンにサイズ1。調子が良いので、引っ張り癖のあるもう1頭にも使うことにした体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208747_10000923/4.1/','rakuten','208747_10000923:20200930:e2ec855d:cd25646c1e'),
('julius-k9-idc-power','少しむちむちした1歳・20kg弱のハスキーにサイズ0。首回りはいっぱいに絞り、胸回りは半分ほど伸ばしてちょうど良かった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208747_10000923/5.1/','rakuten','208747_10000923:20191127:315543b1:d0e87e54b5'),
('julius-k9-idc-power','ラブラドールとボーダーコリー2頭の3頭散歩で、ぐいぐい引くボーダーコリーの引っ張り癖がおさまっていった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208747_10000923/5.1/','rakuten','208747_10000923:20190522:d47f3e91:d274dc1fef'),
('julius-k9-idc-power','リードをぐいぐい引いて息切れがひどかった5か月の黒ラブで、一番締めた状態でぴったり。以前ほど息切れしなくなった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208747_10000923/5.1/','rakuten','208747_10000923:20181126:482b8f69:b6269ca6b0'),
('julius-k9-idc-power','体重22kgと小さめだが毛量の多いサモエドにサイズ1。引っ張った時に左手でリードを引くと体に伝わるらしく、引くのをやめる体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208747_10000923/5.1/','rakuten','208747_10000923:20170127:bf47e5bf:6dd62f1800'),
('julius-k9-idc-power','首輪で後ずさりした時に3度ほど抜けて怖い思いをしたシェパードで、このハーネスなら簡単には抜けないと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208747_10000923/5.1/','rakuten','208747_10000923:20150918:02e2c37a:d0d7bc8b11'),
('julius-k9-idc-power','ワンサイズ小さめに買い直したホワイトシェパードにぴったりで、ライトホルダーに懐中電灯を付けると夜の散歩でも足元がよく見える体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208747_10000923/5.1/','rakuten','208747_10000923:20141213:02006ff0:9bb71ab092')
)
INSERT OR IGNORE INTO review_sources(review_id,source_type,source_url,source_platform,source_review_id)
SELECT r.id,s.source_type,s.source_url,s.source_platform,s.source_review_id
FROM new_sources s
JOIN reviews r ON r.product_id=s.product_id AND r.summary=s.summary;

SELECT COUNT(*) AS dog_harness_product_count FROM products WHERE category='dog-harness' AND active=1;
SELECT COUNT(*) AS dog_harness_review_count FROM reviews r JOIN products p ON p.id=r.product_id WHERE p.category='dog-harness' AND p.active=1;
SELECT COUNT(*) AS dog_harness_review_source_count FROM review_sources s JOIN reviews r ON r.id=s.review_id JOIN products p ON p.id=r.product_id WHERE p.category='dog-harness' AND p.active=1;
