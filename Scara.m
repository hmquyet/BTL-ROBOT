
function varargout = Scara(varargin)
% SCARA MATLAB code for Scara.fig
%      SCARA, by itself, creates a new SCARA or raises the existing
%      singleton*.
%
%      H = SCARA returns the handle to a new SCARA or the handle to
%      the existing singleton*.
%
%      SCARA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SCARA.M with the given input arguments.
%
%      SCARA('Property','Value',...) creates a new SCARA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Scara_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Scara_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Scara

% Last Modified by GUIDE v2.5 10-Dec-2023 09:36:20

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Scara_OpeningFcn, ...
                   'gui_OutputFcn',  @Scara_OutputFcn, ...
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



% --- Executes just before Scara is made visible.
function Scara_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Scara (see VARARGIN)
global path;
clearvars -global path;
global step;
step = 40;

global t_theta1;
global t_theta2;
global t_d3;
global t_theta4;

t_theta1 = zeros(1, step);
t_theta2 = zeros(1, step);
t_d3 = zeros(1, step);
t_theta4 = zeros(1, step);

global pre_theta1;
global pre_theta2;
global pre_d3;
global pre_theta4; 

global end_theta1;
global end_theta2 ;
global end_d3 ; 
global end_theta4;

pre_theta1 =0;
pre_theta2=90;
pre_d3=0;
pre_theta4=0;


end_theta1= pre_theta1;
end_theta2= pre_theta2;
end_d3 = pre_d3;
end_theta4= pre_theta4;

% disp(end_theta1);
% disp(end_theta2);
% disp(end_theta4);
% disp(end_d3);

set(handles.edit_v_max,'String',10);
set(handles.edit_a_max,'String',10);
% set(handles.para_x2,'String',20);
% set(handles.para_y2,'String',30);
% set(handles.para_z2,'String',0);
% set(handles.para_yaw2,'String',0);

set(handles.text_x,'String',20);
set(handles.text_y,'String',30);
set(handles.text_z,'String',0);
set(handles.text_roll,'String',0);
set(handles.text_pitch,'String',0);
set(handles.text_yaw,'String',0);


set(handles.edit_set_roll,'String',180);
set(handles.edit_set_pitch,'String',0);


% sim('PIDController', 'SimulationMode', 'normal', 'StopTime', '50');

DrawRobot(end_theta1,end_theta2,end_d3,end_theta4,handles);
if  handles.checkbox_workspace.Value
      Workspace(handles)  
end
% Choose default command line output for Scara
handles.output = hObject;
% Creat DH Matrix

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Scara wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Scara_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
%%

% --- Executes on slider movement.
function slider_d3_Callback(hObject, eventdata, handles)
% hObject    handle to slider_d3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider



    set(handles.slider_d3, 'Max',15)
    set(handles.slider_d3, 'Min', 0);
    set(handles.slider_d3, 'SliderStep' , [1, 1] / 50 );
   
  

global end_d3 ; 

end_d3 = get(handles.slider_d3,'Value');
    set(handles.edit_d3,'String',end_d3)
    set(handles.edit_d3, 'Value' , end_d3 );
  

% --- Executes during object creation, after setting all properties.
function slider_d3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_d3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

%%
% --- Executes on slider movement.
function slider_theta1_Callback(hObject, eventdata, handles)
% hObject    handle to slider_theta1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


    set(handles.slider_theta1, 'Max', 125);
    set(handles.slider_theta1, 'Min', -125);
    set(handles.slider_theta1, 'SliderStep' , [1, 1] / 50 );
    
global end_theta1;

end_theta1 = get(handles.slider_theta1,'Value');
set(handles.edit_theta1,'String',end_theta1)
set(handles.edit_theta1, 'Value' , end_theta1 );

   

% --- Executes during object creation, after setting all properties.
function slider_theta1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_theta1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

