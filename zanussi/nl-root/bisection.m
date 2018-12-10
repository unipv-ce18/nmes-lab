function [ x, its ] = bisection( f, a, b, tol, maxits )

interval = [a b];
its = 0;

while true

    if its >= maxits
        warning('Maximum number of iterations reached');
        break; 
    end
    its = its + 1;
    
    x = mean(interval);

    if abs(f(x)) < tol
        break;
    end

    if f(interval(1)) * f(x) < 0
        % 0 is in the interval [a c]
        interval = [interval(1) x];
        continue;
    end

    if f(x) * f(interval(2)) < 0
        % 0 is in the interval [c b]
        interval = [x interval(2)];
        continue;
    end

    error('This should not happen! (No zero crossing in this region?)');
    
end

end

