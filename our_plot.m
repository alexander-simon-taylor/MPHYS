function graphic = our_plot(graphic_input,output,title_text,varying,...
    A1,A2,B2,C2,number,x0,y0,number_of_sections,method_choice,...
    field_choice_vector,ratio,ds,Larmor_radius)
    % starting animation titles and control
    if contains(output,'animation')
        if varying == 1 || varying == 6
            varied_param = "number";
            varied_value = number;
        elseif varying == 2
            varied_param = "A1";
            varied_value = A1;
        elseif varying == 3
            varied_param = "second order coefficients";
            varied_value = [A2,B2,C2];
        elseif varying == 4
            varied_param = "magnetic field mixing";
            varied_value = field_choice_vector;
        elseif varying == 5
            varied_param = "ratio";
            varied_value = ratio;
        end
        if varying == 1 || varying == 2 || varying == 5 || varying == 6
            % if number or A1 are being varied
            title_text = "The value of " + string(varied_param) + " is " + ...
                string(varied_value);
        elseif varying == 3 % if SOC is being varied
            title_text = "The value of " + string(varied_param) + " is (" + ...
                string(varied_value(1)) + ', ' + string(varied_value(2)) +...
                ', ' + string(varied_value(3)) + ')';
        elseif varying == 4
            title_text = "The vector for magnetic field mixing is (" + ...
                string(field_choice_vector(1));
            for i = 2:length(field_choice_vector)
                title_text = title_text + "," + string(field_choice_vector(i));
            end
            title_text = title_text + ").";
        elseif varying == 5
            title_text = "The value of " + string(varied_param) + " is " + ...
                string(varied_value);
        end
        char_output = char(output);
        output_short = char_output(1:end-10);
        output_text = "The animation type is " + string(output_short);
        title_text = [output_text,title_text];
    end
    % end of animation titling and control
    
    % start of multiple path plotting
    if contains(output,'multiple')
        iterations = size(graphic_input,3);
        graphic = figure("visible","off");
        for j = 1:iterations
            plot3(graphic_input(:,1,j),graphic_input(:,2,j),...
                    graphic_input(:,3,j), 'Color', RGB_gen(j,iterations));
            hold on;
        end
        hold off;
        xlabel('x');
        ylabel('y');
        zlabel('z');
        title(title_text);
    % end of multiple path plotting

    % start of single path plotting
    elseif contains(output,'path')
        num_colours = size(graphic_input,3);
        if num_colours > 1 % plotting all colours on one plot
            graphic = zeros(1,num_colours + 1);
            graphic(end) = figure('visible','off');
            for j = 1:num_colours
                plot3(graphic_input(:,1,j),graphic_input(:,2,j),...
                    graphic_input(:,3,j), 'Color', RGB_gen(j,num_colours));
                hold on
            end
            xlabel('x');
            ylabel('y');
            zlabel('z');
            title(title_text);
        else
            graphic = 0;
        end
        for j = 1:num_colours % plotting individual colours
            graphic(j) = figure('visible','off');
            plot3(graphic_input(:,1,j),graphic_input(:,2,j),...
                graphic_input(:,3,j), 'Color', RGB_gen(j,num_colours));
            xlabel('x');
            ylabel('y');
            zlabel('z');
            title(title_text);
        end
        hold off
    % end of single path plotting
        
    % Start of Slice plotting %
    elseif contains(output,'slice')
        num_colours = size(graphic_input,2);
        if num_colours > 1 % plotting all colours on one plot
            graphic = zeros(1,num_colours + 1);
            graphic(end) = figure('visible','off');
            for j = 1:num_colours
                one_colour = cell2mat(graphic_input(j));
                scatter(one_colour(:,1),one_colour(:,2),10,'.',...
                    'MarkerEdgeColor', RGB_gen(j,num_colours));
                hold on
            end
            xlabel('x/{2\pi}'); xlim([0,1]);
            ylabel('y/{2\pi}'); ylim([0,1]);
            title(title_text);
        else
            graphic = 0;
        end
        for j = 1:num_colours % plotting individual colours
            graphic(j) = figure('visible','off');
            %ax = axes;
            one_colour = cell2mat(graphic_input(j));
            scatter(one_colour(:,1),one_colour(:,2),10,'.',...
                'MarkerEdgeColor', RGB_gen(j,num_colours),...
                'MarkerFaceAlpha',.2,'MarkerEdgeAlpha',.2);
            xlabel('x/{2\pi}'); xlim([0,1]);
            ylabel('y/{2\pi}'); ylim([0,1]);
            xlim([0,1]); ylim([0,1]);
            %title(['','']);
            title(title_text);
        end
        hold off
    % End slice plotting %
        
    % Start of Histogram plotting
    elseif contains(output,'histogram')
        graphic = zeros(1,3);
        for i = 1:3
            graphic(i) = figure('visible','off');
            if i == 1
                coordinate = 'x ';
            elseif i == 2
                coordinate = 'y ';
            elseif i == 3
                coordinate = 'z ';
            end
            histogram(graphic_input(:,i),50);
            label_text = 'Sum of (' + string(coordinate) + 'mod 2\pi) coordinates in each section.';
            xlabel(label_text);
            ylabel('Count');
            title(title_text)
        end
		% End of histogram plotting
		
		% Start of recurrence plotting
    elseif contains(output,'recurrence')
        [counts,centers] = hist(graphic_input);
        graphic = figure('visible','off');
        bar(centers,log10(counts));
        xlabel('Recurrence Length');
        ylabel('log_{10}Counts');
        title(title_text)
		% End of recurrence plotting
		
		% Start of chaos plotting
    elseif contains(output,'chaos')
        if contains(output,'animation')
            on_off = "off";
        else
            on_off = "on";
        end
        graphic = figure('visible',on_off);
        plot(graphic_input(:,1),graphic_input(:,2));
        if ~contains(output,'animation')
            title("Enter the lower x-bound for the best fit line in the terminal.");
            lower_bound = input('Enter the lower x-bound for the best fit line.\n>> ');
            delete(findall(0));
        else
            lower_bound = 2.5;
            % Can make this variable for different field types
        end
        graphic = figure('visible','off');
        sAxis = graphic_input(:,1);
        plot(graphic_input(:,1),graphic_input(:,2));
        [~,minIndex] = min(abs(sAxis-lower_bound));
        fittedLine = polyfit(sAxis(minIndex:end),graphic_input(minIndex:end,2),1);
        xForFit = linspace(sAxis(minIndex),sAxis(end),1000);
        yFit = fittedLine(1)*xForFit + fittedLine(2);
        gradientText = 'The gradient is ' + string(fittedLine(1));
        interceptText = ', and the intercept is ' + string(fittedLine(2));
        title_text = [title_text,gradientText];
        hold on
        plot(xForFit,yFit)
        hold off
        xlabel('log_{10} s');
        ylabel('log_{10} \sigma^2');
        title(title_text)
		% End of chaos plotting
		
		% Start of Lyapunov plotting
    elseif contains(output,'lyapunov')
        length_input = sqrt(length(graphic_input));
        if contains(output,'region')
            plotting_points = linspace(x0,y0,length_input);
        else
            plotting_points = linspace(0,1,length_input);
        end
        chaos_matrix = [];
        non_chaos_matrix = [];
        i = 1;
        for x = plotting_points
            for y = plotting_points
                if graphic_input(i) == 1
                    chaos_matrix(i,:) = [x,y];
                else
                    non_chaos_matrix(i,:) = [x,y];
                end
                i = i + 1;
            end
        end
