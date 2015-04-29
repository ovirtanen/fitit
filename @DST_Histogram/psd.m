function [rpsd,psd,w] = psd(obj,~,p)
%PSD Returns custom PSD and collocation points
%   
%   [rpsd,p,w] = psd(nc,p)
%
%   Parameters
%   nc          Number of collocation points for the distribution
%   p           Parameter vector, where
%                   p(1)    Shift of the histogram (nm)
%
%   Returns
%   rpsd        Collocation points
%   psd         Value of the PSD at rpsd
%   w           Quadrature weight for midpoint rule

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.


shift = p(1);

w = obj.w ;                                     % quadrature weight
rpsd = obj.rpsd + shift;                        % equidistant grid points for psd

psd = obj.hpsd;

end

