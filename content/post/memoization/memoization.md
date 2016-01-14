+++
Description = ""
date = "2016-01-10T14:42:47-05:00"
menu = ""
title = "Memoization in Python"
slug = "memoization"

+++

Memoization is a way of caching the results of a function call. If a function
is memoized, evaluating it is simply a matter of looking up the result you got
the first time the function was called with those parameters. This is recorded
in the memoization cache. If the lookup fails, that's because the function has
never been called with those parameters. Only then do you need to run the
function itself.

Memoization only makes sense if the function is deterministic, or you can live
with the result being out of date. But if the function is expensive,
memoization can result in a massive speedup. You're trading the computational
complexity of the function for that of lookup.

This article will:

 - show you what memoization is,
 - demonstrate three ways of doing it by hand in Python,
 - introduce you to the idea of decorators,
 - and show you how to use the Python standard library to circumvent the fiddly
   details of memoization and decoration

## The Fibonnaci sequence

The usual expository example of memoization is the Fibonacci sequence

```
1 1 2 3 5 8 13 21 ...
```

where each item in the sequence is the sum of the previous two items. Here's a
Python implementation:

```python
def fib(n):
    if n <= 2:
        return 1
    else:
        return fib(n - 2) + fib(n - 1)
```

The problem with that naive recursive approach is that the number of calls
grows exponentially with n, making it very expensive for large `n`:

```python
In [1]: [_ = fib(i) for i in range(1, 35)]
CPU times: user 30.6 s, sys: 395 ms, total: 31 s
Wall time: 31.9 s
```

To evaluate `fib(10)` we need to compute `fib(8)` and `fib(9)`. But we already
computed `fib(8)` when computing `fib(9)`. The trick is to remember these
results. This is _memoization_. 

