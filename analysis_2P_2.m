Diff50_3691215 = [];
mod50_3691215 = [];
dist50_3691215 = [];
ID = [];
mean_diff = [];
mean_mod = [];
%%
%130909WT/depth4, SC17      depth:176.6μm
cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/130909WT/depth4');
Diff50 = csvread('SC17_diff_50.csv');
Diff50_3691215 = [Diff50_3691215;Diff50];
mean_diff = mean(Diff50);
mod50 = csvread('SC17_mod_50.csv');
mod50_3691215 = [mod50_3691215;mod50];
mean_mod = mean(mod50);
dist50 = csvread('SC17_dist2_50.csv');
dist50_3691215 = [dist50_3691215;dist50];
ID = [ID;ones(length(Diff50),1)];

%130909WT/depth5, SC21     depth:88.47μm
cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/130909WT/depth5');
Diff50 = csvread('SC21_diff_50.csv');
Diff50_3691215 = [Diff50_3691215;Diff50];
mean_diff = [mean_diff; mean(Diff50)];
mod50 = csvread('SC21_mod_50.csv');
mod50_3691215 = [mod50_3691215;mod50];
mean_mod = [mean_mod; mean(mod50)];
dist50 = csvread('SC21_dist2_50.csv');
dist50_3691215 = [dist50_3691215;dist50];
ID = [ID;2*ones(length(Diff50),1)];

%130906WT/depth2, SC13     depth:104μm
cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/130906WT/depth2');
Diff50 = csvread('SC13_diff_50.csv');
Diff50_3691215 = [Diff50_3691215;Diff50];
mean_diff = [mean_diff; mean(Diff50)];
mod50 = csvread('SC13_mod_50.csv');
mod50_3691215 = [mod50_3691215;mod50];
mean_mod = [mean_mod; mean(mod50)];
dist50 = csvread('SC13_dist2_50.csv');
dist50_3691215 = [dist50_3691215;dist50];
ID = [ID;3*ones(length(Diff50),1)];

%130906WT/depth4, SC18      depth:154μm
cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/130906WT/depth4');
Diff50 = csvread('SC18_diff_50.csv');
Diff50_3691215 = [Diff50_3691215;Diff50];
mean_diff = [mean_diff; mean(Diff50)];
mod50 = csvread('SC18_mod_50.csv');
mod50_3691215 = [mod50_3691215;mod50];
mean_mod = [mean_mod; mean(mod50)];
dist50 = csvread('SC18_dist2_50.csv');
dist50_3691215 = [dist50_3691215;dist50];
ID = [ID;4*ones(length(Diff50),1)];

%130906WT/depth5, SC21      depth:156.8μm
cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/130906WT/depth5');
Diff50 = csvread('SC21_diff_50.csv');
Diff50_3691215 = [Diff50_3691215;Diff50];
mean_diff = [mean_diff; mean(Diff50)];
mod50 = csvread('SC21_mod_50.csv');
mod50_3691215 = [mod50_3691215;mod50];
mean_mod = [mean_mod; mean(mod50)];
dist50 = csvread('SC21_dist2_50.csv');
dist50_3691215 = [dist50_3691215;dist50];
ID = [ID;5*ones(length(Diff50),1)];

%130906WT/depth6, SC24      depth:198μm
cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/130906WT/depth6');
Diff50 = csvread('SC24_diff_50.csv');
Diff50_3691215 = [Diff50_3691215;Diff50];
mean_diff = [mean_diff; mean(Diff50)];
mod50 = csvread('SC24_mod_50.csv');
mod50_3691215 = [mod50_3691215;mod50];
mean_mod = [mean_mod; mean(mod50)];
dist50 = csvread('SC24_dist2_50.csv');
dist50_3691215 = [dist50_3691215;dist50];
ID = [ID;6*ones(length(Diff50),1)];

%130906WT/depth7, SC28      depth:207μm
cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/130906WT/depth7');
Diff50 = csvread('SC28_diff_50.csv');
Diff50_3691215 = [Diff50_3691215;Diff50];
mean_diff = [mean_diff; mean(Diff50)];
mod50 = csvread('SC28_mod_50.csv');
mod50_3691215 = [mod50_3691215;mod50];
mean_mod = [mean_mod; mean(mod50)];
dist50 = csvread('SC28_dist2_50.csv');
dist50_3691215 = [dist50_3691215;dist50];
ID = [ID;7*ones(length(Diff50),1)];

