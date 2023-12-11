function DrawRobot(theta1,theta2,d3,theta4,handles)
global path;
global step;
n = step;

a1=20;
a2=30;
d4=0;

% 
% global x;
% global y;
% global z;
% global yaw;

    set(handles.edit_theta1,'Value',theta1);
    set(handles.edit_theta1,'Value',theta2);
    set(handles.edit_d3,'Value',d3);
    set(handles.edit_theta4,'Value',theta4);
    
    global pre_theta1;
    global pre_theta2;
    global pre_d3;
    global pre_theta4; 

    pre_theta1=theta1;
    pre_theta2 =theta2;
    pre_d3=d3;
    pre_theta4=theta4;

cla(handles.axes1,'reset');
hold(handles.axes1,'on');
grid(handles.axes1,'on');

% Bảng DH
a     = [a1     ; a2     ; 0  ; 0     ];
alpha = [0      ; 0      ; 0  ; pi    ];
d     = [0      ; 0      ; -d3 ; d4   ];
theta = [theta1*pi/180 ; theta2*pi/180 ; 0  ; theta4*pi/180];

% Ma trận biến đổi thuần nhất của các Rf kế cạnh nhau
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
p4 = [A0_4(1,4) A0_4(2,4) A0_4(3,4)]; %3 vị trí x,y,z của effector
% Orientation
 o1 = Orientation(A0_1);
 o2 = Orientation(A0_2);
 o3 = Orientation(A0_3);
 o4 = Orientation(A0_4);

%Workspace

if  handles.checkbox_Coordinate.Value
  
    coordinate(handles,p0(1),p0(2),p0(3),20,20,20,0,0);
    coordinate(handles,p1(1),p1(2),p1(3),20,20,20,1,o1(3));
    coordinate(handles,p2(1),p2(2),p2(3),20,20,20,2,o2(3));
    coordinate(handles,p3(1),p3(2),p3(3),20,20,20,3,o3(3));
    coordinate(handles,p4(1),p4(2),p4(3),20,-20,-20,4,o4(3));

end

xlabel(handles.axes1,'x');
ylabel(handles.axes1,'y');
zlabel(handles.axes1,'z');
xlim(handles.axes1,[-100 100]);
ylim(handles.axes1,[-100 100]);
zlim(handles.axes1,[-50 100]);

%base
plot_base(handles);
%link1
plot_Link1(handles,o1(3),p0,p1)
%link2
plot_Link2(handles,o2(3),p1,p2)
%link3
plot_Link3(handles,o4(3),d3,p2,p3)

rotate3d(handles.axes1,'on')
view(handles.axes1,30,30);


[~, n] = size(path);
% append path
% them toa do x,y,z,yaw vao mang 'path'
path(1,n+1) = round(p4(1),3);
path(2,n+1) =  round(p4(2),3);
path(3,n+1) = round(p4(3),3);
path(4,n+1) = round(o4(3)*180/pi,3);

set(handles.text_x,'String',round(p4(1),3));
set(handles.text_y,'String',round(p4(2),3));
set(handles.text_z,'String',round(p4(3),3));

set(handles.text_roll,'String',round(o4(1)*(-180/pi),3));
set(handles.text_pitch,'String',round(o4(2)*(-180/pi),3));
set(handles.text_yaw,'String',round(o4(3)*180/pi,3));




% draw path
x = path(1,:);
y = path(2,:);
z = path(3,:);
yaw = path(4,:)  ;

plot3(handles.axes1,x,y,z,'LineWidth',2);

end

function plot_Link1(handles, yaw_d,p0,p1)
x0 = p0(1);
y0 = p0(2);
% L = a1 = chiều dài, W: chiều rộng, H: chiều cao

L=20;
%L = str2num(get(handles.edit_a1,'String')); % X

W=12;
H=10.1;

opacity=1;
%opacity = get(handles.slider_opacity,'Value');
Yaw = yaw_d-pi/2;

