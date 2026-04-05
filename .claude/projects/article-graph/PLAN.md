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
  - Reference image: [graph-visualization.png](graph-visualization.png) — shows the desired look: tight circular clusters with clear overlap zones for shared tags, generous spacing between unrelated clusters, loose untagged nodes scattered freely outside
  - Reference image: [multi-cluster.png](multi-cluster.png) — shows the multi-cluster layout: large outer circles contain smaller sub-cluster circles for shared-tag subsets; non-sharing clusters are fully separated with clear whitespace between them; nodes may appear outside all clusters (truly untagged or single-article tags)
  - More reference images may be added to `.claude/projects/` in the future
  - Areas to explore: label placement, cluster label positioning, node sizing, color palette tuning, animation easing, tooltip styling

## Test Infrastructure ✅ Complete

**All test infrastructure is in place.** See [TEST_PLAN.md](TEST_PLAN.md) for full details.

Delivered:

- `_data/test_graph.yml` — 99 synthetic nodes covering all edge cases
- `reading/test-graph.json` — Liquid template with `testCategory` baked in at build time
- `reading-test.html` — unpublished test page (`published: false`)
- Test mode (`?testmode=1`) — node colors, yellow cross-cluster links, blue/red circle outlines, test info tooltip

### Cluster design decisions

> **Data model correction (2026-04-04):** The original test data (`_data/test_graph.yml`) used incorrect tag structure — subcluster nodes had only `[subcluster]` tags instead of `[parent, subcluster]` like the production data. This caused the geometric supercluster detection to fail (the `tech` circle never contained the `frontend` circle because `frontend`-only nodes were not in `tagGroups['tech']`). Fixed by: (1) updating all subcluster node tags to include the parent (e.g. `[frontend]` → `[tech, frontend]`), (2) updating dual-subcluster tags (e.g. `[frontend, backend]` → `[tech, frontend, backend]`), (3) deleting the now-redundant categories 9–13, and (4) replacing the hardcoded `SUPER_TAGS` set in JS with dynamic computation from node membership supersets. All force changes that were made against the old data were reverted before restarting.

- **Max 1 level of subclusters** — hierarchy is `supercluster → subcluster` only; no sub-sub-clusters. A subcluster tag cannot simultaneously act as a supercluster.
- **Supercluster detection is geometric** — a tag is a supercluster when its computed circle fully contains at least one other tag's circle. Containment is checked after each simulation tick.
- **Superclusters should not visually overlap** — the force changes push them apart with a minimum gap. Bridge nodes (tagged with two supercluster-level tags) may sit between circles but circles themselves should not intersect.
- **Minimum 2 articles to draw a circle** — a tag with only 1 article is treated as a free node (no cluster circle drawn, no centroid pull).
- **Ref links can cross any boundary** — a link may connect nodes in different subclusters, different superclusters, or between free and clustered nodes. Forces must maintain correct node placement regardless.

### How to enable test mode

```bash
bundle exec jekyll serve --unpublished   # makes reading-test.html accessible
# visit: http://localhost:4000/reading-test/?testmode=1
```

`reading-test.html` has `published: false` — Jekyll excludes it from production builds entirely. GitHub Pages never sees it. Test mode (`?testmode=1`) only changes colors and tooltips; no force parameters change.

| Test color | Category | Expected position |
| --- | --- | --- |
| Red fill | Supercluster-only node | Outer ring of supercluster, NOT inside any subcluster |
| Orange fill | Dual-subcluster node | Between two sibling subcluster circles |
| Magenta fill | Cross-supercluster bridge | Near boundary between two superclusters |
| Cyan fill | Free node (no tags / singleton tag) | Just outside nearest cluster circle |
| Yellow stroke | Node with cross-cluster ref link | Marks nodes actively pulled across boundaries |
| Blue dashed circle | Supercluster boundary | Should not overlap another blue circle |
| Red solid circle | Subcluster boundary | Should not overlap a sibling red circle |

---

## Visual Refinement Plan

Checklist of targeted changes based on research. Add items here as we identify specific things to improve.

### Page formatting

The site's key breakpoints (from `styles.scss`):

- **≤ 767px** — sidebar stacks above content (no longer a side column), significantly reducing vertical space for the graph
- **≤ 414px** — smallest phones

The `reading.html` layout uses `d-md-flex` (Primer flex at ≥768px), so below 768px the sidebar becomes a top bar and the graph container height needs to account for that. The graph currently computes `H = container.clientHeight` at load time but may not re-measure correctly on mobile.

