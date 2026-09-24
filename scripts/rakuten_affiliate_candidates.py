#!/usr/bin/env python3
import csv
import json
import os
import re
import time
import unicodedata
import urllib.parse
import urllib.request
import urllib.error
from difflib import SequenceMatcher
from pathlib import Path

PRODUCTION_PRODUCTS_API = "https://inu-taikenki.com/api/products"
RAKUTEN_ENDPOINT = "https://openapi.rakuten.co.jp/ichibams/api/IchibaItem/Search/20260701"
APP_ID = os.environ["RAKUTEN_APPLICATION_ID"]
AFFILIATE_ID = os.environ["RAKUTEN_AFFILIATE_ID"]
ACCESS_KEY = os.environ["RAKUTEN_ACCESS_KEY"]
OUTPUT = Path("output")
OUTPUT.mkdir(exist_ok=True)

GENERIC = {
    "犬用","ペット","ブラシ","ピンブラシ","スリッカー","コーム","シャンプー","コンディショナー",
    "爪切り","爪やすり","バリカン","歯ブラシ","歯磨き","歯みがき","ジェル","ガム","イヤークリーナー",
    "クリーナー","自動給餌器","ペットドライヤー","ドライヤー","小型犬","中型犬","大型犬","用"
}

_last_rakuten_call = 0.0

def norm(text):
    text = unicodedata.normalize("NFKC", text or "").lower()
    text = re.sub(r"[™®©#№]+", " ", text)
    text = re.sub(r"[\[\]【】()（）<>＜＞/／・,，.。:+＋_-]+", " ", text)
    text = re.sub(r"\s+", " ", text).strip()
    return text

def alnum_tokens(text):
    return set(re.findall(r"[a-z]+\d+[a-z0-9-]*|\d+[a-z]+[a-z0-9-]*|[a-z]{2,}|\d{2,}", norm(text)))

def words(text):
    return [w for w in norm(text).split() if w and w not in GENERIC]

def rakuten_valid_token(token):
    token = token.strip()
    if not token:
        return False
    # Rakuten rejects one-character ASCII tokens and one-character kana/symbol tokens.
    if token.isascii() and len(token) < 2:
        return False
    if len(token) == 1 and re.fullmatch(r"[ぁ-んァ-ヶー]", token):
        return False
    return True

def clean_keyword(text):
    parts = [p for p in norm(text).split() if rakuten_valid_token(p)]
    q = " ".join(parts)
    while len(q.encode("utf-8")) > 120 and len(parts) > 1:
        parts.pop()
        q = " ".join(parts)
    if not q:
        raw = norm(text).replace(" ", "")
        q = raw[:8]
    return q

def search_query(name):
    return clean_keyword(name)

def simplified_query(name):
    parts = [p for p in words(name) if rakuten_valid_token(p)]
    models = alnum_tokens(name)
    keep = []
    for p in parts:
        if p in models or len(p) >= 3:
            keep.append(p)
    if not keep:
        keep = parts
    return clean_keyword(" ".join(keep[:8]) or name)

def score_candidate(product_name, item_name):
    a, b = norm(product_name), norm(item_name)
    seq = SequenceMatcher(None, a, b).ratio()
    aw, bw = set(words(a)), set(words(b))
    overlap = len(aw & bw) / max(1, len(aw))
    models = alnum_tokens(a)
    model_hits = len(models & alnum_tokens(b))
    model_score = (model_hits / len(models)) if models else 0.5
    score = 0.50 * seq + 0.30 * overlap + 0.20 * model_score
    if models and model_hits == 0:
        score *= 0.72
    return round(score, 4)

def confidence(score):
    if score >= 0.78:
        return "high"
    if score >= 0.60:
        return "medium"
    return "low"

def fetch_json(url, headers=None, timeout=30):
    req = urllib.request.Request(url, headers=headers or {"User-Agent":"inu-taikenki-rakuten-audit/1.0"})
    try:
        with urllib.request.urlopen(req, timeout=timeout) as res:
            return json.load(res)
    except urllib.error.HTTPError as exc:
        body = exc.read().decode("utf-8", "replace")
        raise RuntimeError(f"HTTP {exc.code}: {body[:500]}") from exc

def load_products():
    products = []
    offset = 0
    while True:
        params = urllib.parse.urlencode({"limit": 100, "offset": offset})
        data = fetch_json(f"{PRODUCTION_PRODUCTS_API}?{params}")
        batch = data.get("products", [])
        products.extend(batch)
        nxt = data.get("next_offset")
        if nxt is None:
            break
        offset = int(nxt)
    # Production D1 is the source of truth.
    unique = {p["id"]: p for p in products}
    return [unique[k] for k in sorted(unique)]

