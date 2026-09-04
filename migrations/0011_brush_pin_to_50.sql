PRAGMA foreign_keys = ON;

WITH new_reviews(product_id,dog_breed,dog_size,coat_type,needs,summary,source_type,source_url) AS (
VALUES
('german-pin-brush-201','中型犬2頭','medium',NULL,'multi daily durability','中型犬2頭を1日2回ブラッシングする家庭で使い、サイズがちょうどよく手になじみ、毎日の使用でも耐久性に満足している体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/ee4906a702/review/'),
('german-pin-brush-201','長毛の大型犬＋短毛の小型犬',NULL,NULL,'multi coat-variety','長毛の大型犬と短毛の小型犬の両方に使い、2頭とも嫌がらずブラッシングを受けた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=j-08-200-0m-000&store_id=aecom'),
('german-pin-brush-201','ヨークシャーテリア','small','long','long-coat daily','長毛のヨーキーの日常ケアで使い、サイズと取り回しが良く、長く使えていると感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/ee4906a702/review/'),
('german-pin-brush-201','初めて迎えた犬',NULL,NULL,'beginner relaxed','初めて犬を迎えた家庭でタッチトレーニング代わりに使用し、頭から尻尾まで丁寧に梳かすと途中で寝てしまうこともあった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=j-08-200-0m-000&store_id=aecom'),
('german-pin-brush-201','長毛犬',NULL,'long','scared daily','スリッカーは嫌う長毛犬が、このピンブラシは喜んで受け入れ、毎日のブラッシングに使えた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/ee4906a702/review/'),
('german-pin-brush-201','犬種不明・ブラッシング好き',NULL,NULL,'relaxed massage','ピンの当たりを痛がるのではと心配したが、実際には気持ちよさそうにブラッシングを受けた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=j-08-200-0m-000&store_id=aecom'),
('german-pin-brush-201','アフガンハウンド','large','long','long-coat','アフガンハウンドの長い被毛の手入れに継続使用し、きれいにブラッシングできるためこのブラシを選んでいる体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=j-08-200-0m-000&store_id=aecom'),
('german-pin-brush-201','アメリカンコッカー','medium','long','gentle','コッカーに使用し、痛がる様子がなく使い心地に満足している体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=j-08-200-0m-000&store_id=aecom'),
('german-pin-brush-201','ポメラニアン','small','long','long-coat durability','長毛のポメラニアンに使い、ピンの長さと硬さ、柄の持ちやすさが扱いやすいと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=000961&store_id=petech'),
('german-pin-brush-201','犬種不明・毎日ケア',NULL,NULL,'daily durability','安価なピンブラシではピンがへたりやすかったためこの製品へ替え、しっかりした作りと長持ちしそうな点を評価した体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/ee4906a702/review/'),
('german-pin-brush-201','犬種不明・スリッカー併用',NULL,NULL,'daily combo','スリッカーと一緒に購入し、どちらも使いやすく日常ケアで併用している体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=j-08-200-0m-000&store_id=aecom'),
('german-pin-brush-201','犬種不明・マッサージ目的',NULL,NULL,'massage relaxed','ブラッシング時の適度な刺激をマッサージのように感じ、犬も嫌がらず受け入れた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=j-08-200-0m-000&store_id=aecom'),
('german-pin-brush-201','犬種不明・同製品リピート',NULL,NULL,'repeat durability','ゴム部分の経年劣化で同じ製品を買い替え、使いやすさを理由に同型を選び直した体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/ee4906a702/review/'),
('german-pin-brush-201','犬種不明・長期使用',NULL,NULL,'long-use','以前から同系統を使い、取り回しの良さから2本目として再購入した体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=000961&store_id=petech'),
('german-pin-brush-201','犬種不明・ピンの硬さを確認',NULL,NULL,'gentle relaxed','金属ピンの刺激を心配していたが、実際に使うと犬が気持ちよさそうにし、日常ケアへ取り入れた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=000961&store_id=petech'),
('german-pin-brush-201','犬種不明・家庭用',NULL,NULL,'daily handling','家庭でのブラッシングに使い、持ち手が手になじみ、日々の被毛ケアで扱いやすいと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/review/item/1/208700_10000710/1.1/'),
('german-pin-brush-201','犬種不明・ブラシの耐久性重視',NULL,NULL,'durability','安いピンブラシを何度も買い替えるより、しっかりした作りのものを長く使いたいと選び、耐久性を評価した体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/ee4906a702/review/'),
('german-pin-brush-203','トイプードル・5kg','small','curly','scared relaxed','ブラッシングが苦手な5kgのトイプードルが、尻尾を振ってお腹を見せ、途中で寝るほど落ち着いて受け入れた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208700_10000708/1.1/'),
('german-pin-brush-203','犬種不明・外出時も使用',NULL,NULL,'travel daily','朝の顔・脇腹ケアに毎日使い、外出前の汚れ落としにも携帯しやすいサイズとして重宝している体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208700_10000708/1.1/'),
('german-pin-brush-203','犬種不明・ブラッシングで逃げる犬',NULL,NULL,'scared','以前は逃げたり噛んだりしていた犬が、このブラシでは多少嫌がりながらも毎日ブラッシングを受けられるようになった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208700_10000708/1.1/'),
('german-pin-brush-203','ビションフリーゼ・6.4kg','small','curly','leg tangle','6.4kgのビションで、嫌がる足元をまずピンブラシで梳かしてからスリッカーを使うと、もつれを取りやすかった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208700_10000708/1.1/'),
('german-pin-brush-203','ヨークシャーテリア','small','long','gentle','ヨーキーに使い、大きすぎないサイズで犬も嫌がらずブラッシングを受けた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208700_10000708/1.1/'),
('german-pin-brush-203','犬種不明・スリッカーが苦手',NULL,NULL,'scared','スリッカーを嫌がってケア回数が減っていた犬が、このブラシでは逃げずにブラッシングを受けられるようになった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208700_10000708/1.1/'),
('german-pin-brush-203','ポメラニアン・6.5kg','small','long','belly legs','6.5kgのポメで、小ぶりなヘッドがお腹や脚の付け根など細かい場所を梳かしやすかった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208700_10000708/1.1/'),
('german-pin-brush-203','柴犬2頭','medium','double','multi daily gentle','柴犬2頭に毎日使い、肌への当たりがやさしく使いやすいと感じ、3本目を購入している体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208700_10000708/1.1/'),
('german-pin-brush-203','犬種不明・ブラッシング好き',NULL,NULL,'relaxed','使用すると犬がとても気持ちよさそうにし、ブラッシング自体もスムーズになった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208700_10000708/1.1/'),
('german-pin-brush-203','犬種不明・家庭用',NULL,NULL,'daily handling','しっかりした作りで持ちやすく、家庭で実際にブラッシングして使いやすいと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208700_10000708/1.1/'),
('german-pin-brush-203','子犬・1.4kg','small',NULL,'puppy scared fluffy','普段のブラッシングでは暴れる1.4kgの子犬が、このブラシでは大人しく受け入れ、仕上がりもふわふわになった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208700_10000708/1.1/'),
('german-pin-brush-203','ビションフリーゼ・1歳','small','curly','gentle','1歳のビションの柔らかな毛をやさしく梳かせ、スリッカーから替えて良かったと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208700_10000708/1.1/'),
('german-pin-brush-203','柴犬','medium','double','shedding relaxed','換毛期の抜け毛が多い柴犬に使い、気持ちよさそうにブラッシングを受けた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208700_10000708/1.1/'),
('german-pin-brush-203','ポメラニアン・5歳','small','long','daily handling','5歳のポメラニアンに使い、これまで試したブラシの中でも特に扱いやすいと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208700_10000708/1.1/'),
('german-pin-brush-203','犬種不明・初めてのピンブラシ',NULL,NULL,'gentle compact','初めてピンブラシを使い、スリッカーより当たりがやさしく、小さく持ちやすいと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208700_10000708/1.1/'),
('german-pin-brush-203','トイプードル・もつれあり','small','curly','tangle scared','毎日ブラッシングしていてももつれが残るトイプードルで、スリッカーより梳かしやすく負担が少ないと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208700_10000708/1.1/'),
('german-pin-brush-203','トイプードル','small','curly','size','以前は大きめブラシで失敗したため小ぶりな203を選び、トイプードルに使いやすいと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208700_10000708/1.1/'),
('german-pin-brush-203','犬種不明・トリマー推奨',NULL,NULL,'daily pro-recommend','トリマーから毎日のケアにピンブラシを勧められ、小ぶりでピンに適度な硬さがあり使いやすいと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208700_10000708/1.1/'),
('german-pin-brush-203','マルチーズ・11か月','small','long','scared puppy','ブラッシング嫌いの11か月のマルチーズが、このブラシでは少しずつ手入れを受けられるようになった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208700_10000708/1.1/'),
('german-pin-brush-203','チワプー・3kg強','small','curly','scared size','3kg強のチワプーにちょうどよいサイズで、ブラッシングが苦手でも初日から何とか使用できた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208700_10000708/1.1/'),
('german-pin-brush-203','犬種不明・30年近く同型使用',NULL,NULL,'long-use','約30年前から同タイプを使い続け、一番好きなピンブラシとして再購入している長期使用体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208700_10000708/1.1/'),
('german-pin-brush-203','チワプー＋トイプードル','small','curly','multi scared','チワプーとトイプードルに使い、スリッカーやコームより嫌がりにくく、ストレスを抑えてケアできた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208700_10000708/1.1/'),
('german-pin-brush-203','ビションフリーゼ','small','curly','scared','ビションフリーゼのブラッシングに使い、犬が嫌がらず受け入れるため継続している体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208700_10000708/1.1/'),
('german-pin-brush-203','大型犬','large','long','undercoat hindquarters','大型犬のアンダーコートがよく取れ、お尻まわりの長い被毛にも使いやすかった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208700_10000708/1.1/'),
('german-pin-brush-203','ボルゾイ','large','long','delicate areas','ボルゾイの耳やお尻まわりなど繊細な部位のブラッシングに使い、扱いやすかった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208700_10000708/1.1/'),
('german-pin-brush-203','小柄なマルチーズ','small','long','size daily','小さなマルチーズにサイズが合い、毎日のブラッシングに使っている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208700_10000708/1.1/'),
('german-pin-brush-203','ヨークシャーテリア','small','long','breakage gentle','スリッカー使用時の切れ毛が気になってピンブラシへ替え、よりやさしくケアできると感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/208700_10000708/1.1/'),
('german-pin-brush-203','ポメマル・4.5kg','small','long','face legs size','4.5kgのポメマルに使い、顔まわりや脚まで梳かしやすく、犬も嫌がらず気持ちよさそうだった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/z4gfmb1ofl')
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
 (SELECT COUNT(*) FROM reviews r JOIN products p ON p.id=r.product_id WHERE p.category='brush-pin') AS brush_pin_review_count;
