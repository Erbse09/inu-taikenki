PRAGMA foreign_keys = ON;

DELETE FROM reviews;
DELETE FROM products;

INSERT INTO products (id, name, category, active) VALUES ('petaboo-l400', 'Petaboo L400', 'pet-dryer', 1);
INSERT INTO products (id, name, category, active) VALUES ('dogone-quick-dry', 'DogOne Quick Dry', 'pet-dryer', 1);
INSERT INTO products (id, name, category, active) VALUES ('morisawa', 'MORISAWA', 'pet-dryer', 1);
INSERT INTO products (id, name, category, active) VALUES ('homerunpet-drybo-pro', 'HomerunPET Drybo Pro', 'pet-dryer', 1);
INSERT INTO products (id, name, category, active) VALUES ('homerunpet-pd10', 'HomerunPET PD10', 'pet-dryer', 1);

INSERT INTO reviews (product_id, dog_breed, dog_size, coat_type, needs, summary, source_type, source_url) VALUES ('petaboo-l400', 'ゴールデンドゥードル', 'large', 'long', 'speed', '何倍も早く乾いたという体験。以前は人用ドライヤー。', 'existing_article_summary', '/pet-dryer.html');
INSERT INTO reviews (product_id, dog_breed, dog_size, coat_type, needs, summary, source_type, source_url) VALUES ('petaboo-l400', 'ボーダーコリー', 'medium', 'double', 'speed', '約60分から約15分まで短縮した体験。', 'existing_article_summary', '/pet-dryer.html');
INSERT INTO reviews (product_id, dog_breed, dog_size, coat_type, needs, summary, source_type, source_url) VALUES ('petaboo-l400', 'ゴールデン', 'large', 'long', 'speed puppy', '約90分から30〜60分以内。パピーは動き回った。', 'existing_article_summary', '/pet-dryer.html');
INSERT INTO reviews (product_id, dog_breed, dog_size, coat_type, needs, summary, source_type, source_url) VALUES ('petaboo-l400', 'コーギー', 'medium', 'double', 'scared speed', '高い音を気にしたが徐々に慣れた。以前は60分以上。', 'existing_article_summary', '/pet-dryer.html');
INSERT INTO reviews (product_id, dog_breed, dog_size, coat_type, needs, summary, source_type, source_url) VALUES ('petaboo-l400', 'サモエド 6か月', 'large', 'double long', 'puppy speed', '約50分。毛絡みと長時間時のホース熱が気になった。', 'existing_article_summary', '/pet-dryer.html');
INSERT INTO reviews (product_id, dog_breed, dog_size, coat_type, needs, summary, source_type, source_url) VALUES ('petaboo-l400', 'キャバリア', 'small', 'long', NULL, '人用は音と熱の割に乾きにくかった。ホースが短く、両手は空かない点が気になった。', 'existing_article_summary', '/pet-dryer.html');
INSERT INTO reviews (product_id, dog_breed, dog_size, coat_type, needs, summary, source_type, source_url) VALUES ('petaboo-l400', 'ゴールデンアイリッシュ 成犬＋6か月', 'large', 'long', 'puppy scared', '成犬は問題なく使用。子犬は逃げ回り、慣らしが必要だった。', 'existing_article_summary', '/pet-dryer.html');
INSERT INTO reviews (product_id, dog_breed, dog_size, coat_type, needs, summary, source_type, source_url) VALUES ('dogone-quick-dry', '秋田犬', 'large', 'double', 'speed', '中まで風が届き、乾燥時間が短縮した体験。', 'existing_article_summary', '/pet-dryer.html');
INSERT INTO reviews (product_id, dog_breed, dog_size, coat_type, needs, summary, source_type, source_url) VALUES ('dogone-quick-dry', '柴犬 5kg', 'small', 'double', NULL, '初の家シャンプーで十分な風量。ホースの熱とフィルターに毛が付く点が気になった。', 'existing_article_summary', '/pet-dryer.html');
INSERT INTO reviews (product_id, dog_breed, dog_size, coat_type, needs, summary, source_type, source_url) VALUES ('dogone-quick-dry', 'コーギー', 'medium', 'double', 'scared speed', '中間風量で約20分。最初は音に驚き嫌がった。', 'existing_article_summary', '/pet-dryer.html');
INSERT INTO reviews (product_id, dog_breed, dog_size, coat_type, needs, summary, source_type, source_url) VALUES ('dogone-quick-dry', 'サモエド', 'large', 'double long', 'speed', '乾きが早く、強風でも気持ちよさそうだったという体験。', 'existing_article_summary', '/pet-dryer.html');
INSERT INTO reviews (product_id, dog_breed, dog_size, coat_type, needs, summary, source_type, source_url) VALUES ('dogone-quick-dry', '元野犬の雑種・音敏感', 'medium', NULL, 'scared speed', '湿り気なく時短。最初は震えたが後半は落ち着いた。', 'existing_article_summary', '/pet-dryer.html');
INSERT INTO reviews (product_id, dog_breed, dog_size, coat_type, needs, summary, source_type, source_url) VALUES ('dogone-quick-dry', 'ラブラドール', 'large', 'short', 'speed', '2人・2台で30〜40分だったところ、約半分の時間になった体験。', 'existing_article_summary', '/pet-dryer.html');
INSERT INTO reviews (product_id, dog_breed, dog_size, coat_type, needs, summary, source_type, source_url) VALUES ('dogone-quick-dry', '犬種不明・ビビり', NULL, NULL, 'scared speed', '乾燥は時短。顔まわりは怖がり、人用ドライヤーで仕上げ。', 'existing_article_summary', '/pet-dryer.html');
INSERT INTO reviews (product_id, dog_breed, dog_size, coat_type, needs, summary, source_type, source_url) VALUES ('morisawa', 'ポメラニアン', 'small', 'long', 'speed', '人用2台で約30分から、10分でほぼ乾燥・15分で仕上げ。', 'existing_article_summary', '/pet-dryer.html');
INSERT INTO reviews (product_id, dog_breed, dog_size, coat_type, needs, summary, source_type, source_url) VALUES ('morisawa', 'ゴールデン', 'large', 'long', 'speed', '数十分〜60分超から約20分になった体験。', 'existing_article_summary', '/pet-dryer.html');
INSERT INTO reviews (product_id, dog_breed, dog_size, coat_type, needs, summary, source_type, source_url) VALUES ('morisawa', '14kg 雑種', 'medium', NULL, 'scared', '中風量でも水滴が飛ぶ。物音で驚き、その後は使用困難。', 'existing_article_summary', '/pet-dryer.html');
INSERT INTO reviews (product_id, dog_breed, dog_size, coat_type, needs, summary, source_type, source_url) VALUES ('morisawa', 'ダックス 2頭', 'small', 'long', 'speed', '1頭目20分、2頭目15分。肉球が乾かしやすかった。', 'existing_article_summary', '/pet-dryer.html');
INSERT INTO reviews (product_id, dog_breed, dog_size, coat_type, needs, summary, source_type, source_url) VALUES ('morisawa', 'コーギー', 'medium', 'double', 'speed', '人用ドライヤーから約15分。心地よさそうだった。', 'existing_article_summary', '/pet-dryer.html');
INSERT INTO reviews (product_id, dog_breed, dog_size, coat_type, needs, summary, source_type, source_url) VALUES ('morisawa', 'ゴールデン×ラブ', 'large', 'short long', 'scared speed', '約25分。音と風に驚き逃げようとし、毛が舞った。', 'existing_article_summary', '/pet-dryer.html');
INSERT INTO reviews (product_id, dog_breed, dog_size, coat_type, needs, summary, source_type, source_url) VALUES ('morisawa', 'シェルティ 2頭', 'medium', 'double long', 'scared', 'フワフワ感が向上。弱でも強く、耳を嫌がった。', 'existing_article_summary', '/pet-dryer.html');
INSERT INTO reviews (product_id, dog_breed, dog_size, coat_type, needs, summary, source_type, source_url) VALUES ('homerunpet-drybo-pro', 'ポメラニアン', 'small', 'long', 'handsfree', 'おやつ誘導ですんなり入れた。静かだったという体感。', 'existing_article_summary', '/pet-dryer.html');
INSERT INTO reviews (product_id, dog_breed, dog_size, coat_type, needs, summary, source_type, source_url) VALUES ('homerunpet-drybo-pro', 'ポメラニアン', 'small', 'long', 'handsfree', '怖がらず使用し、足元から乾いたという体験。', 'existing_article_summary', '/pet-dryer.html');
INSERT INTO reviews (product_id, dog_breed, dog_size, coat_type, needs, summary, source_type, source_url) VALUES ('homerunpet-drybo-pro', 'ビションフリーゼ 6.8kg', 'small', 'long', 'handsfree', '使用できた体験。一回り大きくてもよかったという感想。', 'existing_article_summary', '/pet-dryer.html');
INSERT INTO reviews (product_id, dog_breed, dog_size, coat_type, needs, summary, source_type, source_url) VALUES ('homerunpet-pd10', '犬種不明の子犬', NULL, NULL, 'puppy handsfree', '公式購入体験で快適そうだった旨。犬種・体重・乾燥時間は不明。', 'existing_article_summary', '/pet-dryer.html');


