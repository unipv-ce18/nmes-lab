function [ A ] = amatrix( sz, h, method )
%AMATRIX Creates an A matrix for the specified numerical method
%   A = AMATRIX(SZ, H, 'fd') makes an sz*sz "A" matrix for use
%   in a Finite Differences algorithm, using H for step size.
%   See this <a
%   href="matlab:web('https://en.wikipedia.org/wiki/Finite_difference_coefficient')">wiki article</a> for more information.
%
%   A = AMATRIX(SZ, H, 'fe') makes an sz*sz "A" matrix for use in
%   a Finite Element algorithm, using H for step size.

Abase = sparse( ...
    cat(2, 1:sz, 2:sz, 1:sz-1), ...
    cat(2, 1:sz, 1:sz-1, 2:sz), ...
    cat(2, 2*ones(1, sz), -1*ones(1, 2*sz-2)));

switch method
    case 'fd' % for Finite Difference Method (FDM)
        A = 1/h^2 * Abase;
    case 'fe' % for Finite Element Method (FEM)
        A = 1/h * Abase;
    otherwise
        throw(MException('AMatrix:unknownMethod', ...
            'Method must be one of "fd", "fe" (was "%s")', method));
end

end
