function [enable,ri,wl,eta,fixed] = display_br_dialog(obj,dri,dwl,deta,dfixed)
%DISPLAY_BR_DIALOG Displays a dialog for collecting data for the cuvette
%backreflection
%   
% [ri,wl,eta,free] = display_br_dialog(dri,dwl,deta,dfree)
% 
% Parameters
% dri           Default value for refractive index
% dwl           Default value for wavelenght (nm)
% deta          Default value for fraction of reflected intensity
% dfixed        Default value whether fixed (1) or free (0) parameter
%
% Returns
% ri            User specified refractive index
% wl            User specified wavelength
% eta           User specified fraction of reflected intensity
% fixed         User specified boolean for fixed (1) or free (0) fit
%
% If the dialog box is cancelled, empty arrays will be returned.

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.

%% Dialog
d = dialog();
d.Visible = 'off';
d.Name = 'SLS backreflection';
d.Units = 'pixels';
d.Position = [0 0 200 200];

d.Units = 'normalized';
d.Position(1:2) = [0.5 0.5];
d.Units = 'pixels';

%% Ri
ritxt = uicontrol('Parent',d);
ritxt.Style = 'text';
ritxt.HorizontalAlignment = 'left';
ritxt.String = 'Refractive index: ';
ritxt.Units = 'normalized';
ritxt.Position = [0.05 0.78 0.45 0.10];

riedit = uicontrol('Parent',d);
riedit.Style = 'edit';
riedit.HorizontalAlignment = 'left';
riedit.String = num2str(dri);
riedit.Units = 'normalized';
riedit.Position = [0.55 0.8 0.3 0.10];


%% Wl

wltxt = uicontrol('Parent',d);
wltxt.Style = 'text';
wltxt.HorizontalAlignment = 'left';
wltxt.String = 'Wavelength (nm): ';
wltxt.Units = 'normalized';
wltxt.Position = [0.05 0.63 0.45 0.10];

wledit = uicontrol('Parent',d);
wledit.Style = 'edit';
wledit.HorizontalAlignment = 'left';
wledit.String = num2str(dwl);
wledit.Units = 'normalized';
wledit.Position = [0.55 0.65 0.3 0.10];


%% Eta

etatxt = uicontrol('Parent',d);
etatxt.Style = 'text';
etatxt.HorizontalAlignment = 'left';
etatxt.String = 'Eta:';
etatxt.Units = 'normalized';
etatxt.Position = [0.05 0.48 0.45 0.10];

etaedit = uicontrol('Parent',d);
etaedit.Style = 'edit';
etaedit.HorizontalAlignment = 'left';
etaedit.String = num2str(deta);
etaedit.Units = 'normalized';
etaedit.Position = [0.55 0.50 0.3 0.10];


%% Free or fixed

fixedtxt = uicontrol('Parent',d);
fixedtxt.Style = 'text';
fixedtxt.HorizontalAlignment = 'left';
fixedtxt.String = 'Fix eta:';
fixedtxt.Units = 'normalized';
fixedtxt.Position = [0.05 0.33 0.45 0.10];

fixedbox = uicontrol('Parent',d);
fixedbox.Style = 'checkbox';
fixedbox.HorizontalAlignment = 'left';
fixedbox.Value = dfixed;
fixedbox.Units = 'normalized';
fixedbox.Position = [0.55 0.35 0.3 0.10];


%% Enable, disable and cancel buttons
ebtn = uicontrol('Parent',d);
ebtn.Units = 'normalized';
ebtn.Position = [0.65 0.05 0.3 0.15];
ebtn.Callback = @ebtncallback;

if not(isempty(obj.model.sls_br)) && obj.model.sls_br.enabled == 1
   
    ebtn.String = 'Update';
   
else
    
    ebtn.String = 'Enable';
    
end

dbtn = uicontrol('Parent',d);
dbtn.Units = 'normalized';
dbtn.Position = [0.35 0.05 0.3 0.15];
dbtn.String = 'Disable';
dbtn.Callback = @dbtncallback;

if isempty(obj.model.sls_br) || obj.model.sls_br.enabled == 0
   
    dbtn.Enable = 'off';
   
else
    
    dbtn.Enable = 'on';
    
end

   
cbtn = uicontrol('Parent',d);
cbtn.Units = 'normalized';
cbtn.Position = [0.05 0.05 0.3 0.15];
cbtn.String = 'Cancel';
cbtn.Callback = @cbtncallback;

d.Visible = 'on';
uiwait(d);

%% Dialog callbacks

    function ebtncallback(hObject,callbackdata)
        
        enable = true;
        ri = str2num(riedit.String);
        wl = str2num(wledit.String);
        eta = str2num(etaedit.String);
        fixed = logical(fixedbox.Value);
        d.delete();
        
    end

    function dbtncallback(hObject,callbackdata)
        
        enable = false;
        ri = str2num(riedit.String);
        wl = str2num(wledit.String);
        eta = str2num(etaedit.String);
        fixed = logical(fixedbox.Value);
        d.delete();
        
    end

    function cbtncallback(hObject,callbackdata)
        
        enable = [];
        ri = [];
        wl = [];
        eta = [];
        fixed = [];
        d.delete();
        
    end

end

