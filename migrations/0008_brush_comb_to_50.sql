PRAGMA foreign_keys = ON;

WITH new_reviews(product_id,dog_breed,dog_size,coat_type,needs,summary,source_type,source_url) AS (
VALUES
('okano-double-comb','豆柴','small','double','shedding fit','いくつかの抜け毛ケア用品を試した中で、この金櫛がいちばん合ったと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=10021668&store_id=kurosu'),
('okano-double-comb','トイプードル・細くもつれやすい毛','small','curly','tangle static','細く絡まりやすい毛でも櫛が入りやすく、静電気も起こりにくいと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=10021668&store_id=kurosu'),
('okano-double-comb','小型犬','small',NULL,'face body size','中・小・小小を使い比べ、顔まわりには小小、体全体には小が使いやすいと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=10021668&store_id=kurosu'),
('okano-double-comb','犬種不明・外出用に2本目',NULL,NULL,'durability travel','安価な別メーカー品では歯が曲がりやすく、結局同じ岡野製を外出用にも買い足した体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=10021668&store_id=kurosu'),
('okano-double-comb','初めて飼った犬・ブラシを噛んで逃げていた',NULL,NULL,'beginner scared','安価な櫛では引っかかって逃げていた犬が、このコームでは座ってブラッシングを受けるようになり、抜け毛と毛艶も良く感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=10021668&store_id=kurosu'),
('okano-double-comb','トイプードル・3kg','small','curly','size finish','中サイズが3kgのプードルにちょうどよく、根元のもつれを取りやすく静電気も起こりにくいと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=10021668&store_id=kurosu'),
('okano-double-comb','トイプードル・1歳','small','curly','smooth beginner','人用の櫛から替えたところ、伸びた毛でも滑らかに通り、ブラッシングが楽になった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=10021668&store_id=kurosu'),
('okano-double-comb','シェルティ','medium','double long','scared gentle','毎日のスリッカーからコームも試し、丸い歯先のおかげか嫌がらず手入れできた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=10021668&store_id=kurosu'),
('okano-double-comb','ダブルコートの犬',NULL,'double','undercoat relaxed','歯先の当たりがやさしく下毛まで届き、ブラッシング中に犬がまったりする様子だった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=10021668&store_id=kurosu'),
('okano-double-comb','犬と猫の多頭飼い・犬にも使用',NULL,NULL,'multi daily','長く使っていたコームの買い替えで中サイズを選び、犬にも日常的に使いやすいと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=10021668&store_id=kurosu'),
('okano-double-comb','ポメラニアン・生後3か月','small','long','puppy scared','スリッカーを嫌がる子犬にブリーダーから勧められ、櫛の重みを使って毎日ブラッシングできた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list/2/?page_key=18305447&store_id=familypet'),
('okano-double-comb','柴犬・子犬','medium','double','puppy shedding','換毛期までに慣らす目的で子犬期から少しずつ使用し、犬も気持ちよさそうにしていた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list/2/?page_key=18305447&store_id=familypet'),
('okano-double-comb','ポメラニアン・4.5kg','small','long','ear mat','耳まわりの毛玉予防に使い、サイズ感も扱いやすかったという体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/z4eqlr1ghj/review/'),
('okano-double-comb','ロングコートチワワ','small','long','scared tangle','スリッカーでは逃げる子でもコームなら手入れしやすく、粗目と細目を使い分けて抜け毛を取れた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/z4eqlr1ghj/review/'),
('okano-double-comb','保護犬・痩せ気味',NULL,NULL,'rescue gentle','背骨まわりへ負担をかけないよう慎重に使い、嫌がらず手入れを続けられた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/z4eqlr1ghj/review/'),
('okano-double-comb','犬2頭',NULL,NULL,'multi daily','2頭の日常ケアで粗目と細目を使い分け、毎日のブラッシングに使いやすかった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/z4eqlr1ghj/review/'),
('okano-double-comb','マルチーズ・1.5kg','small','long','face small','小さいマルチーズの顔まわりやカット時に小サイズが扱いやすかった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=18305446&store_id=familypet'),
('okano-double-comb','トイプードル','small','curly','face tear finish','目元の固まった毛を粗目でほぐして細目で整え、スリッカー後の仕上がり確認にも使った体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=202453&store_id=chanet'),
('okano-double-comb','コーギー','medium','double','shedding detail','スリッカーでは取りにくかった脇やお尻まわりの抜け毛もコームで取りやすく、痛がる様子もなかった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=202453&store_id=chanet'),
('okano-double-comb','チワワ・好奇心旺盛','small',NULL,'daily acclimation','最初はコームをおもちゃのように気にしたが、慣れると日常のブラッシングで抜け毛を取れるようになった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=202453&store_id=chanet'),
('okano-double-comb','トイプードル・1.8kg・4歳','small','curly','face tear','小さなトイプードルの目まわりのケアに使い、以前の櫛より手入れしやすくなったと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=202453&store_id=chanet'),
('okano-double-comb','トイプードル2頭','small','curly','scared fluffy','スリッカーを嫌がる2頭でもコームは受け入れやすく、ふわふわに整えられた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=4907733140019&store_id=yleciel'),
('okano-double-comb','トイプードル・2.5kg・カール強め','small','curly','scared tangle','ブラッシング嫌いで強めのカールがある犬に使い、他のブラシ類より比較的スムーズに手入れできた体験。','public_buyer_review_summary','https://store.shopping.yahoo.co.jp/vaps/4907733140019.html'),
('okano-double-comb','ポメラニアン','small','long','daily','毎日のケア用に使い、価格と品質のバランスが良く継続使用している体験。','public_buyer_review_summary','https://store.shopping.yahoo.co.jp/vaps/4907733140019.html'),
('okano-double-comb','顔まわりをスリッカーで嫌がる犬',NULL,NULL,'face scared static','顔まわりはスリッカーを嫌がるが、このコームなら手入れさせてくれた一方、トップノット周辺では静電気を感じた体験。','public_buyer_review_summary','https://store.shopping.yahoo.co.jp/vaps/4907733140019.html'),
('okano-double-comb','ボーダーコリー','medium','double long','shedding','毎日スリッカーをしていても残る抜け毛が、コームを併用するとさらに取れた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=4907733140019&store_id=yleciel'),
('okano-double-comb','トイプードル','small','curly','daily','初めて専用コームを購入し、特に不満なく日常のブラッシングに使えている体験。','public_buyer_review_summary','https://store.shopping.yahoo.co.jp/largo1991/fk1594-a2205.html'),
('okano-double-comb','ポメラニアン・子犬','small','long','puppy daily','子犬を迎える準備として購入し、子どもでも持ちやすいサイズで毎日のケアに使いやすかった体験。','public_buyer_review_summary','https://store.shopping.yahoo.co.jp/largo1991/fk1594-a2205.html'),
('okano-double-comb','9kgの小型犬','small',NULL,'face small','小小サイズを目まわりなどの細かい部分に使い、以前の中・小より取り回しが良かった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=a-008a-n&store_id=tao-store'),
('okano-double-comb','トイプードル','small','curly','face','小小サイズを主に目やに取りへ使い、しっかりした作りで扱いやすいと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=a-008a-n&store_id=tao-store'),
('okano-double-comb','トイプードル','small','curly','grooming','小小サイズをトリミングに使い、粗目と細目を一本で使い分けられて便利だった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=a-008a-n&store_id=tao-store'),
('okano-double-comb','犬種不明・ブラッシング嫌い',NULL,NULL,'scared','以前はブラッシングを強く嫌がっていたが、このコームでは痛がりにくく気持ちよさそうに受け入れた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=a-008a-n&store_id=tao-store'),
('okano-double-comb','トイプードル','small','curly','fluffy','コームで整えると毛がふわふわになり、軽量で扱いやすいと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=a-008a-n&store_id=tao-store'),
('okano-double-comb','モコモコ毛質の小型雑種犬','small','fluffy','scared mat','スリッカーは絡まって嫌がる犬でも粗目は受け入れやすく、抜け毛と毛玉の手入れに使えた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list/2/?page_key=18305447&store_id=familypet'),
('okano-double-comb','小型犬','small',NULL,'size durability','中サイズでも扱いやすく、ステンレス製で長く使えそうと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/z4eqlr1ghq/review/10/'),
('okano-double-comb','犬種不明・毛が長め',NULL,'long','smooth static','適度な重みと長さで伸びた毛にも入りやすく、静電気が起こらず滑らかに梳かせた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=10021668&store_id=kurosu'),
('okano-double-comb','犬種不明・多年使用',NULL,NULL,'durability daily','何年も使ったコームの買い替えでも同系統を選び、犬の日常ケアで最も重宝しているという体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=10021668&store_id=kurosu'),
('okano-double-comb','犬種不明・仕上げ用',NULL,NULL,'finish','スリッカー後の仕上げに使うと毛並みが揃い、顔まわりの細かいコーミングもしやすかった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=os-036&store_id=petlifepotter'),
('okano-double-comb','ポメラニアン・生後3か月','small','long','puppy scared','ブリーダーの勧めで導入し、スリッカー嫌いの子犬でも毎日使いやすかった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=os-036&store_id=petlifepotter'),
('okano-double-comb','トイプードル・小型','small','curly','face small','中サイズよりさらに細かな顔まわり用として小サイズを追加し、部位ごとに使い分けた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list/2/?page_key=18305446&store_id=familypet'),
('okano-double-comb','犬種不明・ブラシ掃除と被毛ケア',NULL,NULL,'maintenance finish','安価な櫛より作りがしっかりしていて、被毛の仕上げとブラシ掃除の両方で使いやすかった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=202450&store_id=chanet'),
('okano-double-comb','犬種不明・毛が絡みやすい',NULL,NULL,'tangle','絡まった毛にも櫛が入りやすく、丈夫で日々のブラッシングに重宝した体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=202450&store_id=chanet'),
('okano-double-comb','犬種不明・小型犬','small',NULL,'size','小型犬では小または小小サイズが扱いやすく、顔と体でサイズを使い分けると便利だった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=4907733140019&store_id=yleciel'),
('okano-double-comb','犬種不明・毎日ケア',NULL,NULL,'daily smooth','金属製の適度な重さで滑らかに梳かせ、毎日のケアに使い続けやすいと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=18305446&store_id=familypet'),
('okano-double-comb','犬種不明・旧コーム破損後の買い替え',NULL,NULL,'durability','プラスチック部のある旧コームが壊れたため全金属製へ替え、少し重いものの扱いやすいと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=4907733140019&store_id=yleciel')
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
  (SELECT COUNT(*) FROM reviews r JOIN products p ON p.id=r.product_id WHERE p.category='brush-comb') AS brush_comb_review_count;
