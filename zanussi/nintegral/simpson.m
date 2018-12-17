function q = simpson( fun, xmin, xmax, n  )
h = (xmax - xmin) / n;

s = linspace(xmin, xmax, n+1);
params = [s(1:end-1); s(2:end)];
partsum = sum([1; 1; 4] .* fun([params; mean(params)]));

q = h / 6 * sum(partsum);
end
