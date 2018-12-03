function [ f ] = test2c_solvers( name )
switch name
    case 'backslash'
        f = @backslash_solver;
    case 'gem'
        f = @gem_solver;
    case 'lu'
        f = @lu_solver;
    case 'luinv'
        f = @luinv_solver;
    case 'chol'
        f = @chol_solver;
    case 'cholinv'
        f = @cholinv_solver;
    otherwise
        error('Unknown solver name');
end
end

function [ U ] = backslash_solver( A, F )
tic;
U = A \ F;
fprintf('%14s took %6.3f ms\n', 'Backslash', 1000 * toc);
end

function [ U ] = gem_solver( A, F )
tic;
[At, Ft] = gem(A, F);
U = substsolve(At, Ft);
fprintf('%14s took %6.3f ms\n', 'GEM', 1000 * toc);
end

function [ x ] = lu_solver( A, F )
tic;
[L,U,~] = lu(A);
x = substsolve(U, substsolve(L, F));
fprintf('%14s took %6.3f ms\n', 'LU', 1000 * toc);
end

function [ U ] = luinv_solver( A, F )
tic;
U = luinv(A) * F;
fprintf('%14s took %6.3f ms\n', 'LU inv.', 1000 * toc);
end

function [ U ] = chol_solver( A, F )
tic;
L = chol(A, 'lower');
U = substsolve(L', substsolve(L, F));
fprintf('%14s took %6.3f ms\n', 'Cholesky', 1000 * toc);
end

function [ U ] = cholinv_solver( A, F )
tic;
U = cholinv(A) * F;
fprintf('%14s took %6.3f ms\n', 'Cholesky inv.', 1000 * toc);
end