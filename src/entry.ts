import worker from "./index";

type WorkerEnv = Parameters<typeof worker.fetch>[1];

const GA4_ID = "G-QPN12RPX3N";
const GA4_TAG = `<!-- Google tag (gtag.js) -->
<script async src="https://www.googletagmanager.com/gtag/js?id=${GA4_ID}"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());
  (() => {
    const ownerKey = 'inu_owner_exclude_v1';
    const params = new URLSearchParams(location.search);
    if (params.get('owner') === '1') localStorage.setItem(ownerKey, '1');
    if (params.get('owner') === '0') localStorage.removeItem(ownerKey);
    if (localStorage.getItem(ownerKey) === '1') window['ga-disable-${GA4_ID}'] = true;
    if (params.has('owner')) {
      params.delete('owner');
      const q = params.toString();
      history.replaceState(null, '', location.pathname + (q ? '?' + q : '') + location.hash);
    }
  })();
  gtag('config', '${GA4_ID}');
  (() => {
    if (document.documentElement.hasAttribute('data-inu-analytics-installed')) return;
    document.documentElement.setAttribute('data-inu-analytics-installed', '');

    const send = (name, params = {}) => {
      if (typeof window.gtag !== 'function') return;
      window.gtag('event', name, {
        page_path: location.pathname + location.search,
        ...params
      });
    };
    const textOf = (el) => (el?.textContent || '').replace(/\\s+/g, ' ').trim().slice(0, 120);

    document.addEventListener('click', (event) => {
      const target = event.target instanceof Element ? event.target : null;
      if (!target) return;
      const a = target.closest('a[href]');
      if (a) {
        let url = null;
        try { url = new URL(a.href, location.href); } catch {}
        const href = a.getAttribute('href') || '';
        const params = { link_text: textOf(a), link_url: url?.href || href };

        if (url && url.origin !== location.origin) {
          const host = url.hostname;
          const isAmazon = /(^|\\.)amazon\\./i.test(host) || /amzn\\.to$/i.test(host);
          send(isAmazon ? 'product_click' : 'outbound_click', {
            ...params,
            destination_host: host
          });
        } else if (/review-search/.test(href)) {
          send('review_search_click', params);
        } else if (/review-insights/.test(href)) {
          send('review_insights_click', params);
        } else if (/dog-size/.test(href)) {
          send('dog_size_click', params);
        } else {
          send('internal_link_click', params);
        }
      }

      const more = target.closest('[data-db-more]');
      if (more) send('reviews_more_click', { category: document.querySelector('[data-db-review-browser]')?.getAttribute('data-category') || '' });
    }, true);

    document.addEventListener('change', (event) => {
      const el = event.target;
      if (!(el instanceof HTMLSelectElement)) return;
      if (el.matches('[data-db-product-select]')) {
        send('review_product_filter', {
          product_value: el.value.slice(0, 120),
          category: document.querySelector('[data-db-review-browser]')?.getAttribute('data-category') || ''
        });
      }
    }, true);
  })();
</script>`;

const ARTICLE_COVERAGE_NOTE = `<div data-article-coverage style="margin:-15px 0 26px;background:#fff7ed;border:1px solid #f0dcc6;border-radius:13px;padding:10px 12px;font-size:10px;color:#765f50;line-height:1.65"><strong style="color:#d97828">公開体験：50件</strong>　上の件数は記事内で詳しく紹介している代表例です。さらに、このページ下部から犬のサイズ・毛質・条件で50件の体験を絞り込めます。</div>`;

const REPRESENTATIVE_EXAMPLE_PAGES = new Set([
  "/dog-shampoo",
  "/dog-nail-clipper",
  "/dog-nail-grinder",
  "/dog-clipper",
]);

const BRUSH_COVERAGE_PAGES = new Set([
  "/brush-guide",
  "/brush-slicker",
  "/brush-pin",
  "/brush-comb",
  "/brush-undercoat",
]);

function withAnalytics(response: Response, html: string) {
  const headers = new Headers(response.headers);
  headers.delete("content-length");
  headers.delete("etag");
  return new Response(html, {
    status: response.status,
    statusText: response.statusText,
    headers,
  });
}

function alignHomepageReviewCounts(request: Request, html: string) {
  const pathname = new URL(request.url).pathname;
  if (pathname !== "/" && pathname !== "/index.html") return html;

  html = html.replaceAll('<b>10</b><span>具体的な体験</span>', '<b>50</b><span>公開体験</span>');
  html = html.replace('犬の具体的な公開体験10件から「うちの子なら？」を比べます。', '公開体験50件を整理し、記事内の具体例から「うちの子なら？」を比べます。');
  html = html.replace('犬種が分かる公開体験を中心に25件整理。乾燥時間・音への反応・困った点まで比較しました。', '犬種が分かる公開体験50件を整理。記事内では代表例も掲載し、乾燥時間・音への反応・困った点まで比較しました。');
  html = html.replace('<b>25</b><span>具体的な体験</span>', '<b>50</b><span>公開体験</span>');
  return html;
}

