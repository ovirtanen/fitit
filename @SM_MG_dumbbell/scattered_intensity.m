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
%   Pedersen, J. S. Advances in Colloid and Interface Science 1997, 70, 171?210.



a = p(1);
frs = p(2);
frc = p(3);
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

psdw = psd(:) * (w .* ones(1,numel(q)));            % PSD and quadrature weight

qq = ones(numel(rpsd),1) * q(:)';

i_sing = sum(psdw .* SM_Core_shell.f3(qq,rt,(frc ./ 100 .* rt),pds,pdc).^2)';

% Dumbbels ----------------------------------------------------------------


%t = tic();
%i_dum = SM_MG_dumbbell.i_dumbbell(q,rpsd,psd,w,frc./100,pds,pdc);
i_dum = SM_MG_dumbbell.i_dumbbellGPUh(q,rpsd,psd,w,frc./100,pds,pdc);
%display(toc(t));
i_mod = a .* (frs./100 .* i_sing + (100-frs)./100 .* i_dum);

%{
i_dum = zeros(numel(q),1);
t = tic();
for i = 1:numel(q)
    
    % Grid, where (i,j) is the contribution of dumbbells comprised of
    % particles with total radii of r1(i) and r2(j) at scattering vector
    % magnitude q
    allc = SM_MG_dumbbell.p4(q(i),frc./100,r1,r2,pds,pdc) .* psdw;
    
    i_dum(i) = sum(allc(:));
    
end

i_mod = a .* (frs./100 .* i_sing + (100-frs)./100 .* i_dum);
display(toc(t));

%}
end

