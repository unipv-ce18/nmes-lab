function [ t, y ] = cranknic( f, y0, t0, T, dt )
%CRANKNIC Solves y'(t) == f(t, y) using Crank-Nicolson's method
%   Initial condition is y(t0) = y0, output is y(t) sampled by dt up to T.

t = t0:dt:T;
y = zeros(1, length(t));
y(1) = y0;

syms yc yn tc;
cnStep = matlabFunction( ...
    rhs(isolate(yn == yc + dt/2 * (f(tc, yc) + f(tc + dt, yn)), yn)));

for i = 1:length(t)-1
    y(i+1) = cnStep(t(i), y(i));
end

end
