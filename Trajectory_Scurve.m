function Trajectory_Scurve(handles)
% Quy hoạch vận tốc hình thang
global step;
Plot_axes(handles);
% global t_theta1;
% global t_theta2;
% global t_d3;
% global t_theta4;
% 
% global q_theta1;
% global q_theta2;
% global q_d3;
% global q_theta4;

% global x;
% global y;
% global z;
% global yaw;

    a1     = 20;
    a2     = 30;
    d4     = 0;
 
    v_max      = str2num(get(handles.edit_v_max,'String'));
    a_max      = str2num(get(handles.edit_a_max,'String'));
    
    d3     = str2num(get(handles.edit_d3,'String'))
    theta1 = str2num(get(handles.edit_theta1,'String'))
    theta2 = str2num(get(handles.edit_theta2,'String'))
    theta4 = str2num(get(handles.edit_theta4,'String'))

    x1     = str2num(get(handles.para_x1,'String'));
    y1     = str2num(get(handles.para_y1,'String'));
    z1     = str2num(get(handles.para_z1,'String'));
    yaw1   = str2num(get(handles.para_yaw1,'String'))*pi/180;

    x2     = str2num(get(handles.text_x,'String'));
    y2     = str2num(get(handles.text_y,'String'));
    z2     = str2num(get(handles.text_z,'String'));
    yaw2   = str2num(get(handles.text_yaw,'String'))*pi/180;
    
    
    d3_new = -z1 + d4
    theta2_new =  acos( (x1^2 + y1^2 - a1^2 - a2^2)/(2*a1*a2))
    c1 = (x1*(a1 + a2*cos(theta2_new)) + y1*a2*sin(theta2_new))/(x1^2 + y1^2);
    s1 = (y1*(a1 + a2*cos(theta2_new)) - x1*a2*sin(theta2_new))/(x1^2 + y1^2);
    theta1_new = atan2(s1,c1)
    theta4_new = yaw1 - theta1_new - theta2_new

    if (d3_new < 0 || abs(d3_new) > 15)
        warndlg('The new d3 is out of range', 'Warning', 'modal');
        break_signal = 1;
        return
    end 
    if (theta2_new < -145*pi/180 || theta2_new > 145*pi/180)
        warndlg('The new theta2 is out of range', 'Warning', 'modal');
        break_signal = 1;
        return
    end
    if (theta1_new < -125*pi/180 || theta1_new > 125*pi/180)
        warndlg('The new theta1 is out of range', 'Warning', 'modal');
        break_signal = 1;
        return
    end


    % Tính toán vị trí cũ
    q_Theta1_max = theta1_new*180/pi-theta1;
    q_Theta2_max = theta2_new*180/pi-theta2;
    q_d3_max = d3_new-d3;
    q_Theta4_max = theta4_new*180/pi-theta4;

      theta1_a=linspace(theta1,theta1_new*180/pi,step); 
    theta2_a=linspace(theta2,theta2_new*180/pi,step);
    theta4_a=linspace(theta4,theta4_new*180/pi,step);
    d3_a=linspace(d3,d3_new,step);

    
    
    set(handles.edit_theta1,'String',theta1_new*180/pi);
    set(handles.edit_theta2,'String',theta2_new*180/pi);
    set(handles.edit_d3,'String',d3_new);
    set(handles.edit_theta4,'String',theta4_new*180/pi);

  %% Tính toán các giá trị q,v,a,J cho từng khớp

 [q_theta1, v_theta1, a_theta1, J_theta1, t_theta1]=Scurve(q_Theta1_max,v_max,a_max,theta1);
 [q_theta2, v_theta2, a_theta2, J_theta2, t_theta2]=Scurve(q_Theta2_max,v_max,a_max,theta2);
 [q_d3, v_d3, a_d3, J_d3, t_d3]=Scurve(q_d3_max,v_max,a_max,d3);
 [q_theta4, v_theta4, a_theta4, J_theta4, t_theta4]=Scurve(q_Theta4_max,v_max,a_max,theta4);

  mat1 = [t_theta1;q_theta1];
mat2 = [t_theta2;q_theta2]
mat3 = [t_d3;q_d3];
mat4 = [t_theta4;q_theta4];

save theta1set.mat mat1;
save theta2set.mat mat2;
save d3set.mat mat3;
save theta4set.mat mat4;

  
  %% Tính toán các giá trị q,v,a,J cho Effector
