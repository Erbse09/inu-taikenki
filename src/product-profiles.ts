// Server-rendered product overview for each category article.
// Everything shown here is computed from existing rows (reviews/products); nothing is generated or guessed.
// Read-only: SELECT statements only, so it also passes the Preview read-only wrapper.
interface Statement {
  bind(...values: (string | number | null)[]): Statement;
  all<T>(): Promise<{ results?: T[] }>;
}
interface DB { prepare(sql: string): Statement; }

type ProductRow = { id: string; name: string };
type ReviewRow = {
  product_id: string;
  dog_breed: string | null;
  dog_size: string | null;
  coat_type: string | null;
  needs: string | null;
  summary: string;
  source_type: string | null;
  source_url: string | null;
};

export const PROFILE_CATEGORIES = new Set([
  "pet-dryer", "auto-feeder", "dog-clipper", "brush-slicker", "brush-pin", "brush-undercoat", "brush-comb",
  "nail-grinder", "nail-clipper", "dog-shampoo", "dog-conditioner", "dog-toothbrush", "dog-toothpaste",
  "dog-dental-chew", "dog-ear-cleaner",
]);

const SIZE_LABELS: Record<string, string> = { small: "小型", medium: "中型", large: "大型" };
const COAT_LABELS: Record<string, string> = {
  short: "短毛", long: "長毛", double: "ダブルコート", curly: "巻毛", wire: "ワイヤー", single: "シングルコート",
};
const NEED_LABELS: Record<string, string> = {
  scared: "怖がり", puppy: "子犬", senior: "シニア", speed: "時短", handsfree: "ハンズフリー", shedding: "抜け毛",
  mat: "毛玉", tangle: "もつれ", gentle: "やさしさ重視", relaxed: "落ち着いて使用", multi: "多頭", "multi-dog": "多頭",
  daily: "日常ケア", grooming: "お手入れ", face: "顔まわり", skin: "皮膚配慮", "skin-sensitive": "皮膚配慮",
  quiet: "静音", camera: "カメラ", travel: "外出・旅行", beginner: "初心者", handling: "扱いやすさ", scent: "香り",
  taste: "味・食いつき", repeat: "リピート", size: "サイズ感",
};

// A contrast marker ("〜の一方…") or an explicit reservation. Used only to pick which existing summaries to quote.
const RESERVATION = /一方|混合評価|不具合|故障|難点|物足り|が気になった|気になると感じ/;
const NOT_RESERVATION = /不満なく|不安を減らせ/;

const esc = (value: unknown) => String(value ?? "")
  .replaceAll("&", "&amp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;")
  .replaceAll('"', "&quot;").replaceAll("'", "&#039;");

const tokens = (value: string | null | undefined) =>
  String(value ?? "").trim().toLowerCase().split(/\s+/).filter((t) => t && t !== "null");

export function sourceKind(row: Pick<ReviewRow, "source_type" | "source_url">): string {
  if (row.source_type === "existing_article_summary") return "サイト内記事の再整理";
  const url = row.source_url || "";
  if (/rakuten\.co\.jp/i.test(url)) return "楽天市場";
  if (/yahoo\.co\.jp/i.test(url)) return "Yahoo!ショッピング";
  if (/amazon\./i.test(url)) return "Amazon";
  if (/chewy\.com|lowes\.com/i.test(url)) return "海外小売サイト";
  return "その他の公開情報";
}

