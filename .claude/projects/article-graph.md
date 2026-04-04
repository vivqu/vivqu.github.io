# Article Graph — Build Spec

Jekyll + GitHub Pages · D3 v7 force graph · no custom plugins

## Implementation Plan

- [x] **Step 1 — Page scaffold**: Create `reading.html` at repo root with Jekyll front matter, layout, and placeholder content. Page lives at `/reading`.
  - Title and subtitle rendered in `_layouts/reading.html`, not the page body (Liquid only processes reliably in layouts).
  - Subtitle copy (hardcoded in layout, do not change): *"an interactive map of articles and essays I've found worth reading, connected by domain and cross-references"*
- [x] **Step 2 — Nav link**: Add "reading" link to `_includes/masthead.html` between "books" and "subscribe".
- [x] **Step 3 — Sample data**: Create `_data/reading.yml` with ~10–15 representative articles covering a few domains and tags, including a few `refs` cross-links and at least one own post (`domain: self`).
- [x] **Step 4 — graph.json template**: Create `reading/graph.json` (Liquid template). Emits nodes and links from `_data/reading.yml`. Rendered to `/reading/graph.json` at build time.
- [x] **Step 5 — D3 graph**: Build the full visualisation inside `reading.html`:
  - SVG element with dark background, zoom/pan, drag
  - Ref link edges only (dashed, semi-transparent white) — domain nodes removed as visual noise
  - Article nodes only: purple `#7c6edb`, gold `#f0c060` for own posts
  - Circular cluster overlays per tag (not convex hulls): filled semi-transparent circle per tag, recomputed each tick
  - Outer circles expand to fully contain any inner sub-cluster circles (e.g. `forecasting` contains `skepticism`)
  - Clustering force pulls nodes toward their tag centroids; repulsion force pushes non-member nodes outside cluster boundary + 50px buffer
  - Hover tooltip (title, author, year, tags); article labels visible on hover
  - Clickable article nodes (open in new tab)
- [x] **Step 6 — Force tuning**: Verified simulation params; adjusted charge, collide, center force strength, alpha/velocity decay for stable layout.
- [x] **Step 7 — Visual refinement**: Research D3 graph options and refine the output to better match the target aesthetic.
  - Reference image: [article-graph-visualization.png](.claude/projects/article-graph-visualization.png) — shows the desired look: tight circular clusters with clear overlap zones for shared tags, generous spacing between unrelated clusters, loose untagged nodes scattered freely outside
  - More reference images may be added to `.claude/projects/` in the future
  - Areas to explore: label placement, cluster label positioning, node sizing, color palette tuning, animation easing, tooltip styling

## Visual Refinement Plan

Checklist of targeted changes based on research. Add items here as we identify specific things to improve.

### Page formatting

The site's key breakpoints (from `styles.scss`):

- **≤ 767px** — sidebar stacks above content (no longer a side column), significantly reducing vertical space for the graph
- **≤ 414px** — smallest phones

The `reading.html` layout uses `d-md-flex` (Primer flex at ≥768px), so below 768px the sidebar becomes a top bar and the graph container height needs to account for that. The graph currently computes `H = container.clientHeight` at load time but may not re-measure correctly on mobile.

- [ ] **Match content width** — the reading layout caps the header at `max-width: 700px` with consistent side margins; constrain `#graph-container` to the same width so the graph edges align with the page content rather than stretching full viewport width
- [ ] **Graph height on mobile** — on ≤767px the graph container `calc(100vh - 180px)` offset should be increased to account for the stacked header/nav; measure actual header height dynamically at render time rather than using a hardcoded offset
- [ ] **Tooltip positioning on mobile** — `event.clientX/Y` positioning can push tooltips off-screen on narrow viewports; clamp to viewport width on small screens (≤767px)
- [ ] **Cluster label readability** — at small viewport widths the cluster label text (11px) may overlap; consider hiding labels below ≤414px or reducing font size
- [ ] **Legend placement on mobile** — the bottom-left age color legend and top-right zoom buttons may collide with the graph content on narrow screens; stack or relocate them below ≤767px
- [ ] **Verify simulation bounds** — `W` and `H` are computed once on load; on mobile after orientation change, they'll be stale — add a `ResizeObserver` or `resize` event listener to recompute and restart the simulation

### Cluster layout

