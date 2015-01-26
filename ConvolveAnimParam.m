function varargout = ConvolveAnimParam(varargin)
% CONVOLVEANIMPARAM M-file for ConvolveAnimParam.fig
%      Helper function for ConvolveGUI.m

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
if (length(varargin)~=8),
    beep;
    disp('Wrong number of input arguments to ConvolveAnimParam');
    uiresume
else
    handles.textFileName.String=varargin{1};
    handles.filePath=varargin{2};
    handles.editNumFrames.String=num2str(varargin{3});
    handles.checkSaveFile.Value=varargin{4};
    movieType=varargin{5};
    switch (movieType),
        case {1}
            handles.radioMatLabMovie.Value=1;
            handles.radioAvi.Value=0;
            handles.radioMp4.Value=0;
        case {2}
            handles.radioMatLabMovie.Value=0;
            handles.radioAvi.Value=1;
            handles.radioMp4.Value=0;
        case {3}
            handles.radioMatLabMovie.Value=0;
            handles.radioAvi.Value=0;
            handles.radioMp4.Value=1;
        otherwise
            handles.radioMatLabMovie.Value=1;
            handles.radioAvi.Value=0;
            handles.radioMp4.Value=0;
    end
    
    handles.checkShowLegend.Value=varargin{6};
    handles.editFPS.String=num2str(varargin{7});
    handles.editVideoQ.String=num2str(varargin{8});
end

guidata(hObject, handles);  % Update handles structure
% UIWAIT makes ConvolveAnimParam wait for user response (see UIRESUME)
uiwait(handles.ConvolveAnimParamDlg);


% --- Outputs from this function are returned to the command line.
function varargout = ConvolveAnimParam_OutputFcn(~, ~, handles)
varargout{1}=handles.textFileName.String;
varargout{2}=handles.filePath;
varargout{3}=str2double(handles.editNumFrames.String);
varargout{4}=handles.checkSaveFile.Value;
if (handles.radioMatLabMovie.Value==1),
    movieType=1;
elseif (handles.radioAvi.Value==1),
    movieType=2;
elseif (handles.radioMp4.Value==1),
    movieType=3;
else
    beep;
    disp('Warning: unknown file type, ConvolveAnimParam_OutputFcn');
    movieType=1;
end
varargout{5}=movieType;
varargout{6}=handles.checkShowLegend.Value;
varargout{7}=str2double(handles.editFPS.String);
varargout{8}=str2double(handles.editVideoQ.String);


delete(handles.ConvolveAnimParamDlg);


function editNumFrames_Callback(~, ~, ~) %#ok<*DEFNU>

function editFPS_Callback(~, ~, ~)

function checkShowLegend_Callback(~, ~, ~)

function checkSaveFile_Callback(~, ~, ~)

function pushDone_Callback(~, ~, ~)
uiresume;

function ConvolveAnimParamDlg_CloseRequestFcn(hObject, ~, ~)
delete(hObject);

function editNumFrames_CreateFcn(hObject, ~, ~)
if ispc && isequal(hObject.BackgroundColor,...
 get(0,'defaultUicontrolBackgroundColor'))
    hObject.BackgroundColor='white';
end

function editFPS_CreateFcn(hObject, ~, ~)
if ispc && isequal(hObject.BackgroundColor,...
 get(0,'defaultUicontrolBackgroundColor'))
    hObject.BackgroundColor='white';
end

function editVideoQ_CreateFcn(hObject, ~, ~)
if ispc && isequal(hObject.BackgroundColor,...
 get(0,'defaultUicontrolBackgroundColor'))
    hObject.BackgroundColor='white';
end

% --- Executes on button press in radioMatLabMovie.
function radioMatLabMovie_Callback(~, ~, handles)
handles.radioMatLabMovie.Value=1;
handles.radioAvi.Value=0;
handles.radioMp4.Value=0;
myFName=handles.textFileName.String;
[pNm, fNm, ~] = fileparts(myFName);   % Strip off extension
handles.textFileName.String=fullfile(pNm, [fNm '.mat']);

% --- Executes on button press in radioAvi.
function radioAvi_Callback(~, ~, handles)
handles.radioAvi.Value=1;
handles.radioMatLabMovie.Value=0;
handles.radioMp4.Value=0;
myFName=handles.textFileName.String;
[pNm, fNm, ~] = fileparts(myFName);   % Strip off extension
handles.textFileName.String=fullfile(pNm, [fNm '.avi']);

% --- Executes on button press in radioMp4.
function radioMp4_Callback(~, ~, handles)
handles.radioMp4.Value=1;
handles.radioMatLabMovie.Value=0;
handles.radioAvi.Value=0;
myFName=handles.textFileName.String;
[pNm, fNm, ~] = fileparts(myFName);   % Strip off extension
handles.textFileName.String=fullfile(pNm, [fNm '.mp4']);

% --- Executes on button press in pushFileName.
function pushFileName_Callback(~, ~, handles)
if handles.radioMatLabMovie.Value==1,
    [fileName, pathName]=uiputfile('*.mat','Save Matlab Movie as .mat file');
elseif handles.radioAvi.Value==1,
    [fileName, pathName]=uiputfile('*.avi','Save Matlab Movie as .avi file');
elseif handles.radioMp4.Value==1,
    [fileName, pathName]=uiputfile('*.mp4','Save Matlab Movie as .mp4 file');
else
    errordlg('Unknown file type, ConvolveAnimParam, pushFileName_Callback');
end
if (fileName~=0),
    handles.textFileName.String=fileName;
    handles.filePath=pathName;
end
guidata(handles.ConvolveAnimParamDlg, handles);



function editVideoQ_Callback(hObject, ~, handles)
try
    Q = round(str2double(hObject.String));
catch
    Q=75;
end
if Q>100, 
    Q=100;
elseif Q<50, 
    Q=50;
end
hObject.String = num2str(Q);
handles.videoQ = Q;
guidata(handles.ConvolveAnimParamDlg, handles);


