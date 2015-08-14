---
title: Projects
subtext: Experiments, hobby projects and other stuff I've made available.
description: "A list of my side projects that don't deserve their own page, but are interesting enough to mention and/or link to."
---

Like most professional programmers, I get the itch to try out languages that I don't use day-to-day, decide to launch ambitious hobby projects that I'll probably never work on again, let alone finish, and generally faff about on the weekends.

Here are some of the things I've worked on that are interesting but probably don't deserve their own page.

iSomething
----------

Web page: [http://www.isomething.co.uk][1]
GitHub repository: [iSomething source][2]

This is a quickly hacked together replacement for [iGoogle][3], or at least how I had configured it.

I say quick, it took me about an hour to do most of it, and then loads of time trying to write something resembling a stable API for consuming the Met Office UK dataset. 

There are some gems (and I did use one), but it seemed to confer no real benefits apart from parsing the JSON. This is great except:

* I can easily construct a URL, so I could have just done it myself.
* I still had to write my own error handling for when the API fails or arbitarily decides to omit parts of its structure (due to a bug, but it still happened).
  
Some of the code is a bit ugly, but this was one of my earlier forays into using Ruby and Sinatra and it basically works fine.

The Sinatra One Time Password Service
-------------------------------------

GitHub repository: [sinatra-rotp][5]

As part of the [Fivium Hack Day 2015][6], I knocked up a little [REST][7] API that can be used to easily plug in a multi-factor authentication mechanism to any existing web application. For anyone not familiar with multi-factor authentication, it's essentially just having additional known secret(s) to log into a system, usually a password and one other mechanism, such as the code from a [security token][8] or [grid card][9], and so on. 

My idea was to create a simple [Time-based One Time Password][10] (TOTP) system, which when paired with the [Google Authenticator][11] mobile app would provide a free and simple authentication solution, with very few changes required to the consuming application.

To that end, my simple API helps callers to:

* Generate a secret (to be stored as part of the user account details)
* Create a scannable QR code for a known secret (i.e. to be scanned using Google Authenticator)
* Verify that particular code is valid (when presented with the code and the shared secret)

I quickly plugged this into one of our development systems at work as a proof of concept (the code for which hasn't been released, but you can use your imagination). The hack won me a t-shirt, which I'm more than happy with as a hack day outcome.

This website
------------

Please see the [about][4] section.

[1]: http://www.isomething.co.uk
[2]: http://github.com/benbasson/isomething
[3]: http://en.wikipedia.org/wiki/IGoogle
[4]: /about
[5]: https://github.com/benbasson/sinatra-rotp
[6]: http://www.fivium.co.uk/hackday/
[7]: https://en.wikipedia.org/wiki/Representational_state_transfer
[8]: https://en.wikipedia.org/wiki/RSA_SecurID
[9]: https://codetechnology.wordpress.com/2007/09/17/bingo-cards/
[10]: https://en.wikipedia.org/wiki/Time-based_One-time_Password_Algorithm
[11]: https://play.google.com/store/apps/details?id=com.google.android.apps.authenticator2&hl=en_GB