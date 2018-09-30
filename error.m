format long
animate = true   
N=1000000; %Number of Iterations
a=0.001; %Base alpha


%Intialize Parameters

 xb=csvread('ph1.csv');
 xa=csvread('ph2.csv');
 Y1=csvread('b1.csv');
 Y2=csvread('b2.csv');

 
 m1=length(xb);
 m2=length(xa);

n=2; % Number of variables measures
m=m1+m2;


%Bob's Data

X1=ones(m1,n); %Bobs LR matrix
X1(:,2:n)=xb; 

Xb=X1'*X1;  %Need to encrypt
Yb=X1'*Y1;
%------------

%Alice's Data

X2=ones(m2,n); %Alices LR matrix
X2(:,2:n)=xa;

Xa=X2'*X2; %Need to Encrypt
Ya=X2'*Y2;
%------------

%Finding X'X = A, X'Y=b

A = Xb + Xa;
B = Yb + Ya;

%Actual Theta

actual = inv(A)*B


%Our guess t0

t0=rand(n,1)/100 ;

%Gradient Descent Without Randomization and Protocol 
t = 6.5:0.01:9;
plot([xa; xb], [Y1; Y2], 'r*'); 
hold on; 
yt = actual(1)* ones (1, length(t)) + actual(2)*t;
plot(t, yt, 'b-');
tN=t0;
hold on; 

for i=1:N+1
    tN=tN-(a/m)*(A*tN-B);     
    yt = tN(1)*ones(1,length(t)) + tN(2)*t;
    if (animate && mod(i, 1000) == 0 )  
      p = plot (t, yt, 'ko');
      pause(0.00001)
      delete(p) 
    end      
end
p = plot (t, yt, 'k+');


error1 = norm(actual-tN)/norm(actual)
tN
error2 = norm ([X1; X2]  * actual - [Y1; Y2], 2)
error3 = norm ([X1; X2]  * tN - [Y1; Y2], 2) 