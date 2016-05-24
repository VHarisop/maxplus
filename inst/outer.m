function R = outer(a, b)
	## OUTER computes the max-algebraic outer product of two vectors
	## Equivalent to a(:) * b(:).'
	## 
	## Usage:
	## 		R = outer(a, b);
	[sz_x, sz_y] = size(a);
	if sz_x ~= 1 && sz_y ~= 1
		error("[a] must be a vector");
	endif

	[sz_x, sz_y] = size(b);
	if sz_x ~= 1 && sz_y ~= 1
		error("[b] must be a vector");
	endif

	# Compute (a)^T * b, in max-algebraic terms
	R = a(:) * b(:).';
endfunction
