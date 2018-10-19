mesh = [0 .1 .4 .6 .7 1];
Fgen = @(x) 16*pi^2*sin(4*pi*x);

U = FEM1Dnonuniform(mesh, Fgen);

tgtf = @(x) sin(4*pi*x);

figure(1);
hold on;
fplot(tgtf, [0 1], 'r');
plot(mesh, U, 'bx');

%%

%{
Testing FEM1DNeumann w/ e.g.
  -U'' = F, U(0) = 0, U'(1) = 2, F = -1

DSolve[{-u''[x] == -1, u[0] == 0, u'[1] == 2}, u[x], x]
  u[x] -> 1/2 (2 x + x^2)
%}
N = 11;
Fgen = @(x) -1;
gamma = 2;
tgtf = @(x) x.^2/2 + x;

U = FEM1DNeumann(N, Fgen, gamma);
x = linspace(0,1,N)';

figure(2);
hold on;
fplot(tgtf, [0 1], 'r');
plot(x, U,  'bx');
