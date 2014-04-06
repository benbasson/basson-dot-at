---
author: Ben Basson
title: Building basson.at
subtext: Ruby, Sinatra, Heroku and importantly, no PHP.
date: 2014-06-08T20:45:01
shortname: building-basson-dot-at
summary: I thought a great way to properly start off this blog would be to talk a little bit about how I wrote this website and why I did some of the things I did.
---

I thought a great way to properly start off this blog would be to talk a little bit about how I wrote this website and why I did some of the things I did. 

The background
--------------

My previous website (now decommissioned) was written almost entirely in PHP. Like just about everyone else who voluntarily uses PHP, I chose it because it was easy and I already knew some syntax.

What's the problem with that? Nothing, apart from PHP basically sucks in a *lot* of ways. Alex Monroe has written about this in excruciating detail in his article [PHP: a fractal of bad design][1], which is worth a read (but you'll need to set aside a bit of time as it is *verbose*).

My favourite thing from his article:

~~~ php
$arg = 'T';
$vehicle = ( ( $arg == 'B' ) ? 'bus' :
             ( $arg == 'A' ) ? 'airplane' :
             ( $arg == 'T' ) ? 'train' :
             ( $arg == 'C' ) ? 'car' :
             ( $arg == 'H' ) ? 'horse' :
             'feet' );
echo $vehicle;
~~~

The ternary operator in PHP is *left* associative, so the outcome from this is "horse". Yep. No other language does this.

The goals
---------

I had a few simple goals starting out.

1. Minimise the amount of code required in relation to the content. I want to spend time writing content, not maintaining the infrastructure around it.
2. Go outside of my comfort zone.
3. Make it easy to keep information about my Firefox Add-ons up to date.

The stack
---------

I get my fill of Java, Oracle, XML and others at work, and PHP is off the cards *forever* as far as I'm concerned. The choice beyond that was a bit of a no-brainer for me. 

I've been faffing about with Ruby and [Sinatra][3] for a few months now and I know enough to get by and figured that it would be a good fit for this project. 

If you haven't seen it before, Sinatra makes building a website *ridiculously* simple:

~~~ ruby
require 'sinatra'

get '/hi' do
  haml :index
end
~~~

Yes, that's all it takes to map "/hi" to a template.

Sinatra supports a ton of templating options, and of those available my preference is [HAML][4]. It's a lovely alternative to HTML and ERB and handles nesting through indentation instead of closing tags.

~~~ haml
!!!
%html
  %head
    %title Hello, world!
  %body
    .container
      %h1 Hello!
      %p My first HAML template!
~~~

This is too easy.

Although HAML is great for templating, it's not wonderful for content. Specifically, if you want to do things like put a link inside a sentence, you end up with stuff like this:

~~~ haml
%p
  This is a sentence with a 
  %a{href: 'http://www.google.com'} hyperlink
  .
~~~

This manifests horribly as you end up with whitespace at the end of the sentence, between the link and the full stop (*period* if you're American). There are various verbose workarounds, but they're all kinda ugly:

~~~ haml
%p
  = succeed "." do  
    This is a sentence with a 
    %a{href: 'http://www.google.com'} hyperlink
~~~

So, I decided to use [Markdown][5] for almost all the content, turning the above exercise into this:

~~~ markdown
This is a sentence with a [hyperlink](http://www.google.com).
~~~

Luckily, I can still render this from within my HAML templates, which makes for a lovely clean separation of concerns without a database in sight.

Why don't I want to use a database? Well, I get enough of that in my day job, plus it's a bit excessive for my needs. After all, the only dynamic bit a blog really needs is comments, and [Disqus][6] has solved that problem forever.

External APIs
-------------

No website would be complete without the dangers of consuming third-party APIs over HTTP to potentially bring the whole thing crashing down. I wanted to have live information about my Firefox Add-ons featured on the website, so I consume data from the GitHub API and Mozilla Add-ons API to then render in-line with my own content.

To protect against potential downtime of those and for obvious performance reasons I'm caching this data in memory. 

The hosting
-----------

[Heroku][7]. It's free for anything that doesn't need a lot of horsepower, I can't stress enough how easy it is to get up and running:

1. Build your website.
2. Create a couple of config files so Heroku knows how to launch your code.
3. Push to Heroku via Git.

There's something very satisfying about Heroku acting as as Git repository and simply pushing changes to it for deployment. 

Also, they have a cool slider that you can use to ramp up resources for your site. Literally, a slider on a web page that adds CPUs and RAM as you drag it. It doesn't sound very impressive in the modern cloud age, but I can still remember using MS-DOS on a [386][8] and this is essentially magic by comparison.

Why roll your own blog / website?
---------------------------------

Call me old fashioned if you didn't already, but it seems a bit *too* lazy for a competent programmer to use a framework or site generator for something so fundamentally simple as their own homepage. 

There were probably a hundred ways I could have done this easier, faster or cleaner, but I wanted to mess about, try some things out and see how little code I could write while still integrating all my [Firefox Add-on][9] content, RSS and so on. As it turns out, [very little indeed][10].

Isn't this harder than using a blog engine?
-------------------------------------------

Not really.

I have no need for a [WYSIWYG][11] editor - I'm writing all my content in Markdown using a lovely editor for Windows called [MarkdownPad][12]. 

To stage and test new content, I can just add it to the local, development version of my website and view it in my browser.

To publish, I just have to push a Git commit to Heroku. Helpfully, Heroku restarts the application whenever it receives new commits, at which point my initialisation code kicks in, parsing and caching the content.

Yes, that means potentially seconds of downtime whenever I publish something, but unless my blog becomes popular I can live with it. 

The results
-----------

I'm pretty happy with how it turned out and can tick off the key objectives. I'm not a designer, but it looks clean and has all the functionality I want. 

The code remains a work in progress and I'm more than happy for people to send me suggestions or pull requests if they can find nice ways to reduce the code footprint further.

Over the coming weeks I'll write about some of the specific development hurdles and interesting things I found along the way.

[1]: http://me.veekun.com/blog/2012/04/09/php-a-fractal-of-bad-design/
[2]: http://en.wikipedia.org/wiki/Domain_parking 
[3]: http://www.sinatrarb.com/
[4]: http://haml.info/
[5]: http://daringfireball.net/projects/markdown/
[6]: http://disqus.com
[7]: http://heroku.com
[8]: http://en.wikipedia.org/wiki/Intel_80386
[9]: http://www.basson.at/firefox-addons
[10]: https://github.com/benbasson/basson-dot-at/
[11]: http://en.wikipedia.org/wiki/WYSIWYG
[12]: http://markdownpad.com/