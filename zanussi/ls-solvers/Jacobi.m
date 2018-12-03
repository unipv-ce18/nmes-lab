function [ x, res, its, rnorms ] = Jacobi( A, b, tol, maxit, x0 )
[x, res, its, rnorms] = itersolv1('jacobi', A, b, tol, maxit, x0);
end
