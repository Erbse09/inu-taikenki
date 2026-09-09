PRAGMA foreign_keys = ON;

INSERT OR IGNORE INTO products (id, name, category, active) VALUES ('norvasan-otic', 'ノルバサン オチック', 'dog-ear-cleaner', 1);
INSERT OR IGNORE INTO products (id, name, category, active) VALUES ('oats-ear-cleaner', 'オーツイヤークリーナー 125ml', 'dog-ear-cleaner', 1);
INSERT OR IGNORE INTO products (id, name, category, active) VALUES ('epiotic-peptide', 'エピオティック ペプチド', 'dog-ear-cleaner', 1);
INSERT OR IGNORE INTO products (id, name, category, active) VALUES ('lanatule-ear-cleaner', 'LaNatule イヤークリーナー', 'dog-ear-cleaner', 1);
INSERT OR IGNORE INTO products (id, name, category, active) VALUES ('sure-limpu-ear', 'シュアリンプウ イヤークリーナー', 'dog-ear-cleaner', 1);
INSERT OR IGNORE INTO products (id, name, category, active) VALUES ('mimikyua-one', 'ミミキュアワン', 'dog-ear-cleaner', 1);

DELETE FROM reviews WHERE product_id IN ('norvasan-otic','oats-ear-cleaner','epiotic-peptide','lanatule-ear-cleaner','sure-limpu-ear','mimikyua-one');

UPDATE products SET affiliate_url='https://www.amazon.co.jp/s?k=ノルバサン+オチック&tag=100things-22' WHERE id='norvasan-otic';
UPDATE products SET affiliate_url='https://www.amazon.co.jp/s?k=オーツイヤークリーナー+125ml&tag=100things-22' WHERE id='oats-ear-cleaner';
UPDATE products SET affiliate_url='https://www.amazon.co.jp/s?k=4535023301378&tag=100things-22' WHERE id='epiotic-peptide';
UPDATE products SET affiliate_url='https://www.amazon.co.jp/s?k=LaNatule+イヤークリーナー&tag=100things-22' WHERE id='lanatule-ear-cleaner';
UPDATE products SET affiliate_url='https://www.amazon.co.jp/s?k=シュアリンプウ+イヤークリーナー&tag=100things-22' WHERE id='sure-limpu-ear';
UPDATE products SET affiliate_url='https://www.amazon.co.jp/s?k=ミミキュアワン+イヤークリーナー&tag=100things-22' WHERE id='mimikyua-one';

