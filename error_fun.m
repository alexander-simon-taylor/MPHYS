function error_output = error_fun(error_input,method_choice,simulation_length,number)
    % error_input has dimensions (frames,3,iterations-1), and is a
    % diff_history type of array
    error_output = zeros(1,2);
    distance_sum = 0;
    for j = 2:size(error_input,2) % iterations
        distance_sum = distance_sum + sqrt(error_input(1,j)^2 + error_input(2,j)^2 + error_input(3,j)^2);
    end
    error_output(1) = distance_sum/size(error_input,3);
    if method_choice == 'euler'
        p = 1;
    elseif contains(method_choice,'improved')
        p = 2;
    elseif method_choice == 'rk4'
        p = 4;
    elseif method_choice == 'rk6'
        p = 6;
    end
    error_output(2) = (simulation_length/number)^p;
end