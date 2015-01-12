function [intst,rpd,rpsd,psd] = scattered_intensity(q,a,nc,tau,vskin,fuzz,psd_m,psd_w)
%SCATTERED_INTENSITY Model expression for the scattered intensity by
%microgel particles
%
% [intst,rpd,rpsd,psd] = scattered_intensity(q,nc,rfrac,vcore,vexc,fuzz,psd_m,psd_w)
%
% Parameters
% q             scattering vector magnitude where form factor is evaluated
% a             amplitude term incorporating contrast and number of
%               particles etc
% nc            number of collocation points
% vskin         max relative polarization density at the top of the ramp
% fuzz          fuzziness factor, std of the gaussian
% psd_m         mean of the particle radius distribution (Gaussian)
% psd_w         std of the particle radius distribution  
%
% Returns
% intst         scattered intensity at points q     
% rpd           radial collocation points used for the polarization density
%               profile
% rpsd          collocation points used for the particle radius
%               distribution
%


w = ((psd_m + 4.*psd_w) - (psd_m - 4.*psd_w)) ./ nc;    % take collocation points 4 stds from the mean
rpsd = (psd_m-4.*psd_w) + w .* ((1:nc)-0.5)';           % equidistant grid points for psd

%w = ((psd_m + 4.*psd_w) - (psd_m - 9.*psd_w)) ./ nc;    % take collocation points 4 stds from the mean
%rpsd = (psd_m-9.*psd_w) + w .* ((1:nc)-0.5)';           % equidistant grid points for psd

psd = normpdf(rpsd,psd_m,psd_w);
%psd = evpdf(flipud(rpsd),psd_m,psd_w);
%psd = wblpdf(flipud(rpsd),psd_m,psd_w);

%w = mean(diff(rpsd)); % quadrature weight, average rounding errors

intst = zeros(numel(q),1);

for p = 1:numel(psd)
    
    [rpd, pd] = Model.pd_profile(nc,rpsd(p),tau,vskin,fuzz);
    intst = intst + a .* psd(p).* Model.vnumP(rpd,w,pd,q) .* w;
    
end % for

end

