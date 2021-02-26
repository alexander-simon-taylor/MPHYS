function xyz_sums = hist_fun(history, number_of_sections)
    mod_history = mod(history,2*pi);
    xyz_sums = zeros(number_of_sections,3);
    for i = 1:3 % each for x,y,z
        coordinate_path = mod_history(:,i);
        length_of_section = floor(length(coordinate_path)/number_of_sections);
        for j = 1:number_of_sections
            xyz_sums(j,i) = sum(coordinate_path(1+(j-1)*length_of_section:j*length_of_section));
        end
    end
end