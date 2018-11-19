function X = backsubst( A, B )
%BACKSUBST Calculates A \ B using Backsubstitution
%   BACKSUBST(A,B) calculates A \ B using a backsubstitution algorithm,
%   An upper-triangular matrix is required for the algorithm to work.

if ~istriu(A)
    % The backsubstitution algorithm works only on triangular matrices
    warning('Backsubstitution works only on (upper) triangular matrices');
    return;
end

n = length(A);
X = zeros(n, 1);

% Calculate the last value of X...
X(n) = B(n) / A(n, n);

% Then the other ones in descending order using the given formula
for i = n-1:-1:1
    X(i) = (B(i) - sum(A(i,i+1:n) * X(i+1:n))) / A(i,i);
end

% Comparing the result X with A \ B should give the same vector

end
