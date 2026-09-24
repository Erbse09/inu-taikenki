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
  "/dog-toothbrush": "小さい口・歯磨き嫌いから選ぶ犬用歯ブラシ｜公開レビューの実体験を横断比較",
  "/dog-toothpaste": "味・香り・歯磨き嫌いから選ぶ犬用歯磨きジェル・歯磨き粉｜公開レビューを横断比較",
  "/dog-dental-chew": "噛む時間・サイズ・カロリーから選ぶ犬用デンタルガム｜公開レビューを横断比較",
  "/dog-ear-cleaner": "垂れ耳・低刺激・耳掃除嫌いから選ぶ犬用イヤークリーナー｜公開レビューを横断比較",
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
  "/dog-toothbrush": "楽天市場の公開購入者レビューとメーカー公式情報をもとに、犬用歯ブラシ6商品・50件の体験を整理。小型犬・小さい口、毛のやわらかさ、歯磨き嫌い、シニア、噛み癖などを比較し、うちの子に近い実体験から選べます。",
  "/dog-toothpaste": "楽天市場の公開購入者レビューとメーカー公式情報をもとに、犬用歯磨きジェル・歯磨き粉6商品・50件の体験を整理。味・香り、ジェルとペーストの違い、歯磨き嫌い、子犬、シニアなどを比較し、うちの子に近い実体験から選べます。",
  "/dog-dental-chew": "楽天市場の公開購入者レビューとメーカー公式情報をもとに、犬用デンタルガム6商品・50件の体験を整理。噛む時間、サイズ、子犬・シニア、口臭ケア、カロリー、丸飲みしやすさなどを比較し、うちの子に近い実体験から選べます。",
  "/dog-ear-cleaner": "楽天市場の公開購入者レビューとメーカー・販売元情報をもとに、犬用イヤークリーナー6商品・50件の体験を整理。垂れ耳、刺激の少なさ、香り、におい・汚れ、耳掃除嫌い、容量などを比較し、うちの子に近い実体験から選べます。",
};

type RelatedGuideLink = {
  href: string;
  label: string;
  note: string;
};

type RelatedGuideConfig = {
  title: string;
  links: RelatedGuideLink[];
};

const DISCOVERY_GUIDES: RelatedGuideLink[] = [
  { href: "/dog-brushing-dislike", label: "ブラッシングを嫌がるとき", note: "逃げる・噛む・痛がる原因とブラシ選びを整理" },
  { href: "/dog-nail-care-dislike", label: "爪切りを嫌がるとき", note: "パチン音・黒い爪・電動やすりを比較" },
  { href: "/dog-toothbrushing-dislike", label: "歯磨きを嫌がるとき", note: "歯ブラシ・ジェル・デンタルガムを使い分け" },
  { href: "/dog-home-shampoo-guide", label: "おうちシャンプーの手順", note: "ブラシからシャンプー、コンディショナー、乾燥まで" },
  { href: "/breed-toy-poodle", label: "トイプードルの公開体験", note: "犬種欄に明記された体験だけをカテゴリ横断で表示" },
];

