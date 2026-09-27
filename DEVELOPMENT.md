# 犬体験記：開発・Preview・一括公開

## 現在の状態（2026-09-27）

**準備済み・運用開始前。Preview URLは未発行。Cloudflare側の設定確認が必要。**

- GitHub APIから再取得したmain: `c1e52669a2c5a86cddf73fe2b14d71f2b80edbd3`。
- mainのtree: `d5c460c7aaac4302c436fbe9677230e5ae840aae`。全ファイルのGit blob hashを照合済み。
- 長期ブランチ: `develop`（現在ローカルのみ。remote作成前にブランチ名の衝突を再確認）。
- 本番Worker名: `inu-taikenki`。入口 `src/final-entry.ts`、静的資産 `public/`。
- 本番設定上のDB: `inu-taikenki` / `a7339570-f395-48fd-8757-b5259a505560` / binding `DB`。
- 独自ドメイン: `inu-taikenki.com` と `www.inu-taikenki.com`。
- 現mainのWorkers Builds成功記録: build `ace4acfe-3c56-4d35-8444-9711242fa9e6`、version `f66d6192-3b99-4e79-b0db-5c49ca8c6bc7`。
- `.github/workflows` は存在しない。ただしGitHubの動的 `pages build and deployment` がmainで実行されている（run `36164272812`）。Cloudflareとは別であり、今回変更していない。
- Cloudflare管理画面は作業用ブラウザのセキュリティ検証で停止。実際のProduction branch、Build/Deploy/Previewコマンド、D1の現物・件数・バックアップ・workers.devサブドメインは未確認。
- 本番・main・本番D1の変更なし。seed.sql実行なし。GitHubへのpushも行っていない。

## 方針

mainは公開専用。通常はdevelopに次回公開分を蓄積する。小分けの作業ブランチを使う場合もdevelopから分岐し、developに戻す。
既存の本番入口・wrangler.jsonc・記事・商品・口コミを変更せず、Preview専用ファイルを追加した。
別Workerや別サービスは作らず、**同じWorker内のWorker Previews**を使用する。
公式仕様ではWrangler 4.135.0以上が必要。旧 `versions upload` と混同しない。

公式資料:
- https://developers.cloudflare.com/workers/previews/
- https://developers.cloudflare.com/workers/previews/configuration/
- https://developers.cloudflare.com/workers/previews/resources/

## 初回セットアップ（未実施）

1. Cloudflare Workers Buildsを読み取り確認。production branchがmainであること、現在のbuild/deployコマンドにDB操作がないことを確認。Preview対象はdevelopのみに限定する。既存の設定を記録し、Production側のコマンドを変更しない。
2. D1一覧とWorkerの実bindingを照合。本番DBを読み取りでexportし、スキーマ・全テーブル・カテゴリ別件数・商品ID・口コミID・出典情報・既存行内容を記録する。バックアップには非公開データが含まれる可能性があるためGitへ入れない。
3. `inu-taikenki-preview` という専用D1を作る。既存なら勝手に上書きしない。空の新DBに本番の検証済みスナップショットをインポートし、全テーブルと既存行を比較する。seed.sqlや過去のmigration一括適用で復元しない。
4. 両方の `wrangler.preview*.json` の未設定IDを実際の開発D1 IDに置き換える。コードに本番DBへのfallbackは設けない。
5. Node 24以上とWrangler 4.135.0以上（major 4）を用意し、実際に解決したバージョンでPreviewのdry-run/アップロードを検証する。現package.jsonの下限は旧版のため、運用開始時に検証済み版へ更新・lockfileを作成する。未検証のまま自動運用しない。
6. `node scripts/preview.mjs check` と下記ローカルテストを通す。developをcommitし、Cloudflare側が本番へ出さない設定と確認できてからGitHubへpush。
7. 読み取り確認とD1照合の完了を記録し、コマンドの実行環境に `INU_PREVIEW_SETUP_VERIFIED=1` を設定する。これは権限付与ではなく誤操作防止用の確認フラグ。
8. Previewコマンドは `node scripts/preview.mjs publish`。内部では `wrangler preview --name develop --config wrangler.preview.json` のみを実行する。`wrangler deploy` は使用しない。Cloudflare BuildsのPreview commandにも同じコマンドを設定。build commandにSQL操作を含めない。
9. 出力された**実URL**をここに記録する。固定URLと、その回のUnique Deployment URLを両方保存。URLを推測して記載しない。
10. iPhone SafariとChatGPTの双方で同じURLを開き、以下の監査を通す。ここまで完了して初めて運用開始。

