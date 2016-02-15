
lpv4=insv';
lpv3=fix(lpv4/1000*fs);

m=find(selectdraw == n);
hspikes(1,m) = {lpv4};


figure(2);
subplot(3,1,1);plot(t,B(:,n),'b')
hold on
subplot(3,1,1);plot(lpv4,B(lpv3,n),'m*'); 
hold off



