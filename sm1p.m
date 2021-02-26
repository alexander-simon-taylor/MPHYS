function starting_matrix_1point = sm1p(x0,y0,z0,radius,iterations)
     i = 1;
     j = 0;
     starting_matrix_1point = zeros(iterations,3);
     starting_matrix_1point(1,:) = [x0,y0,z0];
     while i <= iterations - 1 && i <= 6
         if i > 3
             j = 1;
         end
         index = mod(i - 1,3) + 1;
         zero_point = zeros(1,3);
         zero_point(index) = zero_point(index) + 1;
         starting_matrix_1point(i + 1,:) = [x0,y0,z0] + radius*(-1)^j.*zero_point;
         i = i + 1;
     end
     if iterations > 7
         for k = 8:iterations
            starting_matrix_1point(k,:) = [x0,y0,z0] + radius*random_vector(k);
         end
     end
end