%130906WT/depth8, SC30      depth:180.3μm
cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/130906WT/depth8');
Diff50 = csvread('SC30_diff_50.csv');
Diff50_3691215 = [Diff50_3691215;Diff50];
mean_diff = [mean_diff; mean(Diff50)];
mod50 = csvread('SC30_mod_50.csv');
mod50_3691215 = [mod50_3691215;mod50];
mean_mod = [mean_mod; mean(mod50)];
dist50 = csvread('SC30_dist2_50.csv');
dist50_3691215 = [dist50_3691215;dist50];
ID = [ID;8*ones(length(Diff50),1)];

%130906WT/depth10, SC35      depth:173μm
cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/130906WT/depth10');
Diff50 = csvread('SC35_diff_50.csv');
Diff50_3691215 = [Diff50_3691215;Diff50];
mean_diff = [mean_diff; mean(Diff50)];
mod50 = csvread('SC35_mod_50.csv');
mod50_3691215 = [mod50_3691215;mod50];
mean_mod = [mean_mod; mean(mod50)];
dist50 = csvread('SC35_dist2_50.csv');
dist50_3691215 = [dist50_3691215;dist50];
ID = [ID;9*ones(length(Diff50),1)];

%130819WT/depth1, SC5      depth:92μm
cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/130819WT/depth1');
Diff50 = csvread('SC5_diff_50.csv');
Diff50_3691215 = [Diff50_3691215;Diff50];
mean_diff = [mean_diff; mean(Diff50)];
mod50 = csvread('SC5_mod_50.csv');
mod50_3691215 = [mod50_3691215;mod50];
mean_mod = [mean_mod; mean(mod50)];
dist50 = csvread('SC5_dist2_50.csv');
dist50_3691215 = [dist50_3691215;dist50];
ID = [ID;10*ones(length(Diff50),1)];
%130819WT/depth1, SC8      depth:92μm
cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/130819WT/depth1');
Diff50 = csvread('SC8_diff_50.csv');
Diff50_3691215 = [Diff50_3691215;Diff50];
mean_diff = [mean_diff; mean(Diff50)];
mod50 = csvread('SC8_mod_50.csv');
mod50_3691215 = [mod50_3691215;mod50];
mean_mod = [mean_mod; mean(mod50)];
dist50 = csvread('SC8_dist2_50.csv');
dist50_3691215 = [dist50_3691215;dist50];
ID = [ID;11*ones(length(Diff50),1)];
%%
figure;
boxplot(Diff50_3691215)
s_dist = [0 3,6,9,12,15];

figure;plot(s_dist,Diff50_3691215, 'b.-');hold on
errorbar(s_dist,mean(Diff50_3691215),std(Diff50_3691215), 'r.-');
figure;
plot(s_dist(2:end), mean_diff(:,2:end),'ko-');hold on
errorbar(s_dist(2:end), mean(mean_diff(:,2:end)),std(mean_diff(:,2:end)),'r.-');




figure;
boxplot(mod50_3691215);
figure;plot(s_dist,mod50_3691215, 'b.-');hold on
errorbar(s_dist,mean(mod50_3691215),std(mod50_3691215), 'r.-');

figure;
plot(s_dist(2:end), mean_mod(:,2:end),'ko-');hold on
errorbar(s_dist(2:end), mean(mean_mod(:,2:end)),std(mean_mod(:,2:end)),'r.-');

%%
col = ['b','c','g','y','r'];
figure;hold on
for n = 1:5
    plot(dist50_3691215(:,n), Diff50_3691215(:,n+1),[col(n),'.']);
end
line([0,320],[0,0]);
xlim([0,320]);
ylim([-0.1,0.2]);

%%





