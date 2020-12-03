---
title: "resume.md: a Markdown resume"
date: 2020-07-25T21:50:13-07:00
slug: resume.md
thumbnail: post/resume.md/resume.png
description: "resume.md: write your resume in Markdown, style it with CSS, output to HTML and PDF."
---

I just put [resume.md on GitHub](https://github.com/mikepqr/resume.md). It's
a Makefile and some CSS that builds a HTML and PDF version of a resume from
plain Markdown source.

Plain text source has all the usual benefits (plays nice with version control,
diff, grep, etc.), but this approach has the additional advantage that it has
very light dependencies: two pure Python packages that can be pip installed
([python-markdown](https://python-markdown.github.io/) and
[weasyprint](https://weasyprint.org/)). You don't need pandoc or LaTeX.

To use it: clone the repository, install the dependencies, edit the
file
[resume.md](https://raw.githubusercontent.com/mikepqr/resume.md/main/resume.md)
(which is very simple vanilla Markdown), then run `make`. You'll get
a HTML file that looks like this ![Screenshot of
resume.html](/post/resume.md/resume.png)
and a [PDF that looks very
similar](https://raw.githubusercontent.com/mikepqr/resume.md/main/resume.pdf).
Edit the CSS to change fonts, spacing, layout, etc. See [the README for
more](https://github.com/mikepqr/resume.md).
