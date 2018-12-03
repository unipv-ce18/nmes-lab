function X = substsolve( A, B )
%SUBSTSOLVE Calculates A \ B using back/forward substitution
%   SUBSTSOLVE(A,B) calculates A \ B using a backsubstitution algorithm,
%   An upper-triangular matrix is required for the algorithm to work.

n = length(A);
X = zeros(n, 1);

if istriu(A) % Backsubstitution
    % Calculate the last value of X...
    X(n) = B(n) / A(n, n);

    % Then the other ones in descending order using the given formula
    for i = n-1:-1:1
        X(i) = (B(i) - sum(A(i,i+1:n) * X(i+1:n))) / A(i,i);
    end

else if istril(A) % Forward substitution
    % Calculate the first value of X...
    X(1) = B(1) / A(1, 1);

    % Then the other ones in ascending order using the given formula
    for i = 2:n
        X(i) = (B(i) - sum(A(i,1:i-1) * X(1:i-1))) / A(i,i);
    end

else
    % The backsubstitution algorithm works only on triangular matrices
    warning('Substitution works only on triangular matrices');
    return;
end


% Comparing the result X with A \ B should give the same vector

end
