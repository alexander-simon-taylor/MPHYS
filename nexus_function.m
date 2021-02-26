function graphic = nexus_function(x0,y0,z0,vx0,vy0,vz0,field_choice,method_choice,A1,B1,C1,...
    lambda1,A2,B2,C2,lambda2,ds,number,output,radius,iterations,...
    number_per_save,num_colours,number_of_sections,path_name,position,...
    radius_recurrence,sqrt_num_starting_points,varying,ratio,...
    field_choice_vector,difference_check,particle_field_check,Larmor_radius)
    
    % Text stuff starts here
    output = string(output); output = output.lower();
    method_choice = string(method_choice); method_choice = method_choice.lower();
    field_choice = string(field_choice); field_choice = field_choice.lower();
    
    graph_title = title_text(x0,y0,z0,vx0,vy0,vz0,field_choice,method_choice,A1,B1,C1...
        ,lambda1,A2,B2,C2,lambda2,ds,number,output,radius,iterations,num_colours...
        ,number_of_sections,position,radius_recurrence,sqrt_num_starting_points...
        ,ratio,field_choice_vector);
    % Text block ends here%
    
    % Starting point matrix starts here %
    starting_matrix = starting_matrix_fun(x0,y0,z0,radius,iterations,output,sqrt_num_starting_points);
    % Starting point matrix ends here %
    
    % Data collection starts here %
    load_number = all_field_lines(field_choice,method_choice,A1,B1,C1,...
        lambda1,A2,B2,C2,lambda2,ds,number,number_per_save,path_name,...
        starting_matrix,vx0,vy0,vz0,output,ratio,field_choice_vector);
    % Data collection ends here %
    
    % Data loading %
    
    if size(starting_matrix,1) > 1
        graphic_input = zeros(1,sqrt_num_starting_points^2);
        tot_lengths = [];
        for i = 1:size(starting_matrix,1)/iterations
            if ~contains(output,'endpoints') && ~contains(output,"error")
                % initialising history array
                if contains(output,'recurrence') || contains(output,'chaos')...
                        || contains(output,'lyapunov') || contains(output,'energy')...
                        || contains(output,'multiple')
                    history = zeros(number,3,iterations);
                else
                    history = zeros(number,3);
                end
                for j = 1:iterations
                    index = (i - 1)*iterations + j;
                    % grabbing all the iterations for the ith starting pos.
                    start_pos = starting_matrix(index,:);
                    save_file_vector = save_file_text(path_name,load_number(index),...
                        field_choice,method_choice,A1,...
                        A2,ds,start_pos(1),start_pos(2),start_pos(3),...
                        vx0,vy0,vz0,output,ratio,field_choice_vector);
                    file_name = save_file_vector(3);
                    opened_file = fopen(file_name);
                    if contains(output,'particle')
                        try
                            temp = cell2mat(textscan(opened_file,'%f %f %f %f %f %f',number));
                            history(:,:,j) = temp(:,1:3);
                            clear('temp');
                        catch
                            file_name
                        end
                    else
                        try
                            temp = cell2mat(textscan(opened_file,'%f %f %f',number));
                            history(:,:,j) = temp;
                            clear('temp');
                        catch
                            file_name
                        end
                    end
                    fclose('all');
                end
            else % this else covers endpoints and error
                history = zeros(3,iterations);
                for j = 1:iterations
                    index = (i - 1)*iterations + j;
                    start_pos = starting_matrix(index,:);
                    save_file_vector = save_file_text(path_name,load_number(index),...
                        field_choice,method_choice,A1,...
                        A2,ds,start_pos(1),start_pos(2),start_pos(3),...
                        vx0,vy0,vz0,output,ratio,field_choice_vector);
                    file_name = save_file_vector(3);
                    new_data = importdata(string(file_name));
                    % Following from internet
%                     fid = fopen(string(file_name),'r');     %# Open the file as a binary
%                     lastLine = '';                   %# Initialize to empty
%                     offset = 1;                      %# Offset from the end of file
%                     fseek(fid,-offset,'eof');        %# Seek to the file end, minus the offset
%                     newChar = fread(fid,1,'*char');  %# Read one character
%                     while (~strcmp(newChar,newline)) || (offset == 1) % Online has 'char(10)' instead of 'newline'
%                       lastLine = [newChar lastLine];   %# Add the character to a string
%                       offset = offset + 1;
%                       fseek(fid,-offset,'eof');        %# Seek to the file end, minus the offset
%                       newChar = fread(fid,1,'*char');  %# Read one character
%                     end
                    fclose('all');  %# Close the file
%                     end_pos = string(split(lastLine));
%                     end_position_vector = [str2num(end_pos{1}),...
%                         str2num(end_pos{2}),str2num(end_pos{3})];
                    history(:,j) = new_data(number,1:3);
                    clear('new_data');
					% End from internet
                end
            end
            diff_history = abs(history - history(:,:,1));
            if contains(output,'lyapunov')
                graphic_input(i) = lyapunov(diff_history,number,iterations);
            elseif contains(output,'chaos')
                graphic_input = chaos(diff_history,iterations,number,ds,0);
            elseif contains(output,'recurrence')
                tot_lengths = [tot_lengths,recurrence(history,ds,position,radius_recurrence,tot_lengths)];
            elseif contains(output,'endpoints')
                graphic_input = history';
            elseif contains(output,'error')
                error_history = history - history(:,1);
                graphic_input = error_history';
            elseif contains(output,'multiple')
                graphic_input = history;
            end
        end
        if output == 'recurrence'
            graphic_input = tot_lengths;
        end
    else % for outputs with only one field line/path line
        save_file_vector = save_file_text(path_name,load_number(1),...
            field_choice,method_choice,A1,A2,ds,x0,y0,z0,vx0,vy0,vz0,...
            output,ratio,field_choice_vector);
        file_name = save_file_vector(3);
        temp = importdata(file_name);
        try
            history = temp(1:number,1:3);
        catch
            file_name
        end
        clear('temp');
        % quick loading needed
        if contains(output,'slice')
            graphic_input = slice(history,num_colours,number); 
            % Cell array of matrices (poincare plots)
        elseif contains(output,'path')
            graphic_input = path_fun(history,num_colours,number);
            % 3D array of different sections of the field line
        elseif contains(output, 'histogram')
            graphic_input = hist_fun(history, number_of_sections);
            % Matrix of sums of each component
        elseif contains(output,'energy')
            speed_history = temp(1:number,4:6);
            energy_history = vecnorm(speed_history');
            time_axis = ds*linspace(0,length(energy_history),length(energy_history));
            graphic_input = [time_axis;energy_history];
        end
    end
    
    if ~contains(output,'error') && ~difference_check && ~particle_field_check
        graphic = our_plot(graphic_input,output,"",varying,...
        A1,A2,B2,C2,number,x0,y0,number_of_sections,method_choice,...
        field_choice_vector,ratio,ds,Larmor_radius);
    %graphic = our_plot(graphic_input,output,[],varying,...
        %A1,A2,B2,C2,number,x0,y0,number_of_sections);
    else
        graphic = graphic_input;
    end
end