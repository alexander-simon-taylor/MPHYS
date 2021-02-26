A1 = 1;
B1 = sqrt(2/3);
C1 = sqrt(1/3);
lambda1 = 1;
plot_strength_array = zeros(3,1000000);
second_order_coefficient = 0;
A2 = second_order_coefficient*A1;
B2 = second_order_coefficient*B1;
C2 = second_order_coefficient*C1;
lambda2 = -0.5;
field_choice_vector = 0;
for i = 1:1000
    for j = 1:1000
        plot_strength_array(j + 1000*(i - 1),1) = 2*pi*i/1000;
        plot_strength_array(j + 1000*(i - 1),2) = 2*pi*j/1000;
        plot_strength_array(i,j) = vecnorm(B_field_all(2*pi*i/1000,2*pi*j/1000,0,"ABC",A1,B1,C1,lambda1,...
            A2,B2,C2,lambda2,"false",field_choice_vector));
    end
end
plot3(plot_strength_array(1,:), plot_strength_array(2,:), plot_strength_array(3,:));