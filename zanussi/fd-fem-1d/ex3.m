% Solution for exercise 3 at:
% http://www-dimat.unipv.it/sangalli/numerical_methods_eng_sciences/1-exercices.pdf

% TODOs:
% - Modularize in reusable functions
% - Add documentation
% - Use a generator function for B given any beta(x)



% First, an analytical solution to the problem:
%   -eps * u''(x) + beta(x) * u'(x) = f(x)    u(a) = u(b) = 0
%
% - In MATLAB (JESUS, good luck):
%   https://it.mathworks.com/help/matlab/math/boundary-value-problems.html
%
% - Using Wolfram Mathematica:
%     a=0; b=1; eps=1; beta=1;
%     DSolve[{-eps u''[x] + beta u'[x] == x^2, u[a]==0, u[b]==0}, u[x], x]
%   ...gives:
%     u[x] -> (10 - 10 E^x - 6 x + 6 E x - 3 x^2 + 3 E x^2 - x^3 + E x^3)/(3 (-1 + E))
%uTgt = @(x) (10*(1-exp(x)) + (exp(1)-1)*(6*x+3*x^2+x^3))/(3*(exp(1)-1));
syms x_ eps_;
uTgtSym(x_) = (1 - exp(x_/eps_) + 3*eps_ - 3*exp(x_/eps_)*eps_ + ...
    6*eps_^2 - 6*exp(x_/eps_)*eps_^2 - 6*eps_^2*x_ + ...
    6*exp(1/eps_)*eps_^2*x_ - 3*eps_*x_^2 + 3*exp(1/eps_)*eps_*x_^2 - ...
    x_^3 + exp(1/eps_)*x_^3)/(3*(-1 + exp(1/eps_)));

a = 0;
b = 1;
h = 1/20;
x = (a+h:h:b-h)';

fGen = @(x) x.^2;
if ~exist('eps', 'var')
    eps = 1;
end
beta = 1;

sz = 1/h - 1;
A = eps/h * sparse( ...
    [1:sz 1:sz-1 2:sz], ...
    [1:sz 2:sz   1:sz-1], ...
    cat(2, 2 * ones(1, sz), -1 * ones(1, 2*sz-2)));
B = sparse( ...
    [1:sz-1 2:sz], ...
    [2:sz 1:sz-1], ...
    cat(2, +1/2 * ones(1, sz-1), -1/2 * ones(1,sz-1)));
AB = A + B;

ifGen = @(x) integral( ...
    @(t) fGen(t) .* triangularPulse(x-h, x+h, t), ...
    x-h, x+h);
F = arrayfun(ifGen, x);
U = AB \ F;

hold on;
uTgt = subs(uTgtSym, eps_, eps);
fplot(@(x) double(uTgt(x)), [0 1], 'r');
plot(x, U, 'xb');
