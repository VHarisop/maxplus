function R = gt(A, B)
	## GT overloads the '>' operator for maxplus objects.
	## Usage:
	## 		R = gt(A, B);
	##		R = A > B;
	if isa(A, 'maxplus')
		A = A.mat;
	endif
	if isa(B, 'maxplus')
		B = B.mat;
	endif
	R = A > B;
endfunction
