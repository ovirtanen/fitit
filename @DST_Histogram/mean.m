function m = mean(obj,~)
%MEAN Mean of the histogram distribution
%   m = mean()
%
%   Returns
%   m           mean of the distribution
%
%

m = sum(obj.rpsd .* obj.hpsd);

end

