+++
Description = ""
date = "2016-02-03T15:33:26-05:00"
menu = ""
title = "extranapkins's sequence in functional Python"
slug = "extranapkins"

+++

Inspired by [Douglas
Hofstadter's](https://en.wikipedia.org/wiki/G%C3%B6del,_Escher,_Bach) and
[Martin Gardner's](https://en.wikipedia.org/wiki/Martin_Gardner) deeply
profound works on mathematical sequences and recursion, and Joel Grus's talk
[Stupid Itertools Tricks for Data
Science](https://www.youtube.com/watch?v=ThS4juptJjQ), I present a functional
Python implementation of extranapkins's sequence.[^1]

<blockquote class="twitter-tweet" data-lang="en"><p lang="en" dir="ltr">I&#39;ve got eight words for you: I&#39;ve got two words for you: Fuck off</p>&mdash; &#39;&#39;Steve&#39;&#39; (@extranapkins) <a href="https://twitter.com/extranapkins/status/627001477169573889">July 31, 2015</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

The 0th item in this sequence is

    "Fuck off"

The 1st item is

    "I've got two words for you: Fuck off"

The 2nd item is

    "I've got eight words for you: I've got two words for you: Fuck off"

The `n+1`th item in this sequence is

    "I've got L_n words for you: S_n"

where `S_n` is the `n`th item in the sequence, and `L_n` is the number of words
in `S_n`, expressed in words. Thus, here is a Python function that takes the
`n`th item and returns the `n+1`th item in extranapkins's sequence:[^2]

```python
from num2words import num2words

def next_ens(s):
    n = num2words(len(s.split()))
    return "I've got {} words for you: {}".format(n, s)
```

Given `next_ens()` we can generate successive items in the sequence by hand:

```python
>>> next_ens('Fuck off')
"I've got two words for you: Fuck off"
>>> next_ens(next_ens('Fuck off'))
"I've got eight words for you: I've got two words for you: Fuck off"
```

We could automate this with recursion or a loop. But we can do it more quickly,
with less code, and at the same time eliminate the dangers of variable
mutation, the irritant of
[`sys.setrecursionlimit`](https://docs.python.org/3/library/sys.html#sys.setrecursionlimit),
and the inefficiencies of [recursion with memoization](/2016/memoization/), by
using the tools of functional programming.

In particular we'll use [Joel Grus's python
implementation](https://github.com/joelgrus/stupid-itertools-tricks-pydata/blob/master/src/stupid_tricks.py#L15-L17)
of [Haskell's `iterate()`
function](https://www.haskell.org/hoogle/?hoogle=iterate). This takes a
function `f` and an initial value `x`, and returns an iterator that lazily
yields the items in the infinite sequence `x`, `f(x)`, `f(f(x))`, `f(f(f(x)))`,
...

```
from itertools import accumulate, repeat

def iterate(f, x):
    return accumulate(repeat(x), lambda fx, _: f(fx))
```

You might have to stare at `iterate()` for a while (or [watch Joel's
talk](https://www.youtube.com/watch?v=ThS4juptJjQ)) to figure out how it does
what it does. I also needed a pen and paper. Having to stare at a line for ten
minutes is part of the hazing ritual of functional programming. After a while
you can stop caring how these functions work, and take them on trust.

Anyway, we can use `next_ens()`, which tells you how to get from the `n`th to
the `n+1`th item, and `iterate()`, to create an iterator `ens` that yields the
items in the sequence...

```python
>>> ens = iterate(next_ens, 'Fuck off')
>>> next(ens)
'Fuck off'
>>> next(ens)
"I've got two words for you: Fuck off"
>>> next(ens)
"I've got eight words for you: I've got two words for you: Fuck off"
```

...and with Joel's [Python implementation of `take()`](https://github.com/joelgrus/stupid-itertools-tricks-pydata/blob/master/src/stupid_tricks.py#L9-L10)...

```python
from itertools import islice

def take(n, it):
    return [x for x in islice(it, n)]
```

...we can evaluate the first `n` items...

```python
>>> ens = iterate(next_ens, 'Fuck off')
>>> take(5, ens)
['Fuck off', "I've got two words for you: Fuck off", "I've got eight words for you: I've got two words for you: Fuck off", "I've got fourteen words for you: I've got eight words for you: I've got two words for you: Fuck off", "I've got twenty words for you: I've got fourteen words for you: I've got eight words for you: I've got two words for you: Fuck off"]
```

...or just the nth item:

```python
>>> ens = iterate(next_ens, 'Fuck off')
>>> take(100, ens)[-1] 
"I've got eight hundred and thirty-one words for you: I've got eight hundred and twenty-two words for you: I've got eight hundred and thirteen words for you: I've got eight hundred and four words for you: I've got seven hundred and ninety-five words for you: I've got seven hundred and eighty-six words for you: I've got seven hundred and seventy-seven words for you: I've got seven hundred and sixty-eight words for you: I've got seven hundred and fifty-nine words for you: I've got seven hundred and fifty words for you: I've got seven hundred and forty-one words for you: I've got seven hundred and thirty-two words for you: I've got seven hundred and twenty-three words for you: I've got seven hundred and fourteen words for you: I've got seven hundred and five words for you: I've got six hundred and ninety-six words for you: I've got six hundred and eighty-seven words for you: I've got six hundred and seventy-eight words for you: I've got six hundred and sixty-nine words for you: I've got six hundred and sixty words for you: I've got six hundred and fifty-one words for you: I've got six hundred and forty-two words for you: I've got six hundred and thirty-three words for you: I've got six hundred and twenty-four words for you: I've got six hundred and fifteen words for you: I've got six hundred and six words for you: I've got five hundred and ninety-seven words for you: I've got five hundred and eighty-eight words for you: I've got five hundred and seventy-nine words for you: I've got five hundred and seventy words for you: I've got five hundred and sixty-one words for you: I've got five hundred and fifty-two words for you: I've got five hundred and forty-three words for you: I've got five hundred and thirty-four words for you: I've got five hundred and twenty-five words for you: I've got five hundred and sixteen words for you: I've got five hundred and seven words for you: I've got five hundred words for you: I've got four hundred and ninety-one words for you: I've got four hundred and eighty-two words for you: I've got four hundred and seventy-three words for you: I've got four hundred and sixty-four words for you: I've got four hundred and fifty-five words for you: I've got four hundred and forty-six words for you: I've got four hundred and thirty-seven words for you: I've got four hundred and twenty-eight words for you: I've got four hundred and nineteen words for you: I've got four hundred and ten words for you: I've got four hundred and one words for you: I've got three hundred and ninety-two words for you: I've got three hundred and eighty-three words for you: I've got three hundred and seventy-four words for you: I've got three hundred and sixty-five words for you: I've got three hundred and fifty-six words for you: I've got three hundred and forty-seven words for you: I've got three hundred and thirty-eight words for you: I've got three hundred and twenty-nine words for you: I've got three hundred and twenty words for you: I've got three hundred and eleven words for you: I've got three hundred and two words for you: I've got two hundred and ninety-three words for you: I've got two hundred and eighty-four words for you: I've got two hundred and seventy-five words for you: I've got two hundred and sixty-six words for you: I've got two hundred and fifty-seven words for you: I've got two hundred and forty-eight words for you: I've got two hundred and thirty-nine words for you: I've got two hundred and thirty words for you: I've got two hundred and twenty-one words for you: I've got two hundred and twelve words for you: I've got two hundred and three words for you: I've got one hundred and ninety-four words for you: I've got one hundred and eighty-five words for you: I've got one hundred and seventy-six words for you: I've got one hundred and sixty-seven words for you: I've got one hundred and fifty-eight words for you: I've got one hundred and forty-nine words for you: I've got one hundred and forty words for you: I've got one hundred and thirty-one words for you: I've got one hundred and twenty-two words for you: I've got one hundred and thirteen words for you: I've got one hundred and four words for you: I've got ninety-eight words for you: I've got ninety-two words for you: I've got eighty-six words for you: I've got eighty words for you: I've got seventy-four words for you: I've got sixty-eight words for you: I've got sixty-two words for you: I've got fifty-six words for you: I've got fifty words for you: I've got forty-four words for you: I've got thirty-eight words for you: I've got thirty-two words for you: I've got twenty-six words for you: I've got twenty words for you: I've got fourteen words for you: I've got eight words for you: I've got two words for you: Fuck off"
```

So there you go: extranapkins's sequence in functional Python.

[^1]: Seriously though, [Joel's talk](https://www.youtube.com/watch?v=ThS4juptJjQ) is really good. It demonstrates that `iterate` is useful for much more than a recursively defined sequence with an F-bomb at the end. It can be used in any situation where an operation is applied repeatedly, such as gradient descent, and can lead to much simpler code.

[^2]: This function uses [`num2words`](https://pypi.python.org/pypi/num2words) to convert an integer such as `129` into its English language words (`"one hundred and twenty-nine"`). Note that this package supports several languages, included Indian English and Latvian, so it would be simple to generalize extranapkins's sequence to those languages.
