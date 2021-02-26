function RGB = RGB_gen(i,num_colours)
    if num_colours == 1
        RGB = [0,0,1];
    else
		green_space = linspace(0,1,num_colours);
        RGB = [1,1-green_space(i),0];
    end
end