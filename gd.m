function [theta_exact, theta_gd, rel_err] = gd (xb,xa,yb,ya, N, a,s)
%xb bob's data; yb: bob labels 
%xa alice's data; ya: alice labels 
%N: nb of iterations 
%a: alpha : learning rate 
%s: scaling factor 
%returns: theta_real: exact solution theta,  theta_gd : gradient descent
%theta, rel_err: relative error in theta 

m1=length(xb);
m2=length(xa);
m=m1+m2;

% exact solution 
A =  xb'*xb + xa'*xa;
b = xb'*yb + xa'*ya;
theta_exact = A\b;
n = length (theta_exact); % dimension of the theta 

%encode 
xb= round(xb * s);
xa = round(xa * s);
Xb=  xb'*xb; % encoded with s^2 
Xa= xa'* xa ; % endoded with s^2 
X = Xa + Xb; 

yb = round (yb * s^2);
ya = round (ya * s^2);

yb = xb'*yb; % encoded with 3s 
ya = xa'*ya; % encoded with 3s 
y = ya + yb; 

%initial guess
 theta_gd=round(rand(n,1)*s); % encoded with s 

%iterate 
for i=1:N+1
    % decode
     grad = (X*theta_gd - y)/(s^3);
     % update
     theta_gd = theta_gd/s - (a/m) * grad;
     
     % encode 
     theta_gd = round (theta_gd * s);
end 

 theta_gd = theta_gd/s;
 rel_err = norm(theta_gd - theta_exact)/norm(theta_exact);