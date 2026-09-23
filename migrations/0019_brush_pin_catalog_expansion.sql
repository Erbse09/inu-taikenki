-- Phase 1: broaden brush-pin catalog and add verified public experience summaries.
-- Additive/idempotent only. Never run seed.sql in production.
PRAGMA foreign_keys = ON;

INSERT OR IGNORE INTO products(id,name,category,active) VALUES
('dog-groomer-pin-200','ドッググルーマー インターナショナル ピンブラシ No.200 大','brush-pin',1),
('dog-groomer-pin-202','ドッググルーマー インターナショナル ピンブラシ No.202 小','brush-pin',1),
('dog-groomer-pin-204','ドッググルーマー インターナショナル ピンブラシ No.204 角','brush-pin',1),
('dog-groomer-pin-500','ドッググルーマー インターナショナル ドイツピンブラシ短ピン No.500 大','brush-pin',1),
('dog-groomer-pin-501','ドッググルーマー インターナショナル ドイツピンブラシ短ピン No.501 中','brush-pin',1),
('dog-groomer-pin-504','ドッググルーマー インターナショナル ドイツピンブラシ短ピン No.504 角','brush-pin',1),
('kpro-groomer-pin-474','ケイプロ GROOMERピンブラシ No.474','brush-pin',1),
('kpro-groomer-pin-475','ケイプロ GROOMERピンブラシ No.475','brush-pin',1),
('kpro-groomer-pin-476','ケイプロ GROOMERピンブラシ No.476','brush-pin',1),
('kpro-groomer-pin-485','ケイプロ GROOMERピンブラシ No.485','brush-pin',1),
('kpro-groomer-pin-486','ケイプロ GROOMERピンブラシ No.486','brush-pin',1),
('kpro-groomer-pin-487','ケイプロ GROOMERピンブラシ No.487','brush-pin',1),
('allsystems-white-soft-s','#1 ALL SYSTEMS ピンブラシ ホワイト ソフト S','brush-pin',1),
('allsystems-ultimate-oblong-m2','#1 ALL SYSTEMS ピンブラシ アルティメットオブロン M2','brush-pin',1),
('allsystems-pin-l','#1 ALL SYSTEMS ピンブラシ L','brush-pin',1),
('allsystems-white-soft-27','#1 ALL SYSTEMS ホワイトピンブラシ ソフトタッチ 27mm','brush-pin',1),
('allsystems-white-soft-35','#1 ALL SYSTEMS ホワイトピンブラシ ソフトタッチ 35mm','brush-pin',1),
('allsystems-white-35','#1 ALL SYSTEMS ホワイトピンブラシ 35mm','brush-pin',1),
('plush-puppy-pocket-pin','Plush Puppy ポケットピンブラシ','brush-pin',1),
('plush-puppy-ultimate-pin','Plush Puppy アルティメットピンブラシ レギュラー','brush-pin',1),
('plush-puppy-ultimate-long-pin','Plush Puppy アルティメットロングピンブラシ','brush-pin',1),
('showtech-ultrapro-s','SHOW TECH Ultra-Pro ピンブラシ S #66','brush-pin',1),
('showtech-ultrapro-l','SHOW TECH Ultra-Pro ピンブラシ L','brush-pin',1),
('showtech-ultrapro-extra-long','SHOW TECH Ultra-Pro エクストラロング ピンブラシ #63','brush-pin',1),
('supreme-stainless-pin','サプリーム ピンブラシ ステンレスピン','brush-pin',1),
('sharr-2in1-pin-brush','SHARR 2in1 ペットブラシ','brush-pin',1);

