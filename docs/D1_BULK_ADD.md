# D1一括追加（iPhoneからGitHubで手動実行）

Cloudflare管理画面で口コミを50件ずつコピペする作業をなくすための仕組みです。
**このPRを取り込んだだけでは何も実行されません。** 本番D1への追加は、運営者が下の手順で明示的に実行したときだけ行われます。

## 安全の仕組み

| 項目 | 内容 |
|---|---|
| 手動のみ | `workflow_dispatch` だけ。schedule/push/PRでは動かない |
| 対象DB固定 | 既存D1 `inu-taikenki`（ID末尾 `…5560`）。名前+IDが一致しないと停止。新規D1は作らない |
| 追加専用SQL | DELETE/UPDATE/DROP/REPLACE/CREATE等を含むSQL、重複防止のない口コミINSERTは停止 |
| 内容固定 | `release-data/bulk-manifest.json` のsha256とSQLが違うと停止 |
| 三重の確認 | ①manifestの `approved_for_apply: true`（PRレビュー）②GitHub Environment `production-d1` の承認 ③確認文字 `ADD inu-taikenki` |
| 認証情報 | GitHub Secretsのみ。コード・ログ・チャットに出さない |
| 事前 | 接続先確認 → 全テーブルの件数と**全行の内容ハッシュ**を記録 → Time Travel復元地点をログに記録 |
| 事後 | 実行前に存在した全行（全テーブル）を同じ範囲で再計算したハッシュと比較。1文字の書き換え・削除も検知。想定外のテーブル変更・件数も停止 |
| 非公開データ | DBのエクスポートはRunnerに保存せず、Artifactやリポジトリにもアップロードしない。ハッシュ値だけを扱う（本文は出力しない） |

## ⚠️ iPhoneの Run workflow ボタンが出る条件（mainへの導入が必要）

GitHub Actionsの手動実行（`workflow_dispatch`）は、**ワークフローのファイルがデフォルトブランチ（main）にないと、Actions画面の左一覧に出ず「Run workflow」も押せません**。
したがって「developにマージすればiPhoneから実行できる」は誤りでした。developだけでは、画面から手動実行できません。

### mainへの安全な導入案（mainへはまだマージしません。運営者が公開を指示したときだけ）
推奨は**次回の通常公開（develop→main）に同梱**するか、急ぐ場合は**専用の小さなPR**にすることです。

1. 専用PRに入れるのは `.github/workflows/d1-bulk-add.yml`、`scripts/d1-bulk/`、`release-data/bulk-manifest.json`、`docs/`、`tests/d1-bulk.test.mjs` のみ（サイトのコード・DB・SQLは含めない）。サイト表示は変わりませんが、mainのマージはWorkers Buildsの本番ビルドが走るため、通常の公開と同じ承認で行う。
2. mainに入った時点では何も実行されません（自動トリガーなし）。`approved_for_apply: false` のままなので、追加データはapplyできません。
3. 実行時は **Use workflow from: main**（推奨）を選びます。コードとSQLが同じmainにあるものだけが実行対象になり、developの未レビュー変更で本番トークンが使われません。この場合、追加SQL（`migrations/0042…`）がmainにある必要があり、**#114の公開（または同じ内容のマージ）後**になります。
4. Environment `production-d1` の「Deployment branches」は **main のみ**を推奨（今回の手順ではdevelopからのapplyは非推奨）。`develop` を許可すると、developに書き込める人がレビュー前のコードで本番トークンを使える余地が生じます。dry-runを先に試したい場合のみ一時的にdevelopを許可し、終わったら外してください。
5. ワークフロー内のゲートは、applyを `develop` / `main` のrefに限定しています。さらにmainのみに絞る場合は `scripts/d1-bulk/remote.mjs` の正規表現を変更する小さなPRを別に出します（今回は変更していません）。

注意: GitHubのスマホアプリではワークフローの手動実行ボタンが使えない場合があります。その場合はSafariでGitHubのWebサイトを開き、必要なら「デスクトップ用Webサイトを表示」にしてください。

## 初回だけ必要な設定

1. **Cloudflare APIトークン作成**（dash.cloudflare.com → 右上アイコン → マイプロフィール → APIトークン → トークンを作成 → カスタム）
   - 権限は **アカウント / D1 / 編集** のみ。リソースは対象アカウント1つだけ。有効期限は短め（例: 1か月）。
   - トークンは一度しか表示されません。**チャットや画面共有に貼らない**。
   - アカウントIDはCloudflareの Workers & Pages 概要ページ右側にあります。
2. **GitHub Environment を作る**: リポジトリ → Settings → Environments → New environment → 名前 `production-d1`
   - 「Required reviewers」に自分を追加（承認ボタンになります）。
   - 「Deployment branches」を `develop` と `main` に限定。
   - Environment secrets に `CLOUDFLARE_API_TOKEN` と `CLOUDFLARE_ACCOUNT_ID` を登録。
