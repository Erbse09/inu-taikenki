PRAGMA foreign_keys = ON;

WITH new_reviews(product_id,dog_breed,dog_size,coat_type,needs,summary,source_type,source_url) AS (
VALUES
('shizenryu-all','犬種不明・リピーター',NULL,NULL,'fluffy scent','洗い上がりがふわふわになり、香りも気に入ってコンディショナーと併用している体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/239893_10001167/1.1/'),
('shizenryu-all','犬種不明・自宅シャンプー',NULL,NULL,'scent repeat','自宅で洗うようになってから家族で使い続け、香りが強すぎず自然に感じるため3回目の購入になった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/239893_10001167/1.1/'),
('shizenryu-all','超大型犬・50kg超','large','double','sensitive skin dry-time','50kg超のダブルコート犬で、敏感肌でもフケが出にくく、乾きが早いと感じてリピートしている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/239893_10001167/1.1/'),
('shizenryu-all','中型犬・皮膚が弱い','medium',NULL,'sensitive skin','皮膚が弱い中型犬に継続使用し、このシャンプーは合っているように感じ、香りも好みという体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/239893_10001167/1.1/'),
('shizenryu-all','犬種不明・肌へのやさしさ重視',NULL,NULL,'skin fluffy shine','洗い上がりに艶とふわっと感があり、犬の肌にも洗う人の手にもやさしく感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/239893_10001167/1.1/'),
('shizenryu-all','兄犬＋弟犬',NULL,NULL,'multi soft finish','兄犬で愛用した後、弟犬にも使い、さらっとしつつ柔らかい仕上がりを気に入った多頭飼いの体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/239893_10001167/1.1/'),
('shizenryu-all','犬複数頭',NULL,NULL,'multi fluffy','複数の犬に初めて使い、洗い上がりがさらさら・ふわふわになったと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/239893_10001167/1.1/'),
('shizenryu-all','フレンチブルドッグ・5歳','medium','short','sensitive skin long-use','皮膚が弱い5歳のフレンチブルドッグに4年間使用し、少量でも泡立ちやすくトラブルなく継続できている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/239893_10001167/1.1/'),
('shizenryu-all','犬種不明・香りに敏感な家庭',NULL,NULL,'mild scent','他のシャンプーより自然で穏やかな香りに感じ、犬にも強すぎない点を気に入って使っている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/239893_10001167/1.1/'),
('shizenryu-all','犬種不明・リンス併用',NULL,NULL,'fluffy dry-time','リンスと一緒に使うとよりふわっと仕上がり、乾かす時間も短く感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/239893_10001167/1.1/'),
('shizenryu-all','トイプードル・細い毛','small','curly','fluffy tangle caution','トイプードルでふわふわに仕上げたい時に合うと感じる一方、細かな毛は絡みやすくコンディショナー併用が良さそうと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/239893_10001167/1.1/'),
('shizenryu-all','チワワ','small',NULL,'scent soft-coat','チワワに使用し、ハーブの香りを気に入り、洗った後の毛がゴワゴワしにくいと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/239893_10001167/1.1/'),
('shizenryu-all','超大型犬・50kg・ダブルコート','large','double','shine wavy coat','50kgのダブルコート犬に希釈して使用し、首まわりのうねりが落ち着き、毛艶がよくなると感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/239893_10001167/1.1/'),
('shizenryu-all','ダブルコート犬＋シングルコート犬',NULL,'mixed','multi coat-variety','ダブルコートとシングルコートの2頭に使い、どちらの毛質でも香り・毛艶・洗い上がり・乾きに満足した体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/239893_10001167/1.1/'),
('shizenryu-all','犬種不明・皮膚が弱い',NULL,NULL,'sensitive skin shine','皮膚が弱い犬に使い、保湿感と毛艶、洗い心地を良く感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/239893_10001167/1.1/'),
('shizenryu-all','歴代犬・肌が弱い子を含む',NULL,NULL,'long-use sensitive skin','歴代の犬たちに使い続け、肌が弱い子にも使いやすいと感じてリピートしている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/239893_10001167/1.1/'),
('shizenryu-all','犬種不明・希釈使用',NULL,NULL,'soft coat scent','薄めて使えて長持ちし、香りと柔らかな仕上がりを気に入っている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/239893_10001167/1.1/'),
('shizenryu-all','柴犬・8歳','medium','double short','senior long-use','8歳の柴犬に子犬の頃から使い続けている長期使用の体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/239893_10001167/1.1/'),
('shizenryu-all','犬種不明・皮膚トラブルを気にする犬',NULL,NULL,'skin mild scent','使用中に皮膚トラブルが出ず、香りも強くない点を気に入って継続している体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/239893_10001167/1.1/'),
('shizenryu-all','犬種不明・ふわ艶重視',NULL,NULL,'fluffy shine','洗った後にふわっと艶のある仕上がりになり、継続使用している体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/239893_10001167/1.1/'),
('shizenryu-all','犬種不明・10年以上使用',NULL,NULL,'long-use','10年以上同じシャンプーを使い続け、家庭での定番になっている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/239893_10000736/1.1/'),
('shizenryu-all','犬種不明・15歳',NULL,NULL,'senior long-use','15歳の犬に子犬の頃から使い、さらさらの仕上がりと一度で洗える手軽さを理由に長年愛用している体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/239893_10000736/1.1/'),
('shizenryu-all','短毛犬2頭',NULL,'short','multi shine','短毛犬2頭に使用し、毛艶が出て、香りもきつくなく優しいと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/239893_10000736/1.1/'),
('shizenryu-all','犬種不明・14年間の飼育歴',NULL,NULL,'long-use finish','犬を飼い続けて14年の家庭で長く愛用し、他製品を使った時より仕上がりが良いと感じて戻った体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/239893_10000736/1.1/'),
('shizenryu-all','ラブラドールレトリバー','large','short','large soft-coat','ラブラドールにたっぷり使うため大容量を選び、成犬になってもパピーのような柔らかな手触りが続くと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/239893_10000736/1.1/'),
('shizenryu-all','ブルドッグ','medium','short','sensitive skin frequent-wash','洗う頻度と使用量が多いブルドッグで、肌が弱くても使いやすいと感じ、大容量をリピートしている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/239893_10000736/1.1/'),
('shizenryu-all','中型犬4頭・1頭は皮膚病経験あり','medium',NULL,'multi skin','皮膚病改善をきっかけに中型犬へ使い始め、現在は4頭すべてに使用し、脂質が出やすい子はリンスなしで使い分けている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/239893_10000736/1.1/'),
('shizenryu-all','犬種不明・香り持続重視',NULL,NULL,'foam scent','泡立ちと香りを気に入り、以前のシャンプーより香りが長く残るように感じてリピートしている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/239893_10000736/1.1/'),
('shizenryu-all','犬種不明・散歩後に足洗い',NULL,NULL,'paw frequent-wash','散歩後に毎回足を洗う犬へ試し、香りが良く、毎日使っても肉球が荒れにくいか様子を見ながら使っている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/239893_10000736/1.1/'),
('shizenryu-all','多頭飼い・皮膚病と脂漏傾向の犬を含む',NULL,NULL,'multi skin frequent-wash','皮膚病や脂漏傾向の犬がいる多頭飼い家庭で、使用感と香りが良く、洗う回数が多い中で継続候補になった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/239893_10000736/1.1/'),
('shizenryu-all','シーズー・1歳半','small','long','foam fluffy','1歳半のシーズーに使用し、以前の薬用シャンプーより泡立てやすく、洗い上がりがふわふわで香りも良いと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/239893_10000736/1.1/'),
('shizenryu-all','大型犬4頭＋ほか5頭','large',NULL,'multi large','大型犬4頭を含む9頭の家庭で使い、ワンランク上の同シリーズと大差を感じず、こちらをリピートした体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/239893_10000736/1.1/'),
('shizenryu-all','大型長毛犬の飼育経験＋現在テリア2頭',NULL,'long','multi long-use','大型長毛犬の頃から使い続け、現在はテリア2頭にも使用し、細かな泡と柔らかく艶のある仕上がりを気に入っている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/239893_10000736/1.1/'),
('shizenryu-all','敏感肌の犬を含む3頭',NULL,NULL,'multi sensitive skin','3頭の家庭で使い、敏感肌の子も痒がらず、規定希釈で十分泡立つため一度洗いで使っている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/239893_10000736/1.1/'),
('shizenryu-all','中型犬','medium',NULL,'clean fluffy shine','ホームセンター製品から替え、中型犬の汚れ落ちが良く、洗い上がりがふわふわ・艶々になり香りも良いと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/239893_10000736/1.1/'),
('shizenryu-all','小型犬6頭','small',NULL,'multi cost','小型犬6頭の家庭で初めて使い、希釈できるため想像よりコスト負担が大きくなく、使用感にも満足した体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/239893_10000736/1.1/'),
('shizenryu-all','犬種不明・濃縮タイプ',NULL,NULL,'fluffy scent','濃縮タイプを薄めて使い、香りとふわふわの仕上がりを気に入った体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/239893_10000736/1.1/'),
('shizenryu-all','犬種不明・敏感肌',NULL,NULL,'sensitive skin','敏感肌の犬に使用し、痒がる様子がなく、規定通り薄めても泡立ちやすいと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/239893_10000736/1.1/'),
('shizenryu-all','犬種不明・香りと泡立ち重視',NULL,NULL,'foam scent repeat','香りと泡立ちの良さを気に入り、他製品より香りが長く続くように感じて繰り返し購入している体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/239893_10000736/1.1/'),
('shizenryu-all','犬種不明・家庭で詰め替え使用',NULL,NULL,'scent handling','小さいボトルから業務用へ切り替え、詰め替えの手間はあるものの香りと使用感を気に入っている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/239893_10000736/1.1/')
)
INSERT INTO reviews(product_id,dog_breed,dog_size,coat_type,needs,summary,source_type,source_url)
SELECT n.product_id,n.dog_breed,n.dog_size,n.coat_type,n.needs,n.summary,n.source_type,n.source_url
FROM new_reviews n
WHERE NOT EXISTS (
 SELECT 1 FROM reviews r
 WHERE r.product_id=n.product_id
 AND COALESCE(r.dog_breed,'')=COALESCE(n.dog_breed,'')
 AND r.summary=n.summary
);

SELECT
 (SELECT COUNT(*) FROM reviews r JOIN products p ON p.id=r.product_id WHERE p.category='dog-shampoo') AS dog_shampoo_review_count;
