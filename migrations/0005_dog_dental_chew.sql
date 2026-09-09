PRAGMA foreign_keys = ON;

INSERT OR IGNORE INTO products (id, name, category, active) VALUES ('greenies-teenie-mini', 'グリニーズ プラス 成犬用 超小型犬用ミニ 1.3-4kg', 'dog-dental-chew', 1);
INSERT OR IGNORE INTO products (id, name, category, active) VALUES ('greenies-calorie-mini', 'グリニーズ プラス カロリーケア 超小型犬用ミニ 1.3-4kg', 'dog-dental-chew', 1);
INSERT OR IGNORE INTO products (id, name, category, active) VALUES ('greenies-freshmint-teenie', 'グリニーズ プラス 口臭ケア 超小型犬用 2-7kg', 'dog-dental-chew', 1);
INSERT OR IGNORE INTO products (id, name, category, active) VALUES ('petkiss-standard-small', 'PETKISS 食後の歯みがきガム 小型犬用', 'dog-dental-chew', 1);
INSERT OR IGNORE INTO products (id, name, category, active) VALUES ('petkiss-puppy', 'PETKISS 食後の歯みがきガム 子犬用', 'dog-dental-chew', 1);
INSERT OR IGNORE INTO products (id, name, category, active) VALUES ('veggident-fresh-xs', 'C.E.T. ベジデントフレッシュ XS', 'dog-dental-chew', 1);

DELETE FROM reviews WHERE product_id IN ('greenies-teenie-mini','greenies-calorie-mini','greenies-freshmint-teenie','petkiss-standard-small','petkiss-puppy','veggident-fresh-xs');

UPDATE products SET affiliate_url='https://www.amazon.co.jp/s?k=グリニーズ+プラス+成犬用+超小型犬用+ミニ+1.3-4kg&tag=100things-22' WHERE id='greenies-teenie-mini';
UPDATE products SET affiliate_url='https://www.amazon.co.jp/s?k=グリニーズ+プラス+カロリーケア+超小型犬用+ミニ+1.3-4kg&tag=100things-22' WHERE id='greenies-calorie-mini';
UPDATE products SET affiliate_url='https://www.amazon.co.jp/s?k=4902397846017&tag=100things-22' WHERE id='greenies-freshmint-teenie';
UPDATE products SET affiliate_url='https://www.amazon.co.jp/s?k=PETKISS+食後の歯みがきガム+小型犬用&tag=100things-22' WHERE id='petkiss-standard-small';
UPDATE products SET affiliate_url='https://www.amazon.co.jp/s?k=PETKISS+食後の歯みがきガム+子犬用&tag=100things-22' WHERE id='petkiss-puppy';
UPDATE products SET affiliate_url='https://www.amazon.co.jp/s?k=C.E.T.+ベジデントフレッシュ+XS&tag=100things-22' WHERE id='veggident-fresh-xs';

INSERT INTO reviews (product_id,dog_breed,dog_size,coat_type,needs,summary,source_type,source_url) VALUES
('greenies-teenie-mini','チワワ 2kg',NULL,NULL,'daily taste','2kgのチワワに毎日与えており、1本では途中で飽きるため半分にして使っているという体験。','public_purchase_review_summary','https://review.rakuten.co.jp/item/1/419811_10001193/1.1/'),
('greenies-teenie-mini','チワワ 4kg',NULL,NULL,'size','4kgのチワワではミニサイズが小さく感じ、次は一段大きいサイズを選びたいという体験。','public_purchase_review_summary','https://review.rakuten.co.jp/item/1/303046_10002076/1.1/'),
('greenies-teenie-mini','チワワ 2頭',NULL,NULL,'multi daily taste','2頭のチワワが夕食後のグリニーズを他のおやつ以上に楽しみにしているという体験。','public_purchase_review_summary','https://review.rakuten.co.jp/item/1/217176_10108425/1.1/sort6/'),
('greenies-teenie-mini',NULL,NULL,NULL,'daily','寝る前に1本が日課で、切らさないよう常備しているという体験。','public_purchase_review_summary','https://review.rakuten.co.jp/review/item/1/217176_10114065/1.1/'),
('greenies-teenie-mini','チワワ 複数頭',NULL,NULL,'multi chew','前足で持ちながらゆっくり奥歯で噛んで食べており、噛む時間が取れているという体験。','public_purchase_review_summary','https://review.rakuten.co.jp/review/item/1/217176_10114065/1.1/'),
('greenies-teenie-mini',NULL,NULL,NULL,'scared daily','歯ブラシでの歯磨きを嫌がる犬の補助として使っており、続けやすいという体験。','public_purchase_review_summary','https://review.rakuten.co.jp/review/item/1/217176_10114065/1.1/'),
('greenies-teenie-mini',NULL,NULL,NULL,'daily taste','歴代の犬たちが長年グリニーズを好み、歯磨きガムとして継続しているという体験。','public_purchase_review_summary','https://review.rakuten.co.jp/item/1/217176_10108425/1.1/sort6/'),
('greenies-teenie-mini',NULL,NULL,NULL,'daily','毎食後に与えているが、歯垢への変化ははっきり分からないと感じている体験。','public_purchase_review_summary','https://review.rakuten.co.jp/item/1/419811_10001193/1.1/'),

