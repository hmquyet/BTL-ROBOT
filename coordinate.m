function coordinate(handles,x,y,z,Ox_Length,Oy_Length,Oz_Length,num,yaw)
% x,y,z: toa do bat dau cua he toa do
% x_dir, y_dir, z_dir: huong cua truc toa do tuong ung
% num: so thu tu cua he truc toa do
% vidu: 
% plot_coordinate(p0(1),p0(2),p0(3),1,1,1,0);
R=[ cos(yaw), -sin(yaw), 0;
    sin(yaw), cos(yaw), 0;
    0,          0       1];
hold on
axis1 = R*[Ox_Length ;         0;         0];
axis2 = R*[0         ; Oy_Length;         0];
axis3 = R*[0         ;         0; Oz_Length];

line(handles.axes1,[x x+axis1(1)],[y y+axis1(2)],[z z+axis1(3)],'linewidth',1.5,'color', 'red')
text(handles.axes1,x+axis1(1),y+axis1(2),z+axis1(3),(['x',num2str(num)]))

line(handles.axes1,[x x+axis2(1)],[y y+axis2(2)],[z z+axis2(3)],'linewidth',1.5,'color', 'green')
text(handles.axes1,x+axis2(1),y+axis2(2),z+axis2(3),(['y',num2str(num)]))

line(handles.axes1,[x x+axis3(1)],[y y+axis3(2)],[z z+axis3(3)],'linewidth',1.5,'color', 'blue')
text(handles.axes1,x+axis3(1),y+axis3(2),z+axis3(3),(['z',num2str(num)]))


% line(handles.axes1,[x x],[y y+0.2*y_dir],[z z],'linewidth',1.5,'color', 'green')
% text(handles.axes1,x,y+0.2*y_dir,z,(['y',num2str(num)]))
% 
% line(handles.axes1,[x x],[y y],[z z+0.2*z_dir],'linewidth',1.5,'color', 'blue')
% text(handles.axes1,x,y,z+0.2*z_dir,(['z',num2str(num)]))

end