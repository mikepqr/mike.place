---
title: "Create a global gitignore"
date: 2020-05-22T22:50:13-07:00
slug: global-gitignore
description: "Set a global gitignore. Don't repeat yourself, and don't inflict your preferences on others."
---

If you use git then you should almost certainly create a _global_ `gitignore`
file. To do this, put the files and patterns you want to ignore globally in
`~/.config/git/ignore`.

This is the perfect place to ignore things like:

 - operating system cruft (`.DS_Store`, `Thumbs.db`)
 - editor stuff (`*.swp`, `.vscode`)
 - compiled source and bytecode (`*.o`, `__pycache__`)
 - virtual environments and external dependencies (`venv`, `node_modules`)
 - files you should rename before you commit (`Untitled.ipynb`)
 - tooling caches and output (`.mypy_cache`)

The global gitignore file works just like `.gitignore` files in individual
repositories, but it applies everywhere. Here's what [mine looks
like](https://github.com/williamsmj/dotfiles/blob/master/git/.config/git/ignore).

You might be tempted to put this stuff in a per-repository `.gitignore` file. I
think that's fine for stuff that's guaranteed to be created in a working copy
of a particular repository (e.g. `__pycache__` in a Python project).
But I much prefer to avoid it for OS-specific or editor-specific stuff.
Here's why.

1. These are things you always want to ignore. It's a waste of time to recreate
   this file in every repository.

2. Other users of the repository do not care about the crap created by the
   operating system or editor you happen to be using currently, you don't care
   about theirs. This stuff should not be in the shared, version-controlled
   configuration.
