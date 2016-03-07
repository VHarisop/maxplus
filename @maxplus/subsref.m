function r = subsref (val, idx)
	## Retrieve the .mat field of a @maxplus object.
	if (strcmp (idx.type, ".") && strcmp (idx.subs, "mat"))
		r = val.mat;
	endif
endfunction
