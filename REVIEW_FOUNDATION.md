# 大量レビュー対応の土台（収集・本番適用は未実施）

## 基準と監査

基準 main: `63620b84c42267ab08bdf2b4f89117e0f51c160e`（2026-09-18）。
作業ブランチ: `feat/scalable-review-foundation`。

実際の入口は `src/final-entry.ts` → `src/entry.ts` → `src/index.ts`。
公開アセットは `public/`。ルートの同名HTMLは今回変更しない。

リポジトリの既存SQLを使って、隔離したローカルDBに **73商品・750レビュー・15カテゴリ各50件** を再現した。
これは本番D1の直接監査ではない。本番の750件という申告と一致するが、本番の現時点の内容・migration履歴は未取得。

- products: id, name, category, asin, affiliate_url, active, created_at, updated_at。
- reviews: id, product_id, dog_breed, dog_size, coat_type, needs, summary, source_type, source_url, created_at。
- reviews.product_id → products.id は既存の外部キー。既存の CASCADE 定義も変更しない。
- サイズ・毛質・特徴は空白区切り文字列。犬種には年齢・体重・複数頭の表記が混在。
- source_url 欠損0件。source_type は existing_article_summary 94件、public_buyer_review_summary 456件、public_purchase_review_summary 200件。
- existing_article_summaryの94件は既存記事への参照。個別レビューの原出典まで今回再検証したわけではない。元の参照を維持し、将来の収集時に不足情報を確認する。
- 複数行で共有する出典URLが123個ある。URLだけを一意キーにすると正当な複数レビューを消すため、一意化しない。
- 同名商品「SHOWTECH ユニバーサル デュオピン」が2行：showtech-duopin-slicker（0レビュー）、showtech-duopin-undercoat（1レビュー）。型番・仕様同一の確認なしに統合しない。
- 既存 `seed.sql` は全 products / reviews を削除する。**本番で絶対に再実行しない**。
- 既存migrationには番号重複・まとめSQLがある。今回のために全migrationを本番で再実行しない。

## 追加migration

`migrations/0018_scalable_review_foundation.sql` は既存2テーブルの行・列・ID・要約・出典を更新／削除しない。

| 追加 | 用途 |
|---|---|
| product_identifiers | 検証済みGTIN・メーカー型番＋仕様のキーを商品IDへ対応。namespace + identifier に一意制約 |
| product_listings | Amazon・楽天・Yahooの掲載IDを同じ商品IDへ紐づけ。marketplace + external_id に一意制約 |
| review_sources | 将来の個別レビュー識別子・出典URL・出典種別。platform + individual review ID に一意制約 |
| review_attributes | 既存 size / coat / needs の明記済みトークンを検索用に分離。review_id + kind + value に一意制約 |
| review_attribute_tokens | 既存値を空白で分けるJSONベースのビュー。原文や推測属性は追加しない |
| 2トリガー | reviewsへのINSERT／対象属性UPDATE時に検索トークンを同期。DELETE時はFKで対応行のみ削除 |

検索属性は size 306、coat 311、trait 1475トークンをローカルで生成。
NULL・空文字・文字列 null は属性としない。英字を小文字化するが元のreviewsは不変。
犬種は既存 dog_breed をそのまま検索し、性格・特徴は trait で検索する。

追加index:

- review_attributes(kind, value, review_id) と主キー(review_id, kind, value)
- products(category, active, id)
- reviews(product_id, id)
- reviews(dog_breed, id)（犬種完全一致用）
- product_identifiers(product_id), product_listings(product_id), review_sources(review_id)

### 今後の登録ルール

1. products.id を販売店と独立した共通の商品IDとする。市場ごとにproducts行を新規作成しない。
2. 出典で確認したGTIN、またはメーカー・型番・サイズ／仕様を含む正規化キーを product_identifiers で照合する。
3. 同じ商品の販売ページは product_listings に追加するだけ。楽天は shop:item、Yahooは store:item 等、店舗を含む安定IDを使う。
4. 名称が似ているだけの場合・仕様の違い・既存IDの競合は保留し、人が確認する。既存73商品を推測で自動マージしない。
5. 新規レビューは識別可能な1体験の要約のみを reviews に保存。レビュー原文を保存する列やキャッシュを作らない。
6. 個別レビューIDが確認できれば review_sources に登録。共有一覧ページを個別レビューIDとして使用しない。ID不明の場合は既存の出典と要約で重複候補を確認する。

