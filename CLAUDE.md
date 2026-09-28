# 犬体験記：AIエージェント作業ルール

詳しい運用手順は [DEVELOPMENT.md](DEVELOPMENT.md) を参照。以下は必ず守る。

## CONTROL ROOM（Notion）

- 作業開始時に、非公開Notionの「犬体験記 CONTROL ROOM」を確認し、GitHubの最新main・develop・作業ブランチ・Preview状態と照合してから作業する。
- 作業終了時にCONTROL ROOMを最新化する。長い日報は書かず、現在状態・進捗・GitHub branch/commit・Preview・D1保全・ユーザー確認事項・質問・ブロッカー・次の作業だけを残す。
- 「最終更新したAI」と「最終更新時刻（JST）」を必ず更新する。
- CONTROL ROOMの更新は、mainへのmerge・本番公開・本番D1変更の承認の代わりにならない。

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
