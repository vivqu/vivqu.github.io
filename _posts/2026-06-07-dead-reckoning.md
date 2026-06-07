---
title: "The problem with dead reckoning"
subtitle: "Navigating uncharted waters to build a cool little tool"
published: true
source: false
seo_description: "mobile-apps agentic-coding workflows"
tags: work tech reading
image: assets/img/posts/dead-reckoning/turner-ship.jpg
read_time: 14 min
---

<img class="banner-image" src="/assets/img/posts/dead-reckoning/turner-ship.jpg" />
<em>"Snow Storm" by J.M. Turner (from <a href="https://www.tate.org.uk/art/artworks/turner-snow-storm-steam-boat-off-a-harbours-mouth-n00530" target="_blank">Tate Collection</a>)</em>
<br />

I've built a little side project that solves a personal pain point. I call it my **AI reading graph** and you can find it [here](/reading).

<br />
![reading-graph](/assets/img/posts/dead-reckoning/reading-graph.png)
*Snapshot of my reading graph on June 7th, you can see the live version <a href="/reading">here</a>.*
<br />

The inspiration for the project came from simple frustration: it's hard keeping up with AI progress even if you are on top of your reading. There is so much new content constantly coming out, from frontier research developments to systematic evaluations of AI capabilities to hot takes on the best ways to use agents. Even though I have a battle-tested [information delivery system](/blog/2026/01/12/reading-habit/), it's been absolutely flooded with technical writing on AI. (Sometimes I shudder when I open my Instapaper and have to quickly scroll past all the AI thinkpieces to give myself a break.) And for the pieces I've already read, it's hard to keep track and process how the discussions intersect in meaningful ways.

