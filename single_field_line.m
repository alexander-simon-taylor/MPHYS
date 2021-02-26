%function that collects data
%input arguments = (number, step size, starting _points, field and method arguments)
%pathName_field_choice_A1_number_stepSize_starting_point

function history = single_field_line(number,ds,x0,y0,z0,field_choice,...
    method_choice,A1,B1,C1,lambda1,A2,B2,C2,lambda2,number_per_save,...
    path_name,field_choice_vector)
    number_of_saves = floor(number/number_per_save) + 1;
	save_text_array = save_file_text(path_name,number,field_choice,...
        method_choice,A1,A2,ds,x0,y0,z0,0,0,0,"none",1,field_choice_vector);
	save_text = save_text_array(3);
    save_file = fopen(save_text,'w');
    fclose('all');
    r = [x0,y0,z0];
    for i = 1:number_of_saves
        history = zeros(number_per_save,3);
        for j = 1:number_per_save
            r = all_methods_field_lines(r(1),r(2),r(3),field_choice,method_choice,...
                A1,B1,C1,lambda1,A2,B2,C2,lambda2,ds,field_choice_vector);
            history(j,:) = r;
        end
        save_file = fopen(save_text,'at');
        fprintf(save_file, '%d %d %d\n', history');
        fclose('all');
    end
end