- [x] **Match content width** — add `max-width: 920px; margin: 0 auto` to `#graph-container` so the graph edges align with the header/subtitle text above it
- [x] **Graph height on mobile** — replaced `calc(100vh - 180px)` with `updateContainerHeight()`: measures `container.getBoundingClientRect().top` at render time and sets `height = innerHeight - top - 20px`; called on load and inside ResizeObserver
- [x] **Tooltip positioning on mobile** — added bottom clamp: `Math.min(..., window.innerHeight - 220)`; right clamp was already present
- [x] **Cluster label readability** — cluster label text hidden via `display: none` when `W < 415`
- [x] **Legend placement on mobile** — zoom buttons increased to 44×44px; age legend hidden (skipped entirely) when `W < 415`; `legendEl` tracked so it's removed cleanly on re-render
- [x] **Verify simulation bounds** — added debounced `ResizeObserver` on `#graph-container`; on fire: updates container height, re-reads W/H/VW/VH, updates zoom `translateExtent` + resets initial transform, stops old simulation, clears `g` content, re-renders with stored `graphData`

### Cluster layout

> **See [TEST_PLAN.md](TEST_PLAN.md)** for the test dataset design (`test_graph.yml`, 103 nodes) and test mode color coding (`?testmode=1`) used to verify the force changes.

All known layout issues are resolved. The simulation uses the following force stack (registered in this order):

| Force | What it does |
| --- | --- |
| `forceLink` | Ref-link edges. Distance 40. Strength varies by link type: `sub-cross` 0.01, `sub-free` 0.10, default 0.08. Weak cross-cluster links prevent forceLink from overpowering cluster placement. |
| `forceManyBody` | Global charge −35. |
| `forceCollide` | Collision radius = `nodeRadius(d) + 8`. |
| `forceX` / `forceY` | Soft anchor toward each supercluster's seed position (strength 0.025). Zero strength for non-supercluster nodes — prevents free/orphan nodes from being pulled to center. |
| `clusterForce` | Pulls each node toward its tag's centroid. Subcluster pull 0.15, supercluster pull 0.06 (weaker so nodes prefer their subcluster over the outer ring). Non-member clustered nodes are repelled outside `circle.r + 56`. Free nodes skipped. |
| `clusterBoundaryForce` | Pushes cluster node groups away from SVG edges so circles don't clip the viewport boundary. |
| `subclusterSeparationForce` | Pushes sibling subcluster circles apart (gap ≥ 20px). Skips pairs that share nodes (intentional Venn overlap). |
| `superclusterProximityForce` | Supercluster ↔ supercluster: attracts when gap > 50px, repels with strength `overlap * alpha * 1.2` when closer. Orphan clusters ↔ all other circles: repel only (gap ≥ 30px). |
| `ringOrbitalForce` | Pulls supercluster-only nodes (no sub-tag) to an orbital ring that clears all subcluster circles within their supercluster. Target radius = max(0.82 × supercluster.r, edge of furthest sub-circle + 50). |
| `nodeExclusionForce` | Pushes any node out of sibling subcluster circles it doesn't belong to (boundary = `sib.r + nodeRadius + 12`, strength `penetration * 3.0 * alpha`). Covers supercluster-only, dual-subcluster, and single-subcluster nodes. |
| `freeNodeForce` | Keeps free nodes (no cluster tag) outside all cluster circles (margin 40px). Also gently attracts them toward the nearest circle's edge so they park nearby rather than drifting. |

**Initial seeding** — nodes start separated by type to give forces a clean start:

- Supercluster nodes: evenly spaced on a ring at 0.22× canvas radius from center
- Subcluster nodes: offset within their supercluster seed by a pre-computed angle
- Orphan cluster nodes (≥2 nodes, not a sub/supercluster): evenly spaced on the outer ring at 0.42× radius
- Free nodes: random angle on the same 0.42× outer ring

### Node visual encoding

**Backlink-based sizing** — use `d3.scaleThreshold` to map inbound ref count to 5 radius classes. Thresholds are intentionally generous to stay meaningful as the dataset grows:

| Backlinks | Radius              |
|-----------|---------------------|
| 0         | 6 (current default) |
| 1         | 8                   |
| 2–3       | 11                  |
| 4–6       | 15                  |
| 7+        | 20                  |

- [x] Precompute a `backlinkCount` map from `refLinks` (count how many times each node `id` appears as a `target`)
- [x] Define `d3.scaleThreshold([1, 2, 4, 7], [6, 8, 11, 15, 20])` and apply to node circle `r`
- [x] Update `forceCollide` radius fn to use the same scale so larger nodes don't overlap

**Age-based color desaturation** — use `d3.hsl` to blend the node's base color toward grey based on article age. Apply to the article fill color only (not own-post gold). Final values differ from original spec after visual tuning — saturation and lightness both vary for perceptual distinction at low saturation levels:

| Age          | Saturation | Lightness |
|--------------|------------|-----------|
| < 1 month    | 1.00       | 0.56      |
| 1–3 months   | 0.80       | 0.62      |
| 3–6 months   | 0.58       | 0.64      |
| 6–12 months  | 0.36       | 0.64      |
| 12–24 months | 0.12       | 0.53      |
| 24+ months   | 0.04       | 0.44      |

