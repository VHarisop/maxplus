function R = le(A, B)
	## LE overloads the '<=' operator for maxplus objects.
	## Usage:
	## 		R = le(A, B);
	##		R = A <= B;
	if isa(A, 'maxplus')
		A = A.mat;
	endif
	if isa(B, 'maxplus')
		B = B.mat;
	endif
	R = A <= B;
endfunction
