PRAGMA foreign_keys = ON;

WITH new_reviews(product_id,dog_breed,dog_size,coat_type,needs,summary,source_type,source_url) AS (
VALUES
('panasonic-er807pp','毛の柔らかい子犬','small',NULL,'puppy quiet attachment','毛の柔らかい子犬にアタッチメントを初めて使い、長めに残しつつ、音と振動が静かで敏感な後頭部も怖がらず刈れた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=20005404&store_id=biasu'),
('panasonic-er807pp','マルチーズ','small','long','mat 3mm','細く絡まりやすい長毛のマルチーズに3mmで使い、コームへ毛が挟まることはあるものの、きちんと刈れた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=20005404&store_id=biasu'),
('panasonic-er807pp','犬種不明・バリカン初心者',NULL,NULL,'beginner scared battery','最初は犬が警戒したがすぐ慣れ、9mm・6mmを試した後3mmでカット。初回は充電切れで足裏とお尻をハサミ仕上げにした体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/b57e75aa0a'),
('panasonic-er807pp','3kg未満の小型犬','small',NULL,'fullbody cool-blade waterproof','小型犬を2回全身カットし、慣れるまでは40分を超えてコード接続も使った一方、刃が熱くなりにくく足裏も落ち着いて切れた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/b57e75aa0a'),
('panasonic-er807pp','小型犬','small',NULL,'home-grooming attachment','サロン任せから自宅カットへ切り替え、長さ調整アダプターで全身から足裏・お尻まで1台で整えられた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=er807pp-a&store_id=kaden-sakura'),
('panasonic-er807pp','ミニチュアシュナウザー2頭','medium','wire','multi quiet oil-maintenance','2頭のシュナウザーに使い、静かでじっとしてくれ、刈る面積も広く楽だった一方、注油を省くと切れ味の違いを感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/b57e75aa0a'),
('panasonic-er807pp','犬種不明・夏の全身カット','medium',NULL,'summer technique','初めて犬の全身を自宅で刈り、背中は刈りやすい一方、首や腹は難しく、柔らかい毛は少し湿らせると扱いやすいと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/b57e75aa0a'),
('panasonic-er807pp','トイプードル','small','curly','beginner 12mm fullbody','初セルフトリミングで12mmを使い、説明書を見ながら全身を約1時間で仕上げ、次回は40分ほどでできそうと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/b57e75aa0a'),
('panasonic-er807pp','犬種不明','small',NULL,'quiet lightweight charging-indicator','想像より静かで犬も怖がらず、本体も軽く扱いやすかった一方、充電完了がランプで分かりにくいと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/b57e75aa0a'),
('panasonic-er807pp','トイプードル・初トリミング','small','curly','multi-length beginner','初めてのトイプードルで、お尻と足裏1mm、顔3mm、体6〜12mmと部位で長さを変え、数回でかなり理想の形に近づけた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/b57e75aa0a'),
('panasonic-er807pp','犬種不明・一度の充電で全身','small',NULL,'battery quiet maintenance','一度の充電で全身をカットでき、音と振動が少なく犬も落ち着き、刃の取り外しや手入れもしやすかった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list/2/?page_key=er807pp-a&store_id=kaden-sakura'),
('panasonic-er807pp','トイプードル','small','curly','value cut-quality','ホームセンターの高価なバリカンでは切れなかったトイプードルの毛が、価格を抑えたこの機種ではしっかり切れたと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list/2/?page_key=er807pp-a&store_id=kaden-sakura'),
('panasonic-er807pp','ミニチュアダックス・12歳','small','long','senior negative clogging','ロングヘアの12歳ダックスに使い、毛がすぐ刃へ詰まり虎刈りになりやすく、短時間で終えたいシニア犬には時間がかかると感じた否定的体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list/2/?page_key=er807pp-a&store_id=kaden-sakura'),
('panasonic-er807pp','犬種不明・10年以上使用後の買い替え',NULL,NULL,'repeat durability handling','初代を10年以上使い、充電が持たなくなって別メーカーへ替えたものの、引っ掛かりや持ちにくさから再び同機種へ戻った体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list/2/?page_key=er807pp-a&store_id=kaden-sakura'),
('panasonic-er807pp','ミニチュアシュナウザー','medium','wire','handling cut-quality','ドギーマン製の切れ味低下を機に買い替え、手に馴染む形と新品の切れ味で使いやすいと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list/3/?page_key=er807pp-a&store_id=kaden-sakura'),
('panasonic-er807pp','ゴールデンレトリバー','large','long','paw fullbody summer','足まわりをハサミで整える負担から導入し、足だけでなく大型犬の全身や腹・お尻の暑さ対策にも使えた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list/3/?page_key=er807pp-a&store_id=kaden-sakura'),
('panasonic-er807pp','細い毛の犬',NULL,'fine','attachment noise mixed','細い毛でも引っ掛からずきれいに刈れ、アタッチメントで長さも揃えやすかった一方、音はやや大きく感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list/3/?page_key=er807pp-a&store_id=kaden-sakura'),
('panasonic-er807pp','犬種不明・足裏中心','small',NULL,'paw quiet acclimation','ハサミより安全そうと足裏用に使い、電源を入れて少し待って音に慣らしてから始めると犬があまり気にせずカットできた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=er807pp-a&store_id=kaden-sakura'),
('panasonic-er807pp','ロングチワワ＋トイプードル','small','long curly','multi coat cut-quality','毛量の多いロングチワワとトイプードルに使い、過去の安価品よりきちんと毛を刈れて替刃も購入できる点を評価した体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=20005404&store_id=biasu'),
('panasonic-er807pp','ミニチュアシュナウザー','medium','wire','cord-use quiet smooth','充電途中でもコードをつないで使え、密なシュナウザーの毛を以前の機種より静かな音と少ない振動でスムーズに刈れた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=20005404&store_id=biasu'),
('pateker-lg4','犬種不明・初心者','medium',NULL,'beginner quiet safety','ワイドタイプを初めて使い、音が小さく切れ味は強すぎず、初心者でも安全寄りに扱いやすいと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/306097_10000190/1.1/'),
('pateker-lg4','怖がりな犬','small',NULL,'scared beginner safe-blade','バリカン初挑戦の飼い主が使い、犬は怖がったものの刃が皮膚に触れても傷つきにくく、よく剃れて扱う側は安心できた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/306097_10000190/1.1/'),
('pateker-lg4','幼犬・1.6kg','small',NULL,'puppy paw sanitary','1.6kgの幼犬に使い、肉球の間やお尻まわりを問題なく細かく整えられた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/306097_10000190/1.1/'),
('pateker-lg4','トイプードル','small','curly','paw quiet','トイプードルの足裏用に使い、作動音が静かで小回りも利き、日常ケアに使いやすかった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/306097_10000190/1.1/'),
('pateker-lg4','ミニチュアダックスフンド','small','long','ear mat quiet','耳の後ろに毛玉ができやすいミニチュアダックスで、細かな部分に合うサイズと大きすぎない音で毛玉周辺を整えやすかった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/306097_10000190/1.1/'),
('pateker-lg4','シーズー','small','long','face paw lightweight','大きなバリカンでは難しかった肉球の間や鼻の上に使い、軽くて音も大きくなく細部へ当てやすかった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/306097_10000190/1.1/'),
('pateker-lg4','トイプードル','small','curly','paw light wide','ワイドタイプでも思ったより小さく、LEDで足裏が見やすく、トイプードルの足裏にちょうど良かった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/306097_10000190/1.1/'),
('pateker-lg4','ビビりな犬','small',NULL,'scared negative quiet','本体は軽く音も想像以上に小さかったが、怖がりな犬が作業そのものを受け入れず使い切れなかった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/306097_10000190/1.1/'),
('pateker-lg4','ミニチュアダックスフンド・16歳','small','long','senior light','もうすぐ16歳のミニチュアダックスのケアに使い、LEDで手元が見やすくもっと早く買えばよかったと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/306097_10000190/1.1/'),
('pateker-lg4','トイプードル','small','curly','paw sanitary light','通常サイズのバリカンとは別にスリムを導入し、足裏とお尻周りを気になった時にすぐ整えられ、ライトも役立った体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/306097_10000190/1.1/'),
('pateker-lg4','ボーダーコリー','medium','double long','paw ear quiet cordless','ボーダーコリーの足裏と耳まわりに使い、静音で怖がりにくく、LEDとコードレスで細部を見ながら整えやすかった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/306097_10000190/1.1/'),
('pateker-lg4','犬2頭','small',NULL,'multi scared mixed','2頭に使い、きれいにカットできた一方、1頭は作動音を怖がったため犬によって反応が分かれた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/306097_10000190/1.1/'),
('pateker-lg4','チワワ','small',NULL,'paw quiet safety','爪切りも苦手なチワワの足裏に使い、音が静かで小さな刃が扱いやすく、肉球に一瞬触れても傷になりにくく安心した体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/306097_10000190/1.1/'),
('pateker-lg4','16歳ダックス＋チワワ','small',NULL,'senior partial','トリミングが難しくなった16歳のダックスとチワワに使い、足首・耳・指先まわりを想像以上にスムーズに整えられた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/306097_10000190/1.1/'),
('pateker-lg4','スタンダードプードル','large','curly','paw wide','通常の全身バリカンでは難しい指の間のためワイドタイプを導入し、足まわりの細かなカットにミニバリカンの必要性を感じた体験。','public_buyer_review_summary','https://store.shopping.yahoo.co.jp/selectshopcrea/pateker-lg4.html'),
('speedik-peace','トイプードル2頭','small','curly','multi power cordless','毛量の多いトイプードル2頭に使い、価格は高く感じたもののパワーがあり、充電式で替刃の長さを交換できる点を評価した体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=016767&store_id=petech'),
('speedik-peace','犬種不明・THRIVEから買い替え',NULL,NULL,'power noise','長年使ったTHRIVEから替え、力強いトルクを感じた一方、作動音はしっかり聞こえるタイプだと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=016767&store_id=petech'),
('speedik-peace','犬種不明・コード式と併用',NULL,NULL,'cordless partial','犬のカット負担を減らすためコードレス機を追加し、細かい部分と広い部分で2台を使い分け、どちらも切れ味に満足した体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=016767&store_id=petech'),
('speedik-peace','トイプードル','small','curly','soft-coat power','柔らかい毛で他社バリカンがほとんど切れなかったトイプードルに使い、切り始めから切れ味の違いを感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=016767&store_id=petech'),
('speedik-peace','犬種不明・コード式から変更',NULL,NULL,'cordless handling','従来のコード付きSPEEDIKからワイヤレスへ替え、ケーブルの煩わしさがなくなって取り回しが楽になった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=016767&store_id=petech'),
('speedik-peace','犬種不明・音に敏感',NULL,NULL,'noise negative','コードレスで使いやすい一方、従来のコード式より音が大きく、敏感な犬には別の静かなバリカンを使い分けている体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=016767&store_id=petech'),
('speedik-peace','犬種不明・買い替え',NULL,NULL,'repeat blade-compatibility','同じ機種の配線や充電器が傷んだため本体だけ買い替え、手持ちの替刃をそのまま使える点が助かった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=016767&store_id=petech'),
('speedik-peace','犬種不明・コードレス比較',NULL,NULL,'cordless power','長くSPEEDIKを使ってきた家庭で、コードレスでも切る力が大きく落ちず使いやすいと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=016767&store_id=petech'),
('speedik-peace','犬種不明',NULL,NULL,'weight handling cord','犬のカットに使い、程よい重さで取り回しやすい一方、コード接続時はコードの絡みが気になると感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=016767&store_id=petech'),
('speedik-peace','敏感な犬',NULL,NULL,'scared noise mixed','コードレスの操作性は良かったが音が大きめで、敏感な犬には以前のバリカンを使うこともあるという混合評価。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=016767&store_id=petech'),
('speedik-peace','犬種不明・使用中に停止',NULL,NULL,'durability negative','購入後しばらくすると充電済みでも使用中に電源が切れるようになり、コード式へ戻ろうと考えた否定的体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=016767&store_id=petech'),
('speedik-peace','犬種不明・長期使用前提',NULL,NULL,'repairability handling','本体の大きさが扱いやすく、替刃の研ぎ直しや本体修理に対応できるため長く使いやすいと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=016767&store_id=petech'),
('speedik-peace','犬種不明・旧コード式から買い替え',NULL,NULL,'cordless location','古くなったコード式から替え、コードレスになったことで場所を選ばずカットしやすくなった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=016767&store_id=petech'),
('speedik-peace','犬種不明・TAPIOから変更',NULL,NULL,'cordless handling size','TAPIOより本体は少し長く感じたものの、コードレスのため動かしやすく、総合的には使いやすかった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=016767&store_id=petech'),
('speedik-peace','犬種不明・家庭と職場で使用',NULL,NULL,'weight professional','職場で使い慣れた同じ機種を家庭用にも導入し、ある程度の重みはあるものの慣れれば問題なく扱えた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=016767&store_id=petech')
)
INSERT INTO reviews(product_id,dog_breed,dog_size,coat_type,needs,summary,source_type,source_url)
SELECT n.product_id,n.dog_breed,n.dog_size,n.coat_type,n.needs,n.summary,n.source_type,n.source_url
FROM new_reviews n
WHERE NOT EXISTS (
  SELECT 1 FROM reviews r
  WHERE r.product_id=n.product_id
    AND r.summary=n.summary
);

SELECT COUNT(*) AS dog_clipper_product_count
FROM products
WHERE category='dog-clipper' AND active=1;

SELECT COUNT(*) AS dog_clipper_review_count
FROM reviews r
JOIN products p ON p.id=r.product_id
WHERE p.category='dog-clipper' AND p.active=1;
