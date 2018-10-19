function U = fem( pts, fGen )
%FDM Calculates points of U satisfying -U'' = F using Finite Elements
%   U = FEM(PTS, FGEN) gives values of U calculated in PTS,
%   FGEN is a generator function for values of F in PTS.

[sz, h] = ptsinfo(pts);

% For FEM, F are the values of int(f(x) * phi_i, a, b) at anchor points
ifGen = @(x) mintegral( ...
    @(t) fGen(t) .* triangularPulse(x-h, x+h, t), ...
    x-h, x+h, 2);
% Do not use the "infinite" precision built-in integral function
%ifGen = @(x) integral( ...
%    @(t) fGen(t) .* triangularPulse(x-h, x+h, t), ...
%    x-h, x+h);
F = arrayfun(ifGen, pts);
A = amatrix(sz, h, 'fe');
U = A \ F;
end
