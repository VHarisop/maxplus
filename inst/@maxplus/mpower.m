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
		# find the maximum exponent, q, for which 2^q < s
		inf_exponent = floor(log2(s));
		R = maxplus(MA);
		for i = 1:inf_exponent
			# calculate R^2 in max-plus terms
			R = mtimes(R, R);
		endfor
		# calculate the remaining powers by stepping
		for i = 1: (s - (2 ^ inf_exponent))
			R = mtimes(R, A);
		endfor
	endif
