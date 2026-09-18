-- Additive only. Never replay seed.sql on production.
-- Existing products/reviews, IDs, summaries and source fields remain untouched.
PRAGMA foreign_keys = ON;

-- A product is a manufacturer/model/variant, never a marketplace listing.
-- Register verified cross-market identifiers against the existing products.id.
CREATE TABLE IF NOT EXISTS product_identifiers (
  namespace TEXT NOT NULL CHECK(namespace IN ('gtin','manufacturer_model')),
  identifier TEXT NOT NULL CHECK(length(trim(identifier)) > 0),
  product_id TEXT NOT NULL REFERENCES products(id) ON DELETE RESTRICT,
  evidence_url TEXT NOT NULL CHECK(evidence_url GLOB 'https://*'),
  PRIMARY KEY(namespace, identifier)
);
CREATE INDEX IF NOT EXISTS idx_product_identifiers_product ON product_identifiers(product_id);
CREATE TABLE IF NOT EXISTS product_listings (
  marketplace TEXT NOT NULL CHECK(marketplace IN ('amazon','rakuten','yahoo')),
  external_id TEXT NOT NULL CHECK(length(trim(external_id)) > 0),
  product_id TEXT NOT NULL REFERENCES products(id) ON DELETE RESTRICT,
  source_url TEXT NOT NULL CHECK(source_url GLOB 'https://*'),
  PRIMARY KEY(marketplace, external_id)
);
CREATE INDEX IF NOT EXISTS idx_product_listings_product ON product_listings(product_id);

-- Optional future per-review identity, not a raw-text archive.
-- A shared product review-page URL is NOT a unique individual review ID.
CREATE TABLE IF NOT EXISTS review_sources (
  review_id INTEGER NOT NULL REFERENCES reviews(id) ON DELETE CASCADE,
  source_type TEXT NOT NULL,
  source_url TEXT NOT NULL CHECK(source_url GLOB 'https://*'),
  source_platform TEXT NOT NULL,
  source_review_id TEXT NOT NULL CHECK(length(trim(source_review_id)) > 0),
  PRIMARY KEY(source_platform, source_review_id),
  UNIQUE(review_id, source_platform, source_review_id)
);
CREATE INDEX IF NOT EXISTS idx_review_sources_review ON review_sources(review_id);

-- Exact searchable tokens derived only from existing explicitly recorded fields.
CREATE TABLE IF NOT EXISTS review_attributes (
  review_id INTEGER NOT NULL REFERENCES reviews(id) ON DELETE CASCADE,
  kind TEXT NOT NULL CHECK(kind IN ('size','coat','trait')),
  value TEXT NOT NULL,
  PRIMARY KEY(review_id, kind, value)
);
CREATE INDEX IF NOT EXISTS idx_review_attributes_lookup ON review_attributes(kind, value, review_id);
CREATE INDEX IF NOT EXISTS idx_products_category_active_id ON products(category, active, id);
CREATE INDEX IF NOT EXISTS idx_reviews_product_cursor ON reviews(product_id, id);
CREATE INDEX IF NOT EXISTS idx_reviews_breed_cursor ON reviews(dog_breed, id);

-- json_quote safely handles arbitrary legacy text; whitespace token fields are
-- kept verbatim in reviews. Empty / literal null tokens are not dog facts.
CREATE VIEW IF NOT EXISTS review_attribute_tokens AS
SELECT fields.review_id, fields.kind, lower(trim(j.value)) AS value
FROM (
  SELECT id AS review_id, 'size' AS kind, dog_size AS tokens FROM reviews
  UNION ALL SELECT id, 'coat', coat_type FROM reviews
  UNION ALL SELECT id, 'trait', needs FROM reviews
) fields,
json_each('[' || replace(json_quote(
  replace(replace(replace(replace(replace(replace(coalesce(fields.tokens,''),
    char(9),' '),char(10),' '),char(13),' '),char(11),' '),char(12),' '),'　',' ')
), ' ', '","') || ']') j;

INSERT OR IGNORE INTO review_attributes(review_id, kind, value)
SELECT review_id, kind, value FROM review_attribute_tokens WHERE value NOT IN ('','null');
CREATE TRIGGER IF NOT EXISTS reviews_attributes_insert AFTER INSERT ON reviews BEGIN
  INSERT OR IGNORE INTO review_attributes(review_id,kind,value)
  SELECT review_id,kind,value FROM review_attribute_tokens WHERE review_id=NEW.id AND value NOT IN ('','null');
END;
CREATE TRIGGER IF NOT EXISTS reviews_attributes_update AFTER UPDATE OF dog_size,coat_type,needs ON reviews BEGIN
  DELETE FROM review_attributes WHERE review_id=NEW.id;
  INSERT OR IGNORE INTO review_attributes(review_id,kind,value)
  SELECT review_id,kind,value FROM review_attribute_tokens WHERE review_id=NEW.id AND value NOT IN ('','null');
END;
