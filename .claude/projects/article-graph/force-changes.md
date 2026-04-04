# Article Graph — Force Layout Changes

## Problem

Nodes that belong only to a **parent tag** (e.g. `forecasting`-only) are drawn inside a **sub-cluster circle** they don't belong to (e.g. `skepticism`). Same issue for `open-source`-only nodes drifting inside `frameworks` or `agent-harness`.

The visual goal (see [fixes-for-clusters.png](fixes-for-clusters.png)):

- Sub-cluster circles within a supercluster do not overlap each other
- Supercluster-only nodes sit in the outer ring of the supercluster, away from sub-clusters
- Superclusters (major cluster groups) are close to each other but do not overlap
- Free nodes (no cluster membership) are pulled near the closest cluster boundary but stay outside it

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

Six targeted changes grouped by concern. Steps 1–3 rebalance the force magnitudes (prerequisite for everything else). Steps 4–6 implement the four layout goals from the diagram.

Apply in order — each step builds on the previous.

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

### 3. Strengthen centroid pull in `clusterForce`

```js
// Before (in clusterForce)
n.vx -= dx * alpha * 0.08;
n.vy -= dy * alpha * 0.08;

// After
const strength = ti === 0 ? 0.20 : 0.08; // primary tag vs secondary
n.vx -= dx * alpha * strength;
n.vy -= dy * alpha * strength;
```

At strength 0.20, a node 50px from its centroid gets `50 × 0.20 × alpha = 10 × alpha` pull. At alpha=0.5 that's 5 units — still less than link force alone, but combined with the weakened link (step 1) and no compressing center force (step 2), cluster membership should dominate placement.

**Verify after steps 1–3**: take settled screenshots. Cluster membership should be mostly correct before proceeding.

### 4. Subcluster circle separation

Sub-cluster circles within the same supercluster must not overlap. After each simulation tick, for every pair of sub-cluster circles that share a parent tag, push them apart if their edges are closer than a minimum gap.

```js
// After each tick, for each pair of sub-clusters (tagA, tagB) under the same parent:
const gap = 20; // minimum px between circle edges
const dist = Math.hypot(cx_B - cx_A, cy_B - cy_A);
const overlap = (r_A + r_B + gap) - dist;
if (overlap > 0 && dist > 0) {
  const nx = (cx_B - cx_A) / dist;
  const ny = (cy_B - cy_A) / dist;
  const push = overlap * 0.05 * alpha; // gentle, stable
  nodesInTag(tagA).forEach(n => { n.vx -= nx * push; n.vy -= ny * push; });
  nodesInTag(tagB).forEach(n => { n.vx += nx * push; n.vy += ny * push; });
}
```

Only push sub-clusters that share a parent. Completely separate top-level groups are handled by step 5.

**Verify after step 4**: `skepticism` and `forecasting` circles should not overlap; same for `frameworks` and `agent-harness`.

### 5. Supercluster proximity — attract without overlap

Major cluster groups should sit close (image shows them near but not touching). Add a centroid-to-centroid force between top-level cluster circles with both an attraction (when far) and a floor (when close enough):

```js
// After each tick, for each pair of top-level cluster circles (circleA, circleB):
const minDist = r_A + r_B + 40; // 40px gap minimum between edges
const dist = Math.hypot(cx_B - cx_A, cy_B - cy_A);
if (dist > minDist) {
  // attract: pull both groups toward each other
  const nx = (cx_B - cx_A) / dist;
  const ny = (cy_B - cy_A) / dist;
  const pull = (dist - minDist) * 0.015 * alpha;
  nodesInCluster(clusterA).forEach(n => { n.vx += nx * pull; n.vy += ny * pull; });
  nodesInCluster(clusterB).forEach(n => { n.vx -= nx * pull; n.vy -= ny * pull; });
} else if (dist < minDist && dist > 0) {
  // repel if somehow overlapping
  const nx = (cx_B - cx_A) / dist;
  const ny = (cy_B - cy_A) / dist;
  const push = (minDist - dist) * 0.05 * alpha;
  nodesInCluster(clusterA).forEach(n => { n.vx -= nx * push; n.vy -= ny * push; });
  nodesInCluster(clusterB).forEach(n => { n.vx += nx * push; n.vy += ny * push; });
}
```

