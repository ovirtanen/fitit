function x = snc(x)
% SNC Sinc function
% x = snc(x)

f = x == 0;
x = sin(x)./x;
x(f) = 1;
        
end

