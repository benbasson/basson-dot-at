---
author: Ben Basson
authorurl: http://plus.google.com/107880308657806834664
title: Consuming APIs and libraries
subtext: Understanding and managing your dependencies.
date: 2016-11-27T22:44:16
shortname: consuming-apis-and-libraries
description: Software development is all about trade-offs. You can use APIs and libraries to build features quickly and to open up new opportunities for functionality, but this all comes at a cost.
summary: Software development is all about trade-offs. You can use APIs and libraries to build features quickly and to open up new opportunities for functionality, but this all comes at a cost.
---

This is the seventh part of my blog mini-series of [things university doesn't teach you about being a software developer][1].

These days, if you're writing any moderately complicated software, it's very likely you'll be reusing code or making use of common libraries or APIs to help you build things better and faster. 

This isn't cost-free and there are a lot of potential pitfalls. A solid experience of integrating software components allows you to anticipate these problems, but more importantly, to build amazing new things out of simpler parts.

Thing 7 - Consuming APIs and libraries
--------------------------------------

In professional software development, you'll probably be doing this all the time. If you need to create PDF files, why learn the entire PDF specification and implement the bits you need, when you could grab a library that gives you a simple API you can get started with in minutes? If you want to add value these days, you'll almost certainly be mashing data together from multiple sources.

So what does it really mean to use a library or an API? Fundamentally, it means creating a dependency, and every time you do this, you need to understand a fair bit about it. Is it robust? Is it going to last? Will that API be there tomorrow?

Why is this so important to understand?
---------------------------------------

The most compelling argument for reusing someone else's API or library is that it makes you more competitive than someone who doesn't. Getting features out to your customers quickly is the name of the game, the faster you do that, the faster you create value. 

There are also lots of pragmatic reasons - why waste time on a problem that's already been solved? If you rolled your own solution, would it even be any better? Will you have time to keep your solution working when things change?

The industry is also seeing an increasing shift towards using a [microservice architecture][2], where APIs play a hugely important role, separating out core parts of an application. This poses similar challenges to external API dependencies.

What are the risks of using APIs?
---------------------------------

These are some of the main challenges that you'll have to mitigate:

1. Outages - if a remote (or even local) service becomes unavailable, you need to have a strategy to cope with that. This could be graceful error handling, a local cache of data, etc, but you need to think about it because it *will* happen.
2. Latency - the more network links you introduce, the more you are at risk of latency. This can be managed in many different ways, but for most applications this is a negligible concern.
3. Incompatible changes - you'll have to keep up to date with API changes as older versions of an API get phased out.
4. Weird behaviour - an API could give you unexpected data, or something could get corrupted in transit, so you need to anticipate, detect and deal with that.

All of these fall under "handle errors properly", but it's easy to forget one or more of them.

What are the risks with using libraries?
----------------------------------------

The risks with APIs are mostly about not having control, the risks with libraries are similar although arguably slightly more scary:

1. You're trusting foreign code in your software. Is it secure? Does it impact on memory, garbage collection, etc? When you're using an API, these are someone else's problems, but with a library they're yours too.
2. Security vulnerabilities - if you're using a library, you'll most likely need to keep it up to date, which adds management overhead.
3. Updates - when you upgrade the library, you may have to update your code to match any interface changes. 
4. Licence - can you use the library legally? Is it compatible with your software licence?
5. Bugs - can you do anything about them? Is the project actively maintained? Can you submit fixes (and tests), or will you be stuck on your own fork of the library?

Remember that you're trading off writing and maintaining code for management of the risks above. 

"Not invented here"
-------------------

Sometimes you'll encounter resistance to using third-party libraries or APIs, but before accusing someone of having "[Not Invented Here Syndrome][3]" it's worth listening to their arguments. 

Sometimes you do need something more specific, more tailored, more accurate or trustworthy, and in those cases it may well be worth investing your time and effort into a bespoke solution. 

Of course, sometimes that's also a terrible idea. But without the discussion, how will you know the right approach? It's never as clear cut as you think!

Why university courses don't cover this
---------------------------------------

Computer science courses are all about fundamentals of computing, teaching you the core concepts that you need. Generally, however, they're light on practical implementation, and it's usually an after-thought if it's present at all.

Software engineering, on the other hand, is much more about building things, but tends to focus on *you* building things rather than reusing existing software to your advantage. 

In all of the coursework that I did at university, I can remember precisely one single instance where we reused some Java libraries, and even then it was limited to helping us manipulate 2D graphics a bit more easily.

How could this be covered at university?
----------------------------------------

I think it would be pretty simple to bake this in to pretty much any kind of web application development module.

Have students expose data from another source that they integrate via its API. Maybe they could read in some data and then add a mapping library (or other data visualisation tool) to expose that data. That's one API and one library covered in a single routine task that any web developer might have to perform.

Finally, they could teach some theory on open source licences - you can pick up the basics pretty quickly, but it's such an important topic and it trips developers up time and time again.

What should universities take away from this?
---------------------------------------------

This is a massively understated subject matter, given the general direction of software development over the last few years. Yes, computing fundamentals are important, but so are practical applications of theory.

Foster a culture of code re-use. It's important to assess each student for their software coding abilities, but also to develop their understanding that real world software is built on layer upon layer of reuse.

Teach the benefits and the risks inherent to this subject matter. It's only going to become more important over time.

What should students take away from this?
-----------------------------------------

There are a whole bunch of ways you can pick up these core skills outside of university:

* Make sure you reuse libraries and APIs in your hobby projects. If it's meant to be fun, you probably don't want to be grinding away for hours solving already solved problems.
* Go to a hack day (like [BattleHack][4]), string a bunch of stuff together and watch it work (or rather, "work"). As a bonus, this also gives you experience at pitching and presenting your work. You could even win a prize!
* Learn about open source - there's plenty of information out there. Teach yourselves about the different types of open source licence and when they should (or shouldn't) be used.
 
Always be aware of the implications if you build something that's supposed to be fit for production use - it's not straightforward and there are no easy answers. Using other people's stuff is a great way to get you there faster, but you're ultimately making trade-offs no matter what your decision. 

Next up!
--------

I'll be discussing the issues of project planning, execution and scale, and how these day-to-day topics could be woven into a university syllabus.

[1]: /blog/things-uni-doesnt-teach-you-about-software-dev
[2]: http://martinfowler.com/articles/microservices.html
[3]: http://www.joelonsoftware.com/articles/fog0000000007.html
[4]: https://www.battlehack.org/