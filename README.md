# maxplus
An Octave toolbox for performing common tasks in [max-plus algebra][maxpluswiki].

## Creating matrices and vectors in the max-plus semiring
A constructor for max-plus matrices is available. To create a new matrix/vector
simply invoke:

```octave
mp_x = maxplus(x);
```

where `x` is any vector, matrix or scalar. For example:

```octave
octave:1> mp_x = maxplus(1)
Max-Plus matrix:

 1

octave:2> mp_y = maxplus([1 0; -1 4])
Max-Plus matrix:

   1   0
  -1   4

octave:3> mp_z = maxplus([1 2 3 4]')
Max-Plus matrix:

   1
   2
   3
   4
```

## Addition and multiplication in the max-plus semiring
When dealing with operations in the max-plus semiring, the notions of "addition"
and "multiplication" are counter-intuitive. In max-algebra, the binary
operation of addition, "+", is replaced by "max". In a similar manner, the
operation of multiplication, "\*", is replaced by "+". Therefore, in max-plus
notation:

```
1 + 2 = max(1, 2) = 2
1 * 2 = 1 + 2 = 3
```

Matrix addition is defined as taking the maximum element-wise and
multiplication is the same as in linear algebra after replacing "\*" with "+"
and taking the maximum over row - column element combinations instead of
adding the products.

In the max-plus semiring, the identity elements for "addition" and "multiplication"
are negative infinity for the former and 0 for the latter.

## Overloaded operators in the `maxplus` package
A set of standard Octave operators have been overloaded so far with common
operations from max algebra. Those are:

* plus - overloaded for scalar / matrix addition
* mtimes - overloaded for scalar / matrix multiplication
* mpower - scalar / matrix powers using the max-plus interpretation of
  multiplication
* uminus - negation, equivalent to `-X`
* uplus - unary plus, equivalent to `+X`
* transpose - the transpose of a matrix, which is the same as in linear algebra
* ctranspose - the conjugate transpose, which is defined as the negative
  transpose

To use the overloaded operators, simply make sure that you are applying them to
objects that have been created with the `maxplus()` constructor. For example:

```octave
octave:1> mp_A = maxplus([1 0; -1 0]);
octave:2> mp_v = maxplus([1 2]');
octave:3> mp_A * mp_v
Max-Plus matrix:

   2
   2
octave:4> mp_A ^ 2
Max-Plus matrix:

   4   3
   2   1
octave:5> ...
```

### Arithmetic and logical indexing
Starting with v0.2.1, indexing using arithmetic, slicing and conditional
expressions is partially supported. For example:

```octave
octave:1> mp_A = maxplus([-1 0 5; 9 0 -1; -1 0 2]);
octave:2> mp_A(mp_A == 0) = -Inf;
octave:3> mp_A
Max-Plus matrix:

   -1    -Inf     5
    9    -Inf    -1
   -1    -Inf     2   
```

## Max-algebraic methods
Common methods and procedures from max-algebra are intended to be implemented
as functions. This is what the package has to offer so far:

* `principal_solution`: Finds the principal solution of a one-sided system.
* `max_cycle_mean`: Computes the maximum cycle mean of a matrix.
* `weak_tran_closure`: Computes the weak transitive closure of a matrix,
  if any, setting a flag if a positive cycle exists.
* `strong_tran_closure`: Like the above, but computes the strong transitive
  closure instead.
* `chebyshev`: Computes the chebyshev distance between two max-algebraic
  matrices or vectors.

Some of the above might work without passing a matrix explicitly created by
the `maxplus` constructor, but you should not rely on that.

## Installing the package
You will need to clone this repo and create a gzipped package from source.

```bash
git clone https://github.com/VHarisop/maxplus.git && \
	tar -cvzf maxplus.tgz maxplus/
```

Alternatively, you can look under [releases][releases], although these will
probably be far from the latest builds.

Then just install the package in Octave like you would normally do:
```octave
octave:1> pkg install maxplus.tgz
octave:2> pkg load maxplus
```

If you want the `maxplus` package to be autoloaded when opening Octave,
add an entry to your `.octaverc`:

```
pkg load maxplus
```

[maxpluswiki]: https://en.wikipedia.org/wiki/Max-plus_algebra
[releases]: https://github.com/VHarisop/maxplus/releases
