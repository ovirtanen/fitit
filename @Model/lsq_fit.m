function p = lsq_fit(obj,varargin)
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
%
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

if numel(obj.data_sets) ~= 1
    
    error('Only one data set is supported at the time.');
    
end %

%% Other inputs

q = obj.data_sets.q_exp;
intst = obj.data_sets.i_exp;
std = obj.data_sets.std_exp;
nc = 150;

if any(cellfun(@isempty,{q intst std}))
   
    error('No empirical data loaded.');
    
end % if

%% Prepare parameter vector and bounds

% Parameter vector
p = obj.get_total_parameter_vector();

% Free parameters
free_filter = obj.get_total_free_params();
pf = 1:numel(p);
pf = pf(free_filter);

% values of the initial guess
x0 = p(pf);                     

% Parameter bounds
[lb,ub] = obj.get_total_param_bounds();

lb = lb(pf);
ub = ub(pf);


%% Initialize handles for chi2

handles = obj.handles;

for i = 1:numel(handles)
    
    handles{i} = @(x) handles{i}(nc,q,x);
    
end % for


% p0_to_p maps the free parameters to their right places in the total
% parameter vector.
prm = @(p0) obj.p0_to_p(p0,p,pf);

%% Handle for fmincon

% Special case for a regularized fit using SM_Free_profile
smfp = cellfun(@(x)isa(x,'SM_Free_profile'),obj.s_models);

if any(smfp)
    
    % Warning: this goes south if logical indexing gets more than one
    % model, sm will be the first match.
    
    sm = obj.s_models{smfp};
    
    % The second thing that goes south here is that the length of p changes
    % if background and backreflection (in future maybe more?) are enabled.
    % This is taken care of in Model.update_handles for regular models, but
    % has to be recognized here for SM_Free_profile.reg(p).
    
    ps = 1 + double(obj.bg.enabled) + double(not(isempty(obj.sls_br)) && obj.sls_br.enabled);
    rh = @(x) sm.reg(x(ps:end),2);  % second derivative smoothing norm
    f = @(x) Model.chi2reg(intst,std,prm(x),handles,rh);
    
else % All the other models without regularization
    
    f = @(x) Model.chi2(intst,std,prm(x),handles);

end

%% Minimize & return

if isempty(options)

    [pfit,~,exitflag] = fmincon(f,x0,[],[],[],[],lb,ub);
    
else
    
    [pfit,~,exitflag] = fmincon(f,x0,[],[],[],[],lb,ub,[],options);
    
end % if

p(pf) = pfit;

end