q_max =0;
x_temp=x2;
y_temp=y2;
z_temp=z2;
for i=1:step
a1=20;
a2=30;
d4=0;
a     = [a1     ; a2     ; 0  ; 0     ];
alpha = [0      ; 0      ; 0  ; pi    ];
d     = [0      ; 0      ; -d3_a(i) ; d4   ];
theta = [theta1_a(i)*pi/1810 ; theta2_a(i)*pi/180 ; 0  ; theta4_a(i)*pi/180];

% 
A0_1 = DH_matrix(a(1),alpha(1),d(1),theta(1)) ;
A1_2 = DH_matrix(a(2),alpha(2),d(2),theta(2)) ;
A2_3 = DH_matrix(a(3),alpha(3),d(3),theta(3)) ;
A3_4 = DH_matrix(a(4),alpha(4),d(4),theta(4)) ;

A0_2=A0_1*A1_2;
A0_3=A0_2*A2_3;
A0_4=A0_3*A3_4;   
% Position 
p0 = [0;0;0];
p1 = [A0_1(1,4) A0_1(2,4) A0_1(3,4)];
p2 = [A0_2(1,4) A0_2(2,4) A0_2(3,4)];
p3 = [A0_3(1,4) A0_3(2,4) A0_3(3,4)];
p4 = [A0_4(1,4) A0_4(2,4) A0_4(3,4)];
% Orientation
 o1 = Orientation(A0_1);
 o2 = Orientation(A0_2);
 o3 = Orientation(A0_3);
 o4 = Orientation(A0_4);

x(i) = round(p4(1),3);
y(i) =  round(p4(2),3);
z(i) = round(p4(3),3);

q = sqrt((x(i)-x_temp)^2+(y(i)-y_temp)^2+(z(i)-z_temp)^2);

x_temp=x(i);
y_temp=y(i);
z_temp=z(i);
q_max =q_max+q;
end

[q, v, a, J, t]=Scurve(q_max,v_max,a_max,0);


if handles.checkbox_PID.Value
     load_system('PIDController_theta1');
    open_system('PIDController_theta1'); 
    set_param('PIDController_theta1','SimulationMode','normal');

         load_system('PIDController_theta2');
    open_system('PIDController_theta2'); 
    set_param('PIDController_theta2','SimulationMode','normal');

             load_system('PIDController_theta4');
    open_system('PIDController_theta4'); 
    set_param('PIDController_theta4','SimulationMode','normal');

             load_system('PIDController_d3');
    open_system('PIDController_d3'); 
    set_param('PIDController_d3','SimulationMode','normal');
    
    set_param('PIDController_theta1/motor1/Integrator','InitialCondition',num2str(theta1));
     set_param('PIDController_theta2/motor2/Integrator','InitialCondition',num2str(theta2));
     set_param('PIDController_d3/motor3/Integrator','InitialCondition',num2str(d3));
     set_param('PIDController_theta4/motor4/Integrator','InitialCondition',num2str(theta4));

    fixed_step_size = t_theta1(end)/step;
    set_param('PIDController_theta1', 'Solver', 'ode5', 'FixedStep', num2str(fixed_step_size));
    set_param('PIDController_theta1','StopTime',num2str(t_theta1(end)));
    set_param('PIDController_theta1','SimulationCommand','start');

     fixed_step_size = t_theta2(end)/step;
    set_param('PIDController_theta2', 'Solver', 'ode5', 'FixedStep', num2str(fixed_step_size));
    set_param('PIDController_theta2','StopTime',num2str(t_theta2(end)));
    set_param('PIDController_theta2','SimulationCommand','start');

     fixed_step_size = t_theta4(end)/step;
    set_param('PIDController_theta4', 'Solver', 'ode5', 'FixedStep', num2str(fixed_step_size));
    set_param('PIDController_theta4','StopTime',num2str(t_theta4(end)));
    set_param('PIDController_theta4','SimulationCommand','start');

     fixed_step_size = t_d3(end)/step;
    set_param('PIDController_d3', 'Solver', 'ode5', 'FixedStep', num2str(fixed_step_size));
    set_param('PIDController_d3','StopTime',num2str(t_d3(end)));
    set_param('PIDController_d3','SimulationCommand','start');
    
    q_theta1_PV = evalin('base','q_theta1out');
    q_theta2_PV = evalin('base','q_theta2out');
    q_theta4_PV = evalin('base','q_theta4out');
    q_d3_PV = evalin('base','q_d3out');

    v_theta1_PV = evalin('base','v_theta1out');
    v_theta2_PV = evalin('base','v_theta2out');
    v_theta4_PV = evalin('base','v_theta4out');
    v_d3_PV = evalin('base','v_d3out');

   
    a_theta1_PV = evalin('base','a_theta1out');
    a_theta2_PV = evalin('base','a_theta2out');
    a_theta4_PV = evalin('base','a_theta4out');
    a_d3_PV = evalin('base','a_d3out');
    
     j_theta1_PV = evalin('base','j_theta1out');
    j_theta2_PV = evalin('base','j_theta2out');
    j_theta4_PV = evalin('base','j_theta4out');
    j_d3_PV = evalin('base','j_d3out');

 for i=1:step
    
     % Vẽ quỹ đạo Trajactory effector