%%
% --- Executes on slider movement.
function slider_theta2_Callback(hObject, eventdata, handles)
% hObject    handle to slider_theta2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

    set(handles.slider_theta2, 'Max', 145);
    set(handles.slider_theta2, 'Min', -145);
    set(handles.slider_theta2, 'SliderStep' , [1, 1] / 90 );
    

global end_theta2 ;

end_theta2 = get(handles.slider_theta2,'Value');
set(handles.edit_theta2,'String',end_theta2)
set(handles.edit_theta2, 'Value' , end_theta2 );

   


% --- Executes during object creation, after setting all properties.
function slider_theta2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_theta2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
%%
% --- Executes on slider movement.
function slider_theta4_Callback(hObject, eventdata, handles)
% hObject    handle to slider_theta4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
  
    set(handles.slider_theta4, 'Max', 180*2);
    set(handles.slider_theta4, 'Min', -180*2);
    set(handles.slider_theta4, 'SliderStep' , [1, 1] / 50 );

global end_theta4;
end_theta4 = get(handles.slider_theta4,'Value');
set(handles.edit_theta4,'String',end_theta4)
set(handles.edit_theta4, 'Value' , end_theta4 );


   

% --- Executes during object creation, after setting all properties.
function slider_theta4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_theta4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
%%

function edit_d3_Callback(hObject, eventdata, handles)
% hObject    handle to edit_d3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_d3 as text
%        str2double(get(hObject,'String')) returns contents of edit_d3 as a double



% --- Executes during object creation, after setting all properties.
function edit_d3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_d3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_theta1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_theta1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_theta1 as text
%        str2double(get(hObject,'String')) returns contents of edit_theta1 as a double

%plot(handles)
% --- Executes during object creation, after setting all properties.
function edit_theta1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_theta1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_theta2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_theta2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_theta2 as text
%        str2double(get(hObject,'String')) returns contents of edit_theta2 as a double
%plot(handles)

% --- Executes during object creation, after setting all properties.
function edit_theta2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_theta2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_theta4_Callback(hObject, eventdata, handles)
% hObject    handle to edit_theta4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_theta4 as text
%        str2double(get(hObject,'String')) returns contents of edit_theta4 as a double

%plot(handles)
% --- Executes during object creation, after setting all properties.
function edit_theta4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_theta4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkbox_coordinate_4.
function checkbox_coordinate_4_Callback(hObject, eventdata, handles)

% hObject    handle to checkbox_coordinate_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Forward(handles)
% Hint: get(hObject,'Value') returns toggle state of checkbox_coordinate_4


% --- Executes on button press in checkbox_coordinate_3.
function checkbox_coordinate_3_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_coordinate_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Forward(handles)
% Hint: get(hObject,'Value') returns toggle state of checkbox_coordinate_3


% --- Executes on button press in checkbox_coordinate_2.
function checkbox_coordinate_2_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_coordinate_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Forward(handles)
% Hint: get(hObject,'Value') returns toggle state of checkbox_coordinate_2


% --- Executes on button press in checkbox_coordinate_1.
function checkbox_coordinate_1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_coordinate_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Forward(handles)
% Hint: get(hObject,'Value') returns toggle state of checkbox_coordinate_1


% --- Executes on button press in checkbox_coordinate_0.
function checkbox_coordinate_0_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_coordinate_0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_coordinate_0



function edit_coor4_x_Callback(hObject, eventdata, handles)
% hObject    handle to text_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of text_x as text
%        str2double(get(hObject,'String')) returns contents of text_x as a double


% --- Executes during object creation, after setting all properties.
function text_x_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_coor4_y_Callback(hObject, eventdata, handles)
% hObject    handle to text_y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of text_y as text
%        str2double(get(hObject,'String')) returns contents of text_y as a double


