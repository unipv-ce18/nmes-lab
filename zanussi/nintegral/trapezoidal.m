function q = trapezoidal( fun, xmin, xmax, n  )
h = (xmax - xmin) / n;

s = linspace(xmin, xmax, n+1);
params = [s(1:end-1); s(2:end)];
partsum = sum(fun(params));

q = h / 2 * sum(partsum);
end

