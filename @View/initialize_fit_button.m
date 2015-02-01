function b = initialize_fit_button(~,p)
%INITIALIZE_FIT_BUTTON Initializes fit button


b = uicontrol(p,'Style','pushbutton','Units','pixels');

b.Position = [0 0 120 40];

b.Tag = 'fit_btn';
b.String = 'Data not loaded';
b.Enable = 'off';

b.Visible = 'off';

end

