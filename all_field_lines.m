function load_number = all_field_lines(field_choice,method_choice,...
    A1,B1,C1,lambda1,A2,B2,C2,lambda2,ds,number,number_per_save,...
    path_name,starting_matrix,vx0,vy0,vz0,output,ratio,field_choice_vector)

%    cd 'C:/Users/mbcxaat2/Documents/MPHYS';
    cd 'E:/MPHYS/data';
    files = ls;
    cd 'D:\Documents\University\MPHYS\MATLAB';
    load_number = number*ones(1,size(starting_matrix,1));
    for i = 1:size(starting_matrix,1)
        ending = [];
        % Array to find the first underscore corresponding to the number
        file_names = [];
        % Starting generating the file name
        r = starting_matrix(i,:);
        save_text_all = save_file_text(path_name,number,field_choice,...
            method_choice,A1,A2,ds,r(1),r(2),r(3),vx0,vy0,vz0,output,...
            ratio,field_choice_vector);
        % File name generation done
        
        % Checking every single file to look for a single .txt file
        for k = 1:size(files,1) % Looks through files that do exist by above
            if contains(files(k,:),string(save_text_all(1)))
                % Checks all non-number parameters of the file
                all_underscores = strfind(files(k,:),'_');
                % Finds all underscores in these file names
                ending = [ending;all_underscores(1)];
                % Finds the position of the first underscores
                file_names = [file_names;files(k,:)];
                % Creates a vector of the first underscore positions
            end
        end
        if ~isempty(file_names)
            existing_numbers = str2double(file_names(:,1:ending-1));
            % Takes the numbers of all existing files using position of
            % first _
            for j = 1:length(existing_numbers)
                old_number = existing_numbers(j);
                if number > old_number + number_per_save
                    % We want a larger number of loops than the file gives
                    save_text_old = save_file_text(path_name,old_number,...
                        field_choice,method_choice,A1,A2,ds,r(1),r(2),r(3),...
                        vx0,vy0,vz0,output,ratio,field_choice_vector);
                    excess_number = number - old_number;
                    % Making the save text of the old file
                    old_data = importdata(string(save_text_old(3)));
                    % There's no advantage to making this able to load
                    % part of the file - it never does
                    last_pos = old_data(end,:);
                    if contains(output.lower(),'particle')
                        single_particle_path(excess_number,ds,last_pos(1),...
                            last_pos(2),last_pos(3),last_pos(4),last_pos(5),last_pos(6),field_choice,method_choice,...
                            A1,B1,C1,lambda1,A2,B2,C2,lambda2,number_per_save,path_name,output,ratio,field_choice_vector);
                    else
                        single_field_line(excess_number,ds,last_pos(1),last_pos(2),last_pos(3),field_choice,method_choice,...
                            A1,B1,C1,lambda1,A2,B2,C2,lambda2,number_per_save,path_name,field_choice_vector);
                    end
                    % Making the save text for the new files
                    if contains(output.lower(),'particle')
                        save_text_new = save_file_text(path_name,excess_number,...
                            field_choice,method_choice,A1,...
                            A2,ds,last_pos(1),last_pos(2),last_pos(3),...
                            last_pos(4),last_pos(5),last_pos(6),output,...
                            ratio,field_choice_vector);
                    else
                        save_text_new = save_file_text(path_name,excess_number,...
                            field_choice,method_choice,A1,...
                            A2,ds,last_pos(1),last_pos(2),last_pos(3),...
                            vx0,vy0,vz0,output,ratio,field_choice_vector);
                    end
                    new_data = importdata(string(save_text_new(3)));
                    % Putting the data together
                    data = [old_data;new_data];
                    % Making the save text for all of the data
                    save_text_all = save_file_text(path_name,number,...
                        field_choice,method_choice,A1,A2,ds,r(1),r(2),r(3),...
                        vx0,vy0,vz0,output,ratio,field_choice_vector);                    
                    save_file = fopen(string(save_text_all(3)),'w');
                    % Saving the new data
                    if contains(output,"particle")
                        fprintf(save_file, '%d %d %d %d %d %d\n', data');
                    else
                        fprintf(save_file, '%d %d %d\n', data');
                    end
                    % does that
                    clear('save_file');
                    clear('new_data');
                    clear('old_data');
                    fclose('all');
                    delete(save_text_old(3));
                    delete(save_text_new(3));
                    % deletes the old file
                else
                    load_number(i) = old_number;
                end
            end
        elseif contains(output.lower(),'particle')
            single_particle_path(number,ds,r(1),...
                r(2),r(3),vx0,vy0,vz0,field_choice,method_choice,...
                A1,B1,C1,lambda1,A2,B2,C2,lambda2,number_per_save,...
                path_name,output,ratio,field_choice_vector);
        else
            single_field_line(number,ds,r(1),r(2),r(3),field_choice,method_choice,...
                A1,B1,C1,lambda1,A2,B2,C2,lambda2,number_per_save,...
                path_name,field_choice_vector);
        end
    end
end 