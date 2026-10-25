// Rows that the 2026-10-17 source audit (audit/review-source-20261017/) marked status "C":
// the matching public post was written by a cat owner, so the row is not evidence about dogs.
// The rows stay in D1 and in the audit ledger untouched. They are only left out of what readers see:
// lists, search, grouping, product counts, headline totals and attribute facets.
import { LEDGER } from "./review-source-ledger";

export const EXCLUDED_REVIEW_IDS: readonly number[] = Object.entries(LEDGER)
  .filter(([, entry]) => entry[0] === "C")
  .map(([id]) => Number(id))
  .filter((id) => Number.isSafeInteger(id) && id > 0)
  .sort((a, b) => a - b);

// The ids are integers taken from the static ledger (never from a request), so inlining them is injection-safe.
export function notExcludedSql(alias = "r"): string {
  if (!/^[a-z]+$/.test(alias)) throw new Error("invalid_alias");
  return EXCLUDED_REVIEW_IDS.length ? `${alias}.id NOT IN (${EXCLUDED_REVIEW_IDS.join(",")})` : "1=1";
}
