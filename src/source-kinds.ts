// How a stored experience row relates to its source, decided in one place.
//
// `source_type = 'existing_article_summary'` was meant for rows that re-organise this site's own articles
// (source_url starts with "/"). Six rows (ids 921-926) use the same type but point to outside articles
// (a personal blog and the brand's own sites). Those are neither this site's articles nor buyer reviews,
// so they get their own kind. Nothing in D1 is changed: the kind is derived from the stored URL at display time.

export type SourceKind = "third_party" | "site_article" | "external_blog" | "external_brand" | "external_article";

export type SourceKindInfo = {
  kind: SourceKind;
  /** Full label shown on a card. Empty for ordinary third-party reviews (they have the source-check label instead). */
  label: string;
  /** Short tag put in front of a quoted line, e.g. ［個人ブログ記事の要約］. Empty for ordinary reviews. */
  short: string;
  /** Link text for the original page. */
  linkLabel: string;
};

const HOST_KIND: Array<[RegExp, "external_blog" | "external_brand"]> = [
  [/(^|\.)ameblo\.jp$/i, "external_blog"],
  [/(^|\.)plushpuppy(?:america)?\.(?:co\.nz|com)$/i, "external_brand"],
];

const INFO: Record<Exclude<SourceKind, "third_party">, Omit<SourceKindInfo, "kind">> = {
  site_article: {
    label: "サイト内記事の再整理（他サイトの体験ではありません）",
    short: "サイト内記事の再整理",
    linkLabel: "元にしたサイト内記事を見る →",
  },
  external_blog: {
    label: "外部の個人ブログ記事の要約（購入者レビューではありません）",
    short: "個人ブログ記事の要約",
    linkLabel: "元の記事を見る ↗",
  },
  external_brand: {
    label: "ブランド・販売元サイトの記事の要約（飼い主の購入レビューではありません）",
    short: "ブランド・販売元の記事の要約",
    linkLabel: "元の記事を見る ↗",
  },
  external_article: {
    label: "外部記事の要約（購入者レビューではありません）",
    short: "外部記事の要約",
    linkLabel: "元の記事を見る ↗",
  },
};

export function sourceKindOf(row: { source_type?: string | null; source_url?: string | null }): SourceKindInfo {
  if (row.source_type !== "existing_article_summary") {
    return { kind: "third_party", label: "", short: "", linkLabel: "" };
  }
  const url = String(row.source_url ?? "").trim();
  if (!/^https?:\/\//i.test(url)) return { kind: "site_article", ...INFO.site_article };
  let host = "";
  try { host = new URL(url).hostname; } catch { /* malformed URL: treated as an unknown external article */ }
  const hit = HOST_KIND.find(([pattern]) => pattern.test(host));
  return { kind: hit ? hit[1] : "external_article", ...INFO[hit ? hit[1] : "external_article"] };
}

export const isArticleKind = (kind: SourceKind) => kind !== "third_party";
export const isExternalArticleKind = (kind: SourceKind) => kind.startsWith("external_");
