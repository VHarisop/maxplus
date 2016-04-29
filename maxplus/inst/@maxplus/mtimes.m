function R = mtimes(A, B)
	## MTIMES implements matrix multiplication in the max-plus semiring.
	## Usage:
	## 		C = A * B;
	## 		C = mtimes(A, B);
	## 		
	## If C = A x B then
	## 		c_{ij} = max_{all k} { a_{ik} + b_{kj} }
	##

	MA = A.mat; MB = B.mat;
	[bx, by] = size(MB);
	[ax, ay] = size(MA);

	# if any of the elements is a scalar, add to every element of the matrix
	if (bx == 1 && by == 1) || (ax == 1 && ay == 1)
		R = MA + MB;
	elseif (bx != ay)
		# Make sure that matrix sizes are compatible in order
		# to perform row-column matrix multiplication
		error('Matrix sizes are incompatible!');
	else
		R = zeros(ax, by);
		# max-plus matrix multiplication is performed by taking the maximum
		# over every (matrix row + vector_column)
		for i = 1:by
			R(:, i) = max(MA + MB(:, i)', [], 2);
		endfor
	endif
	# cast result to max-plus type matrix
	R = maxplus(R);
endfunction
