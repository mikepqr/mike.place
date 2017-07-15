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
Match host server !exec "command_that_tests_connection"
	ProxyJump gateway.example.com

Host server
	Hostname server.example.com
```

The `ProxyJump` directive is applied if and only if you're connecting to `host
server` and `command_that_tests_connection` exits with non-zero status. In that
case you'll go via the gateway.

### My configuration

It's up to you to write `command_that_tests_connection`. What you need will
depend on the circumstances in which your server is inaccessible. You want a
command that fails (ideally quickly) when the server is not directly
accessible.

This command works for me. It exits with non-zero status if the host doesn't
respond to a ping command within one second. 

```bash
#!/bin/sh
ping -t 1 -o "${1}"
```

I save this as `local-accessible` in my path. Then I can do

```bash
# at home
$ local-accessible server.example.com &>/dev/null && echo "OK" || echo "FAIL"
OK
```
and
```bash
# elsewhere
$ local-accessible server.example.com &>/dev/null && echo "OK" || echo "FAIL"
FAIL
```

`~/.ssh/config` then looks like this:

```
Match host server !exec "local-accessible server.example.com &>/dev/null"
    ProxyJump gateway.example.com

Host server
    Hostname server.example.com
```

With this setup, when I run `ssh server`, I connect directly and almost
instantaneously at home, and via the gateway with a one second overhead
elsewhere.

### Debugging

If you run into problems, first check that your version of `local-accessible`
behaves as expected by running it manually and testing the exit code, e.g.

```
$ local-accessible server.example.com &>/dev/null && echo "OK" || echo "FAIL"
```

If all looks well, you can examine the logic of the `Match` conditions by
connecting with `ssh -vvv server`. Pay particular attention to the `debug3`
lines near the top of the output.

[^1]: The [`ProxyJump` option was introduced in OpenSSH 7.3](http://lists.mindrot.org/pipermail/openssh-commits/2016-July/005433.html). It simplifies connecting via a gateway by replacing `ProxyCommand ssh -W %h:%p gateway.example.com` or something involving `nc`.
