function R = ne(A, B)
	## NEQ overloads equality for maxplus objects.
	##
	## Usage:
	##		R = neq(A, B);
	##		R = A ~= B;
	if isa(A, 'maxplus')
		A = A.mat;
	endif
	if isa(B, 'maxplus')
		B = B.mat;
	endif
	R = (A ~= B);
endfunction