%%
%P1 center から dist_set 以内のなかで P2 center からの距離がちかいもの 1/3 を選んで plot
dist_set = 100;
figure;
hold on;
%
%130909WT/depth4, SC17      depth:176.6μm, single の SD １次元では
cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/130909WT/depth4');
yn2 = csvread('SC17_peak.csv');
l = size(yn2,1);
SR = 1:89;
OGB = 90: l;
ROI_Polar = zeros(l,2,6);
ROI_Polar(:,:,1) = csvread('SC17_ROI_Polar1.csv');
ROI_Polar(:,:,2) = csvread('SC17_ROI_Polar2.csv');
ROI_Polar(:,:,3) = csvread('SC17_ROI_Polar3.csv');
ROI_Polar(:,:,4) = csvread('SC17_ROI_Polar4.csv');
ROI_Polar(:,:,5) = csvread('SC17_ROI_Polar5.csv');
ROI_Polar(:,:,6) = csvread('SC17_ROI_Polar6.csv');
%dist_centers = csvread('dist_centers2p.csv');
b_fit1 = csvread('beta_deg_all.csv');%Amp,center,SD,DC
[diff1,r_pol1,i1,i_near1] = plot2p(yn2,ROI_Polar,OGB,b_fit1);
diff1 = [diff1,ones(size(diff1,1),1)];
%
%130909WT/depth5, SC21     depth:88.47μm
cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/130909WT/depth5');
yn2 = csvread('SC21_peak.csv');
l = size(yn2,1);
SR = 1:70;
OGB = 71: l;
ROI_Polar = zeros(l,2,6);
ROI_Polar(:,:,1) = csvread('SC21_ROI_Polar1.csv');
ROI_Polar(:,:,2) = csvread('SC21_ROI_Polar2.csv');
ROI_Polar(:,:,3) = csvread('SC21_ROI_Polar3.csv');
ROI_Polar(:,:,4) = csvread('SC21_ROI_Polar4.csv');
ROI_Polar(:,:,5) = csvread('SC21_ROI_Polar5.csv');
ROI_Polar(:,:,6) = csvread('SC21_ROI_Polar6.csv');
%dist_centers = csvread('dist_centers2p.csv');
b_fit2 = csvread('beta_deg_all.csv');%Amp,center,SD,DC
[diff2,r_pol2,i2,i_near2] = plot2p(yn2, ROI_Polar,OGB,b_fit2);
diff2 = [diff2,2*ones(size(diff2,1),1)];

%130906WT/depth2, SC13     depth:104μm
cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/130906WT/depth2');
yn2 = csvread('SC13_peak.csv');
l = size(yn2,1);
SR = 1:81;
OGB = 82:l;
ROI_Polar = zeros(l,2,6);
ROI_Polar(:,:,1) = csvread('SC13_ROI_Polar1.csv');
ROI_Polar(:,:,2) = csvread('SC13_ROI_Polar2.csv');
ROI_Polar(:,:,3) = csvread('SC13_ROI_Polar3.csv');
ROI_Polar(:,:,4) = csvread('SC13_ROI_Polar4.csv');
ROI_Polar(:,:,5) = csvread('SC13_ROI_Polar5.csv');
ROI_Polar(:,:,6) = csvread('SC13_ROI_Polar6.csv');
%dist_centers = csvread('dist_centers2p.csv');
b_fit3 = csvread('beta_deg_all.csv');%Amp,center,SD,DC
[diff3,r_pol3,i3,i_near3] = plot2p(yn2, ROI_Polar,OGB,b_fit3);
diff3 = [diff3,3*ones(size(diff3,1),1)];

%130906WT/depth4, SC18      depth:154μm
cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/130906WT/depth4');
yn2 = csvread('SC17_peak.csv');
l = size(yn2,1);
%SR/OGBぶんりないので，参考として
SR = [];
OGB = 1:l;
ROI_Polar = zeros(l,2,6);
ROI_Polar(:,:,1) = csvread('SC17_ROI_Polar1.csv');
ROI_Polar(:,:,2) = csvread('SC17_ROI_Polar2.csv');
ROI_Polar(:,:,3) = csvread('SC17_ROI_Polar3.csv');
ROI_Polar(:,:,4) = csvread('SC17_ROI_Polar4.csv');
ROI_Polar(:,:,5) = csvread('SC17_ROI_Polar5.csv');
ROI_Polar(:,:,6) = csvread('SC17_ROI_Polar6.csv');
b_fit4 = csvread('beta_deg_all.csv');%Amp,center,SD,DC
[diff4,r_pol4,i4,i_near4] = plot2p(yn2, ROI_Polar,OGB,b_fit4);
diff4 = [diff4,4*ones(size(diff4,1),1)];

