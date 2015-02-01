function initialize_menu(obj,p)
%INITIALIZE_MENU Initializes the menu bar

% File menu
f = uimenu(p,'Label','File');
fa = uimenu(f,'Label','About');

fl = uimenu(f,'Label','Load dataset');
fl.Tag = 'single_ds_loader';
fl.Callback = @(hObject,callbackdata) obj.controller.load_data_set_callback(hObject,callbackdata);

flm = uimenu(f,'Label','Load multiple datasets');
flm.Enable = 'off';
flm.Tag = 'multiple_ds_loader';

fs = uimenu(f,'Label','Save dataset');
fq = uimenu(f,'Label','Quit');

% Model menu
m = uimenu(p,'Label','Model');
m.Tag = 'model_menu';

% Distribution menu
d = uimenu(p,'Label','Distribution');
d.Tag = 'dist_menu';

% Help menu
h = uimenu(p,'Label','Help');

end

