function m = mean(obj,~)
%MEAN Mean of the histogram distribution
%   m = mean()
%
%   Returns
%   m           mean of the distribution
%
%

w = mean(diff(obj.rpsd));
m = sum(obj.rpsd .* obj.hpsd  .* w);

end

