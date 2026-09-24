PRAGMA foreign_keys = ON;

WITH new_reviews(product_id,dog_breed,dog_size,coat_type,needs,summary,source_type,source_url) AS (
VALUES
('petaboo-l400','イングリッシュコッカースパニエル','medium','long','speed paws sound','人用ドライヤーでは毛量が多く重労働だったが、風量を上げても音に強く反応せず、乾燥時間がほぼ半分になり指の間までしっかり乾かせた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/405945_10000167/1.1/'),
('petaboo-l400','バーニーズマウンテンドッグ','large','long','large speed','普通のドライヤー2台で乾かしていたバーニーズに使い、乾燥効率が大きく上がったと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/405945_10000167/1.1/'),
('petaboo-l400','超大型犬のパピー','large',NULL,'puppy scared acclimation fluffy hose','大きな音が苦手な超大型犬の子犬に最初は弱風で使い、時間はかかっても全身をしっかり乾かしてふわふわに仕上げた体験。成長に合わせて風量を上げたい一方、ホースはもう少し長いと感じた。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/405945_10000167/1.1/'),
('petaboo-l400','犬種不明',NULL,NULL,'speed shine gentle-heat','人用ドライヤーより温風は低めだが、風量18程度でも足元や地肌まで乾き、以前より早くツヤのある仕上がりになったと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/405945_10000167/1.1/'),
('petaboo-l400','犬種不明・自宅シャンプー',NULL,NULL,'quiet lightweight hose','本体が軽く風量も十分で、犬も強く嫌がらず使えた一方、ホースが短く取り回しにはもう少し余裕が欲しいと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/405945_10000167/1.1/'),
('petaboo-l400','ビションフリーゼ','small','curly','professional speed finish storage','トリマーが自宅のビションに使い、強風でまず水気を飛ばしてからブラシ仕上げをすると人用ドライヤーだけより大幅に早く、収納性も高く評価した体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/405945_10000167/1.1/'),
('petaboo-l400','大型犬・音に興奮しやすい','large',NULL,'scared acclimation speed','初めて見る機械と音に最初は落ち着かなかった大型犬が、使ううちに徐々に慣れ、風量を上げるほど速く乾かせた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/405945_10000167/1.1/'),
('petaboo-l400','ダブルコート犬',NULL,'double','speed fluffy shine','人用ドライヤーでは乾きにくかったダブルコートの犬に使い、乾燥時間が短くなり、ふわふわ・つやつやに仕上がったと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/405945_10000167/1.1/'),
('petaboo-l400','犬種不明・長めの被毛',NULL,'long','speed fluffy hose','温風30程度で全体に風を当てると人用ドライヤーより早く乾き、数日たってもふわふわ感が続いた一方、ホースの短さは気になった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/405945_10000167/1.1/'),
('petaboo-l400','犬3頭',NULL,NULL,'multi speed fluffy noise','3頭を人用ドライヤーで乾かす負担から導入し、風量を上げるほど音も大きくなるが犬たちは強く気にせず、乾きが早くふわふわに仕上がった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/405945_10000167/1.1/'),
('dogone-quick-dry','スタンダードプードル・3か月','large','curly','puppy acclimation stand root-dry','3か月のスタンダードプードルの初シャンプー後に、弱風から慣らして使用。最大風量では音も大きいが毛の根元までしっかり乾かせ、キャスター付きスタンドも扱いやすかった体験。','public_buyer_review_summary','https://item.rakuten.co.jp/ssfortuna/drstset-white/'),
('dogone-quick-dry','柴犬','medium','double','skin-sensitive speed quiet','皮膚炎を繰り返さないよう自宅でしっかり乾かす目的で導入し、思ったより静かな音で地肌が見えるほど風が届き、速乾性を実感した体験。','public_buyer_review_summary','https://item.rakuten.co.jp/ssfortuna/qd-bk/'),
('dogone-quick-dry','犬種不明・トリマー経験者の愛犬',NULL,NULL,'professional temperature power value','高額なプロ用機と比較してもパワー差は小さく、温度も犬の皮膚や被毛へ負担をかけにくい程度と感じ、価格を含めて満足した体験。','public_buyer_review_summary','https://review.rakuten.co.jp/review/item/1/295394_10007730/1.1/'),
('dogone-quick-dry','コーギー2頭','medium','double','multi speed low-heat','2頭のコーギーを乾かす時間が大きく短くなった一方、温風はもう少し高くてもよいと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/review/item/1/295394_10007730/1.1/'),
('dogone-quick-dry','スタンダードプードル3頭','large','curly','multi speed stand scared','毛量の多いスタンダードプードル3頭に使い、1頭あたり約45分で概ね乾燥。高さ・角度調整が便利で、最初は音に驚いた犬も徐々に慣れた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/review/item/1/295394_10007730/1.1/'),
('dogone-quick-dry','大型犬','large',NULL,'speed stand','以前のブロワーでは約50分かかっていた大型犬が約30分で乾き、専用スタンドで落下を気にせず作業しやすかった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/282253_10008403'),
('dogone-quick-dry','ゴールデンレトリバー','large','long','speed scared low-heat','普通のドライヤーと扇風機よりは早く乾いたが、音を気にして途中で止めながら使い、温風もぬるめに感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/277064_10021176/1.1/'),
('dogone-quick-dry','犬種不明・ハンドドライヤー2台から変更',NULL,NULL,'noise temperature-adjust compact','ハンドドライヤー2台の大きな音と温度調整の難しさから切り替え、風量と温度を調整でき、業務用よりコンパクトで扱いやすいと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/review/item/1/295394_10007730/1.1/'),
('morisawa','犬の幼稚園で複数頭',NULL,NULL,'multi speed quiet professional','プール遊び後など複数の犬に使い、強い風が被毛の奥まで届いて乾燥時間が短くなり、想像より音も静かで作業効率が上がった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=petgoods002&store_id=morisawa5628'),
('morisawa','犬3頭・ダブルコート',NULL,'double','multi speed scared finish','人用ドライヤーで3頭を乾かしていた家庭で使用し、風が地肌まで届いて時短でき、以前ドライヤーを嫌がっていた犬たちも大人しく乾かせ、ふわふわに仕上がった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=petgoods002&store_id=morisawa5628'),
('morisawa','大型犬・体毛約4.5cm','large','long','speed scared hose-heat','毛の長い大型犬で約15分で乾かせるほど風量が強かった一方、音で犬が逃げ回り、ホースがかなり熱くなる点も気になった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=petgoods002&store_id=morisawa5628'),
('morisawa','ゴールデンレトリバー','large','long','speed fluffy low-heat','ゴールデンに使い、人用ドライヤーより早い30〜40分ほどで乾き、柔らかい温風でふわっと仕上がった一方、毛が広く舞うため掃除が必要だった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=petgoods002&store_id=morisawa5628'),
('morisawa','ラブラドールレトリバー','large','short','skin-sensitive scared acclimation','膿皮症で週1回の薬用シャンプーが必要なラブラドールに導入。風力は十分だが音に驚いて逃げたため、つけたまま音へ徐々に慣らしている体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=petgoods002&store_id=morisawa5628'),
('morisawa','犬種不明・トリマーの家庭犬や友人犬',NULL,NULL,'professional low-heat finish value','元トリマーが家庭犬や友人の犬に使い、普通のドライヤーより低温で皮膚へ配慮しやすく、プードル系の毛も伸ばしながら乾かしやすいと評価した体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=petgoods002&store_id=morisawa5628'),
('morisawa','犬種不明・散歩後の足洗い',NULL,NULL,'frequent-wash speed','雨続きで散歩後に足を洗うたび人用ドライヤーで乾かす負担が大きかったが、導入後は乾燥時間が圧倒的に短くなった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=petgoods002&store_id=morisawa5628')
)
INSERT INTO reviews(product_id,dog_breed,dog_size,coat_type,needs,summary,source_type,source_url)
SELECT n.product_id,n.dog_breed,n.dog_size,n.coat_type,n.needs,n.summary,n.source_type,n.source_url
FROM new_reviews n
WHERE NOT EXISTS (
  SELECT 1 FROM reviews r
  WHERE r.product_id=n.product_id
    AND r.summary=n.summary
);


