# 犬体験記：developで確認し、mainへ一括公開

## 現在の状態（2026-09-28 JST）

- 本番: `main` → https://inu-taikenki.com （mainのWorkers Buildsのみが本番deployする）。
- 通常作業: 最新 `develop` から作業ブランチを作り、`develop` 向けPRで取り込む。
- Worker Previewsの初期設定は完了済み。同じWorker `inu-taikenki` のPreviewを使い、別Worker・D1の新設やコピーはしない。
- **固定Preview URL: https://develop.inu-taikenki.com** （`develop` の内容を表示）
- ユーザーのiPhone Safariで上記URLの表示を確認済み。
- ChatGPTの外部Web取得からは、現時点でこのURLへ直接アクセスできない。ChatGPTでの確認はスクリーンショットや取得済みHTMLなどで代替する。
- 作業ブランチ（develop以外）のPRでは「Workers Builds」が失敗表示になる。本番ビルドガード（`scripts/production-build-guard.mjs`）がmain以外を止める想定内の動作で、ガードは外さない。

## D1保護

Preview設定は既存本番D1 `inu-taikenki`、ID `a7339570-f395-48fd-8757-b5259a505560`、binding `DB` を参照する。
物理的なread-only接続ではない。保護はPreview専用入口とSQLラッパーで実施する。

- `src/preview-entry.ts` は本番ドメイン・APP_ENV不一致を拒否。GET/HEAD以外はDBに触れず405。
- アプリに本物のDBを渡さず、`src/readonly-db.ts` の凍結したラッパーだけを渡す。
- SELECTのみ許可。複数文、コメント、変更系キーワード、未知の関数、引用識別子を拒否。パラメーターはbindで渡す。
- all/firstでもSQL検査する。run/raw/exec/batch/withSession/dumpを拒否。新しいSELECTでも許可外構文なら失敗するのでテストして拡張する。
- 本番は元の入口・元のDB bindingのまま。Previewの制限は本番に適用しない。
- 将来アプリで `cloudflare:workers` のenvを直接importすると保護を迂回できるため禁止し、テストで監視。
- CLI、管理画面、悪意あるコード変更までDB権限で禁止する仕組みではない。保護コードの変更は必ず監査する。
- Previewの読み取りも本番D1の利用枠・負荷を共有する。負荷試験や大量クロールはしない。

## Preview運用（設定済み）

- Preview command は `npm run preview:publish`（内部で `wrangler preview --name develop --config wrangler.preview.json --ignore-base-config`）。標準の `npx wrangler preview` に戻さない。
- 設定は `wrangler.preview.json`（APP_ENV=preview、DB=既存inu-taikenki、ASSETS=public）。Base設定から余分なサービス・秘密情報を継承させない。Previewに本番secretは不要。
- ビルド環境はNode 24以上、Wranglerはpackage-lock.jsonに固定した4.135.0。
- `develop` が更新されると同じ固定URLのPreviewが更新される。
- 本番設定にはmain限定ビルドガードがある。旧versions uploadやdeployをmain以外で実行するとアップロード前に停止する。これは誤操作防止であり、環境変数の偽装や意図的なガード削除まで防ぐ権限境界ではない。
- Cloudflare Accessなどのログイン保護はPreviewに設定していない。noindexはアクセス制御ではないため、Previewには公開してよい情報だけを置く。

監査したcommit SHA / Deployment URL / 日時: **未記録**（監査のたびに記録する）

## 日々の開発

1. main/developをfetchして最新SHAと差分・未commit作業を確認。既存変更を捨てない。
2. 最新developから作業ブランチを作成し、文言・記事・デザイン・検索などを修正。
3. `npm ci` → `npm run check` → `npm run test:preview` → `npm run preview:check`。
4. 作業ブランチをpushし、develop向けPRを作成（developへ直接pushしない）。マージ後、https://develop.inu-taikenki.com でユーザーが実画面を確認する。
5. 監査承認時は固定URLだけでなく対象SHAとDeployment URLも記録。以後変更すれば再監査。
6. 普段はmainへマージしない。自動マージもしない。

