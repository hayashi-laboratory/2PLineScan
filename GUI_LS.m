function varargout = GUI_LS(varargin)
% GUI_LS MATLAB code for GUI_LS.fig
%      GUI_LS, by itself, creates a new GUI_LS or raises the existing
%      singleton*.
%
%      H = GUI_LS returns the handle to a new GUI_LS or the handle to
%      the existing singleton*.
%
%      GUI_LS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_LS.M with the given input arguments.
%
%      GUI_LS('Property','Value',...) creates a new GUI_LS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_LS_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_LS_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_LS

% Last Modified by GUIDE v2.5 16-Jun-2018 09:30:38

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_LS_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_LS_OutputFcn, ...
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


% --- Executes just before GUI_LS is made visible.
function GUI_LS_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_LS (see VARARGIN)

% Choose default command line output for GUI_LS
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI_LS wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_LS_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton1

global axesinfo1;
global axesinfo2;
axesinfo1.axes = handles.axes1;
axesinfo2.axes = handles.axes2;

zoom on;
%fprintf('zoom on!\n');

%コールバックの設定
h = zoom;
set(h,'ActionPostCallback',@zoomcallback);
set(h,'Enable','on');


%ズーム操作のコールバック
function zoomcallback(obj,event_obj)
%zoom reset;
global axesinfo1;
global axesinfo2;
global viewinfo1;
global viewinfo2;

if obj.CurrentAxes == axesinfo1.axes
	viewinfo1 = localCreateViewInfo(event_obj.Axes);
else
	viewinfo2 = localCreateViewInfo(event_obj.Axes);
end



% --- Executes on button press in radiobutton2.
function radiobutton2_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton2

zoom off;

% --- Executes on button press in radiobutton3.
function radiobutton3_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton3

zoom off;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global data
global mouse_status

[FileName,PathName,FilterIndex] = uigetfile('*.*','Select image file');

FileName = [ PathName '/' FileName ];

if FilterIndex ~= 0
	[filepath,name,ext] = fileparts(FileName);

	data.dir = filepath;
	data.file_name = FileName;
	data.file_base = name;
	data.img = imread( data.file_name );

	data.line = [];

	mouse_status = 0;

	data.file_binary_org = [ data.dir '/binarize_' data.file_base '.png'];
	data.file_binary_edt = [ data.dir '/binarize_edited_' data.file_base '.png'];
	data.file_csv = [ data.dir '/' data.file_base '.csv'];
	data.file_mat = [ data.dir '/' data.file_base '.mat'];

	if exist( data.file_mat ) ~= 0
		load( data.file_mat );
	end

	data.file_plot = [ data.dir '/' data.file_base '_plotLine.png'];

	data.BW = imread( data.file_binary_org );


	data.BW2 = data.BW;
	getBW2

	data.slope.B = [];

	show_img(handles);
end

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global data

data.line(end) = [];
getBW2

show_img(handles);

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global data

lmin = str2num( get(handles.edit2,'String') );

[ data.slope.B data.slope.Xrange data.slope.Yrange ] = slope_LS( data.BW2, lmin );

show_img(handles);



% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


global data

imwrite( data.BW2, data.file_binary_edt );
save( data.file_mat, 'data' );

fp = fopen( data.file_csv,'wt');
fprintf( fp, 'number, slope, length, xstart, ystart, xend, yend\n' );
si = size( data.BW );
for is = 1:size( data.slope.B, 1 )
	xs = data.slope.Xrange(is,1);
	xe = data.slope.Xrange(is,2);
	ys = data.slope.Yrange(is,1);
	ye = data.slope.Yrange(is,2);
	dx = xe - xs;
	dy = ye - ys;
	l = sqrt( dx*dx + dy*dy );

	fprintf( fp,'%d,%f,%f,%f,%f,%f,%f\n',is, -data.slope.B(is,2), l, xs, si(1)-ys, xe, si(1)-ye );
end
fclose(fp);

h = figure('visible','off');
imshow( data.img );
hold on
for is = 1:size( data.slope.B, 1 )
	text( data.slope.Xrange(is,1)-10, data.slope.Yrange(is,1), num2str(is), 'Color','red' );
	plot( data.slope.Xrange(is,:), data.slope.Yrange(is,:), '-r' );
