function [ f ] = test2c_solvers( name )
switch name
    case 'backslash'
        f = @backslash_solver;
    case 'gem'
        f = @gem_solver;
    case 'lu'
        f = @lu_solver;
    case 'chol'
        f = @chol_solver;
    otherwise
        error('Unknown solver name');
end
end

function [ U ] = backslash_solver( A, F )
tic;
U = A \ F;
fprintf('Backslash took %.5f seconds\n', toc);
end

function [ U ] = gem_solver( A, F )
tic;
[An, Fn] = gem(A, F);
U = substsolve(An, Fn);
fprintf('GEM took %.5f seconds\n', toc);
end

function [ x ] = lu_solver( A, F )
tic;
%x = luinv(A) * F;
[L,U,~] = lu(A);
x = substsolve(U, substsolve(L, F));
fprintf('LU took %.5f seconds\n', toc);
end

function [ U ] = chol_solver( A, F )
tic;
%U = cholinv(A) * F;
L = chol(A,'lower');
U = substsolve(L', substsolve(L, F));
fprintf('Cholesky took %.5f seconds\n', toc);
end