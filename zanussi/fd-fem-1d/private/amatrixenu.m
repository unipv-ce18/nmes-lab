function A = amatrixenu( h )
%AMATRIXENU Creates an A matrix for a non uniform FEM mesh
%   A = AMATRIXENU(H) makes an sz*sz "A" matrix (where sz = length(H) - 1)
%   for use in a 1D Finite Element algorithm with variable mesh size.
%   H is an array of the step sizes composing the linear mesh.
%
%   If the mesh is constant (H = k*ones(sz,1)),
%   then AMATRIXENU(H) == amatrix(length(H) - 1, k, 'fe')
%
%   See also AMATRIX

% A(i,j) = 1/hl+1/hr on i = j;  A(i, i+-1) = -1/h
%
% e.g. with 4 internal nodes:
%   A = [ 1/h(1)+1/h(2)  -1/h(2)        0               0
%        -1/h(2)        1/h(2)+1/h(3)  -1/h(3)         0
%        0              -1/h(3)        1/h(3)+1/h(4)  -1/h(4)
%        0              0              -1/h(4)        1/h(4)+1/h(5) ];
%
% Why? Remeber phi_i is a triangle (rise x(i-1), center x(i), fall x(i+1))
%   case i == j:
%     int(phi_i' * phi_j') from x-hl to x+hr = int((phi_i')^2)
%     = int(1/hl^2) "rising, width hl" + int((-1/hr)^2) "falling, width hr"
%     = hl*1/hl^2 + hr*1/hr^2
%     = 1/hl + 1/hr
%   case i == j+-1:
%     int(phi_i' * phi_j') only on the side shared between x(i) and x(j)
%                          of width h; one rising, the other falling
%     = int(+1/h * -1/h) = int(-1/h^2) = h * -1/h^2
%     = -1/h

% We have N intervals, so we have N-1 inner nodes
sz = length(h) - 1;

% Function evaluated on the diagonal and around it to get A(i,j) values
function v = acoefficients( i, j )
if i == j
    v = 1/h(j) + 1/h(j+1);
else
    v = -1/h(max(i, j));
end
end

sweepI = [ 1:sz 2:sz 1:sz-1 ]; % Rows sweep
sweepJ = [ 1:sz 1:sz-1 2:sz ]; % Columns sweep
A = sparse(sweepI, sweepJ, arrayfun(@acoefficients, sweepI, sweepJ));

end
