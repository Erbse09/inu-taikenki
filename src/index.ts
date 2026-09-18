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

const HOME_DESCRIPTION = "犬用品15カテゴリ・公開体験750件を、犬種・サイズ・毛質・性格・悩みから探せます。人気ランキングではなく、うちの子に近い体験から商品比較記事やブラシの選び方へ進めます。";

const HOME_SEARCH_PROMO = `
<section data-home-review-search style="margin-top:24px;background:linear-gradient(145deg,#fff7ed,#ffe5ca);border:1px solid #f0d7bd;border-radius:22px;padding:20px 18px;text-align:center;box-shadow:0 8px 24px rgba(86,61,41,.06)">
  <div style="font-size:10px;color:#d97828;font-weight:900;letter-spacing:.08em">750 EXPERIENCES / 15 CATEGORIES</div>
  <h2 style="font-size:21px;line-height:1.45;color:#3a312b;margin:5px 0 8px">犬用品を「うちの子基準」で探す</h2>
  <p style="font-size:11px;color:#766b63;line-height:1.75;margin:0 0 14px">人気順ではなく、犬のサイズ・毛質・性格・悩みや、ブラシの用途などから入口を選べます。</p>
  <div style="display:grid;grid-template-columns:repeat(2,minmax(0,1fr));gap:8px;text-align:left">
    <a href="/review-search" style="display:block;background:#ef9446;color:#fff;text-decoration:none;border-radius:12px;padding:11px 12px;font-size:10px;font-weight:900;line-height:1.55">🐶 毛質・性格・悩みから探す<br><span style="font-size:8px;font-weight:700;opacity:.9">750件を条件検索</span></a>
    <a href="/dog-size" style="display:block;background:#fff;color:#765f50;text-decoration:none;border:1px solid #edc89f;border-radius:12px;padding:11px 12px;font-size:10px;font-weight:900;line-height:1.55">📏 小型・中型・大型から探す<br><span style="font-size:8px;font-weight:700;color:#9a7b63">犬サイズ別の体験へ</span></a>
    <a href="/brush-guide" style="display:block;background:#fff;color:#765f50;text-decoration:none;border:1px solid #edc89f;border-radius:12px;padding:11px 12px;font-size:10px;font-weight:900;line-height:1.55">🪮 ブラシの種類から選ぶ<br><span style="font-size:8px;font-weight:700;color:#9a7b63">毛玉・抜け毛・仕上げ別</span></a>
    <a href="/review-insights" style="display:block;background:#fff;color:#765f50;text-decoration:none;border:1px solid #edc89f;border-radius:12px;padding:11px 12px;font-size:10px;font-weight:900;line-height:1.55">📊 体験データの傾向を見る<br><span style="font-size:8px;font-weight:700;color:#9a7b63">サイズ・毛質・特徴別</span></a>
  </div>
</section>`;

const HOME_DOG_SIZE_SCRIPT = `<script data-home-dog-size-links>
(() => {
  const sizes = ['small','medium','large'];
  const cards = document.querySelectorAll('.dog-types .dog-type');
  cards.forEach((card, index) => {
    const size = sizes[index];
    if (!size) return;
    card.setAttribute('role', 'link');
    card.setAttribute('tabindex', '0');
    card.setAttribute('aria-label', card.textContent.trim() + 'の商品体験を全カテゴリから探す');
    card.style.cursor = 'pointer';
    const go = () => { location.href = '/dog-size?size=' + size; };
    card.addEventListener('click', go);
    card.addEventListener('keydown', (event) => {
      if (event.key === 'Enter' || event.key === ' ') {
        event.preventDefault();
        go();
      }
    });
  });
})();
</script>`;

