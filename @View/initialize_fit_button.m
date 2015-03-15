function b = initialize_fit_button(obj,p)
%INITIALIZE_FIT_BUTTON Initializes fit button


b = uicontrol(p,'Style','pushbutton','Units','pixels');
b.Callback = @(hObject,callbackdata) obj.controller.f_button_callback(hObject,callbackdata);

b.Position = [0 0 120 40];

b.Tag = 'fit_btn';
b.String = 'No data loaded';
b.Enable = 'off';

b.Visible = 'off';

end

