function c = chi2reg(nc,q_exp,i_exp,std,p,active_handles,handles,regh)
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

c = 0;

% combined intensity from all the models
% numel(active_handles) == numel(obj.data_sets)
for i = 1:numel(active_handles)
    
    i_mod = zeros(numel(i_exp{i}),1);
    ah = active_handles{i};
    h_set = handles(ah);
    
    for j = 1:numel(h_set)
        
        h = h_set{j};
        i_mod = i_mod + h(nc,q_exp{i},p);
        
    end
    
    c = c + sum(((i_exp{i} - i_mod)./std{i}).^2);
    
end % for

c = c + regh(p);

end

