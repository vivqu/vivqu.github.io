# Article Graph — Force Layout Changes

## Problem

Nodes that belong only to a **parent tag** (e.g. `forecasting`-only) are drawn inside a **sub-cluster circle** they don't belong to (e.g. `skepticism`). Same issue for `open-source`-only nodes drifting inside `frameworks` or `agent-harness`.

The visual goal: nodes should sit inside the circle(s) for their own tags only. Parent-only nodes should occupy the ring between sub-cluster circles and the outer boundary of the parent circle.

## Why Previous Attempts Failed

Three forces compete for node position, and they are not balanced:

| Force | Strength | Effect |
|---|---|---|
| `forceLink` (distance 60, strength 0.8) | ~16–48 units | Pulls ref-linked nodes tightly together |
| Centroid pull (strength 0.08) | ~4–8 units | Pulls nodes toward their tag centroid |
| Cluster push / ring force (attempted) | ~3–7 units | Tried to push non-members outward |

`forceLink` is far stronger than anything added for cluster membership. Several `forecasting`-only articles reference `skepticism` articles that sit inside the `skepticism` sub-circle. The link force physically drags those forecasting-only nodes in, and no push force added was strong enough to overcome it without causing instability.

Specific attempts that were tried and reverted:

- **Centroid-to-centroid repulsion** — fixed major cluster group separation (open-source vs forecasting) but couldn't help the sub-cluster case since sharing-node pairs are skipped by design
- **Per-node push (quadratic formula)** — caused simulation explosions at high alpha; force grew as `overlap²`, too large for deep initial overlaps
- **Per-node push (linear formula)** — stable but lost to `forceLink` (~3 units push vs ~16 units link)
- **Ring orbital force** — elegant in theory (pull parent-only nodes to `targetR = 0.75 × circle.r`), but centroid pull + link force combined still dominated; nodes settled in the gap between sub-clusters rather than the outer ring

`forceCenter` made things worse: it shares momentum across all nodes, actively compressing both cluster groups toward the same viewport center.

## Proposed Changes

Three targeted changes that shift the force balance without adding exotic new forces.

### 1. Weaken `forceLink` and increase distance

```js
// Before
d3.forceLink(refLinks).id(d => d.id).distance(60).strength(0.8)

// After
d3.forceLink(refLinks).id(d => d.id).distance(120).strength(0.3)
```

At distance 120, strength 0.3: link force at 60px past target = `(60) × 0.3 = 18` units. But this only applies when nodes are more than 120px apart — nodes that are close (inside the cluster) feel near-zero link force. The dashed ref lines will be longer but still visually meaningful. The user confirmed "it's ok if the lines are very long" for cross-sub-cluster links.

### 2. Replace `forceCenter` with `forceX` + `forceY`

```js
// Before
d3.forceCenter(W / 2, H / 2).strength(0.15)

// After
d3.forceX(W / 2).strength(0.02)
d3.forceY(H / 2).strength(0.02)
```

`forceCenter` couples all nodes together — pulling one group toward center also pulls other groups. `forceX`/`forceY` applies independently per node. Very low strength (0.02) just prevents isolated nodes from escaping the viewport without compressing cluster groups together.

### 3. Strengthen centroid pull

```js
// Before (in clusterForce)
n.vx -= dx * alpha * 0.08;
n.vy -= dy * alpha * 0.08;

// After
const strength = ti === 0 ? 0.20 : 0.08; // primary tag vs secondary
n.vx -= dx * alpha * strength;
n.vy -= dy * alpha * strength;
```

At strength 0.20, a node 50px from its centroid gets `50 × 0.20 × alpha = 10 × alpha` pull. At alpha=0.5 that's 5 units — still less than link force, but combined with the weakened link (step 1) and no compressing center force (step 2), cluster membership should dominate placement.

## Expected Force Balance After Changes

At a typical mid-simulation alpha=0.5, for a `forecasting`-only node near the `skepticism` boundary:

- Centroid pull toward `forecasting` (50px away): `50 × 0.20 × 0.5 = 5 units`
- Link pull toward ref target inside `skepticism` (80px past target distance 120): `0` units (node is closer than the link distance — link pulls the other way, outward)
- Net: node stays in `forecasting` ring, link stretches to accommodate

The key insight: by increasing link distance to 120px, linked nodes that are 80–120px apart feel near-zero link force. The ref lines will be longer but the cluster membership forces will dominate placement.

## Test Plan

After implementing, run the settled-graph screenshot workflow (4 reloads, 5s wait each):

```bash
playwright-cli open http://localhost:4000/reading/
playwright-cli resize 1400 900
# repeat 4x:
playwright-cli reload && sleep 5 && playwright-cli screenshot --filename .screenshot-tests/article-graph-settled-N.png
```

Verify across all runs:
- `forecasting`-only nodes (e.g. "Could AI Slow Science?", "What If? AI in 2026") appear in the ring between `skepticism` and the outer `forecasting` boundary — not inside `skepticism`
- `open-source`-only nodes (Tailwind, Tldraw) appear in the ring between the sub-clusters and the outer `open-source` boundary
- The two major groups (`open-source` cluster and `skepticism/forecasting` cluster) remain separated with clear whitespace
- No simulation explosions across any of the 4 runs
