% Make sure to explicity put this into all_field_lines too.%!!!
%path_name = "C:/Users/mbcxaat2/Documents/MPHYS";
path_name = "E:/MPHYS/data";
% Make sure to explicity put this into all_field_lines too.%!!!

x0 = 1;
y0 = 1;
z0 = 1;
field_choice = "bessel";
field_choice_vector = [100,0,0,0,0,0];
% field vector: ABC, ABC2, uniform, circular, bar, Bessel
% field vector only triggers if field_choice = multiple, and will get
% normalised automatically
% field choice string vector in B_field_all and master_function
method_choice = "rk4";

ds = 0.001;
number = 1000000;
num_colours = 1;
output = "particle_energy_animation";
A1 = 1;
B1 = sqrt(2/3);
C1 = sqrt(1/3);
lambda1 = 1;

second_order_coefficient = 1;
A2 = second_order_coefficient*A1;
B2 = second_order_coefficient*B1;
C2 = second_order_coefficient*C1;
lambda2 = -0.5;

% For Chaos, Recurrance and Lyapunov
radius = 0.001*pi;
iterations = 25;
% For File saving
number_per_save = 1000;

% For Histogram
number_of_sections = 2000;
% For Recurrence
position = [1,1,1];     % Must be between 0 and 2pi
radius_recurrence = 1;  % Must be less than 2pi
% For Lyapunov
sqrt_num_starting_points = 21;

% Define animation parameters, or for error plots (varying is always 1 for
% error)
frames = 2;
varying = 5;
min_animation = 100; max_animation = 200;
% varying: 1 = number
%          2 = A1
%          3 = second_order_coefficient
%          4 = mixing of ABC1
%          5 = ratio
%          6 = number & step size

% For error plot only
simulation_length = 5;

% For particle properties
ratio = 100; % this specifies the magnetic field strength, given v,q,m.
% vx0_nn = 3;
% vy0_nn = 4;
% vz0_nn = 0.0001; % Components of v will be normalised
speed = 1;
v = B_field_all(x0,y0,z0,field_choice,A1,B1,C1,lambda1,...
       A2,B2,C2,lambda2,'true',field_choice_vector);
vx0_nn = v(1);
vy0_nn = v(2);
vz0_nn = v(3);

particle_charge = 1; % charge in terms of e
particle_mass = 0.511e6; % mass in MeV/c^2

vx0 = speed*vx0_nn/sqrt(vx0_nn^2 + vy0_nn^2 + vz0_nn^2);
vy0 = speed*vy0_nn/sqrt(vx0_nn^2 + vy0_nn^2 + vz0_nn^2);
vz0 = speed*vz0_nn/sqrt(vx0_nn^2 + vy0_nn^2 + vz0_nn^2);

master_function(x0,y0,z0,vx0,vy0,vz0,field_choice,method_choice,A1,B1,C1,...
                    lambda1,A2,B2,C2,lambda2,ds,number,output,radius,iterations,...
                    number_per_save,num_colours,number_of_sections,path_name,position,...
                    radius_recurrence,sqrt_num_starting_points,varying,...
                    min_animation,max_animation,frames,ratio,...
                    field_choice_vector,simulation_length);
clear('all');
fclose all;