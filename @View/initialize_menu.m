function initialize_menu(obj,p)
%INITIALIZE_MENU Initializes the menu bar

% FitIt! menu -------------------------------------------------------------
fi = uimenu(p,'Label','FitIt!');
fia = uimenu(fi,'Label','About');
fia.Callback = @(hObject,callbackdata) obj.controller.about_menu_callback(hObject,callbackdata);

fiq = uimenu(fi,'Label','Quit');
fiq.Callback = @(hObject,callbackdata) obj.controller.quit_callback(hObject,callbackdata);


% File menu ---------------------------------------------------------------
f = uimenu(p,'Label','File');

fl = uimenu(f,'Label','Load dataset');
fl.Tag = 'single_ds_loader';
fl.Callback = @(hObject,callbackdata) obj.controller.load_data_set_callback(hObject,callbackdata);

flm = uimenu(f,'Label','Load multiple datasets');
flm.Enable = 'off';
flm.Tag = 'multiple_ds_loader';

fs = uimenu(f,'Label','Save dataset');
fs.Callback = @(hObject,callbackdata) obj.controller.save_data_callback(hObject,callbackdata);


% Model menu --------------------------------------------------------------
m = uimenu(p,'Label','Model');
m.Tag = 'model_menu';

am = Scattering_model.available_models;

for i = 1 : numel(am)
   
   di = uimenu(m);
   di.Label = am{i};
   di.Callback = @(hObject,callbackdata) obj.controller.model_menu_callback(hObject,callbackdata);
    
end

% Distribution menu -------------------------------------------------------
d = uimenu(p,'Label','Distribution');
d.Tag = 'dist_menu';

ad = Distribution.available_distributions;
for i = 1 : numel(ad)
   
   di = uimenu(d);
   di.Label = ad{i};
   di.Callback = @(hObject,callbackdata) obj.controller.dist_menu_callback(hObject,callbackdata);
    
end

% Help menu ---------------------------------------------------------------
h = uimenu(p,'Label','Help');
c = uimenu(h,'Label','Comfort me');
c.Callback = @(hObject,callbackdata) obj.controller.comfort_me_callback(hObject,callbackdata);

end

