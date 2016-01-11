function [p,std_p] = lsq_fit_core(obj,handles,active_handles,nc,q,intst,std,p,p_free,lb,ub,bf,options)
%LSQ_FIT_CORE Generates a handle for fmincon and minimizes it
%   
%   h = lsq_fit_handle(handles,active_handles,nc,q,intst,std,p,p_free,lb,ub)
%
% Parameters
% handles           The current set of available handles from Model
% active_handles    Cell array holding index arrays for appropriate handles
%                   for each dataset
% nc                Number of integration points for the distribution
% q                 Cell array holding q vectors for each dataset
% intst             Cell array holding intensity vectors for each dataset
% std               Cell array holding standard deviation of the intensity
%                   values for each dataset
% p                 Parameter vector
% p_free            Logical vector specifying the parameters free for
%                   fitting in p
% lb                Lower bound vector for p
% ub                Upper bound vector for p
% bf                Indicator for SM_free_profile [sno n]. sno indicates 
%                   the regularization mode either -1, 0, 1 or 2; n 
%                   indicates the number of discretization steps. [0 0] 
%                   indicates that SM_free_profile is not being used.
% options           Options for the fitting routine
%
% Returns
% p                 The minimized parameter vector
% std_p             Standard deviation of the parameters estimated from the
%                   Jacobian

% Copyright (c) 2015-2016, Otto Virtanen
% All rights reserved.


%% Prepare parameter vector and bounds

% Free parameters
free_filter = p_free;
pf = 1:numel(p);
pf = pf(free_filter);

% values of the initial guess
x0 = p(pf);                     

lb = lb(pf);
ub = ub(pf);

% p0_to_p maps the free parameters to their right places in the total
% parameter vector.
prm = @(p0) obj.p0_to_p(p0,p,pf);

%% Handle for fmincon

% ***
% *** Special case for a regularized fit using SM_Free_profile ***
% ***

if not(all(0 == bf))
        
    sno = bf(1);        % smoothing norm order
    n = bf(2);          % number of spherical shells
    
    pnd = Pinds(obj);
    pinds = pnd.get(pnd.n_species); % Parameter indices for the scattering model and distribution
    
    pinds(1:numel(q)+1) = []; % Remove amplitude terms and lambda; numel(q) equals number of datasets equals number of ampitude terms.
    pinds(n:end) = []; % Remove Distribution related parameters.
    
    % pinds should contain n-1 elements, because the model happened to be
    % implemented in a way that the differences in contrast between the
    % shells are the parameters to be minimized (approximate first
    % derivative).
    
    switch sno
        
        case -1
            
            rh = @(x) sm.reg(x(pinds),-1);  % Total variation smoothing norm
       
        case 0
            
            rh = @(x) sm.reg(x(pinds),0);  % 2-norm smoothing norm
            
        case 1
            
            rh = @(x) sm.reg(x(pinds),1);  % first derivative smoothing norm
            
        case 2
            
            rh = @(x) sm.reg(x(pinds),2);  % second derivative smoothing norm
            
        otherwise
            
            error('Illegal regularization norm.');
        
    end
    
    f = @(x) Model.chi2reg(nc,q,intst,std,prm(x),active_handles,handles,rh);
    
else % *** All the other models without regularization ***
    
    f = @(x) Model.chi2(nc,q,intst,std,prm(x),active_handles,handles);

end

%% Minimize

if isempty(options)

    [pfit,~,exitflag,~,~,grad] = fmincon(f,x0,[],[],[],[],lb,ub);
    
else
    
    [pfit,~,exitflag,~,~,grad] = fmincon(f,x0,[],[],[],[],lb,ub,[],options);
    
end % if

%% Estimate the standard deviation of the least squares solution

if any(smfp)    % STD for ill-conditioned inverse problem is crap

    std_p = -1.*ones(size(p));
    
else
    
    std_p = obj.estimate_p_std();
    
end

%% Return

p(pf) = pfit;

end

