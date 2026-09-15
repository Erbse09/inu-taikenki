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

const REMOVE_REVIEW_SOURCE_LINKS = `<script data-remove-review-source-links>
(() => {
  const removeSourceLinks = () => {
    document.querySelectorAll('a').forEach((link) => {
      if ((link.textContent || '').trim().startsWith('確認元を見る')) {
        const wrapper = link.closest('.db-review-source, .source');
        (wrapper || link).remove();
      }
    });
  };
  removeSourceLinks();
  new MutationObserver(removeSourceLinks).observe(document.documentElement, { childList: true, subtree: true });
})();
</script>`;

const SEO_TITLES: Record<string, string> = {
  "/": "犬用品の公開体験750件を犬種・条件別に比較｜犬体験記",
  "/index": "犬用品の公開体験750件を犬種・条件別に比較｜犬体験記",
  "/brush-comb": "毛玉・仕上げから選ぶ犬用コーム｜公開レビューの実体験を横断比較",
  "/brush-slicker": "毛玉・もつれから選ぶ犬用スリッカーブラシ｜複数サイトの実体験を横断比較",
  "/brush-undercoat": "換毛期・抜け毛から選ぶ犬用アンダーコートブラシ｜複数サイトの実体験を横断比較",
  "/brush-pin": "犬種・毛質から選ぶ犬用ピンブラシ｜複数サイトの実体験を横断比較",
  "/dog-shampoo": "低刺激・保湿・仕上がりから選ぶ犬用シャンプー｜複数サイトの実体験を横断比較",
  "/dog-conditioner": "毛質・仕上がりから選ぶ犬用コンディショナー｜複数サイトの実体験を横断比較",
  "/dog-nail-clipper": "ギロチン・ニッパーの違いから選ぶ犬用爪切り｜複数サイトの実体験を横断比較",
  "/dog-nail-grinder": "音・振動・太い爪から選ぶ犬用電動爪やすり｜複数サイトの実体験を横断比較",
  "/dog-clipper": "全身・足裏・怖がり犬から選ぶ犬用バリカン｜複数サイトの実体験を横断比較",
  "/auto-feeder": "留守番・停電対策・カメラから選ぶ犬用自動給餌器｜複数サイトの実体験を横断比較",
  "/pet-dryer": "音・乾燥時間から選ぶ犬用ペットドライヤー｜複数サイトの実体験を横断比較",
  "/dog-toothbrush": "犬用歯ブラシの公開体験50件｜サイズ・磨きやすさ・嫌がり方を比較",
  "/dog-toothpaste": "犬用歯磨きジェル・歯磨き粉の公開体験50件｜味・使いやすさを比較",
  "/dog-dental-chew": "犬用デンタルガムの公開体験50件｜食いつき・硬さ・続けやすさを比較",
  "/dog-ear-cleaner": "犬用イヤークリーナーの公開体験50件｜低刺激・におい・耳掃除嫌いを比較",
};

const SEO_DESCRIPTIONS: Record<string, string> = {
  "/pet-dryer": "Amazon・楽天など複数サイトの公開口コミ・体験を横断整理。犬種・サイズ・毛質ごとに、風量・音への反応・乾燥時間・ハンズフリーの使いやすさを比較し、うちの子に近い実体験から選べます。",
  "/brush-slicker": "Amazon・楽天など複数サイトの公開口コミ・体験を横断整理。犬種・毛質ごとに、毛玉・もつれへの使いやすさ、ピンの硬さ、仕上がりを比較し、うちの子に近い実体験から選べます。",
  "/brush-undercoat": "楽天レビュー・Xなど複数の公開情報から犬用アンダーコートブラシの体験を横断整理。柴犬・コーギー・レトリバーなどダブルコート犬を中心に、換毛期の抜け毛、下毛の取れ方、嫌がり方、スリッカーとの違いを比較し、うちの子に近い実体験から選べます。",
  "/brush-comb": "楽天レビューなどの公開情報から犬用コームの体験を横断整理。トイプードル・マルチーズなど犬種や毛質ごとに、毛玉・もつれ、スリッカー後の仕上げ、根元確認、顔・足まわりでの使いやすさを比較し、うちの子に近い実体験から選べます。",
  "/dog-shampoo": "楽天・Yahoo!ショッピングなど複数サイトの犬用シャンプーの公開口コミ・体験を横断整理。短毛・長毛など毛質ごとに、低刺激・保湿・香り・泡立ち・すすぎやすさ・仕上がりを比較し、うちの子に近い実体験から選べます。",
  "/dog-conditioner": "Amazon・楽天など複数サイトの犬用コンディショナー・トリートメントの公開口コミ・体験を横断整理。長毛・短毛など毛質ごとに、ふわふわ・しっとり、毛玉、静電気、香りを比較し、うちの子に近い実体験から選べます。",
  "/dog-nail-clipper": "Amazon・楽天など複数サイトの犬用爪切りの公開口コミ・体験を横断整理。ギロチン・ニッパー・ハサミ式の違い、犬のサイズ、黒い爪、音や衝撃への反応、初心者の使いやすさを比較し、うちの子に近い実体験から選べます。",
  "/dog-nail-grinder": "Yahoo!ショッピング・海外小売レビュー・Redditなど複数の公開情報から犬用電動爪やすりの体験を横断整理。怖がり犬・黒い爪・大型犬などの条件ごとに、音・振動、削る速さ、太い爪への対応、使いやすさを比較し、うちの子に近い実体験から選べます。",
  "/dog-clipper": "楽天市場・Yahoo!ショッピングなど複数サイトの公開口コミ・体験を横断整理。犬種・年齢ごとに、全身用と足裏・顔まわり用の違い、音・振動、切れ味、怖がり犬やシニア犬での使いやすさを比較し、うちの子に近い実体験から選べます。",
  "/auto-feeder": "Yahoo!ショッピング・楽天市場・メーカー情報・Xなど複数の公開情報を横断整理。犬種・年齢・留守番スタイルごとに、給餌スケジュール、1回量、容量、停電・Wi-Fi切断時の動作、カメラ機能を比較し、うちの子に近い実体験から選べます。",
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

function integrateSeoDescription(request: Request, html: string) {
  const pathname = new URL(request.url).pathname.replace(/\.html$/, "");
  const description = SEO_DESCRIPTIONS[pathname];
  if (!description) return html;
  const escaped = description.replaceAll("&", "&amp;").replaceAll('"', "&quot;");
  const tag = `<meta name="description" content="${escaped}">`;
  const metaPattern = /<meta\b(?=[^>]*\bname=["']description["'])[^>]*>/i;
  if (metaPattern.test(html)) return html.replace(metaPattern, tag);
  return html.replace("</head>", `${tag}\n</head>`);
}

function integrateReviewSourcePolicy(html: string) {
  if (html.includes("data-remove-review-source-links")) return html;
  return html.replace("</body>", `${REMOVE_REVIEW_SOURCE_LINKS}\n</body>`);
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
    html = integrateSeoDescription(request, html);
    html = integrateReviewSourcePolicy(html);
    return htmlResponse(response, html);
  },
};