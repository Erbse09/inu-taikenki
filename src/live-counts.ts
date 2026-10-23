export type LiveCounts = {
  total_reviews: number;
  total_categories: number;
};

// Only the *current* review / category totals follow the database. Numbers that describe
// history (e.g. "最初の約750件の整理にはChatGPTが…") are facts about past work and must never be
// rewritten. They are protected either by wrapping them in <span data-fixed-count>…</span>
// or by the "最初の(約)N件" / "初期の(約)N件" phrasing.
const FIXED_COUNT_PATTERN = /<span\b[^>]*\bdata-fixed-count\b[^>]*>[\s\S]*?<\/span>|(?:最初の|初期の)約?[\d,]+件/g;

const MASK_OPEN = "";
const MASK_CLOSE = "";

export function needsLiveCounts(html: string) {
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

export function applyLiveCounts(html: string, counts: LiveCounts | null) {
  if (!counts) return html;

  const reviewCount = String(counts.total_reviews);
  const categoryCount = String(counts.total_categories);

  const fixed: string[] = [];
  const masked = html.replace(FIXED_COUNT_PATTERN, (match) => {
    fixed.push(match);
    return `${MASK_OPEN}${fixed.length - 1}${MASK_CLOSE}`;
  });

  const replaced = masked
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

  return replaced.replace(new RegExp(`${MASK_OPEN}(\\d+)${MASK_CLOSE}`, "g"), (_, i) => fixed[Number(i)]);
}
