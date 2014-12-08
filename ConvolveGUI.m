function varargout = ConvolveGUI_fig(varargin)
% CONVOLVEGUI_FIG M-file for ConvolveGUI_fig.fig
%      CONVOLVEGUI_FIG, by itself, creates a new CONVOLVEGUI_FIG or raises the existing
%      singleton*.
%
%      H = CONVOLVEGUI_FIG returns the handle to a new CONVOLVEGUI_FIG or the handle to
%      the existing singleton*.
%
%      CONVOLVEGUI_FIG('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CONVOLVEGUI_FIG.M with the given input arguments.
%
%      CONVOLVEGUI_FIG('Property','Value',...) creates a new CONVOLVEGUI_FIG or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ConvolveGUI_fig_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ConvolveGUI_fig_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ConvolveGUI_fig

% Last Modified by GUIDE v2.5 11-Jan-2012 13:06:09

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @ConvolveGUI_OpeningFcn, ...
    'gui_OutputFcn',  @ConvolveGUI_OutputFcn, ...
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


% --- Executes just before ConvolveGUI_fig is made visible.
function ConvolveGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ConvolveGUI_fig (see VARARGIN)

% Choose default command line output for ConvolveGUI_fig
handles.output = hObject;
if (length(varargin)==0),
    fname='ConvolveFuncs.mat';
elseif ischar(varargin(1)),
    fname=varargin(1);
else
    fname='';
end

[f,m]=fopen(fname);
if (f==-1),
    errordlg(['File: ' fname ' does not exist.']);
    delete(hObject);
end
funcs=load(fname);
funcFields=fieldnames(funcs);
funcNum=length(funcFields);
for i=1:funcNum,
    funcTemp=eval(['funcs.' char(funcFields(i))]);   %Get function data for function #i.
    funcFunc{i}=funcTemp{1};
    funcDesc{i}=funcTemp{2};
end

handles.funcFunc=funcFunc;
handles.funcDesc=funcDesc;

set(handles.fPopup,'string',funcDesc);
set(handles.hPopup,'string',funcDesc);
set(handles.fPopup,'value',1);
set(handles.hPopup,'value',2);

%These variables are passed back and forth to "ConvolveAnimParam"
%to control animation parameters.
handles.fileName='ConvolvAnim';
handles.filePath=cd;
handles.editNumFrames=20;
handles.checkSaveFile=0;
handles.animFileType=1;
handles.checkShowLegend=0;
handles.editFPS=5;
handles.showLegend=1;

handles.tmin=0;
handles.tmax=0;
handles.dt=0;
handles.t=0;
handles.f=0;
handles.h=0;
handles.y=0;

set(handles.showHideToggle,'Value',0);
set(handles.showHideToggle,'String','Hide Result');

% Update handles structure
timeVal=0;
set(handles.TimeSlider,'Value',timeVal);
set(handles.TimeEditText,'String',num2str(timeVal));
guidata(hObject, handles);
FuncCalc(handles);
handles=guidata(hObject);
FuncDisplay(handles);
% UIWAIT makes ConvolveGUI_fig wait for user response (see UIRESUME)
% uiwait(handles.ConvolveGUI_fig);


% --- Executes during object creation, after setting all properties.
function ConvolveGUI_fig_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ConvolveGUI_fig (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% --- Executes on button press in pushWebResource.
function pushWebResource_Callback(hObject, eventdata, handles)
% hObject    handle to pushWebResource (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
web('http://www.swarthmore.edu/NatSci/echeeve1/Ref/Convolution/ConvolveGUI.html','-browser')

% --- Outputs from this function are returned to the command line.
function varargout = ConvolveGUI_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes during object creation, after setting all properties.
function fPopup_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fPopup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


% --- Executes during object creation, after setting all properties.
function hPopup_CreateFcn(hObject, eventdata, handles)
% hObject    handle to hPopup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


% --- Executes on selection change in hPopup.
function hPopup_Callback(hObject, eventdata, handles)
% hObject    handle to hPopup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.TimeSlider,'Value',0);
set(handles.TimeEditText,'String',num2str(0));
FuncCalc(handles);
handles=guidata(handles.ConvolveGUI_fig);
FuncDisplay(handles);


% --- Executes during object creation, after setting all properties.
function TminText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TminText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function TminText_Callback(hObject, eventdata, handles)
% hObject    handle to TminText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
tmin=str2num(get(handles.TminText,'String'));
set(handles.TimeSlider,'Min',tmin);
FuncCalc(handles);
handles=guidata(handles.ConvolveGUI_fig);
FuncDisplay(handles);


% --- Executes during object creation, after setting all properties.
function TmaxText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TmaxText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


function TmaxText_Callback(hObject, eventdata, handles)
% hObject    handle to TmaxText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
tmax=str2num(get(handles.TmaxText,'String'));
set(handles.TimeSlider,'Max',tmax);
FuncCalc(handles);
handles=guidata(handles.ConvolveGUI_fig);
FuncDisplay(handles);


% --- Executes on button press in Close_button.
function Close_button_Callback(hObject, eventdata, handles)
% hObject    handle to Close_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
disp(' '); disp('Convolution GUI closed.'); disp(' '); disp(' ');
close all
% delete(handles.ConvolveGUI_fig);


% --- Executes during object creation, after setting all properties.
function TimeEditText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TimeEditText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

function TimeEditText_Callback(hObject, eventdata, handles)
% hObject    handle to TimeEditText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
timeVal=str2num(get(handles.TimeEditText,'String'));
set(handles.TimeSlider,'Value',timeVal);
FuncDisplay(handles)

% --- Executes on slider movement.
function TimeSlider_Callback(hObject, eventdata, handles)
% hObject    handle to TimeSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
timeVal=get(handles.TimeSlider,'Value');
set(handles.TimeEditText,'String',num2str(timeVal));
FuncDisplay(handles)

% --- Executes during object creation, after setting all properties.
function TimeSlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TimeSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
usewhitebg = 1;
if usewhitebg
    set(hObject,'BackgroundColor',[.9 .9 .9]);
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

% --- Executes on selection change in fPopup.
function fPopup_Callback(hObject, eventdata, handles)
% hObject    handle to fPopup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.TimeSlider,'Value',0);
set(handles.TimeEditText,'String',num2str(0));
FuncCalc(handles);
handles=guidata(handles.ConvolveGUI_fig);
FuncDisplay(handles);


function FuncCalc(handles)
handles.tmin=str2num(get(handles.TminText,'String'));
handles.tmax=str2num(get(handles.TmaxText,'String'));
handles.dt=(handles.tmax-handles.tmin)/1000;
handles.t=handles.tmin:handles.dt:handles.tmax;
t=handles.t;
fFuncIndex=get(handles.fPopup,'Value');
fFuncStr=char(handles.funcFunc{fFuncIndex});
set(handles.fText,'string',['f(t)= ' fFuncStr]);
handles.f=eval(fFuncStr);
hFuncIndex=get(handles.hPopup,'Value');
hFuncStr=char(handles.funcFunc{hFuncIndex});
set(handles.hText,'string',['h(t)= ' hFuncStr]);
handles.h=eval(hFuncStr);

handles.y=conv(handles.f,handles.h)*handles.dt;
guidata(handles.ConvolveGUI_fig, handles);



function FuncDisplay(handles)
tmin=handles.tmin;
tmax=handles.tmax;
dt=handles.dt;
t=handles.t;
f=handles.f;
h=handles.h;
hFuncIndex=get(handles.hPopup,'Value');
hFuncStr=char(handles.funcFunc{hFuncIndex});
y=handles.y;

%Display f(t) and h(t) on one set of axes.
axes(handles.funcAxes);
plot([tmin tmax],[0 0],'Color',0.75*[1 1 1],'LineStyle',':');
hold on
plot(t,f,'c-.','LineWidth',2);      %Display f(t)
plot(t,h,'m:','LineWidth',1)        %Display h(t)
hold off
%Set axes so that y axes are slightly bigger than the functions.
ylims=get(handles.funcAxes,'YLim');
ylower=ylims(1)-0.05*(ylims(2)-ylims(1));
yupper=ylims(2)+0.05*(ylims(2)-ylims(1));
set(handles.funcAxes,'YLim',[ylower yupper]);
set(handles.funcAxes,'XLim',[tmin tmax]);
if (handles.showLegend==1),
    legend('zero reference','f(t)','h(t)');
end
xlabel('Time');
ylabel('Function');
title('f(t) and h(t) vs. time');

%Display convolution on one set of axes.
axes(handles.convolutionAxes);
plot([tmin tmax],[0 0],'Color',0.75*[1 1 1],'LineStyle',':');
tc=2*tmin+dt*(0:(length(y)-1));     %calculate time vector for convolved sequence.
hold on;

%Get current value of time (from slider) and plot it along with convolution.
timeVal=get(handles.TimeSlider,'Value');
TimeIndex=max(find(timeVal>tc));
plot(tc(TimeIndex),y(TimeIndex),'ko','MarkerFaceColor','k');

% if timeVal is in left half of plot, ...
if timeVal<((tmin+tmax)/2),
    loc='ne';  % ... put legends on upper right.
else
    loc='nw';  % ... else put on upper left.
end

if get(handles.showHideToggle,'Value'),
    %Plot part of convolved sequence.
    plot(tc(1:TimeIndex),y(1:TimeIndex),'g','LineWidth',2);
else
    plot(tc,y,'g','LineWidth',2);       %Plot all of convolved sequence.
end
%Set axes so that y axes are slightly bigger than the functions.
ymin=min(y);
ymax=max(y);
ylims=get(handles.convolutionAxes,'YLim');
ylower=ymin-0.05*(ymax-ymin);
yupper=ymax+0.05*(ymax-ymin);
set(handles.convolutionAxes,'YLim',[ylower yupper]);
set(handles.convolutionAxes,'XLim',[tmin tmax]);
xlabel('Time');
title('Convolution, f(t)*h*t)');

if (handles.showLegend==1), 
    legend('zero ref','f(t)*g(t)','t','Location',loc);
end
hold off

%Display f(tau) and h(t-tau) on one set of axes.
Lambda=t;
tMinusLambda=timeVal-Lambda;
t=timeVal-Lambda;      %This needs to be stored in 't' vector for evaluation (next line).
hTMinusLambda=eval(hFuncStr);
fh=f.*hTMinusLambda;
axes(handles.convolveAxes);
plot([tmin tmax],[0 0],'Color',0.75*[1 1 1],'LineStyle',':');
hold on
plot(Lambda,fh,'k','LineWidth',3);
plot(Lambda,f,'c-.','LineWidth',2);
plot(Lambda,hTMinusLambda,'m:','LineWidth',2);

timeVal=get(handles.TimeSlider,'Value');
TimeIndex=max(find(timeVal>tc));
plot(tc(TimeIndex),0,'ko','MarkerFaceColor','k');


if (handles.showLegend==1),
    legend('zero ref',...
        'f(\lambda)h(t-\lambda)','f(\lambda)','h(t-\lambda)','t',...
        'Location',loc);
end
%Set axes so that y axes are slightly bigger than the functions.
ymin=min([f h fh]);
ymax=max([f h fh]);
ylower=ymin-0.05*(ymax-ymin);
yupper=ymax+0.05*(ymax-ymin);
set(gca,'YLim',[ylower yupper]);
set(gca,'XLim',[tmin tmax]);
xlabel('\lambda');
title('f(\lambda), h(t-\lambda) and their product');
hold off


% --- Executes on button press in AnimParamButton.
function AnimParamButton_Callback(hObject, eventdata, handles)
% hObject    handle to AnimParamButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[v1 v2 v3 v4 v5 v6 v7]=ConvolveAnimParam(...
    handles.fileName,...
    handles.filePath,...
    handles.editNumFrames,...
    handles.checkSaveFile,...
    handles.animFileType,...
    handles.checkShowLegend,...
    handles.editFPS);
handles.fileName=v1;
handles.filePath=v2;
handles.editNumFrames=v3;
handles.checkSaveFile=v4;
handles.animFileType=v5;
handles.checkShowLegend=v6;
handles.editFPS=v7;
guidata(handles.ConvolveGUI_fig, handles);


% --- Executes on button press in pushAnimate.
function pushAnimate_Callback(hObject, eventdata, handles)
% hObject    handle to pushAnimate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
tmin=str2num(get(handles.TminText,'String'));
tmax=str2num(get(handles.TmaxText,'String'));
dt=(tmax-tmin)/(handles.editNumFrames-1);
t=tmin:dt:tmax;
for i=1:length(t),
    if ((i==1) | (i==length(t))),
        handles.showLegend=1;
    else
        handles.showLegend=handles.checkShowLegend;
    end
    set(handles.TimeSlider,'Value',t(i));
    set(handles.TimeEditText,'String',num2str(t(i)));
    FuncDisplay(handles);
    if (handles.checkSaveFile==1),
        myMovie(i)=getframe(handles.ConvolveGUI_fig);
    end
    pause(1/handles.editFPS);    %Put pause in to allow execution to be interrupted by ctrl-C.
end

if (handles.checkSaveFile==1),
    h=waitbar(0,'Writing file - this can take a while.  Please wait.');
    myFname=[handles.filePath '\' handles.fileName];
    if exist(myFname,'file'),
        delete(myFname);
    end
    switch (handles.animFileType),
        case {1}
            save(myFname,'myMovie');
        case {2}
            movie2avi(myMovie,myFname,...
                'compression','Cinepak',...
                'quality',90,...
                'fps',handles.editFPS);
        case {3}
            movie2avi(myMovie,myFname,...
                'compression','None',...
                'fps',handles.editFPS);
        otherwise
            save(myFname,'myMovie');
    end
    waitbar(1,h,'done');
    delete(h);
end

function x=U(t)
x=(t>0)*1.0;





% --- Executes on button press in showHideToggle.
function showHideToggle_Callback(hObject, eventdata, handles)
% Either show or hide the result
if get(handles.showHideToggle,'Value'),
    set(handles.showHideToggle,'String','Show Result');
else
    set(handles.showHideToggle,'String','Hide Result');
end
FuncDisplay(handles)

