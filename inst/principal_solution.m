function S = principal_solution(A, B)
	## PRINCIPAL_SOLUTION Calculates the principal solution to a one-sided
	## system in max-algebra.
	##
	## Usage: S = principal_solution(A, B);
	##
	## The solution of a one-sided system,
	## 		A (o) X = B
	## in max algebra, is not guaranteed to exist. However, if a
	## solution exists, it is given by the principal solution
	##		X_optim = (-A') (o)' B
	## where (o)' is the dual operator of (o). With (o)', the
	## minimum replaces the maximum and addition is retained.
	MA = A.mat; 
	MB = B.mat;
	S = zeros(size(MA, 2), size(MB, 2));
	for i = 1: size(MB, 2);
		S(:, i) = min(-MA' + MB(:, i)', [], 2);
	endfor
	S = maxplus(S);
endfunction