So the idea was simple: I wanted a tool to visualize my reading on AI over time. I have always been a huge fan of [d3](), a dataviz library created by a [Mike Bostock](https://www.reddit.com/r/dataisbeautiful/comments/3k3if4/hi_im_mike_bostock_creator_of_d3js_and_a_former/) that can be used to build anything from serious science infographics to [visualizing every line in the Hamilton musical](https://pudding.cool/2017/03/hamilton/). The sky is the limit with how clever and creative you can be with showcasing data, just see the posts in [r/dataisbeautiful](). But it has always felt too difficult and time-consuming for me to learn the ins-and-outs of the framework.

So here was my chance to throw coding agents at the problem! I had a clear concept of the tool I wanted and d3 has a rich, vibrant [open source community](https://github.com/wbkd/awesome-d3) as well as clear [accessible documentation](https://observablehq.com/@d3/gallery?utm_source=d3js-org&utm_medium=hero&utm_campaign=try-observable) for the agent to reference. I also had the [mental commitment](https://thoughts.hmmz.org/2026-05-31.html) to shape, refine, and use this tool on an ongoing basis. No brainer right?

Well, yes and no. Like [everything](/blog/2026/05/24/building-ios-apps-with-agents/) [else](/blog/2025/11/30/vibe-coding-setup/) I've experienced with AI, there were very impressive moments mixed in with times where it fell on its face. But without it, this would not have existed, so we can count this as a win!

<br />
# What it does

The reading graph is made up of content nodes which represent links to specific articles, essays, or papers on AI. You can hover over a node to see more details on the piece. Clicking on the node takes you directly to the source. Each node is colored based on when it was published, so you can easily see which articles are recent and which are older. Nodes can link to each other, which is represented by a dotted line between nodes. The article being referenced (the "sink") is larger in size, indicating that being referenced by the other node (the "source").

<br />
![link-refs](/assets/img/posts/dead-reckoning/link-refs.png)
*Particularly popular or noteworthy articles have a lot of references/citations.*
<br />

The visuals of a graph with connected nodes was inspired by the [Obsidian graph view](https://obsidian.md/help/plugins/graph), which visualizes the relationships between notes in your collection. Lines here represent internal links between two notes.

<br />
![obsidian-graph](/assets/img/posts/dead-reckoning/obsidian-graph.png)
*If my reading graph ever ends up having the same number of nodes as my Obsidian notes, we might have a problem.*
<br />

Nodes are clustered by categories or themes. The graph supports two levels of grouping, which I call "superclusters" and "subclusters." I don't support more than two levels of clustering because the graph ends up being too messy. 

Subclusters can overlap if they share common nodes. There can also be "orphan nodes" and "orphan clusters" if there are no nodes or other clusters which share the same tags.

<br />
![zooming-cluter](/assets/img/posts/dead-reckoning/zooming-cluster.gif)
*Zooming in closer will cause the node titles to appear.*
<br />

The graph is dynamically generated based on simulated physics parameters which push and pull nodes closer together or farther apart, which means that the final graph shape varies based on each page load. It's also interactive! You can pull on individual nodes and drag them around. I didn't originally intend for nodes to be interactable like this--it was simply a cool side effect of using d3's rendering system.

<br />
![graph-interaction](/assets/img/posts/dead-reckoning/graph-interaction.gif)
*Pulling the nodes around doesn't really do anything, it's just fun.*
<br />

I wanted to do something similar to explore various ways of visually representing and conceptually classifying my reading on AI. The grouping and coloring based on recency already has been really helpful to reflect areas of my own interests. 

I also added nodes representing my own writing, shown in gold, so that I can also see where I have contributed to the discourse. The visualization will also help me generate future ideas on what to think more about and write on, since I can see a dense concentration of nodes in one specific cluster.

<br />
![vivian-nodes](/assets/img/posts/dead-reckoning/vivian-nodes.png)
*It's probably a little arrogant to graph my own writing.*
<br />

The graph also adapts to small screen sizes by automatically hiding or transforming the legends. It also compensates for lack of hover on mobile devices by showing touch affordances instead.

<br />
![mobile-graph](/assets/img/posts/dead-reckoning/mobile-graph.png)
*Cluster-only legend on iPhone 14 Pro Max. Minimized legend and button to open links on the node tooltips for iPad Air.*
<br />

The code is all publically accessible. You can read/clone/remix it [here](https://github.com/vivqu/vivqu.github.io/blob/master/.claude/projects/article-graph/SPEC.md).

Now let's get into how I built it!

<br />
# Coding without a human navigator?

Overall this project was assembled in three days, hacked together in afternoons during the long Easter weekend holiday. We were staying in Cornwall and driving around countryside to visit [gardens](https://www.heligan.com/) and [biodomes](https://www.edenproject.com/). It was fun to create this tool during downtime between active exploration and evening relaxation time with my husband and dog.

I was heavily involved throughout the code generation process, also known as "human in the loop" development with coding agents. I was unfortunately **not** able to disconnect and let the coding agents run completely autonomously for the bulk of the project while I went out adventuring. 

If we use the analogy of sailing a ship, the human was firmly in the navigator's seat the whole time.

Let's get into why this was the case.

<br />

# Charting our journey

Building this tool fell into three distinct phases: (1) planning and basic scaffolding, (2) supervised problem-solving, and (3) autonomous last mile improvements.

Human supervision was required for both the initial planning and the supervised problem-solving stages, where I heavily troubleshooted the graph interactions, which ended up taking the bulk of project time.

<br />
**Phase 1 (Planning and Basic Scaffolding)**: involved iterating with the coding agent (Claude Code running Opus 4.7) on a PLAN.md for execution and setting up the initial code structure with a small set of real content nodes. Overall, this phase took 2.5 hours to have the agent research the d3 libraries, manually find reference visualizations to use as references to the plan, mock up my intended UX, and prompt the agent to set up the scaffolding for the tool. At this point, it looked great for our small set of nodes.

<br />
![plan-to-initial](/assets/img/posts/dead-reckoning/plan-to-initial.png)
*The initial mock design versus the initial scaffold with some minimal graph data.*
<br />

**Phase 2 (Supervised Problem-Solving)**: here I was carefully watching the agent while we tried to scale up the number of nodes and substructures (clusters, reference links) that might exist in the future. The physics simulation needed to be surprisingly complex in order to achieve the intended outcome. This required nuanced understanding of how d3 graphing logic worked. Human-in-the-loop was necessary to explore the problem space with the agent and direct it to fix the underlying problems correctly. Frequently the agent went down deep rabbit holes or got stuck in reasoning loops that it couldn't break out of, despite being an overall capable model. I had to intervene constantly in order to direct it to a simpler hypothesis or more obvious solution. 

<br />
![exploded-graph-small](/assets/img/posts/dead-reckoning/exploded-graph-small.png)
*Trying to enforce certain requirements (like superclusters never overlapping) resulted in horrible end states for the graph.*
<br />


**Phase 3 (Autonomous Last Mile Improvements)**: After we solved the core physics logic, the rest of the tool could be built autonomously by the agent. This phase was the most "AI native" of the entire project. I still needed to discover and call out product and UX gaps that existed, but otherwise the coding agent could resolve all the issues once identified.

<br />
![hover-node](/assets/img/posts/dead-reckoning/hover-node.gif)
*I added a small quality-of-life interaction where the node you are hovering on always appears on top of the other content (node titles, cluster names, etc). Unselected titles are also automatically dimmed.*
<br />

If we break down the timeline of all the commits from April 4th-6th, we can see the difference in time and effort for each phase:
- Phase 1 ([52ccb38](https://github.com/vivqu/vivqu.github.io/commit/52ccb381b3ea6df6e7d82a89882fa4e8cd0f1a72)...[4d3eff1](https://github.com/vivqu/vivqu.github.io/commit/4d3eff17964d5ed7a8b73613936614a55c3de512)): 8 commits
- Phase 2 ([1658613](https://github.com/vivqu/vivqu.github.io/commit/16586130649ac632d7d247e1e353523845839853)...[442c2a2](https://github.com/vivqu/vivqu.github.io/commit/442c2a2e5e9b394c14b4a411eb9bcc7aeae63f69)): 27 commits
- Phase 3 ([f4c2499](https://github.com/vivqu/vivqu.github.io/commit/f4c2499461290dec326d6cfb6d46167381cd98f4)...[e94672b](https://github.com/vivqu/vivqu.github.io/commit/e94672b07e35b6f3176fcd06bf653226c65a6056)): 11 commits

So the amount of effort in supervised problem-solving was nearly 2-3x the other phases. 

Unfortunately I don't have token usage numbers for each phase since the Claude Code conversations have already been deleted (side note: you can modify how long conversation data is stored by by extending the [cleanup period settings](https://github.com/anthropics/claude-code/issues/4172)). But given my workflow, where a conversation loosely correlates with somewhere between 1-3 commits, it's clear it was a significantly large multiple in terms of agent usage and human intervention required. 

<br />
# Making the ship sail itself

I've learned a lot about AI workflows from both my personal hacking and my day job building mobile platforms for thousands of engineers. The two key ingredients to set up any coding agent project for success is:
1. A clear, well-documented product spec
2. Tests and verification harness to enable the agent to check it's work

Generating a product spec is still an incredibly time-intensive, fundamentally _human_ process requiring multiple rounds of manual revision. It's an exercise in recording the goals, requirements, behavior, and motivations for your software product so that the coding agent can execute without having to guess the intent behind the request. See my [PLAN.md](https://github.com/vivqu/vivqu.github.io/blob/master/.claude/projects/article-graph/PLAN.md) for reference.

I've found that the more upfront time and energy is spent in the planning phase, the better the quality of the AI output. The agents still are not good at doing the kind of abstract [design thinking](/blog/2025/06/01/gen-ai-is-not-a-silver-bullet/) that the best experienced engineers and designers can do almost subconsciously. Its feeble attempts at guessing the right solution are sometimes comically bad.

Once the plan is in place and a basic initial software scaffold is built, a testing harness is the next crucial piece of project tooling that must be added. This is both for AI agent productivity and for human sanity. Manual end-to-end feature and regression testing is the slowest part of any iteration loop, and making this process visible and accessible to the coding agent is the most powerful part of the workflow. The agent, which never gets tired or bored or distracted, is an incredible manual tester -- but **only if it is able to do the verification.**

I created a [testing plan](https://github.com/vivqu/vivqu.github.io/blob/master/.claude/projects/article-graph/TEST_PLAN.md) to configure access to the web interface using [Playwright CLI](https://github.com/microsoft/playwright-cli) and outline how the agent should generate a large test data set. I included detailed instructions for the agent on where to store screenshots and when to clean them up. My goal was to build a verification harness that could scale to hundreds of content nodes but I didn't have a backlog of articles I could use for the initial data dump.

I put the test data set on a local testing page for verification which only runs locally, with the jekyll bundler excludes it from the final published website.

<br />
![test-page](/assets/img/posts/dead-reckoning/test-page.png)
*Testing page is loaded at /reading-test when run locally. The test data generated two months ago did a great job approximating of the real content I would eventually collect.*
<br />

I also added debug color modes to better inspect myself how the classification worked. This also had the benefit of enabling the agents to also quickly diagnose which kinds of nodes or clusters were having issues. I could also model more complex data relationships, like references linking nodes that spanned multiple subclusters.

<br />
![test-page-debug-mode](/assets/img/posts/dead-reckoning/test-page-debug-mode.png)
*The debug mode colors were helpful in distinguishing whether the clustering was working correctly, especially the nodes that were shared between two subclusters (dual-subcluster).*
<br />

This verification harness worked wonderfully for enabling the agent to fix small visual bugs and add product interaction elements, like the cluster-focusable legend and hovering interactions. I can prompt for small bug fixes and incremental features with very little worry about degrading the existing functionality because it is easily verifiable with this setup.

However, the ability to verify the website was not enough on it's own to build the most complex part of the project: the force simulation of nodes in the visualized graph.

<br />

# The problem with dead reckoning

It turns out that scaling an interactive, physics-based simulation to even ~100 nodes is not easy, even with a fully set up verification harness. The fundamental gap here was that my initial spec focused on _product_ requirements and did not sufficiently detail how to build the graph using the _underlying framework constraints._

D3 is an enormously flexible data visualization framework, but like any piece of software, it is built with certain assumptions and limitations baked into the platform. No software can be infinitely adapatable and perfectly suited for every single use case (and yes, that's true even for LLMs).

Since I myself had no experience with D3, I was not able to bake any knowledge of the D3 framework itself into the initial plan. That means the both Claude and I were in the dark and guessing to how we could manifest this product. I gave access to the coding agent to examples of graph and cluster implementations to use as references, but that was not enough to translate into a true conceptual understanding of how the physics simulation worked.

So as soon as I enabled the test data set, ramping up the content density, the graph exploded.

<br />
![exploded-variants](/assets/img/posts/dead-reckoning/exploded-variants.png)
*Various iterations of graph explosions where the structures collapsed when the simulation broke down.*
<br />

At risk of overusing this sailing metaphor, I was building this project using **dead reckoning**. This is a navigation method of used by ships before the invention of the marine chronometer in the late 1700s. Outside of sight of land or stars to anchor their position, ships were forced to calculate their position from a known starting point and navigate by keeping track of travel speed and the time elapsed. Longitude could not be determined without precise time-keeping or a fixed external reference. Ocean drifts inevitably introduced discrepancies on long journeys, with the errors compounding over time.

My agent and I were navigating blind. Every undefined aspect or assumption about how the force simulation worked carried forward and multipled. I spent several conversational cycles (and thousands of tokens) just throwing the agent at the problem. It attempted to diagnose the problem multiple times and solve it, only to get stuck in reasoning loops. Sometimes it also claimed it solved it, only for me to check it's work, and find it obviously didn't work. 

We kept navigating in wrong directions. Even documenting the observed bugs and prompting the agent to [deeply investigate and reason through it's proposed fixes](https://github.com/vivqu/vivqu.github.io/blob/master/.claude/projects/article-graph/force-changes.md) didn't help resolve it.

<br />
![fixes-for-clusters](/assets/img/posts/dead-reckoning/fixes-for-clusters.png)
*Visual graphic to summarize the multiple bugs with force interactions I gave to the agent.*
<br />

So after repeatedly failing at auto-fixing the force interactions between nodes, I decided to babysit the agent while it problem solved.

I started reading the agent's reasoning as it attempted to problem solve, and this supervision was both needed and extremely helpful. I was able to short-circuit some obvious dead-ends and redirect the agent to new directions to explore. I repeatedly instructed it to rewrite the simulation in a way that ended up being simpler and solved multiple problems at once. The agent kept defaulting to changing the parameters of the interaction forces, instead of taking a step back to consider the initial node placement or address implicit assumptions that made the simulation excessively complex.

At a meta level, what was happening was that I was slowly learning how the underlying D3 framework itself worked as I watched the agent's attempts to fix the bugs. I could see the levers and buttons the agent tried to interact with, as well as when it had to backtrack and reconsider. My conceptual framework was being assembled via the agent, and I had both an actual understanding of what was happening and the ability to make the right judgement calls. The entire [theory of the program](/blog/2026/03/25/writing-as-theory-building/) became fully built in my mind.

<br />
![force-issues](/assets/img/posts/dead-reckoning/force-issues.png)
*Dozens of rounds of attempted fixes and tests slowly revealed the underlying constraints I was working with. All of these screenshots are nodes and subclusters with incorrect behavior.*
<br />

It was a very fascinating experience. By the end, I built a fully working mental model of the system. I can tell you how the data is assembled and labeled, how the system does pre-processing to simplify the initial simulation state, how we preseed the nodes to reliably produce nice-looking results--especially for orphan nodes to not get trapped between superclusters. I can explain how each tick of graph simulation time causes the nodes within subclusters to pull together and the neighboring clusters to repel, how we've balanced the attraction used for reference link lines and and how we've tuned the overall graph spatial dimensions and zoom levels to best highlight the average clustering behavior.

I also know about all the edge cases (aka bugs that I've just conceded to be part of the final product) which will still cause the graph to explode. Please don't judge me for occasional explosion that still may occur.

<br />
![exploding-graph](/assets/img/posts/dead-reckoning/exploding-graph.gif)
*Pulling nodes too far to the edge of the canvas will sometimes cause catastrophic collapse.*
<br />

This is very much the operating behavior of a senior architect that is directing junior engineers on implementation. I know all the important aspects of the system, and yet I still have no idea about the specific force constants used or the particular D3 APIs that are being called. I don't need to know those details, because that's not the gap I needed to fill with critical reasoning.

In hindsight, it's not surprising that this phase took 3x as long as the planning and final fixes stages. I was building the conceptual framework to find our real heading, providing the fixed references for the agents to stop navigating blindly.

<br />
# Sailing on the jagged frontier

In many ways, this is a perfect demonstration in the [jagged frontier](https://papers.ssrn.com/sol3/papers.cfm?abstract_id=4573321) of coding agents. AI is an incredibly beneficial instrument that made it faster and easier for me to build my project and to more quickly understand the D3 framework. But unless there's a true breakthrough in AI capabilities, these agents will never replace the need for human with an accurate mental model of the system. 

Without humans in the loop, it would not have been possible for the agents alone to build my reading graph to the level of high quality I demanded, not to mention scale it correctly to increasing content node density.

But besides the learnings, it's also just fun to play around with my cool little tool. It motivates me to read and collect more writing on AI, and that alone is enough.

<br />
![graph-timelapse](/assets/img/posts/dead-reckoning/graph-timelapse.gif)
*Switching between article age gives a lovely timelapse effect.*
<br />

<hr class="section-divider" />

<footer>This article was last updated on 06/07/2026. v1 is 3,180 words and took 7.25 hours to write and edit.</footer>
