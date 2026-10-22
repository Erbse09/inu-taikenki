# 犬体験記：AIエージェント作業ルール

詳しい運用手順は [DEVELOPMENT.md](DEVELOPMENT.md) を参照。以下は必ず守る。

## 0. AI秘書室｜共通の現在地を使う（2026-10-23追加）

- 作業開始時は [犬体験記 CONTROL ROOM](https://app.notion.com/p/3e9664b9cf278164ad29ca3f75d39c2f) の先頭「📍 現在地｜AI共通ステータス」を**最初に読む**。運用詳細は [AI秘書室｜共通引き継ぎルール](https://app.notion.com/p/401664b9cf27814a9c26cae05d83383d) を参照。
- ユーザーが「犬体験記の続き」と言ったら、旧チャットの記憶だけで判断せず、現在地→GitHubの最新PR/ブランチ/CI→必要ならPreview・本番の順で状況を照合する。
- 作業後はCONTROL ROOM先頭の**同一の現在地欄を上書き**し、「最終確認（JST）・最後の作業AI・今の担当・最新PR・完了・未完了・次の1手・ユーザー承認待ち・本番変更有無・検証した根拠」を更新。詳細履歴は既存方針どおり日付つきで残す。現在地を新規に増殖させない。
- Notion保存後に再取得して確認。Notionが読めない・書けない場合はその事実を報告し、「引き継ぎ更新済み」と言わない。機密情報は記録しない。
- これは**通知やAI同士の自動通信ではない**。毎作業ごとの読み書きルールであり、mainへのマージ・本番公開・本番D1更新の承認にはならない。以下の安全規則を優先する。

## CONTROL ROOM（Notion）

- 作業開始時に、非公開Notionの「犬体験記 CONTROL ROOM」を確認し、GitHubの最新main・develop・作業ブランチ・Preview状態と照合してから作業する。
- 作業終了時にCONTROL ROOMを最新化する。長い日報は書かず、現在状態・進捗・GitHub branch/commit・Preview・D1保全・ユーザー確認事項・質問・ブロッカー・次の作業だけを残す。
- 「最終更新したAI」と「最終更新時刻（JST）」を必ず更新する。
- CONTROL ROOMの更新は、mainへのmerge・本番公開・本番D1変更の承認の代わりにならない。

### 引き継ぎ記録（ChatGPTが別チャットから続けられるようにする）

- CONTROL ROOM（https://app.notion.com/p/3e9664b9cf278164ad29ca3f75d39c2f）を作業状況の正本とする。あわせて「00｜ChatGPT引き継ぎ用まとめ」（https://app.notion.com/p/3fb664b9cf2781879c6efc798e14e4da）に、やさしい日本語の要約を残す。AdSense対策の作業では関連するNotionページも更新する。
- 作業開始時にNotionを読み、重要な作業の完了ごと（milestone）と作業終了時に記録する。終了時だけにまとめて書かない。
- 毎回残す項目：日時（JST）／目的／完了した作業／ブランチと最新コミットSHA／PR番号とURL／GitHub Actionsの実行URLと結果／D1の作業前後の件数／本番D1を書き換えたか／本番サイトを公開・変更したか／テスト結果と確認方法／未解決の問題／運営者の承認が必要な事項／次の作業／ChatGPTに重点確認してほしい箇所。
- 「完了」「未実施」「推測」「承認待ち」を分けて書く。実ログ・実URL・読み取り結果で確認できたことだけを「完了」とする。
- 履歴は消さず、日付つきで追記する。ただし「現在の状態」「最終更新したAI」「最終更新時刻（JST）」など最新情報の欄は必ず更新し、古い情報を最新として残さない。
- 書き込み後はページを再取得して保存を確認する。保存に失敗したときは「Notion更新済み」と報告しない。
- APIトークン・Secrets・その他の認証情報は、Notionを含むどこにも書き込まない。

## ブランチ

- 作業は必ず最新の `develop` を基準にする（`git fetch origin develop` → `origin/develop` から作業ブランチを作成）。
- `main` へ直接push・mergeしない。`main` 向けPRも作らない。
- 変更は作業ブランチにcommit/pushし、`develop` 向けPRを作成する。`develop` へも直接pushしない。

## 禁止事項

- 本番D1への書き込み、migration、`seed.sql` の実行は禁止。
  - `npm run db:migrate:remote`、`npm run db:seed:remote`、`wrangler d1 execute --remote`、`wrangler d1 migrations apply --remote` を使わない。
- 本番公開（`npm run deploy`、`wrangler deploy`、mainへのマージ）はユーザーが明示的に指示した場合のみ行う。

## テスト

変更後は以下を実行し、結果をPRに記載する。

```sh
npm ci
npm run check
npm run test:preview
npm test
```