-- Cross-market identity. Only verified model/variant keys and GTINs are recorded.
INSERT OR IGNORE INTO product_identifiers(namespace,identifier,product_id,evidence_url) VALUES
('manufacturer_model','dog-groomer:201','german-pin-brush-201','https://store.shopping.yahoo.co.jp/petech/a5d4a5f3a5.html'),
('manufacturer_model','dog-groomer:203','german-pin-brush-203','https://store.shopping.yahoo.co.jp/petech/a5d4a5f3a5.html'),
('manufacturer_model','dog-groomer:503','german-pin-brush-503','https://store.shopping.yahoo.co.jp/petech/a5d4a5f3a5.html'),
('gtin','4964658242013','german-pin-brush-201','https://store.shopping.yahoo.co.jp/petech/000961.html'),
('gtin','4964658242037','german-pin-brush-203','https://store.shopping.yahoo.co.jp/petech/000963.html'),
('gtin','4964658245038','german-pin-brush-503','https://store.shopping.yahoo.co.jp/petech/000967.html'),
('manufacturer_model','dog-groomer:200','dog-groomer-pin-200','https://store.shopping.yahoo.co.jp/petech/a5d4a5f3a5.html'),
('manufacturer_model','dog-groomer:202','dog-groomer-pin-202','https://store.shopping.yahoo.co.jp/petech/000962.html'),
('manufacturer_model','dog-groomer:204','dog-groomer-pin-204','https://store.shopping.yahoo.co.jp/petech/a5d4a5f3a5.html'),
('manufacturer_model','dog-groomer:500','dog-groomer-pin-500','https://store.shopping.yahoo.co.jp/petech/a5d4a5f3a5.html'),
('manufacturer_model','dog-groomer:501','dog-groomer-pin-501','https://store.shopping.yahoo.co.jp/petech/000966.html'),
('manufacturer_model','dog-groomer:504','dog-groomer-pin-504','https://store.shopping.yahoo.co.jp/petech/000968.html'),
('gtin','4964658242020','dog-groomer-pin-202','https://store.shopping.yahoo.co.jp/petech/000962.html'),
('gtin','4964658245014','dog-groomer-pin-501','https://store.shopping.yahoo.co.jp/petech/000966.html'),
('gtin','4964658245045','dog-groomer-pin-504','https://store.shopping.yahoo.co.jp/petech/000968.html'),
('manufacturer_model','kpro:groomer-474','kpro-groomer-pin-474','https://store.shopping.yahoo.co.jp/petech/a5d4a5f3a5.html'),
('manufacturer_model','kpro:groomer-475','kpro-groomer-pin-475','https://store.shopping.yahoo.co.jp/petech/a5d4a5f3a5.html'),
('manufacturer_model','kpro:groomer-476','kpro-groomer-pin-476','https://store.shopping.yahoo.co.jp/petech/000954.html'),
('manufacturer_model','kpro:groomer-485','kpro-groomer-pin-485','https://store.shopping.yahoo.co.jp/petech/a5d4a5f3a5.html'),
('manufacturer_model','kpro:groomer-486','kpro-groomer-pin-486','https://store.shopping.yahoo.co.jp/petech/a5d4a5f3a5.html'),
('manufacturer_model','kpro:groomer-487','kpro-groomer-pin-487','https://store.shopping.yahoo.co.jp/petech/a5d4a5f3a5.html'),
('gtin','4560124957094','kpro-groomer-pin-476','https://store.shopping.yahoo.co.jp/petech/000954.html'),
('manufacturer_model','allsystems:white-soft-s','allsystems-white-soft-s','https://store.shopping.yahoo.co.jp/petech/a5d4a5f3a5.html'),
('manufacturer_model','allsystems:ultimate-oblong-m2','allsystems-ultimate-oblong-m2','https://store.shopping.yahoo.co.jp/petech/000973.html'),
('manufacturer_model','allsystems:pin-l','allsystems-pin-l','https://store.shopping.yahoo.co.jp/petech/000974.html'),
('manufacturer_model','allsystems:white-soft-27','allsystems-white-soft-27','https://shopping.yahoo.co.jp/product/j/4936479007201/compare.html'),
('manufacturer_model','allsystems:white-soft-35','allsystems-white-soft-35','https://shopping.yahoo.co.jp/product/j/4936479007195/compare.html'),
('manufacturer_model','allsystems:white-35','allsystems-white-35','https://store.shopping.yahoo.co.jp/petech/a5d4a5f3a5.html'),
('gtin','4936479006426','allsystems-ultimate-oblong-m2','https://store.shopping.yahoo.co.jp/petech/000973.html'),
('gtin','4936479006402','allsystems-pin-l','https://store.shopping.yahoo.co.jp/petech/000974.html'),
('gtin','4936479007201','allsystems-white-soft-27','https://shopping.yahoo.co.jp/product/j/4936479007201/compare.html'),
('gtin','4936479007195','allsystems-white-soft-35','https://shopping.yahoo.co.jp/product/j/4936479007195/compare.html'),
('manufacturer_model','plush-puppy:pocket-pin','plush-puppy-pocket-pin','https://store.shopping.yahoo.co.jp/petech/a5d4a5f3a5.html'),
('manufacturer_model','plush-puppy:ultimate-pin-regular','plush-puppy-ultimate-pin','https://store.shopping.yahoo.co.jp/petech/a5d4a5f3a5.html'),
('manufacturer_model','plush-puppy:ultimate-long-pin','plush-puppy-ultimate-long-pin','https://store.shopping.yahoo.co.jp/petech/a5d4a5f3a5.html'),
('manufacturer_model','showtech:ultrapro-s-66','showtech-ultrapro-s','https://store.shopping.yahoo.co.jp/aecom/5420031936843.html'),
('manufacturer_model','showtech:ultrapro-l','showtech-ultrapro-l','https://item.rakuten.co.jp/freebird/tr24se016/'),
('manufacturer_model','showtech:ultrapro-extra-long-63','showtech-ultrapro-extra-long','https://store.shopping.yahoo.co.jp/freebirdcorp/tr24se017.html'),
('gtin','5420031936843','showtech-ultrapro-s','https://store.shopping.yahoo.co.jp/aecom/5420031936843.html'),
('gtin','5420031936829','showtech-ultrapro-extra-long','https://shopping.yahoo.co.jp/products/z4tnph829t'),
('manufacturer_model','sharr:sh_pet01','sharr-2in1-pin-brush','https://review.rakuten.co.jp/item/1/370173_10001542/1.1/');

