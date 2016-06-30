---
author: Ben Basson
authorurl: http://plus.google.com/107880308657806834664
title: Regressions matter
subtext: Best to avoid playing whack-a-mole with software bugs...
date: 2016-06-30T21:15:11 +1
shortname: regressions-matter
description: On a typical university course, almost all code you write is thrown away. This means that you won't have to deal with the possibility of introducing bugs into existing, functioning code. This post covers that topic in detail and outlines why it's so critical to understand.
summary: On a typical university course, almost all code you write is thrown away. This means that you won't have to deal with the possibility of introducing bugs into existing, functioning code. This post covers that topic in detail and outlines why it's so critical to understand.
---

This is the third part of my blog mini-series of [things university doesn't teach you about being a software developer][1]. This post is about regression - what it is, what the impact is and how to mitigate against it when changing code.

Thing 3 - Regressions matter
----------------------------

University coursework projects tend to be relatively small, concise in scope, and thrown away very quickly. [As I wrote previously][2], this is less than ideal for a number of reasons, but mostly because it does nothing to train you in writing code that will last.

A typical assignment will be set to help learn a very specific concept, or set of concepts, you quickly write some code which works (or doesn't) and ultimately you'll hand in something that you won't need to change later.

In the world of business, this is rare. 

In the "real world", you may write perfect code that does exactly what it's supposed to, or, more realistically, you will write *somewhat* competent code that *mostly* does what it's supposed to. Once that code ships, you'll move on to something else. 

But that code will live on, for longer than you'll ever imagine it will. It'll be part of something that matters, and that means how you treat it in the future matters too.

What is regression?
-------------------

Once you (or someone else) has written a piece of software that's serving a business function, it'll start getting used. Over time, bugs will surface or feature changes will be needed (as the business environment changes, or you add features to be more competitive in the market). 

You're tasked with making a change to this functioning software. In any sufficiently complex system, your change *may* introduce another bug - this is known as a regression, i.e. the behaviour of the overall system has regressed to something worse than it was before.

What are some likely problems?
------------------------------

In my mind there are a few core risks, ranging from "mildly troubling" to "pretty scary".

### Basic functionality bugs

First and foremost, on the milder end of the scale, there's a possibility that your change has a straightforward knock-on effect on another feature in the software - either undesirable behaviour or something flat out stops working.

This is fairly manageable and will often be caught at development time as part of a diligent quality assurance process - i.e. you'll have automated tests, someone actually in charge of quality and testing, etc. 

Even if this kind of bug makes it through your processes and into a production environment where customers notice a problem, assuming you can deploy updates quickly, this probably isn't going to cause any sleepless nights.

### Performance problems

Typically if you have a simple feature and you add more functionality to it, there'll be a performance hit somewhere - doing more things takes more time on the CPU and more RAM. Almost all of the time, this is a perfectly acceptable trade-off for the business value your change provides. Sometimes it isn't.

Performance issues come in two main forms:

1. Inefficient implementation of a feature or change (the code isn't as optimal as it could be, uses resources in a strange or poorly designed way, etc).
2. A seemingly reasonable change manifests in an unintended increase in resources elsewhere while the software is running.

The first is an issue of good coding discipline and design, the second an issue of the overall software architecture. Both should be possible to detect with a decent continuous integration setup, but ultimately if the penalties are small enough they could build up over time without anyone noticing (like the hypothetical frog in slowly boiling water).

### Subtle problems with data accuracy or corruption 

This is the nasty kind of issue - something that's hard to spot, actively problematic, and relatively easy to introduce. 

I have no real tips for you apart from be bloody careful if you're changing how important data is written. Look at things like data precision, length, validation, casting and be careful not to fall foul of them. Test, re-test and test some more. 

What to do if you've caused a regression
----------------------------------------

The simplest course of action is to back-out the offending code, reverting it to its previous working state. This has the advantage that it's easy and quick, but the obvious disadvantage is that any new functionality being relied on is temporarily lost.

If you think you can fix the issue while keeping your desirable change in-place, then great, but be careful that you don't end up playing whack-a-mole with your bugs:

<a href="https://www.flickr.com/photos/tpapi/2765541278" target="_blank" markdown="1">
  <img src="/images/blog/whack-a-mole.jpg" width="600" height="450" alt="Man hitting whack-a-mole machine with a mallet" markdown="1">
</a>

Regressions are usually indicative of poor architecture, poor test coverage or both, and so it's easy to see how you could end up going around in circles fighting these fires.

The most important thing is that you fix things for your customer, but also address the root cause, also known as the "[fixing things twice][3]" method:

1. Fix the customer's problem
2. Stop it happening again, by asking the [five whys][4].

How to prevent regression
-------------------------

So once you've accepted that regression is a real problem that you'll have to tackle, what can you do about it?

Unit tests can mitigate against regression for obvious, low level changes, and integration tests may pick up faults at a higher level, but even the most diligent business won't have 100% coverage and things could slip through. Code reviews mitigate to an extent, but they're more about whether the solution strategy is correct rather than for weeding out bugs.

The best way to mitigate the risk of regression is to have well-factored code with decent [separation of concerns][5]. You can't stop people writing bugs, but by design you can try to stop those propagating outside of the area being altered.

It's also helpful if you have a good understanding of the code you're changing. This isn't always as likely as it might sound, given a sufficiently large codebase.

Part of the appeal of [microservices][6] is that they're easy to small, and easy to understand, and enforce good separation of concerns. In theory, this makes them easier to change and test without huge risks of regression  

Ultimately, no matter your software architecture, you're always going to have to weight up the impact of a potential regression against the amount of time and effort that it's worth investing into your development activity.

What should universities take away from this?
---------------------------------------------

To be honest, I think it would be tricky for universities to do much about this, but they could certainly at least start students thinking about how to change existing code that they didn't write themselves.

For instance, this could come in the form of a worked example of some subject matter that has some bugs in it, and the students would have to fix the bugs without introducing any further problems. Unit tests could be provided, or students could be required to write them to assure against unexpected fallout.

Ultimately the best thing universities can do in this arena is to help students design well-factored code and teach good software architecture. It really is the best protection.

What should students take away from this?
-----------------------------------------

Unless universities start setting you tasks to work on existing pieces of code, you're probably not going to get much practise picking up things other people wrote and making coherent and working changes.

I would strongly advise contributing to an open source project - the bigger the better. [Mozilla][7] has a generally welcoming open source community. The learning curve is quite steep, but you will find people willing to help you get started.

You don't need to be a software architect to be a developer, but you should develop an understanding of how good quality software is architected - with a decent separation of concerns, the right levels of abstraction and so on. Like most core skills, this will be more useful than any individual programming language you could learn.

Next up!
--------

Next time I'll be writing about the inevitability of shipping code with bugs, of which there are two types - the ones you know about, and the ones you don't!

[1]: /blog/things-uni-doesnt-teach-you-about-software-dev
[2]: /blog/writing-code-for-the-long-term
[3]: http://blog.fogcreek.com/scaling-customer-service-by-fixing-things-twice/
[4]: https://en.wikipedia.org/wiki/5_Whys
[5]: https://en.wikipedia.org/wiki/Separation_of_concerns
[6]: http://martinfowler.com/articles/microservices.html
[7]: https://developer.mozilla.org/en-US/docs/Mozilla/Developer_guide/Introduction