const HOME_TRAIT_LINK_SCRIPT = `<script data-home-trait-links>
(() => {
  const rules = [
    { text: 'ダブルコート', href: '/review-search?coat=double', label: 'ダブルコートの体験を750件から探す' },
    { text: '怖がり', href: '/review-search?q=' + encodeURIComponent('怖がり'), label: '怖がりな犬の体験を750件から探す' },
    { text: '子犬', href: '/review-search?q=' + encodeURIComponent('子犬'), label: '子犬の体験を750件から探す' },
    { text: '時短', href: '/review-search?q=' + encodeURIComponent('時短'), label: '時短を重視した体験を750件から探す' }
  ];
  document.querySelectorAll('.tags .tag').forEach((tag) => {
    const text = tag.textContent || '';
    const rule = rules.find((item) => text.includes(item.text));
    if (!rule) return;
    tag.setAttribute('role', 'link');
    tag.setAttribute('tabindex', '0');
    tag.setAttribute('aria-label', rule.label);
    tag.style.cursor = 'pointer';
    const go = () => { location.href = rule.href; };
    tag.addEventListener('click', go);
    tag.addEventListener('keydown', (event) => {
      if (event.key === 'Enter' || event.key === ' ') {
        event.preventDefault();
        go();
      }
    });
  });
})();
</script>`;

const REVIEW_SEARCH_PARAM_SCRIPT = `<script data-review-search-params>
(() => {
  const params = new URL(location.href).searchParams;
  const size = document.getElementById('size');
  const coat = document.getElementById('coat');
  const query = document.getElementById('query');
  const category = document.getElementById('category');
  const reset = document.getElementById('reset');
  if (!size || !coat || !query || !category) return;

  const requestedSize = params.get('size');
  const requestedCoat = params.get('coat');
  const requestedQuery = params.get('q');
  if (requestedSize && [...size.options].some((o) => o.value === requestedSize)) size.value = requestedSize;
  if (requestedCoat && [...coat.options].some((o) => o.value === requestedCoat)) coat.value = requestedCoat;
  if (requestedQuery) query.value = requestedQuery;

  const sync = () => {
    const url = new URL(location.href);
    const values = [
      ['category', category.value],
      ['size', size.value],
      ['coat', coat.value],
      ['q', query.value.trim()]
    ];
    values.forEach(([key, value]) => value ? url.searchParams.set(key, value) : url.searchParams.delete(key));
    history.replaceState(null, '', url);
  };

  category.addEventListener('change', sync);
  size.addEventListener('change', sync);
  coat.addEventListener('change', sync);
  query.addEventListener('input', sync);
  if (reset) reset.addEventListener('click', () => requestAnimationFrame(sync));
  sync();
})();
</script>`;

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
  if (category && !validSlug(category)) return json({ error: "invalid_category" }, 400);

  if (!category) {
    const result = await env.DB.prepare(
      `SELECT r.id, r.product_id, p.name AS product_name, p.category,
              r.dog_breed, r.dog_size, r.coat_type, r.needs,
              r.summary, r.source_type, r.source_url
         FROM reviews r
         JOIN products p ON p.id = r.product_id
        WHERE p.active = 1
        ORDER BY p.category ASC, p.name ASC, r.id ASC`,
    ).all<CategoryReviewRow>();
    const reviews = result.results ?? [];
    return json({ category: null, count: reviews.length, reviews });
  }

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

function htmlResponse(asset: Response, html: string) {
  const responseHeaders = new Headers(asset.headers);
  responseHeaders.delete("content-length");
  responseHeaders.delete("etag");
  responseHeaders.set("cache-control", "no-store");
  return new Response(html, {
    status: asset.status,
    statusText: asset.statusText,
    headers: responseHeaders,
  });
}

async function servePetDryerWithBrowser(request: Request, env: Env) {
  const asset = await env.ASSETS.fetch(request);
  const contentType = asset.headers.get("content-type") ?? "";
  if (!asset.ok || !contentType.includes("text/html")) return asset;

  let html = await asset.text();

  if (!html.includes("/db-review-browser.css")) {
    html = html.replace("</head>", '<link rel="stylesheet" href="/db-review-browser.css">\n</head>');
  }
  if (!html.includes('data-db-review-browser data-category="pet-dryer"') && !html.includes('id="db-product-select"')) {
    html = html.replace("</main>", `${PET_DRYER_BROWSER}\n</main>`);
  }
  if (!html.includes("/db-review-browser.js")) {
    html = html.replace("</body>", '<script src="/db-review-browser.js" defer></script>\n</body>');
  }

  return htmlResponse(asset, html);
}