識別子や掲載情報の既存値からの推測バックフィルはしない。このブランチはread-only APIとスキーマの土台であり、商品登録・収集処理そのものは実装／実行していない。
DB制約は同じ検証済み識別子／掲載IDの二重対応を拒否する。識別子なしでproductsに直接INSERTする手作業まで自動的に同一商品と判定するものではない。

## API仕様

URLは維持し、検索・集計をDBへ移す。すべてGET・JSON・Cache-Control: no-store。

| API | 返却内容・ページング |
|---|---|
| /api/reviews | 絞り込んだ要約。既定20・最大100行、id昇順 |
| /api/products/:id/reviews | 同じ検索・ページング＋商品情報。商品不存在／非公開は404 |
| /api/products | 商品情報とreview_count。既定／最大100商品。offsetで次ページ |
| /api/reviews/groups | 条件に合う商品別件数＋各商品2件までの要約。既定／最大20商品。offsetで次ページ |
| /api/reviews/stats | 条件全体の件数、商品数、カテゴリ数、属性件数、記載率用件数、上位8商品の件数 |

レビュー／集計に共通の条件:

- category, product: 既存ID完全一致。
- size（dog_sizeも可）, coat（coat_typeも可）, trait（needsも可）: トークン完全一致。異なる条件同士はAND。
- breed: 犬種表記の部分一致。breed_mode=exact で完全一致。
- q: 商品名・犬種・既存属性・要約の部分一致。怖がり→scaredなど既存日本語別名も維持。
- 不明な属性値は0件。推測で条件を広げない。
- /api/products 自体の絞り込みはcategoryのみ。

ページ情報:

- count はページ行数ではなく、条件に合う全レビュー数。reviews.length が現在の返却行数。
- limit, has_more, next_cursor, next_offset を返す。商品一覧は total が全商品数。
- レビューは next_cursor を次回のcursorに渡す方式を推奨。大量のoffsetを読み飛ばさない。
- offsetも互換用途でサポート（0〜1,000,000）。cursorと正のoffsetの同時指定は400。
- groupsは count=全該当体験数、product_count=全該当商品数。groups内のcountはその商品の該当件数。
- ページ間で更新がある場合、件数は最新値。スナップショット固定ではない。
- 検索文字列上限200文字、犬種100文字。無効なlimit／ID／cursorは400、DB失敗は503。失敗時に全件取得へ戻さない。

例:

```text
/api/reviews?category=brush-pin&size=small&coat=curly&trait=scared&limit=12
/api/reviews?breed=トイプードル&limit=20
/api/reviews?category=brush-pin&limit=12&cursor=123
/api/reviews/groups?size=small&limit=10&offset=0
/api/reviews/stats?category=brush-pin&trait=scared
```

件数集計は一致行をDB側で数えるため、一定のDB処理は必要。
qと犬種部分一致は文字列走査であり、全文検索indexは今回入れていない。category/productで範囲を絞れる。
属性集計・カテゴリ集計は各100項目上限。将来語彙が100項目を超える場合は集計語彙のページング追加が必要。
新APIにより /api/reviews の無条件アクセスも最大100件。外部の未把握クライアントはページング対応が必要。

## 画面

ページURL・CSS・記事構成は維持。既存の「もっと見る」をサーバー側ページングに変更。

- 共通商品ブラウザー（/brush-pin等）：初回6件、追加8件。条件変更でサーバー再検索。
- /review-search：12件ずつ。商品分布は全件再取得せずstatsを使用。
- /dog-size：10商品ずつ。全レビューを読み込まずgroupsを使用。
- /breed-toy-poodle：12商品ずつ。カテゴリ内の表示商品分の体験件数を明示。
- /review-insights：statsを使用。
- /pet-dryer：既存独自ブラウザーも初回4件、追加6件に対応。
- 条件切替時は前のリクエストをabortし、遅い旧結果による上書きを防止。入力は250ms待って検索。
- 商品選択肢のみ必要に応じて100件ずつ取得。レビュー本文を全ページ自動収集するループはない。

