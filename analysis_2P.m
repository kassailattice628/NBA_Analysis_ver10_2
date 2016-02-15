%%%%% 2 point âêÕ
%%%%% Main ÇÃî‰ärÇÕ 2stim ÇÃÇ∆Ç´ÇÃ 0deg ÇÃíÜêSÇ©ÇÁ 100 or 50 um ÇÃ äàìÆÇî‰är
Diff100_3691215 = [];
Diff50_3691215 = [];

mean_diff3_all = [];

%%
%{
%130909WT/depth1, SC4     depth:105.2É m
cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/130909WT/depth1');
%stim space interval, 3,6,9,12,15 deg
Diff100 = csvread('SC4_diff2n_100.csv');
Diff50 = csvread('SC4_diff2n_50.csv');

figure
boxplot(Diff50);
figure
boxplot(Diff100);

Diff100_3691215 = [Diff100_3691215;Diff100];
Diff50_3691215 = [Diff50_3691215;Diff50];
%}

%130909WT/depth4, SC17      depth:176.6É m
cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/130909WT/depth4');
Diff100 = csvread('SC17_diff2n_100.csv');
Diff50 = csvread('SC17_diff2n_50.csv');
figure
boxplot(Diff50);
figure
boxplot(Diff100);

figure;
plot(0:3:15,Diff50, 'b.-');
hold on
errorbar(0:3:15, mean(Diff50),std(Diff50),'r');

Diff100_3691215 = [Diff100_3691215;Diff100];
Diff50_3691215 = [Diff50_3691215;Diff50];

mean_diff3 = csvread('SC17mean_diff3_all_100_1.csv');
mean_diff3_all = [mean_diff3_all,mean_diff3];

%130909WT/depth5, SC21     depth:88.47É m
cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/130909WT/depth5');
Diff100 = csvread('SC21_diff2n_100.csv');
Diff50 = csvread('SC21_diff2n_50.csv');
figure
boxplot(Diff50);
figure
boxplot(Diff100);
Diff100_3691215 = [Diff100_3691215;Diff100];
Diff50_3691215 = [Diff50_3691215;Diff50];

mean_diff3 = csvread('SC21mean_diff3_all_100_1.csv');
mean_diff3_all = [mean_diff3_all,mean_diff3];
%%
%{
%130906WT/depth1, SC6     depth:134É m
cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/130906WT/depth1');
Diff100 = csvread('SC6_diff2n_100.csv');
Diff50 = csvread('SC6_diff2n_50.csv');
figure
boxplot(Diff50);
figure
boxplot(Diff100);

Diff100_3691215 = [Diff100_3691215;Diff100];
Diff50_3691215 = [Diff50_3691215;Diff50];
%}
%
%130906WT/depth2, SC13     depth:104É m
cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/130906WT/depth2');
Diff100 = csvread('SC13_diff2n_100.csv');
Diff50 = csvread('SC13_diff2n_50.csv');
figure
boxplot(Diff50);
figure
boxplot(Diff100);

Diff100_3691215 = [Diff100_3691215;Diff100];
Diff50_3691215 = [Diff50_3691215;Diff50];

mean_diff3 = csvread('SC13mean_diff3_all_100_1.csv');
mean_diff3_all = [mean_diff3_all,mean_diff3];
%}

%130906WT/depth4, SC18      depth:154É m
cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/130906WT/depth4');
Diff100 = csvread('SC18_diff2n_100.csv');
Diff50 = csvread('SC18_diff2n_50.csv');
figure
boxplot(Diff50);
figure
boxplot(Diff100);

Diff100_3691215 = [Diff100_3691215;Diff100];
Diff50_3691215 = [Diff50_3691215;Diff50];

mean_diff3 = csvread('SC18mean_diff3_all_100_1.csv');
mean_diff3_all = [mean_diff3_all,mean_diff3];
%%
%130906WT/depth5, SC21      depth:156.8É m
cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/130906WT/depth5');
Diff100 = csvread('SC21_diff2n_100.csv');
Diff50 = csvread('SC21_diff2n_50.csv');
figure
boxplot(Diff50);
figure
boxplot(Diff100);

Diff100_3691215 = [Diff100_3691215;Diff100];
Diff50_3691215 = [Diff50_3691215;Diff50];


mean_diff3 = csvread('SC21mean_diff3_all_100_1.csv');
mean_diff3_all = [mean_diff3_all,mean_diff3];
%%
%130906WT/depth6, SC24      depth:198É m
cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/130906WT/depth6');
Diff100 = csvread('SC24_diff2n_100.csv');
Diff50 = csvread('SC24_diff2n_50.csv');
figure
boxplot(Diff50);
figure
boxplot(Diff100);