def rakuten_search(keyword):
    global _last_rakuten_call
    elapsed = time.monotonic() - _last_rakuten_call
    if elapsed < 1.10:
        time.sleep(1.10 - elapsed)
    params = {
        "applicationId": APP_ID,
        "affiliateId": AFFILIATE_ID,
        "format": "json",
        "formatVersion": 2,
        "keyword": keyword,
        "hits": 10,
        "availability": 1,
        "imageFlag": 1,
        "field": 0
    }
    url = RAKUTEN_ENDPOINT + "?" + urllib.parse.urlencode(params)
    try:
        data = fetch_json(url, headers={
            "User-Agent":"inu-taikenki-rakuten-audit/1.0",
            "accessKey": ACCESS_KEY,
            "Origin":"https://inu-taikenki.com",
            "Referer":"https://inu-taikenki.com/",
        })
    finally:
        _last_rakuten_call = time.monotonic()
    raw_items = data.get("items")
    if raw_items is None:
        raw_items = data.get("Items", [])
    normalized = []
    for entry in raw_items or []:
        if isinstance(entry, dict) and "Item" in entry:
            normalized.append(entry["Item"])
        elif isinstance(entry, dict) and "item" in entry:
            normalized.append(entry["item"])
        else:
            normalized.append(entry)
    return normalized

def first_image(item):
    imgs = item.get("mediumImageUrls") or item.get("smallImageUrls") or []
    if not imgs:
        return ""
    first = imgs[0]
    if isinstance(first, dict):
        return first.get("imageUrl", "")
    return str(first)

def audit():
    products = load_products()
    if not products:
        raise RuntimeError("Production API returned zero products")

    results = []
    candidate_rows = []
    matched = 0
    print(f"Loaded {len(products)} active products from production API")

    for idx, product in enumerate(products, 1):
        name = product.get("name", "")
        q1 = search_query(name)
        used_query = q1
        error = ""
        try:
            items = rakuten_search(q1)
        except Exception as exc:
            items = []
            error = str(exc)
        if not items:
            q2 = simplified_query(name)
            if q2 and q2 != q1:
                used_query = q2
                try:
                    items = rakuten_search(q2)
                    error = ""
                except Exception as exc:
                    items = []
                    error = str(exc)

        ranked = []
        for item in items:
            s = score_candidate(name, item.get("itemName", ""))
            ranked.append((s, item))
        ranked.sort(key=lambda x: x[0], reverse=True)
        top = ranked[:3]
        best_score = top[0][0] if top else 0.0
        conf = confidence(best_score) if top else "none"
        if conf == "high":
            matched += 1

        rec = {
            "product_id": product.get("id"),
            "product_name": name,
            "category": product.get("category"),
            "existing_review_count": product.get("review_count"),
            "query": used_query,
            "candidate_count": len(items),
            "error": error,
            "best_score": best_score,
            "confidence": conf,
            "candidates": []
        }

        for rank, (s, item) in enumerate(top, 1):
            c = {
                "rank": rank,
                "score": s,
                "itemName": item.get("itemName", ""),
                "itemCode": item.get("itemCode", ""),
                "itemPrice": item.get("itemPrice"),
                "shopName": item.get("shopName", ""),
                "reviewCount": item.get("reviewCount"),
                "reviewAverage": item.get("reviewAverage"),
                "affiliateUrl": item.get("affiliateUrl", ""),
                "itemUrl": item.get("itemUrl", ""),
                "imageUrl": first_image(item),
            }
            rec["candidates"].append(c)
            candidate_rows.append({
                "product_id": rec["product_id"],
                "product_name": name,
                "category": rec["category"],
                "confidence": conf,
                "rank": rank,
                **c
            })
        results.append(rec)
        suffix = f" error={error[:120]}" if error else ""
        print(f"[{idx}/{len(products)}] {rec['product_id']}: {conf} {best_score:.3f} ({len(items)} candidates){suffix}")

    (OUTPUT / "rakuten-affiliate-candidates.json").write_text(
        json.dumps(results, ensure_ascii=False, indent=2), encoding="utf-8"
    )

    fields = [
        "product_id","product_name","category","confidence","rank","score",
        "itemName","itemCode","itemPrice","shopName","reviewCount","reviewAverage",
        "affiliateUrl","itemUrl","imageUrl"
    ]
    with (OUTPUT / "rakuten-affiliate-candidates.csv").open("w", encoding="utf-8-sig", newline="") as fh:
        writer = csv.DictWriter(fh, fieldnames=fields, extrasaction="ignore")
        writer.writeheader()
        writer.writerows(candidate_rows)

    counts = {"high":0,"medium":0,"low":0,"none":0}
    for r in results:
        counts[r["confidence"]] = counts.get(r["confidence"],0) + 1

    summary = f"""# Rakuten affiliate candidate audit

- Production products: {len(products)}
- High confidence: {counts.get('high',0)}
- Medium confidence: {counts.get('medium',0)}
- Low confidence: {counts.get('low',0)}
- No result: {counts.get('none',0)}
- API version: 2026-07-01
- Production DB writes: none
- Site writes: none

Only candidate data is generated. Do not auto-apply medium/low matches.
"""
    (OUTPUT / "summary.md").write_text(summary, encoding="utf-8")
    print(summary)

if __name__ == "__main__":
    audit()