%
fill3(handles.axes1,[x0-W/2*cos(Yaw),x0+W/2*cos(Yaw),x0-L*sin(Yaw)+W/2*cos(Yaw),x0-L*sin(Yaw)-W/2*cos(Yaw)],[y0-W/2*sin(Yaw), y0+W/2*sin(Yaw), y0+L*cos(Yaw)+W/2*sin(Yaw), y0+L*cos(Yaw)-W/2*sin(Yaw)],[0, 0, 0, 0 ],[245, 161, 66]/255,'FaceAlpha',opacity)
fill3(handles.axes1,[x0-W/2*cos(Yaw),x0+W/2*cos(Yaw),x0-L*sin(Yaw)+W/2*cos(Yaw),x0-L*sin(Yaw)-W/2*cos(Yaw)],[y0-W/2*sin(Yaw), y0+W/2*sin(Yaw), y0+L*cos(Yaw)+W/2*sin(Yaw), y0+L*cos(Yaw)-W/2*sin(Yaw)],[H, H, H, H ],[245, 161, 66]/255,'FaceAlpha',opacity)

fill3(handles.axes1,[x0+W/2*cos(Yaw), x0+W/2*cos(Yaw)-L*sin(Yaw), x0+W/2*cos(Yaw)-L*sin(Yaw), x0+W/2*cos(Yaw)],[y0+W/2*sin(Yaw), y0+L*cos(Yaw)+W/2*sin(Yaw), y0+L*cos(Yaw)+W/2*sin(Yaw), y0+W/2*sin(Yaw)],[0, 0, H, H ],[245, 161, 66]/255,'FaceAlpha',opacity)
fill3(handles.axes1,[x0-W/2*cos(Yaw), x0-W/2*cos(Yaw)-L*sin(Yaw), x0-W/2*cos(Yaw)-L*sin(Yaw), x0-W/2*cos(Yaw)],[y0-W/2*sin(Yaw), y0+L*cos(Yaw)-W/2*sin(Yaw), y0+L*cos(Yaw)-W/2*sin(Yaw), y0-W/2*sin(Yaw)],[0, 0, H, H ],[245, 161, 66]/255,'FaceAlpha',opacity)

%
r = W/2;
hgt = H;
th=(pi+Yaw):pi/100:(2*pi+Yaw);
a=r*cos(th);
b=r*sin(th);

surf(handles.axes1,[a; a]+x0, [b; b]+y0, [ones(1,size(th,2))*0; ones(1,size(th,2))*hgt],'FaceColor',[245, 161, 66]/255, 'EdgeColor','none','FaceAlpha',opacity)
fill3(handles.axes1,a +x0, b+y0 , 0*ones(1,size(th,2))-0*ones(1,size(th,2)) ,[245, 161, 66]/255,'FaceAlpha',opacity);
fill3(handles.axes1,a+x0 , b+y0 , hgt*ones(1,size(th,2))-0*ones(1,size(th,2)),[245, 161, 66]/255,'FaceAlpha',opacity);

%

x1=p1(1);
y1=p1(2);
%z1=p1(3);
r = W/2;
hgt = H;
th=(0+Yaw):pi/100:(pi+Yaw);
a=r*cos(th);
b=r*sin(th);

surf(handles.axes1,[a; a]+x1, [b; b]+y1, [ones(1,size(th,2))*0; ones(1,size(th,2))*hgt],'FaceColor',[245, 161, 66]/255, 'EdgeColor','none','FaceAlpha',opacity)
fill3(handles.axes1,a+x1 , b+y1 , 0*ones(1,size(th,2))-0*ones(1,size(th,2)) ,[245, 161, 66]/255,'FaceAlpha',opacity);
fill3(handles.axes1,a+x1 , b+y1 , hgt*ones(1,size(th,2))-0*ones(1,size(th,2)),[245, 161, 66]/255,'FaceAlpha',opacity);



end

function plot_Link2(handles, yaw_d,p1,p2)

