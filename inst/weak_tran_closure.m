function [Gamma, cycle] = weak_tran_closure(M)
	## WEAK_TRAN_CLOSURE computes the weak transitive closure of a matrix
	## 
	## Usage:
	## 		Gamma = weak_tran_closure(M);
	## 		[Gamma, cycle] = weak_tran_closure(M);
	## 
	## The weak transitive closure of a matrix is the matrix
	## 		G = A (+) A^2 (+) ... (+) A^n
	##
	## Remark: The input matrix might not have a transitive closure
	## in the case it has positive eigenvalue. Make sure to always
	## check the `cycle` output argument.
	[G, cycle] = floyd_warshall(M);
	Gamma = maxplus(G);
endfunction

# The following function is used internally by WEAK_TRAN_CLOSURE
function [Gamma, cycle] = floyd_warshall(A)
	## FLOYD_WARSHALL runs the Floyd-Warshall algorithm on A's induced digraph.
	## Usage:
	## 		Gamma = floyd_warshall(A);
	## 		[Gamma, cycle] = floyd_warshall(A);
	##
	## If, at some point, a positive cycle is found, it is returned
	## in the second output argument.

	# initially, assume no cycle exists
	cycle = 0;

	if ~isa(A, "maxplus")
		Gamma = A;
	else
		Gamma = A.mat;
	endif

	# only square matrices have well-defined induced digraphs
	if ~(size(Gamma, 1) == size(Gamma, 2))
		error("Cannot run Floyd-Warshall on nonsquare matrices!");
	endif

	# main loop of floyd - warshall algorithm
	for p = 1:size(Gamma, 1)
		for i = 1:size(Gamma, 1)
			for j = 1:size(Gamma, 1)
				if Gamma(i, j) < (Gamma(i, p) + Gamma(p, j))
					Gamma(i, j) = Gamma(i, p) + Gamma(p, j);
				endif
				if (i == j) && (Gamma(i, j) > 0)
					cycle = 1;
					return;
				endif
			endfor
		endfor
	endfor
endfunction
