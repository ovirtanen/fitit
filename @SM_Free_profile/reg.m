function r = reg(obj,p,d)
%REG Regularization term for SM_Free_profile
%
%   r = reg(p)
%
% Parameters
% p             Model parameter vector, where
%                   p(1)        Regularization parameter lambda (not needed here)
%                   p(2)        Scattering amplitude
%                   p(3)        Polariszation density of the 1st step
%                   .
%                   .
%                   p(n+2)      Polarization density of the nth step
%                   p(n+3:end)  Parameters for the PSD
% d                 order of the smoothing norm        
%                   0       Standard norm
%                   1       1st derivative norm
%                   2       2nd derivative norm
%
% Returns
% r             Regularization term
%

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.

n = obj.n;
lambda = 10.^p(1);
prf = p(3:n+2);


switch d
    
    case 0
        
        r = lambda.^2 .* sum((1./prf).^2);
        
    case 1
        
        r = lambda.^2 .* sum(diff((1./prf)).^2);
        
    case 2

        r = lambda.^2 .* sum(diff((1./prf),2).^2);
        
    otherwise
        
        error('Invalid norm.');

end

end

