function  Forward(handles)
global end_theta1;
global end_theta2 ;
global end_d3 ; 
global end_theta4;

global pre_theta1;
global pre_theta2;
global pre_d3;
global pre_theta4; 

    end_d3    = get(handles.edit_d3,'Value');
    end_theta1 = get(handles.edit_theta1,'Value');
    end_theta2 = get(handles.edit_theta2,'Value');
    end_theta4 = get(handles.edit_theta4,'Value');

    theta1 = linspace(pre_theta1,end_theta1,20);
    theta2 = linspace(pre_theta2,end_theta2,20);
    theta4 = linspace(pre_theta4,end_theta4,20);
    d3 = linspace(pre_d3, end_d3, 20);

%     pre_theta1 = end_theta1;
%     pre_theta2 =end_theta2;
%     pre_d3 = end_d3;
%     pre_theta4 = end_theta4;

for i = 1:50

    DrawRobot(theta1(i),theta2(i),d3(i),theta4(i),handles)
    pause(0.01)
end
end