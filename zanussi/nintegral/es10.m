N = 10;
fun = @(x) sin(pi*x);
% integral from 0 to 1 should be 2/pi

fprintf('Comparing integration rules (expected %.4f):\n', 2/pi);
fprintf('\t%-18s%.4f\n', 'Midpoint rule:', midpoint(fun, 0, 1, 10));
fprintf('\t%-18s%.4f\n', 'Trapezoidal rule: ', trapezoidal(fun, 0, 1, 10));
fprintf('\t%-18s%.4f\n', 'Simpson rule: ', simpson(fun, 0, 1, 10));
