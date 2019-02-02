function [ t, y ] = ieuler( f, y0, t0, T, dt )
%IEULER Solves y'(t) == f(t, y) using Implicit (backward) Euler
%   Initial condition is y(t0) = y0, output is y(t) sampled by dt up to T.

t = t0:dt:T;
y = zeros(1, length(t));
y(1) = y0;

syms yc yn tc;
ieStep = matlabFunction( ...
    rhs(isolate(yn == yc + dt * f(tc + dt, yn), yn)));

for i = 1:length(t)-1
    y(i+1) = ieStep(t(i), y(i));
end

end
