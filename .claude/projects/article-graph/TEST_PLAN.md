# Article Graph — Test Plan

## Overview

Two deliverables:

1. **`_data/test_graph.yml`** — 99 synthetic nodes covering every topological edge case
2. **Test mode** (`?testmode=1`) — color-coded visualization to verify force behavior without hunting through screenshots

The test dataset uses three superclusters with controlled ref link patterns designed to stress-test each of the proposed force changes in isolation. Test mode makes misplaced nodes immediately visible.

---

## Part 1: Test Dataset (`_data/test_graph.yml`)

### Tag Taxonomy

```none
tech        (supercluster A)
├── frontend    (subcluster A1, ≥4 nodes)
└── backend     (subcluster A2, ≥4 nodes)

science     (supercluster B)
├── biology     (subcluster B1, ≥4 nodes)
└── physics     (subcluster B2, ≥4 nodes)

society     (supercluster C — single-subcluster case)
└── politics    (subcluster C1, ≥4 nodes)
   [intentionally no second subcluster — tests simpler layout]

misc        (no-circle tag — only 2 articles, never gets a cluster circle)
```

The YAML data file is loaded by setting `data_file: test_graph` in the graph page front matter (see implementation note at bottom).

### Edge Case Matrix

| # | Category | Tags | Count | Expected position | Test color |
|---|---|---|---|---|---|
| 1 | Subcluster-only node | `[frontend]` | 6 | Inside A1 circle | Purple (default) |
| 2 | Subcluster-only node | `[backend]` | 6 | Inside A2 circle | Purple (default) |
| 3 | Subcluster-only node | `[biology]` | 5 | Inside B1 circle | Purple (default) |
| 4 | Subcluster-only node | `[physics]` | 5 | Inside B2 circle | Purple (default) |
| 5 | Subcluster-only node | `[politics]` | 5 | Inside C1 circle | Purple (default) |
| 6 | Supercluster-only node | `[tech]` | 8 | **Outer ring of A, not inside A1/A2** | **Red** |
| 7 | Supercluster-only node | `[science]` | 8 | **Outer ring of B, not inside B1/B2** | **Red** |
| 8 | Supercluster-only node | `[society]` | 6 | **Outer ring of C, not inside C1** | **Red** |
| 9 | Supercluster + subcluster | `[tech, frontend]` | 4 | Inside A1 (subcluster wins) | Purple (default) |
| 10 | Supercluster + subcluster | `[tech, backend]` | 4 | Inside A2 (subcluster wins) | Purple (default) |
| 11 | Supercluster + subcluster | `[science, biology]` | 4 | Inside B1 | Purple (default) |
| 12 | Supercluster + subcluster | `[science, physics]` | 4 | Inside B2 | Purple (default) |
| 13 | Supercluster + subcluster | `[society, politics]` | 4 | Inside C1 | Purple (default) |
| 14 | Dual-subcluster (same supercluster) | `[frontend, backend]` | 4 | **Between A1 and A2, inside A** | **Orange** |
| 15 | Dual-subcluster (same supercluster) | `[biology, physics]` | 4 | **Between B1 and B2, inside B** | **Orange** |
| 16 | Cross-supercluster bridge | `[tech, science]` | 4 | **At boundary between A and B superclusters** | **Magenta** |
| 17 | Cross-supercluster bridge | `[science, society]` | 4 | **At boundary between B and C** | **Magenta** |
| 18 | Cross-supercluster bridge | `[tech, society]` | 4 | **At boundary between A and C** | **Magenta** |
| 19 | Free node (no tags) | `[]` | 5 | **Just outside nearest cluster circle** | **Cyan** |
| 20 | Free node (singleton tag) | `[misc]` | 2 | **Just outside nearest cluster circle** | **Cyan** |
| 21 | Own post in subcluster | `[frontend]` (self) | 1 | Inside A1 | Gold (default) |
| 22 | Own post, supercluster-only | `[tech]` (self) | 1 | **Outer ring of A** | Gold + red stroke |
| 23 | Own post, free | `[]` (self) | 1 | **Just outside nearest cluster** | Gold + cyan stroke |

**Total: 99 nodes**

### Ref Link Topology

Ref links are the primary source of force-balance problems. The following patterns are intentionally included:

**Within-subcluster refs** (baseline, should work fine):

- 3 frontend → frontend refs
- 3 biology → biology refs

**Cross-subcluster refs within same supercluster** (medium stress):

- 2 frontend → backend refs (forceLink pulls across A1/A2 boundary)
- 2 biology → physics refs

**Supercluster-only → subcluster refs** (primary stress test — this is the bug case):

