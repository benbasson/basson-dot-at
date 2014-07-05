---
author: Ben Basson
authorurl: http://plus.google.com/107880308657806834664
title: Installing Curb on Windows
subtext: A fiddly experience with native gem extensions 
date: 2014-07-05T16:32:47 +1
shortname: installing-curb-on-windows
description: A guide to installing the curb Ruby gem on Windows.
summary: As a developer using Windows, I sometimes encounter obstacles due to my operating system choice. In this blog post, I detail how to install the curb gem on Windows which comes with a native (binary) extension.
---

I'm a developer that likes using Windows and I prefer it for day to day programming (and everything else for that matter). That said, even the most militant Linux or Mac fan will probably agree with me that the operating system doesn't really make a lot of difference once you've got an IDE open. 

One problem I have faced as a result of my choice of operating system is installing Ruby gems that have native extensions. Why am I mentioning this in a Windows-specific context? Well, there's plenty of well written blog posts / guides out there for troubleshooting problems with this process on Linux / Mac, but for the most part it *just works* (as it should). On Windows, it's a bit more of a faff and a lot of guidance out there seems to gloss over the detail. While annoying, it is *relatively* simple.

What are native extensions?
---------------------------

Native extensions are essentially bits of C code that are bundled inside a Ruby gem. There are various reasons to include them, but the main two reasons are:

1. Performance - getting out of the Ruby stack and accessing memory directly / using more highly optimised code can give *huge* speed benefits for intensive processing tasks.
2. To leverage existing C libraries, such as [libcurl][1] which are stable, mature products that don't need to be reinvented.

Without getting into huge amounts of detail, installing a gem with native extensions may require that you compile the C code for your platform; in my case Windows. If you're lucky, a compatible binary will already be provided with the gem, but in many cases it won't be.

What is Curb?
-------------

This post specifically looks at installing [Curb][2], but I'm sure it could prove useful for other gems. 

Curb is essentially a Ruby wrapper for [curl][3], a command-line tool for retrieving or sending data over just about any web protocol. Generally speaking, curl is handy, especially when setting up and testing infrastructure or writing simple system administration jobs. It lets you retrieve remote data as easily as this:

~~~ bash
curl -s 'http://www.basson.at/service-status' | grep -i 'Up'
~~~

My reason for using Curb is that it's a dependency of [FeedJira][4], which I used for RSS parsing in [iSomething][5].

Curb installation overview
--------------------------

Thankfully, the gem installation process will do most of the hard work, but you need to give it some additional information and satisfy all the dependencies up-front. For curb means the following is required:

* Ruby (presumably you've already got this far...)
* The C source code (included with the gem)
* A Windows C compiler (included via the MinGW distribution in the [Ruby DevKit][6])
* The Windows version of [libcurl][5] (you'll need the MinGW variant)
* Some patience

I'm normally lacking in the latter when it comes to this kind of non-programming task - if you are too, take a deep breath and keep reading - it's not that bad.

The Ruby DevKit
---------------

Most Windows-based developers using Java / .NET platforms will probably be used to simple installations of build tools (for Java, just download the JDK and run the installer). Getting the standard Linux / Mac build tools (`gcc`, `make`, etc) running on Windows is slightly tricker if you do it all yourself.

Luckily, the [Ruby DevKit][6] exists to give you everything that the gem / bundler install process needs to compile native extensions without you having to really worry about any of it. All you need to do is grab it from the Ruby website and extract it to `C:\rubydevkit-x86` (for example). Then run the following commands to set it up:

~~~ bash
cd \rubydevkit-x86
ruby dk.rb init
ruby dk.rb install
~~~

There's a guide covering all of this in more detail on the [RubyInstaller DevKit wiki page][7], but the above should work just fine.

It's worth noting that there's a 64-bit and a 32-bit version of the DevKit. I used the 32-bit version.

Install libcurl
---------------

As I used the 32-bit DevKit, I also needed the 32-bit version of libcurl. 

Curiously, the MinGW32 version isn't listed on the [libcurl download page][8], but if you poke around and use some intelligent URL guesswork, you'll find it listed here: [http://curl.haxx.se/gknw.net/7.34.0/dist-w32/][9] (7.34 is the current version at the time of writing, you may want to look for a newer release).

Simply extract the archive you download; I installed libcurl at `C:\libcurl-7.34.0`

Don't forget to add the libcurl `bin` directory to your Windows `PATH`. I generally do this using the GUI because it's easier than any of the seeming *dozen* different ways to do it via the command-line. Remember if you do this that you'll need to open a new `cmd` or PowerShell window before the change will take effect.

Various Stack Overflow posts and other guides say that you need to use forward slashes on the `PATH` entry, i.e.

~~~ bash
C:/libcurl-7.34.0/bin
~~~

instead of 

~~~ bash
C:\libcurl-7.34.0\bin
~~~

I didn't need to do this, but if you have issues it might be worth a shot.

Finally, install the gem
------------------------

Unfortunately, a simple `gem install curb` isn't going to cut it. Fortunately, here's the command for you to copy and paste (remember to substitute folders as necessary):

~~~ bash
gem install curb -- -- --with-curl-lib=C:\libcurl-7.34.0\bin --with-curl-include=C:\libcurl-7.34.0\include
~~~

As before, you may need to use forward slashes instead of back slashes, but I didn't find that this was the case.

A note on the install command syntax
------------------------------------

A *lot* of guides / Stack Overflow answers out there state a similar, but subtly different command. I could only make this work with two sets of double-dashes; i.e.

~~~ bash
gem install curb -- -- --with-curl-lib [etc...]
~~~

The widely reported variant is as follows:

~~~ bash
gem install curb -- --with-curl-lib [etc...]
~~~ 

This fails every time for me, with the following (unhelpful) error message:

~~~ bash
ERROR:  While executing gem ... (OptionParser::InvalidOption)
    invalid option: --with-curl-lib=C:\libcurl-7.34.0\bin
~~~

I'm not really sure why I (and reportedly some others) have this problem, while others do not. If anyone knows, please share the answer in the comments and I'll update this post. 

That wasn't so bad, was it?
---------------------------

Ok, admittedly it's a bit of a pain, but with the right tools and a bit of guidance it all works fine. My main sticking point was the double-dash issue which I have yet to explain. 

I'm sure I'm not the only Windows-based developer trying to use Ruby gems with native extensions;  hopefully anyone searching for the error message above will find this blog post useful. If you have, please let me know!

[1]: http://curl.haxx.se/libcurl/
[2]: https://rubygems.org/gems/curb
[3]: http://curl.haxx.se/
[4]: http://feedjira.com/
[5]: http://www.isomething.co.uk/
[6]: http://rubyinstaller.org/add-ons/devkit/
[7]: http://wiki.github.com/oneclick/rubyinstaller/development-kit
[8]: http://curl.haxx.se/download.html
[9]: http://curl.haxx.se/gknw.net/7.34.0/dist-w32/
