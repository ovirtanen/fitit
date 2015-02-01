function update_sources(obj)
%UPDATE_SOURCES Updates all the Graphics_sources in this Axes_layout
%  

gs = obj.g_sources;

for i = 1:numel(gs)
   
    gs(i).update();
    
end % for


end

