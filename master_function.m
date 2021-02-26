function graphic = master_function(x0,y0,z0,vx0,vy0,vz0,field_choice,method_choice,A1,B1,C1,...
                    lambda1,A2,B2,C2,lambda2,ds,number,output,radius,iterations,...
                    number_per_save,num_colours,number_of_sections,path_name,position,...
                    radius_recurrence,sqrt_num_starting_points,varying,...
                    min_animation,max_animation,frames,ratio,...
                    field_choice_vector,simulation_length)
   
    field_choice = field_choice.lower();
    method_choice = method_choice.lower();
    output = output.lower();
    % normalises the field_choice_vector, and if only one field is used it
    % changes the inputs to relect that
    
    if contains(field_choice,"multiple")
        field_choice_vector = field_choice_vector/sum(abs(field_choice_vector));
        field_choice_string_vector = ["abc","abc2","uniform","circular","bar","bessel"];
        for i = 1:length(field_choice_vector)
            if field_choice_vector(i) == 1 && varying ~= 4
                field_choice = field_choice_string_vector(i);
            end
        end
    end
    
    ratio = ratio*sqrt(vx0^2 + vy0^2 + vz0^2);
    
    varying_linspace = linspace(min_animation,max_animation,frames);
    GIF_filename = "images/animations/" +  string(output) + ...
        "_" + string(field_choice) + "_" + string(varying) + "_" ...
        + string(min_animation) + "_" + string(max_animation) + ...
        "_" + string(frames) + ".gif";
    
    % Sets the array for whichever parameter is being animated across,
    % if any
    second_order_constant = 1;
    
    if ~contains(output,'animation') && ~contains(output,'error')
        varying = 0;
    end
    
    % Sets the number of output images
    
    length_output = 1;
    
    if contains(output,'path') || contains(output,'slice')
        if num_colours > 1
            length_output = num_colours + 1;
        end
    elseif contains(output,'histogram')
        length_output = 3;
    end
    
    if contains(output,'particle_field')
        num_colours = 1;
    end
    
    if contains(output,'animation')
        animation_check = 1;
    else
        animation_check = 0;
    end
    
    % The following section generates figures using nexus_function if
    % either the corresponding image doesn't exist, or we're running a path
    % animation
    axis_limits = zeros(3,2);
    error_output = zeros(frames,2);
    new_field_choice_vector = field_choice_vector;
    difference_check = 0;
    particle_field_check = 0;
    if contains(output,'difference')
        difference_check = 1;
    elseif contains(output,'particle_field')
        particle_field_check = 1;
    end
    for i = 1:frames
        for v = 1:(1 + difference_check + particle_field_check)
            if varying == 1 || varying == 6
                number = varying_linspace(i);
                if varying == 6
                    ds = simulation_length/varying_linspace(i);
                end
            elseif varying == 2
                A1 = varying_linspace(i);
            elseif varying == 3
                second_order_constant = varying_linspace(i);
            elseif varying == 4
                if contains(field_choice,"multiple") && field_choice_vector(1) ~= 1
                    new_field_choice_vector = field_choice_vector;
                    new_field_choice_vector(1) = 0;
                    new_field_choice_vector = abs(1 - varying_linspace(i))*field_choice_vector/sum(abs(new_field_choice_vector));
                    new_field_choice_vector(1) = varying_linspace(i);
                else
                    varying = 0;
                end
            elseif varying == 5
                ratio = varying_linspace(i);
            end
            A2_scaled = A2*second_order_constant;
            B2_scaled = B2*second_order_constant;
            C2_scaled = C2*second_order_constant;
            if contains(output,'error')
                ds = simulation_length/number;
            end
            image_text = im_text_fun(number,ds,method_choice,field_choice,output,...
            A1,A2_scaled,x0,y0,z0,vx0,vy0,vz0,1,number_of_sections,radius,iterations,...
            radius_recurrence,length_output,sqrt_num_starting_points,ratio,...
            new_field_choice_vector);
            check_for_fig = 0;
            if contains(output,'path_animation') || contains(output,'endpoints_animation')
                check_for_fig = 1;
            end
            if ~isfile(string(image_text)) | check_for_fig == 1 | contains(output,'error') |...
                    difference_check | particle_field_check
                % if the image file doesn't exist, or we're making a
                % path animation
                if difference_check
                    if v == 1
                        output = 'slice';
                    elseif v == 2
                        output = 'particle_slice';
                    end
                elseif particle_field_check
                    if v == 1
                        output = 'path';
                    elseif v == 2
                        output = 'particle_path';
                    end
                end
                velocity = [vx0,vy0,vz0];
                Larmor_radius_numerator = norm(velocity)*norm(velocity - velocity.*B_field_all(x0,y0,z0,...
                        field_choice,A1,B1,C1,lambda1,...
                        A2,B2,C2,lambda2,'true',new_field_choice_vector));
                Larmor_radius_denominator = ratio*norm(B_field_all(x0,y0,z0,...
                        field_choice,A1,B1,C1,lambda1,...
                        A2,B2,C2,lambda2,'false',new_field_choice_vector));
                Larmor_radius = Larmor_radius_numerator/Larmor_radius_denominator;
                graphic = nexus_function(x0,y0,z0,vx0,vy0,vz0,field_choice,method_choice,A1,B1,C1,...
                    lambda1,A2_scaled,B2_scaled,C2_scaled,lambda2,ds,number,...
                    output,radius,iterations,...
                    number_per_save,num_colours,number_of_sections,path_name,position,...
                    radius_recurrence,sqrt_num_starting_points,...
                    varying,ratio,new_field_choice_vector,difference_check,...
                    particle_field_check,Larmor_radius);
                % graphic outputs an array of figures
                if difference_check
                    output = "difference";
                    if animation_check
                        output = output + "_animation";
                    end
                elseif particle_field_check
                    output = "particle_field";
                    if animation_check
                        output = output + "_animation";
                    end
                end
                if contains(output,'slice') || contains(output,'lyapunov')
                    xlim([0,1]); ylim([0,1]);
                    % set the limits for slice and Lyapunov plots
    %             elseif contains(output,'path')
    %                 xlim([-2.5,2.5]); ylim([-2.5,2.5]);
                elseif contains(output,'energy')
                    xlim ([0,ds*number]); ylim([0.8,1.2]);
                end
                for j = 1:length_output
                    fig = graphic(j);
                    if contains(output,'path_animation') ||...
                            contains(output,'endpoints_animation')
                        figure_save_text = string(path_name) + '/' +...
                            string(output) + '_figures/figure_' + string(i);
                        i
                        if ~isfile(string(figure_save_text) + '.fig')
                            saveas(fig,figure_save_text,'fig');
                        end
                        limits = [xlim;ylim;zlim];
                        for k = 1:3
                            if limits(k,1) < axis_limits(k,1)
                                axis_limits(k,1) = limits(k,1);
                            end
                            if limits(k,2) > axis_limits(k,2)
                                axis_limits(k,2) = limits(k,2);
                            end
                        end
                    elseif ~contains(output,'error') && ~difference_check && ~particle_field_check
                        saveas(fig,string(image_text(j)),'png');
                    end
                    clear('fig')
                end
                if contains(output,'error')
                    error_output(i,:) = error_fun(graphic',method_choice,simulation_length,number);
                elseif difference_check
                    if v == 1
                        difference_output_B = cell2mat(graphic);
                    elseif v == 2
                        difference_output_particle = cell2mat(graphic);
                    end
                elseif particle_field_check
                    if v == 1
                        particle_field_field = graphic;
                    elseif v == 2
                        particle_field_particle = graphic;
                    end
                end
            end
        end
        if difference_check
            graph_title = title_text(x0,y0,z0,vx0,vy0,vz0,field_choice,method_choice,A1,B1,C1...
                ,lambda1,A2,B2,C2,lambda2,ds,number,'difference',radius,iterations,num_colours...
                ,number_of_sections,position,radius_recurrence,sqrt_num_starting_points...
                ,ratio,new_field_choice_vector);

            difference_output = difference_fun(difference_output_B,difference_output_particle);

            difference_image = our_plot(difference_output,"difference",graph_title,varying,...
                A1,A2,B2,C2,number,x0,y0,number_of_sections,method_choice,varying_linspace,Larmor_radius);

            saveas(difference_image,string(image_text),'png');
        elseif particle_field_check
            graph_title = title_text(x0,y0,z0,vx0,vy0,vz0,field_choice,method_choice,A1,B1,C1...
                ,lambda1,A2,B2,C2,lambda2,ds,number,'particle_field',radius,iterations,num_colours...
                ,number_of_sections,position,radius_recurrence,sqrt_num_starting_points...
                ,ratio,new_field_choice_vector);

            particle_field_output = zeros(2,floor(number/num_colours),3,num_colours);
            particle_field_output(1,:,:,:) = particle_field_field;
            particle_field_output(2,:,:,:) = particle_field_particle;

            particle_field_image = our_plot(particle_field_output,"particle_field",graph_title,varying,...
                                        A1,A2,B2,C2,number,x0,y0,number_of_sections,method_choice,...
                                        field_choice_vector,ratio,ds,Larmor_radius);
            
            saveas(particle_field_image,string(image_text),'png');
        end
    end
    
    if contains(output,'error')
        graph_title = title_text(x0,y0,z0,vx0,vy0,vz0,field_choice,method_choice,A1,B1,C1...
            ,lambda1,A2,B2,C2,lambda2,ds,number,output,radius,iterations,num_colours...
            ,number_of_sections,position,radius_recurrence,sqrt_num_starting_points...
            ,ratio,new_field_choice_vector);
        
        error_image = our_plot(error_output,output,graph_title,varying,...
            A1,A2,B2,C2,number,x0,y0,number_of_sections,method_choice,varying_linspace,Larmor_radius);
        
        saveas(error_image,string(image_text),'png');
    end
    
    % The following section, if we're running a path animation, loads in
    % the figures, sets the axes and saves them as images.
    % For animation stuff, it then loads in the images, and creates a gif.
    if contains(output,'animation')
        for i = 1:frames
            if varying == 1 || varying == 6
                number = varying_linspace(i);
                if varying == 6
                    ds = simulation_length/varying_linspace(i);
                end
            elseif varying == 2
                A1 = varying_linspace(i);
            elseif varying == 3
                second_order_constant = varying_linspace(i);
            elseif varying == 4
                if contains(field_choice,"multiple") && field_choice_vector(1) ~= 1
                    new_field_choice_vector = field_choice_vector;
                    new_field_choice_vector(1) = 0;
                    new_field_choice_vector = (1 - varying_linspace(i))*field_choice_vector/sum(new_field_choice_vector);
                    new_field_choice_vector(1) = varying_linspace(i);
                else
                    varying = 0;
                end
            elseif varying == 5
                ratio = varying_linspace(i);
            end
            image_text = im_text_fun(number,ds,method_choice,field_choice,output,...
            A1,second_order_constant,x0,y0,z0,vx0,vy0,vz0,1,number_of_sections,radius,iterations,...
            radius_recurrence,length_output,sqrt_num_starting_points,ratio,new_field_choice_vector);
            if contains(output,'path') || contains(output,'endpoints')
                figure_save_text = string(path_name) + '\' +...
                    string(output) + '_figures/figure_' + string(i) + '.fig';
                fig = openfig(figure_save_text);
                xlim(axis_limits(1,:));
                ylim(axis_limits(2,:));
                zlim(axis_limits(3,:));
                try
                    saveas(fig,string(image_text),'png');
                catch
                    image_text
                end
                fig = [];
                clear('fig');
                delete(figure_save_text);
            end
            try
                im = imread(char(image_text));
            catch
                image_text
            end
            [imind,cm] = rgb2ind(im,256);
            % Write to the GIF File
            if i == 1
                imwrite(imind,cm,GIF_filename{1},'gif', 'Loopcount',Inf,'DelayTime',.3); 
            else 
                imwrite(imind,cm,GIF_filename{1},'gif','WriteMode','append','DelayTime',.3); 
            end
        end
    end
end