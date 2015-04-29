classdef Parallel_capable < handle
    %PARALLEL_capable Meta Class for checking GPU and multiple worker
    %support
    %
    %   obj = Parallel_capable(b_gpu,b_par)
    %
    % Parameters
    % b_gpu         1 if gpu capability should be switched on on construct,
    %               otherwise 0
    % b_par         1 if multiple worker capability should be switched on 
    %               on construct, otherwise 0
    %
    %
    
    % Copyright (c) 2015, Otto Virtanen
    % All rights reserved.
    
    properties (SetAccess = private)
        
        g_device;
        gpu_enabled;
        par_enabled;
        
    end
    
    methods (Access = public)
        
        function obj = Parallel_capable(b_gpu,b_par)
            
            obj.gpu_enabled = 0;
            obj.par_enabled = 0;
            
            if b_gpu
                
                obj.enable_gpu();
                
            end
            
            if b_par
                
                obj.enable_par();
                
            end
            
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

