---
title: Context Highlight
subtext: "Right click and highlight all instances of the selected word within 
the page." 
description: "Firefox Addon-on that lets you right click and highlight all 
instances of the selected word within the page."  
shortname: contexthighlight
addonname: Context Highlight
addonid: context-highlight
githubrepo: benbasson/contexthighlight
---

Context Highlight is a Firefox Add-on that allows you to highlight all 
instances of a word that you have selected within the current web page. 

![Picture of Context Highlight appearing as an option in the context (right 
click) menu](/images/addons/contexthighlight.png) 

I primarily built this as a quick research tool, to help users find key words
within a web page quite rapidly. This goes beyond the standard Firefox
highlight functionality by allowing matching on both words and phrases, and
using different colours when multiple terms are highlighted.

How does it work?
-----------------

Select some text text on the current web page, right click and then choose 
"Highlight Word" from the context menu (right click menu):

![Picture of Context Highlight appearing as an option in the context (right 
click) menu when text is selected](/images/addons/contexthighlight-selectword.png)

The text will now be highlighted, like so:

![Picture of text highlighted within the web page as a result of Context
Highlight being used](/images/addons/contexthighlight-wordhighlighted.png)
 
If you select several words, you can choose from the following options:

* Highlight Words - This will simply highlight all of the individual words,
  each in a different colour
* Highlight Phrase - This will highlight the whole selection (all the words
  will be treated as a single pattern which will be highlighted on the page).

To clear highlighting, simply right click anywhere on the page and choose
"Clear Highlighting".

Top tip
-------

Hold down `Ctrl` when highlighting selected words or phrases to preserve any
current highlighting; i.e. the current highlights will not be cleared.