const RELATED_GUIDES: Record<string, RelatedGuideConfig> = {
  "/": { title: "困りごと・犬種から探す", links: DISCOVERY_GUIDES },
  "/index": { title: "困りごと・犬種から探す", links: DISCOVERY_GUIDES },
  "/review-search": { title: "条件検索とあわせて見る", links: DISCOVERY_GUIDES },
  "/dog-size": {
    title: "犬種からも探す",
    links: [
      { href: "/breed-toy-poodle", label: "トイプードルの公開体験", note: "犬種欄にトイプードルと明記された体験だけを見る" },
    ],
  },
  "/brush-guide": {
    title: "ブラッシング・お手入れで困ったら",
    links: [
      { href: "/dog-brushing-dislike", label: "ブラッシングを嫌がるとき", note: "嫌がり方から原因とブラシ選びを整理" },
      { href: "/dog-home-shampoo-guide", label: "おうちシャンプーの手順", note: "洗う前のブラッシングから乾燥まで確認" },
    ],
  },
  "/brush-slicker": {
    title: "ブラッシングで困ったら",
    links: [{ href: "/dog-brushing-dislike", label: "ブラッシングを嫌がるとき", note: "逃げる・噛む・痛がるときの確認ポイント" }],
  },
  "/brush-pin": {
    title: "ブラッシングで困ったら",
    links: [{ href: "/dog-brushing-dislike", label: "ブラッシングを嫌がるとき", note: "逃げる・噛む・痛がるときの確認ポイント" }],
  },
  "/brush-comb": {
    title: "ブラッシングで困ったら",
    links: [{ href: "/dog-brushing-dislike", label: "ブラッシングを嫌がるとき", note: "逃げる・噛む・痛がるときの確認ポイント" }],
  },
  "/brush-undercoat": {
    title: "ブラッシングで困ったら",
    links: [{ href: "/dog-brushing-dislike", label: "ブラッシングを嫌がるとき", note: "逃げる・噛む・痛がるときの確認ポイント" }],
  },
  "/dog-nail-clipper": {
    title: "爪ケアで困ったら",
    links: [{ href: "/dog-nail-care-dislike", label: "犬が爪切りを嫌がるとき", note: "手動爪切りと電動やすりを嫌がり方から比較" }],
  },
  "/dog-nail-grinder": {
    title: "爪ケアで困ったら",
    links: [{ href: "/dog-nail-care-dislike", label: "犬が爪切りを嫌がるとき", note: "手動爪切りと電動やすりを嫌がり方から比較" }],
  },
  "/dog-toothbrush": {
    title: "歯磨きで困ったら",
    links: [{ href: "/dog-toothbrushing-dislike", label: "犬が歯磨きを嫌がるとき", note: "歯ブラシ・ジェル・デンタルガムの使い分けを整理" }],
  },
  "/dog-toothpaste": {
    title: "歯磨きで困ったら",
    links: [{ href: "/dog-toothbrushing-dislike", label: "犬が歯磨きを嫌がるとき", note: "歯ブラシ・ジェル・デンタルガムの使い分けを整理" }],
  },
  "/dog-dental-chew": {
    title: "歯磨きで困ったら",
    links: [{ href: "/dog-toothbrushing-dislike", label: "犬が歯磨きを嫌がるとき", note: "歯ブラシ・ジェル・デンタルガムの使い分けを整理" }],
  },
  "/dog-shampoo": {
    title: "おうちシャンプーの流れも確認",
    links: [{ href: "/dog-home-shampoo-guide", label: "犬のおうちシャンプー手順", note: "ブラッシングから洗浄、コンディショナー、乾燥まで" }],
  },
  "/dog-conditioner": {
    title: "おうちシャンプーの流れも確認",
    links: [{ href: "/dog-home-shampoo-guide", label: "犬のおうちシャンプー手順", note: "ブラッシングから洗浄、コンディショナー、乾燥まで" }],
  },
  "/pet-dryer": {
    title: "おうちシャンプーの流れも確認",
    links: [{ href: "/dog-home-shampoo-guide", label: "犬のおうちシャンプー手順", note: "ブラッシングから洗浄、コンディショナー、乾燥まで" }],
  },
};

type LiveCounts = {
  total_reviews: number;
  total_categories: number;
};

async function readLiveCounts(env: WorkerEnv): Promise<LiveCounts | null> {
  try {
    const row = await env.DB.prepare(`
      SELECT
        (SELECT COUNT(*)
         FROM reviews r
         JOIN products p ON p.id = r.product_id
         WHERE p.active = 1) AS total_reviews,
        (SELECT COUNT(DISTINCT category)
         FROM products
         WHERE active = 1) AS total_categories
    `).first<LiveCounts>();

    if (
      !row ||
      !Number.isFinite(row.total_reviews) ||
      !Number.isFinite(row.total_categories) ||
      row.total_reviews < 1 ||
      row.total_categories < 1
    ) return null;

    return row;
  } catch {
    return null;
  }
}

function needsLiveCounts(html: string) {
  return (
    html.includes("700件") ||
    html.includes("750件") ||
    html.includes("700 EXPERIENCES") ||
    html.includes("750 EXPERIENCES") ||
    html.includes("14カテゴリ") ||
    html.includes("15カテゴリ") ||
    html.includes("14 CATEGORIES") ||
    html.includes("15 CATEGORIES")
  );
}

