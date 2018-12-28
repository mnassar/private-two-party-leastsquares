format long
clf
N=50000; %Number of Iterations
a=0.02; %alpha / learning rate 
xb=csvread('ph1.csv');
xa=csvread('ph2.csv');
yb=csvread('b1.csv');
ya=csvread('b2.csv');
 
% if for linear regression, add a column of ones (x1 + theta1 x2 + ... ) 
m1=length(xb);
m2=length(xa);
xb = [ones(m1, 1) xb] ;
xa = [ones(m2, 1) xa] ;
m = m1+m2

powers = [10^4, 10^5, 10^6, 10^7, 10^8, 10^9, 10^10, 10^11, 10^12, 10^13, 10^14, 10^15];
E = zeros(1,length(powers));

i=1;
for s = powers
    [theta_real, theta_gd, rel_err] = gd (xb, xa, yb, ya, N, a, s);
    E(1,i)=rel_err;
    i=i+1;
end

loglog((powers),E,'r-.','LineWidth',1.5);
hold on;

i=1;
for s = powers
    [theta_real, theta_gd, rel_err] = gd (xb, xa, yb, ya, N*2, a, s);
    E(1,i)=rel_err;
    i=i+1;
end

loglog((powers),E,'b-+','LineWidth',1.5);
hold on;

i=1;
for s = powers
    [theta_real, theta_gd, rel_err] = gd (xb, xa, yb, ya, N*3, a, s);
    E(1,i)=rel_err;
    i=i+1;
end

loglog((powers),E,'g-*','LineWidth',1.5);
hold on;


i=1;
for s = powers
    [theta_real, theta_gd, rel_err] = gd (xb, xa, yb, ya, N*4, a, s);
    E(1,i)=rel_err;
    i=i+1;
end
loglog((powers),E,'k-o','LineWidth',1.5);
hold on;

title({'Relative Error in the norm of \theta vs. Scaling factor s';'\alpha=0.02, m=34'},'fontsize',14);
legend('N=50000','N=2*50000','N=3*50000','N=4*50000','fontsize',12)
xlabel('Scaling Factor','fontsize',12)
ylabel('Relative Error','fontsize',12);
hold off

set(gcf,'Units','Inches');
pos = get(gcf,'Position');
set(gcf,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)]);
print(gcf,'scaling_plots','-dpdf','-r0');