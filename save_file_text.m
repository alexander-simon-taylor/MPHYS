function save_file_text = save_file_text(path_name,number,field_choice,...
    method_choice,A1,A2,ds,x0,y0,z0,vx0,vy0,vz0,output,ratio,field_choice_vector)
    short_save_text = string(method_choice) + '_' + string(field_choice) + '_';
    if contains(output.lower(),'particle')
        short_save_text = short_save_text + 'particle_' + string(ratio) + '_';
    end
    if contains(field_choice.lower(),'abc') || field_choice_vector(1) ~= 0 ...
            || field_choice_vector(2) ~= 0
        short_save_text = short_save_text + string(A1) + '_';
        if contains(field_choice.lower(),'abc2')
            short_save_text = short_save_text + string(A2) + '_';
        end
    end
    short_save_text = short_save_text + string(ds) + '_(' + string(x0/(2*pi)) + ...
    ',' + string(y0/(2*pi)) + ',' + string(z0/pi) + ')';
    
    if contains(output.lower(),'particle')
        short_save_text = short_save_text + '_(' + string(vx0) + ',' + ...
            string(vy0) + ',' + string(vz0) + ')';
    end

    if field_choice.lower() == 'multiple'
        short_save_text = short_save_text + '_fv_(' + string(field_choice_vector(1));
        for i = 2:length(field_choice_vector)
            short_save_text = short_save_text + ',' + string(field_choice_vector(i));
        end
        short_save_text = short_save_text + ')';
    end
    
    path_number = string(path_name) + '/' + string(number) + '_';
    save_text = string(path_number) + string(short_save_text) + '.txt';
    save_file_text = [string(short_save_text),string(path_number),string(save_text)];
end