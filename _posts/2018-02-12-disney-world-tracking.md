---
title: "How Disney World solved the user tracking problem"
published: true
source: true
---
<p class="source">
(This article was originally published in Prototyper, click <a href="https://blog.prototypr.io/how-disney-world-solved-the-user-tracking-problem-beece7a95e97" target="_blank">here</a> to read on Medium.)
</p>
<br>
Privacy concerns are more common than ever. People are worried about how companies will gather and exploit their data. The outcome of this tracking ranges from relatively benign ([“Amazon’s Next Big Business is Selling You”](https://www.wired.com/2012/10/amazon-next-advertising-giant/)) to potentially impacting our civil liberties and the basic functioning of governments ([“What Facebook Did to American Democracy”](https://www.theatlantic.com/technology/archive/2017/10/what-facebook-did/542502/)).

It’s not an exaggeration to say that companies need to proceed very carefully with data tracking these days. But how did Disney World, which tracks tremendous amounts of guest data, escape our attention and suspicion?

Back in 2010, the [New York Times](https://www.nytimes.com/2010/12/28/business/media/28disney.html) covered Disney World’s quiet evolution into a surveillance state. A newly built command center already used satellites to provide “minute-by-minute weather analysis” and make predictions over the course of guests’ entire vacation time, from the moment of reservation booking to the final crowd levels in the park. The command center then could dispatch solutions to problems predicted by their data:

> What if Fantasyland is swamped with people but adjacent Tomorrowland has plenty of elbow room? The operations center can route a miniparade called “Move it! Shake it! Celebrate It!” into the less-populated pocket to siphon guests in that direction. Other technicians in the command center monitor restaurants, perhaps spotting that additional registers need to be opened or dispatching greeters to hand out menus to people waiting to order.

Disney World constantly adds more data to perfect the guest experience and “does not see any of this monitoring as the slightest bit invasive.” And somehow neither do we. Even the Times article glosses briefly over this privacy issue and seems to accept that data collection is the price we pay for the magic that Disney packages and presents.

Disney’s mass surveillance is a curiosity rather than deeply disturbing. They preemptively resolve tracking fears using two principles:

1. Additional tracking is always a side effect of undeniable improvements in the guest experience.

2. Tracking has clear boundaries for where it starts and stops.

<hr class="section-divider" />

## 1. Tracking as a side effect
Disney first avoids associating their public image with cutting-edge technology and user tracking. Theme park visitors prefer to see the park as an effortless experience sprouting directly from the brain of Walt Disney rather than a highly controlled set coordinated from a central command center with NASA-level (or higher) gadgetry. Park planners encourage you to accept that it’s “magic” and not think about how the sausage is made. If one of the ways they produce this experience is through user tracking, then so be it.

Disney has even outright denied tracking certain data. In college, my senior thesis was building a realtime, optimized attraction scheduler for Magic Kingdom. I made a phone call to Disney to ask for a sample of their historical wait data to test our research models. The operations researcher on the other end of the line responded that “they were not sure if they collected or had access to the data.” He assured me that there would be “interesting work in this area” if I wanted an internship, suggesting I would never get this information as long as I was an outsider. I didn’t take the internship and I never did get to see the data.

The claim that they are unsure about data collection — especially for data as important as wait time data — is complete nonsense. A [corporate profile](http://analytics-magazine.org/corporate-profile-how-analytics-enhance-the-guest-experience-at-walt-disney-world/) of Disney in Analytics Magazine from 2012 outlines how parks can not only forecast park attendance, but also predict the rate of guest arrivals at the hotel front desk, park entry turnstiles, restaurants, and merchandise stores down to 15-minute intervals. Ride wait times are even more critical to measure since these rides are one of the primary appeals of the parks.

There’s no denying that Disney’s ability to craft a seamless experience can be greatly enhanced by data gathering. For example, consider the weather-detection satellite that was mentioned in the Times article. Imagine the following scenario:

> You enter the Magic Kingdom park on your family vacation to Disney World. You have flown across the country to spend a week at the parks. This will likely be the only time you visit Disney World in years, or maybe the only time ever. You enjoy the sun and warm weather, the Orlando area having been carefully selected by the original park designers to have the most consistent sunshine in the country.
> But unlucky you! Rainclouds gather on the horizon. Quietly and undetected by the park guests, the monitoring machinery has already kicked into gear. The minute-by-minute weather analysis alerts the park command center of incoming rain. Notified merchandise staff bring out umbrellas from storage and add them to the storefront displays. Tracking on crowd levels in each park area signal that certain stores need extra stock of rain gear. And when you finally notice that rain clouds are gathering overhead, you look over to the nearest store and see umbrellas for sale. Almost like magic.

Using user data to improve the experience is the bread and butter of successful technology companies. The above thought experiment illustrates that Disney can do this just as well, if not better. They have means to coordinate these responses on a huge digital scale, not to mention the enormous physical scale of the parks themselves.

Where non-Disney technology companies usually get tripped up is when people become aware of the data tracking. Sometimes the extent of the monitoring is revealed by investigative reporting. But more often than not, the products themselves reveal their data tracking in a way that doesn’t benefit the user, making it feel creepy and invasive.

![maps-notification](/assets/img/posts/disney-world-tracking/maps_notification.png)
*A recent Google Maps notification*

Take this Google Maps notification as a good example. I walked to my local hair salon without using any navigation assistance from the app. I did not explicitly tell the app where I was going. Later, I was disturbed to receive this notification. This usage of background GPS tracking was certainly not what I had in mind when I granted those permissions. To add insult to injury, the notification was asking me to give a review so that others might benefit. There is no clear immediate benefit to me, only now a perception of unsolicited monitoring.

Which brings us to Disney rigid adherence to that first principle: every permissions request or visible hint of data tracking is presented as a side effect, the main purpose being an unquestionable improvement in the guest experience. In contrast, that Google Maps notification might eventually improve my own experience by enriching the overall reviews ecosystem, but abstract benefits do not outweigh my data tracking concerns. I would not opt into this feature — tracking me and getting more data is the main purpose of this Google Maps feature. Disney makes sure it’s always better to opt in, even if it means additional tracking.

A great example of this is the new [MyMagic+ mobile app](https://disneyworld.disney.go.com/plan/my-disney-experience/my-magic-plus/), which offers a host of appealing user benefits for visitors to Disney World: realtime wait data, integration with the new wearable MagicBands, restaurant reservations, and usage of their new FastPass+ system. To make it an undeniable choice to use this new app, Disney World retired their old paper FastPass system so that guests would have no other options. To go “offline” by avoiding the app means that you lose out on your chance to use the faster lines.

Far, far down the list of benefits on their website is where you find the hint of secondary motive. The app has an “interactive map that lets you see what’s happening near you at that moment.” No doubt this will help guests explore the park more efficiently, but Disney also gains more data with the realtime GPS tracking of individual guests. A guest might also connect their resort hotel room to charge purchases in the park or perhaps additional family members to reserve multiple FastPasses. Disney is surely using this data to better forecast and predict trends in their guest populations. They may also be quietly adding subtle enhancements to the park experience for certain guests to achieve their own ends.

Disney has managed to turn your own smartphone into a stream of data they can utilize. We agree to it because the resulting personalized experience is so compelling. And they would never disclose the extent of their tracking or ask for more information without tempting guests with new, overwhelming benefits— a lesson that other products don’t seem to have learned.

<hr class="section-divider" />

## 2. Clear boundaries
In 2015, Wired published an article called [“Disney’s $1 billion bet on a magical wristband"](https://www.wired.com/2015/03/disney-magicband/), which brilliantly captures how the company figured out how to prompt mass adoption of a wearable tracker (and thousands of receivers around the park) to serve the ultimate effortless experience. Diners can now preorder their meals and later be seated at a park restaurant where their food “magically” appears, without ever needing to coordinate with a human. Cliff Kuang captures the situation perfectly:

> [This] makes [the MagicBand] exactly the type of thing Apple, Facebook, and Google are trying to build. Except Disney World isn’t just an app or a phone — it’s both, wrapped in an idealized vision of life that’s as safely self-contained as a snow globe. Disney is thus granted permission to explore services that might seem invasive anywhere else.

Which brings us to the second reason Disney World isn’t scary: we enter an implicit contract about privacy boundaries. The physical perimeter of the park itself marks where data collection begins and ends. We are okay with Disney watching us move around the theme parks and snooping on our purchases and controlling the weather because we benefit from it. And we can ultimately leave it behind.

To prove this theory, we can see an example of where Disney’s surveillance crosses the boundary from acceptable to invasive. In 1994, Disney attempted its first foray into the world outside the parks by building a new type of residential community. A few miles outside of Disney World they founded Celebration, Florida, which was going to be a new idyllic suburban community. They took all their experience crafting a complete park experience and applied it to urban planning: everything was designed by Disney, from the signposts down to the manhole covers and pattern books for houses. As this [20-year anniversary recap article](https://gizmodo.com/celebration-florida-the-utopian-town-that-america-jus-1564479405) put it, rather than reproducing Disney World’s happiness elixir, Celebration came off as artificial and dystopian because you were fully immersed in their centrally-managed design:

> For one thing, the mere whiff of utopia sets our teeth on edge these days. After a century of high-profile failures — from Fordlandia to Helicon Home Colony — most of us can’t shake the idea that behind those neocolonial shutters lurks something sinister, whether as simple as tax evasion or as truly nightmarish as a violent cult. In other words, Celebration is not only a victim of its own marketing, but a victim of a public that perceives planned communities as deeply creepy — which is how Celebration is described again and again.

![celebration-map](/assets/img/posts/disney-world-tracking/disney_map.png)
*The map for Celebration even looks like a Disney park map*

The inability to disassociate your private life from a government or corporation is the stuff of dystopian nightmares. It’s easy to imagine that Celebration has the same level of high-tech monitoring as the Disney parks themselves, a command headquarters hidden frighteningly within the community. Whether or not Disney has a surveillance center or is using the data for nefarious purposes matters less than the perception that they could be doing those things.

There are plenty of examples where lack of clear boundaries cause tracking anxieties. Smart-home devices like Amazon Echo have no interaction boundaries besides physically leaving the room to escape their monitoring, raising [privacy concerns](https://www.theguardian.com/technology/2015/nov/21/amazon-echo-alexa-home-robot-privacy-cloud) over exactly how much interaction data they are gathering. Even if Amazon suggests dresses to me due to seasonal trends, completely unrelated to any personal information they know about me, I will still wonder if they knew because Alexa overheard me discussing buying dresses with my friend in the kitchen.

Sometimes there is no easy way to introduce boundaries to alleviate a user’s privacy concerns. If there was, smart product designers and engineers would have thought of it already. For the truly tracking-sensitive, often the ultimate solution is just to physically create boundaries from the devices. Unplug the Amazon Echo. In college, my brilliant information security professor always taped a piece of masking tape to his laptop webcam. “A hacker is able to turn on your webcam without the green light indicator turning on,” he told us. The next day the entire class also had small pieces of duct tape covering their webcams.

<hr class="section-divider" />

These two principles form the underlying technology strategy of Disney theme parks. Both of them can be used to prompt critical thinking from product teams: are we gathering more signals in an unobtrusive manner? If a user does notice, is it clear that there are immediate benefits for them to give us their information? What kind of data is necessary to provide an effortless, “magical” experience? How can we demarcate physical or digital boundaries that will enable trust and de-escalate or remove the privacy question altogether?

Disney World is a special product in many ways. Few other products have its expansive physical real estate and the deep pockets that enable it to so relentlessly focus on the guest experience. But nevertheless there are important product lessons we can learn from the honed craft of Disney’s quiet and often invisible user tracking.
