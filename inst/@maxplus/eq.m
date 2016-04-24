function R = eq(A, B)
	## EQ overloads equality for maxplus objects
	if isa(A, 'maxplus')
		A = A.mat;
	endif
	if isa(B, 'maxplus')
		B = B.mat;
	endif
	R = (A == B);
endfunction
