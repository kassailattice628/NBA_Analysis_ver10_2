figure3 = figure('Color','w');

Bmat = B1(:,selectdraw);
Bmat_mean = mean(Bmat,2);
plot(t,Bmat_mean,'r'); 

axis([tmin tmax Vmin Vmax]);