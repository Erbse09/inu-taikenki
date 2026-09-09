PRAGMA foreign_keys = ON;

INSERT OR IGNORE INTO products (id, name, category, active) VALUES ('kins-dental-gel', 'KINS WITH DENTAL GEL for dogs', 'dog-toothpaste', 1);
INSERT OR IGNORE INTO products (id, name, category, active) VALUES ('oratene-dental-gel', 'オーラティーン デンタルジェル', 'dog-toothpaste', 1);
INSERT OR IGNORE INTO products (id, name, category, active) VALUES ('petkiss-gel-leaf', 'PETKISS 歯みがきジェル リーフの香り', 'dog-toothpaste', 1);
INSERT OR IGNORE INTO products (id, name, category, active) VALUES ('dr-yujiro-dental-gel', 'Dr.YUJIRO デンタルジェル（夜用）', 'dog-toothpaste', 1);
INSERT OR IGNORE INTO products (id, name, category, active) VALUES ('virbac-cet-chicken', 'C.E.T. 歯みがきペースト チキンフレーバー', 'dog-toothpaste', 1);
INSERT OR IGNORE INTO products (id, name, category, active) VALUES ('virbac-cet-vanilla-mint', 'C.E.T. 歯みがきペースト バニラミントフレーバー', 'dog-toothpaste', 1);

DELETE FROM reviews WHERE product_id IN ('kins-dental-gel','oratene-dental-gel','petkiss-gel-leaf','dr-yujiro-dental-gel','virbac-cet-chicken','virbac-cet-vanilla-mint');

INSERT INTO reviews (product_id,dog_breed,dog_size,coat_type,needs,summary,source_type,source_url) VALUES
('kins-dental-gel','柴犬 8歳・5歳',NULL,NULL,'daily scared taste','以前の歯磨き粉では寄ってこなかった2頭が、ヤギミルク味に替えると自分から歯磨きに来るようになったという体験。','public_purchase_review_summary','https://review.rakuten.co.jp/review/item/1/404653_10000028/1.1/'),
('kins-dental-gel',NULL,NULL,NULL,'taste daily','歯磨きガムに付けるととても喜び、朝晩のケアを続けやすかったという体験。','public_purchase_review_summary','https://review.rakuten.co.jp/review/item/1/404653_10000028/1.1/'),
('kins-dental-gel',NULL,NULL,NULL,'scared taste','他社品へ替えると歯磨きを嫌がるようになり、KINSに戻すと受け入れやすかったという体験。','public_purchase_review_summary','https://review.rakuten.co.jp/review/item/1/404653_10000028/1.1/'),
('kins-dental-gel',NULL,NULL,NULL,'puppy beginner','歯磨きに慣れていない7か月の犬がジェルに惹かれて歯磨きに来るので助かったという体験。','public_purchase_review_summary','https://review.rakuten.co.jp/review/item/1/404653_10000028/1.1/'),
('kins-dental-gel',NULL,NULL,NULL,'scared daily','歯磨きが苦手だった犬でも、このジェルを使い始めて歯磨きできるようになったという体験。','public_purchase_review_summary','https://review.rakuten.co.jp/review/item/1/404653_10000028/1.1/'),
('kins-dental-gel',NULL,NULL,NULL,'daily taste','ヤギミルク味を気に入り、毎日喜んで歯磨きさせてくれるのでリピートしているという体験。','public_purchase_review_summary','https://review.rakuten.co.jp/review/item/1/404653_10000028/1.1/'),
('kins-dental-gel','柴犬 15歳',NULL,NULL,'senior daily scared','15歳の柴犬に毎晩使用。ガーゼ磨きの仕上げに塗り込み、味が好きなためケアを受け入れてくれているという体験。','public_purchase_review_summary','https://review.rakuten.co.jp/review/item/1/404653_10000028/1.1/'),
('kins-dental-gel',NULL,NULL,NULL,'senior multi daily','歯石がつきやすいシニア犬2頭で、スケーリング後の毎日ケアとして使い始め、2頭とも最初から舐めてくれたという体験。','public_purchase_review_summary','https://review.rakuten.co.jp/review/item/1/404653_10000028/1.1/'),
('kins-dental-gel','保護犬 メス',NULL,NULL,'scared gentle','歯の状態が良く歯磨きも嫌いな保護犬で、味を気に入ったことで拭き取りケアを少しずつ進められたという体験。','public_purchase_review_summary','https://review.rakuten.co.jp/review/item/1/404653_10000028/1.1/'),
('kins-dental-gel',NULL,NULL,NULL,'cost daily','愛犬が気に入って継続できる一方、毎日使うには価格が高めと感じたという体験。','public_purchase_review_summary','https://review.rakuten.co.jp/review/item/1/404653_10000028/1.1/'),