- 4 `[tech]`-only nodes ref `[frontend]` nodes — these nodes must NOT end up inside A1
- 4 `[science]`-only nodes ref `[biology]` nodes — must NOT end up inside B1
- 2 `[society]`-only nodes ref `[politics]` nodes

**Cross-supercluster refs** (secondary stress test):

- 3 refs from tech nodes → science nodes
- 2 refs from science nodes → society nodes
- 1 ref from frontend → biology (maximally cross-cluster)

**Free node refs**:

- 2 free nodes ref clustered nodes (should not pull free nodes into clusters)
- 1 clustered node refs a free node

**High-backlink node** (tests backlink-based sizing):

- 1 `[frontend]` node is referenced by 7+ other nodes → gets the largest radius class

### YAML Format (representative examples per category)

```yaml
# ─── SUBCLUSTER-ONLY (category 1-5) ─────────────────────────────────────────
# Expected: inside their subcluster circle. Baseline — if these drift, forces are broken.

- title: "Frontend Fundamentals 1"
  url: "https://example.com/frontend-1"
  author: "Test Author"
  domain: example.com
  tags: [frontend]
  date: "2024-01-15"
  blurb: "Test node: subcluster-only (frontend). Should be inside the frontend circle."
  refs: []

- title: "Backend Basics 1"
  url: "https://example.com/backend-1"
  author: "Test Author"
  domain: example.com
  tags: [backend]
  date: "2024-02-10"
  blurb: "Test node: subcluster-only (backend). Should be inside the backend circle."
  refs: []

# ─── SUPERCLUSTER-ONLY (category 6-8) ────────────────────────────────────────
# Expected: outer ring of their supercluster, NOT inside any subcluster.
# Test color: RED. If you see red nodes inside a subcluster circle, the fix is incomplete.

- title: "Tech Overview 1"
  url: "https://example.com/tech-1"
  author: "Test Author"
  domain: example.com
  tags: [tech]
  date: "2024-03-01"
  blurb: "Test node: supercluster-only (tech). Must NOT appear inside frontend or backend."
  refs: []

- title: "Tech Overview 2 (refs frontend)"
  url: "https://example.com/tech-2"
  author: "Test Author"
  domain: example.com
  tags: [tech]
  date: "2024-03-05"
  blurb: "Test node: supercluster-only with cross-subcluster ref. Primary stress-test case."
  refs: ["https://example.com/frontend-1"]  # ref to subcluster node — must not get dragged in

# ─── DUAL-SUBCLUSTER (category 14-15) ────────────────────────────────────────
# Expected: between the two subcluster circles, inside the supercluster.
# Test color: ORANGE. If orange nodes are fully inside one subcluster, centroid pull is unbalanced.

- title: "Full Stack 1"
  url: "https://example.com/fullstack-1"
  author: "Test Author"
  domain: example.com
  tags: [frontend, backend]
  date: "2024-04-01"
  blurb: "Test node: dual-subcluster (frontend + backend). Should sit between A1 and A2."
  refs: []

# ─── CROSS-SUPERCLUSTER BRIDGE (category 16-18) ──────────────────────────────
# Expected: near the boundary between two superclusters, possibly partially in both.
# Test color: MAGENTA.

- title: "Tech-Science Bridge 1"
  url: "https://example.com/bridge-tech-science-1"
  author: "Test Author"
  domain: example.com
  tags: [tech, science]
  date: "2024-05-01"
  blurb: "Test node: cross-supercluster bridge (tech + science). Should sit between A and B."
  refs: []

# ─── FREE NODES (category 19-20) ─────────────────────────────────────────────
# Expected: just outside the boundary of the nearest cluster circle.
# Test color: CYAN. If cyan nodes are far away in a corner, the free-node attraction is broken.

- title: "Untagged Article 1"
  url: "https://example.com/free-1"
  author: "Test Author"
  domain: example.com
  tags: []
  date: "2024-06-01"
  blurb: "Test node: free (no tags). Should park just outside the nearest cluster circle."
  refs: []

- title: "Misc Article 1"
  url: "https://example.com/misc-1"
  author: "Test Author"
  domain: example.com
  tags: [misc]   # only 2 nodes with this tag — no circle will be drawn
  date: "2024-06-10"
  blurb: "Test node: singleton-tag (misc). Visually identical to free node."
  refs: []

# ─── OWN POSTS (category 21-23) ──────────────────────────────────────────────
# Expected: same positions as their category above; gold fill distinguishes them.
# In test mode: also gets a colored ring stroke matching their positional category.

- title: "My Frontend Post"
  url: "/blog/my-frontend-post"
  author: "me"
  domain: self
  tags: [frontend]
  date: "2024-07-01"
  blurb: "Own post in subcluster. Gold fill, no extra stroke in test mode."
  refs: []

- title: "My Tech Overview Post"
  url: "/blog/my-tech-overview"
  author: "me"
  domain: self
  tags: [tech]
  date: "2024-07-15"
  blurb: "Own post, supercluster-only. Gold fill + red stroke in test mode."
  refs: []

# ─── HIGH-BACKLINK NODE (for sizing test) ─────────────────────────────────────
# This node is referenced by 7+ others — should render at the largest radius class (r=20).
# All ref sources should list this URL in their refs: list.

- title: "The Canonical Frontend Reference"
  url: "https://example.com/canonical-frontend"
  author: "Test Author"
  domain: example.com
  tags: [frontend]
  date: "2023-01-01"
  blurb: "Test node: high-backlink hub. Should be the largest node in the frontend cluster."
  refs: []
```

