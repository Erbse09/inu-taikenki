-- Review Expansion 50: one-shot production bundle
-- Combines migrations 0008 through 0017.
-- Safe to re-run: each source migration uses NOT EXISTS deduplication.
-- Expected outcome: all 11 target categories have at least 50 reviews.
-- Prepared from main after PR #1 merge.

-- ============================================================
-- 0008_brush_comb_to_50.sql
-- ============================================================
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

-- ============================================================
-- 0009_brush_slicker_to_50.sql
-- ============================================================
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

-- ============================================================
-- 0010_brush_undercoat_to_50.sql
-- ============================================================
PRAGMA foreign_keys = ON;

WITH new_reviews(product_id,dog_breed,dog_size,coat_type,needs,summary,source_type,source_url) AS (
VALUES
('furminator-deshedding','柴犬・2歳','medium','double short','shedding mixed','掃除機タイプのブラシでも残っていた抜け毛対策で使用。10〜15分を数日続けると室内に散る毛が減った一方、毛が切れるような音とトップコートの見え方が気になった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=fur72005&store_id=aries0417'),
('furminator-deshedding','フレンチブルドッグ・フラッフィー','medium','long','shedding','抜け毛の多さが気になり使用し、下毛がかなり取れて抜け毛対策になったと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=10022677&store_id=kurosu'),
('furminator-deshedding','フレンチブルドッグ','medium','short','shedding','複数の抜け毛ブラシを試した中で特に毛がよく取れると感じ、継続使用している体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=10022677&store_id=kurosu'),
('furminator-deshedding','柴犬','medium','double short','shedding home','換毛期に室内へ舞う毛が多かったが、一回のブラッシングで大量に取れ、室内の飛散が減ったと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=10022677&store_id=kurosu'),
('furminator-deshedding','コーギー','medium','double','shedding','柴犬レビューが多く不安だったものの、換毛期のコーギーでも軽く撫でるだけで大量に毛が取れた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=10022677&store_id=kurosu'),
('furminator-deshedding','フレンチブルドッグ・皮膚が荒れやすい部位あり','medium','short','skin caution','毛はごっそり取れた一方、毛が薄く皮膚が荒れている部分では傷ついて出血することがあり、部位を避ける必要を感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=10022677&store_id=kurosu'),
('furminator-deshedding','ビーグル','medium','short','shedding speed','抜け毛が多いビーグルで、約5分でもかなりの量の毛が取れた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=10022677&store_id=kurosu'),
('furminator-deshedding','犬種不明・ブラッシング好き',NULL,NULL,'relaxed shedding','きれいに毛が取れ、ワンタッチでブラシから毛を外しやすく、犬も気持ちよさそうにしていた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=10022677&store_id=kurosu'),
('furminator-deshedding','コーギー','medium','double','weekly shedding','抜け毛対策で使用し、非常によく取れるため頻繁には使わず週1回ほどにしている体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=10022677&store_id=kurosu'),
('furminator-deshedding','柴犬・換毛期','medium','double short','shedding relaxed','換毛期に使うと驚くほど毛が取れ、犬も嫌がらず受け入れたが、長く続けると飽きるほどよく取れた体験。','public_buyer_review_summary','https://store.shopping.yahoo.co.jp/kurosu/10022677.html'),
('furminator-deshedding','パグ','small','short','shedding','パグの抜け毛対策に使用し、驚くほど毛が取れた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=10022677&store_id=kurosu'),
('furminator-deshedding','フレンチブルドッグ','medium','short','shedding relaxed','毎日外でブラッシングするほど抜け毛が多い犬に使い、毛がよく取れ、犬も嫌がりにくかった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/z3lqcc6vds/review/'),
('furminator-deshedding','ラブラドールレトリバー','large','short','shedding relaxed','ふわふわした下毛が大量に取れ、犬も嫌がらず気持ちよさそうにブラッシングを受けた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/z3lqcc6vds/review/'),
('furminator-deshedding','イングリッシュブルドッグ・パピー','medium','short','puppy shedding','秋の抜け毛が多い子犬に使い、横になっている時にブラッシングすると大量に取れ、気持ちよさそうだった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/z3lqcc6vds/review/'),
('furminator-deshedding','柴犬','medium','double short','shedding safety','旧型から新型へ替え、抜け毛が非常によく取れ、サイドの構造に以前より安心感を持った体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/z3lqcc6vds/review/'),
('furminator-deshedding','犬種不明・皮膚負担を気にする飼い主',NULL,NULL,'skin caution','毛はよく取れたが、角度や深さによって皮膚へ負担をかけそうと感じ、力加減に注意して使っている体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/z3lqcc6vds/review/'),
('furminator-deshedding','ロングコートチワワ','small','long','shedding relaxed','サロン帰りでも飛んでいた抜け毛が軽く背中をなぞるだけで大量に取れ、犬もピンブラシより気持ちよさそうだった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/2e8461c77d/review/'),
('furminator-deshedding','豆柴','small','double short','shedding caution','一年中抜け毛が多い豆柴で非常によく取れた一方、トリマーからやりすぎに注意するよう助言され、軽く撫でる感覚で使っている体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/2e8461c77d/review/'),
('furminator-deshedding','チワックス・4kg','small','double','relaxed shedding','他のブラシでは嫌がっていた4kgのチワックスが膝で伏せて受け入れ、不要な毛やフケがよく取れた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/2e8461c77d/review/'),
('furminator-deshedding','犬種不明・臆病',NULL,NULL,'scared negative','毛はよく取れるものの、かなり優しく当てないとブラシの感触を気にし、一番使いたかった臆病な犬が強く嫌がるようになった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/2e8461c77d/review/'),
('furminator-deshedding','スムースチワワ','small','short','shedding','車に乗せると毛だらけになるほど抜け毛が多い犬で、アンダーコートがごっそり取れ、抜け毛が減ったと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/2e8461c77d/review/'),
('furminator-deshedding','ロングコートチワワ・10か月','small','long','puppy shedding relaxed','抜け毛に困っていた10か月のチワワで、スリッカーよりよく取れ、ブラッシング中もじっとしていた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=rhc1301007007&store_id=petwill30'),
('furminator-deshedding','ジャックラッセルテリア','small','short','daily','毎日のブラッシングに使い、使い勝手が良いと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=8117940114512&store_id=soukai'),
('furminator-deshedding','ミニチュアピンシャー','small','short','technique shedding','ブラシ角度に少しコツが必要だったが、うまく当てるとしっかり抜け毛を取れた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=8117940114512&store_id=soukai'),
('furminator-deshedding','パグ','small','short','scared negative','使用時にプチプチとした音がし、痛いのか犬が逃げ回ったため相性に不安を感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=8117940114512&store_id=soukai'),
('furminator-deshedding','カニンヘンダックス','small','long','size','長毛のカニンヘンダックスにXSを選び、Sと迷ったが小さな体には扱いやすかったと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=pw00100002414&store_id=petwill30'),
('furminator-deshedding','ロングコートチワワ','small','long','relaxed smooth','ブラシが得意ではない犬でもうっとりして大人しく受け入れ、抜け毛が取れてブラシ後はサラサラになった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=pw00100002414&store_id=petwill30'),
('furminator-deshedding','チワワ・3.4kg','small','long','size mixed','3.4kgのチワワにXSを使い、犬は気持ちよさそうだったがヘッドが小さく、もう一回り大きくてもよかったと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=pw00100002414&store_id=petwill30'),
('furminator-deshedding','ロングコートチワワ','small','long','shedding','痛がらず手入れでき、日々の抜け毛もかなり減ったと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=pw00100002414&store_id=petwill30'),
('furminator-deshedding','チワワ・1.5kg','small','long','size shedding','一般的な櫛ではほとんど取れなかった1.5kgのチワワで、面白いほど毛が取れ、室内や服への抜け毛も減った体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/6b73ef52ad/review/'),
('furminator-deshedding','チワワ・2kg未満','small','long','scared treat shedding','柔らかい子犬毛が部屋に散っていた2kg未満のチワワで、おやつを使いながら少しずつブラッシングし、抜け毛が大きく減った体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/6b73ef52ad/review/'),
('furminator-deshedding','チワワ・XS使用','small','long','size mixed','チワワ用にXSを選んだが幅が狭く、取れた毛ですぐいっぱいになるためSの方が使いやすかったかもしれないと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/6b73ef52ad/review/'),
('furminator-deshedding','ロングコートチワワ2頭・各2kg弱','small','long','multi size relaxed','2kg弱のチワワ2頭にXSを使用し、よく毛が取れ痛がらず気持ちよさそうだったが、幅の狭さからSでもよかったと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/6b73ef52ad/review/'),
('furminator-deshedding','ロングコートチワワ・3.7kg','small','long','size caution','非常によく毛が取れるため毎日使うと取りすぎが心配になり、3.7kgではXSより一回り大きいサイズでもよかったと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/6b73ef52ad/review/'),
('furminator-deshedding','チワワ・2kg','small','long','size shedding','購入前は価格で迷ったが、2kgのチワワにXSがちょうどよく、もっと早く買えばよかったと感じるほど毛が取れた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=pw00100002414&store_id=petwill30'),
('furminator-deshedding','ゴールデン×柴のミックス','medium','double long','shedding','ダブルコートで抜け毛が多いミックス犬に使い、従来の櫛よりかなり多く毛を回収できた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=w1125&store_id=petyafuupro'),
('furminator-deshedding','長毛の中型雑種犬','medium','long','shedding skin caution','長毛で抜け毛の多い中型ミックスに使い大量に回収できたが、毛量が少ない部位では皮膚を傷めないよう浮かせ気味に使った体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=w1125&store_id=petyafuupro'),
('furminator-deshedding','長毛ボーダーコリー','medium','double long','negative topcoat','アンダーコートだけを取りたかったがオーバーコートも一緒に取れると感じ、使いこなしに難しさを感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=w1125&store_id=petyafuupro'),
('furminator-deshedding','ポメラニアン','small','long','relaxed shedding','安価な類似品から正規品へ替え、抜け毛がよく取れ、犬も気持ちよさそうに受け入れた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=w1125&store_id=petyafuupro'),
('furminator-deshedding','ラブラドールレトリバー','large','short','large shedding','大型犬用を初めて使い、しっかり抜け毛が取れて他のブラシへ戻れないほどと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/z3lqcc6v6g'),
('furminator-deshedding','シベリアンハスキー','large','double long','large shedding','大型犬の長毛用をハスキーに使い、毛並みも整うためこのタイプを選び続けている体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/z3lqcc6v6g'),
('furminator-deshedding','バーニーズ・4か月','large','long','puppy shedding','4か月のバーニーズに大型犬長毛用を使い、評判通り抜け毛がよく取れた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=dg0008&store_id=pet-yass'),
('furminator-deshedding','ジャーマンシェパード','large','double long','large shedding','大型犬長毛用を使用し、多くの毛を取れ、取った毛をブラシから外す操作も簡単と感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=10022680&store_id=kurosu'),
('furminator-deshedding','ダックス3頭','small','long','multi shedding','ペットショップの勧めで大型犬長毛用を購入し、ダックス3頭のブラッシングに使っている体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=10022680&store_id=kurosu')
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
 (SELECT COUNT(*) FROM reviews r JOIN products p ON p.id=r.product_id WHERE p.category='brush-undercoat') AS brush_undercoat_review_count;

-- ============================================================
-- 0011_brush_pin_to_50.sql
-- ============================================================
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

-- ============================================================
-- 0012_dog_shampoo_to_50.sql
-- ============================================================
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

-- ============================================================
-- 0013_nail_clipper_to_50.sql
-- ============================================================
PRAGMA foreign_keys = ON;

WITH new_reviews(product_id,dog_breed,dog_size,coat_type,needs,summary,source_type,source_url) AS (
VALUES
('petio-selftrimmer-clipper','犬種不明・音が苦手',NULL,NULL,'scared noise','以前の爪切りのパチンという音を嫌がる犬に使い、静かに切れて切れ味も良いと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/217176_10174322/1.1/'),
('petio-selftrimmer-clipper','子犬',NULL,NULL,'puppy beginner speed','初めての爪切りで、小さく細い爪でも軽い力で切れ、じっとしているのが苦手な子犬でも短時間で終えやすかった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/217176_10174322/1.1/'),
('petio-selftrimmer-clipper','犬種不明・リピーター',NULL,NULL,'repeat handling','以前のタイプから買い替え、よく切れて扱いやすいため追加購入した体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/217176_10174322/1.1/'),
('petio-selftrimmer-clipper','チワワの子犬','small',NULL,'puppy beginner','小型犬にはハサミ型が使いやすそうと選び、チワワの子犬に持ちやすくスムーズに使えた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/217176_10174322/1.1/'),
('petio-selftrimmer-clipper','犬種不明・ギロチンから変更',NULL,NULL,'quiet low-vibration','ギロチン型から替え、少ない力で切れ、振動が伝わりにくいため犬が嫌がりにくいと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/217176_10174322/1.1/'),
('petio-selftrimmer-clipper','犬種不明・数回使用',NULL,NULL,'repeat','5回ほど実際に爪を切り、切れ味の良さから愛用している体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/217176_10174322/1.1/'),
('petio-selftrimmer-clipper','犬種不明・短時間重視',NULL,NULL,'speed','爪がすばやく切れ、作業に手間がかからず重宝している体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/217176_10174322/1.1/'),
('petio-selftrimmer-clipper','犬種不明・100円品から変更',NULL,NULL,'quiet relaxed','100円ショップの爪切りから替え、切れ味がよく、犬がおとなしく切らせるようになった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/217176_10174322/1.1/'),
('petio-selftrimmer-clipper','小型犬','small',NULL,'beginner','ギロチン型よりハサミ型が合いそうと選び、自宅爪切りへ切り替えた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/217176_10174322/1.1/'),
('petio-selftrimmer-clipper','犬種不明・ガムで気をそらす',NULL,NULL,'food-motivated quiet','ガムを食べさせている間に、音を立てず切る部分を確認しながら短時間で爪切りできた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/217176_10174322/1.1/'),
('petio-selftrimmer-clipper','犬種不明・狼爪ケア',NULL,NULL,'wolf-claw','猫用の同系統では小さかったため犬用へ替え、狼爪を切るのに使いやすかった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/217176_10174322/1.1/'),
('petio-selftrimmer-clipper','犬種不明・家庭爪切り初心者',NULL,NULL,'beginner','ギロチン型を使いこなせなかった家庭で、このハサミ型に替えて自宅で爪切りできるようになった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/217176_10174322/1.1/'),
('petio-selftrimmer-clipper','5kgの小型犬','small',NULL,'clean-cut','5kgの小型犬に使用し、切れ味がよく爪の切り口もきれいに仕上がった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/217176_10174322/1.1/'),
('petio-selftrimmer-clipper','犬種不明・寝ている間にケア',NULL,NULL,'quiet scared','切断音が少なく、犬が寝ている間に気づかれにくく爪を切れた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/217176_10174322/1.1/'),
('petio-selftrimmer-clipper','犬種不明・電動やすり経験あり',NULL,NULL,'quiet beginner','電動やすりやバネ式より扱いやすく、音も少ないため犬への負担が小さいと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/217176_10174322/1.1/'),
('petio-selftrimmer-clipper','犬種不明・音に敏感',NULL,NULL,'scared noise','旧爪切りのパチン音で嫌がっていた犬に使い、音は気にならなくなったが慣らしは必要と感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/217176_10174322/1.1/'),
('petio-selftrimmer-clipper','犬種不明・他社品から変更',NULL,NULL,'low-force','以前の有名メーカー品より軽い力で切れ、犬への負荷も少ないと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/217176_10174322/1.1/'),
('petio-selftrimmer-clipper','犬種不明・パチン音が苦手',NULL,NULL,'low-impact','切断時の衝撃が少なく、犬への負担が小さいと感じ、持ち手も使いやすかった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/217176_10174322/1.1/'),
('petio-selftrimmer-clipper','犬種不明・前足は苦手',NULL,NULL,'mixed scared','切れ味自体は良く後ろ足は切れたが、前足は犬が大人しくできずトリマーへ任せることにした混合評価。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/217176_10174322/1.1/'),
('petio-selftrimmer-clipper','ゴールデンレトリバー','large','long','quiet large','従来品の音と振動を嫌がっていたゴールデンが、音の少ない切れ味の良いこの爪切りでは嫌がらず切らせた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/217176_10174322/1.1/'),
('petio-selftrimmer-clipper','柴犬','medium','double','clean-cut','柴犬の爪に使い、爪が割れずにきれいに切れた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/217176_10174322/1.1/'),
('petio-selftrimmer-clipper','犬種不明・黒い爪あり',NULL,NULL,'black-nail control','白い爪と茶色い爪が混在する犬で、少しずつ切れるハサミ型の方が血管位置を確認しやすいと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/217176_10174322/1.1/'),
('petio-selftrimmer-clipper','犬種不明・1〜3mm調整',NULL,NULL,'control','1mm程度から数mmまで少しずつ調整しながら切れ、犬も嫌がりにくかった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/217176_10174322/1.1/'),
('petio-selftrimmer-clipper','犬種不明・初めて迎えた犬',NULL,NULL,'beginner','初めて迎えた犬の自宅爪切り用に選び、持ちやすさと切れ味に満足した体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/217176_10174322/1.1/'),
('zan-nipper','犬種不明・硬い爪',NULL,NULL,'hard-nail','複数のニッパーを試した飼い主が、硬い爪でも最もスパッと切れたと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/216162_10004918/1.1/?l-id=item_SP_SeeItemReview'),
('zan-nipper','大型犬','large',NULL,'hard-nail quiet','小ぶりな本体でも大型犬の爪をよく切れ、切断時の大きな振動が少ないと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/216162_10004918/1.1/?l-id=item_SP_SeeItemReview'),
('zan-nipper','犬種不明・初心者',NULL,NULL,'beginner','自宅で初めて爪切りに挑戦し、緊張しながらでも使いやすかった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/216162_10004918/1.1/?l-id=item_SP_SeeItemReview'),
('zan-nipper','犬種不明・音に敏感',NULL,NULL,'quiet scared','パチンという音が少なく、愛犬が嫌がらず爪のお手入れを受けた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/216162_10004918/1.1/?l-id=item_SP_SeeItemReview'),
('zan-nipper','犬種不明・ギロチン併用',NULL,NULL,'versatile','ZANのギロチン型と使い分ける目的で導入し、切れ味がよく裏側のやすりも実用的と感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/216162_10004918/1.1/?l-id=item_SP_SeeItemReview'),
('zan-nipper','巻き爪の犬',NULL,NULL,'ingrown-nail','仕事で巻き爪の犬を切る場面に使い、切れ味がよく振動も少ないため扱いやすかった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/216162_10004918/1.1/?l-id=item_SP_SeeItemReview'),
('zan-nipper','大型寄り中型雑種・16歳・17kg','medium',NULL,'senior ingrown-nail','16歳17kgの雑種犬で、弱った後ろ足の巻き爪をギロチン型では切れず、ニッパー型で肉球を傷つけず切れた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/p/92215438b9'),
('zan-nipper','中型雑種・介護中','medium',NULL,'wolf-claw senior','大型犬寄りの中型雑種の介護中、触られるのを嫌う狼爪を寝ている隙に一度のチャレンジで切れた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/216162_10004918/1.1/?l-id=item_SP_SeeItemReview'),
('zan-guillotine-sm','ミニチュアダックス','small','long','scared speed','電動やすりでは時間と粉の飛散を嫌がっていたダックスが、ギロチン型なら短時間で切れて負担が減った体験。','public_buyer_review_summary','https://store.shopping.yahoo.co.jp/petrry/zan-003.html'),
('zan-guillotine-sm','犬種不明・爪切り嫌い',NULL,NULL,'scared','安価な爪切りでは痛そうに嫌がっていた犬が、切れ味の良いZANでは大人しく切らせるようになった体験。','public_buyer_review_summary','https://store.shopping.yahoo.co.jp/petrry/zan-003.html'),
('zan-guillotine-sm','犬種不明・獣医の道具を参考',NULL,NULL,'beginner','獣医が使うギロチン型を参考に初めて購入し、爪切りが苦手な犬でも切った瞬間を気にしにくかった体験。','public_buyer_review_summary','https://store.shopping.yahoo.co.jp/petrry/zan-003.html'),
('zan-guillotine-sm','犬種不明・ハサミ式から変更',NULL,NULL,'beginner low-force','ハサミ式からギロチン型へ替え、少ない力で切れ、慣れると使いやすかった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/p/92215438b9'),
('zan-guillotine-sm','犬種不明・音と振動を気にする犬',NULL,NULL,'quiet','従来品より軽い力でスパッと切れ、音や振動で犬を驚かせにくいと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/p/92215438b9'),
('zan-guillotine-large','犬種不明・初めての自宅爪切り',NULL,NULL,'beginner large','病院へ毎回行く代わりに自宅爪切りへ挑戦し、数mmずつ切って使いやすさを実感した体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/p/92215438b9'),
('zan-guillotine-large','バーニーズ','large','long','hard-nail quiet','バーニーズの硬い狼爪で、以前の爪切りでは割れて出血したが、ZANでは少ない力でスパッと切れ犬も静かだった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/p/92215438b9'),
('zan-guillotine-sm','犬種不明・長期使用',NULL,NULL,'durability','同じZANを5年以上使い、他社品よりバネや刃が長持ちすると感じて買い替えた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/266937_10000856/1.1/')
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
 (SELECT COUNT(*) FROM reviews r JOIN products p ON p.id=r.product_id WHERE p.category='nail-clipper') AS nail_clipper_review_count;

-- ============================================================
-- 0014_nail_grinder_to_50.sql
-- ============================================================
PRAGMA foreign_keys = ON;
WITH new_reviews(product_id,dog_breed,dog_size,coat_type,needs,summary,source_type,source_url) AS (
VALUES
('casfuy-6speed','ジャックラッセルテリア・4歳','small','short','scared acclimation','最初は音と振動を怖がったが、爪切りより抵抗が少なく、3回目には全爪を研がせてくれるようになった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/zzmc7a7k52/review/'),
('casfuy-6speed','犬種不明・旧電動やすりから買い替え',NULL,NULL,'speed power','以前の電動やすりよりパワーがあり、実際の爪ケア時間が半分以下になって犬の拘束時間も短くなったと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/zzmc7a7k52/review/'),
('casfuy-6speed','犬種不明・爪切りが大の苦手',NULL,NULL,'scared low-speed','最初は嫌がったものの徐々に怖くないと分かり削れるようになり、低めの速度で様子を見ながら使っている体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/zzmc7a7k52/review/'),
('casfuy-6speed','犬種不明・ライト重視',NULL,NULL,'light handling','愛犬の爪ケアに使い、ライトで手元を確認しやすく、爪切り時間が楽になったと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/zzmc7a7k52/review/'),
('casfuy-6speed','犬種不明・飼い主が爪切りを怖がる',NULL,NULL,'beginner gradual','爪切りへの不安から電動タイプへ替え、犬が嫌がらないよう短時間ずつ少しずつ削っている体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/zzmc7a7k52/review/'),
('casfuy-6speed','犬複数頭・爪切りを見ると逃げる',NULL,NULL,'multi scared light','爪切りを見ると逃げる複数の犬でも、削る方法ならケアでき、ライトも手元確認に役立った体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/zzmc7a7k52/review/'),
('casfuy-6speed','犬種不明・硬い爪',NULL,NULL,'hard-nail power','複数メーカーの電動やすりを使った後に試し、硬い爪でも問題なく削れるパワーを評価した体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/zzmc7a7k52/review/'),
('casfuy-6speed','トイプードル','small','curly','speed','トイプードルの爪に使い、短時間で削れて便利だと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/product/j/0769044762960/compare.html'),
('casfuy-6speed','犬種不明・削りすぎ注意',NULL,NULL,'power caution','実際に使うと非常によく削れたため、削りすぎないよう注意が必要と感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/zzmc7a7k52/review/2/'),
('casfuy-led2','中型犬・15kg','medium',NULL,'hard-nail speed','15kgの中型犬で、太く硬い爪を以前の電動やすりより短時間で削れ、作業時間が大きく減った体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/product/j/0769044761055/compare.html'),
('casfuy-led2','黒い爪の犬・過去に出血経験',NULL,NULL,'black-nail beginner','爪切りで出血させた後に獣医からやすりを勧められ、練習しながら黒い爪を少しずつ削れるようになった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/product/j/0769044761055/compare.html'),
('casfuy-led2','チワワ','small',NULL,'scared','ハサミ型の爪切りを強く嫌がっていたチワワが、電動やすりでは比較的嫌がらず削らせた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/product/j/0769044761055/compare.html'),
('casfuy-led2','ボーダーコリー2頭','medium','double long','multi scared','手動爪切りを嫌うボーダーコリー2頭が、電動やすりへ替えると嫌がらずケアしやすくなった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/product/j/0769044761055/compare.html'),
('casfuy-led2','チワワ・2kg','small',NULL,'light black-nail','2kgのチワワに使用し、よく削れ、ライトで手元を見やすく切りすぎへの不安を減らせた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/product/j/0769044761055/compare.html'),
('casfuy-led2','黒い爪の犬',NULL,NULL,'black-nail scared noise','パワーがあり削るのは速い一方、黒い爪は確認しながら進める必要があり、音を怖がる反応もあった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/product/j/0769044761055/compare.html'),
('casfuy-led2','犬種不明・旧製品から買い替え',NULL,NULL,'quiet power','以前の電動やすりより音が静かに感じ、犬も大人しく削らせ、握りやすさとパワーを評価した体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/product/j/0769044761055/compare.html'),
('casfuy-led2','犬種不明・白い爪',NULL,NULL,'light relaxed','犬が嫌がらず爪を磨がせ、白い爪ではライトで内部を確認しやすいと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/product/j/0769044762069/compare.html'),
('casfuy-led2','犬種不明・旧電動やすりから変更',NULL,NULL,'power','以前使っていた製品より本体がしっかりしていて、削るパワーが強いと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/product/j/0769044761055/compare.html'),
('casfuy-led2','犬種不明・爪やすりとして使用',NULL,NULL,'handling','犬の爪へ実際に使い、爪切りというより電動やすりとして扱いやすかったと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/product/j/0769044762069/compare.html'),
('petio-selftrimmer-nail','小型犬・爪切りが苦手','small',NULL,'beginner','これまでうまく爪を切れなかったが、やすりなら簡単に削れ、足裏毛も同じ本体で整えられて手入れが楽になった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/z4emqa5v59/review/'),
('petio-selftrimmer-nail','犬種不明・飼い主も犬も初心者',NULL,NULL,'acclimation','爪やすりは犬も飼い主も慣れておらず十分使えなかったが、ゆっくり慣らせば使えそうと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/z4emqa5v59/review/'),
('petio-selftrimmer-nail','犬種不明・爪研ぎ初挑戦',NULL,NULL,'quiet acclimation','足裏カットと爪研ぎを試行錯誤しながら使い、犬は強く嫌がらず、音も小さく感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/z4emqa5v59/review/'),
('petio-selftrimmer-nail','小型犬','small',NULL,'beginner quiet','爪切りを嫌がり始めた小型犬で爪やすりアタッチメントを使い、初心者でも扱いやすく音も気になりにくかった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/261122_11047258/1.1/'),
('petio-selftrimmer-nail','犬種不明・爪処理に慣らし中',NULL,NULL,'quiet acclimation','犬と飼い主の双方がまだ慣れていない段階で少しずつ爪処理に使い、音の小ささを良いと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/review/item/1/217176_10153666/1.1/'),
('petio-selftrimmer-nail','犬種不明・爪やすり目的',NULL,NULL,'handling','複数候補から実際に試したことのある2WAYを選び、爪やすりを主目的に使いやすいと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/review/item/1/217176_10153666/1.1/'),
('dremel-7350-pet','犬複数頭・クリッパーより電動派',NULL,NULL,'multi scared','従来の爪切りより、このグラインダーの方が犬たちが嫌がりにくいと感じた購入者の体験。','public_buyer_review_summary','https://www.lowes.com/reviews/dremel-7350-pet-rotary-tools/5001939579'),
('dremel-7350-pet','犬種不明・1速使用',NULL,NULL,'simple','実際の爪ケアで問題なく使えた一方、速度が1段階だけなのは物足りないと感じた体験。','public_buyer_review_summary','https://www.lowes.com/reviews/dremel-7350-pet-rotary-tools/5001939579'),
('dremel-7350-pet','犬種不明・電動ケアを受け入れる犬',NULL,NULL,'relaxed','操作が簡単で、犬も使用中にあまり気にする様子がなく爪を整えられた体験。','public_buyer_review_summary','https://www.lowes.com/reviews/dremel-7350-pet-rotary-tools/5001939579'),
('dremel-7350-pet','犬種不明・静音重視',NULL,NULL,'quiet','犬の爪を整える用途で使い、音が静かで使いやすいと感じた体験。','public_buyer_review_summary','https://www.lowes.com/reviews/dremel-7350-pet-rotary-tools/5001939579'),
('dremel-7350-pet','大型犬・サロンで使用','large',NULL,'thick-nail negative','ドッググルーミングサロンで大型犬の太い爪に使ったところ、1速では削るのに時間がかかり力不足と感じた体験。','public_buyer_review_summary','https://www.lowes.com/reviews/dremel-7350-pet-rotary-tools/5001939579'),
('dremel-7350-pet','犬種不明・音を気にする家庭',NULL,NULL,'noise mixed','実際に使えて機能面は足りた一方、想像より作動音が大きく、1速しかない点も惜しいと感じた体験。','public_buyer_review_summary','https://www.lowes.com/reviews/dremel-7350-pet-rotary-tools/5001939579'),
('dremel-7350-pet','犬複数頭',NULL,NULL,'multi speed quiet','複数の犬に使い、音が大きすぎず短時間で爪を削れる点を評価した体験。','public_buyer_review_summary','https://www.lowes.com/reviews/dremel-7350-pet-rotary-tools-oscillating-tools/5001939579?offset=20'),
('dremel-7350-pet','興奮しやすい犬',NULL,NULL,'feisty negative','初回使用で本体に不具合が起き、さらにパワー不足に感じ、じっとしにくい犬では素早く終わらせにくいと感じた体験。','public_buyer_review_summary','https://www.lowes.com/reviews/dremel-7350-pet-rotary-tools-oscillating-tools/5001939579?offset=20'),
('dremel-7350-pet','犬複数頭・爪切りから変更',NULL,NULL,'multi quiet','従来の爪切りより低い音で複数の犬の爪を整えやすいと感じた体験。','public_buyer_review_summary','https://www.lowes.com/reviews/dremel-7350-pet-rotary-tools-oscillating-tools/5001939579?offset=20'),
('dremel-7350-pet','犬種不明・自宅爪ケア',NULL,NULL,'quiet beginner','静かで扱いやすく、自宅で犬の爪を整える費用と手間を減らせたと感じた体験。','public_buyer_review_summary','https://www.lowes.com/reviews/dremel-7350-pet-rotary-tools-oscillating-tools/5001939579?offset=20'),
('dremel-7350-pet','足を触られるのが苦手な犬複数頭',NULL,NULL,'multi sensitive-paws','足先を触られるのが苦手な犬たちにも使いやすかったと感じた購入者の体験。','public_buyer_review_summary','https://www.lowes.com/reviews/dremel-7350-pet-rotary-tools-oscillating-tools/5001939579?offset=40'),
('dremel-7350-pet','犬種不明・旧電動グラインダーから変更',NULL,NULL,'noise control','以前の多段階グラインダーより音は残るものの、爪を見ながら操作しやすく、実用上は効果的と感じた体験。','public_buyer_review_summary','https://www.lowes.com/reviews/dremel-7350-pet-rotary-tools-oscillating-tools/5001939579?offset=40'),
('dremel-7350-pet','犬種不明・静かな動作を評価',NULL,NULL,'quiet','犬の爪ケアに使い、滑らかで静かな動作を評価した体験。','public_buyer_review_summary','https://www.lowes.com/reviews/dremel-7350-pet-rotary-tools-oscillating-tools/5001939579?offset=40'),
('dremel-7350-pet','犬複数頭・他社グラインダーから変更',NULL,NULL,'multi speed','他社の犬用グラインダーより削る時間が短く、速く終わるため犬たちも嫌がりにくかった体験。','public_buyer_review_summary','https://www.lowes.com/reviews/dremel-7350-pet-rotary-tools-oscillating-tools/5001939579?offset=40'),
('dremel-7350-pet','犬種不明・低出力が不満',NULL,NULL,'power negative','ペット用として使用したが、出力が弱く充電も長く続かないと感じた否定的な体験。','public_buyer_review_summary','https://www.lowes.com/reviews/dremel-7350-pet-rotary-tools-oscillating-tools/5001939579?offset=40')
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
SELECT (SELECT COUNT(*) FROM reviews r JOIN products p ON p.id=r.product_id WHERE p.category='nail-grinder') AS nail_grinder_review_count;

-- ============================================================
-- 0015_dog_clipper_to_50.sql
-- ============================================================
PRAGMA foreign_keys = ON;
WITH new_reviews(product_id,dog_breed,dog_size,coat_type,needs,summary,source_type,source_url) AS (
VALUES
('pateker-p6','マルプー・約2歳','small','curly','quiet fullbody speed','体9mm・顔6mmで使用し、以前のバリカンより毛詰まりが少なく、静かで短時間に全身を整えやすかった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/review/item/1/306097_10000073/1.1/'),
('pateker-p6','犬種不明・初セルフカット',NULL,NULL,'beginner heat','自宅カットへ切り替えてよく刈れた一方、30分〜1時間ほどで本体が熱を持つため休憩を挟んだ体験。','public_buyer_review_summary','https://review.rakuten.co.jp/review/item/1/306097_10000073/1.1/'),
('pateker-p6','シュナウザー','medium','wire','quiet repeat','旧バリカンの切れ味低下で2台目として購入し、多少まだらでも切れ味と静音性に満足した体験。','public_buyer_review_summary','https://review.rakuten.co.jp/review/item/1/306097_10000073/1.1/'),
('pateker-p6','トイプードル','small','curly','fullbody technique','胴と脚の付け根までバリカンを使い、細かいコームで毛を整えながら進めると刈りやすかった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/review/item/1/306097_10000073/1.1/'),
('pateker-p6','トリミング嫌いの犬',NULL,NULL,'scared quiet','以前より音が静かで切れ味も良く、トリミング嫌いの犬へのストレスを減らせそうと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/review/item/1/306097_10000073/1.1/'),
('pateker-p6','ゴールデン×シェパード・7歳・40kg','large','coarse double','large coarse repeat','40kgの剛毛ミックス犬で4台目まで使い続け、切れ味・モーター・バッテリーに満足している体験。','public_buyer_review_summary','https://review.rakuten.co.jp/review/item/1/306097_10000073/1.1/'),
('pateker-p6','犬種不明・毛量多め',NULL,NULL,'hair-clog finish','よく刈れるがアタッチメントへ毛が詰まりやすく、こまめに取り除くときれいに仕上がった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/review/item/1/306097_10000073/1.1/'),
('pateker-p6','犬種不明・サロン休業中',NULL,NULL,'beginner relaxed','トリマーが休みの間のセルフカット用に使い、犬がおとなしくしてくれてスムーズに仕上げられた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/review/item/1/306097_10000073/1.1/'),
('pateker-p6','犬種不明・足裏ケア',NULL,NULL,'paw lightweight','全身はまだ試さず足裏に使用し、200g台の本体でしっかり毛を切れた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/review/item/1/306097_10000073/1.1/'),
('pateker-p6','犬種不明・全身カット',NULL,NULL,'battery fullbody','全身をカットしても充電が切れず、約3時間充電の使い勝手を良いと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/review/item/1/306097_10000073/1.1/'),
('pateker-p6','犬種不明・手足とお尻ケア',NULL,NULL,'quiet partial','届いてすぐ手足とお尻に使い、音が静かで扱いやすいと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/review/item/1/306097_10000073/1.1/'),
('pateker-p6','トイプードル','small','curly','quiet multi-day','3mmで体をカットし、静音で嫌がりにくかったが、途中で犬が飽きるため数日に分けて仕上げた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/review/item/1/306097_10000073/1.1/'),
('pateker-p6','音に敏感な犬',NULL,NULL,'scared negative','他のバリカンと同様に敏感な犬は音を嫌がり、足裏用にはやや大きくボディ向きと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/review/item/1/306097_10000073/1.1/'),
('pateker-p6','長毛の大型犬・多頭飼い','large','long','multi paw repeat','長毛大型犬の多頭飼いで、2週間に1度の足裏・足先ケアに使い、切れ味と水洗いできる点を評価した体験。','public_buyer_review_summary','https://review.rakuten.co.jp/review/item/1/306097_10000073/1.1/'),
('pateker-p6','超小型犬','small',NULL,'scared acclimation','静音でも音は感じるため少しずつ慣らし、怖がらずカットできたが、一時的に振動が大きくなったこともあった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/review/item/1/306097_10000073/1.1/'),
('pateker-p6','犬種不明・旧バリカン10年以上',NULL,NULL,'speed','10年以上使った小型バリカンから替え、切れ味がよくなってカット時間が短くなった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/review/item/1/306097_10000073/1.1/'),
('pateker-p6','犬種不明・初心者',NULL,NULL,'beginner technique','初めてペット用バリカンを使い、毛流れに沿うか逆らうかで長さが変わることを学びながらきれいに刈れた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/review/item/1/306097_10000073/1.1/'),
('pateker-p6','ポメラニアン','small','long','partial heat caution','全身カットではなく部分ケアに使い、最初だけ音に驚いたものの慣れ、刃の熱を確認しながら使用した体験。','public_buyer_review_summary','https://review.rakuten.co.jp/review/item/1/306097_10000073/1.1/'),
('pateker-p6','犬種不明・暑さ対策',NULL,NULL,'fullbody quiet','サロンへ行けない時期に自宅で全身を整え、1時間弱使えて音も小さく、すっきり仕上げられた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/review/item/1/306097_10000073/1.1/'),
('pateker-p6','トイプードル・8kg','small','curly','senior speed relaxed','高齢になりサロン負担を減らすため自宅カットへ切り替え、6mmで約20分のバリカン作業を終え、寝たまま大部分を刈れた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=pet-01&store_id=selectshopcrea'),
('pateker-p6','トイプードル','small','curly','fullbody battery','複数の犬用バリカンで失敗した後に使用し、全身をよく切れ、充電時間が短いのに使用時間が長いと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=pet-01&store_id=selectshopcrea'),
('pateker-p6','トイプードル・12歳','small','curly','senior stress speed','高齢で目も見えにくくサロン利用が難しくなり、以前のバリカンより短時間で終えられて体調を崩さず済んだ体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=pet-01&store_id=selectshopcrea'),
('pateker-p6','小型犬・皮膚が余りやすい体型','small',NULL,'mixed technique','背中の皮膚を伸ばしながらでないと刈りにくく、音と電池持ちは良いものの期待ほどサクサクではなかった混合評価。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=pet-01&store_id=selectshopcrea'),
('pateker-p6','トイプードル','small','curly','weekly summer','絡まりをなくしてから使うと引っかかりにくく、夏はほぼ毎週サマーカットに使っても切れ味が大きく落ちにくかった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=pet-01&store_id=selectshopcrea'),
('pateker-p6','ミニチュアダックス・シニア','small','long','senior fullbody','高齢になり店でトリミングを断られ、自宅で使ったところ簡単に短くカットできた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list/5/?page_key=pet-01&store_id=selectshopcrea'),
('pateker-p6','犬種不明・耳まわり',NULL,NULL,'quiet face','以前のバリカンより静かで、これまで最後に回していた耳まわりも犬と飼い主が音を気にしにくくカットできた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list/5/?page_key=pet-01&store_id=selectshopcrea'),
('pateker-p6','脳炎のある犬',NULL,NULL,'medical-stress gradual','長時間サロンに出すストレスを避けるため購入し、自宅で様子を見ながら少しずつ全身をカットできた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list/5/?page_key=pet-01&store_id=selectshopcrea'),
('pateker-p6','犬種不明・足裏初バリカン',NULL,NULL,'paw quiet beginner','初めて足裏へ使っても音を気にせず大人しくカットさせ、切れ味は良い一方で刃の着脱に戸惑った体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list/5/?page_key=pet-01&store_id=selectshopcrea'),
('pateker-p6','トイプードル3頭・子犬含む','small','curly','multi puppy','トイプードル3頭を一度に手入れし、細い子犬毛も携帯型よりスムーズに切れ、替刃付きも助かった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list/5/?page_key=pet-01&store_id=selectshopcrea'),
('pateker-p6','マルプー','small','curly','fullbody quiet','顔以外を6mmでセルフトリミングし、長い毛も掃除しながら切れ、音も比較的静かで嫌がりにくかった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list/5/?page_key=pet-01&store_id=selectshopcrea'),
('pateker-p6','トイプードル・13歳','small','curly','senior quiet','13歳のセルフトリミングに長期間使い、コードレスで音が静かなので高齢犬のサロン負担を減らせた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list/5/?page_key=pet-01&store_id=selectshopcrea'),
('pateker-p6','トイプードル','small','curly','quiet relaxed','旧バリカンで毛が絡んでいた犬に使い、実際には絡みにくく上手にカットできた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list/5/?page_key=pet-01&store_id=selectshopcrea'),
('panasonic-er807pp','犬種不明・約9年使用',NULL,NULL,'durability repeat','同じ機種を約9年使った後に充電劣化で買い直し、別製品より毛並みをきれいに切れて使いやすいと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/301897_10003603/1.1/'),
('panasonic-er807pp','犬種不明・リピート',NULL,NULL,'repeat handling','使いやすさを理由に同機種をリピート購入し、家庭で継続使用している体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/301897_10003603/1.1/'),
('panasonic-er807pp','犬種不明・家庭トリミング',NULL,NULL,'fullbody','愛犬のトリミングに使い、家庭でもカットしやすいと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/301897_10003603/1.1/'),
('panasonic-er807pp','トイプードル・月2回','small','curly','long-use fullbody','同機種を8年使用し、月2回トイプードルをフルカットしても長く使え、替刃を買える点を評価した体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212826_10032992/1.1/'),
('panasonic-er807pp','トイプードル・部分カット','small','curly','partial safety','肉球などの部分カットでは刃が触れても痛がりにくく安心だった一方、全身は時間がかかりすぎると感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212826_10032992/1.1/'),
('panasonic-er807pp','高齢犬',NULL,NULL,'senior beginner','高齢でサロン利用が難しくなり初めて自宅バリカンへ挑戦し、充電1回では全身完了しなくても大部分を整えられた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212826_10032992/1.1/'),
('panasonic-er807pp','トイプードル','small','curly','power battery','故障した他社品から替え、使いやすさと切れ味に満足しつつ、バッテリー持ちは短めと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212826_10032992/1.1/'),
('panasonic-er807pp','療養中の犬',NULL,NULL,'quiet beginner','療養中の犬へ初めて使用し、音が静かで本体も熱くなりにくく、初心者でも楽にカットできた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212826_10032992/1.1/')
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
SELECT (SELECT COUNT(*) FROM reviews r JOIN products p ON p.id=r.product_id WHERE p.category='dog-clipper') AS dog_clipper_review_count;

-- ============================================================
-- 0016_auto_feeder_to_50.sql
-- ============================================================
PRAGMA foreign_keys = ON;

WITH new_reviews(product_id,dog_breed,dog_size,coat_type,needs,summary,source_type,source_url) AS (
VALUES
('take-one-p2pro','犬・昼間に食べる子',NULL,NULL,'dog camera daytime','昼間に食べる犬の留守番用に導入。給餌自体はできたが、固定カメラでは食事中に頭頂部しか映らず、口元を確認しにくいと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=p1&store_id=take-one'),
('take-one-p2pro',NULL,NULL,NULL,'camera washability height','カメラ映像がきれいで皿まで確認でき、ステンレス部分を外して洗える点を評価。食べる位置が低いため自作の台へ載せて使った体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=p1&store_id=take-one'),
('take-one-p2pro',NULL,NULL,NULL,'repeat feeder height seal','過去に3台の自動給餌器を使った家庭で最も良いと感じ、専用台で高さを補い、洗えるステンレス皿と密閉性の高い蓋を評価した体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=p1&store_id=take-one'),
('take-one-p2pro','犬・留守番が長い時に使用',NULL,NULL,'dog scared camera','長い留守番用に使い、最初はフードが落ちる音に驚いたが食欲が勝ってすぐ慣れた。広角・夜間カメラも安心材料になった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=p1&store_id=take-one'),
('take-one-p2pro','トイプードル・6か月','small','curly','puppy food-motivated mischief','6か月のトイプードルが最初は落下音に驚いたもののすぐ食べ、皿や本体を前足で触っても倒れにくかった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=p1&store_id=take-one'),
('take-one-p2pro','パピー・7か月',NULL,NULL,'puppy camera jam training','7か月の子犬で広角カメラは便利だった一方、スケジュール給餌で詰まり表示が出ることがあり、自動給餌中はおすわり・お手の習慣にも変化を感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=p1&store_id=take-one'),
('take-one-p2pro',NULL,NULL,NULL,'camera stability portion','旧型レビューを見て購入したが、新型は10g単位で、皿や食事中の様子がカメラに映りにくく、カメラ接続も不安定な時があった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=p1&store_id=take-one'),
('take-one-p2pro',NULL,NULL,NULL,'vomit-prone portion accuracy','吐き戻ししやすい子の小分け給餌で使用。5g設定でも約3g、10g設定で約7gになったため、実測して複数回排出で調整した体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=p1&store_id=take-one'),
('wtw-ipet2971','犬の飼育家庭',NULL,NULL,'dog support camera failure','使用中にカメラが見られなくなる不具合が起き、通信環境を確認しても解決せず、サポート対応にも強い不満を感じて返金となった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=gohan&store_id=wtw'),
('wtw-ipet2971',NULL,NULL,NULL,'replacement camera schedule support','初期不良で交換後は接続が簡単になり、1日30回までの給餌回数とカメラ画質・角度は満足した一方、録音機能や本体奥行き、店舗対応に不満が残った体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=gohan&store_id=wtw'),
('wtw-ipet2971',NULL,NULL,NULL,'setup cleaning battery portion','Wi-Fiとアプリは簡単に設定できたが、現行アプリと説明書の差、分解洗浄の手間、密閉性、6g単位の給餌、電池時の機能制限が気になった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=gohan&store_id=wtw'),
('wtw-ipet2971',NULL,NULL,NULL,'portion accuracy camera','カメラ映像はきれいだったが、設定量より最大8gほど多く出ることがあり、何度も実測して設定量を減らして調整した体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=gohan&store_id=wtw'),
('wtw-ipet2971','犬・犬心ドッグフード使用',NULL,NULL,'dog portion accuracy health','犬用フードでアプリ54g設定に対して実際は約78g出ることがあり、表示を信じて多く与えすぎて体調を崩したため、事前計量の重要性を感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=gohan&store_id=wtw'),
('wtw-ipet2971','チワワ','small',NULL,'dog scared remote-feed','帰宅が遅い時用にチワワへ使用。遠隔・時間指定給餌は簡単で、最初は警戒したがフードが出る音を食事の合図として覚えた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=gohan&store_id=wtw'),
('wtw-ipet2971',NULL,NULL,NULL,'camera realtime travel','留守中の見守り目的で使い、Wi-Fi接続が簡単でカメラ映像もほぼリアルタイムに確認でき、外出時の安心につながった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=gohan&store_id=wtw'),
('wtw-ipet2971',NULL,NULL,NULL,'wifi feed-slide app','Wi-Fi接続は簡単で本体サイズも扱いやすく、数日使用して大きな不安はなかった一方、フードの滑り落ちと英語の通知表示が気になった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=gohan&store_id=wtw'),
('moizze-pet001','チワワ・2.6kg','small',NULL,'dog camera height portion','2.6kgのチワワで朝夕2回に設定。カメラは外出先から確認しやすく、2杯分がちょうどよかったが、皿位置が低いため台へ載せて使った体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/416008_10000986/1.1/'),
('moizze-pet001','愛犬・1日3回食',NULL,NULL,'dog acclimation camera portion','1日3回食の犬で昼食の留守番対策に使用。最初は戸惑ったが3日目から不在でも食べるようになり、声かけカメラは便利だった一方、1フィード約10±3gのばらつきが気になった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/416008_10000986/1.1/'),
('moizze-pet001','愛犬・帰宅が遅い家庭',NULL,NULL,'dog scared remote camera','帰宅が遅い時の給餌用に購入。最初はフードの音を怖がったが在宅時にも自動給餌して慣らし、遠隔操作と録画で留守中の様子を確認できた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/416008_10000986/1.1/'),
('moizze-pet001','小型犬','small',NULL,'dog camera angle','小型犬で問題なく使用。アプリ設定と外出先からの給餌は簡単でカメラも鮮明だったが、食事中はおでこ中心で皿の残量を確認しにくかった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/416008_10000986/1.1/'),
('moizze-pet001','わんぱくな犬',NULL,NULL,'dog mischief durability','わんぱくな犬が皿を外したり本体の周囲を掘ったが、ロックがしっかりしてフードを取り出したり本体を倒したりできず、成長後は皿にも慣れた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/416008_10000986/1.1/'),
('moizze-pet001',NULL,NULL,NULL,'travel nightvision minimum-portion','旅行時の遠隔給餌とカメラ目的で使用。接続が簡単で夜間映像も明るく、15回タイマーと洗える皿を評価した一方、1回量をもっと少なく設定したいと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/416008_10000986/1.1/'),
('moizze-pet001',NULL,NULL,NULL,'multi-device portion height','多頭飼いで2台を登録して使用。フード補充直後や粒サイズで給餌量がぶれるため安定するまで試運転し、低いトレイは台で高さを補った体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/416008_10000986/1.1/'),
('moizze-pet001',NULL,NULL,NULL,'setup cleaning troubleshooting','他社機の故障後に購入し、設定・洗浄性・カメラを評価。初回はフードが出なかったが、セット方法を直すと正常に手動給餌できた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/416008_10000986/1.1/'),
('moizze-pet001',NULL,NULL,NULL,'custom-bowl height','帰宅が遅くなる生活で使用し、自作の台で高さを出し、付属皿ではなく手持ちのボウルへフードが入るよう工夫。ペットも気にせず食べた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/416008_10000986/1.1/'),
('moizze-pet001',NULL,NULL,NULL,'camera sound mic','留守番用にカメラとアプリを接続して使用。画質と静かな本体動作は良かったが、アルミ皿へフードが落ちる音とマイクの音割れが少し気になった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/416008_10000986/1.1/'),
('petlibro-granary',NULL,NULL,NULL,'wifi schedule portion subscription','Wi-Fi接続が不安定でスケジュール給餌が動かない時があり、排出量も不規則、アプリの有料サービス案内も多いと感じた否定的な体験。','public_buyer_review_summary','https://www.chewy.com/petlibro-granary-automatic-cat-dog/product-reviews/661246'),
('petlibro-granary',NULL,NULL,NULL,'app comparison','以前使っていたCasfuyが約13か月で不調になりPETLIBROへ変更。耐久性はまだ不明だが、アプリはこちらの方が使いやすいと感じた体験。','public_buyer_review_summary','https://www.chewy.com/petlibro-granary-automatic-cat-dog/product-reviews/661246'),
('petlibro-granary',NULL,NULL,NULL,'setup subscription','初期設定は直感的で使えた一方、追加料金のサービスへ誘導される表示が多い点を好ましく感じなかった体験。','public_buyer_review_summary','https://www.chewy.com/petlibro-granary-automatic-cat-dog/product-reviews/661246'),
('petlibro-granary',NULL,NULL,NULL,'video sdcard subscription','本体は動作したが、動画履歴を開くたびクラウドサービスの案内が先に出て、SDカード利用までの操作が煩わしいと感じた体験。','public_buyer_review_summary','https://www.chewy.com/petlibro-granary-automatic-cat-dog/product-reviews/661246'),
('petlibro-granary',NULL,NULL,NULL,'travel wifi support','在宅時の定時給餌は便利でも、旅行中にWi-Fi接続が切れて物理リセットが必要になることがあり、サポート対応にも不満を感じた体験。','public_buyer_review_summary','https://www.chewy.com/petlibro-granary-automatic-cat-dog/product-reviews/661246'),
('petlibro-granary',NULL,NULL,NULL,'camera notifications freshness','カメラが約1か月使えなかった後に突然ライブ映像が使えるようになったが、動体通知が多く、蓋の乾燥剤交換も手間に感じた体験。','public_buyer_review_summary','https://www.chewy.com/petlibro-granary-automatic-camera-cat/product-reviews/1042774'),
('petlibro-granary',NULL,NULL,NULL,'schedule remote','外出中でも一定の給餌スケジュールをアプリで組める点が便利で、留守番中の食事管理に使いやすいと感じた体験。','public_buyer_review_summary','https://www.chewy.com/petlibro-granary-wifi-24g-5g/product-reviews/661214'),
('petlibro-granary',NULL,'small',NULL,'small-pet wifi jam noise','以前のGranaryが2年未満で故障し買い替えたが、新しい機種は数日でWi-Fi切断や詰まりが起き、単発給餌が二重になったり出なかったりし、排出も遅く音が大きいと感じた体験。','public_buyer_review_summary','https://www.chewy.com/petlibro-granary-wifi-24g-5g/product-reviews/661214'),
('petlibro-granary',NULL,NULL,NULL,'connection support','以前の2ボウル機から買い替えたが接続できず、公式手順で試しても解決せず、電話窓口がないサポートにも不満を感じた体験。','public_buyer_review_summary','https://www.chewy.com/petlibro-granary-wifi-24g-5g/product-reviews/661214'),
('petlibro-granary',NULL,NULL,NULL,'dual-bowl uneven','2ボウルタイプで左右へ均等にフードが分かれず、片側の量が多くなってペット同士が取り合うことがあった体験。','public_buyer_review_summary','https://www.chewy.com/petlibro-granary-wifi-24g-5g/product-reviews/661230'),
('petlibro-granary',NULL,NULL,NULL,'durability support','購入から約3か月で動かなくなり、カスタマーサービスのコミュニケーションにも不満を感じた体験。','public_buyer_review_summary','https://www.chewy.com/petlibro-granary-wifi-24g-5g/product-reviews/661230'),
('petlibro-granary',NULL,NULL,NULL,'app custom-call','アプリが扱いやすく、カスタムの食事呼びかけ音を設定できる点を便利に感じた体験。','public_buyer_review_summary','https://www.chewy.com/petlibro-granary-wifi-24g-5g/product-reviews/661230'),
('petlibro-granary',NULL,NULL,NULL,'app subscription dual-bowl','スマホアプリが必須で有料サービスへの案内が多く、少量給餌では2つの皿へ均等に分配されにくいと感じた体験。','public_buyer_review_summary','https://www.chewy.com/petlibro-granary-wifi-24g-5g/product-reviews/661230'),
('petlibro-granary',NULL,NULL,NULL,'rural-wifi reset','地方の不安定な回線環境ではインターネットが切れるたび本体の再設定が必要になり、交換品でも改善せず継続利用を断念した体験。','public_buyer_review_summary','https://www.chewy.com/petlibro-granary-wifi-24g-5g/product-reviews/661230'),
('petlibro-granary',NULL,NULL,NULL,'portion-inconsistency app','給餌量が安定せず、週に一度ほど大量に出ることがあり、アプリも機器操作よりサービス販売の表示が目立つと感じた体験。','public_buyer_review_summary','https://www.chewy.com/petlibro-granary-wifi-24g-5g/product-reviews/661230'),
('petlibro-granary',NULL,NULL,NULL,'portion-unit setup','初期設定で『ポーション』の意味が分かりにくく、調べて1ポーション約20mLと理解してから設定できた体験。','public_buyer_review_summary','https://www.chewy.com/petlibro-granary-automatic-dog-cat/product-reviews/378777'),
('petlibro-granary',NULL,NULL,NULL,'four-schedules programming','1日に4回の給餌時刻と量を設定でき、帰宅を急がなくてよくなった一方、プログラム操作はやや分かりにくいと感じた体験。','public_buyer_review_summary','https://www.chewy.com/petlibro-granary-automatic-dog-cat/product-reviews/378777')
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
  (SELECT COUNT(*) FROM reviews r JOIN products p ON p.id=r.product_id WHERE p.category='auto-feeder') AS auto_feeder_review_count;

-- ============================================================
-- 0017_pet_dryer_to_50.sql
-- ============================================================
PRAGMA foreign_keys = ON;

WITH new_reviews(product_id,dog_breed,dog_size,coat_type,needs,summary,source_type,source_url) AS (
VALUES
('petaboo-l400','ラブラドールレトリバー','large','short','frequent-shampoo skin-sensitive scared speed','1〜2週間ごとのシャンプーが必要なラブラドールで使用。人用ドライヤーより根元まで早く乾き、生乾きが減った。大きな音で興奮しやすいため風量は最大75程度に抑えても十分時短できた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/405945_10000167/737f-iaveq-9l4hk9_1_2885454600/'),
('petaboo-l400','パーソンラッセルテリア','small','short','frequent-shampoo scared cool-air speed','頻繁にシャワーする犬で使用。水分を吹き飛ばす力で根元まで早く乾いた一方、70以上の風量では高い音を嫌がった。風が冷たく感じる季節は人用ドライヤーの温風を併用した体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/405945_10000167'),
('petaboo-l400','プードル・約3kg','small','curly','grooming face speed','ペットサロンで約3kgのプードルに使用。顔は弱い風量、全身は強風に切り替え、全身を約17分で乾かせた。部位ごとに細かく風量を変えられる点も使いやすかった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/405945_10000167'),
('petaboo-l400','雑種・生後3か月','medium',NULL,'puppy scared training finish','生後3か月の中型雑種で使用。人用ドライヤーでは音に驚いて吠えたり噛みついたりしていたが、風量30前後では落ち着いて乾かせ、仕上がりもふわふわになった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/405945_10000167'),
('petaboo-l400','大型犬・大きな音に興奮しやすい','large',NULL,'scared acclimation speed','大きな音で興奮しやすい大型犬を自宅で洗うために導入。初回は落ち着かなかったが徐々に慣れ、風量を上げれば乾燥も早かった。電源コードはやや短く延長コードが欲しいと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/405945_10000167'),
('petaboo-l400','長毛種・多頭飼い',NULL,'long','multi-dog tangling speed','長毛種を複数飼う家庭で使用。半分程度までの風量でも短時間で乾かしやすく、強くしすぎると毛が絡んでブラシを通しにくいと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/405945_10000167'),
('petaboo-l400','大型犬','large',NULL,'speed restless hose-length','大型犬を家庭用ドライヤー2台で乾かしていた家庭で使用。L400一台でも十分な風量で乾燥時間が短くなった一方、乾燥中に動き回る犬にはホースがもう少し長いと扱いやすいと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/405945_10000167'),
('dogone-quick-dry','ビションフリーゼ','small','curly','grooming finish speed','ビションフリーゼの自宅ケアで使用。根元から毛を伸ばしやすくサロンに近い仕上がりになり、乾かす場所に合わせて風量と温度を変えられる点を評価した体験。','public_buyer_review_summary','https://review.rakuten.co.jp/review/item/1/282253_10008403/1.1/'),
('dogone-quick-dry','毛量の多いプードル',NULL,'curly','speed scared finish','毛量の多いプードルで使用。ノズルを近づけると音に驚いたため、全体の約8割をブロワーで乾かし、最後は人用ドライヤーで毛を伸ばして仕上げる使い方で時短できた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/295394_10007730/1.1/'),
('dogone-quick-dry','ビション・多頭飼い','small','curly','multi-dog handsfree speed','ビションを複数飼う家庭で使用。両手が空くためスリッカーを使いながら風を当てる位置を変えやすく、以前の固定した人用ドライヤーより乾燥時間を短縮できた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/295394_10007730/1.1/'),
('dogone-quick-dry','小型犬','small',NULL,'small-dog noise airflow','小型犬を扱う環境で使用。業務用ほど音が大きくなく、風量を細かく調整できるので小型犬にも問題なく使えたという体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/295394_10007730/1.1/'),
('dogone-quick-dry',NULL,NULL,NULL,'speed','普通のドライヤーでは約30分かかっていた犬の乾燥が約10分になったという体験。組み立ても難しくなく、初回から時短効果を感じた。','public_buyer_review_summary','https://review.rakuten.co.jp/review/item/1/295394_10007730/1.1/'),
('dogone-quick-dry',NULL,NULL,NULL,'handsfree speed finish','家庭用ドライヤーでは時間がかかっていた犬に使用。両手を使いながら風を当てられ、犬も嫌がらず、乾燥時間が短くなって仕上がりもふわふわになった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/282253_10008403'),
('dogone-quick-dry',NULL,NULL,NULL,'scared face speed','乾燥時間は短くなったが音は大きく感じ、顔まわりは強い風を避けて別の人用ドライヤーで仕上げた体験。より細かく弱風まで調整できると使いやすいと感じた。','public_buyer_review_summary','https://review.rakuten.co.jp/review/item/1/282253_10008403/1.1/'),
('morisawa','サモエド','large','long double','speed professional noise','元トリマーがサモエドの乾燥に使用。高価格の業務用ブロワーに近い風量と扱いやすさがあり、業務用としては音も小さめと感じた一方、コードはもう少し長いと良いと評価した体験。','public_buyer_review_summary','https://review.rakuten.co.jp/review/item/1/400014_10000002/1.1/'),
('morisawa','ボーダーコリー','medium','long double','speed','ダブルコートで長毛のボーダーコリーに使用。強い風量で毛の奥まで乾かしやすく、十分なパワーを感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/review/item/1/400014_10000002/1.1/'),
('morisawa','ラブラドールレトリバー','large','short','speed scared','ラブラドールを家庭用ドライヤーで乾かしていた家庭で使用。乾き残しが減って時間も短くなったが、ドライヤー音には少し怖がる様子があり、その点は以前と同じだった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/review/item/1/400014_10000002/1.1/'),
('morisawa','大型犬・皮膚トラブルで頻繁にシャンプー','large',NULL,'frequent-shampoo skin-sensitive speed finish','皮膚トラブルで頻繁にシャンプーする大型犬に使用。普通のドライヤーより乾燥時間が短くなり、ふわふわに仕上がった。本体を置いたままホースだけ動かせる点も作業しやすかった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/review/item/1/400014_10000002/1.1/'),
('morisawa','中型犬・約10kg','medium',NULL,'scared gentle-heat acclimation','約10kgのかなり怖がりな中型犬に使用。人用ドライヤーより温度を気にせず当てやすかった一方、音を苦手として何度も逃げたため、弱風から少しずつ慣らす必要を感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/review/item/1/400014_10000002/1.1/'),
('morisawa','オーストラリアン・ラブラドゥードル','medium','long curly','speed','ミニチュアサイズのオーストラリアン・ラブラドゥードルで使用。人用ドライヤーでは手脚だけで1時間以上かかっていたのが、10分少々まで短縮した体験。','public_buyer_review_summary','https://review.rakuten.co.jp/review/item/1/400014_10000002'),
('homerunpet-drybo-pro',NULL,NULL,NULL,'handsfree speed stress walk','愛犬の健康を考えて導入し、シャンプー後の乾燥が30分かからず、強い直接風よりストレスが少なそうに感じた体験。散歩後の濡れを乾かす用途にも使っている。','public_buyer_review_summary','https://review.rakuten.co.jp/review/review/item/1/397230_10000156/755d-i9awf-hprlas_1_3686365979/'),
('homerunpet-drybo-pro','皮膚が弱い犬',NULL,'short long','skin-sensitive gentle-heat speed','皮膚が弱く熱いドライヤーを避けたい犬に使用。体は短毛で耳と尻尾は長めで、タオルドライ後約10分でかなり乾いた。座るとお尻と尻尾は乾きにくい一方、耳は早く乾いた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/397230_10000156/1.1/'),
('homerunpet-drybo-pro','フレンチブルドッグ','small','short','scared acclimation brachycephalic','ドライヤー嫌いのフレンチブルドッグに使用。初回は横窓から撫でて慣らし、3回目以降は落ち着いて入れるようになった。手足や腹側は約20分で乾くが背中は湿りやすく、様子を見ながら使った体験。','public_buyer_review_summary','https://review.rakuten.co.jp/review/item/1/397230_10000156/1.1/'),
('homerunpet-drybo-pro',NULL,NULL,NULL,'handsfree scared walk','直接ドライヤーを当てるより音や風を気にしにくそうで、乾かしている間に両手が空く点が助かった体験。散歩後など少し濡れた時にも使いやすいと感じた。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/397230_10000156/1.1/'),
('homerunpet-drybo-pro',NULL,NULL,NULL,'finish grooming handsfree','自宅シャンプー後に使うと毛がふわっと仕上がり、乾燥中にブラッシングもできて、お家シャンプーの負担が下がったと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/397230_10000156/1.1/')
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
  (SELECT COUNT(*) FROM reviews r JOIN products p ON p.id=r.product_id WHERE p.category='pet-dryer') AS pet_dryer_review_count;

-- ============================================================
-- FINAL VERIFICATION
-- Every target category should show review_count >= 50 and status = OK.
-- ============================================================
SELECT
  p.category,
  COUNT(r.id) AS review_count,
  CASE WHEN COUNT(r.id) >= 50 THEN 'OK' ELSE 'CHECK' END AS status
FROM products p
LEFT JOIN reviews r ON r.product_id = p.id
WHERE p.active = 1
  AND p.category IN (
    'pet-dryer',
    'auto-feeder',
    'brush-slicker',
    'brush-undercoat',
    'brush-comb',
    'brush-pin',
    'dog-clipper',
    'nail-grinder',
    'nail-clipper',
    'dog-shampoo',
    'dog-conditioner'
  )
GROUP BY p.category
ORDER BY p.category;
