function c = linear_regression( x, y )

%V = [ length(x) sum(x)
%      sum(x)    sum(x .^ 2) ];

%W = [ sum(y)
%      sum(x .* y) ];

%c = V \ W;

A = [ ones(length(x), 1) x];

c = (A' * A) \ (A' * y);

end
