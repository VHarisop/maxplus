function R = ge(A, B)
	## GE overloads the '>=' operator for maxplus objects.
	## Usage:
	## 		R = ge(A, B);
	##		R = A >= B;
	if isa(A, 'maxplus')
		A = A.mat;
	endif
	if isa(B, 'maxplus')
		B = B.mat;
	endif
	R = A >= B;
endfunction
