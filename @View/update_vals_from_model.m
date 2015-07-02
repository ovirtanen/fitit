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
controls = {obj.bg_panel obj.br_panel obj.p_panel obj.d_panel};
controls = controls(~cellfun(@isempty,controls));

f = @(x) [x.Children];

% controls is a cellarray, each cell containing the handles to the
% UIControls in the panels
controls = cellfun(f,controls,'UniformOutput',false);
controls = cat(1,controls{:});

f = @(x) strcmp(x.Style,'edit')  && ~isempty(strfind(x.Tag,'_val'));

filter = arrayfun(f,controls);
vals = controls(filter);

for i = 1:numel(vals)
    
    switch vals(i).Parent.Tag;
        
        case 'bg_panel'
            
            bg = m.bg;
            
            if size(bg.p_ids,1) > 1
               
                bgnum = str2double(regexp(vals(i).Tag,'\d','match','once'));
                
                if bg.enabled(bgnum)
                   
                    p = bg.get_param(vals(i).Tag);
                    vals(i).String = num2str(p);
                    
                end
                
            else
                
                if bg.enabled
                   
                    p = bg.get_param(vals(i).Tag);
                    vals(i).String = num2str(p);
                    
                end
                
            end
            
 
        case 'br_panel'
            
            brs = m.sls_br;
            ind = regexp(vals(i).Tag,'\d');
            brnum = str2double(vals(i).Tag(ind));
            
            if brs(brnum).enabled
                
                tag = vals(i).Tag;
                tag(ind) = [];
                
                p = brs(brnum).get_param(tag);
                vals(i).String = num2str(p);
                
            end
            
            
        case 'sm_panel'
            
            p = m.s_models{1}.get_param(vals(i).Tag); 
            vals(i).String = num2str(p);
        
        case 'dist_panel'
            
            p = m.s_models{1}.dist.get_param(vals(i).Tag); 
            vals(i).String = num2str(p);
            
        otherwise
            
            error([vals(i).Parent.Tag ': Panel type not recognized.']);
            
    end
    
end

%{

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
                
               p = m.s_models{1}.get_param(v.Tag); 
               v.String = num2str(p);
                
            case 3
                
               p = m.s_models{1}.dist.get_param(v.Tag); 
               v.String = num2str(p);
   
        end % switch
    
    end % for
    
end % for

%}

end

