# Article Graph — Build Spec

Jekyll + GitHub Pages · D3 v7 force graph · no custom plugins

## Implementation Plan

- [x] **Step 1 — Page scaffold**: Create `reading.html` at repo root with Jekyll front matter, layout, and placeholder content. Page lives at `/reading`.
  - Title and subtitle rendered in `_layouts/reading.html`, not the page body (Liquid only processes reliably in layouts).
  - Subtitle copy (hardcoded in layout, do not change): *"an interactive map of articles and essays I've found worth reading, connected by domain and cross-references"*
- [x] **Step 2 — Nav link**: Add "reading" link to `_includes/masthead.html` between "books" and "subscribe".
- [x] **Step 3 — Sample data**: Create `_data/reading.yml` with ~10–15 representative articles covering a few domains and tags, including a few `refs` cross-links and at least one own post (`domain: self`).
- [ ] **Step 4 — graph.json template**: Create `reading-graph.json` (Liquid template) at repo root. Emits nodes and links from `_data/reading.yml`. Rendered to `/reading-graph.json` at build time.
- [ ] **Step 5 — D3 graph**: Build the full visualisation inside `reading.html`:
  - SVG element with dark background, zoom/pan, drag
  - Domain link edges (thin, low-opacity) and ref link edges (dashed, brighter)
  - Article nodes (purple / gold for own posts) and domain nodes (teal / orange at 3+)
  - Convex hull overlays per tag, recomputed each tick
  - Hover tooltip
  - Clickable article nodes (open in new tab)
- [ ] **Step 6 — Force tuning**: Verify simulation params (link distance, charge, collision, center force) look good with real data; adjust as needed.

## Verification Steps

Workflow 1 - Verifying the page loads and UI renders

Use `playwright-cli` to take screenshots (saved to `.screenshot-tests/`, which is gitignored).

If the site is not running at <http://localhost:4000/>, notify the user that they need to run `jbundle`.

First, delete any stale screenshots from previous runs:

```bash
rm -f .screenshot-tests/article-graph-*.png
```

```bash
# Screenshot the homepage to verify the nav link appears
playwright-cli screenshot --url http://localhost:4000/ --filename .screenshot-tests/article-graph-home-nav.png

# Screenshot the reading page to verify title, subtitle, and graph render
playwright-cli screenshot --url http://localhost:4000/reading --filename .screenshot-tests/article-graph-reading-page.png
```

Verify in the screenshots:

- "Reading" link is visible in the left navigation bar between "books" and "subscribe"
- Reading page shows:
  - Title: Reading
  - Subtitle: an interactive map of articles and essays I've found worth reading, connected by domain and cross-references
  - D3 graph SVG is rendered with nodes visible

---

## Goal

Add an interactive knowledge graph page to an existing Jekyll/GitHub Pages site. The graph visualises a curated list of articles (external and own) connected through shared domains.

1. Data — _data/reading.yml

Flat list, one entry per article.

```yaml
- title: "Attention Is All You Need"
  url: <https://arxiv.org/abs/1706.03762>
  author: Vaswani et al.
  domain: arxiv.org          # must be consistent, no <www>.
  tags: [transformers, ml]
  date: "2017-06-12"         # full publication date (YYYY-MM-DD); year is inferred from this
  refs: []                   # URLs of other articles in this list that this article references

- title: "My notes on scaling"
  url: /posts/scaling        # relative = own post
  author: me
  domain: self              # sentinel for own posts
  tags: [scaling, notes]
  date: "2024-03-15"
  refs: ["https://arxiv.org/abs/1706.03762"]  # cross-references to other articles by URL
```

1. Graph data — reading-graph.json

Liquid template at repo root, rendered to /reading-graph.json at build time. No Ruby plugin — works on vanilla GitHub Pages.

Emit one article node per entry (type: "article", includes all fields)

Emit one domain node per unique domain (type: "domain"), deduplicated in Liquid

Emit one link per article → its domain (type: "domain")

Emit one link per entry in refs → target article URL (type: "ref"); skip if target URL not present in articles list

```json
// output shape
{
  "nodes": [
    { "id": "https://arxiv.org/...", "type": "article", "label": ..., "author": ..., "domain": ..., "tags": [...], "date": ..., "self": false },
    { "id": "domain:arxiv.org",     "type": "domain", "label": "arxiv.org", "count": 3 }
  ],
  "links": [
    { "source": "https://arxiv.org/...", "target": "domain:arxiv.org", "type": "domain" },
    { "source": "/posts/scaling",        "target": "https://arxiv.org/...", "type": "ref" }
  ]
}
```

1. Visualisation — reading.html

Jekyll page at /reading. Fetches /reading-graph.json, renders with D3 v7 (cdnjs CDN) on an SVG element.

- Dark background — #14141f
- Article nodes — purple #7c6edb, fixed radius 6px
- Own posts — gold #f0c060
- Domain nodes — teal #38b89a, radius scales with article count; turns orange #e8734a at 3+ articles
- Domain links — thin, low-opacity white lines
- Ref links — dashed, slightly brighter lines to visually distinguish cross-article references from domain edges
- Domain labels always visible; article labels visible on zoom or hover
- Hover tooltip — title, author, date, tags for articles; name + count for domains
- Drag nodes, scroll to zoom, pan

Tag clusters — convex hull overlay (SVG `<path>`, rendered behind nodes):

- One hull per tag; each hull is a filled, semi-transparent region with a rounded stroke
- Assign each tag a distinct muted color from a fixed palette (cycle if more tags than palette entries)
- Hull label at centroid of the hull polygon, small font, matching hull color
- Hulls recompute on every simulation tick as nodes move
- Only draw a hull if the tag has ≥ 2 article nodes currently in the hull (single-node hulls are invisible)
- Tags with only 1 article are not drawn

Article nodes are clickable links — open url in new tab

1. Force simulation params

- Link distance 80px, strength 0.5
- Charge strength −200
- Collision radius = node radius + 10
- Center force to canvas midpoint

1. Constraints

No Ruby plugins — must build on vanilla GitHub Pages

No npm build step — plain JS, D3 from CDN

Single reading.html file — no separate CSS/JS files needed

D3 loaded from cdnjs.cloudflare.com
