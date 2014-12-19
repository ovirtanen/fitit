function varargout = View(varargin)
%VIEW M-file for View.fig
%      VIEW, by itself, creates a new VIEW or raises the existing
%      singleton*.
%
%      H = VIEW returns the handle to a new VIEW or the handle to
%      the existing singleton*.
%
%      VIEW('Property','Value',...) creates a new VIEW using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to View_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      VIEW('CALLBACK') and VIEW('CALLBACK',hObject,...) call the
%      local function named CALLBACK in VIEW.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help View

% Last Modified by GUIDE v2.5 19-Dec-2014 21:12:20

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @View_OpeningFcn, ...
                   'gui_OutputFcn',  @View_OutputFcn, ...
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


% --- Executes just before View is made visible.
function View_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

% Choose default command line output for View
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes View wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = View_OutputFcn(hObject, eventdata, handles)
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



function prda_min_Callback(hObject, eventdata, handles)
% hObject    handle to prda_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of prda_min as text
%        str2double(get(hObject,'String')) returns contents of prda_min as a double


% --- Executes during object creation, after setting all properties.
function prda_min_CreateFcn(hObject, eventdata, handles)
% hObject    handle to prda_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function prda_val_Callback(hObject, eventdata, handles)
% hObject    handle to prda_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of prda_val as text
%        str2double(get(hObject,'String')) returns contents of prda_val as a double


% --- Executes during object creation, after setting all properties.
function prda_val_CreateFcn(hObject, eventdata, handles)
% hObject    handle to prda_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function prda_max_Callback(hObject, eventdata, handles)
% hObject    handle to prda_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of prda_max as text
%        str2double(get(hObject,'String')) returns contents of prda_max as a double


