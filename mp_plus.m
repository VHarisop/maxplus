function R = mp_plus (A, B)
	## MP_PLUS performs 'addition' (conventional max) in max algebra.
	##
	## Usage: R = mp_plus(A, B);

	# if none of the arguments is a scalar, make sure
	# that the matrix sizes are compatible
	if !(all(size(A) == 1)) && !(all(size(B) == 1))
		assert(all(size(A) == size(B)), ...
			"Matrix sizes are incompatible");
	endif

	R = bsxfun(@max, A, B);
endfunction
