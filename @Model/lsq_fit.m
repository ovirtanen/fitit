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

%% Other inputs

ds = obj.data_sets;
handles = obj.handles;
active_handles = {ds.active_handles};

q = {ds.q_exp};
intst = {ds.i_exp};
std = {ds.std_exp};
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

% p0_to_p maps the free parameters to their right places in the total
% parameter vector.
prm = @(p0) obj.p0_to_p(p0,p,pf);

%% Handle for fmincon

% ***
% *** Special case for a regularized fit using SM_Free_profile ***
% ***

smfp = cellfun(@(x)isa(x,'SM_Free_profile'),obj.s_models);

if any(smfp)
    
    % Warning: this goes south if logical indexing gets more than one
    % model, sm will be the first match.
    
    sm = obj.s_models{smfp};
    
    % The second thing that goes south here is that the length of p changes
    % if background and backreflection (in future maybe more?) are enabled.
    % This is taken care of in Model.update_handles for regular models, but
    % has to be recognized here for SM_Free_profile.reg(p).
    
    if isempty(obj.sls_br)
        
        ps = 1 + numel(obj.bg.enabled);
        
    else
        
        ps = 1 + numel(find(obj.bg.enabled)) + numel(find([obj.sls_br.enabled]));
            
    end
    
    nds = numel(obj.data_sets);
    np = sm.n;
    
    pinds = [ps ps+nds+1:ps+nds+np];
    
    switch sm.sno
       
        case 0
            
            rh = @(x) sm.reg(x(pinds),0);  % second derivative smoothing norm
            
        case 1
            
            rh = @(x) sm.reg(x(pinds),1);  % second derivative smoothing norm
            
        case 2
            
            rh = @(x) sm.reg(x(pinds),2);  % second derivative smoothing norm
            
        otherwise
            
            error('Illegal regularization norm.');
        
    end
    
    f = @(x) Model.chi2reg(nc,q,intst,std,prm(x),active_handles,handles,rh);
    
else % *** All the other models without regularization ***
    
    f = @(x) Model.chi2(nc,q,intst,std,prm(x),active_handles,handles);

end

%% Minimize & return

if isempty(options)

    [pfit,~,exitflag] = fmincon(f,x0,[],[],[],[],lb,ub);
    
else
    
    [pfit,~,exitflag] = fmincon(f,x0,[],[],[],[],lb,ub,[],options);
    
end % if

p(pf) = pfit;

end