('oratene-dental-gel',NULL,NULL,NULL,'puppy taste','1歳未満の犬で歯磨き習慣をつけるために使用し、味が好きなのか喜んでいたという体験。','public_purchase_review_summary','https://product.rakuten.co.jp/product/-/050f9e9f3e2e001647ec0cbd866cf2ca/review/'),
('oratene-dental-gel',NULL,NULL,NULL,'daily','先代犬の頃から長く使い続け、日常の口腔ケア用品として欠かせないと感じている体験。','public_purchase_review_summary','https://product.rakuten.co.jp/product/-/050f9e9f3e2e001647ec0cbd866cf2ca/review/'),
('oratene-dental-gel',NULL,NULL,NULL,'scared taste','このジェルならブラシでしっかり磨かせてもらいやすいと感じた体験。','public_purchase_review_summary','https://product.rakuten.co.jp/product/-/050f9e9f3e2e001647ec0cbd866cf2ca/review/'),
('oratene-dental-gel',NULL,NULL,NULL,'multi daily','多頭飼いで毎日使うため複数本セットを継続購入しているという体験。','public_purchase_review_summary','https://product.rakuten.co.jp/product/-/050f9e9f3e2e001647ec0cbd866cf2ca/review/'),
('oratene-dental-gel',NULL,NULL,NULL,'scared','歯磨きを嫌がって十分に磨けない犬でも、使い続けやすかったという体験。','public_purchase_review_summary','https://product.rakuten.co.jp/product/-/050f9e9f3e2e001647ec0cbd866cf2ca/review/'),
('oratene-dental-gel','トイプードル 18歳半',NULL,NULL,'senior daily','18歳半のトイプードルの毎日の歯磨きに長年使用しているという体験。','public_purchase_review_summary','https://product.rakuten.co.jp/product/-/050f9e9f3e2e001647ec0cbd866cf2ca/review/'),
('oratene-dental-gel',NULL,NULL,NULL,'taste daily','ジェルの味が好きで、少し舐めさせながらだと毎日の歯磨きを頑張れるという体験。','public_purchase_review_summary','https://product.rakuten.co.jp/product/-/050f9e9f3e2e001647ec0cbd866cf2ca/review/'),
('oratene-dental-gel',NULL,NULL,NULL,'scared daily','歯磨きは嫌がるものの味は好きなようで、歯石除去後の維持ケアとして続けているという体験。','public_purchase_review_summary','https://product.rakuten.co.jp/product/-/050f9e9f3e2e001647ec0cbd866cf2ca/review/'),
('oratene-dental-gel','トイプードル 4歳・スタンダードプードル 9か月',NULL,NULL,'multi puppy daily','トイプードル4歳とスタンダードプードル9か月の2頭に毎日使っているという体験。','public_purchase_review_summary','https://product.rakuten.co.jp/product/-/050f9e9f3e2e001647ec0cbd866cf2ca/review/'),
('oratene-dental-gel',NULL,NULL,NULL,'cost','従来より内容量が少なくなり、価格とのバランスが気になったという体験。','public_purchase_review_summary','https://product.rakuten.co.jp/product/-/050f9e9f3e2e001647ec0cbd866cf2ca/review/'),

