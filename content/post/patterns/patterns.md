---
title: "What is the deal with software patterns?"
date: 2018-10-12T20:33:13-07:00
slug: patterns
description: "A Pattern Language, the Gang of Four, and Python"
---

If you're someone who has always programmed in a very high level language such
as Python, you may have wondered: "What is the deal with the
Gang of Four software patterns book anyway?!"

The GOF idea of a pattern is inspired by a wonderful planning and architecture
book called [_A Pattern
Language_](https://en.wikipedia.org/wiki/Pattern_language). It's a gem!
It's in your local library!

Here's a [representative
example](http://www.iwritewordsgood.com/apl/patterns/apl167.htm) (and some good
advice):

>  Whenever you build a balcony, a porch, a gallery, or a terrace always make
>  it at least six feet deep. If possible, recess at least a part of it into
>  the building so that it is not cantilevered out and separated from the
>  building by a simple line, and enclose it partially. 

This instruction is preceded by a couple of hundred words of justification,
including:

> Balconies and porches which are less than six feet deep are hardly ever used. 

![](/post/patterns/balcony.gif)

There are 253 of these patterns. They're practical, concrete advice. They're
generic, but they're not abstract.

The GOF patterns are very different in character. They manage to pull off the
trick of being both very abstract and very low level. As a result, the book has
had relatively little practical impact on day-to-day software engineering,
despite its high profile.

Don't take my word for this. [This fantastic Brian Marick
talk](https://www.deconstructconf.com/2017/brian-marick-patterns-failed-why-should-we-care)
does a great job of explaining why _Pattern Language_ works and the GOF book
didn't.

In hindsight then, the GOF book didn't really work. But while its low level and
abstract patterns are not useful to most of us (because they're low level and
abstract!), they great things for language designers to bear in mind.

Python's designers and those of many other modern languages did exactly that,
and made these patterns part of the syntax, as explained so well in
[Brandon Rhode's guide to the GOF patterns and their applicability to
Python](http://python-patterns.guide). (Brandon's site is also a great place to
start if you are unclear on what a design pattern even is.)

So, the moral of the story is: the GOF patterns are not something most of us
need to worry about when we create applications because

 1. they are not actually that useful for application development in any
    language, and
 2. if you're using a modern language, they are probably built in to syntax of
    (or made redundant by the design of) the dang language anyway

But despite that you should watch [Brian's
talk](https://www.deconstructconf.com/2017/brian-marick-patterns-failed-why-should-we-care)
and check out [Brandon's patterns site](http://python-patterns.guide).