-- Stable marketplace listings known at collection time.
INSERT OR IGNORE INTO product_listings(marketplace,external_id,product_id,source_url) VALUES
('yahoo','petech:000961','german-pin-brush-201','https://store.shopping.yahoo.co.jp/petech/000961.html'),
('yahoo','petech:000963','german-pin-brush-203','https://store.shopping.yahoo.co.jp/petech/000963.html'),
('yahoo','petech:000967','german-pin-brush-503','https://store.shopping.yahoo.co.jp/petech/000967.html'),
('yahoo','petech:000962','dog-groomer-pin-202','https://store.shopping.yahoo.co.jp/petech/000962.html'),
('yahoo','petech:000966','dog-groomer-pin-501','https://store.shopping.yahoo.co.jp/petech/000966.html'),
('yahoo','petech:000968','dog-groomer-pin-504','https://store.shopping.yahoo.co.jp/petech/000968.html'),
('yahoo','petech:000954','kpro-groomer-pin-476','https://store.shopping.yahoo.co.jp/petech/000954.html'),
('yahoo','petech:000973','allsystems-ultimate-oblong-m2','https://store.shopping.yahoo.co.jp/petech/000973.html'),
('yahoo','petech:000974','allsystems-pin-l','https://store.shopping.yahoo.co.jp/petech/000974.html'),
('yahoo','aecom:5420031936843','showtech-ultrapro-s','https://store.shopping.yahoo.co.jp/aecom/5420031936843.html'),
('yahoo','freebirdcorp:tr24se017','showtech-ultrapro-extra-long','https://store.shopping.yahoo.co.jp/freebirdcorp/tr24se017.html');

