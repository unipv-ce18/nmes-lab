function c = quadratic_regression( x, y )

% Vandermonde matrix
A = [ ones(length(x), 1) x x.^2];

c = (A' * A) \ (A' * y);

end

