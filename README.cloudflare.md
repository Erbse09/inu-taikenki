# Cloudflare Workers + D1 production notes

`inu-taikenki.com` is currently served by Cloudflare Workers + Static Assets with D1 as the review database. GitHub `main` is the production source branch and Cloudflare Git integration deploys updates automatically.

## Current production architecture

- Worker API: `src/index.ts`
- Static Assets: `public/`
- D1 database binding: `DB`
- Static asset binding: `ASSETS`
- Cloudflare config: `wrangler.jsonc`
- Review UI: `public/db-review-browser.js` + `public/db-review-browser.css`
- Global 550-review search: `public/review-search.html`
- Condition/product distribution helper: `public/review-product-distribution.js`
- Aggregate experience insights: `public/review-insights.html`

The production custom domains are:

- `https://inu-taikenki.com`
- `https://www.inu-taikenki.com` → redirected to the apex domain by the Worker

## Review dataset status

There are 11 production review categories with at least 50 review rows each, for a verified total of 550 rows:

- `brush-comb`
- `brush-slicker`
- `brush-undercoat`
- `brush-pin`
- `dog-shampoo`
- `dog-conditioner`
- `nail-clipper`
- `nail-grinder`
- `dog-clipper`
- `auto-feeder`
- `pet-dryer`

Review expansion migrations are under `migrations/`. The expansion migrations are designed to be idempotent and were applied individually to production D1.

Do not infer missing dog attributes. `dog_breed`, `dog_size`, `coat_type`, and `needs` should only contain information supported by the source review or source material.

## API

Read-only endpoints used by the site:

```text
GET /api/health
GET /api/products
GET /api/products?category=<category>
GET /api/reviews
GET /api/reviews?category=<category>
GET /api/products/:productId/reviews
```

Important behavior:

- `GET /api/reviews` with no category returns reviews across all active categories.
- `GET /api/reviews?category=pet-dryer` returns one category only.
- Product review endpoints return the product metadata plus its review rows.
- API responses use `Cache-Control: no-store`.
- The current review/search APIs do not write to D1.

## Review search behavior

`/review-search.html` supports:

- all-category search across the 550 rows
- category filtering
- dog-size filtering
- coat-type filtering
- Japanese keyword aliases such as 怖がり, 抜け毛, 静音, 多頭, 子犬, シニア, 時短
- progressive disclosure with “もっと見る”
- product-level experience distribution for the currently selected conditions

Product distribution counts are descriptive only. They must not be presented as a recommendation ranking, satisfaction score, or product superiority score because collection volume varies by product.

## Article-level review browsers

Shared article browsers use:

- `public/db-review-browser.js`
- `public/db-review-browser.css`

They support product selection, dog-size filtering, coat filtering, Japanese keyword aliases, source links, and progressive disclosure.

`pet-dryer.html` is a legacy page that receives the shared D1 browser through Worker-side HTML injection. Other migrated category articles can include the shared browser statically.

## Selective Worker-first routing

`wrangler.jsonc` uses selective `run_worker_first` routing rather than routing every static asset through the Worker.

Worker-first routes currently include API paths and HTML pages that require runtime injection, including the homepage, review search, and pet dryer page. Ordinary static article assets continue to be served as static assets.

Worker-rewritten HTML responses use `Cache-Control: no-store` so stale injected UI is less likely to persist across deployments.

## Deployment workflow

Normal production flow:

1. Create a branch from `main`.
2. Make the smallest safe change.
3. Review the diff and avoid unrelated article rewrites.
4. Open a pull request.
5. Confirm the PR is mergeable.
6. Confirm the Cloudflare bot reports `Deployment successful!` for the branch preview/build when available.
7. Merge to `main`.
8. Cloudflare Git integration deploys the new `main` automatically.

GitHub Actions are not required for the normal Cloudflare deployment flow and should not be used merely to trigger production deployment.

## Safety rules for changes

Follow the project’s validation rules before merging meaningful changes:

- syntax or type checks where applicable
- mock or isolated validation before production calls
- failure/empty-state handling
- duplicate and API-call-count checks when data changes are involved
- regression review for existing pages
- no guessed ASINs or fabricated product claims
- no D1 writes unless the task explicitly requires a reviewed migration

For Amazon links, preserve verified direct product links. When the exact ASIN/listing is not verified, use a clearly labelled Amazon product-name search link rather than inventing an ASIN.

## SEO files

Production SEO discovery files live under `public/`:

- `robots.txt`
- `sitemap.xml`

The sitemap includes the global review search and review insights pages. Google Search Console registration for `inu-taikenki.com` is a separate operational task and should be completed when Google account access is available.
