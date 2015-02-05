function p = get_total_s_model_param_vector(sm)
%GET_TOTAL_SMODEL_PARAM_VECTOR Returns the composite parameter vector for a
%Scattering_model instance & its Distribtution
%   
%   p = get_total_param_vector(sm)
%
%   Parameters
%   sm          Scattering_model instance
%
%


p = [sm.get_param_vector(); sm.dist.get_param_vector()];


end