3. 使い終わったらCloudflareでトークンを削除してください。

### 設定の影響・必要な権限
- ワークフローの権限は `contents: read`（読み取りのみ）。コード変更・PR作成・デプロイはできません。
- 既存のWorkers Builds（main自動デプロイ）には触れません。Actionsの消費は実行時間（数分）のみ。
- Cloudflareトークンは **D1の編集権限** を持ち、同じアカウントの他のD1にも理論上届きます。そのためコード側でDB名+IDを固定し照合しています。トークンは最小範囲・短期限にしてください。
- 実行できる人はリポジトリへの書き込み権限者ですが、本番に触るジョブは承認者の承認が必須です。

## 毎回の手順（iPhone）

1. GitHub → リポジトリ → **Actions** → 「D1一括追加（手動実行のみ）」 → **Run workflow**
2. 「Use workflow from」は `main`（上記の手順で導入後）。`entry` を選び、まず **mode = dry-run**（書き込まない）で実行。
3. 承認画面（Review deployments）で **production-d1 を承認**。バックアップと件数確認だけ行われます。
4. ログで「接続先OK」「追加の見込み」を確認。問題なければもう一度 Run workflow:
   **mode = apply**、`confirm` に `ADD inu-taikenki` と入力 → 再度承認。
5. 緑のチェックなら事後照合まで合格です。サイトで該当ページを確認。

## 復旧手順と非公開データの扱い

**原則: DBの中身（口コミ等）を含むファイルは、GitHub（コード、Artifact、Issue、ログ）に置かない。** リポジトリが公開でも非公開でも同じ扱いです。バックアップの正本はCloudflare D1の **Time Travel**（過去の任意時点に戻せる仕組み。保持日数はプランで異なり、Freeは7日・有料は30日。Cloudflareの現行仕様を確認してください）です。

1. 実行前: ジョブが復元地点（bookmark）をジョブのSummaryに記録します（bookmark自体は秘密情報ではありません）。
2. 念のため手元にも残したい場合は、運営者が**自分のPCから** `npx wrangler d1 export inu-taikenki --remote --output <非公開の場所>` を実行し、非公開のクラウド/暗号化ストレージに保管します（ワークフローには含めません）。
3. **途中で止まった/一部だけ入った**: SQLは再実行しても重複しません。dry-run → apply をやり直すと不足分だけ補われます（ローカルで検証済み）。
4. **事後照合が不合格**: そのまま止めて内容を確認します。復元が必要なら、Summaryのbookmarkを使い、運営者が判断して
   `npx wrangler d1 time-travel restore inu-taikenki --bookmark=<bookmark>` を実行します。
   - 復元は**その後の他の書き込みもすべて巻き戻します**。実行後に別の更新（口コミ追加等）があった場合は、先に内容を確認してください。
   - 復元しても、復元直前の状態に戻すためのbookmarkがCloudflareから表示されます。それも控えてください。
5. 追加が想定どおりで「新規追加分だけ取り消したい」場合は、新規商品（manifest記載のID）に紐づく行のみを対象にした別のレビュー済みSQLを作り、運営者の承認後に実行します（自動化しません）。
6. **認証エラー**: トークン期限切れ/権限不足。Secretsを更新して dry-run からやり直し。

## PR #114（犬用ハーネス32商品）の状態（2026-10-18 更新）

- 出典監査の記録: `audit/review-source-20261018-harness/`。689件のうち**対応する公開投稿を確認できた677件だけ**を `migrations/0042` に残し、確認できなかった12件（動画4件・見つからなかった8件）は追加しない。
- 677件それぞれの投稿識別情報を `review_sources` に登録する（同じSQLに含む。追加のみ）。manifest の `expected_review_sources: 677`。事後照合でも件数を確認する。
- 無作為に80件（11.8%）を確認先ページから取得し直して再照合し、80/80件で一致。確認はAI（Claude）によるもので、人の目ではない。
- ローカル検証（メモリSQLite）: 677件追加／2・3回目の再実行で変化なし／既存口コミ・他カテゴリ・他テーブル不変／中途状態から再実行して収束。
- `approved_for_apply` は **false のまま**。運営者が内容（要約の定型性・AI要約の扱い）を確認して承認するまで apply はできません。
- dry-run を実行できる条件: ①このPR #114（または同じ内容）が、実行する場所（mainまたは実行元ブランチ）に含まれている ②ワークフローがmainに導入済み（上記「mainへの導入が必要」）③Environment `production-d1` とSecretsが設定済み。**いずれも未実施なので、現時点ではdry-runも実行できません。**
- #114はdevelopへ未マージです。マージは運営者の承認後です。
