classdef Parallel_capable < handle
    %PARALLEL_capable Meta Class for checking GPU and multiple worker
    %support
    
    % Copyright (c) 2015, Otto Virtanen
    % All rights reserved.
    
    properties (SetAccess = private)
        
        g_device;
        gpu_enabled;
        par_enabled;
        
    end
    
    methods (Access = public)
        
        function obj = Parallel_capable()
            
            obj.gpu_enabled = 0;
            obj.par_enabled = 0;
            
        end % constructor
        
        function enable_gpu(obj)
           
            if gpuDeviceCount() >= 1
                
                obj.gpu_enabled = 1;
                obj.g_device = gpuDevice();
                
            else
                
                obj.gpu_enabled = 0;
                obj.g_device = [];
                
            end
            
        end % enable_gpu
        
        function enable_par(obj)
           
            if isempty(gcp('nocreate'))
               
                obj.par_enabled = 0;
                
            else
                
                obj.par_enabled = 1;
                
                
            end
            
        end % enable_par
        
        function disable_gpu(obj)
           
            obj.gpu_enabled = 0;
            
        end % disable_gpu
        
        function disable_par(obj)
           
            obj.par_enabled = 0;
            
        end % disable_par
        
        function reset(obj)
           
            obj.device.reset();
            
        end % reset
        
    end
    
end

