    function Workspace(handles)
    opacity = 0.5;
    % opacity = get(handles.slider_opacity,'Value');
    % R=178.05
    x = 0;
    y = 0;
    r = 17.805;
    hgt1 = -15;
    th = (-180*pi):pi/100:(180*pi);
    a = r*cos(th);
    b = r*sin(th);
    surf(handles.axes1,[a; a]+x, [b; b]+y, [ones(1,size(th,2)); zeros(1,size(th,2))]*hgt1, 'FaceColor',[151 255 255]/255, 'EdgeColor','none','FaceAlpha',opacity);
  
    fill3(handles.axes1,a , b , hgt1*ones(1,size(th,2)),[255 174 185]/255,'FaceAlpha',opacity);
    fill3(handles.axes1,a , b , 0*ones(1,size(th,2)) ,[255 174 185]/255,'FaceAlpha',opacity);
    
    % R=500
    x = 0;
    y = 0;
    r = 50;
    hgt1 = -15;
    th = (-125/180*pi):pi/100:(125/180*pi);
    a = r*cos(th);
    b = r*sin(th);
    surf(handles.axes1,[a; a]+x, [b; b]+y, [ones(1,size(th,2)); zeros(1,size(th,2))]*hgt1, 'FaceColor',[151 255 255]/255, 'EdgeColor','none','FaceAlpha',opacity);
   
    fill3(handles.axes1,a , b , hgt1*ones(1,size(th,2)) ,[255 174 185]/255,'FaceAlpha',opacity);
    fill3(handles.axes1,a , b , 0*ones(1,size(th,2)) ,[255 174 185]/255,'FaceAlpha',opacity);
    

    % R300_1
    phi = 145; %goc quay
    th = ((-phi-125)*pi/180):pi/100:(-125*pi/180);
    hgt1 = -15;
    r1 = 20;
    r2 = 30;
    a = r1*cos(-125*pi/180)+r2*cos(th);
    b = r1*sin(-125*pi/180)+r2*sin(th);
    surf(handles.axes1,[a; a]+x, [b; b]+y, [ones(1,size(th,2)); zeros(1,size(th,2))]*hgt1, 'FaceColor',[151 255 255]/255, 'EdgeColor','none','FaceAlpha',opacity);
 
    fill3(handles.axes1,a , b , hgt1*ones(1,size(th,2)) ,[255 174 185]/255,'FaceAlpha',opacity);
    fill3(handles.axes1,a , b , 0*ones(1,size(th,2)) ,[255 174 185]/255,'FaceAlpha',opacity);
   
    % R300_2
    phi = 145;
    th = ((125)*pi/180):pi/100:((phi+125)*pi/180);
    hgt1 = -15;
    r1 = 20;
    r2 = 30;
    a = r1*cos(-235*pi/180)+r2*cos(th);
    b = r1*sin(-235*pi/180)+r2*sin(th);
    surf(handles.axes1,[a; a]+x, [b; b]+y, [ones(1,size(th,2)); zeros(1,size(th,2))]*hgt1, 'FaceColor',[151 255 255]/255, 'EdgeColor','none','FaceAlpha',opacity);
  
    fill3(handles.axes1,a , b , hgt1*ones(1,size(th,2)) ,[255 174 185]/255,'FaceAlpha',opacity);
    fill3(handles.axes1,a , b , 0*ones(1,size(th,2)) ,[255 174 185]/255,'FaceAlpha',opacity);
    
