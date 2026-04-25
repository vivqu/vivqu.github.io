# Article Graph — Specification

> **Purpose**: This document is the authoritative description of the article graph feature. It serves two roles:
>
> 1. A human-readable design doc for understanding and guiding the implementation.
> 2. A staleness anchor — if any file listed in [Owned Files](#owned-files) changes, this spec should be reviewed to confirm it is still accurate.

---

## Overview

The article graph is an interactive D3 v7 force-directed graph on the `/reading` page. It visualises a curated list of articles (external and own blog posts) as nodes, grouped into circular topic clusters, and connected by reference edges where one article cites another.

**Design constraints**:

- No Ruby plugins — builds on vanilla GitHub Pages
- No npm build step — plain JS, D3 from CDN
- No separate CSS/JS files — all graph logic lives in `_includes/reading-graph.html`

---

## Key Concepts

### Node types

Every article in `reading.yml` becomes one node. There are three visual node types:

- **Own post** — an article authored by the site owner (`domain: self`). Rendered in gold.
- **External article** — any other article. Color shifts from vivid purple to grey as the article ages.
- **Wikipedia article** — detected by URL; rendered in grey regardless of age.

### Cluster types

A **cluster** is drawn for any tag shared by ≥ 2 articles. Tags with only 1 article get no circle and their node is treated as free.

The cluster hierarchy is **inferred geometrically at render time** from node membership — it is not declared in the data. The data format is just flat tags; the graph discovers structure by checking tag set containment at render time. This is intentional: the author adding articles never needs to think about hierarchy, and the graph degrades gracefully as data changes (a tag that was a subcluster becomes a standalone orphan if its parent loses members).

- **Supercluster** — a tag whose node set is a strict superset of at least one other tag's node set. Its circle visually contains one or more subcluster circles.
- **Subcluster** — a tag that is not a supercluster, but all of its nodes belong to a supercluster's node set. Its circle sits inside the supercluster circle.
- **Orphan cluster** — has ≥ 2 nodes but is neither a supercluster nor a subcluster. Stands alone.
- **Free node** — a node with no cluster tags (untagged, or only singleton tags). Parks just outside the nearest cluster boundary.

**Critical data model invariant:** A node in a subcluster must also carry the parent supercluster tag. For example, a node in the `frontend` subcluster of `tech` must be tagged `[tech, frontend]`, not just `[frontend]`. The containment check works by comparing full node sets — if `frontend` nodes don't also have the `tech` tag, `tech`'s node set won't be a superset of `frontend`'s and the hierarchy will fail to detect. This is non-obvious and caused significant debugging pain when test data was originally structured incorrectly.

**Design invariants:**

- Max 1 level of nesting — `supercluster → subcluster` only; no sub-sub-clusters
- Superclusters must not visually overlap each other
- Sibling subclusters (same parent) must not overlap each other, unless they share nodes (intentional Venn)
- Free nodes park near the graph, not scattered into distant corners

### Reference edges

Articles can cite other articles in the list via `refs`. Each valid cross-reference becomes a directed edge drawn as a dashed line. Edges can cross any cluster boundary.

---

## How to Update the Article Data

Edit `_data/reading.yml`. The graph regenerates automatically on the next Jekyll build.

**Adding an article:**

1. Append a new entry to `_data/reading.yml`
2. Fill all fields including `blurb` and `date`
3. Use existing tag names to join existing clusters; new tag names create new clusters (≥ 2 articles needed to draw a circle)
4. Add URLs to `refs` only if the cited article is also present in the list

**After editing:**

- Update the `last_updated` front matter field in `reading.html` (format: `"Month Nth"`)

**Article entry format:**

```yaml
- title: "Article Title"
  url: "https://example.com/article"   # full URL for external; relative path for own posts
  author: "Author Name"                 # or "me" for own posts
  domain: example.com                   # bare hostname, no www; use "self" for own posts
  tags: [tag-a, tag-b]                  # shared tags create cluster circles on the graph
  date: "2025-06-01"                    # full publication date (YYYY-MM-DD)
  blurb: "One-sentence description."    # shown in hover tooltip
  refs: []                              # URLs of other articles in this list that this article cites
```

**Rules:**

- `domain` must be consistent (no `www.` prefix)
- `domain: self` is the sentinel value for own blog posts
- `refs` must contain full URLs that exactly match the `url` field of another entry — only valid matches become graph edges

---

## Graph Behavior

### Interaction

- **Click node** — opens article URL in a new tab
- **Drag node** — re-anchors the node; simulation heats up briefly while dragging
- **Scroll / pinch** — zoom
- **Pan** — drag on the empty graph background
- **Click empty background** — resets any active cluster focus

### Tooltip

Hovering a node shows a tooltip with: title, author, full publication date, domain, tags, and blurb.

### Legends and controls

**+/− zoom buttons** — positioned in the top-right corner of the graph.

**Age legend** (bottom-left) — 6 color swatches showing how article color shifts from vivid purple (recent) to grey (old). Hidden on the smallest screen sizes.

**Cluster legend** (bottom-right) — lists superclusters and orphan clusters only; subclusters are deliberately omitted. The legend is a navigation aid for the top-level shape of the graph — subclusters are a detail visible by zooming into their parent, not a separate destination. Each entry has a color swatch and the tag name. Hidden on the smallest screen sizes; auto-collapses on portrait orientation.

**Cluster focus** — clicking a legend entry zooms the graph so that cluster fills ~70% of the viewport and fades all unrelated nodes and edges. Clicking the same entry again, or the background, resets to the full view. Node labels appear automatically when a cluster is focused, regardless of zoom level.

### Node labels

Labels are hidden by default and appear when zoomed in past a threshold or when a cluster is focused. A greedy occlusion pass hides lower-priority labels that overlap higher-priority ones — higher backlink count wins; own-post labels always show and always block others. Hovering a node makes its label bold.

### Cluster circles

Clusters use **circles, not convex hulls**. Convex hulls were the original design but circles are mathematically tractable in ways hulls are not — containment, overlap, and distance from center can all be computed analytically, which is essential for writing forces that push nodes in or out of a region. Hulls would require polygon intersection tests and don't compose well with physics.

Each cluster circle is recomputed from current node positions on every simulation tick: center = mean position of members, radius = max distance from center to any member + padding. Supercluster circles then expand further to fully contain any subcluster circles inside them. This creates an important coupling: **node positions determine circle geometry, and circle geometry determines force directions** — the forces read `clusterCircle[tag]` to decide where to push nodes, but that object is updated by the same tick that just moved the nodes. This is intentional and stable because the circles converge as the simulation cools.

### Force simulation

The graph layout is computed by a D3 force simulation that runs when the page loads (and re-runs on window resize). It applies multiple forces simultaneously until the system reaches equilibrium. The final layout is not deterministic — because nodes start with some random jitter in their seed positions, each load produces a slightly different arrangement, but the structural properties (which nodes are inside which circles) are stable.

**Pre-seeding:** Rather than starting nodes at random positions, each node is seeded near its expected region — supercluster nodes near their supercluster's anchor point, subcluster nodes offset within that region by a pre-computed angle, orphan and free nodes on the outer ring. Ring-only nodes (supercluster tag but no subcluster) that are connected by ref links are grouped into BFS components and placed on adjacent arcs of the ring, so their edges don't have to cross through subcluster interiors at tick 1. This gives all forces a head start and avoids the cold-start problem where random positions cause explosive early velocities that cascade into degenerate layouts.

**The layered force model:** Several forces act on nodes simultaneously and are designed to cooperate rather than compete:

- *Charge repulsion* pushes all nodes apart globally so they don't pile up.
- *Collision avoidance* prevents individual node circles from overlapping, respecting each node's radius.
- *Centroid pull* draws each node toward the average position of its cluster members. Subcluster membership pulls harder than supercluster membership, so a node tagged with both a supercluster and a subcluster settles inside the subcluster circle — the tighter pull wins. Importantly, the centroid for a subcluster is computed from its *pure* members only (nodes that don't also belong to a sibling subcluster). Without this, dual-tag bridge nodes skew the centroid toward the overlap zone, causing the whole subcluster to drift inward.
- *Orbital force* handles supercluster-only nodes (tagged with a supercluster but no subcluster). Since the centroid pull would drag them toward the center of the supercluster — potentially inside a subcluster circle — a separate force pulls them to an orbital ring that clears the outermost subcluster boundary. This is what creates the visible "ring" of nodes around the outside of the subcluster circles.
- *Exclusion force* actively pushes any node out of subcluster circles it doesn't belong to. This is the primary guard against nodes drifting into the wrong cluster due to ref link tension.
- *Free node force* keeps untagged nodes outside all cluster circles and parks them near the closest boundary so they stay visible without cluttering the clusters.

**Cluster separation:** Two forces keep the cluster circles from merging into one blob. Sibling subclusters (sharing the same parent) are pushed apart so their circles don't overlap — unless they share nodes, in which case an intentional Venn-diagram overlap is allowed. Superclusters are attracted toward each other to stay grouped on the canvas but repel each other when they get too close, maintaining a visible gap.

**Reference link tension:** Ref links create a gentle pull between connected nodes. This tension is intentionally weakened for links that cross cluster boundaries so they don't overpower the cluster placement forces. A link between two nodes in different subclusters uses a much lower strength than a link within the same cluster. Each link is pre-classified into one of four types before the simulation starts, and the strength is set per type. Cross-cluster links get near-zero strength; same-supercluster ring links get higher strength so ref-linked ring nodes orbit together.

**Velocity cap:** On tick 1, `forceLink` computes velocities proportional to the distance between linked nodes. For distantly-seeded pairs this can be enormous — enough to send nodes flying to the canvas boundary, where the position clamp kills one velocity axis while the other keeps accumulating, producing axis-aligned chains of nodes. A per-tick velocity cap prevents this without affecting the long-term equilibrium.

---

## Testing

### Philosophy

The simulation uses randomised initial positions — exact pixel layout varies per run. Testing verifies **structural properties** (cluster membership, boundary rules, node type placement), not pixel-perfect reproduction.

### Test infrastructure

| File | Purpose |
| --- | --- |
| `_data/test_graph.yml` | 99 synthetic nodes covering all topological edge cases |
| `reading/test-graph.json` | Liquid template: same as `reading/graph.json` but sources `test_graph` and bakes `testCategory` into each node |
| `reading-test.html` | Unpublished page (`published: false`) at `/reading-test`; activates test mode |

### Running the test page

```bash
jbundle --unpublished
# visit: http://localhost:4000/reading-test/?testmode=1
```

`reading-test.html` is excluded from all production builds. GitHub Pages never sees it.

### Test mode (`?testmode=1`)

Test mode only changes node colors and tooltip text — no force parameters change. This means test-mode screenshots are direct evidence of force behavior.

Each node type gets a distinct color so misplaced nodes are immediately visible:

| Category | Test fill | Expected position |
| --- | --- | --- |
| Subcluster-only | purple (unchanged) | Inside their subcluster circle |
| Supercluster-only | red | Outer ring of supercluster, NOT inside any subcluster |
| Supercluster + subcluster | purple (unchanged) | Inside their subcluster (subcluster pull wins) |
| Dual-subcluster (same parent) | orange | Between the two sibling subcluster circles |
| Cross-supercluster bridge | magenta | Near the boundary between two superclusters |
| Free node (no tags / singleton) | cyan | Just outside nearest cluster circle |
| Own post | gold (unchanged) | Same as positional category |

Additional overlays:

| Overlay | What it reveals |
| --- | --- |
| Yellow stroke on node | Node has cross-cluster ref links pulling it across a boundary |
| Blue dashed circle | Supercluster boundary — should not overlap another blue circle |
| Red solid circle | Subcluster boundary — should not overlap a sibling red circle |

Tooltip additions in test mode: node's topological category, primary cluster, and cross-cluster ref count (with ⚠ if > 0).

### Test dataset

99 synthetic nodes in `_data/test_graph.yml` covering 23 node categories. Tag taxonomy:

```text
tech        (supercluster A)
├── frontend    (subcluster A1)
└── backend     (subcluster A2)

science     (supercluster B)
├── biology     (subcluster B1)
└── physics     (subcluster B2)

society     (supercluster C — single subcluster)
└── politics    (subcluster C1)

misc        (orphan cluster — only 2 nodes, no circle drawn)
```

Key stress-test patterns in the ref link topology:

- Supercluster-only nodes that ref subcluster nodes (primary boundary-crossing stress case)
- Cross-subcluster refs within the same supercluster
- Cross-supercluster refs
- Free nodes that ref clustered nodes (must not be pulled inside clusters)
- 1 high-backlink node with ≥ 7 inbound refs (tests largest radius class)
- Date range spanning 2022–2026 (exercises age desaturation scale)

### Human verification workflow

Take 3–4 settled screenshots to account for simulation randomness:

```bash
# Start site (if not already running):
jbundle --unpublished

# Production graph — multiple runs for stable layout check:
playwright-cli open http://localhost:4000/reading/
playwright-cli resize 1400 900
playwright-cli reload && sleep 5 && playwright-cli screenshot --filename .screenshot-tests/article-graph-settled-1.png
playwright-cli reload && sleep 5 && playwright-cli screenshot --filename .screenshot-tests/article-graph-settled-2.png

# Test mode — structural verification:
playwright-cli open "http://localhost:4000/reading-test/?testmode=1"
playwright-cli resize 1400 900
playwright-cli reload && sleep 5 && playwright-cli screenshot --filename .screenshot-tests/test-settled-1.png
playwright-cli reload && sleep 5 && playwright-cli screenshot --filename .screenshot-tests/test-settled-2.png
```

Screenshots are saved to `.screenshot-tests/` (gitignored).

### Production graph verification checklist

Check across multiple settled runs:

- [ ] Cluster circles visible with correct tag labels
- [ ] Nodes stay within graph bounds (no clipping)
- [ ] Dashed ref links connect the correct nodes
- [ ] Age color legend visible in bottom-left corner
- [ ] Cluster focus legend visible in bottom-right corner
- [ ] +/− zoom buttons visible in top-right corner
- [ ] No node groups escape to a corner or collapse into a pile across any run
- [ ] Free nodes float near clusters, not in distant corners

### Test mode verification checklist

- [ ] No red nodes (supercluster-only) are inside a red-bordered subcluster circle
- [ ] Orange nodes (dual-subcluster) sit in the gap between two sibling subcluster circles
- [ ] Magenta nodes (cross-supercluster bridge) sit near the boundary between superclusters
- [ ] Cyan nodes (free) park just outside cluster boundaries, not in distant corners
- [ ] Cyan nodes with yellow strokes have not been pulled inside any cluster
- [ ] No two blue dashed supercluster circles overlap
- [ ] No two red solid sibling subcluster circles overlap
- [ ] No simulation explosion across any run (no nodes at extreme positions)

---

## Visual Encoding Reference

### Node colors

- Own post: gold `#f0c060`
- Wikipedia article: grey `#888`
- External article: age-desaturated purple, base color `#7c6edb`

**Age desaturation** — saturation and lightness both vary across age brackets. Adjusting saturation alone is insufficient: low-saturation colors converge perceptually to an indistinguishable grey. Shifting lightness as well ensures each bracket is visually distinct even at very low saturation.

| Age | Saturation | Lightness |
| --- | --- | --- |
| < 1 month | 1.00 | 0.56 |
| 1–3 months | 0.80 | 0.62 |
| 3–6 months | 0.58 | 0.64 |
| 6–12 months | 0.36 | 0.64 |
| 12–24 months | 0.12 | 0.53 |
| 24+ months | 0.04 | 0.44 |

### Node radius

Radius scales with inbound reference count:

| Inbound refs | Radius (px) |
| --- | --- |
| 0 | 6 |
| 1 | 8 |
| 2–3 | 11 |
| 4–6 | 15 |
| 7+ | 20 |

### Reference edge style

Dashed white lines: `stroke: rgba(255,255,255,0.5)`, `stroke-width: 1.5`, `stroke-dasharray: 5 3`. Only drawn when both source and target nodes exist in the graph.

### Cluster color palette

16 perceptually-spread hues cycling from 0° to 337°, assigned to tags in order of first appearance:

```text
#d87878 #d89a6a #d8b86a #d0d06a #a8d86a #78d87a #6ad8a0 #6ad8c8
#6ac8d8 #6aa8d8 #6a80d8 #7a6ad8 #a06ad8 #c06ad8 #d86ac0 #d86a90
```

---

## Data Format Reference

`reading/graph.json` is a Liquid template rendered at build time. The JS fetches it at page load.

```json
{
  "nodes": [
    {
      "id": "https://example.com/article",
      "type": "article",
      "label": "Article Title",
      "author": "Author Name",
      "tags": ["tag-a", "tag-b"],
      "date": "2025-06-01",
      "blurb": "One-sentence description.",
      "self": false
    }
  ],
  "links": [
    { "source": "https://example.com/citing", "target": "https://example.com/cited", "type": "ref" }
  ]
}
```

Only `type: "ref"` links are generated. Domain nodes and domain links were removed as dead weight.

---

## Owned Files

These are the files that constitute the article graph feature. A change to any of these files should trigger a spec review.

| File | Role |
| --- | --- |
| `reading.html` | Jekyll page front matter — sets title, permalink `/reading`, graph data URL |
| `_layouts/reading.html` | Page layout: sidebar + title/subtitle + graph include + blogroll |
| `_includes/reading-graph.html` | The entire graph: HTML scaffold, D3 JavaScript, tooltip, legends |
| `_data/reading.yml` | Article data — the human-edited source of truth for graph content |
| `reading/graph.json` | Liquid template — transforms `reading.yml` into JSON at build time |
| `reading-test.html` | Unpublished test page (`published: false`) — uses synthetic data + test mode |
| `_data/test_graph.yml` | Synthetic 99-node dataset covering all topological edge cases |
| `reading/test-graph.json` | Liquid template for test data — adds `testCategory` field per node |
| `_includes/masthead.html` | Nav sidebar — contains the "reading" nav link |
