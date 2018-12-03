%% LU factorization

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

%% Solvers profiling

oldpath = addpath('../fd-fem-1d/common');

x = (0+1/10:1/10:1-1/10)';
Fgen = @(x) -1;

Ubs = fem(x, Fgen, test2c_solvers('backslash'));
Ugem = fem(x, Fgen, test2c_solvers('gem'));
Ulu = fem(x, Fgen, test2c_solvers('lu'));
Uluinv = fem(x, Fgen, test2c_solvers('luinv'));
Uchol = fem(x, Fgen, test2c_solvers('chol'));
Ucholinv = fem(x, Fgen, test2c_solvers('cholinv'));
fprintf('\n');

path(oldpath);
