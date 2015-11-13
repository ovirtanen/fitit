function v = res_variance(qn,a,b)
%RES_VARIANCE q dependent variance of the resolution function
%   
%   v = res_variance(a,b)
%
% Parameters
% qn            Nominal q value
% a             Constant term
% b             Quadratic term
%
% Returns
% v         Variance of the q distribtion (sigma^2)
%
% Freltoft, T., Kjems, J. K., & Sinha, S. K. (1986). 
% Physical Review B, 33(1), 269?275. 
% http://doi.org/10.1103/PhysRevB.33.269

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.


v = a + b.*qn.^2;


end

