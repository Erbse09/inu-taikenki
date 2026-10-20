# D1一括追加（iPhoneからGitHubで手動実行）

Cloudflare管理画面で口コミを50件ずつコピペする作業をなくすための仕組みです。
**ワークフローをmainに入れただけでは何も実行されません。** 本番D1への追加は、運営者が下の手順で明示的に実行したときだけ行われます。

## 1. 安全のしくみ（何が防いでくれるか）

| 項目 | 内容 |
|---|---|
| 手動のみ | `workflow_dispatch` だけ。schedule / push / PR では動きません |
| 実行場所はmainだけ | apply は `main` ブランチからしか動きません。Environment も main 限定にします |
| 対象DB固定 | 既存D1 `inu-taikenki`（ID末尾 `…5560`）。名前+IDが一致しなければ停止。新しいD1は作りません |
| 表の構造も確認 | `products` / `reviews` / `review_sources` / `review_attributes` と必要な列があるか確認してから進みます |
| 追加専用SQL | DELETE / UPDATE / DROP / REPLACE / CREATE 等を含むSQL、重複防止のない口コミINSERTは停止 |
| 内容固定 | `release-data/bulk-manifest.json` の sha256 とSQLが違うと停止 |
| 承認が3つ | ①mainの `approved_for_apply` が `true`（承認用PRのマージ）②GitHub Environment `production-d1` での承認ボタン ③確認文字 `ADD inu-taikenki` |
| 認証情報 | GitHub Secrets のみ。コード・ログ・チャットに出ません |
| 事前の記録 | 全テーブルの件数と**全行の内容ハッシュ**、Time Travel の復元地点（bookmark） |
| 事後の照合 | 実行前の全行が1文字も変わっていないこと／対象カテゴリ以外が1件も増減していないこと／`review_sources` の増加がちょうど677件／追加した口コミ・出典の中身がSQLどおり、をすべて確認 |
| DB内容の取り扱い | DBのエクスポートは作りません。GitHub（コード・Artifact・ログ）にDB内容は出ません。出るのは件数とハッシュ値だけです |

## 2. 全体の流れ（誰が何をするか）

| 段階 | 内容 | 運営者の操作 |
|---|---|---|
| 0 | AIが準備（ツール・SQL・記録・テスト・手順書）。**完了済み** | なし |
| 1 | 安全導入PR（ツールとSQLだけ。サイトの表示は変わらない）をmainへマージ | PRの「Merge」をタップ（1回） |
| 初回設定 | Cloudflareのトークン、GitHubの Environment（§3） | 約15分、初回だけ |
| 2 | dry-run（確認だけ。書き込みなし） | Run workflow ＋ 承認ボタン |
| 3 | 承認用PR（`approved_for_apply` を `true` にするだけ）をmainへマージ | 「Merge」をタップ（1回） |
| 4 | apply（本番D1へ追加） | Run workflow（確認文字つき）＋ 承認ボタン |
| 5 | サイトの公開（#114 を含む develop → main）。公開の指示は別途 | 指示のみ（AIがPRを作成）→ Merge |

**順番は 4（D1）→ 5（サイト）です。** 逆にすると、口コミが空のハーネスページが一時的に公開されます。
トップの総件数などはD1の数をその場で表示しているため、4の直後から増えます（1,595件→2,272件、カテゴリ15→16）。
その間、古いサイトにはハーネスのページがありません。**4と5は続けて（同じ日に、数分〜数十分以内で）行ってください。**

## 3. 初回だけの設定（運営者）

### 3-1. Cloudflare（Safari で dash.cloudflare.com）
1. ログインし、左上のメニューから **アカウントID** を控える（「Workers & Pages」の概要ページ右側、または URL の `dash.cloudflare.com/` の次の32桁）。
2. 右上の人型アイコン → **プロフィール** → **API トークン** → **トークンを作成** → 「カスタムトークン」→ **開始する**。
3. トークン名: `inu-taikenki-d1-bulk`。権限: **アカウント / D1 / 編集**（これだけ）。
4. アカウントリソース: **含める / （このアカウント1つ）**。
5. TTL（有効期限）: 開始と終了を設定。**終了日は今日から7日後**にする。
6. 「概要に進む」→「トークンを作成」。表示された長い文字列を「コピー」ボタンで**コピーするだけ**にして、次の 3-2 の入力欄に貼り付ける（スクリーンショット・メモ・チャットには残さない。一度しか表示されません）。

### 3-2. GitHub（Safari で github.com/Erbse09/inu-taikenki）
1. **Settings** → 左メニュー **Environments** → **New environment** → 名前 `production-d1` → Configure environment。
2. **Required reviewers** にチェック → 自分のアカウントを追加 → **Prevent self-review はオフ**（オンだと自分で承認できず進めません）→ Save protection rules。
3. **Deployment branches and tags** → 「Selected branches and tags」→ **Add deployment branch or tag rule** → `main` → Add rule。
4. **Environment secrets** → **Add environment secret**
   - 名前 `CLOUDFLARE_API_TOKEN` ／ 値: 3-1 でコピーしたトークン
   - 名前 `CLOUDFLARE_ACCOUNT_ID` ／ 値: 3-1 のアカウントID
5. **Settings → Actions → General** で「Allow all actions」（または「Allow Erbse09 actions…」）が有効で、Workflow permissions が「Read repository contents」であることを確認（初期値のままで可）。

iPhone のスマホ表示で項目が見つからないときは、Safari の「aA」→「デスクトップ用Webサイトを表示」にしてください。GitHubアプリには「Run workflow」が出ない場合があるので、**Safari を使います**。

