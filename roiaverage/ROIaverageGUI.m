function varargout = ROIaverageGUI(varargin)

%ROIaverageGUI M-file for ROIaverageGUI.fig
%      ROIaverageGUI, by itself, creates a new ROIaverageGUI or raises the existing
%      singleton*.
%
%      H = ROIaverageGUI returns the handle to a new ROIaverageGUI or the handle to
%      the existing singleton*.
%
%      ROIaverageGUI('Property','Value',...) creates a new ROIaverageGUI using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to ROIaverageGUI_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      ROIaverageGUI('CALLBACK') and ROIaverageGUI('CALLBACK',hObject,...) call the
%      local function named CALLBACK in ROIaverageGUI.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ROIaverageGUI

% Last Modified by GUIDE v2.5 15-May-2012 12:27:09

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ROIaverageGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @ROIaverageGUI_OutputFcn, ...
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


% --- Executes just before ROIaverageGUI is made visible.
function ROIaverageGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

% Choose default command line output for ROIaverageGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% set(handles.imfilename,'String','Enter Path and File Name');
% set(handles.bhfilename,'String','Enter Path and File Name');
% 
% strLastpath = 'C:\Users\mac\Documents\MATLAB\caplot'; 
% strLastpath2 = 'C:\Users\mac\Desktop\DATA\'; 

% UIWAIT makes ROIaverageGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ROIaverageGUI_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Analyze.
function Analyze_Callback(hObject, eventdata, handles)
% hObject    handle to Analyze (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


xytfilename=get(handles.imfilename,'String');
roifilename=get(handles.roifilename,'String');

samp = str2double(get(handles.samp,'String'));
startframe = str2double(get(handles.startframe,'String'));
endframe = str2double(get(handles.endframe,'String'));

disp('-----ROIaverage analysis start-----')
ROIaverage (xytfilename, roifilename, samp, startframe,endframe);






% --- Executes on button press in close_figures.
function close_figures_Callback(hObject, eventdata, handles)
% hObject    handle to close_figures (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

windows=get(0,'Children');
nwindows=length(windows);

for f = nwindows:-1:nwindows-7
    if ishandle(f)
        close(f);
    end
end

function samp_Callback(hObject, eventdata, handles)
% hObject    handle to samp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of samp as text
%        str2double(get(hObject,'String')) returns contents of samp as a double


% --- Executes during object creation, after setting all properties.
function samp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to samp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function binsize_Callback(hObject, eventdata, handles)
% hObject    handle to samp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of samp as text
%        str2double(get(hObject,'String')) returns contents of samp as a double


% --- Executes during object creation, after setting all properties.
function binsize_CreateFcn(hObject, eventdata, handles)
% hObject    handle to samp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function imfilename_Callback(hObject, eventdata, handles)
% hObject    handle to imfilename (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of imfilename as text
%        str2double(get(hObject,'String')) returns contents of imfilename as a double


% --- Executes during object creation, after setting all properties.
function imfilename_CreateFcn(hObject, eventdata, handles)
% hObject    handle to imfilename (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in browse.
function browse_Callback(hObject, eventdata, handles)
% hObject    handle to browse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if ~exist('strLastpath')  
    strLastpath = '/Users/mac/Desktop/DATA/'; 
end

[strFileRoot strFilePath] = uigetfile( {'*.*' } , 'Select Data File' , strLastpath );
strLastpath = strFilePath;
strFile = [strFilePath strFileRoot];
set(handles.imfilename,'String',strFile);



function startframe_Callback(hObject, eventdata, handles)
% hObject    handle to startframe (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of startframe as text
%        str2double(get(hObject,'String')) returns contents of startframe as a double


% --- Executes during object creation, after setting all properties.
function startframe_CreateFcn(hObject, eventdata, handles)
% hObject    handle to startframe (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function endframe_Callback(hObject, eventdata, handles)
% hObject    handle to endframe (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of endframe as text
%        str2double(get(hObject,'String')) returns contents of endframe as a double


% --- Executes during object creation, after setting all properties.
function endframe_CreateFcn(hObject, eventdata, handles)
% hObject    handle to endframe (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function roifilename_Callback(hObject, eventdata, handles)
% hObject    handle to roifilename (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of roifilename as text
%        str2double(get(hObject,'String')) returns contents of roifilename as a double


% --- Executes during object creation, after setting all properties.
function roifilename_CreateFcn(hObject, eventdata, handles)
% hObject    handle to roifilename (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes on button press in browse4.
function browse4_Callback(hObject, eventdata, handles)
% hObject    handle to browse4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if ~exist('strLastpath')  
    strLastpath = '/Users/mac/Desktop/DATA/'; 
end

[strFileRoot strFilePath] = uigetfile( {'*.*' } , 'Select Data File' , strLastpath );
strLastpath = strFilePath;
strFile = [strFilePath strFileRoot];
set(handles.roifilename,'String',strFile);
