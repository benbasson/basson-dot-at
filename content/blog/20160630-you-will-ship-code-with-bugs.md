---
author: Ben Basson
authorurl: http://plus.google.com/107880308657806834664
title: You will ship code with bugs
subtext: Some you'll know about, some you won't.
date: 2016-07-03T20:51:41 +1
shortname: you-will-ship-code-with-bugs
description: The reality of shipping products is that you'll ship with known bugs. This post is about why that happens and how to prioritise remedial work.
summary: The reality of shipping products is that you'll ship with known bugs. This post is about why that happens and how to prioritise remedial work.
---

This is the fourth part of my blog mini-series of [things university doesn't teach you about being a software developer][1]. This post is about the reality of shipping products and why you'll need to adjust your expectations when transitioning from academic software projects to the business world.

Thing 4 - You *will* ship code with bugs
----------------------------------------

I have some disturbing news for all budding software development perfectionists out there: Whether you like it or not, you will ship a product that has bugs in it.

Nothing is foolproof, nothing is bug free, and most of the time, you'll only know about some of the problems. There'll be plenty of bugs you don't know about too, and they might lurk for *years*.

University work does not cover quality metrics
----------------------------------------------

A running theme of this blog series is that coursework is too short term to be an effective learning aid for so many useful software engineering concepts, and the idea of quality control and knowing when to ship your software is no exception.

In addition, your entire objective with all work handed in at university is to make it as *perfect as possible*, and you almost certainly have the time to do that. With a few hours of lectures you'll end up with ~12 hours free time every weekday to spend on your coursework, which will be fairly limited in scope anyway.

When you're out in the real world you (or your employer) ultimately can't afford to spend time polishing products until they're perfect. There's also very little chance that you'll work on something so defined and tight in scope that bugs won't creep in.

Why ship something with known bugs?
-----------------------------------

There's a reason that almost every moderate to large software product in existence has a "known bugs" section in the release notes, and that's because holding back a release can have a significant business impact. 

Software isn't just a set of fun problems to solve (although that is a side benefit), it's about building something that delivers business value (either through sales, or intangible benefits).

Once you realise that software is *all* about business value, you'll realise that it's almost always preferable to ship something, even if it isn't perfect (unless you're writing an air traffic control system or something). The sooner you get your product (or new features) to market, or to your end users, the sooner they benefit and the sooner you make money. 

Obviously you'll try to fix as many bugs as you can before your looming release date, but how do you know which to fix? Ultimately every well-scoped bug report has two key aspects to it; severity and priority.

Prioritising bug fixes
----------------------

Are severity and priority different things? Some quick Googling will show you that there is an eternal debate over what they are and what they're for, but the short answer from my experience is "yes". 

So what are they?

I see severity as an indication of the level of problem experienced by a user - does it cause the program to crash, is it just a minor user interface nuisance, is it a typo? The severity should be an **accurate technical assessment** made by a software engineer, noting the technical and potential business consequences of the problem.

The priority is an indication of the **business value** of fixing the bug. Maybe the program crashes when you press a certain button, but this only affects one user,  whereas another bug simply makes users have to click a button twice, but affects a million paying customers. 

Often a high severity bug will also be high priority, but it's not always that simple and there are always lots of unknowns.

The priority may be suggested by developers, but *must* be agreed with business stakeholders. To make this judgement, your stakeholders must understand the technical implications of the bugs being discussed, and it's the job of a good development team (or team lead) to communicate this properly.

Building a prioritised backlog
------------------------------

Knowing that there are bugs is useful, but never forget that you're also building software for a *purpose* and that's an ever-moving target. Having a well written and prioritised backlog will help you plan out what you're working on in the short and medium term.

To make a backlog useful then you need to have actionable tasks in it - either bugs or enhancements that have the following:

 - Some indication of complexity (time estimate, story points)
 - Priority (how important it is to the business)
 - Severity (what the technical impact is)
 - A solid description of what actually needs to happen
 - Ideally, some notion of acceptance criteria (i.e. user stories)

Once you have this, you can have a meaningful discussion about what to work on and when. You can plan out a few weeks of work, always focusing on what provides the most business benefit. The higher up in the backlog an item is, the better defined it should be.

One of the [Joel Test][2] metrics is "do you fix bugs before writing new code", a sensible position to take, but the reality is that there's always a trade-off.

Most software is sufficiently sophisticated that you'll be adding functionality *somewhere* while potentially leaving bugs in another area of code to languish. It's a good idea to solve bugs in an area of code you plan to enhance or build on top of, but that's hardly a black and white issue either.

You need a longer term roadmap
------------------------------

Bug fixes are only one part of software development, you also need to keep an eye on the future - what features do you want to include? You need to understand what prerequisites for those features might be - where will bugs need to be squashed, or code refactored?

Having a prioritised backlog helps you to have sensible discussions about these things. 

What can universities take away from this?
------------------------------------------

There are some important core skills that could be taught (at least in a theory-heavy module on software engineering) and I think it's viable to combine that with some practical exercises:

1. Assessing product quality
2. Fully describing and documenting problems
3. Prioritising problems / building a backlog

Although I think it would require very qualitative grading, it would be possible to give students a piece of software and have them test it, use it, find bugs, document those bugs and then build a prioritised backlog for fixing them. 

What can students take away from this?
--------------------------------------

This is a tricky topic and prioritisation is never easy. Ultimately, as I said at the start of this post, you'll ship with known bugs, and as most software developers are perfectionists, it's a very alien concept to get used to.

I would definitely suggest practising this on any hobby projects you have. 

Build up a backlog of issues (which includes desirable features as well as bugs). Prioritise that list. You'll find it makes keeping on top of all your ideas a lot easier, and if you put tentative estimates against the various tasks, you'll be able to pick them off appropriately when you have spare time to work on your side projects.

Importantly - assess the quality of your side projects, but ultimately get something out there. Most of the time they won't be changing the world or making you any money, so you're in a great position to ship with bugs!

Next up!
--------

Next time I'll be writing about how to present your work effectively. This is mostly about product demonstrations (i.e. to customers or getting feedback from business owners) but I'll also delve into public speaking and other communication channels.

[1]: /blog/things-uni-doesnt-teach-you-about-software-dev
[2]: http://www.joelonsoftware.com/articles/fog0000000043.html