### Node Count Summary

| Supercluster | Nodes | Supercluster-only (RED) | Subcluster nodes | Dual-subcluster (ORANGE) |
|---|---|---|---|---|
| tech (A) | 32 | 8 | A1: 10, A2: 10 | 4 (frontend+backend) |
| science (B) | 30 | 8 | B1: 9, B2: 9 | 4 (biology+physics) |
| society (C) | 15 | 6 | C1: 9 | — |
| Bridge nodes | 12 | — | — | — |
| Free nodes | 7 | — | — | — |
| Own posts | 3 | — | — | — |
| **Total** | **99** | **22** | | **8** |

---

## Part 2: Test Mode Visualization

### Activation

Enable with the URL parameter `?testmode=1`:

```
http://localhost:4000/reading/?testmode=1
```

The JS at the top of the graph script reads:

```js
const TEST_MODE = new URLSearchParams(location.search).get('testmode') === '1';
```

In production (`reading.yml`), all test mode code is inert — no behavior change.

### Node Fill Colors

Nodes are classified at load time based on tag membership. Classification runs once after `graph.json` is parsed, before the simulation starts.

| Category | Production fill | Test mode fill | What to check |
|---|---|---|---|
| Subcluster-only | `#7c6edb` (purple) | `#7c6edb` (unchanged) | Inside their subcluster circle |
| Supercluster-only | `#7c6edb` (purple) | **`#e05555` (red)** | In outer ring, NOT inside any subcluster |
| Supercluster + subcluster | `#7c6edb` (purple) | `#7c6edb` (unchanged) | Inside their subcluster (tag[1] wins) |
| Dual-subcluster (same parent) | `#7c6edb` (purple) | **`#e08020` (orange)** | Between the two subcluster circles |
| Cross-supercluster bridge | `#7c6edb` (purple) | **`#c040c0` (magenta)** | Near boundary between superclusters |
| Free node (no tags / singleton) | `#7c6edb` (purple) | **`#40c0e0` (cyan)** | Just outside nearest cluster circle |
| Own post | `#f0c060` (gold) | `#f0c060` (unchanged) | Same as positional category |

### Node Stroke Overlay (test mode only)

In addition to fill, add a stroke ring to highlight structural properties that cut across position categories:

| Condition | Stroke color | Stroke width | What it reveals |
|---|---|---|---|
| Has at least one cross-cluster ref link | `#f0e040` (yellow) | 2.5px | Which nodes are being pulled by forceLink across cluster boundaries — the primary drag culprits |
| Own post in supercluster-only position | `#e05555` (red) | 2px | Gold node that should also be in outer ring |
| Own post in free-node position | `#40c0e0` (cyan) | 2px | Gold node that should park outside clusters |

"Cross-cluster ref" = the ref target is in a different tag cluster than the source node's primary tag.

### Cluster Circle Outlines (test mode only)

Replace the normal semi-transparent filled circles with clearly bordered outlines:

| Circle type | Normal style | Test mode style |
|---|---|---|
| Supercluster circle | Semi-transparent fill, soft stroke | No fill, `#4a80e0` (blue) stroke, 2px dashed |
| Subcluster circle | Semi-transparent fill, soft stroke | No fill, `#e04a4a` (red) stroke, 2px solid |

This makes the circle hierarchy immediately legible — blue = supercluster boundary, red = subcluster boundary.

### Tooltip Additions (test mode only)

Append a "test info" section to the hover tooltip showing:

```
── test info ──
category: supercluster-only
primary cluster: tech
forces acting: centroid-pull (tech), ring-orbital
ref links: 2 outgoing (1 cross-cluster ⚠)
```

