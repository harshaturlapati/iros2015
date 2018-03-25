function stairclimbinglocusofalllinksforx2y2x3y3()
load('x1y1andx2y2.mat')
%h=16;
l=15;
l0=3;
%d=25;
r=4.5;
x3dash=zeros(1,157);
y3dash=zeros(1,157);
for i=1:n(1,2)
    x2=x2dash(1,i);
    y2=y2dash(1,i);
    count=0;
    k=(l+l0)^2-y2^2-x2^2;
    min=inf;
    for j=1:i
        x3=x2dash(1,j);
        y3=y2dash(1,j);
        M=x3^2-2*x2*x3+y3^2-2*y2*y3;
        sigma=sqrt(abs(M^2-k^2));
        if(sigma<min)
            min=sigma;
            count=j;
        end
    end
    x3dash(1,i)=x2dash(1,count);
    y3dash(1,i)=y2dash(1,count);
   % plot([x3dash(1,i) x2dash(1,i)],[y3dash(1,i) y2dash(1,i)]);
   % axis([-10 100 0 100]);
drawnow
end
save('x2y2andx3y3.mat');
end