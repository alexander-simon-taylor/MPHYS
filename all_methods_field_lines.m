function rnew = all_methods_field_lines(x,y,z,field_choice,method_choice,...
    A1,B1,C1,lambda1,A2,B2,C2,lambda2,ds,field_choice_vector)

r = [x,y,z];
field_choice = string(field_choice);
method_choice = string(method_choice);
% Euler method
if method_choice.lower() == 'euler'
    UnitB = B_field_all(x,y,z,field_choice,A1,B1,C1,lambda1,A2,B2,C2,lambda2,'true',field_choice_vector);
    rnew = r + ds*UnitB;

% Improved Euler method
elseif method_choice.lower() == 'improved euler'
    UnitB = B_field_all(x,y,z,field_choice,A1,B1,C1,lambda1,A2,B2,C2,lambda2,'true',field_choice_vector);
    UnitB2 = B_field_all(x + ds*UnitB(1),y + ds*UnitB(2),z + ds*UnitB(3),field_choice,A1,B1,C1,lambda1,A2,B2,C2,lambda2,'true',field_choice_vector);
    rnew = r + ds*(UnitB + UnitB2)/2;

% RK4
elseif method_choice.lower() == 'rk4'
    k1 = ds*B_field_all(x,y,z,field_choice,A1,B1,C1,lambda1,A2,B2,C2,lambda2,'true',field_choice_vector);
    k2 = ds*B_field_all(x + k1(1)/2,y + k1(2)/2,z + k1(3)/2,field_choice,A1,B1,C1,lambda1,A2,B2,C2,lambda2,'true',field_choice_vector);
    k3 = ds*B_field_all(x + k2(1)/2,y + k2(2)/2,z + k2(3)/2,field_choice,A1,B1,C1,lambda1,A2,B2,C2,lambda2,'true',field_choice_vector);
    k4 = ds*B_field_all(x + k3(1),y + k3(2),z + k3(3),field_choice,A1,B1,C1,lambda1,A2,B2,C2,lambda2,'true',field_choice_vector);
    rnew = r + (k1 + 2*k2 + 2*k3 + k4)/6;
    
% RK6
elseif method_choice.lower() == 'rk6'
    k1 = ds*B_field_all(x,y,z,field_choice,A1,B1,C1,lambda1,A2,B2,C2,lambda2,'true',field_choice_vector);
    
    k2 = ds*B_field_all(x + k1(1),y + k1(2),z + k1(3),field_choice,A1,B1,C1,lambda1,A2,B2,C2,lambda2,'true',field_choice_vector);
    
    k3 = ds*B_field_all(x + (3*k1(1) + k2(1))/8,y + (3*k1(2) + k2(2))/8,z + (3*k1(3) + k2(3))/8,field_choice,A1,B1,C1,lambda1,A2,B2,C2,lambda2,'true',field_choice_vector);
    
    k4 = ds*B_field_all(x + (8*k1(1) + 2*k2(1) + 8*k3(1))/27,y + (8*k1(2) + 2*k2(2) + 8*k3(2))/27,z + (8*k1(3) + 2*k2(3) + 8*k3(3))/27,field_choice,A1,B1,C1,lambda1,A2,B2,C2,lambda2,'true',field_choice_vector);
    
    k5 = ds*B_field_all(x + (3*(3*sqrt(21) - 7)*k1(1) - 8*(7 - sqrt(21))*k2(1) + 48*(7 - sqrt(21))*k3(1) - 3*(21 - sqrt(21))*k4(1))/392,...
        y + (3*(3*sqrt(21) - 7)*k1(2) - 8*(7 - sqrt(21))*k2(2) + 48*(7 - sqrt(21))*k3(2) - 3*(21 - sqrt(21))*k4(2))/392,...
        z + (3*(3*sqrt(21) - 7)*k1(3) - 8*(7 - sqrt(21))*k2(3) + 48*(7 - sqrt(21))*k3(3) - 3*(21 - sqrt(21))*k4(3))/392,field_choice,A1,B1,C1,lambda1,A2,B2,C2,lambda2,'true',field_choice_vector);
    
    k6 = ds*B_field_all(x + (-5*(231 + 51*sqrt(21))*k1(1) - 40*(7 + sqrt(21))*k2(1) - 320*sqrt(21)*k3(1) + 3*(21 + 121*sqrt(21))*k4(1) + 392*(6 + sqrt(21))*k5(1))/1960,...
        y + (-5*(231 + 51*sqrt(21))*k1(2) - 40*(7 + sqrt(21))*k2(2) - 320*sqrt(21)*k3(2) + 3*(21 + 121*sqrt(21))*k4(2) + 392*(6 + sqrt(21))*k5(2))/1960,...
        z + (-5*(231 + 51*sqrt(21))*k1(3) - 40*(7 + sqrt(21))*k2(3) - 320*sqrt(21)*k3(3) + 3*(21 + 121*sqrt(21))*k4(3) + 392*(6 + sqrt(21))*k5(3))/1960,field_choice,A1,B1,C1,lambda1,A2,B2,C2,lambda2,'true',field_choice_vector);
    
    k7 = ds*B_field_all(x + (15*(22 + 7*sqrt(21))*k1(1) + 120*k2(1) + 40*(7*sqrt(21) - 5)*k3(1) - 63*(3*sqrt(21) - 2)*k4(1) - 14*(49 + 9*sqrt(21))*k5(1) + 70*(7 - sqrt(21))*k6(1))/180,...
        y + (15*(22 + 7*sqrt(21))*k1(2) + 120*k2(2) + 40*(7*sqrt(21) - 5)*k3(2) - 63*(3*sqrt(21) - 2)*k4(2) - 14*(49 + 9*sqrt(21))*k5(2) + 70*(7 - sqrt(21))*k6(2))/180,...
        z + (15*(22 + 7*sqrt(21))*k1(3) + 120*k2(3) + 40*(7*sqrt(21) - 5)*k3(3) - 63*(3*sqrt(21) - 2)*k4(3) - 14*(49 + 9*sqrt(21))*k5(3) + 70*(7 - sqrt(21))*k6(3))/180,field_choice,A1,B1,C1,lambda1,A2,B2,C2,lambda2,'true',field_choice_vector);
    
    rnew = r + (9*k1 + 64*k3 + 49*k5 + 49*k6 + 9*k7)/180;
end
end