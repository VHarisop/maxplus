function [A, B, C] = calc_candecomp(X)
	## CALC_CANDECOMP computes the max-decomposition of a given 3-tensor
	## It uses the alternating mathod, as described in [1], adapted for
	## max-algebraic computation. When solving for A, B, or C given the
	## two other matrices, the Cunningamme-Green pseudoinverse is used to
	## compute the principal solution.
	##
	## [1]: T. Kolda & B.W. Bader - Tensor Decompositions and Applciations
	error("Implementation is not available yet");
endfunction

function R = decomp(Xr, A1, A2)
	## Given a tensor slice, Xr, and a pair of matrices that make up the
	## Khatri-Rao part of the slice, solves for the other matrix.
	## The tensor slice / mode X(r) can be decomposed as:
	##
	##			X(r) = R * Lambda * (A1 o A2)^T
	##
	## where "o" denotes the Khatri-Rao product and Lambda is assumed to be
	## a diagonal matrix. Multiplication here is treated in the max-algebraic
	## sense.
	## We can reformulate this as a one-sided max-linear system by setting:
	##
	## 		A' = [(A1 o A2)^T]^T = (A1 o A2)
	##		B' = X(r)^T
	##		X' = R^T
	##
	## which leads us to the equation
	##
	##		A' * X' = B'
	##
	## In the above, we can solve for X' using the Cunningamme-Green inverse.

	# Reformulate as one-sided max-linear system
	Anew = khatri_rao(A1, A2);
	Bnew = Xr.';

	# Solve and return the transpose
	R = (principal_solution(Anew, Bnew)).';
endfunction
