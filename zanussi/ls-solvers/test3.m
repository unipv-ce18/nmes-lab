%% - Iterative solvers -

A = [  7  6  3
       2  5 -4
      -4 -3  8 ];

B = [ 16; 3; 1];


%% Jacobi 

[x, res, its, rnorms] = Jacobi(A, B, .1, 50, [0;0;0])


%% Gauss-Seidel

[x, res, its, rnorms] = Jacobi(A, B, .05, 50, [0;0;0])
