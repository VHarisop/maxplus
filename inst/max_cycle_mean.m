function lambda = max_cycle_mean(M)
	## MAX_CYCLE_MEAN calculates the max cycle mean of a square matrix M in the
	## max-plus semiring. It uses the naive way, calculating all powers of M up
	## to N.
	##
	## Usage:
	## 		lambda = max_cycle_mean(M);
	##

	[dim_x, dim_y] = size(M);
	if (dim_x ~= dim_y)
		error("Maximum cycle mean is not defined for non-square matrices!");
	endif

	if ~isa(M, "maxplus")
		M = maxplus(M);
	endif

	current_mat = M;
	lambda = diagonal_max(M);
	for i = 2:dim_x
		current_mat = current_mat * M;
		lambda = max(diagonal_max(current_mat) / i, lambda);
	endfor
endfunction

function res = diagonal_max(A)
	## Finds the maximum element on the diagonal of a max-plus matrix.
	res = max(diag(A.mat));
endfunction
		


