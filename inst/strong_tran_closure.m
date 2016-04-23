function [Delta, cycle] = strong_tran_closure(A)
	## STRONG_TRAN_CLOSURE computes the strong transitive closure of a matrix.
	##
	## Usage:
	## 		Delta = strong_tran_closure(A);
	## 		[Delta, cycle] = strong_tran_closure(A);
	##
	## where Delta is the computed transitive closure and cycle is a flag
	## indicating if a positive cycle exists.
	##
	## The strong transitive closure is defined as 
	## 		Delta = I (+) Gamma
	## where Gamma is the weak transitive closure.
	##
	## Remark: the input matrix might not have a closure in the case it has
	## a positive principal eigenvalue. Make sure to use the `cycle` output
	## argument.
	[Gamma, cycle] = weak_tran_closure(A);

	# NOTE: dimension checking has already been performed in weak_tran_closure
	[dim_x, ~] = size(A);

	# create the unit matrix of size `dim_x`	
	I = repmat(-Inf, dim_x);
	I(1:dim_x + 1 : dim_x * dim_x) = 0;

	Delta = maxplus(I) + Gamma;
endfunction
