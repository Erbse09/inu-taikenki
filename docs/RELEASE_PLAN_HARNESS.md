# 犬用ハーネス公開計画（二段階公開）

本番D1への追加（口コミ677件）と、サイト側の公開（`/dog-harness` など）を、**別々に・安全な順序で**行うための計画です。
操作手順（iPhone向け）は [D1_BULK_ADD.md](D1_BULK_ADD.md) を参照してください。

## 1. なぜ二段階にするか

- ワークフローは、ファイルが**デフォルトブランチ（main）にないとiPhoneの Actions 画面に出ません**。SQL（`migrations/0042`）も、実行する場所（main）に必要です。
- 一方 `develop` には、まだ本番に出していない変更（AdSense対策 #118・#119 など、mainと49ファイルの差）が入っており、ハーネスのサイト側（#114）はそれらの上に作られています。**サイト側だけを先に出すことはできません**（#114 は #118 の出典台帳の仕組みに依存）。
- そこで、**ツールとSQLだけ**を先にmainへ入れる「段階1」と、サイト側の公開「段階5」を分けます。段階1はサイトの表示・動作を一切変えません。

## 2. ブランチ（AIが準備済み・いずれもPR未作成／未マージ）

| ブランチ | 内容 | main との差 |
|---|---|---|
| `release/d1-bulk-stage1` | 段階1：ワークフロー、`scripts/d1-bulk/`、manifest（`approved_for_apply: false`）、`migrations/0042`（677件）、監査記録、手順書、テスト | 14ファイル追加のみ。`src/`・`public/`・`wrangler.jsonc`・`package.json` は**変更なし** |
| `release/d1-bulk-approve` | 段階3：manifest の `approved_for_apply` を `true` にするだけ（段階1の上の1コミット） | 1ファイル・3行 |
| `claude/dog-harness`（PR #114） | サイト側（`/dog-harness`、商品別比較、内部リンク、出典表示など）＋ 段階1の履歴を取り込み済み | — |

- 段階1のファイルは #114 と**内容が同一**で、#114 に段階1の履歴を取り込み済みです。そのため後の統合（段階5）で競合しません（`git merge-tree` で確認済み）。
- **段階1のPRは「Create a merge commit」でマージしてください**（Squash は不可。承認用ブランチが段階1の上に作ってあるため）。
- main向けPRは、運営者の指示があったときにAIが作成します（作業ルール：mainへのPRは公開指示がある場合のみ）。

## 3. 公開順序

```
 段階1  安全導入PR（ツール＋SQL）→ main        ← サイト表示は不変。Workers Builds が走るが、公開されるコードは同じ
 初回設定  Cloudflareトークン／GitHub Environment（運営者・約15分）
 段階2  dry-run（書き込みなし）→ 結果を確認
 段階3  承認用PR（approved_for_apply: true）→ main
 段階4  apply（本番D1へ追加）                   ← ここで初めて「677件」がD1に入る
 段階5  サイト公開（#114 → develop → main）     ← 段階4の直後（同日）に
```

### 「677件」を、D1更新より前に見せない方法
- 段階1〜3のmain変更には、サイトのコード・HTMLが含まれません。したがって、**D1を更新するまで、サイトのどこにもハーネスの件数は出ません**。
- サイト側（段階5）のトップのカードからは、固定の件数表記（「677」）を**削除済み**です（「32比較商品」「条件検索」のみ）。`/dog-harness` 内の件数は、D1の現在の数を表示します。
- 段階5を段階4より前に行うと、トップに `/dog-harness` へのカードが出るのに口コミが空、という状態になります。**必ず 段階4 → 段階5 の順**にします。
- 段階4の直後〜段階5の前は、古いサイトのままD1の数だけが増えます（総件数 1,595→2,272、カテゴリ 15→16）。ハーネスのページがまだ無い短い期間です。段階4と5は続けて行ってください。

## 4. 運営者が行う操作（最小限）

| # | 操作 | 回数・所要 |
|---|---|---|
| 1 | 段階1のPRをマージ（Create a merge commit） | 1タップ |
| 2 | Cloudflare：アカウントIDを控える／APIトークン作成（D1編集のみ・7日） | 初回のみ・約5分 |
| 3 | GitHub：Environment `production-d1`（承認者＝自分、Prevent self-review オフ、ブランチ=main）、Secrets 2つ | 初回のみ・約10分 |
| 4 | dry-run：Run workflow → Approve and deploy → Summaryを読む | 約3分 |
| 5 | 承認用PRをマージ | 1タップ |
| 6 | apply：Run workflow（`ADD inu-taikenki`）→ Approve and deploy | 約3分 |
| 7 | サイト公開の指示（AIがPRを作成）→ Merge | 指示＋1タップ |
| 8 | Cloudflareのトークンを削除 | 1分 |

**AIが代行済み／代行できるもの**：ツール・SQL・出典監査・テスト・手順書・ブランチ作成・差分／競合確認・ローカルでのリハーサル、公開PRの作成（指示後）、公開後の確認（GETのみ）。
**AIにはできないもの**：Cloudflare・GitHubの設定（認証情報が必要）、承認ボタン、マージの承認。

## 5. 公開前の再確認（2026-10-20 実施）

