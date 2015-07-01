function initialize_menu(obj,p)
%INITIALIZE_MENU Initializes the menu bar

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.

%% FitIt! menu ------------------------------------------------------------
fi = uimenu(p,'Label','FitIt!');
fi.Tag = 'fitit_menu';
obj.menu.fitit = fi;

fia = uimenu(fi,'Label','About');
fia.Callback = @(hObject,callbackdata) obj.controller.about_menu_callback(hObject,callbackdata);

fiq = uimenu(fi,'Label','Quit');
fiq.Callback = @(hObject,callbackdata) obj.controller.quit_callback(hObject,callbackdata);


%% File menu --------------------------------------------------------------
f = uimenu(p,'Label','File');
f.Tag = 'file_menu';
obj.menu.file = f;

fl = uimenu(f,'Label','Load dataset');
fl.Tag = 'single_ds_loader';
fl.Callback = @(hObject,callbackdata) obj.controller.load_data_set_callback(hObject,callbackdata);

flm = uimenu(f,'Label','Load multiset');
%flm.Enable = 'off';
flm.Tag = 'multiple_ds_loader';
flm.Callback = @(hObject,callbackdata) obj.controller.load_data_set_callback(hObject,callbackdata);

fs = uimenu(f,'Label','Save dataset');
fs.Callback = @(hObject,callbackdata) obj.controller.save_data_callback(hObject,callbackdata);


%% Model menu -------------------------------------------------------------
m = uimenu(p,'Label','Model');
m.Tag = 'model_menu';
obj.menu.model = m;

am = Scattering_model.available_models;

for i = 1 : numel(am)
   
   di = uimenu(m);
   di.Label = am{i};
   di.Callback = @(hObject,callbackdata) obj.controller.model_menu_callback(hObject,callbackdata);
    
end

%% Distribution menu ------------------------------------------------------
d = uimenu(p,'Label','Distribution');
d.Tag = 'dist_menu';
obj.menu.dist = d;

di = uimenu(d);
di.Label = 'Load histogram...';
di.Callback = @(hObject,callbackdata) obj.controller.load_histogram_callback(hObject,callbackdata);

ad = Distribution.available_distributions;
for i = 1 : numel(ad)
   
   di = uimenu(d);
   di.Label = ad{i};
   di.Callback = @(hObject,callbackdata) obj.controller.dist_menu_callback(hObject,callbackdata);
    
end

%% Tools menu
t = uimenu(p,'Label','Tools');
t.Tag = 'tools_menu';
obj.menu.tools = t;

tbr = uimenu(t,'Label','Enable SLS Backreflection');
tbr.Tag = 'br_switch';
tbr.Callback = @(hObject,callbackdata) obj.controller.br_switch_callback(hObject,callbackdata);

tlc = uimenu(t,'Label','Determine L-Curve');
tlc.Tag = 'l_curve';
tlc.Callback = @(hObject,callbackdata) obj.controller.l_curve_callback(hObject,callbackdata);
tlc.Enable = 'off';

tgpu = uimenu(t,'Label','Enable GPU');
tgpu.Tag = 'gpu_switch';
tgpu.Callback = @(hObject,callbackdata) obj.controller.gpu_switch_callback(hObject,callbackdata);

tpar = uimenu(t,'Label','Enable Multiple Workers');
tpar.Tag = 'par_switch';
tpar.Callback = @(hObject,callbackdata) obj.controller.par_switch_callback(hObject,callbackdata);

% Check whether Parallel Computing Toolbox is installed

v = ver();
tbs = {v.Name}';

if not(any(strcmp(tbs,'Parallel Computing Toolbox')))
    
    tgpu.Enable = 'off';
    tpar.Enable = 'off';
    
elseif isempty(obj.controller.gpu)
    
    % no GPU available
    tgpu.Enable = 'off';
    
end % if

%% View menu
v = uimenu(p,'Label','View');
v.Tag = 'view_menu';
obj.menu.view = v;

vloglin = uimenu(v,'Label','Log-lin');
vloglin.Tag = 'loglin_scale';
vloglin.Callback = @(hObject,callbackdata) obj.controller.si_scale_callback(hObject,callbackdata);

vloglog = uimenu(v,'Label','Log-log');
vloglog.Tag = 'loglog_scale';
vloglog.Callback = @(hObject,callbackdata) obj.controller.si_scale_callback(hObject,callbackdata);

%% Help menu --------------------------------------------------------------
h = uimenu(p,'Label','Help');
h.Tag = 'help_menu';
obj.menu.help = h;

c = uimenu(h,'Label','Comfort me');
c.Callback = @(hObject,callbackdata) obj.controller.comfort_me_callback(hObject,callbackdata);

end