Diff100_3691215 = [Diff100_3691215;Diff100];
Diff50_3691215 = [Diff50_3691215;Diff50];


mean_diff3 = csvread('SC24mean_diff3_all_100_1.csv');
mean_diff3_all = [mean_diff3_all,mean_diff3];

%130906WT/depth7, SC28      depth:207É m
cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/130906WT/depth7');
Diff100 = csvread('SC28_diff2n_100.csv');
Diff50 = csvread('SC28_diff2n_50.csv');
figure
boxplot(Diff50);
figure
boxplot(Diff100);

Diff100_3691215 = [Diff100_3691215;Diff100];
Diff50_3691215 = [Diff50_3691215;Diff50];


mean_diff3 = csvread('SC28mean_diff3_all_100_1.csv');
mean_diff3_all = [mean_diff3_all,mean_diff3];

%130906WT/depth8, SC30      depth:180.3É m
cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/130906WT/depth8');
Diff100 = csvread('SC30_diff2n_100.csv');
Diff50 = csvread('SC30_diff2n_50.csv');
figure
boxplot(Diff50);
figure
boxplot(Diff100);

Diff100_3691215 = [Diff100_3691215;Diff100];
Diff50_3691215 = [Diff50_3691215;Diff50];


mean_diff3 = csvread('SC30mean_diff3_all_100_1.csv');
mean_diff3_all = [mean_diff3_all,mean_diff3];

%130906WT/depth10, SC35      depth:173É m
cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/130906WT/depth10');
Diff100 = csvread('SC35_diff2n_100.csv');
Diff50 = csvread('SC35_diff2n_50.csv');
figure
boxplot(Diff50);
figure
boxplot(Diff100);

Diff100_3691215 = [Diff100_3691215;Diff100];
Diff50_3691215 = [Diff50_3691215;Diff50];


mean_diff3 = csvread('SC35mean_diff3_all_100_1.csv');
mean_diff3_all = [mean_diff3_all,mean_diff3];

%%
%130819WT/depth1, SC5      depth:92É m

cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/130819WT/depth1');
Diff100 = csvread('SC5_diff2n_100.csv');
Diff50 = csvread('SC5_diff2n_50.csv');
figure
boxplot(Diff50);
figure
boxplot(Diff100);

Diff100_3691215 = [Diff100_3691215;Diff100];
Diff50_3691215 = [Diff50_3691215;Diff50];

mean_diff3 = csvread('SC5mean_diff3_1_100_2.csv');
mean_diff3_all = [mean_diff3_all,mean_diff3];

%130819WT/depth1, SC8      depth:92É m
cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/130819WT/depth1');
Diff100 = csvread('SC8_diff2n_100.csv');
Diff50 = csvread('SC8_diff2n_50.csv');
figure
boxplot(Diff50);
figure
boxplot(Diff100);

Diff100_3691215 = [Diff100_3691215;Diff100];
Diff50_3691215 = [Diff50_3691215;Diff50];


mean_diff3 = csvread('SC8mean_diff3_2_100_2.csv');
mean_diff3_all = [mean_diff3_all,mean_diff3];

%{
%130819WT/depth12, SC26      depth:133.3É m,  SRÇÌÇØÇƒÇ»Ç¢ÇÃÇ≈ÉJÉbÉg
cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/130819WT/depth12');
Diff100 = csvread('SC26_diff2n_100.csv');
Diff50 = csvread('SC26_diff2n_50.csv');
figure
boxplot(Diff50);
figure
boxplot(Diff100);

Diff100_3691215 = [Diff100_3691215;Diff100];
Diff50_3691215 = [Diff50_3691215;Diff50];
%}

%%
Diff100_2571015 = [];
Diff50_2571015 = [];
%130208GAD/SC7-12_2p      depth:226.2É m
%stim distance, 2,5,7,10,15
cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/130208GAD/SC7-12_2p/');
Diff100 = csvread('SC7-12_diff2n_100.csv');
Diff50 = csvread('SC7-12_diff2n_50.csv');
figure
boxplot(Diff50);
figure
boxplot(Diff100);
  
Diff100_2571015 = [Diff100_2571015;Diff100];
Diff50_2571015 = [Diff50_2571015;Diff50];
%%
Diff100_2510 = [];
Diff50_2510 = [];
%130206GAD/SC5-8_2p      depth:106.37um
%stim distance, 2,5,10
cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/130206GAD/SC5-8_2p/');
Diff100 = csvread('SC5-8_diff2n_100.csv');
Diff50 = csvread('SC5-8_diff2n_50.csv');
figure
boxplot(Diff50);
figure
boxplot(Diff100);

