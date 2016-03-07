# maxplus
An Octave toolbox for performing common tasks in max algebra.

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


