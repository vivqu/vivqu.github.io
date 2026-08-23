---
title: "Software archaeology and resurrection"
subtitle: "On the benefits of cheaper software"
published: true
source: false
seo_description: "agentic-coding dead-software"
tags: work tech
image: assets/img/posts/software-archaeology/pompeii-vesuvius.jpg
read_time: 7 min
---

<img class="banner-image" src="/assets/img/posts/software-archaeology/pompeii-vesuvius.jpg" />
<em>"The Forum, Pompeii, with Vesuvius in the Distance" by Christen Kobke (from <a href="https://www.wikiart.org/en/christen-kobke/the-forum-pompeii-with-vesuvius-in-the-distance-1841" target="_blank">WikiArt</a>)</em>
<br />

Now that coding agents have made the cost of writing software much cheaper, one positive outcome is that resurrecting dead software has actually become cost-effective and feasible. 

It used to take long nights and weekends to keep side projects alive, requiring constant maintenance and updates to keep up with the latest frameworks. Thousands of hours have been dedicated to reviving classic games that can no longer run on modern hardware. Online communities have desperately rushed to build open source clones when the companies behind their beloved software products announced they ran out of money and were shutting down.

Why do people give so much of their time and money to keep old software going? Well, it used to be because you had to do it. Software is never "finished" in the same way that physical goods are. When you buy a paperback book, you can enjoy reading it for nearly a lifetime (assuming you take moderate care and don't drop the book in the bath). Software is not like this: the company goes under, the product roadmap is reprioritized, old game consoles and cartridges are no longer produced, computers no longer run older versions of the operating system.

Many years ago, I joined a B2B startup as the founding mobile engineer. After months of intense development we launched the first version of the mobile app. I proudly told my friends and family of the milestone. A family member congratulated me and then asked, "What are you going to work on now?" She thought that our work was done; after all, the software had launched! I had to explain that it doesn't work that way, and there was a neverending list of ongoing fixes and future improvements planned.

Software is in a constant state of [_rotting_](https://en.wikipedia.org/wiki/Software_rot). The functionality encoded in software--whether it's a game, productivity tool, or a B2B mobile app--depends on the environment surrounding the software program itself. Relentless evolution in physical hardware, operating systems, programming languages, and the underlying libraries means that software needs ongoing maintenance to keep functioning. Breaking changes can be introduced anytime which catastrophically degrade the behavior. Sometimes even the impersonal machinery of bureaucracy can kill software--in 2022, I was forced to scramble to update my mobile game [because Apple's App Store guidelines considered it outdated](/blog/2022/09/25/outdated-apps/).

We used to be a lot more concerned with software deterioration. In the pre-AI world especially, there were many urgent reports about decaying content on the Internet. "Content drift" happens when a piece of linked content changes over time, and "link rot" happens when the content is removed entirely. Harvard professor Jonathan L. Zittrain wrote about [various academic studies showing](https://www.theatlantic.com/technology/archive/2021/06/the-internet-is-a-collective-hallucination/619320/) that 25-75% of links have drifted or died, with the results worsening the farther back in time you go. Pew Research released [an analysis in 2024](https://www.pewresearch.org/data-labs/2024/05/17/when-online-content-disappears/) that showed 38% of webpages that existed in 2013 are no longer available. Even non-Internet encoded data is a problem because the file format itself can become obsolete. The applications which can read the file format can disappear. As the MIT Libraries write about vulnerabilities in [digital preservation management](https://www.dpworkshop.org/dpm-eng/oldmedia/obsolescence1.html),

> [...] today's wildly successful software can be tomorrow's also-ran or distant memory. There has been tremendous consolidation in the commercial software industry and many products have disappeared following mergers and acquisitions. Others have succumbed to competition from superior or more cleverly marketed products.

Nowadays we have a different problem: the proliferation of AI slop on the Internet. [Bots have outstripped humans in online traffic](https://www.forbes.com/sites/josipamajic/2026/06/04/bots-now-outnumber-humans-online-and-the-internet-was-never-built-for-this/) and Pew Resarch [released a study in August 2026](https://www.pewresearch.org/data-labs/2026/08/20/how-much-of-the-internet-is-written-with-ai/) (three days ago, as of this writing) that analyzed 10,000 webpages from July 2026 for AI authorship using Pangram. 10% showed "significant signs of AI authorship." The result is even more galling when restricting the sample set to pages published after the release of ChatGPT. 35% of those pages (!!) are written or substantially edited by AI. 

What happens when these two forces collide? Will the Internet end up being the doomsayers' worst nightmare? Natural content deterioration will slowly rot away the genuine human content while AI mass-production keeps going on, until it's just AI outputting and consuming it's own content, an ouroboros of endless generated content.

But I believe there is another hidden force at play here--the irrepressible desire of humans to create beautiful and useful things. It's now cheaper than ever to produce AI slop, but it's also cheaper than ever to excavate dead software and provide ongoing maintenance to existing programs. 

I have been so inspired reading about people reviving their old programs. Their stories explaining the creation of the original software, why it languished or became obsolete, and how it was resurrected in the past few months are addicting to read. It clearly showcases the changing dynamics of software development and exciting possibilities for more creative, non-slop things. 

Jon Radoff used coding agents to [reconstruct Legends of Future Past](https://meditations.metavert.io/p/resurrecting-a-1992-mud-with-agentic), an online multiplayer game he built in 1992 over six months. It ran for seven years until the servers were shut down in 1999, after which the game was unplayable for twenty-seven years. Then this year, Radoff was able to resurrect it in a single weekend with Claude Code and a set of artifacts. What was even more impressive was that he was able to do this on a game that was written in his own custom scripting language, without the original game engine source code!

Mathematician Terry Tao has [restored multiple mini-apps](https://terrytao.wordpress.com/2026/07/11/old-and-new-apps-via-modern-coding-agents/) he built as far back as 1999. The mini-apps he built were useful teaching aids but were "time-consuming to program", and many quietly died when webpages no longer supported the version of Java they were written with. Now with coding agents, he was able to [port his mini-apps to modern Javascript](https://teorth.github.io/tao-web/apps/porting-legacy-applets.html) in only a few hours, easily adding updates and visual improvements. The relative ease of modernizing his apps inspired him to also try creating other app ideas, which Tao had previously attempted but the complexity quickly outstripped his expertise level. Today, Tao has published [40 interactive tools](https://teorth.github.io/tao-web/applets.html), 20 of which have been ported from old versions built from 1998-2007. 

And people are also bringing back software not originally built by them. Video games are an especially compelling magnet for motivated folks, armed with coding agents and a dream. According to the [Video Game History Foundation](https://gamehistory.org/87percent/), 87% of classic  games released before 2010 are no longer widely available. Playing a game can bring up strong emotions like joy and childhood nostalgia, so it's no wonder there is such fervent desire to bring them back into wider circulation.

I've collected a few case studies about the resurrection of vintage games:
- [Weltendaemmerung](https://github.com/s-macke/weltendaemmerung) ("Twilight of the Worlds") - reverse engineering and porting a German 1980s fantasy strategy game to the web. The original game took 2 months to develop. This was the author's second port: the first version in 2021 took several weeks to understand the code and write the C port. This project took 3 days and $100 of Claude Code credits.
- [psxrecomp]([https://github.com/mstan/psxrecomp](https://1379.tech/i-built-a-ps1-static-recompiler-with-no-prior-experience-and-claude-code/)) - this project resulted in a [general purpose static recompiler for PS1](https://github.com/mstan/psxrecomp?ref=1379.tech) and recompiled the game _Tomba!_ using Claude Code in three weeks, with no previous experience in reverse engineering.
- [Chromatron](https://quesma.com/blog/chromatron-recompiled/) - used open-source compiler Ghidra and modern agents to "vibe-port" a puzzle game that only ran on Windows XP/PowerPC to work for Apple Silicon and Wasm.
- [Micropolis](https://github.com/c-ehrlich/micropolis/tree/main) - Typescript port of SimCity (1989) built using Codex 5.3 in 4 days.
- [Crimsonland](https://banteg.xyz/posts/crimsonland/) - a full rewrite of a top-down shooter originally released in 2003. The original creators took a year to port the game in 2014, and this author took 2 weeks to rewrite it using the binaries only and no access to the original source code.
- [Snowboard Kids 2](https://blog.chrislewis.au/the-long-tail-of-llm-assisted-decompilation/) - the author decompiled "the greatest N64 game ever made" with a detailed breakdown of his workflow. Discovered some new [cheat codes](https://www.reddit.com/r/SnowboardKids/comments/1pw1nj4/new_sbk2_cheat_code/?share_id=_dyHtZV9QtJ9Nbed1Vrxw&utm_content=1&utm_medium=ios_app&utm_name=ioscss&utm_source=share&utm_term=1) along the way.

All of these examples make me very excited for *more* interesting software being created, not less. The culture of [software archaeology](https://en.wikipedia.org/wiki/Software_archaeology) might spread from the niche gaming subcultures to something that any hobbyist can do. We can keep alive and enhance old software in ways that used to be too cost-prohibitive. These works might even be further enhanced, remixed, and recombined into new and different tools and experiences.

The [Ship of Harkinian](https://www.shipofharkinian.com/faq) is an unofficial port of the N64 game _The Legend of Zelda: Ocarina of Time_. It was painstakingly decompiled by hand in 2024 to run on the PC by a group of devoted fans. As they write in their FAQ:

> This is a project done by volunteers during their spare time for free. The work gets accomplished by whoever's interested in implementing what, with a few things being prioritized as milestones for stable releases. To set deadlines would be to create unrealistic expectations that would likely never be met and cause disappointment.

How many more of these cool projects will exist now that it's easier and cheaper to accomplish? I'm excited to find out.


<hr class="section-divider" />

<footer>This article was last updated on 08/23/2026. v2 is 1,503 words and took 4 hours to write and edit.</footer>
