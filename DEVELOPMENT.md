# 犬体験記：developで確認し、mainへ一括公開

## 現在の状態（2026-09-27 UTC）

- 開始時main: `c1e52669a2c5a86cddf73fe2b14d71f2b80edbd3`。通常作業は長期ブランチ `develop`。
- 前回のローカルcommit `6ce041f0f7db22c427346614d6907693e73f072c` を引き継ぎ、別D1案を撤回。
- 同じWorker `inu-taikenki` のWorker Previewsを使用。別Worker・別ドメイン・D1の新設やコピーはしない。
- **Preview URLは未発行。Cloudflareの切替操作と実URL検証が完了するまで運用完成とは扱わない。**
- 本番入口 `src/final-entry.ts` と `public/` は変更していない。mainへマージせず、本番deploy・D1操作・seed実行はしていない。
- GitHub内の `.github/workflows` はなし。mainには動的GitHub Pages buildの履歴あり。これはCloudflareとは別の既存設定で、変更していない。
- 提供されたCloudflare画面ではproduction branch=main、非本番build有効、build command=None、deploy=`npx wrangler deploy`、旧version command=`npx wrangler versions upload`、root=/。
- Cloudflare管理画面は作業ブラウザのセキュリティ検証で停止。現在の管理画面設定・実D1 binding・本番versionをAPIで再照合できていない。
- Wranglerのwhoamiでも未認証を確認。URL発行には上記Cloudflare側の初回操作が必要。別アカウントの仮サイトを作る回避策は使わない。

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

## 初回：Cloudflareで一度だけ行う操作

1. 既存Worker **inu-taikenki → Settings → Builds** を開く。Production branchは**main**のまま。Build commandはNone、Deploy commandは `npx wrangler deploy`、rootは `/` のまま。非本番buildを有効にし、対象を指定できる場合はdevelopに限定する。
2. **Set up Worker Previews** を開く。設定はdevelop内の `wrangler.preview.json` に記載済み（APP_ENV=preview、DB=既存inu-taikenki、ASSETS=public）。新DB・DBコピー・新Workerは作らない。管理画面のPreview設定を入力する場合も同じ値だけを使い、Production設定は変更しない。
3. 設定確認のチェックを入れ、**New preview command** を `npm run preview:publish` に変更する。標準の `npx wrangler preview` のままにしない（専用設定・書込保護入口が必要）。
4. 旧モデルへ戻せないという警告を確認して **Switch to Worker Previews**。既存Productionのデプロイを実行しない。
5. ビルド環境はNode 24以上。必要ならBuild variable `NODE_VERSION=24` を設定。依存はpackage-lock.jsonに固定したWrangler 4.135.0を利用。
6. developの最新commitだけをRetry/Rebuild。旧command時のdevelop buildが失敗していても安全停止なので、mainを再deployしない。
7. Preview `develop` のworkers.dev URLを取得。ログインを要求するCloudflare AccessはこのPreviewに設定しない。組織側のAccessポリシーがある場合は無断解除せず管理者に確認。
8. 固定Preview URLを下欄へ記録し、SafariとChatGPTで監査する。設定後は通常developへのpushで同じPreviewが更新される。

固定Preview URL: **未発行（実際の出力を記録。推測しない）**
監査したcommit SHA / Deployment URL / 日時: **未記録**

内部コマンドは `wrangler preview --name develop --config wrangler.preview.json --ignore-base-config`。
Base設定から余分なサービス・秘密情報を継承させない。Previewに本番secretは不要。
本番設定にはmain限定ビルドガードを追加済み。旧versions uploadやdeployをdevelopで実行するとアップロード前に停止する。
これは誤操作防止であり、環境変数の偽装や意図的なガード削除まで防ぐ権限境界ではない。

## 日々の開発

1. main/developをfetchして最新SHAと差分・未commit作業を確認。既存変更を捨てない。
2. developで文言・記事・デザイン・検索などを修正。
3. `npm ci` → `npm run check` → `npm run test:preview` → `npm run preview:check`。
4. developへcommit/push。Workers Buildsの成功を確認し、固定Preview URLでユーザーとChatGPTが確認。
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
node scripts/audit-preview.mjs https://実際のPreviewホスト/
```

- トップ、全カテゴリ記事、商品選択と商品別口コミ、検索、分析、犬サイズ・犬種記事、主要ナビ、about/privacy/affiliate/editorial-policy。
- APIの実件数・商品別件数・ページ表示が一致。「100件なのに50件」の旧文言、全体数と検索結果数の取り違えがない。
- iPhone Safariで改行、横はみ出し、画像、表、メニュー、ボタン。ChatGPTでも同じURLを取得し、可能ならブラウザ描画を確認。
- JS描画後のundefined/null/NaN、コンソールエラー、空状態・失敗状態。
- 商品切替、絞込、検索、もっと見る、重複・欠落・リンク切れ。
- 文言・出典・断定表現・未完成/薄い記事・ポリシー・AdSense対策。
- 全レスポンスのX-Robots-Tag noindex、HTML meta noindex、広告・GA通信の抑止。robots.txtはAllow（noindexを読ませるため）、sitemap/ads.txtは404。
- 本番向けcanonical/robots/sitemap/構造化データ/広告設定はgit diffで別途確認。Previewのnoindexを本番へ移さない。
- 公開PreviewへのPOST/PUT/PATCH/DELETEはダミー内容だけで405を確認。DB変更SQLを本番へ送って試験しない。

ローカル検証済み: 16テスト成功。SQL変更文の拒否・raw DBへの到達0、全APIクエリの互換性、インメモリDBの前後不変、HTTP書込遮断、既存静的/AdSense対策テスト。
seedは不使用。Wrangler 4.135.0で本番/Preview入口のdry-runとdevelopの旧upload拒否を検証。
**dry-runはリモートPreview発行・D1接続・実ブラウザ表示の確認ではない。実URLでの検証は未完了。**

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
- Safari実機、外部ChatGPTアクセス、実レスポンスヘッダー、実D1件数照合はURL発行後に実施する。
- https://developers.cloudflare.com/workers/previews/
- https://developers.cloudflare.com/workers/previews/configuration/
- https://developers.cloudflare.com/workers/ci-cd/builds/configuration/
