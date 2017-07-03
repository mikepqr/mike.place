+++
Description = "The background to my O'Reilly series on probabilistic programming from scratch"
date = "2017-07-02T23:22:10-07:00"
menu = ""
title = "Probabilistic programming from scratch"
thumbnail = "post/ppscratch/compareposteriors.png"
+++

O'Reilly just published a series of Orioles (interactive video tutorials) by me
about probabilistic programming in Python. You can read [the
highlights](https://www.oreilly.com/learning/probabilistic-programming-from-scratch)
for free. A Safari login is required for [the
Orioles](https://www.safaribooksonline.com/search/?query=%22Probabilistic%20Programming%20from%20Scratch%22&extended_publisher_data=true&highlight=true&is_academic_institution_account=false&source=user&include_assessments=false&include_courses=true&include_orioles=true&include_playlists=true&publishers=O%27Reilly%20Media%2C%20Inc.&field=title&sort=relevance&utm_source=oreilly&utm_medium=newsite&utm_campaign=probabilistic-programming-from-scratch-top-cta-orioles-link)
themselves.

## The approach: from scratch, by simulation

My goal in the series is that you understand every line of code. I attempt to
ensure this by implementing things from scratch, and choosing a Bayesian
inference algorithm that is particularly transparent and non-mathematical.

![Posterior comparison](/post/ppscratch/compareposteriors.png)

The "from scratch" approach means I don't import any libraries. This was
inspired by Joel Grus's great book [Data Science from
Scratch](https://github.com/joelgrus/data-science-from-scratch), which uses
core data structures (lists, dictionaries, etc.) to implement fairly
sophisticated algorithms such as Naive Bayes and feed-forward neural networks.

The series also draws from Jake VanderPlas's PyCon talk [Statistics for
Hackers](https://www.youtube.com/watch?v=Iq9DzN6mvYA). In that talk, Jake shows
that, by taking advantage of the fact that computers can repeat things very
quickly, it's often simplest to _simulate_ your way to the answer to a
statistical question. With this approach, you avoid the need to memorize a zoo
of frequentist statistical tests of dubious applicability. Peter Norvig took a
similar approach in his beautiful notebooks on Probability ([A Concrete
Introduction](http://nbviewer.jupyter.org/url/norvig.com/ipython/Probability.ipynb)
and [Probability, Paradox and the Reasonable Person
Principle](http://nbviewer.jupyter.org/url/norvig.com/ipython/ProbabilityParadox.ipynb)).

If you have a non-mathematical programming background, or your calculus is a
little rusty, or you're the kind of person who likes to compose together simple
well-understood tools to answer complex questions, you might like this
approach.

## Approximate Bayesian Computation

In real world problems, with lots of data, and lots of unknown parameters, and
hierarchical structure, inference problems are often solved with industrial
strength probabilistic programming systems such as
[PyMC3](https://github.com/pymc-devs/pymc3) or [Stan](http://mc-stan.org/).
These systems embed well-tested and extremely fast implementations of
algorithms such as [Hamiltonian Monte Carlo](https://arxiv.org/abs/1701.02434)
with the [No U-Turn Sampler](https://arxiv.org/abs/1111.4246), or [Automatic
Differentiation Variational Inference](https://arxiv.org/abs/1603.00788). These
algorithms are great, but they require a deep mathematical background to truly
understand.

Instead I use Approximate Bayesian Computation. ABC may note be the fastest,
but it's not wrong, and if you can wait long enough, it always works. And
crucially, given my goal that you understand every line of code, it's a great
example of the "simulate your way to the answer" approach that relies on the
computer's ability to repeat calculations.

Here's the entire Approximate Bayesian Computation algorithm:

 1. Draw a sample from prior
 2. Simulate the process you observed assuming the sample from the prior is the
    correct value
 3. If the outcome of simulation matches the data you observed, the sample from
    prior is now a sample from posterior
 4. Repeat 1-3 until you have enough samples from the posterior to answer a
    concrete statistical question.
 
In Python, that looks like this:

```python
def posterior_sampler(data, prior_sampler, simulate):
    for p in prior_sampler:
        if simulate(p) == data:
            yield p
```

It's up to the user of this function to write `prior_sampler` (a generator that
yields samples from the prior) and `simulate` (a function that simulates the
process you observed).

But otherwise, that's it. Short and sweet!

If you don't know what the prior or posterior are, read the [highlights article
on the O'Reilly
website](https://www.oreilly.com/learning/probabilistic-programming-from-scratch).

And if you have a Safari login and want to see this algorithm used to solve
real problems (including online learning), the connection with Bayes's Theorem
made more explicit, and comparison to PyMC3, check out [the
Orioles](https://www.safaribooksonline.com/search/?query=%22Probabilistic%20Programming%20from%20Scratch%22&extended_publisher_data=true&highlight=true&is_academic_institution_account=false&source=user&include_assessments=false&include_courses=true&include_orioles=true&include_playlists=true&publishers=O%27Reilly%20Media%2C%20Inc.&field=title&sort=relevance&utm_source=oreilly&utm_medium=newsite&utm_campaign=probabilistic-programming-from-scratch-top-cta-orioles-link).
