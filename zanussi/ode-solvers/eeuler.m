function [ t, y ] = eeuler( f, y0, t0, T, dt )
%EEULER Solves y'(t) == f(t, y) using Explicit (forward) Euler
%   Initial condition is y(t0) = y0, output is y(t) sampled by dt up to T.

t = t0:dt:T;
y = zeros(1, length(t));
y(1) = y0;

for i = 1:length(t)-1
    y(i+1) = y(i) + dt * f(t(i), y(i));
end

end
