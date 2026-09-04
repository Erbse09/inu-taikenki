PRAGMA foreign_keys = ON;
WITH new_reviews(product_id,dog_breed,dog_size,coat_type,needs,summary,source_type,source_url) AS (
VALUES
('casfuy-6speed','ジャックラッセルテリア・4歳','small','short','scared acclimation','最初は音と振動を怖がったが、爪切りより抵抗が少なく、3回目には全爪を研がせてくれるようになった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/zzmc7a7k52/review/'),
('casfuy-6speed','犬種不明・旧電動やすりから買い替え',NULL,NULL,'speed power','以前の電動やすりよりパワーがあり、実際の爪ケア時間が半分以下になって犬の拘束時間も短くなったと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/zzmc7a7k52/review/'),
('casfuy-6speed','犬種不明・爪切りが大の苦手',NULL,NULL,'scared low-speed','最初は嫌がったものの徐々に怖くないと分かり削れるようになり、低めの速度で様子を見ながら使っている体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/zzmc7a7k52/review/'),
('casfuy-6speed','犬種不明・ライト重視',NULL,NULL,'light handling','愛犬の爪ケアに使い、ライトで手元を確認しやすく、爪切り時間が楽になったと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/zzmc7a7k52/review/'),
('casfuy-6speed','犬種不明・飼い主が爪切りを怖がる',NULL,NULL,'beginner gradual','爪切りへの不安から電動タイプへ替え、犬が嫌がらないよう短時間ずつ少しずつ削っている体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/zzmc7a7k52/review/'),
('casfuy-6speed','犬複数頭・爪切りを見ると逃げる',NULL,NULL,'multi scared light','爪切りを見ると逃げる複数の犬でも、削る方法ならケアでき、ライトも手元確認に役立った体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/zzmc7a7k52/review/'),
('casfuy-6speed','犬種不明・硬い爪',NULL,NULL,'hard-nail power','複数メーカーの電動やすりを使った後に試し、硬い爪でも問題なく削れるパワーを評価した体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/zzmc7a7k52/review/'),
('casfuy-6speed','トイプードル','small','curly','speed','トイプードルの爪に使い、短時間で削れて便利だと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/product/j/0769044762960/compare.html'),
('casfuy-6speed','犬種不明・削りすぎ注意',NULL,NULL,'power caution','実際に使うと非常によく削れたため、削りすぎないよう注意が必要と感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/zzmc7a7k52/review/2/'),
('casfuy-led2','中型犬・15kg','medium',NULL,'hard-nail speed','15kgの中型犬で、太く硬い爪を以前の電動やすりより短時間で削れ、作業時間が大きく減った体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/product/j/0769044761055/compare.html'),
('casfuy-led2','黒い爪の犬・過去に出血経験',NULL,NULL,'black-nail beginner','爪切りで出血させた後に獣医からやすりを勧められ、練習しながら黒い爪を少しずつ削れるようになった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/product/j/0769044761055/compare.html'),
('casfuy-led2','チワワ','small',NULL,'scared','ハサミ型の爪切りを強く嫌がっていたチワワが、電動やすりでは比較的嫌がらず削らせた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/product/j/0769044761055/compare.html'),
('casfuy-led2','ボーダーコリー2頭','medium','double long','multi scared','手動爪切りを嫌うボーダーコリー2頭が、電動やすりへ替えると嫌がらずケアしやすくなった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/product/j/0769044761055/compare.html'),
('casfuy-led2','チワワ・2kg','small',NULL,'light black-nail','2kgのチワワに使用し、よく削れ、ライトで手元を見やすく切りすぎへの不安を減らせた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/product/j/0769044761055/compare.html'),
('casfuy-led2','黒い爪の犬',NULL,NULL,'black-nail scared noise','パワーがあり削るのは速い一方、黒い爪は確認しながら進める必要があり、音を怖がる反応もあった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/product/j/0769044761055/compare.html'),
('casfuy-led2','犬種不明・旧製品から買い替え',NULL,NULL,'quiet power','以前の電動やすりより音が静かに感じ、犬も大人しく削らせ、握りやすさとパワーを評価した体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/product/j/0769044761055/compare.html'),
('casfuy-led2','犬種不明・白い爪',NULL,NULL,'light relaxed','犬が嫌がらず爪を磨がせ、白い爪ではライトで内部を確認しやすいと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/product/j/0769044762069/compare.html'),
('casfuy-led2','犬種不明・旧電動やすりから変更',NULL,NULL,'power','以前使っていた製品より本体がしっかりしていて、削るパワーが強いと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/product/j/0769044761055/compare.html'),
('casfuy-led2','犬種不明・爪やすりとして使用',NULL,NULL,'handling','犬の爪へ実際に使い、爪切りというより電動やすりとして扱いやすかったと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/product/j/0769044762069/compare.html'),
('petio-selftrimmer-nail','小型犬・爪切りが苦手','small',NULL,'beginner','これまでうまく爪を切れなかったが、やすりなら簡単に削れ、足裏毛も同じ本体で整えられて手入れが楽になった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/z4emqa5v59/review/'),
('petio-selftrimmer-nail','犬種不明・飼い主も犬も初心者',NULL,NULL,'acclimation','爪やすりは犬も飼い主も慣れておらず十分使えなかったが、ゆっくり慣らせば使えそうと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/z4emqa5v59/review/'),
('petio-selftrimmer-nail','犬種不明・爪研ぎ初挑戦',NULL,NULL,'quiet acclimation','足裏カットと爪研ぎを試行錯誤しながら使い、犬は強く嫌がらず、音も小さく感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/z4emqa5v59/review/'),
('petio-selftrimmer-nail','小型犬','small',NULL,'beginner quiet','爪切りを嫌がり始めた小型犬で爪やすりアタッチメントを使い、初心者でも扱いやすく音も気になりにくかった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/261122_11047258/1.1/'),
('petio-selftrimmer-nail','犬種不明・爪処理に慣らし中',NULL,NULL,'quiet acclimation','犬と飼い主の双方がまだ慣れていない段階で少しずつ爪処理に使い、音の小ささを良いと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/review/item/1/217176_10153666/1.1/'),
('petio-selftrimmer-nail','犬種不明・爪やすり目的',NULL,NULL,'handling','複数候補から実際に試したことのある2WAYを選び、爪やすりを主目的に使いやすいと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/review/item/1/217176_10153666/1.1/'),
('dremel-7350-pet','犬複数頭・クリッパーより電動派',NULL,NULL,'multi scared','従来の爪切りより、このグラインダーの方が犬たちが嫌がりにくいと感じた購入者の体験。','public_buyer_review_summary','https://www.lowes.com/reviews/dremel-7350-pet-rotary-tools/5001939579'),
('dremel-7350-pet','犬種不明・1速使用',NULL,NULL,'simple','実際の爪ケアで問題なく使えた一方、速度が1段階だけなのは物足りないと感じた体験。','public_buyer_review_summary','https://www.lowes.com/reviews/dremel-7350-pet-rotary-tools/5001939579'),
('dremel-7350-pet','犬種不明・電動ケアを受け入れる犬',NULL,NULL,'relaxed','操作が簡単で、犬も使用中にあまり気にする様子がなく爪を整えられた体験。','public_buyer_review_summary','https://www.lowes.com/reviews/dremel-7350-pet-rotary-tools/5001939579'),
('dremel-7350-pet','犬種不明・静音重視',NULL,NULL,'quiet','犬の爪を整える用途で使い、音が静かで使いやすいと感じた体験。','public_buyer_review_summary','https://www.lowes.com/reviews/dremel-7350-pet-rotary-tools/5001939579'),
('dremel-7350-pet','大型犬・サロンで使用','large',NULL,'thick-nail negative','ドッググルーミングサロンで大型犬の太い爪に使ったところ、1速では削るのに時間がかかり力不足と感じた体験。','public_buyer_review_summary','https://www.lowes.com/reviews/dremel-7350-pet-rotary-tools/5001939579'),
('dremel-7350-pet','犬種不明・音を気にする家庭',NULL,NULL,'noise mixed','実際に使えて機能面は足りた一方、想像より作動音が大きく、1速しかない点も惜しいと感じた体験。','public_buyer_review_summary','https://www.lowes.com/reviews/dremel-7350-pet-rotary-tools/5001939579'),
('dremel-7350-pet','犬複数頭',NULL,NULL,'multi speed quiet','複数の犬に使い、音が大きすぎず短時間で爪を削れる点を評価した体験。','public_buyer_review_summary','https://www.lowes.com/reviews/dremel-7350-pet-rotary-tools-oscillating-tools/5001939579?offset=20'),
('dremel-7350-pet','興奮しやすい犬',NULL,NULL,'feisty negative','初回使用で本体に不具合が起き、さらにパワー不足に感じ、じっとしにくい犬では素早く終わらせにくいと感じた体験。','public_buyer_review_summary','https://www.lowes.com/reviews/dremel-7350-pet-rotary-tools-oscillating-tools/5001939579?offset=20'),
('dremel-7350-pet','犬複数頭・爪切りから変更',NULL,NULL,'multi quiet','従来の爪切りより低い音で複数の犬の爪を整えやすいと感じた体験。','public_buyer_review_summary','https://www.lowes.com/reviews/dremel-7350-pet-rotary-tools-oscillating-tools/5001939579?offset=20'),
('dremel-7350-pet','犬種不明・自宅爪ケア',NULL,NULL,'quiet beginner','静かで扱いやすく、自宅で犬の爪を整える費用と手間を減らせたと感じた体験。','public_buyer_review_summary','https://www.lowes.com/reviews/dremel-7350-pet-rotary-tools-oscillating-tools/5001939579?offset=20'),
('dremel-7350-pet','足を触られるのが苦手な犬複数頭',NULL,NULL,'multi sensitive-paws','足先を触られるのが苦手な犬たちにも使いやすかったと感じた購入者の体験。','public_buyer_review_summary','https://www.lowes.com/reviews/dremel-7350-pet-rotary-tools-oscillating-tools/5001939579?offset=40'),
('dremel-7350-pet','犬種不明・旧電動グラインダーから変更',NULL,NULL,'noise control','以前の多段階グラインダーより音は残るものの、爪を見ながら操作しやすく、実用上は効果的と感じた体験。','public_buyer_review_summary','https://www.lowes.com/reviews/dremel-7350-pet-rotary-tools-oscillating-tools/5001939579?offset=40'),
('dremel-7350-pet','犬種不明・静かな動作を評価',NULL,NULL,'quiet','犬の爪ケアに使い、滑らかで静かな動作を評価した体験。','public_buyer_review_summary','https://www.lowes.com/reviews/dremel-7350-pet-rotary-tools-oscillating-tools/5001939579?offset=40'),
('dremel-7350-pet','犬複数頭・他社グラインダーから変更',NULL,NULL,'multi speed','他社の犬用グラインダーより削る時間が短く、速く終わるため犬たちも嫌がりにくかった体験。','public_buyer_review_summary','https://www.lowes.com/reviews/dremel-7350-pet-rotary-tools-oscillating-tools/5001939579?offset=40'),
('dremel-7350-pet','犬種不明・低出力が不満',NULL,NULL,'power negative','ペット用として使用したが、出力が弱く充電も長く続かないと感じた否定的な体験。','public_buyer_review_summary','https://www.lowes.com/reviews/dremel-7350-pet-rotary-tools-oscillating-tools/5001939579?offset=40')
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
SELECT (SELECT COUNT(*) FROM reviews r JOIN products p ON p.id=r.product_id WHERE p.category='nail-grinder') AS nail_grinder_review_count;
