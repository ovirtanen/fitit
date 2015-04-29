function [rprf,prf] = radial_profile(obj)
%RADIAL_PROFILE Radial profile for Stieger microgel
%
%   [rprf,prf] = radial_profile()
%

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.

mean = obj.dist.mean();
fuzz = obj.get_param('fuzz_val');
nc = 100;
rng = mean + 2.*fuzz;    % range of values

w = rng ./ nc;                      % quadrature weight rng - (-rng) / nc
rprf = -rng + w .* ((1:2*nc)-0.5)';   % equidistant grid points

f = ones(numel(rprf),1);
f(abs(rprf) > mean) = 0;
g = sqrt(2)./(fuzz.*sqrt(pi)).*exp(-2.*rprf.^2./(fuzz.^2));      % Pedersen's gaussian, A = 1

prf = conv2(f,g.*w,'same');            % vector convolution, add weight. Conv2 slightly faster than conv

fil = rprf > 0;

rprf = rprf(fil);
prf = prf(fil);

end