('petkiss-gel-leaf','チワワ',NULL,NULL,'scared taste','香りや犬の受け入れやすさを比べた末にこのジェルへ戻り、歯磨きのきっかけとして使っているという体験。','public_purchase_review_summary','https://review.rakuten.co.jp/item/1/388158_10014389/1.1/'),
('petkiss-gel-leaf',NULL,NULL,NULL,'scared daily','犬が嫌がらず歯磨きさせてくれるためリピートしているという体験。','public_purchase_review_summary','https://review.rakuten.co.jp/item/1/388158_10014389/1.1/'),
('petkiss-gel-leaf',NULL,NULL,NULL,'taste daily','寝る前のケアに使用し、香りと味が良いのか愛犬が喜ぶという体験。','public_purchase_review_summary','https://review.rakuten.co.jp/item/1/388158_10014389/1.1/'),
('petkiss-gel-leaf',NULL,NULL,NULL,'daily','毎日の歯磨きで継続使用しやすく、ドラッグストアより安く買えた点も良かったという体験。','public_purchase_review_summary','https://review.rakuten.co.jp/item/1/388158_10014389/1.1/'),
('petkiss-gel-leaf',NULL,NULL,NULL,'taste scared','歯磨き後のご褒美として使うと愛犬が喜び、歯磨きに協力しやすくなったという体験。','public_purchase_review_summary','https://review.rakuten.co.jp/review/item/1/211165_10490047/1.1/'),
('petkiss-gel-leaf',NULL,NULL,NULL,'daily','他の香りも試したがリーフの香りを一番使いやすく感じ、毎日使っているという体験。','public_purchase_review_summary','https://review.rakuten.co.jp/item/1/254471_10106253/1.1/'),
('petkiss-gel-leaf',NULL,NULL,NULL,'taste','チキン味だと興奮しそうなのでリーフを選び、草のような香りを好む犬が楽しんで歯磨きしているという体験。','public_purchase_review_summary','https://review.rakuten.co.jp/item/1/254471_10106253/1.1/'),
('petkiss-gel-leaf',NULL,NULL,NULL,'scared','塗るだけではなく実際に磨く必要があると考え、犬が嫌がりにくいジェルとして使っているという体験。','public_purchase_review_summary','https://review.rakuten.co.jp/item/1/388158_10014389/1.1/'),

('dr-yujiro-dental-gel',NULL,NULL,NULL,'multi daily','多頭飼いで毎日歯磨き後に指で塗っており、1本の減りが早いものの継続しているという体験。','public_purchase_review_summary','https://review.rakuten.co.jp/review/item/1/300669_10000000/1.1/'),
('dr-yujiro-dental-gel',NULL,NULL,NULL,'taste','独特の香りでそのままでは舐めなかったため、チキン味のペーストに混ぜると使えたという体験。','public_purchase_review_summary','https://review.rakuten.co.jp/review/item/1/300669_10000000/1.1/'),
('dr-yujiro-dental-gel','トイプードル 10歳',NULL,NULL,'senior daily','10歳のトイプードルに数年使用し、毎日のケアを続けているという体験。','public_purchase_review_summary','https://review.rakuten.co.jp/review/item/1/300669_10000000/1.1/'),
('dr-yujiro-dental-gel',NULL,NULL,NULL,'taste beginner','使い始め3日目でも犬たちがペロペロ舐め、味の面では続けられそうと感じた体験。','public_purchase_review_summary','https://review.rakuten.co.jp/review/item/1/300669_10000000/1.1/'),
('dr-yujiro-dental-gel',NULL,NULL,NULL,'daily','毎日歯磨き後に犬歯や歯ぐきへ塗る使い方を続けているという体験。','public_purchase_review_summary','https://review.rakuten.co.jp/review/item/1/300669_10000000/1.1/'),
('dr-yujiro-dental-gel',NULL,NULL,NULL,'daily','指で歯へ直接塗る方法で長く継続しているという体験。','public_purchase_review_summary','https://review.rakuten.co.jp/review/item/1/300669_10000000/1.1/'),
('dr-yujiro-dental-gel',NULL,NULL,NULL,'scared taste','犬には苦そうで嫌がることもあるが、毎日少しずつ続けているという体験。','public_purchase_review_summary','https://review.rakuten.co.jp/review/item/1/300669_10000000/1.1/'),
('dr-yujiro-dental-gel',NULL,NULL,NULL,'daily','すぐには変化を感じなかったが、長期で使い続けるうちにケアの手応えを感じたという体験。','public_purchase_review_summary','https://review.rakuten.co.jp/review/item/1/300669_10000000/1.1/'),