WITH new_reviews(product_id,dog_breed,dog_size,coat_type,needs,summary,source_type,source_url) AS (
VALUES
('petaboo-l400','犬種不明・高音に敏感',NULL,NULL,'speed scared nozzle-length','普通のドライヤーより早く乾き、毛もパサつきにくかった一方、風量50前後の高い音では怯える様子があり、動く犬にはノズルがもう少し長いと扱いやすいと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/405945_10000167/1.1/'),
('petaboo-l400','犬種不明・初めての家シャンプー',NULL,NULL,'speed fluffy beginner','初めての自宅シャンプー後に使い、乾くのが早く、仕上がりもふわふわになって楽だった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/405945_10000167/1.1/'),
('dogone-quick-dry','顔まわりのドライが苦手な犬',NULL,NULL,'professional face scared low-heat','トリマーが使用し、最小風量でも人用ドライヤーより風は強いものの、ぬるめの温度で顔まわりが苦手な犬も嫌がり方が少なかった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/282253_10008403'),
('dogone-quick-dry','スタンダードプードル・短めカット','large','curly','root-dry stand no-brush','短めカットのスタンダードプードルにスタンド付きで使い、平たいノズルで毛を一定方向に分けながら根元まで乾かせ、ブラッシングしながらでなくても毛玉ができにくかった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/282253_10008403'),
('dogone-quick-dry','犬種不明・家族がトリミング',NULL,NULL,'stand nozzle handling','トリマー1年目の家族が自宅の犬に使い、スタンドと下向きノズルが実際の乾燥作業で役立った一方、スタンドは大きく重さもあると感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/282253_10008403'),
('dogone-quick-dry','犬種不明・人用上位ドライヤーから変更',NULL,NULL,'root-dry low-heat','人用の高性能ドライヤーを強風で使っていた家庭で切り替え、低温の強風で表面だけでなく地肌までしっかり乾かしやすいと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/282253_10008403'),
('dogone-quick-dry','パグ・10kg','medium','short','power warm finish','10kgのパグに最大風量と高めの温風で使い、トリミング慣れしていたため音にも比較的落ち着き、パワフルに乾かしてふわっと仕上がった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/282253_10008403'),
('dogone-quick-dry','犬種不明・自宅トリミング',NULL,NULL,'blower stand maintenance','自宅の犬をトリミングする際に、ブロワーとしてもスタンドドライヤーとしても使えて便利だった一方、使用中に固定ネジが外れたことがあり組み付けには注意した体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/295394_10007730/1.1/'),
('dogone-quick-dry','プードル3頭＋ダックス＋ペキニーズなど6頭','medium','mixed','multi handsfree speed finish','6頭の多頭飼い家庭で使い、プードルはブラシを使いながらふわっと仕上げ、ダックスやペキニーズも人用ドライヤーより早く乾かせた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/282253_10008403/1.1/'),
('dogone-quick-dry','スタンダードプードル・自宅用','large','curly','professional home-use','トリマーが自宅のスタンダードプードル用に使い、家庭用としては十分な風量があり、ブロワーノズルも使いやすいと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/review/item/1/295394_10007730/1.1/'),
('homerunpet-pd10','毛量の多い犬',NULL,'long','speed','毛量の多い犬に使い、短時間で乾かせてよく働いていると感じた体験。','public_buyer_review_summary','https://homerunpet.com/products/homerunpet-pet-hair-dryer'),
('homerunpet-pd10','子犬たち',NULL,NULL,'puppy comfortable','複数の子犬に使い、乾かしている間も比較的快適そうに過ごしていたという体験。','public_buyer_review_summary','https://homerunpet.com/products/homerunpet-pet-hair-dryer'),
('morisawa','ゴールデンレトリバー・6か月','large','long','puppy speed paws','人用ドライヤーでは2時間かけても生乾きだった6か月のゴールデンが、約半分の時間で乾き、散歩後に乾きにくかった肉球の間にも使いやすかった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list/2/?page_key=petgoods002&store_id=morisawa5628'),
('morisawa','小型犬','small',NULL,'negative strong-air salon-finish','小型犬には最弱でも風量が強く感じた一方、根元から毛が立ち上がり、仕上がりはトリミング後のようにさらさらになった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list/2/?page_key=petgoods002&store_id=morisawa5628'),
('morisawa','フレンチブルドッグ','small','double short','speed noise','尻尾まわりなど乾きにくいダブルコートのフレンチブルドッグに使い、ハンディ掃除機程度の音はするものの、乾燥が早くなり風量を段階的に上げて使えた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list/2/?page_key=petgoods002&store_id=morisawa5628'),
('morisawa','長毛の小型犬','small','long','speed hose-stiff','長毛小型犬に使い、人用ハンドドライヤーの約半分の時間で乾いた一方、初回はホースが硬く感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list/2/?page_key=petgoods002&store_id=morisawa5628'),
('morisawa','ゴールデンレトリバー','large','long','speed scared noise','ゴールデンの乾燥時間を短縮できるほどパワーがあった一方、音は大きめで犬が最初は怖がった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list/2/?page_key=petgoods002&store_id=morisawa5628'),
('morisawa','犬種不明・人用ドライヤーから変更',NULL,NULL,'speed quiet','人用ドライヤーではかなり時間がかかっていた犬に使い、想像より音は大きくなく、乾燥時間もおよそ半分まで短くなったと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list/2/?page_key=petgoods002&store_id=morisawa5628'),
('morisawa','フレンチブルドッグ','small','short','speed root-dry','人用ドライヤーより強い風で根元から水分を飛ばせ、フレンチブルドッグを約20分で乾かせた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list/2/?page_key=petgoods002&store_id=morisawa5628'),
('morisawa','皮膚トラブル後の犬',NULL,NULL,'skin-sensitive root-dry noise','人用ドライヤーで乾き残しがあり皮膚トラブルが出た経験から導入し、本体を扉の外へ置いて音を遠ざけながら、根元までしっかり乾かせた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list/2/?page_key=petgoods002&store_id=morisawa5628'),
('morisawa','犬種不明・付属ノズルの音を嫌う犬',NULL,NULL,'scared nozzle low-heat','本体音は人用ドライヤーより静かに感じたが、付属ノズルを付けた時の音は犬が怖がったため、ノズルなしで使うと温度もちょうどよく乾かせた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list/2/?page_key=petgoods002&store_id=morisawa5628'),
('morisawa','犬種不明・店舗で継続使用',NULL,NULL,'professional value hose-length','店舗で高価な海外製ブロワーを何台も使ってきた購入者が導入し、価格に対して十分な性能を感じた一方、ホースはもう少し長いと良いと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list/2/?page_key=petgoods002&store_id=morisawa5628'),
('morisawa','犬種不明・初回使用',NULL,NULL,'power towel-dry technique','初回は強い風量を楽しみにしてタオルドライを十分にしなかったため思ったより時間がかかり、次回は事前にしっかり水分を取って使おうと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list/2/?page_key=petgoods002&store_id=morisawa5628'),
('morisawa','トイプードル2頭','small','curly','negative strong-air face','2頭のトイプードルに使い、最弱でもティーカップサイズの犬には風が強く、特に顔まわりは嫌がるため距離を取る必要があった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list/3/?page_key=petgoods002&store_id=morisawa5628'),
('morisawa','柴犬','medium','double','speed noise','ダブルコートの柴犬に使い、人用ドライヤーの約3分の1ほどの時間、約10分で乾かせた一方、音は大きめに感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list/3/?page_key=petgoods002&store_id=morisawa5628')
)
INSERT INTO reviews(product_id,dog_breed,dog_size,coat_type,needs,summary,source_type,source_url)
SELECT n.product_id,n.dog_breed,n.dog_size,n.coat_type,n.needs,n.summary,n.source_type,n.source_url
FROM new_reviews n
WHERE NOT EXISTS (
  SELECT 1 FROM reviews r
  WHERE r.product_id=n.product_id
    AND r.summary=n.summary
);

SELECT COUNT(*) AS pet_dryer_product_count
FROM products
WHERE category='pet-dryer' AND active=1;

SELECT COUNT(*) AS pet_dryer_review_count
FROM reviews r
JOIN products p ON p.id=r.product_id
WHERE p.category='pet-dryer' AND p.active=1;
