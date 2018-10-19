function ex1_results( h )
global a b;

% Script parameters
a = 0;
b = 1;
if ~exist('h', 'var')
    h = 1/10;
end

% Generator functions for "F" values
F1gen = @(x) -1;
F2gen = @(x) 16*pi^2*sin(4*pi*x);

% Target "U" functions for reference in plots
U1fTgt = @(x) x.*(x-1)/2;
U2fTgt = @(x) sin(4*pi*x);

% X-axis values for computation: [ .1 .2 ... .8 .9]' if a=0, b=1, h=.1
x = (a+h:h:b-h)';

% Solve linear systems (A U = F) for U and plot
figure('Name', sprintf('FD/FE Methods results (N = %d)', 1/h));

U1fdm = fdm(x, F1gen);
tgtplot(1, 'FDM - fun. 1', x, U1fdm, U1fTgt);

U1fem = fem(x, F1gen);
tgtplot(2, 'FEM - fun. 1', x, U1fem, U1fTgt);

U2fdm = fdm(x, F2gen);
tgtplot(3, 'FDM - fun. 2', x, U2fdm, U2fTgt);

U2fem = fem(x, F2gen);
tgtplot(4, 'FEM - fun. 2', x, U2fem, U2fTgt);


% NOTE: The integral for the 1st function's FEM (f = -1)
% is also constant and can be also calculated by hand:
%
%   F(i) = integral(f * phi_i) from a to b
%        = integral(-1 * phi_i)
%        = -1 * integral("triangle of width 2h and height 1")
%        = -1 * 2h*1 / 2
%        = -h
%
% An "F = -h * ones(sz, 1)" can thus be used directly
% in the last step of fem().

end

function tgtplot( i, name, x, y, tgtf )
global a b;
subplot(2, 2, i);
title(name);
hold on;
fplot(tgtf, [a b], 'r');
plot([a;x;b], [0;y;0], 'bx');
end
