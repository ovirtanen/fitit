classdef SM_Free_profile < Scattering_model_spherical & handle
%SM_FREE_PROFILE Scattering model for a particle with a density profile
%consisting of freely adjustable steps. The model has been implemented as
%spherical cocentric shells model.
%
%   obj = SM_Free_profile(d,n)
%
%   Parameters
%   d           Distribution instance
%   n           Number of steps in the profile
%

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.
    
    properties (Constant)
       
        name = 'Free Profile Model';
        
    end
    
    properties (SetAccess = protected)
        
        dist;                   % Distribution instance
        n;                      % Number of steps in the profile
        sno;                    % Order of the smooting norm; 0, 1 or 2.
        
        p_name_strings;         % parameter name strings for gui
        p_ids;                  % internal names for the parameters
        
        params;
        param_map;


    end
    
    methods (Static)
       
        f = f_hard_sphere(qr);
        A = mult3(A,x);
        
    end
    
    
    methods (Access = public)
       
        function obj = SM_Free_profile(d,n,sno)
            
            obj.dist = d;
            obj.n = n;
            obj.sno = sno;
            
            % Indice of the amplitude paramter
            obj.scale_param_rows = 2;
            
            % Parameter name strings
            deltas = repmat({'Delta '},n-1,1);
            inds_outer  = strsplit(num2str(fliplr(2:n)))';
            inds_inner  = strsplit(num2str(fliplr(1:n-1)))';
            dash = repmat({' - '},numel(deltas),1);
            
            obj.p_name_strings = {'log lambda';...
                                  'Amplitude (1/cm)';}; 
            obj.p_name_strings = [obj.p_name_strings; strcat(deltas,inds_outer,dash,inds_inner)];
            
            % Parameter ids
            ids = repmat({'dlt'},n-1,1);
            
            obj.p_ids = {'lambda';...
                         'a'};
            obj.p_ids = [obj.p_ids; strcat(ids,inds_outer,inds_inner)];
            
            % Model parameters map
            keyset = obj.param_ids_to_tags(obj.p_ids,'params');
            valueset = num2cell(1:numel(keyset));
            
            obj.param_map = containers.Map(keyset(:),valueset);
            
            % Model parameter default values
            obj.params = {-1 -1 3 1;...                         % log lambda
                          0 1 1 1 };                            % Amplitude     
            obj.params = [obj.params; repmat({-3 0 3 1},n-1,1)];   % Steps: Default values [0 ... 1]
            
        end % constructor  
        
        i_mod = scattered_intensity(obj,nc,q,p);
        
        r = reg(obj,p,d);
        [rprf,prf] = radial_profile(obj);
        lims = axis_lims(obj);
        n = n_total_params(obj); 
        
    end % public methods
    
end

