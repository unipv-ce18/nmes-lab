function [ x, res, its, rnorms ] = itersolv1( mode, A, b, tol, maxit, x0 )

r0 = b - A * x0;

rnorms = zeros(1, maxit+1);
rnorms(1) = norm(r0);

switch mode
    case 'jacobi'
        M = diag(diag(A));
    case 'gauss_seidel'
        M = tril(A);
    otherwise
        error('Unknown mode')
end

% N = A - M

x = x0;
res = r0;
for its=1:maxit
    % x = M^-1 * (B - N * x);  [see (*), becomes...]
    % x = x + M^-1 * (B - A * x);
    x = x + M^-1 * res;
    res = b - A * x;

    rnorms(its+1) = norm(res);
    if abs(rnorms(its+1) / rnorms(1)) < tol; break; end
end

%{
N = M - A

(*)
x = M^-1 (b + N xprev)
  = M^-1 (b + M xprev - A xprev)
  = xprev + M^-1 (b - A xprev)

where r = b - A xprev
remember M^-1 M = I
%}

end
