%% LU Factorization

A = [ 1  2  4
      3  8 14
      2  6 13 ];

luinv(A)
A^-1

%% Cholesky factorization

% Cholesky never needs pivoting

A = [  2  -1  0
      -1   2 -1
       0  -1  2 ]; % Needs to be positive definite

cholinv(A)
A^-1
