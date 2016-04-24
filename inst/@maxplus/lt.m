function R = lt(A, B)
	## LT overloads the '<' operator for maxplus objects.
	## Usage:
	## 		R = lt(A, B);
	##		R = A < B;
	if isa(A, 'maxplus')
		A = A.mat;
	endif
	if isa(B, 'maxplus')
		B = B.mat;
	endif
	R = A < B;
endfunction
