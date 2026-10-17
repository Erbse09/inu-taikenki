"""Dump the public review/product data (GET only) into <dir>/reviews.json and <dir>/products.json."""
import json, subprocess, sys, time
out = sys.argv[1]
origin = sys.argv[2] if len(sys.argv) > 2 else "https://inu-taikenki.com"
get = lambda path: json.loads(subprocess.check_output(["curl", "-sS", "-f", origin + path]))
reviews, cursor = [], 0
while True:
    page = get(f"/api/reviews?limit=100&cursor={cursor}")
    reviews += page["reviews"]
    cursor = page.get("next_cursor")
    if not cursor:
        break
    time.sleep(0.2)
products, offset = [], 0
while True:
    page = get(f"/api/products?limit=100&offset={offset}")
    products += page["products"]
    if not page["has_more"]:
        break
    offset = page["next_offset"]
json.dump(reviews, open(out + "/reviews.json", "w"), ensure_ascii=False)
json.dump(products, open(out + "/products.json", "w"), ensure_ascii=False)
print(len(reviews), len(products))
