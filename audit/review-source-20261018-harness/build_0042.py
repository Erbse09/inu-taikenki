#!/usr/bin/env python3
"""出典監査の結果(verdicts.csv)から migrations/0042_dog_harness.sql を作り直す。

使い方: python3 build_0042.py <元のSQL(07ab40c版)> <verdicts.csv> <出力SQL>

- status が V(全文目視) / A(自動一致+抜粋目視) の行だけを口コミとして残す。N/U は追加しない。
- 追加した口コミごとに review_sources を INSERT OR IGNORE で登録する(追加のみ。既存行は更新しない)。
- ネットワークには接続しない。D1にも接続しない。
"""
import csv, hashlib, re, sys

CHUNK = 50
orig_path, csv_path, out_path = sys.argv[1:4]
orig = open(orig_path, encoding='utf-8').read()
rows_csv = list(csv.DictReader(open(csv_path, encoding='utf-8')))

# 元SQLの口コミ行: 1行1口コミ。順序が verdicts.csv の no と一致する。
pat = re.compile(r"^\('([^']+)',(NULL|'[^']*'),(NULL|'[^']*'),(NULL|'[^']*'),(NULL|'[^']*'),'((?:[^']|'')*)','([^']+)','([^']+)'\),?$", re.M)
reviews = [m.groups() for m in pat.finditer(orig)]
assert len(reviews) == len(rows_csv) == 689, (len(reviews), len(rows_csv))
for i, (rv, c) in enumerate(zip(reviews, rows_csv), 1):
    assert int(c['no']) == i and rv[0] == c['product_id'], i
    summary = rv[5].replace("''", "'")
    assert hashlib.sha256(summary.encode()).hexdigest()[:12] == c['summary_sha'], f'summary changed at {i}'

keep = [(rv, c) for rv, c in zip(reviews, rows_csv) if c['status'] in ('V', 'A')]
head = orig[:orig.index('WITH new_reviews')]
# 見出しコメントを更新
head = head.replace(
    '-- 口コミは楽天市場・Yahoo!ショッピングの購入者レビューと公開動画の説明文を要約したもの（原文の転載なし）。Amazonレビューは使用していない。',
    '-- 口コミは楽天市場・Yahoo!ショッピングの購入者レビューを要約したもの（原文の転載なし）。Amazonレビューは使用していない。動画(YouTube)由来の4件は確認できなかったため含めない。\n'
    '-- 出典監査(audit/review-source-20261018-harness/): 689件中677件について対応する公開投稿を確認し、確認できた行だけを追加する。投稿の識別情報は review_sources に登録する。')
head = head.replace('再実行しても重複しない（商品は INSERT OR IGNORE、口コミは同一商品・同一要約があれば挿入しない）。',
                    '再実行しても重複しない（商品は INSERT OR IGNORE、口コミは同一商品・同一要約があれば挿入しない、review_sources は (platform, source_review_id) が一意）。')

def q(s):
    return "'" + s.replace("'", "''") + "'"

out = [head.rstrip('\n') + '\n\n']
cols = 'product_id,dog_breed,dog_size,coat_type,needs,summary,source_type,source_url'
for k in range(0, len(keep), CHUNK):
    part = keep[k:k + CHUNK]
    lines = ["(" + ",".join([q(rv[0])] + [rv[i] for i in (1, 2, 3, 4)] + ["'" + rv[5] + "'", q(rv[6]), q(rv[7])]) + ")" for rv, _ in part]
    out.append(f"WITH new_reviews({cols}) AS (\nVALUES\n" + ",\n".join(lines) + "\n)\n")
    out.append(f"INSERT INTO reviews({cols})\nSELECT n.product_id,n.dog_breed,n.dog_size,n.coat_type,n.needs,n.summary,n.source_type,n.source_url\nFROM new_reviews n\nWHERE NOT EXISTS (\n  SELECT 1 FROM reviews r\n  WHERE r.product_id=n.product_id\n    AND r.summary=n.summary\n);\n\n")

out.append("-- 投稿の識別情報(review_sources)。review_id は (product_id, summary) で上の口コミに結び付ける。追加のみ。\n")
for k in range(0, len(keep), CHUNK):
    part = keep[k:k + CHUNK]
    lines = []
    for rv, c in part:
        summary = rv[5]  # すでにSQLエスケープ済み
        lines.append("(" + ",".join([q(rv[0]), "'" + summary + "'", q(rv[6]), q(c['post_page_url']), q(c['platform']), q(c['source_review_id'])]) + ")")
    out.append("WITH new_sources(product_id,summary,source_type,source_url,source_platform,source_review_id) AS (\nVALUES\n" + ",\n".join(lines) + "\n)\n")
    out.append("INSERT OR IGNORE INTO review_sources(review_id,source_type,source_url,source_platform,source_review_id)\nSELECT r.id,s.source_type,s.source_url,s.source_platform,s.source_review_id\nFROM new_sources s\nJOIN reviews r ON r.product_id=s.product_id AND r.summary=s.summary;\n\n")

out.append("SELECT COUNT(*) AS dog_harness_product_count FROM products WHERE category='dog-harness' AND active=1;\n")
out.append("SELECT COUNT(*) AS dog_harness_review_count FROM reviews r JOIN products p ON p.id=r.product_id WHERE p.category='dog-harness' AND p.active=1;\n")
out.append("SELECT COUNT(*) AS dog_harness_review_source_count FROM review_sources s JOIN reviews r ON r.id=s.review_id JOIN products p ON p.id=r.product_id WHERE p.category='dog-harness' AND p.active=1;\n")
open(out_path, 'w', encoding='utf-8').write(''.join(out))
print(len(keep), 'reviews kept')
