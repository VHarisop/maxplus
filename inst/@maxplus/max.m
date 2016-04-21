function r = max_cycle_mean(M)
	## Returns the maximum cycle mean of a square matrix M in the max plus semiring.
	## 
	## This function operates the naive way, calculating all matrices of power
	## up to N, where N is the row/column dimension of the matrix.
	## 
	## Usage:
	## 		lambda = max_cycle_mean(M);
	##
	if ~isa(M, "maxplus")
		M = maxplus(M);
	endif

