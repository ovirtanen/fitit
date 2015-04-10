function i_mod = scattered_intensity(obj,nc,q,p)
%SCATTERED_INTENSITY Scattered intensity of mixture of core shell particles
%and doublets formed from these particles at random
%
%   i_mod = scattered_intensity(nc,q,p)
%
%   Parameters
%   nc          Number of collcation points for the distribution
%   q           Scattering vector magnitudes
%   p           Parameter vector p, where
%                   p(1)        Scattering amplitude
%                   p(2)        Fraction of singlets
%                   p(3)        Fractional radius of the core
%                   p(4)        Polarization density of the core
%                   p(5)        Polarization density of the shell
%                   p(6:end)    Parameters for the PSD
%
%   Returns
%   i_mod       Scattered intensity at points q
%
%   Pedersen, J. S. Advances in Colloid and Interface Science 1997, 70, 171-210.



a = p(1);
frs = p(2) ./ 100;      % note change to fraction
frc = p(3) ./ 100;      % note change to fraction
pdc = p(4);
pds = p(5);

% Singlets ----------------------------------------------------------------

[rpsd,psd,w] = obj.dist.psd(nc,p(6:end));

% Numerical integration over the distribution using the mid-point rule

% r = [r1 r1 r1 ... r1          q = [q1 q2 q3 ... qn
%      r2 r2 r2 ... r2               q1 q2 q3 ... qn
%       . .  .      .                .  .  .      .
%      rn rn rn ... rn]              q1 q2 q3 ... qn]
%


rt = rpsd(:) * ones(1,numel(q));                    % total particle radius

psdw = frs .* psd(:) * (w .* ones(1,numel(q)));     % PSD and quadrature weight FOR SINGLETS (frs)

% scattering weight normalizer for singlets
mwns = sum(SM_Core_shell.m3(rpsd(:),frc.*rpsd(:),pds,pdc).^2 .* w .* frs.* psd(:)); 

qq = ones(numel(rpsd),1) * q(:)';

i_sing = sum(psdw .* SM_Core_shell.m3(rt,frc.*rt,pds,pdc).^2 .* SM_Core_shell.f3(qq,rt,(frc .* rt),pds,pdc).^2)';

% Dumbbels ----------------------------------------------------------------
% PSD given to dumbbells = (1-frs) .* psd


%t = tic();

switch obj.gpu_enabled
   
    case 1 
        
        [i_dum, mwnd] = SM_MG_dumbbell.i_dumbbellGPUh(q,rpsd,(1-frs) .* psd,w,frc,pds,pdc);
   
    case 0
        
        [i_dum, mwnd] = SM_MG_dumbbell.i_dumbbell(q,rpsd,(1-frs) .* psd,w,frc,pds,pdc);
        
    otherwise
        
        error('Invalid GPU capability.');
    
end

%display(toc(t));

% normalize according to the scattering weights
i_mod = a ./ (mwns + mwnd) .* (i_sing + i_dum);

end

