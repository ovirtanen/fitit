function [solnorm, resnorm, lambda, pc] = l_curve(obj,npoints,prg)
%L_CURVE Calculates L-curve for SM_Free_profile
%   
%   [solnorm, resnorm,pc] = lcurve(npoints)
%
% Parameters
% npoints           Number of points for the L-curve between the lambda limits
% prg               Handle to an output function
% 
% Returns
% solnorm           Solution norm
% resnorm           Residual norm
% pc                Cell array of parameter vectors, one entry for each
%                   point on the L-curve

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.

sm = obj.s_models{cellfun(@(x)isa(x,'SM_Free_profile'),obj.s_models)};

if isempty(sm)
   
    error('The model is not SM_Free_profile.');
    
end


lambdaprms = sm.params(1,:);
[minl,maxl] = lambdaprms{[1,3]};
lambda = linspace(minl,maxl,npoints);

n = sm.n;                                           % number of steps in the profile
p_orig = obj.get_total_parameter_vector();          % original parameter vector

%% Offset in the parameter vector due to background and backreflection

% number of backgrounds
ebg = obj.bg.enabled;
nbg = ebg(ebg == true);
nbg = numel(nbg);

% number of backreflections
if not(isempty(obj.sls_br))
   
    ebr = [obj.sls_br.enabled];
    nbr = ebr(ebr == true);
    nbr = numel(nbr);
    
else
    
    nbr = 0;
    
end


p_off = nbg + nbr;

%% Initiatlize output vectors
solnorm = zeros(numel(lambda),1);   % solution norm
resnorm = zeros(numel(lambda),1);   % residual norm
rchisqr = zeros(numel(lambda),1);   % reduced chi-squared
pc = cell(numel(lambda),1);

%% Do the calculation for different regularization parameters

options = optimoptions('fmincon');
options.MaxFunEvals = 5000;

for i = 1:numel(lambda)
    
    pi = p_orig;
    pi(1+p_off) = lambda(i);
    
    obj.set_total_parameter_vector(pi);
    
    p_l = obj.lsq_fit(options);
    pc{i} = p_l;
    
    obj.set_total_parameter_vector(p_l);
    
    prf_start = p_off + 2 + numel(obj.data_sets);
    prf_end = prf_start + n - 1 ;
    prf = p_l(prf_start:prf_end);

    solnorm(i) = sqrt(sum(diff(prf,2).^2));
    
    h = figure;
    hold on;
    
    ndata = 0;
    
    for j = 1:numel(obj.data_sets)
        
        ds = obj.data_sets(j);
        
        q = ds.q_exp;
        intst = ds.i_exp;
        std = ds.std_exp;
        ah = ds.active_handles;
        
        % ***
        errorbar(q,intst,std);
        
        fit = obj.total_scattered_intensity(150,ah,q);
        
        % ***
        plot(q,fit);
        
        res =  (fit - intst) ./ intst; % correct for the fast decaying data
        
        rchisqr(i) = rchisqr(i) + sum(((fit - intst) ./ std).^2);
        resnorm(i) = resnorm(i) + res(:)' * res(:);
        ndata = ndata + numel(intst);
        
    end
    
    rchisqr(i) = rchisqr(i) ./ (ndata - numel(p_orig) + 1); % +1 from lambda, which is not really a model parameter
    resnorm(i) = sqrt(resnorm(i));
    
    title(['Lambda: ' num2str(lambda(i)) ': Residual norm: ' num2str(resnorm(i)) ' RChiSqr: ' num2str(rchisqr(i))]);
    h.Children.YScale = 'log';
    box on;
    hold off;
    
    prg(i/numel(lambda));
    
end % for

obj.set_total_parameter_vector(p_orig);

end

