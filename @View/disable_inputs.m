function disable_inputs(obj)
%DISABLE_INPUTS Disables all user inputs
%
% disable_inputs()
% 
% Pretty crappy but all the solutions in internetz were equally crappy.

handles = guidata(obj.gui);

k = keys(obj.model.param_map)';

fnms = fieldnames(handles);

sldrs = fnms(~cellfun(@isempty,strfind(fnms,'_sldr')));
smenus = fnms(~cellfun(@isempty,strfind(fnms,'_smenu')));

k = [k; sldrs; smenus]';
% k has to be column vector or char(i) freaks out

for i = k
    
    ic = char(i);
    set(handles.(ic),'Enable','off');
    
end


end

