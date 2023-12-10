function Plot_axes(handles)

 cla(handles.q,'reset');
    hold(handles.q,'on');
    grid(handles.q,'on');
    xlabel(handles.q,'t');
    ylabel(handles.q,'q');
    
    cla(handles.v,'reset');
    hold(handles.v,'on');
    grid(handles.v,'on');
    xlabel(handles.v,'t');
    ylabel(handles.v,'v');

    
    cla(handles.a,'reset');
    hold(handles.a,'on');
    grid(handles.a,'on');
    xlabel(handles.a,'t');
    ylabel(handles.a,'a');


%      cla(handles.j,'reset');
%     hold(handles.j,'on');
%     grid(handles.j,'on');
%     xlabel(handles.j,'t');
%     ylabel(handles.j,'j');

    %%%%% theta1
    cla(handles.q_Theta1,'reset');
    hold(handles.q_Theta1,'on');
    grid(handles.q_Theta1,'on');
    xlabel(handles.q_Theta1,'t');
    ylabel(handles.q_Theta1,'Px');
    
    cla(handles.v_Theta1,'reset');
    hold(handles.v_Theta1,'on');
    grid(handles.v_Theta1,'on');
    xlabel(handles.v_Theta1,'t');
    ylabel(handles.v_Theta1,'Py');

    
    cla(handles.a_Theta1,'reset');
    hold(handles.a_Theta1,'on');
    grid(handles.a_Theta1,'on');
    xlabel(handles.a_Theta1,'t');
    ylabel(handles.a_Theta1,'Pz');


%      cla(handles.j_Theta1,'reset');
%     hold(handles.j_Theta1,'on');
%     grid(handles.j_Theta1,'on');
%     xlabel(handles.j_Theta1,'t');
%     ylabel(handles.j_Theta1,'j');

 %%%%%Theta2
    cla(handles.q_Theta2,'reset');
    hold(handles.q_Theta2,'on');
    grid(handles.q_Theta2,'on');
    xlabel(handles.q_Theta2,'t');
    ylabel(handles.q_Theta2,'Px');
    
    cla(handles.v_Theta2,'reset');
    hold(handles.v_Theta2,'on');
    grid(handles.v_Theta2,'on');
    xlabel(handles.v_Theta2,'t');
    ylabel(handles.v_Theta2,'Py');

    
    cla(handles.a_Theta2,'reset');
    hold(handles.a_Theta2,'on');
    grid(handles.a_Theta2,'on');
    xlabel(handles.a_Theta2,'t');
    ylabel(handles.a_Theta2,'Pz');


%      cla(handles.j_Theta2,'reset');
%     hold(handles.j_Theta2,'on');
%     grid(handles.j_Theta2,'on');
%     xlabel(handles.j_Theta2,'t');
%     ylabel(handles.j_Theta2,'j');

     %%%%% d3
    cla(handles.q_d3,'reset');
    hold(handles.q_d3,'on');
    grid(handles.q_d3,'on');
    xlabel(handles.q_d3,'t');
    ylabel(handles.q_d3,'Px');
    
    cla(handles.v_d3,'reset');
    hold(handles.v_d3,'on');
    grid(handles.v_d3,'on');
    xlabel(handles.v_d3,'t');
    ylabel(handles.v_d3,'Py');

    
    cla(handles.a_d3,'reset');
    hold(handles.a_d3,'on');
    grid(handles.a_d3,'on');
    xlabel(handles.a_d3,'t');
    ylabel(handles.a_d3,'Pz');


%      cla(handles.j_d3,'reset');
%     hold(handles.j_d3,'on');
%     grid(handles.j_d3,'on');
%     xlabel(handles.j_d3,'t');
%     ylabel(handles.j_d3,'j');

     %%%%% theta4
    cla(handles.q_Theta4,'reset');
    hold(handles.q_Theta4,'on');
    grid(handles.q_Theta4,'on');
    xlabel(handles.q_Theta4,'t');
    ylabel(handles.q_Theta4,'Px');
    
    cla(handles.v_Theta4,'reset');
    hold(handles.v_Theta4,'on');
    grid(handles.v_Theta4,'on');
    xlabel(handles.v_Theta4,'t');
    ylabel(handles.v_Theta4,'Py');

    
    cla(handles.a_Theta4,'reset');
    hold(handles.a_Theta4,'on');
    grid(handles.a_Theta4,'on');
    xlabel(handles.a_Theta4,'t');
    ylabel(handles.a_Theta4,'Pz');

% 
%      cla(handles.j_Theta4,'reset');
%     hold(handles.j_Theta4,'on');
%     grid(handles.j_Theta4,'on');
%     xlabel(handles.j_Theta4,'t');
%     ylabel(handles.j_Theta4,'j');

end