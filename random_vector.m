function random_vector = random_vector(seed)
rng(seed)
% Seeding needs to be done better
% At the moment, if r_v(i = k,seed = k) fails,
% and r_v(i = k, seed = k + 3) succeeds, then
% r_v(i = k + 3, seed = k + 3) will also succeed, reducing the number
% of unique paths.
x = 2*rand() - 1; rng(seed + 1)
y = 2*rand() - 1; rng(seed + 2)
z = 2*rand() - 1;
r = x^2 + y^2 + z^2;
while r > 1
    seed = seed + 1000; rng(seed)
    x = 2*rand() - 1; rng(seed + 1)
    y = 2*rand() - 1; rng(seed + 2)
    z = 2*rand() - 1;
    r = x^2 + y^2 + z^2;
end
random_vector = [x y z]./sqrt(r);
end