PRAGMA foreign_keys = ON;

WITH new_reviews(product_id,dog_breed,dog_size,coat_type,needs,summary,source_type,source_url) AS (
VALUES
('zan-guillotine-sm','パグ＋ポメラニアン',NULL,NULL,'multi low-force','ハサミ式からギロチン式へ替え、軽い力で切れ、最初は少しずつ試しながらすぐ操作に慣れた体験。犬たちは爪切り自体は苦手でも以前より道具を扱いやすく感じた。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/p/92215438b9/review/'),
('zan-guillotine-sm','犬種不明・サロン任せだった犬',NULL,NULL,'scared home-care speed','爪切りを嫌がってサロンに任せていた犬で、自宅用に導入すると軽い力で素早く切れ、逃げ回るほどの抵抗が減って短時間で終えられた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/p/92215438b9/review/'),
('zan-guillotine-sm','チワワ2頭','small',NULL,'beginner sensitive-feet','爪切り経験のない飼い主が動物病院で使い方を教わってから使用。足先に敏感な2頭でも爪への衝撃が少なく、少しずつ定期的に切れた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/p/92215438b9/review/'),
('zan-guillotine-sm','ミニチュアシュナウザー','small',NULL,'hard-nail quiet','硬めの爪に少しずつ刃を入れると大きな音を立てずに切れ、以前の安価なギロチンより犬が嫌がりにくかった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/p/92215438b9/review/2/'),
('zan-guillotine-sm','ペキニーズ','small',NULL,'hard-nail speed','しっかりした爪でもスパスパ切れ、以前の爪切りで足を引こうとしていた犬の爪切りを短時間で終えられた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/p/92215438b9/review/2/'),
('zan-guillotine-sm','黒い爪の犬',NULL,NULL,'black-nail low-pressure control','黒い爪で自宅ケアを諦めていたが、爪へ強い圧力をかけず薄くスライスするように少しずつ切れ、切り過ぎへの不安が減った体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/p/92215438b9/review/3/'),
('zan-guillotine-sm','ミニチュアピンシャー・18歳超','small','short','senior black-nail quiet','18歳を超えた黒爪のミニピンを、深く眠っている間に薄く少しずつ切り、起こさず手足すべてを整えられた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/p/92215438b9/review/3/'),
('zan-guillotine-sm','犬種不明・古いギロチンから買い替え',NULL,NULL,'quiet low-force','ホームセンターの古いギロチンは切断音が大きく犬が嫌がっていたが、買い替え後は静かで力も少なく切れた体験。切れ味が良いため切り過ぎには注意している。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/p/92215438b9/review/2/'),
('zan-guillotine-sm','怖がりの中型犬・約15kg','medium',NULL,'scared speed quiet','約15kgの怖がりな中型犬で、以前は全爪を切るのに数日かかっていたが、音が小さくよく切れるため数十分で終えられた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/p/92215438b9/review/4/'),
('zan-guillotine-sm','子犬',NULL,NULL,'puppy quiet sleep','初めての爪切りで怖がらせたくないため切れ味重視で選び、寝ている間に気づかれにくく爪先を切れた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/p/92215438b9/review/5/'),
('zan-guillotine-sm','犬種不明・ギロチン初心者',NULL,NULL,'beginner acclimation','ギロチン式への不安が強かったが、数か月かけて飼い主と犬が少しずつ慣れ、狙いが定まれば一度で切れるようになった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/p/92215438b9/review/5/'),
('zan-guillotine-sm','ミニチュアダックスフンド','small','long','grinder-switch speed','電動爪やすりでは時間がかかり粉も舞って犬が嫌がっていたが、ギロチンへ替えると短時間で切れて後片付けも楽になった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/p/92215438b9/review/5/'),
('zan-guillotine-sm','子犬・3か月','small',NULL,'puppy beginner','3か月の子犬で初めて自宅爪切りを行い、柔らかい爪をなんとか切ることができた体験。子犬期から慣らす目的で使い始めた。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/p/92215438b9/review/10/'),
('zan-guillotine-sm','チワワ','small',NULL,'scared hammock speed','爪切りを強く嫌がるチワワをハンモックで保定し、以前より切れ味が良いため作業時間を短縮できた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/p/92215438b9/review/5/'),
('zan-guillotine-sm','犬種不明・深爪経験あり',NULL,NULL,'scared slice-control','以前の爪切りで深爪して犬が嫌いになった家庭で、薄くスライスするように少しずつ切ると気づかれにくく終えられた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/p/92215438b9/review/5/'),
('zan-guillotine-sm','犬種不明・自宅爪切り再開',NULL,NULL,'sleep home-care','有名メーカーの爪切りより切れ味の違いを感じ、犬が寝ている間に爪切りからやすりがけまで終えられた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/p/92215438b9/review/5/'),
('zan-guillotine-sm','犬種不明・シニア＋新しい犬のいる家庭',NULL,NULL,'senior repeat durability','10年以上使っていた爪切りから買い替え、シニア犬や新しく迎えた犬のケアで再び使用頻度が増え、切れ味の良さを実感した体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/p/92215438b9/review/10/'),
('zan-guillotine-sm','チワックス','small',NULL,'low-impact slice','カバー付き爪切りの切断時の衝撃が苦手で変更し、軽く薄くスライスするように切れるため犬も飼い主も緊張が減った体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/p/92215438b9/review/5/'),
('zan-guillotine-sm','犬種不明・病院の道具を参考に購入',NULL,NULL,'quiet sleep','獣医が使うギロチン式を参考に選び、犬が深く眠っている時なら切断の衝撃で起きにくく爪を切れた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/p/92215438b9/review/10/'),
('zan-guillotine-sm','犬種不明・トリミング学校で使用経験あり',NULL,NULL,'professional long-use','トリミング学校で最初に使った同型を7年間使い、錆びたため同じものへ買い替えた体験。慣れた操作感を重視して継続した。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/p/92215438b9/review/'),
('zan-guillotine-sm','犬種不明・安価品から変更',NULL,NULL,'speed low-force','力を入れないと切れない安価品から替え、少ない力で一度に切れるため犬も飼い主も爪切り時間の負担が減った体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/p/92215438b9/review/10/'),
('zan-guillotine-sm','犬種不明・爪切り嫌い',NULL,NULL,'scared handling','以前は切れ味の悪い道具で時間がかかり足を出さなくなっていた犬が、切れ味の良い道具へ替えると嫌々ながらも手を出してくれるようになった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/p/92215438b9/review/10/'),
('zan-guillotine-sm','犬種不明・ハサミ式から変更',NULL,NULL,'low-force beginner','ハサミ式では爪を潰すように力を入れていたが、ギロチン式へ替えると軽い力で一発で切れ、操作への抵抗感が減った体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/p/92215438b9/review/10/'),
('zan-guillotine-sm','犬種不明・切断音が苦手',NULL,NULL,'quiet vibration','音や振動が大きい爪切りでは次回から嫌がるため、軽い握力で少しずつ切れるZANへ替え、犬を驚かせにくくなった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/p/92215438b9/review/'),
('zan-guillotine-large','大型犬・自宅爪切り初心者','large',NULL,'beginner home-care','毎月病院へ爪切りに行く代わりに自宅ケアへ挑戦し、動画や割り箸で練習してから寝ている犬の爪を数mmずつ切れた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/a0970d4b06'),
('zan-guillotine-large','バーニーズ','large','long','hard-nail wolf-claw','硬い狼爪を切れ味の悪い爪切りで割ってしまった経験から変更し、少ない力でスパッと切れて犬も静かにしていた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/a0970d4b06'),
('zan-guillotine-large','バーニーズ','large','long','hard-nail low-force','大型犬用を使うと太く硬い爪でもサクサク切れ、小型犬用との見分けもしやすく、犬への負担が少ないと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/a0970d4b06'),
('zan-guillotine-large','老犬のボーダーコリー','medium','long','senior hard-nail stress','15年近く硬い爪のケアに苦労してきた老犬で、寝ている間に少しずつ切るとスムーズに進み、爪切りによるストレスを減らせた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/a0970d4b06'),
('zan-guillotine-large','ゴールデンレトリバー','large','long','large-hole speed','大型犬用の大きな穴へ爪を入れやすく、短時間で切れたため爪切り嫌いのゴールデンが以前ほど嫌がらなくなった体験。爪の角を丸く整えるのも楽だった。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/a0970d4b06'),
('zan-guillotine-large','ブラックラブラドールレトリバー','large','short','black-nail control','黒い爪で血管が見えないため少しずつ切る必要があり、切れ味の良い大型犬用なら人も犬もストレスを抑えて進められた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/a0970d4b06'),
('zan-guillotine-large','雑種犬・30kg','large',NULL,'scared quiet speed','以前は大きな切断音で鳴いて爪切り嫌いになっていた30kgの雑種犬が、切れ味の良い大型犬用では受け入れやすくなり短時間で終えられた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/a0970d4b06'),
('zan-guillotine-large','ゴールデンレトリバー','large','long','wolf-claw low-vibration','散歩で削れにくい親指の爪を寝ている時に切り、起きないほど振動が少ないように感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/a0970d4b06'),
('zan-guillotine-large','大型犬','large',NULL,'size-up hard-nail','小型犬用の爪切りでは切りにくく時間がかかっていたため大型犬用へ変更し、太い爪でも薄くスライスできるほど切れ味が良いと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/a0970d4b06'),
('zan-guillotine-large','大型犬・長期使用後の買い替え','large',NULL,'repeat durability','14年近く使った旧爪切りの錆とバネ破損を機に大型犬用へ買い替え、切れ味と扱いやすさを改めて評価した体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/p/92215438b9/review/10/'),
('zan-nipper','雑種犬・16歳・17kg','medium',NULL,'senior ingrown-nail','後ろ足が弱って巻き爪になり、ギロチンでは角度的に切れなかった爪をニッパーで切り、肉球を傷つけずに済んだ体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=uv482&store_id=zunzunpetsupply'),
('zan-nipper','超大型犬','large',NULL,'hard-nail quiet size','超大型犬では本体の開口がぎりぎりだった一方、硬い爪でも切れ味はよく、ハサミ式より静かで短時間に切れた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=uv482&store_id=zunzunpetsupply'),
('zan-nipper','中〜大型犬','large',NULL,'visibility hard-nail','ギロチンで入りにくい太い爪のためニッパーへ変更し、切る位置が見やすく使いやすかった一方、太い爪では力が必要と感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=uv482&store_id=zunzunpetsupply'),
('zan-nipper','15kgと22kgの犬2頭','medium',NULL,'multi hard-nail quiet','硬い爪を切るたび大きな音と力が必要だった犬2頭で、ニッパーへ替えると多くの爪をほとんど音なく軽く切れた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=uv482&store_id=zunzunpetsupply'),
('zan-nipper','犬5頭',NULL,NULL,'multi long-use control','血管が見えにくいギロチンなど複数の爪切りで失敗した後にニッパーへたどり着き、5頭のケアで何度も同じ製品を買い直している体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=uv482&store_id=zunzunpetsupply'),
('zan-nipper','犬種不明・工具操作に慣れた飼い主',NULL,NULL,'handling control','工具に近い操作感を好んでギロチンからニッパーへ替え、手に収まりやすく、バネの強さもコントロールしやすいと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=uv482&store_id=zunzunpetsupply'),
('zan-nipper','犬種不明・業務で毎日使用',NULL,NULL,'professional durability negative','仕事で毎日使うほど切れ味と使いやすさを気に入っている一方、バネが半年ほどで壊れることがあり耐久性には不満を感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=uv482&store_id=zunzunpetsupply'),
('zan-nipper','ラブラドールレトリバー・20kg','large','short','beginner weekly','20kgのラブラドールで大型犬の爪切りに初挑戦し、問題なく切れたため週1回ほど少しずつ整えている体験。ギロチンより扱いやすく感じた。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=uv482&store_id=zunzunpetsupply'),
('zan-nipper','大型犬・約30kg','large',NULL,'speed mixed-finish','普段のギロチンから初めてニッパーへ替え、30kg近い犬でも爪が収まり短時間で切れた一方、切り口はギロチンの方が好みと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=uv482&store_id=zunzunpetsupply'),
('zan-nipper','超大型犬','large',NULL,'hard-nail control','過去に複数の爪切りを壊してきた超大型犬で、爪の角を少しずつ削るように切る方法で使いやすかった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=uv482&store_id=zunzunpetsupply'),
('zan-nipper','爪切りが苦手な犬',NULL,NULL,'scared quiet sleep','爪を挟み込む操作を嫌がる犬で、寝ている間に使いやすく、切れ味が良く音も大きくないため自宅ケアを続けられそうと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=uv482&store_id=zunzunpetsupply'),
('zan-nipper','犬種不明・古い爪切りから買い替え',NULL,NULL,'speed repeat','切れ味が落ちた旧爪切りからニッパーへ替え、ギロチンより使いやすく短時間で済む点を犬への負担軽減として評価した体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=uv482&store_id=zunzunpetsupply'),
('zan-nipper','爪切り嫌いの犬',NULL,NULL,'quiet low-impact','ピーコック型では音と衝撃で逃げていた犬が、ニッパーでは音が小さくスパスパ切れるためその場でじっとしていた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=uv482&store_id=zunzunpetsupply'),
('zan-nipper','犬種不明・自宅爪切り初挑戦',NULL,NULL,'beginner angle','初めて自宅で爪を切る飼い主でも、さまざまな角度から刃を当てやすく、すんなり作業できた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=uv482&store_id=zunzunpetsupply'),
('zan-nipper','バセットハウンド','large',NULL,'hard-nail repeat','バセットハウンドの太い爪でもスパスパ切れ、酷使して前の同製品が壊れた後も同じものを再購入した体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=uv482&store_id=zunzunpetsupply'),
('zan-nipper','犬種不明',NULL,NULL,'fine-control handling','握りが柔らかく細かな微調整が効き、切れ味も良いため日常の爪ケアで使いやすいと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=uv482&store_id=zunzunpetsupply')
)
INSERT INTO reviews(product_id,dog_breed,dog_size,coat_type,needs,summary,source_type,source_url)
SELECT n.product_id,n.dog_breed,n.dog_size,n.coat_type,n.needs,n.summary,n.source_type,n.source_url
FROM new_reviews n
WHERE NOT EXISTS (
  SELECT 1 FROM reviews r
  WHERE r.product_id=n.product_id
    AND r.summary=n.summary
);

SELECT COUNT(*) AS nail_clipper_product_count
FROM products
WHERE category='nail-clipper' AND active=1;

SELECT COUNT(*) AS nail_clipper_review_count
FROM reviews r
JOIN products p ON p.id=r.product_id
WHERE p.category='nail-clipper' AND p.active=1;
