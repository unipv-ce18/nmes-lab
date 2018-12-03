function q = mintegral( fun, xmin, xmax, n )
%MINTEGRAL Numerically evaluate integral using the midpoint rule.
%   Q = MINTEGRAL(FUN,A,B,N) approximates the integral of function FUN
%   from A to B using the midpoint rule over N intervals.
%
%   See also INTEGRAL

% Example, using N = 2 intervals of integration, XMIN = .1 to XMAX = .3:
%   - Intervals of width .1, centers are in .15 and .25
%   - Integration result is sum of rectangles with height FUN(centers)
%
% If FUN is F * "triangle of width 2h centered in .2, height 1"
%   - triangle(.15) = triangle(.25) = 1/2
%   - result is -> .1 "interval width" * F(.15) * 1/2 + .1 * F(.25) * 1/2
%   - "interval width" = h = .1 is a mere coincidence and changes w/ N != 2

% Define extremes of the integration intervals
s = linspace(xmin, xmax, n+1);

% Find the midpoint value of these intervals
midpts = mean([s(1:end-1); s(2:end)]);

% Evaluate the function at these midpoints
heights = arrayfun(fun, midpts);

% We need to sum the area of all the rectangles
% of interval width and evaluated function height.

% This is the width of an interval
w = (xmax - xmin) / n;

% Instead of multiplying each height for its width,
% we can extract it outside the sum.
q = w * sum(heights);
end
