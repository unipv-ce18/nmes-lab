function [ t, y ] = heun( f, y0, t0, T, dt )
%HEUN Solves y'(t) == f(t, y) using Heun's method
%   Initial condition is y(t0) = y0, output is y(t) sampled by dt up to T.

t = t0:dt:T;
y = zeros(1, length(t));
y(1) = y0;

for i = 1:length(t)-1
    yp = y(i) + dt * f(t(i), y(i)); % y(i+1) estimate using EE
    y(i+1) = y(i) + dt/2 * (f(t(i),y(i)) + f(t(i+1), yp));
end

end
