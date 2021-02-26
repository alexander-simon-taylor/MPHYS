function starting_matrix = starting_matrix_fun(x0,y0,z0,radius,iterations,output,sqrt_num_starting_points)
    output = string(output); output = output.lower();
    if contains(output,'chaos') || contains(output,'recurrence') ||...
            contains(output,'endpoints') || contains(output,'energy') ||...
            contains(output,'multiple') || contains(output,'error')
		starting_matrix = sm1p(x0,y0,z0,radius,iterations);
    elseif contains(output,"slice") || contains(output,"histogram") ||...
            contains(output,"path")
        starting_matrix = [x0,y0,z0];
	elseif contains(output,'lyapunov')
		starting_matrix_3D = zeros(iterations,3,sqrt_num_starting_points^2);
        if contains(output,'region')
            starting_linspace = linspace(x0,y0,sqrt_num_starting_points);
        else
            starting_linspace = linspace(0,2*pi,sqrt_num_starting_points);
        end
		a = 1;
		for x = starting_linspace
			for y = starting_linspace
				starting_matrix_3D(:,:,a) = sm1p(x,y,z0,radius,iterations);
				a = a + 1;
			end
		end
		starting_matrix = zeros(iterations*sqrt_num_starting_points^2,3);
		i = 1:sqrt_num_starting_points^2;
		j = (i-1)*iterations + 1;
		for k = 1:length(j)
			starting_matrix(j(k):j(k) + iterations - 1,:) = starting_matrix_3D(:,:,k);
		end
    end
end