PRAGMA foreign_keys = ON;

WITH new_reviews(product_id,dog_breed,dog_size,coat_type,needs,summary,source_type,source_url) AS (
VALUES
('apdc-teatree','犬種不明・パピー期から使用',NULL,NULL,'puppy long-use skin','パピー期から継続して使い、購入者は皮膚トラブルなく使えていると感じている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/349561_10003253/1.1/'),
('apdc-teatree','犬種不明・長期使用',NULL,NULL,'long-use shine','長年使い続け、被毛の艶が良くなったように感じて気に入っている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/349561_10003253/1.1/'),
('apdc-teatree','犬種不明・大容量使用',NULL,NULL,'large-volume mild-scent','5Lを選び、犬にも負担が少なそうな優しい香りで飼い主も心地よく感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/349561_10003253/1.1/'),
('apdc-teatree','犬種不明・迎えてから継続',NULL,NULL,'long-use scent smooth salon','迎えてからずっと使い、自宅だけでなくトリミングサロンにも持ち込み、爽やかな香りと手触りを気に入っている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/349561_10003253/1.1/'),
('apdc-teatree','犬種不明・リピーター',NULL,NULL,'repeat scent','香りを気に入って再購入し、継続して使っている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/349561_10003253/1.1/'),
('apdc-teatree','犬種不明・パッケージ変更後も継続',NULL,NULL,'repeat scent lasting','以前から使い続け、パッケージ変更後も購入。シャンプー後のほのかな香りが続き、周囲からも良い香りと言われた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/349561_10003253/1.1/'),
('apdc-teatree','犬種不明・長期リピート',NULL,NULL,'repeat scent home','長くリピートし、洗った後しばらく部屋にも良い香りが広がる点を気に入っている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/349561_10003253/1.1/'),
('apdc-teatree','トイプードル・15歳','small','curly','senior long-use fluffy scent','15歳のトイプードルに長年使い続け、良い香りとふわっとした仕上がりを気に入っている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/349561_10003253/1.1/'),
('apdc-teatree','犬種不明',NULL,NULL,'clean scent','汚れがきれいになり、香りもとても良いと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/349561_10003253/1.1/'),
('apdc-teatree','トイプードル','small','curly','scent repeat','香りを気に入り、今後はトイプードルの定番シャンプーとして使いたいと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/349561_10003253/1.1/'),

('zoic-n-short','マルチーズ','small','long','foam mild-scent dilute','ポメラニアン用に選んだ製品を先にマルチーズへ使い、お湯で薄めても少量で細かな泡が立ち、香りも強すぎないと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/2719d6717a/review/'),
('zoic-n-short','犬・10か月','small',NULL,'puppy fluffy static tangle','パピー用からショートへ切り替え、ふわっと仕上がり、静電気や毛玉対策にも使いやすいと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/2719d6717a/review/'),
('zoic-n-short','犬種不明',NULL,NULL,'foam mild-scent clean caregiver-hands','少量でも泡立ちが良く、優しい香りときれいな仕上がりを感じ、洗う側の手も荒れにくかったという体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/2719d6717a/review/'),
('zoic-n-short','犬種不明・リンスインから変更',NULL,NULL,'foam mild-scent fluffy','リンスインからシャンプーとリンス別タイプへ替え、泡立ちが良く、香りも強すぎず、家庭洗いでもふわっとした手触りになった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/2719d6717a/review/'),
('zoic-n-short','犬種不明',NULL,NULL,'scent shine smooth','シャンプーを2本購入して使い、乾かした後は強すぎないフローラル系の香りで、被毛がつやつや・さらさらに感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/2719d6717a/review/'),
('zoic-n-short','トイプードル','small','curly','foam rinse home-grooming','耳を長めにしたトイプードルの自宅ケアに使い、泡立ちと泡切れが良く、トリミングの合間にも使いやすいと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/2719d6717a/review/'),
('zoic-n-short','トイプードル・5kg','small','curly','repeat shine coat scent frequent-wash','5kgのトイプードルに繰り返し使い、洗った後の毛艶・毛並み・手触りと香りを気に入っている体験。泥汚れで続けて洗った時も購入者は肌荒れを感じなかった。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/2719d6717a/review/'),
('zoic-n-short','ミニチュアダックスフンド','small',NULL,'rinse-speed mild-scent mixed-foam','ミニチュアダックスに使い、香りが強すぎず泡切れが早いため寒い時期に短時間で終えやすい一方、泡立ちはもう少し欲しいと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/2719d6717a/review/'),
('zoic-n-short','トイプードル多頭飼い','small','curly','multi foam scent fluffy','複数のトイプードルに使い、泡立ちと香りが良く、乾かした後はふわっとして香りもほんのり残ると感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/2719d6717a/review/2/'),
('zoic-n-short','トイプードル','small','curly','home-wash scent fluffy repeat','サロンで勧められてトイプードルの自宅洗いに使い、2週間に1度の使用で良い香りとふわっとした仕上がりを感じている体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/2719d6717a/review/2/'),

('zoic-n-long','犬種不明',NULL,NULL,'foam soft fluffy scent','シャンプーの泡がきめ細かく、洗い流した時から手触りの変化を感じ、リンス併用後はさらにふわっと柔らかく仕上がった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/30291805b1/review/'),
('zoic-n-long','ミニチュアダックスフンド・13歳','small','long','senior odor fluffy mild-scent','13歳のロングコートダックスに使い、強い香りでごまかさなくても数日後のにおいが気になりにくく、洗い上がりもふわっとしたと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/30291805b1/review/'),
('zoic-n-long','ロングコートチワワ','small','long','long-use scent stress cost','ロングコートチワワに半年ほど月1〜2回使い、香りが強すぎず翌日もほのかに残り、犬も大きなストレスなく使えていると感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/30291805b1/review/'),
('zoic-n-long','シーズー','small','long','soft shine dandruff scent','シーズーに使い、香りは控えめだが毛が柔らかく艶も出たと感じ、冬場のシャンプー後に出ていたフケも購入者は気にならなくなった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/30291805b1/review/'),
('zoic-n-long','プードル','small','curly long','tangle soft fluffy separate-care','毛が伸びると毛玉ができやすいプードルで、トリートメントインからシャンプーとリンス別タイプへ替え、乾かす段階から柔らかさとしっとり・ふわっとした仕上がりの違いを感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/30291805b1/review/'),
('zoic-n-long','ミニチュアシュナウザー','small',NULL,'foam mild-scent fluffy lasting','ミニチュアシュナウザーに使い、泡立ちが良く香りも強すぎず、洗った後のふわっと感が数日続いたと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/30291805b1/review/'),
('zoic-n-long','犬種不明・以前の製品で痒がった犬',NULL,NULL,'scent skin-observation repeat','以前の安価なシャンプーでは痒がる様子があった犬で、ZOICを数回使った後は購入者がその様子を感じにくくなり、香りも気に入った体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/30291805b1/review/'),
('zoic-n-long','白い被毛の犬',NULL,'long','white-coat foam scent','白い被毛の犬に使い、以前使っていた同シリーズ別タイプより白さが目立つように感じ、泡立ちと香りも良いと評価した体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/30291805b1/review/2/'),
('zoic-n-long','犬複数頭',NULL,NULL,'multi repeat smooth scent','複数の犬にシャンプーとリンスを別々に使い、洗った後しばらくサラサラ感が続き、香りも気に入って再購入した体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/30291805b1/review/2/'),
('zoic-n-long','ポメラニアン・3歳','small','long','tangle fluffy repeat','3歳のポメラニアンに使い、洗っている時も毛の絡まりが気になりにくく、ドライ後はふわっと仕上がるため他社製品から戻した体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/30291805b1/review/2/'),
('zoic-n-long','ミニチュアシュナウザー','small','long','static smooth fluffy moist scent','髭や足の毛が絡みやすいミニチュアシュナウザーに使い、冬の静電気が気になる時期でもサラサラ・ふわふわ・しっとりした仕上がりと香りを気に入った体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/30291805b1/review/2/'),
('zoic-n-long','犬種不明',NULL,NULL,'scent soft relaxed','薬用シャンプーから替え、香りと毛並みの柔らかさを実感し、犬も気持ちよさそうにしていたと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/30291805b1/review/2/'),
('zoic-n-long','トイプードル','small','curly','finish mild-scent price','トイプードルに使い、価格は高めに感じたものの仕上がりは良く、香りはもう少し欲しいと感じた混合評価。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/30291805b1/review/2/'),
('zoic-n-long','犬種不明・トリマー推奨',NULL,NULL,'mild-scent lasting smooth fluffy','トリマーに聞いて購入し、香りがかなり控えめで、1か月ほど経っても被毛がふわっとサラサラしていると感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/30291805b1/review/2/'),
('zoic-n-long','犬種不明・リピーター',NULL,NULL,'repeat scent shine smooth','リピートして使い、香りが良く、洗った後は被毛がサラサラ・艶やかになると感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/30291805b1/review/2/'),
('zoic-n-long','犬種不明・成犬',NULL,NULL,'tangle fluffy return','パピー用から他社製品へ替えたらキシつきや毛玉が気になったためZOICへ戻し、洗っている時のきしみが少なく、洗い上がりもふんわりしたと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/30291805b1/review/2/'),
('zoic-n-long','犬種不明',NULL,NULL,'foam fluffy mild-scent','泡立ちが良く、リンス併用でふわっと仕上がり、香りは控えめで犬には強すぎないと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/30291805b1/review/3/'),
('zoic-n-long','シェットランドシープドッグ','medium','long double','puppy-to-adult shine mild-scent','パピー用から長毛用へ切り替えたシェルティで、細かな泡立ちと穏やかな香りを気に入り、乾かした後もパサつかず艶よく仕上がったと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/30291805b1/review/3/'),
('zoic-n-long','カニンヘンダックス','small','long','long-use finish','ロングヘアのカニンヘンダックスに20年以上同シリーズを使い続け、仕上がりの良さから家庭の定番になっている体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/30291805b1/review/3/'),
('zoic-n-long','マルチーズ','small','long','foam mild-scent smooth rinse-caution','マルチーズに使い、泡立ちが良く香りも控えめで、乾かした後はさらっとした手触りになった一方、つけすぎるとすすぎに時間がかかると感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/30291805b1/review/3/'),
('zoic-n-long','ポメラニアン','small','long','long-use smooth fluffy scent','ポメラニアンに10年以上使い続け、香りとシャンプー後のサラサラ・ふわっとした仕上がりを気に入っている体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/30291805b1/review/3/'),
('zoic-n-long','犬種不明',NULL,NULL,'foam rinse shine fluffy','泡立ちと泡切れが良く、乾かした後は艶とふわっとした仕上がりを感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/30291805b1/review/3/'),
('zoic-n-long','ヨークシャーテリア','small','long','shine soft sensitive-skin observation','ヨークシャーテリアに初めて使い、泡立ちが良く香りもきつすぎず、リンス後は艶と柔らかさを感じた体験。皮膚が弱いため使用後の様子を見ながら継続を検討している。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/30291805b1/review/3/'),
('zoic-n-long','毛量の多い犬',NULL,NULL,'fluffy volume repeat','しっとりしすぎると被毛がぺたんこになりやすい犬で、他製品と比べて毛量感を保ちながらふわっと仕上がる点を気に入って戻った体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/30291805b1/review/3/'),
('zoic-n-long','ロングコートチワワ','small','long','repeat scent smooth odor','ロングコートチワワに2週間おきの自宅風呂とトリミングを交互にしながら使い、香りが続きやすく被毛もサラサラに感じるためリピートしている体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/30291805b1/review/3/'),

('shizenryu-all','トイプードル','small','curly','negative dry tangle','元トリマーの購入者がプードルに使い、被毛がパサつき、数日後にもつれが増えたように感じたためリピートしないとした否定的体験。','public_buyer_review_summary','https://item.rakuten.co.jp/petech/009529/'),
('shizenryu-all','犬種不明',NULL,NULL,'fluffy scent caution','洗い上がりがふわっとした一方、香りは飼い主には好みでも犬にはもう少し控えめでもよいと感じた体験。','public_buyer_review_summary','https://item.rakuten.co.jp/petech/009529/'),
('shizenryu-all','犬種不明',NULL,NULL,'foam rinse fluffy scent','香りと泡切れが良く、洗った後はふわっとした仕上がりになったと感じた体験。','public_buyer_review_summary','https://item.rakuten.co.jp/petech/009529/'),
('shizenryu-all','犬2頭',NULL,NULL,'multi gentle coat mild-scent','2頭に使い、どちらもシャンプーを強く嫌がらず、毛並みが整い香りも控えめだと感じた体験。','public_buyer_review_summary','https://item.rakuten.co.jp/naturehill-hill/h-4315-new/'),
('shizenryu-all','小型犬','small',NULL,'weekly long-use clean scent value','小型犬に週1回ほど使い、業務用サイズを約2年使えたほど長持ちし、香りと洗い上がりを気に入っている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/216162_10018165/1.1/')
)
INSERT INTO reviews(product_id,dog_breed,dog_size,coat_type,needs,summary,source_type,source_url)
SELECT n.product_id,n.dog_breed,n.dog_size,n.coat_type,n.needs,n.summary,n.source_type,n.source_url
FROM new_reviews n
WHERE NOT EXISTS (
  SELECT 1 FROM reviews r
  WHERE r.product_id=n.product_id
    AND r.summary=n.summary
);

SELECT COUNT(*) AS dog_shampoo_product_count
FROM products
WHERE category='dog-shampoo' AND active=1;

SELECT COUNT(*) AS dog_shampoo_review_count
FROM reviews r
JOIN products p ON p.id=r.product_id
WHERE p.category='dog-shampoo' AND p.active=1;