### 5-1. mainとdevelopの差
- `main`（`ef1bd39`）→ `develop`（`1cd39ea`）：20コミット、49ファイル（+5,708／−93）。内訳は、公開ページ（`public/`）の更新、`src/`（出典台帳・商品別表示・件数表示の修正など）、`tests/`、監査記録（`audit/`）、`release-data/`、`DEVELOPMENT.md`、`wrangler.jsonc`、`package.json`。これは未公開の AdSense 対策などで、**段階5で一緒に公開されます**（運営者の公開判断が必要）。
- `main` → `claude/dog-harness`（#114込み）：61ファイル（+9,097／−100）。
- `main` → `release/d1-bulk-stage1`：14ファイル（+3,477）、`src/`・`public/`・`wrangler*`・`package.json` の変更は 0。
- 競合（`git merge-tree`）：stage1→main、#114→stage1、#114→approve のいずれも**競合なし**。

### 5-2. テスト結果（Node 24.22）
| 対象 | check | npm test | test:preview | その他 |
|---|---|---|---|---|
| `claude/dog-harness`（#114込み） | OK | 73/73 | 48/48 | test:browser 2/2、ローカルSQL検証 全合格 |
| `release/d1-bulk-stage1`（mainの上） | OK | 22/22（main既存）＋ d1-bulk 13/13 | 18/18 | ローカルSQL検証 全合格 |
| `release/d1-bulk-approve` | — | d1-bulk 13/13 | — | gate が承認後に通ることを確認 |

### 5-3. 本番の現状（GETで確認）
- `https://inu-taikenki.com/api/reviews/stats`：口コミ1,595件・商品97・カテゴリ15。ハーネスは未登録。`/dog-harness` は 404（未公開）。
- 固定Preview（develop）も同じ件数（D1を共有しており、まだ何も書き込んでいない）。

### 5-4. 既存データの保全条件（すべて満たさないと apply は成功しない）
1. SQLは追加専用（DELETE/UPDATE/DROP/REPLACE/CREATE などを検査で拒否）。重複防止つき。
2. SQLの sha256 が manifest と一致（差し替え不可）。
3. 接続先は既存D1 `inu-taikenki`（名前＋ID一致）。新しいD1は作らない。表と列の構造も確認。
4. 実行前に全テーブルの件数と全行の内容ハッシュを記録。実行後、**実行前に存在した全行が1文字も変わっていない**ことを確認。
5. 対象カテゴリ以外の口コミ・商品・出典・属性が1件も増減していないことを確認（トリガーで増える `review_attributes` は対象カテゴリ分のみ許可）。
6. `review_sources` の増加がちょうど677件、追加した口コミ・出典の中身がSQLどおり（値のハッシュ）。
7. 実行前に Time Travel の復元地点を記録。DBの中身はGitHubに出さない。
8. `seed.sql`・`db:migrate:remote`・`db:seed:remote` は使わない。mainの `migrations/0042` は idempotent（再実行しても重複しない）。

### 5-5. ローカルでのリハーサル（本物のwranglerとローカルD1・Cloudflareには接続せず）
`node scripts/d1-bulk/rehearse-local.mjs dog-harness-677` は、使い捨てのローカルD1に「0042より前の全migration＋seed」を流して今の本番に近い状態（口コミ1,595件）を作り、次を実際の手順どおり通します。

gate → 構造確認 → 事前記録 → dry-run → 承認前はapplyが止まることの確認 → **`wrangler d1 execute --file` で実際に適用** → 事後照合 → 要約 → 同じSQLを再適用して変化がないことの確認

2026-10-20 の結果（すべて成功）：
| 項目 | 実行前 | 実行後 |
|---|--:|--:|
| 口コミ | 1,595 | 2,272（+677） |
| 商品 | 109 | 141（+32） |
| review_sources | 0 | 677（+677） |
| review_attributes（トリガーで連動） | 5,012 | 6,164（対象カテゴリ分のみ増加） |

- 事後照合：実行前の全行のハッシュが一致（1件も変わっていない）、対象カテゴリ以外の件数が不変、追加分の中身がSQLと一致。
- 再適用：全テーブルの件数・内容ハッシュが変わらない。
- 照合の問い合わせは、wranglerの起動回数を減らすためまとめて実行する（本番でも数回で終わる想定）。

## 6. 未解決事項・リスク
- **本物のCloudflare D1でのapplyは未試験**です（認証情報がないため）。ローカルD1では上記のとおり本物のwranglerで通しました。本番のdry-runは接続・構造・事前記録を確認しますが、リモートへの `--file` 書き込みは apply で初めて実行されます。再実行しても重複しない設計と、実行前の Time Travel 記録で備えています。
- `wrangler d1 execute --file` は途中で止まる可能性があり、全体が1つのトランザクションとは限りません（その場合は再実行で補完）。
- Time Travel の保持日数はプランで異なります。復元は他の書き込みも巻き戻します。
- 要約が定型（平均61文字・99.9%が「体験。」終わり）、第一者情報なし、判定はAI。AdSenseの審査リスクとして別途判断が必要です。
- 段階5は未公開のAdSense対策（#118・#119 ほか）を含む通常の公開です。これらの公開可否は運営者の判断です。
- 段階4〜5の間、古いサイトにはD1の増加分だけが反映されます。
