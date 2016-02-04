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
% Physical Review B, 33(1), 269-275. 
% http://doi.org/10.1103/PhysRevB.33.269
%
% Pedersen, J. S., & Riekel, C. (1991).
% Journal of Applied Crystallography, 24(5), 893?909. 
% http://doi.org/10.1107/S0021889891003692
%

% Copyright (c) 2015, 2016 Otto Virtanen
% All rights reserved.

r = q./sigma2 .* exp(-(qn.^2 + q.^2)./(2.*sigma2)) .* besseli(0,(qn.*q./sigma2));

end