function applyLiveCounts(html: string, counts: LiveCounts | null) {
  if (!counts) return html;

  const reviewCount = String(counts.total_reviews);
  const categoryCount = String(counts.total_categories);

  return html
    .replaceAll("700件", `${reviewCount}件`)
    .replaceAll("750件", `${reviewCount}件`)
    .replaceAll("700 EXPERIENCES", `${reviewCount} EXPERIENCES`)
    .replaceAll("750 EXPERIENCES", `${reviewCount} EXPERIENCES`)
    .replaceAll("700 DOG PRODUCT EXPERIENCES", `${reviewCount} DOG PRODUCT EXPERIENCES`)
    .replaceAll("750 DOG PRODUCT EXPERIENCES", `${reviewCount} DOG PRODUCT EXPERIENCES`)
    .replaceAll("14カテゴリ", `${categoryCount}カテゴリ`)
    .replaceAll("15カテゴリ", `${categoryCount}カテゴリ`)
    .replaceAll("14 CATEGORIES", `${categoryCount} CATEGORIES`)
    .replaceAll("15 CATEGORIES", `${categoryCount} CATEGORIES`)
    .replaceAll('<b>700</b><span>整理した公開体験</span>', `<b>${reviewCount}</b><span>整理した公開体験</span>`)
    .replaceAll('<b>750</b><span>整理した公開体験</span>', `<b>${reviewCount}</b><span>整理した公開体験</span>`)
    .replaceAll('<b>700</b><span>公開体験</span>', `<b>${reviewCount}</b><span>公開体験</span>`)
    .replaceAll('<b>750</b><span>公開体験</span>', `<b>${reviewCount}</b><span>公開体験</span>`)
    .replaceAll('<b>14</b><span>犬用品カテゴリ</span>', `<b>${categoryCount}</b><span>犬用品カテゴリ</span>`)
    .replaceAll('<b>15</b><span>犬用品カテゴリ</span>', `<b>${categoryCount}</b><span>犬用品カテゴリ</span>`)
    .replaceAll('<b>14</b><span>カテゴリ</span>', `<b>${categoryCount}</b><span>カテゴリ</span>`)
    .replaceAll('<b>15</b><span>カテゴリ</span>', `<b>${categoryCount}</b><span>カテゴリ</span>`);
}


type ReviewFallbackRow = {
  product_name?: string | null;
  dog_breed?: string | null;
  dog_size?: string | null;
  coat_type?: string | null;
  needs?: string | null;
  summary?: string | null;
};

type ReviewFallbackPayload = {
  count?: number;
  reviews?: ReviewFallbackRow[];
};

type ReviewStatsFallbackPayload = {
  count?: number;
  product_count?: number;
  coverage?: { breed?: number; size?: number; coat?: number };
  products?: Array<{ product_name?: string | null; count?: number }>;
};

function escapeHtml(value: unknown) {
  return String(value ?? "")
    .replaceAll("&", "&amp;")
    .replaceAll("<", "&lt;")
    .replaceAll(">", "&gt;")
    .replaceAll('"', "&quot;")
    .replaceAll("'", "&#039;");
}

function searchApiParams(request: Request, includeLimit = false) {
  const pageUrl = new URL(request.url);
  const params = new URLSearchParams();
  const category = pageUrl.searchParams.get("category") || "pet-dryer";
  params.set("category", category);
  for (const key of ["size", "coat", "q", "breed", "trait", "product"]) {
    const value = pageUrl.searchParams.get(key);
    if (value) params.set(key, value);
  }
  if (includeLimit) params.set("limit", "6");
  return params;
}

async function readReviewSearchFallback(request: Request, env: WorkerEnv): Promise<ReviewFallbackPayload | null> {
  try {
    const pageUrl = new URL(request.url);
    const params = searchApiParams(request, true);
    const apiRequest = new Request(new URL(`/api/reviews?${params.toString()}`, pageUrl.origin), {
      headers: { accept: "application/json" },
    });
    const apiResponse = await worker.fetch(apiRequest, env);
    if (!apiResponse.ok) return null;
    const payload = await apiResponse.json() as ReviewFallbackPayload;
    if (!Number.isFinite(payload.count) || !Array.isArray(payload.reviews)) return null;
    return payload;
  } catch {
    return null;
  }
}

function renderReviewFallbackCard(row: ReviewFallbackRow) {
  const breed = row.dog_breed?.trim() || "犬種情報なし";
  return `<article class="card" data-static-review-card>
<div class="product">${escapeHtml(row.product_name || "犬用品")}</div>
<div class="dog">${escapeHtml(breed)}</div>
<div class="summary">${escapeHtml(row.summary || "")}</div>
</article>`;
}

async function integrateReviewSearchFallback(request: Request, html: string, env: WorkerEnv) {
  const pathname = new URL(request.url).pathname.replace(/\.html$/, "");
  if (pathname !== "/review-search") return html;

  const payload = await readReviewSearchFallback(request, env);
  if (!payload) return html;

  const count = Number(payload.count) || 0;
  const cards = payload.reviews?.slice(0, 6).map(renderReviewFallbackCard).join("\n") || "";
  const status = `<div class="status" id="status" aria-live="polite" data-static-review-status><strong>${count}件</strong> 条件一致</div>`;
  const list = cards
    ? `<div class="list" id="list" data-static-review-fallback>${cards}</div>`
    : '<div class="list" id="list" data-static-review-fallback><div class="empty">この条件に合う体験はありません。条件を少し広げてみてください。</div></div>';

  html = html.replace(
    /<div class="status" id="status" aria-live="polite">[\s\S]*?<\/div>/,
    status,
  );
  html = html.replace('<div class="list" id="list"></div>', list);
  return html;
}

