import worker from "./index";

type WorkerEnv = Parameters<typeof worker.fetch>[1];

const GA4_ID = "G-QPN12RPX3N";
const GA4_TAG = `<!-- Google tag (gtag.js) -->
<script async src="https://www.googletagmanager.com/gtag/js?id=${GA4_ID}"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());
  gtag('config', '${GA4_ID}');
</script>`;

const ARTICLE_COVERAGE_NOTE = `<div data-article-coverage style="margin:-15px 0 26px;background:#fff7ed;border:1px solid #f0dcc6;border-radius:13px;padding:10px 12px;font-size:10px;color:#765f50;line-height:1.65"><strong style="color:#d97828">公開体験：50件</strong>　上の件数は記事内で詳しく紹介している代表例です。さらに、このページ下部から犬のサイズ・毛質・条件で50件の体験を絞り込めます。</div>`;

const REPRESENTATIVE_EXAMPLE_PAGES = new Set([
  "/dog-shampoo",
  "/dog-nail-clipper",
  "/dog-nail-grinder",
  "/dog-clipper",
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

  return html.replace(
    '<p class="source-line">※上の25件は、既存調査で確認した楽天市場・Yahoo!ショッピング・メーカー公開ページの個別投稿を「1投稿＝1体験」で整理したものです。</p>',
    '<p class="source-line"><strong>記事内代表例：25件</strong>　上の25件は、既存調査で確認した公開体験から詳しく紹介している代表例です。このカテゴリでは50件の公開体験を収録しており、犬のサイズ・毛質・条件で絞り込めます。</p>',
  );
}

function clarifyAutoFeederCoverage(request: Request, html: string) {
  const pathname = new URL(request.url).pathname.replace(/\.html$/, "").replace(/\/$/, "");
  if (pathname !== "/auto-feeder" || html.includes('data-auto-feeder-coverage')) return html;

  const marker = '<h2>🐶 うちの子条件検索</h2>';
  if (!html.includes(marker)) return html;

  const note = '<div data-auto-feeder-coverage style="margin:-17px 0 28px;background:#fff7ed;border:1px solid #f0dcc6;border-radius:13px;padding:11px 13px;font-size:10px;color:#765f50;line-height:1.7"><strong style="color:#d97828">調査範囲について：</strong>この記事では100件以上の公開口コミ本文を確認しています。条件検索で表示する公開体験は50件です。前者は調査母数、後者は検索対象として整理した件数です。</div>';
  return html.replace(marker, `${note}\n${marker}`);
}

function removeVisibleDatabaseWording(html: string) {
  return html
    .replaceAll('公開体験DB', '公開体験')
    .replaceAll('体験DB', '体験一覧')
    .replaceAll('DBに整理', '整理')
    .replaceAll('商品別DB収録', '商品別に収録');
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
