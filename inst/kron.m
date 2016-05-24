function R = kron(A, B)
	## KRON computes the max-algebraic kronecker product of two matrices
	## 
	## Usage:
	##		R = kron(A, B);
	##
	## If A has size NxK and B has size MxR, the resulting matrix has
	## size (NM)x(KR).
	[n, k] = size(A);
	[m, r] = size(B);
	R = maxplus(zeros(n*m, k*r));

	# Compute a_{ij} * B for all elements of A
	for i = 1:n
		for j = 1:k
 			irange = ((i - 1) * m + 1) : (i * m);
			jrange = ((j - 1) * r + 1) : (j * r);
			R(irange, jrange) = A(i, j) * B;
		endfor
	endfor
endfunction
