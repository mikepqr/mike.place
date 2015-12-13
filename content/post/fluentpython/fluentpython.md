+++
Description = ""
date = "2015-11-23T19:15:43-05:00"
menu = ""
slug = "fluent-python-reading"
title = "Further Reading from Fluent Python"

+++

I'm reading Luciano Ramalho's [*Fluent
Python*](http://shop.oreilly.com/product/0636920032519.do) right now. It's a
great book. I'm particularly enjoying the Further Reading sections that end
each chapter. Here are some of my highlights.

### Chapter 1: The Python data model

 - [Data model](https://docs.python.org/3/reference/datamodel.html) in *The
   Python Language Reference*

### Chapter 2: An array of sequences

 - [Why numbering should start from
   zero](https://www.cs.utexas.edu/users/EWD/transcriptions/EWD08xx/EWD831.html)
   by Edsger W. Dijkstra

### Chapter 4: Text versus bytes

 - [Pragmatic unicode](http://nedbatchelder.com/text/unipain.html) by Ned
   Batchelder at PyCon 2012
 - [Character encoding and unicode in
   Python](https://www.youtube.com/watch?v=Mx70n1dL534) by Travis Fischer and
   Esther Nam at PyCon 2014
 - [Chapter 3 of *Dive Into
   Python*](http://www.diveintopython3.net/strings.html) by Mark Pilgrim 
 - [Processing text files in Python
   3](http://python-notes.curiousefficiency.org/en/latest/python3/text_file_processing.html)
     by Nick Coghlan

### Chapter 5: First-class functions

 - [Functional programming
    HOWTO](https://docs.python.org/3/howto/functional.html)
 - [Raymond Hettinger on function annotations at Stack
   Overflow](http://stackoverflow.com/questions/3038033/what-are-good-uses-for-python3s-function-annotations/7811344#7811344)
 - [Alex Martelli on `functools.partial` at Stack
   Overflow](http://stackoverflow.com/questions/3252228/python-why-is-functools-partial-necessary/3252425#3252425)

### Chapter 6: Design patterns with first-class functions

 - [Design patterns with dynamics languages](http://norvig.com/design-patterns/) by Peter Norvig

### Chapter 7: Function decorators and closures

 - [Python decorators in 12
   steps](http://simeonfranklin.com/blog/2012/jul/1/python-decorators-in-12-steps/)
   by Simeon Franklin (not mentioned in *Fluent Python*, but I'd been meaning
   to read it for a while, so I'm putting it here)
 - [The decorator module
   documentation](http://pythonhosted.org/decorator/documentation.html) by
   Michele Simionato
 - [Blog posts on decorators and monkey
   patching](https://github.com/GrahamDumpleton/wrapt/tree/master/blog) by
   Graham Dumpleton
 - [Closures in Python](http://effbot.org/zone/closure.htm) by Fredrik Lundh
 - [The roots of Lisp](http://www.paulgraham.com/rootsoflisp.html) by Paul
   Graham

### Chapter 8: Object references, mutability and recycling

 - [Python 103: Memory model & best
   practices](http://cdn.oreillystatic.com/en/assets/1/event/95/Python%20103_%20Memory%20Model%20_%20Best%20Practices%20Presentation.pdf)
   by Wesley Chun

### Chapter 9: A Pythonic object

 - [Format Specification
   Mini-Language](https://docs.python.org/3/library/string.html#formatspec) in
   *The Python Language Reference*
 - [The definitive guide on how to use static, class or abstract methods in
   Python](https://julien.danjou.info/blog/2013/guide-python-static-class-abstract-methods)
   by Julien Danjou

### Chapter 11: Interfaces: from protocols to ABCs

 - [Contracts in Python: A conversation with Guido van
   Rossum](http://www.artima.com/intv/pycontract.html) by Bill Venners

### Chapter 12: Inheritance: for good or for worse

 - [Python's super is nifty, but you can't use
   it](https://fuhm.net/super-harmful/) by James Knight
 - [Super considered
   super](https://rhettinger.wordpress.com/2011/05/26/super-considered-super/)
   by Raymond Hettinger
 - [Setting multiple inheritance
   straight](http://www.artima.com/weblogs/viewpost.jsp?thread=246488) by
   Michele Simionato

### Chapter 14: Iterables, iterators, and generators

 - [Loop like a native](http://nedbatchelder.com/text/iter.html) by Ned
   Batchelder at PyCon 2013 (not mentioned in *Fluent Python*)
 - [Iterables vs. iterators vs.
   generators](http://nvie.com/posts/iterators-vs-generators/) (not mentioned
   in *Fluent Python*)
 - [Generator Tricks for Systems
   Programmers](http://www.dabeaz.com/generators/) by David Beazley (not
   mentioned in *Fluent Python*)

### Chapter 15: Context managers and else blocks

 - [Raymond Hettinger on `try-except-else` at Stack
   Overflow](http://stackoverflow.com/a/16138864) 
 - [What makes Python awesome](https://www.youtube.com/watch?v=NfngrdLv9ZQ) by
   Raymond Hettinger at PyCon 2013
 - [Transforming code into beautiful, idiomatic
   Python](https://www.youtube.com/watch?v=OSGv2VnC0go) by Raymond Hettinger at
   PyCon 2013 (see also [Jeff Paine's
   notes](https://gist.github.com/JeffPaine/6213790))
 - [The Python `with` statement by
   example](http://preshing.com/20110920/the-python-with-statement-by-example/)
   by Jeff Preshing
 - [`redirect_stdout` in `contextlib`
   utilities](https://docs.python.org/3/library/contextlib.html#utilities)

### Chapter 16: Coroutines

 - [Flattening a nested sequence with `yield
   from`](https://www.safaribooksonline.com/library/view/python-cookbook-3rd/9781449357337/ch04s14.html)
   from the *Python Cookbook*, 3rd edition 
 - [A curious course on coroutines and
   concurrency](http://www.dabeaz.com/coroutines/) by David Beazley (videos:
   [1](http://pyvideo.org/video/213/), [2](http://pyvideo.org/video/215/),
   [3](http://pyvideo.org/video/214/))
 - [Consider coroutines to run many functions
   concurrently](http://www.informit.com/articles/article.aspx?p=2320938) by
   Brett Slatskin implements Conway's game of life with coroutines. Ramalho
   provides a [refactored
   version](https://gist.github.com/ramalho/da5590bc38c973408839)
 - [Iterables, Iterators and
   Generators](https://github.com/wardi/iterables-iterators-generators/blob/master/Iterables%2C%20Iterators%2C%20Generators.ipynb)
   by Ian Ward implements Rock-Paper-Scissors with coroutines
 - [Writing a discrete event simulation: ten easy
   lessons](http://www.cs.northwestern.edu/~agupta/_projects/networking/QueueSimulation/mm1.html)
   by Ashish Gupta

### Chapter 19: Concurrency with futures

 - [The future is
   soon](http://www.pyvideo.org/video/480/pyconau-2010--the-future-is-soon) by
   Brian Quinlan at PyCon AU 2010
 - [Understanding the GIL](https://www.youtube.com/watch?v=Obt-vMVdM8s) by
   David Beazley at PyCon 2010

### Chapter 18: Concurrency with asyncio

 - [Fan-in and fan-out: The crucial components of
   concurrency](https://www.youtube.com/watch?v=CWmq-jtkemY) by Brett Slatkin
   at PyCon 2014

### Chapter 19: Dynamic attributes and properties

 - [The simple but handy "collector of a bunch of named stuff"
   class](http://code.activestate.com/recipes/52308-the-simple-but-handy-collector-of-a-bunch-of-named/)
   by Alex Martelli

### Chapter 20: Attribute descriptors

 - [Descriptor HOWTO](https://docs.python.org/3/howto/descriptor.html) by
   Raymond Hettinger
 - [The Python object model](https://www.youtube.com/watch?v=VOzvpHoYQoo) by
   Alex Martelli
 - [Python
   warts](http://web.archive.org/web/20031002184114/www.amk.ca/python/writing/warts.html)
   by A. M. Kuchling

### Afterword

 - [A Python æsthetic: beauty and why I
   python](https://www.youtube.com/watch?v=x-kB2o8sd5c) by Brandon Rhodes
 - [The Hitchhiker’s Guide to Python](http://docs.python-guide.org/en/latest/)

### Books

Several books are mentioned repeatedly in the Further Reading sections, or
otherwise caught my eye:

 - *Python Cookbook*, 2nd Edition edited by Alex Martelli, Anna Martelli
   Ravenscroft, and David Ascher, and... 
 - *Python Cookbook*, 3rd Edition by David Beazley and Brian K. Jones. The
   second edition was written for Python 2.4. According to Ramalho, the third
   edition, 'which was rewritten from scratch, focusses more on semantics of
   the language, particularly what has changed in Python 3, while the second
   edition emphasizes pragmatics' and 'it is worthwhile to have both editions
   on hand'. The 3rd edition is mentioned in the Further Reading section of
   almost every chapter of *Fluent Python*.
 - *Python in a Nutshell*, 2nd Edition by Alex Martelli (covers Python 2.5, but
   apparently especially clear and authoritative on the data model)
 - *Python 3: Essential Reference*, 4th Edition by David Beazley
 - *Design Patterns: Elements of Reusable Object-Oriented Software* by Gamma,
   Helm, Johnson, Vlissides
 - *Head First Design Patterns* by Eric Freeman, Bert Bates, Kathy Sierra and
   Elisabeth Robson
 - *Effective Python* by Brett Ratkin
