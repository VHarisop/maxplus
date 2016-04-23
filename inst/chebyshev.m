function d = chebyshev(X, Y, dim)
	## CHEBYSHEV computes the chebyshev distance between 2 max-plus matrices.
	## Equivalent to max(abs(X - Y), [], dim).
	## 
	## Usage: 
	##		dists = chebyshev(X, Y)
	##		dists = chebyshev(X, Y, dim)
	##
	## Default parameter for dim is 1, therefore max() is across columns.
	## Note that the result is an ordinary matrix or vector.
	if (nargin < 3)
		dim = 1;
	endif

	# If X is of max-plus type, get its matrix field.
	if isa(X, 'maxplus')
		MX = X.mat;
	else
		MX = X;
	endif

	# If Y is of max-plus type, get its matrix field.
	if isa(Y, 'maxplus')
		MY = Y.mat;
	else
		MY = Y;
	endif

	# Calculate maximum absolute difference along specified dimension.
	d = max(abs(MX - MY), [], dim);
endfunction
