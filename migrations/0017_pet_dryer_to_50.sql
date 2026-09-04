PRAGMA foreign_keys = ON;

WITH new_reviews(product_id,dog_breed,dog_size,coat_type,needs,summary,source_type,source_url) AS (
VALUES
('petaboo-l400','ラブラドールレトリバー','large','short','frequent-shampoo skin-sensitive scared speed','1〜2週間ごとのシャンプーが必要なラブラドールで使用。人用ドライヤーより根元まで早く乾き、生乾きが減った。大きな音で興奮しやすいため風量は最大75程度に抑えても十分時短できた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/405945_10000167/737f-iaveq-9l4hk9_1_2885454600/'),
('petaboo-l400','パーソンラッセルテリア','small','short','frequent-shampoo scared cool-air speed','頻繁にシャワーする犬で使用。水分を吹き飛ばす力で根元まで早く乾いた一方、70以上の風量では高い音を嫌がった。風が冷たく感じる季節は人用ドライヤーの温風を併用した体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/405945_10000167'),
('petaboo-l400','プードル・約3kg','small','curly','grooming face speed','ペットサロンで約3kgのプードルに使用。顔は弱い風量、全身は強風に切り替え、全身を約17分で乾かせた。部位ごとに細かく風量を変えられる点も使いやすかった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/405945_10000167'),
('petaboo-l400','雑種・生後3か月','medium',NULL,'puppy scared training finish','生後3か月の中型雑種で使用。人用ドライヤーでは音に驚いて吠えたり噛みついたりしていたが、風量30前後では落ち着いて乾かせ、仕上がりもふわふわになった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/405945_10000167'),
('petaboo-l400','大型犬・大きな音に興奮しやすい','large',NULL,'scared acclimation speed','大きな音で興奮しやすい大型犬を自宅で洗うために導入。初回は落ち着かなかったが徐々に慣れ、風量を上げれば乾燥も早かった。電源コードはやや短く延長コードが欲しいと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/405945_10000167'),
('petaboo-l400','長毛種・多頭飼い',NULL,'long','multi-dog tangling speed','長毛種を複数飼う家庭で使用。半分程度までの風量でも短時間で乾かしやすく、強くしすぎると毛が絡んでブラシを通しにくいと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/405945_10000167'),
('petaboo-l400','大型犬','large',NULL,'speed restless hose-length','大型犬を家庭用ドライヤー2台で乾かしていた家庭で使用。L400一台でも十分な風量で乾燥時間が短くなった一方、乾燥中に動き回る犬にはホースがもう少し長いと扱いやすいと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/405945_10000167'),
('dogone-quick-dry','ビションフリーゼ','small','curly','grooming finish speed','ビションフリーゼの自宅ケアで使用。根元から毛を伸ばしやすくサロンに近い仕上がりになり、乾かす場所に合わせて風量と温度を変えられる点を評価した体験。','public_buyer_review_summary','https://review.rakuten.co.jp/review/item/1/282253_10008403/1.1/'),
('dogone-quick-dry','毛量の多いプードル',NULL,'curly','speed scared finish','毛量の多いプードルで使用。ノズルを近づけると音に驚いたため、全体の約8割をブロワーで乾かし、最後は人用ドライヤーで毛を伸ばして仕上げる使い方で時短できた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/295394_10007730/1.1/'),
('dogone-quick-dry','ビション・多頭飼い','small','curly','multi-dog handsfree speed','ビションを複数飼う家庭で使用。両手が空くためスリッカーを使いながら風を当てる位置を変えやすく、以前の固定した人用ドライヤーより乾燥時間を短縮できた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/295394_10007730/1.1/'),
('dogone-quick-dry','小型犬','small',NULL,'small-dog noise airflow','小型犬を扱う環境で使用。業務用ほど音が大きくなく、風量を細かく調整できるので小型犬にも問題なく使えたという体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/295394_10007730/1.1/'),
('dogone-quick-dry',NULL,NULL,NULL,'speed','普通のドライヤーでは約30分かかっていた犬の乾燥が約10分になったという体験。組み立ても難しくなく、初回から時短効果を感じた。','public_buyer_review_summary','https://review.rakuten.co.jp/review/item/1/295394_10007730/1.1/'),
('dogone-quick-dry',NULL,NULL,NULL,'handsfree speed finish','家庭用ドライヤーでは時間がかかっていた犬に使用。両手を使いながら風を当てられ、犬も嫌がらず、乾燥時間が短くなって仕上がりもふわふわになった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/282253_10008403'),
('dogone-quick-dry',NULL,NULL,NULL,'scared face speed','乾燥時間は短くなったが音は大きく感じ、顔まわりは強い風を避けて別の人用ドライヤーで仕上げた体験。より細かく弱風まで調整できると使いやすいと感じた。','public_buyer_review_summary','https://review.rakuten.co.jp/review/item/1/282253_10008403/1.1/'),
('morisawa','サモエド','large','long double','speed professional noise','元トリマーがサモエドの乾燥に使用。高価格の業務用ブロワーに近い風量と扱いやすさがあり、業務用としては音も小さめと感じた一方、コードはもう少し長いと良いと評価した体験。','public_buyer_review_summary','https://review.rakuten.co.jp/review/item/1/400014_10000002/1.1/'),
('morisawa','ボーダーコリー','medium','long double','speed','ダブルコートで長毛のボーダーコリーに使用。強い風量で毛の奥まで乾かしやすく、十分なパワーを感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/review/item/1/400014_10000002/1.1/'),
('morisawa','ラブラドールレトリバー','large','short','speed scared','ラブラドールを家庭用ドライヤーで乾かしていた家庭で使用。乾き残しが減って時間も短くなったが、ドライヤー音には少し怖がる様子があり、その点は以前と同じだった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/review/item/1/400014_10000002/1.1/'),
('morisawa','大型犬・皮膚トラブルで頻繁にシャンプー','large',NULL,'frequent-shampoo skin-sensitive speed finish','皮膚トラブルで頻繁にシャンプーする大型犬に使用。普通のドライヤーより乾燥時間が短くなり、ふわふわに仕上がった。本体を置いたままホースだけ動かせる点も作業しやすかった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/review/item/1/400014_10000002/1.1/'),
('morisawa','中型犬・約10kg','medium',NULL,'scared gentle-heat acclimation','約10kgのかなり怖がりな中型犬に使用。人用ドライヤーより温度を気にせず当てやすかった一方、音を苦手として何度も逃げたため、弱風から少しずつ慣らす必要を感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/review/item/1/400014_10000002/1.1/'),
('morisawa','オーストラリアン・ラブラドゥードル','medium','long curly','speed','ミニチュアサイズのオーストラリアン・ラブラドゥードルで使用。人用ドライヤーでは手脚だけで1時間以上かかっていたのが、10分少々まで短縮した体験。','public_buyer_review_summary','https://review.rakuten.co.jp/review/item/1/400014_10000002'),
('homerunpet-drybo-pro',NULL,NULL,NULL,'handsfree speed stress walk','愛犬の健康を考えて導入し、シャンプー後の乾燥が30分かからず、強い直接風よりストレスが少なそうに感じた体験。散歩後の濡れを乾かす用途にも使っている。','public_buyer_review_summary','https://review.rakuten.co.jp/review/review/item/1/397230_10000156/755d-i9awf-hprlas_1_3686365979/'),
('homerunpet-drybo-pro','皮膚が弱い犬',NULL,'short long','skin-sensitive gentle-heat speed','皮膚が弱く熱いドライヤーを避けたい犬に使用。体は短毛で耳と尻尾は長めで、タオルドライ後約10分でかなり乾いた。座るとお尻と尻尾は乾きにくい一方、耳は早く乾いた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/397230_10000156/1.1/'),
('homerunpet-drybo-pro','フレンチブルドッグ','small','short','scared acclimation brachycephalic','ドライヤー嫌いのフレンチブルドッグに使用。初回は横窓から撫でて慣らし、3回目以降は落ち着いて入れるようになった。手足や腹側は約20分で乾くが背中は湿りやすく、様子を見ながら使った体験。','public_buyer_review_summary','https://review.rakuten.co.jp/review/item/1/397230_10000156/1.1/'),
('homerunpet-drybo-pro',NULL,NULL,NULL,'handsfree scared walk','直接ドライヤーを当てるより音や風を気にしにくそうで、乾かしている間に両手が空く点が助かった体験。散歩後など少し濡れた時にも使いやすいと感じた。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/397230_10000156/1.1/'),
('homerunpet-drybo-pro',NULL,NULL,NULL,'finish grooming handsfree','自宅シャンプー後に使うと毛がふわっと仕上がり、乾燥中にブラッシングもできて、お家シャンプーの負担が下がったと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/397230_10000156/1.1/')
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
  (SELECT COUNT(*) FROM reviews r JOIN products p ON p.id=r.product_id WHERE p.category='pet-dryer') AS pet_dryer_review_count;
