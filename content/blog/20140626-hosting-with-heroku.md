---
author: Ben Basson
authorurl: http://plus.google.com/107880308657806834664
title: Hosting with Heroku
subtext: Some notes and tips from my experiences with Heroku hosting...
date: 2014-06-26T22:34:52 +1
shortname: hosting-with-heroku
description: There are plenty of quick start / getting started guides out there, but while setting up both this website and iSomething, I hit a few issues and noted down some things that could be improved. I wanted to share these thoughts as they may be useful for anyone thinking about using Heroku for hosting.
summary: There are plenty of quick start / getting started guides out there, but while setting up both this website and iSomething, I hit a few issues and noted down some things that could be improved. I wanted to share these thoughts as they may be useful for anyone thinking about using Heroku for hosting.
---

One of the attractive things about working with Platform as a Service (PaaS) providers is that you really don't have to think about much before you're up and running. You get an application server, web server, usually database provisioning, storage, memory, CPU, networking and all the rest without really doing anything. This leaves you to focus on your application and is very well suited to rapid prototyping.

[Heroku][1] provides a PaaS service for applications written in Ruby, Java, Node.js, Scala, Clojure, Python and PHP, which means that if you're using pretty much *any* mainstream web framework, your hosting needs are covered.

There are plenty of quick start / getting started guides out there, including the [excellent documentation on Heroku's own page][2], but while setting up this website, and my little experimentation [iSomething][3], I hit a few issues and noted down some things that could be improved. I wanted to share these thoughts as they may be useful for anyone thinking about using Heroku for hosting.

Getting up and running (Ruby)
-----------------------------

It's almost ridiculous how easy it is to take an application you've been developing locally and make it run on Heroku. These steps are for a Ruby application, but it's similar for all supported languages and frameworks.

If you're building using [Sinatra][4] (as I have) or [Ruby on Rails][5], then there are loads of existing guides out there to help you, but the key steps are as follows:

* Sign up to Heroku.
* Write a [config.ru][6] file to tell Heroku how to start your application.
* Initialise a Git repository for your application source code (if you hadn't done so already).
* Use the [Heroku Toolbelt][7] to create a Heroku application (which should also register itself as a Git remote).
* Push your code to the Git remote that Heroku registered.

The commands for all of those steps look something like the following:

~~~ bash
git init
git add .
git commit -m "Initial commit."
heroku create yourappname
git push heroku master
~~~

That's it. Your application will build and run. Except, unless you've achieved perfect source control, your dependencies are in order and you've remembered to configure all the environment variables, it probably won't, at least not first time.

Read the instructions
---------------------

Despite how easy Heroku makes things, and how easy I make this all sound (which it is), you should still read the basic instructions provided. Being a typical developer, I decided to just have a go without bothering to [RTFM][8].

Sinatra is a [Rack][9]-based framework, and Heroku requires a Rackup config file (config.ru) to tell it how to start. It can be as simple as this: 

~~~ ruby
require './index'
run Sinatra::Application
~~~

When writing iSomething, I hadn't created this file - I didn't need it for running locally, because I was just invoking the Ruby file directly in my IDE. Once I'd put this in place and pushed the commit to Heroku, my application started straight away.

Get access to the logs
----------------------

The first thing you'll want to do when debugging most problems is look at the logs. Heroku provides a basic command-line tool for this, `heroku logs`, which works very much like the Linux `tail` command, in that you can request a specific number of lines (`--num`) or follow the output as a live stream (`--tail`). 

This is fine for simple diagnostics, but as with pretty much all command-line tools, it's a clunky approach and there are better ways to visualise the data.

[Logentries][10] is a pretty neat web application, available for free as a Heroku add-on, which handily doesn't require any up-front configuration. It'll let you watch the live stream of logs, but more usefully, it'll help you search through logs, tag lines using regular expressions, set up alerts and more.

Sync the stdout and stderr streams
----------------------------------

When working on iSomething, I wrote a simple memory-based Time To Live cache. This allows me to cache RSS data for an amount of time before fetching it again, saving on CPU cycles and bandwidth while making the site more responsive.

I had a few issues, so I decided to write some simple logging with `puts` (and yes, I'm aware that writing to stdout is not *proper* logging, but it's good enough for this project). Unfortunately, when viewing my logs in Logentries, the debug messages were nowhere to be seen.

Yet again, this came down to my failure to RTFM. Unlike my IDE, Heroku buffers the `stdout` and `stderr` streams, and you have to request that those streams are flushed if you want to be able to read from them immediately, as I did. This involved a simple edit to my config.ru file, which now looks like this:

~~~ ruby
require './index'
run Sinatra::Application
$stdout.sync = true
$stderr.sync = true
~~~

Now my warnings and update notifications are being streamed in a timely fashion and I can keep an eye on things.

NB: This is a totally rubbish way to cache, especially as Ruby and Heroku offer tons of proper caching options, but I didn't need anything sophisticated, and it's always nice to play around and roll your own solution when nothing really hinges on it being good.

Make sure your dependencies are installed
-----------------------------------------

[Bundler][11] is basically a standard dependency management tool, helping you to deploy your code consistently and in a sane way.

Without a serious amount of experience using any others, I can't say if it's better or worse than any other offering, but it's incredibly easy to understand and start using, and works pretty well. You simply create a Gemfile and list the gems you want to have (optionally specifying versions) like so:

~~~ ruby
gem 'thin'
gem 'sinatra'
gem 'sinatra-contrib'
gem 'actionpack', '4.0.4'
~~~

If you've installed any gems manually (i.e. not with Bundler) then make sure you remember to add them to the Gemfile.

To check that all the required gems are installed (and install any that are missing), just run the following command:

~~~ bash
bundle install 
~~~

Bundler will look at each gem listed, including dependencies, and sort out the whole mess for you. Then it will install all of the gems required and create a file called Gemfile.lock which freezes the versions of gems that you're using. If you run the install again, it will attempt to reuse the versions you had before to maintain stability.

You can do a lot of neat things with Bundler, like specify that a specific Github repository should be used (i.e. if you fork a gem), or that a local copy you're editing should be used instead for development purposes. I'll talk about those in another post because there are some dependencies on your IDE not being crap before that works.

When you push commits to Heroku, it will shut down your application, clean up, and then run `bundle install` prior to starting your application again. This should mean that you'll always have a clean install of your application.

Use a staging area
------------------

For iSomething, I'm using a gem called [Feedjira][12] to take care of my RSS parsing needs. It's a great gem, which at the time I started development was called Feedzirra.

When I pushed my code to Heroku, Bundler dutifully went off to grab all the gems I needed; unfortunately Feedzirra no longer existed (and for presumably a good reason) had seemingly been purged from the Internet. As Bundler was unable to find the gem, my application instance was broken until I could quickly rewrite the Gemfile and code to use the new name. 

As this was for a hobby project - of which I'm probably the only user - it wasn't really an issue, but it does make a strong case for having a release staging area (as if there weren't enough compelling reasons already).

Heroku recommends that you [set up a staging area a second Heroku application][13] and simply push changes to that application first. This is easy to do, as you can simply add the second application as an additional remote in your Git repository.

There are some drawbacks to their approach, namely that you have to keep Heroku add-ons, contributors and environment variables synchronised between the two applications manually.

It seems to me like they missed a trick by not building staging in by default... It would certainly make it a lot easier if multiple Git branches were supported (mapping to different subdomains) within a Heroku application, avoiding the configuration overhead. 

Set up your domain name
-----------------------

Heroku apps run on the subdomain *.herokuapps.com, which is fine for testing, but doesn't look particularly professional. Once your application is up and running, you'll probably want to set it up on a custom domain name. This is a two part process:

1. Set up Heroku to accept requests for your domain (just log into your Heroku dashboard and add the domain in the Settings page).
2. Point your domain to your app on Heroku (using the yourapp.herokuapps.com address).

Heroku uses dynamic IPs, so you won't be able to set up a [DNS A Record][14] and therefore have to use [CNAME Records][15]. CNAMEs come with the unfortunate drawback that you can't set up the root (apex) of your domain, i.e. you can set up "www.basson.at", but not "basson.at".

Some domain registrars offer the [ALIAS][16] record type, either explicitly or as part of their CNAME configuration interface, but many do not. If this is the case, you'll have to set up a permanent redirect ([HTTP 301][17]) from the domain root to the "www" subdomain. This is pretty straightforward and offered almost universally by domain registrars. 

Unfortunately, my domain registrar for basson.at (EuroDNS) doesn't provide any of the nice options, so I'm currently stuck with the permanent redirect. It'll do for now.

Scaling up
----------

Heroku makes it very easy to scale your application if it becomes popular. The dashboard for each app literally provides a slider, which starts at 1 "[dyno][18]" (which is basically a limited-scope virtual machine that contains an instance of your application) and allows you to scale up to 100. 

Dynos come in various flavours, but the cheapest variant gives you 512MB of RAM and a single share of a CPU. A single standard dyno of this type is free, and as you drag the slider, the monthly cost estimate is increased.  At the time of writing, 2 standard dynos will cost $34.50 per month and 100 will set you back $3,562.50 per month. You can find out more about the pricing structure on [Heroku's pricing page][19].

If you value convenience, then this is likely an attractive option, but it would be significantly cheaper to set up your own infrastructure (using [Amazon EC2][20] or similar), and you could use something like [Chef][21] or [Puppet][22] to take the effort out of it in the long run. This would require a more up-front investment in time, but you'd only have to do it once and the cost savings could be well worth it.

Stop Heroku idling
------------------

If you only have a single dyno (i.e. you're using Heroku for free) and don't get many visitors, you'll find that your dyno will shut down after an hour of inactivity. To work around this, you can either move onto one of the paid plans, or find some way of keeping your application active.

Handily, Heroku offers a [New Relic][23] add-on and one of its features is availability monitoring. You can give it a URL to check and a string that must be in the response to indicate a successful request. I set up a specific Sinatra handler for this (to avoid the overhead of invoking templates):

~~~ ruby
get '/service-status/?' do
  "Up and running: #{Time.now.to_formatted_s :db}" 
end
~~~ 

This is exposed as [http://www.basson.at/service-status/][24] and I instruct New Relic to inspect the response for the string "Up and running". 

According to the New Relic documentation, they'll run the availability check every 20 seconds, which should ensure your dyno never idles.

Development vs. production gems
------------------------------

I can't remember if you need to install the New Relic ruby gem for the availability monitoring feature to work, but you certainly need it for any of the other statistics and features of New Relic. You'll probably only want to install the gem in your production instance, which you do easily enough with Bundler groups:

~~~ ruby
group :production do
  gem 'newrelic_rpm'
end
~~~

This will ensure that the New Relic gem is only installed when `bundle install` is run and the environment variable `RACK_ENV` is set to `production`. As the gem isn't installed locally, I needed to bypass requiring the gem for my local development purposes. This is really simple in Sinatra:

~~~ ruby
configure :production do
  require 'newrelic_rpm'
end
~~~

Would I recommend Heroku?
-------------------------

Despite a few little hitches (which were all my own fault) and some issues around application staging and DNS, it's easy to get up and running on Heroku and if you're using pretty much any web framework for a hobby project, it's probably your best bet.

It seems a bit on the pricey side if you start scaling up and using more resources and I suspect you'd hit diminishing returns quickly in terms of value for money. That said, the free offering is great and provides amazing no-fuss hosting. The issues I encountered along the way were pretty minor and hopefully my documenting them in this blog post will be useful to someone out there.

Overall, I'm a huge fan and I'll continue to use Heroku for the foreseeable future. 

[1]: https://www.heroku.com/home
[2]: https://devcenter.heroku.com/articles/quickstart
[3]: http://www.isomething.co.uk
[4]: http://www.sinatrarb.com/
[5]: http://rubyonrails.org/
[6]: https://devcenter.heroku.com/articles/rack#frameworks
[7]: https://toolbelt.heroku.com/
[8]: http://en.wikipedia.org/wiki/RTFM
[9]: http://rack.github.io/
[10]: https://logentries.com/
[11]: http://bundler.io/
[12]: http://feedjira.com/
[13]: https://devcenter.heroku.com/articles/multiple-environments
[14]: http://support.dnsimple.com/articles/a-record/
[15]: http://support.dnsimple.com/articles/cname-record/
[16]: http://support.dnsimple.com/articles/alias-record/
[17]: http://en.wikipedia.org/wiki/HTTP_301
[18]: https://devcenter.heroku.com/articles/dynos
[19]: https://www.heroku.com/pricing
[20]: http://aws.amazon.com/ec2/
[21]: http://www.getchef.com/chef/
[22]: http://puppetlabs.com/
[23]: http://newrelic.com/
[24]: http://www.basson.at/service-status/