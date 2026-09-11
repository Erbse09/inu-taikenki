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

    const html = integrateEarCleaner(request, await response.text());
    return htmlResponse(response, html);
  },
};
