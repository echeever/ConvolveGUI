function varargout = ConvolveGUI(varargin)
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
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before ConvolveGUI_fig is made visible.
function ConvolveGUI_OpeningFcn(hObject, ~, handles, varargin)
if verLessThan('matlab','8.4.0')
    error(['This program needs a version of MATLAB ' ...
        '8.4.0 or greater.  Type "ver" at prompt to ' ...
        'find out your version']);
end

handles.output = hObject;
try
    x=load('ConvFuncs.mat');       % Load data from file
catch err
    error(['Could not find file "ConvFuncs.mat".  ',...
        'Try running ConvolveFuncs.m to create file.']);
end
cFunc  = x.cFunc;    % Get cFunc from file

handles.cord = handles.convolveAxes.ColorOrder;  % Get color order;
% f = cord(1,:), h=cord(2,:), prod=cord(3), conv=cord(4,:);

handles.cFunc = cFunc;
handles.fPopup.String={cFunc(:).n};  % Get all names of functions for h(t).
% This next line is somewhat obscure - it only includes functions
% without impulses in the list of available function for h(t).
handles.hPopup.String={cFunc(cellfun(@isempty,{cFunc(:).d})).n};
handles.hPopup.String={cFunc(:).n};  % Get all names of functions for h(t).
handles.fPopup.Value=1;
handles.hPopup.Value=2;

%These variables are passed back and forth to "ConvolveAnimParam"
%to control animation parameters (2 per line to save space)
handles.fileName='ConvolvAnim.mat';     handles.filePath=cd;
handles.editNumFrames=20;               handles.checkSaveFile=0;
handles.animFileType=1;                 handles.checkShowLegend=0;
handles.editFPS=5;                      handles.showLegend=1;
handles.videoQ = 75;

handles.tmin=0; handles.tmax=0;	handles.dt=0; 	handles.t=0;
handles.f=0; 	handles.h=0;    % functions	
handles.fd=0;   handles.hd=0;   % impulses in functions.
handles.y=0;                    % convolution values in array



axes(handles.hAxText);  axis off;   cla
handles.hDispText = text(0,0.5,'.','HorizontalAlignment','left',...
    'VerticalAlignment','middle','Interpreter','latex');

axes(handles.fAxText);  axis off;   cla
handles.fDispText = text(0,0.5,'.','HorizontalAlignment','left',...
    'VerticalAlignment','middle','Interpreter','latex');

handles.showHideToggle.Value=0;
handles.showHideToggle.String='Hide Result';

% Update handles structure
timeVal=0;
handles.TimeSlider.Value=timeVal;
handles.TimeEditText.String=num2str(timeVal);
guidata(hObject, handles);
FuncCalc(handles);
handles=guidata(hObject);
FuncDisplay(handles);


% --- Executes during object creation, after setting all properties.
function ConvolveGUI_fig_CreateFcn(~, ~, ~) %#ok<*DEFNU>

% --- Executes on button press in pushWebResource.
function pushWebResource_Callback(~, ~, ~)
web('http://lpsa.swarthmore.edu/Convolution/ConvolveGUI.html','-browser')

% --- Outputs from this function are returned to the command line.
function varargout = ConvolveGUI_OutputFcn(~, ~, handles)
varargout{1} = handles.output;

% --- helper for several GUI components
function checkPC(hObject)
if ispc && isequal(hObject.BackgroundColor,...
        get(0,'defaultUicontrolBackgroundColor'))
    hObject.BackgroundColor='white';
end

% --- Executes during object creation, after setting all properties.
function fPopup_CreateFcn(hObject, ~, ~)
checkPC(hObject);

function hPopup_CreateFcn(hObject, ~, ~)
checkPC(hObject);

function TminText_CreateFcn(hObject, ~, ~)
checkPC(hObject);

function TmaxText_CreateFcn(hObject, ~, ~)
checkPC(hObject);

function TimeEditText_CreateFcn(hObject, ~, ~)
checkPC(hObject);

function TimeSlider_CreateFcn(hObject, ~, ~)
hObject.BackgroundColor=[.9 .9 .9];

