function [solnorm, resnorm, lambda, pc] = l_curve(obj,npoints,fitop,prg)
%L_CURVE Calculates L-curve for SM_Free_profile
%   
%   [solnorm, resnorm,pc] = lcurve(npoints)
%
% Parameters
% npoints           Number of points for the L-curve between the lambda limits
% fitop             Cellarray to handles to subplots, where solutions will
%                   be plotted
% prg               Handle to waitbar function
% 
% Returns
% solnorm           Solution norm
% resnorm           Residual norm
% pc                Cell array of parameter vectors, one entry for each
%                   point on the L-curve
%
% Note: This function is more or less crap that combines computation with
% output. Plotting has to be separated in the future.
%

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.

sm = obj.s_models{cellfun(@(x)isa(x,'SM_Free_profile'),obj.s_models)};

if isempty(sm)
   
    error('The model is not SM_Free_profile.');
    
elseif numel(fitop) ~= npoints
    
    error('Not enough handles for output');
    
elseif not(all(cellfun(@(x) isa(x,'matlab.graphics.axis.Axes'),fitop)))
    
    error('Input is not a cellarray of Axes.');
    
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
options.TolX = 1e-7;

for i = 1:numel(lambda)
    
    pi = p_orig;
    pi(1+p_off) = lambda(i);
    
    obj.set_total_parameter_vector(pi);
    
    p_l = obj.lsq_fit(options);
    pc{i} = p_l;
    
    obj.set_total_parameter_vector(p_l);
    
    prf_start = p_off + 2 + numel(obj.data_sets);
    prf_end = prf_start + n - 2 ; % !!!! Changed to -2 from -1 for diffprf
    prf = p_l(prf_start:prf_end);
    
    solnorm(i) = sqrt(sum(prf.^2));
    
    ndata = 0;
    
    for j = 1:numel(obj.data_sets)
        
        ds = obj.data_sets(j);
        
        q = ds.q_exp;
        q_fit = linspace(1e-4,max(q),200);
        intst = ds.i_exp;
        std = ds.std_exp;
        ah = ds.active_handles;
        nc = obj.nc;
        
        % Plot results --------------------------------
        
        hold(fitop{i},'on');
        
        fitop{i}.YLim;
        fitop{i}.XLim;
        
        errorbar(fitop{i},q,intst,std,'Marker','o','MarkerSize',3);
        
        fit = obj.total_scattered_intensity(nc,ah,q_fit);
        
        if j == 1
        
            fitop{i}.YLim(1) = min(intst);  % min Y
            fitop{i}.YLim(2) = max(fit);  % max Y

            fitop{i}.XLim(1) = 0; % min X
            fitop{i}.XLim(2) = max(q_fit); % max X
            
        else
            
            fitop{i}.YLim(1) = min(fitop{i}.YLim(1),min(intst));  % min Y
            fitop{i}.YLim(2) = max(fitop{i}.YLim(2),max(fit));  % max Y

            fitop{i}.XLim(2) = max(fitop{i}.XLim(2),max(q_fit)); % max X
            
        end
        
        plot(fitop{i},q_fit,fit,'LineWidth',1.5);
        
        fit = obj.total_scattered_intensity(nc,ah,q);
        
        hold(fitop{i},'off');
        
        % ---------------------------------------------
        
        res =  (fit - intst) ./ intst; % correct for the fast decaying data
        
        rchisqr(i) = rchisqr(i) + sum(((fit - intst) ./ std).^2);
        resnorm(i) = resnorm(i) + res(:)' * res(:);
        ndata = ndata + numel(intst);
        
    end
    
    rchisqr(i) = rchisqr(i) ./ (ndata - numel(p_orig) + 1); % +1 from lambda, which is not really a model parameter
    resnorm(i) = sqrt(resnorm(i));
    
    % Plot title -------------------
    
    title(fitop{i},['\lambda: ' num2str(lambda(i),2) ', Sol. norm: ' num2str(solnorm(i),3) ', Res. norm: ' num2str(resnorm(i),3)]);
    drawnow();
   
    % ----------------
    
    prg(i/numel(lambda));
    
end % for

obj.set_total_parameter_vector(p_orig);

end

