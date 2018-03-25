%function [tracforce,normforce,tau]=stairs()
clc;
clear;
load('anglesdata.mat');
load('finalbotlocationsdatasets.mat');
%% All Units are SI ###########
m_w = 0.120; %wheel weight
m_l = 0.3; %link weight
mu = 1; %coefficient of friction
l = 0.15 ; %length of link
l0 = 0.03; %length of separation between two links
r = 0.045; %radius of wheel
clearance = 0.0626; %clearance
g=10; %acceleration due to gravity
W=m_w*g;
L=m_l*g;
M= W+L ; % module weight #############
x0=[0.01 0.01 0.01 0.01 0.1 0.1 0.1 0.1 0 0]; % [f1 f2 f3 f4 n1 n2 n3 n4 m1 m2]
lb=[0.01 0.01 0.01 0.01 0.1 0.1 0.1 0.1 0 0];%LOWER BOUNDS
ub=[13 13 13 13 14 14 14 14 inf inf];%UPPER BOUNDS
options = optimset('Algorithm','interior-point');
tracforce = zeros(n(1,2),4);  
normforce = zeros(n(1,2),4);
tau = zeros(n(1,2),2);
phi = zeros(n(1,2),2);
h = zeros(n(1,2),1);
springstiffnesses=zeros(n(1,2),2);

    A = [1 0 0 0 -mu 0 0 0 0 0 ;
         0 1 0 0 0 -mu 0 0 0 0 ;
         0 0 1 0 0 0 -mu 0 0 0 ;
         0 0 0 1 0 0 0 -mu 0 0 ];
    B = [0;0;0;0];
for i=1:80
    %phi1=absang1(1,i)*(pi/180);
%phi2=absang2(1,i)*(pi/180);
%phi3=absang3(1,i)*(pi/180);
   phi1 = (i/180)*3.14;
   % phi(i,1) = phi1 ;