## テスト

Node 24以上を使用。`npm install` → `npm run check` → `npm test`。
ブラウザー検証は `npx playwright install chromium` 後に `npm run test:browser`。
既存Chromium利用時は CHROMIUM_EXECUTABLE_PATH を指定できる。

- migration前後の全products/reviewsの完全一致・750件維持・再実行・FK整合。
- 全15カテゴリ×サイズ×毛質の旧条件判定との一致。
- 既存出典、NULL／複数属性、トリガー同期、個別レビューID／掲載ID競合。
- cursor全750件の重複／欠落なし、入力異常、SQLインジェクション文字列、非公開商品、空結果、DBエラー。
- 30商品×500件=15,000件の模擬データ追加。複数属性検索で12件のみ返す。性能悪化の回帰ガードあり。
- 全公開HTMLのinline JS・外部JS構文、必須URL、全件fetch依存の除去。
- Wranglerの隔離ローカルD1へ旧データ＋0018を適用し334 SQL文が成功。
- Worker dry-runビルド成功。本番デプロイ・本番D1操作・大量収集は0回。

375 / 390 / 430 / 768pxで7ページを検証。条件変更・ページ追加・遅延応答競合・503復帰・0件表示が成功。JavaScript例外0、横はみ出し0。日本語フォントを補ったChromiumでも成功。画像バイナリ自体は今回未変更・検証対象外。

ローカル速度は本番D1での速度保証ではない。

## 本番へ反映する順序・マージ条件

mainはCloudflare Git連携で自動デプロイされるので、**0018適用前にmainへマージしない**。

1. 本番DBをエクスポートし、保管する。既存schema・migration履歴を読み取り、想定スキーマと比較する。
2. `scripts/review-foundation-audit.sql` を読み取り実行し、750件・カテゴリ件数・ID範囲・出典を記録する。差異があれば先に調査。
3. 新しい0018だけを一度適用する。`seed.sql`／全migration一括適用は使わない。
4. 同じ監査SQLの前後結果を比較。ローカルと同じ完全照合が必要ならエクスポート同士も比較する。
5. PRをレビューし、上記確認後にmainへマージする。APIの小さな読取確認だけを行う。

今回、本番Cloudflareへの書込接続は使っていない。今すぐ無条件にマージしてよい状態ではなく、**0018の本番適用・保存確認後にマージ可能**。
旧Workerに戻しても追加テーブルは残してよい。元テーブルは変えていないため、rollbackでレビューを消したりseedを流したりする必要はない。

D1のSQL互換性はCloudflare公式資料も確認した：
[Cloudflare D1 SQL statements](https://developers.cloudflare.com/d1/sql-api/sql-statements/)

## 変更ファイル一覧

- `src/review-api.ts`（新規）、`src/index.ts`：API検索・集計・ページングとルーティング。
- `migrations/0018_scalable_review_foundation.sql`（新規）：追加スキーマと検索index。
- `public/db-review-browser.js`、`public/review-search.html`、`public/review-product-distribution.js`：商品別／全体検索のページングと分布集計。
- `public/dog-size.html`、`public/breed-toy-poodle.html`、`public/review-insights.html`、`public/pet-dryer.html`：全件取得依存除去と既存表示の互換対応。
- `tests/api.test.mjs`、`tests/database.mjs`、`tests/static.test.mjs`、`tests/browser.test.mjs`、`tests/ts-loader.mjs`（新規）：隔離DB・API・画面回帰テスト。
- `scripts/review-foundation-audit.sql`（新規）：本番適用前後の読取監査。
- `package.json`、`.gitignore`（新規）：テストコマンドと生成物除外。
- `README.cloudflare.md`、`REVIEW_FOUNDATION.md`（新規）：旧仕様への注意と今回の仕様・適用手順。

`public/brush-guide.html` / `public/brush-pin.html`、既存CSS、画像、既存migration、seed、wrangler設定は変更していない。
