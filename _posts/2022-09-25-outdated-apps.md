---
title: "Outdated vs. Complete"
subtitle: "In defense of apps that don’t need updates"
published: true
source: false
seo_description: "tech mobile platform"
tags: tech
image: assets/img/posts/outdated-apps/iphone-apps.jpg
read_time: 10 min
---

On August 22nd, I got an email out of the blue from Apple that notified me that I had a new App Review message. It was for my app, [WorldAnimals](https://worldanimalsapp.com/), a light-hearted game for guessing animal onomatopoeia sounds in different languages. 

Usually, you receive a message after you submit a new version to the App Store for review. The reviewer has found something wrong and your app is rejected. The notice explains where you have violated the App Store Guidelines and how you can rectify the issue to get your app update approved. Maybe your app is crashing, the reviewer can’t log in to test, or god forbid the update description mentions their rival platform–these are all actual reasons I have been rejected by the App Store.

The relationship between developers and App Store reviewers is tense at best. Most people are trying to build well-designed, useful mobile apps. Apple has instituted App Store reviews to maintain a high-quality bar for apps and weed out spammy or nefarious actors, using human evaluators to test individual apps and provide direct feedback. However, malicious apps are relatively rare–and arguably, Apple doesn’t do a great job filtering them out anyway. So for the vast majority of developers, App Store reviews add an additional layer of friction and time to shipping updates. And then in the inevitable case when you need to push out an emergency fix for crashes happening to your app users, the App Store review process goes from an inconvenient annoyance to an outright roadblock to improving the user experience.

<div class="twitter-container"><blockquote class="twitter-tweet tw-align-center"><p lang="en" dir="ltr">I think the asymmetry of App Review is still lost on Apple. For indie developers our hopes and dreams (and sometimes our finances) hang in the balance, for the App Review team it’s just another app rejection among tens of thousands. I know they think they get it, they just don’t. <a href="https://t.co/YSsj2zyilA">https://t.co/YSsj2zyilA</a></p>&mdash; David Barnard (@drbarnard) <a href="https://twitter.com/drbarnard/status/1492173728855252998?ref_src=twsrc%5Etfw">February 11, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script></div>

I’ve been around the block, both as an indie developer and a full-time-employed mobile developer. I have released fun, tiny games like WorldAnimals and production SaaS mobile apps. When I was at Pinterest, I helped in communications with our dedicated App Store representative who would expedite Pinterest app updates through the review process. I have seen first-hand the lack of support for indie apps compared to the white glove experience that large companies get. Suffice it to say, I probably have above-average knowledge of how this whole process works.

And _still_, I was surprised to receive an App Review message. I hadn’t submitted a new update for WorldAnimals. The app was still working well, with zero crashes and a handful of new downloads every month. My boss had even shown me last week that he had downloaded my app on his phone for his daughter–we played the game together during a work meeting and laughed at the silly animal sounds. In my mind, there was no reason I should be receiving a vaguely threatening message from Apple’s App Review system.

Well, it turns out, Apple’s problem with my app was the fact that I wasn’t updating it.

<hr class="section-divider" />

I opened the message and was greeted with the ["App Store Improvement Notice"](https://developer.apple.com/news/?id=gi6npkmf). I was essentially told that I hadn’t updated my app in three years and now it counts as outdated. I needed to update the app within 90 days or it would get automatically taken down.

<br />
![app-notice](/assets/img/posts/outdated-apps/improvement-notice.png)
*The message I received from the App Store Review told me my app was "oudated".*

<br />
Never mind the fact that my app has a 5-star rating and was still being downloaded, with no complaints from any of my users. Also disregard the fact that I had other highly-rated apps up on the App Store, some of which had been updated much more recently than July 2019, clearly showing that I have not abandoned these apps entirely. If there had been an actual reviewer who checked my outdated app, they would have discovered that I architected the app from the beginning to dynamically scale the UI so it resizes to fit the latest iPhone devices. All these could be signals that indicate to Apple that this is not a garbage-filled scam app that is lowering the quality of their App Store.

[Many other developers have complained](https://www.theverge.com/2022/4/23/23038870/apple-app-store-widely-remove-outdated-apps-developers) about this draconian measure. The decision to remove outdated apps places a disproportional burden on indie developers and hobbyists because they might not have time or resources to revisit these old apps. Just having an active Apple developer membership [costs $99 a year](https://developer.apple.com/support/compare-memberships/). It feels a bit like extortion when the platform, which you already paid to publish your app once, is now requiring you to continue renewing your membership to make that same app stay available. 

Beyond the financial cost, what is the most insulting to me about Apple’s policy is how poorly thought out their measure of “quality” is for apps. The message contains two separate statements about my app: (1) it hasn’t been updated in three years, and (2) it doesn’t meet a “minimum download threshold.” Fixing either of those so-called problems doesn’t magically mean my app will be a high-quality, positive experience for users.

There is absolutely no requirement for what is contained in the app update since Apple only states, “the app will remain available if an app update is submitted and approved within 90 days.” At least in Google’s case, the Play Store requires an update to their [minimum target level API](https://www.theverge.com/2022/4/7/23014518/google-play-store-cracks-down-on-outdated-apps) which at least ensures that developers will need to be using a newer version of Android Studio. 

The intention behind Apple and Google’s policies is to force developers to make sure their apps run successfully on the latest devices and operating systems. Apple claims that the App Store improvement process will improve user experience because “keeping apps up to date to conform with modern screen sizes, SDKs, APIs [...] ensures users can have a great experience with any app they get from the App Store”. But my app was working correctly, which makes it feel like I am being forced to push a completely useless and performative update.

<br />
![app-screenshot](/assets/img/posts/outdated-apps/worldanimals.png)
*My app was working well even on the latest iPhone and iPad devices.*

<br />
Even more frustrating is that while the app itself runs fine on all the latest end-user devices, Apple’s development ecosystem has changed rapidly over the last three years. My old code simply did not work anymore with the latest versions of Xcode. So I had to spend four hours on Saturday upgrading all my platform libraries simply so that I could compile the damn app. And all this effort was ultimately in order to just change the build version number from “1.0” to “1.1”. The UI and functionality remained unchanged since it had already been working as intended!

<div class="twitter-container"><blockquote class="twitter-tweet tw-align-center"><p lang="en" dir="ltr">I&#39;m sitting here on a Friday night, working myself to to bone after my day job, trying my best to scrape a living from my indie games, trying to keep up with Apple, Google, Unity, Xcode, MacOS changes that happen so fast my head spins while performing worse on older devices.</p>&mdash; Protopop Games (@protopop) <a href="https://twitter.com/protopop/status/1517702095482331137?ref_src=twsrc%5Etfw">April 23, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script></div>

And to add insult to injury, Apple tells me I could have avoided all this pain if my app was being downloaded above a “minimum download threshold”. The policy is completely silent on what this download number needs to be to avoid getting flagged as outdated–is it hundreds or thousands or hundreds of thousands of downloads a month? This seems like an explicit carve-out in the policy for apps with major marketing budgets. According to [industry research](https://www.businessofapps.com/marketplace/app-marketing/research/app-marketing-cost/), the total marketing spend for app installs is projected to be $61.1 billion in 2022. So it seems like an incredibly bad faith argument to claim that a higher download rate means better quality apps. All a higher download rate means is that more money was probably spent to market and optimize app installs.

<div class="twitter-container"><blockquote class="twitter-tweet tw-align-center"><p lang="en" dir="ltr">Apple also removed a version of my FlickType Keyboard that catered specifically to the visually impaired community, because I hadn&#39;t updated it in 2 years.<br><br>Meanwhile, games like Pocket God have not been updated by the developers for 7 years now: <a href="https://t.co/3azyIydty7">https://t.co/3azyIydty7</a> <a href="https://t.co/n36rvHvF4H">pic.twitter.com/n36rvHvF4H</a></p>&mdash; Kosta Eleftheriou (@keleftheriou) <a href="https://twitter.com/keleftheriou/status/1517907548623437824?ref_src=twsrc%5Etfw">April 23, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script></div>

The overall message that this crackdown sends is that Apple doesn't care about about small and independent developers. For instance, the App Store could factor in:

- App Store ratings and reviews
- Active developer membership 
- Historical behavior of the developer (ie. updating other apps)
- Number of crashes
- Number of active sessions, especially for the latest devices and platform versions

These are all metrics that the Apple already automatically tracks, made available to the developer through the [App Store Connect](https://developer.apple.com/app-store-connect/) portal. 

<br />
![appstoreconnect-overview](/assets/img/posts/outdated-apps/appstoreconnect-overview.png)
*App Store Connect shows an overview of your app and includes a variety of metrics, including active sessions and crashes.*

<br/>
![appstoreconnect-metrics](/assets/img/posts/outdated-apps/appstoreconnect-metrics.png)
*The metrics tab enables developers to break down their app metrics by device and platform version.*

<br />
It would be almost zero cost to Apple to add these additional checks to their filter for outdated apps--after all, the data already exists in their system. So it doesn't seem like mere oversight that the policy neglected to use a more nuanced set of inputs, it feels like Apple is actively degrading the developer experience because they consider us worthless to their platform.

<hr class="section-divider" />

In the end, Apple will always prefer the needs of mega-apps that have millions of downloads since these apps generate the bulk of the revenue for the App Store. The impact of the App Store Improvement policy is nonexistent for VC-funded companies. The high-growth apps trying to blitzscale their way to product-market-fit have been churning out regular updates all along with their massive teams of mobile developers. Small apps and their developers will need to conform to the whims of the platform or else disappear entirely–this is and always has been the risk of building software inside a walled garden.

I wish that the App Stores had a concept of a “complete” app that does not need further updates. Emilia ([@lazerwalker](https://twitter.com/lazerwalker)) put it really well by describing certain types of software as “finished artworks”:


<div class="twitter-container"><blockquote class="twitter-tweet tw-align-center"><p lang="en" dir="ltr">.<a href="https://twitter.com/Apple?ref_src=twsrc%5Etfw">@apple</a> is removing a few of my old games b/c they have “not been updated in a significant amount of time”<br><br>Games can exist as completed objects! These free projects aren’t suitable for updates or a live service model, they’re finished artworks from years ago. <a href="https://t.co/iflH70j7q4">pic.twitter.com/iflH70j7q4</a></p>&mdash; emilia ✨ (@lazerwalker) <a href="https://twitter.com/lazerwalker/status/1517849201148932096?ref_src=twsrc%5Etfw">April 23, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script></div>

Games are not the only type of software that doesn’t need updates. Author Robin Sloan has a wonderful app called [Fish](https://apps.apple.com/us/app/fish-a-tap-essay/id510560804), which is an experimental digital essay. The app was last updated in June 2018, “outdated” by Apple’s standards. Sloan has probably contested the removal so it’s still available on iOS, and there is always an option to [read it on macOS or Windows if needed](https://www.robinsloan.com/fish/). Other creators might not be as lucky or have the money/time to provide their work on different platforms.

It will be very difficult to reverse the incentives for Apple and Google and get them to start caring about these small gems. They have been killing apps from the very start, in favor of the newest mobile devices and functionality. There is a whole trend on Tiktok [#oldapps](https://www.tiktok.com/tag/oldapps?is_from_webapp=1&sender_device=pc) that are simply videos of people booting up old phones to play with apps that no longer can be run and reminisce about the joy that these apps created. 

<div class="twitter-container"><blockquote class="tiktok-embed" cite="https://www.tiktok.com/@karalof/video/7124015574182546734" data-video-id="7124015574182546734" style="border-left: 0px; max-width: 605px;min-width: 325px;" > <section> <a target="_blank" title="@karalof" href="https://www.tiktok.com/@karalof?refer=embed">@karalof</a> diving deep back into middle school 😅💅💖 <a title="fyp" target="_blank" href="https://www.tiktok.com/tag/fyp?refer=embed">#fyp</a> <a title="ipodtouch" target="_blank" href="https://www.tiktok.com/tag/ipodtouch?refer=embed">#ipodtouch</a> <a title="apple" target="_blank" href="https://www.tiktok.com/tag/apple?refer=embed">#apple</a> <a title="middleschool" target="_blank" href="https://www.tiktok.com/tag/middleschool?refer=embed">#middleschool</a> <a title="nostalgia" target="_blank" href="https://www.tiktok.com/tag/nostalgia?refer=embed">#nostalgia</a> <a title="nostalgic" target="_blank" href="https://www.tiktok.com/tag/nostalgic?refer=embed">#nostalgic</a> <a title="biginkenergy" target="_blank" href="https://www.tiktok.com/tag/biginkenergy?refer=embed">#BigInkEnergy</a> <a title="retro" target="_blank" href="https://www.tiktok.com/tag/retro?refer=embed">#retro</a> <a title="elementaryschool" target="_blank" href="https://www.tiktok.com/tag/elementaryschool?refer=embed">#elementaryschool</a> <a title="ipod" target="_blank" href="https://www.tiktok.com/tag/ipod?refer=embed">#ipod</a> <a title="apps" target="_blank" href="https://www.tiktok.com/tag/apps?refer=embed">#apps</a> <a title="angrybirds" target="_blank" href="https://www.tiktok.com/tag/angrybirds?refer=embed">#angrybirds</a> <a title="kik" target="_blank" href="https://www.tiktok.com/tag/kik?refer=embed">#kik</a> <a title="appzilla" target="_blank" href="https://www.tiktok.com/tag/appzilla?refer=embed">#appzilla</a> <a target="_blank" title="♬ Say Hey (I Love You) (feat. Cherine Tanya Anderson) - Michael Franti &#38; Spearhead" href="https://www.tiktok.com/music/Say-Hey-I-Love-You-feat-Cherine-Tanya-Anderson-6946697184817465346?refer=embed">♬ Say Hey (I Love You) (feat. Cherine Tanya Anderson) - Michael Franti &#38; Spearhead</a> </section> </blockquote></div> <script async src="https://www.tiktok.com/embed.js"></script>

Day-by-day, month-by-month, the App Store will get a little less rich and vibrant as apps start being designated as outdated and get removed. Another consequence of this hostile policy is that indie and hobbyist developers may stop building mobile apps. After all, the web is fundamentally a more stable place for experimental software and “finished artworks”, since backwards-compatibility is the gold standard and apps can run indefinitely. 

After 4 hours of work to re-compile my app and 44 hours waiting in the review queue, WorldAnimals is now updated to a new version. I am safe for at least another three years before getting automatically flagged for removal. Unless, that is, Apple decides there is a new threshold for "outdated" and change their policy once again.

<br />
![appstore-submission](/assets/img/posts/outdated-apps/appstore-submission.png)
*WorldAnimals is now available for another three years (hopefully).*

<br />
I still love mobile development--a large part of my engineering career has been building mobile apps of all sizes, for small hobby side projects and for huge unicorn companies. I am proud of WorldAnimals and want to make sure it's still available for download. But this outdated policy will make me seriously think twice about building fun, experimental mobile apps on iOS in the future.

<hr class="section-divider" />

<footer>This article was last updated on 9/25/2022. v1 is 1,809 words and took 5.25 hours to write and edit.</footer>