---
title: "High-leverage architecture"
subtitle: "The business impact of documentation and exploring architecture automation"
published: true
source: false
seo_description: "software engineering architecture communication"
tags: tech software-engineering architecture
image: assets/img/posts/architecture-docs/code-diagram.png
---

Aleksey Kladov wrote a [smart, concise explanation](https://matklad.github.io//2021/02/06/ARCHITECTURE.md.html) about why all open-source projects need an explainer for the high-level architecture of the codebase. I would go further to state that every software project needs to have an ARCHITECTURE.md file.

Kladov very clearly identifies the difference between a core developer and an occasional contributor to a project: one person has a mental model of the codebase itself, while the other does not. As he writes (emphasis mine):

> Roughly, it takes 2x more time to write a patch if you are unfamiliar with the project, but it takes 10x more time to figure out _where_ you should change the code. This difference might be hard to perceive if you’ve been working with the project for a while. If I am new to a code base, I read each file as a sequence of logical chunks specified in some pseudo-random order. If I’ve made significant contributions before, the perception is quite different. I have a mental map of the code in my head, so I no longer read sequentially. Instead, I just jump to where the thing should be, and, if it is not there, I move it. *Mental map is the source of truth.*

I agree with this. Lacking a high-level overview of a codebase significantly hampers your ability to make changes and pinpoint issues. I am actually very fast at traversing unfamiliar codebases, and my [Google-fu](https://en.wiktionary.org/wiki/Google-fu) is excellent. Still, both of these skills can fail if I don't have a high-level understanding of the codebase. Missing critical knowledge about the organization makes it challenging to figure out where to jump into the code in the first place.

There are multiple factors for why any large-scale software project should invest in architecture documentation:
- [Program comprehension is time-consuming](#program-comprehension-is-time-consuming)
- [Developers are expensive](#developers-are-expensive)
- [Proliferation of system boundaries](#proliferation-of-system-boundaries)
- [Training more effective communicators](#training-more-effective-communicators)

At the end of this post, I also explore if [architecture documentation can be automated](#architecture-automation).

## Program comprehension is time-consuming

Even core developers may not always remember the details of the code. At my job, I am the founding mobile engineer and have implemented the mobile apps from scratch. The codebase is written by me, yet I still have times when I forget the organization for a particular feature or function. As the apps mature, the codebase will get increasingly complex and interdependent. Written documentation can remind even the most knowledgeable engineer about the architecture.

A wide range of research backs up the difficulty of comprehending codebases. A 2017 paper titled [Measuring Program Comprehension: A Large-Scale Field Study with Professionals](https://www.researchgate.net/publication/318811113_Measuring_Program_Comprehension_A_Large-Scale_Field_Study_with_Professionals) by Xia et al. concretely demonstrated that "program comprehension is an essential and time-consuming activity in software maintenance." The authors used sound methodology by collecting a large amount of real-world developer activity data, rather than artificial laboratory settings, to do the analysis (78 developers across 7 projects over 3,148 working hours).

The aggregate data found that developers spend the most time (58%) on program comprehension. The second most time was navigation through the codebase, categorized as an entirely separate activity. Editing only took up 5% of the time spent. Note that these averages are likely underestimates since the data doesn't take into account familiarity with the codebase itself.

<br />
![time_spent](/assets/img/posts/architecture-docs/time-spent.png)
*Research findings on average time spent in software development.*
<br />

The researchers also conducted interviews with 10 participants to assess why developers spent so much time on program comprehension. They classified 9 root causes, six of which can be categorized as insufficient general documentation.
- No comments or insufficient comments
- Meaningless classes/methods/variables names
- Navigating inheritance hierarchies
- Lack of documents, and ambiguous/incomplete document content
- Searching for the relevant documents
- Unfamiliarity with the business logic

<br />
![reasons](/assets/img/posts/architecture-docs/reasons.png)
*Root causes for why program comprehension took up so much time.*
<br />

The last four root causes (inheritance hierarchies, lack of documents, searching for relevant documents, unfamiliarity with business logic) can be directly addressed with better high-level architecture documentation. Since program comprehension is the largest share of time spent, streamlining comprehension can significantly impact developer velocity and quality of work.

Time spent on understanding codebases is not evenly distributed across senior and junior engineers. As Xia et al. found, senior engineers with 5+ years of professional experience only spend about 44% of total time on program comprehension. Contrast this with midlevel (3-5 years) and junior (<3 years) engineers who spend 56% and 66% of their time, respectively.

<br />
![seniority](/assets/img/posts/architecture-docs/seniority.png)
*Breakdown of time spent on program comprehension by seniority level.*
<br />

The findings have significant consequences depending on the makeup of the engineering teams. Teams with a larger proportion of junior engineers should invest more in architecture documentation since every incremental document has huge time-saving effects across the whole group.

<div class="twitter-container"><blockquote class="twitter-tweet tw-align-center"><p lang="en" dir="ltr">I can&#39;t say this enough.<br><br>You will read code more than you write code.<br><br>Learn to get good at it.</p>&mdash; Laurie (@laurieontech) <a href="https://twitter.com/laurieontech/status/1300422871328518146?ref_src=twsrc%5Etfw">August 31, 2020</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script></div>

## Developers are expensive

Open-source projects are usually understaffed, relying on a core set of developers and only occasional contributions from the community. Any way of increasing knowledge for these community members can have outsize effects. By making onboarding faster and easier, more changes could come from those occasional contributors. This significantly lightens the burden on core developers and reduces the bottleneck of limited engineering resources.

Profit-driven tech companies are usually able to hire enough developers to just meet their resource needs. However, there is still a cost to adding each additional engineer. In my experience, it takes at least three months for a new hire to onboard to a point where they are relatively proficient. It can take a year or more to be truly embedded, with a robust mental map of the codebase and enough context to jump immediately to the root cause of an issue.

According to HR tool [LuckyCarrot](https://luckycarrotapp.com/Employee-Turnover-Calculator), the average cost of replacing a fully-ramped up engineer with a new hire is $78,700:

<br />
![turnover](/assets/img/posts/architecture-docs/turnover.png)
*Estimated turnover cost is based on team size, average salary, and recruitment costs.*
<br />

This was calculated using conservative datapoints of $154,000 salary (using the average SF salary), recruitment costs only being 10% of salary, and managing to find a new employee within 30 days. Other calculations are in the same ballpark, [estimating $50,000 to hire and train a productive engineer](https://blog.usejournal.com/it-costs-50k-to-hire-a-software-engineer-d06a0d051abf). Both these estimates do not account for the cost of new engineers existing in a state between being proficient and deeply knowledgeable. 

Financial costs aside, it's still an expensive proposition to onboard new engineers. Hiring and training new people [takes time away from your most productive, experienced engineers](https://lethain.com/productivity-in-the-age-of-hypergrowth/). Any artifacts that can help build up these new engineers' mental models without explicit communication by more tenured folks are extremely high leverage. If we add in Kladov's recommendations to keep it simple and only document things that are unlikely to frequently change, the `ARCHITECTURE` file ends up being an extremely low-effort way to improve the expensive onboarding situation. 

As I begin building out a mobile team at my company ([we're hiring!](https://boards.greenhouse.io/pathlight)), you can bet that I'll be writing `ARCHITECTURE` files to help the new engineers build their mental maps as fast as possible.

## Proliferation of system boundaries

So companies, not just open-source projects, should be proactively writing high-level architecture descriptions. And in fact, I could argue that the `ARCHITECTURE` file is even more important at a software company than open-source projects.

Most open-source projects are relatively self-contained or have a limited set of boundaries with other systems. This is because open-source projects are by nature designed to be easily pulled into larger projects or adapted by others. A good open-source project should have the smallest possible footprint possible.

For most products built by tech companies, these incentives don't exist. There exists a huge variety of systems that grow increasingly complex over time as the feature set grows. Even a simple app that is just made up of mobile clients and a monolithic backend can be exceedingly convoluted to understand—each side can have dozens of dependencies, internal and external. Without high-level guidance, it can be almost impossible to grasp the system landscape as a newcomer, much less quickly diagnose an issue. Is the bug due to internal code or one of the many libraries that are being used? Does the issue occur on the client or in the backend?

As Kladov explains, a well-written `ARCHITECTURE` file should explicitly contribute to addressing this problem by shedding light on the interaction between systems:

> Point out boundaries between layers and systems as well. A boundary implicitly contains information about the implementation of the system behind it. It even constraints all _possible_ implementations. But finding a boundary by just randomly looking at the code is hard — good boundaries have measure zero.

## Training more effective communicators

Another reason to value the `ARCHITECTURE` file is that it creates an opportunity to practice architectural communication. I've found that the most effective senior engineers all have the ability to clearly express systems architecture to others.

Communicating architectural thinking is an entirely separate skill from implementing architectural changes. Like coding, being able to do something doesn't necessarily mean you are good at explaining it.

In my experience, it's pretty difficult to find the chance to practice architectural communication as a junior engineer. At large companies, most of this occurs when there is a new initiative or a large-scale refactor. There are few opportunities to drive these projects as a junior engineer since spearheading that work is usually delegated to folks who already have the experience. (If you do find one, my advice is to [seize onto it](https://medium.com/pinterest-engineering/supporting-react-native-at-pinterest-f8c2233f90e6) and never let go). At small startups, it can seem like a distraction to focus on formalized architecture communication when the team is still scrambling to find product-market fit.

Keep in mind that architecture docs don't always have to be written by the team's most senior people. It is a valuable learning opportunity for more junior teammates to write these documents and receive coaching from experienced engineers.
## Architecture automation

As I thought about all the benefits of documenting high-level architecture, I wondered whether it was possible to automate parts of writing it. Even though the `ARCHITECTURE` file is intentionally lightweight, it is still a manual process that relies on engineers to prioritize. It's easy for the team to forget or put off, especially because the benefits are not immediately visible. 

I've already spent some time thinking about the difficulty of navigating the structure of digital gardens, [brainstorming possible ways to simplify context-sharing and improve information delivery to readers](/blog/2020/10/18/digital-gardens/). Can something similar be done for engineering architecture? Is it possible to create tools to help identify important architectural concepts and critical system boundaries?

Products offering "code intelligence" are increasingly available. Sourcegraph, which provides universal code search and automatic code analysis, just raised a [$50M Series C round](https://about.sourcegraph.com/blog/series-c-with-sequoia/) in December 2020. Academic research is also making progress at locating [code smells](https://en.wikipedia.org/wiki/Code_smell), with advancements like automatically [detecting duplicate code and refactoring](https://www.researchgate.net/publication/340932700_Automation_of_duplicate_code_detection_and_refactoring) and adding [multi-language support](https://ieeexplore.ieee.org/document/89665160) for more practical applications. However, all these tools only offer data about code utilization and don't provide any overall system meta-analysis.

As far as I know, there aren't any tools that can generate architectural insights. [Sourcetrail](https://www.sourcetrail.com/) has a tagline heading in the right direction ("get productive on unfamiliar source code") but ultimately is simply a source code graph visualizer. It does not give high-level summarizations or suggestions that would help a human write `ARCHITECTURE` files.

It actually might be impossible to automate the process, at least to a level that doesn't require manual human intervention. Simon Brown, author of [Software Architecture for Developers](https://simonbrown.je) and the founder of architecture diagram tool [Structurizr](https://structurizr.com/), states that you just get "chaos" when you auto-generate architecture. Even in a reasonable codebase, the diagrams you can generate from code aren't helpful. From his talk [Visualize, Document, and Explore Your Software Architecture](https://academy.realm.io/posts/gotocph-simon-brown-visualize-document-explore-your-software-architecture/), Brown contends that it's impossible to reverse engineer a useful architecture diagram from the code itself:


<br />
![code_diagram](/assets/img/posts/architecture-docs/code-diagram.png)
*The [UML](https://en.wikipedia.org/wiki/Unified_Modeling_Language) diagram for a simple Javascript app running in the browser.*
<br />

> The diagram is showing us all of the code level elements and all of the relationships between them and it’s hard to pick out what the important parts of this code base are. Even with less than 1,00 lines the diagram is already useless, imagine if the code base was 100,000 or 1,000,000 lines; the diagram would become unreadable. This is simply because diagramming tools see code not components; they are unable to “zoom out” and show the user bigger abstractions, again creating a model-code gap.
> 
> Software engineers have been dealing with this problem for a long time. A paper was published in the 1990’s that noted that if you ask and engineer to draw a picture of their software, they will create a nice high level view. However if you reverse engineer a diagram from the code, the result is completely different. The reversed engineered diagram will be very accurate, but it’s not how the engineer thinks.

This suggests that the human brain's cognition is fundamentally separate from the underlying code that it models. The best mental representation of the codebase therefore cannot be found from the code structure itself. This idea shows up again later in the talk. According to Brown, the most important thing for architecture documentation is to capture all the information *you can't see from the codebase*. This is the bare minimum of important information. Automation would clearly be useless at capturing this information because it solely exists in people's brains, not visible in the code.

But despite Brown's argument to the contrary, I still bet there is plenty of room for tools to help identify and generate starting points for documentation.  Simply piping a code repository into a visualizer doesn't work, so we will have to get a little more creative at designing the tools.

A 2009 panel on [the future of software architecture documentation](https://www.infoq.com/articles/virtual-panel-arch-documentation/) proposed a possibility that we can embed architectural information directly into codebases:

> One of the reasons we need much of our architecture documentation today is because there's no way of representing architectural structures directly using the technologies we have at our disposal. I'd love to see our architectural constructs as first class implementation structures and then architecture documentation can evolve to capture decisions, rationale and analysis, rather than just capturing structures.

Some tools like [CodeScene](https://codescene.com/how-it-works/) are already making progress towards capturing the human aspects of coding. The tool offers "behavioral code analysis" in addition to the standard data analysis provided by code intelligence platforms. This new behavioral analysis looks at engineer activity and tracks how the codebase is being changed/evolved over time, then utilizes this information to find code quality and technical debt issues. 

Behavioral analysis techniques could be directly adapted for architectural purposes. Perhaps we can identify critical areas of the codebase that need documentation by looking at areas where the code rarely changes but is being heavily used throughout the rest of the system. There are opportunities to create tools that span multiple codebases, generating output that locates similar structures and attempts to model the relationship between those specific systems. We could even surface these suggestions as an interconnected graph representing the different codebases or areas within the codebase that need to be further inspected.

[Xia et al.](https://www.researchgate.net/publication/318811113_Measuring_Program_Comprehension_A_Large-Scale_Field_Study_with_Professionals) suggest a possible future tool that combines behavioral analysis and embedded architectural information to bridge the gap between junior and senior engineers more effectively. They write,

> [...] it would be interesting to develop a tool which can automatically monitor developers' behaviors when they perform program comprehension activities, and recommend best practices to developers to help them reduce program comprehension time. The best practices can possible be learnt automatically by mining the activities of senior developers.
>
> As an example, in a project team, we can analyze how senior developers navigate source code to acquire a good program understanding to perform various maintenance tasks (e.g. implementing newly requested features, fixing newly reported bugs, etc.). Based on senior developers' navigation patterns, we can build new behavior-driven change impact analysis and bug localization techniques. Given a particular source code file to change, we can recommend what other source code files and documentation to inspect to get the needed information to perform the change. [...] As another example, we can recommend sites that senior developers frequently visited to get information that is needed during program comprehension phase, or to learn new technology and tips to improve their skills.

I don't think there's anything fundamentally wrong with the concept of automated visualization. The underlying issue Brown identified was assuming we can capture _all_ useful architectural information through automatic generation. Instead, we might just need to be more targeted with what the visualization identifies and displays. These tools would provide _motivated_ visualization to answer a small subproblem about the architecture, rather than acting as a full standalone solution by itself. Humans would still be needed to analyze and integrate the information at the highest level, but the process would certainly be a lot easier than it is now.


<hr class="section-divider" />

I'm fascinated by the theory behind good software architecture. I am still early in my practice of effective architecture communication, so let me know if you have any good tips or useful tools! Share them with me on Twitter [@vivqu](https://twitter.com/vivqu) or send a note [here](mailto:hello@vivqu.com).

<hr class="section-divider" />

<footnote>This article was last updated on 3/1/2021. v1 is 2,831 words and took 10.55 hours to write and edit.</footnote>