**固定Preview URL: 未発行**
**Unique Deployment URL: 未発行**

## 普段の開発

1. 最新develop/mainをfetchして状態を確認。古い保存物で上書きしない。
2. 記事・文言・見た目・検索変更をdevelopへcommit。公開資産はpublic/、実際のWorker入口はsrc/final-entry.tsである点に注意。
3. 商品・口コミは出典を検証した差分SQLをrelease-data/へ追加。想定件数、重複回避、既存行保全、出典URLを併記する。開発D1への適用は1ファイルずつ `node scripts/preview.mjs apply release-data/対象.sql`。本番DBは触らない。
4. テスト後にPreviewを更新。同じ固定URLでユーザーとChatGPTが確認。承認時はcommit SHAとUnique Deployment URLも記録し、以後変更したら再確認。
5. 日々mainへマージしない。本番向けPRは公開単位でまとめる。自動マージしない。

## 保護の仕組み

- Preview専用設定は本番のroutesとD1 bindingを持たない。同じWorker名を使い、`previews.d1_databases` だけに開発D1を指定。
- 専用スクリプトは本番D1 ID/名前、ID未設定、2設定間の不一致、develop以外を拒否する。publishは未commit変更も拒否。
- 専用入口はAPP_ENVがpreviewでなければ503。本番ドメインでも503。GET/HEAD以外は405。これは公開APIの保護であり、SQL接続自体を読み取り権限にする機能ではない。実データ保護の本体は別D1 binding。
- 全リクエストをWorker経由にし、正常/リダイレクト/静的ファイル/404/例外にも `X-Robots-Tag: noindex, nofollow, noarchive` とno-storeを付ける。HTMLにもnoindex。robotsはAllowとしてnoindexを読めるようにする。sitemap/ads.txtはPreviewで404。
- Previewのみ広告・GAスクリプトを取り除き、CSPで外部スクリプト・外部API接続・iframeを抑止。本番の広告/解析/SEO設定は変更しない。
- noindexは検索エンジン向け指示で、秘密保持やすべてのbotの排除ではない。URLを知る人は閲覧できる。機密情報をPreviewや公開Gitに置かない。
- shellから直接別コマンドを実行することまでは防げない。運用ルールとCloudflare側のアクセス権も必要。

## 公開前チェック

自動のローカル確認（seed.sqlを使用しない）:
```sh
node --import ./tests/ts-loader.mjs --test tests/preview.test.mjs tests/static.test.mjs
node scripts/preview.mjs check
```
後者はD1未設定の現在は失敗するのが正しい。既存のnpm test/test:browserはseed.sqlを呼ぶため今回未実行。実行する場合も隔離されたテストDBであることを確認し、ユーザーのseed禁止指示がある間は実行しない。

実URLでの読み取り監査:
```sh
node scripts/audit-preview.mjs https://実際に発行されたPreviewホスト/
```
このコマンドはHTML/ヘッダー/内部リンク/APIの限定的な検査。レイアウト・文章の正しさ・全カテゴリの件数一致を自動で保証しない。

