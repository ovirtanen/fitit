classdef SM_Background < Scattering_model & handle
%SM_SOLVENT Scattering model for solvent background scattering
%
%   obj = SM_Background()
%

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.
    
properties (Constant)
            
    name = 'Background scattering';
            
end
    
    
properties (SetAccess = protected)
              
    dist;                   % Distribution instance
        
    p_name_strings;         % parameter name strings for gui
    p_ids;                  % internal names for the parameters
        
    params;
    param_map;

    enabled;                % background enabled

end
    

methods (Access = public)
        
    function obj = SM_Background()
               
        obj.dist = [];
            
        obj.p_name_strings = {'Background (cm^{-1})'};
        obj.p_ids = {'bg'};
            
        % Model parameters map
        keyset = obj.param_ids_to_tags(obj.p_ids,'params');
        valueset = num2cell(1:numel(keyset));
            
        obj.param_map = containers.Map(keyset(:),valueset);
            
        % Model parameter default values
        obj.params = {1e-7 1e-7 1e-5 1};               % BG
        
        obj.enabled = false;
            
    end % constructor
        
    function i_mod = scattered_intensity(obj,nbg,p)
        
        e = obj.enabled;
        if e(nbg)
            
            i_mod = p(1);
            
        else
           
            i_mod = 0;
            
        end
            
    end
    
    function toggle_bg(obj,nbg,toggle)
        % TOGGLE_BG Toggles the SM_Backgrounds enabled property
        %
        % Parameters
        % nbg           the number of the background to be toggled
        % toggle        'on' or 'off'
        %
       
        Lib.inargtchck(nbg,@(x)all([nbg >= 1 rem(nbg,1)==0 nbg <= numel(obj.enabled)]));
        
        switch toggle
            
            case 'on'
                
                obj.enabled(nbg) = true;
                
            case 'off'
                
                obj.enabled(nbg) = false;
                
            otherwise
                
                error('Invalid toggle value.');
                
        end % switch
        
    end
    
    match_scale_factors_to_ds(obj,nds);
        
    set_param_vector(obj,p);
    n = n_total_params(obj);    
        
end % public methods
    
    
end

