+++
date = "2017-01-19T22:33:07-05:00"
title = "Setting up Python for development on a new Unix machine"
menu = ""
Description = ""
slug = "python"

+++

As of January 2017, this is how I set up Python on a new Unix/macOS machine. I
have much of this in a single script, but I'm going to break it down
line-by-line here. You don't need to sudo or run any of this as root. All of it
can be easily undone. Just delete the virtual environment that ails you (or
`~/.virtualenvs` if you want to start completely from scratch).

## macOS-only prerequsite

Install homebrew and use it to install isolated, up-to-date versions of Python
and legacy Python 2.
```bash
brew install python python3
```

Optionally (and this is not Python related), update git and install some
goodies:
```bash
brew install git bash
brew cask install macvim
sudo chsh -s /usr/local/bin/bash $USER
```

## All systems

Bootstrap pip:
```bash
python -m ensurepip --user
python3 -m ensurepip --user
```

This will result in an error on Debian/Ubuntu systems, but won't do any harm.

Then install/update the [Python packaging
basics](https://glyph.twistedmatrix.com/2016/08/python-packaging.html) in your
"global" Pythons. These global Pythons will be the system versions on a Linux
system, or the homebrew versions on macOS (assuming you've installed homebrew
as described above):
```bash
python -m pip install --user --upgrade pip virtualenv wheel
python3 -m pip install --user --upgrade pip virtualenv wheel
```

Now, never touch the global Python's again, or at least never install any
packages in them. You can make sure of this by configuring pip to refuse to
install anything outside a virtualenv:

```bash
mkdir ~/.pip
cat > ~/.pip/pip.conf <<END
[global]
require-virtualenv = true
END
```

Set up lightweight commands to create and change environments by putting this
in your shell startup:

```bash
workon () {
    if [ -f "${HOME}/.virtualenvs/$1/bin/activate" ]; then
        source "${HOME}/.virtualenvs/$1/bin/activate"
    fi
}
mkvirtualenv () {
    deactivate 2> /dev/null || true
    python3 -m virtualenv ${HOME}/.virtualenvs/${1}
    workon ${1}
}
mkvirtualenv_legacy () {
    deactivate 2> /dev/null || true
    python2 -m virtualenv ${HOME}/.virtualenvs/${1}
    workon ${1}
}
```

These commands are inspired by
[virtualenvwrapper](http://virtualenvwrapper.readthedocs.io/en/latest/) which
is overkill for me, but a great option if you want a more complete
project/virtualenv manager.

Now create a directory for your virtualenvs to live in, a `default` virtualenv
for day-to-day work, and a `legacy` Python 2 virtualenv. 

```bash
mkdir -p ~/.virtualenvs
mkvirtualenv default
mkvirtualenv_legacy legacy
```

If you prefer to put virtual environments in the same directory as the
corresponding project or application, then change the shell function above or
just create each project by hand:

```bash
cd my_project
python3 -m virtualenv venv
```

You can use the `workon` function to activate a particular environment, as long
as it lives in `~/.virtualenvs`:

```bash
workon default
```

I have `workon default` in my shell startup.

A fresh install of macOS will add the name of the active virtual environment to
your bash prompt. This is not necessary, but is nice to have. If you want it
and your system doesn't, or you have specific requirements, then there are lots
of options including, e.g. [my
dotfiles](https://github.com/williamsmj/dotfiles/blob/874fbf15a459d1464ae60876014b0d14f413b8b1/bash/.bashrc#L72-L150),
which I pinched from
[StackOverflow](http://stackoverflow.com/a/23410110/409879).

I use my `default` environment for quick tests and day-to-day coding not
associated with a particular project. For that work, at a minimum, I need a few
basics:

```bash
workon default
pip install numpy scipy jupyter sklearn pandas matplotlib seaborn pytest
```

## Optional extra: autoenv

Install [autoenv](https://github.com/kennethreitz/autoenv) to run a set of
commands every time you change into a directory. These commands are shell
commands contained in a file `.env` in that directory. I use them to ensure the
appropriate virtual environment is activated, and any necessary environment
variables are set (which I use a lot, per [12
Factor](https://12factor.net/config)).

```bash
brew install autoenv  # or whatever for your system
mkdir ~/my_project/
echo source ~/.virtualenvs/my_project/bin/activate" >> ~/my_project/.env
cd ~/my_project
```

The `my_project` environment is now automatically enabled when I `cd` into
`~/my_project`.

## Optional extra: pipsi

Install [pipsi](https://github.com/mitsuhiko/pipsi) and use it to install
Python-based command line tools so they are accessible from any environment and
you don't have to install them in every one. First add `~/.local/bin` to your
path then

```bash
curl https://raw.githubusercontent.com/mitsuhiko/pipsi/master/get-pipsi.py | python
pipsi install flake8
pipsi install httpie
pipsi install magic-wormhole
```
