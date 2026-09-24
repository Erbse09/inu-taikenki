PRAGMA foreign_keys = ON;

WITH new_reviews(product_id,dog_breed,dog_size,coat_type,needs,summary,source_type,source_url) AS (
VALUES
('norvasan-otic','アメリカンコッカースパニエル',NULL,NULL,'droop repeat','垂れ耳のアメリカンコッカーで何度もリピートし、日常の耳洗浄に欠かせないと感じている体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=4571144450038&store_id=petgo'),
('norvasan-otic','トイプードル',NULL,NULL,'itch smell weekly','耳を強く痒がっていたトイプードルに使い、数回で掻く仕草とにおいがかなり減り、その後は週1回ほどのケアにしている体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/0196d09e7c/review/'),
('norvasan-otic','シーズー2頭＋ヨークシャーテリアの子犬',NULL,NULL,'multi wet-ear ear-mite','多頭飼いで使用し、耳が蒸れやすいシーズーや迎えたばかりのヨーキーの耳汚れに、入浴時の耳洗浄と拭き取りを組み合わせている体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/2bf7b975f0?reviewp=1'),
('norvasan-otic','大型犬','large',NULL,'vet trust long-term','大型犬を代々飼う家庭で、動物病院と同じ製品という安心感から20年近く耳掃除に使い続けている体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/0196d09e7c/review/'),
('norvasan-otic','犬2頭',NULL,NULL,'multi shampoo massage','月1回のシャンプー時に2頭まとめて耳へ入れ、耳の付け根をマッサージして自分でブルブルさせる方法で使っている体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=4571144450045&store_id=petgo'),
('norvasan-otic','初めて犬を飼った家庭',NULL,NULL,'beginner cap usability','初めて犬を飼い耳掃除用に購入したが、キャップを外すのではなく緩めて使う構造が分かりにくく、初心者には説明が欲しいと感じた体験。','public_buyer_review_summary','https://store.shopping.yahoo.co.jp/petgo-2nd/4571144450045.html'),
('norvasan-otic','犬種不明・耳が赤くなりやすい犬',NULL,NULL,'redness odor weekly','耳に赤みとにおいが出た時に獣医師から教わった方法で洗浄し、数日で落ち着いた後は刺激を避けるため週1回程度にしている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/204094_10001084/1.1/'),
('norvasan-otic','ラブラドール3頭','large',NULL,'multi chronic-wet-ear','3頭のラブラドールのうち耳が常に湿りやすい1頭へ使い、自宅でこまめに耳内を清潔に保つケアへ取り入れた体験。','public_buyer_review_summary','https://store.shopping.yahoo.co.jp/petgo/4571144450038.html'),
('norvasan-otic','犬種不明・大容量を小分け使用',NULL,NULL,'large-bottle refill','大容量ボトルを小さい容器へ詰め替えて使うことで、継続ケアのコストを抑えながら使いやすさも確保している体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/204094_10001084/1.1/'),
('oats-ear-cleaner','チワックス',NULL,NULL,'droop shampoo odor','垂れ耳で汚れやすいチワックスに、シャンプー前に耳へ入れて揉み、ブルブルさせる方法で使うとにおいが気になりにくくなる体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/p/1a145ceacd/review/'),
('oats-ear-cleaner','耳毛が伸びやすい犬',NULL,NULL,'ear-hair cleaning','耳毛が伸びやすく汚れがたまりやすい犬で、耳毛ケアと併用して汚れが気になる時だけ少量使っている体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/p/1a145ceacd/review/'),
('oats-ear-cleaner','犬種不明・香りに敏感',NULL,NULL,'unscented scared','以前使っていた香りの強いクリーナーを嫌がった犬が、においの穏やかなオーツでは我慢できる時間が長くなった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/7e0990ae13'),
('oats-ear-cleaner','犬種不明・春秋に汚れやすい',NULL,NULL,'seasonal dirt','春と秋に耳が汚れやすい犬へ長く使い、季節の変わり目の定期ケアとして取り入れている体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=oats-cle&store_id=pet1122'),
('oats-ear-cleaner','外耳炎治療中の犬',NULL,NULL,'otitis weekly wax','外耳炎で通院中の犬に週1回の自宅洗浄として使い、使用後は耳垢が見える位置まで出てきて拭き取りやすくなった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=dss-100900-001s00&store_id=doubutsunotame'),
('oats-ear-cleaner','犬種不明・かゆみが気になる犬',NULL,NULL,'itch improvement','耳を掻く仕草が気になった時に使い始め、数日後から掻く頻度が少なくなったように感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=dss-100900-001s00&store_id=doubutsunotame'),
('oats-ear-cleaner','犬種不明・液量調整重視',NULL,NULL,'narrow-nozzle handling','他製品は液が出すぎると感じていたが、細いノズルで少量ずつ入れやすく、耳掃除の量を調整しやすかった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=oats-cle&store_id=pet1122'),
('oats-ear-cleaner','犬種不明・動物病院推奨',NULL,NULL,'vet repeat','通院先でも勧められて購入し、自宅での定期的な耳掃除に安心して使い続けている体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=dss-100900-001s00&store_id=doubutsunotame'),
('epiotic-peptide','中型犬・約10kg','medium',NULL,'daily odor wax cost','約10kgの垂れ耳犬に毎日使い、耳垢とにおいが減ったと感じる一方、日常使いでは価格が少し高いと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/214024_10001297/1.1/'),
('epiotic-peptide','犬種不明・動物病院と同じ製品',NULL,NULL,'vet gentle fragrance','動物病院で使われているものと同じ製品を選び、刺激が強すぎず香りも受け入れやすいと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/214024_10001297/1.1/'),
('epiotic-peptide','外耳炎を繰り返していた犬',NULL,NULL,'otitis brown-wax odor','他のクリーナーで改善しにくかった褐色の耳垢とにおいが、この製品へ替えて気になりにくくなった一方、容器は少し扱いにくいと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/214024_10001297/1.1/'),
('epiotic-peptide','アレルギーのある垂れ耳犬',NULL,NULL,'allergy humid-season weekly','アレルギーがあり垂れ耳の犬に、湿度の高い夏は週1〜2回使うと耳の状態が安定しやすいと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/214024_10001297/1.1/'),
('epiotic-peptide','耳汚れを繰り返す犬',NULL,NULL,'mixed-effect vet-switch','普段のケアには使いやすいが、菌が増えて汚れが落ちにくい時は十分でないことがあり、獣医師へ相談して別製品へ一時的に切り替えた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/214024_10001297/1.1/'),
('epiotic-peptide','耳掃除が苦手な犬',NULL,NULL,'scared fragrance prevention','香りを察すると逃げるほど耳掃除が苦手な犬でも、軽い外耳炎をきっかけに定期使用し、その後は大きなトラブルなく維持できている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/214024_10001297/1.1/'),
('epiotic-peptide','垂れ耳のシニア犬',NULL,NULL,'senior droop daily','高齢の垂れ耳犬で毎日のケアに使い、使用後の耳のにおいがすっきりする点を気に入っている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/214024_10001297/1.1/'),
('epiotic-peptide','シーズー',NULL,NULL,'breed recurrent-ear','耳トラブルが起きやすいシーズーに、コットンへ含ませて拭くと気持ちよさそうにしており、手放せないと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/214024_10001297/1.1/'),
('lanatule-ear-cleaner','耳掃除が初めての犬',NULL,NULL,'beginner scared unscented','初めての耳掃除で犬が逃げてしまいまだ使いこなせていないが、無香料でにおいが気にならない点は使いやすいと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/394896_10000092/1.1/'),
('lanatule-ear-cleaner','トイプードル・1歳','small','curly','droop inflammation dirt','垂れ耳で炎症や汚れが出やすい1歳のトイプードルに使い、定期ケアを続けるうちに気になりにくくなった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=lanatule-ear-mall&store_id=baumkuchen'),
('lanatule-ear-cleaner','シーズー・5歳','small',NULL,'droop inflammation cleaning','5歳のシーズーで垂れ耳の炎症が多く、使用後は耳がさらっとして汚れもしっかり取れたと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=lanatule-ear-mall&store_id=baumkuchen'),
('lanatule-ear-cleaner','ブラックのトイプードル','small','curly','droop odor brown-wax','耳がにおいやすい黒毛のトイプードルで、シャンプー前に注入して揉み、拭き取ると茶色い汚れがしっかり取れた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=lanatule-ear-mall&store_id=baumkuchen'),
('lanatule-ear-cleaner','敏感肌の犬',NULL,NULL,'sensitive natural','自然由来成分と無香料を重視して選び、使っている間は皮膚トラブルが出ず続けやすいと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=lanatule-ear-mall&store_id=baumkuchen'),
('lanatule-ear-cleaner','犬種不明・容器の扱いに注意',NULL,NULL,'cap flow caution','キャップを回して開ける構造は便利だが、開きすぎると押さなくても液が出やすいため、直接入れる時は流量に注意した体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=lanatule-ear-mall&store_id=baumkuchen'),
('lanatule-ear-cleaner','垂れ耳の犬',NULL,NULL,'droop itch dirt','梅雨時に耳垢と痒みが出やすい垂れ耳犬へ使い、直接流して揉んだ後は奥の汚れも取れやすかった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=lanatule-ear-mall&store_id=baumkuchen'),
('lanatule-ear-cleaner','犬種不明・直接注入が苦手',NULL,NULL,'cotton alternative','耳へ直接入れるのが難しい時はコットンへ含ませて拭く方法で使い、見える範囲の汚れを落としやすかった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=lanatule-ear-mall&store_id=baumkuchen'),
('lanatule-ear-cleaner','犬種不明・におい重視',NULL,NULL,'odor mixed','耳の汚れは取れやすかった一方、においへの変化は数回使わないと分かりにくいと感じ、継続して様子を見た体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=lanatule-ear-mall&store_id=baumkuchen'),
('sure-limpu-ear','梅雨時に耳を痒がる犬2頭',NULL,NULL,'multi humid-season itch odor','梅雨時に耳の痒みとにおいが続く2頭へ使い、軽い方は2日ほどで気になりにくくなり、症状の強い方はもう少し継続が必要と感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/review/review/item/1/302082_10001828/1.1/'),
('sure-limpu-ear','ラブラドール・10歳','large',NULL,'senior redness odor portable','10歳のラブラドールで耳の赤みと強いにおいが増えたため、1日1回を数日続けて改善を感じ、小ボトルを散歩時にも持ち歩いた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/review/review/item/1/302082_10001828/1.1/'),
('sure-limpu-ear','犬種不明・耳掃除を嫌がる犬',NULL,NULL,'scared odor','しつけ教室で紹介され、耳のにおいは大きく減ったと感じた一方、点耳自体は嫌がるため慣らしが必要だった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/review/review/item/1/302082_10001828/1.1/'),
('sure-limpu-ear','耳垢と黒ずみが出やすい犬',NULL,NULL,'black-wax wipe','耳垢や黒ずみが気になる時に毎日使い、綿棒やコットンへ含ませて耳の入口や裏側まで拭くと汚れが落ちやすかった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/review/review/item/1/302082_10001828/1.1/'),
('sure-limpu-ear','子犬','small',NULL,'puppy scared unscented','耳掃除を嫌がる子犬へ使い、無臭で刺激を感じにくかったのか、頭を振る回数が減ったように感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/219987_10003978/1.1/'),
('sure-limpu-ear','コーギーの子犬','medium',NULL,'puppy upright-ear dirt','立ち耳のコーギーの子犬で汚れが広がりやすく、さらっとしたローションが耳全体へなじみやすく拭き取りやすかった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/219987_10003978/1.1/'),
('sure-limpu-ear','耳トラブルのなかった犬',NULL,NULL,'negative redness','予防目的で使ったところ、回数を重ねるほど耳の中が赤くなり、使用をやめると治まったため相性が合わないと判断した体験。','public_buyer_review_summary','https://review.rakuten.co.jp/review/review/item/1/302082_10001828/1.1/'),
('sure-limpu-ear','ミニチュアダックスフンド',NULL,NULL,'droop negative compare','垂れ耳のダックスで外耳炎予防に週2回使ったが、汚れ方に大きな変化を感じず、においも気になったため別のクリーナーへ替えた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/review/review/item/1/302082_10001828/1.1/'),
('mimikyua-one','耳を痒がる犬',NULL,NULL,'itch dirt gentle','耳を痒がっていた犬に使うと強く嫌がらず、汚れがしっかり取れてケアしやすかった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/394896_10000025/1.1/'),
('mimikyua-one','アレルギー体質の犬',NULL,NULL,'allergy routine','アレルギー体質で耳も汚れやすいため定期的に使い、扱いやすく清潔を保ちやすいと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/394896_10000025/1.1/'),
('mimikyua-one','多頭飼い',NULL,NULL,'multi value','子犬の頃から使い続け、多頭飼いになって使用量は増えたものの、容量と価格のバランスが良く続けやすいと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/394896_10000025/1.1/'),
('mimikyua-one','ラブラドールレトリバー','large',NULL,'large otitis cotton','ラブラドールが外耳炎になった時に使い、直接耳へ液を入れるのを嫌がるためコットンへ含ませて拭く方法なら続けやすかった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/394896_10000025/1.1/'),
('mimikyua-one','耳掃除が苦手な犬',NULL,NULL,'scared mild-scent','耳掃除そのものは苦手でも香りがきつくなく、使用後に痒がる様子もないため継続している体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/394896_10000025/1.1/'),
('mimikyua-one','トイプードル','small','curly','cold-season daily','トイプードルの日常ケアに使い、冬は液が冷たく少し嫌がるものの、香りも含めて欠かせないと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/394896_10000025/1.1/'),
('mimikyua-one','ゴールデンレトリバー','large','long','gentle scent','ゴールデンの耳掃除に使い、低刺激で嫌がりにくく、使用後の香りも強すぎない点を気に入った体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/394896_10000025/1.1/'),
('mimikyua-one','垂れ耳のトイプードル','small','curly','droop recurrent-otitis nozzle','外耳炎になりやすい垂れ耳のトイプードルで、病院の洗浄液より香りが穏やかで、ノズルの流量を調整しながら使いやすかった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/394896_10000025/1.1/')
)
INSERT INTO reviews(product_id,dog_breed,dog_size,coat_type,needs,summary,source_type,source_url)
SELECT n.product_id,n.dog_breed,n.dog_size,n.coat_type,n.needs,n.summary,n.source_type,n.source_url
FROM new_reviews n
WHERE NOT EXISTS (
  SELECT 1 FROM reviews r
  WHERE r.product_id=n.product_id
    AND r.summary=n.summary
);

SELECT COUNT(*) AS ear_cleaner_product_count
FROM products
WHERE category='dog-ear-cleaner' AND active=1;

SELECT COUNT(*) AS ear_cleaner_review_count
FROM reviews r
JOIN products p ON p.id=r.product_id
WHERE p.category='dog-ear-cleaner' AND p.active=1;