('greenies-calorie-mini','トイプードル オス3歳',NULL,NULL,'weight daily taste','体重が気になりカロリーケアへ変更したが、以前と同じように喜んで食べ、歯磨き後の習慣になったという体験。','public_purchase_review_summary','https://review.rakuten.co.jp/review/item/1/217176_10108428/1.1/'),
('greenies-calorie-mini',NULL,NULL,NULL,'senior daily','1歳から16歳まで長年与え続けているが、歯石取りと歯磨きも必要だったという体験。','public_purchase_review_summary','https://review.rakuten.co.jp/review/item/1/217176_10108428/1.1/'),
('greenies-calorie-mini',NULL,NULL,NULL,'daily taste','食後になるとジャンプして催促するほど気に入っているという体験。','public_purchase_review_summary','https://review.rakuten.co.jp/review/item/1/217176_10108428/1.1/'),
('greenies-calorie-mini',NULL,NULL,NULL,'daily gel','毎晩のルーティンとして食べ、最近は歯磨きジェルをのせて与えているという体験。','public_purchase_review_summary','https://review.rakuten.co.jp/review/item/1/217176_10108428/1.1/'),
('greenies-calorie-mini','ダックス',NULL,NULL,'weight chew','丸呑みしがちなダックスでも数回に分けて食べ、ダイエット中なので小型サイズを選んでいるという体験。','public_purchase_review_summary','https://review.rakuten.co.jp/review/item/1/217176_10108428/1.1/'),
('greenies-calorie-mini',NULL,NULL,NULL,'multi weight daily','3頭で寝る前に歯磨きガムを食べる習慣があり、カロリーを気にしてこのタイプを選んでいるという体験。','public_purchase_review_summary','https://review.rakuten.co.jp/review/item/1/217176_10108428/1.1/'),
('greenies-calorie-mini','チワワ 3.2kg',NULL,NULL,'size daily','3.2kgのチワワで、以前の大きめサイズを半分にするよりミニの方が与えやすかったという体験。','public_purchase_review_summary','https://review.rakuten.co.jp/review/item/1/211165_10349091/1.1/'),
('greenies-calorie-mini','トイプードル 15歳',NULL,NULL,'senior daily','15歳のトイプードルで、食後にこれをもらうまで食事が終わった気にならないほど習慣化しているという体験。','public_purchase_review_summary','https://review.rakuten.co.jp/item/1/239851_10007250/1.1/'),

