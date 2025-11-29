---
title: "My mobile vibe coding setup"
subtitle: "Building a home-cooked mobile app"
published: true
source: false
seo_description: "llms vibe-coding mobile-development"
tags: tech work
image: assets/img/posts/mobile-coding-agents/agent-setup.png
read_time: 10 min
---

This is my vibe coding setup. 

As I outlined in [why mobile coding agents are worse](/blog/2025/11/23/mobile-coding-agents/), models and agents are not by-default optimized for mobile development. I wanted to understand how good the AI-assisted mobile development workflow is today. 

While the jury is still out on whether AI will automate software engineers into obsolescence, I do believe that coding agents will unlock an entire category of new software: [home-cooked apps](https://maggieappleton.com/home-cooked-software). This term was first coined by [Robin Sloan](https://www.robinsloan.com/notes/home-cooked-app/) in 2020 and refers to custom-fit apps that are designed and distributed for a tiny group of people, made with love and care like a home-cooked meal. No blitzscaling or user growth projections or fundraising demands in sight.

This idea has been expanded by [Maggie Appleton](https://maggieappleton.com/home-cooked-software) and [Jasmine Sun](https://www.msn.com/en-us/money/other/your-next-favorite-app-the-one-you-make-yourself/ar-AA1FhFQh) to a broader movement of "personal scale" software. It's really inspiring to learn about all these grassroots efforts to build software that can address the long tail of user needs. These are the problems that industrial/professional software has always deprioritized because there's not enough value or revenue to justify funding it.

<br />
![app-opportunity](/assets/img/posts/vibe-coding-setup/app-opportunity.png)
*The new territory AI-assisted workflows unlock, diagram from [Appleton's talk](https://maggieappleton.com/home-cooked-software)*
<br />

Still, most home-cooked examples are web or mobile web apps. After all, that's what vibe coding is much better at.

So here's a window into my own experiments creating home-cooked _mobile_ apps. I'll share my setup, learning and observations, and conclude how we can continue to evolve this space to be better.

## Setup

There are a lot of opinions out there on how to bootstrap your vibe coding environment. I intentionally went very minimal. I was curious how good the coding agents could be without any additional tools/harness, and my background as a professional software engineer made me confident I could rescue myself out of any disastrous situations.

<br />
![agent-setup](/assets/img/posts/vibe-coding-setup/agent-setup.png)
*The project was created with SwiftUI, Cursor, Claude Code, and XcodeBuildMCP.*
<br />

My quick setup guide:
- Create an empty git repository 
- Install Xcode 26.0.01 and CLI tools
- Install Cursor
- Install Claude Code in your terminal ([docs](https://docs.claude.com/en/docs/claude-code/setup))
- Run `claude` inside Cursor integrated terminal
- Setup [XcodeBuildMCP](https://github.com/cameroncooke/XcodeBuildMCP)
- Create an empty Xcode project with SwiftUI and SwiftData
- Create a README for my project
- Run `claude /init` to create a new CLAUDE.md

This project was done using Cursor on the Pro plan ($20/mo) and Claude Code Pro plan ($17/mo) running Sonnet 4.5. And even though I haven't released this project, I also pay for an annual $99 Apple Developer license for my other apps.

You can check out the repository at [vivqu/bullet-journal-todos-swiftui](https://github.com/vivqu/bullet-journal-todos-swiftui).

## The project

In the spirit of home-cooked apps, I wanted to build a todos app. 

Todo apps are personal to the extreme. They can range from a simple [never-ending .txt file](https://jeffhuang.com/productivity_text_file/) to [advanced open-source software](https://github.com/johannesjo/super-productivity?tab=readme-ov-file) with built-in time tracking and JIRA/Github/etc integration (my nightmare). Developers [_love_ to build their own todo apps](https://www.reddit.com/r/webdev/comments/1evp046/is_it_worth_building_a_todo_web_app_and_other/) because existing solutions never quite fit an individual's needs or quirks.

I have loved the [bullet journaling](https://en.wikipedia.org/wiki/Bullet_journal) method from the first use. It's an analog system for organization, mindfulness, and productivity that can be endlessly customized and adapted to the individual person's preferences. 

The core of the system is the manual carrying over of incomplete tasks from day-to-day or week-to-week. The process of re-transcribing the task to the next block provides time to reflect and reprioritize on the work.

![bullet-journal-todos](/assets/img/posts/vibe-coding-setup/bullet-journal-todos.png)
*Todos can be completed, migrated to the next day, or deprioritized.*
<br />

Some other benefits of choosing a todo app as my vibe coding exercise:
- No authentication required
- Local by default (cloud data syncing can be added later)
- Intuitive understanding of the space from being a power user of (many) todo apps

To get started, I created a [README](https://github.com/vivqu/bullet-journal-todos-swiftui/blob/main/README.md) describing the basic requirements of the app. I only needed to provide minimal tweaks to the initial [CLAUDE.md](https://github.com/vivqu/bullet-journal-todos-swiftui/blob/main/CLAUDE.md) file. Then I hopped into [excalidraw](https://excalidraw.com/) to create low-fidelity mocks of the UI:

![todo-app-mocks](/assets/img/posts/vibe-coding-setup/mocks.png)
*Three screens demonstrating the primary use cases of the app.*
<br />

I am a visual learner/planner and mobile UX is so much easier to wireframe than to describe with text. I was curious how well the coding agent could handle screenshots when [creating plans](https://www.anthropic.com/engineering/claude-code-best-practices#a-explore-plan-code-commit) for the project. I committed the screens directly into the codebase in the [`/mocks`](https://github.com/vivqu/bullet-journal-todos-swiftui/tree/main/mocks) folder and pointed it out to the agent for planning.

Creating the [plan.md](https://github.com/vivqu/bullet-journal-todos-swiftui/blob/main/plan.md) required many rounds of back-and-forth with the agent. I knew that the task breakdown and detail within the plan would make a large difference in the experience of vibe coding. As the Claude Code [best practices](https://www.anthropic.com/engineering/claude-code-best-practices#a-explore-plan-code-commit) state:

> Steps #1 - #2 are crucial—without them, Claude tends to jump straight to coding a solution. While sometimes that's what you want, asking Claude to research and plan first significantly improves performance for problems requiring deeper thinking upfront.

It took me a full 45 minutes of active prompting to create the final plan with 23 (!) discrete steps. Guiding the agent to produce a well-structured, reasonable plan with meaningful progression chunks was very reminiscent of working with a new grad engineer. 

```
# Bullet Journal Todos - Development Plan

## Phase 1: Data Foundation

- [ ] 1. Create SwiftData models
  - Task model: `text: String`, `isComplete: Bool`, `focusArea: FocusArea`, `sortOrder: Int`, `createdAt: Date`, `week: Week`
    - Note: `createdAt` tracks when task was originally created (useful for carry-over tracking and debugging)
    - Note: `week` is non-optional - tasks must belong to a week
    - Note: Task text is stored exactly as provided by user (including empty strings and whitespace)
  - Week model: `startDate: Date`, `tasks: [Task]`
  - FocusArea enum: `.life`, `.work`

- [ ] 2. Create unit tests for data models
...
```

Claude Code frequently jumped to conclusions or added too much scope too quickly. This was by far the most difficult part of the entire project, and my 10+ years of training as a software engineer was extremely relevant for guiding the agent here.

![mocks-commit](/assets/img/posts/vibe-coding-setup/mocks-commit.png)

![plans-commit](/assets/img/posts/vibe-coding-setup/plan-commit.png)
*I was continuously prompting the agent between adding the commits and creating the plan.*
<br />

The plan was also not fixed or stable for the duration of the vibe coding. As you can see from the [history](https://github.com/vivqu/bullet-journal-todos-swiftui/commits/main/plan.md), there were plenty of times I needed correct the agent with refactors or add implementation/future notes to the plans. Keeping track of the future considerations allowed the agent to understand we were building a _minimum viable product_ (MVP) and to stay on track with the overall project goals.


## Workflow

Now that we had an initial plan, we could get into the actual vibe coding of tasks!

One of the most crucial parts of the agentic workflow is when and how to provide [context](https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents) to the agents. There are a [lot](https://simonwillison.net/2025/Oct/25/coding-agent-tips/) [of](https://tombedor.dev/optimizing-repos-for-ai) [opinions](https://www.geoffreylitt.com/2025/10/24/code-like-a-surgeon) on how to structure your codebase, add rules files, [docs](https://context7.com/), MCP tools, skills, and more. You can find plenty of [open-source CLAUDE instruction sets](https://raw.githubusercontent.com/obra/dotfiles/6e088092406cf1e3cc78d146a5247e934912f6f8/.claude/CLAUDE.md), tips for [writing agents.md](https://github.blog/ai-and-ml/github-copilot/how-to-write-a-great-agents-md-lessons-from-over-2500-repositories/), collections of [rules](https://github.com/continuedev/awesome-rules) [files](https://github.com/steipete/agent-rules), and [skills](https://github.com/obra/superpowers) to get started. 

However, I didn't really want to base my workflow using external information. The whole point of the exercise was to find out the limitations of the current model/agents. I didn't want to obfuscate the signal by providing supporting struts of additional context. 

Plus, I have a suspicion that all of the contextual harness around the agents will eventually become very customized/personal to each vibe coder, and perhaps to each project itself. I believe this context wrapper will be like the equivalent of a chef's knife kit -- using off-the-shelf equipment is an ok place to start, but as you get more adept with vibe coding you'll eventually want to optimize your setup for the unique way you work with and prompt the agents.

I quickly started building up my own context and documentation for the models. Instead of simply fixing any bad generated code, I tried to diagnose the agent's behavior and update my vibe coding setup to prevent the same mistakes from occuring again. I saved new information into the codebase every time the agent stumbled.

Here's the set of context I've created (so far):

```
BulletJournalTodos/
docs/
	|- swift.md      // Personal style guidelines for Swift
	|- ipad.md       // iPad-specific implementation and testing
	|- ui.md         // Design guidelines
	|- test_setup.md // Configuring tests in Xcode
mocks/
	|- add-new-task.png
	|- main-screen.png
	|- work-selected-main-screen.png
CLAUDE.md
README.md
plan.md
DEFAULT_TASK_WORKFLOW.md // Task workflow for the agent

```

<br />
Here was my general workflow loop:
- Start task
	- Open a new Claude session to clear the context window
	- Prompt the agent to start on a task ("Let's work on task 12")
	- Ensure the agent follows the workflow (check for uncommited changes & create new branch)
- Make changes
	- Carefully watch as it makes code edits, manually approving each edit
	- After a significant chunk of the task was done, review the code holistically like a code reviewer
	- Ask for revisions or changes as needed
- Validation
	- Once the task is largely complete, turn on `dangerouslyAllowPermissions` to let the agent run manual validation with XcodeBuildMCP
    - Run unit tests
- Commit
	- Wrap up the workflow by updating the plan, commit the changes, and merging the branch

Some might argue that I wasn't truly "vibe coding" since I was still watching the agent and reading the generated code at each step. While I admit this workflow is quite far from the dream of full autonomous, blind execution without human oversight that the AI-pilled hype men like to tout as the future, I still felt the magic of this process. Much of the heavy lifting of thinking and execution was abstracted away to the model/agent. It was so fun! 

![task-workflow](/assets/img/posts/vibe-coding-setup/task-workflow.png)
*The agentic workflow for each task.*
<br />

It felt like working with a very talented, if overeager, intern. And this is probably more obvious working on mobile codebases since there were quite a few places it simply got stuck. Perhaps with webapps there's much less of this, although I have heard anecdotally the number is nowhere close to zero ([centering a div](https://www.nuanced.dev/blog/how-centering-a-div-made-me-question-the-future-of-ai-coding) stumps both humans and AI).

From the very first task, I realized I needed to document the [default task workflow](https://github.com/vivqu/bullet-journal-todos-swiftui/blob/main/DEFAULT_TASK_WORKFLOW.md) that I wanted. Claude Code just jumps into execution without any concept of revision control or checking the commit state. It took me several tries to ensure that the agent reliably followed the workflow. 

The best things I found to get it to adhere to the process was:
- Naming the file with extreme clarity (`NEW_TASK_WORKFLOW.md` is better than `WORKFLOW.md`). This also allows the agent to better disregard these instructions when we are _not_ working on a new task.
- Use [`@import` syntax](https://code.claude.com/docs/en/memory#claude-md-imports) to directly import the workflow instructions into `CLAUDE.md`

As I worked through the plan with the agent, I quickly noticed repeated bad patterns or failures at executing mobile-specific details. I encoded these into `/docs` files, and I would let the agent reference these as needed without explicit instructions. While the agents are not _specifically_ aware of documentation files, I found that its ability to code search is general enough to find these as needed.

Some noticeable gaps the agent had:
- Unable to access or configure the [test target](https://github.com/vivqu/bullet-journal-todos-swiftui/blob/main/docs/test_setup.md), even with commands available through the XCode MCP tool
- General [lack of best practices in Swift](https://github.com/vivqu/bullet-journal-todos-swiftui/blob/main/docs/swift.md) like force unwrapping and not understanding `#Preview` blocks
- Confusion on what [manual validation commands](https://github.com/vivqu/bullet-journal-todos-swiftui/blob/main/docs/ipad.md) were possible with the XCode MCP tool (swiping is possible, shrinking an app to split screen is not doable)
- Unable to validate or observe crashes which occurred due to data models requiring migration

Every four or five tasks or so, I started kicking off a review session. Using a fresh session, I ask Claude to act as an expert reviewer to analyze the codebase and fix issues:

```
Before we work on task 18, review the entire codebase as a principal iOS engineer. Look for problems or areas that we need to fix. Don't jump into fixing them but write up a list of areas that you recommend we address
```

This enabled the agent to review the overall code structure and identify problems that fell outside the it's narrow task focus. 

![review-workflow](/assets/img/posts/vibe-coding-setup/review-workflow.png)
*My final workflow that incorporates an expert review session every 4-5 tasks.*
<br />

I was generally impressed with the issues it identified, overperforming as a reviewer compared to it's junior-level project brainstorming. 

![expert-review-output](/assets/img/posts/vibe-coding-setup/expert-review-output.png)
*Representative first output from the expert reviewer, enabling me to dive into each identified issue and determine if it was correct or a hallucination.*
<br />

But the most fantastic part was definitely the automation of manual validation. With just my bare bones setup, Claude Code + XcodeBuildMCP was able to fully handle complex visual verification tasks. 

<br />
<div class="iframe-wrapper">
<iframe id="youtube-player-2x" width="560" height="315" src="https://www.youtube.com/embed/-t79BljBP0Y?si=9Gc7-SJqBJZSUel5&enablejsapi=1" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>
</div>
<br />

The code --> compile --> manual test loop takes quite a lot of time with mobile builds. While the agent is quite slow, it was a huge boost to be able to let it run for as long as it needed in the background. 

It's normally very frustrating to do the manual validation loop across different OS versions (which can have quite different APIs) and form factors (iPhone vs iPad) on every significant change, but with coding agents this part of the workflow is a breeze.

![ipad-validation](/assets/img/posts/vibe-coding-setup/ipad-validation.png)
*Asking the coding agent to do the same verification tasks again on iPad.*
<br />

Coding agents still struggle quite a bit with complex interactive tasks. It was able to identify the problem when I attached a video showing the bug, but it isn't able to fix layout issues that are combined with keyboard animations or transitions. I always ended up stepping in to debug the issue myself. 

Complex layout interaction is definitely a major gap in the models themselves. It makes sense that it's a weakness given how challenging it would be to construct a dataset or benchmarks for interactive layouts and animations. I would suggest foregoing the agents entirely in this case (or have it just generate the starting code), and manually tune/test these cases for final app polish.

## Next steps

![todo-complete](/assets/img/posts/vibe-coding-setup/todo-complete.png)
*Before and after, from mock to real prototype app.*
<br />

While the app is certainly not done, with more features and edge cases I can test, I also want to explore more topics within agentic mobile development.

Specifically I'm curious about:
- Investigating tools for mobile vibe coding gaps (crash detection)
- Researching mobile (and UI) LLM benchmarks
- Conducting a comparison of React Native, SwiftUI, and Swift in terms of agentic performance
- Testing a larger range of agents (Codex, CursorAI, etc) against Claude Code to see if there's any variance in mobile code quality

There's many open question about how we can make the agentic workflow better for mobile apps! I hope this essay adds useful information to the collective knowledge of the mobile dev community, and I'm excited to keep digging in.

<hr class="section-divider" />

<footer>This article was last updated on 11/30/2025. v1 is 2,411 words and took 5 hours to write and edit.</footer>

