function varargout = tuxiang(varargin)
% TUXIANG MATLAB code for tuxiang.fig
%      TUXIANG, by itself, creates a new TUXIANG or raises the existing
%      singleton*.
%
%      H = TUXIANG returns the handle to a new TUXIANG or the handle to
%      the existing singleton*.
%
%      TUXIANG('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TUXIANG.M with the given input arguments.
%
%      TUXIANG('Property','Value',...) creates a new TUXIANG or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before tuxiang_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to tuxiang_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help tuxiang

% Last Modified by GUIDE v2.5 18-Apr-2023 11:02:06

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @tuxiang_OpeningFcn, ...
                   'gui_OutputFcn',  @tuxiang_OutputFcn, ...
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


% --- Executes just before tuxiang is made visible.
function tuxiang_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to tuxiang (see VARARGIN)

% Choose default command line output for tuxiang
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes tuxiang wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = tuxiang_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in opencamera.
function opencamera_Callback(hObject, eventdata, handles)
% hObject    handle to opencamera (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global vid 
vid = videoinput('winvideo', 1,'YUY2_640x480'); 
set(vid,'ReturnedColorSpace','rgb'); 
subplot(331); 
vidRes = get(vid, 'VideoResolution'); 
nBands = get(vid, 'NumberOfBands'); 
hImage = image( zeros(vidRes(2), vidRes(1), nBands) ); 
preview(vid, hImage);

% --- Executes on button press in capture.
function capture_Callback(hObject, eventdata, handles)
% hObject    handle to capture (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global vid 
global Catch 
subplot(332); 
Catch = getsnapshot(vid); 
imshow(Catch); 
title('原始图');


% --- Executes on button press in openimage.
function openimage_Callback(hObject, eventdata, handles)
% hObject    handle to openimage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Catch 
[filename,pathname]=uigetfile({'*.*';'*.bmp';'*.jpg';'*.tif'},'选择图像'); 
 if isequal([filename pathname],[0,0]) 
 return 
 else 
 %file=fullfile(pathname,filename); 
 file=[pathname,filename]; 
 Catch=imread(file); 
 subplot(332); 
 imshow(Catch); 
 title('原始图'); 
end 

% --- Executes on button press in grey.
function grey_Callback(hObject, eventdata, handles)
% hObject    handle to grey (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Catch 
global Gray 
subplot(334); 
Gray=rgb2gray(Catch); 
imshow(Gray); 
title('灰化图');


% --- Executes on button press in filter.
function filter_Callback(hObject, eventdata, handles)
% hObject    handle to filter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Gray 
global Filtering 
subplot(335); 
Filtering=medfilt2(Gray,[10 10]); 
imshow(Filtering); 
title('过滤图'); 


% --- Executes on button press in binary.
function binary_Callback(hObject, eventdata, handles)
% hObject    handle to binary (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global J; 
global Filtering 
global Binaryzation 
subplot(335); 
Binaryzation = Filtering; 
J= Binaryzation<100; 
Binaryzation(J)=0; 
J= Binaryzation>=100; 
Binaryzation(J)=255; 
imshow(Binaryzation); 
title('二值化图');


% --- Executes on button press in fill.
function fill_Callback(hObject, eventdata, handles)
% hObject    handle to fill (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global J 
global BinaryzationFILL 
global Binaryzation 
subplot(335); 
BinaryzationFS=Binaryzation; 
J= Binaryzation==0; 
BinaryzationFS(J)=255; 
J=find(Binaryzation==255); 
BinaryzationFS(J)=0; 
BinaryzationFILL = imfill(BinaryzationFS,'holes'); 
imshow(BinaryzationFILL); 
title('填充图'); 


% --- Executes on button press in calculate.
function blob_Callback(hObject, eventdata, handles)
% hObject    handle to calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global BinaryzationFILL 
global Final 
global FinalResult 
subplot(335); 
global J 
BinaryzationFSH = BinaryzationFILL; 
J= BinaryzationFILL==0; 
BinaryzationFSH(J)=255; 
J=find(BinaryzationFILL==255); 
BinaryzationFSH(J)=0; 
ZZL=BinaryzationFSH; 
[B,L] = bwboundaries(ZZL,4); 
%figure; 
Final=label2rgb(L, @jet, [.5 .5 .5]); 
imshow(Final) 
hold on 
for k = 1:length(B) 
boundary = B{k}; 
plot(boundary(:,2),boundary(:,1),'w','LineWidth',2)
title('最终图'); 
end 
% 找到每个连通域的质心 
stats = regionprops(L,'Area','Centroid'); 
% 循环历遍每个连通域的边界 
area = zeros(length(B),1); 
FinalResult=''; 
for k = 1:length(B) 
%kk=int2str(k); 
% 获取一条边界上的所有点 
boundary = B{k}; 
% 获取边界所围面积 
%area(k,1) = stats(k).Area; 
TheResult=sprintf('\n 第 %d 个 物 体 面 积 ： %d ， 质 心 为 %.3f, %.3f \r\n',k,stats(k).Area,stats(k).Centroid(1,1),stats(k).Centroid(1,2)); 
FinalResult=strcat(FinalResult,TheResult); 
end 
set(handles.edit4,'Visible','on');%edit4 即为文本框的 Tag 值 
%set(handles.popupmenu3,'Visible','on'); 
set(handles.edit4, 'String', FinalResult); 

% --- Executes on button press in act.
function act_Callback(hObject, eventdata, handles)
% hObject    handle to act (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global serialport 
global s 
s=serial('COM1'); 
s.baudrate=9600; 
s.parity='none'; 
s.databits=8; 
s.stopbits =1; 
fopen(s); 
fprintf(s,97); 
fclose(s); 
delete(s); 
clear s;


% --- Executes on button press in exit.
function exit_Callback(hObject, eventdata, handles)
% hObject    handle to exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
closepreview; 
close all;



% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function saveimage_Callback(hObject, eventdata, handles)
% hObject    handle to saveimage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function exportdata_Callback(hObject, eventdata, handles)
% hObject    handle to exportdata (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Catch 
global Gray 
global Binaryzation 
global Final 
global FinalResult 
[filename,pathname fileindex]=uiputfile({'*.txt';'*.doc';'*.xls'},'保存数据'); 
 if isequal([filename pathname fileindex],[0,0])
 return 
 else 
 file=strcat(pathname,filename); 
 switch fileindex 
 case 1 
 fid=fopen(file,'w'); 
 fprintf(fid,'%3.100000000s\r\n',FinalResult); 
 fclose(fid); 
 case 2 
 fid=fopen(file,'w'); 
 fprintf(fid,'%3.100000000s\r\n',FinalResult); 
 fclose(fid); 
 case 3 
 fid=fopen(file,'w'); 
 fprintf(fid,'%3.100000000s\r\n',FinalResult); 
 fclose(fid); 
 end 
 end

% --------------------------------------------------------------------
function original_Callback(hObject, eventdata, handles)
% hObject    handle to original (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Catch 
global Gray 
global Binaryzation 
global Final 
global FinalResult 
[filename,pathname fileindex]=uiputfile({'*.jpg';'*.bmp';'*.png'},'保存图像'); 
 if isequal([filename pathname fileindex],[0,0])
 return 
 else 
 file=strcat(pathname,filename); 
 switch fileindex 
 case 1 
 imwrite(Catch,file); 
 case 2 
 imwrite(Catch,file); 
 case 3 
 imwrite(Catch,file); 
 end 
 end 



% --------------------------------------------------------------------
function gray_Callback(hObject, eventdata, handles)
% hObject    handle to grey (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Catch 
global Gray 
global Binaryzation 
global Final 
global FinalResult 
[filename,pathname fileindex]=uiputfile({'*.jpg';'*.bmp';'*.png'},'保存图像'); 
 if isequal([filename pathname fileindex],[0,0])
 return 
 else 
 file=strcat(pathname,filename); 
 switch fileindex 
 case 1 
 imwrite(Gray,file); 
 case 2 
 imwrite(Gray,file); 
 case 3 
 imwrite(Gray,file); 
 end 
 end 

% --------------------------------------------------------------------
function binaryzation_Callback(hObject, eventdata, handles)
% hObject    handle to binaryzation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Catch 
global Gray 
global Binaryzation 
global Final 
global FinalResult 
[filename,pathname fileindex]=uiputfile({'*.jpg';'*.bmp';'*.png'},'保存图像'); 
 if isequal([filename pathname fileindex],[0,0])
 return 
 else 
 file=strcat(pathname,filename); 
 switch fileindex 
 case 1 
 imwrite(Binaryzation,file); 
 case 2 
 imwrite(Binaryzation,file); 
 case 3 
 imwrite(Binaryzation,file); 
 end 
 end

% --------------------------------------------------------------------
function final_Callback(hObject, eventdata, handles)
% hObject    handle to final (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Catch 
global Gray 
global Binaryzation 
global Final 
global FinalResult 
[filename,pathname fileindex]=uiputfile({'*.jpg';'*.bmp';'*.png'},'保存图像'); 
 if isequal([filename pathname fileindex],[0,0])
 return 
 else 
 file=strcat(pathname,filename); 
 switch fileindex 
 case 1 
 imwrite(Final,file); 
 case 2 
 imwrite(Final,file); 
 case 3 
 imwrite(Final,file); 
 end 
 end 

% --------------------------------------------------------------------
function histogram_Callback(hObject, eventdata, handles)
% hObject    handle to histogram (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Gray 
global Binaryzation 
global Final 
global FinalResult 
[filename,pathname fileindex]=uiputfile({'*.jpg';'*.bmp';'*.png'},'保存图像'); 
 if isequal([filename pathname fileindex],[0,0])
 return 
 else 
 file=strcat(pathname,filename); 
 switch fileindex 
 case 1 
 f=figure('visible','off'); 
 imhist(Gray); 
 saveas(f,file); 
 case 2 
 f=figure('visible','off'); 
 imhist(Gray); 
 print(f,'-dbmp',file); 
 case 3 
 f=figure('visible','off'); 
 imhist(Gray); 
 print(f,'-dpng',file); 
 default 
 messagebox('出错','warn'); 
 end 
 end

% --------------------------------------------------------------------
function full_Callback(hObject, eventdata, handles)
% hObject    handle to full (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Catch 
global Gray 
global Binaryzation 
global Final 
global FinalResult 
global BinaryzationFILL 
[filename,pathname fileindex]=uiputfile({'*.jpg';'*.bmp';'*.png'},'保存图像'); 
 if isequal([filename pathname fileindex],[0,0])
 return 
 else 
 file=strcat(pathname,filename); 
 switch fileindex 
 case 1 
 imwrite(BinaryzationFILL,file); 
 case 2 
 imwrite(BinaryzationFILL,file); 
 case 3 
 imwrite(BinaryzationFILL,file); 
 end 
 end 

% --------------------------------------------------------------------
function fliter_Callback(hObject, eventdata, handles)
% hObject    handle to fliter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Catch 
global Gray 
global Binaryzation 
global Final 
global FinalResult 
global BinaryzationFILL 
global Filtering 
[filename,pathname fileindex]=uiputfile({'*.jpg';'*.bmp';'*.png'},'保存图像'); 
 if isequal([filename pathname fileindex],[0,0])
 return 
 else 
 file=strcat(pathname,filename); 
 switch fileindex 
 case 1 
 imwrite(Filtering,file); 
 case 2 
 imwrite(Filtering,file); 
 case 3 
 imwrite(Filtering,file); 
 end 
 end 


% --- Executes on button press in blob.
function pushbutton11_Callback(hObject, eventdata, handles)
% hObject    handle to blob (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