- [ ] トップ、全カテゴリ記事、商品選択と商品別口コミ、検索、分析、犬サイズ、犬種記事、about/privacy/affiliate/editorial-policyを表示。
- [ ] iPhone Safariで見出し改行、横スクロール、画像、表、ボタン、メニュー、空状態、読み込み失敗時を確認。ChatGPTも同じURLのブラウザ表示を確認。
- [ ] 動的描画後にundefined/null/NaN、JSエラー、崩れを確認。
- [ ] 全カテゴリの商品/口コミ件数をD1監査結果・API総件数・ページ表示と照合。もっと見るで欠落/重複がない。
- [ ] 犬種/サイズ/毛質/条件検索、商品切り替え、該当なしを試す。
- [ ] 文言統一、出典、断定表現、件数の意味、データにない犬属性の捏造がない。
- [ ] 内部リンク/画像/外部出典/アフィリエイトURLが正しい。商品詳細が外部ページの場合も確認。
- [ ] Previewの全種レスポンスでnoindex。広告・GAへの通信なし。本番へ勝手に遷移しない。
- [ ] 本番向けcanonical/robots/sitemap/構造化データ/広告タグはgit diffで別途確認。Previewのnoindexを本番ファイルへ混入しない。
- [ ] 薄い/重複/未完成の記事、説明不足、ポリシー不足がない。AdSense合格を保証するものではない。
- [ ] 承認対象のSHA、URL、データスナップショット、検証者、未解決事項を記録。

## データも含めた一括公開

**mainへのマージだけではD1は更新されない。本番D1に先にSQLを流すと先行公開になる。**
厳密に公開前の表示を維持する公開単位では、検証済み開発D1を公開用DBとして昇格し、コードとDB bindingを同じ本番Worker versionで切り替える。新しいサイトは作らない。

1. 公開承認を得てdevelopへの変更・開発D1への書き込みを凍結。mainの最新SHAと本番version/D1 IDを記録し、現在の本番D1をexport。
2. 最新本番と候補D1を全テーブル・全行で比較。旧行と出典が保全されており、承認された差分だけであることを確認。開発中に本番データが変わっていれば新しいスナップショットへ承認SQLだけを再適用し、再監査する。テスト行を含むDBは昇格させない。
3. 候補D1を以後本番専用として扱い、通常開発コマンドの対象から外す。次のdevelopには新しい別D1を割り当てる。**切替後の本番DBを開発用として再利用しない**。
4. 公開PRで本番 `wrangler.jsonc` のDB ID/名前をこの検証済み候補D1に切り替える。入口は `src/final-entry.ts` のまま。Preview専用設定は別D1へ更新するか未設定に戻し、保護スクリプトが本番IDを拒否することを確認。
5. mainへのPRにコード/データ差分、件数、監査結果、復旧用version/旧DBを添付。承認済みSHAでまとめてマージする。Cloudflareのmain自動デプロイに任せ、別途手動deployを重ねない。
6. 新versionが承認コードと候補D1を同時に参照していることを管理画面で確認。本番URLで表示・API・件数・検索・canonical・noindex混入なし・広告タグを確認。
7. 問題時は旧コードと旧DB bindingを持つ本番versionへ戻す。DB削除や復元SQLの上書きはしない。旧DBは確認完了まで保持。
8. mainをdevelopに取り込み、新しい開発D1を本番の検証済みスナップショットから準備して次回開発を再開。

コードのみの公開でD1差分がなければDB昇格は不要。Cloudflareの配信切替中は旧/新versionのリクエストが混在する可能性があるため、世界中の全リクエストを同一瞬間に変えるトランザクションは保証しない。

## 未完了と制限

- Cloudflare実設定・D1現物確認、開発DB作成/コピー、Wrangler新版での検証、remote develop作成、自動Preview設定、実URL発行、iPhone/ChatGPT実画面監査は未実施。
- mainはAPI確認時protected=false。今回権限/保護ルールは変更していない。運用開始後も手動の誤マージを技術的には禁止できていない。
- 既存GitHub Pagesの公開範囲は未監査。今回新サイトを作成/削除していない。
- PreviewとD1は同じCloudflareアカウントの利用枠を消費する。大量追加・アクセス時の上限は実アカウントで確認する。
