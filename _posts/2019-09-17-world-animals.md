---
title: "Saving time with React Native"
subtitle: "Actual developer data from launching a React Native mobile app"
published: true
source: false
seo_description: "react-native mobile-game mobile-dev software-engineering"
tags: react-native mobile software-engineering
image: world-animals/code-time.png
---

In July 2019, I launched the [WorldAnimals](https://worldanimalsapp.com) app on iOS and Android. The app is a mobile game that teaches you different animal onomatopoeia from languages around the world.

The app idea was dead simple: three screens with easy to use interactions. First, a welcome title screen. Then, the main flashcard-style screen that would show the question ("What does a frog say in Japanese?"). When you tap on the screen, the answer is shown ("gero gero"), accompanied by a sound recording. And finally, a settings page.

<br>
![app_design](/assets/img/posts/world-animals/app-design.png)
*Three screens needed for the WorldAnimals app.*

<br>
Before I even started coding, I knew the app concept was a great candidate for using React Native. Specifically, it was well-suited because the app needed only:
- the same basic UI on Android and iOS
- simple functionality, with no highly-optimized performance demands
- efficient developer utilization, with only one developer available (me)

This post will dive into various stats and data gathered for this project, from ideation all the way to final launch of the product. I wanted hard numbers on how React Native helped streamline my development process. To that end, I made sure to time track the different tasks I worked on during the development of the app.

There isn't much hard data on how much React Native actually reduces costs and improves efficiency. Some claim that the framework reduces development costs by [30-40%](https://ideamotive.co/react-native-development-guide/?utm_source=reactdigest&utm_medium=web&utm_campaign=featured#current-state-of-react-native) and requires [only 20% of code to be changed](https://www.bacancytechnology.com/blog/how-react-native-increase-developers-productivity). Others assert that React Native [doesn't really save you time and money in the long run](https://www.gun.io/blog/react-native-doesnt-save-you-time-and-money) and AirBnb famously [sunsetted React Native](https://medium.com/airbnb-engineering/react-native-at-airbnb-f95aa460be1c) because they did not find much improvement in the overall developer experience, among other problems. 

So in the end, how much time did I actually save?

<br>
## Background and inspiration

The original inspiration for the app came from one specific day in my Japanese language classes when I was living abroad in Tokyo. We started to learn the sounds animals made in Japanese--frogs say "gero gero" (ゲロゲロ ), dogs say "wan wan" (ワンワン), and cats say "nyan nyan" (にゃんにゃん). 

<br>
![nyan_cat](/assets/img/posts/world-animals/nyan-cat.jpg)
*That's how I finally learned what the "nyan" meant in [nyan cat](https://www.youtube.com/watch?v=QH2-TGUlwu4).*

<br>
To make sure the lesson was fun and engaging, my Japanese teacher went around the room asking all the students what sounds we used for animals in our native languages. The class was a diverse mix of people from around the world: Italy, China, the Philippines, France, Brazil, Russia, Norway and America. We spent the next thirty minutes sharing and laughing at how different the same animal could sound. It was one of my favorite memories while learning a new language.

I wanted other language lovers have the same experience, so turning it into a mobile app seemed like a great idea.

To make sure it was viable, I did some basic sanity checking by looking up the major world languages that also had [easily accessible information](https://en.wikipedia.org/wiki/Cross-linguistic_onomatopoeias) on cross-linguistic animal onomatopoeia. I tried to pick the most common animals that still had distinct sounds in each language. I would be personally voicing the animal sounds used in the app in order to create a fun, consistent user experience and make it easy for young children who can't read to still be able to play. Luckily my experience [producing a podcast](https://www.sanfransokyopodcast.com) meant that I had plenty of recording equipment easily at hand.

I tried to loosely cross-reference the languages with the corresponding majority-speaking countries that had [high mobile app usage](https://newzoo.com/insights/rankings/top-50-countries-by-smartphone-penetration-and-users/), to make sure I had a good chance of high audience exposure and downloads once the app launched. Ultimately I chose the following 15 animals and 11 languages:

<br>
![country_by_animals](/assets/img/posts/world-animals/country-by-animal.png)
*Which languages contain specific onomatopoeias for the given animal.*

<br>
From the very beginning, using React Native made a lot of sense for this project. Platform popularity varies dramatically in the different target countries. While Android market share is less than 50% in North America, it has 70% market share in Europe and close to 75% in China, according to [MacWorld](https://www.macworld.co.uk/feature/iphone/iphone-vs-android-market-share-3691861/). Focusing only on one platform would leave out a lot of users. On the other hand, building the same (admittedly, pretty simple) app twice was very unappealing as a solo developer. The promise of React Native is to be able implement an app on both Android and iOS, and implement it efficiently.

WorldAnimals was also an opportunity for me to try React Native in a new way. I have worked as an iOS developer for the last five years, and spent nearly a year researching and testing the [React Native platform at Pinterest](https://medium.com/@Pinterest_Engineering/supporting-react-native-at-pinterest-f8c2233f90e6). But using the framework in a large existing production app is very different than building a mobile app using 100% React Native from the beginning. How much does the framework live up to its promise of cross-platform development in this context?

<br>
## The Data

Overall it took 144 hours from start to final launch for the app or about 3.5 weeks developing full-time. In actuality, I worked on the app part-time for about 3-4 hours a day so it was finished in a little over two months.

If we break down the time by the different phases of production, coding took around 42 hours or 29% of total time:

<br>
![total_time](/assets/img/posts/world-animals/total-time.png)
*Distribution of total time taken to complete the app.*

<br>
"Design" includes time spent prototyping the app UI in Sketch, designing the app icon and splash screens, and hand-drawing the animals and hats used in the app. The "Other" category consists of researching the animal sounds, as well as time spent exploring animation using Adobe After Effects and [Lottie](https://lottiefiles.com). Ultimately, I abandoned the effort for animated interactions because I am not a good designer and I also couldn't get the [Lottie-Sketch plugin](https://github.com/buba447/Lottie-Sketch-Export) to work. 

As for "Marketing", I started with a goal from the beginning to produce an ultra-high quality experience for users. Specifically this meant a really nice landing website and App Store/Play Store experience with nice promotional screenshots. In the past, I did not make any special effort to market previous apps so I wanted to make a good attempt this time around. I will dive into the learnings from the "Marketing" segment in a followup blog post.

<br>
### Part 1: Building the iOS app

Now let's zoom into the coding portion. I fully built the app using React Native on iOS first before porting it to Android. You can assume all non-Android-specific categories in the graph below indicates time spent building the app on iOS.

<br>
![code_time](/assets/img/posts/world-animals/code-time.png)
*Distribution of time taken to code the app.*

<br>
Unsurprisingly, the largest chunk of time taken was getting the basic functionality working (12 hours). I used vanilla React Native rather than Expo since there was a lot of libraries included in Expo that I did not need, which would bloat the app size unnecessarily. But even with vanilla React Native, I had to manually comment out the [geolocation API](https://facebook.github.io/react-native/docs/geolocation) enabled by default in order to stop Xcode from complaining about location permissions.

It is difficult to estimate the exact difference in development time using React Native on iOS versus native Swift or Objective-C code. Because of my background as an iOS developer, I have stronger fluency with native libraries compared to the corresponding Javascript ones. On the other hand, React Native saves implementation and testing time with instant app reloading, fixing the problem of painfully slow Xcode compilation times.

One rarely-discussed downside of choosing React Native is losing out on tools in Xcode. [Storyboards](https://developer.apple.com/library/archive/documentation/ToolsLanguages/Conceptual/Xcode_Overview/DesigningwithStoryboards.html) are a WYSIWYG tool that is useful for dynamic layouts and especially powerful for simple UI screens like the ones in WorldAnimals. [Artsy's explainer on React Native for iOS developers](https://artsy.github.io/blog/2017/07/06/React-Native-for-iOS-devs/) cites storyboards as one reason to keep some of their apps in native. 

<br>
![storyboards_resizing](/assets/img/posts/world-animals/storyboards-resizing.png)
*Adding resizing constraints is just a few mouse clicks using Storyboards.*

<br>
I also couldn't justify trying to use storyboards with React Native for this project. The minimal productivity gains of using storyboards come at the cost of huge overhead in terms of time and code complexity to bridge native files into Javascript, making it unappealing to have a hybrid app. Plus, these ported storyboards would be unusable in Android. And given that the entire purpose of using React Native is to be able to share code cross-platform, it is better off to build an 100% React Native app from the start. 

Given these tradeoffs, I am assuming that it is essentially the same amount of time (as an iOS developer) to build an iOS app regardless of whether you use native or React Native. I was trading off proficiency with Swift/Objective-C and platform-specific tooling for faster builds and code iteration. Assuming a basic level of familiarity with Javascript, it is overall net neutral for a native developer to switch to using React Native on their home platform. 

I do think there are significant positive benefits in using React Native for developers who have little to no familiarity with the native mobile platforms because it suddenly unlocks the ability to build apps without needing to learn an entirely new ecosystem. So web developers will find it much easier to get started on iOS by using React Native. Similarly, I saved so much time because I did not need to learn everything about the Android platform to [build an Android version of WorldAnimals](#part-2-building-the-android-app). 

But before we get to Android, let's talk about a few pain points when using React Native. The biggest surprise in post-analysis was the amount of time spent on accessibility (7.25 hours), localization (3.3 hours), and the loading animation on the splash screen (1.75 hours). I underestimated how unwieldy React Native was in these few cases due to subtle differences in the framework compared to the underlying mobile platforms.

<br>
![cost_time](/assets/img/posts/world-animals/cost-time.png)
*Time spent in these categories were higher compared to native development.*

<br>
For accessibility, it is not obvious how the [accessibility properties](https://facebook.github.io/react-native/docs/accessibility) provided by React Native will translate to native. Getting the proper sequence of accessibility labels read by VoiceOver is definitely more art than science even when using native APIs, and React Native just adds another layer of obfuscation. Plus there are many "iOS only" or "Android only" properties which demand a careful reading of the docs to get right.

Regarding localization, React Native does not provide a built-in library for localizing strings based on a user's locale. Setting up [`react-native-localize`](https://github.com/react-native-community/react-native-localize) and [`i18n-js`](https://github.com/fnando/i18n-js) is required if your app needs localization. This adds more setup and configuration friction that doesn't exist when using `NSLocalizedString` on iOS or `strings.xml` on Android.

Finally, there is the problem of splash screens. There are still a few cases where you must leave the React Native development environment to dive into the native code and tooling. On app start, the underlying framework architecture first [initializes the Javascript bridge](https://tadeuzagallo.com/blog/react-native-bridge/) and [loads the JS bundle](https://facebook.github.io/react-native/docs/performance#loading-javascript) before any UI is shown. And because splash screens are shown immediately when the app is launching, developers need to have a native splash screen that is displayed while the JS is unavailable. While there are plenty of [good](https://medium.com/handlebar-labs/how-to-add-a-splash-screen-to-a-react-native-app-ios-and-android-30a3cec835ae) [tutorials](https://www.freecodecamp.org/news/how-to-add-app-icons-and-splash-screens-to-a-react-native-app-in-staging-and-production-d1dab615e7c6/) that you can easily follow to set up a smooth splash screen experience, you may encounter some subtle bugs caused by rendering differences in native code and Javascript. I had issues with image positioning and ended up spending a lot of time making two splash screens look identical. 

<video autoplay loop muted playsinline style="width:250px">
  <source src="/assets/img/posts/world-animals/splash-screen.mp4" type="video/mp4">
</video>
<em class="video-subtitle">Transitioning from native to React Native splash screen may require layout adjustments.</em>

<br>
### Part 2: Building the Android app

In the previous section, I discussed why development time is largely equivalent whether or not you use React Native for single-platform development as an experienced mobile engineer. React Native becomes extremely compelling when you start building on the second mobile platform.

I recorded Android development time as time spent on android-specific UI and functionality (4 hours) and getting the android build to work (1.75 hours). Overall, only 13.7% of total coding time was spent on porting a fully functioning iOS app onto Android. 

<br>
![code_time](/assets/img/posts/world-animals/android-code-time.png)
*Time spent building on Android as percentage of overall coding time.*

<br>
Let's ignore my inexperience on Android for a moment. Assuming that I could build a production-level native Android app in the same time as it took me on iOS, it would still have taken another 36 hours to rebuild WorldAnimals. This means that code reuse reduced the dual platform implementation time from an estimated 72 hours to 42 hours, saving me **41.6% development time**.

<br>
![android_time](/assets/img/posts/world-animals/android-time.png)
*Visual representation of estimated time taken if I had developed both mobile apps using native.*

<br>
Of course, 41.6% is a lower bound on time saved using React Native. I would have needed to ramp up on the Android platform before being able to build the app. A ballpark estimate on the time needed is another 40 hours to get up to speed, calculated by taking the average time needed for the top five Android development courses on [Udemy](https://www.udemy.com/courses/search/?src=ukw&q=android%20development).

I was able to reuse most of the Javascript code since the planned app design and functionality was pretty much identical between the two platforms. WorldAnimals has a total of 3028 lines of Javascript code (pulled with [cloc](http://cloc.sourceforge.net/)):

{% highlight shell %}
~/code/world-animals/src (master) $ cloc ./

11 text files.
11 unique files.                              
0 files ignored.

github.com/AlDanial/cloc v 1.82  T=0.24 s (46.4 files/s, 13424.9 lines/s)
-------------------------------------------------------------------------------
Language                     files          blank        comment           code
-------------------------------------------------------------------------------
JavaScript                      11            102             53           3028
-------------------------------------------------------------------------------
SUM:                            11            102             53           3028
{% endhighlight %}
<br>
There were about 165 lines of platform-specific code, or around 5.5% of the JS codebase. Most of the required changes were adapting the app UI for Android conventions, including:
- Hardware back button handling
- Using material design-compatible icons
- Deep linking to Play Store instead of App Store
- Minor margins and padding tweaks

For example, action icons are slightly different on iOS and Android. I updated the icons on the settings page to match commonly used design patterns on the respective platforms.

<br>
![ios_android_ui](/assets/img/posts/world-animals/ios-android-ui.png)
*Updating icons based on the mobile platform gives users a more native experience.*

<br>

React Native provides an elegant way to check for the platform and use the correct icon and margins. The code snippet below renders the prompt for the users to share the app ("Share with friends and family"). Only lines 14-15 need to be updated to get the UI to look nice on Android:

{% highlight react linenos %}
return (
    <View style={styles.rowStyle}>
        <Text accessible={true} style={styles.settingsText}>Share with friends and family</Text>
        <TouchableOpacity
            accessible={true}
            accessibilityLabel={'Share'}
            accessibilityRole={'button'}
            style={styles.rightAlignItem}
            activeOpacity={0.5}
            onPress={this._onPressShare}
            hitSlop={styles.rightAlignItemSlop}
        >
            <Image
                source={Platform.OS == 'ios' ? require('../images/share-ios.png') : require('../images/share-android.png')}
                style={[styles.settingsButtonStyle, { marginRight: Platform.OS == 'android' ? 4 : 0 }]} />
        </TouchableOpacity>
    </View>
);
{% endhighlight %}

However, there were a few gaps in React Native that required additional work on Android. For instance, a [poorly documented React Native bug](https://github.com/facebook/react-native/issues/1402#issuecomment-107629965) caused a white flash when launching the app. The bug had a relatively easy solution on iOS while requiring a [third-party library workaround](https://github.com/mehcode/rn-splash-screen/) for Android.

In addition, there was significantly more work needed to configure the Android build and [publish to the Google Play Store](https://facebook.github.io/react-native/docs/signed-apk-android). For the iOS-specific configuration, I needed about 35 lines of Objective-C code for the `AppDelegate.m` file and one WYSIWYG storyboard file to set up the native iOS splash screen. Android needed 223 lines of native code: 70 lines for `android/app/build.gradle`, 20 lines for `MainActivity.java`, and 133 lines of XML/Java to get the native Android splash screen up and running. That's about 6 times as much native code on Android compared to iOS.

Furthermore, third party React Native libraries seem to have more problems on Android. I used [`react-native-sound`](https://github.com/zmxv/react-native-sound) to play the recorded animal sounds in the app. There are more than double the number of reported issues on Android ([23 open issues](https://github.com/zmxv/react-native-sound/labels/android)) compared to iOS ([10 open issues](https://github.com/zmxv/react-native-sound/labels/ios)). Not only that, I also had to fix a bug where users [stopped being able to hear sounds](https://github.com/zmxv/react-native-sound/issues/574) after 30 plays, which only happened on Android devices.

In general it does seem like Android is somewhat of a second-class citizen for React Native. The platform needs more complicated bug fixes and workarounds, requires significantly more time spent on build configuration and deployment, and opens up your project to more potential issues when adopting third-party libraries. And although I didn't encounter this problem in this project, React Native reportedly has [performance issues](https://blog.discordapp.com/using-react-native-one-year-later-91fd5e949933) that affect Android much more than iOS. It is not clear to me if these difficulties arise from underlying complexities of Android itself or capabilities missing from React Native that might be addressed in the future.

<br>
## The results

The actual recorded results actually showed even better gains than expected:

{:.post-table}
|             | Expected | WorldAnimals |
|-------------|----------|--------------|
| Time saved  | 30-40%   | >41.6%       |
| Code shared | 80%      | 86.9%        |

Be sure to take these numbers with a grain of salt. WorldAnimals is in some ways the ideal case for React Native, due to the simple and streamlined nature of the app. There are many situations where it [may](https://medium.com/airbnb-engineering/sunsetting-react-native-1868ba28e30a) [not](https://engineering.udacity.com/react-native-a-retrospective-from-the-mobile-engineering-team-at-udacity-89975d6a8102?gi=5b2dc02dff2a) be the best tool of choice. Even in my development journey for this project, I encountered plenty of stumbling points for the framework when compared to native. 

Overall, React Native succeeded as a tool to improve developer productivity and efficiency. My one-woman team moved much faster with the ability to share code, easily test UI and make minor platform-specific tweaks, and skip learning all the nuts and bolts of a new mobile platform. 

Stay tuned for the next post, where I'll describe the mistakes and learnings in my attempt at amateur marketing the WorldAnimals app.

<hr class="section-divider" />

<footnote>This article was last updated on 09/17/2019. v1 is 2,645 words and took 6.5 hours to write and 1 hour to edit. If you any feedback on this post or want to share your experience with React Native, you can send me a note <a href="mailto:hello@vivqu.com">here</a>.</footnote>