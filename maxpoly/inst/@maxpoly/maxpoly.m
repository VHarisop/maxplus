classdef maxpoly
	## MAXPOLY is a class that represents a polynomial in (max, +) algebra.
	## The class uses two arrays internally to represent the maxpolynomial.
	## The first array contains the coefficients, e_i, of the polynomial, while
	## the second array contains the constant terms, b_i.
	## The resulting maxpolynomial is equivalent to
	## 		max_r { (c_r + x * j_r) }
	## in ordinary arithmetic.
	## However, it can also be interpreted as
	## 		sum_r { max{ b_r, z } * e_r }
	## The first of these two is the default interpretation.
	properties
		coeffs # The coefficients of the polynomial's terms
		consts # The constant terms of the polynomial's factors
	endproperties
	methods
		function obj = maxpoly(coefficients, constants)
			## MAXPOLY creates a new maxpolynomial
			##
			## Usage:
			##		x = maxpoly(coefficients);
			## 		x = maxpoly(coefficients, constants);
			##
			## `coefficients` is a vector containing the coefficients
			## of the maxpolynomial's terms.
			## `constants` is a vector containing the constant terms of the
			## maxpolynomial's factors.
			## If `constants` are not provided, they are assumed to be equal
			## to 0.
			if nargin == 2
				# make sure input is ok
				if ~(isa(coefficients, 'numeric') || isa(constants, 'numeric'))
					error('Maxpolynomial arguments must be numeric!');
				endif
				if length(coefficients) ~= length(constants)
					error('Constants / coefficients have different lengths!');
				endif
			elseif nargin == 1
				# make sure input is ok
				if ~isa(coefficients, 'numeric')
					error ('Maxpolynomial arguments must be numeric!');
				end
				constants = zeros(length(coefficients), 1);
			else
				error('Cannot create empty maxpolynomial!');
			endif
			# acquire standard (i.e. ascending) order of coefficients
			[~, ind] = sort(coefficients);
			obj.coeffs = coefficients(ind)(:);
			obj.consts = constants(ind)(:);
		endfunction

		function val = value_at(obj, x)
			## VALUE_AT evaluates the maxpolynomial at a specified `x`.
			## Usage:
			## 		val = value_at(obj, x);
			##		val = obj.value_at(x);
			val = max(obj.consts + obj.coeffs * x);
		endfunction

		function grad = gradient_at(obj, x)
			## GRADIENT_AT computes the gradient at a specified `x`.
			##
			## Usage:
			##		grad = gradient_at(obj, x);
			##		grad = obj.gradient_at(x);
			##
			## If the point in question is a corner of the maxpolynomial,
			## the value returned is Nan (checked easily with isnan()).

			# get first index of maximum and the maximum itself
			[mx, arg] = max(obj.consts + obj.coeffs * x);
			grad = obj.coeffs(arg);
			if arg == length(obj.coeffs)
				return;
			endif
			# if more than one points attain maximum, return NaN instead
			if (obj.consts(arg + 1) + obj.coeffs(arg + 1) * x) == mx
				grad = NaN;
			endif
		endfunction

		function subgrad = subgradient_at(obj, x)
			## SUBGRADIENT_AT computes the subgradient at a point `x`.
			##
			## Usage:
			##		subgrad = subgradient_at(obj, x);
			##		subgrad = obj.subgradient_at(obj, x);
			##
			## The subgradient coincides with the gradient in the case where
			## the maxpolynomial is differentiable at `x`. Otherwise, it is
			## calculated as 0.5 * (gradient_at(x - e) + gradient_at(x + e))
			## where `e` is a perturbation around `x`.
			subgrad = gradient_at(obj, x);
			# if NaN was returned, return subgradient
			if isnan(subgrad)
				[~, arg] = max(obj.consts + obj.coeffs * x);
				subgrad = (obj.coeffs(arg) + obj.coeffs(arg + 1)) / 2;
			endif
		endfunction

		function display(obj)
			## DISPLAY displays a maxpoly object in the Octave interpreter.
			##
			## Displays the current maxpolynomial in ordinary notation, which
			## is max { c_r + z * j_r }
			n = length(obj.coeffs);
			coeffs = obj.coeffs;
			consts = obj.consts;
			val = 'max{';
			for i = 1:(n - 1)
				val = strcat(val, sprintf(' %d + %dz,', consts(i), coeffs(i)));
			endfor
			val = strcat(val, sprintf(' %d + %dz }', consts(n), coeffs(n)));
			disp(val);
		endfunction

		function gammas = corners(obj)
			## CORNERS computes the corners of a maxpolynomial.
			## The corners are the intersection points of two terms of the
			## polynomial, c_p + z * j_p and c_r + z * j_r.
			##
			## This function works properly when the maxpolynomial
			## uses standard (i.e. ascending) order of terms, which
			## is normally enforced by its constructor.
			gammas = - diff(obj.consts) ./ diff(obj.coeffs);
		endfunction

		function pol = rectify(obj)
			## RECTIFY removes inessential terms from the maxpolynomial.
			## Usage:
			##		mpoly = maxpoly(...arguments...);
			##		r = mpoly.rectify();
			## RECTIFY uses the standard algorithm (see Butkovic, p. 110)
			error ("RECTIFY not implemented yet!");
		endfunction
	endmethods

	methods(Static = true)
		function pol = evolution(e_rs, b_rs)
			## EVOLUTION runs the evolution algorithm on a maxpolynomial
			## This converts a maxpolynomial from product form to standard
			## form.
			## The product form in standard notation is:
			## 		sum_r { max{ b_r, z } * e_r }
			##
			## Usage:
			## 		poly = maxpoly.evolution(e_rs, b_rs);
			##
			## The returned value is the resulting maxpolynomial.
			t = cell(length(b_rs) + 1, 2);
			t(1, :) = {sum(b_rs .* e_rs), 0};
			for r = 1:length(b_rs)
				# replace previous leading constant
				b_rs(r) = 0;

				# set on new term
				t{r + 1, 1} = sum(b_rs .* e_rs);
				t{r + 1, 2} = t{r, 2} + e_rs(r);
			endfor
			poldata = cell2mat(t);
			## Convert the result into a maxpolynomial
			pol = maxpoly(poldata(:, 2), poldata(:, 1));
		endfunction
	endmethods
endclassdef
