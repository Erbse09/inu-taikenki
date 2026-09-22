-- Read-only preflight AND post-migration check. Save both outputs for comparison.
PRAGMA table_info(products);
PRAGMA table_info(reviews);
PRAGMA foreign_key_check;
SELECT COUNT(*) AS product_count FROM products;
SELECT COUNT(*) AS review_count, MIN(id) AS min_id, MAX(id) AS max_id,
       SUM(length(summary)) AS summary_characters,
       SUM(length(source_url)) AS source_url_characters
FROM reviews;
SELECT p.category, COUNT(r.id) AS review_count
FROM products p LEFT JOIN reviews r ON r.product_id=p.id
GROUP BY p.category ORDER BY p.category;
SELECT source_type, COUNT(*) AS review_count FROM reviews GROUP BY source_type;
SELECT name, COUNT(*) AS product_count FROM products GROUP BY name HAVING COUNT(*)>1;
SELECT asin, COUNT(*) AS product_count FROM products
WHERE nullif(trim(asin),'') IS NOT NULL GROUP BY asin HAVING COUNT(*)>1;
SELECT COUNT(*) AS missing_source_urls FROM reviews WHERE nullif(trim(source_url),'') IS NULL;
