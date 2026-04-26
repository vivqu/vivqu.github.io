---
title: "Writing as theory-building"
subtitle: "Keeping the program alive"
published: true
source: false
seo_description: "writing science tech generative-ai"
tags: writing tech career
image: assets/img/posts/writing-theory-building/lunar-surface-surveyor-5.jpg
read_time: 16 min
---

_This is the third part on [writing as necessary friction](/blog/2026/02/22/writing-as-necessary-friction/)._

<img class="banner-image" src="/assets/img/posts/writing-theory-building/lunar-surface-surveyor-5.jpg" />
<em>"Lunar Surface Photographed by Surveyor 5" by NASA (from <a href="https://www.metmuseum.org/art/collection/search/284701" target="_blank">The Met Collection</a>)</em>
<br />

So far we've explored general reasons to write—to better [train your thinking](/blog/2026/02/22/writing-as-necessary-friction/) and [perceive reality](/blog/2026/03/01/writing-as-synchronizing-reality/).

I would argue that for scientists and engineers, writing is even more essential. In these highly complex domains, we operate at the limits of knowledge. The technical subject matter itself is challenging to understand and even more difficult to convey to others. We must be continually improving communication in order to push forward the state of the art.

I approach this from the perspective of software engineering, but it's equally relevant for mathematics, engineering, and other hard sciences.

<hr class="section-divider" />

