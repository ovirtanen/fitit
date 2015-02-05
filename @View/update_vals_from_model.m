function update_vals_from_model(obj)
%UPDATE_VALS_FROM_MODEL Fetches values for '*_val' boxes from the model and
%updates the edit boxe strings
%   
%   update_vals_from_model()
%
%   Does not handle multiple scattering models yet!

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
               v.String = num2str(p);
                
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

