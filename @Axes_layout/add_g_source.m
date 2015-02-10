function add_g_source(obj,gs)
%ADD_G_SOURCE Adds a Graphics_source instance to the Axes_layout

if isa(gs,'Graphics_source')
    
    obj.g_sources = [obj.g_sources gs];
    
else
    
    error('Not a Graphics_source');
    
end

end

