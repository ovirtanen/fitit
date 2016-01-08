function initialize_from_data_node(obj,dn,varargin)
%INITIALIZE_FROM_DATA_NODE Initialize Model according to Data_node
%   
%   initialize_from_data_node(dn)
%   initialize_from_data_node(dn,'onlydata')
% 
%
% Parameters
% dn            Data_node instance
% options       Additional options
%                   'onlydata'  Load only data and disregard other
%                               parameters
%
%
%   Updates handles.
%

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.

%% Inarg check

Lib.inargtchck(dn,@(x)isa(x,'Data_node'),...
               dn,@(x)all([numel(x.data_sets) >= 1 numel(x.filenames) >= 1 numel(x.data_sets) == numel(x.filenames)]));
           
b = [isempty(dn.s_model_name); isempty(dn.dist_name); isnan(dn.total_param_vector)];          
           
b_only_data = false;

if numel(varargin) > 1
    
    error('Too many options');
    
elseif numel(varargin) == 1     
   
    switch varargin{1}
       
        case 'onlydata'     % override switch
            
            b_only_data = true;
            
        otherwise
        
            error('Invalid option.');
            
    end % switch
    
elseif all(not(b))       % Data for Model parameters, no override switch
    
    % do nothing, b_only_data stays false
    
elseif all(b)  % All are empty
    
    b_only_data = true;
    
else    % Inconsistent Data_node instance
    
    error('Invalid Data_node instance.');
    
end

%% Remove old data

obj.remove_experimental_data();

%% Load data_set references to Model

ds = dn.data_sets;

for i = 1 : numel(ds)
          
    obj.add_data_set(ds(i));
           
end

%% Load appropriate model, distribution and other parameters if necessary

if not(b_only_data)
   
   % BACKGROUND ----------------------------------------------------------- 
   
   if any(dn.bg_enabled)    % background scattering enabled
        
        obj.bg.match_scale_factors_to_ds(numel(ds));
        
        for i = 1:numel(dn.bg_enabled)
           
            switch dn.bg_enabled(i)
            
                case true
                    
                    obj.bg.toggle_bg(i,'on');
                    
                case false
                    
                    obj.bg.toggle_bg(i,'off');
            
            end     % switch
            
        end     % for
        
   end
    
    % BACKREFLECTION-------------------------------------------------------
    
    if any(dn.sls_br_enabled) 
        
        if numel(obj.sls_br == 0) % Backreflection enabled but Model doesn't have the necessary instances
           
            
            for i = 1:numel(dn.sls_br_enabled)
                
                obj.initialize_sls_backreflection(dn.sls_br_param(i).ri,dn.sls_br_param(i).wl,0.003,1);
               
                switch dn.sls_br_enabled(i)
                    
                    case true
                
                        obj.sls_br(i).enable();
                        
                    case false
                        
                        obj.sls_br(i).disable();
                
                end % switch
                
            end % for
            
        else
            
            obj.match_br_to_ds(numel(ds));
            
            for i = 1:numel(dn.sls_br_enabled)
               
                switch dn.sls_br_enabled(i)
                    
                    case true
                
                        obj.sls_br(i).enable();
                        
                    case false
                        
                        obj.sls_br(i).disable();
                
                end % switch
                
            end % for
            
        end
              
    end
    
    % SCATTERING MODEL AND RADIUS DISTRIBUTION ----------------------------
    
    asm = obj.get_active_s_model();
    
    b_sd = [strcmp(dn.s_model_name,asm.name) strcmp(dn.dist_name,asm.dist.name)];
    
    if all(b_sd == [0 0])       % Both scattering model and distribution need to be swapped
        
        dh = Distribution.available_distributions(dn.dist_name);
        d = dh();
        
        smh = Scattering_model.available_models(dn.s_model_name);
        sm = smh(d);
        
        obj.replace_s_model(sm);    % updates handles, adjusts to number of datasets
        
        
    elseif all(b_sd == [0 1])   % Only scattering model needs to be swapped
        
        d = asm.dist;
        
        smh = Scattering_model.available_models(dn.s_model_name);
        sm = smh(d);
        
        obj.replace_s_model(sm);    % updates handles, adjusts to number of datasets
        
    elseif all(b_sd == [1 0])   % Only distribution needs to be swapped
        
        dh = Distribution.available_distributions(dn.dist_name);
        d = dh();
        
        asm.set_distribution(d);
        obj.update_handles();
        
    end
   
    % Update parameters in Model ------------------------------------------
    
    obj.set_total_parameter_vector(dn.total_param_vector);
    tb = dn.total_param_bounds;
    obj.set_total_bounds(tb(:,1),tb(:,2));
    
else % ONLY DATA ----------------------------------------------------------
% Only data loaded, number of parameters in the scattering model has to be adjusted & handles updated.
    
   for i = 1:numel(obj.s_models)
   
    sm = obj.s_models{i};
    sm.match_scale_factors_to_ds(numel(ds));
    
    end

    obj.bg.match_scale_factors_to_ds(numel(ds));

    if not(isempty(obj.sls_br))

        obj.match_br_to_ds(numel(ds));
        
    end
    
    obj.update_handles();
    
end

end

