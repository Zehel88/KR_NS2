%% Стандартные функции создания/запуска/инициализации формы 
function varargout = lab2_main(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @lab2_main_OpeningFcn, ...
                   'gui_OutputFcn',  @lab2_main_OutputFcn, ...
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


function lab2_main_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);


function varargout = lab2_main_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;


function edit1_Callback(hObject, eventdata, handles)



function edit1_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function pushbutton1_Callback(hObject, eventdata, handles)
%% Кнопка нечеткой аппроксимации
% Получаем диапазон для аппроксимации
d=str2num(get(handles.edit3,'String'))
% Получаем колво точек для аппроксимации
n=str2double(get(handles.edit2,'String'))
% Значения для построения НС
dia=d(1):(abs(d(1))+abs(d(2)))/(n-1):d(2)
% Получаем функцию для аппроксимации
af=get(handles.edit1,'String')
% Приводим функцию в встроенному виду
f=inline(af)
% Вычисляем выходной диапазон
for i=1:n
dy(i)=f(dia(i));
end

% Создаем новую НС типа Сугено
F=newfis('lab2_fis','sugeno');
sv=symvar(f);

F=addvar(F,'input',sv{1},[d]);
F=addvar(F,'output','y',[dy]);
sko=str2double(get(handles.edit4,'String'));
for i=1:n   
     F=addmf(F,'input',1,num2str(i),'gaussmf',[sko dia(i)]);
     F=addmf(F,'output',1,num2str(i),'constant',[dy(i)]);
     rulelist(i,:)=[i i 1 1];
end
    
F = addrule(F,rulelist);




% Сохраняем НС
writefis(F,'lab2_fis');

axes(handles.axes1)
plotmf(F,'input',1)
title('Функции принадлежности входной переменной')
axes(handles.axes2)
gensurf(F)
title('Аппроксимированная ф-я')
grid on




function edit2_Callback(hObject, eventdata, handles)

function edit2_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)

function edit3_CreateFcn(hObject, eventdata, handles)
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
