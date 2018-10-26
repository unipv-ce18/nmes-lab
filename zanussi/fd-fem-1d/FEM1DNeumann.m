function U = FEM1DNeumann( N, f, gamma )
%FEM1DNEUMANN Computes FEM with U'(1) = GAMMA from 0 to 1
%   U = FEM1DNEUMANN(N, F, GAMMA) calculates U over N linearly spaced
%   points satisfying -U'' = F with boundary U(0) = 0 and U(1) = GAMMA.

% Define N linearly spaced points for X
xAll = linspace(0,1,N);

% Since U(0) is known (= 0),
% we are going to compute it only on the remaining points
pts = xAll(2:end)';

% Calculate the length of an interval
h = 1/(N-1);

% This is our usual F generation integral, BUT we also have to consider
% an half-triangle on the last point of the mesh.
% We didn't have to consider this with simple Dirichlet conditions because
% we had not to compute U at the extremes of the interval (known = 0).
ifGen = @(x) integral( ...
    @(t) f(t) .* triangularPulse(x-h, x+h, t), ...
    x-h, x+(x~=pts(end))*h); % i.e. if "x not last" then x+h else only x 
F = arrayfun(ifGen, pts);

% From theory, each F value is summed by gamma*phi_i(N),
% since phi_i(N) is 1 only at N, we can sum gamma only to the last F value
F(end) = F(end) + gamma;

% We calculate A as usual,
% but we need to half the last value to reflect the last half-triangle 
A = amatrix(length(pts), h, 'fe');
A(end,end) = A(end,end)/2;

% Preped zero to U as the boundary condition in 0
% we calculated in pts, which excluded this 1st point
U = [0; A \ F];

end
