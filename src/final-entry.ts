import worker from "./entry";

type WorkerEnv = Parameters<typeof worker.fetch>[1];

const EAR_HOME_CARD = `<article class="research-card">
<div class="article-badge">犬用イヤークリーナー</div>
<h3>犬用イヤークリーナー6商品を公開体験50件で比較</h3>
<p>垂れ耳・耳掃除嫌い・におい・汚れ・低刺激など、選び方が分かる公開体験を6商品で整理しました。</p>
<div class="research-summary"><div class="research-stat"><b>50</b><span>公開体験</span></div><div class="research-stat"><b>6</b><span>比較商品</span></div><div class="research-stat"><b>6軸</b><span>選び方</span></div></div>
<div class="breed-list"><span class="breed">ゴールデン</span><span class="breed">トイプードル</span><span class="breed">チワックス</span><span class="breed">垂れ耳</span></div>
<a class="read-button" href="dog-ear-cleaner">うちの子向けイヤークリーナーを見る →</a>
</article>`;

const WEBSITE_SCHEMA = `<script type="application/ld+json" data-inu-website-schema>
{
  "@context": "https://schema.org",
  "@type": "WebSite",
  "url": "https://inu-taikenki.com/",
  "name": "犬用品みんなの体験記",
  "alternateName": "犬体験記",
  "inLanguage": "ja"
}
</script>`;

const FAVICON_LINKS = `<link rel="icon" type="image/png" sizes="96x96" href="/favicon-96.png">
<link rel="icon" type="image/svg+xml" href="/site-icon.svg">
<link rel="shortcut icon" href="/favicon.ico">
<link rel="apple-touch-icon" href="/apple-touch-icon.svg">
<link rel="manifest" href="/site.webmanifest">`;

const SEO_TITLES: Record<string, string> = {
  "/": "犬用品の公開体験750件を犬種・条件別に比較｜犬体験記",
  "/index": "犬用品の公開体験750件を犬種・条件別に比較｜犬体験記",
  "/brush-comb": "犬用コームの公開体験50件｜毛玉・仕上げ・長毛犬を比較",
  "/brush-slicker": "犬用スリッカーブラシの公開体験50件｜毛玉・抜け毛・怖がり犬を比較",
  "/brush-undercoat": "犬用アンダーコートブラシの公開体験50件｜抜け毛・ダブルコートを比較",
  "/brush-pin": "犬種・毛質から選ぶ犬用ピンブラシ｜複数サイトの実体験を横断比較",
  "/dog-shampoo": "犬用シャンプーの公開体験50件｜低刺激・保湿・仕上がりを比較",
  "/dog-conditioner": "犬用コンディショナーの公開体験50件｜毛質・仕上がり別に比較",
  "/dog-nail-clipper": "犬用爪切りの公開体験50件｜ギロチン・ニッパー・怖がり犬を比較",
  "/dog-nail-grinder": "犬用電動爪やすりの公開体験50件｜音・怖がり・大型犬を比較",
  "/dog-clipper": "犬用バリカンの公開体験50件｜音・切れ味・初心者目線で比較",
  "/auto-feeder": "犬用自動給餌器の公開体験50件｜留守番・食べ方・使いやすさを比較",
  "/pet-dryer": "犬用ペットドライヤーの公開体験50件｜風量・音・乾燥時間を比較",
  "/dog-toothbrush": "犬用歯ブラシの公開体験50件｜サイズ・磨きやすさ・嫌がり方を比較",
  "/dog-toothpaste": "犬用歯磨きジェル・歯磨き粉の公開体験50件｜味・使いやすさを比較",
  "/dog-dental-chew": "犬用デンタルガムの公開体験50件｜食いつき・硬さ・続けやすさを比較",
  "/dog-ear-cleaner": "犬用イヤークリーナーの公開体験50件｜低刺激・におい・耳掃除嫌いを比較",
};

function updateCounts(html: string) {
  return html
    .replaceAll("700件", "750件")
    .replaceAll("700 EXPERIENCES", "750 EXPERIENCES")
    .replaceAll("14カテゴリ", "15カテゴリ")
    .replaceAll('<b>14</b><span>犬用品カテゴリ</span>', '<b>15</b><span>犬用品カテゴリ</span>')
    .replaceAll('<b>14</b><span>カテゴリ</span>', '<b>15</b><span>カテゴリ</span>');
}

