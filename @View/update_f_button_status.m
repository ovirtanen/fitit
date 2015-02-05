function update_f_button_status(obj)
%UPDATE_F_BUTTON_STATUS Sets obj.f_button .String and .Enable appropriately
%depending on loaded data and fixed parameters
%   
%   update_f_button_status() if no experimental data is loaded, .String is
%   set to 'No data loaded' and the button is disabled. If data is loaded
%   but all parameters are fixed .String is set to 'All fixed' and the
%   button is disabled. If data is loaded and some parameters are free
%   .String is set to 'Fit'.
%
%

ds = obj.model.data_sets;

if numel(ds) == 1 && any(cellfun(@isempty,{ds.q_exp ds.i_exp ds.std_exp}))
    
    % no experimental data loaded
    obj.f_button.String = 'No data loaded';
    obj.f_button.Enable = 'off';
    
elseif not(any(obj.model.get_total_free_params()))
    
    % experimental data loaded but all parameters are fixed
    obj.f_button.String = 'All fixed';
    obj.f_button.Enable = 'off';
    
else
    
    % experimental data loaded and some parameters are free
    
    obj.f_button.String = 'Make it fit!';
    obj.f_button.Enable = 'on';
    
end % if

end

