function R = subsasgn(A, idx, rhs)
	## SUBSASGN overloads index assignment for maxplus objects
	if strcmp(idx.type, '()')
		# in case the rhs of the assignment is a maxplus object
		# itself, obtain its underlying matrix first
		if isa(rhs, 'maxplus')
			rhs = rhs.mat;
		endif
		R = maxplus(subsasgn(A.mat, idx, rhs));
	endif
endfunction
