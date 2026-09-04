PRAGMA foreign_keys = ON;

WITH new_reviews(product_id,dog_breed,dog_size,coat_type,needs,summary,source_type,source_url) AS (
VALUES
('furminator-deshedding','柴犬・2歳','medium','double short','shedding mixed','掃除機タイプのブラシでも残っていた抜け毛対策で使用。10〜15分を数日続けると室内に散る毛が減った一方、毛が切れるような音とトップコートの見え方が気になった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=fur72005&store_id=aries0417'),
('furminator-deshedding','フレンチブルドッグ・フラッフィー','medium','long','shedding','抜け毛の多さが気になり使用し、下毛がかなり取れて抜け毛対策になったと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=10022677&store_id=kurosu'),
('furminator-deshedding','フレンチブルドッグ','medium','short','shedding','複数の抜け毛ブラシを試した中で特に毛がよく取れると感じ、継続使用している体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=10022677&store_id=kurosu'),
('furminator-deshedding','柴犬','medium','double short','shedding home','換毛期に室内へ舞う毛が多かったが、一回のブラッシングで大量に取れ、室内の飛散が減ったと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=10022677&store_id=kurosu'),
('furminator-deshedding','コーギー','medium','double','shedding','柴犬レビューが多く不安だったものの、換毛期のコーギーでも軽く撫でるだけで大量に毛が取れた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=10022677&store_id=kurosu'),
('furminator-deshedding','フレンチブルドッグ・皮膚が荒れやすい部位あり','medium','short','skin caution','毛はごっそり取れた一方、毛が薄く皮膚が荒れている部分では傷ついて出血することがあり、部位を避ける必要を感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=10022677&store_id=kurosu'),
('furminator-deshedding','ビーグル','medium','short','shedding speed','抜け毛が多いビーグルで、約5分でもかなりの量の毛が取れた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=10022677&store_id=kurosu'),
('furminator-deshedding','犬種不明・ブラッシング好き',NULL,NULL,'relaxed shedding','きれいに毛が取れ、ワンタッチでブラシから毛を外しやすく、犬も気持ちよさそうにしていた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=10022677&store_id=kurosu'),
('furminator-deshedding','コーギー','medium','double','weekly shedding','抜け毛対策で使用し、非常によく取れるため頻繁には使わず週1回ほどにしている体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=10022677&store_id=kurosu'),
('furminator-deshedding','柴犬・換毛期','medium','double short','shedding relaxed','換毛期に使うと驚くほど毛が取れ、犬も嫌がらず受け入れたが、長く続けると飽きるほどよく取れた体験。','public_buyer_review_summary','https://store.shopping.yahoo.co.jp/kurosu/10022677.html'),
('furminator-deshedding','パグ','small','short','shedding','パグの抜け毛対策に使用し、驚くほど毛が取れた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=10022677&store_id=kurosu'),
('furminator-deshedding','フレンチブルドッグ','medium','short','shedding relaxed','毎日外でブラッシングするほど抜け毛が多い犬に使い、毛がよく取れ、犬も嫌がりにくかった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/z3lqcc6vds/review/'),
('furminator-deshedding','ラブラドールレトリバー','large','short','shedding relaxed','ふわふわした下毛が大量に取れ、犬も嫌がらず気持ちよさそうにブラッシングを受けた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/z3lqcc6vds/review/'),
('furminator-deshedding','イングリッシュブルドッグ・パピー','medium','short','puppy shedding','秋の抜け毛が多い子犬に使い、横になっている時にブラッシングすると大量に取れ、気持ちよさそうだった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/z3lqcc6vds/review/'),
('furminator-deshedding','柴犬','medium','double short','shedding safety','旧型から新型へ替え、抜け毛が非常によく取れ、サイドの構造に以前より安心感を持った体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/z3lqcc6vds/review/'),
('furminator-deshedding','犬種不明・皮膚負担を気にする飼い主',NULL,NULL,'skin caution','毛はよく取れたが、角度や深さによって皮膚へ負担をかけそうと感じ、力加減に注意して使っている体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/z3lqcc6vds/review/'),
('furminator-deshedding','ロングコートチワワ','small','long','shedding relaxed','サロン帰りでも飛んでいた抜け毛が軽く背中をなぞるだけで大量に取れ、犬もピンブラシより気持ちよさそうだった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/2e8461c77d/review/'),
('furminator-deshedding','豆柴','small','double short','shedding caution','一年中抜け毛が多い豆柴で非常によく取れた一方、トリマーからやりすぎに注意するよう助言され、軽く撫でる感覚で使っている体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/2e8461c77d/review/'),
('furminator-deshedding','チワックス・4kg','small','double','relaxed shedding','他のブラシでは嫌がっていた4kgのチワックスが膝で伏せて受け入れ、不要な毛やフケがよく取れた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/2e8461c77d/review/'),
('furminator-deshedding','犬種不明・臆病',NULL,NULL,'scared negative','毛はよく取れるものの、かなり優しく当てないとブラシの感触を気にし、一番使いたかった臆病な犬が強く嫌がるようになった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/2e8461c77d/review/'),
('furminator-deshedding','スムースチワワ','small','short','shedding','車に乗せると毛だらけになるほど抜け毛が多い犬で、アンダーコートがごっそり取れ、抜け毛が減ったと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/2e8461c77d/review/'),
('furminator-deshedding','ロングコートチワワ・10か月','small','long','puppy shedding relaxed','抜け毛に困っていた10か月のチワワで、スリッカーよりよく取れ、ブラッシング中もじっとしていた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=rhc1301007007&store_id=petwill30'),
('furminator-deshedding','ジャックラッセルテリア','small','short','daily','毎日のブラッシングに使い、使い勝手が良いと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=8117940114512&store_id=soukai'),
('furminator-deshedding','ミニチュアピンシャー','small','short','technique shedding','ブラシ角度に少しコツが必要だったが、うまく当てるとしっかり抜け毛を取れた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=8117940114512&store_id=soukai'),
('furminator-deshedding','パグ','small','short','scared negative','使用時にプチプチとした音がし、痛いのか犬が逃げ回ったため相性に不安を感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=8117940114512&store_id=soukai'),
('furminator-deshedding','カニンヘンダックス','small','long','size','長毛のカニンヘンダックスにXSを選び、Sと迷ったが小さな体には扱いやすかったと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=pw00100002414&store_id=petwill30'),
('furminator-deshedding','ロングコートチワワ','small','long','relaxed smooth','ブラシが得意ではない犬でもうっとりして大人しく受け入れ、抜け毛が取れてブラシ後はサラサラになった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=pw00100002414&store_id=petwill30'),
('furminator-deshedding','チワワ・3.4kg','small','long','size mixed','3.4kgのチワワにXSを使い、犬は気持ちよさそうだったがヘッドが小さく、もう一回り大きくてもよかったと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=pw00100002414&store_id=petwill30'),
('furminator-deshedding','ロングコートチワワ','small','long','shedding','痛がらず手入れでき、日々の抜け毛もかなり減ったと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=pw00100002414&store_id=petwill30'),
('furminator-deshedding','チワワ・1.5kg','small','long','size shedding','一般的な櫛ではほとんど取れなかった1.5kgのチワワで、面白いほど毛が取れ、室内や服への抜け毛も減った体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/6b73ef52ad/review/'),
('furminator-deshedding','チワワ・2kg未満','small','long','scared treat shedding','柔らかい子犬毛が部屋に散っていた2kg未満のチワワで、おやつを使いながら少しずつブラッシングし、抜け毛が大きく減った体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/6b73ef52ad/review/'),
('furminator-deshedding','チワワ・XS使用','small','long','size mixed','チワワ用にXSを選んだが幅が狭く、取れた毛ですぐいっぱいになるためSの方が使いやすかったかもしれないと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/6b73ef52ad/review/'),
('furminator-deshedding','ロングコートチワワ2頭・各2kg弱','small','long','multi size relaxed','2kg弱のチワワ2頭にXSを使用し、よく毛が取れ痛がらず気持ちよさそうだったが、幅の狭さからSでもよかったと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/6b73ef52ad/review/'),
('furminator-deshedding','ロングコートチワワ・3.7kg','small','long','size caution','非常によく毛が取れるため毎日使うと取りすぎが心配になり、3.7kgではXSより一回り大きいサイズでもよかったと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/6b73ef52ad/review/'),
('furminator-deshedding','チワワ・2kg','small','long','size shedding','購入前は価格で迷ったが、2kgのチワワにXSがちょうどよく、もっと早く買えばよかったと感じるほど毛が取れた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=pw00100002414&store_id=petwill30'),
('furminator-deshedding','ゴールデン×柴のミックス','medium','double long','shedding','ダブルコートで抜け毛が多いミックス犬に使い、従来の櫛よりかなり多く毛を回収できた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=w1125&store_id=petyafuupro'),
('furminator-deshedding','長毛の中型雑種犬','medium','long','shedding skin caution','長毛で抜け毛の多い中型ミックスに使い大量に回収できたが、毛量が少ない部位では皮膚を傷めないよう浮かせ気味に使った体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=w1125&store_id=petyafuupro'),
('furminator-deshedding','長毛ボーダーコリー','medium','double long','negative topcoat','アンダーコートだけを取りたかったがオーバーコートも一緒に取れると感じ、使いこなしに難しさを感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=w1125&store_id=petyafuupro'),
('furminator-deshedding','ポメラニアン','small','long','relaxed shedding','安価な類似品から正規品へ替え、抜け毛がよく取れ、犬も気持ちよさそうに受け入れた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=w1125&store_id=petyafuupro'),
('furminator-deshedding','ラブラドールレトリバー','large','short','large shedding','大型犬用を初めて使い、しっかり抜け毛が取れて他のブラシへ戻れないほどと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/z3lqcc6v6g'),
('furminator-deshedding','シベリアンハスキー','large','double long','large shedding','大型犬の長毛用をハスキーに使い、毛並みも整うためこのタイプを選び続けている体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/z3lqcc6v6g'),
('furminator-deshedding','バーニーズ・4か月','large','long','puppy shedding','4か月のバーニーズに大型犬長毛用を使い、評判通り抜け毛がよく取れた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=dg0008&store_id=pet-yass'),
('furminator-deshedding','ジャーマンシェパード','large','double long','large shedding','大型犬長毛用を使用し、多くの毛を取れ、取った毛をブラシから外す操作も簡単と感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=10022680&store_id=kurosu'),
('furminator-deshedding','ダックス3頭','small','long','multi shedding','ペットショップの勧めで大型犬長毛用を購入し、ダックス3頭のブラッシングに使っている体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=10022680&store_id=kurosu')
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

SELECT
 (SELECT COUNT(*) FROM reviews r JOIN products p ON p.id=r.product_id WHERE p.category='brush-undercoat') AS brush_undercoat_review_count;
