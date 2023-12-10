
function [q, v, a,Jerk, t] = Scurve(q_max, v_max, a_max, init_q)
%     v_max=10; 
%     a_max=10;
%     q_max=30;
global step;
if q_max>0
 if v_max > sqrt(q_max*a_max/2)
       v_max = sqrt(q_max*a_max/2);
 end
    
    t1 = v_max/a_max;
    t2 = 2*t1;
    t3 = q_max/v_max;
    t4 = t3 + t1;
    tf = t3 + t2;
    j = a_max/t1;

    t = linspace(0, tf, step);
    q = zeros(size(t));
    v = zeros(size(t));
    a = zeros(size(t));
    Jerk = zeros(size(t));
    for i = 1:length(t)
        if t(i) <= t1
            q(i) = j*t(i)^3/6;
            v(i) = j*t(i)^2/2;
            a(i) = j*t(i);
            Jerk(i)= j ;
        elseif t(i) <= t2
            q(i) = j*t1^3/6 + j*t1^2/2*(t(i)-t1) + a_max*(t(i)-t1)^2/2 - j*(t(i)-t1)^3/6;
            v(i) = j*t1^2/2 + a_max*(t(i)-t1) - j*(t(i)-t1)^2/2;
            a(i) = a_max - j*(t(i)-t1);
            Jerk(i)= -j ;
        elseif t(i) <= t3
            q(i) = a_max*t1^2 + v_max*(t(i)-t2);
            v(i) = v_max;
            a(i) = 0;
            Jerk(i)= 0 ;
        elseif t(i) <= t4
            q(i) = a_max*t1^2 + v_max*(t3-t2) + v_max*(t(i)-t3) - j*(t(i)-t3)^3/6;
            v(i) = v_max - j*(t(i)-t3)^2/2;
            a(i) = -j*(t(i)-t3);
            Jerk(i)= -j ;
        elseif t(i) <= tf
            q(i) = q_max - j*(tf - t(i))^3/6;
            v(i) = v_max - j*(t4-t3)^2/2 - a_max*(t(i)-t4) + j*(t(i)-t4)^2/2;
            a(i) = -a_max + j*(t(i)-t4);
            Jerk(i)= j ;
        end
        q(i)=init_q+q(i);
    end
else
    q_max =abs(q_max);

    if v_max > sqrt(q_max*a_max/2)
       v_max = sqrt(q_max*a_max/2);
    end
    
    t1 = v_max/a_max;
    t2 = 2*t1;
    t3 = q_max/v_max;
    t4 = t3 + t1;
    tf = t3 + t2;
    j = a_max/t1;

    t = linspace(0, tf, step);
    q = zeros(size(t));
    v = zeros(size(t));
    a = zeros(size(t));
    Jerk = zeros(size(t));
    for i = 1:length(t)
        if t(i) <= t1
            q(i) = -j*t(i)^3/6;
            v(i) = -j*t(i)^2/2;
            a(i) = -j*t(i);
            Jerk(i)= -j ;
        elseif t(i) <= t2
            q(i) =-( j*t1^3/6 + j*t1^2/2*(t(i)-t1) + a_max*(t(i)-t1)^2/2 - j*(t(i)-t1)^3/6);
            v(i) = -(j*t1^2/2 + a_max*(t(i)-t1) - j*(t(i)-t1)^2/2);
            a(i) = -(a_max - j*(t(i)-t1));
            Jerk(i)= j ;
        elseif t(i) <= t3
            q(i) = -(a_max*t1^2 + v_max*(t(i)-t2));
            v(i) = -v_max;
            a(i) = 0;
            Jerk(i)= 0 ;
        elseif t(i) <= t4
            q(i) = -(a_max*t1^2 + v_max*(t3-t2) + v_max*(t(i)-t3) - j*(t(i)-t3)^3/6);
            v(i) = -(v_max - j*(t(i)-t3)^2/2);
            a(i) = -(-j*(t(i)-t3));
            Jerk(i)= j ;
        elseif t(i) <= tf
            q(i) = -(q_max - j*(tf - t(i))^3/6);
            v(i) = -(v_max - j*(t4-t3)^2/2 - a_max*(t(i)-t4) + j*(t(i)-t4)^2/2);
            a(i) = -(-a_max + j*(t(i)-t4));
            Jerk(i)= -j ;
        end
         q(i)=init_q+q(i);
    end

end

   
end
%     plot(t,q);
%     hold on;
%     plot(t,v);
%     hold on;
%     plot(t,a);
%     hold on;
%     grid on;