async function serveHomeWithSearchPromo(request: Request, env: Env) {
  const asset = await env.ASSETS.fetch(request);
  const contentType = asset.headers.get("content-type") ?? "";
  if (!asset.ok || !contentType.includes("text/html")) return asset;

  let html = await asset.text();
  const homeDescriptionTag = `<meta name="description" content="${HOME_DESCRIPTION}">`;
  const descriptionPattern = /<meta\b(?=[^>]*\bname=["']description["'])[^>]*>/i;
  if (descriptionPattern.test(html)) html = html.replace(descriptionPattern, homeDescriptionTag);
  if (!html.includes("data-home-review-search")) {
    html = html.replace("<main>", `<main>\n${HOME_SEARCH_PROMO}`);
  }
  if (!html.includes("data-home-dog-size-links")) {
    html = html.replace("</body>", `${HOME_DOG_SIZE_SCRIPT}\n</body>`);
  }
  if (!html.includes("data-home-trait-links")) {
    html = html.replace("</body>", `${HOME_TRAIT_LINK_SCRIPT}\n</body>`);
  }
  return htmlResponse(asset, html);
}

async function serveReviewSearchWithGlobalOption(request: Request, env: Env) {
  const asset = await env.ASSETS.fetch(request);
  const contentType = asset.headers.get("content-type") ?? "";
  if (!asset.ok || !contentType.includes("text/html")) return asset;

  let html = await asset.text();
  if (!html.includes('value="">すべてのカテゴリ')) {
    html = html.replace(
      '<select id="category">',
      '<select id="category">\n<option value="">すべてのカテゴリ（700件）</option>',
    );
  }
  html = html.replace('条件一致 / このカテゴリ ', '条件一致 / 検索対象 ');
  if (!html.includes('data-review-insights-link')) {
    html = html.replace(
      '<div class="status" id="status" aria-live="polite">体験を読み込み中…</div>',
      '<a data-review-insights-link href="/review-insights.html" style="display:block;margin:12px 0 0;text-align:center;color:#9b6036;font-size:10px;font-weight:800;text-underline-offset:3px">700件の体験傾向を見る 📊</a>\n<div class="status" id="status" aria-live="polite">体験を読み込み中…</div>',
    );
  }
  if (!html.includes('/review-product-distribution.js')) {
    html = html.replace('</body>', '<script src="/review-product-distribution.js" defer></script>\n</body>');
  }
  if (!html.includes('data-review-search-params')) {
    html = html.replace('</body>', `${REVIEW_SEARCH_PARAM_SCRIPT}\n</body>`);
  }
  return htmlResponse(asset, html);
}

export default {
  async fetch(request: Request, env: Env): Promise<Response> {
    const url = new URL(request.url);

    if (url.protocol !== "https:" || url.hostname === "www.inu-taikenki.com") {
      url.protocol = "https:";
      if (url.hostname === "www.inu-taikenki.com") url.hostname = "inu-taikenki.com";
      return Response.redirect(url.toString(), 301);
    }

    if (request.method === "GET" && url.pathname.endsWith(".html")) {
      url.pathname = url.pathname === "/index.html" ? "/" : url.pathname.slice(0, -5);
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

    if (request.method === "GET" && url.pathname === "/pet-dryer") {
      return servePetDryerWithBrowser(request, env);
    }

    if (request.method === "GET" && url.pathname === "/") {
      return serveHomeWithSearchPromo(request, env);
    }

    if (request.method === "GET" && url.pathname === "/review-search") {
      return serveReviewSearchWithGlobalOption(request, env);
    }

    if (url.pathname.startsWith("/api/")) return json({ error: "not_found" }, 404);
    return env.ASSETS.fetch(request);
  },
};