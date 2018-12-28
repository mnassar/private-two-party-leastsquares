N=50000*2; %Number of Iterations
a=0.01; %alpha / learning rate 

%read data from csv 

xb=csvread('ph1.csv');
xa=csvread('ph2.csv');
yb=csvread('b1.csv');
ya=csvread('b2.csv');
 
s = 10^4;

% if for linear regression, add a column of ones (x1 + theta1 x2 + ... ) 
 
m1=length(xb);
m2=length(xa);
xb = [ones(m1, 1) xb] ;
xa = [ones(m2, 1) xa] ;

[theta_real, theta_gd, rel_err] = gd (xb, xa, yb, ya, N, a, s)