The cross-cluster ref warning (`⚠`) makes it easy to identify which specific ref links are fighting the cluster forces.

### Classification Logic

```js
// Classify each node for test mode coloring
function classifyNode(d, clusterMeta) {
  if (d.self) return 'own-post'; // handle separately — apply positional stroke
  const tags = d.tags || [];
  if (tags.length === 0) return 'free';

  const superclusters = tags.filter(t => clusterMeta[t]?.isSuper);
  const subclusters   = tags.filter(t => clusterMeta[t]?.isSub);

  if (superclusters.length >= 2) return 'bridge';           // spans 2 superclusters
  if (subclusters.length  >= 2 &&
      subclusters.every(t => clusterMeta[t].parent === subclusters[0] &&
                             clusterMeta[t].parent === clusterMeta[subclusters[1]].parent))
    return 'dual-subcluster';                               // 2 subclusters, same parent
  if (superclusters.length === 1 && subclusters.length === 0)
    return 'supercluster-only';                             // outer ring case
  if (subclusters.length >= 1) return 'subcluster';        // normal subcluster member
  return 'free';                                            // singleton tag, no circle
}

const TEST_COLORS = {
  'subcluster':         '#7c6edb',
  'supercluster-only':  '#e05555',
  'dual-subcluster':    '#e08020',
  'bridge':             '#c040c0',
  'free':               '#40c0e0',
  'own-post':           '#f0c060',
};
```

`clusterMeta` is derived from the cluster circle computation that already runs — each tag gets `{ isSuper, isSub, parent }` flags based on whether it contains other cluster circles.

---

## Verification Checklist

After implementing the force changes, take 4 settled screenshots in test mode:

```bash
playwright-cli open "http://localhost:4000/reading/?testmode=1"
playwright-cli resize 1400 900
playwright-cli reload && sleep 5 && playwright-cli screenshot --filename .screenshot-tests/test-settled-1.png
playwright-cli reload && sleep 5 && playwright-cli screenshot --filename .screenshot-tests/test-settled-2.png
playwright-cli reload && sleep 5 && playwright-cli screenshot --filename .screenshot-tests/test-settled-3.png
playwright-cli reload && sleep 5 && playwright-cli screenshot --filename .screenshot-tests/test-settled-4.png
```

Check each screenshot:

**Red nodes (supercluster-only):**

- [ ] No red nodes are fully inside a red-bordered (subcluster) circle
- [ ] Red nodes cluster in the visible ring between the subcluster circles and the blue supercluster boundary
- [ ] Red nodes with yellow strokes (cross-cluster refs) are especially visible — they must still be outside subclusters despite the ref pull

**Orange nodes (dual-subcluster):**

- [ ] Orange nodes sit in the gap/intersection zone between two sibling subcluster circles
- [ ] They are not fully consumed by either one circle

**Magenta nodes (cross-supercluster bridge):**

- [ ] Magenta nodes sit near the edge of at least one supercluster circle
- [ ] They are not deeply interior to either supercluster

**Cyan nodes (free):**

- [ ] Cyan nodes are not scattered into corners of the viewport
- [ ] Each cyan node is visibly near (but outside) the boundary of the closest blue supercluster circle
- [ ] Cyan nodes with yellow strokes (refs to clustered nodes) have not been pulled inside the cluster

**Blue circles (superclusters):**

- [ ] Supercluster circles are visibly close to at least one other supercluster circle
- [ ] No two blue supercluster circles overlap

**Red circles (subclusters):**

- [ ] Subcluster circles within the same supercluster do not overlap each other

**Stability:**

- [ ] No node group escapes to a viewport corner across any of the 4 runs
- [ ] No simulation explosions (nodes at infinity / NaN positions)

---

## Implementation Notes

### Excluding the test page from production builds

Use Jekyll's built-in `published: false` front matter on `reading-test.html`:

```yaml
---
layout: reading
title: Reading (test)
published: false
data_file: test_graph
---
```

Jekyll will **not render this page at all** when `published: false` — it won't appear in `_site/`, won't be deployed to GitHub Pages, and won't be discoverable. No extra config or build flag needed for production.

To access it during local development, pass `--unpublished` to Jekyll:

```bash
bundle exec jekyll serve --unpublished
```

Then visit `http://localhost:4000/reading-test/?testmode=1`. The `--unpublished` flag only affects local dev — GitHub Pages always builds without it.

### Loading the test dataset

Use a `data_file` front matter key to select which data file to load:

```yaml
---
layout: reading
title: Reading (test)
published: false
data_file: test_graph   # loads _data/test_graph.yml
---
```

