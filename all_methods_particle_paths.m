function p_new = all_methods_particle_paths(x,y,z,vx,vy,vz,field_choice,method_choice,...
    A1,B1,C1,lambda1,A2,B2,C2,lambda2,ds,ratio,field_choice_vector)

r = [x,y,z];
v = [vx,vy,vz];
field_choice = string(field_choice).lower();
method_choice = string(method_choice).lower();
% Euler method
if method_choice.lower() == 'euler'
    acceleration = Lorentz_force(x,y,z,vx,vy,vz,field_choice,A1,B1,C1,lambda1,A2,B2,C2,lambda2,ratio,field_choice_vector);
    vnew = v + ds*acceleration;
    rnew = r + ds*v;
    p_new = [rnew,vnew];

% Improved Euler method
elseif method_choice.lower() == 'improved euler'
    rnew = r + ds*v + ds^2*Lorentz_force(x,y,z,vx,vy,vz,field_choice,A1,B1,C1,lambda1,A2,B2,C2,lambda2,ratio)/2;
    k1 = ds*Lorentz_force(x,y,z,vx,vy,vz,field_choice,A1,B1,C1,lambda1,A2,B2,C2,lambda2,ratio,field_choice_vector);
    k2 = ds*Lorentz_force(x + ds*vx,y + ds*vy,z + ds*vz,vx + k1(1),vy + k1(2),vz + k1(3)...
        ,field_choice,A1,B1,C1,lambda1,A2,B2,C2,lambda2,ratio,field_choice_vector);
    vnew = v + (k1 + k2)/2;
    p_new = [rnew,vnew];

% RK4. q here corresponds to position, k to velocity.
elseif method_choice.lower() == 'rk4'
    q1 = ds*v;
    k1 = ds*Lorentz_force(x,y,z,vx,vy,vz,field_choice,A1,B1,C1,lambda1,A2,B2,C2,lambda2,ratio,field_choice_vector);
    
    q2 = [vx + k1(1)/2,vy + k1(2)/2,vz + k1(3)/2];
    k2 = ds*Lorentz_force(x + q1(1)/2,y + q1(2)/2,z + q1(3)/2,q2(1),q2(2),q2(3),...
        field_choice,A1,B1,C1,lambda1,A2,B2,C2,lambda2,ratio,field_choice_vector);
    q2 = ds*q2;
    
    q3 = [vx + k2(1)/2,vy + k2(2)/2,vz + k2(3)/2];
    k3 = ds*Lorentz_force(x + q2(1)/2,y + q2(2)/2,z + q2(3)/2,q3(1),q3(2),q3(3),...
        field_choice,A1,B1,C1,lambda1,A2,B2,C2,lambda2,ratio,field_choice_vector);
    q3 = ds*q3;
    
    q4 = [vx + k3(1),vy + k3(2),vz + k3(3)];
    k4 = ds*Lorentz_force(x + q3(1),y + q3(2),z + q3(3),q4(1),q4(2),q4(3),...
        field_choice,A1,B1,C1,lambda1,A2,B2,C2,lambda2,ratio,field_choice_vector);
    q4 = ds*q4;
    
    vnew = v + (k1 + 2*k2 + 2*k3 + k4)/6;
    rnew = r + (q1 + 2*q2 + 2*q3 + q4)/6;
    p_new = [rnew,vnew];
    