INSERT INTO reviews (product_id,dog_breed,dog_size,coat_type,needs,summary,source_type,source_url) VALUES
('norvasan-otic','ゴールデンレトリバー',NULL,NULL,'droop large daily','垂れ耳で汚れやすいため、コットンに含ませてこまめに拭き取り、継続使用している体験。','public_purchase_review_summary','https://product.rakuten.co.jp/product/-/7b7f029ac48a291aa063703423a9be1e/'),
('norvasan-otic','フラットコーテッドレトリバー・ゴールデンレトリバー',NULL,NULL,'droop large multi','垂れ耳の大型犬2頭で使うため大容量を選び、日常の耳洗浄に使っている体験。','public_purchase_review_summary','https://review.rakuten.co.jp/item/1/216162_10005789/1.1/'),
('norvasan-otic','ヨークシャーテリア',NULL,NULL,'droop scared weekly','垂れ耳で週1回の耳掃除に使用。イヤークリーナーを嫌がるものの継続している体験。','public_purchase_review_summary','https://item.rakuten.co.jp/kurosu/10003777/'),
('norvasan-otic','シュナウザー',NULL,NULL,'semi-droop smell','半立ち耳のシュナウザーで、他製品より匂いが気になりにくく使いやすかったという体験。','public_purchase_review_summary','https://review.rakuten.co.jp/item/1/204094_10001084/1.1/'),
('norvasan-otic',NULL,NULL,NULL,'daily smell','毎日の耳掃除に使用し、香りが良く犬も嫌がりにくかったという体験。','public_purchase_review_summary','https://item.rakuten.co.jp/petech/005932/'),
('norvasan-otic',NULL,NULL,NULL,'redness daily','赤みが出やすかった耳の入口周りをコットンで拭くケアに使い、継続している体験。','public_purchase_review_summary','https://item.rakuten.co.jp/petech/005932/'),
('norvasan-otic',NULL,NULL,NULL,'dirt cleaning','耳の汚れが浮きやすく、日常の洗浄に使いやすいと感じた体験。','public_purchase_review_summary','https://item.rakuten.co.jp/petech/005932/'),
('norvasan-otic',NULL,NULL,NULL,'long-term','以前から長く耳掃除に使っており、必需品としてリピートしている体験。','public_purchase_review_summary','https://item.rakuten.co.jp/kurosu/10003777/'),
('norvasan-otic',NULL,NULL,NULL,'vet daily','動物病院で使われていたのと同じ製品を選び、自宅ケアへ取り入れている体験。','public_purchase_review_summary','https://review.rakuten.co.jp/item/1/204094_10001084/1.1/'),
('oats-ear-cleaner','チワックス',NULL,NULL,'droop smell','垂れ耳で汚れやすく、耳に入れて揉んだ後にブルブルさせる使い方で、においが気になりにくくなった体験。','public_purchase_review_summary','https://shopping.yahoo.co.jp/products/7e0990ae13/review/'),
('oats-ear-cleaner','トイプードル',NULL,NULL,'droop smell scared','以前のクリーナーの強い匂いを嫌がった犬で、オーツは匂いが穏やかで掃除しやすかったという体験。','public_purchase_review_summary','https://shopping.yahoo.co.jp/products/7e0990ae13/review/'),
('oats-ear-cleaner','トイプードル',NULL,NULL,'sensitive redness','他のイヤークリーナーで赤くなりやすかったが、オーツは刺激が少なく使い続けられたという体験。','public_purchase_review_summary','https://review.rakuten.co.jp/review/item/1/256849_10009232/1.1/'),
('oats-ear-cleaner','トイプードル',NULL,NULL,'droop smell','垂れ耳で耳のにおいが気になる時に使い、掃除後はにおいが気になりにくくなったという体験。','public_purchase_review_summary','https://review.rakuten.co.jp/item/1/219837_10006328/1.1/'),
('oats-ear-cleaner',NULL,NULL,NULL,'sensitive','刺激が少なく、耳掃除の際に痛がりにくかったという体験。','public_purchase_review_summary','https://review.rakuten.co.jp/item/1/219837_10006328/1.1/'),
('oats-ear-cleaner',NULL,NULL,NULL,'droop daily','垂れ耳の犬たちでトラブルなく使えており、定期的な耳掃除に欠かせないという体験。','public_purchase_review_summary','https://review.rakuten.co.jp/item/1/219837_10006328/1.1/'),
('oats-ear-cleaner','トイプードル 13歳',NULL,NULL,'senior long-term','外耳炎をきっかけに獣医師から勧められ、13年近く使い続けているという体験。','public_purchase_review_summary','https://shopping.yahoo.co.jp/products/2e7c73fd9a/review/'),
('oats-ear-cleaner',NULL,NULL,NULL,'dirt cleaning','耳に垂らしてコットンで拭くと汚れがしっかり取れ、使いやすかったという体験。','public_purchase_review_summary','https://review.rakuten.co.jp/item/1/256849_10009234/1.1/'),
('oats-ear-cleaner',NULL,NULL,NULL,'vet sensitive','動物病院で使われているのを見て購入し、自宅での耳掃除に取り入れたという体験。','public_purchase_review_summary','https://review.rakuten.co.jp/review/item/1/256849_10009232/1.1/'),
('epiotic-peptide',NULL,NULL,NULL,'vet gentle','動物病院と同じ製品を自宅用に購入し、安心感を持って耳掃除に使っているという体験。','public_purchase_review_summary','https://item.rakuten.co.jp/sundrug/4535023301378/'),
('epiotic-peptide',NULL,NULL,NULL,'gentle dispense','液が一気に出すぎにくく、耳へ入れる量を調整しやすかったという体験。','public_purchase_review_summary','https://item.rakuten.co.jp/sundrug/4535023301378/'),
('epiotic-peptide',NULL,NULL,NULL,'cleaning','耳あかを洗い流す目的で定期的に使い、日常の耳道ケアへ取り入れている体験。','public_purchase_review_summary','https://item.rakuten.co.jp/vetslabo/dc000113/'),
('epiotic-peptide',NULL,NULL,NULL,'sensitive','アルコールフリーのものを探し、低刺激性を重視して選んだという体験。','public_purchase_review_summary','https://item.rakuten.co.jp/vetslabo/dc000113/'),
('epiotic-peptide',NULL,NULL,NULL,'long-term','以前から継続して使っており、耳掃除用品としてリピートしている体験。','public_purchase_review_summary','https://product.rakuten.co.jp/product/-/2098765d1c7657cea30cee849ef0ee17/'),
('epiotic-peptide',NULL,NULL,NULL,'smell','耳洗浄後のすっきり感を気に入り、定期ケアに使っているという体験。','public_purchase_review_summary','https://product.rakuten.co.jp/product/-/2098765d1c7657cea30cee849ef0ee17/'),
('epiotic-peptide',NULL,NULL,NULL,'vet','獣医師に勧められたことをきっかけに、自宅用として継続購入しているという体験。','public_purchase_review_summary','https://product.rakuten.co.jp/product/-/2098765d1c7657cea30cee849ef0ee17/'),
('epiotic-peptide',NULL,NULL,NULL,'cleaning gentle','耳の汚れを落としつつ刺激が強すぎないものを求めて選び、使いやすかったという体験。','public_purchase_review_summary','https://item.rakuten.co.jp/vetslabo/dc000113/'),
('lanatule-ear-cleaner','オールドイングリッシュシープドッグ',NULL,NULL,'large itch smell','大型犬で耳の痒みとにおいが気になって使い、使用後は気になりにくくなったという体験。','public_purchase_review_summary','https://review.rakuten.co.jp/item/1/394896_10000092/1.1/'),
('lanatule-ear-cleaner','トイプードル',NULL,NULL,'droop smell','垂れ耳で夏場ににおいと汚れが気になるため、自宅ケア用として選んだという体験。','public_purchase_review_summary','https://review.rakuten.co.jp/item/1/394896_10000092/1.1/'),
('lanatule-ear-cleaner','トイプードル',NULL,NULL,'droop dirt','耳に注入して揉み、拭き取ると茶色い汚れが取れ、隔週ケアに使っているという体験。','public_purchase_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=lanatule-ear-mall&store_id=baumkuchen'),
('lanatule-ear-cleaner',NULL,NULL,NULL,'droop itch','垂れ耳で耳垢と痒みが出やすく、定期的に使うと耳垢が取りやすかったという体験。','public_purchase_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=lanatule-ear-mall&store_id=baumkuchen'),
('lanatule-ear-cleaner',NULL,NULL,NULL,'unscented gentle','香りが強くないものを探し、無香料で使いやすいと感じた体験。','public_purchase_review_summary','https://review.rakuten.co.jp/item/1/394896_10000092/1.1/'),
('lanatule-ear-cleaner',NULL,NULL,NULL,'beginner nozzle','ノズルから耳へ入れやすく、初心者でも扱いやすかったという体験。','public_purchase_review_summary','https://review.rakuten.co.jp/item/1/394896_10000092/1.1/'),
('lanatule-ear-cleaner',NULL,NULL,NULL,'dirt cleaning','耳垢が落ちやすく、耳掃除後の汚れ残りが気になりにくかったという体験。','public_purchase_review_summary','https://review.rakuten.co.jp/item/1/394896_10000092/1.1/'),
('lanatule-ear-cleaner',NULL,NULL,NULL,'cost large','使い心地は良い一方、大型犬で継続するには容量と価格が気になったという体験。','public_purchase_review_summary','https://review.rakuten.co.jp/item/1/394896_10000092/1.1/'),
('sure-limpu-ear','トイプードル',NULL,NULL,'droop itch smell','垂れ耳のトイプードルでにおいと痒みが気になり、毎日のケアに使ったという体験。','public_purchase_review_summary','https://item.rakuten.co.jp/pet-gp/lim-earmini-22/'),
('sure-limpu-ear','トイプードル',NULL,NULL,'droop prevention','外耳炎を繰り返しやすいトイプードルで、予防目的の自宅ケアとして選んだという体験。','public_purchase_review_summary','https://item.rakuten.co.jp/pet-gp/lim-earmini-22/'),
('sure-limpu-ear',NULL,NULL,NULL,'itch smell','耳を掻く回数とにおいが気になって使い始め、数日で変化を感じたという体験。','public_purchase_review_summary','https://item.rakuten.co.jp/mpcpets/112640-30ml/'),
('sure-limpu-ear',NULL,NULL,NULL,'no-wipe','拭き取り不要の使い方が手軽で、続けやすいと感じたという体験。','public_purchase_review_summary','https://item.rakuten.co.jp/mpcpets/112640-30ml/'),
('sure-limpu-ear',NULL,NULL,NULL,'small bottle','大きいボトルを使い切れなかった経験から、小さい30mlサイズを選んだという体験。','public_purchase_review_summary','https://item.rakuten.co.jp/mpcpets/112640-30ml/'),
('sure-limpu-ear',NULL,NULL,NULL,'dirt','黒っぽい耳汚れが気になった時に数日使い、自宅ケアへ取り入れたという体験。','public_purchase_review_summary','https://item.rakuten.co.jp/mpcpets/112640-30ml/'),
('sure-limpu-ear',NULL,NULL,NULL,'scared','点耳の音だけで嫌がるほど耳ケアが苦手で、使いたくても入れにくかったという体験。','public_purchase_review_summary','https://item.rakuten.co.jp/pet-gp/lim-earmini-22/'),
('sure-limpu-ear',NULL,NULL,NULL,'smell easy','使い方が簡単で、耳のにおいが気になりにくくなったと感じたという体験。','public_purchase_review_summary','https://item.rakuten.co.jp/joinus/10002638/'),
('mimikyua-one',NULL,NULL,NULL,'long-term','何年も継続して使い、香りと使いやすさを気に入っているという体験。','public_purchase_review_summary','https://review.rakuten.co.jp/item/1/394896_10000025/1.1/'),
('mimikyua-one',NULL,NULL,NULL,'gentle','低刺激を重視して選び、日常の耳掃除に取り入れているという体験。','public_purchase_review_summary','https://review.rakuten.co.jp/item/1/394896_10000025/1.1/'),
('mimikyua-one',NULL,NULL,NULL,'dirt cleaning','耳垢や汚れが気になる時の自宅ケアとして使い、拭き取りやすかったという体験。','public_purchase_review_summary','https://review.rakuten.co.jp/item/1/394896_10000025/1.1/'),
('mimikyua-one',NULL,NULL,NULL,'smell','耳のにおいが気になる時に使い、香りも強すぎず使いやすかったという体験。','public_purchase_review_summary','https://review.rakuten.co.jp/item/1/394896_10000025/1.1/'),
('mimikyua-one',NULL,NULL,NULL,'droop','垂れ耳で蒸れやすい犬の定期ケアとして使っているという体験。','public_purchase_review_summary','https://review.rakuten.co.jp/item/1/394896_10000025/1.1/'),
('mimikyua-one',NULL,NULL,NULL,'scared gentle','耳掃除が苦手な犬で、刺激が少ないものを探して使い始めたという体験。','public_purchase_review_summary','https://review.rakuten.co.jp/item/1/394896_10000025/1.1/'),
('mimikyua-one',NULL,NULL,NULL,'daily','自宅での定期的な耳掃除用としてリピートし、ケア習慣にしているという体験。','public_purchase_review_summary','https://review.rakuten.co.jp/item/1/394896_10000025/1.1/'),
('mimikyua-one',NULL,NULL,NULL,'multi','複数本セットを選び、切らさないよう自宅に常備しているという体験。','public_purchase_review_summary','https://review.rakuten.co.jp/item/1/394896_10000025/1.1/');

SELECT COUNT(*) AS ear_cleaner_product_count FROM products WHERE category='dog-ear-cleaner' AND active=1;
SELECT COUNT(*) AS ear_cleaner_review_count FROM reviews r JOIN products p ON p.id=r.product_id WHERE p.category='dog-ear-cleaner';
