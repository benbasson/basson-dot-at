---
author: Ben Basson
authorurl: http://plus.google.com/107880308657806834664
title: Writing code for the long term
subtext: You might be surprised how long it sticks around.
date: 2016-06-12T22:34:16 +1
shortname: writing-code-for-the-long-term
description: One of the common problems encountered by students or fresh graduates when they begin working on real software projects is that, though they have excellent knowledge of computing theory, they are missing many of the skills required to write good code. This post suggests how universities could improve coursework to teach those key skills.
summary: One of the common problems encountered by students or fresh graduates when they begin working on real software projects is that, though they have excellent knowledge of computing theory, they are missing many of the skills required to write good code. This post suggests how universities could improve coursework to teach those key skills.
---

This is the first part of my blog mini-series of [things university doesn't teach you about software development][1]. Today we'll cover coursework and why the short-term approach teaches you nothing about working with software in the real world (apart from perhaps prototyping). 

What is coursework?
-------------------

A strong component of most university courses is coursework, and on computing courses this typically means writing a piece of software. This could make up anything between 10% and 100% of the overall grade for each module of a course, so it's important. In my experience, very few modules were solely exam-based, those that were related to the more periphery parts of my course such as marketing or pure mathematics. 

In many respects, this approach is ideal as it gives you practical time to work on code and understand the problem you're solving in a way that exams never could.

What's wrong with coursework?
-----------------------------

I look back on coursework I did as equivalent to the output of an extended [hack day][2] or prototyping exercise - no tests, no documentation, no comments, possibly no source control, and certainly have no user guidance. This is certainly the typical state of almost every piece of coursework handed in. 

Work may receive a cursory glance by a tutor or PHD student, receive a grade and then be consigned to the deepest depths of your hard drive, never to be looked at, thought about or touched again.

This is about as far from working as a professional developer as it could possibly get, and that's a huge missed opportunity given that it would be really easy to teach some key skills at the same time as providing a mechanism for assessment. 

Your code is the new legacy code
--------------------------------

When you develop software, you're creating a legacy. You're working on something that will evolve, change, and be worked on by others - mostly without talking to you about your contribution.

There is a lot of skill in being able to explain your work through structure, comments, documentation and [good commit messages][3] and these are consistently the biggest issues that I see newly hired students and graduates struggle with because they've often never had to think about them before.

Some of those are team working / tooling issues, but designing and writing code that's easier to pick up and modify later is something you can do even by yourself.

You'll almost always work on existing code
------------------------------------------

As a professional software developer, you'll sometimes get the chance to write a completely new piece of code, with no legacy baggage, and it's a wonderful thing. Most often though, you'll be working on adding new features to something that already exists.

Most coursework completely glosses over this and robs you of some useful skills. Namely, the ability to read and understand code written by someone else, which frankly apart from *naming things* is one of the [hardest problems you'll ever have][4].

How to improve coursework
-------------------------

If I were setting coursework to students, I would make the following key improvements:

1. Set expected formatting standards - preferred naming, indenting and style conventions. I'd do this because any sane company will require developers to adhere to their conventions, and because a known convention makes code a lot easier to read.
2. Set out the requirements as things that are testable and require the students to write automated tests that pass if they've done the work properly, or at least, to write out the manual process for testing the software written. This introduces students to [TDD][5] and helps them self-assess their work. It also makes work quicker to grade.
3. Require at least [JavaDoc][6]-style comments or the equivalent for whichever language is in use.
4. Where possible, include some element of modifying existing code, i.e. have a half-written piece of software, or one with some bugs that need fixing.

These all seem trivial, but would bring coursework much more in-line with real work and require minimal effort on the part of both the tutor and student. They also all help massively towards the creation of maintainable and understandable code.

Set the coursework earlier
--------------------------

Something that never made sense to me was that coursework topics would be this huge secret until mid-way through a 15 week semester. As someone writing actual code, you would never get more than 2 months into a project in the real world without some notion of what your deliverables are.

The charitable part of me assumes the idea is to maintain focus on a wide-range of lecture material, rather than allowing students to focus on the narrower topics covered in the coursework and ignore the rest. However, this is an utterly deluded approach. 

The coursework should cover as much of the course as possible. People learn by doing. Establish the requirements for the coursework on day 1 of the course, and make use of it to help teach the course material. You could have a deliverable for each week, or slowly build up a larger deliverable over the semester.

This also encourages code to be more maintainable and gets students used to incrementally building on top of code that they've already written.

What universities should take away from this
--------------------------------------------

Make coursework a delivery vehicle for skills rather than just a way of grading students. By allocating a small proportion of the overall marking scheme to things like code standards and test coverage, you're making students think about these important issues with almost no extra invested effort. 

The improvements listed above will help students grow their software development skills and will make their work faster and easier to grade. It's a win-win. 

What students and graduates should take away from this
------------------------------------------------------

These (and more!) are the standards that any competent software company will expect of you, try holding yourself to a higher standard than your university tutors and peers. It'll require more of an investment, but it'll pay off big time in terms of getting you used to best-practise. As a nice bonus your code will look *much* better if any prospective employers want to see it in an interview setting. That's something I *always* ask for, and I'm sure others do as well.

Think about writing code as if it'll exist for the long term. That's the reality of the vast majority of software development jobs. 

Next up
-------

Next week I'll be writing about teamwork and why university group projects are an inadequate way to prepare students for working in a team environment. 

[1]: /blog/things-uni-doesnt-teach-you-about-software-dev
[2]: http://en.wikipedia.org/wiki/Hackathon
[3]: http://chris.beams.io/posts/git-commit/
[4]: /blog/softwarearchaeology
[5]: https://en.wikipedia.org/wiki/Test-driven_development
[6]: https://en.wikipedia.org/wiki/Javadoc