%         if isfile("lyapunov_images\background_slice.fig")
%             graphic = openfig("lyapunov_images\background_slice.fig",'invisible'); hold on;
%             title(title_text);
%         else
%             message('File not found - make a slice file called "Lyapunov_images\background_slice.fig".');
%             graphic = figure('visible','off');
%         end
        graphic = figure('visible','off'); % this line is in the stop the background
        ax = axes;
        if ~isempty(chaos_matrix)
            scatter(ax,chaos_matrix(:,1),chaos_matrix(:,2),'.r'); hold on;
            set(gca,'color','none')
        end
        if ~isempty(non_chaos_matrix)
            scatter(ax,non_chaos_matrix(:,1),non_chaos_matrix(:,2),'.g');
            set(gca,'color','none')
        end
        title(title_text);
        hold off;
		% End of Lyapunov plotting
        
        % Start of endpoints plotting
    elseif contains(output,'endpoints')
        graphic = figure('visible','off');
        scatter3(graphic_input(:,1),graphic_input(:,2),graphic_input(:,3),'.');
        xlabel('x'); ylabel('y'); zlabel('z');
        title(title_text);
        % End of endpoints plotting
        
        % Start of energy plotting
    elseif contains(output,'energy')
        graphic = figure('visible','off');
        speed_dropoff = 0;
        for i = 1:length(graphic_input(2,:))
            if graphic_input(2,i) < 0.95*graphic_input(2,1)
                speed_dropoff = i;
                break;
            end
        end
        plot(graphic_input(1,:),graphic_input(2,:));
        xlabel('Iteration length'); ylabel('Speed');
        title_text = [title_text,"The speed dropoff occurs at " + string(speed_dropoff*ds)];
        title(title_text);
        % End of energy plotting
        
        % Start of error plotting
    elseif contains(output,'error')
        if method_choice == 'euler'
            p = 1;
        elseif contains(method_choice,'improved')
            p = 2;
        elseif method_choice == 'rk4'
            p = 4;
        elseif method_choice == 'rk6'
            p = 6;
        end
        graphic = figure('visible','off');
        scatter(graphic_input(:,2),graphic_input(:,1));
        ylabel('Mean of distance from reference point of iterations');
        xlabel('ds^' + string(p));
        % End of error plotting
        
        % Start of difference plotting
    elseif contains(output,'difference')
        x_linspace = linspace(1,length(graphic_input),length(graphic_input));
        graphic = figure('visible','off');
        scatter(x_linspace,graphic_input,'.');
        ylabel('Distance between associated points in Poincare plot.');
        xlabel('Index of point');
        xlim([0,1.5]); ylim([0,1.5]);
        title(title_text);
        % End of difference plotting
        
        % Sstart of particle & field line plotting
    elseif contains(output,'particle_field')
        graphic = figure('visible','off');
        for type = 1:2
            plot3(graphic_input(type,:,1,1),graphic_input(type,:,2,1),...
                graphic_input(type,:,3,1), 'Color', RGB_gen(type,2));
            hold on;
        end
        threshold = 4*Larmor_radius + ds + 0.1;
        len_segment = length(graphic_input(1,:,1,1));
        m = 1;
        break_check = 0;
        for k = 1:len_segment
            while vecnorm(graphic_input(1,k,:,1) - graphic_input(2,m,:,1)) > threshold
                if vecnorm(graphic_input(1,k,:,1) - graphic_input(2,m,:,1)) > 3*threshold || m == len_segment
                    break_check = 1;
                    title_text = [title_text, "The lines first deviate by more than " + ...
                        string(threshold) + " at the " + string(k) + "^{th} step."];
                    break;
                else
                    m = m + 1;
                end  
            end
            if break_check
                break;
            elseif k == len_segment
                title_text = [title_text, "The lines stay together."];
            end
        end
        if contains(output,'animation')
            xlim([-50,50]); ylim([0,300]); zlim([-50,50]);
        end
        xlabel('x');
        ylabel('y');
        zlabel('z');
        title(title_text);
        hold off;
    end
end