function clarifyArticleCoverage(request: Request, html: string) {
  const rawPathname = new URL(request.url).pathname;
  const pathname = rawPathname.replace(/\.html$/, "");
  if (!REPRESENTATIVE_EXAMPLE_PAGES.has(pathname)) return html;

  html = html.replace('<b>10</b><span>具体体験</span>', '<b>10</b><span>記事内代表例</span>');
  html = html.replace('<b>10</b><span>具体体験を整理</span>', '<b>10</b><span>記事内代表例</span>');

  if (!html.includes('data-article-coverage')) {
    const marker = '<section class="item-finder"';
    if (html.includes(marker)) {
      html = html.replace(marker, `${ARTICLE_COVERAGE_NOTE}\n<section class="item-finder"`);
    }
  }
  return html;
}

function clarifyPetDryerCoverage(request: Request, html: string) {
  const pathname = new URL(request.url).pathname.replace(/\.html$/, "").replace(/\/$/, "");
  if (pathname !== "/pet-dryer") return html;

  html = html.replace(
    '<p class="source-line">※上の25件は、既存調査で確認した楽天市場・Yahoo!ショッピング・メーカー公開ページの個別投稿を「1投稿＝1体験」で整理したものです。</p>',
    '<p class="source-line"><strong>記事内代表例：25件</strong>　上の25件は、既存調査で確認した公開体験から詳しく紹介している代表例です。このカテゴリでは50件の公開体験を収録しており、犬のサイズ・毛質・条件で絞り込めます。</p>',
  );
  html = html.replace('データベースから商品別の体験を表示', '商品別の体験を見る');
  html = html.replace('この欄はCloudflare D1から商品一覧を読み込み、選んだ商品IDの体験要約をAPI経由で表示します。', '商品を選ぶと、その商品について整理した公開体験を表示します。');
  return html;
}

function clarifyAutoFeederCoverage(request: Request, html: string) {
  const pathname = new URL(request.url).pathname.replace(/\.html$/, "").replace(/\/$/, "");
  if (pathname !== "/auto-feeder" || html.includes('data-auto-feeder-coverage')) return html;

  const marker = '<h2>🐶 うちの子条件検索</h2>';
  if (!html.includes(marker)) return html;

  const note = '<div data-auto-feeder-coverage style="margin:-17px 0 28px;background:#fff7ed;border:1px solid #f0dcc6;border-radius:13px;padding:11px 13px;font-size:10px;color:#765f50;line-height:1.7"><strong style="color:#d97828">調査範囲について：</strong>この記事では100件以上の公開口コミ本文を確認しています。条件検索で表示する公開体験は50件です。前者は調査母数、後者は検索対象として整理した件数です。</div>';
  return html.replace(marker, `${note}\n${marker}`);
}

function clarifyBrushCoverage(request: Request, html: string) {
  const pathname = new URL(request.url).pathname.replace(/\.html$/, "").replace(/\/$/, "");
  if (!BRUSH_COVERAGE_PAGES.has(pathname) || html.includes('data-brush-coverage')) return html;

  const style = 'margin:10px 0 26px;background:#fff7ed;border:1px solid #f0dcc6;border-radius:13px;padding:11px 13px;font-size:10px;color:#765f50;line-height:1.7';
  if (pathname === "/brush-guide") {
    const marker = '<section class="finder" id="dogFinder">';
    if (!html.includes(marker)) return html;
    const note = `<div data-brush-coverage style="${style}"><strong style="color:#d97828">件数の見方：</strong>1,000件以上は確認先ページに掲載されている公開口コミの母数です。4つの専門記事では、各ブラシ種類ごとに50件の公開体験を整理しています。口コミ母数と整理した体験件数は別の数字です。</div>`;
    return html.replace(marker, `${note}\n${marker}`);
  }

  const marker = '<section class="item-finder" id="itemFinder">';
  if (!html.includes(marker)) return html;
  const note = `<div data-brush-coverage style="${style}"><strong style="color:#d97828">件数の見方：</strong>上部の「公開口コミ母数」は、確認先ページに掲載されている口コミの総数です。このブラシ種類では50件の公開体験を整理しています。口コミ母数と整理した体験件数は別の数字です。</div>`;
  return html.replace(marker, `${note}\n${marker}`);
}

function addDogClipperAffiliateLinks(request: Request, html: string) {
  const pathname = new URL(request.url).pathname.replace(/\.html$/, "").replace(/\/$/, "");
  if (pathname !== "/dog-clipper" || html.includes('data-dog-clipper-affiliate-links')) return html;

  const note = '<span class="amazon-note">※Amazon内検索を開きます。型番・販売元・販売状況を確認してください。</span>';
  const additions = [
    {
      marker: '<div class="pillrow"><span class="pill">トイプードル</span><span class="pill">ミニチュアダックス</span><span class="pill">シニア</span></div>',
      query: 'Panasonic+ER807PP-A',
    },
    {
      marker: '<div class="pillrow"><span class="pill">足裏</span><span class="pill">顔まわり</span><span class="pill">怖がり</span></div>',
      query: 'Pateker+LG4+ミニバリカン',
    },
    {
      marker: '<div class="pillrow"><span class="pill">多頭</span><span class="pill">全身</span><span class="pill">替刃</span></div>',
      query: 'SPEEDIK+PEACE+バリカン',
    },
  ];

  for (const item of additions) {
    if (!html.includes(item.marker)) continue;
    const link = `<a class="amazon-cta" data-dog-clipper-affiliate-links href="https://www.amazon.co.jp/s?k=${item.query}&tag=100things-22" rel="sponsored noopener" target="_blank">Amazonでこの商品名を探す</a>${note}`;
    html = html.replace(item.marker, `${item.marker}${link}`);
  }
  return html;
}

