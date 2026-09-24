PRAGMA foreign_keys = ON;

WITH new_reviews(product_id,dog_breed,dog_size,coat_type,needs,summary,source_type,source_url) AS (
VALUES
('mindup-small-head','中型犬・やや小さめ','medium',NULL,'curve molar','子ども用歯ブラシを試していた家庭で変更し、犬の口に合うカーブで奥歯へ当てやすくなった一方、頻繁に交換するには価格が少し高いと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/239851_10003361/1.1/'),
('mindup-small-head','犬種不明・リピーター',NULL,NULL,'molar durability','奥歯まで磨きやすく何度も使っている一方、噛んだり使い込んだりすると毛先が早く傷みやすいと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/239851_10003361/1.1/'),
('mindup-small-head','小型犬','small',NULL,'molar firmness','小型犬に使い、小さめヘッドと適度な毛の硬さで奥歯まで届かせやすかった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/239851_10003361/1.1/'),
('mindup-small-head','犬種不明・子ども用歯ブラシから変更',NULL,NULL,'compact curved-handle','人間の子ども用よりさらにヘッドが小さく、柄の適度なカーブも犬の口へ当てやすいと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/239851_10003361/1.1/'),
('mindup-small-head','犬種不明・歯石除去後',NULL,NULL,'daily treat routine','病院で歯石除去後にもらったサンプルをきっかけに使い始め、歯磨き後のご褒美と組み合わせることで毎朝のケアを習慣化できた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/239851_10003361/1.1/'),
('mindup-small-head','トイプードル','small',NULL,'gum sensitivity cleaning-power','ソフトタイプでは磨けている感触が弱く歯石が増えたため通常毛へ戻した一方、時々歯ぐきから出血することがあり、磨き方に注意しながら使っている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/239851_10003361/1.1/'),
('mindup-small-soft','小型犬','small',NULL,'gentle scared','小さなヘッドと柔らかい毛で、歯磨きをあまり嫌がらずに受け入れやすかった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/review/item/1/211165_10602868/1.1/'),
('mindup-small-soft','犬種不明',NULL,NULL,'thin-head long-handle','他メーカーより柄が長く、ヘッドが小さく薄いため口の中で動かしやすいと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/review/item/1/211165_10602868/1.1/'),
('mindup-small-soft','小型犬','small',NULL,'beginner daily','小さい歯に合わせてスモールヘッドを選び、こまめな歯磨き習慣をつけるために使い始めた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/review/item/1/211165_10602868/1.1/'),
('mindup-small-soft','トイプードル・子犬','small','curly','puppy chewing size','トイプードルの子犬に使い、歯ブラシ自体を噛んで遊ぶことはあるものの、口の大きさには合いやすいと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/review/item/1/211165_10602868/1.1/'),
('mindup-small-soft','犬種不明',NULL,NULL,'molar front-teeth mixed','奥歯にはスムーズに届いて磨きやすかった一方、前歯へ当てると嫌がる様子があった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/review/item/1/211165_10602868/1.1/'),
('mindup-small-soft','トイプードル・4kg','small','curly','neck-angle gentle repeat','4kgのトイプードルで、ネック角度と柔らかな毛、小さなヘッドが奥歯へ当てやすく、約1か月ごとに交換しながら使っている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/review/item/1/211165_10602868/1.1/'),
('mindup-small-soft','小型犬','small',NULL,'size-switch scared','トリマー推奨の丸いヘッドが小型犬には大きかったため変更し、喜んで磨かせるほどではないもののサイズはこちらの方が合うと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/review/item/1/211165_10602868/1.1/'),
('mindup-small-soft','歯磨き拒否の犬',NULL,NULL,'scared quick-brush','歯ブラシや指ガーゼを長く拒否していた犬が、この柔らかい小ヘッドなら手早く行うことで磨かせてくれるようになった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/review/item/1/211165_10602868/1.1/'),
('petkiss-compact','小型犬・歯肉炎あり','small',NULL,'gentle gingivitis','小型犬の歯肉炎ケアに使い、小さなヘッドと柔らかめの毛が歯ぐきへ当てやすいと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=239832&store_id=chanet'),
('petkiss-compact','トイプードル・3kg','small','curly','small-mouth','3kgのトイプードルに使い、小さな口でもヘッドを入れやすく問題なく磨けた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=239832&store_id=chanet'),
('petkiss-compact','愛犬・1.8kg・2歳','small',NULL,'too-small negative','1.8kgの犬でもヘッドが小さすぎて逆に動かしにくく、指サックや360度型の方が合っていたため嫌がるようになった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=239832&store_id=chanet'),
('petkiss-compact','超小型犬ミックス','small',NULL,'small-mouth neck-sensitive','口が小さく合う歯ブラシが少ない超小型犬ミックスで使い、首にも負担をかけたくない中で小さなヘッドが役立った体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=239832&store_id=chanet'),
('petkiss-compact','チワワ・4kg','small',NULL,'small-mouth repeat','4kgのチワワで、他の小型犬用ブラシでも大きく感じたため再びこの小さなヘッドへ戻り、使いやすいと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=239832&store_id=chanet'),
('petkiss-compact','シニアのチワワ','small',NULL,'senior gum-sensitive','高齢になって歯ぐきから少し出血するようになったチワワで、人間の赤ちゃん用から犬の口に合う小ヘッドへ替えた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=239832&store_id=chanet'),
('petkiss-compact','犬種不明・動きやすい犬',NULL,NULL,'too-small density negative','ヘッドはとても小さいが、じっとしていない犬を短時間で磨くには毛量が少なく、もう少し密なブラシの方が向くと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=239832&store_id=chanet'),
('petkiss-finger','小型犬・9歳・3kg','small',NULL,'senior scared acclimation','9歳3kgの小型犬で歯磨き習慣をやり直すため導入し、小さなブラシと滑りにくい指サックは扱いやすかったが、犬はまだ歯磨きと分かると逃げるため段階的に慣らしている体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/5ab50936e1/review/'),
('petkiss-finger','犬種不明・3年以上継続',NULL,NULL,'daily gentle repeat','子犬期から3年以上使い、360度ブラシと併用しながら毎日2回を目標にケア。柔らかなシリコンで口当たりがよく嫌がりにくいと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/5ab50936e1/review/'),
('petkiss-finger','犬・約4kg','small',NULL,'size soft-handle','約4kgの犬に使い、柔らかい持ち手は扱いやすかった一方、ヘッドはさらに小さい方が口に合うと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/5ab50936e1/review/'),
('petkiss-finger','豆柴','small',NULL,'molar durability daily','マズルの小さい豆柴に毎日使い、指先で操作しやすく奥まで届き、1か月程度使っても大きくへたりにくいと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/5ab50936e1/review/'),
('petkiss-finger','犬種不明・シリコン歯ブラシから変更',NULL,NULL,'compact chewing','以前のシリコン歯ブラシよりコンパクトヘッドが口に合い、ペーストも付けやすかった一方、噛まれると毛先が早く傷みそうと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/5ab50936e1/review/'),
('petkiss-finger','歯ブラシ嫌いの犬',NULL,NULL,'scared finger-fit','柄付き歯ブラシを嫌がる犬に試し、柔らかい毛先と指に沿う形のおかげで怖がりにくく、飼い主も磨きやすかった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/5ab50936e1/review/'),
('petkiss-finger','シニアのチワワ','small',NULL,'senior scared finger-size','口臭が気になる高齢チワワに使ったが、犬はさらに嫌がり、指が太い飼い主には装着しにくさも感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/5ab50936e1/review/'),
('petkiss-finger','噛み癖のある犬',NULL,NULL,'chewing maneuverability','噛み癖があり従来品との比較は難しいものの、指先に近い感覚で小回りが利き、道具自体は扱いやすいと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/5ab50936e1/review/'),
('petkiss-finger','歯磨きが苦手な犬',NULL,NULL,'only-accepted soft','いくつも試した中で唯一口へ入れさせてくれ、柔らかく曲げやすいので磨きやすかった体験。','public_buyer_review_summary','https://lohaco.yahoo.co.jp/review/product/h-lohaco/5987962/'),
('petkiss-finger','犬種不明・シートから変更',NULL,NULL,'sheet-switch small-head','歯磨きシートより磨けている感触はあった一方、ブラシが小さく動く犬の歯へ狙って当てるのは難しいと感じた体験。','public_buyer_review_summary','https://lohaco.yahoo.co.jp/review/product/h-lohaco/5987962/'),
('petkiss-finger','犬種不明・歯磨きトレーニング中',NULL,NULL,'training mixed','歯磨きトレーニングの段階として導入したが、普通の歯ブラシと比べて犬の反応に大きな違いは感じなかった体験。','public_buyer_review_summary','https://lohaco.yahoo.co.jp/review/product/h-lohaco/5987962/'),
('petkiss-finger','犬種不明・リピーター',NULL,NULL,'repeat flexible-handle','継続使用し、しっかり磨けていると感じ、柔らかな柄で持ち方を調整しやすい点を評価した体験。','public_buyer_review_summary','https://lohaco.yahoo.co.jp/review/product/h-lohaco/5987962/'),
('petkiss-finger','犬種不明・初めての歯ブラシ',NULL,NULL,'beginner molar','初めての歯ブラシとして使い、強く嫌がらなかった一方、奥歯までうまく当てるには飼い主側の慣れが必要と感じた体験。','public_buyer_review_summary','https://lohaco.yahoo.co.jp/review/product/h-lohaco/5987962/'),
('petkiss-finger','犬種不明・ジェル併用',NULL,NULL,'scared gel routine','歯磨き自体は好きではない犬でも、シリコンの持ち手と歯磨きジェルを組み合わせると問題なくケアを続けられた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/5ab50936e1/review/2/'),
('petkiss-finger','噛み癖のある犬',NULL,NULL,'chewing detail','指に装着して細かな場所まで磨ける一方、途中で奪って噛もうとするためブラシの耐久性に注意が必要だった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/5ab50936e1/review/2/'),
('petkiss-finger','トイプードル・8kg','medium','curly','all-angle durability','8kgのトイプードルに使い、全面ブラシで角度を変えやすく、多少噛まれても比較的丈夫と感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/5ab50936e1/review/2/'),
('petkiss-finger','犬種不明・奥歯ケア',NULL,NULL,'molar finger-fit','指からずれにくく奥歯へ当てやすかった一方、ブラシ毛はもう少し柔らかい方が好みと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/5ab50936e1/review/2/'),
('petkiss-finger','犬種不明・歯ブラシを見ると唸る犬',NULL,NULL,'scared introduction','通常の歯ブラシを見るだけで唸る犬でも口へ入れるところまではでき、磨く段階へ進むにはさらに慣らしが必要と感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/5ab50936e1/review/3/'),
('petkiss-finger','小型犬','small',NULL,'gentle compact','全体が柔らかいシリコンでヘッドも小さく、小型犬の歯へ当てやすく、歯ブラシを見ても強く嫌がらなかった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/5ab50936e1/review/3/'),
('petkiss-finger','柴犬','medium',NULL,'too-small flexible negative','柴犬に使うとヘッドが小さすぎた一方、柄が柔らかく指に沿って曲がる操作感は良いと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/5ab50936e1/review/3/'),
('petkiss-finger','小型犬','small',NULL,'molar fine-control','指にフィットして細かな動きがしやすく、小型犬の奥歯まで当てやすかった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/5ab50936e1/review/3/'),
('mindup-large-head','歯ブラシ嫌いの犬',NULL,NULL,'scared curve molar','いくつもの歯ブラシを試した中で使いやすく、カーブしたヘッドで奥歯まで届かせると嫌がりながらも磨かせてくれた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/91ddb86bfa'),
('mindup-large-head','中型犬','medium',NULL,'size angle','中型犬では小さすぎるヘッドや大きすぎるヘッドよりこのサイズが口に合い、角度も付いていて磨きやすかった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/91ddb86bfa'),
('mindup-large-head','犬種不明・長期愛用',NULL,NULL,'repeat handling','長く愛用し、ヘッドの大きさと持ち手のカーブがちょうどよく、継続して使いやすいと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/91ddb86bfa'),
('mindup-slim-cylinder','犬種不明・毎日使用',NULL,NULL,'daily 360','360度ブラシで角度を気にせず当てやすく、毎日の歯磨きに使いやすいと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/216162_10026612/1.1/'),
('mindup-slim-cylinder','小型犬','small',NULL,'daily scared','小型犬に毎日使い、少し嫌がりながらも続けやすい大きさで、獣医から歯がきれいと褒められた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/216162_10026612/1.1/'),
('mindup-slim-cylinder','犬種不明',NULL,NULL,'size brush-firmness','口径が小さく奥へ入れやすく、ブラシ密度にも満足した一方、毛はもう少し柔らかい方がよいと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/216162_10026612/1.1/'),
('mindup-slim-cylinder','多頭飼い',NULL,NULL,'multi all-angle','多頭飼いで複数本を用意し、どの角度からでも歯へ当てやすい点を便利に感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/216162_10026612/1.1/'),
('mindup-slim-cylinder','噛みながら磨く犬',NULL,NULL,'chewing rotate negative','おもちゃのように噛む犬でも上下の歯へ同時に毛が当たりやすかった一方、ブラシ部分が回転してしまう点は扱いにくいと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/216162_10026612/1.1/')
)
INSERT INTO reviews(product_id,dog_breed,dog_size,coat_type,needs,summary,source_type,source_url)
SELECT n.product_id,n.dog_breed,n.dog_size,n.coat_type,n.needs,n.summary,n.source_type,n.source_url
FROM new_reviews n
WHERE NOT EXISTS (
  SELECT 1 FROM reviews r
  WHERE r.product_id=n.product_id
    AND r.summary=n.summary
);

SELECT COUNT(*) AS toothbrush_product_count
FROM products
WHERE category='dog-toothbrush' AND active=1;

SELECT COUNT(*) AS toothbrush_review_count
FROM reviews r
JOIN products p ON p.id=r.product_id
WHERE p.category='dog-toothbrush' AND p.active=1;
