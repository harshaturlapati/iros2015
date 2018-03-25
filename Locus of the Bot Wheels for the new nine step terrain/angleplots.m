function angleplots()
load('finalbotlocationsdatasets.mat');
ang1=zeros(n);
ang2=zeros(n);
absang1=zeros(n);
absang2=zeros(n);
    for i=1:n(1,2)
        absang1(1,i)=atan((y(1,i)-y2dash(1,i))/((x(1,i)-x2dash(1,i))))*(180/pi);
        absang2(1,i)=atan((y2dash(1,i)-y3dash(1,i))/((x2dash(1,i)-x3dash(1,i))))*(180/pi);
        absang3(1,i)=atan((y3dash(1,i)-y4dash(1,i))/((x3dash(1,i)-x4dash(1,i))))*(180/pi);
        ang1(1,i)=absang1(1,i)-absang2(1,i);
        ang2(1,i)=absang2(1,i)-absang3(1,i);
    end
    figure();
    subplot(1,2,1);
    plot(ang1);
    subplot(1,2,2);
    plot(ang2);
    save('anglesdata.mat','ang1','ang2','absang1','absang2','absang3');
end