The `reading/graph.json` Liquid template reads:

```liquid
{% assign articles = site.data[page.data_file] | default: site.data.reading %}
```

The production `reading.html` omits `data_file`, so `default: site.data.reading` kicks in and nothing changes for the production build.

### Test mode is purely visual

Test mode only changes colors and tooltip text. It does not alter any force parameters, simulation behavior, or graph structure. This means screenshots taken in test mode are direct evidence of whether the force changes achieved the correct layout.

---

## Implementation Checklist

Complete these in order before making any further cluster layout changes.

### 1. Test dataset

- [x] Create `_data/test_graph.yml` with all 99 nodes per the edge case matrix above
  - [x] All 23 node categories represented (supercluster-only, dual-subcluster, bridge, free, own-post variants, etc.)
  - [x] Ref link topology from the "Ref Link Topology" section: within-subcluster, cross-subcluster, supercluster-only → subcluster (primary stress case), cross-supercluster, free node refs
  - [x] 1 high-backlink node (≥7 inbound refs) to test radius scaling
  - [x] Date range spanning 2022–2026 to exercise the age desaturation scale

### 2. Test data template

- [x] Create `reading/test-graph.json` — Liquid template identical to `reading/graph.json` but with `{% assign articles = site.data.test_graph %}` hardcoded at the top (no `data_file` indirection needed here)

### 3. Test page

- [x] Create `reading-test.html` at repo root with:
  - `published: false` front matter
  - `data_file: test_graph` front matter
  - All other front matter identical to `reading.html`
  - Graph JS loads from `/reading/test-graph.json` instead of `/reading/graph.json`

### 4. Node classification

- [x] Bake `testCategory` into each node at build time in `reading/test-graph.json` (Liquid)
  - Hardcoded tag hierarchy in the template: superclusters = `tech, science, society`; subclusters = `frontend, backend, biology, physics, politics`
  - Classification logic runs per-article in Liquid: counts supercluster and subcluster tag matches, assigns one of `subcluster`, `supercluster-only`, `dual-subcluster`, `bridge`, `free`, `own-post`
  - Result emitted as `"testCategory"` field on each node in the JSON
  - No runtime JS inference needed — graph JS just reads `d.testCategory` directly
  - Verified counts match test plan: 47 subcluster, 22 supercluster-only, 8 dual-subcluster, 12 bridge, 7 free, 3 own-post (99 total)

### 5. Test mode node colors

- [x] Added `const TEST_MODE = new URLSearchParams(location.search).get('testmode') === '1'`
- [x] `TEST_COLORS` map keyed by `testCategory` (read from JSON, no runtime inference)
- [x] Node fill: `d.self ? OWN_COL : TEST_COLORS[d.testCategory]` when `TEST_MODE`; production `nodeColor(d)` otherwise
- [x] Own posts: gold fill + `TEST_OWN_STROKE` colored stroke (red for `supercluster-only`, cyan for `free`, none for `subcluster`)
- [x] Also updated `test-graph.json` Liquid: removed `own-post` from classification so `testCategory` always reflects positional category; `d.self` flag handles gold fill separately
- [x] Verified: all 99 nodes render with correct colors (47 purple, 22 red, 8 orange, 12 magenta, 7 cyan, 3 gold)

### 6. Test mode ref link colors

- [ ] In test mode, color ref link lines yellow (`#f0e040`) when the link crosses a cluster boundary (source and target have different primary tags or one is free)
- [ ] Normal white dashed style for within-cluster refs

### 7. Test mode cluster circle styles

- [ ] In test mode, replace semi-transparent filled circles with outlined circles:
  - Supercluster circles: `#4a80e0` (blue), 2px dashed stroke, no fill
  - Subcluster circles: `#e04a4a` (red), 2px solid stroke, no fill
- [ ] Apply only when `TEST_MODE` is true; production styles unchanged

### 8. Test mode tooltip additions

- [ ] In test mode, append a `── test info ──` section to the hover tooltip showing:
  - `category:` (e.g. `supercluster-only`)
  - `primary cluster:` (the first supercluster tag, if any)
  - `cross-cluster refs:` count with `⚠` if > 0

### 9. Screenshot verification

- [ ] Run `bundle exec jekyll serve --unpublished`
- [ ] Delete stale test screenshots: `rm -f .screenshot-tests/test-*.png`
- [ ] Open `http://localhost:4000/reading-test/?testmode=1` in playwright
- [ ] Take 4 settled screenshots (reload + 5s wait each) and verify the full checklist in the Verification Checklist section above
