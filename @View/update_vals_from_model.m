function update_vals_from_model(obj)
%UPDATE_VALS_FROM_MODEL Fetches values for '*_val' boxes from the model and
%updates the edit box strings
%   
%   update_vals_from_model()
%
%   Does not handle multiple scattering models yet!

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.

m = obj.model;
handles = {obj.bg_panel.Children obj.p_panel.Children obj.d_panel.Children};

f = @(x) strcmp(x.Style,'edit')  && ~isempty(strfind(x.Tag,'_val'));

for i = 1:numel(handles)
    
    h = handles{i};
    filter = arrayfun(f,h);
    vals = h(filter);

    for j = 1:numel(vals)
    
        v = vals(j);
        
        switch i
            
            case 1
                
               p = m.bg.get_param(v.Tag);
               
               if p ~= 0
                   % if p == 0, bg_panel is inactive and the value shown to
                   % the user should not be replaced with 0
                   v.String = num2str(p);
               end
               
            case 2
                
               p = m.s_models.get_param(v.Tag); 
               v.String = num2str(p);
                
            case 3
                
               p = m.s_models.dist.get_param(v.Tag); 
               v.String = num2str(p);
   
        end % switch
    
    end % for
    
end % for

end

