function l_curve_callback(obj,hObject,callbackdata)
%L_CURVE_CALLBACK Callback for the Tools menu Determine L-Curve item
%   
%   l_curve_callback(hObject,callbackdata)
%
% Determines the L-curve for regularized SM_Free_profile fit, i.e.,
% computes regularized solution for the scattering pattern with different
% regularization parameter lambda values and plots inverse solution norm
% against residual norm on log-log scale. The optimal lambda value is close
% to the corner of the L-curve. Initial guess values are those set by the
% user in the parameter panel.

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.

sm = obj.model.s_models{cellfun(@(x)isa(x,'SM_Free_profile'),obj.model.s_models)};

if isempty(sm)
   
    error('The model is not SM_Free_profile.');
    
end

lambdaprms = sm.params(1,:);
[minl,maxl] = lambdaprms{[1,3]};
lambda = linspace(minl,maxl,15);

n = sm.n;                                           % number of steps in the profile
p_orig = obj.model.get_total_parameter_vector();    % original parameter vector

% Offset in the parameter vector due to background and backreflection
p_off = 0 + double(obj.model.bg.enabled) + double(not(isempty(obj.model.sls_br)) && obj.model.sls_br.enabled); 

isolnorm = zeros(numel(lambda),1);  % inverse solution norm
resnorm = zeros(numel(lambda),1);   % residual norm

if numel(obj.model.data_sets) ~= 1

    error('Only one dataset is supported at the moment.');
    
end
    
data = obj.model.data_sets(1).i_exp;
q = obj.model.data_sets(1).q_exp;

w = waitbar(0,'Calculating L-curve with given initial guesses...');
for i = 1:numel(lambda)
    
    pi = p_orig;
    pi(1+p_off) = lambda(i);
    
    obj.model.set_total_parameter_vector(pi);
    
    pi
    p_l = obj.model.lsq_fit();
    
    [p_orig(:) pi(:) p_l(:)]
    
    obj.model.set_total_parameter_vector(p_l);
    
    prf = p_l(3+p_off:2+n+p_off);
    isolnorm(i) = 1./ sqrt((prf(:)' * prf(:)));
    
    res = obj.model.total_scattered_intensity(150,q) - data;
    resnorm(i) = sqrt(res(:)' * res(:));
    
    waitbar(i/numel(lambda));
    
end % for

isolnorm
resnorm

waitbar(1);
w.delete();

obj.model.set_total_parameter_vector(p_orig);

figure();
l = scatter(resnorm,isolnorm);
l.Parent.YScale = 'log';
l.Parent.XScale = 'log';
l.Parent.YLim = [min(l.YData) max(l.YData)];
l.Parent.XLim = [min(l.XData) max(l.XData)];
l.Parent.YLabel.String = 'Inverse solution norm';
l.Parent.XLabel.String = 'Residual norm';
box on;

end

