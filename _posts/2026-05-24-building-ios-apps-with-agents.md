---
title: "Building iOS Apps with Agents"
subtitle: "Vibe-coding mobile apps by closing the loop"
published: true
source: false
seo_description: "mobile-apps agentic-coding workflows"
tags: work tech
image: assets/img/posts/building-ios-apps-agents/cover-slide.png
read_time: 14 min
---

This is a talk I presented at the [AI Native Dev Meetup](https://luma.com/nik9qra6) in London, March 2025. It's geared towards any developers who want to learn more about coding agent workflows, but is especially relevant to anyone who's tried AI-assisted web development and is wondering why mobile feels so much harder.

I previously have reviewed the [landscape of iOS agentic workflows](/blog/2025/11/23/mobile-coding-agents/) and shared [my mobile vibe-coding setup](/blog/2025/11/30/vibe-coding-setup/). This talk expands on both points further using new industry benchmarks from March 2026, as well as includes a getting started toolkit I created specifically for this talk.

<br />

# AI Native Dev Video

<div class="iframe-wrapper">
<iframe width="560" height="315" src="https://www.youtube.com/embed/S1kUmkygP8E?si=DmCscgPpVDXPKaDl" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>
</div>

<br />

# Slides & Transcript

<img class="banner-image" src="/assets/img/posts/building-ios-apps-agents/cover-slide.png" />

Today I'll give you a talk on how to build iOS apps with agents. My name is Vivian and I'm currently an iOS engineer at Meta. My day job is building both infrastructure and general context, skills, and patterns to help agents work better in our custom iOS frameworks, enabling iOS engineers to build apps faster at Meta.

I've been a mobile developer for almost 15 years. I've worked with many different UI frameworks and platforms on iOS, and I'm a bit of an Android survivalist too — a lot of this will also apply to Android development as well. So let's get into it.

<img class="banner-image" src="/assets/img/posts/building-ios-apps-agents/table-of-contents-slide.png" />

In this talk I'll cover three areas. The first is what makes mobile development hard. I've framed this talk with the assumption that you've tried AI agents — maybe with web, maybe for full-stack development — and I'll talk a bit about things you might want to consider if you're jumping into building iOS apps.

I'll also share patterns and best practices: observations and learnings from my many hours interacting with agents day-to-day, and from my own side projects using open source tools.

And finally, I've prepared what is hopefully at least a getting-started toolkit if you're starting from zero. You can mix and match, and I'll go into how you can build some of your own tools to make mobile development easier with agents.

## 1. What makes mobile dev hard

<img class="banner-image" src="/assets/img/posts/building-ios-apps-agents/section-1-title.png" />

You may or may not be familiar with the iOS ecosystem specifically, but there are some things I want to call out that are quite different from web and full-stack frameworks.

<img class="banner-image" src="/assets/img/posts/building-ios-apps-agents/section-1-intro-1.png" />

Apple and Android are fundamentally **closed-source ecosystems**. iOS more so than Android.

As you can imagine, this affects how foundation models are trained, since they have less access to the underlying code. These are proprietary operating systems and platform APIs, and the tooling and languages are very specific to the platform. For instance, iOS 26 has very different APIs you might have to interact with.

In addition, Apple and Android are much more cavalier about breaking changes. They try to do a good job being backwards-compatible, but there are still breaking changes version to version. If you were developing in the early days of Swift, you might remember the migrations from Swift 1 to Swift 2 to Swift 3 — it was completely different. They even had to build tools to help you migrate, but this was before agents, so you had to try to do it deterministically.

There are **yearly major releases** that often introduce breaking changes, plus regular API deprecation for old versions. And in my experience, they do their best, but a lot of the nuances and details of the platform APIs are often not documented — and because you don't have access to them, the community also has trouble understanding what's going on.

<img class="banner-image" src="/assets/img/posts/building-ios-apps-agents/section-1-intro-2.png" />

There's much more **device fragmentation**. The form factors you have to think about for iOS don't even all fit on the slide. There are phone, tablet, and watch form factors (plus also the Apple Vision Pro), and on top of that, different UX paradigms that Apple emphasizes for each one. Devices tend to be locked to a maximum OS version to encourage you to buy new ones. So especially if you're targeting markets where people have less data access or are more price conscious, they might be on older devices and versions — that's something to keep track of too.

We'll talk in a little bit about how to deal with that by reducing scope to make the agent more successful.

And something I work on day-to-day and think about a lot: mobile just has **slow verification loops**. On web, you can load up a page, and agents can even access it directly. But on mobile, you're using custom proprietary tool chains, and we're still seeing new releases and new ways to access this for agents — so it's a work in progress.

A big pain point you might feel, especially coming from React or React Native to vanilla iOS, is that there's no hot reloading. There are some tools that make it easier, but basically you write your code, run a build (which may take a couple of minutes), and then look at a simulator or a real device to verify your code works. That whole loop is slower, which produces more errors and reliability problems.

On web you have headless mode, so you can test UI without running it in a true environment — you can't do that on iOS. You also can't replicate certain multi-touch gestures, and if you're testing things like Bluetooth or location-based capabilities, you have to use a real device. 

So there's a lot of complexity to consider when doing iOS development. I'll try to simplify much of it for you today.

<img class="banner-image" src="/assets/img/posts/building-ios-apps-agents/benchmark-1.png" />

I'm glad I'm giving this talk now, because two weeks ago Google published the first comprehensive official benchmark for mobile development ([AndroidBench](https://developer.android.com/bench)). Part of why I want to go into this is that it shows a lot of where the gaps are in the mobile ecosystem today.

<img class="banner-image" src="/assets/img/posts/building-ios-apps-agents/benchmark-2.png" />

If you look at the leaderboard, one thing you might notice is that their model is the best (which makes sense). But the highest score is 72%. If you've looked at benchmarks like SWE-bench for the new frontier model releases, scores are usually in the 80-90% thresholds. So already we're seeing a gap. It's great that we're starting to measure where we are — it's still early days, and models are getting better.

I'm going to focus on the benchmark results for Opus 4.6, but you could break this down by each individual model to see the relative performance.

<img class="banner-image" src="/assets/img/posts/building-ios-apps-agents/benchmark-3.png" />

I went into the source code and had AI categorize the 100 tasks based on the different categories being tested. I found this revealing because you can see all the different areas you have to think about for mobile development.

Just focusing on the top left (UI & Jetpack Compose), there are 25 tasks. That may seem like a lot. But at Meta, for our internal UI frameworks, we've just gotten started on measuring effectiveness and we're already at 100+ tasks just for UI and layout alone. So again, we're still in the very early days — this is just a broad overview of how the models are doing, and we can probably get more specific and granular for these agents moving forward.

<img class="banner-image" src="/assets/img/posts/building-ios-apps-agents/benchmark-4.png" />

Another thing I want to emphasize, echoed in my practical experience: because a lot is harder to verify on mobile, you see very different performance across different kinds of tasks. Architecture and dependency injection (DI) — not too bad. But other categories like device and media, builds and migrations, you see a lot more failures. And again, this is Opus 4.6, a very high-performing model on general software engineering tasks.

<img class="banner-image" src="/assets/img/posts/building-ios-apps-agents/benchmark-5.png" />

Those are aggregate numbers by category. I was curious how it performed on specific tasks, so I downloaded the data set and analyzed it across 10 individual runs on the same task. What I want to point out is that something like Bluetooth, Claude failed 100% of the time. I don't know if you've tried using the Bluetooth stack, but it's really, really hard — I don't think I could figure it out as a human, so I get it, Claude.

But directionally this is great, because at least we now have a measurement, and as an ecosystem and community we can improve from here. The success of what the agent is good at for mobile will vary quite a bit, but it is already good at a lot of stuff.

<img class="banner-image" src="/assets/img/posts/building-ios-apps-agents/benchmark-6.png" />

So where are we on iOS? 

I've talked a lot about Android. For React Native — Callstack, a company that does React Native visibility — also released [benchmarks](https://rn-evals.vercel.app/) coincidentally on the same day two weeks ago, so we have some signal there too. 

But on iOS for Swift, we actually don't have any robust benchmarks yet. The best is from May 2025, when some researchers [released 28 handcrafted examples](https://swifteval.macpaw.com/), but that's already out of date and doesn't test the latest models. So we're only just getting started, and I'm excited that we're beginning to measure this and improve as a mobile development community.

## 2. Patterns & best practices

<img class="banner-image" src="/assets/img/posts/building-ios-apps-agents/patterns-1.png" />

Hopefully I've given you a sense that if you're struggling, honestly, that makes sense. There's a lot we don't even know yet about where the gaps are for agents doing mobile development. The first step is understanding where we are, and then we can start to get better.

<img class="banner-image" src="/assets/img/posts/building-ios-apps-agents/patterns-2.png" />

The most crucial thing, in my opinion, is that you have to **set up a verification loop**. Without underlying knowledge in those frontier models, I've seen — especially on mobile — endless failure cycles. Usually a good model or harness like Claude Code will eventually stop and say, "I don't know, you try. Sorry, I can't figure it out." But I've seen this much more frequently on mobile than on other stacks or in web development. 

So creating a loop where the agent can check itself with real generated UI or interactions with a simulator is really important. The more signals it can gain to check itself, the more it can start to recover from mistakes and make up for the lack of knowledge in its model weights.

You might be thinking, "Hey, this is a talk on iOS," but I also think React Native is a really good option if you want to do mobile development. You can ship cross-platform writing just one app. But what I want to call out is that agents can't make up for fundamental limitations in the frameworks. I worked in React Native full-time for a couple of years, and I would not pick it for high-performance scrolling infinite feeds — you're going back and forth across a JS bridge, so it's naturally going to have more latency. So as much as possible, **understand the technologies and platforms you're picking**.

There's not a lot of context that comes with a model, so you need to start building that up over time. Choosing your stack is really useful so you can start building your own skills, tools, and rules. Also — something we've tried at work — language-to-language translation just multiplies complexity. If you have a React Native app, it does not do well if you try to translate it into SwiftUI. We're not even talking about iOS to Android yet, though that's also something people are very interested in. There are ways to make it better, but as a flag: converting later might be very difficult, and you might be better off starting from scratch.

<img class="banner-image" src="/assets/img/posts/building-ios-apps-agents/patterns-3.png" />

So what should you do? My best recommendation is to get as **clear as you can on your project scope**. 

There's a lot to decide on:

- How many form factors will you support?
- How many OS versions? (people might not upgrade to the latest version or have the latest device)
- Should you support rotation? 
- How do you handle local storage (there are a few options in iOS)?
- What capabilities do you need, and which require permissions?
- Do you worry about data and offline?

Generally, if you're prototyping or just getting started, try to limit scope as much as possible. It's easier to add functionality later than to start really broad and then have to figure out why your UI looks weird on iPad when you weren't paying attention to it.

Before getting into my recommended settings and frameworks — **planning is key**. The best results come from combining really well-defined specs or project plans with a verification loop that works, so the agent knows what it's trying to do as clearly as possible and can check its own work.

Note that if you're doing language-to-language conversion: we tried to convert SwiftUI to our in-house declarative UI framework. We found it was better to take the SwiftUI app, create a spec, and then give that spec to an agent with the context of the other framework to re-implement. Otherwise the agent got really confused when having access to the original code directly.

I think that's a interesting finding that really showcases the value of planning. Of course, this might also change as frontier models get better and can understand mobile development from the get-go.

<img class="banner-image" src="/assets/img/posts/building-ios-apps-agents/patterns-4.png" />

One final recommendation, and you might be familiar with this kind of workflow. I have a task workflow that has validation and verification built in. But over time there might be an aggregation of errors or complexity, or the agent might not know how to stitch things together. 

So approximately every three or four tasks, I run an expert review flow to identify issues in the codebase, clean things up, and update any skills or docs. I find this more manageable, but try out what works for you.

## 3. Getting started toolkit

<img class="banner-image" src="/assets/img/posts/building-ios-apps-agents/toolkit-1.png" />

And finally, I think you should build your own tools — I'll talk about how to do that.

<img class="banner-image" src="/assets/img/posts/building-ios-apps-agents/toolkit-2.png" />

Now I've given you the high-level problem area and some best practices, but you might be saying, "Vivian, I just want to build a mobile app. What do I do?"

So I've created a template to get started called the [SwiftUI Agent Toolkit](https://github.com/vivqu/SwiftUIAgentToolkit/tree/main). It's actually pretty basic, which I think is cool — you can get started without much baked in. It's essentially an empty skeleton: it has some skills, a plugin I wrote, some docs on how to set things up, and a place where you can build your Xcode project. I'll talk in a second about why I think this works better than going straight into Xcode.

<img class="banner-image" src="/assets/img/posts/building-ios-apps-agents/toolkit-3.png" />

In terms of the agentic setup — this will probably change in the future — I get great mileage out of Sonnet 4.6. I'm also pretty cheap so I don't use Opus a lot, or 4.7. Claude Code is great; you can use it directly, but if you want an IDE, Cursor works. VS Code works fine too.

The most important part: [XcodeBuildMCP](https://www.xcodebuildmcp.com/). This is an open-source tool that creates the verification loop. It can talk to a simulator, click around, take screenshots, and show them to you. It's really great.

For Xcode, if you're getting started, I'd recommend using SwiftUI — it's what Apple is pushing as the future anyway, and declarative UI is where the whole mobile development ecosystem is moving. 

If you aren't familiar with iOS, you also have to pick a minimum deployment target — the lowest OS level your app supports. I recommend picking the last two versions. You could pick iOS 26, the current version, but the last two versions give the agent enough information out in the wild to know what's going on without being locked into the very newest APIs, where it might run into more issues. 

And again, limiting scope: I'd just do iPhone and lock the rotation to portrait mode, so you don't have to worry about those things when all you want is to build some cool mobile apps.

<br />
<div class="iframe-wrapper">
<iframe width="560" height="315" src="https://www.youtube.com/embed/-t79BljBP0Y?si=SisePDJuvNmhciyM" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>
</div>

I'll put my money where my mouth is and show you two tools I built two days ago for this talk — a plugin and a skill. The first shows what the verification loop can look like. This is the default XcodeBuildMCP tool.

I told it I wanted to create a to-do app with a keyboard, and it will even type for you, hit the plus button, and take screenshots the whole time to make sure everything's working. This is awesome — I didn't have to manually click around and verify it myself.

<img class="banner-image" src="/assets/img/posts/building-ios-apps-agents/toolkit-4.png" />

Something the tool doesn't do by default is account for mobile conventions. So some things I put into the [ios-verify-ui plugin](https://github.com/vivqu/claude-ios-verify-ui-plugin) are:

- check light/dark mode
- make sure it doesn't overlap the Dynamic Island at the top
- make sure that if you put text on the screen, there's enough visual distinction from the background color (since colors can adapt based on light/dark mode)

It's just a thin wrapper around the MCP tool, but you can see that over time, as you get more familiar with mobile, you can add more context and adhere more to the iOS guidelines. I'd really recommend you jump in and build your own tools.

<img class="banner-image" src="/assets/img/posts/building-ios-apps-agents/toolkit-5.png" />

Another skill I baked into the toolkit is a placeholder images skill. 

I like to wireframe, so I made a wireframe and asked, "How does the agent do if I just ask it to build this UI?" On its own, it's actually pretty good — it goes to a public domain image site and downloads a lot of images, but it doesn't have any sense of what the images are.

So I added a [placeholder-ui skill](https://github.com/vivqu/SwiftUIAgentToolkit/blob/main/.claude/skills/placeholder-ui/SKILL.md) that has pre-bundled avatar, product, heroes, landscapes, and architecture images.

With very little additional prompting, you can give it the screen and the agent can determine: "Oh, that circle on top is probably an avatar," so it finds the avatar image. It can reason that "these are all products," so it uses the product images from the pre-bundled assets. That's an easy idea of design templates you can build to make your initial prototypes much richer and more realistic.

My workflow is to figure out all the UI — where things look and experiment with mock data — as much as possible before wiring up the more complicated real data and networking. So with only an hour or two of scaffolding, you can get much better results with your UI.

<img class="banner-image" src="/assets/img/posts/building-ios-apps-agents/toolkit-6.png" />

Final thing: [Apple Intelligence on Xcode](https://developer.apple.com/documentation/Xcode/writing-code-with-intelligence-in-xcode) has just launched, so technically you can go into Xcode and use all their new AI tools. They currently support both OpenAI and Claude Code. Honestly, I think it's cool — there's not much difference in quality and for me it's more of a usability thing. The MCP tool already works for most of my use cases. The one thing Apple Intelligence gives you is preview support — the ability to see the UI without recompiling — so that might be a reason to use it.

Some downsides:

- you have to use the latest version of Xcode
- you're locked into those agents
- you have to use their IDE.

They have a bridge that lets you tunnel commands to Xcode, but [it has to be open and you have to approve permissions regularly](https://danielsaidi.com/blog/2026/04/30/using-xcode-mcp-with-claude-code), so the developer experience is not great. I'm sure it'll get better, but my recommendation for now is to use the XcodeBuildMCP tool because it can get you really far. There are also instructions in a skill in the toolkit if you're curious and want to try it out.

<img class="banner-image" src="/assets/img/posts/building-ios-apps-agents/final-slide.png" />

That's a quick 101 on how to build iOS apps with agents. I hope you enjoyed it, and I think we have time for some questions. Thank you so much!

<hr class="section-divider" />

## Aside: React Native Evals

As a final addition, here is the analysis I did for the performance of Opus 4.6 on the [React Native evals](https://rn-evals.vercel.app/). I didn't have time to go over them in the talk itself.

As you can see in the breakdown, the number of tasks (43) is smaller than AndroidBench and focuses primarily on UI/UX behavior. The overall model scores are higher but the tasks do not cover deep mobile-specific tasks that are included in the Android benchmarks.

Several categories of tasks were [not yet released at the time of this talk](https://github.com/callstackincubator/evals) but are now updated or actively in progress.

<br />
![react-native-overview](/assets/img/posts/building-ios-apps-agents/react-native-1.png)
*An interesting coincidence that the React Native evals were released on the exact same day as AndroidBench.*

<br />
![react-native-overview](/assets/img/posts/building-ios-apps-agents/react-native-2.png)
*Tasks focused on user experience behavior (animation, async, navigation) but did not cover layout or any core capabilities like data, networking, or bluetooth.*

<br />
![react-native-overview](/assets/img/posts/building-ios-apps-agents/react-native-3.png)
*Overall Opus 4.6 performed the best (at the time) with a >80% passing rate.*

<br />
![react-native-overview](/assets/img/posts/building-ios-apps-agents/react-native-4.png)
*However, category performance still varies and models perform worse at harder to verify tasks like animations.*

<br />
![react-native-overview](/assets/img/posts/building-ios-apps-agents/react-native-5.png)
*Breaking down further to individual tasks, category-level scores mask the fact that some tasks have very low success rates across 10 separate runs for the same model.*

<hr class="section-divider" />

<footer>This article was last updated on 05/24/2026. v1 is 3,419 words. Transcription was extracted via <a href="https://youtube-transcript.ai/" target="_blank">Youtube Transcript AI</a> and edited for conciseness and clarity.</footer>
