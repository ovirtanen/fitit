function varargout = fit_it_ui(varargin)
%FIT_IT_UI M-file for fit_it_ui.fig
%      FIT_IT_UI, by itself, creates a new FIT_IT_UI or raises the existing
%      singleton*.
%
%      H = FIT_IT_UI returns the handle to a new FIT_IT_UI or the handle to
%      the existing singleton*.
%
%      FIT_IT_UI('Property','Value',...) creates a new FIT_IT_UI using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to fit_it_ui_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      FIT_IT_UI('CALLBACK') and FIT_IT_UI('CALLBACK',hObj    ect,...) call the
%      local function named CALLBACK in FIT_IT_UI.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help fit_it_ui

% Last Modified by GUIDE v2.5 07-Jan-2015 09:08:14

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @fit_it_ui_OpeningFcn, ...
                   'gui_OutputFcn',  @fit_it_ui_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
   gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before fit_it_ui is made visible.
function fit_it_ui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

% Choose default command line output for fit_it_ui
handles.output = hObject;


% get handle to the controller & the view
for i = 1:2:length(varargin)
    
    switch varargin{i}
        
        case 'controller'
            
            handles.controller = varargin{i+1};
            
        case 'view'
            
            handles.view = varargin{i+1};
        
        otherwise
            error('unknown input')
            
    end % switch
end % for


%%% Initialize default values to edit boxes and sliders

pmap = handles.controller.model.param_map;
m = handles.controller.model;

for i = keys(pmap)
    
    fieldname = i{1};
    
    if strfind(fieldname,'_chck')   % checkbox
        
        set(handles.(fieldname),'Value',m.get_fit_param(fieldname));
       
    else % editable text box
        
        index = m.get_fit_param_index(fieldname);
        
        set(handles.(fieldname),'String',num2str(m.get_fit_param(index))); 
        
        % set corresponding slider values
        if strfind(fieldname,'_min')            % minimum limit
            
            set(handles.([fieldname(1:end-4) '_sldr']),'Min',m.get_fit_param(index)); 
            
        elseif strfind(fieldname,'_val')        % fit value
            
            set(handles.([fieldname(1:end-4) '_sldr']),'Value',m.get_fit_param(index)); 
            
        elseif strfind(fieldname,'_max')        % maximum limit
            
            set(handles.([fieldname(1:end-4) '_sldr']),'Max',m.get_fit_param(index)); 
            
        end % inner if     
        
    end % if
    
end % for

%%% Initialize calculate_btn

set(handles.calculate_btn,'String','No data loaded')
set(handles.calculate_btn,'Enable','off')


%%% Initialize axes

v = handles.view;

v.initialize_form_factor_axes(handles.form_factor_axes);
%v.initialize_residual_axes(handles.residual_axes);
v.initialize_pd_axes(handles.pd_axes);
v.initialize_psd_axes(handles.psd_axes);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes fit_it_ui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = fit_it_ui_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in calculate_btn.
function calculate_btn_Callback(hObject, eventdata, handles)
% hObject    handle to calculate_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.view.fit_callback();



function meanr_min_Callback(hObject, eventdata, handles)
% hObject    handle to meanr_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of meanr_min as text
%        str2double(get(hObject,'String')) returns contents of meanr_min as a double

tag = 'meanr_min';
type = 'min';
inp = str2double(get(hObject,'String'));

handles.view.edit_box_callback(hObject,inp,tag,type);


% --- Executes during object creation, after setting all properties.
function meanr_min_CreateFcn(hObject, eventdata, handles)
% hObject    handle to meanr_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function meanr_val_Callback(hObject, eventdata, handles)
% hObject    handle to meanr_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of meanr_val as text
%        str2double(get(hObject,'String')) returns contents of meanr_val as a double

tag = 'meanr_val';
type = 'val';
inp = str2double(get(hObject,'String'));

handles.view.edit_box_callback(hObject,inp,tag,type);


% --- Executes during object creation, after setting all properties.
function meanr_val_CreateFcn(hObject, eventdata, handles)
% hObject    handle to meanr_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function meanr_max_Callback(hObject, eventdata, handles)
% hObject    handle to meanr_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of meanr_max as text
%        str2double(get(hObject,'String')) returns contents of meanr_max as a double