function integrateEarCleaner(request: Request, html: string) {
  const pathname = new URL(request.url).pathname.replace(/\.html$/, "");
  html = updateCounts(html);

  if (pathname === "/" || pathname === "/index") {
    html = html.replace(
      '<div class="article-badge">犬用デンタルガム</div>\n<h3>犬用歯磨きジェル・歯磨き粉6商品を公開体験50件で比較</h3>',
      '<div class="article-badge">犬用デンタルガム</div>\n<h3>犬用デンタルガム6商品を公開体験50件で比較</h3>',
    );
    if (!html.includes('href="dog-ear-cleaner"')) {
      html = html.replace('<div class="article-grid">', `<div class="article-grid">\n${EAR_HOME_CARD}`);
    }
    if (!html.includes("data-inu-website-schema")) {
      html = html.replace("</head>", `${WEBSITE_SCHEMA}\n</head>`);
    }
  }

  if (pathname === "/review-search" || pathname === "/review-insights") {
    if (!html.includes('value="dog-ear-cleaner"')) {
      html = html.replace(
        '<option value="dog-dental-chew">犬用デンタルガム</option>',
        '<option value="dog-dental-chew">犬用デンタルガム</option><option value="dog-ear-cleaner">犬用イヤークリーナー</option>',
      );
    }
  }

  if (pathname === "/dog-size") {
    if (!html.includes('data-cat="dog-ear-cleaner"')) {
      html = html.replace(
        '<button class="cat" data-cat="dog-dental-chew">デンタルガム</button>',
        '<button class="cat" data-cat="dog-dental-chew">デンタルガム</button><button class="cat" data-cat="dog-ear-cleaner">イヤークリーナー</button>',
      );
    }
    if (!html.includes("'dog-ear-cleaner':'犬用イヤークリーナー'")) {
      html = html.replace(
        "'dog-dental-chew':'犬用デンタルガム'",
        "'dog-dental-chew':'犬用デンタルガム','dog-ear-cleaner':'犬用イヤークリーナー'",
      );
    }
    if (!html.includes("'dog-ear-cleaner':'/dog-ear-cleaner'")) {
      html = html.replace(
        "'dog-dental-chew':'/dog-dental-chew'",
        "'dog-dental-chew':'/dog-dental-chew','dog-ear-cleaner':'/dog-ear-cleaner'",
      );
    }
  }

  return html;
}

function integrateFavicons(html: string) {
  const faviconPattern = /<link\b[^>]*rel=["'][^"']*(?:icon|manifest)[^"']*["'][^>]*>\s*/gi;
  html = html.replace(faviconPattern, "");
  if (html.includes("</head>")) {
    return html.replace("</head>", `${FAVICON_LINKS}\n</head>`);
  }
  return html;
}

function integrateSeoTitle(request: Request, html: string) {
  const pathname = new URL(request.url).pathname.replace(/\.html$/, "");
  const title = SEO_TITLES[pathname];
  if (!title) return html;
  if (/<title>[\s\S]*?<\/title>/i.test(html)) {
    return html.replace(/<title>[\s\S]*?<\/title>/i, `<title>${title}</title>`);
  }
  return html.replace("</head>", `<title>${title}</title>\n</head>`);
}

function htmlResponse(response: Response, html: string) {
  const headers = new Headers(response.headers);
  headers.delete("content-length");
  headers.delete("etag");
  headers.set("cache-control", "no-store");
  return new Response(html, {
    status: response.status,
    statusText: response.statusText,
    headers,
  });
}

export default {
  async fetch(request: Request, env: WorkerEnv): Promise<Response> {
    const response = await worker.fetch(request, env);
    if (request.method !== "GET" || !response.ok) return response;
    const contentType = response.headers.get("content-type") ?? "";
    if (!contentType.includes("text/html")) return response;

    let html = integrateEarCleaner(request, await response.text());
    html = integrateFavicons(html);
    html = integrateSeoTitle(request, html);
    return htmlResponse(response, html);
  },
};