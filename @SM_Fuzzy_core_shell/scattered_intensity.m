function i_mod = scattered_intensity(obj,nc,q,p)
%SCATTERED_INTENSITY Scattered intensity of core shell particle
%   i_mod = scattered_intensity(nc,q,p)
%
%   Parameters
%   nc          Number of collcation points for the distribution
%   q           Scattering vector magnitudes
%   p           Parameter vector p, where
%                   p(1)        Number of particles
%                   p(2)        Width of the particle chell
%                   p(3)        Width of the particle core
%                   p(4)        Width of the interpenetration region of
%                               core and shell
%                   p(5)        Relative scattering contrast *
%                               polymer volumefraction of the core
%                   p(6)        Relative scattering contrast *
%                               polymer volumefraction of the shell
%                   p(5:end)    Parameters for the PSD
%                   sigmaS      Dependent parameter: R - p(2)-p(3)-p(4)
%
%
%   Returns
%   i_mod       Scattered intensity at points q
%
%   I. Berndt, J.S. Pedersen, P. Lindner, W. Richtering, Langmuir 22 (2006) 459.
%   M. Stieger, W. Richtering, J.S. Pedersen, P. Lindner, J. Chem. Phys. 120 (2004) 6197.

% Copyright (c) Otto Virtanen and Arjan Gelissen 2016
% All rights reserved.

a = p(1);
Rbox_frac = p(2); % Rbox as fraction of total particle radius rpsd(i)
sigmaC_frac = p(3);
RS_frac = p(4);
volfracC = p(5);
volfracS = p(6);

% frc = p(2);
% pdc = p(3);
% pds = p(4);

intst = zeros(size(q));

[rpsd,psd,~] = obj.dist.psd(nc,p(7:end));

normalizer = 0;

for i = 1 : numel(rpsd)
    
    R_tot = rpsd(i);
    Rbox = Rbox_frac .* R_tot;
    sigmaC = sigmaC_frac .* (R_tot-Rbox)./2;
    RS = RS_frac .* (R_tot - Rbox - 2.*sigmaC);
    sigmaS = (R_tot - (Rbox + RS + 2.*sigmaC))/2;
    
    %rho_core = volfracC*(Rbox + sigmaC);
    %m_core = obj.vol_sphere(Rbox+sigmaC) * rho_core/(Rbox + sigmaC); % Scattering weight core
    
    
    %rho_shell = volfracS * (sigmaC + RS + sigmaS);                  
    %m_shell = (obj.vol_sphere(R_tot-sigmaS) - obj.vol_sphere(Rbox+sigmaC))* (rho_shell/(sigmaC + RS + sigmaS)); % Scattering weight shell
    
    
    r_out = R_tot - sigmaS;
    r_in = Rbox + sigmaC;
    
    %v_core = obj.vol_sphere(r_in);
    v_core = 4*pi*(r_in.^3/3 + r_in.*sigmaC.^2./6);
    v_shell = 4*pi*(r_out.^3/3 + r_out.*sigmaS.^2./6);
    %v_shell = obj.vol_sphere(r_out) - obj.vol_sphere(r_in);
    
    normalizer = normalizer + psd(i) * (volfracS .* v_shell + (volfracC - volfracS) .* v_core).^2;
   
    intst = intst + psd(i) .* (volfracS .* v_shell .* obj.phi(q,r_out,sigmaS) + (volfracC - volfracS) .* v_core .* obj.phi(q,r_in,sigmaC)).^2;
    %intst = intst + psd(i) .* (m_shell .* obj.phi(q,r_out,sigmaS) + m_core .* obj.phi(q,r_in,sigmaC)).^2;
    
end

i_mod = a .* intst./normalizer;

% Numerical integration over the distribution using the mid-point rule

% r = [r1 r1 r1 ... r1          q = [q1 q2 q3 ... qn
%      r2 r2 r2 ... r2               q1 q2 q3 ... qn
%       . .  .      .                .  .  .      .
%      rn rn rn ... rn]              q1 q2 q3 ... qn]
%

%rt = rpsd(:) * ones(1,numel(q));                            % total particle radius
%rc = frc ./ 100 .* rt;                                      % core radius

%psdw = psd(:) * (w .* ones(1,numel(q)));                    % PSD and quadrature weight



% Scattering weight normalizer. Dividing the scattered intensity with the
% normalizer normalizes the integral of the (scattering mass)^2 weighted PSD
% to 1, resulting in P(0) = 1.

%swn = sum(SM_Core_shell.m3(rpsd(:),frc./100.*rpsd(:),pds,pdc).^2 .*w .* psd(:)); 

%q = ones(numel(rpsd),1) * q(:)';

%i_mod = a ./swn .* sum(psdw  .* SM_Fuzzy_core_shell.m3(rt,frc./100.*rt,pds,pdc).^2 .*  SM_Fuzzy_core_shell.f3(q,rt,rc,pds,pdc).^2)';


end

