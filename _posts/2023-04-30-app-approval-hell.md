---
title: "The app review experience from hell"
subtitle: "Misadventures in working with Chrome extensions and Google OAuth"
published: true
source: false
seo_description: "chrome-extension quotes reading"
tags: tech
image: assets/img/posts/app-approval-hell/computer-disaster.jpg
read_time: 15 min
---

I've [written previously](/blog/2022/09/25/outdated-apps/) about my strong opinions about the App Store and Google Play stores. These platforms and the massive tech companies that operate them make misguided policy decisions that disadvantage small indie developers while also decreasing the creativity and richness of their mobile app ecosystems, motivated by corporate profits or just plain indifference. 

But at this point, after years as a professional mobile developer as well as building multiple side projects, I thought I had seen it all—the good, the bad, and the ugly of getting my apps approved. I believed I had a good understanding of the bargain that companies and developers make when engaging with app ecosystems.

That is, until I decided to make a Chrome extension with Google login.

My Chrome extension [Recite](/blog/2023/04/02/recite-extension/) is about as basic as you can get. It's only 1,744 lines of code and uses bare HTML/CSS/JS, one simple third-party utility library ([lodash](https://lodash.com/)), and makes GET requests to two Google spreadsheets API endpoints. I quickly built it as a fun weekend project in less than 8 hours. The final step was just to wrap it up by publishing through official channels so anyone could install the extension.

