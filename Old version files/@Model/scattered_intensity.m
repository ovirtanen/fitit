function [intst,rpd,rpsd,psd] = scattered_intensity(q,amp,nc,tau,vskin,fuzz,p_a,p_c,p_k)
%SCATTERED_INTENSITY Model expression for the scattered intensity by
%microgel particles
%
% [intst,rpd,rpsd,psd] = scattered_intensity(q,nc,rfrac,vcore,vexc,fuzz,psd_m,psd_w)
%
% Parameters
% q             scattering vector magnitude where form factor is evaluated
% amp           amplitude term incorporating contrast and number of
%               particles etc
% nc            number of collocation points
% vskin         max relative polarization density at the top of the ramp
% fuzz          fuzziness factor, std of the gaussian
% p_a           Burr parameter a, location parameter
% p_c           Burr parameter c, "left skewness" parameter
% p_k           Burr parameter k, "right skewness" parameter
%
% Returns
% intst         scattered intensity at points q     
% rpd           radial collocation points used for the polarization density
%               profile
% rpsd          collocation points used for the particle radius
%               distribution
%


% Burr
m1 = Model.burr_moments(1,p_a,p_c,p_k);         % 1st moment = mean
m2 = Model.burr_moments(2,p_a,p_c,p_k);         % 2nd moment
std = sqrt(-m1.^2 + m2);                        % variance = -m1.^2 + m2

lowlimit = max([0 m1 - 4.* max([1 p_k]) .* std]); % totally arbitrary limits
highlimit =  m1 + 6 .* std;

w = (highlimit-lowlimit) ./ nc;                 % quadrature weight
rpsd = lowlimit + w .* ((1:nc)-0.5)';           % equidistant grid points for psd

psd = Model.burrpdf(rpsd,p_a,p_c,p_k);

intst = zeros(numel(q),1);

for p = 1:numel(psd)
    
    [rpd, pd] = Model.pd_profile(nc,rpsd(p),tau,vskin,fuzz);
    intst = intst + amp .* psd(p).* Model.vnumP(rpd,w,pd,q) .* w;
    
end % for

end

