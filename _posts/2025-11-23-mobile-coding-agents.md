---
title: "Why are mobile coding agents worse?"
subtitle: "Challenges in AI-assisted mobile development"
published: true
source: false
seo_description: "llms vibe-coding mobile-development"
tags: tech work
image: assets/img/posts/mobile-coding-agents/mobile-developer.png
read_time: 4 min
---

There are plenty of examples of vibe coding apps but they are mostly web apps or tooling projects that are well suited for agentic workflows. 

Mobile apps are trickier to build with agents. There are a few structural reasons for this:
- mobile languages are extremely specialized and platform-dependent, with yearly OS updates often come with breaking API changes 
- core mobile APIs are closed source, thanks to Apple and Google's attempts at ecosystem and developer lock-in, making it harder for LLMs to have the appropriate context and skills
- most production mobile apps themselves are closed source, giving fewer examples for the LLMs to train on

Validation loops are more difficult in mobile too. Each platform requires specific IDEs (Xcode and Android Studio), and building and deploying mobile apps require custom toolchains that agents are not optimized to use. UI and integration testing is difficult and limited. On iOS, you can't even simulate navigation and tap events without compiling the full app and running it on a simulator, making it slow and prone to breakages.

There also hasn't been much research on the effectiveness of LLMs for building mobile apps. The most directionally relevant paper I found was a [pilot study on translating projects from Android to iOS](https://www.arxiv.org/abs/2507.16037) published in July 2025. As stated in the introduction, "the performance and applicability of LLM-based translation approaches in the context of mobile application migration, especially across fundamentally different platforms like Android and iOS, remain largely unexplored." 

And even though the case study only looked at translating five Android projects, the results were consistent with my intuition on the challenges of AI-assisted mobile development:
- 33.95% of the 380 reviewed issues were package-level issues that spanned multiple files and dependencies, revealing fundamental gaps in platform-specific code generation
- All the translated projects could not be compiled without "further substantial human efforts" due to dependency management, environment compatibility, and project structure alignment

The paper concludes with an overview of gaps and the significant headroom for improving mobile-specific code generation:

> While general-purpose LLMs such as GPT-4 are proficient in generic programming tasks, they often lack the nuanced understanding of platform-specific constructs required for accurate cross-platform translation. Android and iOS differ significantly in their architectural patterns, lifecycle management, UI frameworks, permission handling, and asynchronous programming models.
> 
> Our analysis also revealed key categories of platform-specific challenges, e.g., differences in system settings and design paradigms, that often lead to incorrect or suboptimal translations between Android and iOS. These issues highlight the limitations of current LLMs in adapting to the distinct architectural, behavioral, and policy-driven characteristics of each mobile platform.
> 
> Furthermore, platform-specific UI design conventions, accessibility practices, and navigation hierarchies introduce additional complexity when translating across ecosystems. In future work, practitioners should focus on enhancing LLMs with explicit knowledge of these platform-specific behaviors, potentially through fine-tuning on platform-aligned datasets, prompt engineering guided by platform constraints, or the integration of symbolic rules derived from SDK documentation.

Anecdotally there are also ideological barriers preventing the update of coding agents in mobile development. Mobile engineers tend to be some of the most opinionated, craft-driven engineers I know<sup><a href="#fn1" id="ref1">1</a></sup>. This bunch tends towards a much more hardline approach to language and architectural decisions. This is partially due to the mobile software delivery process, since code is bundled and shipped on a weekly basis, making mistakes and crashes much more painful to fix. Poor output and code hallucinations are a lot less tolerable to this cohort. Thus the lack of adoption creates a vicious negative spiral since fewer early adopters mean less communal knowledge that could be built up to compensate for the weakness of current coding agents. 

