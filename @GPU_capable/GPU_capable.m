classdef GPU_capable < handle
    %GPU Meta Class for checking GPU support
    
    properties (SetAccess = private)
        
        device;
        gpu_enabled;
        
    end
    
    methods (Access = public)
        
        function obj = GPU_capable()
            
            if gpuDeviceCount() >= 1
                
                obj.gpu_enabled = 1;
                obj.device = gpuDevice();
                
            else
                
                obj.gpu_enabled = 0;
                obj.device = [];
                
            end
            
        end % constructor
        
        function enable_gpu(obj)
           
            obj.gpu_enabled = 1;
            
        end % enable_gpu
        
        function disable_gpu(obj)
           
            obj.gpu_enabled = 0;
            
        end % disable_gpu
        
        function reset(obj)
           
            obj.device.reset();
            
        end % reset
        
    end
    
end

