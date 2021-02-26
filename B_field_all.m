function magnetic = B_field_all(x,y,z,field_choice,A1,B1,C1,lambda1,...
    A2,B2,C2,lambda2,unit,field_choice_vector)
    % ABC field
    field_choice = string(field_choice).lower();
    unit = string(unit).lower();
    if contains(field_choice,'abc')
        x1Arg = lambda1*x;
        x1Arg = x1Arg - 2*pi*floor(x1Arg/(2*pi));
        y1Arg = lambda1*y;
        y1Arg = y1Arg - 2*pi*floor(y1Arg/(2*pi));
        z1Arg = lambda1*z;
        z1Arg = z1Arg - 2*pi*floor(z1Arg/(2*pi));
        Bx = A1*sin(z1Arg) + C1*cos(y1Arg);
        By = B1*sin(x1Arg) + A1*cos(z1Arg);
        Bz = C1*sin(y1Arg) + B1*cos(x1Arg);
    
    % ABC second order
		if contains(field_choice,'abc2')
			x2Arg = lambda2*x;
			x2Arg = x2Arg - 2*pi*floor(x2Arg/(2*pi));
			y2Arg = lambda2*y;
			y2Arg = y2Arg - 2*pi*floor(y2Arg/(2*pi));
			z2Arg = lambda2*z;
			z2Arg = z2Arg - 2*pi*floor(z2Arg/(2*pi));
			Bx = Bx + A2*sin(z2Arg) + C2*cos(y2Arg);
			By = By + B2*sin(x2Arg) + A2*cos(z2Arg);
			Bz = Bz + C2*sin(y2Arg) + B2*cos(x2Arg);
        end
    % Uniform
    elseif field_choice == 'uniform'
        Bx = 0;
        By = 0;
        Bz = 1;
    
    % Circular
    elseif field_choice == 'circular'
        rSq = x^2 + y^2;
        Bx = -y/rSq;
        By = x/rSq;
        Bz = 0;
    
    % Bar magnet
   
    elseif field_choice == 'bar'
        rSq = x^2 + y^2 + z^2;
        xRadius = 0.1;
        yRadius = 0.1;
        zRadius = 0.2;
        if abs(x) > xRadius || abs(y) > yRadius || abs(z) > zRadius
            Bx = 3*x*z/rSq^(5/2);
            By = 3*y*z/rSq^(5/2);
            Bz = (3*z^2/rSq - 1)/rSq^(3/2);
        else
            Bx = 0;
            By = 0;
            Bz = 1;
        end
    
    elseif field_choice == 'bessel'
        r = sqrt(x^2 + y^2);
        Bx = -y*besselj(1,lambda1*r)/r;
        By = x*besselj(1,lambda1*r)/r;
        Bz = besselj(0,lambda1*r);
        
    % Superimposes many magnetic fields
    elseif field_choice == 'multiple'
        field_choice_string_vector = ["abc","abc2","uniform","circular","bar","bessel"];
        magnetic = [0,0,0];
        for i = 1:length(field_choice_vector)
            if field_choice_vector(i) ~= 0
                magnetic = magnetic + field_choice_vector(i)*B_field_all(x,y,z,...
                    field_choice_string_vector(i),A1,B1,C1,lambda1,...
                    A2,B2,C2,lambda2,'false');
            end
        end
        Bx = magnetic(1); By = magnetic(2); Bz = magnetic(3);
    end
    magnetic = [Bx,By,Bz];
    if unit == 'true'
        magnetic = magnetic/norm(magnetic);
    end
end