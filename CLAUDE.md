# 犬体験記：AIエージェント作業ルール

詳しい運用手順は [DEVELOPMENT.md](DEVELOPMENT.md) を参照。以下は必ず守る。

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
