mesh = [0 .1 .4 .6 .7 1];
Fgen = @(x) 16*pi^2*sin(4*pi*x);

U = FEM1Dnonuniform(mesh, Fgen);

tgtf = @(x) sin(4*pi*x);

figure(1);
hold on;
fplot(tgtf, [0 1], 'r');
plot(mesh, U, 'bx');

% TODO: Implement FEM1DNeumann