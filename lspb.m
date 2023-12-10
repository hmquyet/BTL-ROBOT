function [q, v, a, J,t] = lspb(q_max, v_max, a_max,init_q)
global step;
if(q_max>0)
if v_max > sqrt(q_max*a_max)
   
    v_max = sqrt(q_max*a_max);
end

tc = v_max/a_max;
qc = 1/2*a_max*tc^2;
t_m = (q_max-2*qc)/v_max;
tf = 2*tc+t_m;

    t = linspace(0, tf, step);

    q = zeros(size(t));
    v = zeros(size(t));
    a = zeros(size(t));
    J = zeros(size(t));

    for i=1:length(t)
        if t(i)<tc
            q(i)=1/2*a_max*t(i)^2;
            v(i) = a_max*t(i);
            a(i) = a_max;
            J(i)=0;
        elseif t(i)<tc+t_m
            q(i) = qc + v_max*(t(i)-tc);
            v(i) = v_max;
            a(i) = 0;
            J(i)=0;
        else
            q(i) = q_max - 1/2*a_max*(tf-t(i))^2;
            v(i) = a_max*(tf-t(i));
            a(i) = -a_max;
            J(i)=0;
        end
        q(i)=init_q+q(i);
    end
    
else
    q_max=abs(q_max);

    if v_max > sqrt(q_max*a_max)
    v_max = sqrt(q_max*a_max);
    end

tc = v_max/a_max;
qc = 1/2*a_max*tc^2;
t_m = (q_max-2*qc)/v_max;
tf = 2*tc+t_m;

    t = linspace(0, tf, step);

    q = zeros(size(t));
    v = zeros(size(t));
    a = zeros(size(t));
    J = zeros(size(t));

    for i=1:length(t)
        if t(i)<tc
            q(i)=-1/2*a_max*t(i)^2;
            v(i) =-a_max*t(i);
            a(i) = -a_max;
            J(i)=0;
        elseif t(i)<tc+t_m
            q(i) = -(qc + v_max*(t(i)-tc));
            v(i) = -v_max;
            a(i) = 0;
            J(i)=0;
        else
            q(i) =- (q_max - 1/2*a_max*(tf-t(i))^2);
            v(i) =- (a_max*(tf-t(i)));
            a(i) = a_max;
            J(i)=0;
        end
         q(i)=init_q+q(i);
    end
end


end
