function close_btn_callback(obj,handles)
%CLOSE_BTN_CALLBACK Callback for window close button
%
% close_btn_callback(handles) shows a dialog box asking for the
% confirmation for quitting the software.
% 

selection = questdlg('Are you sure you want to quit?',...
                     'Quit FitIt',...
                     'Yes','No','No'); 
   
switch selection, 
      
    case 'Yes',
         
        delete(handles.fitit);
      
    case 'No'
      
        return 
   
end % switch

end



