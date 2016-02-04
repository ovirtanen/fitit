function update_booleans(obj,hObject,callbackdata)
%UPDATE_BOOLEANS Updates the booleans struct with current selection and
%calls update_push_buttons to apply changes to GUI.
%

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.


% BUTTON GROUP
if isa(hObject,'matlab.ui.container.ButtonGroup')
    
    r_btn_string = callbackdata.NewValue.String;
    
    switch hObject.Title
        
        case 'Discard Options'
            
            switch r_btn_string
               
                case 'All'
                    
                    obj.booleans.discard_all = true;
                    obj.booleans.discard_all_but_selected = false;
                    obj.booleans.discard_selected = false;
                    
                case 'All but selected'
                    
                    obj.booleans.discard_all = false;
                    obj.booleans.discard_all_but_selected = true;
                    obj.booleans.discard_selected = false;
                    
                case 'Selected'
                    
                    obj.booleans.discard_all = false;
                    obj.booleans.discard_all_but_selected = false;
                    obj.booleans.discard_selected = true;
                    
                otherwise
                    
                    error('Radio button not recognized.');
                
            end
            
        case 'Parameter Update Policy'
            
            switch r_btn_string
               
                case 'Always keep updated'
                    
                    obj.booleans.p_update_always = true;
                    obj.booleans.p_update_after_fit = false;
                    
                case 'Update only after fit'
                    
                    obj.booleans.p_update_always = false;
                    obj.booleans.p_update_after_fit = true;

                otherwise
                    
                    error('Radio button not recognized.');
                
            end
            
        case 'Fit'
            
            switch r_btn_string
               
                case 'All'
                    
                    obj.booleans.fit_all = true;
                    obj.booleans.fit_selected = false;
                    
                case 'Only selected'
                   
                    obj.booleans.fit_all = false;
                    obj.booleans.fit_selected = true;
                    
                otherwise
                    
                    error('Radio button not recognized.');
                
            end
            
        case 'Initial Guess Vector p'
            
            switch r_btn_string
               
                case 'Use original p'
                    
                    obj.booleans.p_use_original = true;
                    obj.booleans.p_use_active = false;
                    obj.booleans.p_propagate = false;
                    
                case 'Use active p'
                    
                    obj.booleans.p_use_original = false;
                    obj.booleans.p_use_active = true;
                    obj.booleans.p_propagate = false;
                    
                case 'Propagate active p'
                    
                    obj.booleans.p_use_original = false;
                    obj.booleans.p_use_active = false;
                    obj.booleans.p_propagate = true;
                    
                otherwise
                    
                    error('Radio button not recognized.');
                
            end
            
        case 'Save Now'
            
            switch r_btn_string
               
                case 'All'
                    
                    obj.booleans.save_now_all = true;
                    obj.booleans.save_now_selected = false;
                    
                case 'Only selected'
                    
                    obj.booleans.save_now_all = false;
                    obj.booleans.save_now_selected = true;
                    
                otherwise
                    
                    error('Radio button not recognized.');
                
            end
            
        otherwise
            
            error('Button group not recognized.');
        
    end
    
% CHECKBOX    
elseif isa(hObject,'matlab.ui.control.UIControl') && strcmp(hObject.Style,'checkbox')
   
    checkbox_string = hObject.String;

    switch checkbox_string
       
        case 'Batch Fit Autosave'
            
            obj.booleans.b_fit_autosave = hObject.Value;
            
        case 'Save as .fitit'
            
            obj.booleans.save_as_fitit = hObject.Value;
            
        case 'Save Loading Seq.'
            
            obj.booleans.save_loading_seq = hObject.Value;
            
        case 'Export p to table'
            
            obj.booleans.export_p_to_table = hObject.Value;
            
        case 'Export as text'
            
            obj.booleans.export_as_text = hObject.Value;
            
        otherwise
            
            error('Checkbox not recognized.');
        
        
    end
    
    
end

obj.update_push_buttons();

end