"Top-level clusters" = tags that have ≥1 sub-cluster or ≥3 member nodes (i.e. tags that get a visible circle drawn).

**Verify after step 5**: the two major cluster groups should be visibly closer than before but with a clear gap between them.

### 6. Ring orbital force and free-node attraction

With step 1 weakening `forceLink`, the ring orbital approach that failed before should now work.

**Supercluster-only nodes** (node's primary tag is the supercluster tag, and that tag has sub-clusters): pull toward a target radius in the outer ring rather than toward the centroid.

```js
const targetR = 0.75 * superclusterCircle.r;
const currentR = Math.hypot(n.x - cx, n.y - cy);
if (currentR > 0) {
  // pull = positive when outside ring (bring in), negative when inside (push out)
  const pull = (currentR - targetR) * 0.10 * alpha;
  n.vx -= (n.x - cx) / currentR * pull;
  n.vy -= (n.y - cy) / currentR * pull;
}
```

**Free nodes** (no tags, or all tags have only 1 article so no circle is drawn): find the nearest cluster circle and pull toward a point just outside its boundary.

```js
let nearestCircle = null, nearestDist = Infinity;
for (const [tag, circle] of Object.entries(clusterCircles)) {
  const d = Math.hypot(n.x - circle.cx, n.y - circle.cy);
  if (d < nearestDist) { nearestDist = d; nearestCircle = circle; }
}
if (nearestCircle) {
  const targetDist = nearestCircle.r + 30; // just outside the boundary
  const pull = (nearestDist - targetDist) * 0.04 * alpha;
  if (nearestDist > 0) {
    n.vx -= (n.x - nearestCircle.cx) / nearestDist * pull;
    n.vy -= (n.y - nearestCircle.cy) / nearestDist * pull;
  }
}
```

The sign of `pull` is naturally correct: if the node is farther than `targetDist`, pull is positive (attracts inward toward the boundary); if closer, pull is negative (repels outward), preventing the node from entering the circle.

**Verify after step 6**: supercluster-only nodes should appear in the outer ring away from sub-clusters; free nodes should park just outside the nearest cluster circle.

## Expected Force Balance After All Changes

At a typical mid-simulation alpha=0.5, for a `forecasting`-only node near the `skepticism` boundary:

- Centroid pull toward `forecasting` centroid (50px away): `50 × 0.20 × 0.5 = 5 units`
- Ring orbital pull toward outer ring: `(currentR − targetR) × 0.10 × 0.5 ≈ 2–4 units` depending on position
- Link pull toward ref target inside `skepticism` (node is within 120px of target): `≈ 0 units` — node is closer than the link rest length, so link force pushes outward
- Subcluster separation push (if circles overlap): `overlap × 0.05 × 0.5`
- Net: node drifts to `forecasting` outer ring; ref line stretches to accommodate

For a free node near the `open-source` cluster:

- Free-node attraction toward cluster boundary: `(dist − targetDist) × 0.04 × 0.5`
- forceX/forceY centering: 0.02 — too weak to fight the attraction
- No centroid pull, no link force
- Net: node parks just outside the `open-source` circle edge

## Test Plan

After implementing all steps, run the settled-graph screenshot workflow (4 reloads, 5s wait each):

```bash
playwright-cli open http://localhost:4000/reading/
playwright-cli resize 1400 900
# repeat 4x:
playwright-cli reload && sleep 5 && playwright-cli screenshot --filename .screenshot-tests/article-graph-settled-N.png
```

Verify across all runs:

- `forecasting`-only nodes (e.g. "Could AI Slow Science?", "What If? AI in 2026") appear in the ring between `skepticism` and the outer `forecasting` boundary — not inside `skepticism`
- `open-source`-only nodes (Tailwind, Tldraw) appear in the ring between sub-clusters and the outer `open-source` boundary
- `skepticism` and `forecasting` sub-circles do not overlap (clear gap between edges)
- `frameworks` and `agent-harness` sub-circles do not overlap
- The two major cluster groups are visibly closer than before but maintain a clear gap — no overlap between the group circles
- Free/untagged nodes float just outside the boundary of the nearest cluster circle
- No simulation explosions across any of the 4 runs
- All clusters remain on-screen with no runaway nodes
