function U = FEM1Dnonuniform( mesh, f )
%FEM1DNONUNIFORM FEM computation with a non-uniform mesh
%   U = FEM1DNONUNIFORM(MESH, F) calculates U in the points provided by
%   MESH satisfying -U'' = F with boundary U(MESH(1)) = U(MESH(END)) = 0.

% Calculate H values for each interval (e.g. [1 5 15] -> [4 10])
h = sum([mesh(2:end); -mesh(1:end-1)]);

% Inner X values (we need to calculate U only on these points)
x = mesh(2:end-1)';

% Define phi_i(t), rises at x(i-1), max at x(i), falls at x(i+1)
basisf = @(i, t) triangularPulse(x(i)-h(i), x(i), x(i)+h(i+1), t);

% Generate A matrix for a non-uniform mesh
A = amatrixenu(h);

% Compute int(f * phi_i) from a to b (0 outside x(i-1):x(i+1)), at each i
ifGen = @(i) integral( ...
    @(t) f(t) .* basisf(i, t), ...
    x(i)-h(i), x(i)+h(i+1));
F = arrayfun(ifGen, (1:size(x))');

% Return U, pad with zeros (boundary conditions) to comply with given mesh
U = [ 0; A \ F; 0 ];

end
