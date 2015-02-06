classdef Scattering_model_spherical < Scattering_model & handle
    %SCATTERING_MODEL_SPHERILCAL Abstract class for defining the interface for
    %scattering models with spherical symmetry
    %  
    
    methods (Static)
       
        p = vnumP(rc,w,pd,q);
        
    end

    methods (Abstract, Access = public)
        
        [rprf,prf] = radial_profile(obj);
        lims = axis_lims(obj);
        
    end
    
end

