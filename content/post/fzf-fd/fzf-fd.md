---
title: "Navigating a filesystem quickly with fzf and fd"
date: 2017-10-24T16:40:36-07:00
slug: "fzf-fd"
Description: "Together, you can use fzf and fd to quickly find files and change directories."
---

[fzf](https://github.com/junegunn/fzf) is a command line tool that allows you
to interactively filter its input using fuzzy searching.
[fd](https://github.com/sharkdp/fd) sends the paths of files in a directory
tree to standard output. Together, you can use fzf and fd to quickly find files
and change directories.

## tl;dr

Install [fzf](https://github.com/junegunn/fzf) and
[fd](https://github.com/sharkdp/fd) according to the instructions for your OS.

Set these environment variables
```bash
export FZF_DEFAULT_COMMAND="fd . $HOME"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd -t d . $HOME"
```

Done. You can now press
 
 - `CTRL-T` to fuzzily search for a file or directory in your home directory
   then insert its path at the cursor
 - `ALT-C` to fuzzily search for a directory in your home directory then cd
   into it
 - `CTRL-R` to fuzzily search your command line history then run an old command

Read on for the details.

## Basic fzf use

On macOS with homebrew you can install fzf with

```
brew install fzf
```

Now is a good time to run it's post-install script, which sets up some keyboard
shortcuts we'll be using later. If you installed with homebrew, you can do this
by running `/usr/local/opt/fzf/install`. See the documentation for other
operating systems.

Once it's installed, run this command

```
cat /usr/share/dict/words | fzf
```

This pipes the contents of `/usr/share/dict/words` into into fzf. You can then
use the fuzzy matching of fzf to filter the file (which is a list of lots of
English words).

Type a few characters to see what happens. You can use the arrow keys (or
`Ctrl-N/P`) to navigate the list if the particular item you're looking for is
hard to filter. Then hit return and the selection is sent to standard output.

fzf has lots of options that come in handy when using it in pipelines (e.g.
`-1`, `-m`, `-q`) or that affect it's appearance (e.g `--height 40%`, or even
`fzf-tmux`). See `man fzf` for more.

## Basic fd use

[fd](https://github.com/sharkdp/fd) is a faster, more user-friendly alternative
to the venerable unix `find` command. It doesn't do everything `find` does, but
it's faster (both to type the command, and to run it) for most interactive use
cases.

On macOS with homebrew you can install fd with

```
brew install fd
```

Then you can list all files whose names match a
pattern below a path with

```bash
fd [pattern] [path]
```

Omit the pattern and path to list all files below your current location. Or do

```
fd . ~
```

to list all files in your home directory.

Note that these commands ignore hidden files and `.gitignore`d files by
default. "Hidden" files are those whose name start with a dot.

## Using fd with fzf

fzf's keyboard shortcuts make it a powerful command line file navigation tool.

Make sure you followed the fzf installation instructions to configure these
shortcuts in your shell, e.g. if you installed with homebrew, run
`/usr/local/opt/fzf/install`.

Then set these environment variables in your shell startup:

```
export FZF_DEFAULT_COMMAND="fd . $HOME"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd -t d . $HOME"
```

`FZF_DEFAULT_COMMAND` is piped into fzf if you run `fzf` without any input. So,
with this setup, `fd . $HOME | fzf` and `fzf` do the same thing.

They send a listing of all non-hidden, non-ignored files and directories in
your home directory to fzf, and then send the file you select to standard
output.

Just sending the file to standard output is not very useful on its own
though. The keyboard shortcuts are where it gets useful.

### `CTRL-T` to add paths to a command

If you hit `CTRL-T` the thing you select in fzf (which again is a line from
the output of fd) is added to your command line at the cursor. So you can type

```
cp foo.txt <CTRL-T>
```

You can then use fzf to select the destination directory (as long as it's
somewhere in your home directory). Once you've selected it you can hit return
to add it to the command line you're working on, and then hit return again to
execute the command.

### `ALT-C` to change directory

If you hit `ALT-C` then you can use fzf to change to any directory in your home
directory.

That's because `FZF_ALT_C_COMMAND="fd -t d . $HOME"` generates a list of
directories below home.

### `CTRL-R` to search the history

`CTRL-R` pipes your history to fzf, allowing you to find and rerun complicated
commands with fzf.

## Searching outside home and excluding directories

Change `$HOME` in `FZF_DEFAULT_COMMAND` and `FZF_ALT_C_COMMAND` to start the
search for files or directories from a root directory other than `~`.

If you choose to start the search somewhere high up the directory tree (e.g.
`/`), or if your home directory contains a lot of files, then you may find
things slow down a little simply because there are more directories to search.

The solution is to add directories you're not interested in to a `.gitignore`
file in the root directory from which you're starting fd. The `.gitignore` file
doesn't need to be used by git. So, for example, my `~/.gitignore` consists of

```markdown
/Library/
!/.dotfiles/
```

The first line tells fd (and git, if I were to make my home directory a repo)
to ignore `~/Library/` (which is where macOS and it's GUI application put a
bunch of configuration and cache stuff a command line user is not usually
interested in).

The second line explicitly tells fd to include `~/.dotfiles`, which is a
directory in my home folder that it would otherwise ignore.

## A note on ripgrep

fd shares some code with [ripgrep](https://github.com/BurntSushi/ripgrep/). fd
is designed to search for files by name, while ripgrep is an alternative to
`grep`, [ag](https://github.com/ggreer/the_silver_searcher), and
[ack](https://beyondgrep.com/), i.e. it's designed to search the _contents_ of
files. 

But ripgrep _can_ be used to search for files by name rather than contents. So
if for some reason you don't want to use fd with fzf [it is
possible](http://owen.cymru/fzf-ripgrep-navigate-with-bash-faster-than-ever-before/)
to do much of what fd does above with ripgrep.

One note: ripgrep doesn't handle producing a list of directories well, so
you'll end up using a different tool for `FZF_ALT_C_COMMAND`, or with something
like [`FZF_ALT_C_COMMAND="rg --sort-files --files --null 2> /dev/null | xargs
-0 dirname | uniq"`](https://github.com/BurntSushi/ripgrep/issues/388).
