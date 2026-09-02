# Cloudflare Workers + D1 prototype

This branch is an isolated prototype. The current GitHub Pages production branch (`main`) is unchanged.

## What it adds

- Cloudflare Worker API in `src/index.ts`
- D1 schema in `migrations/0001_init.sql`
- Seed data in `seed.sql` (5 dryer products / 25 existing experience summaries)
- Existing static site copied to `public/`
- D1-powered product/review browser on `public/pet-dryer.html`

## API

- `GET /api/health`
- `GET /api/products`
- `GET /api/products/:productId/reviews`

Example: `GET /api/products/petaboo-l400/reviews`

## Deploy outline

1. `npm install`
2. `npx wrangler d1 create inu-taikenki`
3. Put the returned D1 database ID into `wrangler.jsonc`
4. `npm run db:migrate:remote`
5. `npm run db:seed:remote`
6. `npm run deploy`
7. After verification, attach the custom domain in Cloudflare and switch DNS from GitHub Pages.

Do not switch the production domain until the Worker preview URL has been fully tested.


## 追加記事のD1化（2026-09）

以下のCloudflare版記事にも、商品カテゴリ別のD1ブラウザを追加しています。

- `auto-feeder.html` → `auto-feeder`
- `brush-slicker.html` → `brush-slicker`
- `brush-undercoat.html` → `brush-undercoat`
- `brush-comb.html` → `brush-comb`
- `brush-pin.html` → `brush-pin`

追加データは `migrations/0002_other_articles.sql` にあります。
既存記事にある商品だけを products に追加し、商品が特定できる公開体験要約だけを reviews に紐付けています。
商品を特定できない一般的な生活投稿は、無理に商品へ紐付けず静的記事側に残します。

カテゴリ別商品API:

```
GET /api/products?category=auto-feeder
GET /api/products?category=brush-slicker
GET /api/products?category=brush-undercoat
GET /api/products?category=brush-comb
GET /api/products?category=brush-pin
```

商品ID別レビューAPIは従来どおり:

```
GET /api/products/:productId/reviews
```

Cloudflare版の共通表示コード:

- `public/db-review-browser.js`
- `public/db-review-browser.css`

体験表示は初期4件、その後「もっと見る」で6件ずつ追加します。