if(i>=1 && i<6100)
     Aeq = [0 1 1 1 -1 0 0 0 0 0;                    % [f1 f2 f3 f4 n1 n2 n3 n4 tau1 tau2]
         2 0 0 0 0 2 2 2 0 0 ;
         2*l*cos(phi1)+2*r 0 0 0 2*l*sin(phi1) 0 0 0 -1 0 ;
         2*(l+l0) 2*r 0 0 0 2*l 0 0 1 -1;
         2*(l+l0) 0 2*r 2*r 0 2*(l+l0) 2*l 0 0 1];
       
    
    Beq = [0;8*W+3*L;2*W*l*cos(phi1)+ L*((l/2)*cos(phi1)-clearance*sin(phi1));(2*W*l)+L*(l/2)+(2*W+L)*(l+l0);(2*W*l)+L*(l/2)+((4*W)+(2*L))*(l+l0)];
    end
    
    if(i>6100 && i<7429)
     Aeq = [1 1 1 1 0 0 0 0 0 0;                    % [f1 f2 f3 f4 n1 n2 n3 n4 tau1 tau2]
         0 0 0 0 2 2 2 2 0 0 ;
         -2*l*sin(phi1)+2*r 0 0 0 2*l*cos(phi1) 0 0 0 -1 0 ;
         0 2*r 0 0 2*(l+l0) 2*l 0 0 1 -1;
         0 0 2*r 2*r 2*(l+l0) 2*(l+l0) 2*l 0 0 1];
       
    
    Beq = [0;8*W+3*L;2*W*l*cos(phi1)+ L*((l/2)*cos(phi1)-clearance*sin(phi1));(2*W*l)+L*(l/2)+(2*W+L)*(l+l0);(2*W*l)+L*(l/2)+((4*W)+(2*L))*(l+l0)]; 
    end
    
    if(i>7429 && i<7856)
     Aeq = [1 0 1 1 0 -1 0 0 0 0;                    % [f1 f2 f3 f4 n1 n2 n3 n4 tau1 tau2]
         0 2 0 0 2 0 2 2 0 0 ;
         2*abs(l*sin(phi1)-r) 0 0 0 2*l*cos(phi1) 0 0 0 -1 0 ;
         -2*(l+l0)*sin(phi2) 2*(r+l*cos(phi2)) 0 0 2*(l+l0)*cos(phi2) 2*l*sin(phi2) 0 0 1 -1;
         0 2*(l+l0) 2*r 2*r 2*(l+l0) 0 2*l 0 0 1];
       
    
    Beq = [0;8*W+3*L;2*W*l*cos(phi1)+ L*((l/2)*cos(phi1)-clearance*sin(phi1));(2*W*l*cos(phi2))+L*((l/2)*cos(phi2)-clearance*sin(phi2))+(2*W+L)*(l+l0)*cos(phi2);(2*W*l)+L*(l/2)+((4*W)+(2*L))*(l+l0)]; 
    end
    if(i>=7856 && i<9141)
     Aeq = [0 1 1 1 -1 0 0 0 0 0;                    % [f1 f2 f3 f4 n1 n2 n3 n4 tau1 tau2]
         2 0 0 0 0 2 2 2 0 0 ;
         2*l*cos(phi1)+2*r 0 0 0 2*l*sin(phi1) 0 0 0 -1 0 ;
         2*(l+l0)*cos(phi2) 2*abs(r-l*sin(phi2)) 0 0 2*(l+l0)*cos(phi2) 2*l*cos(phi2) 0 0 1 -1;
         2*(l+l0) 0 2*r 2*r 0 2*(l+l0) 2*l 0 0 1];
       
    
    Beq = [0;8*W+3*L;2*W*l*cos(phi1)+ L*((l/2)*cos(phi1)-clearance*sin(phi1));(2*W*l*cos(phi2))+L*((l/2)*cos(phi2)-clearance*sin(phi2))+(2*W+L)*cos(phi2)*(l+l0);(2*W*l)+L*(l/2)+((4*W)+(2*L))*(l+l0)];
    end
    
    if(i>=9141 && i<9984)
     Aeq = [1 1 1 1 0 0 0 0 0 0;                    % [f1 f2 f3 f4 n1 n2 n3 n4 tau1 tau2]
         0 0 0 0 2 2 2 2 0 0 ;
         -2*l*sin(phi1)+2*r 0 0 0 2*l*cos(phi1) 0 0 0 -1 0 ;
         2*(l+l0)*sin(phi2) 2*abs(r-l*sin(phi2)) 0 0 2*(l+l0)*cos(phi2) 2*l*cos(phi2) 0 0 1 -1;
         0 0 2*r 2*r 2*(l+l0) 2*(l+l0) 2*l 0 0 1];
       
    
    Beq = [0;8*W+3*L;2*W*l*cos(phi1)+ L*((l/2)*cos(phi1)-clearance*sin(phi1));(2*W*l*cos(phi2))+L*((l/2)*cos(phi2)-clearance*sin(phi2))+(2*W+L)*cos(phi2)*(l+l0);(2*W*l)+L*(l/2)+((4*W)+(2*L))*(l+l0)];
    end
    
    if(i>=9984 && i<10414)
     Aeq = [1 1 0 1 0 0 -1 0 0 0;                    % [f1 f2 f3 f4 n1 n2 n3 n4 tau1 tau2]
         0 0 2 0 2 2 0 2 0 0 ;
         -2*l*sin(phi1)+2*r 0 0 0 2*l*cos(phi1) 0 0 0 -1 0 ;
         2*(l+l0)*sin(phi2) 2*abs(r-l*sin(phi2)) 0 0 2*(l+l0)*cos(phi2) 2*l*cos(phi2) 0 0 1 -1;
         -2*(l+l0)*sin(phi3) -2*(l+l0)*sin(phi3) 2*(r+l*cos(phi3)) 2*r 2*(l+l0)*cos(phi3) 2*(l+l0)*cos(phi3) 2*l*sin(phi3) 0 0 1];
       
    
    Beq = [0;8*W+3*L;2*W*l*cos(phi1)+ L*((l/2)*cos(phi1)-clearance*sin(phi1));(2*W*l*cos(phi2))+L*((l/2)*cos(phi2)-clearance*sin(phi2))+(2*W+L)*cos(phi2)*(l+l0);(2*W*l*cos(phi3))+L*((l/2)*cos(phi3)-clearance*sin(phi3))+((4*W)+(2*L))*(l+l0)*cos(phi3)];
    end
     if(i>=10414 && i<10892)
     Aeq = [1 0 1 1 0 -1 0 0 0 0;                    % [f1 f2 f3 f4 n1 n2 n3 n4 tau1 tau2]
            0 2 0 0 2 0 2 2 0 0 ;
          -2*l*sin(phi1)+2*r 0 0 0 2*l*cos(phi1) 0 0 0 -1 0 ;
        -2*(l+l0)*sin(phi2) 2*(r+l*cos(phi2)) 0 0 2*(l+l0)*cos(phi2) 2*l*sin(phi2) 0 0 1 -1;
         -2*(l+l0)*sin(phi3) 2*(l+l0)*cos(phi3) -2*abs(r-l*sin(phi3)) 2*r 2*(l+l0)*cos(phi3) 2*(l+l0)*sin(phi3) 2*l*sin(phi3) 0 0 1];
       
    
    Beq = [0;8*W+3*L;2*W*l*cos(phi1)+ L*((l/2)*cos(phi1)-clearance*sin(phi1));(2*W*l*cos(phi2))+L*((l/2)*cos(phi2)-clearance*sin(phi2))+(2*W+L)*(l+l0)*cos(phi2);(2*W*l*cos(phi3))+L*((l/2)*cos(phi3)-clearance*sin(phi3))+((4*W)+(2*L))*(l+l0)*cos(phi3)];
    end
    
    ceq=[];
    c=[];
    if(i>1)
         x = fmincon(@(x) norm([x(9),x(10)]-tau(i-1,:)),x0,A,B,Aeq,Beq,lb,ub,[ceq,c],options);   
    else
    if(i==1)
        x = fmincon(@(x) norm([x(9),x(10)]),x0,A,B,Aeq,Beq,lb,ub,[ceq,c],options);
    end
    end
    x0=x;
    tracforce(i,:) = [x(1),x(2),x(3),x(4)];
    normforce(i,:) = [x(5),x(6),x(7),x(8)];
    tau(i,:) = [x(9), x(10)];
    phi(i,:)=[ang1(1,i), ang2(1,i)];
