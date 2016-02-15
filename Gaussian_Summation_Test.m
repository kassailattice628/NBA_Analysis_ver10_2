%ÉKÉEÉVÉAÉìë´ÇµçáÇÌÇπ


x_plot = linspace(-400,400,100);
beta_r = [1,0,50,0.5,1.5];

beta_r1 = [1,-100,50,0.5,1.5];
beta_r2 = [1,-50,50,0.5,1.5];
beta_r3 = [1,50,50,0.5,1.5];
beta_r4 = [1,100,50,0.5,1.5];

Y = Gaussian1D(beta_r,x_plot);
Y1 = Gaussian1D(beta_r1,x_plot);
Y2 = Gaussian1D(beta_r2,x_plot);
Y3 = Gaussian1D(beta_r3,x_plot);
Y4 = Gaussian1D(beta_r4,x_plot);

figure;
plot(x_plot,Y);hold on
plot(x_plot,Y1);
plot(x_plot,Y2);
plot(x_plot,Y3);
plot(x_plot,Y4);

plot(x_plot, Y+Y1+Y2+Y3+Y4,'r');

%%
ROI_Pokar = csvread('SC2_ROI_Polar2.csv');
x_plot = 0:250;
szr = yn(:,1);
beta_r = [0.1,0,300];%[Amp0, x0, xsd0, Amp1, xsd1]
lb_r = [0,-10,0];
ub_r = [1,10,250];

[beta_r1,~, residual] = lsqcurvefit(@Gaussian1D, beta_r,ROI_Polar(OGB,2),szr(OGB), lb_r, ub_r);
Z_fit_r = Gaussian1D(beta_r1,x_plot);

szr = yn(:,2);
beta_r = [0.1,0,300,0,1];%[Amp0, x0, xsd0, Amp1, xsd1]
lb_r = [0,-10,0,0,0.001];
ub_r = [1,10,250,1,10];

[beta_r2,~, residual] = lsqcurvefit(@Gaussian1D, beta_r,ROI_Polar(OGB,2),szr(OGB), lb_r, ub_r);
Z_fit_r2 = Gaussian1D(beta_r2,x_plot);
szr = yn(:,3);
[beta_r3,~, residual] = lsqcurvefit(@Gaussian1D, beta_r,ROI_Polar(OGB,2),szr(OGB), lb_r, ub_r);
Z_fit_r3 = Gaussian1D(beta_r3,x_plot);

szr = yn(:,4);
[beta_r4,~, residual] = lsqcurvefit(@Gaussian1D, beta_r,ROI_Polar(OGB,2),szr(OGB), lb_r, ub_r);
Z_fit_r4 = Gaussian1D(beta_r4,x_plot);

szr = yn(:,5);
[beta_r5,~, residual] = lsqcurvefit(@Gaussian1D, beta_r,ROI_Polar(OGB,2),szr(OGB), lb_r, ub_r);
Z_fit_r5 = Gaussian1D(beta_r5,x_plot);

%%
figure;
subplot(5,1,1);plot(ROI_Polar(OGB,2),yn(OGB,1), 'b.');hold on
plot(x_plot,Z_fit_r);

subplot(5,1,2);plot(ROI_Polar(OGB,2),yn(OGB,2), 'c.');hold on
plot(x_plot,Z_fit_r2);
subplot(5,1,3);plot(ROI_Polar(OGB,2),yn(OGB,3), 'g.');hold on
plot(x_plot,Z_fit_r3);
subplot(5,1,4);plot(ROI_Polar(OGB,2),yn(OGB,4), 'y.');hold on
plot(x_plot,Z_fit_r4);
subplot(5,1,5);plot(ROI_Polar(OGB,2),yn(OGB,5), 'r.');hold on
plot(x_plot,Z_fit_r5);


