function [X1, X2, X3] = calc_slices(A, B, C)
	## CALC_SLICES calculates 3rd-order tensor slices given a decomposition
	## The matrices A, B, C that make up the decomposition must have the
	## same 2nd dimension, R.
	##
	## Usage:
	##		[X1, X2, X3] = slices(A, B, C);
	[~, sza] = size(A);
	[~, szb] = size(B);
	[~, szc] = size(C);

	# Make sure the inner dimensions of the matrices
	# are equal
	if any([sza, szb, szc] ~= sza)
		error("[A], [B], [C] must have the same 2nd dimension");
	endif

	# Compute the 3 slices
	X1 = A * (khatri_rao(C, B).');
	X2 = B * (khatri_rao(C, A).');
	X3 = C * (khatri_rao(B, A).');
endfunction