### この設定の影響・必要な権限
- ワークフローの権限は `contents: read`（読み取りのみ）。コード変更・PR作成・デプロイはできません。
- 既存のWorkers Builds（mainの自動デプロイ）には触れません。Actionsの消費は実行時間（数分）のみ。
- Cloudflareトークンは **D1の編集権限** を持ち、同じアカウントの他のD1にも理論上は届きます。そのためコード側でDB名+IDを固定して照合しています。トークンは最小範囲・短期限にし、**終わったら Cloudflare で削除（ロール）** してください。
- 実行できる人はリポジトリへの書き込み権限者ですが、本番に触るジョブは Environment の承認が必須です。

## 4. dry-run（確認だけ。書き込みなし）

1. Safari で `github.com/Erbse09/inu-taikenki/actions` を開く。
2. 「All workflows」→ **D1一括追加（手動実行のみ）** を選ぶ。
3. 右の **Run workflow** をタップ。
   - Use workflow from: **main**
   - entry: `dog-harness-677`
   - mode: **dry-run**
   - confirm: **空のまま**
   - 緑の **Run workflow**。
4. 少し待つと実行が一覧に出る。タップして開く。
5. `remote` の所に黄色い「Waiting」と **Review deployments** が出る → タップ → `production-d1` にチェック → **Approve and deploy**。
6. 完了後、実行の画面を下へスクロールして **Summary**（要約）を読む。

**合格の目安（Summary）**
- 「本番D1には何も書き込んでいません」と書かれている。
- 口コミ・商品・出典の「追加される見込み」が **+677 / +32 / +677**。
- 実行前の件数が、今の本番（口コミ1,595・商品97）と同じか、近い値。
- ログに「接続先OK」「表の構造OK」「照合OK (dry-run)」がある。

どれかが違う、または赤い×が付いたら**そこで止めて**、スクリーンショットをAIに見せてください（トークンが写っていない画面だけ）。

## 5. apply（本番D1へ追加）

dry-run が合格してから進めます。

1. **承認用PRをmainにマージ**（`approved_for_apply` を `true` にするだけの小さなPR。AIが準備済み。Files changed に1行だけの変更が出ます）。
2. 前の 4 と同じ手順で **Run workflow**。今度は:
   - Use workflow from: **main**
   - entry: `dog-harness-677`
   - mode: **apply**
   - confirm: **`ADD inu-taikenki`**（半角・大文字小文字そのまま）
3. 同じく **Review deployments → Approve and deploy**。
4. 数分で完了。Summary に次が出れば成功:
   - 「本番D1に追加しました」
   - 口コミ・商品・出典の増加が **+677 / +32 / +677**
   - 「既存データの内容ハッシュ照合: 一致（1件も変わっていません）」
5. すぐに §2 の段階5（サイト公開）に進みます。

## 6. 実行後の確認（サイト公開後）

- トップ・口コミ検索の総件数が増えている（例: 2,272件・16カテゴリ）。
- `/dog-harness` が開き、「商品別に体験談を見る」で口コミが出る。各カードに「出典確認済み」と「確認できた投稿のあるページを見る」が出る。
- 既存カテゴリ（例: `/dog-clipper`、`/brush-pin`）の件数・表示が変わっていない。
- 終わったら Cloudflare のトークンを**削除**する。

## 7. 失敗したとき

- **dry-run の失敗**: 本番D1は変わっていません。ログの「停止:」の行を確認してAIに伝える。
- **途中で止まった／一部だけ入った**: SQLは再実行しても重複しません（商品は `INSERT OR IGNORE`、口コミは同一商品・同一要約があれば追加しない、出典は `(platform, source_review_id)` が一意）。もう一度 apply（承認用PRは `true` のまま）で不足分だけ補われます。
- **事後照合が不合格（既存データが変わった等）**: そのまま止め、Summary と、ジョブの「復元地点（Time Travel）」の bookmark を控える。復元は運営者が判断して、
  `npx wrangler d1 time-travel restore inu-taikenki --bookmark=<bookmark>`（直近の期間。保持日数はプランで異なる）。復元は**その後の他の書き込みも巻き戻す**ので、内容を確認してから。復元の直前の bookmark も表示されるので控える。
- **認証エラー**: トークンの期限切れ／権限不足。Cloudflare でトークンを作り直し、GitHub の Secret を更新して dry-run からやり直す。
- **新規分だけ取り消したい**: 新しい商品IDに紐づく行だけを対象にした別のレビュー済みSQLを作り、承認後に実行します（自動化していません）。

## 8. 非公開データの扱い

DBの中身（口コミ等）を含むファイルは、GitHub（コード・Artifact・Issue・ログ）に置きません。バックアップの正本は Cloudflare D1 の **Time Travel** です。手元にも残したい場合は、運営者が自分のPCから `npx wrangler d1 export inu-taikenki --remote --output <非公開の場所>` を実行し、非公開のクラウド／暗号化ストレージに保管してください（ワークフローには含めません）。

## 9. 今回のデータ（ハーネス677件）の状態

- 出典監査: `audit/review-source-20261018-harness/`。689件中、対応する公開投稿を確認できた677件だけをSQLに残し、確認できなかった12件（動画4件・見つからず8件）は追加しない。判定はAI（Claude）によるもの。
- 無作為80件（11.8%）を確認先から取得し直して再照合し、80/80件一致。自動判定(A)106件のうち30件を全文で読み直し、30/30件一致。
- 677件の投稿識別情報を `review_sources` に登録（同じSQLに含む。追加のみ）。
- ローカル検証（メモリSQLite）: 677件追加／2・3回目の再実行で変化なし／既存口コミ・他カテゴリ・他テーブル不変／中途状態から再実行して収束。
- 残る課題: 要約が定型（平均61文字・99.9%が「体験。」終わり）、第一者情報なし。AdSense対策として別途検討が必要です。
