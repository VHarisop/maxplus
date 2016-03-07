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

	## Make sure that matrix sizes are compatible in order
	## to perform matrix multiplication
	if (bx != ay)
		error("Matrix sizes are incompatible!");
	endif

	R = zeros(ax, by);
	## max-plus matrix multiplication is performed by taking the maximum
	## over every (matrix row + vector_column)
	for i = 1:by
		R(:, i) = max(MA + MB(:, i)', [], 2);
	endfor

	R = maxplus(R);
endfunction
