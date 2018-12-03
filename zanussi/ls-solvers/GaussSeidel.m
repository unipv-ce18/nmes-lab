function [ x, res, its, rnorms ] = GaussSeidel( A, b, tol, maxit, x0 )
[x, res, its, rnorms] = itersolv1('gauss_seidel', A, b, tol, maxit, x0);
end
