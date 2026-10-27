# 新規購入ガイド3本：保留中のAmazon検索リンク（未掲載）

2026-10-27時点で、以下9本のAmazon検索リンクは**記事に掲載していない**。
Claude Code実行環境からAmazonは自動アクセスを遮断し（curl: HTTP 503、Chromium: 検索結果0件の汎用ページ）、
検索先に該当商品（型番・サイズ・包装）が表示されることを確認できなかったため。別商品や直接ASINでの代用もしていない。
リンクはWork成果物「05｜情報源・商品・広告リンク確認表」の検索語とtag（`100things-22`）をそのまま使用している。

掲載する場合の手順（通常のブラウザで人が確認する）:

1. 下表のリンクを開き、tag=`100things-22` が維持され、検索結果に対象の型番・サイズ・包装が表示されることを確認する。
2. 一致しない商品は掲載しない。一致を確認したものだけ、公式リンクの隣に `rel="sponsored noopener" target="_blank"` 付きで追加し、記事冒頭のPR表記を「広告リンクを含みます」に戻す。
3. `tests/static.test.mjs` の「Amazonリンクを含まない」検査を、確認済みリンクに合わせて更新する。

| ID | 記事 | 商品 | 検索リンク |
| --- | --- | --- | --- |
| C1 | dog-crate-size-guide | ファインR ダブルドア S | https://www.amazon.co.jp/s?k=%E3%83%AA%E3%83%83%E3%83%81%E3%82%A7%E3%83%AB%20%E3%82%AD%E3%83%A3%E3%83%B3%E3%83%94%E3%83%B3%E3%82%B0%E3%82%AD%E3%83%A3%E3%83%AA%E3%83%BC%E3%83%95%E3%82%A1%E3%82%A4%E3%83%B3R%20%E3%83%80%E3%83%96%E3%83%AB%E3%83%89%E3%82%A2%20S&tag=100things-22 |
| C2 | dog-crate-size-guide | ファインR ダブルドア M | https://www.amazon.co.jp/s?k=%E3%83%AA%E3%83%83%E3%83%81%E3%82%A7%E3%83%AB%20%E3%82%AD%E3%83%A3%E3%83%B3%E3%83%94%E3%83%B3%E3%82%B0%E3%82%AD%E3%83%A3%E3%83%AA%E3%83%BC%E3%83%95%E3%82%A1%E3%82%A4%E3%83%B3R%20%E3%83%80%E3%83%96%E3%83%AB%E3%83%89%E3%82%A2%20M&tag=100things-22 |
| C3 | dog-crate-size-guide | ATC-530 ダークグレー | https://www.amazon.co.jp/s?k=%E3%82%A2%E3%82%A4%E3%83%AA%E3%82%B9%E3%82%AA%E3%83%BC%E3%83%A4%E3%83%9E%20ATC-530%204967576593533&tag=100things-22 |
| G1 | dog-indoor-gate-fit-guide | スマートゲイト2 | https://www.amazon.co.jp/s?k=%E6%97%A5%E6%9C%AC%E8%82%B2%E5%85%90%20%E3%83%9A%E3%83%83%E3%83%88%E3%82%BB%E3%83%AC%E3%82%AF%E3%83%88%20%E3%82%B9%E3%83%9E%E3%83%BC%E3%83%88%E3%82%B2%E3%82%A4%E3%83%882&tag=100things-22 |
| G2 | dog-indoor-gate-fit-guide | 木製おくだけドア付ゲート M | https://www.amazon.co.jp/s?k=%E3%83%AA%E3%83%83%E3%83%81%E3%82%A7%E3%83%AB%20%E3%83%9A%E3%83%83%E3%83%88%E7%94%A8%20%E6%9C%A8%E8%A3%BD%E3%81%8A%E3%81%8F%E3%81%A0%E3%81%91%E3%83%89%E3%82%A2%E4%BB%98%E3%82%B2%E3%83%BC%E3%83%88%20M%20058481&tag=100things-22 |
| G3 | dog-indoor-gate-fit-guide | おくだけとおせんぼスマートワイド | https://www.amazon.co.jp/s?k=%E6%97%A5%E6%9C%AC%E8%82%B2%E5%85%90%20%E3%83%9A%E3%83%83%E3%83%88%E3%82%B2%E3%83%BC%E3%83%88%20%E3%81%8A%E3%81%8F%E3%81%A0%E3%81%91%E3%81%A8%E3%81%8A%E3%81%9B%E3%82%93%E3%81%BC%E3%82%B9%E3%83%9E%E3%83%BC%E3%83%88%E3%83%AF%E3%82%A4%E3%83%89&tag=100things-22 |
| S1 | dog-pet-sheet-cost-guide | ES-N200 200枚 | https://www.amazon.co.jp/s?k=%E3%82%A2%E3%82%A4%E3%83%AA%E3%82%B9%E3%82%AA%E3%83%BC%E3%83%A4%E3%83%9E%20ES-N200%204967576456791&tag=100things-22 |
| S2 | dog-pet-sheet-cost-guide | CPS-88 88枚（CSPS-88ではない） | https://www.amazon.co.jp/s?k=%E3%82%A2%E3%82%A4%E3%83%AA%E3%82%B9%E3%82%AA%E3%83%BC%E3%83%A4%E3%83%9E%20CPS-88%204967576482080&tag=100things-22 |
| S3 | dog-pet-sheet-cost-guide | デオシート無香消臭 レギュラー112枚（112枚×4ではない） | https://www.amazon.co.jp/s?k=%E3%83%87%E3%82%AA%E3%82%B7%E3%83%BC%E3%83%88%20%E3%81%97%E3%81%A3%E3%81%8B%E3%82%8A%E8%B6%85%E5%90%B8%E5%8F%8E%20%E7%84%A1%E9%A6%99%E6%B6%88%E8%87%AD%20%E3%83%AC%E3%82%AE%E3%83%A5%E3%83%A9%E3%83%BC%20112%E6%9E%9A&tag=100things-22 |