end
%display(tracforce)  
%display(normforce)

figure(1);
subplot(2,2,1);plot(phi(1:80,1));ylabel('angle - phi1');
subplot(2,2,2);
plot(phi(1:80,2));ylabel('angle - phi2');
subplot(2,2,3);scatter(phi(1:80,1),tau(1:80,1));ylabel('tau1');xlabel('phi1');
subplot(2,2,4);scatter(phi(1:80,2),tau(1:80,2));ylabel('tau2');xlabel('phi2');

%{
figure(1);
subplot(2,2,1);plot(phi(1:n(1,2),1));ylabel('angle - phi1');
subplot(2,2,2);
plot(phi(1:n(1,2),2));ylabel('angle - phi2');
subplot(2,2,3);scatter(phi(1:n(1,2),1),tau(1:n(1,2),1));ylabel('tau1');xlabel('phi1');
subplot(2,2,4);scatter(phi(1:n(1,2),2),tau(1:n(1,2),2));ylabel('tau2');xlabel('phi2');
figure(2);
subplot(1,2,1);plot(tau(:,1));ylabel('tau1');xlabel('iteration');
subplot(1,2,2);plot(tau(:,2));ylabel('tau2');xlabel('iteration');
figure(3);
subplot(2,2,1);plot(tracforce(:,1));ylabel('tracforce1');xlabel('iteration');
subplot(2,2,2);plot(tracforce(:,2));ylabel('tracforce2');xlabel('iteration');
subplot(2,2,3);plot(tracforce(:,3));ylabel('tracforce3');xlabel('iteration');
subplot(2,2,4);plot(tracforce(:,4));ylabel('tracforce4');xlabel('iteration');
figure(4);
subplot(2,2,1);plot(normforce(:,1));ylabel('normforceforce1');xlabel('iteration');
subplot(2,2,2);plot(normforce(:,2));ylabel('normforceforce2');xlabel('iteration');
subplot(2,2,3);plot(normforce(:,3));ylabel('normforceforce3');xlabel('iteration');
subplot(2,2,4);plot(normforce(:,4));ylabel('normforceforce4');xlabel('iteration');


1:6100
6100:7429
7429:7856
7856:9141
9141:9984
9984:10414
10414:10892

a=[1 6100 7429 7856 9141 9984 10414];
b=[6100 7429 7856 9141 9984 10414 10892];

for i=1:7
figure(i);
aa=a(1,i);
bb=b(1,i);
subplot(3,2,1);plot(tau(aa:bb,1));ylabel('tau1');xlabel('iteration');
subplot(3,2,2);plot(tau(aa:bb,2));ylabel('tau2');xlabel('iteration');
subplot(3,2,3);plot(phi(aa:bb,1));ylabel('angle - phi1');
subplot(3,2,4);plot(phi(aa:bb,2));ylabel('angle - phi2');
subplot(3,2,5);scatter(phi(aa:bb,1),tau(aa:bb,1));ylabel('tau1');xlabel('phi1');
subplot(3,2,6);scatter(phi(aa:bb,2),tau(aa:bb,2));ylabel('tau2');xlabel('phi2');
end
%}