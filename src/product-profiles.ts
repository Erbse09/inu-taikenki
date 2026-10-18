// Server-rendered product overview for each category article.
// Everything shown here is computed from existing rows (reviews/products); nothing is generated or guessed.
// Read-only: SELECT statements only, so it also passes the Preview read-only wrapper.
interface Statement {
  bind(...values: (string | number | null)[]): Statement;
  all<T>(): Promise<{ results?: T[] }>;
}
import { ledgerTotals, sourceCheck, sourceCheckFromRegistry } from "./review-source-check";
interface DB { prepare(sql: string): Statement; }

type ProductRow = { id: string; name: string };
type ReviewRow = {
  id?: number;
  product_id: string;
  dog_breed: string | null;
  dog_size: string | null;
  coat_type: string | null;
  needs: string | null;
  summary: string;
  source_type: string | null;
  source_url: string | null;
  // First review_sources.source_url registered for the row (rows added with an audit record); null/undefined otherwise.
  registered_source_url?: string | null;
};

// Static ledger first (production rows audited on 2026-10-17); then the D1 registry for rows added later.
const checkOf = (row: Pick<ReviewRow, "id" | "registered_source_url">) => sourceCheck(row.id) ?? sourceCheckFromRegistry(row.registered_source_url);

export const PROFILE_CATEGORIES = new Set([
  "pet-dryer", "auto-feeder", "dog-clipper", "brush-slicker", "brush-pin", "brush-undercoat", "brush-comb",
  "nail-grinder", "nail-clipper", "dog-shampoo", "dog-conditioner", "dog-toothbrush", "dog-toothpaste",
  "dog-dental-chew", "dog-ear-cleaner", "dog-harness",
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
  allCoats: Record<string, number>;
  allNeeds: Record<string, number>;
  articleRows: number;
  checks: { V: number; P: number; N: number; U: number; C: number; none: number };
  breeds: string[];
  sources: Array<[string, number]>;
  examples: string[];
  reservations: string[];
};

// The interactive list (db-review-browser.js) opens on the product with the most experiences and shows its first rows.
// The quotes below skip those rows so the same sentences are not printed twice on one page.
const INTERACTIVE_INITIAL_ROWS = 6;

export function buildProfiles(products: ProductRow[], reviews: ReviewRow[]): ProductProfile[] {
  const byProduct = new Map<string, ReviewRow[]>();
  for (const review of reviews) {
    const list = byProduct.get(review.product_id) ?? [];
    list.push(review);
    byProduct.set(review.product_id, list);
  }
  const profiles: ProductProfile[] = [];
  const defaultProduct = [...products]
    .filter((p) => byProduct.get(p.id)?.length)
    .sort((a, b) => (byProduct.get(b.id)!.length - byProduct.get(a.id)!.length) || (a.name < b.name ? -1 : a.name > b.name ? 1 : a.id < b.id ? -1 : 1))[0];
  const shownByInteractiveList = new Set<ReviewRow>(
    defaultProduct ? [...byProduct.get(defaultProduct.id)!].sort((a, b) => (a.id ?? 0) - (b.id ?? 0)).slice(0, INTERACTIVE_INITIAL_ROWS) : [],
  );
  for (const product of products) {
    const rows = byProduct.get(product.id);
    if (!rows?.length) continue;
    const sizes: Record<string, number> = { small: 0, medium: 0, large: 0 };
    let sizeUnknown = 0;
    const coats = new Map<string, number>();
    const needs = new Map<string, number>();
    const breeds = new Map<string, number>();
    const sources = new Map<string, number>();
    let articleRows = 0;
    const checks = { V: 0, P: 0, N: 0, U: 0, C: 0, none: 0 };
    for (const row of rows) {
      if (row.source_type === "existing_article_summary") articleRows++;
      const status = checkOf(row)?.status;
      if (status) checks[status]++;
      else if (row.source_type !== "existing_article_summary") checks.none++;
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
    // Third-party summaries first; the site's own re-organised article rows only when nothing else is available.
    // Rows whose matching source post was written by a cat owner are never quoted as dog experiences.
    const quotable = rows.filter((r) => r.summary && r.summary.length >= 20 && !shownByInteractiveList.has(r) && checkOf(r)?.status !== "C");
    const thirdParty = quotable.filter((r) => r.source_type !== "existing_article_summary");
    const usable = thirdParty.length >= 2 ? thirdParty : quotable;
    const pick = (candidates: ReviewRow[], limit: number) => {
      // Prefer rows that name a breed, and spread the picks across different dog sizes when possible.
      // Rows whose source was checked (status V) come first; unverified rows are never preferred.
      const rank = (r: ReviewRow) => (checkOf(r)?.status === "V" ? 2 : 0) + (breedKey(r.dog_breed) ? 1 : 0);
      const ranked = [...candidates].sort((x, y) => rank(y) - rank(x));
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
      const check = checkOf(row);
      const tag = row.source_type === "existing_article_summary" ? "［サイト内記事の再整理］" : check ? `［${check.short}］` : "［出典の確認は未実施］";
      return tag + (breed ? breed + "｜" : "") + row.summary;
    };
    profiles.push({
      id: product.id,
      name: product.name,
      count: rows.length,
      sizes,
      sizeUnknown,
      coats: top(coats, 2),
      needs: top(needs, 4),
      allCoats: Object.fromEntries(coats),
      allNeeds: Object.fromEntries(needs),
      articleRows,
      checks,
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
[data-inu-profiles] .ip-cond table{min-width:0}
[data-inu-profiles] th,[data-inu-profiles] td{border:1px solid #eadfd5;padding:7px 9px;text-align:left;vertical-align:top}
[data-inu-profiles] th{background:#fff7ed;font-weight:800}
[data-inu-profiles] .ip-card{border-top:1px solid #eadfd5;padding:10px 0 4px}
[data-inu-profiles] .ip-card summary{cursor:pointer;font-size:14px;line-height:1.7;padding:4px 0}
[data-inu-profiles] a{color:#c4621b}
[data-inu-profiles] .ip-meta{color:#766c65;margin:0 0 6px}
[data-inu-profiles] ul{margin:4px 0 10px;padding-left:20px}
[data-inu-profiles] .ip-label{font-weight:800;font-size:13px;margin:8px 0 2px;color:#8a5a2b}
</style>`;

function checkCell(profile: ProductProfile) {
  const c = profile.checks;
  const parts = [c.V && `確認済み${c.V}`, c.P && `部分一致${c.P}`, c.N && `見つからず${c.N}`, c.U && `確認不能${c.U}`, c.C && `猫の投稿の可能性${c.C}`, c.none && `未実施${c.none}`].filter(Boolean);
  return parts.length ? parts.join("／") + "件" : "—";
}

function sizeCell(profile: ProductProfile) {
  const parts = (["small", "medium", "large"] as const)
    .filter((key) => profile.sizes[key] > 0)
    .map((key) => `${SIZE_LABELS[key]}${profile.sizes[key]}`);
  const body = parts.length ? parts.join("／") : "記載なし";
  return profile.sizeUnknown ? `${body}（サイズ記載なし${profile.sizeUnknown}）` : body;
}

const COAT_KEY_BY_LABEL = Object.fromEntries(Object.entries(COAT_LABELS).map(([key, label]) => [label, key]));
// Needs that the search page understands as a keyword (see aliases in review-api.ts); others get no link.
const SEARCHABLE_NEEDS = new Set(["怖がり", "子犬", "シニア", "時短", "抜け毛", "毛玉", "もつれ", "多頭", "静音", "皮膚配慮"]);

type ConditionRow = { label: string; total: number; products: Array<[string, number]>; href: string | null };

export function buildConditionRows(category: string, profiles: ProductProfile[]): ConditionRow[] {
  const rows: ConditionRow[] = [];
  const add = (label: string, pick: (p: ProductProfile) => number, href: string | null) => {
    const per = profiles.map((p) => [p.name, pick(p)] as [string, number]).filter(([, n]) => n > 0);
    const total = per.reduce((sum, [, n]) => sum + n, 0);
    if (!total) return;
    per.sort((x, y) => y[1] - x[1] || x[0].localeCompare(y[0], "ja"));
    rows.push({ label, total, products: per.slice(0, 3), href });
  };
  const q = (extra: string) => `/review-search?category=${encodeURIComponent(category)}&${extra}`;
  for (const key of ["small", "medium", "large"] as const) {
    add(`${SIZE_LABELS[key]}犬の体験`, (p) => p.sizes[key], q(`size=${key}`));
  }
  const sum = (pick: (p: ProductProfile) => Record<string, number>) => {
    const totals = new Map<string, number>();
    for (const p of profiles) for (const [label, n] of Object.entries(pick(p))) totals.set(label, (totals.get(label) ?? 0) + n);
    return top(totals, 6);
  };
  for (const [label] of sum((p) => p.allCoats).slice(0, 3)) {
    add(`${label}の犬の体験`, (p) => p.allCoats[label] ?? 0, COAT_KEY_BY_LABEL[label] ? q(`coat=${COAT_KEY_BY_LABEL[label]}`) : null);
  }
  for (const [label] of sum((p) => p.allNeeds)) {
    add(`「${label}」が書かれた体験`, (p) => p.allNeeds[label] ?? 0, SEARCHABLE_NEEDS.has(label) ? q(`q=${encodeURIComponent(label)}`) : null);
  }
  return rows;
}

export function renderProfilesHtml(categoryLabel: string, profiles: ProductProfile[], category = ""): string {
  if (!profiles.length) return "";
  const total = profiles.reduce((sum, p) => sum + p.count, 0);
  const withSize = profiles.reduce((sum, p) => sum + p.count - p.sizeUnknown, 0);
  const articleTotal = profiles.reduce((sum, p) => sum + p.articleRows, 0);
  const rows = profiles.map((p) =>
    `<tr><th scope="row">${esc(p.name)}</th><td>${p.count}件</td><td>${esc(sizeCell(p))}</td><td>${esc(p.needs.map(([l]) => l).slice(0, 3).join("・") || "記載なし")}</td><td>${esc(p.breeds.join("・") || "記載なし")}</td><td>${esc(checkCell(p))}</td></tr>`).join("");
  const conditions = category ? buildConditionRows(category, profiles) : [];
  const conditionRows = conditions.map((c) => {
    const names = c.products.map(([name, n]) => `${esc(name)}（${n}件）`).join("、");
    const caution = c.total < 5 ? "（体験が少ないため参考程度）" : "";
    const label = c.href ? `<a href="${esc(c.href)}">${esc(c.label)}</a>` : esc(c.label);
    return `<tr><th scope="row">${label}</th><td>${c.total}件${caution}</td><td>${names}</td></tr>`;
  }).join("");
  const conditionTable = conditionRows
    ? `<h3>犬の条件から見る：どの商品に体験が多いか</h3>
<p class="ip-note">愛犬と同じ条件の体験が、どの商品に何件あるかを数えた表です（体験の多い順に上位3商品）。条件名を押すと、その条件の体験だけを読めます。0件の条件は載せていません。</p>
<div class="ip-scroll ip-cond"><table>
<thead><tr><th scope="col">条件</th><th scope="col">該当する体験</th><th scope="col">体験が多い商品</th></tr></thead>
<tbody>${conditionRows}</tbody></table></div>`
    : "";
  const cards = profiles.map((p) => {
    const sources = p.sources.map(([label, n]) => `${esc(label)}${n}件`).join("／");
    const coats = p.coats.length ? p.coats.map(([l, n]) => `${esc(l)}${n}`).join("・") : "記載なし";
    const needs = p.needs.length ? p.needs.map(([l, n]) => `${esc(l)}${n}`).join("・") : "記載なし";
    const list = (items: string[]) => items.map((t) => `<li>${esc(t)}</li>`).join("");
    return `<details class="ip-card" data-inu-profile="${esc(p.id)}">
<summary><strong>${esc(p.name)}</strong>｜体験${p.count}件</summary>
<p class="ip-meta">犬のサイズ：${esc(sizeCell(p))}｜毛質の記載：${coats}｜条件の記載：${needs}</p>
<p class="ip-meta">要約の元になった確認先：${sources}｜出典の確認状況：${esc(checkCell(p))}</p>
${p.examples.length ? `<div class="ip-label">この商品の体験から（要約）</div><ul>${list(p.examples)}</ul>` : ""}
${p.reservations.length ? `<div class="ip-label">評価が分かれた・気になる点にも触れた体験（要約）</div><ul>${list(p.reservations)}</ul>` : ""}
</details>`;
  }).join("\n");
  const articleNote = articleTotal ? `このカテゴリの${total}件のうち${articleTotal}件は「サイト内記事の再整理」で、他サイトの体験ではありません。` : "";
  return `${STYLE}
<section data-inu-profiles aria-label="${esc(categoryLabel)}の商品別データ">
<div class="ip-eyebrow">PRODUCT DATA</div>
<h2>${esc(categoryLabel)}｜商品別に見る体験の傾向（${profiles.length}商品・${total}件）</h2>
<p class="ip-note">下の表は、このサイトに整理した体験の記載から集計したものです。<strong>体験の件数が多い＝おすすめ順位ではありません</strong>。「うちの子と同じサイズ・毛質・条件の体験があるか」を見るための目安として使ってください。犬のサイズが書かれていた体験は${total}件中${withSize}件で、書かれていないものは推測で補っていません。${esc(articleNote)}</p>
<div class="ip-scroll"><table>
<thead><tr><th scope="col">商品</th><th scope="col">体験数</th><th scope="col">犬のサイズ（記載のあった体験）</th><th scope="col">よく書かれた条件</th><th scope="col">犬の記載例（犬種など）</th><th scope="col">出典の確認状況</th></tr></thead>
<tbody>${rows}</tbody></table></div>
${conditionTable}
<h3>商品ごとの詳細（タップで開く）</h3>
${cards}
<p class="ip-note">体験は、販売サイトなどに公開されたレビュー等を、生成AI（ChatGPT・Claude）を使って要約したものです（運営者自身の使用体験ではありません）。すべての要約を運営者が原文と1件ずつ照合したわけではなく、確認先ページに該当の投稿が見つからない場合があります。確認先の多くは商品のレビュー一覧ページで、個別の投稿へ直接リンクしているわけではありません。詳しくは<a href="/editorial-policy">調査・編集方針</a>をご覧ください。</p>
</section>`;
}

export async function loadCategoryProfiles(db: DB, category: string): Promise<ProductProfile[]> {
  const products = (await db.prepare(
    "SELECT p.id, p.name FROM products p WHERE p.active = 1 AND p.category = ? ORDER BY p.name, p.id",
  ).bind(category).all<ProductRow>()).results ?? [];
  const reviews = (await db.prepare(
    "SELECT r.id, r.product_id, r.dog_breed, r.dog_size, r.coat_type, r.needs, r.summary, r.source_type, r.source_url, (SELECT s.source_url FROM review_sources s WHERE s.review_id = r.id ORDER BY s.rowid LIMIT 1) AS registered_source_url FROM reviews r JOIN products p ON p.id = r.product_id WHERE p.active = 1 AND p.category = ? ORDER BY r.id LIMIT 1000",
  ).bind(category).all<ReviewRow>()).results ?? [];
  return buildProfiles(products, reviews);
}

export type SourceBreakdown = { external: number; article: number; total: number; byKind: Array<[string, number]>; registered?: number };

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
  // Rows added together with an audit record (a specific public post found) carry it in review_sources.
  const registered = (await db.prepare(
    "SELECT COUNT(*) AS n FROM review_sources s JOIN reviews r ON r.id = s.review_id JOIN products p ON p.id = r.product_id WHERE p.active = 1",
  ).all<{ n: number }>()).results?.[0]?.n ?? 0;
  return { external: rows.length - article, article, total: rows.length, byKind: top(counter, 8), registered: Number(registered) || 0 };
}

function renderLedgerNote(registered = 0): string {
  const t = ledgerTotals();
  const day = t.date.replace(/^(\d+)-(\d+)-(\d+)$/, (_m, y, mo, d) => `${y}年${Number(mo)}月${Number(d)}日`);
  return `<p data-inu-source-ledger style="font-size:14px;line-height:1.8;color:#766c65;margin:0 0 8px"><strong>出典の確認状況（${esc(day)}時点）：</strong>他サイトの要約${t.all}件の確認を試みました。取得できた確認先ページの本文がある要約は、生成AI（Claude）が候補となる投稿と1件ずつ読み比べています（本文を取得できなかったものは確認不能、キーワードがまったく重ならなかったものは読み比べずに「見つけられず」としています）。一度きりの確認で、自動更新はされません。結果は、確認先の一覧で対応する投稿を確認できたもの${t.V}件、内容が一部一致するもの${t.P}件、対応する投稿を見つけられなかったもの${t.N}件、確認先ページを取得できず確認できなかったもの${t.U}件、対応すると思われる投稿が猫の飼い主によるものだったもの${t.C}件です。「見つけられなかった」「確認できなかった」は、作り話だと判明したという意味ではありません（確認先の一覧を全件取得できない、掲載が更新される、といった理由でも起こります）。一方で、確認できていない要約を実体験として保証するものでもありません。ラベルのない体験は確認を実施していません。${registered > 0 ? `このほか、出典の監査を経て追加した体験のうち${registered}件は、確認できた投稿の識別情報を登録しており、各体験に「出典確認済み」と、確認できた投稿のあるページへのリンクを表示しています（人の目ではなくAIによる確認です）。` : ""}</p>`;
}

export function renderSourceBreakdownHtml(data: SourceBreakdown): string {
  const kinds = data.byKind.map(([label, n]) => `<li>${esc(label)}：${n}件</li>`).join("");
  return `<section data-inu-source-breakdown style="margin:30px 0;background:#fff;border:1px solid #eadfd5;border-radius:18px;padding:18px 16px">
<h2 style="font-size:20px;margin:0 0 8px">現在のデータの内訳</h2>
<p style="font-size:14px;line-height:1.8;color:#766c65;margin:0 0 8px">当サイトに整理している体験は合計<strong>${data.total}件</strong>です。そのうち、他サイトに公開されたレビュー等を要約したものが<strong>${data.external}件</strong>、当サイト内の既存記事を再整理したものが<strong>${data.article}件</strong>です。後者は新しい第三者の体験ではないため、別に数えています。</p>
<ul style="font-size:14px;line-height:1.8;color:#766c65;margin:0 0 8px;padding-left:20px">${kinds}</ul>
${renderLedgerNote(data.registered ?? 0)}
<p style="font-size:14px;line-height:1.8;color:#766c65;margin:0">この件数は閲覧時点の登録数から自動で表示しています。件数が多いことは、商品の品質や人気を示すものではありません。</p>
</section>`;
}
