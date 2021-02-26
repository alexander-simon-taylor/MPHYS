x = linspace(0,5,1000);
y0 = besselj(0,x);
y1 = besselj(1,x);

graphic = figure();
plot(x,y0);
hold on;
plot(x,y1);
xlabel('\lambda*r');
ylabel('B/B_0');