function removeVisibleDatabaseWording(html: string) {
  return html
    .replaceAll('公開体験DB', '公開体験')
    .replaceAll('体験DB', '体験一覧')
    .replaceAll('DBに整理', '整理')
    .replaceAll('商品別DB収録', '商品別に収録')
    .replaceAll('公開レビューを整理したDBの分布', '公開レビューを整理した体験データの分布')
    .replaceAll('ここではDB内の「分布」だけを表示しています。', 'ここでは整理した体験の「分布」だけを表示しています。')
    .replaceAll('D1に保存した公開購入者レビューの要約50件', '整理した公開購入者レビューの要約50件');
}

function injectStructuredSeo(request: Request, html: string) {
  if (html.includes('data-structured-seo')) return html;

  const url = new URL(request.url);
  const pathname = url.pathname === "/index.html" ? "/" : url.pathname.replace(/\.html$/, "");
  const canonical = `${url.origin}${pathname || "/"}`;

  let schema: Record<string, unknown>;
  if (pathname === "/") {
    schema = {
      "@context": "https://schema.org",
      "@type": "WebSite",
      name: "犬用品みんなの体験記",
      url: canonical,
      inLanguage: "ja",
    };
  } else {
    const titleMatch = html.match(/<title>([\s\S]*?)<\/title>/i);
    const currentName = (titleMatch?.[1] ?? "犬用品みんなの体験記")
      .replace(/\s*\|\s*犬用品みんなの体験記\s*$/u, "")
      .trim();

    schema = {
      "@context": "https://schema.org",
      "@type": "BreadcrumbList",
      itemListElement: [
        {
          "@type": "ListItem",
          position: 1,
          name: "犬用品みんなの体験記",
          item: `${url.origin}/`,
        },
        {
          "@type": "ListItem",
          position: 2,
          name: currentName || "ページ",
          item: canonical,
        },
      ],
    };
  }

  const tag = `<script type="application/ld+json" data-structured-seo>${JSON.stringify(schema)}</script>`;
  return html.includes("</head>") ? html.replace("</head>", `${tag}\n</head>`) : html;
}

function alignSeoAndInternalUrls(request: Request, html: string) {
  const url = new URL(request.url);
  const pathname = url.pathname === "/index.html" ? "/" : url.pathname.replace(/\.html$/, "");
  const canonical = `${url.origin}${pathname || "/"}`;

  html = html.replace(
    /<link\s+rel=["']canonical["'][^>]*>/i,
    `<link rel="canonical" href="${canonical}">`,
  );
  html = html.replace(
    /<meta\s+property=["']og:url["'][^>]*>/i,
    `<meta property="og:url" content="${canonical}">`,
  );

  html = html.replace(/href=(['"])([^'"]+)\1/g, (match, quote, target) => {
    if (/^(?:https?:)?\/\//i.test(target) || /^(?:mailto:|tel:|#)/i.test(target)) return match;

    const splitAt = target.search(/[?#]/);
    const path = splitAt === -1 ? target : target.slice(0, splitAt);
    const suffix = splitAt === -1 ? "" : target.slice(splitAt);
    if (!path.endsWith(".html")) return match;

    const withoutHtml = path.slice(0, -5);
    const normalized = withoutHtml === "index" || withoutHtml === "/index" ? "/" : withoutHtml;
    return `href=${quote}${normalized}${suffix}` + quote;
  });

  return html;
}

export default {
  async fetch(request: Request, env: WorkerEnv): Promise<Response> {
    const response = await worker.fetch(request, env);

    if (request.method !== "GET" || !response.ok) return response;
    const contentType = response.headers.get("content-type") ?? "";
    if (!contentType.includes("text/html")) return response;

    let html = await response.text();
    html = alignHomepageReviewCounts(request, html);
    html = clarifyArticleCoverage(request, html);
    html = clarifyPetDryerCoverage(request, html);
    html = clarifyAutoFeederCoverage(request, html);
    html = clarifyBrushCoverage(request, html);
    html = addDogClipperAffiliateLinks(request, html);
    html = removeVisibleDatabaseWording(html);
    html = alignSeoAndInternalUrls(request, html);
    html = injectStructuredSeo(request, html);
    if (html.includes(GA4_ID)) return withAnalytics(response, html);

    if (html.includes("<head>")) {
      html = html.replace("<head>", `<head>\n${GA4_TAG}`);
    } else if (html.includes("</head>")) {
      html = html.replace("</head>", `${GA4_TAG}\n</head>`);
    } else {
      return withAnalytics(response, html);
    }

    return withAnalytics(response, html);
  },
};
