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

const headers = {
  "content-type": "application/json; charset=utf-8",
  "cache-control": "no-store",
};

function json(data: unknown, status = 200) {
  return new Response(JSON.stringify(data, null, 2), { status, headers });
}
function validProductId(value: string) {
  return /^[a-z0-9][a-z0-9._-]{0,63}$/i.test(value);
}

async function listProducts(env: Env, category: string | null) {
  if (category) {
    if (!/^[a-z0-9][a-z0-9._-]{0,63}$/i.test(category)) {
      return json({ error: "invalid_category" }, 400);
    }
    const result = await env.DB.prepare(
      `SELECT id, name, category, asin, affiliate_url
         FROM products
        WHERE active = 1 AND category = ?1
        ORDER BY name ASC`,
    ).bind(category).all<ProductRow>();
    return json({ category, products: result.results ?? [] });
  }

  const result = await env.DB.prepare(
    `SELECT id, name, category, asin, affiliate_url
       FROM products
      WHERE active = 1
      ORDER BY category ASC, name ASC`,
  ).all<ProductRow>();
  return json({ products: result.results ?? [] });
}

// 指定した商品IDのレビューを取得。
// GET /api/products/petaboo-l400/reviews
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

export default {
  async fetch(request: Request, env: Env): Promise<Response> {
    const url = new URL(request.url);

    if (request.method === "GET" && url.pathname === "/api/health") {
      const row = await env.DB.prepare("SELECT 1 AS ok").first<{ ok: number }>();
      return json({ ok: row?.ok === 1, service: "inu-taikenki-worker" });
    }

    if (request.method === "GET" && url.pathname === "/api/products") {
      return listProducts(env, url.searchParams.get("category"));
    }

    if (request.method === "GET") {
      const match = url.pathname.match(/^\/api\/products\/([^/]+)\/reviews\/?$/);
      if (match) return getReviewsByProductId(env, decodeURIComponent(match[1]));
    }

    if (url.pathname.startsWith("/api/")) return json({ error: "not_found" }, 404);
    return env.ASSETS.fetch(request);
  },
};
