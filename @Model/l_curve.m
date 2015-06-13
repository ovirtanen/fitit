function [isolnorm, resnorm, lambda, pc] = l_curve(obj,npoints,prg)
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

if numel(obj.data_sets) ~= 1

    error('Only one dataset is supported at the moment.');
    
end
    
data = obj.data_sets(1).i_exp;
q = obj.data_sets(1).q_exp;

lambdaprms = sm.params(1,:);
[minl,maxl] = lambdaprms{[1,3]};
lambda = linspace(minl,maxl,npoints);

n = sm.n;                                           % number of steps in the profile
p_orig = obj.get_total_parameter_vector();          % original parameter vector

% Offset in the parameter vector due to background and backreflection
p_off = 0 + double(obj.bg.enabled) + double(not(isempty(obj.sls_br)) && obj.sls_br.enabled); 

isolnorm = zeros(numel(lambda),1);  % inverse solution norm
resnorm = zeros(numel(lambda),1);   % residual norm
pc = cell(numel(lambda),1);

for i = 1:numel(lambda)
    
    pi = p_orig;
    pi(1+p_off) = lambda(i);
    
    obj.set_total_parameter_vector(pi);
    
    p_l = obj.lsq_fit();
    pc{i} = p_l;
    
    obj.set_total_parameter_vector(p_l);
    
    prf = p_l(3+p_off:2+n+p_off);
    % normalization doesn't affect the scattering curve because only
    % relative differences in the density profile matter, but scaling the
    % absolute profile values helps to distinguish excessive
    % regularization. Large regularization values force to profile to box
    % profile, but the height of the profile is not necessarily 1 when a
    % smoothing norm is used, which messes up the "real" solution norm.
    prf = prf ./ max(prf); 
    prf = 1./prf;
    isolnorm(i) = sqrt((prf(:)' * prf(:)));
    
    res = obj.total_scattered_intensity(150,q) - data;
    res = res ./ max(res);
    resnorm(i) = sqrt(res(:)' * res(:));
    
    prg(i/numel(lambda));
    
end % for

obj.set_total_parameter_vector(p_orig);

end

