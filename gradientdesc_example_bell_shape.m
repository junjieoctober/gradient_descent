function gradientdesc_example_bell_shape()
%applied to F(x,y)=exp(-10*x^2-y^2)

dx = 0.1;
dy = 0.1; 
sx = 2; 
[X,Y] = meshgrid(-1:dx:1, -1:dy:1);
Z =  exp(-sx*X.^2-Y.^2); 


close all; 
surf(X,Y,Z);

figure; 
[C,h] = contour(X,Y,Z); 
clabel(C,h); 
grid on;
hold on; 

gamma = .01;
N = 50; 
t = zeros(N,2); 
t(1,1) = -.5;
t(1,2) = .5; 

format long g; 

for k = 2 : N
    x = t(k-1,1);
    y = t(k-1,2);
    z = exp(-sx*x^2-y^2); 
    
    
    dzdx = -2*sx*x*z;  
    dzdy = -2*y*z; 
    
    %Z =  sin(0.5*X.^2-0.25*Y.^2+3).*cos(2*X+1-exp(Y)); 
    dzdzdxdx = 4*sx*sx*x*x*z-2*sx*z; 
    dzdzdxdy = 4*sx*x*y*z; 
    dzdzdydx = dzdzdxdy; 
    dzdzdydy = 4*y*y*z-2*z; 
    H = [dzdzdxdx dzdzdxdy; dzdzdydx dzdzdydy];
    display(det(H)); 
    Hinv = inv(H); 
    %corr = Hinv*[dzdx dzdy]';
    %t(k,:) = t(k-1,:) + sign(-det(H))*gamma*corr';
    corr = [dzdx dzdy]'/sqrt(dzdx^2+dzdy^2);
    t(k,:) = t(k-1,:) + gamma*corr';
    
    t(k,:),z,dzdx, dzdy
    
end

[px,py]= gradient(Z,dx,dy); 
plot(t(:,1),t(:,2),'-*');
quiver(X,Y,px,py); 

axis square;


