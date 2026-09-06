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

const GLOBAL_HEAD = `
<link rel="icon" href="/favicon.ico" sizes="any">
<link rel="icon" type="image/png" href="/favicon-96.png" sizes="96x96">
<link rel="manifest" href="/site.webmanifest">
<meta name="theme-color" content="#fff8ef">
<meta name="twitter:card" content="summary">`;

const HOME_SCHEMA = `<script type="application/ld+json" data-site-schema>{"@context":"https://schema.org","@graph":[{"@type":"Organization","@id":"https://inu-taikenki.com/#organization","name":"犬用品みんなの体験記","url":"https://inu-taikenki.com/","logo":{"@type":"ImageObject","url":"https://inu-taikenki.com/favicon-96.png"}},{"@type":"WebSite","@id":"https://inu-taikenki.com/#website","url":"https://inu-taikenki.com/","name":"犬用品みんなの体験記","publisher":{"@id":"https://inu-taikenki.com/#organization"},"potentialAction":{"@type":"SearchAction","target":{"@type":"EntryPoint","urlTemplate":"https://inu-taikenki.com/review-search.html?q={search_term_string}"},"query-input":"required name=search_term_string"}}]}</script>`;

const HOME_TRUST_BLOCK = `
<section data-home-trust style="margin-top:24px;background:#fff;border:1px solid #eee3d8;border-radius:22px;padding:20px 18px;box-shadow:0 8px 24px rgba(86,61,41,.05)">
  <div style="font-size:10px;color:#d97828;font-weight:900;letter-spacing:.08em">HOW WE RESEARCH</div>
  <h2 style="font-size:20px;line-height:1.45;color:#3a312b;margin:5px 0 12px">このサイトの3つの約束</h2>
  <div style="display:grid;gap:9px">
    <div style="background:#fbf6f0;border:1px solid #f0e5d9;border-radius:14px;padding:12px 13px"><b style="display:block;font-size:12px;color:#443a33;margin-bottom:3px">① 公開元を確認できる体験を整理</b><span style="font-size:10px;color:#81766e;line-height:1.65">出どころが分からない体験談を、事実として混ぜません。</span></div>
    <div style="background:#fbf6f0;border:1px solid #f0e5d9;border-radius:14px;padding:12px 13px"><b style="display:block;font-size:12px;color:#443a33;margin-bottom:3px">② 犬の属性を勝手に推測しない</b><span style="font-size:10px;color:#81766e;line-height:1.65">犬種・サイズ・毛質など、確認できない情報は空欄のまま扱います。</span></div>
    <div style="background:#fbf6f0;border:1px solid #f0e5d9;border-radius:14px;padding:12px 13px"><b style="display:block;font-size:12px;color:#443a33;margin-bottom:3px">③ 広告と編集基準を分ける</b><span style="font-size:10px;color:#81766e;line-height:1.65">購入リンクの有無だけで、体験件数や表示結果を優遇しません。</span></div>
  </div>
  <div style="display:flex;flex-wrap:wrap;gap:8px 14px;margin-top:13px;font-size:10px;font-weight:800;color:#9b6036">
    <a href="/editorial-policy.html" style="text-underline-offset:3px">調査・編集方針を見る</a>
    <a href="/affiliate.html" style="text-underline-offset:3px">広告・アフィリエイト方針を見る</a>
  </div>
</section>`;

const SEARCH_SCHEMA = `<script type="application/ld+json" data-search-schema>{"@context":"https://schema.org","@type":"CollectionPage","name":"550件の犬用品体験から探す｜うちの子条件検索","url":"https://inu-taikenki.com/review-search.html","isPartOf":{"@id":"https://inu-taikenki.com/#website"},"about":{"@type":"Thing","name":"犬用品の公開体験"}}</script>`;

const CANONICAL_HTML_SLUGS = new Set([
  "about",
  "affiliate",
  "auto-feeder",
  "brush-comb",
  "brush-guide",
  "brush-pin",
  "brush-slicker",
  "brush-undercoat",
  "dog-clipper",
  "dog-conditioner",
  "dog-nail-clipper",
  "dog-nail-grinder",
  "dog-shampoo",
  "dog-size",
  "editorial-policy",
  "pet-dryer",
  "privacy",
  "review-insights",
  "review-search",
]);

function withHtml(response: Response, html: string) {
  const headers = new Headers(response.headers);
  headers.delete("content-length");
  headers.delete("etag");
  return new Response(html, {
    status: response.status,
    statusText: response.statusText,
    headers,
  });
}

function injectBeforeHeadClose(html: string, content: string) {
  return html.includes("</head>") ? html.replace("</head>", `${content}\n</head>`) : html;
}

