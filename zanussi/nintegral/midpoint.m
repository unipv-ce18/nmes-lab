function q = midpoint( fun, xmin, xmax, n )
h = (xmax - xmin) / n;

s = linspace(xmin, xmax, n+1);
params = mean([s(1:end-1); s(2:end)]);
partsum = fun(params);

q = h * sum(partsum);
end
