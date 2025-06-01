---
title: "GenAI is not a silver bullet"
subtitle: "How LLMs won't fix software engineering"
published: true
source: false
seo_description: "gen-ai software-engineering"
tags: tech work
image: assets/img/posts/gen-ai-silver-bullet/software-design.jpg
read_time: 8 min
---

As someone who works in tech, you can barely go a full day without getting confronted with debates about how generative AI is going to affect the industry. The predictions vary wildly in terms of the expected scope and impact, with arguments constantly shifting and evolving with every new release as the frontier labs duke it out for market dominance.

One one side, you have the extreme and dire warnings about AI upending the entire practice of building software. [Engineers are obsolete](https://jagilley.github.io/faang-blog.html), the [sky-high compensation](https://www.seangoedecke.com/tactical-work-in-the-age-of-layoffs/) will vanish, and everyone who remains will be some kind of business-technical hybrid that solely exists to dictate product specifications to the code-writing computers. 

On the other side are folks dismissing AI as overhyped and underwhelming. Sure, these coding assistants may be enabling a new generation of vibe coders to spit out instantaneous vaporware full of security holes and spaghetti code, but there is little in the way of production-level code that can be released without humans handholding the AI the entire way.

The answer, like most other technological innovations, will be somewhere in between. While it is dramatic to imagine total upheaval or a total no-op, the middle path is not exciting to talk about. I believe the industry will change in some very significant ways in terms of how we organize and build software, but largely the practice of software engineering for skilled programmers will be the same. After all, tools of our trade are constantly being built and rebuilt by ourselves and our compatriots in the first place. It will take a long time, maybe a decade or more, for generative AI to become ["normal technology"](https://www.aisnakeoil.com/p/ai-as-normal-technology) inside tech companies alone.

I'm fairly confident in the boring middle-of-the-road outcome here. I've been working in industry long enough to see several boom-bust hype cycles. Founders and tech luminaries repeatedly overpromise and underdeliver on products in the five-to-ten-year time horizon. Just see self-driving cars, the gig economy, and cryptocurrency. 

Even the release of the smartphone, and the corresponding monumental shift towards mobile development, took 20 years to go mainstream with public consumers. Even after Apple released the App Store in 2007, it took at least a decade for mobile programmers to get trained up into the industry (anyone else remember [so-lo-mo](https://youtu.be/B8C5sjjhsso?si=VZhSEZEiwr7LF-QG)?). Best practices continue to change. Arguably, the "right way" to do software development on mobile is still being disputed, with changes in accepted technologies and redistribution of engineering staffing constantly happening.

<br/>
<div class="iframe-wrapper">
<iframe width="560" height="315" src="https://www.youtube.com/embed/B8C5sjjhsso?si=MisVepFbWD-zIWnl" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>
</div>
<em class="video-subtitle">I had to stop watching HBO's Silicon Valley because it was too painfully accurate.</em>
<br/>

## The core of software engineering

Generative AI will not be a silver bullet. As Fred Brooks [wrote back in 1986](/assets/pdf/Brooks_No_Silver_Bullet.pdf), 

> There is no single development, in either technology or management technique, which itself promises even one order-of-magnitude improvement within a decade in productivity, in reliability, in simplicity.

The reason that AI will not provide a revolutionary breakthrough is because the "conceptual essence" of software is one of abstract, creative problem-solving. The hardest parts of building software is defining the specifications, design, and testing of a solution to address a theoretical problem space. The difficulty of translating that conceptual abstraction into a concrete implementation is only incidental, and the speedups we get from AI will only address the labor of coding the implementation rather than burden of choosing what to build itself.

Pete McBreen argues that software is much more free-form and creative than other engineering disciplines, and proposes the term "software craftsmanship" is more accurate in his book [Software Craftsmanship: The New Imperative](https://learning.oreilly.com/library/view/software-craftsmanship-the/0201733862/):

> Software development is all about the unknown. The production process for software is trivially easy—just copy a disk or CD. The software engineering metaphor fails because we understand production, a mechanical task, much better than we understand design, an intellectual task.

At my experience level, my ability to successfully ship software projects is never limited by coding knowledge or even the time to code. What does block me from being able to deliver is:
- **Decision-making**: waiting for other stakeholders who need to weigh in on key product or technical decisions, disagreements in _what_ to work on or build
- **Misunderstanding the problem space**: holding the wrong assumptions about the market or end users, measuring or tracking the wrong things, the end user not understanding the product (marketing, discoverability, in-product education)
- **Planning constraints**: staffing resources not matching the demanded deadlines, short-term vs long-term tradeoffs, thrash created by changing priorities

These are not problems that AI-assisted coding can solve because they are fundamentally people problems. As Lars Wirzenius writes in his reflections on [40 years of programming](https://liw.fi/40/):

> Interesting and significant software is beyond the capacity of any one person to build alone in a reasonable time frame. This means that the fundamental, crucial, core skills in building software are communication and collaboration.

The way to actually improve the art of software engineering, as outlined by Brooks, is through discovering and training great software designers. 

> Whereas the difference between poor conceptual designs and good ones may lie in the soundness of design method, the difference between good designs and great ones surely does not. Great designs come from great designers. Software construction is a creative process. Sound methodology can empower and liberate the creative mind; it cannot enflame or inspire the drudge.
> 
> The differences are not minor—it is rather like Salieri and Mozart. Study after study shows that the very best designers produce structures that are faster, smaller, simpler, cleaner, and produced with less effort. The differences between the great and the average approach an order of magnitude.

I think this is just as important as ever. And one big concern I have is many companies buying into the LLM hype and defunding their engineering teams. As we discuss in the next section, the current benefits of generative AI in coding is relatively limited. We risk [kneecapping our own industry](https://charity.wtf/2024/06/10/generative-ai-is-not-going-to-build-your-engineering-team-for-you/) for a long time by [underinvesting in junior engineers](https://skamille.medium.com/things-i-currently-believe-about-ai-and-tech-employment-3e712df1dc51) and missing out on great software talent.

## How LLMs are actually useful

My experience of using generative AI in my regular coding workflows is that it is very helpful in narrow, targeted contexts. Once I have already planned out what to build, I can get minor boosts in productivity from AI help me code or find specific answers even faster. Code autocomplete is actually situationally aware and significantly more helpful than a few years ago. And now instead of googling or looking up two different parts of Swift syntax in the official Apple documentation, I can ask for a summary of the differences. For infrequent tasks where I am constantly forgetting the programming details, AI is a fantastic replacement for manually finding examples. I no longer have to search through the codebase for references on mocking to skeleton out my own unit tests, I can prompt the LLM to do this for me. 

I still have to watch the LLM-generated output very carefully to validate the generated summaries and make sure the code outputs works correctly. More than half the time, its proposed solutions to fix basic compiler warnings don't work at all. LLMs get a lot of complex edge cases in regular programming languages completely wrong, especially in newer languages like Swift where there is a less history in it's vast training data. In these cases, it really reveals how it's just regurgitating some random crap because its missing adequate context.

This is further exacerbated in my FAANG job where all our tools and code are propriety. Even though the [internal close-sourced version of Llama](https://fortune.com/2024/12/03/meta-openai-gpt-4-llama-coding-tool/) is trained on the entire corpus of company code and documents, it's simply not comprehensive enough. These fine-tuned specialized models face the most human of issues: the fact that people are very bad at writing down what's in their head. Most of the time it's simply faster to manually search through our massive company wikis or chase down the right owner rather than play guess-and-check with the model output.

A lot of experienced active practitioners agree with me:
- Max Woolf [discusses his limited usage of LLMs for coding](https://minimaxir.com/2025/05/llm-use/#llms-for-coding)
- Gavin Leech [doesn't use LLMs](https://www.gleech.org/llms) for deep work
- Manuel Kießling on [AI models needing to be directed in order to be effective](https://manuel.kiessling.net/2025/03/31/how-seasoned-developers-can-achieve-great-results-with-ai-coding-agents/)
- Birgitta Böckeler on [the constant need for human steering with agentic coding](https://martinfowler.com/articles/exploring-gen-ai/13-role-of-developer-skills.html)
- Simon Willison [treats LLMs as the equivalent of an intern for production code](https://simonwillison.net/2024/Sep/20/using-llms-for-code/)

There are still plenty of situations where LLMs are enormously helpful in software development. Prototyping, bootstrapping greenfield projects, brainstorming various approaches to technical problems are all good use cases. For my personal projects, I use it extensively for doing all the last mile work to get from a coding project to an actual packaged product. There is so much fine detail polish to get something from v0 to a production-level v1 that falls outside of pure technical work. Marketing, writing copy, setting up a splash page are all necessary to explain to users what your software does. These are things I don't have to deal with in my day job with a fully staffed cross-functional team. Generative AI can help transform my shitty output into something that is at least not embarrassing through boosting my limited skills. A few rounds of back-and-forth refinement usually results in a decent result. 

That being said, my personal stance is that I will never commit code or publish writing generated by an LLM without closely reviewing and modifying it myself. Vibe coding might be fine for fun hobby projects or technical explorations, but there is a standard of professional behavior I uphold for production code. Even if you could guarantee me that the AI will 100% generate clean, readable, bug-free code, I would still review it. After all, I am putting my name on this work at the end of the day. Even with human teammates whose technical abilities I implicitly trust, there are only a handful of extremely limited urgent scenarios (production incidents and SEVs) where I might blindly accept their code without understanding it. 

And even if I'm not [pushing out garbage AI slop](https://www.theatlantic.com/technology/archive/2025/05/ai-written-newspaper-chicago-sun-times/682861/) without human review, the style and taste of code I output is just as important to me as making sure it functions correctly. These are hard-won parts of my professional identity that have taken more than a decade of experience to cultivate. The importance of taste and how to develop it will be the topic of a future essay.

Maybe one day we will be able to upgrade AI-generated code into another ubiquitous layer in the software development stack. The practice of software engineering will then be able to move to another level of abstraction, analogous to the transition from assembly code to high-level programming languages. In this world, AI-generated code would be so common and reliable that it could just be accepted without significant manual review.

Yet I still don't believe this will obviate the need for software engineers and deep technical craft. As the [fundamental theorem of software engineering](https://en.m.wikipedia.org/wiki/Fundamental_theorem_of_software_engineering) goes,

> We can solve any problem by introducing an extra level of indirection.

Which is usually immediately followed immediately by "...except for the problem of too many levels of indirection."

So I'm sure we'll have absolutely no problems at all if we make generated AI code part of the fundamental infrastructure of developing software while underinvesting in software engineers. No problems at all.


<hr class="section-divider" />

<footer>This article was last updated on 6/1/2025. v1 is 1,876 words and took 4.25 hours to write and edit.</footer>

