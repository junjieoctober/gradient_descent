function gradientdesc_example_rosenbrock()
%https://en.wikipedia.org/wiki/Gradient_descent#Examples
% Rosenbrock function
dx = 0.5; 
dy = 0.5;
[X,Y] = meshgrid(-0.8:.02:1.2, -0.8:.02:1.2);
Z =  (1-X).^2+100*(Y-X.^2).^2; 


close all; 
surf(X,Y,Z);

figure; 
[C,h] = contour(X,Y,Z,30); 
clabel(C,h); 
grid on;
hold on; 


gamma = .05;
N = 1000; 
t = zeros(N,2); 
t(1,1) = -0.5;
t(1,2) = 0.5; 

format long g; 

for k = 2 : N
    x = t(k-1,1);
    y = t(k-1,2); 
    z = (1-x)^2 + 100*(y-x^2)^2; 
    dzdx = 2*(x-1) + 200*(x^2-y)*2*x;
    dzdy = 200*(y-x^2);
    
    dzdzdxdx = 2+400*(x^2-y)+800*x*x; 
    dzdzdxdy = -400*x; 
    dzdzdydx = -400*x; 
    dzdzdydy = 200; 
    
    H = [dzdzdxdx dzdzdxdy; dzdzdydx dzdzdydy];
    Hinv = inv(H); 
    %display(det(Hinv));
    %corr = Hinv*[dzdx dzdy]';
    corr = [dzdx dzdy]'/sqrt(dzdx^2 + dzdy^2);
    t(k,:) = t(k-1,:) - gamma*corr';
    t(k,:),dzdx,dzdy,z

end
[px,py]= gradient(Z,dx,dy); 
plot(t(:,1),t(:,2),'-*');
quiver(X,Y,px,py); 


