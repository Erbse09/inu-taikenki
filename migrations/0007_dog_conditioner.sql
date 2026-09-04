PRAGMA foreign_keys = ON;

INSERT OR IGNORE INTO products
(id,name,category,asin,affiliate_url,active)
VALUES
('apdc-conditioner','A.P.D.C. ティーツリーコンディショナー','dog-conditioner',NULL,'https://www.amazon.co.jp/s?k=A.P.D.C.+%E3%83%86%E3%82%A3%E3%83%BC%E3%83%84%E3%83%AA%E3%83%BC+%E3%82%B3%E3%83%B3%E3%83%87%E3%82%A3%E3%82%B7%E3%83%A7%E3%83%8A%E3%83%BC&tag=100things-22',1),
('zoic-n-short-rinse','ZOIC N ショート リンス','dog-conditioner',NULL,'https://www.amazon.co.jp/s?k=ZOIC+N+%E3%82%B7%E3%83%A7%E3%83%BC%E3%83%88+%E3%83%AA%E3%83%B3%E3%82%B9&tag=100things-22',1),
('zoic-n-long-rinse','ZOIC N ロング リンス','dog-conditioner',NULL,'https://www.amazon.co.jp/s?k=ZOIC+N+%E3%83%AD%E3%83%B3%E3%82%B0+%E3%83%AA%E3%83%B3%E3%82%B9&tag=100things-22',1),
('lafancys-nk22','ラファンシーズ トリートメントリンス NK-22','dog-conditioner',NULL,'https://www.amazon.co.jp/s?k=%E3%83%A9%E3%83%95%E3%82%A1%E3%83%B3%E3%82%B7%E3%83%BC%E3%82%BA+NK-22&tag=100things-22',1),
('shizenryu-conditioner','自然流 トリートメントコンディショナー','dog-conditioner',NULL,'https://www.amazon.co.jp/s?k=%E8%87%AA%E7%84%B6%E6%B5%81+%E3%83%88%E3%83%AA%E3%83%BC%E3%83%88%E3%83%A1%E3%83%B3%E3%83%88%E3%82%B3%E3%83%B3%E3%83%87%E3%82%A3%E3%82%B7%E3%83%A7%E3%83%8A%E3%83%BC&tag=100things-22',1);