end
saveas(gcf,data.file_plot)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% --- Executes on mouse press over figure background, over a disabled or
% --- inactive control, or over an axes background.
function figure1_WindowButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global mouse_status
global data




%右画面
axes(handles.axes2);
Cp = get(gca,'CurrentPoint'); % 座標軸上のマウスの位置を取得
XX = Cp(1,1); YY = Cp(1,2);

%fprintf( flog, 'XX=%f YY=%f length( data.obj(nobj).info ) = %d frame_info=%d\n', XX,YY, length( data.obj(nobj).info ), frame_info );

%切り抜き範囲の指定
viewinfo = localCreateViewInfo(handles.axes2);
if XX >= viewinfo.XLim(1)-20 && XX <= viewinfo.XLim(2)+20 && YY >= viewinfo.YLim(1)-20 && YY <= viewinfo.YLim(2)+20

	if mouse_status  == 0
		data.line(end+1).xs = XX;
		data.line(end).ys = YY;
		mouse_status = 1;

	elseif mouse_status  == 1
		data.line(end).xe = XX;
		data.line(end).ye = YY;
		data.line(end).w  = str2num( get(handles.edit1,'String') );
		data.line(end).white = get(handles.radiobutton2,'Value');
		mouse_status = 0;

		getBW2
		show_img(handles);
	end
end


function getBW2

global data;
data.BW2 = data.BW;

for ii=1:length( data.line )
	xs = data.line(ii).xs;	xe = data.line(ii).xe;
	ys = data.line(ii).ys;	ye = data.line(ii).ye;

	dy = ye-ys;
	dx = xe-xs;

	dd = sqrt( dx*dx + dy*dy );

	if dd == 0; continue; end

	dyn = dy / dd;
	dxn = dx / dd;

	lum = data.line(ii).white * 255;

	xx = []; yy=[];
	xx(1,:) = [ xs xe ];
	yy(1,:) = [ ys ye ];
	for dw = 0.5:0.5:(data.line(ii).w-1)/2
		xx(end+1,:) = [ xs-dyn*dw xe-dyn*dw ];
		yy(end+1,:) = [ ys+dxn*dw ye+dxn*dw ];

		xx(end+1,:) = [ xs+dyn*dw xe+dyn*dw ];
		yy(end+1,:) = [ ys-dxn*dw ye-dxn*dw ];
	end

	for jj=1:size(xx,1)
		dx = xx(jj,2) - xx(jj,1);
		dy = yy(jj,2) - yy(jj,1);
		nl = sqrt( dx*dx + dy*dy );
		[cx,cy,c] = improfile(data.BW , xx(jj,:) , yy(jj,:), 2*nl  );
		for kk=1:length(cx)
			py = round(cy(kk));
			px = round(cx(kk));
			if py > 0 && py <= size( data.BW,1) && px > 0 && px <= size( data.BW,2)
				data.BW2( py, px ) = lum;
			end
		end
	end
end



% --- Executes on mouse press over figure background, over a disabled or
% --- inactive control, or over an axes background.
function figure1_WindowButtonUpFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function show_img(handles)

global data
global axesinfo1;
global axesinfo2;
global viewinfo1;
global viewinfo2;



axes(handles.axes1)
cla
imshow( data.img );
hold on
for is = 1:size( data.slope.B, 1 )
	text( data.slope.Xrange(is,1)-10, data.slope.Yrange(is,1), num2str(is), 'Color','red' );
	plot( data.slope.Xrange(is,:), data.slope.Yrange(is,:), '-r' );
end

if exist( 'viewinfo1' ) ~= 0
	localApplyViewInfo( handles.axes1, viewinfo1);
end


axes(handles.axes2)
cla

imshow( data.BW2 );
hold on
for is = 1:size( data.slope.B, 1 )
	text( data.slope.Xrange(is,1)-10, data.slope.Yrange(is,1), num2str(is), 'Color','red' );
	plot( data.slope.Xrange(is,:), data.slope.Yrange(is,:), '-r' );
end

if exist( 'viewinfo2' ) ~= 0
	localApplyViewInfo( handles.axes2, viewinfo2);
end



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
