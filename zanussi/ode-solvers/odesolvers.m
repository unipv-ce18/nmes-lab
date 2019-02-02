%% Testing of ODE solvers

f = @(t,y) -3*y + 2*t - 2;
y0 = -1;
dt = .05;
fprintf('--- y(1) value, dt = %.3f ---\n', dt);

% Exact
yf = @(t) 2*t/3 - 1/9*exp(-3*t) - 8/9;
yexact = yf(1);
fprintf('%-22s %.4f\n', 'Exact:', yexact);

% EE
[~, yo] = eeuler(f, y0, 0, 1, dt);
fprintf('%-22s %.4f\n', 'Explicit/Fwd. Euler:', yo(end));

% IE
[~, yo] = ieuler(f, y0, 0, 1, dt);
fprintf('%-22s %.4f\n', 'Implicit/Bkwd. Euler:', yo(end));

% Crank-Nicolson
[~, yo] = cranknic(f, y0, 0, 1, dt);
fprintf('%-22s %.4f\n', 'Crank-Nicolson:', yo(end));

% Heun
[~, yo] = heun(f, y0, 0, 1, dt);
fprintf('%-22s %.4f\n', 'Heun:', yo(end));

fprintf('\n');


%% Consistency analysis (while varying dt)

dtv = [ .5 .25 .1 .05 .025 .01 ];
yov = zeros(4, length(dtv));

for i = 1:length(dtv)
    [~, yee] = eeuler(f, y0, 0, 1, dtv(i));
    [~, yie] = ieuler(f, y0, 0, 1, dtv(i));
    [~, ycn] = cranknic(f, y0, 0, 1, dtv(i));
    [~, yhe] = heun(f, y0, 0, 1, dtv(i));

    yov(:, i) = [ yee(end) yie(end) ycn(end) yhe(end) ];
end

eov = abs(yov - yexact);

figure('Name', 'Error log plot');
for i = 1:4
    semilogy(dtv, eov(i, :), '-*');
    hold on;
end
title('Error log plot'), xlabel('dt'), ylabel('|y(t) - y_*(T)|');
legend({'Explicit Euler', 'Implicit Euler', 'Crank-Nicolson', 'Heun'}, ...
    'Location', 'southeast');
