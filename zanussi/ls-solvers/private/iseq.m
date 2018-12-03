function [ is_equal ] = iseq( A, B, tolerance )
%ISEQ Returns true if A equals to B up to a given tolerance
%   ISEQ(A,B,1e-6) returns true if the difference between values of
%   A and B in pairs are all less than 10^-6.

diff = abs(A - B);
diff(diff < tolerance) = 0;
is_equal = ~nnz(diff);

end

