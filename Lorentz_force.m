function Lorentz_F = Lorentz_force(x,y,z,vx,vy,vz,field_choice,A1,B1,C1,...
    lambda1,A2,B2,C2,lambda2,ratio,field_choice_vector)
    B_field = B_field_all(x,y,z,field_choice,A1,B1,C1,lambda1,...
        A2,B2,C2,lambda2,'false',field_choice_vector);
    velocity = [vx,vy,vz]/sqrt(vx^2 + vy^2 + vz^2);
    Lorentz_F = ratio*cross(velocity,B_field);
end