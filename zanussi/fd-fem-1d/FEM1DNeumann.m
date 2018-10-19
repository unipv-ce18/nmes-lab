function U = FEM1DNeumann( N, f, gamma )
%FEM1DNEUMANN Computes FEM with U(b) = GAMMA
%   TODO: Description

xr = linspace(0,1,N);
pts = xr(2:end)'; % no -1

sz = length(pts);
h = pts(2) - pts(1);

ifGen = @(x) integral( ...
    @(t) f(t) .* triangularPulse(x-h, x+h, t), ...
    x-h, x+(x~=xr(end))*h);

F = arrayfun(ifGen, pts);

F(end) = F(end) + gamma;

A = amatrix(sz, h, 'fe');
A(end,end) = A(end,end)/2;
U = A \ F;

U = [0;U];

end

