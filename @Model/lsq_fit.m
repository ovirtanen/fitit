function [p, std_p] = lsq_fit(obj,varargin)
%LSQ_FIT Least squares fit on the experimental data
%   
%   p = lsq_fit() performs a least squares fit on single experimental data
%   set and returns total parameter vector for all the included models and
%   their distributions
%
%   p = lsq_fit(options), performs the fit using options. Can be used e.g.
%   to set an output function
%
%   Parameters
%   options     optim.options.Fmincon
%
%   Returns
%   p           Total parameter vector
%   std_p       Estimated standard deviation of the least squares solution
%

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.

%% Check for Fmincon options

switch nargin
   
    case 1
        
        options = [];
        
    case 2
        
        if isa(varargin{1},'optim.options.Fmincon')
            
            options = varargin{1};
            
        else
            
            options = [];
            
        end
        
    otherwise
        
        error('Wrong number of inargs.');
    
end

%% Other inputs

ds = obj.data_sets;
handles = obj.handles;
active_handles = {ds.active_handles};

q = {ds.q_exp};
intst = {ds.i_exp};
std = {ds.std_exp};
nc = obj.nc;

if any(cellfun(@isempty,{q intst std}))
   
    error('No empirical data loaded.');
    
end % if

p = obj.get_total_parameter_vector();
p_free = obj.get_total_free_params();
[lb,ub] = obj.get_total_param_bounds();
bf = [0 0];

%% Check for SM_Free_profile

smfp = cellfun(@(x)isa(x,'SM_Free_profile'),obj.s_models);

if any(smfp)
    
    sm = obj.s_models{smfp};
    bf = [sm.sno sm.n];
    
end

%% Minimize and return

[p,std_p] = lsq_fit_core(obj,handles,active_handles,nc,q,intst,std,p,p_free,lb,ub,bf,options);


end

