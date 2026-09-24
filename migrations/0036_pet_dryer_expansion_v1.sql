PRAGMA foreign_keys = ON;

WITH new_reviews(product_id,dog_breed,dog_size,coat_type,needs,summary,source_type,source_url) AS (
VALUES
('petaboo-l400','イングリッシュコッカースパニエル','medium','long','speed paws sound','人用ドライヤーでは毛量が多く重労働だったが、風量を上げても音に強く反応せず、乾燥時間がほぼ半分になり指の間までしっかり乾かせた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/405945_10000167/1.1/'),
('petaboo-l400','バーニーズマウンテンドッグ','large','long','large speed','普通のドライヤー2台で乾かしていたバーニーズに使い、乾燥効率が大きく上がったと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/405945_10000167/1.1/'),
('petaboo-l400','超大型犬のパピー','large',NULL,'puppy scared acclimation fluffy hose','大きな音が苦手な超大型犬の子犬に最初は弱風で使い、時間はかかっても全身をしっかり乾かしてふわふわに仕上げた体験。成長に合わせて風量を上げたい一方、ホースはもう少し長いと感じた。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/405945_10000167/1.1/'),
('petaboo-l400','犬種不明',NULL,NULL,'speed shine gentle-heat','人用ドライヤーより温風は低めだが、風量18程度でも足元や地肌まで乾き、以前より早くツヤのある仕上がりになったと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/405945_10000167/1.1/'),
('petaboo-l400','犬種不明・自宅シャンプー',NULL,NULL,'quiet lightweight hose','本体が軽く風量も十分で、犬も強く嫌がらず使えた一方、ホースが短く取り回しにはもう少し余裕が欲しいと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/405945_10000167/1.1/'),
('petaboo-l400','ビションフリーゼ','small','curly','professional speed finish storage','トリマーが自宅のビションに使い、強風でまず水気を飛ばしてからブラシ仕上げをすると人用ドライヤーだけより大幅に早く、収納性も高く評価した体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/405945_10000167/1.1/'),
('petaboo-l400','大型犬・音に興奮しやすい','large',NULL,'scared acclimation speed','初めて見る機械と音に最初は落ち着かなかった大型犬が、使ううちに徐々に慣れ、風量を上げるほど速く乾かせた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/405945_10000167/1.1/'),
('petaboo-l400','ダブルコート犬',NULL,'double','speed fluffy shine','人用ドライヤーでは乾きにくかったダブルコートの犬に使い、乾燥時間が短くなり、ふわふわ・つやつやに仕上がったと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/405945_10000167/1.1/'),
('petaboo-l400','犬種不明・長めの被毛',NULL,'long','speed fluffy hose','温風30程度で全体に風を当てると人用ドライヤーより早く乾き、数日たってもふわふわ感が続いた一方、ホースの短さは気になった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/405945_10000167/1.1/'),
('petaboo-l400','犬3頭',NULL,NULL,'multi speed fluffy noise','3頭を人用ドライヤーで乾かす負担から導入し、風量を上げるほど音も大きくなるが犬たちは強く気にせず、乾きが早くふわふわに仕上がった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/405945_10000167/1.1/'),
('dogone-quick-dry','スタンダードプードル・3か月','large','curly','puppy acclimation stand root-dry','3か月のスタンダードプードルの初シャンプー後に、弱風から慣らして使用。最大風量では音も大きいが毛の根元までしっかり乾かせ、キャスター付きスタンドも扱いやすかった体験。','public_buyer_review_summary','https://item.rakuten.co.jp/ssfortuna/drstset-white/'),
('dogone-quick-dry','柴犬','medium','double','skin-sensitive speed quiet','皮膚炎を繰り返さないよう自宅でしっかり乾かす目的で導入し、思ったより静かな音で地肌が見えるほど風が届き、速乾性を実感した体験。','public_buyer_review_summary','https://item.rakuten.co.jp/ssfortuna/qd-bk/'),
('dogone-quick-dry','犬種不明・トリマー経験者の愛犬',NULL,NULL,'professional temperature power value','高額なプロ用機と比較してもパワー差は小さく、温度も犬の皮膚や被毛へ負担をかけにくい程度と感じ、価格を含めて満足した体験。','public_buyer_review_summary','https://review.rakuten.co.jp/review/item/1/295394_10007730/1.1/'),
('dogone-quick-dry','コーギー2頭','medium','double','multi speed low-heat','2頭のコーギーを乾かす時間が大きく短くなった一方、温風はもう少し高くてもよいと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/review/item/1/295394_10007730/1.1/'),
('dogone-quick-dry','スタンダードプードル3頭','large','curly','multi speed stand scared','毛量の多いスタンダードプードル3頭に使い、1頭あたり約45分で概ね乾燥。高さ・角度調整が便利で、最初は音に驚いた犬も徐々に慣れた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/review/item/1/295394_10007730/1.1/'),
('dogone-quick-dry','大型犬','large',NULL,'speed stand','以前のブロワーでは約50分かかっていた大型犬が約30分で乾き、専用スタンドで落下を気にせず作業しやすかった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/282253_10008403'),
('dogone-quick-dry','ゴールデンレトリバー','large','long','speed scared low-heat','普通のドライヤーと扇風機よりは早く乾いたが、音を気にして途中で止めながら使い、温風もぬるめに感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/277064_10021176/1.1/'),
('dogone-quick-dry','犬種不明・ハンドドライヤー2台から変更',NULL,NULL,'noise temperature-adjust compact','ハンドドライヤー2台の大きな音と温度調整の難しさから切り替え、風量と温度を調整でき、業務用よりコンパクトで扱いやすいと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/review/item/1/295394_10007730/1.1/'),
('morisawa','犬の幼稚園で複数頭',NULL,NULL,'multi speed quiet professional','プール遊び後など複数の犬に使い、強い風が被毛の奥まで届いて乾燥時間が短くなり、想像より音も静かで作業効率が上がった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=petgoods002&store_id=morisawa5628'),
('morisawa','犬3頭・ダブルコート',NULL,'double','multi speed scared finish','人用ドライヤーで3頭を乾かしていた家庭で使用し、風が地肌まで届いて時短でき、以前ドライヤーを嫌がっていた犬たちも大人しく乾かせ、ふわふわに仕上がった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=petgoods002&store_id=morisawa5628'),
('morisawa','大型犬・体毛約4.5cm','large','long','speed scared hose-heat','毛の長い大型犬で約15分で乾かせるほど風量が強かった一方、音で犬が逃げ回り、ホースがかなり熱くなる点も気になった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=petgoods002&store_id=morisawa5628'),
('morisawa','ゴールデンレトリバー','large','long','speed fluffy low-heat','ゴールデンに使い、人用ドライヤーより早い30〜40分ほどで乾き、柔らかい温風でふわっと仕上がった一方、毛が広く舞うため掃除が必要だった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=petgoods002&store_id=morisawa5628'),
('morisawa','ラブラドールレトリバー','large','short','skin-sensitive scared acclimation','膿皮症で週1回の薬用シャンプーが必要なラブラドールに導入。風力は十分だが音に驚いて逃げたため、つけたまま音へ徐々に慣らしている体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=petgoods002&store_id=morisawa5628'),
('morisawa','犬種不明・トリマーの家庭犬や友人犬',NULL,NULL,'professional low-heat finish value','元トリマーが家庭犬や友人の犬に使い、普通のドライヤーより低温で皮膚へ配慮しやすく、プードル系の毛も伸ばしながら乾かしやすいと評価した体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=petgoods002&store_id=morisawa5628'),
('morisawa','犬種不明・散歩後の足洗い',NULL,NULL,'frequent-wash speed','雨続きで散歩後に足を洗うたび人用ドライヤーで乾かす負担が大きかったが、導入後は乾燥時間が圧倒的に短くなった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=petgoods002&store_id=morisawa5628')
)
INSERT INTO reviews(product_id,dog_breed,dog_size,coat_type,needs,summary,source_type,source_url)
SELECT n.product_id,n.dog_breed,n.dog_size,n.coat_type,n.needs,n.summary,n.source_type,n.source_url
FROM new_reviews n
WHERE NOT EXISTS (
  SELECT 1 FROM reviews r
  WHERE r.product_id=n.product_id
    AND r.summary=n.summary
);
