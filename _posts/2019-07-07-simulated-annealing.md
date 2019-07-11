---
title: "Simulated Annealing: a framework for life decision-making"
subtitle: "Discovering what you truly want and reaching a decent outcome"
published: false
source: false
# seo_description: "zen-buddhism zen-and-the-art-of-archery handstands meditation"
# tags: zen handstands mind-body-duality
---

I enjoy learning about different systems for living a good life. These can range from specific productivity practices to high-level formulations that attempt to reimagine the very concept of meaning in your life.

I am an efficient software engineer so I dislike repeating work to rebuild tools that already exist in the wild. There already are many of these systems that others have written in detail about, and I have found many useful for improving various aspects of my life. ([At the bottom of this article](#a-list-of-other-life-frameworks), you can find a list of the ones I find particularly interesting and thoughtful.)

Yet here I am, writing about a new framework. So I must feel strongly enough that this is adding something new to the conversation. 

__Simulated annealing is a framework for life decision-making__. It can help you get to a pretty decent outcome for anything meaningful you are striving for in your life. Specifically, it tackles the following fundamental assumptions that others don't directly address: 

1. Humans are very bad at knowing what they want
2. Humans are also bad at understanding probability
3. Humans want to control how they grow and change

<br>
## Simulated Annealing 101

[Simulated annealing (SA)](https://en.wikipedia.org/wiki/Simulated_annealing) is a concept from computer science and applied mathematics. I first learned about it in college while taking a class about artificial intelligence. We wrote toy programs to outcompete each other using various algorithms and strategies. SA is one of those strategies that turns out to have very practical implifications for life.

SA is a great strategy __under certain conditions__; specifically, when you have 

- A massive search space or unmanageably large number of combinations
- Incomplete information, and
- Limited time

Given these constraints, SA can find a very good solution. Note that it does not necessarily guarantee finding the overall optimal solution. 

I can't think of a better description for the general conditions of life. Humans have seemingly infinite options for what to do in life. However, we can't spend forever searching for the best solution since we have a limited amount of time in our lifespans. So how do we look for the best possible outcome given this reality?

Simulated annealing is an improvement on naive search optimizations, like hill climbing, with two special "tricks":

1. Search the current set of available options for the best choice.

2. __Trick #1 (jump)__: At some probabilistic interval, jump to a new area in the search space and begin searching even if the new area has a worse state than the original area.

3. __Trick #2 (slowdown)__: Over time, decrease the amount of negative value you are willing to accept to jump to new states. This means that you only accept smaller and smaller differences in the current and new states when jumping, until you eventually stop jumping to new areas.

This will be summarized as the __search-jump-slowdown cycle__. It is a bit of an oversimplification but hopefully you get the idea. The name and inspiration actually came from the metallurgical process of [annealing](https://en.wikipedia.org/wiki/Annealing_(metallurgy)), a technique to reduce defects in metal by the heating and controlled cooling of the metal.

Simulated annealing is innovative is because it overcomes a major hurdle of more basic heuristics: __getting stuck on local optima__. 

If you naively search by greedily choosing the best out of visible choices, how do you know the final "best" choice is truly the global optimum? Life is an incomplete information game and you are searching among endless possibilities, so optimizing from an arbitrary starting point is likely to just get you to a overall mediocre outcome.

![process](/assets/img/posts/simulated-annealing/process.png)
*Searching for the highest peak using simulated annealing, with two jump phases.*

<br>
## A practical example

Let's try a practical example: finding a new sport to do as a hobby. You have a set of criteria you want for your hobby: you want it to be fun, improve your health and fitness, and maybe even be a sport you can get skilled at given your natural talents.

![sports-base](/assets/img/posts/simulated-annealing/sports-base.png)
*The available search space for your new hobby.*

An easy first __simple initial search method__ is trying out sports related to your past experience. Suppose you were a runner in high school; you might begin by signing up for a local running group and maybe a team relay race with friends. Finding the best option within these choices is easy. You can even expand your consideration to sports with a big running component prett quickly, like ultimate frisbee or soccer. 

![sports-running](/assets/img/posts/simulated-annealing/sports-running.png)
*Searching among all running-related sports.*

You're currently searching in the space of "running-related" sports. But what if there exists sports outside of this range that would be better suited for you? More fun _and_ faster improvement curve for your skill and physical fitness? What if it had nothing to do with running at all?

Many people at this point prefer not to deal with the uncertainty of whether running-related sports are best suited for them. They buckle down and commit to their running-type sport. It would be impossibly time-consuming to exhaustively try new sports one after the other.

And even if you're wiling to try out other sports, society doesn't teach us a good method to start or stop our searching. Maybe you try a few vastly different sports at random, until you get too busy or demotivated to keep looking. Perhaps you get lucky and have a friend or members of your local community introduce you to a great new sport. However both these approaches don't constitute systemic ways of thinking; random searches based on willpower and relying on others are not reproducible decision-making patterns.

<div class="float-left">
    <img src="/assets/img/posts/simulated-annealing/sports-jump.png" alt="sports-jump">
</div>

Simulated annealing offers a practical, systematic approach to searching for that new sport. After an initial search phase of "running-related" sports, you should __jump to a radically new area__. Importantly, you should spend time to explore the new area even if it's worse than the current state.

Let's say we choose to try surfing. If you end up enjoying it, then you can straightforwardly switch to surfing as your main sports hobby. But if it is neutral to deeply horrible, you shouldn't necessarily swear off all watersports. Following a simulated annealing strategy encourages you to do a little more searching in adjacent, related sports. It may turn out that the _best_ watersport for you is actually superior to the best running-related sport.

![water-sports](/assets/img/posts/simulated-annealing/sports-graph-1.png)
*You might stop searching the space of watersports before you realize you love kite surfing.*

The second trick of simulated annealing is also extremely suitable for life decision-making. Since we can't search forever, we gradually reduce the __number times we jump__ and __how willing we are to suffer through new (bad) sports experiences__. In our simple example for finding a new sports hobby, probably exploring 3-4 new categories of sports is sufficient to make up your mind. You slowly settle on your favorite sports hobby after searching through a much larger set of sports than you otherwise might have. 

![best-sport](/assets/img/posts/simulated-annealing/sports-graph-2.png)
*After repeating a few jump iterations, you conclude squash is the best sport for you.*

So by not searching endlessly or until whatever point you are exhausted, you still have time to play and enjoy your chosen hobby. And because you have been deliberately searching through very different options, you have steadily increased the degree of certainty that the final sport is very suitable for you.

Which now brings us to how simulated annealing addresses those three fundamental assumptions...
<br><br>
## 1. Humans are very bad at knowing what they want

Many life philosophies are created in order to streamline your focus and output based on _what you want to do._

But if humans actually are very bad at predicting their own desires, then those systems are doomed. Hacking your productivity or sticking to habits is useless if you made choices based on the wrong preferences. People will be left with a lot of existential angst and regret when they spend too much time pursuing ultimately unsatisfying results.

There are many factors that can contribute to someone incorrectly assessing their personal preferences. Preferences may change. Individuals can be influenced by what society says is the best or which is the most socially-approved choice. There is even evidence of a human cognitive bias called the [introspection illusion](https://en.wikipedia.org/wiki/Introspection_illusion), where we tend to believe we have direct insight into our own mental states while other people's introspections are regarded as unreliable. This bias can lead to people falsely explaining causes for their behavior or inaccurately predicting future mental states.

Simulated annealing is unaffected, and maybe even improves in usefulness, when people are bad at knowing what they want. That is because SA is a [metaheuristic](https://en.wikipedia.org/wiki/Metaheuristic), or a higher-level procedure to generate a search heuristic. So even if the underlying search criteria change, you can still apply the search-jump-slowdown cycle with the new optimization preferences.

<div class="float-left">
    <img src="/assets/img/posts/simulated-annealing/experience.png" alt="experience">
    <em>Hopefully the improvement in your assessment of what you want, over time.</em>
</div>

Another benefit of utilizing simulated annealing, is that the "jump" step forces you to quickly prove or disprove your hypothesized preferences with real experience. Nothing clears up any false preconceived notions of what your ideal dating "type" is by going on a dreadfully horrible date with someone who fits your mental ideal.

Clarifying your actual expectations through experience and testing out a vast array of possibilities has the added benefit of providing _certainty_ to your decision-making. Many times I've heard friends say they aren't sure about the long-term viability of their current partner. These are friends who have been dating their partners for a significant period of time -- months and even years. Ostensibly they have had enough time to deeply understand the personality and quirks of the other person. So their lack of commitment stems from an internal uncertainty rather than lack of knowledge about the partner.

This hesitation either comes from a lack of self-knowledge about their own wants or lack of experience, oftentimes both. For those lacking experience, they often haven't dated enough to decide on this relationship. In other words, people don't know if their current perspective is accurate or not because they have no adequate reference points. It is not so much a "grass is always greener" problem as it is an inability to even know what the color green looks like.

So now we get to the next part, which is: how many different options are really even out there? 

<br><br>
## 2. Humans are also bad at understanding probability

Science has proven that humans really stink at probability. [Hindsight bias](https://en.wikipedia.org/wiki/Hindsight_bias), [base rate fallacy](https://en.wikipedia.org/wiki/Base_rate_fallacy), [gambler's fallacy](https://en.wikipedia.org/wiki/Gambler%27s_fallacy), [neglect of probability](https://en.wikipedia.org/wiki/Neglect_of_probability)... just to name a few failures in our mental capacity to understand probability. Buster Benson has a great [article](https://medium.com/better-humans/cognitive-bias-cheat-sheet-55a472476b18) that breaks down cognitive biases into larger categories. Many of our biases stem from our inability to intuitively understand and apply probabilities.

<div class="float-right" style="margin-top: -20px">
    <img src="/assets/img/posts/simulated-annealing/sports-all.png" alt="sports-all">
</div>

This failure to understand probability manifests in a lack of consideration for the space of possibilities. 

If we look at the [practical example](#a-practical-example) again, the search space for a new sports hobby is not so large. It is possible to explore a significant area of the search space with only a handful of jumps. But this is not always the case for other life decisions. Questions in life, and especially the most existential meaningful ones, can have massively huge sets of potential answers. 

For dating, there are probably hundreds of compatible romantic partners for each of us in the world. Even if you winnow down the available dating pool based on specific ages, location, education level, earning potential, or whatever criteria you care about, there will still be more people than you can possibly finish searching through in one lifetime. 

<div class="float-left">
    <img src="/assets/img/posts/simulated-annealing/dating.png" alt="dating">
    <em>Dating is a life search space that has gotten larger and more complicated over time.</em>
</div>

It used to be that we could quickly choose between the options for romantic partners. There are only so many eligible people similar in age living in your local village or town back in the day. But with the globalization of communication, increased accessibility to travel, more frequent moves to new cities and countries, the meteoric rise of online dating, as well as a host of other factors, the search space for romantic partners has exponentially increased.

Simulated annealing pushes for a more deliberate and diverse-seeking mindset towards the problem of dating, not only to clarify your own desires and expectations, but also to decide how much of the available search space to explore. Before, you might only need to date one or two people to feel like you've understood most of the available dating pool. Nowadays it will take many more jumps to achieve the same level of knowledge and certainty.

Okay but, you might say, a lot of dating is unpredictable and out of your control. Finding a partner not only depends on finding the right person but also having that person return your interest.

I want to emphasize that I'm not trying to negate the many factors that make meeting a life partner miserably hard: stereotyping and bias, societal and parental expectations, biological clocks, and the simple difficulties of chemistry are just a few of those complicating considerations. And I'm not necessarily arguing you should try to date hundreds of people to completely exhaust the search space. 

Simulated annealing can provide a useful perspective to think about your approach to dating in this brave, new world. And as I attempt to apply a nice and neat framework to a highly complex, messy decision-making space in life, there are probably many edge cases where this framework breaks down. Dating is in no way tidy and neat unless you are very, very lucky.

So let's consider another thought experiment, a meaningful life decision that is a little less dependent on other people but is by no means easier to answer: "What should my life's work be?" 

The human condition has the rather frustrating quality of being one of incomplete information. You can't know the full range of possible answers to for what your legacy should be. Maybe your life's work will be raising a happy family. Or what if you are more fulfilled writing a novel? Or spending all your free time furthering marine conservation? Or perhaps something else will be your legacy, something you haven't even conceived of yet.

By its very nature, the system of simulated annealing forces the user to pause and consider the size of the search space. You can use your thoughtful reflection on the size of the search space to decide how many times you want to repeat the search-jump-slowdown cycles before you are likely satisfied. A large search space may require many more iterations, while a smaller search space can be narrowed down more quickly. Deciding on your life's work probably needs more searching than picking your new sports hobby.

The other systems that I've encountered tend to ignore the difference in size and complexity of your decisions. Productivity-focused frameworks push you to think about how to quickly and effectively improve the prioritized list of (five? three? one?) outcomes you are focused on. Never have I seen a productivity framework pause to ask you to reflect on the overall set of choices you are focusing on, and whether the ones you've picked are really the best fit for you. Coupled with the assumption that humans are really bad at knowing what they want, it's very unlikely you can reach the optimal solution based on mental rationalization alone.

I am also very suspicious of such productivity systems since they tend to come with branded swag they are trying to sell you. This starts edging out of life philosophy territory and into the category of sellable, marketable self-help products. While the underlying ideas might be useful (ex. I used the basic concept behind [Bullet Journal](https://bulletjournal.com/) for many years), beware that they have an incentive to push you to get on with your tasks. The more unquestioning attitude you have then the quicker you'll be reading their book or downloading their app. It is against their business interest to tell you to stop and evaluate why you're doing things in the first place.

<br><br>
## 3. Humans want to control how they grow and change

In addition to not thinking about probability and the range of possibilities, I think many life philosophies mistakenly focus on personal growth. Like I was saying above, these systems end up just being productivity "hacks" that push you to unquestioningly make plans and habit trackers rather than doing the hard work of thinking about what you should be focusing on.

<div class="float-right">
    <img src="/assets/img/posts/simulated-annealing/possibility-1.png" alt="what-you-can-imagine">
</div>

I believe the popularity of personal growth frameworks comes from an underlying desire to control how we ourselves change. You might be okay with thinking about children as being heavily influenced by upbringing and environment but, as an adult, it's very alarming to think about how your future self will be a mix of only a small amount of your own input and mostly random chance and external forces. It's even worse to consider a future self who you can't imagine at all based on your present values.

Funnily enough, I think kids actually think of their adult selves that way. I remember being young and failing to imagine what I would be like when I grew up. Not because I lacked any imagination, but because there wasn't one thing that I thought I would definitely be. There seemed like an almost infinite set of options that my adult self might become. After all, what kid ever really thinks they are going to grow up?

<div class="float-left">
    <img src="/assets/img/posts/simulated-annealing/possibility-2.png" alt="new-state">
</div>

Simulated annealing can restore some of the child-like carefree attitude towards radical, unpredictable change. By accepting that the search space of life is huge and impossible to fully comprehend, you are acknowledging that the "best" choice for you might be something that you can't conceive of at this moment. And even if external forces push or pull you to arrive at certain choices, SA will naturally resist that by encouraging you to go way out of your comfort zone. 

One other thing: "personal growth" not only evangelizes that people should try to control how they change, but also that people need to be constantly _growing_. This fixation on growth can cause you to discard worse-off choices that could over time lead to a better answer. Accepting certain levels of discomfort and negative experience, tempered by a continual decrease in the tolerance for those negative situations, could help you discover answers you would otherwise have thrown out.

Now you might say that doing search-jump-slowdown cycles _is_ a form of personal growth. But I believe a better framing of this process is as "self-actualization". Another way of saying it is that simulated annealing encourages people to incrementally "come alive":

<p class="large-quote" style="margin-bottom: 0">Don't ask yourself what the world needs. Ask yourself what makes you come alive, and go do that, because what the world needs is people who have come alive.</p><p class="large-quote" style="margin-top: 0; text-align: right">- Howard Thurman</p>

Personal growth often means a narrow and single-minded mentality, with only a short list of things you can prioritize. Personal growth is also driven by the individual's own sense of progress against a mental scoreboard, logically determining whether your actions and results are successful. 

"Actualization" simply means making something into reality. The term makes no judgement on whether the change direction will be interpreted as positive or not. In addition, while the jump step in simulated annealing may be initiated by the person doing the searching, there is an element of unexpected discovery. You don't necessarily know if this new jump area is where you want to go. You give yourself space to respond to the experience both rationally and emotionally, consciously and unconsciously.

<br>
## Simulated annealing as a formula

What I like so much about simulated annealing is it gives very concrete steps for how to expand the range of outcomes for important life decisions.

Venkatash Rao has a great formulation that also loudly refutes the personal growth mindset: [life intensification](https://mailchi.mp/ribbonfarm/life-spirit-distillation). In his framework, he too declares a need to think about the search space of possibilities -- your "potentialities" -- and unplanned change. Rao rejects thinking of life as deterministic optimization problem. Instead, life intensification advocates for accepting the effect of external influences and moving towards more "intense" versions of yourself.

My only complaints with the arguments of life intensification are that (1) it lacks any real tactical steps (this is by design, since Rao claims that formulas inherently contradict what it means to be a life intensification philosophy); and (2) it still frames changes in life intensity as needing pre-evaluation. 

<div class="float-left">
    <img src="/assets/img/posts/simulated-annealing/possibility-3.png" alt="lazy-possibility">
</div>

I think that simulated annealing provides just enough high-level structure to encourage me to explore more intense versions of myself that could exist. Without an explicit forcing function like the jump phase, I can too easily fall into the trap of rationalizing away why the new state wouldn't be a more intense version of me. Lazy people like me will just revert to the default in the absence of systematic accountability.

Also, life intensification is described as an _active_ choice -- you first evaluate whether this new version of yourself will be more intense before you agree to the change. Whereas simulated annealing allows for the possibility of trying something new, not knowing what to expect, and being surprised at your own reaction to the experience. For me, deciding first whether the new state will be more intense just creates another chance for me to practice being terrible at knowing what I want.

<br>
## Jumping: a year abroad in Japan

I left my job and the Bay Area in 2018 and moved to Tokyo with my partner and dog. I am essentially taking a year-long sabbatical to learn Japanese and explore the country, living off my savings. I took the leap (ha!) to move internationally in large part because I viewed this as an important "jump" - one phase in my great exploration of what it means to live a rich and fulfilled life. 

Although it turned out to be an incredibly positive experience, I had plenty of concerns and reservations before coming here. I don't think I would have been willing to move if not for the simulated annealing mindset: there were too many potential risks and negatives for taking a year off in my career, international move logistics were terrible, it could cause challenges in my romantic and platonic relationships, I was sacrificing a year of money-making potential, etc. 

Simulated annealing allowed me to reframe my anxieties about moving to Japan to as a natural cost of jumping to a brand new part of the search space of life. It was normal to experience a potential negative hit to my life during a jump phase, and because I am early enough in my search for a diversified life, I am okay experiencing a larger negative cost. And by not doing it, I could be throwing away the chance to discover a better answer to my question of: "What is _my_ ideal life?".

Without the forcing function of a jump phase, I might have never moved to Japan. It also means I might have never [started a podcast](https://www.sanfransokyopodcast.com/) or [built a game](https://worldanimalsapp.com/) to help language lovers learn animal sounds from around the world. I would have never traveled to dozens of areas in Japan or had new revelations about how I wanted to spend my retirement. There is so much more that I could write about the impact of this year in Japan that it requires it's own dedicated post.

<br>
## A list of other life frameworks

Have other frameworks you like? Simulated annealing can certainly be used alongside other life philosophies.

Take the [deathbed game](https://busterbenson.com/blog/2013/06-29-the-death-bed-game/) by Buster Benson, a lovely framework that helps you reconsider what is valuable by continually reflecting on what you will regret on your deathbed. One of the top regrets people have on their deathbed is "wishing I had let myself be happier." 

It's easy to think of straightforward changes in your life that are preventing your happiness. Eliminating those is a clear first step. But after that, what proactive changes should you take to add more happiness to your life? The deathbed game doesn't define an explicit process to make new changes, so pairing simulated annealing and the deathbed game together can be effective at adding practical steps for your decision-making.

Here is a list of systems that are useful to check out:
1. Getting Things Done
2. [Your Life in Weeks](https://waitbutwhy.com/2014/05/life-weeks.html) by Wait But Why


Decision Journal to improve decision-making.