('greenies-freshmint-teenie',NULL,NULL,NULL,'odor chew','匂いは強めに感じるが、犬はよく噛んで食べ、これまでのガムで最も口臭への手応えを感じたという体験。','public_purchase_review_summary','https://review.rakuten.co.jp/review/item/1/217176_10114065/1.1/'),
('greenies-freshmint-teenie','チワプー 2歳',NULL,NULL,'odor daily taste','2歳のチワプーが朝晩の食後に楽しみに食べ、口臭ケア用として続けているという体験。','public_purchase_review_summary','https://review.rakuten.co.jp/item/1/211709_10027630/1.1/'),
('greenies-freshmint-teenie',NULL,NULL,NULL,'multi odor daily','2頭に毎日1本ずつ与え、口のにおいが少し良くなったように感じたという体験。','public_purchase_review_summary','https://review.rakuten.co.jp/item/1/211709_10027630/1.1/'),
('greenies-freshmint-teenie','チワワ',NULL,NULL,'size','チワワには超小型犬用でも大きく感じ、半分に切って与えているという体験。','public_purchase_review_summary','https://review.rakuten.co.jp/review/item/1/280582_10011061/1.1/'),
('greenies-freshmint-teenie',NULL,NULL,NULL,'odor daily taste','夕食後に与え始めたところ非常に気に入り、毎回強く要求するようになったという体験。','public_purchase_review_summary','https://review.rakuten.co.jp/review/item/1/309015_10001788/1.1/'),
('greenies-freshmint-teenie',NULL,NULL,NULL,'multi daily taste','姉妹犬2頭が夕食後の1本を楽しみに待つため、切らさないよう注文しているという体験。','public_purchase_review_summary','https://review.rakuten.co.jp/review/item/1/309015_10001788/1.1/'),
('greenies-freshmint-teenie','ダックス 12歳',NULL,NULL,'senior daily','12歳のダックスで食後や歯磨き後のご褒美として使い、奥歯に挟まることがあるという体験。','public_purchase_review_summary','https://review.rakuten.co.jp/review/item/1/309015_10001788/1.1/'),
('greenies-freshmint-teenie','トイプードル',NULL,NULL,'odor chew','トイプードルでよく噛んで食べ、口臭が気になりにくくなったと感じているという体験。','public_purchase_review_summary','https://review.rakuten.co.jp/review/item/1/309015_10001788/1.1/'),

('petkiss-standard-small','プードル 4頭',NULL,NULL,'multi chew','プードル4頭で使っており、顎が強く1分ほどで食べ終えるため噛む時間は短いという体験。','public_purchase_review_summary','https://review.rakuten.co.jp/item/1/261122_10961295/1.1/'),
('petkiss-standard-small',NULL,NULL,NULL,'senior soft','老犬でも食べられる歯磨きガムとしてリピートしているという体験。','public_purchase_review_summary','https://review.rakuten.co.jp/item/1/261122_10961295/1.1/'),
('petkiss-standard-small',NULL,NULL,NULL,'daily','長く継続しており、犬の歯がきれいなのはこのガムのおかげと感じているという体験。','public_purchase_review_summary','https://review.rakuten.co.jp/item/1/261122_10961295/1.1/'),
('petkiss-standard-small','トイプードル 7歳',NULL,NULL,'daily','7歳になっても継続しており、歯がきれいな状態を保てていると感じているという体験。','public_purchase_review_summary','https://review.rakuten.co.jp/item/1/261122_10961295/1.1/'),
('petkiss-standard-small','トイプードル 2歳',NULL,NULL,'taste daily','おやつをあまり好まない2歳のトイプードルでも、このガムだけは好きで常備しているという体験。','public_purchase_review_summary','https://review.rakuten.co.jp/item/1/261122_10961295/1.1/'),
('petkiss-standard-small',NULL,NULL,NULL,'size taste','小型犬なので1本を半分にして与え、準備すると非常に喜ぶという体験。','public_purchase_review_summary','https://review.rakuten.co.jp/item/1/261122_10961295/1.1/'),
('petkiss-standard-small',NULL,NULL,NULL,'chew daily','夜ご飯後に毎日与えているが、3口ほどですぐ食べ終えるため歯磨き効果は分かりにくいという体験。','public_purchase_review_summary','https://review.rakuten.co.jp/item/1/261122_10961295/1.1/'),
('petkiss-standard-small','柴犬',NULL,NULL,'taste','柴犬が気に入り、継続購入したいと感じたという体験。','public_purchase_review_summary','https://review.rakuten.co.jp/item/1/261122_10961295/1.1/'),

