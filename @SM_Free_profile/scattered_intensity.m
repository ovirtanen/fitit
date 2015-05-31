function i_mod = scattered_intensity(obj,nc,q,p)
%SCATTERED_INTENSITY Scattered intensity of a spherical cocentric shells
%particle
%   i_mod = scattered_intensity(nc,q,p)
%
%   Parameters
%   nc          Number of integration points for the distribution
%   q           Scattering vector magnitudes
%   p           Parameter vector p, where
%                   p(1)        Scattering amplitude
%                   p(2)        Polariszation density of the 1st step
%                   .
%                   .
%                   p(n)        Polarization density of the nth step
%                   p(n+1:end)  Parameters for the PSD
%
%   Returns
%   i_mod       Scattered intensity at points q
%
%   Pedersen, J. S. Advances in Colloid and Interface Science 1997, 70, 171-210.

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.

% Particle structure
%
% ^ prf
% |    ---
% |---|   |---
% |   |   |   |
% |   |   |   |
% |   |   |   |
% ------------------> rprf
% 0  rs1 rs2 rs3 == rp
%
% rs: radius of a shell
% rp: radius of the particle

%% Collect inputs
n = obj.n;
a = p(1);
prf = p(2:n+1);              % polarization density profile
rprf = ((1:n)./n)';          % radii of the cocentric shells (fractional)

[rpsd,psd,w] = obj.dist.psd(nc,p(n+2:end));

% Numerical integration over the distribution using the mid-point rule

% rs = [rs1 rs1 rs1 ... rs1          q = [q1 q2 q3 ... qn
%       rs2 rs2 rs2 ... rs2               q1 q2 q3 ... qn
%        .   .   .       .                .  .  .      .
%       rp  rp  rp ...  rp]              q1 q2 q3 ... qn]
%

%% 3D matrix for the particle radii

rs = rprf(:) * ones(1,numel(q));

rs = repmat(rs,[1,1,numel(rpsd)]);  % Fractional 3d particle radii matrix
rs = obj.mult3(rs,rpsd(:));

%% Expand q to the same dimensions

qq = ones(numel(rprf),1) * q(:)';
qq = repmat(qq,[1,1,numel(rpsd)]);

%%  Calculate the scattering amplitudes of all the size fractions of the core-shell particles

m3f3 = obj.f_hard_sphere(rs .* qq);     % m3f3 is the scattering amplitude multiplied by the scattering mass weight
dprf = prf - [prf(2:end); 0];           % polarization density differences between adjacent shells
smw = 4./3.*pi.*(rs).^3;                % Scattering mass weight for each shell in each particle size fraction
m3f3 = smw .* bsxfun(@times,dprf,m3f3);
m3f3 = sum(m3f3,1);                     % sum down the columns to get scattering amplitude of each particle size fraction
m3f3 = squeeze(m3f3);                   % remove the singleton dimension, now each column contains m3f3(q) for each particle size fraction

v2p = m3f3.^2 * (w .* psd(:));          % weight each fraction according to the PSD. v2 = m3.^2; p = f3.^2

%% Scattering mass normalizer. 
% Dividing the scattered intensity with the
% normalizer normalizes the integral of the (scattering mass)^2 weighted PSD
% to 1, resulting in P(0) = 1.

smn = squeeze(smw(:,1,:));              
smn = bsxfun(@times,dprf,smn);
smn = sum(smn,1);                       % scattering mass weight, for each particle!

smn = (smn(:).^2)' * (w .* psd(:)); 

%% Scattered intensity

i_mod = a ./smn .* v2p;

