function Plot_qva(q,v,a,J,t,i,handles_axes_q,handles_axes_v,handles_axes_a,color)

        plot(handles_axes_q,t(1:i), q(1:i), color,'LineWidth', 1.25);
        xlabel(handles_axes_q,'t');
        ylabel(handles_axes_q,'q');
        grid (handles_axes_q, 'on');
        hold(handles_axes_q, 'on');
   
     
        
%         drawnow;  % Cập nhật đồ thị

        plot(handles_axes_v,t(1:i), v(1:i), color,'LineWidth', 1.25);
        xlabel(handles_axes_v,'t');
        ylabel(handles_axes_v,'v');
         grid (handles_axes_v, 'on');
        hold(handles_axes_v, 'on');
       
       
        
%         drawnow;  % Cập nhật đồ thị

        plot(handles_axes_a,t(1:i), a(1:i), color,'LineWidth', 1.25);
        xlabel(handles_axes_a,'t');
        ylabel(handles_axes_a,'a');
        grid (handles_axes_a, 'on');
         hold(handles_axes_a, 'on');
       
         
%         drawnow;  % Cập nhật đồ thị

%         plot(handles_axes_J,t(1:i),  J(1:i), color,'LineWidth', 2);
%         xlabel(handles_axes_J,'t');
%         ylabel(handles_axes_J,'j');
%          hold(handles_axes_J, 'on');
      
        
%         drawnow;  % Cập nhật đồ thị

end