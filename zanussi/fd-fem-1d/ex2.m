%% FEM1Dnonuniform test case

% Test this with function #2 from exercise 1
Fgen = @(x) 16*pi^2*sin(4*pi*x); % Generator for values of F
Utgt = @(x) sin(4*pi*x); % Target U (for plot comparison)

% Define an arbitrary mesh points from 0 to 1
mesh = [0 .1 .4 .6 .7 1];

% Calculate U...
U = FEM1Dnonuniform(mesh, Fgen);

% ...and plot it
figure('Name', 'FEM test case, non-uniform mesh');
hold on;
fplot(Utgt, [0 1], 'r');
plot(mesh, U, 'bx');

%% FEM1DNeumann test case

% Test this with an altered version of function #1 from exercise 1
% i.e. -U'' = F, U(0) = 0, U'(1) = 2, F = -1

% Use Mathematica to reconstruct the primitive:
%   DSolve[{-u''[x] == -1, u[0] == 0, u'[1] == 2}, u[x], x]
% gives u[x] -> 1/2 (2 x + x^2)

N = 11;
Fgen = @(x) -1;
gamma = 2;
Utgt = @(x) x.^2/2 + x;

U = FEM1DNeumann(N, Fgen, gamma);

figure('Name', 'FEM test case, Neumann boundary condition');
hold on;
fplot(Utgt, [0 1], 'r');
plot(linspace(0,1,N), U, 'bx');
