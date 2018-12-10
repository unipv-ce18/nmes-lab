%% Bisection test

%f = @(x) atan(3*(x - .6));
%[x, its] = bisection(f, 0, 1, 1e-6, 100);
f = @(x) exp(x) - cos(x) - 2;
[x, its] = bisection(f, -1, 1, 1e-6, 100);
fprintf('Found x = %.2f in %d iterations\n', x, its);

%% Newton test

%f = @(x) atan(3*(x - .6));
%derf = @(x) 3 / (1 + 9 * (-.6 + x) .^ 2);

f = @(x) exp(x) - cos(x) - 2;
derf = @(x) exp(x) - sin(x);

[x, its] = newton(f, derf, 0, 1e-6, 100);
fprintf('Found x = %.2f in %d iterations\n', x, its);

fplot(f, [0 1]);

%% Solve cbrt(x-pi) = 0

f = @(x) nthroot(x - pi, 3);
derf = @(x) 1/(3 .* abs(x - pi).^(2/3));

[x, its] = bisection(f, 2, 4, 1e-6, 100);
fprintf('Bisection: x = %.2f (%d iterations)\n', x, its);

[x, its] = newton(f, derf, 3.141592653589793238, 1e-6, 100);
fprintf('Newton:    x = %.2f (%d iterations)\n', x, its);

hold on;
fplot(f, [2 4]);
fplot(derf, [2 4]);