async function readReviewStatsFallback(request: Request, env: WorkerEnv): Promise<ReviewStatsFallbackPayload | null> {
  try {
    const pageUrl = new URL(request.url);
    const params = new URLSearchParams();
    for (const key of ["category", "size", "coat", "trait"]) {
      const value = pageUrl.searchParams.get(key);
      if (value) params.set(key, value);
    }
    const apiRequest = new Request(new URL(`/api/reviews/stats?${params.toString()}`, pageUrl.origin), {
      headers: { accept: "application/json" },
    });
    const apiResponse = await worker.fetch(apiRequest, env);
    if (!apiResponse.ok) return null;
    const payload = await apiResponse.json() as ReviewStatsFallbackPayload;
    if (!Number.isFinite(payload.count) || !Number.isFinite(payload.product_count)) return null;
    return payload;
  } catch {
    return null;
  }
}

async function integrateReviewInsightsFallback(request: Request, html: string, env: WorkerEnv) {
  const pathname = new URL(request.url).pathname.replace(/\.html$/, "");
  if (pathname !== "/review-insights") return html;

  const payload = await readReviewStatsFallback(request, env);
  if (!payload) return html;

  const count = Number(payload.count) || 0;
  const productCount = Number(payload.product_count) || 0;
  const coverage = payload.coverage || {};
  const pct = (value: number | undefined) => count > 0 ? `${Math.round((Number(value) || 0) / count * 100)}%` : "0%";
  const products = (payload.products || []).slice(0, 5).map((product) =>
    `<div class="product-item" data-static-insight-product><b>${escapeHtml(product.product_name || "犬用品")}</b><span>${Number(product.count) || 0}件の体験を収録</span></div>`
  ).join("");

  html = html
    .replace('<b id="total">…</b>', `<b id="total">${count}</b>`)
    .replace('<b id="products">…</b>', `<b id="products">${productCount}</b>`)
    .replace('<div class="summary" id="summary">読み込み中…</div>', `<div class="summary" id="summary" data-static-review-summary><strong>${count}件</strong> の公開体験を集計</div>`)
    .replace('<div class="product-list" id="topProducts"></div>', `<div class="product-list" id="topProducts">${products}</div>`)
    .replace('<b id="breedCov">…</b>', `<b id="breedCov">${pct(coverage.breed)}</b>`)
    .replace('<b id="sizeCov">…</b>', `<b id="sizeCov">${pct(coverage.size)}</b>`)
    .replace('<b id="coatCov">…</b>', `<b id="coatCov">${pct(coverage.coat)}</b>`);

  return html;
}

function integrateEarCleaner(request: Request, html: string) {
  const pathname = new URL(request.url).pathname.replace(/\.html$/, "");

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

function integrateInternalLinks(request: Request, html: string) {
  if (html.includes("data-inu-related-guides")) return html;
  const pathname = new URL(request.url).pathname.replace(/\.html$/, "");
  const config = RELATED_GUIDES[pathname];
  if (!config) return html;

  const links = config.links.filter(
    ({ href }) => !html.includes(`href="${href}"`) && !html.includes(`href='${href}'`),
  );
  if (!links.length) return html;

  const cards = links
    .map(
      ({ href, label, note }) => `<a href="${href}" style="display:block;background:#fff;border:1px solid #eee3d8;border-radius:14px;padding:13px 14px;text-decoration:none;color:#3a312b">
<strong style="display:block;font-size:12px;line-height:1.5;margin-bottom:4px">${label}</strong>
<span style="display:block;font-size:10px;line-height:1.65;color:#766b63">${note}</span>
<span style="display:block;margin-top:7px;font-size:9px;font-weight:850;color:#d97828">詳しく見る →</span>
</a>`,
    )
    .join("\n");

  const section = `<section data-inu-related-guides aria-label="関連ガイド" style="margin:34px 0 28px">
<div style="font-size:10px;font-weight:900;letter-spacing:.08em;color:#d97828">RELATED GUIDES</div>
<h2 style="font-size:20px;line-height:1.5;margin:5px 0 11px;color:#3a312b">${config.title}</h2>
<div style="display:grid;grid-template-columns:repeat(auto-fit,minmax(210px,1fr));gap:9px">${cards}</div>
</section>`;

  if (html.includes("</main>")) return html.replace("</main>", `${section}\n</main>`);
  return html.replace("</body>", `${section}\n</body>`);
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
    html = integrateInternalLinks(request, html);
    html = integrateFavicons(html);
    html = integrateSeoTitle(request, html);
    html = integrateSeoDescription(request, html);
    if (needsLiveCounts(html)) {
      html = applyLiveCounts(html, await readLiveCounts(env));
    }
    html = await integrateReviewSearchFallback(request, html, env);
    html = await integrateReviewInsightsFallback(request, html, env);
    html = integrateReviewSourcePolicy(html);
    return htmlResponse(response, html);
  },
};