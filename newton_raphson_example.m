function newton_raphson_example()

%to get the min/max of x3+2x2+x+1;

x=linspace(-1,1,10000);
fx = x.^3+2*x.^2+x+1;

min(fx)
close all;
plot(x,fx);

N = 100;
x = zeros(N,1); 

gamma = 0.2; 
for i = 2 : N
    f1x = 3*x(i-1)^2+4*x(i-1)+1;
    f2x = 6*x(i-1)+4; 
    x(i) = x(i-1) - gamma*f1x/f2x; 
end
x
x(N)^3+2*x(N)^2+x(N)+1

figure; 
plot(x,'-+'); 
