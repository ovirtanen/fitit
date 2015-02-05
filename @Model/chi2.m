function c = chi2(i_exp,std,p,handles)
%CHI2 Calculates Chi squared of multiple model expressions
%   
%   c = chi2(intst,std,p,handles) iterates through all the model
%   expressions given by function handles in handles and returns the chi
%   squared for the combined model
%
%   Parameters
%   i_exp           Experimental intensity
%   std             Experimental standard deviation
%   p               Combined parameter vector for all handles
%   handles         Cell array of handles to models, h = @(p)
%                   f(nc,q,p(5:8)), see lsq_fit
%   
%   Returns
%   c               Chi squared
%
%

i_mod = zeros(numel(i_exp),1);

% combined intensity from all the models
for i = 1:numel(handles)
   
    h = handles{i};
    i_mod = i_mod + h(p);
    
end % for

c = sum(((i_exp-i_mod)./std).^2);

end