The punchline of this article is that you can memoize a function in Python 3.2
or later by importing `functools` and adding the `@functools.lru_cache`
decorator to the function. Feel free to [skip to the final
section](#punchline), which shows this.

But if you want to know a little bit more about how memoization works in
Python, why doing it by hand involves syntactically ugly compromises, and what
decorators are, read on through three approaches to manual memoization.

## Memoization by hand: misusing a default parameter

The first approach to memoization takes advantage of an infamous 'feature' of
Python to add state to a function:

```python
def fib_default_memoized(n, cache={}):
    if n in cache:
        ans = cache[n]
    elif n <= 2:
        ans = 1
        cache[n] = ans
    else:
        ans = fib_default_memoized(n - 2) + fib_default_memoized(n - 1)
        cache[n] = ans

    return ans
```

The basic logic should be obvious: `cache` is a dictionary of the results of
previous calls to `fib_default_memoized()`, with the parameter `n` as the key,
and the nth Fibonacci number as the value. In the function, we first check if
the Fibonacci number for `n` is already in the cache. If it is, we're done. If
not, we evaluate it as in the naive recursive version, and store it in the
cache before returning the result.

The trick here is that `cache` is a keyword parameter of the function. Python
evaluates keyword parameters once and only once, when the function is imported.
This means that if the keyword parameter is mutable (which a dictionary is),
then it only gets initialized once. [This is often the cause of subtle
bugs](http://effbot.org/zone/default-values.htm), but in this case we take
advantage of it by mutating the keyword parameter. The changes we make (i.e.
populating the cache) don't get wiped out by `cache={}` in the function
definition, because that expression doesn't get evaluated again.

With memoization we get a speedup of six orders of magnitude, from seconds to
microseconds. Which is nice.

```python
In [2]: %time [_ = fib_default_memoized(i) for i in range(1, 35)]
CPU times: user 33 µs, sys: 0 ns, total: 33 µs
Wall time: 37.9 µs
```

## Memoization by hand: objects

Some would argue that mutating the formal parameters of a function is not a
good idea. Some other people (Java programmers, for example), would argue that
a function with state should be made into an object. This is how that might
look:

```python
class Fib():

    cache = {}

    def __call__(self, n):
        if n in self.cache:
            ans = self.cache[n]
        if n <= 2:
            ans = 1
            self.cache[n] = ans
        else:
            ans = self(n - 2) + self(n - 1)
            self.cache[n] = ans

        return ans
```

Here we use the `__call__` dunder method to make instances of `Fib` behave
syntactically like functions. `cache` is a class attribute, which means it is
shared by all instances of `Fib`. In the case of evaluating Fibonacci numbers,
this is desirable. But if the object was making calls to a server defined in
the constructor, and the result depended on the server, it would be a bad
thing. You would then move it into a object attribute by moving it into
`__init__`. Regardless, you get the memoization speedup:

```python
In [3]: f = Fib()

In [4]: %time [_ = f(i) for i in range(1, 35)]
CPU times: user 116 µs, sys: 0 ns, total: 116 µs
Wall time: 120 µs
```

Now, in 2012 Jack Diederich gave a wonderful PyCon talk called '[Stop Writing
Classes](https://www.youtube.com/watch?v=o9pEzgHorH0)'. You should watch the
whole thing! But the short version is: a Python class with only two methods,
one of which is `__init__` has a bad [code
smell](https://en.wikipedia.org/wiki/Code_smell). Class `Fib` up there doesn't
even have two methods. And it's four times slower than the hacky default parameter
method because of object lookup overheads. It stinks. 

## Memoization by hand: using `global` 

You can avoid the hacky mutation of default parameters, and the Java-like
over-engineered object, by simply using `global`. `global` gets a bad rap, but
if it's [good enough for Peter
Norvig](http://nbviewer.ipython.org/url/norvig.com/ipython/Probability.ipynb),
they're good enough for me:

> My personal preference would be that the `global here` declarations add 
> less visual clutter than the 32 instances of `self` needed for the class 
> definition.

Our `Fib` class doesn't quite have 32 instances of `self`, but you could argue
that the `global` version is more readable:

```python
global_cache = {}

def fib_global_memoized(n):
    global global_cache
    if n in global_cache:
        ans = global_cache[n]
    elif n <= 2:
        ans = 1
        global_cache[n] = ans
    else:
        ans = fib_global_memoized(n - 2) + fib_global_memoized(n - 1)
        global_cache[n] = ans

    return ans
```

This is identical to the hacky default parameter method, but in this case we
ensure the cache is retained across function calls by making it global.

Neither the default parameter, object, or global cache methods are entirely
satisfactory. The good news, however, is that in Python 3.2, the problem was
solved for us by the `lru_cache` decorator.

## An aside: decorators

A decorator is a higher-order function, i.e. one that takes as its argument a
function, and returns another function. In the case of a decorator, that
returned function is usually just the original function augmented with some
extra functionality. In the simplest case, the extra functionality is a pure
side-effect such a logging. For example, we could create a decorator that
prints some text each time the function it decorates is called:

```python
def output_decorator(f):
    def f_(f)
        f()
        print('Ran f...')
    return f_
```

You can replace `f` with the decorated version by doing `f =
output_decorator(f)`. If you now call `f()`, you get the decorated version,
i.e. the original function, plus the print output. Python provides some
syntactic sugar to make this even easier:

```python
@output_decorator
def f()
    # ... define f ...
```

If that didn't make sense, Simeon Franklin's [Understanding decorators in 12
easy
steps](http://simeonfranklin.com/blog/2012/jul/1/python-decorators-in-12-steps/)
is a tutorial that takes you from the fundamentals of first class functions to
the principles of decoration. It's great!

The side-effect of our `output_decorator` is not very interesting. But we could
go beyond pure side-effects and augment the operation of the function itself.
For example, the decorator could add precisely the kind of cache required for
memoization, and intercept calls to the decorated function when the answer is
already in the cache.

But if you try to write your own decorator for memoization, you quickly get
mired in the details of argument passing and, and once you've figured that out
you get truly stuck with Python introspection. Put simply, naively decorating a
function is a good way to break the features the interpreter and other code
depends on to learn about the function. For more details, check out the
[documentation of the `decorator`
module](http://pythonhosted.org/decorator/documentation.html#statement-of-the-problem),
The `decorator` and [`wrapt`](https://github.com/GrahamDumpleton/wrapt) modules
figure these introspection issues out for you if you're happy to use
non-standard library code.

But luckily for us, for the particular case of memoization, the fiddly
decorator details have been worked out, and the solution in in the standard
library.

<a name="punchline"></a>
## `functools.lru_cache`

If you're running Python 3.2 or newer, all you have to do to memoize a function
is apply the `functools.lru_cache` decorator:

```python
import functools

@functools.lru_cache()
def fib_lru_cache(n):
    if n < 2:
        return n
    else:
        return fib_lru_cache(n - 2) + fib_lru_cache(n - 1)
```

Note this is simply the original function with an extra `import` and a
decorator. What could be simpler? And applying this decorator gives the six
orders of magnitude speedup we expect:

```
In [5]: %time [fib.fib_lru_cache(i) for i in range(1, 35)]
CPU times: user 57 µs, sys: 1 µs, total: 58 µs
Wall time: 61 µs
```

The LRU in `lru_cache` stands for least-recently used. It's a FIFO approach to
managing the size of the cache, which could grow very large for functions more
complicated than `fib()`. But fundamentally, the approach to memoization taken
by this standard library decorator is the same as is discussed above. In fact,
And there are [backports of this
decorator](http://code.activestate.com/recipes/578078-py26-and-py30-backport-of-python-33s-lru-cache/)
if you're stuck on Python 2.7 (or want to take a quick look at the code).

`lru_cache` is not without compromises and overheads (note that `fib_lru_cache`
is half the speed of our first attempt at memoization), but its trivial
decorator interface makes it so easy to use that, when you find a good place in
your application for memoization, it's as easy as throwing a switch.
