---
title: Projects
subtext: Experiments, hobby projects and other stuff I've made available.
---

Like most professional programmers, I get the itch to try out languages that I
don't use day-to-day, decide to launch ambitious hobby projects and generally
faff about on the weekends.

Here are some of the things I've done recently that are interesting but
probably don't deserve their own page.

iSomething
----------

[http://www.isomething.co.uk][1] ([On GitHub][2])

This is a quickly hacked together replacement for [iGoogle][3], or at least how
I had configured it.

I say quick, it took me about an hour to do most of it, and then loads of time
trying to write something resembling a stable API for consuming the Met Office 
UK dataset. 

There are some gems (and I did use one), but it seemed to confer no real
benefits apart from parsing the JSON. This is great except:

* I can easily construct a URL, so I could have just done it myself.
* I still had to write my own error handling for when the API fails or 
  arbitarily decides to omit parts of its structure (due to a bug, but 
  it still happened).
  
Some of the code is a bit ugly, but this was one of my earlier forays into 
using Ruby and Sinatra and it basically works fine.

This website
------------

Please see the [about][4] section.

[1]: http://www.isomething.co.uk
[2]: http://github.com/benbasson/isomething
[3]: http://en.wikipedia.org/wiki/IGoogle
[4]: /about
