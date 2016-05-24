function R = khatri_rao(A, B)
	## KHATRI_RAO computes the max-algebraic Khatri-Rao product of 2 matrices
	## Matrices A and B must share second dimension, as the Khatri Rao
	## product is defined as the per-column outer product of A and B.
	##
	## Usage:
	## 		R = khatri_rao(A, B);
	##
	## If A has size NxK and B has size MxK, R has size (NM)xK.
	[n, sza] = size(A);
	[m, szb] = size(B);

	if sza ~= szb
		error("[A] and [B] must have the same 2nd dimension");
	endif

	# Preallocate resulting matrix
	R = maxplus(zeros(n * m, sza));

	# Compute the outer product that fills each column
	for i = 1:sza
		R(:, i) = (outer(A(:, i), B(:, i))).'(:);
	endfor
endfunction