% --- Executes during object creation, after setting all properties.
function text_y_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text_y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_coor4_z_Callback(hObject, eventdata, handles)
% hObject    handle to text_z (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of text_z as text
%        str2double(get(hObject,'String')) returns contents of text_z as a double


% --- Executes during object creation, after setting all properties.
function text_z_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text_z (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_coor4_phi_Callback(hObject, eventdata, handles)
% hObject    handle to text_roll (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of text_roll as text
%        str2double(get(hObject,'String')) returns contents of text_roll as a double


% --- Executes during object creation, after setting all properties.
function text_roll_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text_roll (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_coor4_theta_Callback(hObject, eventdata, handles)
% hObject    handle to text_pitch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of text_pitch as text
%        str2double(get(hObject,'String')) returns contents of text_pitch as a double


% --- Executes during object creation, after setting all properties.
function text_pitch_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text_pitch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_coor4_psi_Callback(hObject, eventdata, handles)
% hObject    handle to text_yaw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of text_yaw as text
%        str2double(get(hObject,'String')) returns contents of text_yaw as a double


% --- Executes during object creation, after setting all properties.
function text_yaw_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text_yaw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



%plot_robot(handles)

% --- Executes on button press in PushButton_Reset.
function PushButton_Reset_Callback(hObject, eventdata, handles)
% hObject    handle to PushButton_Reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
hold off;

global path;
clearvars -global path;


cla(handles.q,'reset');
 cla(handles.v,'reset');
cla(handles.a,'reset');

cla(handles.q_Theta1,'reset');
cla(handles.v_Theta1,'reset');
cla(handles.a_Theta1,'reset');

 cla(handles.q_Theta2,'reset');
cla(handles.v_Theta2,'reset');
 cla(handles.a_Theta2,'reset');

 cla(handles.q_Theta4,'reset');
cla(handles.v_Theta4,'reset');
 cla(handles.a_Theta4,'reset');

 cla(handles.q_d3,'reset');
cla(handles.v_d3,'reset');
 cla(handles.a_d3,'reset');


set(handles.edit_v_max,'String',10 );
set(handles.edit_a_max,'String',10);
% set(handles.para_x2,'String',20);
% set(handles.para_y2,'String',30);
% set(handles.para_z2,'String',0);
% set(handles.para_yaw2,'String',0);

set(handles.text_x,'String',20);
set(handles.text_y,'String',30);
set(handles.text_z,'String',0);
set(handles.text_roll,'String',0);
set(handles.text_pitch,'String',0);
set(handles.text_yaw,'String',0);

set(handles.edit_d3,'string',num2str(0));
 set(handles.edit_theta1,'string',num2str(0));
 set(handles.edit_theta2,'string',num2str(90));
 set(handles.edit_theta4,'string',num2str(0));

 set(handles.slider_theta1, 'Value' , 0 );
 set(handles.slider_theta2, 'Value' , 90 );
 set(handles.slider_d3, 'Value' , 0 );
 set(handles.slider_theta4, 'Value' , 0 );

set(handles.edit_theta1, 'Value' , 0 );
set(handles.edit_theta2, 'Value' , pi/2 );
set(handles.edit_d3, 'Value' , 0 );
set(handles.edit_theta4, 'Value' , 0 );

% DrawRobot(pre_theta1,pre_theta2,pre_d3,pre_theta4,handles);

global pre_theta1;
global pre_theta2;
global pre_d3;
global pre_theta4; 

pre_theta1 =0;
pre_theta2=90;
pre_d3=0;
pre_theta4=0;


global end_theta1;
global end_theta2 ;
global end_d3 ; 
global end_theta4;

end_theta1= pre_theta1 ;
end_theta2= pre_theta2 ;
end_d3 = pre_d3;
end_theta4= pre_theta4;

set(handles.text_roll,'String',180);
set(handles.text_pitch,'String',0);
set(handles.text_yaw,'String',0);

set(handles.edit_set_roll,'String',180);
set(handles.edit_set_pitch,'String',0);

DrawRobot(end_theta1,end_theta2,end_d3,end_theta4,handles);

% --- Executes on button press in PushButton_Set.
function PushButton_Set_Callback(hObject, eventdata, handles)
% hObject    handle to PushButton_Set (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global end_theta1;
global end_theta2 ;
global end_d3 ; 
global end_theta4;

 Forward(handles);






% --- Executes on button press in checkbox_workspace.
function checkbox_workspace_Callback(hObject, eventdata, handles)
global end_theta1;
global end_theta2 ;
global end_d3 ; 
global end_theta4;


if  handles.checkbox_workspace.Value
      Workspace(handles)
else
    DrawRobot(end_theta1,end_theta2,end_d3,end_theta4,handles);
end


% hObject    handle to checkbox_workspace (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% axis=axes1;
% 
% Hint: get(hObject,'Value') returns toggle state of checkbox_workspace


% --- Executes on slider movement.
function slider_opacity_Callback(hObject, eventdata, handles)
% hObject    handle to slider_opacity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Forward(handles);
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider_opacity_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_opacity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in checkbox_fill.
function checkbox_fill_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_fill (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_fill


% --- Executes on button press in checkbox_fill.
function checkbox_workspace_fill_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_fill (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_fill








% --- Executes on button press in inverse_putton.
function inverse_putton_Callback(hObject, eventdata, handles)
% hObject    handle to inverse_putton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    
Inverse(handles);





function edit_set_yaw_Callback(hObject, eventdata, handles)
% hObject    handle to edit_set_yaw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_set_yaw as text
%        str2double(get(hObject,'String')) returns contents of edit_set_yaw as a double


% --- Executes during object creation, after setting all properties.
function edit_set_yaw_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_set_yaw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_set_pitch_Callback(hObject, eventdata, handles)
% hObject    handle to edit_set_pitch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_set_pitch as text
%        str2double(get(hObject,'String')) returns contents of edit_set_pitch as a double


% --- Executes during object creation, after setting all properties.
function edit_set_pitch_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_set_pitch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_set_roll_Callback(hObject, eventdata, handles)
% hObject    handle to edit_set_roll (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_set_roll as text
%        str2double(get(hObject,'String')) returns contents of edit_set_roll as a double


% --- Executes during object creation, after setting all properties.
function edit_set_roll_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_set_roll (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_set_z_Callback(hObject, eventdata, handles)
% hObject    handle to edit_set_z (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_set_z as text
%        str2double(get(hObject,'String')) returns contents of edit_set_z as a double


% --- Executes during object creation, after setting all properties.
function edit_set_z_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_set_z (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_set_y_Callback(hObject, eventdata, handles)
% hObject    handle to edit_set_y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_set_y as text
%        str2double(get(hObject,'String')) returns contents of edit_set_y as a double


% --- Executes during object creation, after setting all properties.
function edit_set_y_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_set_y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_set_x_Callback(hObject, eventdata, handles)
% hObject    handle to edit_set_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_set_x as text
%        str2double(get(hObject,'String')) returns contents of edit_set_x as a double


% --- Executes during object creation, after setting all properties.
function edit_set_x_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_set_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in push_path_planning.
function push_path_planning_Callback(hObject, eventdata, handles)
% hObject    handle to push_path_planning (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if  handles.radio_Scurve.Value
     Trajectory_Scurve(handles);  
end
if  handles.radio_lspb.Value
     Trajactory_Lspb(handles);  
end


function edit116_Callback(hObject, eventdata, handles)
% hObject    handle to edit_q_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_q_max as text
%        str2double(get(hObject,'String')) returns contents of edit_q_max as a double


% --- Executes during object creation, after setting all properties.
function edit_q_max_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_q_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_v_max_Callback(hObject, eventdata, handles)
% hObject    handle to edit_v_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_v_max as text
%        str2double(get(hObject,'String')) returns contents of edit_v_max as a double


% --- Executes during object creation, after setting all properties.
function edit_v_max_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_v_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_a_max_Callback(hObject, eventdata, handles)
% hObject    handle to edit_a_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_a_max as text
%        str2double(get(hObject,'String')) returns contents of edit_a_max as a double


% --- Executes during object creation, after setting all properties.
function edit_a_max_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_a_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function para_x1_Callback(hObject, eventdata, handles)
% hObject    handle to para_x1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of para_x1 as text
%        str2double(get(hObject,'String')) returns contents of para_x1 as a double


% --- Executes during object creation, after setting all properties.
function para_x1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to para_x1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function para_y1_Callback(hObject, eventdata, handles)
% hObject    handle to para_y1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of para_y1 as text
%        str2double(get(hObject,'String')) returns contents of para_y1 as a double


% --- Executes during object creation, after setting all properties.
function para_y1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to para_y1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function para_z1_Callback(hObject, eventdata, handles)
% hObject    handle to para_z1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of para_z1 as text
%        str2double(get(hObject,'String')) returns contents of para_z1 as a double


% --- Executes during object creation, after setting all properties.
function para_z1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to para_z1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function para_yaw1_Callback(hObject, eventdata, handles)
% hObject    handle to para_yaw1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of para_yaw1 as text
%        str2double(get(hObject,'String')) returns contents of para_yaw1 as a double


% --- Executes during object creation, after setting all properties.
function para_yaw1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to para_yaw1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function para_x2_Callback(hObject, eventdata, handles)
% hObject    handle to para_x2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of para_x2 as text
%        str2double(get(hObject,'String')) returns contents of para_x2 as a double


% --- Executes during object creation, after setting all properties.
function para_x2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to para_x2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function para_y2_Callback(hObject, eventdata, handles)
% hObject    handle to para_y2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of para_y2 as text
%        str2double(get(hObject,'String')) returns contents of para_y2 as a double


% --- Executes during object creation, after setting all properties.
function para_y2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to para_y2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function para_z2_Callback(hObject, eventdata, handles)
% hObject    handle to para_z2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of para_z2 as text
%        str2double(get(hObject,'String')) returns contents of para_z2 as a double


% --- Executes during object creation, after setting all properties.
function para_z2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to para_z2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function para_yaw2_Callback(hObject, eventdata, handles)
% hObject    handle to para_yaw2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of para_yaw2 as text
%        str2double(get(hObject,'String')) returns contents of para_yaw2 as a double


% --- Executes during object creation, after setting all properties.
function para_yaw2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to para_yaw2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in radio_lspb.
function radio_lspb_Callback(hObject, eventdata, handles)
% hObject    handle to radio_lspb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radio_lspb


% --- Executes on button press in radio_Scurve.
function radio_Scurve_Callback(hObject, eventdata, handles)
% hObject    handle to radio_Scurve (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radio_Scurve


% --- Executes on button press in Effector.
function Effector_Callback(hObject, eventdata, handles)
% hObject    handle to Effector (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.pnEffector,'Visible','on');
set(handles.pnJointSpace,'Visible','off');


% --- Executes on button press in joint_Space.
function joint_Space_Callback(hObject, eventdata, handles)
% hObject    handle to joint_Space (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.pnEffector,'Visible','off');
set(handles.pnJointSpace,'Visible','on');


% --- Executes on button press in PID.
function PID_Callback(hObject, eventdata, handles)
% hObject    handle to PID (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushpid.
function pushpid_Callback(hObject, eventdata, handles)

% hObject    handle to pushpid (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in checkbox_PID.
function checkbox_PID_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_PID (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_PID


% --- Executes on button press in checkbox_Coordinate.
function checkbox_Coordinate_Callback(hObject, eventdata, handles)
global end_theta1;
global end_theta2 ;
global end_d3 ; 
global end_theta4;

DrawRobot(end_theta1,end_theta2,end_d3,end_theta4,handles);

% hObject    handle to checkbox_Coordinate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_Coordinate