Diff100_2510 = [Diff100_2510;Diff100];
Diff50_2510 = [Diff50_2510;Diff50];
%%
%130206GAD_SC10_12-16_2p, 8ï˚å¸ depth:138.5 um
%stim distance, 2,5,7,10,15
cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/130206GAD/SC10_12-16_2p/');
Diff100 = csvread('SC10_12-16_diff2n_100.csv');
Diff50 = csvread('SC10_12-16_diff2n_50.csv');
figure
boxplot(Diff50);
figure
boxplot(Diff100);

Diff100_2571015 = [Diff100_2571015;Diff100];
Diff50_2571015 = [Diff50_2571015;Diff50];

%130206GAD/SC18-23_2p, 8ï˚å¸      depth:98.34 um
%stim distance, 2,5,7,10,15
cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/130206GAD/SC18-23_2p/');
Diff100 = csvread('SC18-23_diff2n_100.csv');
Diff50 = csvread('SC18-23_diff2n_50.csv');
figure
boxplot(Diff50);
figure
boxplot(Diff100);

Diff100_2571015 = [Diff100_2571015;Diff100];
Diff50_2571015 = [Diff50_2571015;Diff50];
%%
%%%%%%%%%%%%%
D100_2 = [Diff100_2571015(:,2);Diff100_2510(:,2)];
D100_3 = [Diff100_3691215(:,2)];
D100_5 = [Diff100_2571015(:,3);Diff100_2510(:,3)];
D100_6 = [Diff100_3691215(:,3)];
D100_7 = [Diff100_2571015(:,4)];
D100_9 = [Diff100_3691215(:,4)];
D100_10 = [Diff100_2571015(:,5);Diff100_2510(:,4)];
D100_12 = [Diff100_3691215(:,5)];
D100_15 = [Diff100_3691215(:,6);Diff100_2571015(:,6)];


D100_mean = [mean(D100_2),mean(D100_3),mean(D100_5),mean(D100_6),mean(D100_7),mean(D100_9),mean(D100_10),mean(D100_12),mean(D100_15)];
D100_std = [std(D100_2),std(D100_3),std(D100_5),std(D100_6),std(D100_7),std(D100_9),std(D100_10),std(D100_12),std(D100_15)];
s_dist = [2,3,5,6,7,9,10,12,15];
figure
errorbar(s_dist,D100_mean,D100_std);


%%
D50_2 = [Diff50_2571015(:,2);Diff50_2510(:,2)];
D50_3 = [Diff50_3691215(:,2)];
D50_5 = [Diff50_2571015(:,3);Diff50_2510(:,3)];
D50_6 = [Diff50_3691215(:,3)];
D50_7 = [Diff50_2571015(:,4)];
D50_9 = [Diff50_3691215(:,4)];
D50_10 = [Diff50_2571015(:,5);Diff50_2510(:,4)];
D50_12 = [Diff50_3691215(:,5)];
D50_15 = [Diff50_3691215(:,6);Diff50_2571015(:,6)];


D50_mean = [mean(D50_2),mean(D50_3),mean(D50_5),mean(D50_6),mean(D50_7),mean(D50_9),mean(D50_10),mean(D50_12),mean(D50_15)];
D50_std = [std(D50_2),std(D50_3),std(D50_5),std(D50_6),std(D50_7),std(D50_9),std(D50_10),std(D50_12),std(D50_15)];
s_dist = [2,3,5,6,7,9,10,12,15];
figure
errorbar(s_dist,D50_mean,D50_std);

%%
figure
boxplot(Diff100_3691215)
figure;
boxplot(Diff50_3691215)
s_dist = [0 3,6,9,12,15];

figure;plot(s_dist,Diff50_3691215, 'b.-');hold on
errorbar(s_dist,mean(Diff50_3691215),std(Diff50_3691215), 'r.-');
figure;plot(0:3:15,Diff100_3691215, 'b.-'); hold on
errorbar(s_dist,mean(Diff100_3691215),std(Diff100_3691215), 'r.-');

%%
figure;
boxplot(Diff100_2571015)
figure;
boxplot(Diff50_2571015)
%%



%%
figure;
plot(1:5, mean_diff3_all,'ko-');
hold on
errorbar([1:5]+0.2, mean(mean_diff3_all,2), std(mean_diff3_all,0,2),'ro-')
line([0,6],[0,0])








