+++
Description = ""
date = "2016-02-01T17:00:00-05:00"
menu = ""
title = "Why not use Jupyter Notebook?"
slug = "notebook"

+++

Jupyter Notebook is a wonderful tool in situations that play to its
strengths. But I try to use it only in those situations, because I find it
makes it hard to write good code and to practice good software engineering.

YMMV, but I use notebook to:

 - distribute reports with inline figures, or
 - explain code containing no function or class definitions to an audience

Why not more often?

## 1. I find it hard to write substantial code in a notebook

Jumping between notebooks (or even moving around within a notebook) is hard
compared to a text editor or IDE, so functions and classes place a cognitive
overhead on the coder/reader that is not entirely overcome by
[`shift-tab`](https://twitter.com/jakevdp/statuses/648622705340583936).

And you can execute cells out of order. In fact it's natural to use it in this
way. But I find that I introduce bugs as soon as I try it in a project more
substantial or structured than a script. Sometimes the bugs are simple
`NameError` exceptions, which are irritating since they would be [easily
spotted](https://github.com/scrooloose/syntastic) in a text editor, but are
simple enough to fix by running cells in order. But mutated variables often
introduce much subtler and less benign bugs.

![NameError](/post/notebook/nameerror.png)

The upshot of these two issues is that I almost never define classes or
non-`lambda` functions in a notebook. When I do, I write buggy, confusing code.
And in any case, if code is useful enough and abstractable enough to be a
function or class, then it belongs in a module that can be imported by other
code, not siloed off in a notebook.

An environment in which I avoid writing functions or classes is not an
environment I can use for substantial work.

## 2. It doesn't play nice with version control 

The notebook way of doing things requires documentation, code and output to be
woven together. There is not a one-to-one mapping between lines of the `.ipynb`
file and the code and comments you typed. This complicates the semantics of
version control enormously. 

Notebook diffs are difficult to read, which makes things harder for the
committer, and *much* harder for anyone who has to review commits ([this
diff](https://github.com/williamsmj/notebook-diffs/commit/cedcadee87c878e48192b4fb845dd7b3c322236f)
fixed a NameError by running cells in order without changing code). And your
version control software may insist that a file has changed when, from your
point of view, it hasn't.

Why is this? Firstly, diffs due to real changes to the input are hard to read
because they contain json cruft and the `<textarea>` editor makes it harder to
edit code consistently:

![notebook diff](/post/notebook/nbdiff.png)

Secondly, changes to the `metadata` section of a notebook are invisible to the
user until they `diff`. And finally, a notebook changes when you run a cell,
even if the input is unchanged:

 - cell numbers change every time you run a cell
 - output can change if the environment is different or the code has random
   behaviour
 - the string that encodes an inline image can change, even if the image is
   visually identical

You can of course manually clear output before committing, or use [commit hooks
to automate this] (https://gist.github.com/matsen/37521f504a14aede644d). And
although it makes reading diffs extra-difficult, you might actually want to
record output changes in version control. But these complexities make
integrating notebooks into a source-controlled project --- or getting used to
version control as a beginner --- non-trivial.

## 3. I have to swap my text editor for a `<textarea>`

This is a big point, but it doesn't take as long as the others to explain: text
editing in Notebook has come on leaps and bounds. But it doesn't help me write
PEP8-compliant code, it doesn't have IDE features to navigate a non-trivial
project and spot bugs, and because it's ultimately a tricked-out `<textarea>`
for the general user, it will never [behave like my text
editor](https://github.com/williamsmj/dotfiles-vim).

![vim command](/post/notebook/vim.png)

So, that's why I don't use Jupyter Notebook more often!

## Jupyter Notebook is great!

All that said, the features of Jupyter Notebook that lead to the difficulties
I've described are _features_, not bugs, and I'm certainly not suggesting they
be "fixed". All things in moderation, but a notebook is often the right tool
for the job, and [literate
programming](https://en.wikipedia.org/wiki/Literate_programming) is a
tremendously powerful way of interacting with a computer. 

If a notebook workflow works for you, then my intention here is not to persuade
you that you're wrong! But if you struggle to grok development in notebooks as
I do, I wrote this to remind you that modules and text editors are still an
option. And if you teach, think about whether the benefits justify the
complexities for beginner coders.

p.s. `i 💙  ipython` (the command line version)
