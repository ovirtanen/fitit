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
%                   p(2)        Fraction of multiplets
%                   p(3)        Fraction of triplets
%                   p(4)        Fraction of linear triplets
%                   p(5)        Fractional radius of the core
%                   p(6)        Polarization density of the core
%                   p(7)        Polarization density of the shell
%                   p(8:end)    Parameters for the PSD
%
%   Returns
%   i_mod       Scattered intensity at points q
%
%   Pedersen, J. S. Advances in Colloid and Interface Science 1997, 70, 171-210.



a = p(1);
frml = p(2) / 100;     % note change to fraction
frtr = p(3) / 100;     % note change to fraction
frl = p(4) / 100;      % note change to fraction
frc = p(5) / 100;      % note change to fraction
pdc = p(6);
pds = p(7);


% Singlets ----------------------------------------------------------------

[rpsd,psd,w] = obj.dist.psd(nc,p(8:end));


% Numerical integration over the distribution using the mid-point rule

% r = [r1 r1 r1 ... r1          q = [q1 q2 q3 ... qn
%      r2 r2 r2 ... r2               q1 q2 q3 ... qn
%       . .  .      .                .  .  .      .
%      rn rn rn ... rn]              q1 q2 q3 ... qn]
%


rt = rpsd(:) * ones(1,numel(q));                    % total particle radius

psdw = (1-frml) .* psd(:) * (w .* ones(1,numel(q)));   % PSD and quadrature weight FOR SINGLETS (1-frml)

% scattering weight normalizer for singlets
swsng = sum(SM_Core_shell.m3(rpsd(:),frc.*rpsd(:),pds,pdc).^2 .* w .* (1-frml).* psd(:)); 

qq = ones(numel(rpsd),1) * q(:)';

i_sing = sum(psdw .* SM_Core_shell.m3(rt,frc.*rt,pds,pdc).^2 .* SM_Core_shell.f3(qq,rt,(frc .* rt),pds,pdc).^2)';

% Doublets ----------------------------------------------------------------

% calculate doublets only if there are doublets
if frml > 0 && frtr ~= 100

frdbl = frml .* (1-frtr); % fraction doublets    

    if obj.gpu_enabled
            
        [i_dbl, swdbl] = SM_MG_triplets.i_dumbbellGPUh(q,rpsd, (frdbl .* psd),w,frc,pds,pdc);
        
    else
        
        % i_dumbbellPAR doesn't use any explicit parallel functions
        [i_dbl, swdbl] = SM_MG_triplets.i_dumbbellPAR(q,rpsd, (frdbl .* psd),w,frc,pds,pdc);
    
    end % if
    
else
    
    i_dbl = 0;
    swdbl = 0;
    
end % if



% Tripets -----------------------------------------------------------------



%t = tic();

% calculate triplets only if there are triplets
if frml > 0 && frtr > 0
    
frtr = frml .* frtr; % fraction triplets    

    if obj.gpu_enabled
        
        [i_trpl, swtrpl] = SM_MG_triplets.i_tripletsGPU(q,rpsd, (frtr .* psd),w,frl,frc,pds,pdc);
   
    elseif obj.par_enabled
        
        [i_trpl, swtrpl] = SM_MG_triplets.i_tripletsPAR(q,rpsd, (frtr .* psd),w,frl,frc,pds,pdc);
        
    else
        
        error('Parallel execution recommended.');
        
    end % switch
    
else
   
    i_trpl = 0;
    swtrpl = 0;
    
end % if

%display(toc(t));

% normalize according to the scattering weights
i_mod = a ./ (swsng + swdbl + swtrpl) .* (i_sing + i_dbl + i_trpl);

end

