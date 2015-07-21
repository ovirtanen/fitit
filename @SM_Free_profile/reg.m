function r = reg(~,p,d)
%REG Regularization term for SM_Free_profile
%
%   r = reg(p)
%
% NOTE: Model.lsq_fit is responsible for formatting the parameter vector to
% be suitable for reg!
%
% Parameters
% p             Model parameter vector, where
%                   p(1)        Regularization parameter lambda
%                   p(2)        Polarization density of the 1st step
%                   .
%                   .
%                   p(n+1)      Polarization density of the nth step
% d                 order of the smoothing norm:       
%                       0       Standard norm
%                       1       1st derivative norm
%                       2       2nd derivative norm
%
% Returns
% r             Regularization term
%

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.

lambda = 10.^p(1);
prf = p(2:end);


switch d
    
    case 0
        
        r = lambda.^2 .* sum((1./prf).^2);
        
    case 1
        
        %r = lambda.^2 .* sum(diff((1./prf)).^2);
        r = lambda.^2 .* sum(diff(prf).^2);
    case 2

        r = lambda.^2 .* sum(diff(prf,2).^2);
        
    otherwise
        
        error('Invalid norm.');

end

end