% RK6. q here corresponds to position, k to velocity.
elseif method_choice.lower() == 'rk6'
    q1 = ds*v;
    k1 = ds*Lorentz_force(x,y,z,vx,vy,vz,field_choice,A1,B1,C1,lambda1,A2,B2,C2,lambda2,ratio,field_choice_vector);
    
    q2 = [vx + k1(1),vy + k1(2),vz + k1(3)];
    k2 = ds*Lorentz_force(x + q1(1),y + q1(2),z + q1(3),q2(1),q2(2),q2(3),...
        field_choice,A1,B1,C1,lambda1,A2,B2,C2,lambda2,ratio,field_choice_vector);
    q2 = ds*q2;
    
    q3 = [vx + (3*k1(1) + k2(1))/8,vy + (3*k1(2) + k2(2))/8,vz + (3*k1(3) + k2(3))/8];
    k3 = ds*Lorentz_force(x + (3*q1(1) + q2(1))/8,y + (3*q1(2) + q2(2))/8,z + (3*q1(3) + q2(3))/8,...
        q3(1),q3(2),q3(3),field_choice,A1,B1,C1,lambda1,A2,B2,C2,lambda2,ratio,field_choice_vector);
    q3 = ds*q3;
    
    q4 = [vx + (8*k1(1) + 2*k2(1) + 8*k3(1))/27,vy + (8*k1(2) + 2*k2(2) + 8*k3(2))/27,vz + (8*k1(3) + 2*k2(3) + 8*k3(3))/27];
    k4 = ds*Lorentz_force(x + (8*q1(1) + 2*q2(1) + 8*q3(1))/27,y + (8*q1(2) + 2*q2(2) + 8*q3(2))/27,z + (8*q1(3) + 2*q2(3) + 8*q3(3))/27,...
        q4(1),q4(2),q4(3),field_choice,A1,B1,C1,lambda1,A2,B2,C2,lambda2,ratio,field_choice_vector);
    q4 = ds*q4;
    
    q5 = [vx + (3*(3*sqrt(21) - 7)*k1(1) - 8*(7 - sqrt(21))*k2(1) + 48*(7 - sqrt(21))*k3(1) - 3*(21 - sqrt(21))*k4(1))/392,...
        vy + (3*(3*sqrt(21) - 7)*k1(2) - 8*(7 - sqrt(21))*k2(2) + 48*(7 - sqrt(21))*k3(2) - 3*(21 - sqrt(21))*k4(2))/392,...
        vz + (3*(3*sqrt(21) - 7)*k1(3) - 8*(7 - sqrt(21))*k2(3) + 48*(7 - sqrt(21))*k3(3) - 3*(21 - sqrt(21))*k4(3))/392];
    k5 = ds*Lorentz_force(x + (3*(3*sqrt(21) - 7)*q1(1) - 8*(7 - sqrt(21))*q2(1) + 48*(7 - sqrt(21))*q3(1) - 3*(21 - sqrt(21))*q4(1))/392,...
        y + (3*(3*sqrt(21) - 7)*q1(2) - 8*(7 - sqrt(21))*q2(2) + 48*(7 - sqrt(21))*q3(2) - 3*(21 - sqrt(21))*q4(2))/392,...
        z + (3*(3*sqrt(21) - 7)*q1(3) - 8*(7 - sqrt(21))*q2(3) + 48*(7 - sqrt(21))*q3(3) - 3*(21 - sqrt(21))*q4(3))/392,...
        q5(1),q5(2),q5(3),field_choice,A1,B1,C1,lambda1,A2,B2,C2,lambda2,ratio,field_choice_vector);
    q5 = ds*q5;
    
    q6 = [vx + (-5*(231 + 51*sqrt(21))*k1(1) - 40*(7 + sqrt(21))*k2(1) - 320*sqrt(21)*k3(1) + 3*(21 + 121*sqrt(21))*k4(1) + 392*(6 + sqrt(21))*k5(1))/1960,...
        vy + (-5*(231 + 51*sqrt(21))*k1(2) - 40*(7 + sqrt(21))*k2(2) - 320*sqrt(21)*k3(2) + 3*(21 + 121*sqrt(21))*k4(2) + 392*(6 + sqrt(21))*k5(2))/1960,...
        vz + (-5*(231 + 51*sqrt(21))*k1(3) - 40*(7 + sqrt(21))*k2(3) - 320*sqrt(21)*k3(3) + 3*(21 + 121*sqrt(21))*k4(3) + 392*(6 + sqrt(21))*k5(3))/1960];
    k6 = ds*Lorentz_force(x + (-5*(231 + 51*sqrt(21))*q1(1) - 40*(7 + sqrt(21))*q2(1) - 320*sqrt(21)*q3(1) + 3*(21 + 121*sqrt(21))*q4(1) + 392*(6 + sqrt(21))*q5(1))/1960,...
        y + (-5*(231 + 51*sqrt(21))*q1(2) - 40*(7 + sqrt(21))*q2(2) - 320*sqrt(21)*q3(2) + 3*(21 + 121*sqrt(21))*q4(2) + 392*(6 + sqrt(21))*q5(2))/1960,...
        z + (-5*(231 + 51*sqrt(21))*q1(3) - 40*(7 + sqrt(21))*q2(3) - 320*sqrt(21)*q3(3) + 3*(21 + 121*sqrt(21))*q4(3) + 392*(6 + sqrt(21))*q5(3))/1960,...
        q6(1),q6(2),q6(3),field_choice,A1,B1,C1,lambda1,A2,B2,C2,lambda2,ratio,field_choice_vector);
    q6 = ds*q6;
    
    q7 = [vx + (15*(22 + 7*sqrt(21))*k1(1) + 120*k2(1) + 40*(7*sqrt(21) - 5)*k3(1) - 63*(3*sqrt(21) - 2)*k4(1) - 14*(49 + 9*sqrt(21))*k5(1) + 70*(7 - sqrt(21))*k6(1))/180,...
        vy + (15*(22 + 7*sqrt(21))*k1(2) + 120*k2(2) + 40*(7*sqrt(21) - 5)*k3(2) - 63*(3*sqrt(21) - 2)*k4(2) - 14*(49 + 9*sqrt(21))*k5(2) + 70*(7 - sqrt(21))*k6(2))/180,...
        vz + (15*(22 + 7*sqrt(21))*k1(3) + 120*k2(3) + 40*(7*sqrt(21) - 5)*k3(3) - 63*(3*sqrt(21) - 2)*k4(3) - 14*(49 + 9*sqrt(21))*k5(3) + 70*(7 - sqrt(21))*k6(3))/180];
    k7 = ds*Lorentz_force(x + (15*(22 + 7*sqrt(21))*q1(1) + 120*q2(1) + 40*(7*sqrt(21) - 5)*q3(1) - 63*(3*sqrt(21) - 2)*q4(1) - 14*(49 + 9*sqrt(21))*q5(1) + 70*(7 - sqrt(21))*q6(1))/180,...
        y + (15*(22 + 7*sqrt(21))*q1(2) + 120*q2(2) + 40*(7*sqrt(21) - 5)*q3(2) - 63*(3*sqrt(21) - 2)*q4(2) - 14*(49 + 9*sqrt(21))*q5(2) + 70*(7 - sqrt(21))*q6(2))/180,...
        z + (15*(22 + 7*sqrt(21))*q1(3) + 120*q2(3) + 40*(7*sqrt(21) - 5)*q3(3) - 63*(3*sqrt(21) - 2)*q4(3) - 14*(49 + 9*sqrt(21))*q5(3) + 70*(7 - sqrt(21))*q6(3))/180,...
        q7(1),q7(2),q7(3),field_choice,A1,B1,C1,lambda1,A2,B2,C2,lambda2,ratio,field_choice_vector);
    q7 = ds*q7;
    
    rnew = r + (9*q1 + 64*q3 + 49*q5 + 49*q6 + 9*q7)/180;
    vnew = v + (9*k1 + 64*k3 + 49*k5 + 49*k6 + 9*k7)/180;
    p_new = [rnew,vnew];
end
end