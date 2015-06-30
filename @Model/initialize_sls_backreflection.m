function initialize_sls_backreflection(obj,ri,wl,eta,fixed)
%INITIALIZE_SLS_BACKREFLECTION Initializes and adds an SLS_Backreflection 
%instance to the Model
%
%   initialize_sls_backreflection(ri,wl,eta)
%
% Parameters
% ri            Refractive index of the medium
% wl            Wave length of the laser
% eta           Fraction of the back reflected light
% fixed         1 if eta is fixed, otherwise 0

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.

sbr = SLS_Backreflection(ri,wl,eta,fixed);
obj.sls_br = [obj.sls_br sbr];

obj.update_handles();

end

