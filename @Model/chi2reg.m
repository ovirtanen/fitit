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
%   nc              Number of integration points for the PSD
%   q_exp           Cell array containing experimental q values for all
%                   datasets
%   i_exp           Cell array containing experimental intensity for all
%                   datasets
%   std             Cell array containing standard deviation of intensity 
%                   for all datasets
%   p               Combined parameter vector for all handles
%   active_handles  Cell array containing arrays indicating which handles
%                   are active for each dataset
%   handles         Cell array of handles to models, each handle accepts
%                   three arguments h(nc,q,p)
%   regh            Handle to a regularization term, regh(p)
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
    
    %c = c + sum((log10(i_exp{i}).^2.*(i_exp{i} - i_mod)./std{i}).^2);
    c = c + sum(((i_exp{i} - i_mod)./std{i}).^2);
    
end % for

c = c + regh(p);

end