%130906WT/depth5, SC21      depth:156.8μm
cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/130906WT/depth5');
yn2 = csvread('SC21_peak.csv');
l = size(yn2,1);
SR = 1:89;
OGB = 90:l;
ROI_Polar = zeros(l,2,6);
ROI_Polar(:,:,1) = csvread('SC21_ROI_Polar1.csv');
ROI_Polar(:,:,2) = csvread('SC21_ROI_Polar2.csv');
ROI_Polar(:,:,3) = csvread('SC21_ROI_Polar3.csv');
ROI_Polar(:,:,4) = csvread('SC21_ROI_Polar4.csv');
ROI_Polar(:,:,5) = csvread('SC21_ROI_Polar5.csv');
ROI_Polar(:,:,6) = csvread('SC21_ROI_Polar6.csv');
%dist_centers = csvread('dist_centers2p.csv');
b_fit5 = csvread('beta_deg_all.csv');%Amp,center,SD,DC
[diff5,r_pol5,i5,i_near5] = plot2p(yn2, ROI_Polar,OGB,b_fit5);
diff5 = [diff5,5*ones(size(diff5,1),1)];

%130906WT/depth6, SC24      depth:198μm
cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/130906WT/depth6');
yn2 = csvread('SC24_peak.csv');
l = size(yn2,1);
SR = 1:102;
OGB = 103:l;
ROI_Polar = zeros(l,2,6);
ROI_Polar(:,:,1) = csvread('SC24_ROI_Polar1.csv');
ROI_Polar(:,:,2) = csvread('SC24_ROI_Polar2.csv');
ROI_Polar(:,:,3) = csvread('SC24_ROI_Polar3.csv');
ROI_Polar(:,:,4) = csvread('SC24_ROI_Polar4.csv');
ROI_Polar(:,:,5) = csvread('SC24_ROI_Polar5.csv');
ROI_Polar(:,:,6) = csvread('SC24_ROI_Polar6.csv');
%dist_centers = csvread('dist_centers2p.csv');
b_fit6 = csvread('beta_deg_all.csv');%Amp,center,SD,DC
[diff6,r_pol6,i6,i_near6] = plot2p(yn2, ROI_Polar,OGB,b_fit6);
diff6 = [diff6,6*ones(size(diff6,1),1)];

%130906WT/depth7, SC28      depth:207μm
cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/130906WT/depth7');
yn2 = csvread('SC28_peak.csv');
l = size(yn2,1);
SR = 1:131;
OGB = 132:l;
ROI_Polar = zeros(l,2,6);
ROI_Polar(:,:,1) = csvread('SC28_ROI_Polar1.csv');
ROI_Polar(:,:,2) = csvread('SC28_ROI_Polar2.csv');
ROI_Polar(:,:,3) = csvread('SC28_ROI_Polar3.csv');
ROI_Polar(:,:,4) = csvread('SC28_ROI_Polar4.csv');
ROI_Polar(:,:,5) = csvread('SC28_ROI_Polar5.csv');
ROI_Polar(:,:,6) = csvread('SC28_ROI_Polar6.csv');
%dist_centers = csvread('dist_centers2p.csv');
b_fit7 = csvread('beta_deg_all.csv');%Amp,center,SD,DC

[diff7,r_pol7,i7,i_near7] = plot2p(yn2, ROI_Polar,OGB,b_fit7);
diff7 = [diff7,7*ones(size(diff7,1),1)];

