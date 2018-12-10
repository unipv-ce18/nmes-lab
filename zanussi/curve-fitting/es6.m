%% Test linear_regression

load least_squares_data.mat

c = linear_regression(x, y);

hold on;
plot(x, y, 'x')
fplot(@(x) c(1) + c(2) * x, [min(x), max(x)])

%% Test quadratic_regression

load least_squares_data.mat

c = quadratic_regression(x, y);

hold on;
plot(x, y, 'x')
fplot(@(x) c(1) + c(2) * x + c(3) * x.^2, [min(x), max(x)])
