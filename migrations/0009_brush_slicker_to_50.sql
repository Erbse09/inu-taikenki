PRAGMA foreign_keys = ON;

WITH new_reviews(product_id,dog_breed,dog_size,coat_type,needs,summary,source_type,source_url) AS (
VALUES
('showtech-slicker','犬・6kg',NULL,NULL,'size time fluffy','100円ショップのスリッカーから替え、毛通りが滑らかで時短になり、6kgの犬にサイズも合った体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/z4tnph78bn'),
('showtech-slicker','トイプードル・4kg弱','small','curly','size head body','Sサイズを頭用、Mサイズを体用に分け、部位ごとに使い分けた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/z4tnph78bn'),
('showtech-slicker','長毛犬',NULL,'long','gentle coat-length','カーブしたヘッドで長毛を軽いタッチで梳かしやすい一方、短毛やサマーカットでは刺激が強そうに感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/z4tnph78bn/review/2/'),
('showtech-slicker','ゴールデンレトリバー・2歳','large','long','large daily','以前のブランド品スリッカーより良いと感じ、ゴールデンの日常ケアに使った体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/z4tnph78bn/review/2/'),
('showtech-slicker','柴犬','medium','double','shedding relaxed','換毛期の抜け毛が多い柴犬で、家の中の抜け毛が減ったと感じ、犬も気持ちよさそうにブラッシングを受けた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/z4tnph78bn/review/2/'),
('showtech-slicker','ブラッシング苦手な小型犬','small',NULL,'scared fluffy','小型犬には少し大きく感じたが、苦手だった犬が大人しくブラッシングを受け、被毛がふかふかになった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/z4tnph78bn/review/2/'),
('showtech-slicker','犬種不明・毛玉が多い犬',NULL,NULL,'mat gentle','毛玉が多くてもつれをほどきやすく、犬が痛がりにくいとトリマーが感じた使用体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/z4tnph78bn/review/3/'),
('showtech-slicker','犬種不明・ソフト使用歴1年以上',NULL,NULL,'mat time','ソフトを長く使った後にハードも試し、毛玉が早く取れてふわふわになり、ブラッシング時間も短くなった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/z4tnph78bn/review/4/'),
('showtech-slicker','ボーダーコリー','medium','double long','smooth','普通のスリッカーから替え、毛通りが滑らかになったと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/z4tnph78bn/review/5/'),
('showtech-slicker','犬種不明・ブラシ未経験',NULL,NULL,'scared negative','ブラシ部分を硬めに感じ、毛量のある犬が引っかかりを嫌がって結局使えなかったという否定的体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/z4tnph78bn/review/5/'),
('showtech-slicker','犬種不明・サロン通い',NULL,NULL,'salon fluffy','通っているドッグサロンのトリマーに教わって購入し、以前のスリッカーよりふわふわに仕上がった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/z4tnph78bn/review/5/'),
('showtech-slicker','犬種不明・足に毛玉',NULL,NULL,'leg mat','ピンの長いタイプを足へそっと当てて梳かしたところ、毛玉が取れて驚いた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/z4tnph78bn/review/5/'),
('showtech-slicker','プードル多頭飼い','small','curly','multi fluffy','複数のプードルに使い、大きめに感じながらも扱いやすく、ふわふわに整えられた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/z4tnph78bn/review/5/'),
('showtech-slicker','柴犬','medium','double','undercoat','ダブルコートの柴犬で、以前のブラシより換毛期の抜け毛をよく取れた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/z4tnph78bn/review/5/'),
('showtech-slicker','ポメラニアン','small','long','tangle fluffy','長い毛のポメラニアンで抜け毛がよく取れ、ふわふわになる一方、長く続けると引っ張られて嫌がる様子もあった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/z4tnph78bn/review/5/'),
('showtech-slicker','ポメラニアン・5か月・3kg台','small','long','puppy scared mat','お迎え時からブラッシング嫌いの爆毛ポメで、少ない回数でも小さな毛玉が取れ、ふわふわになった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/z4tnph78bn'),
('showtech-slicker','犬種不明・木製ブラシを噛む犬',NULL,NULL,'chewing durability','木製ブラシは持ち手を噛まれて傷んだが、このブラシは噛まれても傷みにくく感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/z4tnph78bn'),
('showtech-slicker','犬種不明・以前は木製スリッカー',NULL,NULL,'scared fluffy','木製ハンドルのスリッカーより使いやすく、犬も嫌がりにくいうえ仕上がりがふわふわになった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/z4tnph78bn/review/10/'),
('showtech-slicker','犬種不明・毛量多め',NULL,NULL,'time mat','ブラシ面が広く、毛玉やもつれのある部分を短時間で整えやすかった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=5420031910263&store_id=runpet'),
('showtech-slicker','犬種不明・複数ブラシ比較',NULL,NULL,'gentle','いくつものスリッカーを試した中でも力を抜いて梳かせ、犬が痛がりにくく気持ちよさそうだった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/z4tnph78bn/review/2/'),
('showtech-slicker','犬種不明・小型犬','small',NULL,'size','ヘッドと持ち手が大きめで小型犬では細かい部分が扱いにくいが、被毛はふかふかに仕上がった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/z4tnph78bn/review/2/'),
('showtech-slicker','犬種不明・ワンコ仲間の紹介',NULL,NULL,'recommend','犬仲間から勧められて導入し、従来品より使いやすいと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/z4tnph78bn/review/10/'),
('showtech-slicker','シェルティ','medium','long','soft caution','ソフトタイプの柔らかいピンが長毛を梳かしやすかった一方、先端が尖っているため皮膚への当て方には注意が必要と感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=5420031919273&store_id=runpet'),
('showtech-slicker','長毛のハスキー','large','double long','undercoat long-pin','長いピンが首やお尻の密な被毛まで入りやすく、長毛のハスキーの手入れに使いやすかった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/z4tnph78bn/review/4/'),
('showtech-slicker','ハスキー・ブラッシング嫌い','large','double','scared','ブラッシングを嫌がるハスキーで、安価なスリッカーより抵抗が少なかったものの抜け毛を取るにはコツが必要だった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/z4tnph78bn/review/4/'),
('showtech-slicker','トイプードル2頭','small','curly','multi mat','2頭のトイプードルの日常ケアで使いやすく、もつれや毛玉をほぐしてふわっと整えやすかった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/z4tnph78bn/review/4/'),
('showtech-slicker','犬種不明・ブラッシング時間が長かった犬',NULL,NULL,'time fluffy','従来品より短い時間でふわふわに仕上がり、犬側の拘束時間も減らせたと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/z4tnph78bn/review/4/'),
('showtech-slicker','犬種不明・軽い力で使用',NULL,NULL,'relaxed','カーブに沿って軽く当てると犬が落ち着いて受け入れ、もつれも解きやすかった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/z4tnph78bn/review/3/'),
('showtech-slicker','犬種不明・トリミング現場',NULL,NULL,'pro mat','トリミング現場で毛玉の多い犬に使い、通常のスリッカーより短時間でほぐしやすかった実使用体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/z4tnph78bn/review/3/'),
('showtech-slicker','犬種不明・6kg前後',NULL,NULL,'size limbs','体にはちょうどよい一方、手足など狭い部分ではMサイズが大きく感じられた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/z4tnph78bn'),
('lawrence-soft-slicker','ゴールデンレトリバー','large','long','relaxed shedding','ブラッシング中にじっとして気持ちよさそうにし、抜け毛も取れた一方、ブラシに残った毛を外すのは手間と感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=j-08-001-0l-000&store_id=aecom'),
('lawrence-soft-slicker','ゴールデンレトリバー','large','long','shine scared','以前の海外製ブラシでは痛がって逃げた犬が、このブラシではじっとでき、ブラッシング後の毛艶も良く感じた体験。','public_buyer_review_summary','https://store.shopping.yahoo.co.jp/houndcom/care00088l.html'),
('lawrence-soft-slicker','中型犬','medium',NULL,'scared fluffy','以前の硬いスリッカーでは痛がっていた犬が、このブラシでは喜んで手入れを受け、毛もふわふわになった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=j-08-001-0l-000&store_id=aecom'),
('lawrence-soft-slicker','犬種不明・ブラッシング嫌い',NULL,NULL,'scared','普段は毛づくろいを最後までさせない犬が、このブラシでは嫌がらず最後まで手入れできた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=j-08-001-0l-000&store_id=aecom'),
('lawrence-soft-slicker','長毛犬',NULL,'long','long-coat','複数の犬種で使ってきた飼い主が、長毛犬の日常ケアには欠かせないと感じた体験。','public_buyer_review_summary','https://store.shopping.yahoo.co.jp/houndcom/care00088l.html'),
('lawrence-soft-slicker','ゴールデンレトリバー','large','long','size shine','成長してMからLサイズへ変更し、大きな背中を梳かしやすく、毛艶も良くなると感じた体験。','public_buyer_review_summary','https://store.shopping.yahoo.co.jp/aecom/j-08-001-0l-000.html'),
('lawrence-soft-slicker','プードル','small','curly','negative hard-pin','ソフト表記でもピンを硬く感じ、プードルには皮膚負担が心配でハスキー用に回したという否定的体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=lawrence-m&store_id=inuyashan'),
('lawrence-soft-slicker','ハスキー','large','double','hard-pin','プードルには硬すぎると感じたブラシをハスキーへ使用したという毛質による使い分け体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=lawrence-m&store_id=inuyashan'),
('lawrence-soft-slicker','犬種不明・抜け毛が多い犬',NULL,NULL,'shedding','下毛が思うように取れ、ブラッシング後の毛並みも良くなったと感じ、毎日使っている体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=4964658501110&store_id=koji'),
('lawrence-soft-slicker','ゴールデンレトリバー','large','long','fluffy hard-pin','ピンをやや硬めに感じながらも、ゴールデンの被毛がふわふわに仕上がり重宝している体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=4964658501110&store_id=koji'),
('lawrence-soft-slicker','犬・4kg','small',NULL,'daily static durability','4kgの小型犬に毎日使用し、木製ハンドルで静電気が起きにくく、1年以上使える耐久性を感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/211165_10221431/1.1/'),
('lawrence-soft-slicker','中型犬','medium',NULL,'gentle','細いピンとクッション性で毛を取りやすく、犬を傷つけず中型犬にちょうどよいと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/216162_10005673/1.1/'),
('lawrence-soft-slicker','犬種不明・約10年使用','null',NULL,'long-use gentle','別メーカーのソフトタイプを硬すぎると感じてローレンスへ戻し、犬も痛がりにくい柔らかさを評価した体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/216162_10005673/1.1/'),
('lawrence-soft-slicker','トイプードルの飼い主仲間','small','curly','fluffy','毛に吸いつくようなピン角度で梳かしやすく、トイプードル仲間でも使われていてふわふわに仕上がった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/z4gfmb9lg7')
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

SELECT (SELECT COUNT(*) FROM reviews r JOIN products p ON p.id=r.product_id WHERE p.category='brush-slicker') AS brush_slicker_review_count;