% --- Executes on button press in Close_button.
function Close_button_Callback(~, ~, handles)
fprintf('\nConvolution GUI closed.\n\n'); close(handles.ConvolveGUI_fig);

% --- Executes on selection change in hPopup.
function hPopup_Callback(~, ~, handles)
handles.TimeSlider.Value=0; handles.TimeEditText.String=num2str(0);
FuncCalc(handles);
handles=guidata(handles.ConvolveGUI_fig);
FuncDisplay(handles);

function TminText_Callback(~, ~, handles)
tmin=str2double(handles.TminText.String); handles.TimeSlider.Min=tmin;
FuncCalc(handles);
handles=guidata(handles.ConvolveGUI_fig);
FuncDisplay(handles);

function TmaxText_Callback(~, ~, handles)
tmax=str2double(handles.TmaxText.String); handles.TimeSlider.Max=tmax;
FuncCalc(handles);
handles=guidata(handles.ConvolveGUI_fig);
FuncDisplay(handles);

function TimeEditText_Callback(~, ~, handles)
timeVal=str2double(handles.TimeEditText.String);
handles.TimeSlider.Value=timeVal;
FuncDisplay(handles)

% --- Executes on slider movement.
function TimeSlider_Callback(~, ~, handles)
timeVal=handles.TimeSlider.Value;
handles.TimeEditText.String=num2str(timeVal);
FuncDisplay(handles)

% --- Executes on selection change in fPopup.
function fPopup_Callback(~, ~, handles)
handles.TimeSlider.Value=0;  handles.TimeEditText.String=num2str(0);
FuncCalc(handles);
handles=guidata(handles.ConvolveGUI_fig);
FuncDisplay(handles);


function FuncCalc(handles)
handles.tmin=str2double(handles.TminText.String);
handles.tmax=str2double(handles.TmaxText.String);
handles.dt=(handles.tmax-handles.tmin)/1000;
handles.t=handles.tmin:handles.dt:handles.tmax;
t=handles.t; %  This variable is used in eval (below)

fIndex=handles.fPopup.Value;
fFuncStr=char(handles.cFunc(fIndex).f);
handles.fDispText.String=['f(t)= ' handles.cFunc(fIndex).s];
handles.f=@(t) eval(fFuncStr);  % Uses the variable t
fd=handles.cFunc(fIndex).d;
handles.fd=fd;

hIndex=handles.hPopup.Value;
hFuncStr=char(handles.cFunc(hIndex).f);
handles.hDispText.String=['h(t)= ' handles.cFunc(hIndex).s];
handles.h=@(t) eval(hFuncStr);
hd=handles.cFunc(hIndex).d;
handles.hd=hd;

% Find the function f(t) for convolution.
fcnv = handles.f(t);           % Get continuous part
for i=1:size(fd,1)  % for each impulse
    [~,inx]=min(abs(fd(i,2)-t));  % Find index of point closest to impulse
    fcnv(inx) = fcnv(inx)+fd(i,1)/handles.dt;  % Add impulse, area=fd(i,1)
end
% Do the same for h(t)
hcnv = handles.h(t);           % Get continuous part
for i=1:size(hd,1)  % for each impulse
    [~,inx]=min(abs(hd(i,2)-t));  % Find index of point closest to impulse
    hcnv(inx) = hcnv(inx)+hd(i,1)/handles.dt;  % Add impulse, area=hd(i,1)
end

handles.y=conv(fcnv,hcnv)*handles.dt;
guidata(handles.ConvolveGUI_fig, handles);


function FuncDisplay(handles)
tmin=handles.tmin;
tmax=handles.tmax;
dt=handles.dt;
t=handles.t;
f=handles.f;        % Function f(t)
fd=handles.fd;      % Impulses in f(t), nx2 array, [size, time]
h=handles.h;        % Function h(t)
hd=handles.hd;       
cord=handles.cord;
%hIndex=handles.hPopup.Value;
%hFuncStr=char(handles.cFunc(hIndex).f);
y=handles.y;

