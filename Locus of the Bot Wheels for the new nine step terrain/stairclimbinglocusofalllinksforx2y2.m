function stairclimbinglocusofalllinksforx2y2()
%%
%%%%%%%LOCUS OF FIRST WHEEL DONE
%{
x1=1:0.1:50;
n=size(x1);
y1=linspace(3,3,n(1,2));

y2=3:0.1:13;
n=size(y2);
x2=linspace(50,50,n(1,2));

x3=50:0.1:70;
n=size(x3);
y3=linspace(13,13,n(1,2));

y4=13:0.1:23;
n=size(y4);
x4=linspace(70,70,n(1,2));

x5=70:0.1:90;
n=size(x5);
y5=linspace(23,23,n(1,2));

y6=23:0.1:33;
n=size(y6);
x6=linspace(90,90,n(1,2));

x7=90:0.1:110;
n=size(x7);
y7=linspace(33,33,n(1,2));

y8=33:0.1:43;
n=size(y8);
x8=linspace(110,110,n(1,2));

x9=110:0.1:130;
n=size(x9);
y9=linspace(43,43,n(1,2));

%HAD h=10 and w=20
%}

%NEED h=12 and w=18

x1=1:0.01:50;
n=size(x1);
y1=linspace(4.5,4.5,n(1,2));

y2=4.5:0.01:4.5+12;
n=size(y2);
x2=linspace(50,50,n(1,2));

x3=50:0.01:50+18;
n=size(x3);
y3=linspace(4.5+12,4.5+12,n(1,2));

y4=4.5+12:0.01:4.5+12+12;
n=size(y4);
x4=linspace(50+18,50+18,n(1,2));

x5=50+18:0.01:50+18+18;
n=size(x5);
y5=linspace(4.5+12+12,4.5+12+12,n(1,2));

y6=4.5+12+12:0.01:4.5+12+12+12;
n=size(y6);
x6=linspace(50+18+18,50+18+18,n(1,2));

x7=50+18+18:0.01:50+18+18+18;
n=size(x7);
y7=linspace(4.5+12+12+12,4.5+12+12+12,n(1,2));

y8=4.5+12+12+12:0.01:4.5+12+12+12+12;
n=size(y8);
x8=linspace(50+18+18+18,50+18+18+18,n(1,2));

x9=50+18+18+18:0.01:50+18+18+18+18;
n=size(x9);
y9=linspace(4.5+12+12+12+12,4.5+12+12+12+12,n(1,2));

x=[x1 x2 x3 x4 x5 x6 x7 x8 x9];
y=[y1 y2 y3 y4 y5 y6 y7 y8 y9];
%plot(x,y)

%%%%%%%LOCUS OF FIRST WHEEL DONE
%%
n=size(x);
l=15;
l0=3;
d=25;
r=3;
x2dash=zeros(1,n(1,2));
y2dash=zeros(1,n(1,2));
for i=1:n(1,2)
    
    x2d=x(1,i);
    y2d=y(1,i);
    count=0;
    k=(l+l0)^2-y2d^2-x2d^2;
    min=inf;
    for j=1:i
        x3=x(1,j);
        y3=y(1,j);
        M=x3^2-2*x2d*x3+y3^2-2*y2d*y3;
        sigma=sqrt(abs(M^2-k^2));
        if(sigma<min)
            min=sigma;
            count=j;
        end
    end
    %dummyx=x2;
    x2dash(1,i)=x(1,count);
    y2dash(1,i)=y(1,count);
    %plot([x2dash(1,i) x(1,i)],[y2dash(1,i) y(1,i)]);
    %axis([-10 500 0 500]);
    %drawnow
end
save('x1y1andx2y2.mat');
end