function bq = f_hmg(q,r,dr)
%F_HMG Scattering amplitude of a hollow microgel particle
%   
%   bq = f_hmg(q,r,dr)
%
% Parameters
% q         Scattering vector magnitudes
% r         Outer radius of the particle
% dr        Decay rate of the profile
%
% Returns
% bq        Scattering length of the particle

qr = r(:) * q(:)';
rmg = r(:) * ones(1, numel(q));
q = ones(numel(r),1) * q(:)';

bq = 4.*pi./(q.*(dr.^2+q.^2)).* ...
    ((dr.*rmg + (q.^2-dr.^2)./(dr.^2+q.^2)).*sin(qr) + ...
    (2.*q.*dr./(dr.^2+q.^2) - qr).* cos(qr) - ...
    2.*q.*dr.*exp(-dr.*rmg)./(dr.^2+q.^2));

end

