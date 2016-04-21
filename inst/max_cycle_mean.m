function lambda = max_cycle_mean(M)
	## MAX_CYCLE_MEAN calculates the max cycle mean of a square matrix M in the
	## max-plus semiring. It uses the naive way, calculating all powers of M up
	## to N.
	##
	## Usage:
	## 		lambda = max_cycle_mean(M);
	##
	if ~isa(M, "maxplus")
		M = maxplus(M);
	endif

	[dim_x, dim_y] = size(M);
	if (dim_x ~= dim_y)
		error("Maximum cycle mean is not defined for non-square matrices!");
	endif

	diag_max = @(X) max(diag(X.mat));

	current_mat = M;
	lambda = diag_max(M);
	for i = 2:dim_x
		current_mat = current_mat * M;
		lambda = max(diag_max(current_mat) / i, lambda);
	endfor
endfunction
