function R = mp_times (A, B)
	## MP_TIMES Performs matrix 'multiplication' in max-plus algebra.
	## 
	## Usage: R = mp_times(A, B);
	##
	## Here, A is assumed to be a matrix (or vector) of size n x k and B
	## a matrix (or vector) of size m x k. The resulting matrix is of
	## size m x n.

	[bx, by] = size(B);
	[ax, ay] = size(A);

	## Make sure that matrix sizes are compatible in order
	## to perform matrix multiplication
	assert(by == ay, "Matrix sizes are incompatible!");

	R = zeros(bx, ax);
	## max-plus matrix multiplication is performed by taking the maximum
	## over every (matrix row + vector_column)
	for i = 1:bx
		R(i, :) = max(A + B(i, :), [], 2);
	endfor
endfunction