('virbac-cet-chicken',NULL,NULL,NULL,'taste scared','味を気に入っているため、強く嫌がらず歯磨きさせてくれるという体験。','public_purchase_review_summary','https://review.rakuten.co.jp/review/review/item/1/268103_10001054/1.1/'),
('virbac-cet-chicken',NULL,NULL,NULL,'taste','トリマーに教えてもらって購入し、犬が美味しそうに舐めていたという体験。','public_purchase_review_summary','https://review.rakuten.co.jp/review/review/item/1/268103_10001054/1.1/'),
('virbac-cet-chicken',NULL,NULL,NULL,'beginner scared','病院で歯磨きを勧められて初めて使用。最初に舐めさせると受け入れたため、慣らしながら続けているという体験。','public_purchase_review_summary','https://review.rakuten.co.jp/review/review/item/1/268103_10001054/1.1/'),
('virbac-cet-chicken','ワイヤーダックス',NULL,NULL,'taste beginner','おやつと勘違いするほど食いつきが良く、歯磨き練習を続けやすかった一方、ひげにペーストが絡みやすかったという体験。','public_purchase_review_summary','https://review.rakuten.co.jp/review/review/item/1/268103_10001054/1.1/'),
('virbac-cet-chicken',NULL,NULL,NULL,'daily taste','先代犬の時から15年近く使い続け、現在の2頭にも継続しているという体験。','public_purchase_review_summary','https://review.rakuten.co.jp/item/1/256849_10012137/1.1/'),
('virbac-cet-chicken',NULL,NULL,NULL,'taste','犬がチキン味を気に入り、歯磨きガムに少量つける使い方をしているという体験。','public_purchase_review_summary','https://review.rakuten.co.jp/item/1/256849_10012244/1.1/'),
('virbac-cet-chicken',NULL,NULL,NULL,'daily taste','嗜好性が高く、毎日の歯磨きのご褒美感覚で使いやすかったという体験。','public_purchase_review_summary','https://review.rakuten.co.jp/item/1/256849_10012244/1.1/'),

('virbac-cet-vanilla-mint',NULL,NULL,NULL,'senior daily','7歳の愛犬に動物病院の勧めで使用し、毎日できる範囲で歯磨きを続けているという体験。','public_purchase_review_summary','https://review.rakuten.co.jp/review/item/1/256849_10008775/1.1/'),
('virbac-cet-vanilla-mint',NULL,NULL,NULL,'taste daily','愛犬が気に入っているようで、自分から歯磨きを要求することがあるという体験。','public_purchase_review_summary','https://review.rakuten.co.jp/review/item/1/256849_10008775/1.1/'),
('virbac-cet-vanilla-mint',NULL,NULL,NULL,'scared','歯磨きさせてくれないため歯磨き棒に付けて使い、香りは好印象だったという体験。','public_purchase_review_summary','https://review.rakuten.co.jp/review/item/1/256849_10008775/1.1/'),
('virbac-cet-vanilla-mint',NULL,NULL,NULL,'senior multi daily','シニア犬4頭で長く使用し、歯磨き後のすっきり感を気に入っているという体験。','public_purchase_review_summary','https://review.rakuten.co.jp/review/item/1/256849_10008775/1.1/'),
('virbac-cet-vanilla-mint',NULL,NULL,NULL,'allergy daily','食物アレルギーがある犬で他の味が合わず、バニラミントを継続しているという体験。','public_purchase_review_summary','https://review.rakuten.co.jp/review/item/1/256849_10008775/1.1/'),
('virbac-cet-vanilla-mint','ミニチュアシュナウザー 3歳',NULL,NULL,'daily taste','3歳のミニチュアシュナウザーで嫌がらず使え、1日2回の歯磨きに継続しやすかったという体験。','public_purchase_review_summary','https://review.rakuten.co.jp/review/item/1/256849_10008775/1.1/'),
('virbac-cet-vanilla-mint','トイプードル 8歳',NULL,NULL,'senior taste','8歳のトイプードルで子犬の頃から使用し、この味を好んでいるという体験。','public_purchase_review_summary','https://review.rakuten.co.jp/review/item/1/256849_10008775/1.1/');

SELECT COUNT(*) AS toothpaste_product_count FROM products WHERE category='dog-toothpaste' AND active=1;
SELECT COUNT(*) AS toothpaste_review_count FROM reviews r JOIN products p ON p.id=r.product_id WHERE p.category='dog-toothpaste';