-- Other article data for Cloudflare D1
CREATE INDEX IF NOT EXISTS idx_products_category_active
ON products(category, active);

INSERT OR IGNORE INTO products (id, name, category, active) VALUES ('karikari-machine-v2c-plus', 'カリカリマシーン V2C Plus', 'auto-feeder', 1);
INSERT OR IGNORE INTO products (id, name, category, active) VALUES ('petkit-yumshare-solo2-p572', 'PETKIT YUMSHARE SOLO 2（P572）', 'auto-feeder', 1);
INSERT OR IGNORE INTO products (id, name, category, active) VALUES ('petlibro-granary', 'PETLIBRO 5L / Granary系', 'auto-feeder', 1);
INSERT OR IGNORE INTO products (id, name, category, active) VALUES ('moizze-pet001', 'Moizze PET001 4L カメラ付き', 'auto-feeder', 1);
INSERT OR IGNORE INTO products (id, name, category, active) VALUES ('wtw-ipet2971', 'WTW-IPET2971', 'auto-feeder', 1);
INSERT OR IGNORE INTO products (id, name, category, active) VALUES ('take-one-p2pro', 'Take-One P2Pro', 'auto-feeder', 1);
INSERT OR IGNORE INTO products (id, name, category, active) VALUES ('latuna-4l', 'Latuna 4L タイマー式', 'auto-feeder', 1);
INSERT OR IGNORE INTO products (id, name, category, active) VALUES ('elecom-pet-af04', 'ELECOM PET-AF04系', 'auto-feeder', 1);
INSERT OR IGNORE INTO products (id, name, category, active) VALUES ('petlabo-auto-feeder', 'ペットラボ館 自動給餌器', 'auto-feeder', 1);
INSERT OR IGNORE INTO products (id, name, category, active) VALUES ('mofmore-two-food', 'MOFMORE 2フード対応タイプ', 'auto-feeder', 1);
INSERT OR IGNORE INTO products (id, name, category, active) VALUES ('showtech-slicker', 'SHOWTECH スリッカー（ソフト／レギュラー／ハード）', 'brush-slicker', 1);
INSERT OR IGNORE INTO products (id, name, category, active) VALUES ('lawrence-soft-slicker', 'ローレンス ソフトスリッカー', 'brush-slicker', 1);
INSERT OR IGNORE INTO products (id, name, category, active) VALUES ('okano-musashi-soft', '岡野製作所 スリッカー 武蔵 ソフト', 'brush-slicker', 1);
INSERT OR IGNORE INTO products (id, name, category, active) VALUES ('showtech-duopin-slicker', 'SHOWTECH ユニバーサル デュオピン', 'brush-slicker', 1);
INSERT OR IGNORE INTO products (id, name, category, active) VALUES ('furminator-deshedding', 'FURminator deShedding Tool', 'brush-undercoat', 1);
INSERT OR IGNORE INTO products (id, name, category, active) VALUES ('showtech-duopin-undercoat', 'SHOWTECH ユニバーサル デュオピン', 'brush-undercoat', 1);
INSERT OR IGNORE INTO products (id, name, category, active) VALUES ('undercoat-rake-generic', 'アンダーコートレーキ／抜け毛コーム系', 'brush-undercoat', 1);
INSERT OR IGNORE INTO products (id, name, category, active) VALUES ('okano-double-comb', '岡野製作所 高級両目金櫛', 'brush-comb', 1);
INSERT OR IGNORE INTO products (id, name, category, active) VALUES ('showtech-as-comb', 'SHOWTECH グレイハウンド ASコーム', 'brush-comb', 1);
INSERT OR IGNORE INTO products (id, name, category, active) VALUES ('showtech-greyhound-19cm', 'SHOWTECH NEW GREYHOUND 19cm', 'brush-comb', 1);
INSERT OR IGNORE INTO products (id, name, category, active) VALUES ('german-pin-brush-201', '東京ペット商事 ドイツピンブラシ 201', 'brush-pin', 1);
INSERT OR IGNORE INTO products (id, name, category, active) VALUES ('german-pin-brush-203', 'ドイツピンブラシ 203', 'brush-pin', 1);
INSERT OR IGNORE INTO products (id, name, category, active) VALUES ('german-pin-brush-503', 'ドイツピンブラシ 503', 'brush-pin', 1);

