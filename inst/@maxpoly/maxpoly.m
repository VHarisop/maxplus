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
		# Constructor
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
				obj.coeffs = coefficients(:);
				obj.consts = constants(:);
			elseif nargin == 1
				# assume constants equal to 0
				obj.coeffs = coefficients(:);
				obj.consts = zeros(length(coefficients), 1);
			else
				error('Cannot create empty maxpolynomial!');
			endif
		endfunction

		# Maxpolynomial evaluation
		function val = value_at(obj, x)
			## VALUE_AT evaluates the maxpolynomial at a specified `x`.
			## Usage:
			## 		val = value_at(obj, x);
			##		val = obj.value_at(x);
			val = max(obj.consts + obj.coeffs * x);
		endfunction	

		# Display function for octave toplevel
		function display(obj)
			## DISPLAY pretty display for a maxpoly object.
			## Displays the current maxpolynomial in ordinary notation.
			n = length(obj.coeffs);
			coeffs = obj.coeffs;
			consts = obj.consts;
			val = 'max{';
			for i = 1:(n - 1)
				val = strcat(val, sprintf(' %d + z^%d,', consts(i), coeffs(i)));
			endfor
			val = strcat(val, sprintf(' %d + z^%d }', consts(n), coeffs(n)));
			disp(val);
		endfunction
	endmethods

	# Static methods on maxpolynomials
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
