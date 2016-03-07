function R = transpose(M)
	## Return the transpose of M in the max plus semiring.
	## 
	## This function and M.' are equivalent.
	R = maxplus(M.mat.');
endfunction
