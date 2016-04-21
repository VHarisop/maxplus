function [dimx, dimy] = size(M)
	## Returns the size of a max-plus matrix.
	##
	## Usage:
	## 		[sz_x, sz_y] = size(M);
	##
	if isa(M, "maxplus")
		M = M.mat;
	endif

	# act appropriately based on number of outputs
	if nargout < 2
		dimx = size(M);
	else
		[dimx, dimy] = size(M);
	endif
endfunction
