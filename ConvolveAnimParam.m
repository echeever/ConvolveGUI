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

% Last Modified by GUIDE v2.5 24-Dec-2014 09:56:26

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @ConvolveAnimParam_OpeningFcn, ...
    'gui_OutputFcn',  @ConvolveAnimParam_OutputFcn, ...
    'gui_LayoutFcn',  [] , ...
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


% --- Executes just before ConvolveAnimParam is made visible.
function ConvolveAnimParam_OpeningFcn(hObject, ~, handles, varargin)
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

guidata(hObject, handles);  % Update handles structure
% UIWAIT makes ConvolveAnimParam wait for user response (see UIRESUME)
uiwait(handles.ConvolveAnimParamDlg);
 

% --- Outputs from this function are returned to the command line.
function varargout = ConvolveAnimParam_OutputFcn(~, ~, handles)
myFName=get(handles.textFileName,'String');
varargout{2}=handles.filePath;
varargout{3}=str2double(get(handles.editNumFrames,'String'));
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
varargout{7}=str2double(get(handles.editFPS,'String'));

[~, ~, ext] = fileparts(myFName);
if (strcmp(ext,'')),
    switch movieType,
        case {1}
            myFName=[myFName '.mat'];
        case {2, 3}
            myFName=[myFName '.avi'];
        otherwise
            beep;
            disp('Warning 2, unknown file type, ConvolveAnimParam_OutputFcn');
           % movieType=1;
    end
end
varargout{1}=myFName;

delete(handles.ConvolveAnimParamDlg);


function editNumFrames_Callback(~, ~, ~) %#ok<*DEFNU>

function editFPS_Callback(~, ~, ~)

% --- Executes on button press in checkShowLegend.
function checkShowLegend_Callback(~, ~, ~)

% --- Executes on button press in checkSaveFile.
function checkSaveFile_Callback(~, ~, ~)

% --- Executes on button press in pushDone.
function pushDone_Callback(~, ~, ~)  
uiresume;

% --- Executes when user attempts to close ConvolveAnimParamDlg.
function ConvolveAnimParamDlg_CloseRequestFcn(hObject, ~, ~)
delete(hObject);


% --- Executes during object creation, after setting all properties.
function editNumFrames_CreateFcn(hObject, ~, ~)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


function editFPS_CreateFcn(hObject, ~, ~)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


% --- Executes on button press in radioMatLabMovie.
function radioMatLabMovie_Callback(~, ~, handles)
set(handles.radioMatLabMovie,'Value',1);
set(handles.radioAviComp,'Value',0);
set(handles.radioAviNotComp,'Value',0);

% --- Executes on button press in radioAviComp.
function radioAviComp_Callback(~, ~, handles)
set(handles.radioAviComp,'Value',1);
set(handles.radioMatLabMovie,'Value',0);
set(handles.radioAviNotComp,'Value',0);

% --- Executes on button press in radioAviNotComp.
function radioAviNotComp_Callback(~, ~, handles)
set(handles.radioAviNotComp,'Value',1);
set(handles.radioMatLabMovie,'Value',0);
set(handles.radioAviComp,'Value',0);


% --- Executes on button press in pushFileName.
function pushFileName_Callback(~, ~, handles)
if (get(handles.radioMatLabMovie,'Value')==1),
    [fileName, pathName]=uiputfile('*.mat','Save Matlab Movie as .mat file');
elseif ((get(handles.radioAviComp,'Value')==1) || ...
        (get(handles.radioAviNotComp,'Value')==1)),
        [fileName, pathName]=uiputfile('*.avi','Save Matlab Movie as .avi file');
else
    errordlg('Unknown file type, ConvolveAnimParam, pushFileName_Callback');
end
if (fileName~=0),
    set(handles.textFileName,'String',fileName);
    handles.filePath=pathName;
end
guidata(handles.ConvolveAnimParamDlg, handles);

