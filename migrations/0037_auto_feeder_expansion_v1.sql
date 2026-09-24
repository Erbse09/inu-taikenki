PRAGMA foreign_keys = ON;

WITH new_reviews(product_id,dog_breed,dog_size,coat_type,needs,summary,source_type,source_url) AS (
VALUES
('karikari-machine-v2c-plus','犬を迎えて1か月の家庭',NULL,NULL,'dog camera remote-feed','留守番中の犬とフードの状態をカメラで確認でき、サークル全体は映しにくいものの餌やり目的では十分で、写真や動画も残せて安心した体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=uespv2cp&store_id=catfamily'),
('karikari-machine-v2c-plus','犬種不明・長時間外出時のみ使用',NULL,NULL,'remote-feed voice portion','長時間の外出時に5g単位で遠隔給餌し、飼い主の声が聞こえると給餌器前へ走ってくるようになった一方、実際の排出量にはばらつきがあると感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=uespv2cp&store_id=catfamily'),
('karikari-machine-v2c-plus','犬種不明・他社機から買い替え',NULL,NULL,'reliability schedule wifi','以前の給餌器ではフードの詰まりやスケジュール失敗、突然のオフラインが続いたが、買い替え後は給餌と接続が安定していると感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=uespv2cp&store_id=catfamily'),
('karikari-machine-v2c-plus','犬種不明・少量頻回給餌',NULL,NULL,'small-portion app cleaning','アプリ設定が簡単で5g単位・1日最大20回の設定を使いやすく、ステンレス皿も洗いやすいと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=uespv2cp&store_id=catfamily'),
('karikari-machine-v2c-plus','犬種不明・外出時間が延びる家庭',NULL,NULL,'outdoor reassurance','予定より帰宅が遅くなっても自動給餌できるため安心感が増え、在宅時は通常の食器で与えるなど使い分けている体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=uespv2cp&store_id=catfamily'),
('karikari-machine-v2c-plus','ペット2頭・2台運用',NULL,NULL,'multi quiet camera backup','2台で使い、静音性・アプリ設定・カメラ・乾電池バックアップは便利だった一方、同じ設定でも実際の排出量に差があり、密閉性も少し気になった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=uespv2cp&store_id=catfamily'),
('karikari-machine-v2c-plus','犬種不明・旅行時利用',NULL,NULL,'washability portion-variation','旅行時に使い、アプリ操作と食洗機対応の皿は便利だった一方、1回の排出量が数g前後ぶれるため厳密なカロリー管理には向きにくいと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=uespv2cp&store_id=catfamily'),
('karikari-machine-v2c-plus','犬種不明・初回接続で手間取った家庭',NULL,NULL,'camera mic low-height setup','分解洗浄・高画質カメラ・リアルタイム通話を評価した一方、皿とカメラ位置が低く、最初のWi-Fi設定では入力ミスに気づくまで時間がかかった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/z45ichss2i/review/'),
('petlabo-auto-feeder','タイニートイプードル・パピー','small',NULL,'puppy small-portion camera','600gほどのパピー期から5gを1日8回に分けて与え、成長後もカメラでフードが出て食べていることを確認でき、低血糖対策として安心感があった体験。','public_buyer_review_summary','https://item.rakuten.co.jp/petlabokan/pet-051/'),
('petlabo-auto-feeder','犬種不明・帰宅が遅い家庭',NULL,NULL,'late-return timer','帰宅が遅くなる日でもタイマーで決まった時間にフードを出せるため、食事時間の心配が減った体験。','public_buyer_review_summary','https://item.rakuten.co.jp/petlabokan/pet-051/'),
('petlabo-auto-feeder','犬種不明・約5か月使用',NULL,NULL,'jam durability negative','購入直後から時々異音があり、その後数か月でフード詰まりが増え、分解洗浄しても改善せず耐久性に不満を感じた体験。','public_buyer_review_summary','https://item.rakuten.co.jp/petlabokan/pet-051/'),
('petlabo-auto-feeder','犬種不明・アプリ式モデル',NULL,NULL,'wifi camera maintenance','Wi-Fi設定は何度か試す必要があったが接続後は安定し、動体検知とカメラ、洗いやすいステンレス皿を便利に感じた一方、停電時の予備電源が気になった体験。','public_buyer_review_summary','https://item.rakuten.co.jp/petlabokan/pet-051/'),
('petlabo-auto-feeder','犬種不明・3か月未満で故障',NULL,NULL,'durability support negative','使用開始から3か月ほどでAC電源でも電池でも動かなくなり、保証期間中でも修理時の送料負担が必要な点に不満を感じた体験。','public_buyer_review_summary','https://item.rakuten.co.jp/bestanswer/pet-051/'),
('petlabo-auto-feeder','犬種不明・いたずら対策重視',NULL,NULL,'mischief-proof simple','タイマー式のシンプルな給餌器として使い、回して固定する蓋・小さめの排出口・保護されたコードなど、いたずらされにくい構造を評価した体験。','public_buyer_review_summary','https://item.rakuten.co.jp/tokusenkan/pet-051/'),
('petlabo-auto-feeder','犬種不明・給餌音に最初は警戒',NULL,NULL,'scared acclimation height','最初はフードが落ちる音を警戒したが、手動給餌で慣らすうちに給餌時刻付近で待つようになり、本体が低いため台へ載せて使った体験。','public_buyer_review_summary','https://item.rakuten.co.jp/bestanswer/pet-051/'),
('petlabo-auto-feeder','犬種不明・5g単位の精度確認',NULL,NULL,'portion accuracy','使用中のドライフードでは1ポーション約5gでほぼ狙った量が出て、シンプルな設定で使いやすかった体験。','public_buyer_review_summary','https://item.rakuten.co.jp/bestanswer/pet-051/'),
('moizze-pet001','犬種不明・トレー耐久性を重視',NULL,NULL,'tray-rust support','本体の使いやすさには満足した一方、ステンレス皿に早い段階で錆が出て衛生面が気になり、問い合わせ後に交換提案を受けた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/416008_10000986'),
('moizze-pet001','犬種不明・別カメラも併用',NULL,NULL,'camera cleaning value','価格に対してカメラ画質と分解洗浄のしやすさを評価した一方、遠隔でカメラ角度を変えられず、動体検知など一部機能は有料と感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/416008_10000986'),
('moizze-pet001','犬種不明・留守中給餌',NULL,NULL,'remote-feed camera stain','留守中でも給餌しながらカメラで様子を確認できる点に満足した一方、フードタンク内部に拭いても取れない汚れがあり気になった体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/416008_10000986'),
('moizze-pet001','犬種不明・ロック重視',NULL,NULL,'seal lock app','密閉感とロック機構、カメラ画質、アプリ接続のしやすさを評価した一方、初回操作は少し分かりにくいと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/416008_10000986'),
('moizze-pet001','犬種不明・初めてのカメラ給餌器',NULL,NULL,'camera app fixed-angle','カメラ画質とアプリの使いやすさには満足したが、フード皿とカメラの位置を遠隔で変えられない点は惜しいと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/416008_10000986'),
('moizze-pet001','犬種不明・旧機故障後に買い替え',NULL,NULL,'washability camera-angle','故障した旧給餌器から買い替え、取り外して洗えるステンレス皿と画質を評価した一方、カメラ角度が手動で皿全体を確認しにくく、別カメラを併用した体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/416008_10000986'),
('moizze-pet001','犬種不明・電源接触に注意',NULL,NULL,'wifi power height','アプリ設定は問題なかったが、電源コード接続が緩むとWi-Fiが切れやすく、皿位置も低いため台へ載せて使った体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/416008_10000986'),
('moizze-pet001','多頭飼い',NULL,NULL,'multi small-meals history','少量を複数回に分けて与えられ、フード音を合図に食べに来るようになった一方、多頭では誰がどれだけ食べたか後から確認できる録画履歴が欲しいと感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/416008_10000986'),
('moizze-pet001','犬・帰宅が遅くなる家庭',NULL,NULL,'dog remote camera portion','帰宅が遅くなる日に遠隔給餌でき、広い範囲のカメラで犬の様子も確認できた一方、手動給餌ボタンの操作と最小給餌量には改善余地を感じた体験。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/416008_10000986')
)
INSERT INTO reviews(product_id,dog_breed,dog_size,coat_type,needs,summary,source_type,source_url)
SELECT n.product_id,n.dog_breed,n.dog_size,n.coat_type,n.needs,n.summary,n.source_type,n.source_url
FROM new_reviews n
WHERE NOT EXISTS (
  SELECT 1 FROM reviews r
  WHERE r.product_id=n.product_id
    AND r.summary=n.summary
);