WITH new_reviews(product_id,dog_breed,dog_size,coat_type,needs,summary,source_type,source_url) AS (
VALUES
('apdc-conditioner','3歳ゴールデンレトリバー','large','long','smooth scent large','初めて洗った際に使い、毛並みがサラサラになったと感じた体験。洗っている間は香りが強めに感じたが、乾かすと穏やかになった。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/p/dfbef2d5f2/review/'),
('apdc-conditioner','5頭の犬',NULL,NULL,'multi volume scent','多頭飼いで5Lを使用。自宅ケアのコストを抑えつつ、爽やかな香りと毛並みの仕上がりを評価していた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/p/dfbef2d5f2/review/'),
('apdc-conditioner','フレンチブルドッグ','medium','short','dryness coat','フケが気になっていたフレブルで、コンディショナーを使い始めてからフケが気にならなくなったと感じ、毛艶も評価していた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/p/dfbef2d5f2/review/'),
('apdc-conditioner','犬種不明',NULL,NULL,'long-use scent shine','トリマーに勧められて数年継続。ハーブ系の香りと毛艶を気に入り、家庭でのシャンプー時に使っている体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/p/dfbef2d5f2/review/'),
('apdc-conditioner','ポメラニアン','small','long','scent smooth','ティーツリーなどのやさしいハーブの香りと、乾燥後のサラサラした手触りを気に入っている体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/p/dfbef2d5f2/review/'),
('apdc-conditioner','多頭飼い',NULL,NULL,'multi dilute scent','5Lを希釈して使用。大容量の使いやすさ、比較的長く残る香り、毛並みの仕上がりを評価していた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/p/dfbef2d5f2/review/'),
('apdc-conditioner','シニア犬',NULL,NULL,'senior shine soft','シニア期の犬で、使用後に毛艶がよく柔らかくなったと感じ、森のような香りも1週間ほど楽しめたという体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/p/dfbef2d5f2/review/'),
('apdc-conditioner','犬種不明',NULL,NULL,'shine repeat','他のコンディショナーも試した後に戻り、ツヤのある仕上がりで周囲から毛並みを褒められると感じている体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/p/dfbef2d5f2/review/'),
('apdc-conditioner','チワワ','small',NULL,'scent long-use','洗い上がりと香りの持続を気に入り、シャンプーと同シリーズで長く使っている体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/p/dfbef2d5f2/review/'),
('apdc-conditioner','ノーフォークテリア／ノーリッチテリア','small','hard','hard-coat scent','プラッキングで硬さを保ちたい犬種に使用し、コシを残しつつしなやかな毛質に仕上がる点と穏やかな残り香を評価していた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/p/dfbef2d5f2/review/'),
('zoic-n-short-rinse','ポメラニアン','small','long hard','fluffy scent','硬めの毛質のポメラニアンで、香りが強すぎず、リンスインシャンプーよりふわふわに仕上がると感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/19ee2b3d62'),
('zoic-n-short-rinse','犬種不明',NULL,NULL,'fluffy two-step','最初はシャンプーとリンスを分ける手間を気にしていたが、使ってみると毛並みがふんわりし、その後も継続している体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/19ee2b3d62'),
('zoic-n-short-rinse','プードル','small','curly','long-use brush','長年自宅ケアで使用。リンスが伸ばしやすくすすぎやすいと感じ、乾燥後もスリッカーブラシが通りやすいという体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/19ee2b3d62'),
('zoic-n-short-rinse','シーズー','small','long','frequent-care','皮膚が弱いと感じているシーズーで使用。複数のリンスを探した中から選び、週2回のケアでも継続している体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/19ee2b3d62'),
('zoic-n-short-rinse','犬種不明',NULL,NULL,'groomer fluffy','トリマーの紹介で使用開始。リンスインより手間はかかるが、ふわふわ感の違いを感じて継続している体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/19ee2b3d62'),
('zoic-n-short-rinse','チワプー','small','curly','smooth scent','プードルに近い毛並みのチワプーで、サラサラ感と香りを気に入り、リピートしたいと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/19ee2b3d62'),
('zoic-n-short-rinse','犬種不明',NULL,NULL,'light finish compare','ロングタイプも使った経験があり、ロングはしっとり、ショートはよりサラッと軽く仕上がると感じた比較体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/19ee2b3d62'),
('zoic-n-short-rinse','犬種不明',NULL,NULL,'shine smooth scent','シャンプーとセットで使用し、サラサラ感とツヤ、香りの仕上がりを評価していた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/19ee2b3d62'),
('zoic-n-short-rinse','犬種不明',NULL,NULL,'fluffy scent','ふわふわの仕上がりと香りを気に入り、家庭でのケア後に見た目の仕上がりにも満足していた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/d2615f1965'),
('zoic-n-short-rinse','犬種不明',NULL,NULL,'repeat gentle-scent','継続購入しており、香りがきつすぎず、ふわっと残る程度なのがちょうど良いと感じている体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/d2615f1965'),
('zoic-n-long-rinse','パピヨン','small','long','shine white-coat','レッド＆ホワイトのパピヨンで使用し、白い部分のツヤと毛1本ずつの透明感のある見え方を気に入っている体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/e2ac439743/review/'),
('zoic-n-long-rinse','長毛犬',NULL,'long','comb scent','洗面器で薄めて全身にかけ、長毛でも櫛通りがよくサラサラになる点と、比較的長く残る香りを評価していた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/e2ac439743/review/'),
('zoic-n-long-rinse','1歳前後のポメラニアン','small','long','fluffy tangle','他メーカーでキシキシ・ゴワゴワしたためZOICへ戻し、乾かした後のふんわり感を気に入った体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/e2ac439743/review/'),
('zoic-n-long-rinse','犬種不明',NULL,NULL,'winter dry','冬場の乾燥が気になり、トリートメントインシャンプーに加えてリンスも使い始めた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/e2ac439743/review/'),
('zoic-n-long-rinse','ポメラニアン','small','long','fluffy long-use','仔犬の頃から使用し、他メーカーでキシキシしたため再びZOICへ戻したところ、洗い上がりのふわふわ感を気に入った体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/e2ac439743/review/'),
('zoic-n-long-rinse','ロングコートチワワ','small','long','scent coat','2回目の購入で、香りと毛並みの仕上がりを評価。シャンプーよりリンスの方が早く減ると感じていた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/e2ac439743/review/'),
('zoic-n-long-rinse','ミニチュアシュナウザー','small','wire','fluffy cost','リンスインシャンプーよりふわふわになると感じ、価格は高めでも約10回使える量として納得している体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/e2ac439743/review/'),
('zoic-n-long-rinse','犬種不明',NULL,NULL,'drying scent','このシリーズへ替えてから乾きが早く感じ、香りも気に入ったため継続購入している体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/e2ac439743/review/'),
('zoic-n-long-rinse','犬種不明',NULL,NULL,'mild-scent separate-care','シャンプーとリンスが別になった製品を探して購入し、香りが強すぎない点を気に入ってリピートしている体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/e2ac439743/review/'),
('zoic-n-long-rinse','犬種不明',NULL,NULL,'long-use comb','子犬の頃にペットショップから勧められて以来セットで継続し、櫛通りと手触り、ふわふわ感を評価している体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/e2ac439743/review/'),
('lafancys-nk22','犬種不明',NULL,NULL,'volume shine next-day','初回使用では直後のボリューム感が物足りなく感じたが、翌日に毛が落ち着き、ブラッシング後のツヤと毛が潰れにくい点を評価した体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/f5a8922825'),
('lafancys-nk22','ビションフリーゼ','small','curly','fluffy mat','使用するとふわふわになり、毛玉もできにくいと感じてリピートしている体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/f5a8922825'),
('lafancys-nk22','犬種不明',NULL,NULL,'fluffy scent set','シャンプーとセットで使い、香りとふわふわの仕上がりを気に入っている体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/f5a8922825'),
('lafancys-nk22','犬種不明',NULL,NULL,'firm fluffy scent','毛にコシが出てふわふわに仕上がり、香りも好みで継続している体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/f5a8922825'),
('lafancys-nk22','9歳トイプードル','small','curly','senior long-use volume','パピー期から長く使用。ふわふわ・サラサラ・毛艶を保てていると感じ、香りも控えめで犬が嫌がりにくいという体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/216747_10002164/1.1/'),
('lafancys-nk22','ゴールデンレトリバー','large','long','large dilute volume','希釈して使用し、乾燥後に毛が根元から立って体が大きく見えるほどボリュームが出たと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/216747_10002164/1.1/'),
('lafancys-nk22','トイプードル','small','curly','low-scent volume','できるだけ香りが強くないものを探して使用し、他製品よりふわっとした仕上がりを気に入った体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/239851_10003464/1.1/'),
('lafancys-nk22','トイプードル','small','curly','salon-like dilute','約3倍に薄めて使用し、トリミング後のように毛がしっかり立つふわふわの仕上がりを評価していた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/239851_10003464/1.1/'),
('lafancys-nk22','2歳トイプードル','small','curly soft','soft-coat volume','柔らかすぎる毛質で使用し、ふわふわ・サラサラ・ボリュームアップした感触が数日楽しめたという体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/239851_10003464/1.1/'),
('lafancys-nk22','犬種不明',NULL,NULL,'no-scent soft breeder','ブリーダーの勧めで使用。無香料で、洗い上がりの毛が軽くふわふわになり、手触りに満足している体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/239851_10003464/1.1/'),
('shizenryu-conditioner','トイプードル2頭＋ポメラニアン','small','curly long','multi mat spray','毛玉ができやすいトイプードルでサラサラ感が続き、希釈してブラッシングスプレーにも使用。毛量の多いポメラニアンでも毛玉管理に役立ったと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/583149e83c'),
('shizenryu-conditioner','ミニチュアダックス＋トイプードル','small','long curly','smooth drying','ロングコートのダックスと白いトイプードルで使用。毛ざわりの変化を感じ、タオルドライ後の水分残りが少なくドライヤー時間も短く感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/583149e83c'),
('shizenryu-conditioner','成犬',NULL,NULL,'soft fluffy','子犬用リンスインシャンプーでは柔らかさが足りなくなり変更。トリートメントをつけた瞬間から柔らかくふわっとしたと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/583149e83c'),
('shizenryu-conditioner','お風呂が苦手な犬',NULL,NULL,'bath-averse concentrate scent','速乾リンスインから変更し、しっとりふわふわの仕上がりを評価。一回の使用量が少なく、ほんのりハーブの香りと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/583149e83c'),
('shizenryu-conditioner','パピヨン4頭（7〜11歳）','small','long','multi senior fluffy','複数のパピヨンに長く使用し、自然な香りとふわふわ・さらさらの仕上がりを気に入っている体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/583149e83c'),
('shizenryu-conditioner','チワプー','small','curly','mat dilute scent','トリートメントをしないと毛玉ができやすい犬で使用。約2倍に薄め、薄めすぎるとサラサラ感の持続が弱いと感じつつ香りを気に入った体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/583149e83c'),
('shizenryu-conditioner','犬種不明',NULL,NULL,'rough-to-fluffy dilute','リンスインシャンプーでゴワつきが気になり変更。約20倍に薄めても、仕上がりがふわふわ・モコモコになったと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/583149e83c'),
('shizenryu-conditioner','犬種不明',NULL,NULL,'static winter fluffy','冬場に静電気で毛が逆立つのが気になっていた犬で使用し、静電気が気になりにくくなり、ふわふわの仕上がりと優しい香りを評価した体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/583149e83c'),
('shizenryu-conditioner','フレンチブルドッグ','medium','short','long-use soft scent','数年間シャンプーと併用し、毛が柔らかくなる点と優しい香りを評価。香りは数日で弱くなると感じている体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/583149e83c'),
('shizenryu-conditioner','ジャックラッセルテリア','small','short','natural low-foam scent','自然素材を重視して選び、問題なく使用できたという体験。香りを気に入った一方、泡立ちが少なく多めに使いがちと感じていた。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/583149e83c')
)
INSERT INTO reviews(product_id,dog_breed,dog_size,coat_type,needs,summary,source_type,source_url)
SELECT n.product_id,n.dog_breed,n.dog_size,n.coat_type,n.needs,n.summary,n.source_type,n.source_url
FROM new_reviews n
WHERE NOT EXISTS(
  SELECT 1 FROM reviews r
  WHERE r.product_id=n.product_id
    AND COALESCE(r.dog_breed,'')=COALESCE(n.dog_breed,'')
    AND r.summary=n.summary
);

SELECT
  (SELECT COUNT(*) FROM products WHERE category='dog-conditioner') AS product_count,
  (SELECT COUNT(*) FROM reviews r JOIN products p ON p.id=r.product_id WHERE p.category='dog-conditioner') AS review_count;