%130906WT/depth8, SC30      depth:180.3μm
cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/130906WT/depth8');
yn2 = csvread('SC30_peak.csv');
l = size(yn2,1);
SR = 1:89;
OGB = 90:l;
ROI_Polar = zeros(l,2,6);
ROI_Polar(:,:,1) = csvread('SC30_ROI_Polar1.csv');
ROI_Polar(:,:,2) = csvread('SC30_ROI_Polar2.csv');
ROI_Polar(:,:,3) = csvread('SC30_ROI_Polar3.csv');
ROI_Polar(:,:,4) = csvread('SC30_ROI_Polar4.csv');
ROI_Polar(:,:,5) = csvread('SC30_ROI_Polar5.csv');
ROI_Polar(:,:,6) = csvread('SC30_ROI_Polar6.csv');
%dist_centers = csvread('dist_centers2p.csv');
b_fit8 = csvread('beta_deg_all.csv');%Amp,center,SD,DC
[diff8,r_pol8,i8,i_near8] = plot2p(yn2, ROI_Polar,OGB,b_fit8);
diff8 = [diff8,8*ones(size(diff8,1),1)];

%130906WT/depth10, SC35      depth:173μm
cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/130906WT/depth10');
yn2 = csvread('SC35_peak.csv');
l = size(yn2,1);
SR = 1:86;
OGB = 87:l;
ROI_Polar = zeros(l,2,6);
ROI_Polar(:,:,1) = csvread('SC35_ROI_Polar1.csv');
ROI_Polar(:,:,2) = csvread('SC35_ROI_Polar2.csv');
ROI_Polar(:,:,3) = csvread('SC35_ROI_Polar3.csv');
ROI_Polar(:,:,4) = csvread('SC35_ROI_Polar4.csv');
ROI_Polar(:,:,5) = csvread('SC35_ROI_Polar5.csv');
ROI_Polar(:,:,6) = csvread('SC35_ROI_Polar6.csv');
%dist_centers = csvread('dist_centers2p.csv');
b_fit9 = csvread('beta_deg_all.csv');%Amp,center,SD,DC
[diff9,r_pol9,i9,i_near9] = plot2p(yn2, ROI_Polar,OGB,b_fit9);
diff9 = [diff9,9*ones(size(diff9,1),1)];
%%
%{
%130819WT/depth12, SC26
cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/130819WT/depth12');
yn2 = csvread('SC26_peak.csv');
l = size(yn2,1);
SR = [];
GFP =[];
OGB = 1:l;
ROI_Polar = zeros(l,2,6);
ROI_Polar(:,:,1) = csvread('SC27_ROI_Polar1.csv');
ROI_Polar(:,:,2) = csvread('SC27_ROI_Polar2.csv');
ROI_Polar(:,:,3) = csvread('SC27_ROI_Polar3.csv');
ROI_Polar(:,:,4) = csvread('SC27_ROI_Polar4.csv');
ROI_Polar(:,:,5) = csvread('SC27_ROI_Polar5.csv');
ROI_Polar(:,:,6) = csvread('SC27_ROI_Polar6.csv');
dist_centers = csvread('dist_centers2p.csv');
b_fit10 = csvread('beta_deg_all.csv');
[diff10,r_pol10,i10,i_near10] = plot2p(yn2, ROI_Polar,OGB,b_fit10);
%}


%%
%difference of gaussian で fitting してみたけど... Rsq = 0.17 とか R2
%からの距離が０にちかいところがうまくfitしてない感じ（y=1/r)てきな変化

b_fit = [b_fit1;b_fit2;b_fit3;b_fit4;b_fit5;b_fit6;b_fit7;b_fit8;b_fit9];
mean(b_fit(:,3));%78.3207
std(b_fit(:,3));%14.1298

%r1中心から100μm以内
r_pol = [r_pol1(i1,:);r_pol2(i2,:);r_pol3(i3,:);r_pol4(i4,:);r_pol5(i5,:);r_pol6(i6,:);r_pol7(i7,:);r_pol8(i8,:);r_pol9(i9,:)];
diff = [diff1(i1,:);diff2(i2,:);diff3(i3,:);diff4(i4,:);diff5(i5,:);diff6(i6,:);diff7(i7,:);diff8(i8,:);diff9(i9,:)];

mesd = picdistmean(r_pol,diff,[]);

