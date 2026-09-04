# Review Expansion to 50+ per Article

Goal: every D1-backed review article has at least 50 individual public experience summaries.

## Rules
- Minimum 50 reviews per category, not merely "review count shown on source page".
- Each D1 row must correspond to one identifiable public review/post.
- Paraphrase; do not copy review text verbatim.
- Prefer actual-use experiences over arrival-only / pre-use comments.
- Keep negative and mixed experiences.
- Skip cat-only reviews.
- Never use platform AI summaries as an individual review.
- Record dog-specific information only when explicit in the source:
  - breed
  - age
  - weight
  - multiple dogs
  - coat / hair description
  - fearfulness / food motivation / other relevant traits
- Do not invent missing dog facts.
- Use source_type = public_buyer_review_summary for newly researched buyer reviews.
- Preserve actual public review page URL in source_url.
- Dedupe by product_id + dog_breed + summary before insert.
- Run count, duplicate and regression checks before asking for a production D1 execution.

## Baseline before expansion

| Category | Current | Target | Needed |
|---|---:|---:|---:|
| pet-dryer | 25 | 50 | 25 |
| auto-feeder | 7 | 50 | 43 |
| brush-slicker | 6 | 50 | 44 |
| brush-undercoat | 6 | 50 | 44 |
| brush-comb | 5 | 50 | 45 |
| brush-pin | 5 | 50 | 45 |
| dog-clipper | 10 | 50 | 40 |
| nail-grinder | 10 | 50 | 40 |
| nail-clipper | 10 | 50 | 40 |
| dog-shampoo | 10 | 50 | 40 |
| dog-conditioner | 50 | 50 | 0 |
| **TOTAL** | **144** | **550** | **406** |

## Prepared migration coverage

All 406 missing rows are now represented by idempotent migrations in GitHub:

| Migration | Category | Rows added | Expected category total |
|---|---|---:|---:|
| 0008_brush_comb_to_50.sql | brush-comb | 45 | 50 |
| 0009_brush_slicker_to_50.sql | brush-slicker | 44 | 50 |
| 0010_brush_undercoat_to_50.sql | brush-undercoat | 44 | 50 |
| 0011_brush_pin_to_50.sql | brush-pin | 45 | 50 |
| 0012_dog_shampoo_to_50.sql | dog-shampoo | 40 | 50 |
| 0013_nail_clipper_to_50.sql | nail-clipper | 40 | 50 |
| 0014_nail_grinder_to_50.sql | nail-grinder | 40 | 50 |
| 0015_dog_clipper_to_50.sql | dog-clipper | 40 | 50 |
| 0016_auto_feeder_to_50.sql | auto-feeder | 43 | 50 |
| 0017_pet_dryer_to_50.sql | pet-dryer | 25 | 50 |
| **TOTAL** |  | **406** | **550 reviews across 11 categories** |

Pet-dryer validation: 25 new rows, 25 public review URLs, 0 duplicate summaries inside the migration, and 19/25 rows include an explicit dog descriptor from the source. Applying the migration twice against a 25-row baseline remains at 50, confirming idempotency at the migration-key level.

## Deployment sequence
1. Research and prepare idempotent SQL migrations in GitHub.
2. Validate exact row counts and duplicate keys locally at the text/SQL level.
3. User runs the prepared migrations in Cloudflare D1 Console.
4. Verify every category with a single count query.
5. Only after DB verification, update article copy/stats to advertise "50+ reviews".
6. Improve the shared DB review cards to surface dog size / coat / needs where available.
7. Run JS + sitemap + production regression checks.
