function stairclimbinglocusofalllinksforx3y3x4y4()
load('x2y2andx3y3.mat')
%h=16;
l=15;
l0=3;
%d=25;
r=4.5;
x4dash=zeros(1,157);
y4dash=zeros(1,157);
for i=1:n(1,2)
    x3=x3dash(1,i);
    y3=y3dash(1,i);
    count=0;
    k=(l+l0)^2-y3^2-x3^2;
    min=inf;
    for j=1:i
        x4=x3dash(1,j);
        y4=y3dash(1,j);
        M=x4^2-2*x3*x4+y4^2-2*y3*y4;
        sigma=sqrt(abs(M^2-k^2));
        if(sigma<min)
            min=sigma;
            count=j;
        end
    end
    x4dash(1,i)=x3dash(1,count);
    y4dash(1,i)=y3dash(1,count);
 %   plot([x4dash(1,i) x3dash(1,i)],[y4dash(1,i) y3dash(1,i)]);
    %axis([-10 100 0 100]);
%drawnow
end
save('x3y3andx4y4.mat');
end