x1=p1(1);
y1=p1(2);
% L=a2
L=30;
%L = str2num(get(handles.edit_a2,'String'));
W = 12;
H_pre = 10.1; %do cao cua khoi truoc
H = 40; % do cao cua link2 22.15
opacity=1;
%opacity = get(handles.slider_opacity,'Value');
Yaw = yaw_d-pi/2;
%%
fill3(handles.axes1,[x1-W/2*cos(Yaw),x1+W/2*cos(Yaw),x1-L*sin(Yaw)+W/2*cos(Yaw),x1-L*sin(Yaw)-W/2*cos(Yaw)],[y1-W/2*sin(Yaw), y1+W/2*sin(Yaw), y1+L*cos(Yaw)+W/2*sin(Yaw), y1+L*cos(Yaw)-W/2*sin(Yaw)],[0+H_pre, 0+H_pre, 0+H_pre, 0+H_pre ],[245, 161, 66]/255,'FaceAlpha',opacity)
fill3(handles.axes1,[x1-W/2*cos(Yaw),x1+W/2*cos(Yaw),x1-L*sin(Yaw)+W/2*cos(Yaw),x1-L*sin(Yaw)-W/2*cos(Yaw)],[y1-W/2*sin(Yaw), y1+W/2*sin(Yaw), y1+L*cos(Yaw)+W/2*sin(Yaw), y1+L*cos(Yaw)-W/2*sin(Yaw)],[H, H, H, H ],[245, 161, 66]/255,'FaceAlpha',opacity)


fill3(handles.axes1,[x1+W/2*cos(Yaw), x1+W/2*cos(Yaw)-L*sin(Yaw), x1+W/2*cos(Yaw)-L*sin(Yaw), x1+W/2*cos(Yaw)],[y1+W/2*sin(Yaw), y1+L*cos(Yaw)+W/2*sin(Yaw), y1+L*cos(Yaw)+W/2*sin(Yaw), y1+W/2*sin(Yaw)],[0+H_pre, 0+H_pre, H, H ],[245, 161, 66]/255,'FaceAlpha',opacity)
fill3(handles.axes1,[x1-W/2*cos(Yaw), x1-W/2*cos(Yaw)-L*sin(Yaw), x1-W/2*cos(Yaw)-L*sin(Yaw), x1-W/2*cos(Yaw)],[y1-W/2*sin(Yaw), y1+L*cos(Yaw)-W/2*sin(Yaw), y1+L*cos(Yaw)-W/2*sin(Yaw), y1-W/2*sin(Yaw)],[0+H_pre, 0+H_pre, H, H ],[245, 161, 66]/255,'FaceAlpha',opacity)

%%

r = W/2;
hgt = H;
th=(pi+Yaw):pi/100:(2*pi+Yaw);
a=r*cos(th);
b=r*sin(th);

surf(handles.axes1,[a; a]+x1, [b; b]+y1, [ones(1,size(th,2))*H_pre; ones(1,size(th,2))*hgt],'FaceColor',[245, 161, 66]/255, 'EdgeColor','none','FaceAlpha',opacity,'edgecolor','none')
fill3(handles.axes1,a + x1 , b + y1, H_pre*ones(1,size(th,2))-0*ones(1,size(th,2)) ,[245, 161, 66]/255,'FaceAlpha',opacity);
fill3(handles.axes1,a + x1 , b + y1 , hgt*ones(1,size(th,2))-0*ones(1,size(th,2)),[245, 161, 66]/255,'FaceAlpha',opacity);

%%
x2 =p2(1);
y2 = p2(2);
th=(0+Yaw):pi/100:(pi+Yaw);
a=r*cos(th);
b=r*sin(th);

surf(handles.axes1,[a; a]+x2, [b; b]+y2, [ones(1,size(th,2))*(H_pre); ones(1,size(th,2))*hgt],'FaceColor',[245, 161, 66]/255, 'EdgeColor','none','FaceAlpha',opacity);
fill3(handles.axes1,a+x2 , b+y2 , H_pre*ones(1,size(th,2))-0*ones(1,size(th,2)) ,[245, 161, 66]/255,'FaceAlpha',opacity);
fill3(handles.axes1,a+x2 , b+y2 , hgt*ones(1,size(th,2))-0*ones(1,size(th,2)),[245, 161, 66]/255,'FaceAlpha',opacity);

end

