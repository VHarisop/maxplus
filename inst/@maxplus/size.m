function dims = size(M)
	## Returns the size of a max-plus matrix.
	##
	## Usage:
	## 		[sz_x, sz_y] = size(M);
	##
	if isa(M, "maxplus")
		dims = size(M.mat);
	else
		dims = size(M);
	endif
