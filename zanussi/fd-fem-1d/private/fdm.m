function U = fdm( pts, fGen )
%FDM Calculates points of U satisfying -U'' = F using Finite Differences
%   U = FDM(PTS, FGEN) gives values of U calculated in PTS,
%   FGEN is a generator function for values of F in PTS.

sz = length(pts);
h = pts(2) - pts(1);

% For FDM, F are the values of f(x) at anchor points
F = arrayfun(fGen, pts);
A = amatrix(sz, h, 'fd');
U = A \ F;
end
