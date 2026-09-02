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
