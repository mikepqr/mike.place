+++
Description = ""
date = "2017-07-13T23:27:47-07:00"
menu = ""
title = "Tunneling an SSH connection only when necessary using Match"
slug = "ssh-match"

+++

If you have to connect via a gateway relay to a server when you're outside your
home network, you probably have a `~/.ssh/config` that looks something like
this:

```
Host server-remote
	Hostname server.example.com
	ProxyJump gateway.example.com

Host server
	Hostname server.example.com
```

With this setup, you run `ssh server` to connect directly at home, and `ssh
server-remote` to connect via the gateway elsewhere.[^1]

The direct connection is more quickly established, stable and faster. But if
you forget you're not at home and type `ssh server`, then you'll get an error
(possibly after a long delay, depending on the reason `server.example.com` is
not accessible).

### Conditional configuration of ssh with `Match`

Wouldn't it be nice to be able to type the same command, `ssh server`, wherever
you are, and have ssh connect via the gateway only if necessary and with
minimal delay? 

This is where the `Match` directive comes in. This allows you to conditionally
configure ssh by specifying a command whose output determines whether the rest
of the configuration block is used. Here's what it looks like.

```
Match host server exec "command_that_tests_connection"
	Hostname server.example.com

Host server
	Hostname server.example.com
	ProxyJump gateway.example.com
```

With this setup, if you run `ssh server` you'll connect to `server.example.com`
directly if `command_that_tests_connection` exits succesfully (with status
zero), and via the gateway otherwise.

### My configuration

It's up to you to write `command_that_tests_connection`. What you need will
depend on the circumstances in which your server is inaccessible. 

For me, this `Match` command that pings a server and times out after one second
works well:

```bash
#!/bin/sh
ping -t 1 -o "${1}"
```

I save this as `local-accessible` in my path. It exits with non-zero status if
the host doesn't respond to a ping command within one second. This may not be
what you need for your server, but it works for me:

```bash
$ local-accessible server.example.com &>/dev/null && echo "❌" || echo "✅"
❌
$ local-accessible gateway.example.com &>/dev/null && echo "❌" || echo "✅"
✅
```

`~/.ssh/config` then looks like this:

```
Match host server exec "local-accessible server.example.com &>/dev/null"
    Hostname server.example.com

Host server
    Hostname server.example.com
    ProxyJump gateway.example.com
```

With this setup, when I run `ssh server`, I connect directly and almost
instantaneously at home, and via the gateway with a one second overhead
elsewhere.

[^1]: The [`ProxyJump` option was introduced in OpenSSH 7.3](http://lists.mindrot.org/pipermail/openssh-commits/2016-July/005433.html). It simplifies connecting via a gateway by replacing `ProxyCommand ssh -W %h:%p gateway.example.com` or something involving `nc`.
