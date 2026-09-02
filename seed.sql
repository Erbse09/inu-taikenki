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
