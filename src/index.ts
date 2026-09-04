interface D1PreparedStatement {
  bind(...values: (string | number | null)[]): D1PreparedStatement;
  all<T>(): Promise<{ results?: T[] }>;
  first<T>(): Promise<T | null>;
}
interface D1Database { prepare(query: string): D1PreparedStatement; }
interface Fetcher { fetch(request: Request): Promise<Response>; }
interface Env { DB: D1Database; ASSETS: Fetcher; }

interface ProductRow {
  id: string;
  name: string;
  category: string;
  asin: string | null;
  affiliate_url: string | null;
  review_count?: number;
}
interface ReviewRow {
  id: number;
  product_id: string;
  dog_breed: string | null;
  dog_size: string | null;
  coat_type: string | null;
  needs: string | null;
  summary: string;
  source_type: string;
  source_url: string | null;
}
interface CategoryReviewRow extends ReviewRow {
  product_name: string;
  category: string;
}

const headers = {
  "content-type": "application/json; charset=utf-8",
  "cache-control": "no-store",
};

const PET_DRYER_BROWSER = `
<section class="db-review-browser" data-db-review-browser data-category="pet-dryer">
  <div class="eyebrow">PRODUCT EXPERIENCES</div>
  <h2>ペットドライヤーの商品別に50件の体験を見る</h2>
  <p class="db-review-note">商品を選ぶと、その商品について確認できた公開体験を表示します。</p>
  <div class="db-controls">
    <label>商品</label>
    <select data-db-product-select><option value="">読み込み中…</option></select>
    <span class="db-status" data-db-status></span>
  </div>
  <div class="db-review-list" data-db-review-list aria-live="polite"></div>
  <div class="db-more-wrap"><button class="db-more-btn" type="button" data-db-more hidden>もっと見る</button></div>
</section>`;

function json(data: unknown, status = 200) {
  return new Response(JSON.stringify(data, null, 2), { status, headers });
}
function validSlug(value: string) {
  return /^[a-z0-9][a-z0-9._-]{0,63}$/i.test(value);
}
function validProductId(value: string) {
  return validSlug(value);
}

async function listProducts(env: Env, category: string | null) {
  if (category) {
    if (!validSlug(category)) return json({ error: "invalid_category" }, 400);
    const result = await env.DB.prepare(
      `SELECT p.id, p.name, p.category, p.asin, p.affiliate_url,
              COUNT(r.id) AS review_count
         FROM products p
         LEFT JOIN reviews r ON r.product_id = p.id
        WHERE p.active = 1 AND p.category = ?1
        GROUP BY p.id, p.name, p.category, p.asin, p.affiliate_url
        ORDER BY review_count DESC, p.name ASC`,
    ).bind(category).all<ProductRow>();
    return json({ category, products: result.results ?? [] });
  }

  const result = await env.DB.prepare(
    `SELECT p.id, p.name, p.category, p.asin, p.affiliate_url,
            COUNT(r.id) AS review_count
       FROM products p
       LEFT JOIN reviews r ON r.product_id = p.id
      WHERE p.active = 1
      GROUP BY p.id, p.name, p.category, p.asin, p.affiliate_url
      ORDER BY p.category ASC, review_count DESC, p.name ASC`,
  ).all<ProductRow>();
  return json({ products: result.results ?? [] });
}

async function getReviewsByCategory(env: Env, category: string | null) {
  if (!category || !validSlug(category)) return json({ error: "invalid_category" }, 400);

  const result = await env.DB.prepare(
    `SELECT r.id, r.product_id, p.name AS product_name, p.category,
            r.dog_breed, r.dog_size, r.coat_type, r.needs,
            r.summary, r.source_type, r.source_url
       FROM reviews r
       JOIN products p ON p.id = r.product_id
      WHERE p.active = 1 AND p.category = ?1
      ORDER BY p.name ASC, r.id ASC`,
  ).bind(category).all<CategoryReviewRow>();

  const reviews = result.results ?? [];
  return json({ category, count: reviews.length, reviews });
}

async function getReviewsByProductId(env: Env, productId: string) {
  if (!validProductId(productId)) return json({ error: "invalid_product_id" }, 400);

  const product = await env.DB.prepare(
    `SELECT id, name, category, asin, affiliate_url
       FROM products
      WHERE id = ?1 AND active = 1
      LIMIT 1`,
  ).bind(productId).first<ProductRow>();

  if (!product) return json({ error: "product_not_found", productId }, 404);

  const result = await env.DB.prepare(
    `SELECT id, product_id, dog_breed, dog_size, coat_type, needs,
            summary, source_type, source_url
       FROM reviews
      WHERE product_id = ?1
      ORDER BY id ASC`,
  ).bind(productId).all<ReviewRow>();

  const reviews = result.results ?? [];
  return json({ product, count: reviews.length, reviews });
}

async function servePetDryerWithBrowser(request: Request, env: Env) {
  const asset = await env.ASSETS.fetch(request);
  const contentType = asset.headers.get("content-type") ?? "";
  if (!asset.ok || !contentType.includes("text/html")) return asset;

  let html = await asset.text();

  if (!html.includes("/db-review-browser.css")) {
    html = html.replace("</head>", '<link rel="stylesheet" href="/db-review-browser.css">\n</head>');
  }

  if (!html.includes('data-db-review-browser data-category="pet-dryer"')) {
    html = html.replace("</main>", `${PET_DRYER_BROWSER}\n</main>`);
  }

  if (!html.includes("/db-review-browser.js")) {
    html = html.replace("</body>", '<script src="/db-review-browser.js" defer></script>\n</body>');
  }

  const responseHeaders = new Headers(asset.headers);
  responseHeaders.delete("content-length");
  responseHeaders.delete("etag");
  return new Response(html, {
    status: asset.status,
    statusText: asset.statusText,
    headers: responseHeaders,
  });
}

export default {
  async fetch(request: Request, env: Env): Promise<Response> {
    const url = new URL(request.url);

    if (url.hostname === "www.inu-taikenki.com") {
      url.hostname = "inu-taikenki.com";
      return Response.redirect(url.toString(), 301);
    }

    if (request.method === "GET" && url.pathname === "/api/health") {
      const row = await env.DB.prepare("SELECT 1 AS ok").first<{ ok: number }>();
      return json({ ok: row?.ok === 1, service: "inu-taikenki-worker" });
    }

    if (request.method === "GET" && url.pathname === "/api/products") {
      return listProducts(env, url.searchParams.get("category"));
    }

    if (request.method === "GET" && url.pathname === "/api/reviews") {
      return getReviewsByCategory(env, url.searchParams.get("category"));
    }

    if (request.method === "GET") {
      const match = url.pathname.match(/^\/api\/products\/([^/]+)\/reviews\/?$/);
      if (match) return getReviewsByProductId(env, decodeURIComponent(match[1]));
    }

    if (request.method === "GET" && url.pathname === "/pet-dryer.html") {
      return servePetDryerWithBrowser(request, env);
    }

    if (url.pathname.startsWith("/api/")) return json({ error: "not_found" }, 404);
    return env.ASSETS.fetch(request);
  },
};
