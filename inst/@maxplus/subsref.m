function r = subsref (val, idx)
	## Overloads subsref function for maxplus objects.

	# Retrieve the .mat field of a @maxplus object.
	if strcmp(idx.type, ".") && strcmp(idx.subs, 'mat')
		r = val.mat;
	# if indexing is requested, pass that request "downwards"
	# and return a maxplus object from the result, if any
	elseif strcmp(idx.type, '()')
		r = maxplus(subsref(val.mat, idx));
	endif
endfunction
