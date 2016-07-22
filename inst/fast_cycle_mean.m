function lambda = fast_cycle_mean(M)
	## FAST_CYCLE_MEAN calculates the max cycle mean of a square matrix M
	## in the max-plus semiring by decomposing it into permutation matrices
	## in order to obtain running time of O(n^2).
	##
	## Usage:
	## 		lambda = fast_cycle_mean(M);
	##
	## The correctness of this method is only guaranteed for special classes
	## of matrices, such as matrices with strictly non-positive elements or
	## metric matrices.
	if isa(M, 'maxplus')
		M = M.mat;
	endif
	[dim_x, dim_y] = size(M);
	if (dim_x ~= dim_y)
		error('Maximum cycle mean is not defined for non-square matrices');
	endif

	# get all cycles from all diagonal paths
	lambda = max(arrayfun(@(k) diagonal_path(M, k), 1:dim_x));
endfunction

function cycle_mean = diagonal_path(M, k)
	## DIAGONAL_PATH computes the max cycle mean of a permutation matrix
	## by computing the maximum cycle from its k'th diagonal decomposition.
	[dim_x, dim_y] = size(M);

	# init cycle mean with negative infinity
	cycle_mean = -Inf;

	# boolean array of visited nodes
	visited = zeros(dim_x); visited(1) = 1; # first node is visited

	# current path weight
	curr_weight = 0;
	start_node = 1; # start from node 1
	curr_node = 1;
	path_length = 0;
	while (start_node <= dim_x)
		# get next node in the diagonal path
		next_node = mod(curr_node + k, dim_y);
		if (next_node == 0)
			next_node = dim_y;
		endif
		# mark it as visited, update the current path weight and length
		visited(curr_node) = 1; 
		curr_weight = curr_weight + M(curr_node, next_node);
		curr_node = next_node;
		path_length = path_length + 1;
		# if back to start, update set of cycle means
		if (curr_node == start_node)
			cycle_mean = max(cycle_mean, curr_weight / path_length);
			curr_weight = 0;
			path_length = 0;
			# look for the next start_node by increasing its index 
			# until we end up on an unvisited node
			while (visited(start_node))
					start_node = start_node + 1;
					curr_node = start_node;
			endwhile
		endif
	endwhile
endfunction
