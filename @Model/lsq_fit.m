function p = lsq_fit(obj)
%LSQ_FIT Least squares fit on the experimental data
%   
%   p = lsq_fit() performs a least squares fit on single experimental data
%   set and returns total parameter vector for all the included models and
%   their distributions
%
%   Returns
%   p           Total parameter vector
%
%

if numel(obj.data_sets) ~= 1
    
    error('Only one data set is supported at the time.');
    
end %

q = obj.data_sets.q_exp;
intst = obj.data_sets.i_exp;
std = obj.data_sets.std_exp;
nc = 100;

if any(cellfun(@isempty,{q intst std}))
   
    error('No empirical data loaded.');
    
end % if

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


% initialize handles for chi2 ---------------------------------------------

handles = @(x) x(1);            % Background intensity

switch numel(obj.s_models)
   
    case 0
        
        error('Model not initialized.');
    
    case 1  % obj.s_models is non-structural, 1 model 
        
        sm = obj.s_models;
        h = @(x) sm.scattered_intensity(nc,q,x(2:end));
        handles = {handles h};
        
    otherwise   % more than one model 
        
        ps = 2;     % start indice of parameters in parameter vector for the model
        for i = 1:numel(obj.s_models)
            
            sm = obj.s_models(i);
            np = numel(sm.p_ids) + numel(sm.dist.p_ids); % number of parameters for the model
            h = @(x) sm.scattered_intensity(nc,q,x(ps:ps+np-1));
            handles = {handles h};
            ps = ps + np;
            
        end % for
    
end % switch

% p0_to_p maps the free parameters to their right places in the total
% parameter vector.
prm = @(p0) obj.p0_to_p(p0,p,pf);

% the actual handle that can be finally fed to fmincon
f = @(x) Model.chi2(intst,std,prm(x),handles);

[pfit,~,exitflag] = fmincon(f,x0,[],[],[],[],lb,ub);

p(pf) = pfit;

end

