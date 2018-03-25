function locusanimation()

x1=1:0.01:50+4.5;
n=size(x1);
y1=linspace(0,0,n(1,2));

y2=0:0.01:12;
n=size(y2);
x2=linspace(50+4.5,50+4.5,n(1,2));

x3=50+4.5:0.01:50+18+4.5;
n=size(x3);
y3=linspace(12,12,n(1,2));

y4=12:0.01:12+12;
n=size(y4);
x4=linspace(4.5+50+18,4.5+50+18,n(1,2));

x5=4.5+50+18:0.01:4.5+50+18+18;
n=size(x5);
y5=linspace(12+12,12+12,n(1,2));

y6=12+12:0.01:12+12+12;
n=size(y6);
x6=linspace(4.5+50+18+18,4.5+50+18+18,n(1,2));

x7=4.5+50+18+18:0.01:4.5+50+18+18+18;
n=size(x7);
y7=linspace(12+12+12,12+12+12,n(1,2));

y8=12+12+12:0.01:12+12+12+12;
n=size(y8);
x8=linspace(4.5+50+18+18+18,4.5+50+18+18+18,n(1,2));

x9=4.5+50+18+18+18:0.01:4.5+50+18+18+18+18;
n=size(x9);
y9=linspace(12+12+12+12,12+12+12+12,n(1,2));


xx=[x1 x2 x3 x4 x5 x6 x7 x8 x9];
yy=[y1 y2 y3 y4 y5 y6 y7 y8 y9];


load('x1y1andx2y2.mat');
load('x2y2andx3y3.mat');
load('x3y3andx4y4.mat');
load('anglesdata.mat');
l = 11 ; %length of link
l0 = 4; %length of separation between two links
c=6.26;
for i=5000:n(1,2)
  
   %{ 
    k=x(1,i)-c*cos((pi/180)*(absang1(1,i)));
     l=y(1,i)+c*sin((pi/180)*(absang1(1,i)));
     k21=x2dash(1,i)-c*cos((pi/180)*(absang1(1,i)));
     l21=y2dash(1,i)+c*sin((pi/180)*(absang1(1,i)));
     k22=x2dash(1,i)-c*cos((pi/180)*(absang2(1,i)));
     l22=y2dash(1,i)+c*sin((pi/180)*(absang2(1,i)));
     k31=x2dash(1,i)-c*cos((pi/180)*(absang2(1,i)));
     l31=y3dash(1,i)+c*sin((pi/180)*(absang2(1,i)));
     k32=x3dash(1,i)-c*cos((pi/180)*(absang3(1,i)));
     l32=y3dash(1,i)+c*sin((pi/180)*(absang3(1,i)));
     k4=x4dash(1,i)-c*cos((pi/180)*(absang3(1,i)));
     l4=y4dash(1,i)+c*sin((pi/180)*(absang3(1,i)));
     %}
     plot(xx,yy);hold on;
     plot([x2dash(1,i) x(1,i)],[y2dash(1,i) y(1,i)],[x3dash(1,i) x2dash(1,i)],[y3dash(1,i) y2dash(1,i)],[x4dash(1,i) x3dash(1,i)],[y4dash(1,i) y3dash(1,i)]);
     %plot([k k21],[l l21],[k22 k31],[l22 l31],[k32 k4],[l32 l4]);
    centers=[x2dash(1,i) y2dash(1,i);x(1,i) y(1,i);x2dash(1,i) y2dash(1,i);x3dash(1,i) y3dash(1,i); x4dash(1,i) y4dash(1,i)];
    radius=[17;4.5; 4.5; 4.5; 4.5];
    viscircles(centers,radius);
    hold off;
    axis([0 120 0 120]);
   drawnow;
end
save('finalbotlocationsdatasets.mat','n','x2dash','x','y2dash','y','x3dash','x2dash','y3dash','y2dash','x4dash','x3dash','y4dash','y3dash');
end
