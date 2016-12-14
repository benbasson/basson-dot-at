---
author: Ben Basson
authorurl: http://plus.google.com/107880308657806834664
title: Project planning and scale
subtext: Putting structure around your software development.
date: 2016-12-14T21:43:15
shortname: project-planning-and-scale
description: Most of the projects you work on at university are relatively small. In professional software development you'll encounter projects of every scale, not just in terms of customers or throughput, but also complexity.  
summary: Most of the projects you work on at university are relatively small. In professional software development you'll encounter projects of every scale, not just in terms of customers or throughput, but also complexity.
---

With the possible exception of a final year dissertation, or post-graduate thesis, all the work you do at university will be on the smaller end of the scale. Unless you end up working for Google, Microsoft, or a large bank (etc), you'll probably stay in the small-to-medium end of the spectrum.

That's not to say that your products and services won't have to scale to lots of users, but there's a difference between the scale and complexity of your project, and the size of the market and market share that it occupies.

Understanding the differences in project scale is important, because you have to approach these situations differently to work effectively. This post will cover some of the issues at a high level.

Thing 8 - Project planning and scale
------------------------------------

There's a huge difference and variety in software these days. Despite this, it's fairly easy to compare software in terms of complexity - how many parts does it have, how many points of failure, how complex are the challenges it is solving? Broadly speaking I would say there are three major categories: 

1. On one end of the spectrum, you have things like web forms ("contact us"), surveys and so on. Basic web applications that have few points of user interaction and store relatively little data. 

2. Then you have things like web forums, chat programs, social media, basic online shops, more complex web applications (such as renewing your driver's licence). These are more complex, but still only have a handful of components, and are fairly easy to reason about.

3. Finally, you have things like Gmail, Amazon, Netflix, online games, etc. Huge applications with hundreds of moving parts. 

Typically, the more complex an application, the larger the team (or number of teams) needed to produce and maintain it. There's also no way you would approach development of a web form in the same way as you would something like Netflix. The latter would require significant planning, a larger team, and huge investment. The former you could knock out in an afternoon by yourself, and any planning beyond a couple of post-it notes would take longer than the actual task.

So what are the key differences between these types of application?

Development methodology
-----------------------

Let's keep this one short: there are pretty few situations where a waterfall (i.e. fully design and plan up-front) approach is effective in software. I've never seen it done, and don't really expect to. 

The real variation in how IT projects are typically run is in the extent to which a project is "agile" (whatever you believe that to mean). 

There's no holy grail here, despite what Scrum advocates may want you to believe, and I subscribe strongly to the [Extreme Programming][1] (XP) mantra of "fix it when it breaks", i.e. change your processes as necessary to fit *your* project and *your* team.

Of course, for a project composed of one team, this is relatively straightforward, you can change what you like. A large and complex project will involve many teams, and regardless of how you work, someone will have to line up deliverables and coordinate across team boundaries to avoid a catastrophic mess. Changing practises can be more challenging in these situations, and generally the more external constraints you have, the harder it is.

For a larger project, I would expect to have an over-arching plan with key milestones and an understanding of how all the different parts need to fit together (and when). That isn't the same thing as waterfall, more like a plan around how you're going to carry out your agile development and set appropriate priorities.

The amount of design and planning
---------------------------------

Smaller projects usually benefit from an MVP (minimum viable product) approach. Build something simple, that meets the absolute minimum level of functionality to be useful, release that, and see how it goes. Once you get feedback, you can iterate, improve and release again. Over time, you improve and add new features in a way that is always founded in feedback and analytic data.

This is a great way to work, as you don't have to invest a lot of time in research up-front and you can get to market quickly (i.e. exploit a new business idea before everyone else does). The downside, of course, is that you might miss something significant or perhaps you'll spend more time and effort rewriting things or changing features later on.

As you scale up project complexity, you also have to scale up the planning. Most projects I tend to work on are planned at the feature level, with the key stakeholders (lead developers, product owners, etc) having oversight to make sure everything gels together properly. A feature is designed with mock-up screens, a vague idea of the code changes required and a breakdown of tasks (with estimates). This then feeds into our sprint cycles.

I've been part of a few larger projects (where I or my team were involved in only a small part of the overall development) and the planning for those can be colossal. It's not so bad when you are starting afresh, but if you have to integrate with other systems, or keep legacy components working, you can multiply the planning effort by 10.

As mentioned above, the idea is usually to produce more of an over-arching, guiding plan than focus in on specific low-level detail, but sometimes that's necessary too.

Potential for defects
---------------------

Simply; the smaller the project, the fewer bugs you will have. It's relatively straightforward to write "bug free" (for any reasonable definition of "free") software in the context of academia, but try achieving that with a team of dozens or hundreds of developers, and millions of lines of code, split over dozens of individually deployable pieces of software.

And of course, you have to plan for this too. Software development is never "done", it's a continuous process. The more complex the software, the more you have to plan for failures and how to react to them. How many people can you commit to solving problems and supporting the live system? These are real considerations for any professional development work, but are not covered in academia.

Why university courses don't cover this
---------------------------------------

My course actually did get into the "[Systems Development Life Cycle][2]" (SDLC), but that's really only a small fraction of what you need to know. 

I suspect the reason that not much effort is spent on this at university is that the skills are practical rather than academic, and not easily taught or assessed. There's no real opportunity for you to plan out and build a huge application, and would be little value in doing so in the context of a university degree.

What should universities take away from this?
---------------------------------------------

I think teaching of the SDLC should essentially be cut down to a single lecture, with much more effort spent on discussing topics like those raised in this blog post (and others). 

Any opportunity to practise would be beneficial, for example, why not have students build a piece of software during weekly lab sessions, and each week give them feedback that they can use to iterate their work? Part of this could involve planning how a feature should look and act and documenting how things change over time.

Have students work on something individually for a few weeks, then scale up the complexity. Make them build things in teams that have to interact with components written by other teams.

While it's difficult to assess these practical skills, it would certainly help to give students some experience and practise.

What should students take away from this?
-----------------------------------------

Students should be aware that their exposure to different types of project is limited. While there might not be a lot of scope to change this, it's certainly possible to practise some of the useful things that you may be expected to do when planning out work in a more collaborative environment later in your career...

1. Do mockups of your designs - it'll help cement your ideas. Share them with others, get feedback.
2. Break down your work into smaller tasks - it's a useful skill to develop and you'll start to figure out what works best for you.
3. Think about your high level objectives and write a roadmap or "plan" that gets you there over time.

Any experience of these things will help you enormously when you transition from academia to working on a real software development team. If you can go through these steps for different sizes of task, it'll help you to understand in which situations you'll want to focus on planning vs. doing.

You can't really prepare for working in a large multi-team company like Netflix without actually just going there and doing it, but you can prepare yourself for some of the more realistic problems you'll face with smaller projects and teams, and it's a good place to start.

Next up!
-------- 
   
I'll be writing a retrospective look at my university course (not all of it, of course) and discussing whether it would be value for money at today's price.

[1]: http://www.extremeprogramming.org/rules/fixit.html
[2]: https://en.wikipedia.org/wiki/Systems_development_life_cycle