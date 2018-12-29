E = 2.1/1000; 
D = 1.9/1000; 
AC = 1.9/1000; 
ME = 1.9/1000; 
MI = 0.2/10000; 
MM = 0.05/10000; 
clf

n = 2:10;
N = 5000; 
time_Alice_r = n.^2 * ( MM + ME ) + n * ( 2*MM + MI + E + D ); 
time_Bob_r = n * ( D + E + MM ); 

time_Alice_s = n.^2 * ( ME + 2*MM ) + n * ( MI + 3 * MM ) ; 
time_Bob_s = n.^2 * E + n * ( E+D ) ;

time_Alice = time_Alice_s + N * time_Alice_r; 
time_Bob = time_Bob_s + N * time_Bob_r; 


plot(n, time_Bob,'r-.','LineWidth',1.5);
hold on; 
plot(n, time_Alice, 'g-*','LineWidth',1.5); 
hold on; 
plot(n, time_Bob + time_Alice, 'b-+','LineWidth',1.5); 

legend('Bob time', 'Alice time', 'Total time','fontsize',12);
title({'Crypto time is quadratic in n';'N = 5000'},'fontsize',14);
xlabel('n = Dimesion of \theta','fontsize',12)
ylabel('Time (seconds)','fontsize',12);
hold off

set(gcf,'Units','Inches');
pos = get(gcf,'Position');
set(gcf,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)]);
print(gcf,'crypto_time','-dpdf','-r0');