WITH new_reviews(product_id,dog_breed,dog_size,coat_type,needs,summary,source_type,source_url) AS (
VALUES
('take-one-p2pro',NULL,NULL,NULL,'setup stainless mic','ステンレス皿を外して洗える点と電源仕様は便利だった一方、オンライン説明書だけでは初期設定に手間取り、トーク機能もスマホ側のマイク設定を確認してようやく使えた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/z45bp4i4if/review/'),
('take-one-p2pro',NULL,NULL,NULL,'multi tray camera notification','2匹分の給餌に使い、給餌通知と留守中のカメラ確認は便利だった一方、受け皿は2匹には小さく、カメラにも死角があると感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/z45bp4i4if/review/2/'),
('take-one-p2pro','犬2頭・2台運用',NULL,NULL,'multi dog camera family portion','2匹目の犬にも同じ給餌器を追加し、それぞれのハウスを家族のスマホから確認。フードによって排出量が少し違うため実測して調整しながら使った体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/z45bp4i4if/review/2/'),
('take-one-p2pro',NULL,NULL,NULL,'portable-power remote-treat schedule','乾電池式の旧給餌器から変更し、ポータブル電源も使え、タイマー回数が多く、外出先からカメラを見ながら追加給餌できる点を便利に感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/z45bp4i4if/review/2/'),
('take-one-p2pro',NULL,NULL,NULL,'setup negative camera-quality','購入後なかなか接続できず1か月以上苦戦したが、接続成功後は以前の高価な機種よりカメラ映像が鮮明で評価が大きく変わった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/z45bp4i4if/review/2/'),
('take-one-p2pro',NULL,NULL,NULL,'schedule washability wide-camera','タイマーと細かな給餌量設定、広範囲のカメラ、取り外して洗える皿を日常使いしやすいと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/z45bp4i4if/review/2/'),
('take-one-p2pro',NULL,NULL,NULL,'backup-power fixation dry-agent','設定時刻に給餌器の前で待つほど習慣化し、モバイルバッテリーでも動作確認できた一方、本体を前足で動かすため家具へ固定し、タンクの乾燥剤置き場も工夫した体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/products/z45bp4i4if/review/2/'),
('wtw-ipet2971',NULL,NULL,NULL,'camera setup manual','本体サイズとカメラ画質には満足し、説明書はやや分かりにくかったものの設定自体は問題なく完了した体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=gohan&store_id=wtw'),
('wtw-ipet2971',NULL,NULL,NULL,'multi large-portion tray nightvision','多頭用に一度に約80g出すと皿へ山状に残りやすく、暗視では奥が暗く感じた一方、タンク容量の大きさは便利だった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=gohan&store_id=wtw'),
('wtw-ipet2971',NULL,NULL,NULL,'portion variation schedule','夜食を自動化するため使い、設定量より最大8gほど多く出ることがあったため、複数回実測して設定量を減らして調整した体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=gohan&store_id=wtw'),
('wtw-ipet2971',NULL,NULL,NULL,'quiet camera seal dish','説明書を見ながら約30分で接続でき、給餌音の静かさとカメラ・音声品質は高く感じた一方、プラスチック皿とタンクの密閉性は惜しいと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=gohan&store_id=wtw'),
('wtw-ipet2971',NULL,NULL,NULL,'realtime camera placement','カメラ映像がほぼリアルタイムで、設置角度を工夫すると留守中の行動まで確認でき、外出時の安心感につながった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=gohan&store_id=wtw'),
('wtw-ipet2971',NULL,NULL,NULL,'quiet-feed loud-voice dish-removal','少量ずつ回数を分けて給餌でき、フード排出音は静かだった一方、録音音声は大きく、皿を外す際に本体を少し持ち上げる必要があり手間に感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=gohan&store_id=wtw'),
('wtw-ipet2971',NULL,NULL,NULL,'camera-down stock app-separation','カメラを下向きにするとフード残量や実際の排出を確認しやすかった一方、皿が樹脂製で密閉性も気になり、同社の見守りカメラとは別アプリが必要だった体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=gohan&store_id=wtw'),
('wtw-ipet2971',NULL,NULL,NULL,'setup quiet smooth japanese-ui','アプリの日本語表現に分かりにくい部分はあったが30分ほどで接続でき、給餌動作は静かでスムーズ、カメラと音声も鮮明だと感じた体験。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?page_key=gohan&store_id=wtw'),
('petlibro-granary',NULL,NULL,NULL,'interval feeding low-food alert cleaning','早食い対策として食事を複数回に分け、時間と量をアプリから調整。分解清掃がしやすく、フード残量と乾燥剤交換の通知も便利だった体験。','public_buyer_review_summary','https://www.chewy.com/petlibro-granary-wifi-24g-5g/product-reviews/661214'),
('petlibro-granary',NULL,NULL,NULL,'server-outage schedule-failure negative','旅行中の定時給餌を任せていたところ、サービス障害中に予定給餌が実行されない事態があり、遠隔機器だけへ依存する怖さを感じた否定的体験。','public_buyer_review_summary','https://www.chewy.com/petlibro-granary-wifi-24g-5g/product-reviews/661214'),
('petlibro-granary',NULL,NULL,NULL,'multi special-diet timing','複数頭で食事内容を分けるため単体機を追加し、一方の給餌を1分早く設定することで別のフードを食べに行く問題を減らせた体験。','public_buyer_review_summary','https://www.chewy.com/petlibro-granary-wifi-24g-5g/product-reviews/661214'),
('petlibro-granary',NULL,NULL,NULL,'schedule outage-warning upsell','時間と量を簡単に設定でき音声呼びかけも使えた一方、システム障害の通知を見て外出中の給餌継続に不安を感じ、有料サービス案内の多さも気になった体験。','public_buyer_review_summary','https://www.chewy.com/petlibro-granary-wifi-24g-5g/product-reviews/661214'),
('petlibro-granary',NULL,NULL,NULL,'dual-bowl tarnish','シングル機から2皿モデルへ替え、2頭が別々の皿で食べやすくなった一方、2皿モデルのボウル表面が変色して見え、素材の耐久性が気になった体験。','public_buyer_review_summary','https://www.chewy.com/petlibro-granary-wifi-24g-5g/product-reviews/661230'),
('petlibro-granary',NULL,NULL,NULL,'weight-management schedule','食事スケジュールを整えながら摂取量を把握しやすくなり、体重管理に役立つと感じた体験。','public_buyer_review_summary','https://www.chewy.com/petlibro-granary-wifi-24g-5g/product-reviews/661230'),
('petlibro-granary',NULL,NULL,NULL,'away feeding simple','外出中の食事を任せる用途で、補充と操作が簡単で給餌時間を気にせず外出しやすくなった体験。','public_buyer_review_summary','https://www.chewy.com/petlibro-granary-wifi-24g-5g/product-reviews/661230'),
('petlibro-granary',NULL,NULL,NULL,'dual quiet even setup','2皿タイプを使い、静かで初期設定も簡単、フードも左右へ均等に出るケースでは多頭給餌が楽になった体験。','public_buyer_review_summary','https://www.chewy.com/petlibro-granary-wifi-24g-5g/product-reviews/661230'),
('petlibro-granary',NULL,NULL,NULL,'remote meal-call metal-bowl','遠方から操作でき、必要に応じて録音した食事呼びかけも使え、金属皿へフードが落ちる音自体が食事の合図になった体験。','public_buyer_review_summary','https://www.chewy.com/petlibro-granary-wifi-24g-5g/product-reviews/661214'),
('petlibro-granary',NULL,NULL,NULL,'large-capacity meal-sound','大容量タンクで決まった時刻に給餌でき、金属皿へ落ちる音だけでもペットが食事に気づくため、録音メッセージを使わず運用できた体験。','public_buyer_review_summary','https://www.chewy.com/petlibro-granary-wifi-24g-5g/product-reviews/661214')
)
INSERT INTO reviews(product_id,dog_breed,dog_size,coat_type,needs,summary,source_type,source_url)
SELECT n.product_id,n.dog_breed,n.dog_size,n.coat_type,n.needs,n.summary,n.source_type,n.source_url
FROM new_reviews n
WHERE NOT EXISTS (
  SELECT 1 FROM reviews r
  WHERE r.product_id=n.product_id
    AND r.summary=n.summary
);

SELECT COUNT(*) AS auto_feeder_product_count
FROM products
WHERE category='auto-feeder' AND active=1;

SELECT COUNT(*) AS auto_feeder_review_count
FROM reviews r
JOIN products p ON p.id=r.product_id
WHERE p.category='auto-feeder' AND p.active=1;
