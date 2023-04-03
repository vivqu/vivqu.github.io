---
title: "Building the Recite Chrome extension"
subtitle: "Rediscover your reading gems in new tabs"
published: true
source: false
seo_description: "chrome-extension quotes reading"
tags: tech life
image: assets/img/posts/recite-extension/book-covers.jpg
read_time: 3 min
---

A few months ago I decided to build a little software project to solve a problem that I've had for years: I [read a lot of books](/blog/2023/01/16/holiday-books/) that have really great quotes that I have saved to my notes or [Kindle notebook](https://read.amazon.com/kp/notebook), but then I never look at them again after finishing the book.

I wanted a low-friction way to recall these excellent snippets of writing I had squirreled away into the dark depths of my note-taking and reading apps. My first instinct was to seek out an existing tool that already does this. Others might immediately jump to building their own custom solution, but I am both busy and lazy. I don't want to reinvent the wheel when my fellow engineers have already built something that can satisfy 80-90% of my needs.

A Chrome extension that modified new tabs to display one of my saved quotes was exactly what I was hoping to find. I thought that this surely existed, especially because one of the most popular Chrome extensions of all time is [Momentum](https://chrome.google.com/webstore/detail/momentum/laookkfknpbbblfpciffpaejjkokdgca?hl=en&__hstc=20629287.a51a184b1f4b68b5a109abeccb174b23.1628192355924.1630000442296.1630011805805.80&__hssc=20629287.1.1630011805805&__hsfp=4043529008)—a beautiful new tab experience that displays an inspiring quote each day.

<br />
![momentum-extension](/assets/img/posts/recite-extension/momentum.png)
*Momentum is a super popular extension that modifies your Chrome new tab to inspire you to be more productive.*
<br />

The only trouble with Momentum was I couldn't customize it to show a quote from my own set of saved quotes, it only showed quotes from their preselected set of list of inspirational quotes. I also didn't need all the other bells and whistles that Momentum provided. So how hard could it be to find a different extension that did what I wanted?

Turns out it was impossible because it didn't exist.

The closest I found was [Readwise](https://readwise.io/), a cross-platform app that integrates directly with different reading sources and aggregates all your highlights. You can have a daily review of your highlights or get a regular email digest of past quotes. It seems like a really lovely product and apparently people have built very [powerful and complex workflows](https://www.roxinekee.com/blog/readwise) using it.

<br />
![readwise-app](/assets/img/posts/recite-extension/readwise.png)
*Readwise also supports powerful features like spaced repetition, tagging, notes, and search to enhance your collection of highlights.*
<br />

But for me, getting another email sent to the blackhole of my personal inbox didn't really satisfy my "low-friction" use case. Plus $5/mo seemed like a steep price for reminding me of my own saved highlights that I painstakingly collected over the years.

So I guess I had to build it myself.

<hr class="section-divider" />

I'm proud to announce [Recite](https://chrome.google.com/webstore/detail/recite/jpngepoglfflfacfcjfodbgnmhejlaoa?hl=en&authuser=0), a simple Chrome extension to display your reading highlights. Each time you open a new tab, the extension will fetch a random quote and display it with a minimal and elegant design.

<br />
![recite-screenshot](/assets/img/posts/recite-extension/screencap.png)
*An example of Recite in action, displaying a quote randomly selected from my saved collection.*
<br />

It's powered using Google spreadsheets to store and retrieve your personal collection of quotes. If you have your quotes stored in different format, I have created a [spreadsheet template](https://docs.google.com/spreadsheets/d/1TsE9HSxYSaYHVrgprOMYRpm6N5E96F8bejeff_t9nqc/edit#gid=0) you can use to get started.

<br />
![recite-authentication](/assets/img/posts/recite-extension/authentication.png)
*You'll give permission to the extension to access your Google spreadsheets from the settings page.*
<br />

You can also choose one of five different color schemes for your saved quotes! I have actually switched between the color schemes a few times when I want a new mood or visual change.

<br />
![recite-settings](/assets/img/posts/recite-extension/settings.png)
*You can also test which color scheme you like the best by loading a sample quote from your Google spreadsheet.*
<br />

I've been using it for a while to randomly select from my saved quotes (447 rows and counting!) and it's been honestly delightful. Whenever I open a new tab, I can take a few seconds to read a quote that reminds me of a good book or intriguing concept I have forgotten. It's also wonderfully low-pressure because I can always ignore the quote if I'm rushing to get some work done—I know that there will always be another quote in another new tab that I can read when I have more leisure time.

<br />
![quote-settings](/assets/img/posts/recite-extension/quote-settings.png)
*Individual columns can also be configured to update the display if you already have an existing spreadsheet that you don't want to modify.*
<br />

If you want to look at the source code or load an unpacked version yourself (using your own Google spreadsheets API key), you can check out the code [here](https://github.com/vivqu/recite_extension). You can also see the [Google OAuth and API usage policy](/recite/) and [privacy policy](/recite/privacy-policy/) for more details.

As Johann Wolfgang von Goethe said, 

> All truly wise thoughts have been thought already thousands of times; but to make them truly ours, we must think them over again honestly, till they take root in our personal experience.

<hr class="section-divider" />

<footer>This article was last updated on 4/2/2023. v1 is 761 words and took 1.5 hours to write and edit.</footer>