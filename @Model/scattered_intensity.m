function [intst,rpd,rpsd,psd] = scattered_intensity(q,a,nc,rfrac,vcore,vexc,fuzz,psd_m,psd_w)
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
% rfrac         fraction of rhard when the ramp begins, e.g. 0.5
% vcore         relative polarization density of the core
% vexc          excess relative polarization density at the top of the ramp, e.g. 1.1
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
% ---------------------------
% Example:
% q = linspace(0.001,0.025,200);
% [intst,rpd,rpsd,psd] = Model.scattered_intensity(q,100,0.7,1,1.1,25,400,20);
%

rpsd = linspace(psd_m-3.*psd_w,psd_m+3.*psd_w,nc); % take collocation points 3 stds from the mean
psd = normpdf(rpsd,psd_m,psd_w);

w = mean(diff(rpsd)); % quadrature weight, average rounding errors

intst = zeros(numel(1),1);

for p = 1:numel(psd)
    
    [rpd, pd] = Model.pd_profile(nc,rpsd(p),rfrac,vcore,vexc,fuzz);
    intst = intst + a .* psd(p).* Model.numP(rpd,pd,q) .* w;
    
end % for

end