%Display f(t) and h(t) on one set of axes.
axes(handles.funcAxes);
cla
plot([tmin tmax],[0 0],'Color',0.75*[1 1 1],'LineStyle',':');
hold on
plot(t,f(t),'-.','LineWidth',2,'Color',cord(1,:));      %Display f(t)
plot(t,h(t),':','LineWidth',2,'Color',cord(2,:))        %Display h(t)
if (handles.showLegend==1),
    legend('zero reference','f(t)','h(t)');
end
plotImp(fd,'-.',2,cord(1,:));
plotImp(hd,':',2,cord(2,:));
hold off
%Set axes so that y axes are slightly bigger than the functions.
ylims=handles.funcAxes.YLim;
ylower=ylims(1)-0.05*(ylims(2)-ylims(1));
yupper=ylims(2)+0.05*(ylims(2)-ylims(1));
handles.funcAxes.YLim=[ylower yupper];
handles.funcAxes.XLim=[tmin tmax];

xlabel('Time');
ylabel('Function');
title('f(t) and h(t) vs. time');

%Display convolution on one set of axes.
axes(handles.convolutionAxes);
plot([tmin tmax],[0 0],'Color',0.75*[1 1 1],'LineStyle',':');
tc=2*tmin+dt*(0:(length(y)-1));     %calculate time vector for convolved sequence.
hold on;

%Get current value of time (from slider) and plot it along with convolution.
timeVal=handles.TimeSlider.Value;
TimeIndex=find(timeVal>tc,1,'last');
plot(tc(TimeIndex),y(TimeIndex),'ko','MarkerFaceColor','k');

% if timeVal is in left half of plot, ...
if timeVal<((tmin+tmax)*3/4),
    loc='ne';  % ... put legends on upper right.
else
    loc='nw';  % ... else put on upper left.
end

if handles.showHideToggle.Value,
    %Plot part of convolved sequence.
    plot(tc(1:TimeIndex),y(1:TimeIndex),'Color',cord(5,:),'LineWidth',2);
else
    plot(tc,y,'Color',cord(5,:),'LineWidth',2); %Plot all of  sequence.
end
ymin=min(y); %Set y axes to be slightly bigger than the functions.
ymax=max(y);
ylower=ymin-0.05*(ymax-ymin);
yupper=ymax+0.05*(ymax-ymin);
handles.convolutionAxes.YLim=[ylower yupper];
handles.convolutionAxes.XLim=[tmin tmax];
xlabel('Time');
title('Convolution, f(t)*h*t)');

if (handles.showLegend==1),
    legend('zero ref','t','f(t)*g(t)','Location',loc);
end
hold off

%Display f(lamb) and h(t-lamb) on one set of axes.
lam=t;
flam = f(lam);
htlam = h(timeVal-lam);
fh=flam.*htlam;
axes(handles.convolveAxes);
cla
plot([tmin tmax],[0 0],'Color',0.75*[1 1 1],'LineStyle',':');
hold on
plot(lam,fh,'LineWidth',3,'Color',cord(3,:));
plot(lam,flam,'-.','LineWidth',2,'Color',cord(1,:));

plot(lam,htlam,':','LineWidth',2,'Color',cord(2,:));

timeVal=handles.TimeSlider.Value;
TimeIndex=find(timeVal>tc,1,'last');
plot(tc(TimeIndex),0,'ko','MarkerFaceColor','k');

if (handles.showLegend==1),
    legend('zero ref',...
        'f(\lambda)h(t-\lambda)','f(\lambda)','h(t-\lambda)','t',...
        'Location',loc);
end

% If there are impulses in f(t), plot them and plot impulses in product
if ~isempty(fd)
    plotImp(fd,'-.',2,cord(1,:));
    plotImp([fd(:,1).*h(timeVal-fd(:,2))  fd(:,2)],'-',3,cord(3,:));
end
if ~isempty(hd)
    plotImp([hd(:,1) timeVal-hd(:,2)],':',2,cord(2,:));
    plotImp([hd(:,1).*f(timeVal-hd(:,2)) timeVal-hd(:,2)],'-',3,cord(3,:));
end


