---
title: "Spaced repetition, Anki and Execute Program"
date: 2020-09-02T21:31:44-07:00
slug: executeprogram
thumbnail: post/executeprogram/executeprogram.png
description: "Learning and memorizing with Anki and Execute Program"
---

Here's the tl;dr

  - memorizing stuff is good
  - spaced repetition is a good way to memorize things
  - [Execute Program](https://www.executeprogram.com/) is a subscription
    learning site that uses spaced repetition
  - Execute Program has good lessons (especially on regular expressions and
    concurrency)
  - Ergo Execute Program is good
  - Also [Anki](https://ankiweb.net/) is good

QED.

## Memorizing stuff is useful

It seems almost self-evident to me that this [John Siracusa
quote](https://overcast.fm/+R7DUeyopY/2:03:38)
([via](https://twitter.com/garybernhardt/status/1287883217450614784)) is true:

> It's good to reach the level of competence where you can write [programs] from
> top to bottom and never have to look anything up.

There are two steps to reaching this enlightened state. The first is learning
the facts in the first place. The second is _remembering_ them. That second step
is crucial because, by storing this stuff in your head, rather than offloading
it to search engines and man pages, you make the connection between your brain
and the computer higher bandwidth. Programming then becomes more more fun in the
same way a conversation between two people who are fluent in the same language
is often more fun.

## Spaced repetition

Most of us stop making time for memorization when we stop taking exams. That's
probably because it's insanely boring and time-consuming. But that is less true
if you use spaced repetition, a family of algorithms for memorizing things
efficiently.

Spaced repitition works like this: on day 0, you're shown a question or prompt
and asked to recall the response. You're shown it again on day 1. And then again
on (for example) day 3, day 8, day 20, etc. These growing intervals are chosen
such that, just when you're on the verge of forgetting something, you're asked
to dredge it up from the back of your mind. If you can't do that then you go
back to the beginning of the sequence of intervals for that prompt. The growing
intervals mean that you're using your time efficiently while minimizing (not
eliminating!) the boringness.

It's a simple and very natural idea so it's a little surprising just how well it
works. I used spaced repetition to learn German. I haven't used German for
nearly ten years. I have a terrible memory. I _still_ remember not only the
words, but the _layout_ of specific flashcards I used to learn pretty obscure
bits of vocabulary.

## Anki

Natural language learning is probably the most common use case for spaced
repetition, but [lots](https://sive.rs/srs) of
[people](https://sasha.wtf/anki-post-1/) use it to memorize bits of things they
learn while programming. Anything that I have to look up more than a couple of
times goes in my list of prompts and responses. Some examples from my "deck" of
prompts and responses:

 - curl switch to follow redirects (short and long versions)  
    `-L --location`

 - Makefile alias for current target  
    `$@`

 - Find and replace string `foo` in a bash `$variable`  
    `${variable//foo/bar}`

 - [Tar a directory](https://xkcd.com/1168/)  
    `tar cf file.tar directory/`

I only add things I have to look up. I don't add things my editor helps me with,
such as the calling signatures of functions. I might benefit from doing that,
but that's where I draw the line.

To manage my "deck" of prompts and responses, and to review them at
appropriately spaced intervals I use [Anki](https://apps.ankiweb.net/).

Anki is a charmingly crusty bit of open-source cross-platform software. It uses
[its own spaced repetition
algorithm](https://faqs.ankiweb.net/what-spaced-repetition-algorithm.html). It's
ugly. It's confusing. The mobile versions are $25! But it's extremely popular,
very flexible, and better than [the scummy
rip-off](https://getpolarized.io/2020/02/03/anki-ripped-off.html).

You can and should assemble your own deck. But that's a lot of work (more work
than the remembering). So, if you want to give it a try first, download a small
public deck [from the shared library](https://ankiweb.net/shared/decks/). I
started with the [US state capitals](https://ankiweb.net/shared/info/959976866). 

## Execute Program and spaced repetition

[Execute Program](https://www.executeprogram.com/) is a subscription learning
site by [Gary Bernhardt](https://www.destroyallsoftware.com/). You work your way
through courses on Javascript, TypeScript, SQL and Regex and then you get
pestered by a spaced repetition algorithm to review, i.e. regurgitate what you
learned by completing tiny programs.

Each course takes perhaps 20 minutes/day for a couple of weeks (you have to wait
for the reviews so you can't do the whole course in a day). Once the lessons are
over, the reviews take about ten minutes/day at first, but that approaches zero
as the spaces between the repetitions grow.

![Execute Program](/post/executeprogram/executeprogram.png)

<p style="text-align:center; font-style:italic">The Execute Program review UI</p>

The spaced repetition is a little crude relative to Anki. For example, I miss
being able to [say if something was easy or
hard](https://docs.ankiweb.net/#/background?id=spaced-repetition). After you get
something right for the fourth time, on day 64, even it doesn't feel like it's
stuck, you're congratulated and told you're never going to see it again. And
related reviews all come on the same day, which makes them artificially easy.

But you can't argue with results. I can say with a straight face that I "know"
this stuff after spending four months as a subscriber, and doing the reviews.
So, very highly recommended!

## Execute Program's courses

In what sense do you "know" these subjects after completing the Execute Program
course? Firstly, you have the syntax at your fingertips thanks to spaced
repetition. For example, I'm not an experienced TypeScript programmer. But I
know the syntax well, and that makes occasionally writing crappy little
TypeScript programs at work much less frustrating. Secondly, the courses
themselves are incredibly well done. They're not a parade of facts. I
_understand_ stuff I didn't understand before I used the site.

I joined planning to learn concurrency but I ended up doing all of the other
courses: regular expressions, JavaScript arrays, Modern JavaScript, TypeScript,
and SQL.

They're all really good! My only complaint (and the reason I've let my
subscription lapse) is that they're not longer and there aren't more of them.
The [FAQ](https://www.executeprogram.com/faq) explains the teaching philosophy
better than I can, so I won't repeat it here. But I will make some comments on
my two favorite courses.

### Regular Expressions

This topic is the perfect fit for spaced repetition because there is no way
around the fact that you just gotta learn a bunch of facts (the same goes for
the course on JavaScript Arrays). The course stops before named groups and
lookback/ahead, so I had to learn that stuff myself (from [the second half of
this perfect, short
book](https://learning.oreilly.com/library/view/learning-regular-expressions/9780134757056/)).
But if you want to learn 90% of what you need to read and write regular
expressions in the absolute shortest amount of time, conditional on being able
to remember any of it, this course is the way to go.

### Concurrency

Concurrency is _not_ the perfect fit for spaced repetition. It's subtle. There
are often many different solutions to a problem. And the review "answers" tend
to be quite long in terms of number of characters. Nevertheless, this course is
probably my favorite.

I have been banging my head against a brick wall with concurrency for years. It
clicked for me this year in great part because of this course. (Shout out to
this talk about [the JS event
loop](https://www.youtube.com/watch?v=8aGhZQkoFbQ&feature=youtu.be) and some
Python async content too, especially [Łukasz Langa's
videos](https://www.youtube.com/watch?v=Xbl7XjFYsN4&list=PLhNSoGM2ik6SIkVGXWBwerucXjgP1rHmB)
and [Brad Solomon's Real Python
article](https://realpython.com/async-io-python/).)

Why is this course so good? Because it doesn't start from the assumption that
you know or care what [callback hell](http://callbackhell.com/) is, or even that
you're a particularly experienced JavaScript programmer (I'm not). Assuming you
know and hate JavaScript is a widespread antipattern in JavaScript writing: "you
think this sucks" is the starting point. Well, I didn't! But now you're making
me nervous (and confused because you're teaching me about a bunch of stuff that
I apparently should not do?!) In other words, [as Max Kreminski
says](https://mkremins.github.io/blog/doors-headaches-intellectual-need/):

> One of the worst things you can do is force people who don’t feel pain to take
> your aspirin.

The Execute Program Concurrency course just gets straight to the point:
timeouts, promises. I hope they add async/await.

## Conclusion

Execute Program is good. It's fun. The lessons are extremely thoughtfully put
together. I hope they add more!

And every time you have to search for something for the third time, add it to
an Anki deck.