In the 1985 paper titled [Programming as Theory Building](https://pages.cs.wisc.edu/~remzi/Naur.pdf), Peter Naur proposes that the primary challenge of software is not delivering the final artifacts—the code, specifications, and written documentation—but constructing the "theory" underlying the code. Naur argues that the tangible outputs of programming are actually a subset of the knowledge required to generate it. The abstract theory of the program takes time and effort to develop in the mind of programmers and is not straightforward to transfer to others.

Naur illustrates the need for such theoretical understanding using real-world case studies. In his clearest formulation, he compares two groups who are building a compiler. Group A has implemented the first version of the compiler, and in the process has developed a fully realized theory of the software. Group B are newcomers who have not worked on the compiler yet, and it is group B that is tasked with extending the capabilities of the compiler.

![naur-group-compiler](/assets/img/posts/writing-theory-building/naur-groups-compiler.png)
*Group A provides documentation and diagrams to Group B, along with the source code of the compiler itself.*
<br />

Group B is provided comprehensive resources such as full documentation, annotated program texts, and direct access to the compiler code. Most importantly, they also are provided direct human support from group A.

The compiler case study reveals that the personal advice and review from group A was necessary for success. Often the newcomers would not incorporate key information, even though it was present and available in the documentation. The missing context needed to be flagged by the first group of experts. Group B lacked a working mental model of the compiler and was thus repeatedly unable to arrive at the best solution.

What is most stunning about this example is not simply how Group A was crucial to detect design issues, but that the problems were identified _instantaneously_:

> In several major cases it turned out that the solutions suggested by group B were found by group A to make no use of the facilities that were not only inherent in the structure of the existing compiler but were discussed at length in its documentation, and to be based instead on additions to that structure in the form of patches that effectively destroyed its power and simplicity. The members of group A were able to spot these cases instantly and could propose simple and effective solutions, framed entirely within the existing structure. This is an example of how the full program text and additional documentation is insufficient in conveying to even the highly motivated group B the deeper insight into the design, that theory which is immediately present to the members of group A.

The code and documentation itself is clearly not sufficient at providing the full scope of knowledge for software development. A theoretical mental model needs to be built in the minds of new practitioners in order to match the effectiveness of experts.

The rest of the paper explores the manner in which theory transcends the recorded artifacts. Essentially, Naur argues that expert programmers have additional **world knowledge** that cannot be captured as specific rules or axioms. After all, if theory could be distilled into an easily shareable format then, by definition, the written documentation could be sufficient.

The required world information can only be defined by the expert programmer themselves,

> By far the largest part of the world aspects and activities will of course lie outside the scope of the program text, being irrelevant in the context. However, the decision that a part of the world is relevant can only be made by someone who understands the whole world. This understanding must be contributed by the programmer.
>
> \[...\]
>
> The programmer having the theory of the program is able to respond constructively to any demand for a modification of the program so as to support the affairs of the world in a new manner. Designing how a modification is best incorporated into an established program depends on the perception of the similarity of the new demand with the operational facilities already built into the program. The kind of similarity that has to be perceived is one between aspects of the world.

This human judgement is used to build nearly all facets of the theoretical knowledge, such as:

- what real-world requirements are important and how they relate to specific program details
- why each part of the program is written in a particular way
- how new constraints interact with previously held assumptions and the implications for modifying the program

Richard Hamming, telecommunications pioneer and mathematician who worked at the Manhattan Project and Bell Labs, said the same of experts in his recorded lectures from [The Art of Doing Science And Engineering](https://amzn.to/4aEUuMM),

> Another trouble is experts seem to use their subconscious, and they can only report their conscious experience in making a diagnosis. It has been estimated it takes about ten years of intensive work in a field to become an expert, and in this time many, many patterns are apparently laid down in the mind, from which the expert then makes a subconscious initial choice of how to approach the problem, as well as the subsequent steps to be used.

Given how subjective and intuitive the nature of theory-building is, it makes sense why transferring theory to others is inherently difficult. Humans cannot capture all the fine-grained details of reality with language alone. As John Muir once observed, spending a summer deep in the Sierra Nevada wilderness,

> When we try to pick out anything by itself we find that it is bound fast by a thousand invisible cords that cannot be broken, to everything in the universe.

<hr class="section-divider" />

Let's now return to writing. Even though theoretical understanding is impossible to directly transfer, the quality of communication does dramatically affect how well others are able to grasp the knowledge.

Naur's paper identifies metaphors as an especially effective way to align people's mental models, especially across increasingly large groups of people:

> The value of a good metaphor increases with the number of designers. The closer each person's guess is "close" to the other people's guesses, the greater the resulting consistency in the final system design. \[...\] An appropriate, shared metaphor lets a person guess accurately where someone else on the team just added code, and how to fit her new piece in with it.

We see this same difficulty in transferring knowledge extend to other technical disciplines, even with the aid of metaphor and other communication aids. Mathematics is a great example of this.

Professor Terence Tao uses the analogy of ["compilation errors"](https://terrytao.wordpress.com/advice-on-writing-papers/on-compilation-errors-in-mathematical-reading-and-how-to-resolve-them/) to describe the comprehension collapse of high-level mathematical proofs. Just like a compiler fails to process an otherwise flawless program that misses one semicolon, a human reader, even a very advanced one who makes serious effort to parse the text, can often be thrown into hopeless confusion by a single undefined term or typo. Tao proposes various approaches for the sophisticated student to try and overcome this: reading ahead to gather more information, isolating a single dimension of the proof, discarding portions of the paper to restrict focus to a simpler case.

But the most important technique, Tao argues, is to understand the author's intent. The impenetrability of a particular proof is a combination of both the difficulty of the subject matter and also the author's inability to fully express the concepts. There can be better and worse approaches to how the paper is written, he explains,

> Finally, and perhaps most importantly, reading becomes much easier when one can somehow “get into the author’s head”, and get a sense of what the author is trying to _do_ with each statement or lemma in the paper, rather than focusing purely on the literal statements in the text. A good author will interleave the mathematical text with commentary that is designed to do exactly this, but even without such explicit clues, one can often get a sense of the purpose of each component of the paper by comparing it with similar components in other papers, or by seeing how such a component is used in the rest of the paper.

Computer scientist and professor emeritus Dick Lipton uses the metaphor of [navigating cities](https://rjlipton.com/2011/05/06/navigating-cities-and-understanding-proofs/) to demonstrate the challenge of understanding proofs. Proofs, Lipton writes, are like dense urban megacities where it's easy to get lost when traveling between two locations. They must be actively navigated by the reader, and the reader can develop techniques that improve their ability to quickly travel from point A to point B, such as using Tao's helpful suggestions for struggling math students. But the city itself can also be constructed in a way that makes it easier or harder to navigate. The author should make the structure more modular and set the abstraction at the appropriate level, so that it's not unnecessarily difficult to understand.

However, the attempt to streamline language can only go so far. Lipton suggests avoiding excessive numbers of cases in a proof, but in certain areas like finite group theory "cases cannot always be avoided \[...\] special cases abound." We hit a hard limit in the ability to transform something inherently complicated into words that are easy to understand.

Fellow professor Eric Schechter reiterates this in his list of [most common errors in undergraduate mathematics](https://math.vanderbilt.edu/schectex/commerrs/#Unclear). The issue is fundamentally that English is not a perfect (or even adequate) medium for transmitting complex details,

>  The English language was not designed for mathematical clarity. Indeed, most of the English language was not really designed at all -- it simply grew. It is not always perfectly clear. Mathematicians must build their communication on top of English \[...\], and so they must work to overcome the weaknesses of English. Communicating clearly is an art that takes great practice, and that can never be entirely perfected.

When you work on the state-of-the-art in a domain, writing requires enormous amounts of creativity. There is no precedent or established forms that can encapsulate the intended meaning. Shorthand metaphors have not yet been invented or propagated across the field. So experts and leading scientists must use their full scope of their reasoning and imagination to express their knowledge.

Using this lens, it's unsurprising that many experts equate technical work directly with creative writing. Richard Hamming first asks, "Is programming closer to novel writing than it is to classical engineering?", and follows with a resounding "yes!". Naur relates the difficulty of building theory in programmers to that of teaching creative writing. Both activities require more than just rote memorization, where "knowledge of how to do certain things dominates over the knowledge that certain things are the case." Writers and scientists constantly exist at the edge of their competence, pushing to go beyond their current skills and knowledge.

The practice of writing can not only benefit your peers and colleagues, but also it helps the individual too. Documenting my work with my best effort to communicate will make it easier for readers to learn and collaborate with me. The reader can be other people, but sometimes it's also me in the future.

Nicola Tietz-Sokolskaya writes about the many benefits of [using an engineering notebook](https://ntietz.com/blog/using-an-engineering-notebook/), chief among them that keeping a notebook facilitates memory and clarity of thought. She emphasizes that,

> The level of detail is a particularly crucial bit, because, for your notes to be useful to yourself later? They have to be useful to someone else, too. Future you _is_ someone else: you won't remember everything. So you have to assume you'll forget much of it.

This echoes my own experience and those of other seasoned software engineers. Lars Wirzenius, when [sharing learnings from his 40-year career](https://liw.fi/40/) in programming, notes that "even in the projects where I'm the only person, there are at least three people involved: past me, present me, and future me."

Everyone with a long-enough career in software has a story that goes something like this: you encounter a piece of code which is written oddly. You think "what dummy wrote this" and open up your source control to see the producer of the bad code. You discover that you were the one who wrote it.

Constructing and keeping up the mental context for a complex project takes ongoing effort. Without that active maintenance, the theory easily degrades and quickly disappears. It's why context switching is so costly. It explains how a human can spend hundreds of hours writing a program by hand, intimately familiar with the rationale behind every single line, only to return to it a few months later with zero recognition.

My present self approaches my own past efforts with the mind of an effective stranger. So any writing artifacts are just as useful to me as anyone else.

<hr class="section-divider" />

The most useful concept in Naur's entire paper is the concept of a "dead program". He defines the death of a piece of software not when it stops being functional, but "when the programmer team possessing its theory is dissolved."

The symptoms of death are only revealed when that software needs to be modified or upgraded in some way. Lacking experts with a working mental model, the dead program becomes something like a ticking time bomb. Minor changes in functionality are more costly than they should be. Even small changes can even risk potential catastrophic failure because the new maintainer stumbles into an unexpected design decision of the original system.

It's often the lesser of two evils to completely rewrite from the ground up rather than attempt a "revival" of the program. Rebuilding the mental theory, especially of massively complex interconnected systems or an ancient cryptic module deeply embedded in the stack, is frequently more time-intensive than just throwing it all away and starting fresh. The painful nature and costliness to reboot mental models goes a long way in explaining why we as a industry [keep attempting full system rewrites](https://vivqu.com/blog/2022/01/01/engineering-disasters/), often to equally disastrous consequences.

![dependency-xkcd](https://imgs.xkcd.com/comics/dependency.png)
*Sometimes a small open source contributor thanklessly keeps a small program alive, and it becomes a core <a href="https://xkcd.com/2347/" target="_blank">dependency</a> of modern digital infrastructure.*

All of the exploration of the need for theory-building and the role of writing in this process brings us to the interesting question of how generative AI fits into the equation. There's no denying that [autonomous code generation](/blog/2025/06/29/no-accounting-for-taste/) is going to form essential parts of the future of software programming. However, I think engineers and scientists risk a lot by fully detaching from the details of the system that they are building.

What coding assistants and AI agents mask with their generalized capabilities and eager hallucinations is the lack of a fully constructed mental theory. If you don't explicitly specify the behavior of a core part of your system but you ask for a functional end result, AI will cheerfully vibe code all of it by nondeterministically outputting whatever is best represented in it's model weights. Maybe this works for the majority of cases, maybe even up to a certain level of complexity with advancing frontier model capabilities, but the lack of comprehension will inevitably show up in first subtle and then increasingly obvious ways.

Many people are attempting to building software and [write mathematics proofs](https://importai.substack.com/p/import-ai-444-llm-societies-huawei) with no sense of how the internal structures are constructed, with unknown key architectural decisions, with no concept how easy or hard it is to navigate through Lipton's metaphorical city.

The programs are dead from the start.

<hr class="section-divider" />

The current AI era of software has started to realize this danger again, rebranding Naur's concept of dead programs as ["cognitive debt"](https://www.media.mit.edu/publications/your-brain-on-chatgpt/). In an [excellent essay](https://margaretstorey.com/blog/2026/02/09/cognitive-debt/) from February 2026 by Professor Margaret Storey, which cites Naur's paper and calls for more research on the impact of cognitive debt in AI workflows, she states simply, "velocity without understanding is not sustainable."

For the daily software practitioner who is not necessarily engaged in frontier research, fully generated solutions work fine for small-scoped or throwaway programs. But for larger complex projects, the cognitive debt appears to quietly compound until it grinds vibe-coded software to a halt at [around 70% completion](https://addyo.substack.com/p/the-70-problem-hard-truths-about). We are still in the early days of understanding how to work with these tools and how to offset our mental theory collapse.

For advanced experts using AI for cutting-edge advancements, we are even further away from being able to fully abandon cognitive effort to machines. From the recent paper on using [Gemini to generate proofs for Erdös problems](https://arxiv.org/abs/2601.22401),

> Large Language Models can easily generate candidate solutions, but the number of experts who can judge the correctness of a solution is relatively small, and even for experts, substantial time is required to carry out such evaluations. As AI-generated mathematics grows, the community must remain vigilant of “subconscious plagiarism”, whereby AI reproduces knowledge of the literature acquired during training, without proper acknowledgment. Note that formal verification cannot help with any of these difficulties.

The important caveat here is that it still takes significant effort ("substantial time") from a small set of qualified individuals to even evaluate the success, or lack thereof, of these LLM-assisted discoveries. The world models of these experts may be increasingly more precious, rather than less, as we attempt to judge the quality of the AI outputs.

And besides the undercutting our own ability to think and understand the work itself, usage of AI tools also appears to be simply exhausting. Studies are still [mixed on the actual productivity gains](https://aleximas.substack.com/p/what-is-the-impact-of-ai-on-productivity), but reports are now emerging of the intensified [mental burden and burnout](https://hbr.org/2026/02/ai-doesnt-reduce-work-it-intensifies-it) from increased task load and context-switching. 

Worst of all, we may be removing the opportunity for the subconscious workings of our minds when we deeply concentrate on a single subject. 

As this [fascinating piece on AI-assisted fiction writing from The Verge](https://www.theverge.com/c/23194235/ai-fiction-writing-amazon-kindle-sudowrite-jasper) describes, we lose an integral part of the creative process when fully surrendering control to AI. Jennifer Lepp, a self-published writer increasingly relying on generative AI tools, explains the first-hand experience of the cognition of her work degrading:

> Writing, for her, had always been a fully immersive process. She would dream about her characters and wake up thinking about them. As the AI took on more of the work, she realized that had stopped.
>
> "I started going to sleep, and I wasn't thinking about the story anymore. And then I went back to write and sat down, and I would forget why people were doing things. Or I'd have to look up what somebody said because I lost the thread of truth," she said. \[...\] Rather than guiding the AI, she started to think she had "followed the AI down the rabbit hole."

The previous mental effort of writing was actually doing a lot to encode the information into Lepp's brain. Even the material you produce can quickly disappear into a mental void, the neurons easily pruned away, if you don't sufficiently embed it deeply enough. The persistence of details can vanish. It’s why the gulf between reading something and truly knowing it can be vast.

We will need to carefully consider how these tools are actually helping or hurting our ability to do the most essential work of technical innovation. Building and maintaining the mental models for projects and proofs takes enormous cognitive effort and willpower, often cultivated over decades. It's extremely hard even with the collaboration of fellow humans, documentation, other artifacts, and now generative AI. It demands an ongoing and never-ending investment into improving one's communication and writing skills.

<hr class="section-divider" />

The path forward for engineering and sciences will still be humans in the driver's seat of innovation. The scientist will use [AI as an instrument]() to more rapidly bootstrap their world models so that they can design new inventions and make discoveries. Tools may help shape communication but can never fully replace it, both for the communicator and the receiver. The LLM models and most humans will always be far behind the bleeding edge of a domain, and only continual concentrated effort by experts can keep a mental model up-to-date at the limits of existing knowledge.

Professor Terence Tao gave an interview in February 2026 on [The Edge of Mathematics](https://www.theatlantic.com/technology/2026/02/ai-math-terrance-tao/686107/) where he predicts the shape of future mathematics advancements, discussing the potential for "hybrid, human-AI contributions." But his perspective is more measured and balanced than AI enthusiasts. Tao calls out the need for "responsible AI use" and the essential work of theoretical comprehension:

> **Wong:** You’ve [written](https://web.archive.org/web/20260313171005/https://github.com/teorth/erdosproblems/wiki/Disclaimers-and-caveats#11-problem-solving-is-only-one-component-of-the-mathematical-research-process) that when human mathematicians approach a new problem, regardless of whether they succeed, they produce insights that others in the field can build on—something AI-based proofs don’t provide. How come?
> 
> **Tao:** These problems are like distant locations that you would hike to. And in the past, you would have to go on a journey. You can lay down trail markers that other people could follow, and you could make maps.
> 
> AI tools are like taking a helicopter to drop you off at the site. You miss all the benefits of the journey itself. You just get right to the destination, which actually was only just a part of the value of solving these problems.
>
> There’s a middle ground where we want to encourage responsible AI use and discourage irresponsible AI use. It is a delicate line to tread. But we’ve done it before. Mathematicians routinely use computers to do numerical work, and there was a lot of backlash initially when computer-assisted proofs first came out, because how can you trust computer code? But we’ve figured that out over 20 or 30 years. Unfortunately, the timelines are much more compressed now. So we have to figure out our standards within a few years. And our community does not move that fast, normally.

So how do we use AI responsibly? How do we keep both actively theory-building and subconsciously dreaming about our work, so that we can still make the most critical intuitive leaps? How do we guard ourselves from going down rabbit holes and instead utilize all instruments in our grasp to advance the limit of human knowledge?

I believe writing is an integral part of the answer to this question. It forces a person to compress their expansive mental theories into the lossy, inaccurate form of language. Metaphors, narratives, clearly sign-posted paths through the dark forest of complex reasoning, these are all useful tools in our theory-building toolkit. 

If you don't believe me, try this yourself. Come back later in a week and try outlining all the points I’ve made in this essay. I really doubt you can do it without any external communication--whether that is note-taking, explaining it to others, or formulating a written response. Writing is one of the best ways to compact information and engrave it onto the messy biological medium of gray matter, so that those concepts are more fully retained to do your best thinking.

<hr class="section-divider" />

Read the final part of the series — [writing as aliveness](/blog/2026/04/26/writing-as-aliveness/).

<hr class="section-divider" />

<footer>This article was last updated on 04/26/2026. v1 is 3,870 words and took 6.5 hours to write and edit.</footer>