% DrawRobot(theta1_a(i),theta2_a(i),d3_a(i),theta4_a(i),handles);
  Plot_qva(q,v,a,J,t,i,handles.q,handles.v,handles.a,'b');
% Vẽ quỹ đạo Trajactory các khớp
  Plot_qva(q_theta1,v_theta1,a_theta1,J_theta1,t_theta1,i,handles.q_Theta1,handles.v_Theta1,handles.a_Theta1,'b');
  Plot_qva(q_theta2,v_theta2,a_theta2,J_theta2,t_theta2,i,handles.q_Theta2,handles.v_Theta2,handles.a_Theta2,'b');
  Plot_qva(q_d3,v_d3,a_d3,J_d3,t_d3,i,handles.q_d3,handles.v_d3,handles.a_d3,'b');
  Plot_qva(q_theta4,v_theta4,a_theta4,J_theta4,t_theta4,i,handles.q_Theta4,handles.v_Theta4,handles.a_Theta4,'b');

 end

    for i=1:step
    DrawRobot(theta1_a(i),theta2_a(i),d3_a(i),theta4_a(i),handles);
     % Vẽ quỹ đạo Trajactory effector
% DrawRobot(theta1_a(i),theta2_a(i),d3_a(i),theta4_a(i),handles);

  Plot_qva(q_theta1_PV,v_theta1_PV,a_theta1_PV,j_theta1_PV,t_theta1,i,handles.q_Theta1,handles.v_Theta1,handles.a_Theta1,'r');
  Plot_qva(q_theta2_PV,v_theta2_PV,a_theta2_PV,j_theta2_PV,t_theta2,i,handles.q_Theta2,handles.v_Theta2,handles.a_Theta2,'r');
  Plot_qva(q_d3_PV,v_d3_PV,a_d3_PV,j_d3_PV,t_d3,i,handles.q_d3,handles.v_d3,handles.a_d3,'r');
  Plot_qva(q_theta4_PV,v_theta4_PV,a_theta4_PV,j_theta4_PV,t_theta4,i,handles.q_Theta4,handles.v_Theta4,handles.a_Theta4,'r');
  
    pause(0.01)
    end
else
    for i=1:step
    DrawRobot(theta1_a(i),theta2_a(i),d3_a(i),theta4_a(i),handles);
     % Vẽ quỹ đạo Trajactory effector
% DrawRobot(theta1_a(i),theta2_a(i),d3_a(i),theta4_a(i),handles);
  Plot_qva(q,v,a,J,t,i,handles.q,handles.v,handles.a,'b');
% Vẽ quỹ đạo Trajactory các khớp
  Plot_qva(q_theta1,v_theta1,a_theta1,J_theta1,t_theta1,i,handles.q_Theta1,handles.v_Theta1,handles.a_Theta1,'b');
  Plot_qva(q_theta2,v_theta2,a_theta2,J_theta2,t_theta2,i,handles.q_Theta2,handles.v_Theta2,handles.a_Theta2,'b');
  Plot_qva(q_d3,v_d3,a_d3,J_d3,t_d3,i,handles.q_d3,handles.v_d3,handles.a_d3,'b');
  Plot_qva(q_theta4,v_theta4,a_theta4,J_theta4,t_theta4,i,handles.q_Theta4,handles.v_Theta4,handles.a_Theta4,'b');

    pause(0.01)
    end
end
