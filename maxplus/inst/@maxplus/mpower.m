function R = mpower(A, s)
	## MPOWER implements matrix exponentiation in the max-plus semiring.
	## Usage:
	##		C = A^n;
	##		C = mpower(A, n);
	##
	## MPOWER uses the repeated squaring algorithm.

	MA = A.mat;
	if all(size(MA) == 1)
		# in the case of a scalar, exponentiation in the max-plus semiring
		# is simply multiplication
		R = maxplus(MA * s);
	else
		# iterative version of exponentiation-by-squaring.
		R = maxplus(MA); R_aux = maxplus(0);
		while (s > 1)
			if (mod(s, 2) == 0)
				R = mtimes(R, R);
				s = s / 2;
			else
				R_aux = mtimes(R, R_aux);
				R = mtimes(R, R);
				s = (s - 1) / 2;
			endif
		endwhile
		R = mtimes(R, R_aux);
	endif
endfunction
