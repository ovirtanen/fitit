function [bn] = noise(b,rnl)
%NOISE Add noise to datapoints
%   [bn] = noise(b,rnl), where b is data points and rnl is the relative
%   noise level, returns datapointes perturbated by gaussian noise

b = b(:);
e = randn(length(b),1);

e = e ./ norm(e);

e = rnl .* norm(b) .* e;

bn = b + e;


end