function plot_Link3(handles,yaw_d,d3,p2,p3)
%  global T;
%     T = Forward(handles);
%% Trục tịnh tiến (phần giữa)
x3=p3(1);
y3=p3(2);
% bán kính trục
r = 2.5;
H = 50;
opacity=1;
%opacity = get(handles.slider_opacity,'Value');
th=0:pi/100:2*pi;
a=r*cos(th);
b=r*sin(th);

surf(handles.axes1,[a; a]+x3, [b; b]+y3, [ones(1,size(th,2))*-d3; ones(1,size(th,2))*(H-d3)], 'FaceColor',[46, 44, 42]/255, 'EdgeColor','none','FaceAlpha',opacity);
fill3(handles.axes1,a+x3 , b+y3 , -d3*ones(1,size(th,2)) ,[46, 44, 42]/255,'FaceAlpha',opacity);
fill3(handles.axes1,a+x3 , b+y3 , (H-d3)*ones(1,size(th,2)) ,[46, 44, 42]/255,'FaceAlpha',opacity);

%% end_effector
W = 15;
H_pre = -d3;
Yaw=yaw_d-pi/2;

r = W/2;
hgt = H_pre-1;
th=(pi+Yaw):pi/100:(2*pi+Yaw);
a=r*cos(th);
b=r*sin(th);

surf(handles.axes1,[a; a]+x3, [b; b]+y3, [ones(1,size(th,2))*H_pre; ones(1,size(th,2))*hgt],'FaceColor',[255,0,0 ]/255, 'EdgeColor','none','FaceAlpha',opacity,'edgecolor','none')
fill3(handles.axes1,a + x3 , b + y3, H_pre*ones(1,size(th,2))-0*ones(1,size(th,2)) ,[255,0,0]/255,'FaceAlpha',opacity);
fill3(handles.axes1,a + x3 , b + y3 , hgt*ones(1,size(th,2))-0*ones(1,size(th,2)),[255,0,0]/255,'FaceAlpha',opacity);


r = W/2;
hgt = H_pre-1;
th=(0+Yaw):pi/100:(pi+Yaw);
a=r*cos(th);
b=r*sin(th);

surf(handles.axes1,[a; a]+x3, [b; b]+y3, [ones(1,size(th,2))*H_pre; ones(1,size(th,2))*hgt],'FaceColor',[224, 206, 45]/255, 'EdgeColor','none','FaceAlpha',opacity,'edgecolor','none')
fill3(handles.axes1,a + x3 , b + y3, H_pre*ones(1,size(th,2))-0*ones(1,size(th,2)) ,[224, 206, 45]/255,'FaceAlpha',opacity);
fill3(handles.axes1,a + x3 , b + y3 , hgt*ones(1,size(th,2))-0*ones(1,size(th,2)),[224, 206, 45]/255,'FaceAlpha',opacity);




end

function plot_base(handles)


% base
x = 0;
y = 0;
r = 7.5;
% r = 0.15;
% kc đến gốc tạo độ
hgt1 = -28;
opacity=1;

% Đây là một vectơ góc (góc) từ 0 đến 2π được tạo để xác định các điểm trên đường viền của hình trụ. 
% Góc này sẽ được sử dụng để tính toán các điểm (x, y) trên bề mặt hình trụ.
th=0:pi/100:2*pi;
% mảng chứa các tọa độ x và y của các điểm trên đường biên của hình trụ. 
% tọa độ này được tính dựa trên bán kính r và góc th.
a=r*cos(th);
b=r*sin(th);

surf(handles.axes1,[a; a]+x(1), [b; b]+y(1), [ones(1,size(th,2)); zeros(1,size(th,2))]*hgt1, 'FaceColor',[245, 161, 66]/255, 'EdgeColor','none','FaceAlpha',opacity)
fill3(handles.axes1,a , b , 0*ones(1,size(th,2)) ,[245, 161, 66]/255,'FaceAlpha',opacity);
fill3(handles.axes1,a , b , hgt1*ones(1,size(th,2)) ,[245, 161, 66]/255,'FaceAlpha',opacity);


end
