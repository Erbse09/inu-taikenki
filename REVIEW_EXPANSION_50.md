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

## Deployment sequence
1. Research and prepare idempotent SQL migrations in GitHub.
2. Validate exact row counts and duplicate keys locally at the text/SQL level.
3. User runs the prepared migrations in Cloudflare D1 Console.
4. Verify every category with a single count query.
5. Only after DB verification, update article copy/stats to advertise "50+ reviews".
6. Improve the shared DB review cards to surface dog size / coat / needs where available.
7. Run JS + sitemap + production regression checks.