%r1中心から100um以内かつr2中心から近いもの1/3
%r_pol = [r_pol1(i_near1,:);r_pol2(i_near2,:);r_pol3(i_near3,:);r_pol4(i_near4,:);r_pol5(i_near5,:);r_pol6(i_near6,:);r_pol7(i_near7,:);r_pol8(i_near8,:);r_pol9(i_near9,:)];
%diff = [diff1(i_near1,:);diff2(i_near2,:);diff3(i_near3,:);diff4(i_near4,:);diff5(i_near5,:);diff6(i_near6,:);diff7(i_near7,:);diff8(i_near8,:);diff9(i_near9,:)];

%距離別で比較, 50um刻みで
%0-50,50-100,100-150,,,,,350-400
mesd1 = picdistmean(r_pol1,diff1,i1);
mesd2 = picdistmean(r_pol2,diff2,i2);
mesd3 = picdistmean(r_pol3,diff3,i3);
mesd4 = picdistmean(r_pol4,diff4,i4);
mesd5 = picdistmean(r_pol5,diff5,i5);
mesd6 = picdistmean(r_pol6,diff6,i6);
mesd7 = picdistmean(r_pol7,diff7,i7);
mesd8 = picdistmean(r_pol8,diff8,i8);
mesd9 = picdistmean(r_pol9,diff9,i9);

%距離別meanとsdのまとめ
dataframe = zeros(9,size(mesd1,1));
dataframe(1,:) = mesd1(:,1);
dataframe(2,:) = mesd2(:,1);
dataframe(3,:) = mesd3(:,1);
dataframe(4,:) = mesd4(:,1);
dataframe(5,:) = mesd5(:,1);
dataframe(6,:) = mesd6(:,1);
dataframe(7,:) = mesd7(:,1);
dataframe(8,:) = mesd8(:,1);
dataframe(9,:) = mesd9(:,1);

