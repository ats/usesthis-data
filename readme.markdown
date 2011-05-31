The Setup by the Numbers
========================

I recently found myself browsing interviews at [The Setup](http://usesthis.com/), where various nerdy and creative types describe the tools they use to do their work, and my curiosity sparked at this brief statement on the about page: "Despite appearances, the site is not actually sponsored by Apple - people just seem to like using their tools. We're a fan, too."

Wouldn't it be interesting, I wondered, to know just how many of the interviewees were Apple users? And what they used? And, for that matter, how many were into Android, or Lightroom versus Aperture, or emacs or obscure outlining applications that absolutely nobody else uses?

[The code for The Setup is on github](https://github.com/waferbaby/usesthis.git), and it includes the text of all the posts! The interviews are in markdown format, and the processor generates links for product names by referencing an index of hardware and software. This is the key for someone like me who wants to make data, because it provides a (mostly) standardized catalog of gear, no content coding required. It also means that the interview text can be descriptive while also referring to the standardized name for that bit of equipment, as in [15" MacBook Pro][macbook-pro].

The ruby code that builds The Setup from those files even helpfully includes a ready-to-go regular expression that finds those hardware and software references. So with a few of my own inelegant but functional passes using grep, perl and awk, I built a tab-delimited data set from which we can learn all sorts of things, such as:

* More of The Setup interviewees are into Lightroom than Aperture
* Apple machines really are popular (and so are iOS devices)
* Textmate still has a lot of adherents
* Canons are more popular than Nikons (though it's pretty close)
* Nobody yet interviewed has a Xoom or Galaxy tablet
* Very few iOS apps are named more than once (not even Angry Birds)

I've used R to put together an easy-to-update, full rundown of the numbers (see usesthis-summary.txt) that I thought were interesting and/or fun, but you can easily explore via awk, too. For example, the following finds and counts all unique iOS applications:

    awk ' {FS = "\t"} { if ($4 ~ /\-ios$/) print $4 }' thesetup-data.txt | sort | uniq | wc -l

There are a few limitations to the making of grand statements about this data: Of course each interview is a static snapshot, and we have no idea (without asking) if, say, [Marco Arment](http://marco.arment.usesthis.com/) has moved his work to a HP touchsmart, or [Kieran Healy](http://kieran.healy.usesthis.com/) has switched to SPSS and MS Word, or if all the reported 3G users are still using that model of the iPhone. [Idea: break down some of the numbers by year.] There are also the occasional instances in the interviews where someone says something like, "I can't imagine using _something_," and due to the context-dumb nature of this data, that becomes a count of that something in the index. Finally, the counts rely on some  skimming of the hardware/software catalogs and subsequent manual coding to identify models of gear that fit into various categories (Windows PCs and Android devices that come in all makes and models, for example). These will probably need periodic updating. 

The data, the code to build the dataset, and the R code to run some numbers are all available.

All of this is possible thanks to the cool coding behind The Setup (imagine the work required to build a catalog if the interviews were simply static, hand-built html), the careful curation of interviews to make use of the hardware and software catalog, and the [Attribution-ShareAlike](http://creativecommons.org/licenses/by-sa/2.5/au/deed.en) licensing of the original -- which licensing applies to this effort, as well. Thanks to Daniel Bogan and contributors to The Setup!


