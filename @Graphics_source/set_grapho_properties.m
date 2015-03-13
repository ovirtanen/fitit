function set_grapho_properties( obj, varargin )
%SET_GRAPHO_PROPERTIES Sets graphics object properties in Graphics_source
%  
%   set_grapho_properties('PropertyName',Propertyvalue,...)
%
%   Parameters
%   'PropertyName'      String specifying the property in the graphics
%                       object, e.g., 'LineWidth'
%   Propertyvalue       Value for the property
%
%
    
if mod(numel(varargin),2) ~= 0
    
    error('Each property name must have a value.');
    
end % if

for i = 1:2:numel(varargin)
   
    set(obj.g_handle,varargin{i},varargin{i+1});
    
end % for

end

