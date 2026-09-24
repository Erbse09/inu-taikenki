PRAGMA foreign_keys = ON;

WITH new_reviews(product_id,dog_breed,dog_size,coat_type,needs,summary,source_type,source_url) AS (
VALUES
('apdc-conditioner','ポメラニアン','small','long','scent smooth dilute','月1回ほどのシャンプー後に使い、ティーツリー系の香りとサラサラした手触りを気に入っている体験。500mlでも長く使え、2〜3倍に薄めて使用している。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=010989&store_id=petech'),
('apdc-conditioner','ビションフリーゼ','small','curly','fluffy lasting scent','ビションに使用し、ふわふわの仕上がりが長く続き、香りも好みだったという体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=4528636804206&store_id=inuomoi'),
('apdc-conditioner','犬種不明・3週間ごとに洗う犬',NULL,NULL,'scent fluffy odor','3週間ほどの間隔で使用し、他製品では途中から気になっていたベタつきやにおいが気になりにくく、香りとふわふわ感を気に入った体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=010989&store_id=petech'),
('apdc-conditioner','トイプードル・10歳','small','curly','smooth comb scent','一度コンディショナーなしで洗った時に被毛がごわつき、再びシャンプーと併用するとサラッとして櫛通りが良く、香りも好みだと再確認した体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=010989&store_id=petech'),
('apdc-conditioner','10歳ヨークシャーテリア','small','long','senior long-use fluffy smooth','10歳のヨークシャーテリアに長年使い続け、ふんわりした仕上がりとサラサラ感、香りを気に入っている体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=010989&store_id=petech'),
('apdc-conditioner','10歳トイプードル','small','curly','senior brush tangle salon-like','10歳のトイプードルに使用し、乾かした後にブラシが通りやすく絡まりにくく、サロン帰りのような手触りになったと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=010989&store_id=petech'),
('apdc-conditioner','皮膚トラブルが気になる犬',NULL,NULL,'frequent-wash cost scent','皮膚状態を気にしてこまめに洗う犬でシャンプーとセット使用し、希釈できるためコスト面にも納得し、ハーブ系の香りを気に入った体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=010989&store_id=petech'),
('apdc-conditioner','犬種不明・週1回使用',NULL,NULL,'long-use price scent','長年愛用し週1回ほど使用。値上がりは負担に感じつつも、仕上がりと香りが好みで継続している体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=4528636804206&store_id=inuomoi'),
('apdc-conditioner','皮膚が弱い犬',NULL,NULL,'dilute smooth scent','薬用シャンプーの後にこのコンディショナーを2〜3倍に薄めて使い、つるっとした手触りと香りを気に入っている体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=4528636804206&store_id=inuomoi'),
('apdc-conditioner','犬種不明・なめらか仕上げ重視',NULL,NULL,'smooth natural-scent large-volume','以前はボリューム系を使っていた家庭でなめらかタイプへ替え、自然なハーブの香りと落ち着いた仕上がりがちょうどよいと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/product/j/4528636808075/compare.html'),
('zoic-n-short-rinse','犬種不明',NULL,NULL,'negative smooth scent','期待したほどサラサラ感を感じず香りも普通と感じたが、使い続けるうちに少しずつ使用感が分かってきたという混合評価。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=70793&store_id=d-fit'),
('zoic-n-short-rinse','ポメラニアン','small','long','fluffy repeat','いろいろなシャンプー・リンスを試した末に最近はこの製品を定番にし、ポメラニアンが格段にふわっと仕上がると感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=70793&store_id=d-fit'),
('zoic-n-short-rinse','犬種不明・シャンプー後に毛が硬くなる犬',NULL,NULL,'soft fluffy nonsticky scent','シャンプー後の硬さが気になって導入し、ベタつかずさらっとして、ふわっと仕上がり香りも良いと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=70793&store_id=d-fit'),
('zoic-n-short-rinse','犬種不明・リピーター',NULL,NULL,'mild-scent repeat','ほんのりした香りを気に入り、次回も同じリンスを使いたいと感じている体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=70793&store_id=d-fit'),
('zoic-n-short-rinse','多頭飼い',NULL,NULL,'multi value repeat','多頭飼いで継続して使っているシリーズとして、価格面も含めて使いやすく次回も購入したいと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=70793&store_id=d-fit'),
('zoic-n-short-rinse','犬種不明・複数タイプ比較',NULL,NULL,'scent compare','同シリーズの複数タイプを使った中で、このショートリンスの香りが最も好みに合うと感じて継続している体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=70793&store_id=d-fit'),
('zoic-n-short-rinse','犬種不明・長期使用',NULL,NULL,'long-use fluffy smooth mild-scent','長く同シリーズを使い続け、ふわふわ感とサラサラ感の両方があり、香りも強すぎない点を気に入っている体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=70793&store_id=d-fit'),
('zoic-n-short-rinse','犬種不明・自宅ケア',NULL,NULL,'sweet-scent lasting home','自宅シャンプーの定番として使い、上品な甘さの香りがほどよく続く点を気に入っている体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=70793&store_id=d-fit'),
('zoic-n-short-rinse','犬種不明',NULL,NULL,'coat-quality repeat','ショートリンスを使うようになってから毛質が良くなったように感じ、継続して使用している体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=70793&store_id=d-fit'),
('zoic-n-short-rinse','歴代7頭の犬',NULL,NULL,'long-use multi','シャンプーとセットで20年以上、歴代7頭の犬に使い続けているという長期・多頭使用の体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=70793&store_id=d-fit'),
('zoic-n-long-rinse','トイプードル＋柴犬','medium','mixed','multi smooth scent repeat','トイプードルと柴犬の2頭に以前から使い、どちらも洗った後のサラサラした手触りと香りを気に入ってリピートしている体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/e2ac439743/review/2/'),
('zoic-n-long-rinse','黒ポメラニアン・12歳','small','long','senior fluffy shine','12歳の黒ポメラニアンに長く使い続け、ふわふわ・つやつやに仕上がるため単品で買い足している体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/e2ac439743/review/2/'),
('zoic-n-long-rinse','キャバリア','small','long','ear mat smooth scent','耳まわりの毛玉に悩むキャバリアに使い、サラサラして絡まりが気になりにくくなり、香りも良いと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/e2ac439743/review/2/'),
('zoic-n-long-rinse','チワワ','small',NULL,'scent finish size','チワワに使用し、香りと仕上がりに満足した一方、使用量が少ないためもっと小容量があれば便利と感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/e2ac439743/review/2/'),
('zoic-n-long-rinse','歴代3頭の犬',NULL,NULL,'long-use soft shine comb','初代犬から3代にわたり使い続け、櫛通りと毛艶、柔らかな手触りを気に入っている体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/e2ac439743/review/2/'),
('zoic-n-long-rinse','ゴールデンレトリバー','large','long','large smooth scent lasting','大型のゴールデンに使い、以前のリンスより香りとサラサラ感が長く続くと感じ、大容量も検討した体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/e2ac439743/review/2/'),
('zoic-n-long-rinse','犬種不明・初回使用',NULL,NULL,'first-use scent finish','別メーカーから初めて切り替え、シャンプーと一緒に使ったところ犬に合っているように感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/e2ac439743/review/2/'),
('zoic-n-long-rinse','犬種不明・初回購入',NULL,NULL,'mild-scent mixed-lasting','初めて使い、香りと仕上がりは良かった一方、香りの持続はもう少し欲しいと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/e2ac439743/review/2/'),
('zoic-n-long-rinse','ヨークシャーテリア','small','long','weekly mild-scent clean','ヨークシャーテリアに週1回ほど使い、ほどよい香りとさっぱりした仕上がりを気に入っている体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/e2ac439743/review/3/'),
('zoic-n-long-rinse','ロングコートダックス','small','long','smooth scent-mixed','ロングコートダックスに使い、被毛がサラサラになった一方、香りは人によって好みが分かれそうと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/e2ac439743/review/3/'),
('lafancys-nk22','コッカプー・17kg','medium','curly','fluffy rinse low-scent','毛量の多い17kgのコッカプーに使い、少量でも足り、すすぎ後はふわっと仕上がり香りもほとんど気にならなかった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/216747_10001078/1.1/'),
('lafancys-nk22','長毛犬',NULL,'long','smooth shine mild-scent','長毛犬に使い、洗い上がりがしっとりサラサラで毛艶も良く、香りも強すぎないと感じた体験。','public_buyer_review_summary','https://store.shopping.yahoo.co.jp/petfind/lafancys-12221833-400.html'),
('lafancys-nk22','トイプードル','small','curly','fluffy scent-mixed repeat','初めて使ったトイプードルで、香りは好みと少し違ったものの被毛がふわっと仕上がり、次回も使いたいと感じた体験。','public_buyer_review_summary','https://store.shopping.yahoo.co.jp/petfind/lafancys-12221833-400.html'),
('lafancys-nk22','トイプードル・トリマー推奨','small','curly','professional fluffy','トリマーに勧められてシャンプーとリンスを揃え、信頼できるブランドとして自宅ケアでもふわっと仕上げている体験。','public_buyer_review_summary','https://store.shopping.yahoo.co.jp/petfind/lafancys-12221833-400.html'),
('lafancys-nk22','トイプードル4頭','small','curly','multi long-use fluffy scent','4頭のトイプードルに約9年使い続け、香りとふわふわの仕上がりを気に入り、他商品へ替えず継続している体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/6ea9cdd8f4'),
('lafancys-nk22','シェットランドシープドッグ','medium','long double','long-coat finish rinse','シェルティの長毛にシャンプーとセットで使い、泡切れと仕上がりの良さを評価した体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=nfp-nk1222-200&store_id=koji'),
('lafancys-nk22','歴代犬・10年以上使用',NULL,NULL,'long-use finish','先住犬の頃から10年以上使い、他製品も試した後に仕上がりの良さから再びこのシリーズへ戻った体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/87180a4252'),
('lafancys-nk22','トイプードル','small','curly','dilute fluffy home-grooming','自宅でトイプードルを洗う際、希釈用アプリケーターを使ってシャンプーとリンスを併用し、ふわっと仕上げている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/review/item/1/211709_10004562/1.1/'),
('lafancys-nk22','犬種不明・長期使用',NULL,NULL,'long-use fluffy caution','長く使いふわふわ感の持続を評価する一方、古くなった在庫を使った際に犬がかゆがった経験から買いだめしすぎないよう注意している体験。','public_buyer_review_summary','https://store.shopping.yahoo.co.jp/albiot-shop/la-tr-nk22-400.html'),
('lafancys-nk22','犬種不明',NULL,NULL,'low-fragrance treatment','人工的な香りが少なく感じ、トリートメントとしての仕上がりにも満足した体験。','public_buyer_review_summary','https://store.shopping.yahoo.co.jp/albiot-shop/la-tr-nk22-400.html'),
('shizenryu-conditioner','ゴールデンレトリバー','large','long','spray allergy-owner-observation brush','ゴールデンにシャンプー時だけでなく、薄めた液を日々のブラッシング時にもスプレーして使っている体験。購入者はアレルギーのある犬でも使いやすいと感じている。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=009533&store_id=petech'),
('shizenryu-conditioner','長毛のミックス犬','medium','long','dilute tangle scent','長毛で絡まりやすい部分は濃いめ、体は約10倍に薄めるなど部位で濃度を使い分け、自然な香りと毛の扱いやすさを気に入っている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/278169_10005384/1.1/'),
('shizenryu-conditioner','トイプードル','small','curly','static mat mild-scent','長めに残した被毛が冬に静電気でもつれやすいトイプードルで、使用後はブラシでもつれを取りやすく、強すぎない香りも合っていると感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=m11154&store_id=dog-penet'),
('shizenryu-conditioner','犬種不明・香りに敏感',NULL,NULL,'negative strong-scent fluffy','毛はふわっと仕上がったものの、香りをかなり強く感じ、犬や洗う人が匂いに敏感な場合は合わないかもしれないと感じた否定的体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=m11154&store_id=dog-penet'),
('shizenryu-conditioner','チワワ','small',NULL,'fluffy scent value','チワワにシャンプーとセットで使い、少量で足りるため長く使え、良い香りとふわっとした仕上がりを気に入った体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=m11154&store_id=dog-penet'),
('shizenryu-conditioner','白いポメラニアン','small','long','long-use fluffy praise','白いポメラニアンに長年使い、香りとふわふわ感を気に入り、周囲から被毛を褒められることが多いという体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=m11154&store_id=dog-penet'),
('shizenryu-conditioner','犬種不明・自宅シャンプーへ移行',NULL,NULL,'shine home-care','引っ越しを機にサロンと自宅シャンプーを交互にし、シャンプーだけでは艶が物足りずコンディショナーを追加して仕上がりを整えている体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=4963974005340&store_id=petgo-3rd'),
('shizenryu-conditioner','パグ','small','short','scent shedding brush fluffy','パグに使い、ハーブ系の香りで犬特有のにおいが気になりにくく、換毛期のブラシも通しやすくなりふわっと仕上がったと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=4963974005340&store_id=petgo-3rd'),
('shizenryu-conditioner','犬種不明・長期リピーター',NULL,NULL,'long-use fluffy smooth scent','長く自然流を使い続け、香りの良さとふわふわ・さらさらの仕上がりを気に入ってリピートしている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/278169_10005384/1.1/'),
('shizenryu-conditioner','犬種不明・サロン仕上がり比較',NULL,NULL,'shine smooth scent value','自宅で使っても香り・艶・手触りが良く、安価なトリミングサロンより満足できる仕上がりと感じて継続している体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/278169_10005384/1.1/')
)
INSERT INTO reviews(product_id,dog_breed,dog_size,coat_type,needs,summary,source_type,source_url)
SELECT n.product_id,n.dog_breed,n.dog_size,n.coat_type,n.needs,n.summary,n.source_type,n.source_url
FROM new_reviews n
WHERE NOT EXISTS (
  SELECT 1 FROM reviews r
  WHERE r.product_id=n.product_id
    AND r.summary=n.summary
);

SELECT COUNT(*) AS dog_conditioner_product_count
FROM products
WHERE category='dog-conditioner' AND active=1;

SELECT COUNT(*) AS dog_conditioner_review_count
FROM reviews r
JOIN products p ON p.id=r.product_id
WHERE p.category='dog-conditioner' AND p.active=1;
