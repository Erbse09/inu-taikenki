#!/usr/bin/env python3
import json
import urllib.parse
from pathlib import Path

SOURCE = Path("output/rakuten-affiliate-candidates.json")
OUT = Path("generated/0042_product_affiliate_links.sql")
AUDIT = Path("output/curated-rakuten-links.json")

# Default: all high-confidence and medium-confidence top candidates.
# Exceptions were manually reviewed against canonical product names / sizes.
REJECT = {"morisawa"}
OVERRIDE = {
    "apdc-conditioner": 3,
    "lawrence-soft-slicker": 2,
    "petio-porta-pin-m": 2,
    "petio-porta-pin-s": 2,
    "showtech-ultrapro-l": 2,
    "virbac-cet-chicken": 2,

    # Low-score matches accepted only after manual title/model review.
    "casfuy-led2": 2,
    "dogone-quick-dry": 2,
    "furminator-deshedding": 3,
    "german-pin-brush-503": 1,
    "karikari-machine-v2c-plus": 1,
    "mimikyua-one": 1,
    "moizze-pet001": 2,
    "okano-musashi-soft": 1,
    "pateker-lg4": 1,
    "petaboo-l400": 2,
    "plush-puppy-blue-pin": 1,
    "plush-puppy-pocket-pin": 1,
    "plush-puppy-ultimate-long-pin": 1,
    "plush-puppy-ultimate-pin": 1,
    "showtech-maxipin-regular": 1,
    "showtech-ultrapro-s": 1,
}

def sql_quote(value):
    if value is None:
        return "NULL"
    if isinstance(value, (int, float)):
        return str(value)
    return "'" + str(value).replace("'", "''") + "'"

def direct_url(affiliate_url):
    try:
        values = urllib.parse.parse_qs(urllib.parse.urlsplit(affiliate_url).query)
        return values.get("pc", [affiliate_url])[0]
    except Exception:
        return affiliate_url

def main():
    data = json.loads(SOURCE.read_text(encoding="utf-8"))
    by_id = {row["product_id"]: row for row in data}

    selection = {}
    for row in data:
        if row["confidence"] in {"high", "medium"} and row["product_id"] not in REJECT:
            selection[row["product_id"]] = 1
    selection.update(OVERRIDE)

    curated = []
    sql_rows = []
    for product_id in sorted(selection):
        row = by_id[product_id]
        rank = selection[product_id]
        candidate = next((c for c in row["candidates"] if c["rank"] == rank), None)
        if not candidate:
            raise RuntimeError(f"missing candidate: {product_id} rank={rank}")
        if not candidate.get("affiliateUrl") or not candidate.get("imageUrl"):
            raise RuntimeError(f"missing affiliate/image URL: {product_id}")

        canonical = direct_url(candidate["affiliateUrl"])
        curated.append({
            "product_id": product_id,
            "product_name": row["product_name"],
            "confidence": row["confidence"],
            "selected_rank": rank,
            "score": candidate["score"],
            "itemCode": candidate["itemCode"],
            "itemName": candidate["itemName"],
            "canonicalUrl": canonical,
            "affiliateUrl": candidate["affiliateUrl"],
            "imageUrl": candidate["imageUrl"],
        })

        values = [
            product_id,
            "rakuten",
            candidate["itemCode"],
            canonical,
            candidate["affiliateUrl"],
            candidate["imageUrl"],
            1,
        ]
        sql_rows.append("(" + ",".join(sql_quote(v) for v in values) + ")")

    if len(curated) != 94:
        raise RuntimeError(f"expected 94 curated links, got {len(curated)}")

    sql = """PRAGMA foreign_keys = ON;

-- Verified marketplace links for canonical products. Additive only.
-- 94 Rakuten matches were reviewed before inclusion; ambiguous/no-result items are intentionally omitted.
CREATE TABLE IF NOT EXISTS product_affiliate_links (
  product_id TEXT NOT NULL REFERENCES products(id) ON DELETE RESTRICT,
  marketplace TEXT NOT NULL CHECK(marketplace IN ('amazon','rakuten','yahoo')),
  external_id TEXT NOT NULL CHECK(length(trim(external_id)) > 0),
  canonical_url TEXT NOT NULL CHECK(canonical_url GLOB 'https://*'),
  affiliate_url TEXT NOT NULL CHECK(affiliate_url GLOB 'https://*'),
  image_url TEXT CHECK(image_url IS NULL OR image_url GLOB 'https://*'),
  verified INTEGER NOT NULL DEFAULT 0 CHECK(verified IN (0,1)),
  updated_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY(product_id, marketplace)
);

CREATE INDEX IF NOT EXISTS idx_product_affiliate_links_marketplace_verified
  ON product_affiliate_links(marketplace, verified, product_id);

INSERT INTO product_affiliate_links(
  product_id,marketplace,external_id,canonical_url,affiliate_url,image_url,verified
) VALUES
""" + ",\n".join(sql_rows) + """
ON CONFLICT(product_id, marketplace) DO UPDATE SET
  external_id=excluded.external_id,
  canonical_url=excluded.canonical_url,
  affiliate_url=excluded.affiliate_url,
  image_url=excluded.image_url,
  verified=excluded.verified,
  updated_at=CURRENT_TIMESTAMP;

SELECT COUNT(*) AS verified_rakuten_links
FROM product_affiliate_links
WHERE marketplace='rakuten' AND verified=1;
"""

    OUT.parent.mkdir(parents=True, exist_ok=True)
    OUT.write_text(sql, encoding="utf-8")
    AUDIT.write_text(json.dumps(curated, ensure_ascii=False, indent=2), encoding="utf-8")
    print(f"Generated {OUT} with {len(curated)} verified Rakuten links")

if __name__ == "__main__":
    main()