%ddist = 50*(0:7) + 50;
ddist = 0.25*(0:23);
plot(ddist,dataframe','o-')

%%
col = cell(1,5);
col{1} = 'b.';
col{2} = 'c.';
col{3} = 'g.';
col{4} = 'y.';
col{5} = 'r.';

r = [r_pol(:,2);r_pol(:,3);r_pol(:,4);r_pol(:,5);r_pol(:,6)];
d = [diff(:,2);diff(:,3);diff(:,4);diff(:,5);diff(:,6)];
plot(r,d,'b.')

beta_r = [0.1,0,50,0.2,1];%[Amp0, x0, xsd0, Amp1, xsd1]
lb_r = [0,-10,0,0,0.1];
ub_r = [1,10,150,1,10];
x_plot = 0:380;

beta_r = [0.1,0,1,0.2,1];%[Amp0, x0, xsd0, Amp1, xsd1]
lb_r = [0,-1,0,0,0.1];
ub_r = [1,1,3,1,10];
x_plot = 0:0.01:5;

[beta_r1,~, residual] = lsqcurvefit(@Gaussian1D, beta_r,r,d, lb_r, ub_r);
Rsq = Calc_Rsq(d,residual);


Z_fit_r = Gaussian1D(beta_r1,x_plot);

figure; hold on
for n = 2:6
    plot(r_pol(:,n), diff(:,n),col{n-1})
end
%figure;plot(r,d, 'b.');
plot(x_plot, Z_fit_r, 'k');
%{
x_plot = 0:380;
b1 = [0.59,0,110.61];
b2 = [0.55,0,110.61*1.075];
Z1 = Gaussian1D(b1,x_plot);
Z2 = Gaussian1D(b2,x_plot);
figure;hold on
plot(x_plot,Z1, x_plot, -Z2, x_plot, Z1-Z2);
line([0,380],[0,0]);
%}


%% exp decay function の引き算？で近似してみるか
%{
x = 0:400;
b0 = [0.5, 100, 0.5, 200];
lb_r = [0,0,0,0];
ub_r = [1,400,1,400];

[beta_r1,~,residual] = lsqcurvefit(@diffExp, b0,r_pol(:,2),diff(:,2),lb_r, ub_r);
Rsq=Calc_Rsq(d,residual);

Z_fit_r = diffExp(beta_r1,x);
figure;hold on
plot(r_pol(:,2),diff(:,2),'b.');
plot(x, Z_fit_r,'k');

[beta_r1,~,residual] = lsqcurvefit(@diffExp, b0,r_pol(:,3),diff(:,3),lb_r, ub_r);
Rsq=Calc_Rsq(d,residual);

Z_fit_r = diffExp(beta_r1,x);
figure;hold on
plot(r_pol(:,3),diff(:,3),'b.');
plot(x, Z_fit_r,'k');


[beta_r1,~,residual] = lsqcurvefit(@diffExp, b0,r_pol(:,4),diff(:,4),lb_r, ub_r);
Rsq=Calc_Rsq(d,residual);

Z_fit_r = diffExp(beta_r1,x);
figure;hold on
plot(r_pol(:,4),diff(:,4),'b.');
plot(x, Z_fit_r,'k');


[beta_r1,~,residual] = lsqcurvefit(@diffExp, b0,r_pol(:,5),diff(:,5),lb_r, ub_r);
Rsq=Calc_Rsq(d,residual);

Z_fit_r = diffExp(beta_r1,x);
figure;hold on
plot(r_pol(:,5),diff(:,5),'b.');
plot(x, Z_fit_r,'k');

%}

%% 2nd center からの距離が near 1/    3 について

x = 0:400;
b0 = [0.1, 100, 0.1, 200];
lb_r = [0,0,0,0];
ub_r = [0.2,105,0.3,150];
[beta_r1,~,residual] = lsqcurvefit(@diffExp, b0,r,d,lb_r, ub_r);
Rsq=Calc_Rsq(d,residual);

Z_fit_r = diffExp(beta_r1,x);
figure; hold on
for n = 2:6
    plot(r_pol(:,n), diff(:,n),col{n-1})
end
plot(x, Z_fit_r,'k');
line([0,400],[0,0]);
%%
Z1 = Gaussian1D([beta_r1(1),0,beta_r1(2)],x);
Z2 = Gaussian1D([beta_r1(3),0,beta_r1(4)*beta_r1(2)],x);
plot(x,Z1,x,-Z2, x,Z1-Z2)




%%
d1 = zeros(size(i_near1,1),6);
for n = 1:5
d1(:,n) = diff1(i_near1(:,n),n+1);
end
d1(:,6) = ones(size(d1,1),1);

d2 = zeros(size(i_near2,1),6);
for n = 1:5
d2(:,n) = diff2(i_near2(:,n),n+1);
end
d2(:,6) = 2*ones(size(d2,1),1);

d3 = zeros(size(i_near3,1),6);
for n = 1:5
d3(:,n) = diff3(i_near3(:,n),n+1);
end
d3(:,6) = 3*ones(size(d3,1),1);

d4 = zeros(size(i_near4,1),6);
for n = 1:5
d4(:,n) = diff4(i_near4(:,n),n+1);
end
d4(:,6) = 4*ones(size(d4,1),1);

d5 = zeros(size(i_near5,1),6);
for n = 1:5
d5(:,n) = diff5(i_near5(:,n),n+1);
end
d5(:,6) = 5*ones(size(d5,1),1);

d6 = zeros(size(i_near6,1),6);
for n = 1:5
d6(:,n) = diff6(i_near6(:,n),n+1);
end
d6(:,6) = 6*ones(size(d6,1),1);

d7 = zeros(size(i_near7,1),6);
for n = 1:5
d7(:,n) = diff7(i_near7(:,n),n+1);
end
d7(:,6) = 7*ones(size(d7,1),1);

d8 = zeros(size(i_near8,1),6);
for n = 1:5
d8(:,n) = diff8(i_near8(:,n),n+1);
end
d8(:,6) = 8*ones(size(d8,1),1);

d9 = zeros(size(i_near9,1),6);
for n = 1:5
d9(:,n) = diff9(i_near9(:,n),n+1);
end
d9(:,6) = 9*ones(size(d9,1),1);

%{
d10 = zeros(size(i_near10,1),6);
for n = 1:5
d10(:,n) = diff10(i_near10(:,n),n+1);
end
d10(:,6) = 10*ones(size(d10,1),1);
%}



d_mean_all = [mean(d1);mean(d2);mean(d3);mean(d4);mean(d5);mean(d6);mean(d7);mean(d8);mean(d9)];%;mean(d10)];


%csvwrite('diff_near_mean_all.csv',d_mean_all);



