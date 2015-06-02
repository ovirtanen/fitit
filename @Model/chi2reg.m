function c = chi2reg(i_exp,std,p,handles,regh)
%CHI2 Calculates Chi squared with regularization of multiple model expressions
%   
%   c = chi2(intst,std,p,handles,regh) iterates through all the model
%   expressions given by function handles in handles and returns the chi
%   squared for the combined model, including regulariztion term
%   
%   The reqularized chi2 has the form:
%
%   c = ||(Ax - b)./std(b)||^2 + lambda^2 * ||x||^2, where ||.|| is the 
%   Euclidean norm. regh needs to encompass the whole second term.
%
%   Parameters
%   i_exp           Experimental intensity
%   std             Experimental standard deviation
%   p               Combined parameter vector for all handles
%   handles         Cell array of handles to models, h = @(p)
%                   f(nc,q,p(5:8)), see lsq_fit
%   regh            Handle to a regularization term
%   
%   Returns
%   c               Chi squared
%
%

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.

i_mod = zeros(numel(i_exp),1);

% combined intensity from all the models
for i = 1:numel(handles)
   
    h = handles{i};
    i_mod = i_mod + h(p);
    
end % for

c = sum(((i_exp-i_mod)./std).^2) + regh(p);

end