商品・口コミは `release-data/` に出典・重複対策・想定件数を添えた差分SQLとして蓄積する。
**PreviewでSQLは適用しない。追加データの公開前Previewは対象外。**
記事がファイルならdevelopで確認できる。D1内に保存する記事なら同様に未適用データはPreviewには出ない。
既存のdb:seed/db:migrate:remoteコマンドは今回一切使わない。過去migrationの一括再実行もしない。

## 公開前の確認

自動確認:
```sh
npm run check
npm run test:preview
npm run preview:check
node scripts/audit-preview.mjs https://develop.inu-taikenki.com/
```

- トップ、全カテゴリ記事、商品選択と商品別口コミ、検索、分析、犬サイズ・犬種記事、主要ナビ、about/privacy/affiliate/editorial-policy。
- APIの実件数・商品別件数・ページ表示が一致。「100件なのに50件」の旧文言、全体数と検索結果数の取り違えがない。
- iPhone Safariで改行、横はみ出し、画像、表、メニュー、ボタン。ChatGPTに確認を頼む場合は、URLではなくスクリーンショット等を渡す。
- JS描画後のundefined/null/NaN、コンソールエラー、空状態・失敗状態。
- 商品切替、絞込、検索、もっと見る、重複・欠落・リンク切れ。
- 文言・出典・断定表現・未完成/薄い記事・ポリシー・AdSense対策。
- 全レスポンスのX-Robots-Tag noindex、HTML meta noindex、広告・GA通信の抑止。robots.txtはAllow（noindexを読ませるため）、sitemap/ads.txtは404。
- 本番向けcanonical/robots/sitemap/構造化データ/広告設定はgit diffで別途確認。Previewのnoindexを本番へ移さない。
- 公開PreviewへのPOST/PUT/PATCH/DELETEはダミー内容だけで405を確認。DB変更SQLを本番へ送って試験しない。

ローカルテスト（`npm run test:preview`）はSQL変更文の拒否・raw DBへの到達0、全APIクエリの互換性、インメモリDBの前後不変、HTTP書込遮断、既存静的/AdSense対策を確認する。
ローカルテストはPreview実環境・実D1件数・実ブラウザ表示の確認ではない。実画面の確認は固定Preview URLで行う。

## 一括公開

1. ユーザーの公開承認を得て、developの対象SHAを確定。最新mainを取り込んで差分・テスト・Preview監査をやり直す。
2. develop→mainのPRに監査結果、対象SHA、変更一覧、データ差分有無、復旧方針を記載。mainへ直接pushせず、承認後にまとめてマージする。
3. mainのWorkers Buildsが本番deployを行う。手動deployを重ねない。自動公開とD1適用をCIで連動させる設定は作っていない。
4. データ追加がある場合は、別途承認済み差分だけを既存本番D1へ適用する。適用前に復旧手段と既存データ保全を確認し、コードと互換性のある順序を決める。seed・初期化・全コピー・既存レビュー削除は禁止。
5. **コードのmainマージとD1更新は単一トランザクションではない。** 追加データはD1適用時に公開される。厳密な同時公開が必要な変更は、同一DB内の公開フラグ等を別途設計・承認してから実施する。今回勝手に追加しない。
6. 本番で主要ページ、API/件数/検索、モバイル、リンク、canonical、noindex混入なし、広告/ポリシーを確認。問題時はCloudflareの旧本番versionに戻す。コードrollbackではD1データは戻らない点に注意。
7. 公開後mainをdevelopへ取り込み、次回分を蓄積する。新しいD1は不要。

## 制限と公式資料

- 本番mainは確認時protected=false。誤マージを権限で防ぐには別途PR必須のブランチ保護が必要。今回変更なし。
- noindexはアクセス制御ではない。公開情報のみを置く。AdSense合格や全クローラーの遵守は保証できない。
- アプリ保護は将来の不適切なコード変更で外せる。SQL許可範囲を緩める際は必ず監査する。
- 実レスポンスヘッダー（noindex等）の確認と実D1件数照合は、公開前の確認時に固定Preview URLで行う。
- https://developers.cloudflare.com/workers/previews/
- https://developers.cloudflare.com/workers/previews/configuration/
- https://developers.cloudflare.com/workers/ci-cd/builds/configuration/
