function m = burr_moments(o,a,c,k)
%BURR_MOMENTS Calculates moments of the Burr XII distribution
%  
%   m = burr_moments(o,a,c,k)
%
% Parameters
% o         order of the moment
% a         Burr parameter a
% c         Burr parameter c
% k         Burr parameter k
%
% Returns
% m         the oth moment of the distribution

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.

try
    m = a.^o .* k .* beta((c.*k-o)./c,(c+o)./c);

catch ME

    display(o);
    display(a);
    display(c);
    display(k);
    
    rethrow(ME);
end

end

