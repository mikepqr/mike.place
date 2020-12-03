---
title: "Create a global gitignore"
date: 2020-05-22T22:50:13-07:00
slug: global-gitignore
description: "Set a global gitignore. Don't repeat yourself, and don't inflict your preferences on others."
---

If you use git then you should almost certainly create a _global_ `gitignore`
file to ignore things like that should almost never be version controlled, e.g.

 - operating system cruft (`.DS_Store`, `Thumbs.db`)
 - editor tempfiles and non-shared[^1] configuration (`*.swp`, `.vscode`)
 - compiled output (`*.o`, `__pycache__`, `build/`)
 - virtual environments and external dependencies (`venv`, `node_modules`)
 - files you should rename before you commit (`Untitled.ipynb`)
 - tooling caches and output (`.mypy_cache`)

By default, the global gitignore path is `~/.config/git/ignore` on Unix/macOS
and `%USERPROFILE%\git\ignore` on Windows.

The syntax is just like that for `.gitignore` files. Here's what [mine looks
like](https://github.com/mikepqr/dotfiles/blob/master/git/.config/git/ignore).

## Don't misuse the repository `.gitignore`

You might be tempted to put this stuff in a per-repository `.gitignore` file. I
think that's fine (if you _insist_) for things that are guaranteed to be
created in a working copy of a particular repository (e.g. `__pycache__` in a
Python project), and thus at particular risk of being merged by collaborators
who don't have a global gitignore like this. But I much prefer to avoid it for
OS-specific or editor-specific stuff. Here's why:

1. These are things you always want to ignore. Recreating and updating this
   file in every repository is a waste of time.

2. Other users of the repository do not care about the crap created by the
   operating system or the editor you happen to be using currently, and you
   don't care about theirs. This stuff should not be in the shared,
   version-controlled configuration.

If you follow this advice, repository `.gitignore` files will contain only of
project-specific configuration. They will be shorter and, if you work on a
project with lots of collaborators, they will produce less history churn.

## Overriding gitignore

If you do want to override your global behavior for some reason then you have a
couple of options. You can either manually `git add -f` the files. Or you can
use gitignore's `!` negation syntax in the repository's `.gitignore` or
`.git/info/exclude`. 

So, for example, if you've ignored `foo.txt` globally, but you really want to
commit it in a particular repository, you can `git add -f foo.txt` or put
`!foo.txt` in a repository `.gitignore` (which is normally version controlled
and shared with collaborators) `.git/info/exclude` (which is not, and is
therefore a truly local configuration).

## You don't need to change `core.excludesfile`

You'll see
[advice](https://stackoverflow.com/questions/7335420/global-git-ignore) to do
something like `git config --global core.excludesfile ~/.gitignore` to tell git
where you keep your global gitignore. There is no need to do this unless you
object to the perfectly reasonable default location
(`$XDG_CONFIG_HOME/git/ignore` or `%USERPROFILE%\git\ignore`).

[^1]: A project's `.editorconfig` should not normally be gitignored!