% --- Executes during object creation, after setting all properties.
function prda_max_CreateFcn(hObject, eventdata, handles)
% hObject    handle to prda_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in prda_chck.
function prda_chck_Callback(hObject, eventdata, handles)
% hObject    handle to prda_chck (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of prda_chck


% --- Executes on slider movement.
function prda_sldr_Callback(hObject, eventdata, handles)
% hObject    handle to prda_sldr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function prda_sldr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to prda_sldr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function prdc_min_Callback(hObject, eventdata, handles)
% hObject    handle to prdc_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of prdc_min as text
%        str2double(get(hObject,'String')) returns contents of prdc_min as a double


% --- Executes during object creation, after setting all properties.
function prdc_min_CreateFcn(hObject, eventdata, handles)
% hObject    handle to prdc_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function prdc_val_Callback(hObject, eventdata, handles)
% hObject    handle to prdc_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of prdc_val as text
%        str2double(get(hObject,'String')) returns contents of prdc_val as a double


% --- Executes during object creation, after setting all properties.
function prdc_val_CreateFcn(hObject, eventdata, handles)
% hObject    handle to prdc_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function prdc_max_Callback(hObject, eventdata, handles)
% hObject    handle to prdc_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of prdc_max as text
%        str2double(get(hObject,'String')) returns contents of prdc_max as a double


% --- Executes during object creation, after setting all properties.
function prdc_max_CreateFcn(hObject, eventdata, handles)
% hObject    handle to prdc_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in prdc_chck.
function prdc_chck_Callback(hObject, eventdata, handles)
% hObject    handle to prdc_chck (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of prdc_chck


% --- Executes on slider movement.
function prdc_sldr_Callback(hObject, eventdata, handles)
% hObject    handle to prdc_sldr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function prdc_sldr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to prdc_sldr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function prdk_min_Callback(hObject, eventdata, handles)
% hObject    handle to prdk_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of prdk_min as text
%        str2double(get(hObject,'String')) returns contents of prdk_min as a double


% --- Executes during object creation, after setting all properties.
function prdk_min_CreateFcn(hObject, eventdata, handles)
% hObject    handle to prdk_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function prdk_val_Callback(hObject, eventdata, handles)
% hObject    handle to prdk_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of prdk_val as text
%        str2double(get(hObject,'String')) returns contents of prdk_val as a double


% --- Executes during object creation, after setting all properties.
function prdk_val_CreateFcn(hObject, eventdata, handles)
% hObject    handle to prdk_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function prdk_max_Callback(hObject, eventdata, handles)
% hObject    handle to prdk_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of prdk_max as text
%        str2double(get(hObject,'String')) returns contents of prdk_max as a double


% --- Executes during object creation, after setting all properties.
function prdk_max_CreateFcn(hObject, eventdata, handles)
% hObject    handle to prdk_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in prdk_chck.
function prdk_chck_Callback(hObject, eventdata, handles)
% hObject    handle to prdk_chck (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of prdk_chck


% --- Executes on slider movement.
function prdk_sldr_Callback(hObject, eventdata, handles)
% hObject    handle to prdk_sldr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function prdk_sldr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to prdk_sldr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function boxradius_min_Callback(hObject, eventdata, handles)
% hObject    handle to boxradius_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of boxradius_min as text
%        str2double(get(hObject,'String')) returns contents of boxradius_min as a double


% --- Executes during object creation, after setting all properties.
function boxradius_min_CreateFcn(hObject, eventdata, handles)
% hObject    handle to boxradius_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function boxradius_val_Callback(hObject, eventdata, handles)
% hObject    handle to boxradius_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of boxradius_val as text
%        str2double(get(hObject,'String')) returns contents of boxradius_val as a double


% --- Executes during object creation, after setting all properties.
function boxradius_val_CreateFcn(hObject, eventdata, handles)
% hObject    handle to boxradius_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function boxradius_max_Callback(hObject, eventdata, handles)
% hObject    handle to boxradius_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of boxradius_max as text
%        str2double(get(hObject,'String')) returns contents of boxradius_max as a double


% --- Executes during object creation, after setting all properties.
function boxradius_max_CreateFcn(hObject, eventdata, handles)
% hObject    handle to boxradius_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in boxradius_chck.
function boxradius_chck_Callback(hObject, eventdata, handles)
% hObject    handle to boxradius_chck (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of boxradius_chck


% --- Executes on slider movement.
function boxradius_sldr_Callback(hObject, eventdata, handles)
% hObject    handle to boxradius_sldr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function boxradius_sldr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to boxradius_sldr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function intercept_min_Callback(hObject, eventdata, handles)
% hObject    handle to intercept_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of intercept_min as text
%        str2double(get(hObject,'String')) returns contents of intercept_min as a double


% --- Executes during object creation, after setting all properties.
function intercept_min_CreateFcn(hObject, eventdata, handles)
% hObject    handle to intercept_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function intercept_val_Callback(hObject, eventdata, handles)
% hObject    handle to intercept_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of intercept_val as text
%        str2double(get(hObject,'String')) returns contents of intercept_val as a double


% --- Executes during object creation, after setting all properties.
function intercept_val_CreateFcn(hObject, eventdata, handles)
% hObject    handle to intercept_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function intercept_max_Callback(hObject, eventdata, handles)
% hObject    handle to intercept_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of intercept_max as text
%        str2double(get(hObject,'String')) returns contents of intercept_max as a double


% --- Executes during object creation, after setting all properties.
function intercept_max_CreateFcn(hObject, eventdata, handles)
% hObject    handle to intercept_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in intercept_chck.
function intercept_chck_Callback(hObject, eventdata, handles)
% hObject    handle to intercept_chck (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of intercept_chck


% --- Executes on slider movement.
function intercept_sldr_Callback(hObject, eventdata, handles)
% hObject    handle to intercept_sldr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function intercept_sldr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to intercept_sldr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function corner_min_Callback(hObject, eventdata, handles)
% hObject    handle to corner_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of corner_min as text
%        str2double(get(hObject,'String')) returns contents of corner_min as a double


% --- Executes during object creation, after setting all properties.
function corner_min_CreateFcn(hObject, eventdata, handles)
% hObject    handle to corner_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function corner_val_Callback(hObject, eventdata, handles)
% hObject    handle to corner_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of corner_val as text
%        str2double(get(hObject,'String')) returns contents of corner_val as a double


% --- Executes during object creation, after setting all properties.
function corner_val_CreateFcn(hObject, eventdata, handles)
% hObject    handle to corner_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function corner_max_Callback(hObject, eventdata, handles)
% hObject    handle to corner_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of corner_max as text
%        str2double(get(hObject,'String')) returns contents of corner_max as a double


% --- Executes during object creation, after setting all properties.
function corner_max_CreateFcn(hObject, eventdata, handles)
% hObject    handle to corner_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in corner_chck.
function corner_chck_Callback(hObject, eventdata, handles)
% hObject    handle to corner_chck (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of corner_chck


% --- Executes on slider movement.
function corner_sldr_Callback(hObject, eventdata, handles)
% hObject    handle to corner_sldr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function corner_sldr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to corner_sldr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function gaussianw_min_Callback(hObject, eventdata, handles)
% hObject    handle to gaussianw_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of gaussianw_min as text
%        str2double(get(hObject,'String')) returns contents of gaussianw_min as a double


% --- Executes during object creation, after setting all properties.
function gaussianw_min_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gaussianw_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function gaussianw_val_Callback(hObject, eventdata, handles)
% hObject    handle to gaussianw_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of gaussianw_val as text
%        str2double(get(hObject,'String')) returns contents of gaussianw_val as a double


% --- Executes during object creation, after setting all properties.
function gaussianw_val_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gaussianw_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function gaussianw_max_Callback(hObject, eventdata, handles)
% hObject    handle to gaussianw_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of gaussianw_max as text
%        str2double(get(hObject,'String')) returns contents of gaussianw_max as a double


% --- Executes during object creation, after setting all properties.
function gaussianw_max_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gaussianw_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in gaussianw_chck.
function gaussianw_chck_Callback(hObject, eventdata, handles)
% hObject    handle to gaussianw_chck (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of gaussianw_chck


% --- Executes on slider movement.
function gaussianw_Callback(hObject, eventdata, handles)
% hObject    handle to gaussianw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function gaussianw_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gaussianw (see GCBO)
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


% --- Executes on slider movement.
function amplitude_sldr_Callback(hObject, eventdata, handles)
% hObject    handle to amplitude_sldr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function amplitude_sldr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to amplitude_sldr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