function breedKey(raw: string | null): string | null {
  const text = String(raw ?? "").trim();
  if (!text || /犬種不明/.test(text)) return null;
  const head = text.split(/[・（(、,\/]/)[0].trim();
  return head && head.length <= 14 ? head : null;
}

function top(counter: Map<string, number>, limit: number): Array<[string, number]> {
  return [...counter.entries()].sort((a, b) => b[1] - a[1] || a[0].localeCompare(b[0], "ja")).slice(0, limit);
}

export type ProductProfile = {
  id: string;
  name: string;
  count: number;
  sizes: Record<string, number>;
  sizeUnknown: number;
  coats: Array<[string, number]>;
  needs: Array<[string, number]>;
  breeds: string[];
  sources: Array<[string, number]>;
  examples: string[];
  reservations: string[];
};

export function buildProfiles(products: ProductRow[], reviews: ReviewRow[]): ProductProfile[] {
  const byProduct = new Map<string, ReviewRow[]>();
  for (const review of reviews) {
    const list = byProduct.get(review.product_id) ?? [];
    list.push(review);
    byProduct.set(review.product_id, list);
  }
  const profiles: ProductProfile[] = [];
  for (const product of products) {
    const rows = byProduct.get(product.id);
    if (!rows?.length) continue;
    const sizes: Record<string, number> = { small: 0, medium: 0, large: 0 };
    let sizeUnknown = 0;
    const coats = new Map<string, number>();
    const needs = new Map<string, number>();
    const breeds = new Map<string, number>();
    const sources = new Map<string, number>();
    for (const row of rows) {
      const sizeTokens = tokens(row.dog_size).filter((t) => t in sizes);
      if (!sizeTokens.length) sizeUnknown++;
      for (const t of new Set(sizeTokens)) sizes[t]++;
      for (const t of new Set(tokens(row.coat_type))) if (COAT_LABELS[t]) coats.set(COAT_LABELS[t], (coats.get(COAT_LABELS[t]) ?? 0) + 1);
      const labels = new Set(tokens(row.needs).map((t) => NEED_LABELS[t]).filter(Boolean));
      for (const label of labels) needs.set(label, (needs.get(label) ?? 0) + 1);
      const breed = breedKey(row.dog_breed);
      if (breed) breeds.set(breed, (breeds.get(breed) ?? 0) + 1);
      const kind = sourceKind(row);
      sources.set(kind, (sources.get(kind) ?? 0) + 1);
    }
    // Quote existing summaries only: prefer ones that name a breed, from different sources / dog sizes.
    const usable = rows.filter((r) => r.summary && r.summary.length >= 20);
    const pick = (candidates: ReviewRow[], limit: number) => {
      // Prefer rows that name a breed, and spread the picks across different dog sizes when possible.
      const ranked = [...candidates].sort((x, y) => Number(!!breedKey(y.dog_breed)) - Number(!!breedKey(x.dog_breed)));
      const chosen: ReviewRow[] = [];
      const seenSize = new Set<string>();
      for (const row of ranked) {
        const size = tokens(row.dog_size)[0] ?? "";
        if (size && seenSize.has(size)) continue;
        chosen.push(row);
        if (size) seenSize.add(size);
        if (chosen.length >= limit) return chosen;
      }
      for (const row of ranked) {
        if (chosen.length >= limit) break;
        if (!chosen.includes(row)) chosen.push(row);
      }
      return chosen;
    };
    const reservations = pick(usable.filter((r) => RESERVATION.test(r.summary) && !NOT_RESERVATION.test(r.summary)), 2);
    const reservationIds = new Set(reservations);
    const examples = pick(usable.filter((r) => !reservationIds.has(r)), 2);
    const line = (row: ReviewRow) => {
      const breed = breedKey(row.dog_breed);
      return (breed ? breed + "｜" : "") + row.summary;
    };
    profiles.push({
      id: product.id,
      name: product.name,
      count: rows.length,
      sizes,
      sizeUnknown,
      coats: top(coats, 2),
      needs: top(needs, 4),
      breeds: top(breeds, 3).map(([name]) => name),
      sources: top(sources, 4),
      examples: examples.map(line),
      reservations: reservations.map(line),
    });
  }
  return profiles.sort((a, b) => b.count - a.count || a.name.localeCompare(b.name, "ja"));
}

const STYLE = `<style data-inu-profiles-style>
[data-inu-profiles]{margin:34px 0 28px;background:#fff;border:1px solid #eadfd5;border-radius:20px;padding:18px 16px;color:#3a312b}
[data-inu-profiles] .ip-eyebrow{font-size:11px;font-weight:900;letter-spacing:.1em;color:#d87327}
[data-inu-profiles] h2{font-size:20px;line-height:1.5;margin:4px 0 8px}
[data-inu-profiles] h3{font-size:16px;line-height:1.5;margin:0 0 6px}
[data-inu-profiles] p,[data-inu-profiles] li,[data-inu-profiles] td,[data-inu-profiles] th{font-size:13px;line-height:1.75}
[data-inu-profiles] .ip-note{color:#766c65;margin:0 0 12px}
[data-inu-profiles] .ip-scroll{overflow-x:auto;-webkit-overflow-scrolling:touch;margin:10px 0 16px}
[data-inu-profiles] table{border-collapse:collapse;min-width:560px;width:100%}
[data-inu-profiles] th,[data-inu-profiles] td{border:1px solid #eadfd5;padding:7px 9px;text-align:left;vertical-align:top}
[data-inu-profiles] th{background:#fff7ed;font-weight:800}
[data-inu-profiles] .ip-card{border-top:1px solid #eadfd5;padding:14px 0 4px}
[data-inu-profiles] .ip-meta{color:#766c65;margin:0 0 6px}
[data-inu-profiles] ul{margin:4px 0 10px;padding-left:20px}
[data-inu-profiles] .ip-label{font-weight:800;font-size:13px;margin:8px 0 2px;color:#8a5a2b}
</style>`;

function sizeCell(profile: ProductProfile) {
  const parts = (["small", "medium", "large"] as const)
    .filter((key) => profile.sizes[key] > 0)
    .map((key) => `${SIZE_LABELS[key]}${profile.sizes[key]}`);
  const body = parts.length ? parts.join("／") : "記載なし";
  return profile.sizeUnknown ? `${body}（サイズ記載なし${profile.sizeUnknown}）` : body;
}

export function renderProfilesHtml(categoryLabel: string, profiles: ProductProfile[]): string {
  if (!profiles.length) return "";
  const total = profiles.reduce((sum, p) => sum + p.count, 0);
  const rows = profiles.map((p) =>
    `<tr><th scope="row">${esc(p.name)}</th><td>${p.count}件</td><td>${esc(sizeCell(p))}</td><td>${esc(p.needs.map(([l]) => l).slice(0, 3).join("・") || "記載なし")}</td><td>${esc(p.breeds.join("・") || "記載なし")}</td></tr>`).join("");
  const cards = profiles.map((p) => {
    const sources = p.sources.map(([label, n]) => `${esc(label)}${n}件`).join("／");
    const coats = p.coats.length ? p.coats.map(([l, n]) => `${esc(l)}${n}`).join("・") : "記載なし";
    const needs = p.needs.length ? p.needs.map(([l, n]) => `${esc(l)}${n}`).join("・") : "記載なし";
    const list = (items: string[]) => items.map((t) => `<li>${esc(t)}</li>`).join("");
    return `<article class="ip-card" data-inu-profile="${esc(p.id)}">
<h3>${esc(p.name)}</h3>
<p class="ip-meta">整理した体験 ${p.count}件｜犬のサイズ：${esc(sizeCell(p))}｜毛質の記載：${coats}｜条件の記載：${needs}</p>
<p class="ip-meta">要約の元になった確認先：${sources}</p>
${p.examples.length ? `<div class="ip-label">この商品の体験から（要約）</div><ul>${list(p.examples)}</ul>` : ""}
${p.reservations.length ? `<div class="ip-label">評価が分かれた・気になる点にも触れた体験（要約）</div><ul>${list(p.reservations)}</ul>` : ""}
</article>`;
  }).join("\n");
  return `${STYLE}
<section data-inu-profiles aria-label="${esc(categoryLabel)}の商品別データ">
<div class="ip-eyebrow">PRODUCT DATA</div>
<h2>${esc(categoryLabel)}｜商品別に見る体験の傾向（${profiles.length}商品・${total}件）</h2>
<p class="ip-note">下の表と一覧は、このサイトに整理した体験の記載から集計したものです。<strong>体験の件数が多い＝おすすめ順位ではありません</strong>。「うちの子と同じサイズ・毛質・条件の体験があるか」を見るための目安として使ってください。サイズなどが書かれていない体験は推測で補っていません。</p>
<div class="ip-scroll"><table>
<thead><tr><th scope="col">商品</th><th scope="col">体験数</th><th scope="col">犬のサイズ（記載のあった体験）</th><th scope="col">よく書かれた条件</th><th scope="col">犬の記載例（犬種など）</th></tr></thead>
<tbody>${rows}</tbody></table></div>
${cards}
<p class="ip-note">体験は、販売サイトなどに公開されたレビュー等を運営者が要約・整理したものです（運営者自身の使用体験ではありません）。確認先の多くは商品のレビュー一覧ページで、個別の投稿へ直接リンクしているわけではありません。詳しくは<a href="/editorial-policy">調査・編集方針</a>をご覧ください。</p>
</section>`;
}

export async function loadCategoryProfiles(db: DB, category: string): Promise<ProductProfile[]> {
  const products = (await db.prepare(
    "SELECT p.id, p.name FROM products p WHERE p.active = 1 AND p.category = ? ORDER BY p.name, p.id",
  ).bind(category).all<ProductRow>()).results ?? [];
  const reviews = (await db.prepare(
    "SELECT r.product_id, r.dog_breed, r.dog_size, r.coat_type, r.needs, r.summary, r.source_type, r.source_url FROM reviews r JOIN products p ON p.id = r.product_id WHERE p.active = 1 AND p.category = ? ORDER BY r.id LIMIT 1000",
  ).bind(category).all<ReviewRow>()).results ?? [];
  return buildProfiles(products, reviews);
}

export type SourceBreakdown = { external: number; article: number; total: number; byKind: Array<[string, number]> };

export async function loadSourceBreakdown(db: DB): Promise<SourceBreakdown | null> {
  const rows = (await db.prepare(
    "SELECT r.source_type, r.source_url FROM reviews r JOIN products p ON p.id = r.product_id WHERE p.active = 1 LIMIT 100000",
  ).all<Pick<ReviewRow, "source_type" | "source_url">>()).results ?? [];
  if (!rows.length) return null;
  const counter = new Map<string, number>();
  for (const row of rows) {
    const kind = sourceKind(row);
    counter.set(kind, (counter.get(kind) ?? 0) + 1);
  }
  const article = counter.get("サイト内記事の再整理") ?? 0;
  return { external: rows.length - article, article, total: rows.length, byKind: top(counter, 8) };
}

export function renderSourceBreakdownHtml(data: SourceBreakdown): string {
  const kinds = data.byKind.map(([label, n]) => `<li>${esc(label)}：${n}件</li>`).join("");
  return `<section data-inu-source-breakdown style="margin:30px 0;background:#fff;border:1px solid #eadfd5;border-radius:18px;padding:18px 16px">
<h2 style="font-size:20px;margin:0 0 8px">現在のデータの内訳</h2>
<p style="font-size:14px;line-height:1.8;color:#766c65;margin:0 0 8px">当サイトに整理している体験は合計<strong>${data.total}件</strong>です。そのうち、他サイトに公開されたレビュー等を要約したものが<strong>${data.external}件</strong>、当サイト内の既存記事を再整理したものが<strong>${data.article}件</strong>です。後者は新しい第三者の体験ではないため、別に数えています。</p>
<ul style="font-size:14px;line-height:1.8;color:#766c65;margin:0 0 8px;padding-left:20px">${kinds}</ul>
<p style="font-size:14px;line-height:1.8;color:#766c65;margin:0">この件数は閲覧時点の登録数から自動で表示しています。件数が多いことは、商品の品質や人気を示すものではありません。</p>
</section>`;
}
