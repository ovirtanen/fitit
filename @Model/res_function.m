function r = res_function(q,qn,sigma2)
%RES_FUNCTION Resolution function for small-angle scattering
%   
%   r = res_function(q,qn,sigma)
%
% Arguments
% q         q grid where r is evaluated
% qn        Nominal q value (instrument setting)
% sigma2    Smearing factor depending on instrumental configuration. Note
%           that sigma2 consist of variances of different smearing factors
%           such as wavelength spread and collimation effects.
%
% Returns
% r         Distribution of q values due to smearing
%
% Freltoft, T., Kjems, J. K., & Sinha, S. K. (1986). 
% Physical Review B, 33(1), 269?275. 
% http://doi.org/10.1103/PhysRevB.33.269

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.

r = qn./sigma2 .* exp(-(q.^2 + qn.^2)./(2.*sigma2)) .* besseli(0,(qn.*q./sigma2));

end

