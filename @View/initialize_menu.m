function initialize_menu(obj,p)
%INITIALIZE_MENU Initializes the menu bar

% File menu ---------------------------------------------------------------
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

end