tag = 'meanr_max';
type = 'max';
inp = str2double(get(hObject,'String'));

handles.view.edit_box_callback(hObject,inp,tag,type);


% --- Executes during object creation, after setting all properties.
function meanr_max_CreateFcn(hObject, eventdata, handles)
% hObject    handle to meanr_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in meanr_chck.
function meanr_chck_Callback(hObject, eventdata, handles)
% hObject    handle to meanr_chck (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of meanr_chck

tag = 'meanr_chck';
inp = get(hObject,'Value');

handles.view.chck_box_callback(inp,tag);


% --- Executes on slider movement.
function meanr_sldr_Callback(hObject, eventdata, handles)
% hObject    handle to meanr_sldr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

tag = 'meanr_sldr';
inp = get(hObject,'Value');

handles.view.slider_callback(hObject,inp,tag);




% --- Executes during object creation, after setting all properties.
function meanr_sldr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to meanr_sldr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function pdisp_min_Callback(hObject, eventdata, handles)
% hObject    handle to pdisp_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of pdisp_min as text
%        str2double(get(hObject,'String')) returns contents of pdisp_min as a double

tag = 'pdisp_min';
type = 'min';
inp = str2double(get(hObject,'String'));

handles.view.edit_box_callback(hObject,inp,tag,type);


% --- Executes during object creation, after setting all properties.
function pdisp_min_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pdisp_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function pdisp_val_Callback(hObject, eventdata, handles)
% hObject    handle to pdisp_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of pdisp_val as text
%        str2double(get(hObject,'String')) returns contents of pdisp_val as a double

tag = 'pdisp_val';
type = 'val';
inp = str2double(get(hObject,'String'));

handles.view.edit_box_callback(hObject,inp,tag,type);


% --- Executes during object creation, after setting all properties.
function pdisp_val_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pdisp_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function pdisp_max_Callback(hObject, eventdata, handles)
% hObject    handle to pdisp_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of pdisp_max as text
%        str2double(get(hObject,'String')) returns contents of pdisp_max as a double

tag = 'pdisp_max';
type = 'max';
inp = str2double(get(hObject,'String'));

handles.view.edit_box_callback(hObject,inp,tag,type);



% --- Executes during object creation, after setting all properties.
function pdisp_max_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pdisp_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function epds_min_Callback(hObject, eventdata, handles)
% hObject    handle to epds_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of epds_min as text
%        str2double(get(hObject,'String')) returns contents of epds_min as a double

tag = 'epds_min';
type = 'min';
inp = str2double(get(hObject,'String'));

handles.view.edit_box_callback(hObject,inp,tag,type);


% --- Executes during object creation, after setting all properties.
function epds_min_CreateFcn(hObject, eventdata, handles)
% hObject    handle to epds_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function epds_val_Callback(hObject, eventdata, handles)
% hObject    handle to epds_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of epds_val as text
%        str2double(get(hObject,'String')) returns contents of epds_val as a double

tag = 'epds_val';
type = 'val';
inp = str2double(get(hObject,'String'));

handles.view.edit_box_callback(hObject,inp,tag,type);



% --- Executes during object creation, after setting all properties.
function epds_val_CreateFcn(hObject, eventdata, handles)
% hObject    handle to epds_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function epds_max_Callback(hObject, eventdata, handles)
% hObject    handle to epds_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of epds_max as text
%        str2double(get(hObject,'String')) returns contents of epds_max as a double

tag = 'epds_max';
type = 'max';
inp = str2double(get(hObject,'String'));

handles.view.edit_box_callback(hObject,inp,tag,type);



% --- Executes during object creation, after setting all properties.
function epds_max_CreateFcn(hObject, eventdata, handles)
% hObject    handle to epds_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in epds_chck.
function epds_chck_Callback(hObject, eventdata, handles)
% hObject    handle to epds_chck (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of epds_chck

tag = 'epds_chck';
inp = get(hObject,'Value');

handles.view.chck_box_callback(inp,tag);


% --- Executes on slider movement.
function epds_sldr_Callback(hObject, eventdata, handles)
% hObject    handle to epds_sldr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

tag = 'epds_sldr';
inp = get(hObject,'Value');

handles.view.slider_callback(hObject,inp,tag);


% --- Executes during object creation, after setting all properties.
function epds_sldr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to epds_sldr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function fuzz_min_Callback(hObject, eventdata, handles)
% hObject    handle to fuzz_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fuzz_min as text
%        str2double(get(hObject,'String')) returns contents of fuzz_min as a double

tag = 'fuzz_min';
type = 'min';
inp = str2double(get(hObject,'String'));

handles.view.edit_box_callback(hObject,inp,tag,type);



% --- Executes during object creation, after setting all properties.
function fuzz_min_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fuzz_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function fuzz_val_Callback(hObject, eventdata, handles)
% hObject    handle to fuzz_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fuzz_val as text
%        str2double(get(hObject,'String')) returns contents of fuzz_val as a double

tag = 'fuzz_val';
type = 'val';
inp = str2double(get(hObject,'String'));

handles.view.edit_box_callback(hObject,inp,tag,type);


% --- Executes during object creation, after setting all properties.
function fuzz_val_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fuzz_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function fuzz_max_Callback(hObject, eventdata, handles)
% hObject    handle to fuzz_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fuzz_max as text
%        str2double(get(hObject,'String')) returns contents of fuzz_max as a double

tag = 'fuzz_max';
type = 'max';
inp = str2double(get(hObject,'String'));

handles.view.edit_box_callback(hObject,inp,tag,type);


% --- Executes during object creation, after setting all properties.
function fuzz_max_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fuzz_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in fuzz_chck.
function fuzz_chck_Callback(hObject, eventdata, handles)
% hObject    handle to fuzz_chck (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of fuzz_chck

tag = 'fuzz_chck';
inp = get(hObject,'Value');

handles.view.chck_box_callback(inp,tag);


% --- Executes on slider movement.
function fuzz_sldr_Callback(hObject, eventdata, handles)
% hObject    handle to fuzz_sldr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

tag = 'fuzz_sldr';
inp = get(hObject,'Value');

handles.view.slider_callback(hObject,inp,tag);


% --- Executes during object creation, after setting all properties.
function fuzz_sldr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fuzz_sldr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function amplitude_min_Callback(hObject, eventdata, handles)
% hObject    handle to amplitude_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of amplitude_min as text
%        str2double(get(hObject,'String')) returns contents of amplitude_min as a double

tag = 'amplitude_min';
type = 'min';
inp = str2double(get(hObject,'String'));

handles.view.edit_box_callback(hObject,inp,tag,type);


% --- Executes during object creation, after setting all properties.
function amplitude_min_CreateFcn(hObject, eventdata, handles)
% hObject    handle to amplitude_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function amplitude_val_Callback(hObject, eventdata, handles)
% hObject    handle to amplitude_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of amplitude_val as text
%        str2double(get(hObject,'String')) returns contents of amplitude_val as a double

tag = 'amplitude_val';
type = 'val';
inp = str2double(get(hObject,'String'));

handles.view.edit_box_callback(hObject,inp,tag,type);


% --- Executes during object creation, after setting all properties.
function amplitude_val_CreateFcn(hObject, eventdata, handles)
% hObject    handle to amplitude_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function amplitude_max_Callback(hObject, eventdata, handles)
% hObject    handle to amplitude_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of amplitude_max as text
%        str2double(get(hObject,'String')) returns contents of amplitude_max as a double

tag = 'amplitude_max';
type = 'max';
inp = str2double(get(hObject,'String'));

handles.view.edit_box_callback(hObject,inp,tag,type);

% --- Executes during object creation, after setting all properties.
function amplitude_max_CreateFcn(hObject, eventdata, handles)
% hObject    handle to amplitude_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in amplitude_chck.
function amplitude_chck_Callback(hObject, eventdata, handles)
% hObject    handle to amplitude_chck (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of amplitude_chck

tag = 'amplitude_chck';
inp = get(hObject,'Value');

handles.view.chck_box_callback(inp,tag);


% --- Executes on slider movement.
function amplitude_sldr_Callback(hObject, eventdata, handles)
% hObject    handle to amplitude_sldr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

tag = 'amplitude_sldr';
inp = get(hObject,'Value');

handles.view.slider_callback(hObject,inp,tag);


% --- Executes during object creation, after setting all properties.
function amplitude_sldr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to amplitude_sldr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function sd_min_Callback(hObject, eventdata, handles)
% hObject    handle to sd_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sd_min as text
%        str2double(get(hObject,'String')) returns contents of sd_min as a double

tag = 'sd_min';
type = 'min';
inp = str2double(get(hObject,'String'));

handles.view.edit_box_callback(hObject,inp,tag,type);


% --- Executes during object creation, after setting all properties.
function sd_min_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sd_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function pdisp_sldr_Callback(hObject, eventdata, handles)
% hObject    handle to pdisp_sldr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

tag = 'pdisp_sldr';
inp = get(hObject,'Value');

handles.view.slider_callback(hObject,inp,tag);


% --- Executes during object creation, after setting all properties.
function pdisp_sldr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pdisp_sldr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on button press in pdisp_chck.
function pdisp_chck_Callback(hObject, eventdata, handles)
% hObject    handle to pdisp_chck (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of amplitude_chck

tag = 'pdisp_chck';
inp = get(hObject,'Value');

handles.view.chck_box_callback(inp,tag);


% --------------------------------------------------------------------
function f_menu_Callback(hObject, eventdata, handles)
% File menu
% hObject    handle to f_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function a_smenu_Callback(hObject, eventdata, handles)
% About menu
% hObject    handle to a_smenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.view.about_menu_callback();


% --------------------------------------------------------------------
function id_smenu_Callback(hObject, eventdata, handles)
% Import Data menu
% hObject    handle to id_smenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.view.import_data_callback();



% --------------------------------------------------------------------
function sd_smenu_Callback(hObject, eventdata, handles)
% Save Data menu
% hObject    handle to sd_smenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.view.save_data_callback();


% --------------------------------------------------------------------
function q_smenu_Callback(hObject, eventdata, handles)
% Quit menu
% hObject    handle to q_smenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.view.close_btn_callback(handles);



% --------------------------------------------------------------------
function h_menu_Callback(hObject, eventdata, handles)
% Help menu
% hObject    handle to h_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function dr_min_Callback(hObject, eventdata, handles)
% hObject    handle to dr_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of dr_min as text
%        str2double(get(hObject,'String')) returns contents of dr_min as a double

tag = 'dr_min';
type = 'min';
inp = str2double(get(hObject,'String'));

handles.view.edit_box_callback(hObject,inp,tag,type);


% --- Executes during object creation, after setting all properties.
function dr_min_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dr_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function dr_val_Callback(hObject, eventdata, handles)
% hObject    handle to dr_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of dr_val as text
%        str2double(get(hObject,'String')) returns contents of dr_val as a double

tag = 'dr_val';
type = 'val';
inp = str2double(get(hObject,'String'));

handles.view.edit_box_callback(hObject,inp,tag,type);


% --- Executes during object creation, after setting all properties.
function dr_val_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dr_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function dr_max_Callback(hObject, eventdata, handles)
% hObject    handle to dr_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of dr_max as text
%        str2double(get(hObject,'String')) returns contents of dr_max as a double

tag = 'dr_max';
type = 'max';
inp = str2double(get(hObject,'String'));

handles.view.edit_box_callback(hObject,inp,tag,type);


% --- Executes during object creation, after setting all properties.
function dr_max_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dr_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in dr_chck.
function dr_chck_Callback(hObject, eventdata, handles)
% hObject    handle to dr_chck (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of dr_chck

tag = 'dr_chck';
inp = get(hObject,'Value');

handles.view.chck_box_callback(inp,tag);


% --- Executes on slider movement.
function dr_sldr_Callback(hObject, eventdata, handles)
% hObject    handle to dr_sldr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

tag = 'dr_sldr';
inp = get(hObject,'Value');

handles.view.slider_callback(hObject,inp,tag);


% --- Executes during object creation, after setting all properties.
function dr_sldr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dr_sldr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes when user attempts to close fitit.
function fitit_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to fitit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
%delete(hObject);
handles.view.close_btn_callback(handles);
