function r = reg(obj,p)
%REG Regularization term for SM_Free_profile
%
%   r = reg(p)
%
% Parameters
% p             Model parameter vector, where
%                   p(1)        Scattering amplitude
%                   p(2)        Regularization parameter lambda (not needed here)
%                   p(3)        Polariszation density of the 1st step
%                   .
%                   .
%                   p(n+2)      Polarization density of the nth step
%                   p(n+3:end)  Parameters for the PSD
%
% Returns
% r             Regularization term
%

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.

n = obj.n;
lambda = 10.^p(2);

r = lambda.^2 .* sum(1./p(3:n+2).^2);

end

