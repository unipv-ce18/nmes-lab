function ex1_errors
global a b Uref Fgen progBar;

% Script parameters
a = 0;
b = 1;
Uref = @(x) sin(4*pi*x);
Fgen = @(x) 16*pi^2*sin(4*pi*x);
H = [1/20; 1/40; 1/80; 1/160];

% Progress bar state holder
progBar = struct( ...
    'h', waitbar(0), ...
    'e', 2 * length(H), ...
    'i', 0);

Efdm = arrayfun(@(h) fdmError(h), H);
Efem = arrayfun(@(h) femError(h), H);

figure('Name', 'FDM error analysis');
subplot(2,1,1);
semilogy(1./H, Efdm);
subplot(2,1,2);
loglog(H, Efdm);

figure('Name', 'FEM error analysis');
subplot(2,1,1);
semilogy(1./H, Efem);
subplot(2,1,2);
loglog(H, Efem);

close(progBar.h)
end

function eMax = fdmError( h )
global a b Uref Fgen;
updateProgress('FDM', h);

x = (a+h:h:b-h)';
eMax = norm(Uref(x) - fdm(x, Fgen), inf);
end

function eMax = femError(h)
global a b Uref Fgen;
updateProgress('FEM', h);

x = (a+h:h:b-h)';
eMax = norm(Uref(x) - fem(x, Fgen), inf);
end

function updateProgress( name, h )
global progBar;
waitbar(progBar.i/progBar.e, progBar.h, ...
    sprintf('Computing %s, N = %d', name, 1/h));
progBar.i = progBar.i + 1;
end