Apple and Google, who are best positioned to optimize coding agents for mobile app development, seem content to let agent performance languish in this domain. It may be somewhat of a strategic gamble, since the market share of programmers using Swift is 5% and self-identified mobile engineers only 3%, according to [StackOverflow's 2025 Developer Survey](https://survey.stackoverflow.co/2025/). 

<br />
![programming-languages](/assets/img/posts/mobile-coding-agents/programming-languages.png)
*5.4% of respondents did extensive development work <a href="https://survey.stackoverflow.co/2025/developers/#3-role" target="_blank">in Swift</a>.*
<br />

![developer-titles](/assets/img/posts/mobile-coding-agents/developer-titles.png)
*Only 3% of self-identified <a href="https://survey.stackoverflow.co/2025/developers/#3-role" target="_blank">roles</a> are mobile engineers.*
<br />


The lack of investment suggests that the companies are waiting for foundational models to improve—in a "the rising tide lifts all boats" sort of situation. Still, given their dominance of the mobile development ecosystem and full vertical integration, it's dispiriting to see so many reports of systematic failures of Apple's [AI coding assistant](https://www.reddit.com/r/Xcode/comments/1p3jd5z/there_is_no_way_that_apple_uses_the_ai_coding/) and Google's [bad Gemini experience inside Android Studio](https://www.reddit.com/r/androiddev/comments/1owcw6k/does_anyone_else_struggle_to_actually_use_the/). 


### Mobile vibe coding in the wild

Given all these challenges, I wanted to try out vibe coding myself. I'll share more of my setup and impressions using an agentic mobile workflow in an upcoming post. 

In the meantime, here's a rough survey of writeups about iOS agentic workflows:

{:.post-table}
| Article | Language | Agent | IDE |
| ------- | -------- | ----- | --- |
| [Writing a (Prototype) IOS App with Cursor.ai](https://rich-gaogle.medium.com/writing-an-okay-prototype-ios-app-with-cursor-ai-079a92e55d2f) | Unclear | Claude Code | Cursor |
| [Building iOS apps with Cursor and Claude Code](https://dimillian.medium.com/building-ios-apps-with-cursor-and-claude-code-ee7635edde24) | SwiftUI | Claude Code | Cursor |
| [Launched an iOS app (Preppr) from scratch in 2 weeks and $150 with Claude AI](https://www.indiehackers.com/post/launched-an-ios-app-preppr-from-scratch-in-2-weeks-and-150-with-claude-ai-61c5342973) | Expo (React Native) | Claude Code | Cursor |
| [I Shipped a macOS App Built Entirely by Claude Code](https://www.indragie.com/blog/i-shipped-a-macos-app-built-entirely-by-claude-code) | SwiftUI | Claude Code | Terminal / Xcode |
| [The Ultimate AI Agent Experiment: Building an Entire iOS App Without Writing a Single Line of Code](https://matteozajac.medium.com/the-ultimate-ai-agent-experiment-building-an-entire-ios-app-without-writing-a-single-line-of-code-b2d0662feb0a) | SwiftUI | Claude Code | Terminal / Xcode |
| [Vibe Coding for mobile with Cursor AI](https://uxplanet.org/vibe-coding-with-cursor-ai-52f5023bc59a) | SwiftUI | Cursor AI   | Cursor |
| (Reddit) [Software engineer (16 years) built an iOS app in 3 weeks using Claude Code](https://www.reddit.com/r/ClaudeAI/comments/1lld60y/software_engineer_16_years_built_an_ios_app_in_3/) | SwiftUI | Claude Code | Terminal / Xcode |
| (Reddit) [vibe coding native mobile apps: what's the best tool and process for a non technical person?](https://www.reddit.com/r/vibecoding/comments/1l4u39z/vibe_coding_native_mobile_apps_whats_the_best/) | various | various | various |

Some other tools I came across that enable more hands-off workflows:
- [Bolt.new](https://bolt.new/)
- Replit's [AI app builder](https://replit.com/usecases/ai-app-builder)

If you have more papers or personal examples of effective mobile coding agent use, I'd love to hear about it! Shoot me an email at <a href="mailto:hello@vivqu.com" target="_blank">hello@vivqu.com</a>.


<br />
<p>
    <footnote id="fn1">1. This is not necessarily complimentary. The number of navel-gazing technical arguments I've had on mobile technologies and architecture are uncountable at this point. I'm guilty of starting some myself.<a href="#ref1" title="Jump back to footnote 1 in the text.">↵</a>
    </footnote>
</p>

<hr class="section-divider" />

<footer>This article was last updated on 11/23/2025. v1 is 963 words and took 3.5 hours to write and edit.</footer>

