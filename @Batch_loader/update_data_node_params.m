function update_data_node_params(obj,dn,varargin)
%UPDATE_DATA_NODE_PARAMS Collects the current parameters from Model and
%updates the given Data_node instance
%   Detailed explanation goes here
%
% update_data_node_params(dn)
% update_data_node_params(dn,isfit)
% update_data_node_params(dn,isfit,std) (This will be hopefully improved.)
%
% Parameters
% dn            Data_node instance whose parameters will be updated
% isfit         boolean, whether the update is due to fit
% std           Standard deviation vector for p. The objective is to modify
%               Model in the future so that the std would be saved there
%               and this option would become unnecessary.
%
%

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.


if nargin > 4
    
    error('Too many inargs.');
    
elseif nargin == 3 && not(islogical(varargin{1}))
    
    error('Illegal inarg type.');
    
elseif nargin == 4 && not(islogical(varargin{1})) && not(isvector(varargin{2})) && not(isnumeric(varargin{2}))
    
    error('Illegal inarg type.');
    
end

%% Collect data from Model

m = obj.model;

smn = m.get_active_s_model().name;
distn = m.get_active_s_model().dist.name;

p = m.get_total_parameter_vector();
[lb,ub] = m.get_total_param_bounds();
f = not(m.get_total_free_params());  % NOTE the difference between FIXED params and m.get_total_free_params()
bg_e = m.bg.enabled;

if not(numel(m.sls_br) == 0)
    
    sls_br_e = [m.sls_br.enabled];
    
else

    sls_br_e = false(size(m.data_sets));
    
end

%% Update data in Data_node

dn.s_model_name = smn;
dn.dist_name = distn;

dn.total_param_vector = p;
dn.total_param_bounds = [lb ub];
dn.total_fixed_params = f;

% Check if STD data is available
if nargin == 4
   
    if numel(varargin{2}) == numel(p)
    
        dn.total_std_vector = varargin{2};
    
    else
    
        error('Standard deviation vector has wrong number of elements.');
        
    end
    
end

dn.bg_enabled = bg_e;
dn.sls_br_enabled = sls_br_e;

if any(sls_br_e)
    
    dn.sls_br_param = struct('ri',num2cell([m.sls_br.refr_index]),'wl',num2cell([m.sls_br.w_length]));

end

if nargin >= 3 && islogical(varargin{1})
    
    dn.isfit = varargin{1};
    
end

        

end

