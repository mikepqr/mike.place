+++
Description = ""
date = "2016-09-25T20:06:59-04:00"
menu = ""
title = "Text summarization, topic models and RNNs"
slug = "summarization"

+++

I've recently given a couple of talks ([PyGotham
video](https://youtu.be/y7XoypvQRhY), [PyGotham
slides](http://mike.place/talks/pygotham/#p1), [Strata NYC
slides](http://mike.place/talks/strata_nyc_2016)) about text summarization.
 
I cover three ways of automatically summarizing text. One is an extremely
simple algorithm from the 1950s, one uses Latent Dirichlet Allocation, and one
uses skipthoughts and recurrent neural networks.

The talk is conceptual, and avoids code and mathematics. So here is a list of
resources if you're interested in text summarization and want to dive deeper. 

This list useful is hopefully also useful if you're interested in topic
modelling or neural networks for other reasons.

## Topic modelling

Now LDA is available in scikit-learn, it's tempting to skip the mathematics of
topic modelling entirely. But don't. At least cover these two resources.

 - Tim Hopper's talk at PyData NYC 2015 ([video](https://youtu.be/_R66X_udxZQ),
   [notebook](http://github.com/tdhopper/pydata-nyc-2015)) is an extremely clear
   introduction to the generative process LDA assumes
 - [*Probabilistic Topic
   Models*](https://www.cs.princeton.edu/~blei/papers/Blei2012.pdf) by David
   Blei is a technical introductory review of topic modelling. The closing
   sections on future research are particularly good.

## Neural networks

If you Google "neural networks" or, god forbid, "deep learning", you will be
overwhelmed with a torrent of bullshit. The first four things on this list
make a great introductory reading/watching list. They're hype-free and
they're by technical people who know what they're talking about. If you cover
those four, you'll be well placed.

 - [*Deep Learning*](http://go.nature.com/7cjbaa) by LeCun et al. is a good
   introductory review to the subject. It's a _Nature_ review, which is not
   usually a good thing, but in this case they use the format well and cover a
   lot of ground.
 - [Chris Olah's articles](http://colah.github.io/) are exceptionally clear
   introductions to some of the trickiest and most important concepts,
   including [word
   embeddings](http://colah.github.io/posts/2014-07-NLP-RNNs-Representations/)
   and [recurrent neural
   networks](http://colah.github.io/posts/2015-08-Understanding-LSTMs/). But
   if you're new to neural networks and interested in the fundamentals, start
   with [the post on
   backpropagation](http://colah.github.io/posts/2015-08-Backprop/).
 - For an elementary computational introduction to neural networks, I cannot
   recommend [Andrew Ng's Coursera course on machine
   learning](https://www.coursera.org/learn/machine-learning) highly enough.
   The middle couple of lectures cover neural nets, so you have to go through a
   couple of weeks of preliminaries to get to the good stuff, and the homeworks
   are in Matlab, so it certainly has its downsides. Despite that, it's the
   clearest, most engaging presentation of the basics I've seen.
 - [Chapters 1-3 of Michael Nielsen's
   textbook](http://neuralnetworksanddeeplearning.com/), are a comprehensive
   treatment of the basic maths of backpropagation, the algorithm used to train
   neural networks. I think it's a great book. But fair warning: Nielsen is a
   physicist, and it shows in his notation, which is that identifiably physics
   mixture of pedantic, inconsisent and verbose. As a physicist I have a strong
   stomach for that, but it may not be everyone's cup of tea.
 - Keras is a high level library for building and training neural nets. I wrote
   [a tutorial introducing it](http://mike.place/2016/keras-oriole/). If you're
   coming a neural networks with an understanding of scikit-learn, that might
   be a good place to start.
 - And if you want to go deep on the application of neural networks to natural
   language then I cannot recommend highly enough [*A Primer on Neural Network
   Models for Natural Language
   Processing*](http://u.cs.biu.ac.il/~yogo/nnlp.pdf) by Yoav Goldberg. This is
   more advanced material than the other five resources. Save it for last.
