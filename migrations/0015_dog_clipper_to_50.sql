PRAGMA foreign_keys = ON;
WITH new_reviews(product_id,dog_breed,dog_size,coat_type,needs,summary,source_type,source_url) AS (
VALUES
('pateker-p6','マルプー・約2歳','small','curly','quiet fullbody speed','体9mm・顔6mmで使用し、以前のバリカンより毛詰まりが少なく、静かで短時間に全身を整えやすかった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/review/item/1/306097_10000073/1.1/'),
('pateker-p6','犬種不明・初セルフカット',NULL,NULL,'beginner heat','自宅カットへ切り替えてよく刈れた一方、30分〜1時間ほどで本体が熱を持つため休憩を挟んだ体験。','public_buyer_review_summary','https://review.rakuten.co.jp/review/item/1/306097_10000073/1.1/'),
('pateker-p6','シュナウザー','medium','wire','quiet repeat','旧バリカンの切れ味低下で2台目として購入し、多少まだらでも切れ味と静音性に満足した体験。','public_buyer_review_summary','https://review.rakuten.co.jp/review/item/1/306097_10000073/1.1/'),
('pateker-p6','トイプードル','small','curly','fullbody technique','胴と脚の付け根までバリカンを使い、細かいコームで毛を整えながら進めると刈りやすかった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/review/item/1/306097_10000073/1.1/'),
('pateker-p6','トリミング嫌いの犬',NULL,NULL,'scared quiet','以前より音が静かで切れ味も良く、トリミング嫌いの犬へのストレスを減らせそうと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/review/item/1/306097_10000073/1.1/'),
('pateker-p6','ゴールデン×シェパード・7歳・40kg','large','coarse double','large coarse repeat','40kgの剛毛ミックス犬で4台目まで使い続け、切れ味・モーター・バッテリーに満足している体験。','public_buyer_review_summary','https://review.rakuten.co.jp/review/item/1/306097_10000073/1.1/'),
('pateker-p6','犬種不明・毛量多め',NULL,NULL,'hair-clog finish','よく刈れるがアタッチメントへ毛が詰まりやすく、こまめに取り除くときれいに仕上がった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/review/item/1/306097_10000073/1.1/'),
('pateker-p6','犬種不明・サロン休業中',NULL,NULL,'beginner relaxed','トリマーが休みの間のセルフカット用に使い、犬がおとなしくしてくれてスムーズに仕上げられた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/review/item/1/306097_10000073/1.1/'),
('pateker-p6','犬種不明・足裏ケア',NULL,NULL,'paw lightweight','全身はまだ試さず足裏に使用し、200g台の本体でしっかり毛を切れた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/review/item/1/306097_10000073/1.1/'),
('pateker-p6','犬種不明・全身カット',NULL,NULL,'battery fullbody','全身をカットしても充電が切れず、約3時間充電の使い勝手を良いと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/review/item/1/306097_10000073/1.1/'),
('pateker-p6','犬種不明・手足とお尻ケア',NULL,NULL,'quiet partial','届いてすぐ手足とお尻に使い、音が静かで扱いやすいと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/review/item/1/306097_10000073/1.1/'),
('pateker-p6','トイプードル','small','curly','quiet multi-day','3mmで体をカットし、静音で嫌がりにくかったが、途中で犬が飽きるため数日に分けて仕上げた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/review/item/1/306097_10000073/1.1/'),
('pateker-p6','音に敏感な犬',NULL,NULL,'scared negative','他のバリカンと同様に敏感な犬は音を嫌がり、足裏用にはやや大きくボディ向きと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/review/item/1/306097_10000073/1.1/'),
('pateker-p6','長毛の大型犬・多頭飼い','large','long','multi paw repeat','長毛大型犬の多頭飼いで、2週間に1度の足裏・足先ケアに使い、切れ味と水洗いできる点を評価した体験。','public_buyer_review_summary','https://review.rakuten.co.jp/review/item/1/306097_10000073/1.1/'),
('pateker-p6','超小型犬','small',NULL,'scared acclimation','静音でも音は感じるため少しずつ慣らし、怖がらずカットできたが、一時的に振動が大きくなったこともあった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/review/item/1/306097_10000073/1.1/'),
('pateker-p6','犬種不明・旧バリカン10年以上',NULL,NULL,'speed','10年以上使った小型バリカンから替え、切れ味がよくなってカット時間が短くなった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/review/item/1/306097_10000073/1.1/'),
('pateker-p6','犬種不明・初心者',NULL,NULL,'beginner technique','初めてペット用バリカンを使い、毛流れに沿うか逆らうかで長さが変わることを学びながらきれいに刈れた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/review/item/1/306097_10000073/1.1/'),
('pateker-p6','ポメラニアン','small','long','partial heat caution','全身カットではなく部分ケアに使い、最初だけ音に驚いたものの慣れ、刃の熱を確認しながら使用した体験。','public_buyer_review_summary','https://review.rakuten.co.jp/review/item/1/306097_10000073/1.1/'),
('pateker-p6','犬種不明・暑さ対策',NULL,NULL,'fullbody quiet','サロンへ行けない時期に自宅で全身を整え、1時間弱使えて音も小さく、すっきり仕上げられた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/review/item/1/306097_10000073/1.1/'),
('pateker-p6','トイプードル・8kg','small','curly','senior speed relaxed','高齢になりサロン負担を減らすため自宅カットへ切り替え、6mmで約20分のバリカン作業を終え、寝たまま大部分を刈れた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=pet-01&store_id=selectshopcrea'),
('pateker-p6','トイプードル','small','curly','fullbody battery','複数の犬用バリカンで失敗した後に使用し、全身をよく切れ、充電時間が短いのに使用時間が長いと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=pet-01&store_id=selectshopcrea'),
('pateker-p6','トイプードル・12歳','small','curly','senior stress speed','高齢で目も見えにくくサロン利用が難しくなり、以前のバリカンより短時間で終えられて体調を崩さず済んだ体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=pet-01&store_id=selectshopcrea'),
('pateker-p6','小型犬・皮膚が余りやすい体型','small',NULL,'mixed technique','背中の皮膚を伸ばしながらでないと刈りにくく、音と電池持ちは良いものの期待ほどサクサクではなかった混合評価。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=pet-01&store_id=selectshopcrea'),
('pateker-p6','トイプードル','small','curly','weekly summer','絡まりをなくしてから使うと引っかかりにくく、夏はほぼ毎週サマーカットに使っても切れ味が大きく落ちにくかった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=pet-01&store_id=selectshopcrea'),
('pateker-p6','ミニチュアダックス・シニア','small','long','senior fullbody','高齢になり店でトリミングを断られ、自宅で使ったところ簡単に短くカットできた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list/5/?page_key=pet-01&store_id=selectshopcrea'),
('pateker-p6','犬種不明・耳まわり',NULL,NULL,'quiet face','以前のバリカンより静かで、これまで最後に回していた耳まわりも犬と飼い主が音を気にしにくくカットできた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list/5/?page_key=pet-01&store_id=selectshopcrea'),
('pateker-p6','脳炎のある犬',NULL,NULL,'medical-stress gradual','長時間サロンに出すストレスを避けるため購入し、自宅で様子を見ながら少しずつ全身をカットできた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list/5/?page_key=pet-01&store_id=selectshopcrea'),
('pateker-p6','犬種不明・足裏初バリカン',NULL,NULL,'paw quiet beginner','初めて足裏へ使っても音を気にせず大人しくカットさせ、切れ味は良い一方で刃の着脱に戸惑った体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list/5/?page_key=pet-01&store_id=selectshopcrea'),
('pateker-p6','トイプードル3頭・子犬含む','small','curly','multi puppy','トイプードル3頭を一度に手入れし、細い子犬毛も携帯型よりスムーズに切れ、替刃付きも助かった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list/5/?page_key=pet-01&store_id=selectshopcrea'),
('pateker-p6','マルプー','small','curly','fullbody quiet','顔以外を6mmでセルフトリミングし、長い毛も掃除しながら切れ、音も比較的静かで嫌がりにくかった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list/5/?page_key=pet-01&store_id=selectshopcrea'),
('pateker-p6','トイプードル・13歳','small','curly','senior quiet','13歳のセルフトリミングに長期間使い、コードレスで音が静かなので高齢犬のサロン負担を減らせた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list/5/?page_key=pet-01&store_id=selectshopcrea'),
('pateker-p6','トイプードル','small','curly','quiet relaxed','旧バリカンで毛が絡んでいた犬に使い、実際には絡みにくく上手にカットできた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list/5/?page_key=pet-01&store_id=selectshopcrea'),
('panasonic-er807pp','犬種不明・約9年使用',NULL,NULL,'durability repeat','同じ機種を約9年使った後に充電劣化で買い直し、別製品より毛並みをきれいに切れて使いやすいと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/301897_10003603/1.1/'),
('panasonic-er807pp','犬種不明・リピート',NULL,NULL,'repeat handling','使いやすさを理由に同機種をリピート購入し、家庭で継続使用している体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/301897_10003603/1.1/'),
('panasonic-er807pp','犬種不明・家庭トリミング',NULL,NULL,'fullbody','愛犬のトリミングに使い、家庭でもカットしやすいと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/301897_10003603/1.1/'),
('panasonic-er807pp','トイプードル・月2回','small','curly','long-use fullbody','同機種を8年使用し、月2回トイプードルをフルカットしても長く使え、替刃を買える点を評価した体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212826_10032992/1.1/'),
('panasonic-er807pp','トイプードル・部分カット','small','curly','partial safety','肉球などの部分カットでは刃が触れても痛がりにくく安心だった一方、全身は時間がかかりすぎると感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212826_10032992/1.1/'),
('panasonic-er807pp','高齢犬',NULL,NULL,'senior beginner','高齢でサロン利用が難しくなり初めて自宅バリカンへ挑戦し、充電1回では全身完了しなくても大部分を整えられた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212826_10032992/1.1/'),
('panasonic-er807pp','トイプードル','small','curly','power battery','故障した他社品から替え、使いやすさと切れ味に満足しつつ、バッテリー持ちは短めと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212826_10032992/1.1/'),
('panasonic-er807pp','療養中の犬',NULL,NULL,'quiet beginner','療養中の犬へ初めて使用し、音が静かで本体も熱くなりにくく、初心者でも楽にカットできた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/212826_10032992/1.1/')
)
INSERT INTO reviews(product_id,dog_breed,dog_size,coat_type,needs,summary,source_type,source_url)
SELECT n.product_id,n.dog_breed,n.dog_size,n.coat_type,n.needs,n.summary,n.source_type,n.source_url
FROM new_reviews n
WHERE NOT EXISTS (
 SELECT 1 FROM reviews r
 WHERE r.product_id=n.product_id
 AND COALESCE(r.dog_breed,'')=COALESCE(n.dog_breed,'')
 AND r.summary=n.summary
);
SELECT (SELECT COUNT(*) FROM reviews r JOIN products p ON p.id=r.product_id WHERE p.category='dog-clipper') AS dog_clipper_review_count;