-- Public review text is not stored. Each row below is a concise independently written summary.
WITH new_reviews(product_id,dog_breed,dog_size,coat_type,needs,summary,source_type,source_url) AS (
VALUES
('dog-groomer-pin-202','シーズー','small','long','scared gentle legs','スリッカーでは手足を嫌がっていたシーズーが、このピンブラシでは嫌がりにくく、体のブラッシング中に眠るほど落ち着いた体験。','public_buyer_review_summary','https://store.shopping.yahoo.co.jp/petech/000962.html'),
('dog-groomer-pin-202','犬種不明・スリッカー嫌い',NULL,NULL,'scared relaxed','トリマーに勧められて使用し、スリッカーを嫌がっていた犬が、このブラシでは横になって受け入れた体験。','public_buyer_review_summary','https://store.shopping.yahoo.co.jp/petech/000962.html'),
('dog-groomer-pin-202','犬種不明・ブラッシング苦手',NULL,NULL,'scared','スリッカーでは嫌そうだった犬が、このブラシに替えると大人しくブラッシングを受けられた体験。','public_buyer_review_summary','https://store.shopping.yahoo.co.jp/petech/000962.html'),
('dog-groomer-pin-202','犬種不明・長期使用を想定',NULL,NULL,'durability handling','使い始めの使用感は良好だった一方、過去の類似ブラシでは柄の破損や接続部の緩みを経験しており、長期耐久性を気にしている体験。','public_buyer_review_summary','https://store.shopping.yahoo.co.jp/petech/000962.html'),
('dog-groomer-pin-501','犬種不明・耐久性重視',NULL,NULL,'durability','長持ちすることを期待して選び、使用開始後は問題なく良好に使えているという体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/z4gfmb1rcm'),
('dog-groomer-pin-504','超小型の長毛犬','small','long','gentle size','超小型の長毛犬に使い、サイズが扱いやすく、犬も気持ちよさそうにブラッシングを受けた体験。','public_buyer_review_summary','https://store.shopping.yahoo.co.jp/petech/000968.html'),
('dog-groomer-pin-504','犬種不明・ブラシ嫌い',NULL,NULL,'scared handling','扱いやすく、犬も嫌がりにくいためスムーズにブラッシングできた体験。','public_buyer_review_summary','https://store.shopping.yahoo.co.jp/petech/000968.html'),
('dog-groomer-pin-504','犬種不明・高価格品との比較',NULL,NULL,'gentle value','高価なピンブラシと比べても品質差を大きく感じず、犬も嫌がりにくく使いやすいと感じた体験。','public_buyer_review_summary','https://store.shopping.yahoo.co.jp/petech/000968.html'),
('kpro-groomer-pin-476','柴犬','medium','double','daily durability scared','柴犬にほぼ毎日使い、約2年11か月でクッションゴムが剥がれるまで継続使用。使い勝手がよく犬も嫌がらないため同じ商品を再購入した体験。','public_buyer_review_summary','https://store.shopping.yahoo.co.jp/petech/000954.html'),
('kpro-groomer-pin-486','ボーダーコリー','medium','long double','daily handling','ボーダーコリーのブラッシングに使い、もっと早く買えばよかったと感じるほど扱いやすかった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/216162_10005596/1.1/'),
('kpro-groomer-pin-486','犬種不明・日常ケア',NULL,NULL,'daily','日常使いのブラシとして導入。犬はまだ慣れ途中だが、良いブラシとして継続して使う予定という体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/216162_10005596/1.1/'),
('kpro-groomer-pin-486','犬種不明・コーム併用',NULL,NULL,'tangle gentle','ピンブラシの後にコームで確認すると引っかかりがほぼなく、スリッカーを使う機会が減り、毛も抜けにくく感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/216162_10005596/1.1/'),
('kpro-groomer-pin-486','犬種不明・持ちやすさ重視',NULL,NULL,'handling gentle','毛への引っかかりが少なくスムーズに梳かせ、重すぎず持ちやすいと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/216162_10005596/1.1/'),
('kpro-groomer-pin-486','ビションフリーゼ','small','curly','fluffy scared','ビションのブラッシングに使い、犬が嫌がりにくく、ふわっとした仕上がりになった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/216162_10005596/1.1/'),
('kpro-groomer-pin-486','アメリカンコッカー','medium','long','relaxed gentle','アメリカンコッカーに使い、犬が落ち着いて受け入れ、当たりもやさしく感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/216162_10005596/1.1/'),
('kpro-groomer-pin-486','犬種不明・耐久性確認中',NULL,NULL,'durability','以前のブラシではピンがクッション側へ沈み込むことがあり買い替え。使いやすさを感じつつ耐久性も確認している体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/216162_10005596/1.1/'),
('allsystems-ultimate-oblong-m2','犬種不明・肌当たり重視',NULL,NULL,'gentle handling','以前のブラシより肌への刺激がやさしく、握りやすく使いやすいと感じた体験。ブラッシング時の抜け毛量も以前より少なく感じた。','public_buyer_review_summary','https://store.shopping.yahoo.co.jp/petech/000973.html'),
('allsystems-ultimate-oblong-m2','ビションフリーゼ','small','curly','tangle','柔らかい毛質のビションでは毛がまとまって引っ張られる感覚があり、体質にはスリッカーの方が合うと感じた体験。','public_buyer_review_summary','https://store.shopping.yahoo.co.jp/petech/000973.html'),
('allsystems-ultimate-oblong-m2','ビションフリーゼ','small','curly','breakage gentle','スリッカー使用時の切れ毛が気になって変更し、必要以上に毛が抜けにくく、クッション性もやさしく感じた体験。','public_buyer_review_summary','https://store.shopping.yahoo.co.jp/petech/000973.html'),
('allsystems-ultimate-oblong-m2','毛量の多い犬',NULL,NULL,'travel handling','毛量の多い犬に使いやすく、外出時にも持ち出して使っている体験。','public_buyer_review_summary','https://store.shopping.yahoo.co.jp/petech/000973.html'),
('allsystems-ultimate-oblong-m2','犬種不明・長期使用',NULL,NULL,'long-use','長期間同じモデルを使い続けているという継続使用の体験。','public_buyer_review_summary','https://store.shopping.yahoo.co.jp/petech/000973.html'),
('allsystems-ultimate-oblong-m2','犬種不明・家庭用',NULL,NULL,'handling','家庭で使い、シンプルに扱いやすいと評価した体験。','public_buyer_review_summary','https://store.shopping.yahoo.co.jp/petech/000973.html'),
('allsystems-pin-l','ゴールデンレトリバー','large','long double','long-coat durability','ゴールデンの長い被毛に使い、丈夫な作りでしっかりブラッシングでき、長毛ケアで重宝している体験。','public_buyer_review_summary','https://store.shopping.yahoo.co.jp/petech/000974.html'),
('allsystems-pin-l','ラフコリー','large','long double','long-coat','ラフコリーの毛の長さと量に対し、ピンの柔軟性が合っていて使いやすいと感じた体験。','public_buyer_review_summary','https://store.shopping.yahoo.co.jp/petech/000974.html'),
('allsystems-pin-l','犬種不明・同シリーズ継続',NULL,NULL,'repeat','このシリーズのピンブラシを気に入り、継続して選んでいる体験。','public_buyer_review_summary','https://store.shopping.yahoo.co.jp/petech/000974.html'),
('allsystems-pin-l','犬種不明・ピンブラシ固定',NULL,NULL,'daily','ピンブラシはこのモデルだけを使い続けているという定着した使用体験。','public_buyer_review_summary','https://store.shopping.yahoo.co.jp/petech/000974.html'),
('allsystems-white-soft-35','大型の長毛ダブルコート犬','large','long double','long-coat gentle','大型の長毛ダブルコート犬に35mmを使い、やさしい力でも地肌まで届き、毛並みを整えやすいと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/product/j/4936479007195/compare.html'),
('allsystems-white-soft-35','ポメラニアン','small','long double','relaxed','犬自身より大きく見えるブラシだったが、使用すると気持ちよさそうにして落ち着いて受け入れた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/product/j/4936479007195/compare.html'),
('allsystems-white-soft-35','トイプードル','small','long curly','long-coat','毛量が多く長めのトイプードルでもブラッシングしやすかった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/product/j/4936479007195/compare.html'),
('allsystems-white-soft-35','犬種不明・ブラッシング好き',NULL,NULL,'relaxed handling','とても扱いやすく、犬も気持ちよさそうにブラッシングを受けた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/product/j/4936479007195/compare.html'),
('allsystems-white-soft-35','犬種不明・使いやすさ重視',NULL,NULL,'handling','日常ケアで非常に使いやすいと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/product/j/4936479007195/compare.html'),
('allsystems-white-soft-27','ビションフリーゼ','small','curly','gentle','ビションに使い、以前のプラスチック製ブラシから替えると使い心地の違いを大きく感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/product/j/4936479007201/compare.html'),
('showtech-ultrapro-s','ミニチュアダックス・5kg','small','long','gentle shedding','5kgのロングコートのダックスに使い、スリッカーよりやさしく梳かせ、犬も気持ちよさそうで抜け毛もよく取れた体験。','public_buyer_review_summary','https://item.rakuten.co.jp/freebird/tr24se019/'),
('showtech-ultrapro-s','犬種不明・小型ブラシ希望',NULL,NULL,'handling','普段使っているシリーズの小さいサイズを誤って選んだが、手になじみやすく扱いやすいと感じた体験。','public_buyer_review_summary','https://item.rakuten.co.jp/freebird/tr24se019/'),
('showtech-ultrapro-s','犬種不明・耐久性注意',NULL,NULL,'durability','使用開始から約10日でピンが1本外れたため、使用前後にピン抜けを確認するようにしている体験。その他の使い心地には問題を感じていない。','public_buyer_review_summary','https://item.rakuten.co.jp/freebird/tr24se019/'),
('showtech-ultrapro-s','ビションフリーゼ','small','curly','scared fluffy','スリッカーを嫌うビションがピンブラシなら受け入れやすく、毎日のケアでふわっと仕上げやすかった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/z4tnph82ab'),
('showtech-ultrapro-s','長毛犬','medium','long','handling tangle','軽くて扱いやすく、長毛でも引っかかりが少ないと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/z4tnph82ab'),
('showtech-ultrapro-s','犬種不明・スリッカー嫌い',NULL,NULL,'scared gentle speed','スリッカーより嫌がりにくく、短時間のブラッシングで使いやすいと感じた体験。丸みのあるピン先もやさしく感じた。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/z4tnph82ab'),
('showtech-ultrapro-s','犬種不明・仕上げ重視',NULL,NULL,'fluffy relaxed','スリッカーと併用して仕上げに使い、犬が落ち着いて受け入れ、ふわっと整えやすかった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/z4tnph82ab'),
('showtech-ultrapro-extra-long','オールドイングリッシュシープドッグ','large','long double','long-coat fluffy','長毛のオールドイングリッシュシープドッグに使い、ピンの長さと硬さが合い、力を入れなくても梳かせてふわっと仕上がった体験。','public_buyer_review_summary','https://store.shopping.yahoo.co.jp/freebirdcorp/tr24se017.html'),
('showtech-ultrapro-extra-long','犬種不明・切れ毛対策',NULL,'long','breakage handling','スリッカーより切れ毛が少なく感じた一方、ロングピンのヘッドが重く、長時間では手首への負担を感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/z4tnph829t/review/'),
('showtech-ultrapro-extra-long','ボーダーコリー','medium','long double','undercoat','ボーダーコリーに使い、アンダーコートがよく取れて扱いやすいと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/z4tnph829t/review/'),
('showtech-ultrapro-extra-long','ビションフリーゼ','small','curly','fluffy face','ビションの日常ケアで頭のボリュームを出すのには便利だが、ボディにはピンが長すぎると感じた体験。','public_buyer_review_summary','https://store.shopping.yahoo.co.jp/freebirdcorp/tr24se017.html'),
('showtech-ultrapro-extra-long','長毛犬','medium','long','shedding tangle','換毛期の長毛犬に使い、浮いた冬毛やもつれを取りやすかった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/z4tnph829t/review/'),
('showtech-ultrapro-extra-long','ボーダーコリー','medium','long curly','handling','ウェーブやカールのあるボーダーコリーの被毛でも梳かしやすかった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/z4tnph829t/review/'),
('showtech-ultrapro-extra-long','シーズー','small','long','long-coat','ロングコートのシーズーに使い、長いピンが被毛へ入りやすく扱いやすかった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/z4tnph829t/review/'),
('sharr-2in1-pin-brush','犬種不明・ブラシ嫌い',NULL,NULL,'scared gentle','普段はブラシを嫌がる犬が、このブラシでは気持ちよさそうに受け入れ、自分からお尻を向けるほど反応が変わった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/370173_10001542/1.1/'),
('sharr-2in1-pin-brush','ダブルコート犬',NULL,'double','tangle','ダブルコートの犬ではピン側が少し引っかかりやすく、短い部分では獣毛側の方がスムーズに使えた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/370173_10001542/1.1/'),
('sharr-2in1-pin-brush','シェルティ','medium','long double','fluffy','長毛で毛量の多いシェルティに使い始めたが、期待したほど大きな仕上がり変化はまだ感じず、水洗いできない点も手入れ面で気になった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/370173_10001542/1.1/'),
('sharr-2in1-pin-brush','マルプー','small','long curly','scared fluffy','マルプーがブラッシングを嫌がりにくくなり、仕上がりもふわふわになった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/370173_10001542/1.1/')
)
INSERT INTO reviews(product_id,dog_breed,dog_size,coat_type,needs,summary,source_type,source_url)
SELECT n.product_id,n.dog_breed,n.dog_size,n.coat_type,n.needs,n.summary,n.source_type,n.source_url
FROM new_reviews n
WHERE NOT EXISTS (
  SELECT 1 FROM reviews r
  WHERE r.product_id=n.product_id
    AND r.summary=n.summary
);

-- Verification. Phase 1 target from the current 3-product/50-review baseline:
-- 29 brush-pin products, 100 brush-pin reviews, while all other categories remain unchanged.
SELECT
  COUNT(*) AS brush_pin_product_count,
  SUM(CASE WHEN EXISTS (SELECT 1 FROM reviews r WHERE r.product_id=p.id) THEN 1 ELSE 0 END) AS reviewed_product_count
FROM products p
WHERE p.category='brush-pin' AND p.active=1;

SELECT COUNT(*) AS brush_pin_review_count
FROM reviews r JOIN products p ON p.id=r.product_id
WHERE p.category='brush-pin' AND p.active=1;
