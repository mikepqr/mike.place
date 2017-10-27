+++
Description = ""
date = "2017-08-06T22:50:11-07:00"
menu = ""
title = "Setting up Python on a Unix machine (with pyenv and direnv)"
slug = "python-pyenv"

+++

This post is about how to set up multiple Python _versions_ and _environments_
on a development machine (and why I don't use conda).

If you need only a single version each of Python 2 and Python 3 then this
approach may be overkill, even if you're planning to make lots of virtual
environments. In that situation, a [simpler setup with a couple of shell
aliases](https://mike.place/2017/python/) will do, although you might be
interested in
[direnv](#use-direnv-to-manage-virtualenv-creation-and-activation), which you
can use to activate and deactivate virtual environments automatically.

And if you're comfortable working in containers (or other quickly
created/destroyed virtual machines) all the time, you can skip all this
entirely.

But the approach described below works well for me on a single Unix machine.

## Install pyenv

[pyenv](https://github.com/pyenv/pyenv) allows you to compile and work with
multiple versions of Python on a single machine.

Note: pyenv is a tool for managing multiple versions of Python _interpreters_.
`pyvenv` (note the extra `v`) is a (now-deprecated) command line tool
distributed with Python to create _virtual environments_. It is effectively a
shell alias for `python -m venv`)

On macOS you can install pyenv with

    brew install pyenv

but a git clone will work on all systems

    git clone https://github.com/pyenv/pyenv.git ~/.pyenv

Then add the following command to your shell startup to add pyenv's
functionality to your shell.

    eval "$(pyenv init -)"

Note: if you cloned pyenv into a path that is not in your shell `$PATH`, you'll
need to add it, e.g.

    export PATH=~/.pyenv/bin:$PATH

## Install a C compiler and libraries

pyenv _compiles_ python, which means you need a C compiler and various
libraries. You may already have them, but if not, on macOS, do

    xcode-select --install

On Ubuntu do

    sudo apt-get install -y \
        make \
        build-essential \
        libssl-dev \
        zlib1g-dev \
        libbz2-dev \
        libreadline-dev \
        libsqlite3-dev \
        wget \
        curl \
        llvm \
        libncurses5-dev \
        libncursesw5-dev \
        xz-utils \
        tk-dev

## Use pyenv to install some python versions

You're now ready to install Python versions. e.g.

    pyenv install 2.7.13
    pyenv install 3.5.3  
    pyenv install 3.6.2

These install the official python.org builds of the corresponding version. You
can get a full list of the versions pyenv knows how to install by running

    pyenv install --list

## Set pyenv preferences 

Very occasionally, you may find yourself working outside a virtual environment.
In that case you can interact with pyenv directly to choose which version you
want to use.

This command sets the pyenv version that will be used by default if you type
`python`

    pyenv global 3.6.1

To override the global setting automatically when you enter a specific
directory do, e.g.

    cd ~/oldpython2project
    pyenv local 2.7.13

To override the global preference for a single shell session do

    pyenv shell 3.5.3

## Set up virtual environments

Generally speaking, except when a new Python version is released, you should be
directly using pyenv very rarely.

Instead you should be creating (and destroying) virtual environments.

To work in this way, first make sure the packaging basics are up to date for
each pyenv version you've installed:

    for v in $(pyenv versions --bare) ; do
        pyenv shell $v 
        pyenv which python
        python -m pip install --upgrade pip virtualenv wheel
    done

Then create a file `~/.pip/pip.conf` containing

    [global]
    require-virtualenv = true

This ensures that you don't accidentally `pip install` anything outside a
virtual environment.

Now, create a virtual environment. First temporarily activate the pyenv version
corresponding to the Python interpreter you want to use for this virtual env,
then create the environment itself

    pyenv shell 3.6.1
    python -m venv path/to/virtual/environment

## Use direnv to manage virtualenv creation and activation

I use [direnv](https://github.com/direnv/direnv) to manage the creation,
activation and deactivation of virtual environments.

First, install direnv and add it to your shell. If you're using bash on macOS,
that might look like this

    brew install direnv
    echo 'eval "$(direnv hook bash)"' >> ~/.bashrc

Then you need to tell direnv about pyenv by putting this in `~/.direnvrc`

    use_python() {
        local python_root=$HOME/.pyenv/versions/$1
        load_prefix "$python_root"
        layout_python "$python_root/bin/python"
    }

Now you're all set. For example, if you create a file `~/project/.envrc` that
says simply

    use python 3.6.1

the first time you `cd` into `~/project` you will be prompted to type `direnv
allow` (a security feature) then direnv will create and activate a virtual
environment using the interpreter version specified in `.envrc`.

Going forward, direnv will automatically activate this environment when you enter
the project directory, and deactivate it when you leave.

If you use tmux, [alias the `tmux`
command](https://github.com/direnv/direnv/wiki/Tmux) so the clever things tmux
and direnv both do to your environment don't conflict. E.g. on bash

    alias tmux="direnv exec / tmux"

## Environment variables with direnv

You can also use direnv to set and unset environment variables on entering and
exiting a directory. You can either put these variables directly in
`~/project/.envrc`

    export $PROJECT_ENV_VARIABLE=foo

or, if they are defined in another file, add 

    dotenv environment-variables

to `~/.project/.envrc`.

## Why not use conda?

Conda allows you to specify not only the packages associated with a project (as
`requirements.txt` does), but also the Python interpreter version. In that
sense, it's more powerful system than virtual environments. And it can make
life easier is you're stuck in Windows and need compiled libraries such as
numpy or dask.

So why go to all the trouble above? Why not just use conda?

YMMV. I know a lot of very happy and very sophisticated conda users in the data
science community. But here's my take.

The goal when defining an environment is to share it with other users or other
systems. "Other users" might be future you, or it might be a data scientist, a
person in the audience of a talk, a software engineer, or a devops engineer.
"Other systems" might be a continuous integration server, a container, a
serverless application platform, or a production server.

Simply put, for my definition of "other users or systems", conda is a
non-standard tool, and using it creates social and pedagogical friction. It
wrote more about this in [a comment on Jake vanderPlas's
blog](http://jakevdp.github.io/blog/2016/08/25/conda-myths-and-misconceptions/#comment-2866310606).
The ability to specify the Python interpreter in the equivalent of
`requirements.txt` is not worth the friction.
