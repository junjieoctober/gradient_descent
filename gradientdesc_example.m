function gradientdesc_example_2()
%https://en.wikipedia.org/wiki/Gradient_descent#Examples
%applied to F(x,y)=\sin\left(\frac{1}{2} x^2 - \frac{1}{4} y^2 + 3 \right) \cos(2 x+1-e^y).

dx = 0.04;
dy = 0.04; 
[X,Y] = meshgrid(-0.6:dx:0.6, -0.6:dy:2);
Z =  sin(0.5*X.^2-0.25*Y.^2+3).*cos(2*X+1-exp(Y)); 


close all; 
surf(X,Y,Z);

figure; 
[C,h] = contour(X,Y,Z); 
clabel(C,h); 
grid on;
hold on; 

gamma = .1;
N = 200; 
t = zeros(N,2); 
t(1,1) = -0.2;
t(1,2) = 0.3; 

format long g; 

for k = 2 : N
    x = t(k-1,1);
    y = t(k-1,2);
    left    = 0.5*x.^2-0.25*y.^2+3;
    right   = 2*x+1-exp(y); 
    z = sin(left)*cos(right);
    
    dzdx = cos(left)*cos(right)*x -sin(left)*sin(right)*2; 
    dzdy = cos(left)*cos(right)*(-0.5*y)-sin(left)*sin(right)*(-exp(y));  
    %Z =  sin(0.5*X.^2-0.25*Y.^2+3).*cos(2*X+1-exp(Y)); 
    dzdzdxdx = cos(left)*cos(right)-4*sin(left)*cos(right)-x^2*sin(left)*cos(right)-4*x*cos(left)*sin(right); 
    dzdzdxdy = 2*sin(left)*exp(y)*cos(right)+y*cos(left)*sin(right)+(x*y*sin(left)*cos(right)/2)+x*cos(left)*exp(y)*sin(right); 
    dzdzdydx = dzdzdxdy; 
    dzdzdydy = sin(left)*exp(y)*sin(right)-y^2*sin(left)*cos(right)/4-cos(left)*cos(right)/2-sin(left)*exp(2*y)*cos(right)-y*cos(left)*exp(y)*sin(right); 
    
    H = [dzdzdxdx dzdzdxdy; dzdzdydx dzdzdydy];
    Hinv = inv(H); 
    %corr = Hinv*[dzdx dzdy]';
    corr = [dzdx dzdy]';
    t(k,:) = t(k-1,:) - gamma*corr';
    t(k,:),dzdx, dzdy,z
end

[px,py]= gradient(Z,dx,dy); 
plot(t(:,1),t(:,2),'-*');
quiver(X,Y,px,py); 
min(Z(:))