INSERT INTO reviews (product_id, dog_breed, dog_size, coat_type, needs, summary, source_type, source_url)
SELECT 'take-one-p2pro', 'ビーグル：皿を持ち逃げ、本体にもいたずら', 'medium', NULL, 'ビーグル 成犬 やんちゃ 食いしん坊 留守番 カメラ いたずら対策', 'やんちゃで、皿を運び出したり本体にフードが入っていることを理解して荒らしたため、給餌器としてではなく見守りカメラ中心になったという体験。食いしん坊＋いたずらタイプでは固定性が重要。', 'existing_article_summary', '/auto-feeder.html'
WHERE NOT EXISTS (
  SELECT 1 FROM reviews
  WHERE product_id = 'take-one-p2pro'
    AND COALESCE(dog_breed, '') = COALESCE('ビーグル：皿を持ち逃げ、本体にもいたずら', '')
    AND summary = 'やんちゃで、皿を運び出したり本体にフードが入っていることを理解して荒らしたため、給餌器としてではなく見守りカメラ中心になったという体験。食いしん坊＋いたずらタイプでは固定性が重要。'
);
INSERT INTO reviews (product_id, dog_breed, dog_size, coat_type, needs, summary, source_type, source_url)
SELECT 'wtw-ipet2971', '14歳：数時間おきの少量給餌に', NULL, NULL, 'シニア 少量 留守番 カメラ', '日中に家を空ける間も数時間おきに少量を与える目的で導入。カメラ性能も安心材料になったという具体例。', 'existing_article_summary', '/auto-feeder.html'
WHERE NOT EXISTS (
  SELECT 1 FROM reviews
  WHERE product_id = 'wtw-ipet2971'
    AND COALESCE(dog_breed, '') = COALESCE('14歳：数時間おきの少量給餌に', '')
    AND summary = '日中に家を空ける間も数時間おきに少量を与える目的で導入。カメラ性能も安心材料になったという具体例。'
);
INSERT INTO reviews (product_id, dog_breed, dog_size, coat_type, needs, summary, source_type, source_url)
SELECT 'petlibro-granary', '4歳コーギー：何年も毎日利用', 'medium', NULL, 'コーギー 成犬 食いしん坊 留守番', '決まった量を1日2回与える用途で長期使用。録音した「ごはんだよ」の声で走ってくる一方、投稿者が実測した1ポーション量はメーカー表記と差があったため、初回計量の必要性が分かる例。', 'existing_article_summary', '/auto-feeder.html'
WHERE NOT EXISTS (
  SELECT 1 FROM reviews
  WHERE product_id = 'petlibro-granary'
    AND COALESCE(dog_breed, '') = COALESCE('4歳コーギー：何年も毎日利用', '')
    AND summary = '決まった量を1日2回与える用途で長期使用。録音した「ごはんだよ」の声で走ってくる一方、投稿者が実測した1ポーション量はメーカー表記と差があったため、初回計量の必要性が分かる例。'
);
INSERT INTO reviews (product_id, dog_breed, dog_size, coat_type, needs, summary, source_type, source_url)
SELECT 'karikari-machine-v2c-plus', 'ビビりな子：慣れるまで約1週間', NULL, NULL, '怖がり 慎重 静音', '同居する好奇心旺盛な子は初回から食べたのに対し、ビビりな子は慣れるまで約1週間。性格差がそのまま導入期間の差になった例。', 'existing_article_summary', '/auto-feeder.html'
WHERE NOT EXISTS (
  SELECT 1 FROM reviews
  WHERE product_id = 'karikari-machine-v2c-plus'
    AND COALESCE(dog_breed, '') = COALESCE('ビビりな子：慣れるまで約1週間', '')
    AND summary = '同居する好奇心旺盛な子は初回から食べたのに対し、ビビりな子は慣れるまで約1週間。性格差がそのまま導入期間の差になった例。'
);
INSERT INTO reviews (product_id, dog_breed, dog_size, coat_type, needs, summary, source_type, source_url)
SELECT 'moizze-pet001', '給餌時のステンレス音に最初はびっくり', NULL, NULL, '怖がり 静音 留守番 カメラ', 'フードが皿へ落ちる音に最初は警戒したものの、慣れると食べられるようになった体験。音に敏感な犬では、留守番本番の前に家にいる状態で練習したい。', 'existing_article_summary', '/auto-feeder.html'
WHERE NOT EXISTS (
  SELECT 1 FROM reviews
  WHERE product_id = 'moizze-pet001'
    AND COALESCE(dog_breed, '') = COALESCE('給餌時のステンレス音に最初はびっくり', '')
    AND summary = 'フードが皿へ落ちる音に最初は警戒したものの、慣れると食べられるようになった体験。音に敏感な犬では、留守番本番の前に家にいる状態で練習したい。'
);
INSERT INTO reviews (product_id, dog_breed, dog_size, coat_type, needs, summary, source_type, source_url)
SELECT 'moizze-pet001', '2台を電池運用：時間差で片方が横取り', NULL, NULL, '多頭 留守番 少量', '2匹に別々のフードを与える家庭で、電池運用時に2台の給餌タイミングがずれ、先に食べた子がもう一方のフードを横取りしたという例。多頭・療法食では時刻精度が重要。', 'existing_article_summary', '/auto-feeder.html'
WHERE NOT EXISTS (
  SELECT 1 FROM reviews
  WHERE product_id = 'moizze-pet001'
    AND COALESCE(dog_breed, '') = COALESCE('2台を電池運用：時間差で片方が横取り', '')
    AND summary = '2匹に別々のフードを与える家庭で、電池運用時に2台の給餌タイミングがずれ、先に食べた子がもう一方のフードを横取りしたという例。多頭・療法食では時刻精度が重要。'
);
INSERT INTO reviews (product_id, dog_breed, dog_size, coat_type, needs, summary, source_type, source_url)
SELECT 'petlibro-granary', '大型犬では本体の安定性に注意', 'large', NULL, 'いたずら対策', '実機比較では、PETLIBROの一部モデルは大きな犬の興奮に対して十分頑丈ではないと評価。大型犬では容量だけでなく、倒されにくさ・ボタンに触れにくい構造も優先したい。', 'existing_article_summary', '/auto-feeder.html'
WHERE NOT EXISTS (
  SELECT 1 FROM reviews
  WHERE product_id = 'petlibro-granary'
    AND COALESCE(dog_breed, '') = COALESCE('大型犬では本体の安定性に注意', '')
    AND summary = '実機比較では、PETLIBROの一部モデルは大きな犬の興奮に対して十分頑丈ではないと評価。大型犬では容量だけでなく、倒されにくさ・ボタンに触れにくい構造も優先したい。'
);
INSERT INTO reviews (product_id, dog_breed, dog_size, coat_type, needs, summary, source_type, source_url)
SELECT 'showtech-slicker', 'シェルティの子犬', 'medium', 'long double', '抜け毛 ブラシ嫌い', '力を入れずに梳かせ、アンダーコートが取れ、子犬も嫌がらず気持ちよさそうだったという体験。', 'existing_article_summary', '/brush-slicker.html'
WHERE NOT EXISTS (
  SELECT 1 FROM reviews
  WHERE product_id = 'showtech-slicker'
    AND COALESCE(dog_breed, '') = COALESCE('シェルティの子犬', '')
    AND summary = '力を入れずに梳かせ、アンダーコートが取れ、子犬も嫌がらず気持ちよさそうだったという体験。'
);
INSERT INTO reviews (product_id, dog_breed, dog_size, coat_type, needs, summary, source_type, source_url)
SELECT 'showtech-slicker', 'ポメラニアン2匹', 'small', 'long double', '毛玉・もつれ ブラシ嫌い', '以前のブラシより嫌がりにくく、アンダーコートの絡まりをほぐしやすかった例。', 'existing_article_summary', '/brush-slicker.html'
WHERE NOT EXISTS (
  SELECT 1 FROM reviews
  WHERE product_id = 'showtech-slicker'
    AND COALESCE(dog_breed, '') = COALESCE('ポメラニアン2匹', '')
    AND summary = '以前のブラシより嫌がりにくく、アンダーコートの絡まりをほぐしやすかった例。'
);
INSERT INTO reviews (product_id, dog_breed, dog_size, coat_type, needs, summary, source_type, source_url)
SELECT 'showtech-slicker', 'オーストラリアン・ラブラドゥードル', 'medium large', 'long curly', '毛玉・もつれ ブラシ嫌い', '毛玉ができやすくスリッカー嫌いだったが、足先以外は嫌がりにくく毎日使えているという体験。', 'existing_article_summary', '/brush-slicker.html'
WHERE NOT EXISTS (
  SELECT 1 FROM reviews
  WHERE product_id = 'showtech-slicker'
    AND COALESCE(dog_breed, '') = COALESCE('オーストラリアン・ラブラドゥードル', '')
    AND summary = '毛玉ができやすくスリッカー嫌いだったが、足先以外は嫌がりにくく毎日使えているという体験。'
);
INSERT INTO reviews (product_id, dog_breed, dog_size, coat_type, needs, summary, source_type, source_url)
SELECT 'showtech-slicker', 'トイプードル', 'small', 'long curly', 'ふわふわ仕上げ', '仕上がりはふわふわだった一方、ピン先を鋭く感じて梳かしにくいという混合評価。', 'existing_article_summary', '/brush-slicker.html'
WHERE NOT EXISTS (
  SELECT 1 FROM reviews
  WHERE product_id = 'showtech-slicker'
    AND COALESCE(dog_breed, '') = COALESCE('トイプードル', '')
    AND summary = '仕上がりはふわふわだった一方、ピン先を鋭く感じて梳かしにくいという混合評価。'
);
INSERT INTO reviews (product_id, dog_breed, dog_size, coat_type, needs, summary, source_type, source_url)
SELECT 'lawrence-soft-slicker', '柴犬', 'medium', 'short double', '抜け毛', '3年以上使ってもピンがほとんど取れず、抜け毛の多い柴犬に長く使っているという耐久性の例。', 'existing_article_summary', '/brush-slicker.html'
WHERE NOT EXISTS (
  SELECT 1 FROM reviews
  WHERE product_id = 'lawrence-soft-slicker'
    AND COALESCE(dog_breed, '') = COALESCE('柴犬', '')
    AND summary = '3年以上使ってもピンがほとんど取れず、抜け毛の多い柴犬に長く使っているという耐久性の例。'
);
INSERT INTO reviews (product_id, dog_breed, dog_size, coat_type, needs, summary, source_type, source_url)
SELECT 'lawrence-soft-slicker', 'トイプードル', 'small', 'long curly', '顔・足まわり ふわふわ仕上げ', '顔や手足など細かい部分で扱いやすく、ふわふわに仕上がるという体験。', 'existing_article_summary', '/brush-slicker.html'
WHERE NOT EXISTS (
  SELECT 1 FROM reviews
  WHERE product_id = 'lawrence-soft-slicker'
    AND COALESCE(dog_breed, '') = COALESCE('トイプードル', '')
    AND summary = '顔や手足など細かい部分で扱いやすく、ふわふわに仕上がるという体験。'
);
INSERT INTO reviews (product_id, dog_breed, dog_size, coat_type, needs, summary, source_type, source_url)
SELECT 'furminator-deshedding', 'ラブラドール2頭', 'large', 'short double', '抜け毛 換毛期', '普通のスリッカーでは抜け毛が減らなかったが、軽く梳かすだけで大量のアンダーコートが取れたという体験。', 'existing_article_summary', '/brush-undercoat.html'
WHERE NOT EXISTS (
  SELECT 1 FROM reviews
  WHERE product_id = 'furminator-deshedding'
    AND COALESCE(dog_breed, '') = COALESCE('ラブラドール2頭', '')
    AND summary = '普通のスリッカーでは抜け毛が減らなかったが、軽く梳かすだけで大量のアンダーコートが取れたという体験。'
);
INSERT INTO reviews (product_id, dog_breed, dog_size, coat_type, needs, summary, source_type, source_url)
SELECT 'furminator-deshedding', 'ゴールデンレトリバーの子犬', 'large', 'long double', '抜け毛 換毛期', '長毛種用で下毛まで届き、スリッカーより扱いやすいと感じた例。刃が痛そうに見えるためおやつ中に使用。', 'existing_article_summary', '/brush-undercoat.html'
WHERE NOT EXISTS (
  SELECT 1 FROM reviews
  WHERE product_id = 'furminator-deshedding'
    AND COALESCE(dog_breed, '') = COALESCE('ゴールデンレトリバーの子犬', '')
    AND summary = '長毛種用で下毛まで届き、スリッカーより扱いやすいと感じた例。刃が痛そうに見えるためおやつ中に使用。'
);
INSERT INTO reviews (product_id, dog_breed, dog_size, coat_type, needs, summary, source_type, source_url)
SELECT 'furminator-deshedding', 'パグ13kg', 'medium', 'short double', '抜け毛', '旧モデルから買い替え、中型犬Mサイズが合ったというサイズ選びの具体例。', 'existing_article_summary', '/brush-undercoat.html'
WHERE NOT EXISTS (
  SELECT 1 FROM reviews
  WHERE product_id = 'furminator-deshedding'
    AND COALESCE(dog_breed, '') = COALESCE('パグ13kg', '')
    AND summary = '旧モデルから買い替え、中型犬Mサイズが合ったというサイズ選びの具体例。'
);
INSERT INTO reviews (product_id, dog_breed, dog_size, coat_type, needs, summary, source_type, source_url)
SELECT 'furminator-deshedding', 'ゴールデンレトリバー', 'large', 'long double', '抜け毛 換毛期', '換毛期前に30分ほど使い、大量の毛が取れた公開投稿を確認。SNSは生活場面の補助情報として扱う。', 'existing_article_summary', '/brush-undercoat.html'
WHERE NOT EXISTS (
  SELECT 1 FROM reviews
  WHERE product_id = 'furminator-deshedding'
    AND COALESCE(dog_breed, '') = COALESCE('ゴールデンレトリバー', '')
    AND summary = '換毛期前に30分ほど使い、大量の毛が取れた公開投稿を確認。SNSは生活場面の補助情報として扱う。'
);
INSERT INTO reviews (product_id, dog_breed, dog_size, coat_type, needs, summary, source_type, source_url)
SELECT 'furminator-deshedding', 'オーストラリアンシェパードの子犬', 'medium large', 'long double', '抜け毛', '1日使わなかっただけで抜け毛が多く、通常ブラシだけでは足りないのかと感じている公開投稿。', 'existing_article_summary', '/brush-undercoat.html'
WHERE NOT EXISTS (
  SELECT 1 FROM reviews
  WHERE product_id = 'furminator-deshedding'
    AND COALESCE(dog_breed, '') = COALESCE('オーストラリアンシェパードの子犬', '')
    AND summary = '1日使わなかっただけで抜け毛が多く、通常ブラシだけでは足りないのかと感じている公開投稿。'
);
INSERT INTO reviews (product_id, dog_breed, dog_size, coat_type, needs, summary, source_type, source_url)
SELECT 'showtech-duopin-undercoat', '柴犬', 'medium', 'short double', '抜け毛 換毛期 ブラシ嫌い', 'アンダーコートがよく取れ、犬が嫌がらず、ブラシ角度も使いやすいというレビュー。', 'existing_article_summary', '/brush-undercoat.html'
WHERE NOT EXISTS (
  SELECT 1 FROM reviews
  WHERE product_id = 'showtech-duopin-undercoat'
    AND COALESCE(dog_breed, '') = COALESCE('柴犬', '')
    AND summary = 'アンダーコートがよく取れ、犬が嫌がらず、ブラシ角度も使いやすいというレビュー。'
);
INSERT INTO reviews (product_id, dog_breed, dog_size, coat_type, needs, summary, source_type, source_url)
SELECT 'okano-double-comb', 'マルチーズ', 'small', 'long single', '毛玉・もつれ 仕上げ・根元確認 顔・足まわり', '根元を押さえて優しく梳かすと嫌がりにくく、毛玉も取れたという体験。', 'existing_article_summary', '/brush-comb.html'
WHERE NOT EXISTS (
  SELECT 1 FROM reviews
  WHERE product_id = 'okano-double-comb'
    AND COALESCE(dog_breed, '') = COALESCE('マルチーズ', '')
    AND summary = '根元を押さえて優しく梳かすと嫌がりにくく、毛玉も取れたという体験。'
);
INSERT INTO reviews (product_id, dog_breed, dog_size, coat_type, needs, summary, source_type, source_url)
SELECT 'okano-double-comb', '柴系雑種', 'medium', 'short double', '抜け毛 換毛期 仕上げ・根元確認', '換毛期のアンダーコート対策で、ラバーやスリッカーなどを試した後にコームが合ったという例。', 'existing_article_summary', '/brush-comb.html'
WHERE NOT EXISTS (
  SELECT 1 FROM reviews
  WHERE product_id = 'okano-double-comb'
    AND COALESCE(dog_breed, '') = COALESCE('柴系雑種', '')
    AND summary = '換毛期のアンダーコート対策で、ラバーやスリッカーなどを試した後にコームが合ったという例。'
);
INSERT INTO reviews (product_id, dog_breed, dog_size, coat_type, needs, summary, source_type, source_url)
SELECT 'showtech-as-comb', 'スタンダードプードル', 'large', 'long curly', '仕上げ・根元確認 ふわふわ仕上げ', 'スリッカー後に毛を立たせるとふわふわに仕上がり、根元まで入りやすいと評価。', 'existing_article_summary', '/brush-comb.html'
WHERE NOT EXISTS (
  SELECT 1 FROM reviews
  WHERE product_id = 'showtech-as-comb'
    AND COALESCE(dog_breed, '') = COALESCE('スタンダードプードル', '')
    AND summary = 'スリッカー後に毛を立たせるとふわふわに仕上がり、根元まで入りやすいと評価。'
);
INSERT INTO reviews (product_id, dog_breed, dog_size, coat_type, needs, summary, source_type, source_url)
SELECT 'showtech-as-comb', 'ビションプー', 'small medium', 'long curly', '毛玉・もつれ 仕上げ・根元確認 ふわふわ仕上げ ブラシ嫌い', '翌日までふわっと感が残り、毛玉が少し抑えられた感覚があったという体験。', 'existing_article_summary', '/brush-comb.html'
WHERE NOT EXISTS (
  SELECT 1 FROM reviews
  WHERE product_id = 'showtech-as-comb'
    AND COALESCE(dog_breed, '') = COALESCE('ビションプー', '')
    AND summary = '翌日までふわっと感が残り、毛玉が少し抑えられた感覚があったという体験。'
);
INSERT INTO reviews (product_id, dog_breed, dog_size, coat_type, needs, summary, source_type, source_url)
SELECT 'showtech-as-comb', '3kg・2.4kgのトイプードル', 'small', 'long curly', '毛玉・もつれ 仕上げ・根元確認 顔・足まわり', '粗目で確認→スリッカー→細目仕上げという使い分け目的で購入した例。', 'existing_article_summary', '/brush-comb.html'
WHERE NOT EXISTS (
  SELECT 1 FROM reviews
  WHERE product_id = 'showtech-as-comb'
    AND COALESCE(dog_breed, '') = COALESCE('3kg・2.4kgのトイプードル', '')
    AND summary = '粗目で確認→スリッカー→細目仕上げという使い分け目的で購入した例。'
);
INSERT INTO reviews (product_id, dog_breed, dog_size, coat_type, needs, summary, source_type, source_url)
SELECT 'german-pin-brush-201', 'オールドイングリッシュシープドッグ・21kg', 'large', 'long double', '毛玉・もつれ ブラシ嫌い', '長いピンでもつれが取りやすくなった一方、犬本人はブラッシングを嫌がったという混合評価。', 'existing_article_summary', '/brush-pin.html'
WHERE NOT EXISTS (
  SELECT 1 FROM reviews
  WHERE product_id = 'german-pin-brush-201'
    AND COALESCE(dog_breed, '') = COALESCE('オールドイングリッシュシープドッグ・21kg', '')
    AND summary = '長いピンでもつれが取りやすくなった一方、犬本人はブラッシングを嫌がったという混合評価。'
);
INSERT INTO reviews (product_id, dog_breed, dog_size, coat_type, needs, summary, source_type, source_url)
SELECT 'german-pin-brush-201', 'ゴールデンレトリバー', 'large', 'long double', NULL, 'スリッカーでは物足りないが毎日コームを使うのは大変な時の日常使いに重宝した例。', 'existing_article_summary', '/brush-pin.html'
WHERE NOT EXISTS (
  SELECT 1 FROM reviews
  WHERE product_id = 'german-pin-brush-201'
    AND COALESCE(dog_breed, '') = COALESCE('ゴールデンレトリバー', '')
    AND summary = 'スリッカーでは物足りないが毎日コームを使うのは大変な時の日常使いに重宝した例。'
);
INSERT INTO reviews (product_id, dog_breed, dog_size, coat_type, needs, summary, source_type, source_url)
SELECT 'german-pin-brush-203', '生後3か月ポメラニアン', 'small', 'long double', '毛玉・もつれ ブラシ嫌い', 'スリッカーやコームが引っかかって痛がるため、最初にピンブラシで大まかに梳かすと使いやすかった例。', 'existing_article_summary', '/brush-pin.html'
WHERE NOT EXISTS (
  SELECT 1 FROM reviews
  WHERE product_id = 'german-pin-brush-203'
    AND COALESCE(dog_breed, '') = COALESCE('生後3か月ポメラニアン', '')
    AND summary = 'スリッカーやコームが引っかかって痛がるため、最初にピンブラシで大まかに梳かすと使いやすかった例。'
);
INSERT INTO reviews (product_id, dog_breed, dog_size, coat_type, needs, summary, source_type, source_url)
SELECT 'german-pin-brush-203', 'トイプードル', 'small', 'long curly', 'ふわふわ仕上げ ブラシ嫌い', '少量ずつ小刻みに動かすと嫌がりにくく、ふわふわにできたという追記レビュー。', 'existing_article_summary', '/brush-pin.html'
WHERE NOT EXISTS (
  SELECT 1 FROM reviews
  WHERE product_id = 'german-pin-brush-203'
    AND COALESCE(dog_breed, '') = COALESCE('トイプードル', '')
    AND summary = '少量ずつ小刻みに動かすと嫌がりにくく、ふわふわにできたという追記レビュー。'
);
INSERT INTO reviews (product_id, dog_breed, dog_size, coat_type, needs, summary, source_type, source_url)
SELECT 'german-pin-brush-503', 'マルチーズ4頭＋マルプー', 'small', 'long single', 'ブラシ嫌い ふわふわ仕上げ', 'スリッカーを怖がって使いづらい家庭で扱いやすく、犬も気持ちよさそうだったという例。', 'existing_article_summary', '/brush-pin.html'
WHERE NOT EXISTS (
  SELECT 1 FROM reviews
  WHERE product_id = 'german-pin-brush-503'
    AND COALESCE(dog_breed, '') = COALESCE('マルチーズ4頭＋マルプー', '')
    AND summary = 'スリッカーを怖がって使いづらい家庭で扱いやすく、犬も気持ちよさそうだったという例。'
);

-- Verification
SELECT category, COUNT(*) AS product_count
FROM products
WHERE active = 1
GROUP BY category
ORDER BY category;

SELECT p.category, COUNT(r.id) AS review_count
FROM products p
LEFT JOIN reviews r ON r.product_id = p.id
WHERE p.active = 1
GROUP BY p.category
ORDER BY p.category;
