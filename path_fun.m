function field_line = path_fun(history,num_colours,number)
    fraction = floor(number/num_colours);
    field_line = zeros(fraction,3,num_colours);
    for i = 1:num_colours
        field_line(:,:,i) = history((i - 1)*fraction + 1:i*fraction,1:3);
    end
end