PRAGMA foreign_keys = ON;

WITH new_reviews(product_id,dog_breed,dog_size,coat_type,needs,summary,source_type,source_url) AS (
VALUES
('showtech-as-comb','マルチーズの子犬','small','long','puppy handling weight','子犬用に導入し、持ちやすい長さと手に馴染む重さで扱いやすく、子犬もおとなしくコーミングを受けた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/360103_10000743/1.1/'),
('showtech-as-comb','犬種不明',NULL,NULL,'root finish','安価なコームから替え、毛の根元までしっかり入り、仕上げ時に梳かしている手応えが大きく違うと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/360103_10000743/1.1/'),
('showtech-as-comb','犬種不明・ブロー後',NULL,NULL,'static finish durability','ブロー後に使っても静電気がほとんど気にならず、長めのピンとしっかりした作りで仕上げに使いやすかった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/360103_10000743/1.1/'),
('showtech-as-comb','バーニーズ・50kg','large','long','large root','50kgのバーニーズに使い、安価なコームより被毛の根元まで届く感覚があり、大型犬でもしっかりコーミングできた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/360103_10000743/1.1/'),
('showtech-as-comb','トイプードル','small','curly','static fluffy','静電気が起きにくく、トイプードルの被毛がふわっと仕上がった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/360103_10000743/1.1/'),
('showtech-as-comb','犬種不明・長期使用',NULL,NULL,'repeat long-use','長く使い続けており、価格が上がっても同じコームを選びたいと感じるほど日常ケアで頼りにしている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/360103_10000743/1.1/'),
('showtech-as-comb','犬種不明・ブラシ嫌い',NULL,NULL,'scared smooth','スリッカーより抵抗が少なく、ブラッシング後の被毛もさらっと整った体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/360103_10000743/1.1/'),
('showtech-as-comb','シーズー・フルコート','small','long','static lightweight handling','かなり長い被毛のシーズーに使い、以前の重いコームより軽く、静電気も気になりにくくなった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/360103_10000743/1.1/'),
('showtech-as-comb','ビションフリーゼ','small','curly','head fluffy lightweight','以前使っていた小さなコームより大きな頭の被毛へ通しやすく、軽く扱えてふわっと整えやすかった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/360103_10000743/1.1/'),
('showtech-as-comb','柴犬','medium','double short','scared shedding size','散歩後の手入れに使い、スリッカーより嫌がりにくく適度に抜け毛が取れ、柴犬には少し大きめでも持ちやすかった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/360103_10000743/1.1/'),
('showtech-as-comb','長毛の大型犬','large','long','static handling durability','長毛大型犬に使い、長年使っていた同型に近い扱いやすさがあり、静電気対策にも使いやすいと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/360103_10000743/1.1/'),
('showtech-as-comb','犬種不明',NULL,NULL,'long-pin handling','一般的なコームよりピンが細く長く、被毛へ入りやすく使い心地が良いと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/360103_10000743/1.1/'),
('showtech-as-comb','犬種不明',NULL,NULL,'size static handling','見た目は大きく感じたものの、実際に使うと扱いやすく、静電気も抑えられているように感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/360103_10000743/1.1/'),
('showtech-as-comb','スタンダードプードルの子犬','large','curly','puppy handling repeat','スタンダードプードルの子犬に使い、嫌がらず扱いやすかったため、もう1本欲しいと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/360103_10000743/1.1/'),
('showtech-as-comb','トイプードル','small','curly','scared','ブラシタイプを嫌がるトイプードルでも、このコームなら比較的嫌がらず手入れを受けた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/360103_10000743/1.1/'),
('showtech-as-comb','ビションフリーゼ','small','curly','static size long-coat','冬場に長めの被毛へ使い、やや大きく感じながらも静電気が抑えられているように感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/360103_10000743/1.1/'),
('showtech-as-comb','トイプードル','small','curly','size fluffy','大きく感じたコームでも実際には持ちやすく、トイプードルの被毛がふさふさに仕上がった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/360103_10000743/1.1/'),
('showtech-as-comb','トイプードル','small','curly','grooming handling','届いた時は大きく感じたが、持つと扱いやすく、自宅カット時のコーミングに使えた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/360103_10000743/1.1/'),
('showtech-as-comb','トイプードル・3か月','small','curly','puppy fluffy handling','3か月のトイプードルにスリッカーと併用し、使いやすく被毛をきれいにモフモフに整えられた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/360103_10000743/1.1/'),
('showtech-as-comb','小型犬','small',NULL,'size static','小型犬には少し大きく感じた一方、静電気防止の効果はあるように感じながら使った体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/360103_10000743/1.1/'),
('showtech-as-comb','長毛犬',NULL,'long','long-pin static','SHOWTECHのスリッカー後に使い、どちらも長めのピンで長毛のブラッシングがしやすく、静電気防止にも期待して使った体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/360103_10000743/2.1/'),
('showtech-as-comb','犬種不明・買い替え',NULL,NULL,'long-use handling','長年使っていたコームを紛失して買い替え、重さや目の粗さに最初は違和感があったものの、慣れると使いやすかった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/360103_10000743/1.1/'),
('showtech-as-comb','犬種不明・職場使用',NULL,NULL,'static negative handling','耳まわりを梳かした際に静電気が出て防止効果には不満が残った一方、コーム自体は使いやすいと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/360103_10000743/2.1/'),
('showtech-as-comb','ポメラニアン','small','long','size negative handling','もふもふのポメラニアンに使い、体が小さいため少し扱いにくさを感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/360103_10000743/1.1/'),
('showtech-as-comb','犬種不明',NULL,NULL,'lightweight handling','グレイハウンドコームを継続して使い、軽くて日常ケアに使いやすいと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/360103_10000743/1.1/'),
('showtech-as-comb','ビションフリーゼ','small','curly','daily static','毎日の手入れが欠かせないビションに使うため購入し、大きめで重さはあるものの静電気防止にも期待して使った体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/z4tnph7mdq'),
('showtech-as-comb','トイプードル','small','curly','finish fluffy smooth','以前のコームより滑らかに通り、少し大きくても慣れると使いやすく、仕上げ後のふわふわ感が長持ちした体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/z4tnph7mdq'),
('showtech-as-comb','トイプードル','small','curly','size finish','第一印象は大きく重かったが、実際に使うと扱いやすく、以前よりきれいに仕上がった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/z4tnph7mdq'),
('showtech-as-comb','小型犬','small',NULL,'size handling coat-quality','小型犬には大きさと重さが少し心配だったが、実際には使いやすく、ブラシとコームを替えてから毛質が良くなったように感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/z4tnph7mdq'),
('showtech-as-comb','犬種不明',NULL,NULL,'root handling weight','トリマーから重めのコームを勧められ、適度な重さで自然に下へ降りるため余分な力を加えず梳かしやすかった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/z4tnph7mdq'),

('showtech-greyhound-19cm','トイプードル','small','curly','finish fluffy','仕上げ用に使い、扱いやすくトイプードルの被毛がふわっと整った体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/360103_10002035/1.1/'),
('showtech-greyhound-19cm','ヨークシャーテリア・6か月','small','long','puppy tangle scared','生後半年のヨーキーに使い、絡まりをほぐしやすく、ブラッシングを嫌がらず受け入れた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/360103_10002035/1.1/'),
('showtech-greyhound-19cm','トイプードル2頭','small','curly','multi size handling','2頭のトイプードル用に大きめのコームを探して選び、全身に使いやすかった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/360103_10002035/1.1/'),
('showtech-greyhound-19cm','ヨークシャーテリア','small','long','size handling','ヨーキー用に使い、少し大きめでも持ちやすく扱いやすかった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/360103_10002035/1.1/'),
('showtech-greyhound-19cm','ダブルコート犬',NULL,'double','undercoat shedding durability','ブラシでは届きにくかった内側の綿毛までコームが入り、抜け毛をしっかり取れ、丈夫さにも安心感を持った体験。','public_buyer_review_summary','https://store.shopping.yahoo.co.jp/petsdms/10010154.html'),

('okano-double-comb','小型の柴犬','small','double short','undercoat gentle','犬のケアをする人にコームを勧められて導入し、痛がらせずアンダーコートを梳けると感じた体験。','public_buyer_review_summary','https://product.rakuten.co.jp/product/-/b17173b9d62b6257fac0309d904a0f24/'),
('okano-double-comb','豆柴・7か月','small','double short','puppy shine','初めての換毛期では抜け毛量は多くなかったが、おとなしく梳かせた部分の毛並みに艶が出たように感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=18305447&store_id=familypet'),
('okano-double-comb','柴犬・14kg','medium','double short','scared static maintenance','ファーミネーターを警戒する14kgの柴犬が初回から落ち着いて受け入れ、静電気も気になりにくく毛の片付けも簡単だった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/review/review/review/item/1/389167_10000004/1.1/'),
('okano-double-comb','トイプードル・6kg','small','curly','size face handling','6kg近いトイプードルに中サイズを使い、顔まわりには小小サイズを併用して部位ごとに使い分けた体験。','public_buyer_review_summary','https://store.shopping.yahoo.co.jp/animaux-mignons/312598.html'),
('okano-double-comb','小柄なヨークシャーテリア','small','long','size face relaxed','小柄なヨーキーに小小サイズを使い、顔まわりにも扱いやすく、気持ちよさそうにブラッシングを受けた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=yk4436-a2011&store_id=bestone1'),
('okano-double-comb','トイプードル','small','curly','grooming weight negative','トリミング用に大サイズを選び、作りはしっかりしている一方、重量をかなり感じた体験。','public_buyer_review_summary','https://product.rakuten.co.jp/product/-/40198fb4bb343149b4911cfded226ce3/review/'),
('okano-double-comb','長毛の中型犬','medium','long','size finish','長毛の中型犬に大サイズを選び、このコーム1本でもかなり被毛がきれいに整うと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/review/item/1/278169_10002472/1.1/'),
('okano-double-comb','犬種不明・複数頭',NULL,NULL,'gentle relaxed','以前使っていたGREYHOUND系コームと比べても肌当たりがやさしく、犬たちが大人しく気持ちよさそうに受け入れた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/review/item/1/278169_10002472/1.1/'),
('okano-double-comb','短毛の小型犬','small','short','scared durability','短毛小型犬に使い、嫌がらずブラッシングでき、日本製の丈夫さにも期待した体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=202450&store_id=chanet'),
('okano-double-comb','犬種不明・自宅カット',NULL,NULL,'grooming weight','自宅で犬をカットするために使い、少し重さは感じるものの扱いやすかった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=202450&store_id=chanet'),
('okano-double-comb','柴犬','medium','double short','shedding face','柴犬に使い、予想以上に抜け毛が取れ、顔まわりなど細かな部分にも使いやすかった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/review/review/item/1/278169_10002471/1.1/'),
('okano-double-comb','柴犬','medium','double short','relaxed','岡野製作所の金櫛を使うと、柴犬が特に気持ちよさそうにブラッシングを受けた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/review/review/review/item/1/389167_10000004/1.1/'),
('okano-double-comb','小型犬','small',NULL,'size face scared','大サイズは小型犬には大きいものの、お手入れを嫌がりやすい犬でも落ち着いている時なら顔近くまで手入れしやすかった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/389167_10000085/1.1/'),
('okano-double-comb','トイプードル・5kg','small','curly','size professional','5kgのトイプードルに小小サイズを使い、動物病院でも使われている櫛として体格にちょうど良いと感じた体験。','public_buyer_review_summary','https://store.shopping.yahoo.co.jp/largo1991/fk4436-a2011.html'),
('okano-double-comb','小型犬','small',NULL,'mouth relaxed','以前の大きな櫛から小小サイズへ替え、口まわりのブラッシングに使いやすく、犬も気持ちよさそうに受け入れた体験。','public_buyer_review_summary','https://store.shopping.yahoo.co.jp/largo1991/fk4436-a2011.html')
)
INSERT INTO reviews(product_id,dog_breed,dog_size,coat_type,needs,summary,source_type,source_url)
SELECT n.product_id,n.dog_breed,n.dog_size,n.coat_type,n.needs,n.summary,n.source_type,n.source_url
FROM new_reviews n
WHERE NOT EXISTS (
  SELECT 1 FROM reviews r
  WHERE r.product_id=n.product_id
    AND r.summary=n.summary
);

SELECT COUNT(*) AS brush_comb_product_count
FROM products
WHERE category='brush-comb' AND active=1;

SELECT COUNT(*) AS brush_comb_review_count
FROM reviews r
JOIN products p ON p.id=r.product_id
WHERE p.category='brush-comb' AND p.active=1;
