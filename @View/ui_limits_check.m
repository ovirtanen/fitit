function b = ui_limits_check(obj,inp,type,tag)
%UI_LIMITS_CHECK Checks the validity of input in editable text boxes in
%fit_it_gui
%   
% b = ui_limits_check(type,tag)
%
% Parameters
%
% inp           Input double
% type          String 'min', 'val' or 'max' depending on the box type
% tag           Ui element tag string
%
% Returns
% 
% b             Boolean true if inp is valid, othewise false
%

if isnan(inp)
    
    b = false;
    return;
    
end % if

m = obj.controller.model;

% minimum limit, value and maximum limit for this tag family
[min,~,max] = m.get_min_val_max(m.get_fit_param_index(tag));


switch type
    
    case 'min'
        
        b = all([(inp >= 0) (inp <= max)]);
        
    case 'val'
        
        b = all([(inp >= 0) (inp >= min) (inp <= max)]);
        
    case 'max'
        
        b = all([(inp >= 0) (inp >= min)]);  
     
end % switch


end

