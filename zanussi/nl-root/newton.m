function [ x, its ] = newton( f, derf, x0, tol, maxits )

its = 0;
x = x0;

while true

    if its >= maxits
        warning('Maximum number of iterations reached');
        break; 
    end
    its = its + 1;
    
    x = x - f(x)/derf(x);
    
    if isnan(x)
        error('Newton method diverges for x0 = %.2f (%d iterations)', ...
            x0, its);
    end

    if abs(f(x)) < tol
        break;
    end
    
end

end

