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
| 事前 | 接続先確認 → 件数/指紋の記録 → Time Travel復元地点の記録 → SQLエクスポート |
| 事後 | 対象カテゴリの件数が想定通りか、他カテゴリの既存口コミ・商品が1行も変わっていないかを照合 |

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
2. ブランチは `develop`。`entry` を選び、まず **mode = dry-run**（書き込まない）で実行。
3. 承認画面（Review deployments）で **production-d1 を承認**。バックアップと件数確認だけ行われます。
4. ログで「接続先OK」「追加の見込み」を確認。問題なければもう一度 Run workflow:
   **mode = apply**、`confirm` に `ADD inu-taikenki` と入力 → 再度承認。
5. 緑のチェックなら事後照合まで合格です。サイトで該当ページを確認。

## 失敗したとき

- **途中で止まった/一部だけ入った**: SQLは再実行しても重複しません（商品は`INSERT OR IGNORE`、口コミは同一商品・同一要約がなければ追加）。dry-run → apply をやり直すと不足分だけ補われます（ローカルで検証済み）。
- **事後照合が不合格**: 実行を止め、ログの `time-travel info` の bookmark を控えて、運営者が判断して復元します。
  `npx wrangler d1 time-travel restore inu-taikenki --bookmark=<bookmark>`（直近30日）。復元は他の書き込みも巻き戻すため、内容を確認してから。
- **認証エラー**: トークン期限切れ/権限不足。Secretsを更新して dry-run からやり直し。

## PR #114（犬用ハーネス32商品・689件）の確認結果

- developと合成して競合なし。`migrations/0042` は追加のみ（INSERT OR IGNORE / NOT EXISTS）。口コミは50件ずつ、最大1文約18KB（D1上限100KB内）。
- ローカル検証: 689件追加、2回目・3回目の再実行で変化なし、既存口コミ・他カテゴリ不変、中途状態からの再実行で想定件数に収束。
- **未解決（そのため `approved_for_apply: false`）**: developの `release-data/README.md`（2026-10-16/17追加ルール）は、追加分に `review_sources` 登録、10%以上の再確認結果、AI要約の明記、犬/猫確認を求めています。#114のSQLは `review_sources` を使わず、これらの記録も見当たりません。確認と運営者の承認後、PRで `true` にします。
- #114はdevelopの #118/#119 より前のブランチです。取り込み時はdevelopを取り込み直し、sha256を更新してください。
- `migrations/0042` は #114 のマージで入ります（このPRには含めない）。それまで `plan` ジョブはファイル不在で止まります。
