function U = FEM1Dnonuniform( mesh, f )
%FEM1DNONUNIFORM FEM computation with a non-uniform mesh
%   U = FEM1DNONUNIFORM(MESH, F) calculates U in the points provided by
%   MESH satisfying -U'' = F with boundary U(MESH(1)) = U(MESH(END)) = 0.

% TODOs:
% - Auto-generate A for any mesh size
% - Modularization + documentation

% Calculate H values for each interval
h = sum([mesh(2:end); -mesh(1:end-1)]);
disp('Spacings:');
disp(h);

% Inner X values
x = mesh(2:end-1)';
disp('Inner:');
disp(x);


% Define phi_i(x)
basisf = @(i, t) triangularPulse(x(i)-h(i), x(i), x(i)+h(i+1), t);

% A(i,j) = 1/hl+1/hr on i = j;

A = [ 1/h(1)+1/h(2)  -1/h(2)        0               0
      -1/h(2)        1/h(2)+1/h(3)  -1/h(3)         0
      0              -1/h(3)        1/h(3)+1/h(4)  -1/h(4)
      0              0              -1/h(4)        1/h(4)+1/h(5) ];
disp('A matrix:');
disp(A);


ifGen = @(i) integral( ...
    @(t) f(t) .* basisf(i, t), ...
    x(i)-h(i), x(i)+h(i+1));

F = arrayfun(ifGen, (1:size(x))');
disp('F vector:');
disp(F);

U = A \ F;

U = [0;U;0];

end

