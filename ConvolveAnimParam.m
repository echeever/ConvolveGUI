function varargout = ConvolveAnimParam(varargin)
% CONVOLVEANIMPARAM M-file for ConvolveAnimParam.fig
%      CONVOLVEANIMPARAM, by itself, creates a new CONVOLVEANIMPARAM or raises the existing
%      singleton*.
%
%      H = CONVOLVEANIMPARAM returns the handle to a new CONVOLVEANIMPARAM or the handle to
%      the existing singleton*.
%
%      CONVOLVEANIMPARAM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CONVOLVEANIMPARAM.M with the given input arguments.
%
%      CONVOLVEANIMPARAM('Property','Value',...) creates a new CONVOLVEANIMPARAM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ConvolveAnimParam_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ConvolveAnimParam_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ConvolveAnimParam

% Last Modified by GUIDE v2.5 23-Dec-2003 14:18:51

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @ConvolveAnimParam_OpeningFcn, ...
    'gui_OutputFcn',  @ConvolveAnimParam_OutputFcn, ...
    'gui_LayoutFcn',  [] , ...
    'gui_Callback',   []);
if nargin & isstr(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before ConvolveAnimParam is made visible.
function ConvolveAnimParam_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ConvolveAnimParam (see VARARGIN)

% Choose default command line output for ConvolveAnimParam
handles.output = hObject;    
if (length(varargin)~=7),
    beep;
    disp('Wrong number of input arguments to ConvolveAnimParam');
    uiresume
else
    set(handles.textFileName,'String',varargin{1});
    handles.filePath=varargin{2};
    set(handles.editNumFrames,'String',num2str(varargin{3}));
    set(handles.checkSaveFile,'Value',varargin{4});
    movieType=varargin{5};
    switch (movieType),
        case {1}
            set(handles.radioMatLabMovie,'Value',1);
            set(handles.radioAviComp,'Value',0);
            set(handles.radioAviNotComp,'Value',0);
        case {2}
            set(handles.radioMatLabMovie,'Value',0);
            set(handles.radioAviComp,'Value',1);
            set(handles.radioAviNotComp,'Value',0);
        case {3}
            set(handles.radioMatLabMovie,'Value',0);
            set(handles.radioAviComp,'Value',0);
            set(handles.radioAviNotComp,'Value',1);
        otherwise
            set(handles.radioMatLabMovie,'Value',1);
            set(handles.radioAviComp,'Value',0);
            set(handles.radioAviNotComp,'Value',0);
    end
    
    set(handles.checkShowLegend,'Value',varargin{6});
    set(handles.editFPS,'String',num2str(varargin{7}));
end
% Update handles structure
guidata(hObject, handles);
% UIWAIT makes ConvolveAnimParam wait for user response (see UIRESUME)
uiwait(handles.ConvolveAnimParamDlg);
 

% --- Outputs from this function are returned to the command line.
function varargout = ConvolveAnimParam_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
myFName=get(handles.textFileName,'String');
varargout{2}=handles.filePath;
varargout{3}=str2num(get(handles.editNumFrames,'String'));
varargout{4}=get(handles.checkSaveFile,'Value');
if (get(handles.radioMatLabMovie,'Value')==1),
    movieType=1;
elseif (get(handles.radioAviComp,'Value')==1),
    movieType=2;
elseif (get(handles.radioAviNotComp,'Value')==1),
    movieType=3;
else
    beep;
    disp('Warning 1, unknown file type, ConvolveAnimParam_OutputFcn');
    movieType=1;
end
varargout{5}=movieType;
varargout{6}=get(handles.checkShowLegend,'Value');
varargout{7}=str2num(get(handles.editFPS,'String'));

[pathstr name ext versn] = fileparts(myFName);
if (strcmp(ext,'')),
    switch movieType,
        case {1}
            myFName=[myFName '.mat'];
        case {2, 3}
            myFName=[myFName '.avi'];
        otherwise
            beep;
            disp('Warning 2, unknown file type, ConvolveAnimParam_OutputFcn');
            movieType=1;
    end
end
varargout{1}=myFName;

delete(handles.ConvolveAnimParamDlg);



% --- Executes on button press in pushDone.
function pushDone_Callback(hObject, eventdata, handles)
% hObject    handle to pushDone (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
uiresume;

% --- Executes during object creation, after setting all properties.
function editNumFrames_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editNumFrames (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

function editNumFrames_Callback(hObject, eventdata, handles)
% hObject    handle to editNumFrames (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% --- Executes during object creation, after setting all properties.

function editFPS_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editFPS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

function editFPS_Callback(hObject, eventdata, handles)
% hObject    handle to editFPS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on button press in checkShowLegend.
function checkShowLegend_Callback(hObject, eventdata, handles)
% hObject    handle to checkShowLegend (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on button press in checkSaveFile.
function checkSaveFile_Callback(hObject, eventdata, handles)
% hObject    handle to checkSaveFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on button press in radioMatLabMovie.
function radioMatLabMovie_Callback(hObject, eventdata, handles)
% hObject    handle to radioMatLabMovie (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.radioMatLabMovie,'Value',1);
set(handles.radioAviComp,'Value',0);
set(handles.radioAviNotComp,'Value',0);

% --- Executes on button press in radioAviComp.
function radioAviComp_Callback(hObject, eventdata, handles)
% hObject    handle to radioAviComp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.radioAviComp,'Value',1);
set(handles.radioMatLabMovie,'Value',0);
set(handles.radioAviNotComp,'Value',0);

% --- Executes on button press in radioAviNotComp.
function radioAviNotComp_Callback(hObject, eventdata, handles)
% hObject    handle to radioAviNotComp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.radioAviNotComp,'Value',1);
set(handles.radioMatLabMovie,'Value',0);
set(handles.radioAviComp,'Value',0);


% --- Executes on button press in pushFileName.
function pushFileName_Callback(hObject, eventdata, handles)
% hObject    handle to pushFileName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if (get(handles.radioMatLabMovie,'Value')==1),
    [fileName pathName]=uiputfile('*.mat','Save Matlab Movie as .mat file');
elseif ((get(handles.radioAviComp,'Value')==1) | ...
        (get(handles.radioAviNotComp,'Value')==1)),
        [fileName pathName]=uiputfile('*.avi','Save Matlab Movie as .avi file');
else
    errordlg('Unknown file type, ConvolveAnimParam, pushFileName_Callback');
end
if (fileName~=0),
    set(handles.textFileName,'String',fileName);
    handles.filePath=pathName;
end
guidata(handles.ConvolveAnimParamDlg, handles);




