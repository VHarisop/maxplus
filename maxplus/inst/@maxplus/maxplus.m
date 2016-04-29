function M = maxplus(A)
	## MAX_PLUS Creates a new matrix in the max-plus algebra.
	##
	## Usage:
	## 		M = maxplus(A);
	## 
	## A can be any ordinary matrix in Octave.
	## It will be stored as the mat field of the result.
	M.mat = A;
	M = class(M, 'maxplus');
endfunction
