function set_distribution(obj,dist)
%SET_DISTRIBUTION Sets a Distribution instance to the Scattering_model
%  
%   set_distribution(dist)
%
%
%

if not(isa(dist,'Distribution'))
    
    error('Parameter is not a Distribution instance.');
    
end

obj.dist = dist;

end