The [Pareto principle](https://en.wikipedia.org/wiki/Pareto_principle) (or 80/20 rule) is often applied to productivity and time management to explain that 20% of your time spent will account for 80% of the results. However, people often forget the implied corollary, which is that the last 20% of a project will consume 80% of your time. For the Recite project, the time spent between building a complete, production-ready extension and making the app available to users was even more extreme than 80/20. I spent less than one working day making the software functional and more than 11 weeks stuck in review processes.

Come along with me as we descend into an app approval hellscape, one stage at a time:
- Part 1: Dreadfully long review times.
- Part 2: Want to charge for your Chrome extension? Too bad.
- Part 3: Surprise! An extra submission process!
- Part 4: How do I get approved? Nyah nyah, I won't tell you.

# Part 1: Dreadfully long review times.

The [Chrome Web Store](https://chrome.google.com/webstore/category/extensions) is the marketplace to download and install extensions and add-ons for the Chrome web browser. It debuted in 2011 and now hosts over 100k extensions.

I assumed that the Chrome Web Store would have a well-developed submission process. The App Store and Google Play Store were launched in 2008 and 2012, respectively. Given the timeline, the Chrome Web Store has been around just as long as these other massive app distribution platforms. At the very least, I thought,  Google's experience and learnings from running the largest app marketplace in the world (with over 3 million Android apps!) should transfer to the Chrome Web Store as well.

The documentation on how to [publish in the Chrome Web Store](https://developer.chrome.com/docs/webstore/publish/) seemed easy enough at first. It's a basic submission form where you upload a zip file of your extension, description and other metadata, and relevant links to websites and policies.

But, even with just a second look, the documentation starts to show warning signs. In the section about [review times](https://developer.chrome.com/docs/webstore/review-process/#review-time), Google claims that most store submissions in 2021 typically completed in less than 24 hours. Then right below that was a note to reach out to support if the extension is in pending "for more than three weeks".

<br />
![webstore-review-times](/assets/img/posts/app-approval-hell/webstore-review-times.png)
*The immediate reveal that review times can take excessively long does not inspire confidence, to say the least.*
<br />

This is already a strange departure from the Play Store publishing process. When you submit a new version of an Android app, they are usually automatically approved and released within a few hours. [Play Store documentation](https://support.google.com/googleplay/android-developer/answer/9859751?hl=en#zippy=%2Cupdate-status%2Citem-status%2Capp-status) notes that only in some cases do apps necessitate a more manual review which "may result in review times of up to seven days or longer in exceptional cases". 

While I hoped that I would be more like the typical case, my first submission was most certainly not. I submitted version 1.0 of the [Recite extension](https://chrome.google.com/webstore/detail/recite/jpngepoglfflfacfcjfodbgnmhejlaoa?hl=en&authuser=0) on December 31st, 2022 and was finally approved 40 days later on February 9th. 

Even after the first version, excessive review times seem to be the norm. Subsequent submissions had "faster" review times that averaged 14.5:
- v1.1: Submitted on 2/12 and approved 3/2 (18 days)
- v1.2: Submitted on 3/3 and approved 3/14 (11 days)

Despite Google's claims that a one-day-turnaround is the default case, a basic Google search shows [threads](https://stackoverflow.com/questions/61835614/google-chrome-extension-review-time-process) and [official complaints](https://support.google.com/chrome/a/thread/29107304/chrome-extensions-are-taking-forever-to-be-published-and-finally-getting-rejected?hl=en) about the review times have been happening for years. Even major successful software products like 1Password that should expect preferential, expedited treatment frequently receive review times ranging from 1-6 days:

<div class="twitter-container"><blockquote class="twitter-tweet"><p lang="en" dir="ltr"><a href="https://twitter.com/googlechrome?ref_src=twsrc%5Etfw">@googlechrome</a>: Chrome Web Store review times:<br>• Average: 36.5 hrs<br>• Max: 127.6 hrs<br>• Min: 2 hrs</p>&mdash; Andrew Beyer (@firebeyer) <a href="https://twitter.com/firebeyer/status/1503943274842578946?ref_src=twsrc%5Etfw">March 16, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script></div>

And these are just issues with the _length_ of review times. My friend D.K. runs a successful software business built on Chrome extensions and he has written about his frustration with [incomprehensible rejection feedback](https://roadtoramen.com/Day-64-Debugging-My-Chrome-Web-Store-Rejection-316d4d55d268414bb75a1c0e4c871c21) and [third-party libraries being mistakenly identified as malicious code](https://roadtoramen.com/Day-435-Google-Took-Down-My-Chrome-Extension-for-Using-Lodash-a3096c51321f42e0a04c77e1a25f484a), which caused him to lose multiple days arguing with customer support and even got his extension delisted without warning.

Taken together, the painfully long and random review process paints a picture of a platform that isn't being resourced or even valued by the parent company. Looking at the list of [open web store bugs](https://bugs.chromium.org/p/chromium/issues/list?q=component%3AWebstore&sort=pri) shows issues that have been ignored for years. One open P2 bug from July 2020 is a simple request to please fix the submission form to actually display [promotional images that are submitted](https://bugs.chromium.org/p/chromium/issues/detail?id=1111341&q=component%3AWebstore&sort=pri). 

I was lucky that I was just trying to publish a fun side project rather than trying to launch an actual software business, in which case the current state of the publishing process on the Chrome Web Store would be unacceptable.

<br />
# Part 2: Want to charge for your Chrome extension? Too bad.

Given that I suspected that Google has stopped investing resources into the Chrome Web Store, I perhaps should not have been surprised that basic features of a "store" were not available.

I wanted to charge a very small fee ($0.99) to download the extension to make sure I was invested in maintaining it. I thought this was something I could configure easily, given that both the App Store and Google Play Store make it seamless to set up one-time download prices.

I guessed wrong again!

Chrome officially shut down its [Chrome Web Store payments](https://developer.chrome.com/docs/webstore/cws-payments-deprecation/) on February 1st, 2020 without much warning. The reasoning they gave was:

> The web has come a long way in the 11 years since we launched the Chrome Web Store. Back then, we wanted to provide a way for developers to monetize their Web Store items. But in the years since, the ecosystem has grown and developers now have many payment-handling options available to them. 

My immediate takeaway is that Google no longer wanted to bother with maintaining their own standalone payment system. The Chrome Web Store only took [5% per transaction](https://developer.chrome.com/docs/webstore/money/) so perhaps it wasn't generating enough revenue to maintain for its parent company. Compare this to their crown jewel, the Android Play Store, which charges 30% per transaction and generated revenue of [$11.2 billion in 2019](https://www.reuters.com/technology/google-play-app-store-revenue-reached-112-bln-2019-lawsuit-says-2021-08-28/). The Play Store continues to offer a payment system to this day.

The deprecation decision understandably angered many developers who were relying on store payments. This [Hacker News thread](https://news.ycombinator.com/item?id=24548876) has hundreds of comments discussing how charging a subscription or one-time payment outside the Chrome Web Store would not only disrupt their existing business models, but also be a bad user experience. It also caused a lot of technical headaches for developers who had no easy way to ensure they didn't double-charge their users:

<br />
![hacker-news-payments](/assets/img/posts/app-approval-hell/hacker-news-cms.png)
*It's pretty bad form to just tell the developers to "figure it out" when making a major platform change.*
<br />

I'm sure there are still ways to [effectively monetize Chrome extensions](https://www.indiehackers.com/post/how-can-i-monetize-a-chrome-extension-3619006a88) for folks trying to build businesses. But for a small hobbyist who just wanted to make a nice extension for themselves and a handful of other interested parties, the cost-to-benefit ratio of implementing complicated Stripe in-app payments for a few bucks just isn't worth it. 

<br />
![extension-install-count](/assets/img/posts/app-approval-hell/install-count.png)
*Not all of my 77 users would have paid $0.99 but I may also have been incentivized to spread the word if it there was an easily monetizable option.*
<br />

# Part 3: Surprise! An extra submission process!

The next unpleasant delay was Google API OAuth verification. Recite uses a Google API key that is restricted to a single API type (Google Sheets) and requests read-only permissions to access a user's spreadsheets.

Read-only spreadsheets access is categorized as a "sensitive scope" which requires additional [API OAuth verification](https://developers.google.com/identity/protocols/oauth2/production-readiness/brand-verification). In other words, I needed to undergo a second submission process with Google in order to get the API portion of the extension working.

<br />
![sensitive-scopes](/assets/img/posts/app-approval-hell/sensitive-scopes.png)
*The extension requests a single sensitive scope in order to read from a user's Google spreadsheets.*
<br />

I only realized that I needed to do this after the first version of my extension was submitted, approved, and released in the Chrome Web Store. This meant that I accidentally shipped a developer-only version of the API key, so no one besides me could functionally use the extension.

I found the error because as soon as my extension was live, I asked a friend to try it out and they immediately got blocked from using it. Oops!

<br />
![missing-approval](/assets/img/posts/app-approval-hell/missing-approval.png)
*The error that Google displays if your OAuth application has not been approved.*
<br />

Admittedly, this was my fault for quickly hacking together the project and not paying close enough attention to check all the requirements were met. I've worked with plenty of other APIs that require authorization to know that there is a difference between developer and production access, and it's very common to have a API verification process.

However, there were a few issues on Google's side that made it very easy to overlook or forget:
1. No feedback from the extension submission review
2. Lack of communication about verification

## 1. No feedback from the extension submission review

Once again, I overestimated the standards and rigor of the Chrome Web Store review process. 

I am used to App Store reviews for mobile submissions that provide a high bar for automated and manual quality. While there are still occasionally mistakes and erroneous rejections, I've also been alerted to legitimate issues by an App Store reviewer doing testing of my mobile apps.

I don't think its unreasonable to assume that Google has the capability to detect usage of their own API keys. They could help developers by automatically flagging extensions which include API keys that haven't been successfully verified. The publishing process would actually serve as a useful checkpoint, where developers get feedback on potential user experience issues, rather than the current situation where zero (or negative) value gets added.

## 2. Lack of communication about verification

When requiring people to go through any process, it's always a good idea to be as explicit as possible. The Google Cloud Console team has apparently taken the opposite approach, since communication about the verification process is incredibly confusing.

Nowhere on any of the [credentials page](https://console.cloud.google.com/apis/credentials) does it indicate that approval is needed when you set up your client credentials and API keys. Ultimately, the developer will need to visit a completely separate screen ([OAuth consent screen](https://console.cloud.google.com/apis/credentials/consent)) in order to productionize their API keys.

<br />
![credentials](/assets/img/posts/app-approval-hell/credentials.png)
*Configuring the OAuth consent screen, adding API scopes, and submitting the OAuth app for verification are located on a different page in the navigation bar.*
<br />

It would be a much more logical place to set permission scopes when configuring the API key or client ID, and it would also be a great place to show an early alert to the developer if they add a sensitive or restricted scope that requires additional verification.

<br />
![api-key](/assets/img/posts/app-approval-hell/api-key.png)
*The page to set up your Google API keys.*
<br />
![client-id](/assets/img/posts/app-approval-hell/client-id.png)
*The page to set up your Google client ID.*
<br />

Compare this to Zoom's much better UX for setting up developer credentials. There is a clear and obvious series of steps for setting all the right information, with "Scopes" and "Activation" clearly called out.

<br />
![zoom-credentials](/assets/img/posts/app-approval-hell/zoom-credentials.png)
*When creating a new API integration with Zoom, there is a clear set of steps to follow on the left.*
<br />
![zoom-scopes](/assets/img/posts/app-approval-hell/zoom-scopes.png)
*Scopes are easily configured towards the end of the setup flow.*
<br />

When you try create a new Google OAuth consent screen, there is no indicator of what steps are going to happen when the developer hits "Create". 

<br />
![consent-start](/assets/img/posts/app-approval-hell/consent-start.png)
*When the OAuth consent screen hasn't been configured yet, this is the first thing that the developer sees.*
<br />
![consent-steps](/assets/img/posts/app-approval-hell/consent-steps.png)
*Only after you hit the "Create" button are you shown all of the information that you need to fill out.*
<br />

And even after the OAuth consent screen is configured, only a small section at the top of the page indicates "Publishing status". It's easy to overlook or forget to come back to it once the app is ready to be released. 

<br />
![publishing-status](/assets/img/posts/app-approval-hell/publishing-status.png)
*I definitely did not pay attention to this screen after I created the OAuth consent screen the first time.*
<br />

The only information for app registration is in an easily ignorable sidebar. There is only a brief description of when an app "might need to go through verification".

<br />
![verification-details](/assets/img/posts/app-approval-hell/verification-details.png)
<br />

Another major complaint I have with the Google Cloud Console is that it's not obvious at all which specific APIs and scopes are considered sensitive or restricted. If you wanted to find out from the docs, [OAuth API verification FAQs](https://support.google.com/cloud/answer/9110914?hl=en) tells the developer to refer to multiple additional resources:
- [Google API Services User Data Policy](https://developers.google.com/terms/api-services-user-data-policy)
- [OAuth 2.0 Scopes for Google APIs](https://developers.google.com/identity/protocols/oauth2/scopes)
- Specific API documentation, such as [Google Sheets API Reference](https://developers.google.com/sheets/api/reference/rest)

<br />
![sensitive-details](/assets/img/posts/app-approval-hell/sensitive-details.png)
<br />

However, none of these documentation pages clearly state whether a scope has regular, sensitive, or restricted designations:

<br />
![sheets-details](/assets/img/posts/app-approval-hell/sheets-details.png)
<br />

So the only way to determine if your scope is sensitive or restricted is when you configured your OAuth consent screen for the first time:

<br />
![scope-info](/assets/img/posts/app-approval-hell/scope-info.png)
*The small lock icons next to each scope is all that indicates whether it's default, sensitive, or restricted.*
<br />

This is a terrible way to communicate critical information about scopes and sensitivity, and it's difficult to reference after setup. It would be much better to also have this information in the docs or even in a separate search screen outside of the OAuth consent screen configuration.

The worst part is that the sensitivity level dramatically impacts how long it would take to verify your OAuth app. The higher the sensitivity of the scope, [the longer the wait times for reviews](https://support.google.com/cloud/answer/9110914?hl=en):
- Default: 2-3 business days
- Sensitive: Up to 10 days
- Restricted: Potentially several weeks (plus independent, third-party security assessment)

This is absolutely not clear when setting up the scopes for the first time. The difference between a few days to _several weeks_ could have a significant impact on a project's success. 

And in keeping with the trend of inconsistent and unclear messaging, the sidebar for the consent screen displays conflicting information with the FAQ documentation.

<br />
![sidebar-scopes](/assets/img/posts/app-approval-hell/sidebar-scopes.png)
<br />
![sidebar-zoom](/assets/img/posts/app-approval-hell/sidebar-zoom.png)
*This section says that sensitive scopes only take 3-5 days, but the FAQ says up to 10 days. Which one is is it?*
<br />

Each individual documentation issue and any one setup flow being a little hard to understand may not be that big of a deal. But when you start adding it all together, it amounts to major confusion for developers when using Google Cloud Console. Important information about review times depending on specific API permissions is buried deep in the errata of FAQ docs or sidebars that users easily can ignore. 

The actual impact on my side project of missing the verification process was just some embarrassment when I showed a friend an incomplete project. But for startups or software projects where every minute and day counts, such a poor developer experience can accidentally cause long delays.

<br />
# Part 4: How do I get approved? Nyah nyah, I won't tell you.

So now that I knew there was only one more submission process to get through, it was smooth sailing to get the extension working correctly, right?

Alas, there was one more level to descend to in developer hell.

If the Chrome web store was comically slow in responding but lax in its review process, the API OAuth verification was the exact opposite: quicker to respond but extremely nitpicky about every requirement.

I submitted my verification request on February 9th and finally was approved on March 19th, a full 38 days later. It took almost the same time end-to-end as getting the first version of the extension approved. But instead of radio silence, I was in an endless back-and-forth with the reviewers:

<br />
![email-hell](/assets/img/posts/app-approval-hell/email-hell.png)
*So many emails exchanged between me and the API OAuth verification reviewers.*
<br />

Here is a summary of everything I had to do to satisfy the OAuth verification process:
- Set up a [OAuth homepage](/recite)
	- Create a new page separate from the [extension landing page](https://chrome.google.com/webstore/detail/recite/jpngepoglfflfacfcjfodbgnmhejlaoa?hl=en&authuser=0) and hosted on my own domain
	- Modify the page to link to the privacy policy
	- Add user data usage explanations, separate from but duplicating the privacy policy
	- Include the Recite logo icon on the page
- Update the [privacy policy](/recite/privacy-policy)
	- Describe Google user data usage in a more specific way
- Change the sign-in button to adhere to [Google brand guidelines](https://about.google/brand-resource-center/guidance/apis/)
- Create a [Youtube video demo](https://www.youtube.com/watch?v=jqn6lEYIW60&feature=youtu.be) of the extension
	- Also needed to re-record the demo when changing the extension

Each of these changes had to be done one by one because the reviewers would not include a full list of all the issues that needed fixing. The feedback was always a copy-paste of the guidelines with no elaboration from a human. Every round of changes also required waiting 1-3 days for the reviewer to respond. 

<br />
![homepage-rejection](/assets/img/posts/app-approval-hell/homepage-rejection.png)
*The majority of the rejections were due to minor changes needed for my OAuth homepage.*
<br />

The OAuth homepage was particularly frustrating to set up because there were no clear details of what they were expecting. I luckily found a [StackOverflow discussion](https://stackoverflow.com/questions/59793437/example-of-an-oauth-homepage-for-google) where Michael Holstrom helped others by providing his own approved pages as examples:

<br />
![homepage-example](/assets/img/posts/app-approval-hell/homepage-example.png)
*So grateful that Michael Holstrom shared his [OAuth homepage](https://holtstrom.com/michael/about/) after passing Google review so I didn't have to do the exact same guess-and-check with the review feedback.*
<br />

Several times the rejection reason was simply wrong and I had to waste another few days waiting for a response, hoping that next time they would actually send me a real reason why I got rejected.

<br />
![invalid-rejection](/assets/img/posts/app-approval-hell/invalid-rejection.png)
*Multiple times they claimed that my app was in development mode, which was not correct.*
<br />
![rejection-response](/assets/img/posts/app-approval-hell/rejection-response.png)
*Several more days wasted just telling them they were wrong.*
<br />

I want to emphasize again: I went through the trouble of setting all of this up so that my extension could have the ability to read **one row from a Google spreadsheet** to display a saved quote. The amount of bureacratic overhead was truly a Kafkaesque nightmare.

The most disappointing of all this is that Google should have a complete picture of my app. They not only have the source code and extension submission details from the Chrome Web Store, but also all the additional information that I had to provide with the API OAuth verification process. From the outside, it looks like unnecessary and irritating extra hoops to jump through to justify my usage of their platforms. 

I know the reality of the situation is probably quite different--I'm sure the people who work on Google Cloud Console and Chrome extensions are in completely separate internal orgs, running isolated product processes, with backends and systems that don't talk to one another. But [Conway's law](https://en.wikipedia.org/wiki/Conway%27s_law) is still not a good justification for a deeply infuriating process, all to get dead simple apps and API usage made available to the public.

<hr class="section-divider" />

In the end, it took me 78 days to release a working Chrome extension that was built in less than 2 days.

I'm not sure if there are any takeaways from this writeup beyond a general plea to improve submissions for Chrome extensions and API OAuth apps. I hope that I can at least give some comfort and schadenfreudian delight to other developers. I also wanted to document this delightful experience so that the artifacts I was forced to make (like the [Google OAuth page](/recite) and [privacy policy](/recite/privacy-policy)) may help others who are stuck in review purgatory.

And though I would never say that the way the App Store and Play Store do reviews are perfect, I have learned viscerally that they could be so *so* much worse.

<hr class="section-divider" />

<footer>This article was last updated on 4/30/2023. v1 is 3,382 words and took 8.5 hours to write and edit.</footer>