Use the [clustered bubbles](https://observablehq.com/@d3/clustered-bubbles) approach for nodes that belong to a tag cluster:

- [ ] Replace `forceCenter` with `forceX(width/2).strength(0.01)` + `forceY(height/2).strength(0.01)`
- [ ] Add custom `forceCluster` that computes per-group centroids each tick and pulls nodes toward them with `strength = 0.2`
- [ ] Replace `d3.forceCollide` with a custom quadtree-based collide force: `padding1 = 2` within same group, `padding2 = 6` across groups

### Unclustered nodes layout

Use the [disjoint force-directed graph](https://observablehq.com/@d3/disjoint-force-directed-graph/2) approach for nodes with no tag (or tags that have only one article):

- [ ] Keep `forceX` + `forceY` (already added above) — this naturally prevents isolated/disjoint nodes from escaping the viewport, unlike `forceCenter`

### Node visual encoding

**Backlink-based sizing** — use `d3.scaleThreshold` to map inbound ref count to 5 radius classes. Thresholds are intentionally generous to stay meaningful as the dataset grows:

| Backlinks | Radius              |
|-----------|---------------------|
| 0         | 6 (current default) |
| 1         | 8                   |
| 2–3       | 11                  |
| 4–6       | 15                  |
| 7+        | 20                  |

- [ ] Precompute a `backlinkCount` map from `refLinks` (count how many times each node `id` appears as a `target`)
- [ ] Define `d3.scaleThreshold([1, 2, 4, 7], [6, 8, 11, 15, 20])` and apply to node circle `r`
- [ ] Update `forceCollide` radius fn to use the same scale so larger nodes don't overlap

**Age-based color desaturation** — use `d3.hsl` to blend the node's base color toward grey based on article age. Apply to the article fill color only (not own-post gold):

| Age          | Saturation        |
|--------------|-------------------|
| < 1 month    | 100% (full color) |
| 1–2 months   | 80%               |
| 3–6 months   | 55%               |
| 6–12 months  | 30%               |
| 12–24 months | 15% (near-grey)   |
| 24+ months   | 8% (almost grey)  |

- [ ] Compute `ageMonths` from `d.date` relative to today at render time
- [ ] Define a `d3.scaleThreshold([1, 3, 6, 12, 24], [1.0, 0.8, 0.55, 0.3, 0.15, 0.08])` saturation multiplier
- [ ] Apply via `d3.hsl(baseColor)` — multiply `.s` by the factor, convert back to hex string

### Viewport controls

- [ ] **Lock pan to content bounds** — call `zoom.translateExtent([[0, 0], [W, H]])` so panning cannot go beyond the SVG dimensions; no dead empty space
- [ ] **+/- zoom buttons** — add two buttons absolutely positioned in the top-right corner of `#graph-container`; wire each to `svg.transition().duration(300).call(zoom.scaleBy, 1.4)` / `zoom.scaleBy(0.7)`; keep `scaleExtent([0.2, 4])` as the clamp; on touch devices pinch-to-zoom works natively but buttons should remain with ≥44px tap targets
- [ ] **Age color legend** — add a small threshold legend (ref: [d3 color legend](https://observablehq.com/@d3/color-legend)) overlaid in the bottom-left corner of the container. Build a `d3.scaleThreshold` mapping the same month thresholds to the desaturated color stops, render discrete color rectangles + axis tick labels via `d3.axisBottom`. Labels should read e.g. "1mo", "3mo", "6mo", "1yr", "2yr+". Title: "Article age".

### Legend cluster focus (Pattern C — zoom + fade)

Clicking a tag in the legend zooms to that cluster and fades unrelated nodes. Clicking the active tag again (or the background) resets.

- [ ] On legend tag click: compute zoom transform from `clusterCircle[tag]` — use `cx`, `cy`, `r` to derive translate + scale so the cluster fills ~70% of the viewport; apply via `svg.transition().duration(600).call(zoom.transform, transform)`
- [ ] Simultaneously fade all nodes/links not belonging to the clicked tag to opacity `0.15` using `.transition().style("opacity", ...)`
- [ ] Highlight the active cluster circle with a brighter stroke (e.g. `stroke-width: 2.5`, full opacity color)
- [ ] Track active tag in a variable; clicking the same tag or the SVG background resets zoom to identity and restores all opacities
- [ ] Style the active legend item distinctly (e.g. underline or filled background) so it's clear which cluster is focused

### Tooltip improvements

- [ ] Show full date instead of year only — `date` is already `YYYY-MM-DD` in the YAML, just change the JS display from `d.date.slice(0, 4)` to a formatted full date
- [ ] Add a `blurb` field to `reading.yml` entries: a 1-sentence description of the article — display it in the tooltip below the author/date line, and include it in `graph.json`

### Data cleanup

The domain nodes and domain links in `reading/graph.json` are generated but immediately filtered out by the JS — they're dead weight. The `domain` field on article nodes is also unused.

- [ ] Remove `domain` field from article nodes in `graph.json`
- [ ] Remove domain node generation block (the `{% for domain in domains %}` loop)
- [ ] Remove domain link generation block (the `source → domain:` links)
- [ ] Remove the `domain_names` dedup string build at the top of the template (no longer needed)

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

Liquid template at repo root, rendered to /reading/graph.json at build time. No Ruby plugin — works on vanilla GitHub Pages.

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

Jekyll page at /reading. Fetches /reading/graph.json, renders with D3 v7 (cdnjs CDN) on an SVG element.

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
