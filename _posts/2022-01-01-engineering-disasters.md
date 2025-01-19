---
title: "Patterns of engineering disasters"
subtitle: "An incomplete collection of failed rewrites, refactors, and other engineering mishaps"
published: true
source: false
seo_description: "software engineering architecture communication management failure"
tags: tech writing
image: assets/img/posts/engineering-disasters/computer-panic.jpg
read_time: 4 min
---

<p class="source">
<a href="#list-of-engineering-disasters">Click here</a> to skip the introduction and go straight to the links.
</p>

## Studying catastrophic project failures

Many engineers, myself included, like to believe engineering is a fundamentally rational
discipline. We spend our work hours carefully implementing complicated algorithms, instrumenting
tests to validate program execution, and weighing technical tradeoffs to achieve the optimal outcome.
Given that everyone building technology should be imminently logical, it's easy to assume that
engineering disasters are mostly a failure of imagination and forethought. "If only the team had
anticipated these potential edge cases then the execution would have been flawless," etc.

The longer I do software engineering, the more I realize the many messy human emotions
involved. Developing technical projects is like any other enterprise undertaken by a group of people
working together—ego, ideological stances, cognitive biases, mismanagement, and politics are all
irrational factors involved in the process.

I don't think it's an exaggeration to say that the worst engineering projects all boil down to human drama.
Personal experience and horror stories from friends and industry all point to this pattern. The ultra-rational
stereotype of engineers does more harm than good in these situations because no one can accept or admit that
the project is a trainwreck. Perhaps it was originally started with the wrong motivations, promised 
unrealistic deliverables, or had so much scope creep [pork-barrelled](https://en.wikipedia.org/wiki/Pork_barrel) into 
it that it was doomed to fail. Engineering disasters can happen even if the workplace does not have a toxic environment,
though having a toxic culture probably generates even more than your average amount of engineering crises. And all these
initiatives end up accruing enormous unanticipated costs along the way, both in terms of the project itself as well as 
the emotional toll on the team.

Below is an ongoing list of mishaps and crises in software engineering teams. The stories demonstrate that well-intentioned 
and rational people can end up in emotionally intense, stressful situations. Every time I re-read them, I am reminded
to be humble, to hope that I can gain some kernels of wisdom to help diffuse and de-escalate future disasters I find
myself in. I try to internalize these learnings so that I can be kind to myself and my teammates if and when a 
project trainwreck is unavoidable. It's helpful to realize that prestigious companies with seasoned veteran engineers
are not immune to engineering disasters. Neither are brilliant individual contributors who, having survived one disaster,
may find themselves in a different kind of chaotic mess in the future.

The biggest reason I think that engineering disasters happen so reliably, eventually appearing at least once in an individual's career,
is the seductive danger of ["leverage points" thinking](https://donellameadows.org/archives/leverage-points-places-to-intervene-in-a-system/)—in other words, hoping that a relatively small amount of effort can cause massive changes in complex systems. We software engineers are 
particularly susceptible to this thinking. If only we had used the right architecture, if only we can quickly execute this rewrite 
or refactor, all our painful problems will be solved. All of the stories in the collection have some element of this wishful thinking,
causing people to dig in their heels and refuse to change course. As Donella H. Meadows perfectly sums up in the conclusion of her essay,

> Magical leverage points are not easily accessible, even if we know where they are and which direction to push on them.
> There are no cheap tickets to mastery. You have to work hard at it, whether that means rigorously analyzing a system or
> rigorously casting off your own paradigms and throwing yourself into the humility of Not Knowing. In the end, it seems
> that mastery has less to do with pushing leverage points than it does with strategically, profoundly, madly letting go.

Here is the same sentiment again, from Frederick Brooks' paper [No Silver Bullet](http://www.cs.unc.edu/techreports/86-020.pdf)
from 1986:

> Not only are there no silver bullets now in view, the very nature of software makes it unlikely that there will be any -
> no inventions that will do for software productivity, reliability, and simplicity what electronics, transistors, large-scale
> integration did for computer hardware. [...] The hardest single part of building a software system is deciding precisely what to build.
> No other part of the conceptual work is so difficult as establishing the detailed technical requirements, including all the 
> interfaces to people, to machines, and to other software systems. No other part of the work so cripples the resulting system
> if done wrong. No other part is more difficult to rectify later. [...] The central question in how to improve the software art centers,
> as it always has, on people. 

## List of engineering disasters

- [Rewriting Uber's app from scratch](https://threadreaderapp.com/thread/1336890442768547845.html): "a tale of politics, architecture and the sunk cost fallacy", and some other versions ([1](https://blog.pragmaticengineer.com/uber-app-rewrite-yolo/), [2](https://cbrauchli.medium.com/binary-size-woes-acb5d96f058a), [3](https://news.ycombinator.com/item?id=25374838))
- [The mistake of rewriting products](https://www.platohq.com/resources/the-mistake-of-rewriting-products): "You do one rewrite in your career and then never again"
- [Digg's v4 launch: an optimism born of necessity](https://lethain.com/digg-v4/): "We were naive. Our education lay in wait."
- [Things you should never do, Part 1](https://www.joelonsoftware.com/2000/04/06/things-you-should-never-do-part-i/): "making the single worst strategic mistake that any software company can make"

<hr class="section-divider" />

<footer>This article was last updated on 1/18/2022. v1 is 822 words and took 4.5 hours to write and edit.</footer>
