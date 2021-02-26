function image_text = im_text_fun(number,ds,method_choice,field_choice,output,...
    A1,A2,x0,y0,z0,vx0,vy0,vz0,num_colours,number_of_sections,radius,iterations,...
    radius_recurrence,length_output,sqrt_num_starting_points,ratio,...
    field_choice_vector)
    start_text = string(method_choice) + '_' + string(field_choice) + '_' + ...
        string(output) + '_number-' + string(number) + '_ds-' + string(ds) + '_';
    if contains(output,'particle') || contains(output,'difference')
        start_text = start_text + 'v0-(' + string(vx0) + ',' + string(vy0) + ...
            ',' + string(vz0) + ')_' + string(ratio) + '_';
    end
    if contains(field_choice.lower,'abc')
        start_text = start_text + 'A1-' + string(A1) + '_';
        if contains(field_choice.lower, 'abc2')
            start_text = start_text + 'A2-' + string(A2) + '_';
        end
    end
    if ~contains(output,'lyapunov')
        image_text_short = start_text + 'r0-(' + string(x0)+ ',' + string(y0) + ...
            ',' + string(z0) + ')';
        if ~contains(output, 'chaos') && ~contains(output,'recurrence') && ~contains(output,'endpoints')
            image_text = strings(length_output,1);
            for i = 1:length_output
                if contains(output,'path') || contains(output,'slice') ||...
                        contains(output,'energy') || contains(output,'error') ||...
                        contains(output,'particle_field')
                    image_text(i) = image_text_short + '_colours-' + string(num_colours)...
                        + '_';
                    if length_output == 1
                        image_text(i) = image_text(i) + 'single_colour';
                    elseif i == length_output
                        image_text(i) = image_text(i) + 'all';
                    else
                        image_text(i) = "coloured/" + image_text(i) + string(i);
                    end 
                elseif contains(output,'histogram')
                    image_text(i) = image_text_short + '_sections-' + ...
                        string(number_of_sections) + '_' + string(i);
                end
            end
        else
			image_text = image_text_short + '_radius-' + string(radius) + '_iterations-' + ...
                string(iterations);
			if contains(output,'recurrence')
				image_text = image_text + '_rec-' + string(radius_recurrence);
			end
        end
    else
        image_text = start_text + 'points-' + string(sqrt_num_starting_points^2) +...
            '_radius' + string(radius) + '_iterations-' + string(iterations);   
    end
    if contains(output,'difference')
        image_text = image_text_short;
    end
    if contains(field_choice,'multiple')
        image_text = image_text + '_fv-(' + string(field_choice_vector(1));
        for i = 2:length(field_choice_vector)
            image_text = image_text + ',' + string(field_choice_vector(i));
        end
        image_text = image_text + ')';
    end
    image_text = 'images\' + string(output) + '_images\' + image_text + '.png';
end