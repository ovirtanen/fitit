function initialize_sls_backreflection(obj,ri,wl)
%INITIALIZE_SLS_BACKREFLECTION Initializes SLS_Backreflection instance to
%the Model
%
%   initialize_sls_backreflection(ri,wl,eta)
%
% Parameters
% ri            Refractive index of the medium
% wl            Wave length of the laser
% eta           Fraction of the back reflected light
%

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.


obj.sls_br = SLS_Backreflection(ri,wl);

obj.sls_br.enable();

obj.update_handles();

end

