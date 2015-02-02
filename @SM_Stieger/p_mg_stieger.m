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


p = SM_Hard_sphere.p_hard_sphere(qr) .* (exp(-f.*q./2)).^2;

end

