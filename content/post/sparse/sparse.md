+++
date = "2015-12-06T22:32:10-05:00"
menu = ""
title = "Empty rows in sparse arrays"
slug = "sparse"

+++

Here is an indexing trick I learned recently. It's not clever, but I'm putting
it here partly because I learned a little bit about sparse arrays, and partly
so I don't have to search for the solution again.

## Sparse arrays in the Python machine learning ecosystem

By default, scikit-learn's feature extraction functions return data in a sparse
array. This is actually good. If what you plan to do with the array is
sparse-friendly --- which is true of scikit-learn's own classifiers and
[lda](https://github.com/ariddell/lda) --- then you save a ton of memory by
keeping things sparse, and many common machine learning operations are faster
when data is represented this way.

But some libraries such as the neural network library [keras](http://keras.io/)
don't accept sparse arrays. This introduces another processing step (usually
the `.toarray()` method) to densify the array. 

Perhaps more seriously, you lose some of the numpy feature set when working
with sparse arrays. It was this problem that I ran into when I wanted to find
the empty rows of a Compressed Sparse Row (CSR) array.

## Finding the non-empty rows of a sparse array

Finding the non-empty rows of a regular dense array is a one-liner:

```python
>>> import numpy as np
>>> Y = np.array([[1, 2, 3],
...               [0, 0, 0],   # empty row
...               [4, 0, 5],
...               [0, 6, 7],
...               [0, 0, 0]])  # empty row
>>> Y.any(axis=1)
array([ True, False,  True,  True, False], dtype=bool)
```

But a CSR array doesn't have the `any` method:

```python
>>> from scipy.sparse import csr_matrix
>>> X = csr_matrix(Y)
>>> X
<5x3 sparse matrix of type '<class 'numpy.int64'>'
        with 7 stored elements in Compressed Sparse Row format>
>>> hasattr(X, 'any')
False
```

and `np.any` is apparently just the identity function when applied to a sparse
array:

```python
>>> np.any(X)
<5x3 sparse matrix of type '<class 'numpy.int64'>'
        with 7 stored elements in Compressed Sparse Row format>
>>> (np.any(X) != X).toarray()
array([[False, False, False],
       [False, False, False],
       [False, False, False],
       [False, False, False],
       [False, False, False]], dtype=bool)
```

So the dense `any()` approach doesn't work.

## The solution

Here's the solution:

```python
>>> np.diff(X.indptr) != 0
array([ True, False,  True,  True, False], dtype=bool)
```

You can stop reading here (or skip to the final section) if you don't care why
this works!

## The reason this works

To understand why this works, you have to understand a little bit about the
Compressed Sparse Row array representation used by scipy. 

The goal of a sparse representation it to consume less memory than the `nrows *
ncolumns * 4` bytes (for integer arrays) required by the dense representation.
To do this, the array stores the values of only its non-zero elements. If the
array is sparse, i.e. mostly zeros, then this is tremendous memory saving.

In scipy's CSR approach, the non-zero values are kept in the array's `data`
attribute:

```python
>>> X.toarray()
array([[1, 2, 3],
       [0, 0, 0],
       [4, 0, 5],
       [0, 6, 7],
       [0, 0, 0]])
>>> X.data
array([1, 2, 3, 4, 5, 6, 7])
```

Alongside `data`, the array must hold attribute(s) that determine where in the
array the values are. Perhaps the most obvious way to do this would be to have
arrays that give the coordinates of each non-zero value. In fact that is the
approach taken by
[COO](http://docs.scipy.org/doc/scipy/reference/generated/scipy.sparse.coo_matrix.html#scipy.sparse.coo_matrix).
But it turns out that, for normal machine learning problems, where rows
represent samples and columns represent features, and the likely operations on
the data are somewhat constrained, CSR is usually more efficient, if a little
harder to grok.

In CSR the array holds `indptr` and `indices` attributes. The `indptr`
attribute is an array of length `nrows + 1`. Each successive pair in `indptr`
tells scipy where to look in the `indices` array to find the columns it should
populate in that row, and where to look in `data` to find the values it should
put in those columns.

```python
>>> X.toarray()
array([[1, 2, 3],
       [0, 0, 0],
       [4, 0, 5],
       [0, 6, 7],
       [0, 0, 0]])
>>> X.data
array([1, 2, 3, 4, 5, 6, 7])
>>> X.indptr
array([0, 3, 3, 5, 7, 7], dtype=int32)
>>> X.indices
array([0, 1, 2, 0, 2, 1, 2], dtype=int32)
```

So, to populate the 0th row of `X`, you look at `X.indptr[0]` and
`X.indptr[1]`. In the example above, these are `0` and `3`. You then take the
slice `0:3` from `X.indices` to get the columns in the 0th row that should be
populated. In this case `X.indices[0:3] == [0, 1, 2]`, i.e. every element of
the 0th row has a value. Finally you put the contents of the slice
`X.data[0:3]` in those positions.

To populate the 1st row of `X`, you look at `X.indptr[1]` and `X.indptr[2]`,
which are `3` and `3`. The slice `[3:3]` is empty, so this row is empty too. 

To populate the 2nd row of `X`, you look at `X.indptr[2]` and `X.indptr[3]`,
which are `3` and `5`. `indices[3:5] == [0, 2]`, so those are the two columns
in the 2nd row we populate with `data[3:5]`

More generally and precisely, [quoting from the scipy
documentation](http://docs.scipy.org/doc/scipy/reference/generated/scipy.sparse.csr_matrix.html#scipy.sparse.csr_matrix):

> the column indices for row `i` are stored in `indices[indptr[i]:indptr[i+1]]`
> and their corresponding values are stored in `data[indptr[i]:indptr[i+1]]`

All this means that, if successive elements of `indptr` are identical, then
corresponding row is empty.

The last thing piece of the puzzle is the utility function `np.diff()` which
takes an array of length `n` and returns an array of length `n-1` whose values
are the differences between successive elements of the argument.

All of which is to say, if the ith element of this thing is `0`

```python
np.diff(X.indptr)
```

then the ith row of `X` is all zeros. 

Incidentally, this means that finding empty rows in a big CSR array is much
faster than in a dense array, since it's `O(nrows)` rather than `O(nrows *
ncolumns)`.

## Indexing regular Python sequences with numpy boolean arrays

One last thing. The output of this (and many other numpy operations) is a
boolean numpy array. This can be used to index a numpy array:

```python
>>> X.toarray()
array([[1, 2, 3],
       [0, 0, 0],
       [4, 0, 5],
       [0, 6, 7],
       [0, 0, 0]])
>>> X[np.diff(X.indptr) != 0].toarray()
array([[1, 2, 3],
       [4, 0, 5],
       [0, 6, 7]], dtype=int64)
```

But it can't be used to index an arbitrary Python sequence:

```python
>>> lst = list('abcde')
>>> lst[np.diff(X.indptr) != 0]
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
TypeError: only integer arrays with one element can be converted to an index
```

The solution is in the ever-useful `itertools` module. `compress` takes two
sequences, `seq` and `mask`. It returns an iterator that yields the values of
`seq` when the corresponding value of `mask` is truthy. Hence,

```python
>>> list(compress(lst, np.diff(X.indptr) != 0))
['a', 'c', 'd']
```
