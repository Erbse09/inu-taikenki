-- Dog toothbrush verified Amazon search affiliate links (JAN-based)
UPDATE products SET affiliate_url='https://www.amazon.co.jp/s?k=4947651906007&tag=100things-22' WHERE id='mindup-small-head';
UPDATE products SET affiliate_url='https://www.amazon.co.jp/s?k=4947651906021&tag=100things-22' WHERE id='mindup-small-soft';
UPDATE products SET affiliate_url='https://www.amazon.co.jp/s?k=4903351005716&tag=100things-22' WHERE id='petkiss-compact';
UPDATE products SET affiliate_url='https://www.amazon.co.jp/s?k=4903351003965&tag=100things-22' WHERE id='petkiss-finger';
UPDATE products SET affiliate_url='https://www.amazon.co.jp/s?k=4947651906014&tag=100things-22' WHERE id='mindup-large-head';
UPDATE products SET affiliate_url='https://www.amazon.co.jp/s?k=4947651906069&tag=100things-22' WHERE id='mindup-slim-cylinder';

SELECT id, name, affiliate_url
FROM products
WHERE category='dog-toothbrush'
ORDER BY id;
