function R = plus(A, B)
	## PLUS performs addition in the max-plus semiring.
	## Usage: 
	## 		C = A + B;
	## 		C = plus(A, B);
	## 
	## If C = A + B then
	## 		c_{ij} = max(a_{ij}, b_{ij}

	MA = A.mat; MB = B.mat;
	# if none of the arguments is a scalar, make sure
	# that the matrix sizes are compatible
	if !(all(size(MA) == 1)) && !(all(size(MB) == 1))
		if !(all(size(MA) == size(MB)))
			error('Matrix sizes are incompatible!');
		endif
	endif

	R = maxplus(bsxfun(@max, MA, MB));
endfunction