- [x] Compute `ageMonths` from `d.date` relative to today at render time
- [x] Define `d3.scaleThreshold` for both saturation and lightness, set absolutely (not as multipliers)
- [x] Apply via `d3.hsl(baseColor)`, setting `.s` and `.l` directly, convert back to hex string

### Viewport controls

- [x] **Lock pan to content bounds** — call `zoom.translateExtent([[0, 0], [W, H]])` so panning cannot go beyond the SVG dimensions; no dead empty space
- [x] **+/- zoom buttons** — add two buttons absolutely positioned in the top-right corner of `#graph-container`; wire each to `svg.transition().duration(300).call(zoom.scaleBy, 1.4)` / `zoom.scaleBy(0.7)`; keep `scaleExtent([0.2, 4])` as the clamp; on touch devices pinch-to-zoom works natively but buttons should remain with ≥44px tap targets
- [x] **Age color legend** — discrete color swatches + labels overlaid in the bottom-left corner of the container; built as an absolutely-positioned SVG appended to `#graph-container`; labels read "< 1mo", "1–3mo", "3–6mo", "6–12mo", "1–2yr", "2yr+"; title: "Article age"

### Legend cluster focus (Pattern C — zoom + fade)

Clicking a tag in the legend zooms to that cluster and fades unrelated nodes. Clicking the active tag again (or the background) resets.

- [ ] On legend tag click: compute zoom transform from `clusterCircle[tag]` — use `cx`, `cy`, `r` to derive translate + scale so the cluster fills ~70% of the viewport; apply via `svg.transition().duration(600).call(zoom.transform, transform)`
- [ ] Simultaneously fade all nodes/links not belonging to the clicked tag to opacity `0.15` using `.transition().style("opacity", ...)`
- [ ] Highlight the active cluster circle with a brighter stroke (e.g. `stroke-width: 2.5`, full opacity color)
- [ ] Track active tag in a variable; clicking the same tag or the SVG background resets zoom to identity and restores all opacities
- [ ] Style the active legend item distinctly (e.g. underline or filled background) so it's clear which cluster is focused

### Tooltip improvements

- [x] Show full date instead of year only — formatted with `toLocaleDateString('en-US', { year: 'numeric', month: 'short', day: 'numeric' })`
- [x] Add a `blurb` field to `reading.yml` entries: a 1-sentence description of the article — display it in the tooltip below the author/date line, and include it in `graph.json`

### Data cleanup

The domain nodes and domain links in `reading/graph.json` are generated but immediately filtered out by the JS — they're dead weight. The `domain` field on article nodes is also unused.

- [x] Remove `domain` field from article nodes in `graph.json`
- [x] Remove domain node generation block (the `{% for domain in domains %}` loop)
- [x] Remove domain link generation block (the `source → domain:` links)
- [x] Remove the `domain_names` dedup string build at the top of the template (no longer needed)

## Verification Steps

Use `playwright-cli` to take screenshots (saved to `.screenshot-tests/`, which is gitignored).

If the site is not running at <http://localhost:4000/>, notify the user that they need to run `jbundle`.

First, delete any stale screenshots from previous runs:

```bash
rm -f .screenshot-tests/article-graph-*.png
```

### Workflow 1 — Page load and static UI

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

### Workflow 2 — Settled graph layout (run 3–4 times)

The force simulation uses random initial positions, so the final layout differs each run. Take multiple settled screenshots and review them all — look for consistent cluster separation and no runaway nodes, not pixel-perfect reproduction.

Use `playwright-cli open` (not `--url`) so you can reload the page between runs without reopening the browser:

```bash
playwright-cli open http://localhost:4000/reading/
playwright-cli resize 1400 900
```

Then repeat the following block **3–4 times**, incrementing the filename suffix each time:

```bash
# Reload to get a fresh simulation run
playwright-cli reload
# Wait ~5s for the simulation to settle, then screenshot
sleep 5 && playwright-cli screenshot --filename .screenshot-tests/article-graph-settled-1.png

# Run 2
playwright-cli reload
sleep 5 && playwright-cli screenshot --filename .screenshot-tests/article-graph-settled-2.png

# Run 3
playwright-cli reload
sleep 5 && playwright-cli screenshot --filename .screenshot-tests/article-graph-settled-3.png

# Run 4
playwright-cli reload
sleep 5 && playwright-cli screenshot --filename .screenshot-tests/article-graph-settled-4.png
```

Verify across all runs:

- Cluster circles are visible with correct tag labels
- Nodes stay within the SVG bounds (no clipping at edges)
- Ref links (dashed lines) connect the correct nodes
- Age color legend is visible in the bottom-left corner
- Zoom +/− buttons are visible in the top-right corner
- No node groups escape to a corner or collapse into a single pile
- Isolated nodes (single-tag articles with no cluster) float near the center, not off in a corner

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
