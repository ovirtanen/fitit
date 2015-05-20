function update_sliders( obj )
%UPDATE_SLIDERS Fetches values for '*_val' boxes from the model and
%updates the corresponding slider positions

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.

m = obj.model;
handles = {obj.bg_panel.Children obj.p_panel.Children obj.d_panel.Children};

f = @(x) strcmp(x.Style,'slider');

for i = 1:numel(handles)
    
    h = handles{i};
    filter = arrayfun(f,h);
    sldrs = h(filter);

    for j = 1:numel(sldrs)
    
        v = sldrs(j);
        valtag = v.Tag;
        valtag = [valtag(1:end-5) '_val'];
        
        switch i
            
            case 1
               
               p = m.bg.get_param(valtag);
               
               if p ~= 0
                   % if p == 0, bg_panel is inactive and the value shown to
                   % the user should not be replaced with 0
                   v.Value = p;
               end
               
            case 2
                
               p = m.s_models{1}.get_param(valtag); 
               v.Value = p;
                
            case 3
                
               p = m.s_models{1}.dist.get_param(valtag); 
               v.Value = p;
   
        end % switch
    
    end % for
    
end % for


end