('petkiss-puppy','トイプードル 4か月',NULL,NULL,'puppy chew','4か月のトイプードルが上手に噛めた一方、ときどき歯にくっつくことがあったという体験。','public_purchase_review_summary','https://review.rakuten.co.jp/item/1/261122_11060951/1.1/'),
('petkiss-puppy',NULL,NULL,NULL,'puppy chew taste','奥歯でしっかり噛み、柔らかくなると前歯でも噛み、味も気に入っているようだったという体験。','public_purchase_review_summary','https://review.rakuten.co.jp/item/1/200195_10081778/1.1/'),
('petkiss-puppy',NULL,NULL,NULL,'puppy taste','2本与えてもすぐ食べ終えるほど食いつきが良かったという体験。','public_purchase_review_summary','https://review.rakuten.co.jp/item/1/396949_10001253/1.1/'),
('petkiss-puppy',NULL,NULL,NULL,'puppy daily','子犬期の歯みがき習慣づくりとして食後に使っているという体験。','public_purchase_review_summary','https://review.rakuten.co.jp/item/1/261122_11117049/1.1/'),
('petkiss-puppy',NULL,NULL,NULL,'puppy soft','やわらかめで噛みやすく、子犬でも扱いやすかったという体験。','public_purchase_review_summary','https://review.rakuten.co.jp/item/1/261122_11117049/1.1/'),
('petkiss-puppy',NULL,NULL,NULL,'puppy taste','ミルク風味を気に入ったようで、毎回楽しみにしているという体験。','public_purchase_review_summary','https://review.rakuten.co.jp/item/1/261122_11117049/1.1/'),
('petkiss-puppy',NULL,NULL,NULL,'puppy chew','細いロープ状で噛みやすく、奥歯で噛む練習に使いやすかったという体験。','public_purchase_review_summary','https://review.rakuten.co.jp/item/1/200195_10081778/1.1/'),
('petkiss-puppy',NULL,NULL,NULL,'puppy daily','食後のおやつ感覚で続けやすく、歯みがき習慣の入口として使っているという体験。','public_purchase_review_summary','https://review.rakuten.co.jp/item/1/261122_11117049/1.1/'),

('veggident-fresh-xs',NULL,NULL,NULL,'chew daily','他のガムより長く噛んでくれるため、1日1本を継続しているという体験。','public_purchase_review_summary','https://review.rakuten.co.jp/review/item/1/256849_10009700/1.1/'),
('veggident-fresh-xs',NULL,NULL,NULL,'allergy daily','アレルギーがあり、動物病院で勧められてから長く継続しているという体験。','public_purchase_review_summary','https://review.rakuten.co.jp/review/item/1/256849_10009700/1.1/'),
('veggident-fresh-xs',NULL,NULL,NULL,'taste daily','愛犬のお気に入りで、病院で初めて買ってから継続しているという体験。','public_purchase_review_summary','https://review.rakuten.co.jp/review/item/1/256849_10009700/1.1/'),
('veggident-fresh-xs',NULL,NULL,NULL,'grooming chew','手で持ちながら少しずつ与えると集中して噛むため、ドライヤーや爪切り時にも役立ったという体験。','public_purchase_review_summary','https://review.rakuten.co.jp/review/item/1/256849_10009700/1.1/'),
('veggident-fresh-xs',NULL,NULL,NULL,'daily taste','病院で許可されたガムとして5年以上夕食後に与え、飽きずに喜んで食べているという体験。','public_purchase_review_summary','https://review.rakuten.co.jp/review/item/1/256849_10009700/1.1/'),
('veggident-fresh-xs',NULL,NULL,NULL,'chew daily','形・厚み・硬さが愛犬に合い、5年ほど毎日続けても飽きずに食べているという体験。','public_purchase_review_summary','https://review.rakuten.co.jp/review/item/1/256849_10009700/1.1/'),
('veggident-fresh-xs',NULL,NULL,NULL,'size daily','体重4kg弱の犬に1本を半分へ折り、朝晩の歯ブラシ後に分けて与えているという体験。','public_purchase_review_summary','https://review.rakuten.co.jp/review/item/1/256849_10009700/1.1/'),
('veggident-fresh-xs',NULL,NULL,NULL,'skin taste','皮膚疾患がある犬で、このガムを選び続けておりお気に入りになっているという体験。','public_purchase_review_summary','https://review.rakuten.co.jp/review/review/review/item/1/268103_10008043/1.1/'),
('veggident-fresh-xs',NULL,NULL,NULL,'vet daily','動物病院でもらった試供品を犬が気に入ったため、その後購入して続けているという体験。','public_purchase_review_summary','https://review.rakuten.co.jp/review/review/review/item/1/268103_10008043/1.1/'),
('veggident-fresh-xs',NULL,NULL,NULL,'daily taste','夜になるとガムが出てくるのを座って待つほど好きで、毎日の習慣になっているという体験。','public_purchase_review_summary','https://review.rakuten.co.jp/review/item/1/204094_10065484/1.1/');

SELECT COUNT(*) AS dental_chew_product_count FROM products WHERE category='dog-dental-chew' AND active=1;
SELECT COUNT(*) AS dental_chew_review_count FROM reviews r JOIN products p ON p.id=r.product_id WHERE p.category='dog-dental-chew';
