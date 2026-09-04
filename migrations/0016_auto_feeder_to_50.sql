PRAGMA foreign_keys = ON;

WITH new_reviews(product_id,dog_breed,dog_size,coat_type,needs,summary,source_type,source_url) AS (
VALUES
('take-one-p2pro','犬・昼間に食べる子',NULL,NULL,'dog camera daytime','昼間に食べる犬の留守番用に導入。給餌自体はできたが、固定カメラでは食事中に頭頂部しか映らず、口元を確認しにくいと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=p1&store_id=take-one'),
('take-one-p2pro',NULL,NULL,NULL,'camera washability height','カメラ映像がきれいで皿まで確認でき、ステンレス部分を外して洗える点を評価。食べる位置が低いため自作の台へ載せて使った体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=p1&store_id=take-one'),
('take-one-p2pro',NULL,NULL,NULL,'repeat feeder height seal','過去に3台の自動給餌器を使った家庭で最も良いと感じ、専用台で高さを補い、洗えるステンレス皿と密閉性の高い蓋を評価した体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=p1&store_id=take-one'),
('take-one-p2pro','犬・留守番が長い時に使用',NULL,NULL,'dog scared camera','長い留守番用に使い、最初はフードが落ちる音に驚いたが食欲が勝ってすぐ慣れた。広角・夜間カメラも安心材料になった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=p1&store_id=take-one'),
('take-one-p2pro','トイプードル・6か月','small','curly','puppy food-motivated mischief','6か月のトイプードルが最初は落下音に驚いたもののすぐ食べ、皿や本体を前足で触っても倒れにくかった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=p1&store_id=take-one'),
('take-one-p2pro','パピー・7か月',NULL,NULL,'puppy camera jam training','7か月の子犬で広角カメラは便利だった一方、スケジュール給餌で詰まり表示が出ることがあり、自動給餌中はおすわり・お手の習慣にも変化を感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=p1&store_id=take-one'),
('take-one-p2pro',NULL,NULL,NULL,'camera stability portion','旧型レビューを見て購入したが、新型は10g単位で、皿や食事中の様子がカメラに映りにくく、カメラ接続も不安定な時があった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=p1&store_id=take-one'),
('take-one-p2pro',NULL,NULL,NULL,'vomit-prone portion accuracy','吐き戻ししやすい子の小分け給餌で使用。5g設定でも約3g、10g設定で約7gになったため、実測して複数回排出で調整した体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=p1&store_id=take-one'),
('wtw-ipet2971','犬の飼育家庭',NULL,NULL,'dog support camera failure','使用中にカメラが見られなくなる不具合が起き、通信環境を確認しても解決せず、サポート対応にも強い不満を感じて返金となった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=gohan&store_id=wtw'),
('wtw-ipet2971',NULL,NULL,NULL,'replacement camera schedule support','初期不良で交換後は接続が簡単になり、1日30回までの給餌回数とカメラ画質・角度は満足した一方、録音機能や本体奥行き、店舗対応に不満が残った体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=gohan&store_id=wtw'),
('wtw-ipet2971',NULL,NULL,NULL,'setup cleaning battery portion','Wi-Fiとアプリは簡単に設定できたが、現行アプリと説明書の差、分解洗浄の手間、密閉性、6g単位の給餌、電池時の機能制限が気になった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=gohan&store_id=wtw'),
('wtw-ipet2971',NULL,NULL,NULL,'portion accuracy camera','カメラ映像はきれいだったが、設定量より最大8gほど多く出ることがあり、何度も実測して設定量を減らして調整した体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=gohan&store_id=wtw'),
('wtw-ipet2971','犬・犬心ドッグフード使用',NULL,NULL,'dog portion accuracy health','犬用フードでアプリ54g設定に対して実際は約78g出ることがあり、表示を信じて多く与えすぎて体調を崩したため、事前計量の重要性を感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=gohan&store_id=wtw'),
('wtw-ipet2971','チワワ','small',NULL,'dog scared remote-feed','帰宅が遅い時用にチワワへ使用。遠隔・時間指定給餌は簡単で、最初は警戒したがフードが出る音を食事の合図として覚えた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=gohan&store_id=wtw'),
('wtw-ipet2971',NULL,NULL,NULL,'camera realtime travel','留守中の見守り目的で使い、Wi-Fi接続が簡単でカメラ映像もほぼリアルタイムに確認でき、外出時の安心につながった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=gohan&store_id=wtw'),
('wtw-ipet2971',NULL,NULL,NULL,'wifi feed-slide app','Wi-Fi接続は簡単で本体サイズも扱いやすく、数日使用して大きな不安はなかった一方、フードの滑り落ちと英語の通知表示が気になった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=gohan&store_id=wtw'),
('moizze-pet001','チワワ・2.6kg','small',NULL,'dog camera height portion','2.6kgのチワワで朝夕2回に設定。カメラは外出先から確認しやすく、2杯分がちょうどよかったが、皿位置が低いため台へ載せて使った体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/416008_10000986/1.1/'),
('moizze-pet001','愛犬・1日3回食',NULL,NULL,'dog acclimation camera portion','1日3回食の犬で昼食の留守番対策に使用。最初は戸惑ったが3日目から不在でも食べるようになり、声かけカメラは便利だった一方、1フィード約10±3gのばらつきが気になった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/416008_10000986/1.1/'),
('moizze-pet001','愛犬・帰宅が遅い家庭',NULL,NULL,'dog scared remote camera','帰宅が遅い時の給餌用に購入。最初はフードの音を怖がったが在宅時にも自動給餌して慣らし、遠隔操作と録画で留守中の様子を確認できた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/416008_10000986/1.1/'),
('moizze-pet001','小型犬','small',NULL,'dog camera angle','小型犬で問題なく使用。アプリ設定と外出先からの給餌は簡単でカメラも鮮明だったが、食事中はおでこ中心で皿の残量を確認しにくかった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/416008_10000986/1.1/'),
('moizze-pet001','わんぱくな犬',NULL,NULL,'dog mischief durability','わんぱくな犬が皿を外したり本体の周囲を掘ったが、ロックがしっかりしてフードを取り出したり本体を倒したりできず、成長後は皿にも慣れた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/416008_10000986/1.1/'),
('moizze-pet001',NULL,NULL,NULL,'travel nightvision minimum-portion','旅行時の遠隔給餌とカメラ目的で使用。接続が簡単で夜間映像も明るく、15回タイマーと洗える皿を評価した一方、1回量をもっと少なく設定したいと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/416008_10000986/1.1/'),
('moizze-pet001',NULL,NULL,NULL,'multi-device portion height','多頭飼いで2台を登録して使用。フード補充直後や粒サイズで給餌量がぶれるため安定するまで試運転し、低いトレイは台で高さを補った体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/416008_10000986/1.1/'),
('moizze-pet001',NULL,NULL,NULL,'setup cleaning troubleshooting','他社機の故障後に購入し、設定・洗浄性・カメラを評価。初回はフードが出なかったが、セット方法を直すと正常に手動給餌できた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/416008_10000986/1.1/'),
('moizze-pet001',NULL,NULL,NULL,'custom-bowl height','帰宅が遅くなる生活で使用し、自作の台で高さを出し、付属皿ではなく手持ちのボウルへフードが入るよう工夫。ペットも気にせず食べた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/416008_10000986/1.1/'),
('moizze-pet001',NULL,NULL,NULL,'camera sound mic','留守番用にカメラとアプリを接続して使用。画質と静かな本体動作は良かったが、アルミ皿へフードが落ちる音とマイクの音割れが少し気になった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/416008_10000986/1.1/'),
('petlibro-granary',NULL,NULL,NULL,'wifi schedule portion subscription','Wi-Fi接続が不安定でスケジュール給餌が動かない時があり、排出量も不規則、アプリの有料サービス案内も多いと感じた否定的な体験。','public_buyer_review_summary','https://www.chewy.com/petlibro-granary-automatic-cat-dog/product-reviews/661246'),
('petlibro-granary',NULL,NULL,NULL,'app comparison','以前使っていたCasfuyが約13か月で不調になりPETLIBROへ変更。耐久性はまだ不明だが、アプリはこちらの方が使いやすいと感じた体験。','public_buyer_review_summary','https://www.chewy.com/petlibro-granary-automatic-cat-dog/product-reviews/661246'),
('petlibro-granary',NULL,NULL,NULL,'setup subscription','初期設定は直感的で使えた一方、追加料金のサービスへ誘導される表示が多い点を好ましく感じなかった体験。','public_buyer_review_summary','https://www.chewy.com/petlibro-granary-automatic-cat-dog/product-reviews/661246'),
('petlibro-granary',NULL,NULL,NULL,'video sdcard subscription','本体は動作したが、動画履歴を開くたびクラウドサービスの案内が先に出て、SDカード利用までの操作が煩わしいと感じた体験。','public_buyer_review_summary','https://www.chewy.com/petlibro-granary-automatic-cat-dog/product-reviews/661246'),
('petlibro-granary',NULL,NULL,NULL,'travel wifi support','在宅時の定時給餌は便利でも、旅行中にWi-Fi接続が切れて物理リセットが必要になることがあり、サポート対応にも不満を感じた体験。','public_buyer_review_summary','https://www.chewy.com/petlibro-granary-automatic-cat-dog/product-reviews/661246'),
('petlibro-granary',NULL,NULL,NULL,'camera notifications freshness','カメラが約1か月使えなかった後に突然ライブ映像が使えるようになったが、動体通知が多く、蓋の乾燥剤交換も手間に感じた体験。','public_buyer_review_summary','https://www.chewy.com/petlibro-granary-automatic-camera-cat/product-reviews/1042774'),
('petlibro-granary',NULL,NULL,NULL,'schedule remote','外出中でも一定の給餌スケジュールをアプリで組める点が便利で、留守番中の食事管理に使いやすいと感じた体験。','public_buyer_review_summary','https://www.chewy.com/petlibro-granary-wifi-24g-5g/product-reviews/661214'),
('petlibro-granary',NULL,'small',NULL,'small-pet wifi jam noise','以前のGranaryが2年未満で故障し買い替えたが、新しい機種は数日でWi-Fi切断や詰まりが起き、単発給餌が二重になったり出なかったりし、排出も遅く音が大きいと感じた体験。','public_buyer_review_summary','https://www.chewy.com/petlibro-granary-wifi-24g-5g/product-reviews/661214'),
('petlibro-granary',NULL,NULL,NULL,'connection support','以前の2ボウル機から買い替えたが接続できず、公式手順で試しても解決せず、電話窓口がないサポートにも不満を感じた体験。','public_buyer_review_summary','https://www.chewy.com/petlibro-granary-wifi-24g-5g/product-reviews/661214'),
('petlibro-granary',NULL,NULL,NULL,'dual-bowl uneven','2ボウルタイプで左右へ均等にフードが分かれず、片側の量が多くなってペット同士が取り合うことがあった体験。','public_buyer_review_summary','https://www.chewy.com/petlibro-granary-wifi-24g-5g/product-reviews/661230'),
('petlibro-granary',NULL,NULL,NULL,'durability support','購入から約3か月で動かなくなり、カスタマーサービスのコミュニケーションにも不満を感じた体験。','public_buyer_review_summary','https://www.chewy.com/petlibro-granary-wifi-24g-5g/product-reviews/661230'),
('petlibro-granary',NULL,NULL,NULL,'app custom-call','アプリが扱いやすく、カスタムの食事呼びかけ音を設定できる点を便利に感じた体験。','public_buyer_review_summary','https://www.chewy.com/petlibro-granary-wifi-24g-5g/product-reviews/661230'),
('petlibro-granary',NULL,NULL,NULL,'app subscription dual-bowl','スマホアプリが必須で有料サービスへの案内が多く、少量給餌では2つの皿へ均等に分配されにくいと感じた体験。','public_buyer_review_summary','https://www.chewy.com/petlibro-granary-wifi-24g-5g/product-reviews/661230'),
('petlibro-granary',NULL,NULL,NULL,'rural-wifi reset','地方の不安定な回線環境ではインターネットが切れるたび本体の再設定が必要になり、交換品でも改善せず継続利用を断念した体験。','public_buyer_review_summary','https://www.chewy.com/petlibro-granary-wifi-24g-5g/product-reviews/661230'),
('petlibro-granary',NULL,NULL,NULL,'portion-inconsistency app','給餌量が安定せず、週に一度ほど大量に出ることがあり、アプリも機器操作よりサービス販売の表示が目立つと感じた体験。','public_buyer_review_summary','https://www.chewy.com/petlibro-granary-wifi-24g-5g/product-reviews/661230'),
('petlibro-granary',NULL,NULL,NULL,'portion-unit setup','初期設定で『ポーション』の意味が分かりにくく、調べて1ポーション約20mLと理解してから設定できた体験。','public_buyer_review_summary','https://www.chewy.com/petlibro-granary-automatic-dog-cat/product-reviews/378777'),
('petlibro-granary',NULL,NULL,NULL,'four-schedules programming','1日に4回の給餌時刻と量を設定でき、帰宅を急がなくてよくなった一方、プログラム操作はやや分かりにくいと感じた体験。','public_buyer_review_summary','https://www.chewy.com/petlibro-granary-automatic-dog-cat/product-reviews/378777')
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
  (SELECT COUNT(*) FROM reviews r JOIN products p ON p.id=r.product_id WHERE p.category='auto-feeder') AS auto_feeder_review_count;