%Set axes so that y axes are slightly bigger than the functions.
ymin=min([flam htlam fh min(fd:1) min(hd:1)]);
ymax=max([flam htlam fh max(fd:1) max(hd:1)]);
ylower=ymin-0.05*(ymax-ymin);
yupper=ymax+0.05*(ymax-ymin);
axis([tmin tmax ylower yupper]);
xlabel('\lambda');
title(sprintf...
    ('f(\\lambda), h(t-\\lambda) vs. \\lambda and product, t=%3.2g',timeVal));
hold off

if ~isempty(fd) && ~isempty(hd),  % If impulses in both f and h, fail
    s = {'You are trying to convolve two functions with impulses.'...
         'This software cannot do that.' ' '...
         'Note: there is no fundamental physical or mathematical'...
         'difficulty involved in the convoloution of two functions'...
         'with impulses, but this sofware is not able to perform'...
         'the calculation, so the result is not shown.' ' '...
         'Hit "OK" in warning dialog box to continue.'};
    warndlg(s,'Warning','modal');
    cla(handles.convolutionAxes);
    cla(handles.convolveAxes);
end


% --- Executes on button press in AnimParamButton.
function AnimParamButton_Callback(~, ~, handles)
[v1, v2, v3, v4, v5, v6, v7, v8]=ConvolveAnimParam(...
    handles.fileName,...
    handles.filePath,...
    handles.editNumFrames,...
    handles.checkSaveFile,...
    handles.animFileType,...
    handles.checkShowLegend,...
    handles.editFPS,...
    handles.videoQ);
handles.fileName=v1;
handles.filePath=v2;
handles.editNumFrames=v3;
handles.checkSaveFile=v4;
handles.animFileType=v5;
handles.checkShowLegend=v6;
handles.editFPS=v7;
handles.videoQ=v8;
guidata(handles.ConvolveGUI_fig, handles);


% --- Executes on button press in pushAnimate.
function pushAnimate_Callback(~, ~, handles)
tmin=str2double(handles.TminText.String);
tmax=str2double(handles.TmaxText.String);
dt=(tmax-tmin)/(handles.editNumFrames-1);
t=tmin:dt:tmax;
% myMovie=ones(1,length(t));
numFrms = length(t);
myMovie(numFrms) = struct('cdata',[],'colormap',[]);
for i=1:length(t),
    if ((i==1) || (i==length(t))),
        handles.showLegend=1;
    else
        handles.showLegend=handles.checkShowLegend;
    end
    handles.TimeSlider.Value=t(i);
    handles.TimeEditText.String=num2str(t(i));
    FuncDisplay(handles);
    if (handles.checkSaveFile==1),
        myMovie(i)=getframe(handles.ConvolveGUI_fig);
    end
    pause(1/handles.editFPS);    % Pause allows termination with ctrl-C.
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
        case {2, 3}
            if strcmp(myFname(end-3:end),'.avi'),
                wObj = VideoWriter(myFname);            % .avi by default
            else
                 wObj = VideoWriter(myFname,'MPEG-4');  % change to .mp4
            end
            wObj.FrameRate = handles.editFPS;
            wObj.Quality = handles.videoQ;

            open(wObj);
            for frmNum=1:numFrms,
                waitbar(numFrms/frmNum,h,'writing');
                writeVideo(wObj,myMovie(frmNum));
            end
            close(wObj);
        otherwise
            save(myFname,'myMovie');
    end
    waitbar(1,h,'done');
    delete(h);
end

function x=U(t)
x=(t>=0)*1.0;


% --- Executes on button press in showHideToggle.
function showHideToggle_Callback(~, ~, handles)
% Either show or hide the result
if handles.showHideToggle.Value,
    handles.showHideToggle.String='Show Result';
else
    handles.showHideToggle.String='Hide Result';
end
FuncDisplay(handles)

function plotImp(d,ls,lw,c)
for i=1:size(d,1),  %Display impulses(t)
    plot([d(i,2) d(i,2)],[0 d(i,1)],ls,'LineWidth',lw,'Color',c); 
    if d(i,1)<0
        m='v';
    else
        m='^';
    end
    s=plot(d(i,2), d(i,1), m, 'Color',c, 'MarkerFaceColor', c);
    if lw>2, s.MarkerSize=s.MarkerSize*1.5; end;
end