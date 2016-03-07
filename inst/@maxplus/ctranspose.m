function R = ctranspose(M)
	## Return the conjugate transpose of M in the max plus semiring.
	## The complex conjugate transpose is defined as -M' in
	## conventional notation.
	## 
	## This function and M' are equivalent.
	R = maxplus(-M.mat');
endfunction
