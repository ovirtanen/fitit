function p = p_mg_stieger(qr,q,f)
%P_MG_STIEGER Form factor for Stieger microgel model
%   
%
%   p = p_mg_stieger(qr,q,f)
%
%   Parameters
%   qr          matrix with values qr
%   q           matrix with the same dimensions as qr but contains only q
%               values
%   f           fuzziness parameter

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.


p = (SM_Hard_sphere.f_hard_sphere(qr) .* exp(-f.*q./2)).^2;

end

