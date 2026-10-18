// Per-row source-check status for the public review summaries.
// The ledger is a static record of an audit (see audit/review-source-20261017/), NOT a live check and NOT stored in D1.
// A row that is not listed has simply not been checked; it must never be shown as "verified".
import { LEDGER, LEDGER_DATE, LEDGER_URLS, type LedgerStatus } from "./review-source-ledger";

export type CheckStatus = LedgerStatus;
export type SourceCheck = { status: CheckStatus; label: string; short: string; url: string | null; checked: string };

const TEXT: Record<CheckStatus, { label: string; short: string }> = {
  V: { label: "出典の確認：確認先の一覧で、対応する投稿を確認できました", short: "出典確認済み" },
  P: { label: "出典の確認：確認先に近い内容の投稿はありますが、同じ投稿かは確認できていません（部分一致）", short: "出典 部分一致" },
  N: { label: "出典の確認：確認先の一覧（取得できた範囲）で、対応する投稿を見つけられていません", short: "出典 見つからず" },
  U: { label: "出典の確認：確認先ページの本文を取得できず、確認できていません（確認不能）", short: "出典 確認不能" },
  C: { label: "出典の確認：確認先で対応すると思われる投稿は、猫の飼い主によるものでした（犬の体験とは言えません）", short: "出典 猫の投稿の可能性" },
};

export const CHECK_STATUSES: CheckStatus[] = ["V", "P", "N", "U", "C"];

export function sourceCheck(id: number | string | null | undefined): SourceCheck | null {
  const entry = LEDGER[Number(id)];
  if (!entry) return null;
  const [status, urlIndex] = entry;
  // A link is only ever offered for rows whose matching post was actually found (status V).
  const url = status === "V" && urlIndex !== undefined ? LEDGER_URLS[urlIndex] ?? null : null;
  return { status, label: TEXT[status].label, short: TEXT[status].short, url, checked: LEDGER_DATE };
}

export function ledgerTotals() {
  const totals: Record<CheckStatus, number> = { V: 0, P: 0, N: 0, U: 0, C: 0 };
  for (const [status] of Object.values(LEDGER)) totals[status]++;
  return { ...totals, all: totals.V + totals.P + totals.N + totals.U + totals.C, date: LEDGER_DATE };
}
