function R = subsasgn(A, idx, rhs)
	## SUBSASGN overloads index assignment for maxplus objects
	if strcmp(idx.type, '()')
		R = maxplus(subsasgn(A.mat, idx, rhs));
	endif
endfunction