function canonicalRedirect(request: Request) {
  if (request.method !== "GET" && request.method !== "HEAD") return null;
  const url = new URL(request.url);
  if (url.pathname === "/index") {
    url.pathname = "/";
    url.hostname = "inu-taikenki.com";
    return Response.redirect(url.toString(), 301);
  }
  const match = url.pathname.match(/^\/([^/.]+)\/?$/);
  if (!match || !CANONICAL_HTML_SLUGS.has(match[1])) return null;
  url.pathname = `/${match[1]}.html`;
  url.hostname = "inu-taikenki.com";
  return Response.redirect(url.toString(), 301);
}

function enhanceHomepage(html: string) {
  if (!html.includes("data-site-schema")) html = injectBeforeHeadClose(html, HOME_SCHEMA);

  const dogLinks: Array<[string, string]> = [
    [
      '<div class="dog-type"><img alt="小型犬" class="dog-photo" src="small-dogw.PNG"/><strong>小型犬</strong><small>チワワ・ポメ・トイプーなど</small></div>',
      '<a class="dog-type" href="/dog-size.html?size=small" aria-label="小型犬の商品体験を全カテゴリから探す"><img alt="小型犬" class="dog-photo" src="small-dogw.PNG"/><strong>小型犬</strong><small>チワワ・ポメ・トイプーなど</small></a>',
    ],
    [
      '<div class="dog-type"><img alt="中型犬" class="dog-photo medium" src="medium-dogw.PNG"/><strong>中型犬</strong><small>柴犬・コーギーなど</small></div>',
      '<a class="dog-type" href="/dog-size.html?size=medium" aria-label="中型犬の商品体験を全カテゴリから探す"><img alt="中型犬" class="dog-photo medium" src="medium-dogw.PNG"/><strong>中型犬</strong><small>柴犬・コーギーなど</small></a>',
    ],
    [
      '<div class="dog-type"><img alt="大型犬" class="dog-photo" src="large-dog.PNG"/><strong>大型犬</strong><small>ゴールデン・大型ミックスなど</small></div>',
      '<a class="dog-type" href="/dog-size.html?size=large" aria-label="大型犬の商品体験を全カテゴリから探す"><img alt="大型犬" class="dog-photo" src="large-dog.PNG"/><strong>大型犬</strong><small>ゴールデン・大型ミックスなど</small></a>',
    ],
  ];
  for (const [from, to] of dogLinks) html = html.replace(from, to);

  const traitLinks: Array<[string, string]> = [
    ['<span class="tag">🌀 ダブルコート</span>', '<a class="tag" href="/review-search.html?coat=double" aria-label="ダブルコートの体験を550件から探す">🌀 ダブルコート</a>'],
    ['<span class="tag">😨 怖がり</span>', '<a class="tag" href="/review-search.html?q=%E6%80%96%E3%81%8C%E3%82%8A" aria-label="怖がりな犬の体験を550件から探す">😨 怖がり</a>'],
    ['<span class="tag">👶 子犬</span>', '<a class="tag" href="/review-search.html?q=%E5%AD%90%E7%8A%AC" aria-label="子犬の体験を550件から探す">👶 子犬</a>'],
    ['<span class="tag">⏱️ 時短重視</span>', '<a class="tag" href="/review-search.html?q=%E6%99%82%E7%9F%AD" aria-label="時短を重視した体験を550件から探す">⏱️ 時短重視</a>'],
  ];
  for (const [from, to] of traitLinks) html = html.replace(from, to);

  if (!html.includes("data-home-trust")) {
    const promoStart = html.indexOf('<section data-home-review-search');
    if (promoStart >= 0) {
      const promoEnd = html.indexOf('</section>', promoStart);
      if (promoEnd >= 0) {
        const insertAt = promoEnd + '</section>'.length;
        html = html.slice(0, insertAt) + HOME_TRUST_BLOCK + html.slice(insertAt);
      }
    }
  }
  return html;
}

export default {
  async fetch(request: Request, env: WorkerEnv): Promise<Response> {
    const redirect = canonicalRedirect(request);
    if (redirect) return redirect;

    const response = await worker.fetch(request, env);

    if (request.method !== "GET" || !response.ok) return response;
    const contentType = response.headers.get("content-type") ?? "";
    if (!contentType.includes("text/html")) return response;

    let html = await response.text();
    const url = new URL(request.url);

    if (!html.includes('href="/favicon.ico"')) html = injectBeforeHeadClose(html, GLOBAL_HEAD);
    if (url.pathname === "/" || url.pathname === "/index.html") html = enhanceHomepage(html);
    if (url.pathname === "/review-search.html" && !html.includes("data-search-schema")) {
      html = injectBeforeHeadClose(html, SEARCH_SCHEMA);
    }

    if (!html.includes(GA4_ID)) {
      if (html.includes("<head>")) {
        html = html.replace("<head>", `<head>\n${GA4_TAG}`);
      } else if (html.includes("</head>")) {
        html = injectBeforeHeadClose(html, GA4_TAG);
      }
    }

    return withHtml(response, html);
  },
};
