function Inverse(handles)
% Update_data
a1     = 20;
a2     = 30;
d4     = 0;

x      = str2num(get(handles.edit_set_x,'String'));
y      = str2num(get(handles.edit_set_y,'String'));
z      = str2num(get(handles.edit_set_z,'String'));
yaw    = str2num(get(handles.edit_set_yaw,'String'))*pi/180;

d3     = str2num(get(handles.edit_d3,'String'))
theta1 = str2num(get(handles.edit_theta1,'String'))
theta2 = str2num(get(handles.edit_theta2,'String'))
theta4 = str2num(get(handles.edit_theta4,'String'))


d3_new = -z + d4;
theta2_new =  acos( (x^2 + y^2 - a1^2 - a2^2)/(2*a1*a2));
c1 = (x*(a1 + a2*cos(theta2_new)) + y*a2*sin(theta2_new))/(x^2 + y^2);
s1 = (y*(a1 + a2*cos(theta2_new)) - x*a2*sin(theta2_new))/(x^2 + y^2);
theta1_new = atan2(s1,c1);
theta4_new = yaw - theta1_new - theta2_new;


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



set(handles.edit_theta1,'String',theta1_new*180/pi);
set(handles.edit_theta2,'String',theta2_new*180/pi);
set(handles.edit_d3,'String',d3_new);
set(handles.edit_theta4,'String',theta4_new*180/pi);

  
theta1_a=linspace(theta1,theta1_new*180/pi,20); 
theta2_a=linspace(theta2,theta2_new*180/pi,20);
theta4_a=linspace(theta4,theta4_new*180/pi,20);
d3_a=linspace(d3,d3_new,20);

for i=1:50
 
 DrawRobot(theta1_a(i),theta2_a(i),d3_a(i),theta4_a(i),handles)
pause(0.01);
end




