function varargout = index(varargin)
% INDEX MATLAB code for index.fig
%      INDEX, by itself, creates a new INDEX or raises the existing
%      singleton*.
%
%      H = INDEX returns the handle to a new INDEX or the handle to
%      the existing singleton*.
%
%      INDEX('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in INDEX.M with the given input arguments.
%
%      INDEX('Property','Value',...) creates a new INDEX or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before index_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to index_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help index

% Last Modified by GUIDE v2.5 25-Mar-2020 21:56:24

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @index_OpeningFcn, ...
                   'gui_OutputFcn',  @index_OutputFcn, ...
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


% --- Executes just before index is made visible.
function index_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to index (see VARARGIN)
% Create the data to plot.

% Choose default command line output for index
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes index wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = index_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Display surf plot of the currently selected data.
surf(handles.current_data);

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
  % Display mesh plot of the currently selected data.
  mesh(handles.current_data);

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 % Display contour plot of the currently selected data.
  contour(handles.current_data);

% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Determine the selected data set.
str = get(hObject, 'String');
val = get(hObject,'Value');
% Set current data to the selected data set.
switch str{val};
case 'peaks' % User selects peaks.
   handles.current_data = handles.peaks;
case 'membrane' % User selects membrane.
   handles.current_data = handles.membrane;
case 'sinc' % User selects sinc.
   handles.current_data = handles.sinc;
end
% Save the handles structure.
guidata(hObject,handles)
% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
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


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%clear all;

global mounth
global promnois
rb3 = get(handles.radiobutton3,'Value');
if rb3==1 
    latitude = str2double(char(get(handles.edit1,'String')));
end
rb4 = get(handles.radiobutton4,'Value');
if rb4==1 
    lat = str2double(char(get(handles.edit1,'String')));
    latitude=0-lat;
end
rb5 = get(handles.radiobutton5,'Value');
if rb5==1 
longitude = str2double(char(get(handles.edit14,'String')));
end
rb6 = get(handles.radiobutton6,'Value');
if rb6==1 
    long = str2double(char(get(handles.edit14,'String')));
    longitude=180+long;
end
hour=str2double(char(get(handles.edit3,'String')));                  %Время, часы
day = str2double(char(get(handles.edit5,'String')));              %День
year = str2double(char(get(handles.edit6,'String')));           %Год

%Параметры линии
Pt=str2double(char(get(handles.edit10,'String')));   %в кВт
Pt=10*log10(Pt);
G1=str2double(char(get(handles.edit11,'String')));   %в разах коэффициент передающей антенны
Gt=10*log10(G1);
D2=str2double(char(get(handles.edit12,'String')));   %в разах коэффициент приемной антенны
Dt=10*log10(D2);
B=str2double(char(get(handles.edit8,'String')));  %Ширина канала в Гц
%bet=5*10^(-3);
betGr=5*10^(-2);%[10^(-3) 2.5*10^(-3) 5*10^(-3) 7.5*10^(-3) 10^(-2) 1.5*10^(-2) 2.5*10^(-2)];    %интенсивоность неоднородностей
bet=0.001:0.0005:0.05;
d=str2double(char(get(handles.edit9,'String'))); %Дальность связи в км
sigmz=14;   %среднеквадратическое отклонение для расчета надежности связи


time = datenum([year mounth day hour 0 0]);

xj=[107.3 106.4 103.5 101 100 85.4 77.6 69.4 61.3 53.8 47.4 43.0 41.2 42.4 46.5 52.6 60.0 68.0 76.2 84.2 91.6 98.0 103.0 106.3 107.6]; %надо научиться расчитывать зенитный угол солнца
xjn=xj(13);
xj=xj(hour+1);

IRI=iri2016(time,latitude,longitude,300,false);

%Параметры ионосферы
f0F2=4.928;%IRI(:,28);     %Критическая частота слоя F2
f0E=IRI(:,30);      %Критическая частота слоя Е
M300F2=IRI(:,23);   %M-параметр при дальности связи 3000 км
R12=IRI(:,38);       %Число солнечных пятен
%hm=IRI(:,15)*10^3;	%Высота максимума ионизации (м)

%Подготовка к расчетам

r=d*10^3;
hm=302400;
fcrF2=f0F2*10^6;

[f0,zdopGr,u0]=FindZdop(fcrF2,r,hm,betGr);
[f0,zdop]=FindZdop(fcrF2,r,hm,bet);
[tmp,f08I]=min(abs(f0-f0(length(f0))*0.8));
[tmp1,f085I]=min(abs(f0-f0(length(f0))*0.85));
[tmp2,f09I]=min(abs(f0-f0(length(f0))*0.9));
clear tmp tmp1 tmp2;

f0=f0*10^(-6);
[Ec,Lb]=FindEc(R12,M300F2,f0,f0F2,f0E,xj,xjn,d);     %Построение напряженности сигнала на входе приемника
[Ep,FamT,Fatm,Fprom,Fsp]=FindEp(f0,f0F2,hour,promnois,B);               %Построение напряженности помехи

Ec=Ec+Gt+Pt;
Pr=Ec+Dt-20*log10(f0)-107.2;
SN=Pr-FamT-10*log10(B)+204;
E=Ec-Ep;
V=abs(20*log10(Ec/Ep));
for j=1:length(betGr)
    for i=1:length(SN)
        DsvGr(i,j)=0.5*erf(sqrt(2)*((SN(i)-zdopGr(i,j))/sigmz)*0.5)+0.5; 
        DsvGru(i,j)=0.5*erf(sqrt(2)*((SN(i)-u0(i,j))/sigmz)*0.5)+0.5;
        %для графика
    end
end
for j=1:length(bet)
    for i=1:length(SN)
        Dsv(i,j)=0.5*erf(sqrt(2)*((SN(i)-zdop(i,j))/sigmz)*0.5)+0.5;    %в общем виде
    end
    Dsv08(j)=Dsv(f08I,j);
    Dsv085(j)=Dsv(f085I,j);
    Dsv09(j)=Dsv(f09I,j);
end


[zdopav,Izdopav]=min(abs(zdopGr-14));
[DsvGrmax,IGrmax]=max(DsvGr);
[DsvGrmin,IGrmin]=min(abs(DsvGr-0.8));
[DsvGrminu,IGrminu]=min(abs(DsvGru-0.8));
DsvGrmin=DsvGrmin+0.8;
Dsvmax=max(Dsv);


for i=1:length(IGrmax)
    textDsv(i,:)=strcat('{\itf}_{орч_',num2str(i),'}');
end



set(0,'DefaultAxesFontSize',12,'DefaultAxesFontName','Times New Roman');
set(0,'DefaultTextFontSize',12,'DefaultTextFontName','Times New Roman'); 

F2MUF=f0(length(f0));
a=1;    %начало по Х
b=F2MUF+0.5;    %конец по Х

c=0.6;    %начало по У
d=1;    %конец по У

figure('position', [100, 100, 1000, 450],'Units', 'normalized');        %Полотно рисунка с размерами в параметре позиций
semilogx(f0,DsvGr,'-','Color',[.1 .1 .1],'LineWidth',1);
line([a b], [0.8 0.8],'Color',[.1 .1 .1],'LineWidth',0.5, 'LineStyle','--');
line([F2MUF F2MUF], [c d],'Color',[.1 .1 .1],'LineWidth',0.1, 'LineStyle','-.');
line([f0(IGrmin(1)) f0(IGrmin(1))], [c DsvGrmin(1)],'Color',[.1 .1 .1],'LineWidth',0.1, 'LineStyle','-.');
line([a f0(IGrmax(1))], [DsvGrmax DsvGrmax],'Color',[.1 .1 .1],'LineWidth',0.1, 'LineStyle','-.');
text(F2MUF-0.1,0.82,'{\itf}_{м}','HorizontalAlignment','left', 'fontsize' ,14);
text(f0(IGrmin(1))+0.01,0.77,'{\itf}_{н}','HorizontalAlignment','left', 'fontsize' ,14);
grid on;
hold on;
semilogx(f0,DsvGru,'--','Color',[.1 .1 .1],'LineWidth',1);
%semilogx(f0,DsvGry,'--','Color',[.1 .1 .1],'LineWidth',1);
for i=1:length(IGrmax)
    line([f0(IGrmax(i)) f0(IGrmax(i))], [0.75 DsvGrmax(i)],'Color',[.1 .1 .1],'LineWidth',0.1, 'LineStyle','-.');   
    if (length(betGr)>1)
        text(f0(IGrmax(i))+0.04*f0(IGrmax(i)),DsvGrmax(i)-0.005,num2str(i),'HorizontalAlignment','right', 'fontsize' ,14);      %Подпись графиков
        text(f0(IGrmax(i))-0.005*f0(IGrmax(i)),0.77,textDsv(i,:),'HorizontalAlignment','right', 'fontsize' ,14);      %Подпись орч
    else text(f0(IGrmax(i))-0.005*f0(IGrmax(i)),0.77,'{\itf}_{орч}','HorizontalAlignment','right', 'fontsize' ,14);      %Подпись орч
    end
    
end
text(F2MUF-0.1,c+3,'{\itf}_{м}','HorizontalAlignment','right', 'fontsize' ,14);
axis([a b c d]);  
if (length(betGr)>1)
    legend('Location','northwest','1. \beta=10^{-3}','2. \beta=2.5\cdot10^{-3}','3. \beta=5\cdot10^{-3}','4. \beta=7.5\cdot10^{-3}','5. \beta=10^{-2}','6. \beta=1.5\cdot10^{-2}','7. \beta=2.5\cdot10^{-2}','8. \beta=5\cdot10^{-2}');
end
set(gca,'xtick',[1 2 3 4 5 6 7 8 9 10 11 12]); 
set(gca,'xticklabel',{'1' ; '2' ; '3' ; '4' ; '5' ; '6' ; '7' ; '8' ; '9' ; '10' ; '11' ; '12'});
xlabel('{\itf_0 ,} МГц','Position',[b+0.2 c -1],'FontWeight','bold','HorizontalAlignment','left', 'fontsize' ,14);                   %Подпись оси Х справа
ylabel('{\itD}_{св}','Position',[a d -1], 'Rotation', 0,'HorizontalAlignment','left','FontWeight','bold', 'fontsize' ,14);



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



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


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



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit8_Callback(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit8 as text
%        str2double(get(hObject,'String')) returns contents of edit8 as a double


% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit9_Callback(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit9 as text
%        str2double(get(hObject,'String')) returns contents of edit9 as a double


% --- Executes during object creation, after setting all properties.
function edit9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit10_Callback(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit10 as text
%        str2double(get(hObject,'String')) returns contents of edit10 as a double


% --- Executes during object creation, after setting all properties.
function edit10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit11_Callback(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit11 as text
%        str2double(get(hObject,'String')) returns contents of edit11 as a double


% --- Executes during object creation, after setting all properties.
function edit11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit12_Callback(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit12 as text
%        str2double(get(hObject,'String')) returns contents of edit12 as a double


% --- Executes during object creation, after setting all properties.
function edit12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
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
%Точка отражения
global mounth
global promnois
rb3 = get(handles.radiobutton3,'Value');
if rb3==1 
    latitude = str2double(char(get(handles.edit1,'String')));
end
rb4 = get(handles.radiobutton4,'Value');
if rb4==1 
    lat = str2double(char(get(handles.edit1,'String')));
    latitude=0-lat;
end
rb5 = get(handles.radiobutton5,'Value');
if rb5==1 
longitude = str2double(char(get(handles.edit14,'String')));
end
rb6 = get(handles.radiobutton6,'Value');
if rb6==1 
    long = str2double(char(get(handles.edit14,'String')));
    longitude=180+long;
end
hour=str2double(char(get(handles.edit3,'String')));                  %Время, часы
day = str2double(char(get(handles.edit5,'String')));              %День
year = str2double(char(get(handles.edit6,'String')));           %Год

%Параметры линии
Pt=str2double(char(get(handles.edit10,'String')));   %в кВт
Pt=10*log10(Pt);
G1=str2double(char(get(handles.edit11,'String')));   %в разах коэффициент передающей антенны
Gt=10*log10(G1);
D2=str2double(char(get(handles.edit12,'String')));   %в разах коэффициент приемной антенны
Dt=10*log10(D2);
B=str2double(char(get(handles.edit8,'String')));  %Ширина канала в Гц
%bet=5*10^(-3);
betGr=5*10^(-3);%[10^(-3) 2.5*10^(-3) 5*10^(-3) 7.5*10^(-3) 10^(-2) 1.5*10^(-2) 2.5*10^(-2)];    %интенсивоность неоднородностей
bet=0.001:0.0005:0.05;
d=str2double(char(get(handles.edit9,'String'))); %Дальность связи в км
sigmz=14;   %среднеквадратическое отклонение для расчета надежности связи


time = datenum([year mounth day hour 0 0]);

xj=[107.3 106.4 103.5 101 100 85.4 77.6 69.4 61.3 53.8 47.4 43.0 41.2 42.4 46.5 52.6 60.0 68.0 76.2 84.2 91.6 98.0 103.0 106.3 107.6]; %надо научиться расчитывать зенитный угол солнца
xjn=xj(13);
xj=xj(hour+1);

IRI=iri2016(time,latitude,longitude,300,false);

%Параметры ионосферы
f0F2=4;%IRI(:,28);     %Критическая частота слоя F2
f0E=IRI(:,30);      %Критическая частота слоя Е
M300F2=IRI(:,23);   %M-параметр при дальности связи 3000 км
R12=IRI(:,38);       %Число солнечных пятен
hm=IRI(:,15)*10^3;	%Высота максимума ионизации (м)

%Подготовка к расчетам

r=d*10^3;
hm=350000;
fcrF2=f0F2*10^6;

[f0,zdopGr]=FindZdop(fcrF2,r,hm,betGr);
[f0,zdop]=FindZdop(fcrF2,r,hm,bet);
[tmp,f08I]=min(abs(f0-f0(length(f0))*0.8));
[tmp1,f085I]=min(abs(f0-f0(length(f0))*0.85));
[tmp2,f09I]=min(abs(f0-f0(length(f0))*0.9));
clear tmp tmp1 tmp2;

f0=f0*10^(-6);
[Ec,Lb]=FindEc(R12,M300F2,f0,f0F2,f0E,xj,xjn,d);     %Построение напряженности сигнала на входе приемника
[Ep,FamT,Fatm,Fprom,Fsp]=FindEp(f0,f0F2,hour,promnois,B);               %Построение напряженности помехи

Ec=Ec+Gt+Pt;
Pr=Ec+Dt-20*log10(f0)-107.2;
SN=Pr-FamT-10*log10(B)+204;

for j=1:length(betGr)
    for i=1:length(SN)
        DsvGr(i,j)=0.5*erf(sqrt(2)*((SN(i)-zdopGr(i,j))/sigmz)*0.5)+0.5;    %для графика
    end
end
for j=1:length(bet)
    for i=1:length(SN)
        Dsv(i,j)=0.5*erf(sqrt(2)*((SN(i)-zdop(i,j))/sigmz)*0.5)+0.5;    %в общем виде
    end
    Dsv08(j)=Dsv(f08I,j);
    Dsv085(j)=Dsv(f085I,j);
    Dsv09(j)=Dsv(f09I,j);
end


[zdopav,Izdopav]=min(abs(zdopGr-14));
[DsvGrmax,IGrmax]=max(DsvGr);
[DsvGrmin,IGrmin]=min(abs(DsvGr-0.8));
DsvGrmin=DsvGrmin+0.8;
Dsvmax=max(Dsv);


for i=1:length(IGrmax)
    textDsv(i,:)=strcat('{\itf}_{орч_',num2str(i),'}');
end



set(0,'DefaultAxesFontSize',12,'DefaultAxesFontName','Times New Roman');
set(0,'DefaultTextFontSize',12,'DefaultTextFontName','Times New Roman'); 

F2MUF=f0(length(f0));
a=1;    %начало по Х
b=F2MUF+0.5;    %конец по Х

a=0.001;
b=0.05;
c=0.75;    %начало по У
d=1;    %конец по У

figure('position', [100, 100, 1000, 450],'Units', 'normalized');        %Полотно рисунка с размерами в параметре позиций
semilogx(bet,Dsvmax,'-','Color',[.1 .1 .1],'LineWidth',1);
text(b+0.05*b,Dsvmax(length(Dsvmax)),'{\itf}_{орч}','HorizontalAlignment','left', 'fontsize' ,14);
grid on;
hold on;
semilogx(bet,Dsv08,'--','Color',[.1 .1 .1],'LineWidth',1);
text(b+0.05*b,Dsv08(length(Dsv08))-0.005*Dsv08(length(Dsv08)),'0.8{\itf}_{м}','HorizontalAlignment','left', 'fontsize' ,14);
semilogx(bet,Dsv085,'-.','Color',[.1 .1 .1],'LineWidth',1);
text(b+0.05*b,Dsv085(length(Dsv085)),'0.85{\itf}_{м}','HorizontalAlignment','left', 'fontsize' ,14);
semilogx(bet,Dsv09,'-','Color',[.1 .1 .1],'LineWidth',1);
text(b+0.05*b,Dsv09(length(Dsv09))+0.005*Dsv09(length(Dsv09)),'0.9{\itf}_{м}','HorizontalAlignment','left', 'fontsize' ,14);
line([F2MUF F2MUF], [c d],'Color',[.1 .1 .1],'LineWidth',0.1, 'LineStyle','-.');
text(F2MUF-0.1,c+3,'{\itf}_{м}','HorizontalAlignment','right', 'fontsize' ,14);
axis([a b c d]);   
set(gca,'xtick',[0.001 0.002 0.003 0.004 0.005 0.006 0.007 0.008 0.009 0.01 0.02 0.03 0.04 0.05]); 
set(gca,'xticklabel',{'10^{-3}' ; '2' ; '3' ; '4' ; '5' ; '6' ; '7' ; '8' ; '9' ; '10^{-2}' ; '2' ; '3' ; '4' ; '5\cdot10^{-2}'});
xlabel('\beta','Position',[b+0.15*b c -1],'FontWeight','bold','HorizontalAlignment','left', 'fontsize' ,14);                   %Подпись оси Х справа
ylabel('{\itD}_{св}','Position',[a d -1], 'Rotation', 0,'HorizontalAlignment','left','FontWeight','bold', 'fontsize' ,14);


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global mounth
global promnois
rb3 = get(handles.radiobutton3,'Value');
if rb3==1 
    latitude = str2double(char(get(handles.edit1,'String')));
end
rb4 = get(handles.radiobutton4,'Value');
if rb4==1 
    lat = str2double(char(get(handles.edit1,'String')));
    latitude=0-lat;
end
rb5 = get(handles.radiobutton5,'Value');
if rb5==1 
longitude = str2double(char(get(handles.edit14,'String')));
end
rb6 = get(handles.radiobutton6,'Value');
if rb6==1 
    long = str2double(char(get(handles.edit14,'String')));
    longitude=180+long;
end
hour=str2double(char(get(handles.edit3,'String')));                  %Время, часы
day = str2double(char(get(handles.edit5,'String')));              %День
year = str2double(char(get(handles.edit6,'String')));           %Год

%Параметры линии
Pt=str2double(char(get(handles.edit10,'String')));   %в кВт
Pt=10*log10(Pt);
G1=str2double(char(get(handles.edit11,'String')));   %в разах коэффициент передающей антенны
Gt=10*log10(G1);
D2=str2double(char(get(handles.edit12,'String')));   %в разах коэффициент приемной антенны
Dt=10*log10(D2);
B=str2double(char(get(handles.edit8,'String')));  %Ширина канала в Гц
%bet=5*10^(-3);
betGr=5*10^(-3);%[10^(-3) 2.5*10^(-3) 5*10^(-3) 7.5*10^(-3) 10^(-2) 1.5*10^(-2) 2.5*10^(-2)];    %интенсивоность неоднородностей
bet=0.001:0.0005:0.05;
d=str2double(char(get(handles.edit9,'String')));; %Дальность связи в км
sigmz=14;   %среднеквадратическое отклонение для расчета надежности связи


time = datenum([year mounth day hour 0 0]);

xj=[107.3 106.4 103.5 101 100 85.4 77.6 69.4 61.3 53.8 47.4 43.0 41.2 42.4 46.5 52.6 60.0 68.0 76.2 84.2 91.6 98.0 103.0 106.3 107.6]; %надо научиться расчитывать зенитный угол солнца
xjn=xj(13);
xj=xj(hour+1);

IRI=iri2016(time,latitude,longitude,300,false);

%Параметры ионосферы
f0F2=4;%IRI(:,28);     %Критическая частота слоя F2
f0E=IRI(:,30);      %Критическая частота слоя Е
M300F2=IRI(:,23);   %M-параметр при дальности связи 3000 км
R12=IRI(:,38);       %Число солнечных пятен
hm=IRI(:,15)*10^3;	%Высота максимума ионизации (м)

%Подготовка к расчетам

r=d*10^3;
hm=350000;
fcrF2=f0F2*10^6;

[f0,zdopGr]=FindZdop(fcrF2,r,hm,betGr);
[f0,zdop]=FindZdop(fcrF2,r,hm,bet);
[tmp,f08I]=min(abs(f0-f0(length(f0))*0.8));
[tmp1,f085I]=min(abs(f0-f0(length(f0))*0.85));
[tmp2,f09I]=min(abs(f0-f0(length(f0))*0.9));
clear tmp tmp1 tmp2;

f0=f0*10^(-6);
[Ec,Lb]=FindEc(R12,M300F2,f0,f0F2,f0E,xj,xjn,d);     %Построение напряженности сигнала на входе приемника
[Ep,FamT,Fatm,Fprom,Fsp]=FindEp(f0,f0F2,hour,promnois,B);               %Построение напряженности помехи

Ec=Ec+Gt+Pt;
Pr=Ec+Dt-20*log10(f0)-107.2;
SN=Pr-FamT-10*log10(B)+204;

for j=1:length(betGr)
    for i=1:length(SN)
        DsvGr(i,j)=0.5*erf(sqrt(2)*((SN(i)-zdopGr(i,j))/sigmz)*0.5)+0.5;    %для графика
    end
end
for j=1:length(bet)
    for i=1:length(SN)
        Dsv(i,j)=0.5*erf(sqrt(2)*((SN(i)-zdop(i,j))/sigmz)*0.5)+0.5;    %в общем виде
    end
    Dsv08(j)=Dsv(f08I,j);
    Dsv085(j)=Dsv(f085I,j);
    Dsv09(j)=Dsv(f09I,j);
end


[zdopav,Izdopav]=min(abs(zdopGr-14));
[DsvGrmax,IGrmax]=max(DsvGr);
[DsvGrmin,IGrmin]=min(abs(DsvGr-0.8));
DsvGrmin=DsvGrmin+0.8;
Dsvmax=max(Dsv);


for i=1:length(IGrmax)
    textDsv(i,:)=strcat('{\itf}_{орч_',num2str(i),'}');
end



set(0,'DefaultAxesFontSize',12,'DefaultAxesFontName','Times New Roman');
set(0,'DefaultTextFontSize',12,'DefaultTextFontName','Times New Roman'); 

F2MUF=f0(length(f0));
a=0.1;    %начало по Х
b=1;    %конец по Х

MMF=0.01:0.01:0.9;
fm=F2MUF*MMF;

c=5;    %начало по У
d=45;    %конец по У


figure('position', [100, 100, 1000, 450],'Units', 'normalized');        %Полотно рисунка с размерами в параметре позиций
semilogx(fm,SN,'-','Color',[.1 .1 .1],'LineWidth',1);

text(b+0.2,SN(length(f0)),'$$\overline{z}$$','HorizontalAlignment','left','interpreter','latex', 'fontsize' ,14);
text(b+0.2,zdopGr(length(f0)),'{\itz}_{доп}','HorizontalAlignment','left', 'fontsize' ,14);
grid on;
hold on;
semilogx(fm,zdopGr,'-','Color',[.1 .1 .1],'LineWidth',1);
if (length(betGr)>1)
    text(f0(Izdopav(1))-0.03*f0(Izdopav(1)),13,num2str(1),'HorizontalAlignment','right', 'fontsize' ,14);      %Подпись графиков
    legend('Location','northwest','1. \beta=10^{-3}','2. \beta=2.5\cdot10^{-3}','3. \beta=5\cdot10^{-3}','4. \beta=7.5\cdot10^{-3}','5. \beta=10^{-2}','6. \beta=1.5\cdot10^{-2}','7. \beta=2.5\cdot10^{-2}','8. \beta=5\cdot10^{-2}');
end
for i=2:length(Izdopav)
    text(f0(Izdopav(i))-0.01*f0(Izdopav(i)),15,num2str(i),'HorizontalAlignment','right', 'fontsize' ,14);      %Подпись графиков
end
axis([a b c d]);   
%title('Рисунок 2');
set(gca,'xtick',[0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1]); 
set(gca,'xticklabel',{'0.1' ; '0.2' ; '0.3' ; '0.4' ; '0.5' ; '0.6' ; '0.7' ; '0.8' ; '0.9' ; '1'});
xlabel('{\itf_0 ,} МГц','Position',[b+0.2 c -1],'FontWeight','bold','HorizontalAlignment','left', 'fontsize' ,14);                   %Подпись оси Х справа
ylabel('z , z_{доп} , дБ','Position',[a d -1], 'Rotation', 0,'HorizontalAlignment','left','FontWeight','bold', 'fontsize' ,14);


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global mounth
global promnois
rb3 = get(handles.radiobutton3,'Value');
if rb3==1 
    latitude = str2double(char(get(handles.edit1,'String')));
end
rb4 = get(handles.radiobutton4,'Value');
if rb4==1 
    lat = str2double(char(get(handles.edit1,'String')));
    latitude=0-lat;
end
rb5 = get(handles.radiobutton5,'Value');
if rb5==1 
longitude = str2double(char(get(handles.edit14,'String')));
end
rb6 = get(handles.radiobutton6,'Value');
if rb6==1 
    long = str2double(char(get(handles.edit14,'String')));
    longitude=180+long;
end
hour=str2double(char(get(handles.edit3,'String')));                  %Время, часы
day = str2double(char(get(handles.edit5,'String')));              %День
year = str2double(char(get(handles.edit6,'String')));           %Год

%Параметры линии
Pt=str2double(char(get(handles.edit10,'String')));   %в кВт
Pt=10*log10(Pt);
G1=str2double(char(get(handles.edit11,'String')));   %в разах коэффициент передающей антенны
Gt=10*log10(G1);
D2=str2double(char(get(handles.edit12,'String')));   %в разах коэффициент приемной антенны
Dt=10*log10(D2);
B=str2double(char(get(handles.edit8,'String')));  %Ширина канала в Гц
%bet=5*10^(-3);
betGr=5*10^(-3);%[10^(-3) 2.5*10^(-3) 5*10^(-3) 7.5*10^(-3) 10^(-2) 1.5*10^(-2) 2.5*10^(-2)];    %интенсивоность неоднородностей
bet=0.001:0.0005:0.05;
d=str2double(char(get(handles.edit9,'String')));; %Дальность связи в км
sigmz=14;   %среднеквадратическое отклонение для расчета надежности связи


time = datenum([year mounth day hour 0 0]);

xj=[107.3 106.4 103.5 101 100 85.4 77.6 69.4 61.3 53.8 47.4 43.0 41.2 42.4 46.5 52.6 60.0 68.0 76.2 84.2 91.6 98.0 103.0 106.3 107.6]; %надо научиться расчитывать зенитный угол солнца
xjn=xj(13);
xj=xj(hour+1);

IRI=iri2016(time,latitude,longitude,300,false);

%Параметры ионосферы
f0F2=4;%IRI(:,28);     %Критическая частота слоя F2
f0E=IRI(:,30);      %Критическая частота слоя Е
M300F2=IRI(:,23);   %M-параметр при дальности связи 3000 км
R12=IRI(:,38);       %Число солнечных пятен
hm=IRI(:,15)*10^3;	%Высота максимума ионизации (м)

%Подготовка к расчетам

r=d*10^3;
hm=350000;
fcrF2=f0F2*10^6;

[f0,zdopGr]=FindZdop(fcrF2,r,hm,betGr);
[f0,zdop]=FindZdop(fcrF2,r,hm,bet);
[tmp,f08I]=min(abs(f0-f0(length(f0))*0.8));
[tmp1,f085I]=min(abs(f0-f0(length(f0))*0.85));
[tmp2,f09I]=min(abs(f0-f0(length(f0))*0.9));
clear tmp tmp1 tmp2;

f0=f0*10^(-6);
[Ec,Lb]=FindEc(R12,M300F2,f0,f0F2,f0E,xj,xjn,d);     %Построение напряженности сигнала на входе приемника
[Ep,FamT,Fatm,Fprom,Fsp]=FindEp(f0,f0F2,hour,promnois,B);               %Построение напряженности помехи

Ec=Ec+Gt+Pt;
Pr=Ec+Dt-20*log10(f0)-107.2;
SN=Pr-FamT-10*log10(B)+204;

for j=1:length(betGr)
    for i=1:length(SN)
        DsvGr(i,j)=0.5*erf(sqrt(2)*((SN(i)-zdopGr(i,j))/sigmz)*0.5)+0.5;    %для графика
    end
end
for j=1:length(bet)
    for i=1:length(SN)
        Dsv(i,j)=0.5*erf(sqrt(2)*((SN(i)-zdop(i,j))/sigmz)*0.5)+0.5;    %в общем виде
    end
    Dsv08(j)=Dsv(f08I,j);
    Dsv085(j)=Dsv(f085I,j);
    Dsv09(j)=Dsv(f09I,j);
end


[zdopav,Izdopav]=min(abs(zdopGr-14));
[DsvGrmax,IGrmax]=max(DsvGr);
[DsvGrmin,IGrmin]=min(abs(DsvGr-0.8));
DsvGrmin=DsvGrmin+0.8;
Dsvmax=max(Dsv);


for i=1:length(IGrmax)
    textDsv(i,:)=strcat('{\itf}_{орч_',num2str(i),'}');
end



set(0,'DefaultAxesFontSize',12,'DefaultAxesFontName','Times New Roman');
set(0,'DefaultTextFontSize',12,'DefaultTextFontName','Times New Roman'); 

F2MUF=f0(length(f0));
a=1;    %начало по Х
b=F2MUF+0.5;    %конец по Х

c=-20;    %начало по У
d=150;    %конец по У

figure('position', [100, 100, 1000, 450],'Units', 'normalized');        %Полотно рисунка с размерами в параметре позиций
semilogx(f0,Lb,'-','Color',[.1 .1 .1],'LineWidth',1);
text(b+0.2,Lb(length(Lb)),'{\itL_b}','HorizontalAlignment','left', 'fontsize' ,14);
text(b+0.2,Ec(length(Ec)),'{\itE}_{c}','HorizontalAlignment','left', 'fontsize' ,14);
grid on;
hold on;
semilogx(f0,Ec,'-','Color',[.1 .1 .1],'LineWidth',1);
%text(F2MUF-0.1,c+3,'{\itf}_{м}','HorizontalAlignment','right', 'fontsize' ,14);
axis([a b c d]);  
if (length(betGr)>1)
    legend('Location','northwest','1. \beta=10^{-3}','2. \beta=2.5\cdot10^{-3}','3. \beta=5\cdot10^{-3}','4. \beta=7.5\cdot10^{-3}','5. \beta=10^{-2}','6. \beta=1.5\cdot10^{-2}','7. \beta=2.5\cdot10^{-2}','8. \beta=5\cdot10^{-2}');
end
set(gca,'xtick',[1 2 3 4 5 6 7 8 9 10 11 12]); 
set(gca,'xticklabel',{'1' ; '2' ; '3' ; '4' ; '5' ; '6' ; '7' ; '8' ; '9' ; '10' ; '11' ; '12'});
xlabel('{\itf_0 ,} МГц','Position',[b+0.2 c -1],'FontWeight','bold','HorizontalAlignment','left', 'fontsize' ,14);                   %Подпись оси Х справа
ylabel('{\itE}_{c} , {\itL_b} , дБ','Position',[a d -1], 'Rotation', 0,'HorizontalAlignment','left','FontWeight','bold', 'fontsize' ,14);

% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global mounth
global promnois
rb3 = get(handles.radiobutton3,'Value');
if rb3==1 
    latitude = str2double(char(get(handles.edit1,'String')));
end
rb4 = get(handles.radiobutton4,'Value');
if rb4==1 
    lat = str2double(char(get(handles.edit1,'String')));
    latitude=0-lat;
end
rb5 = get(handles.radiobutton5,'Value');
if rb5==1 
longitude = str2double(char(get(handles.edit14,'String')));
end
rb6 = get(handles.radiobutton6,'Value');
if rb6==1 
    long = str2double(char(get(handles.edit14,'String')));
    longitude=180+long;
end
hour=str2double(char(get(handles.edit3,'String')));                  %Время, часы
day = str2double(char(get(handles.edit5,'String')));              %День
year = str2double(char(get(handles.edit6,'String')));           %Год

%Параметры линии
Pt=str2double(char(get(handles.edit10,'String')));   %в кВт
Pt=10*log10(Pt);
G1=str2double(char(get(handles.edit11,'String')));   %в разах коэффициент передающей антенны
Gt=10*log10(G1);
D2=str2double(char(get(handles.edit12,'String')));   %в разах коэффициент приемной антенны
Dt=10*log10(D2);
B=str2double(char(get(handles.edit8,'String')));  %Ширина канала в Гц
%bet=5*10^(-3);
betGr=5*10^(-3);%[10^(-3) 2.5*10^(-3) 5*10^(-3) 7.5*10^(-3) 10^(-2) 1.5*10^(-2) 2.5*10^(-2)];    %интенсивоность неоднородностей
bet=0.001:0.0005:0.05;
d=str2double(char(get(handles.edit9,'String')));; %Дальность связи в км
sigmz=14;   %среднеквадратическое отклонение для расчета надежности связи


time = datenum([year mounth day hour 0 0]);

xj=[107.3 106.4 103.5 101 100 85.4 77.6 69.4 61.3 53.8 47.4 43.0 41.2 42.4 46.5 52.6 60.0 68.0 76.2 84.2 91.6 98.0 103.0 106.3 107.6]; %надо научиться расчитывать зенитный угол солнца
xjn=xj(13);
xj=xj(hour+1);

IRI=iri2016(time,latitude,longitude,300,false);

%Параметры ионосферы
f0F2=4;%IRI(:,28);     %Критическая частота слоя F2
f0E=IRI(:,30);      %Критическая частота слоя Е
M300F2=IRI(:,23);   %M-параметр при дальности связи 3000 км
R12=IRI(:,38);       %Число солнечных пятен
hm=IRI(:,15)*10^3;	%Высота максимума ионизации (м)

%Подготовка к расчетам

r=d*10^3;
hm=350000;
fcrF2=f0F2*10^6;

[f0,zdopGr]=FindZdop(fcrF2,r,hm,betGr);
[f0,zdop]=FindZdop(fcrF2,r,hm,bet);
[tmp,f08I]=min(abs(f0-f0(length(f0))*0.8));
[tmp1,f085I]=min(abs(f0-f0(length(f0))*0.85));
[tmp2,f09I]=min(abs(f0-f0(length(f0))*0.9));
clear tmp tmp1 tmp2;

f0=f0*10^(-6);
[Ec,Lb]=FindEc(R12,M300F2,f0,f0F2,f0E,xj,xjn,d);     %Построение напряженности сигнала на входе приемника
[Ep,FamT,Fatm,Fprom,Fsp]=FindEp(f0,f0F2,hour,promnois,B);               %Построение напряженности помехи

Ec=Ec+Gt+Pt;
Pr=Ec+Dt-20*log10(f0)-107.2;
SN=Pr-FamT-10*log10(B)+204;

for j=1:length(betGr)
    for i=1:length(SN)
        DsvGr(i,j)=0.5*erf(sqrt(2)*((SN(i)-zdopGr(i,j))/sigmz)*0.5)+0.5;    %для графика
    end
end
for j=1:length(bet)
    for i=1:length(SN)
        Dsv(i,j)=0.5*erf(sqrt(2)*((SN(i)-zdop(i,j))/sigmz)*0.5)+0.5;    %в общем виде
    end
    Dsv08(j)=Dsv(f08I,j);
    Dsv085(j)=Dsv(f085I,j);
    Dsv09(j)=Dsv(f09I,j);
end


[zdopav,Izdopav]=min(abs(zdopGr-14));
[DsvGrmax,IGrmax]=max(DsvGr);
[DsvGrmin,IGrmin]=min(abs(DsvGr-0.8));
DsvGrmin=DsvGrmin+0.8;
Dsvmax=max(Dsv);


for i=1:length(IGrmax)
    textDsv(i,:)=strcat('{\itf}_{орч_',num2str(i),'}');
end



set(0,'DefaultAxesFontSize',12,'DefaultAxesFontName','Times New Roman');
set(0,'DefaultTextFontSize',12,'DefaultTextFontName','Times New Roman'); 

F2MUF=f0(length(f0));
a=1;    %начало по Х
b=F2MUF+0.5;    %конец по Х

c=25;    %начало по У
d=70;    %конец по У

figure('position', [100, 100, 1000, 450],'Units', 'normalized');        %Полотно рисунка с размерами в параметре позиций
semilogx(f0,Fatm,'--','Color',[.1 .1 .1],'LineWidth',1);
text(b+0.2,Fatm(length(Fatm)),'{\itF}_{атм}','HorizontalAlignment','left', 'fontsize' ,14);
text(b+0.2,Fprom(length(Fprom)),'{\itF}_{инд}','HorizontalAlignment','left', 'fontsize' ,14);
text(b+0.2,Fsp(length(Fsp)),'{\itF}_{гал}','HorizontalAlignment','left', 'fontsize' ,14);
text(b+0.2,FamT(length(FamT))+2,'{\itF_{amT}}','HorizontalAlignment','left', 'fontsize' ,14);
grid on;
hold on;
semilogx(f0,Fprom,'-','Color',[.1 .1 .1],'LineWidth',1);
k=1;
for i=1:length(f0)
    if f0(i)>=f0F2;
        f0sp(k)=f0(i);
        Fsp1(k)=Fsp(i);
        k=k+1;
    end
end
semilogx(f0sp,Fsp1,'-.','Color',[.1 .1 .1],'LineWidth',1);
semilogx(f0,FamT,'-','Color',[.1 .1 .1],'LineWidth',1);
axis([a b c d]);
if (length(betGr)>1)
    legend('Location','northwest','1. \beta=10^{-3}','2. \beta=2.5\cdot10^{-3}','3. \beta=5\cdot10^{-3}','4. \beta=7.5\cdot10^{-3}','5. \beta=10^{-2}','6. \beta=1.5\cdot10^{-2}','7. \beta=2.5\cdot10^{-2}','8. \beta=5\cdot10^{-2}');
end
set(gca,'xtick',[1 2 3 4 5 6 7 8 9 10 11 12]); 
set(gca,'xticklabel',{'1' ; '2' ; '3' ; '4' ; '5' ; '6' ; '7' ; '8' ; '9' ; '10' ; '11' ; '12'});
xlabel('{\itf_0 ,} МГц','Position',[b+0.2 c -1],'FontWeight','bold','HorizontalAlignment','left', 'fontsize' ,14);                   %Подпись оси Х справа
ylabel('{\itF_{amT}} , {\itF}_{атм} , {\itF}_{инд} , {\itF}_{гал} , дБ','Position',[a d -1], 'Rotation', 0,'HorizontalAlignment','left','FontWeight','bold', 'fontsize' ,14);


% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global mounth
global promnois
rb3 = get(handles.radiobutton3,'Value');
if rb3==1 
    latitude = str2double(char(get(handles.edit1,'String')));
end
rb4 = get(handles.radiobutton4,'Value');
if rb4==1 
    lat = str2double(char(get(handles.edit1,'String')));
    latitude=0-lat;
end
rb5 = get(handles.radiobutton5,'Value');
if rb5==1 
longitude = str2double(char(get(handles.edit14,'String')));
end
rb6 = get(handles.radiobutton6,'Value');
if rb6==1 
    long = str2double(char(get(handles.edit14,'String')));
    longitude=180+long;
end
hour=str2double(char(get(handles.edit3,'String')));                  %Время, часы

day = str2double(char(get(handles.edit5,'String')));              %День
year = str2double(char(get(handles.edit6,'String')));           %Год


%Параметры линии
Pt=str2double(char(get(handles.edit10,'String')));   %в кВт
Pt=10*log10(Pt);
G1=str2double(char(get(handles.edit11,'String')));   %в разах коэффициент передающей антенны
Gt=10*log10(G1);
D2=str2double(char(get(handles.edit12,'String')));   %в разах коэффициент приемной антенны
Dt=10*log10(D2);
B=str2double(char(get(handles.edit8,'String')));  %Ширина канала в Гц
%bet=5*10^(-3);
betGr=5*10^(-3);%[10^(-3) 2.5*10^(-3) 5*10^(-3) 7.5*10^(-3) 10^(-2) 1.5*10^(-2) 2.5*10^(-2)];    %интенсивоность неоднородностей
bet=0.001:0.0005:0.05;
d=str2double(char(get(handles.edit9,'String'))); %Дальность связи в км
sigmz=14;   %среднеквадратическое отклонение для расчета надежности связи


time = datenum([year mounth day hour 0 0]);

xj=[107.3 106.4 103.5 101 100 85.4 77.6 69.4 61.3 53.8 47.4 43.0 41.2 42.4 46.5 52.6 60.0 68.0 76.2 84.2 91.6 98.0 103.0 106.3 107.6]; %надо научиться расчитывать зенитный угол солнца
xjn=xj(13);
xj=xj(hour+1);

IRI=iri2016(time,latitude,longitude,300,false);

%Параметры ионосферы
f0F2=4;%IRI(:,28);     %Критическая частота слоя F2
f0E=IRI(:,30);      %Критическая частота слоя Е
M300F2=IRI(:,23);   %M-параметр при дальности связи 3000 км
R12=IRI(:,38);       %Число солнечных пятен
hm=IRI(:,15)*10^3;	%Высота максимума ионизации (м)

%Подготовка к расчетам

r=d*10^3;
hm=350000;
fcrF2=f0F2*10^6;

[f0,zdopGr]=FindZdop(fcrF2,r,hm,betGr);
[f0,zdop]=FindZdop(fcrF2,r,hm,bet);
[tmp,f08I]=min(abs(f0-f0(length(f0))*0.8));
[tmp1,f085I]=min(abs(f0-f0(length(f0))*0.85));
[tmp2,f09I]=min(abs(f0-f0(length(f0))*0.9));
clear tmp tmp1 tmp2;

f0=f0*10^(-6);
[Ec,Lb]=FindEc(R12,M300F2,f0,f0F2,f0E,xj,xjn,d);     %Построение напряженности сигнала на входе приемника
[Ep,FamT,Fatm,Fprom,Fsp]=FindEp(f0,f0F2,hour,promnois,B);               %Построение напряженности помехи

Ec=Ec+Gt+Pt;
Pr=Ec+Dt-20*log10(f0)-107.2;
SN=Pr-FamT-10*log10(B)+204;

for j=1:length(betGr)
    for i=1:length(SN)
        DsvGr(i,j)=0.5*erf(sqrt(2)*((SN(i)-zdopGr(i,j))/sigmz)*0.5)+0.5;    %для графика
    end
end
for j=1:length(bet)
    for i=1:length(SN)
        Dsv(i,j)=0.5*erf(sqrt(2)*((SN(i)-zdop(i,j))/sigmz)*0.5)+0.5;    %в общем виде
    end
    Dsv08(j)=Dsv(f08I,j);
    Dsv085(j)=Dsv(f085I,j);
    Dsv09(j)=Dsv(f09I,j);
end


[zdopav,Izdopav]=min(abs(zdopGr-14));
[DsvGrmax,IGrmax]=max(DsvGr);
[DsvGrmin,IGrmin]=min(abs(DsvGr-0.8));
DsvGrmin=DsvGrmin+0.8;
Dsvmax=max(Dsv);


for i=1:length(IGrmax)
    textDsv(i,:)=strcat('{\itf}_{орч_',num2str(i),'}');
end



set(0,'DefaultAxesFontSize',12,'DefaultAxesFontName','Times New Roman');
set(0,'DefaultTextFontSize',12,'DefaultTextFontName','Times New Roman'); 

F2MUF=f0(length(f0));
a=1;    %начало по Х
b=F2MUF+0.5;    %конец по Х
c=-120;    %начало по У
d=80;    %конец по У


figure('position', [100, 100, 1000, 450],'Units', 'normalized');        %Полотно рисунка с размерами в параметре позиций
semilogx(f0,Pr,'--','Color',[.1 .1 .1],'LineWidth',1);

text(b+0.2,Pr(length(f0)),'{\itP_r}','HorizontalAlignment','left', 'fontsize' ,14);
text(b+0.2,FamT(length(f0))+10,'{\itF_{amT}}','HorizontalAlignment','left', 'fontsize' ,14);
text(b+0.2,SN(length(f0))-10,'$\overline{z}$','HorizontalAlignment','left','interpreter','latex', 'fontsize' ,14);
grid on;
hold on;
semilogx(f0,FamT,'-.','Color',[.1 .1 .1],'LineWidth',1);
semilogx(f0,SN,'-','Color',[.1 .1 .1],'LineWidth',1);
if (length(betGr)>1)
    legend('Location','northwest','1. \beta=10^{-3}','2. \beta=2.5\cdot10^{-3}','3. \beta=5\cdot10^{-3}','4. \beta=7.5\cdot10^{-3}','5. \beta=10^{-2}','6. \beta=1.5\cdot10^{-2}','7. \beta=2.5\cdot10^{-2}','8. \beta=5\cdot10^{-2}');
end
axis([a b c d]);   
%title('Рисунок 2');
set(gca,'xtick',[1 2 3 4 5 6 7 8 9 10 11 12]); 
set(gca,'xticklabel',{'1' ; '2' ; '3' ; '4' ; '5' ; '6' ; '7' ; '8' ; '9' ; '10' ; '11' ; '12'});
xlabel('{\itf_0 ,} МГц','Position',[b+0.2 c -1],'FontWeight','bold','HorizontalAlignment','left', 'fontsize' ,14);                   %Подпись оси Х справа
ylabel('{\itP_r} , {\itF_{amT}} , дБ','Position',[a d -1], 'Rotation', 0,'HorizontalAlignment','left','FontWeight','bold', 'fontsize' ,14);



function edit13_Callback(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit13 as text
%        str2double(get(hObject,'String')) returns contents of edit13 as a double


% --- Executes during object creation, after setting all properties.
function edit13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit14_Callback(hObject, eventdata, handles)
% hObject    handle to edit14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit14 as text
%        str2double(get(hObject,'String')) returns contents of edit14 as a double


% --- Executes during object creation, after setting all properties.
function edit14_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in radiobutton3.
function radiobutton3_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton3


% --- Executes on button press in radiobutton4.
function radiobutton4_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton4


% --- Executes on button press in radiobutton5.
function radiobutton5_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton5


% --- Executes on button press in radiobutton6.
function radiobutton6_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton6



function edit15_Callback(hObject, eventdata, handles)
% hObject    handle to edit15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit15 as text
%        str2double(get(hObject,'String')) returns contents of edit15 as a double


% --- Executes during object creation, after setting all properties.
function edit15_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu3.
function popupmenu3_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu3
contents=cellstr(get(hObject,'String'));
pop_choice=contents(get(hObject,'Value'));
pop_choice
global promnois
if(strcmp(pop_choice,'Индустриальная застройка'))
  promnois = 1
elseif (strcmp(pop_choice,'Город'))
    promnois = 2
elseif (strcmp(pop_choice,'Сельская местность'))
    promnois = 3
elseif (strcmp(pop_choice,'Малодоступная терретория'))
    promnois = 4
end

% --- Executes during object creation, after setting all properties.
function popupmenu3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu4.
function popupmenu4_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu4 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu4
contents=cellstr(get(hObject,'String'));
pop_choice=contents(get(hObject,'Value'));
pop_choice
global mounth
if(strcmp(pop_choice,'Январь'))
  mounth = 1
elseif (strcmp(pop_choice,'Февраль'))
    mounth = 2
elseif (strcmp(pop_choice,'Март'))
    mounth = 3
elseif (strcmp(pop_choice,'Апрель'))
    mounth = 4
elseif (strcmp(pop_choice,'Май'))
    mounth = 5
elseif (strcmp(pop_choice,'Июнь'))
    mounth = 6
elseif (strcmp(pop_choice,'Июль'))
    mounth = 7
elseif (strcmp(pop_choice,'Август'))
    mounth = 8 
elseif (strcmp(pop_choice,'Сентябрь'))
    mounth = 9
elseif (strcmp(pop_choice,'Октябрь'))
    mounth = 10
elseif (strcmp(pop_choice,'Ноябрь'))
    mounth = 11
elseif (strcmp(pop_choice,'Декабрь'))
    mounth = 12
end      

% --- Executes during object creation, after setting all properties.
function popupmenu4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
