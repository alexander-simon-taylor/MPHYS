function graph_title = title_text(x0,y0,z0,vx0,vy0,vz0,field_choice,...
            method_choice,A1,B1,C1,lambda1,A2,B2,C2,lambda2,ds,number,...
            output,radius,iterations,num_colours,number_of_sections,...
            position,radius_recurrence,sqrt_num_starting_points,ratio,field_choice_vector)
    field_choice = string(field_choice);
    method_choice = string(method_choice);
    output = string(output).lower();
    ABC1Text =[]; abc2orderText=[];
    lambda1Text =[]; lambda2Text=[];
    outputText = "The graph type here is " + output;
    methodText = "Method used is " + method_choice;
    BFieldText = "B field used is " + field_choice;
    startText = "(x_0, y_0, z_0) = (" + string(x0) + ", " + string(y0) + ", " + string(z0) + ")";
    stepSize = "The step size is " + string(ds);
    stepNumber = "The number of steps taken is " + string(number);
    iteration_text = "The number of points around the reference point is " + string(iterations);
    radius_text = "The radius of starting locations around the reference point is " + string(radius);
    graph_title = [outputText,methodText,BFieldText,startText,stepSize,stepNumber];
    if contains(field_choice,'multiple')
        multiple_title = "The vector of fields is (" + string(field_choice_vector(1));
        for i = 2:length(field_choice_vector)
            multiple_title = multiple_title + "," + string(field_choice_vector(i));
        end
        graph_title = [graph_title,multiple_title + ")"];
    end
    if contains(field_choice.lower(),"abc") | (field_choice_vector(1) ~= 0) ...
        | (field_choice_vector(2) ~= 0)
        ABC1Text = "(A_1, B_1, C_1) = (" + string(A1) + ", " + string(B1) + ", " + string(C1) + "), ";
        lambda1Text = "\lambda_1 = " + string(lambda1);
        graph_title = [graph_title,ABC1Text + lambda1Text];
        if contains(field_choice.lower(),"abc2") | field_choice_vector ~= 0
            abc2orderText = "(A_2, B_2, C_2) = (" + string(A2) + ", " + string(B2) + ", " + string(C2) + "), ";
            lambda2Text = "\lambda_2 = " + string(lambda2);
            graph_title = [graph_title,abc2orderText + lambda2Text];
        end
    end
    if contains(output.lower,"colour")
        colour_text = "The number of colours is " + string(num_colours);
        graph_title = [graph_title,colour_text];
    elseif contains(output,"chaos") || contains(output,"lyapunov") || contains(output,"endpoints")
        graph_title = [graph_title,iteration_text,radius_text];
        if output.lower() == "lyapunov"
            num_starts_text = "The number of starting locations is " + string(sqrt_num_starting_points^2);
            graph_title = [graph_title,num_starts_text];
        end
    elseif contains(output.lower(),"histogram")
        length_of_section = floor(number/number_of_sections);
        section_text = "There are " + string(number_of_sections) + ...
            " sections, each of length " + string(length_of_section);
        graph_title = [graph_title,section_text];
    elseif output.lower() == "recurrence"
        centre_text = "The centre of the recurrence sphere is ["...
            + string(position(1)) + "," + string(position(2)) + "," +...
            string(position(3)) + "]";
        radius_recurrence_text = "The radius of the recurrence sphere is " + string(radius_recurrence);
        graph_title = [graph_title,iteration_text,radius_text,...
            centre_text,radius_recurrence_text];
    end
    if contains(output,"particle") || contains(output,"difference") || contains(output,"energy")
        graph_title = [graph_title,...
            "(vx0, vy0, vz0) = (" + string(vx0) + ", " + string(vy0) + ", " + string(vz0)...
            + "), speed = " + string(sqrt(vx0^2 + vy0^2 + vz0^2))...
            ", ratio = " + string(ratio)];
        v = [vx0,vy0,vz0];
        Larmor_radius_numerator = norm(v)*norm(v - v.*B_field_all(x0,y0,z0,...
            field_choice,A1,B1,C1,lambda1,...
            A2,B2,C2,lambda2,'true',field_choice_vector));
        Larmor_radius_denominator = ratio*norm(B_field_all(x0,y0,z0,...
            field_choice,A1,B1,C1,lambda1,...
            A2,B2,C2,lambda2,'false',field_choice_vector));
        Larmor_radius = Larmor_radius_numerator/Larmor_radius_denominator;
        graph_title = [graph_title,"Larmor radius at r0 = " + string(Larmor_radius)];
    end
    if contains(output,"difference")
        graph_title(1) = "The graph type is difference";
    end
end