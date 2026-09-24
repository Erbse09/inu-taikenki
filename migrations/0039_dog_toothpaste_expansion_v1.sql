PRAGMA foreign_keys = ON;

WITH new_reviews(product_id,dog_breed,dog_size,coat_type,needs,summary,source_type,source_url) AS (
VALUES
('kins-dental-gel','犬種不明・食後の皿のにおいが気になった犬',NULL,NULL,'odor cost','食後の皿に残るにおいが気になって使い始め、気にならないほど変化を感じた一方、価格は継続のハードルと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/review/item/1/404653_10000028/1.1/'),
('kins-dental-gel','犬種不明・毎晩ケア',NULL,NULL,'daily lick oral-care','毎晩そのまま舐めさせる形で続け、口腔ケアを習慣化しやすいと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/review/item/1/404653_10000028/1.1/'),
('kins-dental-gel','犬複数頭',NULL,NULL,'multi beginner','複数の犬に初めて使い、強く嫌がらず歯磨きさせてくれたため継続できそうと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/review/item/1/404653_10000028/1.1/'),
('kins-dental-gel','歯磨きが苦手な犬',NULL,NULL,'scared apply-only','歯ブラシが苦手な犬で、まず塗るだけでも続けられる点を取り入れやすいと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/review/item/1/404653_10000028/1.1/'),
('kins-dental-gel','犬種不明・汚れが付きやすい犬',NULL,NULL,'stain plaque','継続して使ううちに汚れが落ちやすく、付きにくくなったように感じ、毎日の歯磨きが続けやすくなった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/review/item/1/404653_10000028/1.1/'),
('kins-dental-gel','歯磨きが苦手な犬',NULL,NULL,'gauze odor','主に舐めさせ、ときどきガーゼへ付けて歯ぐきへ塗る使い方でも、口臭が以前より気になりにくくなったと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/review/item/1/404653_10000028/1.1/'),
('kins-dental-gel','犬種不明・長期継続',NULL,NULL,'cost digestion taste','価格は高めでも味を気に入り歯磨きを受け入れやすく、体調面でも続けたいと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/review/item/1/404653_10000028/1.1/'),
('kins-dental-gel','犬種不明・リピーター',NULL,NULL,'odor plaque repeat','リピート使用で口臭が減り、歯石も付きにくくなったように感じ、他製品より楽しんで歯磨きしてくれる点を評価した体験。','public_buyer_review_summary','https://review.rakuten.co.jp/review/item/1/404653_10000028/1.1/'),
('oratene-dental-gel','犬・13歳',NULL,NULL,'senior toothless lick','歯がほとんどない13歳の犬が朝晩指から喜んで舐め、日常の口腔ケアとして続けている体験。','public_buyer_review_summary','https://product.rakuten.co.jp/product/-/050f9e9f3e2e001647ec0cbd866cf2ca/review/'),
('oratene-dental-gel','犬種不明・動物病院推奨',NULL,NULL,'vet finish daily','かかりつけ動物病院の勧めで、歯磨きの仕上げとして毎日使っている体験。','public_buyer_review_summary','https://product.rakuten.co.jp/product/-/050f9e9f3e2e001647ec0cbd866cf2ca/review/'),
('oratene-dental-gel','犬種不明・歯の着色が気になった犬',NULL,NULL,'stain maintenance','歯と歯の間の着色が気になり使い始め、続けるうちに着色が薄くなったように感じた体験。','public_buyer_review_summary','https://product.rakuten.co.jp/product/-/050f9e9f3e2e001647ec0cbd866cf2ca/review/'),
('oratene-dental-gel','パピー',NULL,NULL,'puppy taste repeat','先代犬から使っていたジェルをパピーにも使い、味を気に入って歯磨きを受け入れている体験。','public_buyer_review_summary','https://product.rakuten.co.jp/product/-/050f9e9f3e2e001647ec0cbd866cf2ca/review/'),
('oratene-dental-gel','老犬',NULL,NULL,'senior odor','いろいろ試した老犬で、このジェルを使うようになって口臭が減ったと感じた体験。','public_buyer_review_summary','https://product.rakuten.co.jp/product/-/050f9e9f3e2e001647ec0cbd866cf2ca/review/'),
('oratene-dental-gel','トイプードル・19歳','small','curly','senior no-anesthesia odor','19歳で麻酔下の歯石除去が難しいトイプードルに使い、毎日のケアで年齢の割に口臭が気になりにくいと感じた体験。','public_buyer_review_summary','https://product.rakuten.co.jp/product/-/050f9e9f3e2e001647ec0cbd866cf2ca/review/'),
('oratene-dental-gel','犬・11歳',NULL,NULL,'senior odor repeat','11歳のシニア犬で使用前後の口臭の違いを大きく感じ、長く続けたいと思った体験。','public_buyer_review_summary','https://product.rakuten.co.jp/product/-/050f9e9f3e2e001647ec0cbd866cf2ca/review/'),
('oratene-dental-gel','犬複数頭',NULL,NULL,'multi taste reward','複数の犬が味を好み、歯ブラシに付けるほか、歯磨き後に少量舐めさせるご褒美としても使っている体験。','public_buyer_review_summary','https://product.rakuten.co.jp/product/-/050f9e9f3e2e001647ec0cbd866cf2ca/review/'),
('oratene-dental-gel','犬・12歳',NULL,NULL,'senior long-term','12歳の犬で長く使い、歯磨きを強く嫌がらず口腔トラブルの悪化も少ないと感じた体験。','public_buyer_review_summary','https://product.rakuten.co.jp/product/-/050f9e9f3e2e001647ec0cbd866cf2ca/review/'),
('oratene-dental-gel','犬種不明・長期使用',NULL,NULL,'gumline finish','長年、歯ブラシ後に少量を指へ取り、歯と歯ぐきの境目へ塗る方法で継続している体験。','public_buyer_review_summary','https://product.rakuten.co.jp/product/-/050f9e9f3e2e001647ec0cbd866cf2ca/review/'),
('petkiss-gel-leaf','チワワ','small',NULL,'taste scared repeat','他のペーストも試した末にリーフの香りへ戻り、チワワが嫌がりにくいため継続している体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/388158_10014389/1.1/'),
('petkiss-gel-leaf','チワワ','small',NULL,'routine request','食後に歯磨きを忘れると催促するほど習慣化し、味を楽しみにしているように感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/388158_10014389/1.1/'),
('petkiss-gel-leaf','チワワ','small',NULL,'vet praise routine','継続して歯磨きに使い、動物病院でも歯や歯ぐきの状態を褒められたという体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/388158_10014389/1.1/'),
('petkiss-gel-leaf','チワワ・歯磨きが苦手','small',NULL,'scared switch','歯磨きが苦手なチワワでペーストを変えて試し、今のところ強く嫌がらず磨かせてくれた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/388158_10014389/1.1/'),
('petkiss-gel-leaf','犬種不明・長期使用',NULL,NULL,'licking taste','ジェルの味を気に入り、磨くことより舐める方へ夢中になることもあるが、歯磨き習慣のきっかけとして続けている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/388158_10014389/1.1/'),
('dr-yujiro-dental-gel','犬種不明・デンタルサロン後',NULL,NULL,'odor post-cleaning maintenance','数年前から使い、口臭予防には手応えを感じた一方、歯石が自然に取れた経験はなく、サロンで歯石を取った後の維持目的で続けている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/300669_10000000/1.1/'),
('dr-yujiro-dental-gel','犬複数頭',NULL,NULL,'multi tartar repeat','多頭飼いで毎日歯磨き後に塗り続け、1本の大半を使った頃に歯石が浮いたように感じ、取れた箇所もあった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/300669_10000000/1.1/'),
('dr-yujiro-dental-gel','犬種不明・アレルギーに配慮',NULL,NULL,'allergy trial','試供品から始め、成分面も確認しながら少量のジェルを使い、犬が問題なく受け入れたため継続を考えた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/300669_10000000/1.1/'),
('dr-yujiro-dental-gel','歯磨き嫌いの犬',NULL,NULL,'scared prevention','先代犬では歯の状態を褒められていたため、歯磨きを嫌がる今の犬でもこれ以上悪化させない目的で再び使い始めた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/300669_10000000/1.1/'),
('dr-yujiro-dental-gel','トイプードル2頭','small','curly','multi finger-apply mixed','歯磨き嫌いのトイプードル2頭に約1か月使用し、歯が白くなったように感じた一方、濃い歯石や口臭にはまだ大きな変化がなく、指で直接塗る方法は続けやすかった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/300669_10000000/1.1/'),
('dr-yujiro-dental-gel','犬・約3kg','small',NULL,'taste allergy caution','口臭は減ったと感じた一方、味は苦手そうで、くしゃみも出たため体質との相性を気にしながら少量で再開した体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/300669_10000000/1.1/'),
('dr-yujiro-dental-gel','高齢犬・14歳を含む多頭',NULL,NULL,'senior multi gum','口内のべたつきや口臭が気になる高齢犬たちに朝夕のケアを続け、少しずつ口内の状態がましになったと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/300669_10000000/1.1/'),
('dr-yujiro-dental-gel','犬種不明・初回使用',NULL,NULL,'beginner instructions taste','詳しい説明を見ながら初めて使い、ジェルを嫌がらず舐めてくれたため導入しやすいと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/300669_10000000/1.1/'),
('dr-yujiro-dental-gel','犬種不明・獣医へ成分確認',NULL,NULL,'vet-check repeat','かかりつけ動物病院にも中身を確認してもらい、犬も味を気に入っている様子だったため継続している体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/300669_10000000/1.1/'),
('dr-yujiro-dental-gel','歯ブラシが難しい犬',NULL,NULL,'scared gum-apply odor','歯ブラシが難しい犬で、夜は指へ取って歯ぐきへ直接塗る方法を続け、口臭が落ち着いたと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/300669_10000000/1.1/'),
('virbac-cet-chicken','食いしん坊な犬',NULL,NULL,'food-motivated daily','歯磨き自体は嫌いでもチキンの香りで自分から近づき、毎日のケアを続けやすくなった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/review/review/item/1/228349_10011060/1.1/'),
('virbac-cet-chicken','犬種不明・他フレーバーから変更',NULL,NULL,'taste comparison','味の好みがあり、複数フレーバーを試す中でチキンを特に気に入っているため選んでいる体験。','public_buyer_review_summary','https://review.rakuten.co.jp/review/review/item/1/228349_10011060/1.1/'),
('virbac-cet-chicken','犬種不明',NULL,NULL,'reward taste','歯磨き後のご褒美として少量舐めさせると喜び、ケアを続けるきっかけになっている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/review/review/item/1/228349_10011060/1.1/'),
('virbac-cet-chicken','歯磨き大嫌いの犬',NULL,NULL,'scared lick-only','歯ブラシはなかなか受け入れないものの、ペースト自体はおいしそうに舐めるため、慣らしの入口として使っている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/review/review/item/1/228349_10011060/1.1/'),
('virbac-cet-chicken','歯磨きで逃げていた犬',NULL,NULL,'scared improvement','以前のペーストでは歯磨きを察して隠れていた犬が、チキン味へ替えると自分から来るようになり、歯磨きへの抵抗が少し減った体験。','public_buyer_review_summary','https://review.rakuten.co.jp/review/review/item/1/228349_10011060/1.1/'),
('virbac-cet-chicken','味に好みが強い犬',NULL,NULL,'picky taste','食べ物の好みにうるさい犬でもチキン味は気に入り、喜んで歯磨きさせやすかった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/review/review/item/1/228349_10011060/1.1/'),
('virbac-cet-chicken','ミニチュアシュナウザー','medium',NULL,'breed taste daily','ミニチュアシュナウザーがチキン味を気に入り、歯磨き自体を楽しみにするようになった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/review/review/item/1/228349_10011060/1.1/'),
('virbac-cet-chicken','犬2頭',NULL,NULL,'multi gum taste','2頭に使い、味が付いていることで以前より嫌がり方が少なくなり、歯ぐきの状態も少し良くなったように感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/review/review/item/1/228349_10011060/1.1/'),
('virbac-cet-chicken','マルチーズ','small','long','breed taste cost','マルチーズがこのペーストを好み、歯磨きを嫌がらず続けられ、店頭より安く買える点も助かった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/review/review/item/1/228349_10011060/1.1/'),
('virbac-cet-vanilla-mint','元保護犬・顔まわりが苦手',NULL,NULL,'rescue scared taste','顔まわりを触られるのが苦手な元保護犬でも、バニラミントを喜んで舐め、歯磨きのために口を開けてくれるほど受け入れやすかった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/256849_10008775/1.1/'),
('virbac-cet-vanilla-mint','犬種不明',NULL,NULL,'routine request','この味を気に入り、飼い主へ歯磨きを要求するほど習慣化している体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/256849_10008775/1.1/'),
('virbac-cet-vanilla-mint','歯ブラシが苦手な犬',NULL,NULL,'scared chew-stick','歯ブラシでは磨かせてくれないため歯磨き棒へ付けて使い、香りを嫌がらず取り入れられた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/256849_10008775/1.1/'),
('virbac-cet-vanilla-mint','シニア犬4頭',NULL,NULL,'senior multi odor','シニア犬4頭へ長く使い、歯磨き後は口がすっきりして口臭も気になりにくいと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/256849_10008775/1.1/'),
('virbac-cet-vanilla-mint','犬種不明・他製品から変更',NULL,NULL,'repeat preference','他の歯磨き粉も試した後にバニラミントへ戻り、継続しやすい定番として使っている体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/256849_10008775/1.1/'),
('virbac-cet-vanilla-mint','犬種不明・歯磨き嫌い',NULL,NULL,'excited taste','ペーストを見せると大喜びするほど味を好み、苦手な歯磨きも頑張ってくれる体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/256849_10008775/1.1/'),
('virbac-cet-vanilla-mint','シニア犬・歯石除去後',NULL,NULL,'senior brush-transition','シニアになるまで歯磨きシート中心だった犬が、歯石除去を機に歯ブラシへ移行し、この味を気に入ってスムーズに切り替えられた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/256849_10008775/1.1/'),
('virbac-cet-vanilla-mint','チワワ2頭','small',NULL,'multi flavor-preference','2頭のチワワで好みが分かれ、1頭はバニラミントへの食いつきが強く、もう1頭はチキンの方が機嫌よく磨かせるなど味の相性差を感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/256849_10008775/1.1/')
)
INSERT INTO reviews(product_id,dog_breed,dog_size,coat_type,needs,summary,source_type,source_url)
SELECT n.product_id,n.dog_breed,n.dog_size,n.coat_type,n.needs,n.summary,n.source_type,n.source_url
FROM new_reviews n
WHERE NOT EXISTS (
  SELECT 1 FROM reviews r
  WHERE r.product_id=n.product_id
    AND r.summary=n.summary
);

SELECT COUNT(*) AS toothpaste_product_count
FROM products
WHERE category='dog-toothpaste' AND active=1;

SELECT COUNT(*) AS toothpaste_review_count
FROM reviews r
JOIN products p ON p.id=r.product_id
WHERE p.category='dog-toothpaste' AND p.active=1;
