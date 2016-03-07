function S = mp_principal_sol(A, B)
	## MP_SOLVE Calculates the principal solution to a one-sided
	## system in max-algebra.
	##
	## Usage: S = mp_principal_sol(A, B);
	##
	## The solution of a one-sided system,
	## 		A (o) X = B
	## in max algebra, is not guaranteed to exist. However, if a
	## solution exists, it is given by the principal solution
	##		X_optim = (-A') (o)' B
	## where (o)' is the dual operator of (o). With (o)', the
	## minimum replaces the maximum and addition is retained.

	sz_a = size(A);
	sz_b = size(B);
	# size of A should be m x n, size of B should be m x k
	if (sz_a(1) != sz_b(1))
		error("Matrix sizes are incompatible!");
	end

	for i = 1:sz_b(2)
		S(:, i) = min(-A' + B(:, i)', [], 2);
	endfor
endfunction
