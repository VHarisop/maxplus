function sol = mp_principal_sol(A, b)
	## MP_SOLVE Calculates the principal solution to a one-sided
	## system in max-algebra.
	##
	## Usage: s = mp_principal_sol(A, b);
	##
	## The solution of a one-sided system,
	## 		A (o) x = b
	## in max algebra, is not guaranteed to exist. However, if a
	## solution exists, it is given by the principal solution
	##		x_optim = (-A') (o)' b
	## where (o)' is the dual operator of (o). With (o)', the
	## minimum replaces the maximum and addition is retained.

	sol = min(-A' + b, [], 2);
endfunction
