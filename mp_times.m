function R = mp_times (A, B)
	## MP_TIMES Performs matrix 'multiplication' in max-plus algebra.
	## Matrix multiplication is performed by summing each row with a
	## column, and taking the maximum value of that summation.
	##
	## In greater detail: C = A x B means that
	## 		c_{ij} = max_{1 .. K}{ a_{ik} + b_{kj} }
	## 
	## Usage: R = mp_times(A, B);
	##
	## Here, A is assumed to be a matrix (or vector) of size n x k and B
	## a matrix (or vector) of size k x m. The resulting matrix is of
	## size n x m.

	[bx, by] = size(B);
	[ax, ay] = size(A);

	## Make sure that matrix sizes are compatible in order
	## to perform matrix multiplication
	if (bx != ay)
		error("Matrix sizes are incompatible!");
	endif

	R = zeros(ax, by);
	## max-plus matrix multiplication is performed by taking the maximum
	## over every (matrix row + vector_column)
	for i = 1:by
		R(:, i) = max(A + B(:, i)', [], 2);
	endfor
endfunction
