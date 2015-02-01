function x = rm_nan(x,f)
%RM_NAN Replace NaN elements with 1
% x = rm_nan(x,f), where f is logical array of size(x) specifying elements
% to be replaced.

x(f) = 1;
        
end

