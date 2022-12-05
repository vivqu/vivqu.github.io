---
title: "Stacking PRs"
subtitle: "How this technique levels up engineers"
published: true
source: false
seo_description: "best-practices engineering craft"
tags: tech work management
image: assets/img/posts/stacking-prs/stacked-rocks.jpg
read_time: 5 min
---

University computer science curriculums frequently don't teach practical industry skills that are required to succeed in the workplace. Students are given toy assignments that demonstrate high-level concepts but are rarely required to produce an end-to-end implementation with the goal of real users interacting with the system. Even in internships, projects are usually limited to small, well-scoped projects that can be tidily wrapped up in 3-4 months. This means that most of the coding projects that new grads have completed by the start of their first industry role have been isolated to just one person, or have had only minimal collaboration with others. Basic git commands are usually one of the major gaps that new grads have to learn on the job.

Becoming proficient in version control and change management is a necessary part of any software engineer's job. However, I think that basic proficiency alone is not sufficient to be truly effective when working on complex production-ready software with a team of engineers. **Stacking pull requests (PRs)** is a key skill that should be learned early in a junior engineer's career. 

Stacking PRs is an advanced git technique that allows an engineer to break down one large change into a series of dependent changes that can be turned into smaller pull requests and reviewed separately. 

Imagine a new full-stack feature that requires frontend and backend changes. An engineer might work on both parts simultaneously to implement and test the full functionality. A basic pull request would contain all of these changes, potentially hundreds of lines of code (LOC):

```
main-branch
    |
    ------ all-my-changes (PR #1, 500 LOC)
```

Instead, the engineer could separate the changes into two separate branches, one for frontend changes and one for backend changes. The frontend branch would need to be stacked on top of the backend changes since it uses new APIs. 

```
main-branch
	|
	------ backend-changes (PR #1, 300 LOC)
			|
			------ frontend-changes (PR #2, 200 LOC)
```

This is a better state since each pull request is focused on one specific sub-area of the larger functionality. Each pull request also contains fewer lines of code to review. Stacking PRs can also be done in the middle of feature development, rather than at the end, to enable an engineer to continue to develop additional changes while waiting for a review on the first set of changes.

Timothy Andrew has a detailed write-up of the [stacked PR workflow](https://timothya.com/blog/git-stack/#headline-1) and tools to make the workflow easier. Stacking PRs can be quite cognitively complex because it requires dexterity with branching, cherry-picking, and rebasing commits. Engineers need to be able to thoughtfully decompose their work into comprehensible chunks, which may be challenging if there are many interdependent changes. There is also some practice required to learn how to update a base branch to address comments and merge the pull requests in the appropriate order. 

(Note: GitHub finally added in [pull request retargeting](https://github.blog/changelog/2020-05-19-pull-request-retargeting/) in 2020 to make managing multiple feature branches easier, demonstrating how critical the stacked PRs workflow is to advanced software development practitioners. Phabricator ([RIP](https://admin.phacility.com/phame/post/view/11/phacility_is_winding_down_operations/)) was an [arguably](https://jg.gg/2018/09/29/stacked-diffs-versus-pull-requests/) better platform for this workflow due to stacked diffs, a variant on the same idea of chunking up a large body of engineering work. Perhaps it's unsurprising that I'm a huge fan of stacked pull requests given I used Phabricator at my first job! It's also why I like squashing my commits when I merge in approved pull requests.)

## Benefits of stacking PRs

There are many benefits to smaller pull requests. Google has an entire section in their coding best practices on [smaller changelists](https://google.github.io/eng-practices/review/developer/small-cls.html) (another term for pull requests), outlining how they are:
- Reviewed quickly and more thoroughly
- Less likely to introduce bugs
- Less wasted work if they are rejected
- Easier to merge and design well
- Less blocking on reviews
- Simpler to rollback

But perhaps more importantly than the benefits to individual productivity, stacking PRs is the first step towards a major mindset shift in effective engineering practices.

I've mentored and managed many new grads over my career. Every engineer that I have coached from early to mid-career (and above) needs to make a leap from concentrating only on their _own_ individual output to thinking about the overall team. The effectiveness at the team level is the combination of all the individual team member's output--specifically, _review-approved_ code. 

There are a myriad of factors that make it easier or harder to produce approved code than simply how fast each person can write the code itself. Readability of the codebase is one reason a team's productivity can be sped up or slowed down. Google has also made public their extensive [style guides](https://google.github.io/styleguide/), an important resource to make it "easier to understand a large codebase when all the code in it is in a consistent style". A consistent style makes it quicker to understand old code and add new code that integrates with the existing functionality. 

Similarly, another way to change a team's velocity is to improve PR hygiene. Promptly [reviewing code and responding to feedback](https://google.github.io/eng-practices/review/reviewer/speed.html), conducting a self-review before asking for peers to review, and creating smaller and easier-to-comprehend pull requests are all ways to streamline the code review process.

So while stacking PRs is only one skill out of the many required for software engineers to effectively ship complex software features, I find that teaching the skill produces a true step function change in a junior engineer's effectiveness on the team. This is because stacking PRs requires considering not just how functional your code is (does it work? does it produce the correct output or interface?), but also how to break down the overall changes into logical, discrete chunks that are easy for _others_ to understand. The practice of stacking PRs builds a habit of thinking beyond the working code itself to preparing the code for the review process and other people reading the code. Eventually, as the engineer becomes more senior, this thinking naturally develops into technical leadership and evaluating higher orders of developer experience on the team.

So in conclusion, teach your junior teammates how to stack PRs!

## More reading
- [In Praise of Stacked PRs](https://benjamincongdon.me/blog/2022/07/17/In-Praise-of-Stacked-PRs/) by Benjamin Congdon
- [Stacked diffs vs pull requests](https://jg.gg/2018/09/29/stacked-diffs-versus-pull-requests/) by Jackson Gabbard

<hr class="section-divider" />

<footer>This article was last updated on 10/4/2022. v1 is 1,024 words and took 2 hours to write and edit.</footer>