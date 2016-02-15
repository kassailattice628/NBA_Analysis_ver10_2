%Szr_analysis

%double gaussian fiting parameters of Size dependent responses.
%1: Amp0
%2: X0
%3: SD0
%4: Amp1
%5: SD1

Szr_b = csvread('/Users/lattice/Desktop/SC_2P_R_analysis/Szr_beta_r1_fix2.csv',1,1);
%x = linspace(-20,500,100);
x = -20:500;

Z_fit_r = zeros(size(Szr_b,2),length(x));

for n = 1:size(Szr_b,1)
    Z_fit_r(n,:) = Gaussian1D(Szr_b(n,:),x);
end
Z_mean = mean(Z_fit_r,1);
Z_sd = std(Z_fit_r,1);
Z_plus_sd = Z_mean + 2*Z_sd;
Z_minus_sd = Z_mean - 2*Z_sd;

%%
figure;
plot(x,Z_fit_r,'b');
hold on
%shadedErrorBar(x,Z_fit_r(),{@mean,@std},{'r','linewidth',3},1);
plot(x,Z_mean,'r');
plot(x,Z_plus_sd,'r');
plot(x,Z_minus_sd,'r');
xlim([-5,450]);
ylim([-0.3, 0.3]);
hold off

%%
ind = find(Szr_b(:,3) < 250 );

figure;
plot(x,Z_fit_r(ind,:),'b');
hold on
%shadedErrorBar(x,Z_fit_r(ind,:),{@median,@std},{'r','linewidth',3},0.5);
shadedErrorBar(x,Z_fit_r(ind,:),{@mean,@std},{'r','linewidth',3},0.5);
hold off

%% 130909
%ó‚¢•û‚©‚ç‡”Ô‚É
%depth5(SC23)->depth1(SC2,SC6)->depth2(SC10,SC11)->depth3(SC15)->depth3(SC19)
ind = [14,8:13];
figure;
plot(x,Z_fit_r(14,:),'b');
hold on
plot(x,Z_fit_r([8,9],:),'c');
plot(x,Z_fit_r([10,11],:),'g');
plot(x,Z_fit_r(12,:),'y');
plot(x,Z_fit_r(13,:),'r');
shadedErrorBar(x,Z_fit_r(ind,:),{@mean,@std},{'r','linewidth',3},0.5);
hold off
%%
% ŒÂ‘Ì“à‚Å fit. peak ‚ª‚¢‚¢‚© area ‚ª‚¢‚¢‚©D
ROI_Polar_all = [];
szr_all = [];

cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/130909WT/depth5');
roi_polar = csvread('SC23_ROI_Polar.csv');
y = csvread('SC23_peak.csv');
szr = y(:,5) - y(:,1);
SR = [1:70];
OGB1 = setdiff(1:size(roi_polar,1),SR);

ROI_Polar_all = [ROI_Polar_all;roi_polar(OGB1,:)];
szr_all = [szr_all;szr(OGB1,:)];

cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/130909WT/depth1');
roi_polar = csvread('SC2_ROI_Polar.csv');
y = csvread('SC2_peak.csv');
szr = y(:,5) - y(:,1);
SR = [1:78,172];
OGB = setdiff(1:size(roi_polar,1),SR);

ROI_Polar_all = [ROI_Polar_all;roi_polar(OGB,:)];
szr_all = [szr_all;szr(OGB,:)];

roi_polar = csvread('SC6_ROI_Polar.csv');
y = csvread('SC6_peak.csv');
szr = y(:,5) - y(:,1);
SR = [1:27,97];
OGB = setdiff(1:size(roi_polar,1),SR);

ROI_Polar_all = [ROI_Polar_all;roi_polar(OGB,:)];
szr_all = [szr_all;szr(OGB,:)];

cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/130909WT/depth2');
roi_polar = csvread('SC10_ROI_Polar.csv');
y = csvread('SC10_peak.csv');
szr = y(:,5) - y(:,1);
SR = [1:90];
OGB = setdiff(1:size(roi_polar,1),SR);

ROI_Polar_all = [ROI_Polar_all;roi_polar(OGB,:)];
szr_all = [szr_all;szr(OGB,:)];

roi_polar = csvread('SC11_ROI_Polar.csv');
y = csvread('SC11_peak.csv');
szr = y(:,5) - y(:,1);
SR = [1:27,97];
OGB = setdiff(1:size(roi_polar,1),SR);

ROI_Polar_all = [ROI_Polar_all;roi_polar(OGB,:)];
szr_all = [szr_all;szr(OGB,:)];

cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/130909WT/depth3');
roi_polar = csvread('SC15_ROI_Polar.csv');
y = csvread('SC15_peak.csv');
szr = y(:,5) - y(:,1);
SR = [1:99];
OGB = setdiff(1:size(roi_polar,1),SR);

ROI_Polar_all = [ROI_Polar_all;roi_polar(OGB,:)];
szr_all = [szr_all;szr(OGB,:)];

cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/130909WT/depth4');
roi_polar = csvread('SC19_ROI_Polar.csv');
y = csvread('SC19_peak.csv');
szr = y(:,5) - y(:,1);
SR = [1:89];
OGB = setdiff(1:size(roi_polar,1),SR);

ROI_Polar_all = [ROI_Polar_all;roi_polar(OGB,:)];
szr_all = [szr_all;szr(OGB,:)];

%% fit
beta_r = [0.1,0,300,0.2,1];%[Amp0, x0, xsd0, Amp1, xsd1]
lb_r = [0,-10,0,0,0.001];
ub_r = [1,10,500,1,10];

%ind = find(ROI_Polar_all(:,2)>50 & ROI_Polar_all(:,2) < 250);
%[beta_r1,~, residual] = lsqcurvefit(@Gaussian1D, beta_r,ROI_Polar_all(ind,2),szr_all(ind,:), lb_r, ub_r);

[beta_r1, rnorm, residual,~,~,lambda,jacob] = lsqcurvefit(@Gaussian1D, beta_r,ROI_Polar_all(:,2),szr_all, lb_r, ub_r);
Rsq = Calc_Rsq(szr_all,residual);
%
x = -5:450;
Z_fit_r_all = Gaussian1D(beta_r1,x);
%plot
%figure;plot(ROI_Polar_all((length(OGB1)+1):end,2),szr_all((length(OGB1)+1):end,:), 'k.');
figure;plot(ROI_Polar_all(:,2),szr_all, 'k.');
hold on;
plot(x, Z_fit_r_all,'r','linewidth',2);
xlim([-5, 450]);
ylim([-0.3, 0.3]);

%%{
%M—Š‹æŠÔ
[ypred, delta] = nlpredci(@Gaussian1D, x, beta_r1, residual,'Jacobian', jacob);

figure;plot(ROI_Polar_all((length(OGB1)+1):end,2),szr_all((length(OGB1)+1):end,:), 'k.');
hold on;
plot(x, Z_fit_r_all,'r','linewidth',2);
plot(x, ypred-delta','r');
plot(x, ypred+delta','r');
xlim([-5, 450]);
ylim([-0.3, 0.3]);
%}
%%{
%—\‘ª‹æŠÔ
beta_r = [0.1, 10 ,230,0.2,0.2];%[Amp0, x0, xsd0, Amp1, xsd1]
%0.1192   10.0000  235.1911    0.2302    0.2690
nlm = NonLinearModel.fit(ROI_Polar_all(:,2), szr_all, @Gaussian1D, beta_r);

[ypred,ypredci] = predict(nlm, x', 'Simultaneous',true, 'Prediction', 'observation');
figure;
plot(ROI_Polar_all(:,2), szr_all, 'k.');
hold on;
%plot(x, Z_fit_r_all, 'b', 'linewidth',1);
plot(x,predict(nlm,x'),'r', 'linewidth',2);
plot(x, ypredci,'r--');
xlabel('x'); ylabel('y');
xlim([-5, 450]);
ylim([-0.3, 0.3]);
%}

%%
cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/130909WT/depth5');
mat = csvread('SC23_peak.csv');
mat_diff = zeros(size(mat,1),size(mat,2));
mat2 = mat';
index = zeros(1,size(mat,1));%
max_ROI = cell(1,5);
%% S23 ‚Ì‚Ý size tuning ‚ÌF•t‚«‚Å
%{
for i = 1:size(mat,1)
    in = find(mat2(:,i)==max(mat2(:,i)));
    if length(in) == 1
        index(1,i) = in;
    elseif length(in) > 1
        index(1,i) = min(in);
    end
end
SR = [1:70];
OGB = setdiff(1:size(mat,1),SR);
roi = OGB;
for i = 1:5
    i2 = find(index==i);
    max_ROI{1,i} = i2(ismember(i2,roi));
    clear i2
end
for i = 1:5
    mat_diff(:,i) = mat(:,i) - mat(:,1);
end
%figure;
for i = 1:5
    if i ==1
        c = 'b.';
    elseif i == 2
        c = 'c.';
    elseif i == 3
        c = 'g.';
    elseif i ==4
        c = 'y.';
    elseif i == 5
        c = 'r.';
    end
    %c = select_col(i);
    scatter(ROI_Polar(max_ROI{1,i},2), mat_diff(max_ROI{1,i},size(mat,2)),c);
    hold on
end
xlim([0, 350]);
ylim([-0.3, 0.3]);
hold off
%}
%%
cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/130909WT/depth5');
roi_polar = csvread('SC23_ROI_Polar.csv');
y = csvread('SC23_peak.csv');
szr = y(:,5) - y(:,1);
SR = [1:70];
OGB = setdiff(1:size(roi_polar,1),SR);
mat = y;
X = 1:5;
% peak detection (for coloring plot)
mat2 = mat';
index = zeros(1,size(mat,1));%
max_ROI = cell(1,5);

%
for i = 1:size(mat,1)
    in = find(mat2(:,i)==max(mat2(:,i)));
    if length(in) == 1
        index(1,i) = in;
    elseif length(in) > 1
        index(1,i) = min(in);
    end
end

roi = [OGB];
for i = 1:5
    i2 = find(index==i);
    max_ROI{1,i} = i2(ismember(i2,roi));
    clear i2
end
figure;
for i = 1:5
    subplot(1,5,i)
    if i ==1
        c = 'b.-';
    elseif i == 2
        c = 'c.-';
    elseif i == 3
        c = 'g.-';
    elseif i ==4
        c = 'y.-';
    elseif i == 5
        c = 'r.-';
    end
    plot(X,y(max_ROI{i},:),c);
    ylim([0,0.4])
    xlim([0,6])
end

%% peak1 ‚Æ peak2 ‚Å size tuning ‚Ì”äŠr
roi_polar1 = csvread('SC23_ROI_Polar_peak1.csv');
roi_polar2 = csvread('SC23_ROI_Polar_peak2.csv');

y1 = csvread('SC23_peak1_0724.csv');
szr1 = y1(:,5) - y1(:,1);

y2 = csvread('SC23_peak2_0724.csv');
szr2 = y2(:,5) - y2(:,1);

SR = 1:70;
OGB = setdiff(1:size(roi_polar1,1),SR);

%peak1
mat = y1;
% peak detection (for coloring plot)
mat2 = mat';
index = zeros(1,size(mat,1));%
for i = 1:size(mat,1)
    in = find(mat2(:,i)==max(mat2(:,i)));
    if length(in) == 1
        index(1,i) = in;
    elseif length(in) > 1
        index(1,i) = min(in);
    end
end
max_ROI1 = cell(1,5);
roi = OGB;
for i = 1:5
    i2 = find(index==i);
    max_ROI1{1,i} = i2(ismember(i2,roi));
    clear i2
end

%peak2
mat = y2;
% peak detection (for coloring plot)
mat2 = mat';
index = zeros(1,size(mat,1));%
for i = 1:size(mat,1)
    in = find(mat2(:,i)==max(mat2(:,i)));
    if length(in) == 1
        index(1,i) = in;
    elseif length(in) > 1
        index(1,i) = min(in);
    end
end
max_ROI2 = cell(1,5);
roi = OGB;
for i = 1:5
    i2 = find(index==i);
    max_ROI2{1,i} = i2(ismember(i2,roi));
    clear i2
end


X = 1:5;
figure;
for i = 1:5
    subplot(2,5,i)
    if i ==1
        c = 'b.-';
    elseif i == 2
        c = 'c.-';
    elseif i == 3
        c = 'g.-';
    elseif i ==4
        c = 'y.-';
    elseif i == 5
        c = 'r.-';
    end
    plot(X,y1(max_ROI1{i},:),c);
    ylim([-0.05,0.15])
    xlim([0,6])
    
    subplot(2,5,i+5);
    plot(X,y2(max_ROI2{i},:),c);
    ylim([-0.05,0.26])
    xlim([0,6])
end

%%
X = 1:5;
figure;
for i = 1:5
    subplot(2,5,i)
    if i ==1
        c = 'b.-';
    elseif i == 2
        c = 'c.-';
    elseif i == 3
        c = 'g.-';
    elseif i ==4
        c = 'y.-';
    elseif i == 5
        c = 'r.-';
    end
    plot(X,y1(max_ROI1{i},:),'k-');
    hold on
    plot(X,mean(y1(max_ROI1{i},:)),c);
    hold off
    ylim([-0.05,0.15])
    xlim([0,6])
    
    subplot(2,5,i+5);
    plot(X,y2(max_ROI2{i},:),'k-');
    hold on
    plot(X,mean(y2(max_ROI2{i},:)),c);
    ylim([-0.05,0.26])
    xlim([0,6])
end
%%
%% peak1 ‚Æ peak2 ‚Å size tuning ‚Ì”äŠr
cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/130909WT/depth4');
roi_polar1 = csvread('SC19_ROI_Polar_peak1_0724.csv');
roi_polar2 = csvread('SC19_ROI_Polar_peak2_0724.csv');

y1 = csvread('SC19_peak1_0724.csv');
szr1 = y1(:,5) - y1(:,1);

y2 = csvread('SC19_peak2_0724.csv');
szr2 = y2(:,5) - y2(:,1);

SR = 1:89;
OGB = setdiff(1:size(roi_polar1,1),SR);

%peak1
mat = y1;
% peak detection (for coloring plot)
mat2 = mat';
index = zeros(1,size(mat,1));%
for i = 1:size(mat,1)
    in = find(mat2(:,i)==max(mat2(:,i)));
    if length(in) == 1
        index(1,i) = in;
    elseif length(in) > 1
        index(1,i) = min(in);
    end
end
max_ROI1 = cell(1,5);
roi = OGB;
for i = 1:5
    i2 = find(index==i);
    max_ROI1{1,i} = i2(ismember(i2,roi));
    clear i2
end

%peak2
mat = y2;
% peak detection (for coloring plot)
mat2 = mat';
index = zeros(1,size(mat,1));%
for i = 1:size(mat,1)
    in = find(mat2(:,i)==max(mat2(:,i)));
    if length(in) == 1
        index(1,i) = in;
    elseif length(in) > 1
        index(1,i) = min(in);
    end
end
max_ROI2 = cell(1,5);
roi = OGB;
for i = 1:5
    i2 = find(index==i);
    max_ROI2{1,i} = i2(ismember(i2,roi));
    clear i2
end

X = 1:5;
figure;
for i = 1:5
    if i ==1
        c = 'b.-';
    elseif i == 2
        c = 'c.-';
    elseif i == 3
        c = 'g.-';
    elseif i ==4
        c = 'y.-';
    elseif i == 5
        c = 'r.-';
    end
    subplot(2,5,i)
    if isempty(max_ROI1{i})
    else
        plot(X,y1(max_ROI1{i},:),'k-');
        hold on
        plot(X,mean(y1(max_ROI1{i},:)),c);
        hold off
        ylim([-0.05,0.15])
        xlim([0,6])
    end
    
    if isempty(max_ROI2{i})
    else
        subplot(2,5,i+5);
        plot(X,y2(max_ROI2{i},:),'k-');
        hold on
        plot(X,mean(y2(max_ROI2{i},:)),c);
        hold off
        ylim([-0.05,0.26])
        xlim([0,6])
    end
    
end
%%
%% peak1 ‚Æ peak2 ‚Å size tuning ‚Ì”äŠr
cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/130909WT/depth3');
roi_polar1 = csvread('SC15_ROI_Polar_peak1_0724.csv');
roi_polar2 = csvread('SC15_ROI_Polar_peak2_0724.csv');

y1 = csvread('SC15_peak1_0724.csv');
szr1 = y1(:,5) - y1(:,1);

y2 = csvread('SC15_peak2_0724.csv');
szr2 = y2(:,5) - y2(:,1);

SR = 1:99;
OGB = setdiff(1:size(roi_polar1,1),SR);

%peak1
mat = y1;
% peak detection (for coloring plot)
mat2 = mat';
index = zeros(1,size(mat,1));%
for i = 1:size(mat,1)
    in = find(mat2(:,i)==max(mat2(:,i)));
    if length(in) == 1
        index(1,i) = in;
    elseif length(in) > 1
        index(1,i) = min(in);
    end
end
max_ROI1 = cell(1,5);
roi = OGB;
for i = 1:5
    i2 = find(index==i);
    max_ROI1{1,i} = i2(ismember(i2,roi));
    clear i2
end

%peak2
mat = y2;
% peak detection (for coloring plot)
mat2 = mat';
index = zeros(1,size(mat,1));%
for i = 1:size(mat,1)
    in = find(mat2(:,i)==max(mat2(:,i)));
    if length(in) == 1
        index(1,i) = in;
    elseif length(in) > 1
        index(1,i) = min(in);
    end
end
max_ROI2 = cell(1,5);
roi = OGB;
for i = 1:5
    i2 = find(index==i);
    max_ROI2{1,i} = i2(ismember(i2,roi));
    clear i2
end

X = 1:5;
figure;
for i = 1:5
    if i ==1
        c = 'b.-';
    elseif i == 2
        c = 'c.-';
    elseif i == 3
        c = 'g.-';
    elseif i ==4
        c = 'y.-';
    elseif i == 5
        c = 'r.-';
    end
    subplot(2,5,i)
    if isempty(max_ROI1{i})
    else
        plot(X,y1(max_ROI1{i},:),'k-');
        hold on
        plot(X,mean(y1(max_ROI1{i},:)),c);
        hold off
        ylim([-0.05,0.15])
        xlim([0,6])
    end
    
    if isempty(max_ROI2{i})
    else
        subplot(2,5,i+5);
        plot(X,y2(max_ROI2{i},:),'k-');
        hold on
        plot(X,mean(y2(max_ROI2{i},:)),c);
        hold off
        ylim([-0.05,0.26])
        xlim([0,6])
    end
    
end

%%
%% peak1 ‚Æ peak2 ‚Å size tuning ‚Ì”äŠr
cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/130909WT/depth2');
roi_polar1 = csvread('SC10_ROI_Polar_peak1_0724.csv');
roi_polar2 = csvread('SC10_ROI_Polar_peak2_0724.csv');

y1 = csvread('SC10_peak1_0724.csv');
szr1 = y1(:,5) - y1(:,1);

y2 = csvread('SC10_peak2_0724.csv');
szr2 = y2(:,5) - y2(:,1);

SR = 1:90;
OGB = setdiff(1:size(roi_polar1,1),SR);

%peak1
mat = y1;
% peak detection (for coloring plot)
mat2 = mat';
index = zeros(1,size(mat,1));%
for i = 1:size(mat,1)
    in = find(mat2(:,i)==max(mat2(:,i)));
    if length(in) == 1
        index(1,i) = in;
    elseif length(in) > 1
        index(1,i) = min(in);
    end
end
max_ROI1 = cell(1,5);
roi = OGB;
for i = 1:5
    i2 = find(index==i);
    max_ROI1{1,i} = i2(ismember(i2,roi));
    clear i2
end

%peak2
mat = y2;
% peak detection (for coloring plot)
mat2 = mat';
index = zeros(1,size(mat,1));%
for i = 1:size(mat,1)
    in = find(mat2(:,i)==max(mat2(:,i)));
    if length(in) == 1
        index(1,i) = in;
    elseif length(in) > 1
        index(1,i) = min(in);
    end
end
max_ROI2 = cell(1,5);
roi = OGB;
for i = 1:5
    i2 = find(index==i);
    max_ROI2{1,i} = i2(ismember(i2,roi));
    clear i2
end

X = 1:5;
figure;
for i = 1:5
    if i ==1
        c = 'b.-';
    elseif i == 2
        c = 'c.-';
    elseif i == 3
        c = 'g.-';
    elseif i ==4
        c = 'y.-';
    elseif i == 5
        c = 'r.-';
    end
    subplot(2,5,i)
    if isempty(max_ROI1{i})
    else
        plot(X,y1(max_ROI1{i},:),'k-');
        hold on
        plot(X,mean(y1(max_ROI1{i},:)),c);
        hold off
        ylim([-0.05,0.15])
        xlim([0,6])
    end
    
    if isempty(max_ROI2{i})
    else
        subplot(2,5,i+5);
        plot(X,y2(max_ROI2{i},:),'k-');
        hold on
        plot(X,mean(y2(max_ROI2{i},:)),c);
        hold off
        ylim([-0.05,0.26])
        xlim([0,6])
    end
    
end
%% peak1 ‚Æ peak2 ‚Å size tuning ‚Ì”äŠr
cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/130909WT/depth2');
roi_polar1 = csvread('SC11_ROI_Polar_peak1_0724.csv');
roi_polar2 = csvread('SC11_ROI_Polar_peak2_0724.csv');

y1 = csvread('SC11_peak1_0724.csv');
szr1 = y1(:,5) - y1(:,1);

y2 = csvread('SC11_peak2_0724.csv');
szr2 = y2(:,5) - y2(:,1);

SR = 1:90;
OGB = setdiff(1:size(roi_polar1,1),SR);

%peak1
mat = y1;
% peak detection (for coloring plot)
mat2 = mat';
index = zeros(1,size(mat,1));%
for i = 1:size(mat,1)
    in = find(mat2(:,i)==max(mat2(:,i)));
    if length(in) == 1
        index(1,i) = in;
    elseif length(in) > 1
        index(1,i) = min(in);
    end
end
max_ROI1 = cell(1,5);
roi = OGB;
for i = 1:5
    i2 = find(index==i);
    max_ROI1{1,i} = i2(ismember(i2,roi));
    clear i2
end

%peak2
mat = y2;
% peak detection (for coloring plot)
mat2 = mat';
index = zeros(1,size(mat,1));%
for i = 1:size(mat,1)
    in = find(mat2(:,i)==max(mat2(:,i)));
    if length(in) == 1
        index(1,i) = in;
    elseif length(in) > 1
        index(1,i) = min(in);
    end
end
max_ROI2 = cell(1,5);
roi = OGB;
for i = 1:5
    i2 = find(index==i);
    max_ROI2{1,i} = i2(ismember(i2,roi));
    clear i2
end

X = 1:5;
figure;
for i = 1:5
    if i ==1
        c = 'b.-';
    elseif i == 2
        c = 'c.-';
    elseif i == 3
        c = 'g.-';
    elseif i ==4
        c = 'y.-';
    elseif i == 5
        c = 'r.-';
    end
    subplot(2,5,i)
    if isempty(max_ROI1{i})
    else
        plot(X,y1(max_ROI1{i},:),'k-');
        hold on
        plot(X,mean(y1(max_ROI1{i},:)),c);
        hold off
        ylim([-0.05,0.15])
        xlim([0,6])
    end
    
    if isempty(max_ROI2{i})
    else
        subplot(2,5,i+5);
        plot(X,y2(max_ROI2{i},:),'k-');
        hold on
        plot(X,mean(y2(max_ROI2{i},:)),c);
        hold off
        ylim([-0.05,0.26])
        xlim([0,6])
    end
    
end

%% peak1 ‚Æ peak2 ‚Å size tuning ‚Ì”äŠr
cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/130909WT/depth1');
roi_polar1 = csvread('SC6_ROI_Polar_peak1_0724.csv');
roi_polar2 = csvread('SC6_ROI_Polar_peak2_0724.csv');

y1 = csvread('SC6_peak1_0724.csv');
szr1 = y1(:,5) - y1(:,1);

y2 = csvread('SC6_peak2_0724.csv');
szr2 = y2(:,5) - y2(:,1);

SR = [1:27,97];
OGB = setdiff(1:size(roi_polar1,1),SR);

%peak1
mat = y1;
% peak detection (for coloring plot)
mat2 = mat';
index = zeros(1,size(mat,1));%
for i = 1:size(mat,1)
    in = find(mat2(:,i)==max(mat2(:,i)));
    if length(in) == 1
        index(1,i) = in;
    elseif length(in) > 1
        index(1,i) = min(in);
    end
end
max_ROI1 = cell(1,5);
roi = OGB;
for i = 1:5
    i2 = find(index==i);
    max_ROI1{1,i} = i2(ismember(i2,roi));
    clear i2
end

%peak2
mat = y2;
% peak detection (for coloring plot)
mat2 = mat';
index = zeros(1,size(mat,1));%
for i = 1:size(mat,1)
    in = find(mat2(:,i)==max(mat2(:,i)));
    if length(in) == 1
        index(1,i) = in;
    elseif length(in) > 1
        index(1,i) = min(in);
    end
end
max_ROI2 = cell(1,5);
roi = OGB;
for i = 1:5
    i2 = find(index==i);
    max_ROI2{1,i} = i2(ismember(i2,roi));
    clear i2
end

X = 1:5;
figure;
for i = 1:5
    if i ==1
        c = 'b.-';
    elseif i == 2
        c = 'c.-';
    elseif i == 3
        c = 'g.-';
    elseif i ==4
        c = 'y.-';
    elseif i == 5
        c = 'r.-';
    end
    subplot(2,5,i)
    if isempty(max_ROI1{i})
    else
        plot(X,y1(max_ROI1{i},:),'k-');
        hold on
        plot(X,mean(y1(max_ROI1{i},:),1),c);
        hold off
        ylim([-0.05,0.15])
        xlim([0,6])
    end
    
    if isempty(max_ROI2{i})
    else
        subplot(2,5,i+5);
        plot(X,y2(max_ROI2{i},:),'k-');
        hold on
        plot(X,mean(y2(max_ROI2{i},:),1),c);
        hold off
        %ylim([-0.05,0.26])
        %xlim([0,6])
    end
    
end
%%
%% peak1 ‚Æ peak2 ‚Å size tuning ‚Ì”äŠr
cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/130909WT/depth1');
roi_polar1 = csvread('SC2_ROI_Polar_peak1_0724.csv');
roi_polar2 = csvread('SC2_ROI_Polar_peak2_0724.csv');

y1 = csvread('SC2_peak1_0724.csv');
szr1 = y1(:,5) - y1(:,1);

y2 = csvread('SC2_peak2_0724.csv');
szr2 = y2(:,5) - y2(:,1);

SR = [1:78,172];
OGB = setdiff(1:size(roi_polar1,1),SR);

%peak1
mat = y1;
% peak detection (for coloring plot)
mat2 = mat';
index = zeros(1,size(mat,1));%
for i = 1:size(mat,1)
    in = find(mat2(:,i)==max(mat2(:,i)));
    if length(in) == 1
        index(1,i) = in;
    elseif length(in) > 1
        index(1,i) = min(in);
    end
end
max_ROI1 = cell(1,5);
roi = OGB;
for i = 1:5
    i2 = find(index==i);
    max_ROI1{1,i} = i2(ismember(i2,roi));
    clear i2
end

%peak2
mat = y2;
% peak detection (for coloring plot)
mat2 = mat';
index = zeros(1,size(mat,1));%
for i = 1:size(mat,1)
    in = find(mat2(:,i)==max(mat2(:,i)));
    if length(in) == 1
        index(1,i) = in;
    elseif length(in) > 1
        index(1,i) = min(in);
    end
end
max_ROI2 = cell(1,5);
roi = OGB;
for i = 1:5
    i2 = find(index==i);
    max_ROI2{1,i} = i2(ismember(i2,roi));
    clear i2
end

X = 1:5;
figure;
for i = 1:5
    if i ==1
        c = 'b.-';
    elseif i == 2
        c = 'c.-';
    elseif i == 3
        c = 'g.-';
    elseif i ==4
        c = 'y.-';
    elseif i == 5
        c = 'r.-';
    end
    subplot(2,5,i)
    if isempty(max_ROI1{i})
    else
        plot(X,y1(max_ROI1{i},:),'k-');
        hold on
        plot(X,mean(y1(max_ROI1{i},:)),c);
        hold off
        ylim([-0.05,0.15])
        xlim([0,6])
    end
    
    if isempty(max_ROI2{i})
    else
        subplot(2,5,i+5);
        plot(X,y2(max_ROI2{i},:),'k-');
        hold on
        plot(X,mean(y2(max_ROI2{i},:)),c);
        hold off
        ylim([-0.05,0.26])
        xlim([0,6])
    end
    
end
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Excitatory VS Inhibitory
beta_r_1 = csvread('/Users/lattice/Desktop/SC_2P_R_analysis/beta_r_ExVSIn3/All.csv',1,1);
beta_r_2 = csvread('/Users/lattice/Desktop/SC_2P_R_analysis/beta_r_ExVSIn3/OGB.csv',1,1);
beta_r_3 = csvread('/Users/lattice/Desktop/SC_2P_R_analysis/beta_r_ExVSIn3/GFP.csv',1,1);

beta_r1 = beta_r_1(:,1:end-1);
beta_r2 = beta_r_2(:,1:end-1);
beta_r3 = beta_r_3(:,1:end-1);
depth1 = beta_r_1(:,end);
depth2 = beta_r_2(:,end);
depth3 = beta_r_3(:,end);

mean(beta_r2)
std(beta_r2)

sd2_2 = beta_r2(:,3).*beta_r2(:,5);
mean(sd2_2)
std(sd2_2)

mean(beta_r3)
std(beta_r3)
sd2_3 = beta_r3(:,3).*beta_r3(:,5);
mean(sd2_3)
std(sd2_3)

x = -20:350;

Z_fit_r1 = zeros(size(beta_r1,2),length(x));
Z_fit_r2 = zeros(size(beta_r2,2),length(x));
Z_fit_r3 = zeros(size(beta_r3,2),length(x));
for n = 1:size(beta_r1,1)
    Z_fit_r1(n,:) = Gaussian1D(beta_r1(n,:),x);
end
cells = [1:46,49:size(beta_r1,1)];
Z_mean1 = mean(Z_fit_r1(cells,:),1);
Z_sd1 = std(Z_fit_r1(cells,:),1);
Z_plus_sd1 = Z_mean1 + 2*Z_sd1;Diststd = [Diststd1,Diststd2,Diststd3,Diststd4,Diststd5];
Z_minus_sd1 = Z_mean1 - 2*Z_sd1;

%
figure;
plot(x,Z_fit_r1(cells,:),'b');
hold on
%shadedErrorBar(x,Z_fit_r(),{@mean,@std},{'r','linewidth',3},1);
plot(x,Z_mean1,'r');
plot(x,Z_plus_sd1,'r');
plot(x,Z_minus_sd1,'r');
axis([-5,450, -0.2, 0.2])
hold off

%%
for n = 1:size(beta_r1,1)
    Z_fit_r1(n,:) = Gaussian1D(beta_r1(n,:),x);
end

for n = 1:size(beta_r2,1)
    Z_fit_r2(n,:) = Gaussian1D(beta_r2(n,:),x);
    Z_fit_r3(n,:) = Gaussian1D(beta_r3(n,:),x);
end

Z_mean1 = mean(Z_fit_r1,1);
Z_sd1 = std(Z_fit_r1,1);
Z_plus_sd1 = Z_mean1 + 2*Z_sd1;
Z_minus_sd1 = Z_mean1 - 2*Z_sd1;

figure;
plot(x,Z_fit_r1,'b');

Z_mean2 = mean(Z_fit_r2,1);
Z_sd2 = std(Z_fit_r2,1);
Z_plus_sd2 = Z_mean2 + 2*Z_sd2;
Z_minus_sd2 = Z_mean2 - 2*Z_sd2;

Z_mean3 = mean(Z_fit_r3,1);
Z_sd3 = std(Z_fit_r3,1);
Z_plus_sd3 = Z_mean3 + 2*Z_sd3;
Z_minus_sd3 = Z_mean3 - 2*Z_sd3;



figure;
plot(x,Z_fit_r2,'b');
hold on
plot(x,Z_mean2,'r');
plot(x,Z_plus_sd2,'r');
plot(x,Z_minus_sd2,'r');
axis([-20,500, -0.25, 0.25])
hold off


figure;
plot(x,Z_fit_r3,'b');
hold on
plot(x,Z_mean3,'r');
plot(x,Z_plus_sd3,'r');
plot(x,Z_minus_sd3,'r');
axis([-20,500, -0.25, 0.25])
hold off

%%
y0id = find(x==0);
ModDepth1 = Z_fit_r1(:,y0id);
ModDepth2 = Z_fit_r2(:,y0id);
ModDepth3 = Z_fit_r3(:,y0id);

ModDepth = [ModDepth2,ModDepth3];
X = [0.8,1.2];

ModDep2mean = mean(ModDepth2);
ModDep2std = std(ModDepth2);
ModDep3mean = mean(ModDepth3);
ModDep3std = std(ModDepth3);

figure;
plot(X,ModDepth,'bo-')
hold on
errorbar(X+0.1,[ModDep2mean,ModDep3mean],[ModDep2std,ModDep3std],'ro-');
plot(1.6, ModDepth1,'ko');
errorbar(1.6+0.1, mean(ModDepth1), std(ModDepth1), 'ko-');
hold off
xlim([0,2])

[h,p,ci,stats] = ttest(ModDepth2,ModDepth3);
% p = 0.0077

figure,
scatter(depth1,ModDepth1)
plot(depth2, ModDepth2,'bo');
%%
y0cross1 = zeros(size(beta_r1,1),1);
y0cross2 = zeros(size(beta_r2,1),1);
y0cross3 = zeros(size(beta_r3,1),1);

for n=1:size(beta_r1,1)
    y0cross1(n,1) = x(find(Z_fit_r1(n,:)<0,1,'last') + 1);
end

for n=1:size(beta_r2,1)
    y0cross2(n,1) = x(find(Z_fit_r2(n,:)<0,1,'last') + 1);
    y0cross3(n,1) = x(find(Z_fit_r3(n,:)<0,1,'last') + 1);
end
y0cross = [y0cross2,y0cross3];

y0cross1mean = mean(y0cross1);
y0cross1std = std(y0cross1);

y0cross2mean = mean(y0cross2);
y0cross2std = std(y0cross2);
y0cross3mean = mean(y0cross3);
y0cross3std = std(y0cross3);

plot(X,y0cross,'bo-')
hold on
errorbar(X+0.1,[y0cross2mean,y0cross3mean],[y0cross2std,y0cross3std],'ro-');
plot(1.6, y0cross1,'ko');
errorbar(1.6+0.1, y0cross1mean,y0cross1std, 'ko-');
axis([0,2,-10,110])





[h,p,ci,stats] = ttest(y0cross2,y0cross3);
% p = 0.0065

figure,
plot(depth2, ModDepth2,'bo');
%%
%’†S‚ÌÀ•W‚Ì”äŠr stim 1 vs SZR

beta1_2all = csvread('/Users/lattice/Desktop/SC_2P_R_analysis/beta1_2&2_2/beta1_2.csv',1,1);
beta2_2all = csvread('/Users/lattice/Desktop/SC_2P_R_analysis/beta1_2&2_2/beta2_2.csv',1,1);

%[Center_comp_Pol(:,1),Center_comp_Pol(:,2)] = pol2cart(beta2_2all(:,2) - beta1_2all(:,2),beta2_2all(:,4) - beta1_2all(:,4));
[Center_comp_Pol(:,1),Center_comp_Pol(:,2)] = cart2pol(beta2_2all(:,2) - beta1_2all(:,2), beta2_2all(:,4) - beta1_2all(:,4));
x =beta2_2all(:,2) - beta1_2all(:,2);
y = beta2_2all(:,4) - beta1_2all(:,4);

%
theta = Center_comp_Pol(:,1);
rho = Center_comp_Pol(:,2);
sites = [1:40,49:length(theta)];

%ƒxƒNƒgƒ‹‚Ì•½‹Ï‚È‚Ì‚Å[x,y]‚É•ª‰ð‚µ‚Ä
meanx = mean(rho(sites).*cos(theta(sites)));
meany = mean(rho(sites).*sin(theta(sites)));
[thetamean, rhomean] = cart2pol(meanx,meany);

figure;
polar(theta,rho,'k.');hold on
polar(thetamean,rhomean,'ro');

%%
%‹»•±—}§‚Ì suppression center ‚Ì”äŠr

beta2_2OGB = csvread('/Users/lattice/Desktop/SC_2P_R_analysis/beta2_2Ex_In/OGB.csv',1,1);
beta2_2GFP = csvread('/Users/lattice/Desktop/SC_2P_R_analysis/beta2_2Ex_In/GFP.csv',1,1);

[Center_comp_Pol2(:,1), Center_comp_Pol2(:,2)] = cart2pol(beta2_2OGB(:,2) - beta2_2GFP(:,2), beta2_2OGB(:,4) - beta2_2GFP(:,4));
theta = Center_comp_Pol2(:,1);
rho = Center_comp_Pol2(:,2);

Center_comp(:,1)= beta2_2OGB(:,2) - beta2_2GFP(:,2);
Center_comp(:,2)= beta2_2OGB(:,4) - beta2_2GFP(:,4);

%ƒxƒNƒgƒ‹‚Ì•½‹Ï‚È‚Ì‚Å[x,y]‚É•ª‰ð‚µ‚Ä
meanx = mean(rho.*cos(theta));
meany = mean(rho.*sin(theta));
[thetamean, rhomean] = cart2pol(meanx,meany);

figure;
polar(theta,rho,'k.');hold on
polar(thetamean,rhomean,'ro');




%%
% SZR ‚Ì moduration ‚Æ ’†S‚©‚ç‚Ì‹——£ ‚ð Preffered size ‚Å plot
PSall = [];
SZRall = [];
Distall = [];
Peakall = [];
threshold = 0.07;
ID =[];
MeanDist = [];
%
cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/131111GAD/depth5');
peak = csvread('SC17_peak.csv');
szr = peak(:,5) - peak(:,1);
prefsize = csvread('SC17_prefsize.csv');
ROI_Polar = csvread('SC17_ROI_Polar.csv');
SR= [1:30,32:64];
GFP = [31,65:162];
OGB = setdiff(1:size(peak,1),[SR,GFP,[6 87]]);
roi = [GFP,OGB];
roicut = intersect(roi,find(peak(:,1) > threshold));

mDist = zeros(1,5);
for n = 1:5
    mDist(n) = mean(ROI_Polar(prefsize==n,2));
end
MeanDist = [MeanDist;mDist];
id = ones(length(roicut),1);
ID = [ID;id];


PSall = [PSall,prefsize(roicut)];
SZRall = [SZRall;szr(roicut)];
Distall = [Distall;ROI_Polar(roicut,2)];
Peakall = [Peakall;peak(roicut,:)];
%
cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/131111GAD/depth6');
peak = csvread('SC19_peak.csv');
szr = peak(:,5) - peak(:,1);
prefsize = csvread('SC19_prefsize.csv');
ROI_Polar = csvread('SC19_ROI_Polar.csv');
SR= [1:83];
GFP = [84:157,161:220,321,322];
OGB = setdiff(1:size(peak,1),[SR,GFP,[67 68 111 120 292]]);
roi = [GFP,OGB];
roicut = intersect(roi,find(peak(:,1) > threshold));

PSall = [PSall,prefsize(roicut)];
SZRall = [SZRall;szr(roicut)];
Distall = [Distall;ROI_Polar(roicut,2)];
Peakall = [Peakall;peak(roicut,:)];

mDist = zeros(1,5);
for n = 1:5
    mDist(n) = mean(ROI_Polar(prefsize==n,2));
end
MeanDist = [MeanDist;mDist];
id = ones(length(roicut),1)*2;
ID = [ID;id];
%
cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/131111GAD/depth1');
peak = csvread('SC3_peak.csv');
szr = peak(:,5) - peak(:,1);
prefsize = csvread('SC3_prefsize.csv');
ROI_Polar = csvread('SC3_ROI_Polar.csv');
SR= [1:62];
GFP = [63:162];
OGB = setdiff(1:size(peak,1),[SR,GFP,[38 57 63 65 101 108 131 148 192 201]]);
roi = [GFP,OGB];
roicut = intersect(roi,find(peak(:,1) > threshold));

PSall = [PSall,prefsize(roicut)];
SZRall = [SZRall;szr(roicut)];
Distall = [Distall;ROI_Polar(roicut,2)];
Peakall = [Peakall;peak(roicut,:)];
mDist = zeros(1,5);
for n = 1:5
    mDist(n) = mean(ROI_Polar(prefsize==n,2));
end
MeanDist = [MeanDist;mDist];
id = ones(length(roicut),1)*3;
ID = [ID;id];
%
cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/131108GAD/depth5');
peak = csvread('SC9_peak.csv');
szr = peak(:,5) - peak(:,1);
prefsize = csvread('SC9_prefsize.csv');
ROI_Polar = csvread('SC9_ROI_Polar.csv');
SR= [1:48,171];
GFP = [49:109];
%OGB = setdiff(1:size(peak,1),[SR,GFP]);
OGB = setdiff(1:size(peak,1),[GFP,SR]);
roi = [GFP,OGB];
roicut = intersect(roi,find(peak(:,1) > threshold));

PSall = [PSall,prefsize(roicut)];
SZRall = [SZRall;szr(roicut)];
Distall = [Distall;ROI_Polar(roicut,2)];
Peakall = [Peakall;peak(roicut,:)];
mDist = zeros(1,5);
for n = 1:5
    mDist(n) = mean(ROI_Polar(prefsize==n,2));
end
MeanDist = [MeanDist;mDist];
id = ones(length(roicut),1)*4;
ID = [ID;id];
%
cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/130208GAD/SC3');
peak = csvread('SC3_peak.csv');
szr = peak(:,5) - peak(:,1);
prefsize = csvread('SC3_prefsize.csv');
ROI_Polar = csvread('SC3_ROI_Polar.csv');
SR = [1:5,7:12,14:20,34:41,43:52,54:60,182];
GFP = [6,30:32,42,61:126,149,151,155,157,168,169,181];
NN = [13,21,148,150,153,154,156,158:163,165,166,170:179];
OGB = setdiff(1:size(peak,1),[SR,GFP,NN]);
roi = [GFP,OGB];
roicut = intersect(roi,find(peak(:,1) > threshold));

PSall = [PSall,prefsize(roicut)];
SZRall = [SZRall;szr(roicut)];
Distall = [Distall;ROI_Polar(roicut,2)];
Peakall = [Peakall;peak(roicut,:)];
mDist = zeros(1,5);
for n = 1:5
    mDist(n) = mean(ROI_Polar(prefsize==n,2));
end
MeanDist = [MeanDist;mDist];
id = ones(length(roicut),1)*5;
ID = [ID;id];
%
cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/130208GAD/SC5');
peak = csvread('SC5_peak.csv');
szr = peak(:,5) - peak(:,1);
prefsize = csvread('SC5_prefsize.csv');
ROI_Polar = csvread('SC5_ROI_Polar.csv');
SR = [1:5,7:12,14:20,34:41,43:52,54:60,183,190];
GFP = [6,31:32,42,61:125,149,151,156,157,160,161,168,169,174:176,178,182,191,193,195];
NN = [13,21,30,33,53,148,153:155,158,162,165,167,173,177,179:181,184,186,188,189,192];
OGB = setdiff(1:size(peak,1),[SR,GFP,NN]);
roi = [GFP,OGB];
roicut = intersect(roi,find(peak(:,1) > threshold));

PSall = [PSall,prefsize(roicut)];
SZRall = [SZRall;szr(roicut)];
Distall = [Distall;ROI_Polar(roicut,2)];
Peakall = [Peakall;peak(roicut,:)];
mDist = zeros(1,5);
for n = 1:5
    mDist(n) = mean(ROI_Polar(prefsize==n,2));
end
MeanDist = [MeanDist;mDist];
id = ones(length(roicut),1)*6;
ID = [ID;id];
%
cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/130208GAD/SC7');
peak = csvread('SC7_peak.csv');
szr = peak(:,5) - peak(:,1);
prefsize = csvread('SC7_prefsize.csv');
ROI_Polar = csvread('SC7_ROI_Polar.csv');
SR = [1:11,13:16,18:21,23:25,28:47,49,50];
GFP = [17,51:119,138,141,150,151,165:167,170,172,174];
NN = [22,26,27.137,139,140,144,145,147:149,152:155,160:164,168,169,173];
OGB = setdiff(1:size(peak,1),[SR,GFP,NN]);
roi = [GFP,OGB];
roicut = intersect(roi,find(peak(:,1) > threshold));

PSall = [PSall,prefsize(roicut)];
SZRall = [SZRall;szr(roicut)];
Distall = [Distall;ROI_Polar(roicut,2)];
Peakall = [Peakall;peak(roicut,:)];
mDist = zeros(1,5);
for n = 1:5
    mDist(n) = mean(ROI_Polar(prefsize==n,2));
end
MeanDist = [MeanDist;mDist];
id = ones(length(roicut),1)*7;
ID = [ID;id];
%
cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/130208GAD/SC21');cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/130208GAD/SC21');
peak = csvread('SC21_peak.csv');
szr = peak(:,5) - peak(:,1);
prefsize = csvread('SC21_prefsize.csv');
ROI_Polar = csvread('SC21_ROI_Polar.csv');
SR = [1:22,24,25,27:29,189];
GFP = [30:117,153,154,156:159,161:163,167,169,172:182,187,188,195:197,200];
NN = [23,26,155,160,164,165,170,171,];
OGB = setdiff(1:size(peak,1),[SR,GFP,NN]);
roi = [GFP,OGB];
roicut = intersect(roi,find(peak(:,1) > threshold));

PSall = [PSall,prefsize(roicut)];
SZRall = [SZRall;szr(roicut)];
Distall = [Distall;ROI_Polar(roicut,2)];
Peakall = [Peakall;peak(roicut,:)];
mDist = zeros(1,5);
for n = 1:5
    mDist(n) = mean(ROI_Polar(prefsize==n,2));
end
MeanDist = [MeanDist;mDist];
id = ones(length(roicut),1)*8;
ID = [ID;id];
%
cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/130208GAD/SC23');
peak = csvread('SC23_peak.csv');
szr = peak(:,5) - peak(:,1);
prefsize = csvread('SC23_prefsize.csv');
ROI_Polar = csvread('SC23_ROI_Polar.csv');
SR = [1:22,24,25,27:29,189];
GFP = [30:117,153,154,156:159,161:163,167,169,172:182,187,188,195:197,200];
NN = [23,26,155,160,164,165,170,171,];
OGB = setdiff(1:size(peak,1),[SR,GFP,NN]);
roi = [GFP,OGB];
roicut = intersect(roi,find(peak(:,1) > threshold));

PSall = [PSall,prefsize(roicut)];
SZRall = [SZRall;szr(roicut)];
Distall = [Distall;ROI_Polar(roicut,2)];
Peakall = [Peakall;peak(roicut,:)];
mDist = zeros(1,5);
for n = 1:5
    mDist(n) = mean(ROI_Polar(prefsize==n,2));
end
MeanDist = [MeanDist;mDist];
id = ones(length(roicut),1)*9;
ID = [ID;id];
%
cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/130208GAD/SC24');
peak = csvread('SC24_peak.csv');
szr = peak(:,5) - peak(:,1);
prefsize = csvread('SC24_prefsize.csv');
ROI_Polar = csvread('SC24_ROI_Polar.csv');
SR = [1:22,24,25,27:29,189];
GFP = [30:117,153,154,156:159,161:163,167,169,172:182,187,188,195:197,200];
NN = [23,26,155,160,164,165,170,171,];
OGB = setdiff(1:size(peak,1),[SR,GFP,NN]);
roi = [GFP,OGB];
roicut = intersect(roi,find(peak(:,1) > threshold));

PSall = [PSall,prefsize(roicut)];
SZRall = [SZRall;szr(roicut)];
Distall = [Distall;ROI_Polar(roicut,2)];
Peakall = [Peakall;peak(roicut,:)];
mDist = zeros(1,5);
for n = 1:5
    mDist(n) = mean(ROI_Polar(prefsize==n,2));
end
MeanDist = [MeanDist;mDist];
id = ones(length(roicut),1)*10;
ID = [ID;id];
%
cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/130208GAD/SC26');
peak = csvread('SC26_peak.csv');
szr = peak(:,5) - peak(:,1);
prefsize = csvread('SC26_prefsize.csv');
ROI_Polar = csvread('SC26_ROI_Polar.csv');
SR = [1:58,206,256];
GFP = [59:150,194,195,197,198,202:205,209,211,213:215,218,219,221,230,234,243,244,249,252,253,257:260];
NN = [186,187,193,196,199,200,225:228,231,232,237,242,247,248,250,251,255];
OGB = setdiff(1:size(peak,1),[SR,GFP,NN]);
roi = [GFP,OGB];
roicut = intersect(roi,find(peak(:,1) > threshold));

PSall = [PSall,prefsize(roicut)];
SZRall = [SZRall;szr(roicut)];
Distall = [Distall;ROI_Polar(roicut,2)];
Peakall = [Peakall;peak(roicut,:)];
mDist = zeros(1,5);
for n = 1:5
    mDist(n) = mean(ROI_Polar(prefsize==n,2));
end
MeanDist = [MeanDist;mDist];
id = ones(length(roicut),1)*11;
ID = [ID;id];
%
cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/130208GAD/SC28');
peak = csvread('SC28_peak.csv');
szr = peak(:,5) - peak(:,1);
prefsize = csvread('SC28_prefsize.csv');
ROI_Polar = csvread('SC28_ROI_Polar.csv');
SR = [1:32];
GFP = [33:108,113,115,126,128,131,138,141,143:145,150,152,154,156,159,163,164,167,168,170];
NN = [117,149,161,169];
OGB = setdiff(1:size(peak,1),[SR,GFP,NN]);
roi = [GFP,OGB];
roicut = intersect(roi,find(peak(:,1) > threshold));

PSall = [PSall,prefsize(roicut)];
SZRall = [SZRall;szr(roicut)];
Distall = [Distall;ROI_Polar(roicut,2)];
Peakall = [Peakall;peak(roicut,:)];
mDist = zeros(1,5);
for n = 1:5
    mDist(n) = mean(ROI_Polar(prefsize==n,2));
end
MeanDist = [MeanDist;mDist];
id = ones(length(roicut),1)*12;
ID = [ID;id];
%
cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/130208GAD/SC29');
peak = csvread('SC29_peak.csv');
szr = peak(:,5) - peak(:,1);
prefsize = csvread('SC29_prefsize.csv');
ROI_Polar = csvread('SC29_ROI_Polar.csv');
SR = [12,21,22,29,30,44,51,57,64,76,84,86,90,91];
GFP = [5,6,8,10,11,13,14,16,23,25:28,32,34:37,39:42,47,48,50,52,55,56,58,62,63,65,67,68,71:73,75,78,80,81,88,89,93:97,99,101];
NN = [38,45,59];
OGB = setdiff(1:size(peak,1),[SR,GFP,NN]);
roi = [GFP,OGB];
roicut = intersect(roi,find(peak(:,1) > threshold));

PSall = [PSall,prefsize(roicut)];
SZRall = [SZRall;szr(roicut)];
Distall = [Distall;ROI_Polar(roicut,2)];
Peakall = [Peakall;peak(roicut,:)];
mDist = zeros(1,5);
for n = 1:5
    mDist(n) = mean(ROI_Polar(prefsize==n,2));
end
MeanDist = [MeanDist;mDist];
id = ones(length(roicut),1)*13;
ID = [ID;id];
%
cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/130206GAD/SC10');
peak = csvread('SC10_peak.csv');
szr = peak(:,5) - peak(:,1);
prefsize = csvread('SC10_prefsize.csv');
ROI_Polar = csvread('SC10_ROI_Polar.csv');
SR = [1:11,13:30,32:37,40:44,121,152];
GFP = [12,31,38,45:107,119,132,134,143,146];
NN = [39,126];
OGB = setdiff(1:size(peak,1),[SR,GFP,NN]);
roi = [GFP,OGB];
roicut = intersect(roi,find(peak(:,1) > threshold));

PSall = [PSall,prefsize(roicut)];
SZRall = [SZRall;szr(roicut)];
Distall = [Distall;ROI_Polar(roicut,2)];
Peakall = [Peakall;peak(roicut,:)];
mDist = zeros(1,5);
for n = 1:5
    mDist(n) = mean(ROI_Polar(prefsize==n,2));
end
MeanDist = [MeanDist;mDist];
id = ones(length(roicut),1)*14;
ID = [ID;id];
%
cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/130206GAD/SC11');
peak = csvread('SC11_peak.csv');
szr = peak(:,5) - peak(:,1);
prefsize = csvread('SC11_prefsize.csv');
ROI_Polar = csvread('SC11_ROI_Polar.csv');
SR = [1:11,13:30,32:37,40:44,121,152];
GFP = [12,31,38,45:107,119,132,134,143,146,166];
NN = [39,126];
OGB = setdiff(1:size(peak,1),[SR,GFP,NN]);
roi = [GFP,OGB];
roicut = intersect(roi,find(peak(:,1) > threshold));

PSall = [PSall,prefsize(roicut)];
SZRall = [SZRall;szr(roicut)];
Distall = [Distall;ROI_Polar(roicut,2)];
Peakall = [Peakall;peak(roicut,:)];
mDist = zeros(1,5);
for n = 1:5
    mDist(n) = mean(ROI_Polar(prefsize==n,2));
end
MeanDist = [MeanDist;mDist];
id = ones(length(roicut),1)*15;
ID = [ID;id];
%
cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/130206GAD/SC27');
peak = csvread('SC27_peak.csv');
szr = peak(:,5) - peak(:,1);
prefsize = csvread('SC27_prefsize.csv');
ROI_Polar = csvread('SC27_ROI_Polar.csv');
SR = [1:46];
GFP = [47:108,115:119,123,128,131,132,135,138,140,141,147,149,151];
NN = [];
OGB = setdiff(1:size(peak,1),[SR,GFP,NN]);
roi = [GFP,OGB];
roicut = intersect(roi,find(peak(:,1) > threshold));

PSall = [PSall,prefsize(roicut)];
SZRall = [SZRall;szr(roicut)];
Distall = [Distall;ROI_Polar(roicut,2)];
Peakall = [Peakall;peak(roicut,:)];
mDist = zeros(1,5);
for n = 1:5
    mDist(n) = mean(ROI_Polar(prefsize==n,2));
end
MeanDist = [MeanDist;mDist];
id = ones(length(roicut),1)*16;
ID = [ID;id];
%
cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/130206GAD/SC28');
peak = csvread('SC28_peak.csv');
szr = peak(:,5) - peak(:,1);
prefsize = csvread('SC28_prefsize.csv');
ROI_Polar = csvread('SC28_ROI_Polar.csv');
SR = [1:46];
GFP = [47:108,115:119,123,128,131,132,135,138,140,141,147,149,151];
NN = [];
OGB = setdiff(1:size(peak,1),[SR,GFP,NN]);

roi = [GFP,OGB];
roicut = intersect(roi,find(peak(:,1) > threshold));

PSall = [PSall,prefsize(roicut)];
SZRall = [SZRall;szr(roicut)];
Distall = [Distall;ROI_Polar(roicut,2)];
Peakall = [Peakall;peak(roicut,:)];
mDist = zeros(1,5);
for n = 1:5
    mDist(n) = mean(ROI_Polar(prefsize==n,2));
end
MeanDist = [MeanDist;mDist];
id = ones(length(roicut),1)*17;
ID = [ID;id];
%
cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/130206GAD/SC30');
peak = csvread('SC30_peak.csv');
szr = peak(:,5) - peak(:,1);
prefsize = csvread('SC30_prefsize.csv');
ROI_Polar = csvread('SC30_ROI_Polar.csv');
SR = [1:46];
GFP = [47:107,113,116,126:131,136,144,148,151,153:155];
NN = [];
OGB = setdiff(1:size(peak,1),[SR,GFP,NN]);

roi = [GFP,OGB];
roicut = intersect(roi,find(peak(:,1) > threshold));

PSall = [PSall,prefsize(roicut)];
SZRall = [SZRall;szr(roicut)];
Distall = [Distall;ROI_Polar(roicut,2)];
Peakall = [Peakall;peak(roicut,:)];
mDist = zeros(1,5);
for n = 1:5
    mDist(n) = mean(ROI_Polar(prefsize==n,2));
end
MeanDist = [MeanDist;mDist];
id = ones(length(roicut),1)*18;
ID = [ID;id];
%
cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/130206GAD/SC31');
peak = csvread('SC31_peak.csv');
szr = peak(:,5) - peak(:,1);
prefsize = csvread('SC31_prefsize.csv');
ROI_Polar = csvread('SC31_ROI_Polar.csv');
SR = [1:46];
GFP = [47:107,113,116,126:131,136,144,148,151,153:155,158];
NN = [];
OGB = setdiff(1:size(peak,1),[SR,GFP,NN]);

roi = [GFP,OGB];
roicut = intersect(roi,find(peak(:,1) > threshold));

PSall = [PSall,prefsize(roicut)];
SZRall = [SZRall;szr(roicut)];
Distall = [Distall;ROI_Polar(roicut,2)];
Peakall = [Peakall;peak(roicut,:)];
mDist = zeros(1,5);
for n = 1:5
    mDist(n) = mean(ROI_Polar(prefsize==n,2));
end
MeanDist = [MeanDist;mDist];
id = ones(length(roicut),1)*19;
ID = [ID;id];
%
GFP = [];
cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/131106WT/depth1');
peak = csvread('SC2_peak.csv');
szr = peak(:,5) - peak(:,1);
prefsize = csvread('SC2_prefsize.csv');
ROI_Polar = csvread('SC2_ROI_Polar.csv');
SR = [1:61];
notuse = [155,162,167,181,182,185:192];
OGB = setdiff(1:size(peak,1),[SR,notuse]);

roi = [GFP,OGB];
roicut = intersect(roi,find(peak(:,1) > threshold));

PSall = [PSall,prefsize(roicut)];
SZRall = [SZRall;szr(roicut)];
Distall = [Distall;ROI_Polar(roicut,2)];
Peakall = [Peakall;peak(roicut,:)];
mDist = zeros(1,5);
for n = 1:5
    mDist(n) = mean(ROI_Polar(prefsize==n,2));
end
MeanDist = [MeanDist;mDist];
id = ones(length(roicut),1)*20;
ID = [ID;id];
%
peak = csvread('SC3_peak.csv');
szr = peak(:,5) - peak(:,1);
prefsize = csvread('SC3_prefsize.csv');
ROI_Polar = csvread('SC3_ROI_Polar.csv');
SR = [1:61];
notuse = [155,162,167,181,182,185:192];
OGB = setdiff(1:size(peak,1),[SR,notuse]);

roi = [GFP,OGB];
roicut = intersect(roi,find(peak(:,1) > threshold));

PSall = [PSall,prefsize(roicut)];
SZRall = [SZRall;szr(roicut)];
Distall = [Distall;ROI_Polar(roicut,2)];
Peakall = [Peakall;peak(roicut,:)];
mDist = zeros(1,5);
for n = 1:5
    mDist(n) = mean(ROI_Polar(prefsize==n,2));
end
MeanDist = [MeanDist;mDist];
id = ones(length(roicut),1)*21;
ID = [ID;id];
%
cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/131106WT/depth2_');
peak = csvread('SC7_peak.csv');
szr = peak(:,5) - peak(:,1);
prefsize = csvread('SC7_prefsize.csv');
ROI_Polar = csvread('SC7_ROI_Polar.csv');
SR= [1:54,114:116,120];
OGB = setdiff(1:size(peak,1),SR);

roi = [GFP,OGB];
roicut = intersect(roi,find(peak(:,1) > threshold));

PSall = [PSall,prefsize(roicut)];
SZRall = [SZRall;szr(roicut)];
Distall = [Distall;ROI_Polar(roicut,2)];
Peakall = [Peakall;peak(roicut,:)];
mDist = zeros(1,5);
for n = 1:5
    mDist(n) = mean(ROI_Polar(prefsize==n,2));
end
MeanDist = [MeanDist;mDist];
id = ones(length(roicut),1)*22;
ID = [ID;id];
%
cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/131106WT/depth4');
peak = csvread('SC12_peak.csv');
szr = peak(:,5) - peak(:,1);
prefsize = csvread('SC12_prefsize.csv');
ROI_Polar = csvread('SC12_ROI_Polar.csv');
SR= [1:54,114:116,120];
OGB = setdiff(1:size(peak,1),SR);

roi = [GFP,OGB];
roicut = intersect(roi,find(peak(:,1) > threshold));

PSall = [PSall,prefsize(roicut)];
SZRall = [SZRall;szr(roicut)];
Distall = [Distall;ROI_Polar(roicut,2)];
Peakall = [Peakall;peak(roicut,:)];
mDist = zeros(1,5);
for n = 1:5
    mDist(n) = mean(ROI_Polar(prefsize==n,2));
end
MeanDist = [MeanDist;mDist];
id = ones(length(roicut),1)*23;
ID = [ID;id];
%
cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/131106WT/depth5');
peak = csvread('SC16_peak.csv');
szr = peak(:,5) - peak(:,1);
prefsize = csvread('SC16_prefsize.csv');
ROI_Polar = csvread('SC16_ROI_Polar.csv');
SR= [1:42,165,174,175];
OGB = setdiff(1:size(peak,1),SR);

roi = [GFP,OGB];
roicut = intersect(roi,find(peak(:,1) > threshold));

PSall = [PSall,prefsize(roicut)];
SZRall = [SZRall;szr(roicut)];
Distall = [Distall;ROI_Polar(roicut,2)];
Peakall = [Peakall;peak(roicut,:)];
mDist = zeros(1,5);
for n = 1:5
    mDist(n) = mean(ROI_Polar(prefsize==n,2));
end
MeanDist = [MeanDist;mDist];
id = ones(length(roicut),1)*24;
ID = [ID;id];
%
cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/131106WT/depth6_');
peak = csvread('SC19_peak.csv');
szr = peak(:,5) - peak(:,1);
prefsize = csvread('SC19_prefsize.csv');
ROI_Polar = csvread('SC19_ROI_Polar.csv');
SR= [1:67];
OGB = setdiff(1:size(peak,1),SR);

roi = [GFP,OGB];
roicut = intersect(roi,find(peak(:,1) > threshold));

PSall = [PSall,prefsize(roicut)];
SZRall = [SZRall;szr(roicut)];
Distall = [Distall;ROI_Polar(roicut,2)];
Peakall = [Peakall;peak(roicut,:)];
mDist = zeros(1,5);
for n = 1:5
    mDist(n) = mean(ROI_Polar(prefsize==n,2));
end
MeanDist = [MeanDist;mDist];
id = ones(length(roicut),1)*25;
ID = [ID;id];
%
cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/131106WT/depth7');
peak = csvread('SC23_peak.csv');
szr = peak(:,5) - peak(:,1);
prefsize = csvread('SC23_prefsize.csv');
ROI_Polar = csvread('SC23_ROI_Polar.csv');
SR= [1:64];
GFP =[];
OGB = setdiff(1:size(peak,1),SR);

roi = [GFP,OGB];
roicut = intersect(roi,find(peak(:,1) > threshold));

PSall = [PSall,prefsize(roicut)];
SZRall = [SZRall;szr(roicut)];
Distall = [Distall;ROI_Polar(roicut,2)];
Peakall = [Peakall;peak(roicut,:)];
mDist = zeros(1,5);
for n = 1:5
    mDist(n) = mean(ROI_Polar(prefsize==n,2));
end
MeanDist = [MeanDist;mDist];
id = ones(length(roicut),1)*26;
ID = [ID;id];
%
cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/130909WT/depth1');
peak = csvread('SC2_peak.csv');
szr = peak(:,5) - peak(:,1);
prefsize = csvread('SC2_prefsize.csv');
ROI_Polar = csvread('SC2_ROI_Polar.csv');
SR = [1:78,172];
OGB = setdiff(1:size(peak,1),SR);

roi = [GFP,OGB];
roicut = intersect(roi,find(peak(:,1) > threshold));

PSall = [PSall,prefsize(roicut)];
SZRall = [SZRall;szr(roicut)];
Distall = [Distall;ROI_Polar(roicut,2)];
Peakall = [Peakall;peak(roicut,:)];
mDist = zeros(1,5);
for n = 1:5
    mDist(n) = mean(ROI_Polar(prefsize==n,2));
end
MeanDist = [MeanDist;mDist];
id = ones(length(roicut),1)*27;
ID = [ID;id];
%
peak = csvread('SC6_peak.csv');
szr = peak(:,5) - peak(:,1);
prefsize = csvread('SC6_prefsize.csv');
ROI_Polar = csvread('SC6_ROI_Polar.csv');
SR = [1:27,97];
OGB = setdiff(1:size(peak,1),SR);

roi = [GFP,OGB];
roicut = intersect(roi,find(peak(:,1) > threshold));

PSall = [PSall,prefsize(roicut)];
SZRall = [SZRall;szr(roicut)];
Distall = [Distall;ROI_Polar(roicut,2)];
Peakall = [Peakall;peak(roicut,:)];
id = ones(length(roicut),1)*28;
ID = [ID;id];
%
cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/130909WT/depth2');
peak = csvread('SC10_peak.csv');
szr = peak(:,5) - peak(:,1);
prefsize = csvread('SC10_prefsize.csv');
ROI_Polar = csvread('SC10_ROI_Polar.csv');
SR = [1:90];
OGB = setdiff(1:size(peak,1),SR);

roi = [GFP,OGB];
roicut = intersect(roi,find(peak(:,1) > threshold));

PSall = [PSall,prefsize(roicut)];
SZRall = [SZRall;szr(roicut)];
Distall = [Distall;ROI_Polar(roicut,2)];
Peakall = [Peakall;peak(roicut,:)];
mDist = zeros(1,5);
for n = 1:5
    mDist(n) = mean(ROI_Polar(prefsize==n,2));
end
MeanDist = [MeanDist;mDist];
id = ones(length(roicut),1)*29;
ID = [ID;id];
%
peak = csvread('SC11_peak.csv');
szr = peak(:,5) - peak(:,1);
prefsize = csvread('SC11_prefsize.csv');
ROI_Polar = csvread('SC11_ROI_Polar.csv');
SR = [1:27,97];
OGB = setdiff(1:size(peak,1),SR);

roi = [GFP,OGB];
roicut = intersect(roi,find(peak(:,1) > threshold));

PSall = [PSall,prefsize(roicut)];
SZRall = [SZRall;szr(roicut)];
Distall = [Distall;ROI_Polar(roicut,2)];
Peakall = [Peakall;peak(roicut,:)];
mDist = zeros(1,5);
for n = 1:5
    mDist(n) = mean(ROI_Polar(prefsize==n,2));
end
MeanDist = [MeanDist;mDist];
id = ones(length(roicut),1)*30;
ID = [ID;id];
%
cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/130909WT/depth3');
peak = csvread('SC15_peak.csv');
szr = peak(:,5) - peak(:,1);
prefsize = csvread('SC15_prefsize.csv');
ROI_Polar = csvread('SC15_ROI_Polar.csv');
SR = [1:99];
OGB = setdiff(1:size(peak,1),SR);

roi = [GFP,OGB];
roicut = intersect(roi,find(peak(:,1) > threshold));

PSall = [PSall,prefsize(roicut)];
SZRall = [SZRall;szr(roicut)];
Distall = [Distall;ROI_Polar(roicut,2)];
Peakall = [Peakall;peak(roicut,:)];
mDist = zeros(1,5);
for n = 1:5
    mDist(n) = mean(ROI_Polar(prefsize==n,2));
end
MeanDist = [MeanDist;mDist];
id = ones(length(roicut),1)*31;
ID = [ID;id];
%
cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/130909WT/depth4');
peak = csvread('SC19_peak.csv');
szr = peak(:,5) - peak(:,1);
prefsize = csvread('SC19_prefsize.csv');
ROI_Polar = csvread('SC19_ROI_Polar.csv');
SR = [1:89];
OGB = setdiff(1:size(peak,1),SR);

roi = [GFP,OGB];
roicut = intersect(roi,find(peak(:,1) > threshold));

PSall = [PSall,prefsize(roicut)];
SZRall = [SZRall;szr(roicut)];
Distall = [Distall;ROI_Polar(roicut,2)];
Peakall = [Peakall;peak(roicut,:)];
mDist = zeros(1,5);
for n = 1:5
    mDist(n) = mean(ROI_Polar(prefsize==n,2));
end
MeanDist = [MeanDist;mDist];
id = ones(length(roicut),1)*32;
ID = [ID;id];
%
cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/130909WT/depth5');
peak = csvread('SC23_peak.csv');
szr = peak(:,5) - peak(:,1);
prefsize = csvread('SC23_prefsize.csv');
ROI_Polar = csvread('SC23_ROI_Polar.csv');
SR = [1:70];
OGB = setdiff(1:size(peak,1),SR);

roi = [GFP,OGB];
roicut = intersect(roi,find(peak(:,1) > threshold));

PSall = [PSall,prefsize(roicut)];
SZRall = [SZRall;szr(roicut)];
Distall = [Distall;ROI_Polar(roicut,2)];
Peakall = [Peakall;peak(roicut,:)];
mDist = zeros(1,5);
for n = 1:5
    mDist(n) = mean(ROI_Polar(prefsize==n,2));
end
MeanDist = [MeanDist;mDist];
id = ones(length(roicut),1)*33;
ID = [ID;id];
%
cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/130906WT/depth1');
peak = csvread('SC10_peak.csv');
szr = peak(:,5) - peak(:,1);
prefsize = csvread('SC10_prefsize.csv');
ROI_Polar = csvread('SC10_ROI_Polar.csv');
OGB = 55:size(peak,1);

roi = [GFP,OGB];
roicut = intersect(roi,find(peak(:,1) > threshold));

PSall = [PSall,prefsize(roicut)];
SZRall = [SZRall;szr(roicut)];
Distall = [Distall;ROI_Polar(roicut,2)];
Peakall = [Peakall;peak(roicut,:)];
mDist = zeros(1,5);
for n = 1:5
    mDist(n) = mean(ROI_Polar(prefsize==n,2));
end
MeanDist = [MeanDist;mDist];
id = ones(length(roicut),1)*34;
ID = [ID;id];
%
peak = csvread('SC9_peak.csv');
szr = peak(:,5) - peak(:,1);
prefsize = csvread('SC9_prefsize.csv');
ROI_Polar = csvread('SC9_ROI_Polar.csv');
OGB = 55:size(peak,1);

roi = [GFP,OGB];
roicut = intersect(roi,find(peak(:,1) > threshold));

PSall = [PSall,prefsize(roicut)];
SZRall = [SZRall;szr(roicut)];
Distall = [Distall;ROI_Polar(roicut,2)];
Peakall = [Peakall;peak(roicut,:)];
mDist = zeros(1,5);
for n = 1:5
    mDist(n) = mean(ROI_Polar(prefsize==n,2));
end
MeanDist = [MeanDist;mDist];
id = ones(length(roicut),1)*35;
ID = [ID;id];
%
cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/130906WT/depth2');
peak = csvread('SC12_peak.csv');
szr = peak(:,5) - peak(:,1);
prefsize = csvread('SC12_prefsize.csv');
ROI_Polar = csvread('SC12_ROI_Polar.csv');
OGB = 82:size(peak,1);

roi = [GFP,OGB];
roicut = intersect(roi,find(peak(:,1) > threshold));

PSall = [PSall,prefsize(roicut)];
SZRall = [SZRall;szr(roicut)];
Distall = [Distall;ROI_Polar(roicut,2)];
Peakall = [Peakall;peak(roicut,:)];
mDist = zeros(1,5);
for n = 1:5
    mDist(n) = mean(ROI_Polar(prefsize==n,2));
end
MeanDist = [MeanDist;mDist];
id = ones(length(roicut),1)*36;
ID = [ID;id];
%{
cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/130906WT/depth3');
peak = csvread('SC15_peak.csv');
szr = peak(:,5) - peak(:,1);
prefsize = csvread('SC15_prefsize.csv');
ROI_Polar = csvread('SC15_ROI_Polar.csv');
OGB = 1:size(peak,1);

roi = [GFP,OGB];
roicut = intersect(roi,find(peak(:,1) > threshold));

PSall = [PSall,prefsize(roicut)];
SZRall = [SZRall;szr(roicut)];
Distall = [Distall;ROI_Polar(roicut,2)];
%}

%
cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/130906WT/depth5');
peak = csvread('SC20_peak.csv');
szr = peak(:,5) - peak(:,1);
prefsize = csvread('SC20_prefsize.csv');
ROI_Polar = csvread('SC20_ROI_Polar.csv');
SR = 1:89;
OGB = 90:size(peak,1);

roi = [GFP,OGB];
roicut = intersect(roi,find(peak(:,1) > threshold));

PSall = [PSall,prefsize(roicut)];
SZRall = [SZRall;szr(roicut)];
Distall = [Distall;ROI_Polar(roicut,2)];
Peakall = [Peakall;peak(roicut,:)];
mDist = zeros(1,5);
for n = 1:5
    mDist(n) = mean(ROI_Polar(prefsize==n,2));
end
MeanDist = [MeanDist;mDist];
id = ones(length(roicut),1)*37;
ID = [ID;id];
%
cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/130906WT/depth7');
peak = csvread('SC27_peak.csv');
szr = peak(:,5) - peak(:,1);
prefsize = csvread('SC27_prefsize.csv');
ROI_Polar = csvread('SC27_ROI_Polar.csv');
OGB = 132:size(peak,1);

roi = [GFP,OGB];
roicut = intersect(roi,find(peak(:,1) > threshold));

PSall = [PSall,prefsize(roicut)];
SZRall = [SZRall;szr(roicut)];
Distall = [Distall;ROI_Polar(roicut,2)];
Peakall = [Peakall;peak(roicut,:)];
mDist = zeros(1,5);
for n = 1:5
    mDist(n) = mean(ROI_Polar(prefsize==n,2));
end
MeanDist = [MeanDist;mDist];
id = ones(length(roicut),1)*38;
ID = [ID;id];
%
cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/130906WT/depth10');
peak = csvread('SC34_peak.csv');
szr = peak(:,5) - peak(:,1);
prefsize = csvread('SC34_prefsize.csv');
ROI_Polar = csvread('SC34_ROI_Polar.csv');
OGB = 87:size(peak,1);

roi = [GFP,OGB];
roicut = intersect(roi,find(peak(:,1) > threshold));

PSall = [PSall,prefsize(roicut)];
SZRall = [SZRall;szr(roicut)];
Distall = [Distall;ROI_Polar(roicut,2)];
Peakall = [Peakall;peak(roicut,:)];
mDist = zeros(1,5);
for n = 1:5
    mDist(n) = mean(ROI_Polar(prefsize==n,2));
end
MeanDist = [MeanDist;mDist];
id = ones(length(roicut),1)*39;
ID = [ID;id];
%
cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/130819WT/depth2-10/');
peak = csvread('SC13_peak.csv');
szr = peak(:,5) - peak(:,1);
prefsize = csvread('SC13_prefsize.csv');
ROI_Polar = csvread('SC13_ROI_Polar.csv');
GFP =[];
SR = [1:110,112:116,118,163,167,241,242,262];
OGB = setdiff(1:size(peak,1),SR);

roi = [GFP,OGB];
roicut = intersect(roi,find(peak(:,1) > threshold));

PSall = [PSall,prefsize(roicut)];
SZRall = [SZRall;szr(roicut)];
Distall = [Distall;ROI_Polar(roicut,2)];
Peakall = [Peakall;peak(roicut,:)];
mDist = zeros(1,5);
for n = 1:5
    mDist(n) = mean(ROI_Polar(prefsize==n,2));
end
MeanDist = [MeanDist;mDist];
id = ones(length(roicut),1)*40;
ID = [ID;id];
%
peak = csvread('SC14_peak.csv');
szr = peak(:,5) - peak(:,1);
prefsize = csvread('SC14_prefsize.csv');
ROI_Polar = csvread('SC14_ROI_Polar.csv');
GFP =[];
SR = [1:58,152:158,240,241];
OGB = setdiff(1:size(peak,1),SR);

roi = [GFP,OGB];
roicut = intersect(roi,find(peak(:,1) > threshold));

PSall = [PSall,prefsize(roicut)];
SZRall = [SZRall;szr(roicut)];
Distall = [Distall;ROI_Polar(roicut,2)];
Peakall = [Peakall;peak(roicut,:)];
mDist = zeros(1,5);
for n = 1:5
    mDist(n) = mean(ROI_Polar(prefsize==n,2));
end
MeanDist = [MeanDist;mDist];
id = ones(length(roicut),1)*41;
ID = [ID;id];
%
peak = csvread('SC15_peak.csv');
szr = peak(:,5) - peak(:,1);
prefsize = csvread('SC15_prefsize.csv');
ROI_Polar = csvread('SC15_ROI_Polar.csv');
GFP =[];
SR = [1:68,98,116:119,156:159,164];
OGB = setdiff(1:size(peak,1),SR);

roi = [GFP,OGB];
roicut = intersect(roi,find(peak(:,1) > threshold));

PSall = [PSall,prefsize(roicut)];
SZRall = [SZRall;szr(roicut)];
Distall = [Distall;ROI_Polar(roicut,2)];
Peakall = [Peakall;peak(roicut,:)];
mDist = zeros(1,5);
for n = 1:5
    mDist(n) = mean(ROI_Polar(prefsize==n,2));
end
MeanDist = [MeanDist;mDist];
id = ones(length(roicut),1)*42;
ID = [ID;id];
%
peak = csvread('SC16_peak.csv');
szr = peak(:,5) - peak(:,1);
prefsize = csvread('SC16_prefsize.csv');
ROI_Polar = csvread('SC16_ROI_Polar.csv');
GFP =[];
SR = [1:72,202:205,211,220,221];
OGB = setdiff(1:size(peak,1),SR);

roi = [GFP,OGB];
roicut = intersect(roi,find(peak(:,1) > threshold));

PSall = [PSall,prefsize(roicut)];
SZRall = [SZRall;szr(roicut)];
Distall = [Distall;ROI_Polar(roicut,2)];
Peakall = [Peakall;peak(roicut,:)];
mDist = zeros(1,5);
for n = 1:5
    mDist(n) = mean(ROI_Polar(prefsize==n,2));
end
MeanDist = [MeanDist;mDist];
id = ones(length(roicut),1)*43;
ID = [ID;id];
%
peak = csvread('SC17_peak.csv');
szr = peak(:,5) - peak(:,1);
prefsize = csvread('SC17_prefsize.csv');
ROI_Polar = csvread('SC17_ROI_Polar.csv');
GFP =[];
SR = [1:69,121];
OGB = setdiff(1:size(peak,1),SR);

roi = [GFP,OGB];
roicut = intersect(roi,find(peak(:,1) > threshold));

PSall = [PSall,prefsize(roicut)];
SZRall = [SZRall;szr(roicut)];
Distall = [Distall;ROI_Polar(roicut,2)];
Peakall = [Peakall;peak(roicut,:)];
mDist = zeros(1,5);
for n = 1:5
    mDist(n) = mean(ROI_Polar(prefsize==n,2));
end
MeanDist = [MeanDist;mDist];
id = ones(length(roicut),1)*44;
ID = [ID;id];
%
peak = csvread('SC18_peak.csv');
szr = peak(:,5) - peak(:,1);
prefsize = csvread('SC18_prefsize.csv');
ROI_Polar = csvread('SC18_ROI_Polar.csv');
GFP =[];
SR = [1:53];
OGB = setdiff(1:size(peak,1),SR);

roi = [GFP,OGB];
roicut = intersect(roi,find(peak(:,1) > threshold));

PSall = [PSall,prefsize(roicut)];
SZRall = [SZRall;szr(roicut)];
Distall = [Distall;ROI_Polar(roicut,2)];
Peakall = [Peakall;peak(roicut,:)];
mDist = zeros(1,5);
for n = 1:5
    mDist(n) = mean(ROI_Polar(prefsize==n,2));
end
MeanDist = [MeanDist;mDist];
id = ones(length(roicut),1)*45;
ID = [ID;id];
%
cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/130731WT/depth1-7');
peak = csvread('SC4_peak.csv');
szr = peak(:,5) - peak(:,1);
prefsize = csvread('SC4_prefsize.csv');
ROI_Polar = csvread('SC4_ROI_Polar.csv');
SR = 1:90;
OGB = 91:size(peak,1);

roi = [GFP,OGB];
roicut = intersect(roi,find(peak(:,1) > threshold));

PSall = [PSall,prefsize(roicut)];
SZRall = [SZRall;szr(roicut)];
Distall = [Distall;ROI_Polar(roicut,2)];
Peakall = [Peakall;peak(roicut,:)];
mDist = zeros(1,5);
for n = 1:5
    mDist(n) = mean(ROI_Polar(prefsize==n,2));
end
MeanDist = [MeanDist;mDist];
id = ones(length(roicut),1)*46;
ID = [ID;id];
%
peak = csvread('SC5_peak.csv');
szr = peak(:,5) - peak(:,1);
prefsize = csvread('SC5_prefsize.csv');
ROI_Polar = csvread('SC5_ROI_Polar.csv');
SR = 1:36;
OGB = 37:size(peak,1);

roi = [GFP,OGB];
roicut = intersect(roi,find(peak(:,1) > threshold));

PSall = [PSall,prefsize(roicut)];
SZRall = [SZRall;szr(roicut)];
Distall = [Distall;ROI_Polar(roicut,2)];
Peakall = [Peakall;peak(roicut,:)];
mDist = zeros(1,5);
for n = 1:5
    mDist(n) = mean(ROI_Polar(prefsize==n,2));
end
MeanDist = [MeanDist;mDist];
id = ones(length(roicut),1)*46;%*47;
ID = [ID;id];
%
peak = csvread('SC8_peak.csv');
szr = peak(:,5) - peak(:,1);
prefsize = csvread('SC8_prefsize.csv');
ROI_Polar = csvread('SC8_ROI_Polar.csv');
SR = [1:26,61,74,90,134];
OGB = setdiff(1:size(peak,1),SR);

roi = [GFP,OGB];
roicut = intersect(roi,find(peak(:,1) > threshold));

PSall = [PSall,prefsize(roicut)];
SZRall = [SZRall;szr(roicut)];
Distall = [Distall;ROI_Polar(roicut,2)];
Peakall = [Peakall;peak(roicut,:)];
mDist = zeros(1,5);
for n = 1:5
    mDist(n) = mean(ROI_Polar(prefsize==n,2));
end
MeanDist = [MeanDist;mDist];
id = ones(length(roicut),1)*47;
ID = [ID;id];
%
peak = csvread('SC9_peak.csv');
szr = peak(:,5) - peak(:,1);
prefsize = csvread('SC9_prefsize.csv');
ROI_Polar = csvread('SC9_ROI_Polar.csv');
SR = [1:45,132,146];
OGB = setdiff(1:size(peak,1),SR);

roi = [GFP,OGB];
roicut = intersect(roi,find(peak(:,1) > threshold));

PSall = [PSall,prefsize(roicut)];
SZRall = [SZRall;szr(roicut)];
Distall = [Distall;ROI_Polar(roicut,2)];
Peakall = [Peakall;peak(roicut,:)];
mDist = zeros(1,5);
for n = 1:5
    mDist(n) = mean(ROI_Polar(prefsize==n,2));
end
MeanDist = [MeanDist;mDist];
id = ones(length(roicut),1)*48;
ID = [ID;id];
%
peak = csvread('SC10_peak.csv');
szr = peak(:,5) - peak(:,1);
prefsize = csvread('SC10_prefsize.csv');
ROI_Polar = csvread('SC10_ROI_Polar.csv');
SR = [1:31];
OGB = setdiff(1:size(peak,1),SR);

roi = [GFP,OGB];
roicut = intersect(roi,find(peak(:,1) > threshold));

PSall = [PSall,prefsize(roicut)];
SZRall = [SZRall;szr(roicut)];
Distall = [Distall;ROI_Polar(roicut,2)];
Peakall = [Peakall;peak(roicut,:)];
mDist = zeros(1,5);
for n = 1:5
    mDist(n) = mean(ROI_Polar(prefsize==n,2));
end
MeanDist = [MeanDist;mDist];
id = ones(length(roicut),1)*49;
ID = [ID;id];
%
cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/121221WT/depth1/');
peak = csvread('SC3_peak.csv');
szr = peak(:,5) - peak(:,1);
prefsize = csvread('SC3_prefsize.csv');
ROI_Polar = csvread('SC3_ROI_Polar.csv');
SR = [7,16,18,21,25,37,39,50,51,55,56,71,75,76,81,84,90,95,96,100,102,106,109,110,114,121,129,142,145,148,149,152,158];
GFP = [];
OGB = setdiff(1:size(peak,1),[SR,GFP]);

roi = [GFP,OGB];
roicut = intersect(roi,find(peak(:,1) > threshold));

PSall = [PSall,prefsize(roicut)];
SZRall = [SZRall;szr(roicut)];
Distall = [Distall;ROI_Polar(roicut,2)];
Peakall = [Peakall;peak(roicut,:)];
mDist = zeros(1,5);
for n = 1:5
    mDist(n) = mean(ROI_Polar(prefsize==n,2));
end
MeanDist = [MeanDist;mDist];
id = ones(length(roicut),1)*50;
ID = [ID;id];
%
peak = csvread('SC4_peak.csv');
szr = peak(:,5) - peak(:,1);
prefsize = csvread('SC4_prefsize.csv');
ROI_Polar = csvread('SC4_ROI_Polar.csv');
SR = [7,16,18,21,25,37,39,50,51,55,56,71,75,76,81,84,90,95,96,100,102,106,109,110,114,121,129,142,145,148,149,152,158];
GFP = [];
OGB = setdiff(1:size(peak,1),[SR,GFP]);

roi = [GFP,OGB];
roicut = intersect(roi,find(peak(:,1) > threshold));

PSall = [PSall,prefsize(roicut)];
SZRall = [SZRall;szr(roicut)];
Distall = [Distall;ROI_Polar(roicut,2)];
Peakall = [Peakall;peak(roicut,:)];
mDist = zeros(1,5);
for n = 1:5
    mDist(n) = mean(ROI_Polar(prefsize==n,2));
end
MeanDist = [MeanDist;mDist];
id = ones(length(roicut),1)*51;
ID = [ID;id];
%
peak = csvread('SC5_peak.csv');
szr = peak(:,5) - peak(:,1);
prefsize = csvread('SC5_prefsize.csv');
ROI_Polar = csvread('SC5_ROI_Polar.csv');
SR = [7,16,18,21,25,37,39,50,51,55,56,71,75,76,81,84,90,95,96,100,102,106,109,110,114,121,129,142,145,148,149,152,158];
GFP = [];
OGB = setdiff(1:size(peak,1),[SR,GFP]);

roi = [GFP,OGB];
roicut = intersect(roi,find(peak(:,1) > threshold));

PSall = [PSall,prefsize(roicut)];
SZRall = [SZRall;szr(roicut)];
Distall = [Distall;ROI_Polar(roicut,2)];
Peakall = [Peakall;peak(roicut,:)];
mDist = zeros(1,5);
for n = 1:5
    mDist(n) = mean(ROI_Polar(prefsize==n,2));
end
MeanDist = [MeanDist;mDist];
id = ones(length(roicut),1)*52;
ID = [ID;id];
%
cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/121221WT/depth2/');
peak = csvread('SC17_peak.csv');
szr = peak(:,5) - peak(:,1);
prefsize = csvread('SC17_prefsize.csv');
ROI_Polar = csvread('SC17_ROI_Polar.csv');
SR = [9,12,22,24,27,30,33,40,47,49,67,70,84,86,87,90,93,97,104,107,111,125,131,135,141,144,150,162,164,167,174,175,184,188:190,196];
GFP = [];
OGB = setdiff(1:size(peak,1),[SR,GFP]);

roi = [GFP,OGB];
roicut = intersect(roi,find(peak(:,1) > threshold));

PSall = [PSall,prefsize(roicut)];
SZRall = [SZRall;szr(roicut)];
Distall = [Distall;ROI_Polar(roicut,2)];

Peakall = [Peakall;peak(roicut,:)];
mDist = zeros(1,5);
for n = 1:5
    mDist(n) = mean(ROI_Polar(prefsize==n,2));
end
MeanDist = [MeanDist;mDist];
id = ones(length(roicut),1)*53;
ID = [ID;id];
%
cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/121221WT/depth3/');
peak = csvread('SC29_peak.csv');
szr = peak(:,5) - peak(:,1);
prefsize = csvread('SC29_prefsize.csv');
ROI_Polar = csvread('SC29_ROI_Polar.csv');
SR = [1,4,5,7,15,21,24,36,38,48,56,63,70,73,87,103,108,116,125,127,131,134,145,146,167,172,181,182,188,189];
GFP = [];
OGB = setdiff(1:size(peak,1),[SR,GFP]);

roi = [GFP,OGB];
roicut = intersect(roi,find(peak(:,1) > threshold));

PSall = [PSall,prefsize(roicut)];
SZRall = [SZRall;szr(roicut)];
Distall = [Distall;ROI_Polar(roicut,2)];
Peakall = [Peakall;peak(roicut,:)];
mDist = zeros(1,5);
for n = 1:5
    mDist(n) = mean(ROI_Polar(prefsize==n,2));
end
MeanDist = [MeanDist;mDist];
id = ones(length(roicut),1)*54;
ID = [ID;id];
%
peak = csvread('SC31_peak.csv');
szr = peak(:,5) - peak(:,1);
prefsize = csvread('SC31_prefsize.csv');
ROI_Polar = csvread('SC31_ROI_Polar.csv');
SR = [1,4,5,7,15,21,24,36,38,48,56,63,70,73,87,103,108,116,125,127,131,134,145,146,167,172,181,182,188,189,205];
GFP = [];
OGB = setdiff(1:size(peak,1),[SR,GFP]);

roi = [GFP,OGB];
roicut = intersect(roi,find(peak(:,1) > threshold));

PSall = [PSall,prefsize(roicut)];
SZRall = [SZRall;szr(roicut)];
Distall = [Distall;ROI_Polar(roicut,2)];
Peakall = [Peakall;peak(roicut,:)];
mDist = zeros(1,5);
for n = 1:5
    mDist(n) = mean(ROI_Polar(prefsize==n,2));
end
MeanDist = [MeanDist;mDist];
id = ones(length(roicut),1)*54;%*56;%*55;
ID = [ID;id];
%
cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/121204WT/SC17/');
peak = csvread('SC17_peak.csv');
szr = peak(:,5) - peak(:,1);
prefsize = csvread('SC17_prefsize.csv');
ROI_Polar = csvread('SC17_ROI_Polar.csv');
SR = [1,5:10,17,21,24,36,44,46,62,63,73,105,109,113:115,121];
GFP = [];
OGB = setdiff(1:size(peak,1),[SR,GFP]);

roi = [GFP,OGB];
roicut = intersect(roi,find(peak(:,1) > threshold));

PSall = [PSall,prefsize(roicut)];
SZRall = [SZRall;szr(roicut)];
Distall = [Distall;ROI_Polar(roicut,2)];
Peakall = [Peakall;peak(roicut,:)];
mDist = zeros(1,5);
for n = 1:5
    mDist(n) = mean(ROI_Polar(prefsize==n,2));
end
MeanDist = [MeanDist;mDist];
id = ones(length(roicut),1)*55;
ID = [ID;id];
%
cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/121204WT/SC23/');
peak = csvread('SC23_peak.csv');
szr = peak(:,5) - peak(:,1);
prefsize = csvread('SC23_prefsize.csv');
ROI_Polar = csvread('SC23_ROI_Polar.csv');
SR = [1,5:10,17,21,24,36,44,46,62,63,73,105,109,113:115,121,133];
GFP = [];
OGB = setdiff(1:size(peak,1),[SR,GFP]);

roi = [GFP,OGB];
roicut = intersect(roi,find(peak(:,1) > threshold));

PSall = [PSall,prefsize(roicut)];
SZRall = [SZRall;szr(roicut)];
Distall = [Distall;ROI_Polar(roicut,2)];
Peakall = [Peakall;peak(roicut,:)];
mDist = zeros(1,5);
for n = 1:5
    mDist(n) = mean(ROI_Polar(prefsize==n,2));
end
MeanDist = [MeanDist;mDist];
id = ones(length(roicut),1)*56;
ID = [ID;id];
%%

for n = 1:5
    SZRrateall(:,n) = Peakall(:,n)./Peakall(:,1);
end
%%
MeanPeak = zeros(56*5,8);

for i1 = 1:5%stim
    for i2 = 1:56%ID
        for i3 = 1:5%prefsize
            MeanPeak(i2+56*(i3-1),i1) = nanmean(Peakall(ID==i2 & (PSall' == i3),i1));
            MeanPeak(i2+56*(i3-1),6) = i2;
            MeanPeak(i2+56*(i3-1),7) = i3;
            MeanPeak(i2+56*(i3-1),8) = length(Peakall(ID==i2 & (PSall' == i3),i1));
        end
    end
end

MeanDiff2 = zeros(56,10);
for m = 1:5
    for n = 1:56
        MeanDiff2(n,m) = nanmean(Peakall(ID==n & PSall'==m,2) - Peakall(ID==n & PSall'==m,1));
        MeanDiff2(n,m+5) = nanstd(Peakall(ID==n & PSall'==m,2) - Peakall(ID==n & PSall'==m,1));
    end
end

MeanDiff3 = zeros(56,10);
for m = 1:5
    for n = 1:56
        MeanDiff3(n,m) = mean(Peakall(ID==n & PSall'==m,3) - Peakall(ID==n & PSall'==m,1));
        MeanDiff3(n,m+5) = std(Peakall(ID==n & PSall'==m,3) - Peakall(ID==n & PSall'==m,1));
    end
end

MeanDiff4 = zeros(56,10);
for m = 1:5
    for n = 1:56
        MeanDiff4(n,m) = mean(Peakall(ID==n & PSall'==m,4) - Peakall(ID==n & PSall'==m,1));
        MeanDiff4(n,m+5) = std(Peakall(ID==n & PSall'==m,4) - Peakall(ID==n & PSall'==m,1));
    end
end

MeanDiff5 = zeros(56,10);
for m = 1:5
    for n = 1:56
        MeanDiff5(n,m) = mean(Peakall(ID==n & PSall'==m,5) - Peakall(ID==n & PSall'==m,1));
        MeanDiff5(n,m+5) = std(Peakall(ID==n & PSall'==m,5) - Peakall(ID==n & PSall'==m,1));
    end
end

%% plot
SZRmean1 = mean(SZRall(PSall==1));
SZRstd1 = std(SZRall(PSall==1));
SZRmean2 = mean(SZRall(PSall==2));
SZRstd2 = std(SZRall(PSall==2));
SZRmean3 = mean(SZRall(PSall==3));
SZRstd3 = std(SZRall(PSall==3));
SZRmean4 = mean(SZRall(PSall==4));
SZRstd4 = std(SZRall(PSall==4));
SZRmean5 = mean(SZRall(PSall==5));
SZRstd5 = std(SZRall(PSall==5));
SZRmean = [SZRmean1,SZRmean2,SZRmean3,SZRmean4,SZRmean5];
SZRstd = [SZRstd1,SZRstd2,SZRstd3,SZRstd4,SZRstd5];
%plot(PSall,SZRall,'b.')
scatter(PSall*2, SZRall,'k.','jitter','on', 'jitterAmount',0.5);
hold on
errorbar([1:5]*2+0.2,SZRmean,SZRstd,'r')
%xlim([0,6]);
for n=1:5
    subplot(1,5,n)
    boxplot(SZRall(PSall==n),(PSall(PSall==n)));
    ylim([-0.4,0.4])
end



figure;
Distmean1 = mean(Distall(PSall==1));
Diststd1 = std(Distall(PSall==1));
Distmean2 = mean(Distall(PSall==2));
Diststd2 = std(Distall(PSall==2));
Distmean3 = mean(Distall(PSall==3));
Diststd3 = std(Distall(PSall==3));
Distmean4 = mean(Distall(PSall==4));
Diststd4 = std(Distall(PSall==4));
Distmean5 = mean(Distall(PSall==5));
Diststd5 = std(Distall(PSall==5));
Distmean = [Distmean1,Distmean2,Distmean3,Distmean4,Distmean5];
Diststd = [Diststd1,Diststd2,Diststd3,Diststd4,Diststd5];
%plot(PSall,Distall,'b.')
scatter(PSall*2, Distall,'k.','jitter','on', 'jitterAmount',0.5);
hold on
errorbar([1:5]*2+0.2,Distmean,Diststd,'r')
%xlim([0,6]);

[PSall_sort,PSsort_index]= sort(PSall);
PSallstr = num2str(PSall_sort');
figure;
boxplot(SZRall(PSsort_index),PSallstr)
ylim([-0.4,0.4])
figure;
boxplot(Distall(PSsort_index),PSallstr)



for n =1:5
    figure;
    scatter(PSall, Peakall(:,n)-Peakall(:,1),'b.','jitter','on', 'jitterAmount',0.1);
end

for n = 1:5
    figure;
    hold on
    plot(1, (Peakall(PSall==n,1)-Peakall(PSall==n,1)),'bo')
    plot(2, (Peakall(PSall==n,2)-Peakall(PSall==n,1)),'bo')
    plot(3, (Peakall(PSall==n,3)-Peakall(PSall==n,1)),'bo')
    plot(4, (Peakall(PSall==n,4)-Peakall(PSall==n,1)),'bo')
    plot(5, (Peakall(PSall==n,5)-Peakall(PSall==n,1)),'bo')
    %{
disp(mean(Peakall(PSall==n,1)./Peakall(PSall==n,n)));
disp(mean(Peakall(PSall==n,2)./Peakall(PSall==n,n)));
disp(mean(Peakall(PSall==n,3)./Peakall(PSall==n,n)));
disp(mean(Peakall(PSall==n,4)./Peakall(PSall==n,n)));
disp(mean(Peakall(PSall==n,5)./Peakall(PSall==n,n)));
    %}
    xlim([0,6]);
    hold off
end
col = ['b.';'c.';'g.';'y.';'r.'];
col = cellstr(col);

%{
%gaussian fit 0.5deg stim
beta_r0 = [0.1,0,300];%[Amp0, x0, xsd0, Amp1, xsd1]
lb_r0 = [0,-10,0];
ub_r0 = [1,10,250];

[beta_r01,~, residual] = lsqcurvefit(@Gaussian1D, beta_r0,Distall(Distall<250),Peakall(Distall<250,1), lb_r0, ub_r0);
Rsq = Calc_Rsq(SZRall,residual);
x_plot = 0:450;
Z_fit_r0 = Gaussian1D(beta_r01,x_plot);

figure;
for n = 1:5
plot(Distall(PSall==6-n&(Distall<250)'),Peakall(PSall==6-n&(Distall<250)',1),col{6-n,1});
hold on
end
plot(x_plot, Z_fit_r0, 'k');
ylim([-0.05,0.55])
hold off
%}
%gaussian fit Szr 10deg - 0.5deg
beta_r = [0.1,0,300,0.2,1];%[Amp0, x0, xsd0, Amp1, xsd1]
lb_r = [0,-10,0,0,0.001];
ub_r = [1,10,250,1,10];

[beta_r1,~, residual] = lsqcurvefit(@Gaussian1D, beta_r,Distall(Distall<200),SZRall(Distall<200), lb_r, ub_r);
Rsq = Calc_Rsq(SZRall,residual);

x_plot = -20:500;
Z_fit_r = Gaussian1D(beta_r1,x_plot);


%%
%ƒtƒBƒbƒeƒBƒ“ƒO‚ÌM—Š‹æŠÔ‚Æ—\‘ª‹æŠÔ‚ðƒvƒƒbƒg

beta_r = [0.1, 5 ,230,0.2,0.2];%[Amp0, x0, xsd0, Amp1, xsd1]
%0.1071    2.6439  249.9998    0.1816    0.2451
nlm = NonLinearModel.fit(Distall, SZRall, @Gaussian1D, beta_r);


x = -5:450;

%M—Š‹æŠÔ
[ypred1,ypredci1] = predict(nlm,x','Simultaneous',true);
%—\‘ª‹æŠÔ
[ypred2,ypredci2] = predict(nlm, x', 'Simultaneous',true, 'Prediction', 'observation');
figure;
plot(Distall,SZRall, 'k.');
hold on;
%fit
plot(x, ypred1,'r-');
%95% confidence
plot(x, ypredci1,'r:');
%95% prediction limits
plot(x, ypredci2, 'b:');
xlabel('x'); ylabel('y');
xlim([-5,450]);
ylim([-0.4,0.4]);
%%
figure;
for n = 1:5
    plot(Distall(PSall==6-n),SZRall(PSall==6-n),col{6-n,1});
    hold on
end

%plot(x,Z_fit_r1,'b');
plot(x_plot, Z_fit_r, 'k');
xlim([-5,450]);
%%
% ‹»•±« vs —}§«
%%
% SZR ‚Ì moduration ‚Æ ’†S‚©‚ç‚Ì‹——£ ‚ð Preffered size ‚Å plot
PSex = [];
SZRex = [];
Distex = [];
Peakex =[];
IDex = [];
%
cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/131111GAD/depth5');
peak = csvread('SC17_peak.csv');
szr = peak(:,5) - peak(:,1);
prefsize = csvread('SC17_prefsize.csv');
ROI_Polar = csvread('SC17_ROI_Polar.csv');
SR= [1:30,32:64];
GFP = [31,65:162];
OGB = setdiff(1:size(peak,1),[SR,GFP,[6 87]]);
roi = OGB;
roicut = intersect(roi,find(peak(:,1) > threshold));

PSex = [PSex,prefsize(roicut)];
SZRex = [SZRex;szr(roicut)];
Distex = [Distex;ROI_Polar(roicut,2)];
Peakex = [Peakex;peak(roicut,:)];
id = ones(length(roicut),1)*1;
IDex = [IDex;id];
%
cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/131111GAD/depth6');
peak = csvread('SC19_peak.csv');
szr = peak(:,5) - peak(:,1);
prefsize = csvread('SC19_prefsize.csv');
ROI_Polar = csvread('SC19_ROI_Polar.csv');
SR= [1:83];
GFP = [84:157,161:220,321,322];
OGB = setdiff(1:size(peak,1),[SR,GFP,[67 68 111 120 292]]);
roi = OGB;
roicut = intersect(roi,find(peak(:,1) > threshold));

PSex = [PSex,prefsize(roicut)];
SZRex = [SZRex;szr(roicut)];
Distex = [Distex;ROI_Polar(roicut,2)];
Peakex = [Peakex;peak(roicut,:)];
id = ones(length(roicut),1)*2;
IDex = [IDex;id];
%
cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/131111GAD/depth1');
peak = csvread('SC3_peak.csv');
szr = peak(:,5) - peak(:,1);
prefsize = csvread('SC3_prefsize.csv');
ROI_Polar = csvread('SC3_ROI_Polar.csv');
SR= [1:62];
GFP = [63:162];
OGB = setdiff(1:size(peak,1),[SR,GFP,[38 57 63 65 101 108 131 148 192 201]]);
roi = OGB;
roicut = intersect(roi,find(peak(:,1) > threshold));

PSex = [PSex,prefsize(roicut)];
SZRex = [SZRex;szr(roicut)];
Distex = [Distex;ROI_Polar(roicut,2)];
Peakex = [Peakex;peak(roicut,:)];
id = ones(length(roicut),1)*3;
IDex = [IDex;id];
%
cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/131108GAD/depth5');
peak = csvread('SC9_peak.csv');
szr = peak(:,5) - peak(:,1);
prefsize = csvread('SC9_prefsize.csv');
ROI_Polar = csvread('SC9_ROI_Polar.csv');
SR= [1:48,171];
GFP = [49:109];
%OGB = setdiff(1:size(peak,1),[SR,GFP]);
OGB = setdiff(1:size(peak,1),[GFP,SR]);
roi = OGB;
roicut = intersect(roi,find(peak(:,1) > threshold));

PSex = [PSex,prefsize(roicut)];
SZRex = [SZRex;szr(roicut)];
Distex = [Distex;ROI_Polar(roicut,2)];
Peakex = [Peakex;peak(roicut,:)];
id = ones(length(roicut),1)*4;
IDex = [IDex;id];
%
cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/130208GAD/SC3');
peak = csvread('SC3_peak.csv');
szr = peak(:,5) - peak(:,1);
prefsize = csvread('SC3_prefsize.csv');
ROI_Polar = csvread('SC3_ROI_Polar.csv');
SR = [1:5,7:12,14:20,34:41,43:52,54:60,182];
GFP = [6,30:32,42,61:126,149,151,155,157,168,169,181];
NN = [13,21,148,150,153,154,156,158:163,165,166,170:179];
OGB = setdiff(1:size(peak,1),[SR,GFP,NN]);
roi = OGB;
roicut = intersect(roi,find(peak(:,1) > threshold));

PSex = [PSex,prefsize(roicut)];
SZRex = [SZRex;szr(roicut)];
Distex = [Distex;ROI_Polar(roicut,2)];
Peakex = [Peakex;peak(roicut,:)];
id = ones(length(roicut),1)*5;
IDex = [IDex;id];
%
cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/130208GAD/SC5');
peak = csvread('SC5_peak.csv');
szr = peak(:,5) - peak(:,1);
prefsize = csvread('SC5_prefsize.csv');
ROI_Polar = csvread('SC5_ROI_Polar.csv');
SR = [1:5,7:12,14:20,34:41,43:52,54:60,183,190];
GFP = [6,31:32,42,61:125,149,151,156,157,160,161,168,169,174:176,178,182,191,193,195];
NN = [13,21,30,33,53,148,153:155,158,162,165,167,173,177,179:181,184,186,188,189,192];
OGB = setdiff(1:size(peak,1),[SR,GFP,NN]);
roi = OGB;
roicut = intersect(roi,find(peak(:,1) > threshold));

PSex = [PSex,prefsize(roicut)];
SZRex = [SZRex;szr(roicut)];
Distex = [Distex;ROI_Polar(roicut,2)];
Peakex = [Peakex;peak(roicut,:)];
id = ones(length(roicut),1)*6;
IDex = [IDex;id];
%
cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/130208GAD/SC7');
peak = csvread('SC7_peak.csv');
szr = peak(:,5) - peak(:,1);
prefsize = csvread('SC7_prefsize.csv');
ROI_Polar = csvread('SC7_ROI_Polar.csv');
SR = [1:11,13:16,18:21,23:25,28:47,49,50];
GFP = [17,51:119,138,141,150,151,165:167,170,172,174];
NN = [22,26,27.137,139,140,144,145,147:149,152:155,160:164,168,169,173];
OGB = setdiff(1:size(peak,1),[SR,GFP,NN]);
roi = OGB;
roicut = intersect(roi,find(peak(:,1) > threshold));

PSex = [PSex,prefsize(roicut)];
SZRex = [SZRex;szr(roicut)];
Distex = [Distex;ROI_Polar(roicut,2)];
Peakex = [Peakex;peak(roicut,:)];
id = ones(length(roicut),1)*7;
IDex = [IDex;id];
%
cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/130208GAD/SC21');cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/130208GAD/SC21');
peak = csvread('SC21_peak.csv');
szr = peak(:,5) - peak(:,1);
prefsize = csvread('SC21_prefsize.csv');
ROI_Polar = csvread('SC21_ROI_Polar.csv');
SR = [1:22,24,25,27:29,189];
GFP = [30:117,153,154,156:159,161:163,167,169,172:182,187,188,195:197,200];
NN = [23,26,155,160,164,165,170,171,];
OGB = setdiff(1:size(peak,1),[SR,GFP,NN]);
roi = OGB;
roicut = intersect(roi,find(peak(:,1) > threshold));

PSex = [PSex,prefsize(roicut)];
SZRex = [SZRex;szr(roicut)];
Distex = [Distex;ROI_Polar(roicut,2)];
Peakex = [Peakex;peak(roicut,:)];
id = ones(length(roicut),1)*8;
IDex = [IDex;id];
%
cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/130208GAD/SC23');
peak = csvread('SC23_peak.csv');
szr = peak(:,5) - peak(:,1);
prefsize = csvread('SC23_prefsize.csv');
ROI_Polar = csvread('SC23_ROI_Polar.csv');
SR = [1:22,24,25,27:29,189];
GFP = [30:117,153,154,156:159,161:163,167,169,172:182,187,188,195:197,200];
NN = [23,26,155,160,164,165,170,171,];
OGB = setdiff(1:size(peak,1),[SR,GFP,NN]);
roi = OGB;
roicut = intersect(roi,find(peak(:,1) > threshold));

PSex = [PSex,prefsize(roicut)];
SZRex = [SZRex;szr(roicut)];
Distex = [Distex;ROI_Polar(roicut,2)];
Peakex = [Peakex;peak(roicut,:)];
id = ones(length(roicut),1)*9;
IDex = [IDex;id];
%
cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/130208GAD/SC24');
peak = csvread('SC24_peak.csv');
szr = peak(:,5) - peak(:,1);
prefsize = csvread('SC24_prefsize.csv');
ROI_Polar = csvread('SC24_ROI_Polar.csv');
SR = [1:22,24,25,27:29,189];
GFP = [30:117,153,154,156:159,161:163,167,169,172:182,187,188,195:197,200];
NN = [23,26,155,160,164,165,170,171,];
OGB = setdiff(1:size(peak,1),[SR,GFP,NN]);
roi = OGB;
roicut = intersect(roi,find(peak(:,1) > threshold));

PSex = [PSex,prefsize(roicut)];
SZRex = [SZRex;szr(roicut)];
Distex = [Distex;ROI_Polar(roicut,2)];
Peakex = [Peakex;peak(roicut,:)];
id = ones(length(roicut),1)*10;
IDex = [IDex;id];
%
cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/130208GAD/SC26');
peak = csvread('SC26_peak.csv');
szr = peak(:,5) - peak(:,1);
prefsize = csvread('SC26_prefsize.csv');
ROI_Polar = csvread('SC26_ROI_Polar.csv');
SR = [1:58,206,256];
GFP = [59:150,194,195,197,198,202:205,209,211,213:215,218,219,221,230,234,243,244,249,252,253,257:260];
NN = [186,187,193,196,199,200,225:228,231,232,237,242,247,248,250,251,255];
OGB = setdiff(1:size(peak,1),[SR,GFP,NN]);
roi = OGB;
roicut = intersect(roi,find(peak(:,1) > threshold));

PSex = [PSex,prefsize(roicut)];
SZRex = [SZRex;szr(roicut)];
Distex = [Distex;ROI_Polar(roicut,2)];
Peakex = [Peakex;peak(roicut,:)];
id = ones(length(roicut),1)*11;
IDex = [IDex;id];
%
cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/130208GAD/SC28');
peak = csvread('SC28_peak.csv');
szr = peak(:,5) - peak(:,1);
prefsize = csvread('SC28_prefsize.csv');
ROI_Polar = csvread('SC28_ROI_Polar.csv');
SR = [1:32];
GFP = [33:108,113,115,126,128,131,138,141,143:145,150,152,154,156,159,163,164,167,168,170];
NN = [117,149,161,169];
OGB = setdiff(1:size(peak,1),[SR,GFP,NN]);
roi = OGB;
roicut = intersect(roi,find(peak(:,1) > threshold));

PSex = [PSex,prefsize(roicut)];
SZRex = [SZRex;szr(roicut)];
Distex = [Distex;ROI_Polar(roicut,2)];
Peakex = [Peakex;peak(roicut,:)];
id = ones(length(roicut),1)*12;
IDex = [IDex;id];
%
cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/130208GAD/SC29');
peak = csvread('SC29_peak.csv');
szr = peak(:,5) - peak(:,1);
prefsize = csvread('SC29_prefsize.csv');
ROI_Polar = csvread('SC29_ROI_Polar.csv');
SR = [12,21,22,29,30,44,51,57,64,76,84,86,90,91];
GFP = [5,6,8,10,11,13,14,16,23,25:28,32,34:37,39:42,47,48,50,52,55,56,58,62,63,65,67,68,71:73,75,78,80,81,88,89,93:97,99,101];
NN = [38,45,59];
OGB = setdiff(1:size(peak,1),[SR,GFP,NN]);
roi = OGB;
roicut = intersect(roi,find(peak(:,1) > threshold));

PSex = [PSex,prefsize(roicut)];
SZRex = [SZRex;szr(roicut)];
Distex = [Distex;ROI_Polar(roicut,2)];
Peakex = [Peakex;peak(roicut,:)];
id = ones(length(roicut),1)*13;
IDex = [IDex;id];
%
cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/130206GAD/SC10');
peak = csvread('SC10_peak.csv');
szr = peak(:,5) - peak(:,1);
prefsize = csvread('SC10_prefsize.csv');
ROI_Polar = csvread('SC10_ROI_Polar.csv');
SR = [1:11,13:30,32:37,40:44,121,152];
GFP = [12,31,38,45:107,119,132,134,143,146];
NN = [39,126];
OGB = setdiff(1:size(peak,1),[SR,GFP,NN]);
roi = OGB;
roicut = intersect(roi,find(peak(:,1) > threshold));

PSex = [PSex,prefsize(roicut)];
SZRex = [SZRex;szr(roicut)];
Distex = [Distex;ROI_Polar(roicut,2)];
Peakex = [Peakex;peak(roicut,:)];
id = ones(length(roicut),1)*14;
IDex = [IDex;id];
%
cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/130206GAD/SC11');
peak = csvread('SC11_peak.csv');
szr = peak(:,5) - peak(:,1);
prefsize = csvread('SC11_prefsize.csv');
ROI_Polar = csvread('SC11_ROI_Polar.csv');
SR = [1:11,13:30,32:37,40:44,121,152];
GFP = [12,31,38,45:107,119,132,134,143,146,166];
NN = [39,126];
OGB = setdiff(1:size(peak,1),[SR,GFP,NN]);
roi = OGB;
roicut = intersect(roi,find(peak(:,1) > threshold));

PSex = [PSex,prefsize(roicut)];
SZRex = [SZRex;szr(roicut)];
Distex = [Distex;ROI_Polar(roicut,2)];
Peakex = [Peakex;peak(roicut,:)];
id = ones(length(roicut),1)*15;
IDex = [IDex;id];
%
cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/130206GAD/SC27');
peak = csvread('SC27_peak.csv');
szr = peak(:,5) - peak(:,1);
prefsize = csvread('SC27_prefsize.csv');
ROI_Polar = csvread('SC27_ROI_Polar.csv');
SR = [1:46];
GFP = [47:108,115:119,123,128,131,132,135,138,140,141,147,149,151];
NN = [];
OGB = setdiff(1:size(peak,1),[SR,GFP,NN]);
roi = OGB;
roicut = intersect(roi,find(peak(:,1) > threshold));

PSex = [PSex,prefsize(roicut)];
SZRex = [SZRex;szr(roicut)];
Distex = [Distex;ROI_Polar(roicut,2)];
Peakex = [Peakex;peak(roicut,:)];
id = ones(length(roicut),1)*16;
IDex = [IDex;id];
%
cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/130206GAD/SC28');
peak = csvread('SC28_peak.csv');
szr = peak(:,5) - peak(:,1);
prefsize = csvread('SC28_prefsize.csv');
ROI_Polar = csvread('SC28_ROI_Polar.csv');
SR = [1:46];
GFP = [47:108,115:119,123,128,131,132,135,138,140,141,147,149,151];
NN = [];
OGB = setdiff(1:size(peak,1),[SR,GFP,NN]);

roi = OGB;
roicut = intersect(roi,find(peak(:,1) > threshold));

PSex = [PSex,prefsize(roicut)];
SZRex = [SZRex;szr(roicut)];
Distex = [Distex;ROI_Polar(roicut,2)];
Peakex = [Peakex;peak(roicut,:)];
id = ones(length(roicut),1)*17;
IDex = [IDex;id];
%
cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/130206GAD/SC30');
peak = csvread('SC30_peak.csv');
szr = peak(:,5) - peak(:,1);
prefsize = csvread('SC30_prefsize.csv');
ROI_Polar = csvread('SC30_ROI_Polar.csv');
SR = [1:46];
GFP = [47:107,113,116,126:131,136,144,148,151,153:155];
NN = [];
OGB = setdiff(1:size(peak,1),[SR,GFP,NN]);

roi = OGB;
roicut = intersect(roi,find(peak(:,1) > threshold));

PSex = [PSex,prefsize(roicut)];
SZRex = [SZRex;szr(roicut)];
Distex = [Distex;ROI_Polar(roicut,2)];
Peakex = [Peakex;peak(roicut,:)];
id = ones(length(roicut),1)*18;
IDex = [IDex;id];
%
cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/130206GAD/SC31');
peak = csvread('SC31_peak.csv');
szr = peak(:,5) - peak(:,1);
prefsize = csvread('SC31_prefsize.csv');
ROI_Polar = csvread('SC31_ROI_Polar.csv');
SR = [1:46];
GFP = [47:107,113,116,126:131,136,144,148,151,153:155,158];
NN = [];
OGB = setdiff(1:size(peak,1),[SR,GFP,NN]);

roi = OGB;
roicut = intersect(roi,find(peak(:,1) > threshold));

PSex = [PSex,prefsize(roicut)];
SZRex = [SZRex;szr(roicut)];
Distex = [Distex;ROI_Polar(roicut,2)];
Peakex = [Peakex;peak(roicut,:)];
id = ones(length(roicut),1)*19;
IDex = [IDex;id];
%%
for n = 1:5
    SZRrateex(:,n) = Peakex(:,n)./Peakex(:,1);
end
%%
MeanPeakex = zeros(19*5,8);

for i1 = 1:5%stim
    for i2 = 1:19%IDex
        for i3 = 1:5%prefsize
            MeanPeakex(i2+19*(i3-1),i1) = nanmean(Peakex(IDex==i2 & (PSex' == i3),i1));
            MeanPeakex(i2+19*(i3-1),6) = i2;
            MeanPeakex(i2+19*(i3-1),7) = i3;
            MeanPeakex(i2+19*(i3-1),8) = length(Peakex(IDex==i2 & (PSex' == i3),i1));
        end
    end
end


%% plot
figure;
SZRmean1 = mean(SZRex(PSex==1));
SZRstd1 = std(SZRex(PSex==1));
SZRmean2 = mean(SZRex(PSex==2));
SZRstd2 = std(SZRex(PSex==2));
SZRmean3 = mean(SZRex(PSex==3));
SZRstd3 = std(SZRex(PSex==3));
SZRmean4 = mean(SZRex(PSex==4));
SZRstd4 = std(SZRex(PSex==4));
SZRmean5 = mean(SZRex(PSex==5));
SZRstd5 = std(SZRex(PSex==5));
SZRmean = [SZRmean1,SZRmean2,SZRmean3,SZRmean4,SZRmean5];
SZRstd = [SZRstd1,SZRstd2,SZRstd3,SZRstd4,SZRstd5];
%plot(PSex,SZRex,'b.')
scatter(PSex, SZRex,'k.','jitter','on', 'jitterAmount',0.1);
hold on
errorbar([1:5],SZRmean,SZRstd,'r')
%xlim([0,6]);

figure;
Distmean1 = mean(Distex(PSex==1));
Diststd1 = std(Distex(PSex==1));
Distmean2 = mean(Distex(PSex==2));
Diststd2 = std(Distex(PSex==2));
Distmean3 = mean(Distex(PSex==3));
Diststd3 = std(Distex(PSex==3));
Distmean4 = mean(Distex(PSex==4));
Diststd4 = std(Distex(PSex==4));
Distmean5 = mean(Distex(PSex==5));
Diststd5 = std(Distex(PSex==5));
Distmean = [Distmean1,Distmean2,Distmean3,Distmean4,Distmean5];
Diststd = [Diststd1,Diststd2,Diststd3,Diststd4,Diststd5];
%plot(PSex,Distex,'b.')
scatter(PSex, Distex,'k.','jitter','on', 'jitterAmount',0.1);
hold on
errorbar([1:5],Distmean,Diststd,'r')
%xlim([0,6]);



[PSex_sort,PSsort_index]= sort(PSex);
PSexstr = num2str(PSex_sort');
figure;
boxplot(SZRex(PSsort_index),PSexstr)
ylim([-0.3,0.4])
figure;
boxplot(Distex(PSsort_index),PSexstr)



%gaussian fit Szr 10deg - 0.5deg
beta_r = [0.1,0,300,0.2,1];%[Amp0, x0, xsd0, Amp1, xsd1]
lb_r = [0,-10,0,0,0.001];
ub_r = [1,10,250,1,10];

[beta_r1_ex,~, residual] = lsqcurvefit(@Gaussian1D, beta_r,Distex,SZRex, lb_r, ub_r);
Rsq = Calc_Rsq(SZRex,residual);

x_plot = -20:350;
Z_fit_ex = Gaussian1D(beta_r1_ex,x_plot);

figure;
for n = 1:5
    plot(Distex(PSex==6-n),SZRex(PSex==6-n),col{6-n,1});
    hold on
end
plot(x_plot, Z_fit_ex, 'k');

for n =1:5
    figure;
    scatter(PSex, Peakex(:,n)-Peakex(:,1),'b.','jitter','on', 'jitterAmount',0.1);
end

for n = 1:5
    figure;
    hold on
    plot(1, (Peakex(PSex==n,1)-Peakex(PSex==n,1)),'bo')
    plot(2, (Peakex(PSex==n,2)-Peakex(PSex==n,1)),'bo')
    plot(3, (Peakex(PSex==n,3)-Peakex(PSex==n,1)),'bo')
    plot(4, (Peakex(PSex==n,4)-Peakex(PSex==n,1)),'bo')
    plot(5, (Peakex(PSex==n,5)-Peakex(PSex==n,1)),'bo')
    %{
disp(mean(Peakex(PSex==n,1)./Peakex(PSex==n,n)));
disp(mean(Peakex(PSex==n,2)./Peakex(PSex==n,n)));
disp(mean(Peakex(PSex==n,3)./Peakex(PSex==n,n)));
disp(mean(Peakex(PSex==n,4)./Peakex(PSex==n,n)));
disp(mean(Peakex(PSex==n,5)./Peakex(PSex==n,n)));
    %}
    xlim([0,6]);
    hold off
end

for n = 1:5
    for m =1:5
        Peakexmean(m,n) = mean(Peakex(PSex==n,m) - Peakex(PSex==n,1));
        Peakexstd(m,n) = std(Peakex(PSex==n,m) - Peakex(PSex==n,1));
        %Peakexmean(m,n) = mean(Peakex(PSex==n,m)./Peakex(PSex==n,1));
        %Peakexstd(m,n) = std(Peakex(PSex==n,m)./Peakex(PSex==n,1));
    end
end
figure;
for n = 1:5
    subplot(1,5,n)
    errorbar([1:5],Peakexmean(:,n),Peakexstd(:,n));
    %ylim([0,3])
end







%%
% SZR ‚Ì moduration ‚Æ ’†S‚©‚ç‚Ì‹——£ ‚ð Preffered size ‚Å plot
PSin = [];
SZRin = [];
Distin = [];
Peakin = [];
IDin =[];
%
cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/131111GAD/depth5');
peak = csvread('SC17_peak.csv');
szr = peak(:,5) - peak(:,1);
prefsize = csvread('SC17_prefsize.csv');
ROI_Polar = csvread('SC17_ROI_Polar.csv');
SR= [1:30,32:64];
GFP = [31,65:162];
OGB = setdiff(1:size(peak,1),[SR,GFP,[6 87]]);
roi = GFP;
roicut = intersect(roi,find(peak(:,1) > threshold));

PSin = [PSin,prefsize(roicut)];
SZRin = [SZRin;szr(roicut)];
Distin = [Distin;ROI_Polar(roicut,2)];
Peakin = [Peakin;peak(roicut,:)];
id = ones(length(roicut),1)*1;
IDin = [IDin;id];
%
cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/131111GAD/depth6');
peak = csvread('SC19_peak.csv');
szr = peak(:,5) - peak(:,1);
prefsize = csvread('SC19_prefsize.csv');
ROI_Polar = csvread('SC19_ROI_Polar.csv');
SR= [1:83];
GFP = [84:157,161:220,321,322];
OGB = setdiff(1:size(peak,1),[SR,GFP,[67 68 111 120 292]]);
roi = GFP;
roicut = intersect(roi,find(peak(:,1) > threshold));

PSin = [PSin,prefsize(roicut)];
SZRin = [SZRin;szr(roicut)];
Distin = [Distin;ROI_Polar(roicut,2)];
Peakin = [Peakin;peak(roicut,:)];
id = ones(length(roicut),1)*2;
IDin = [IDin;id];
%
cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/131111GAD/depth1');
peak = csvread('SC3_peak.csv');
szr = peak(:,5) - peak(:,1);
prefsize = csvread('SC3_prefsize.csv');
ROI_Polar = csvread('SC3_ROI_Polar.csv');
SR= [1:62];
GFP = [63:162];
OGB = setdiff(1:size(peak,1),[SR,GFP,[38 57 63 65 101 108 131 148 192 201]]);
roi = GFP;
roicut = intersect(roi,find(peak(:,1) > threshold));

PSin = [PSin,prefsize(roicut)];
SZRin = [SZRin;szr(roicut)];
Distin = [Distin;ROI_Polar(roicut,2)];
Peakin = [Peakin;peak(roicut,:)];
id = ones(length(roicut),1)*3;
IDin = [IDin;id];
%
cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/131108GAD/depth5');
peak = csvread('SC9_peak.csv');
szr = peak(:,5) - peak(:,1);
prefsize = csvread('SC9_prefsize.csv');
ROI_Polar = csvread('SC9_ROI_Polar.csv');
SR= [1:48,171];
GFP = [49:109];
%OGB = setdiff(1:size(peak,1),[SR,GFP]);
OGB = setdiff(1:size(peak,1),[GFP,SR]);
roi = GFP;
roicut = intersect(roi,find(peak(:,1) > threshold));

PSin = [PSin,prefsize(roicut)];
SZRin = [SZRin;szr(roicut)];
Distin = [Distin;ROI_Polar(roicut,2)];
Peakin = [Peakin;peak(roicut,:)];
id = ones(length(roicut),1)*4;
IDin = [IDin;id];
%
cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/130208GAD/SC3');
peak = csvread('SC3_peak.csv');
szr = peak(:,5) - peak(:,1);
prefsize = csvread('SC3_prefsize.csv');
ROI_Polar = csvread('SC3_ROI_Polar.csv');
SR = [1:5,7:12,14:20,34:41,43:52,54:60,182];
GFP = [6,30:32,42,61:126,149,151,155,157,168,169,181];
NN = [13,21,148,150,153,154,156,158:163,165,166,170:179];
OGB = setdiff(1:size(peak,1),[SR,GFP,NN]);
roi = GFP;
roicut = intersect(roi,find(peak(:,1) > threshold));

PSin = [PSin,prefsize(roicut)];
SZRin = [SZRin;szr(roicut)];
Distin = [Distin;ROI_Polar(roicut,2)];
Peakin = [Peakin;peak(roicut,:)];
id = ones(length(roicut),1)*5;
IDin = [IDin;id];
%
cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/130208GAD/SC5');
peak = csvread('SC5_peak.csv');
szr = peak(:,5) - peak(:,1);
prefsize = csvread('SC5_prefsize.csv');
ROI_Polar = csvread('SC5_ROI_Polar.csv');
SR = [1:5,7:12,14:20,34:41,43:52,54:60,183,190];
GFP = [6,31:32,42,61:125,149,151,156,157,160,161,168,169,174:176,178,182,191,193,195];
NN = [13,21,30,33,53,148,153:155,158,162,165,167,173,177,179:181,184,186,188,189,192];
OGB = setdiff(1:size(peak,1),[SR,GFP,NN]);
roi = GFP;
roicut = intersect(roi,find(peak(:,1) > threshold));

PSin = [PSin,prefsize(roicut)];
SZRin = [SZRin;szr(roicut)];
Distin = [Distin;ROI_Polar(roicut,2)];
Peakin = [Peakin;peak(roicut,:)];
id = ones(length(roicut),1)*6;
IDin = [IDin;id];
%
cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/130208GAD/SC7');
peak = csvread('SC7_peak.csv');
szr = peak(:,5) - peak(:,1);
prefsize = csvread('SC7_prefsize.csv');
ROI_Polar = csvread('SC7_ROI_Polar.csv');
SR = [1:11,13:16,18:21,23:25,28:47,49,50];
GFP = [17,51:119,138,141,150,151,165:167,170,172,174];
NN = [22,26,27.137,139,140,144,145,147:149,152:155,160:164,168,169,173];
OGB = setdiff(1:size(peak,1),[SR,GFP,NN]);
roi = GFP;
roicut = intersect(roi,find(peak(:,1) > threshold));

PSin = [PSin,prefsize(roicut)];
SZRin = [SZRin;szr(roicut)];
Distin = [Distin;ROI_Polar(roicut,2)];
Peakin = [Peakin;peak(roicut,:)];
id = ones(length(roicut),1)*7;
IDin = [IDin;id];
%
cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/130208GAD/SC21');cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/130208GAD/SC21');
peak = csvread('SC21_peak.csv');
szr = peak(:,5) - peak(:,1);
prefsize = csvread('SC21_prefsize.csv');
ROI_Polar = csvread('SC21_ROI_Polar.csv');
SR = [1:22,24,25,27:29,189];
GFP = [30:117,153,154,156:159,161:163,167,169,172:182,187,188,195:197,200];
NN = [23,26,155,160,164,165,170,171,];
OGB = setdiff(1:size(peak,1),[SR,GFP,NN]);
roi = GFP;
roicut = intersect(roi,find(peak(:,1) > threshold));

PSin = [PSin,prefsize(roicut)];
SZRin = [SZRin;szr(roicut)];
Distin = [Distin;ROI_Polar(roicut,2)];
Peakin = [Peakin;peak(roicut,:)];
id = ones(length(roicut),1)*8;
IDin = [IDin;id];
%
cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/130208GAD/SC23');
peak = csvread('SC23_peak.csv');
szr = peak(:,5) - peak(:,1);
prefsize = csvread('SC23_prefsize.csv');
ROI_Polar = csvread('SC23_ROI_Polar.csv');
SR = [1:22,24,25,27:29,189];
GFP = [30:117,153,154,156:159,161:163,167,169,172:182,187,188,195:197,200];
NN = [23,26,155,160,164,165,170,171,];
OGB = setdiff(1:size(peak,1),[SR,GFP,NN]);
roi = GFP;
roicut = intersect(roi,find(peak(:,1) > threshold));

PSin = [PSin,prefsize(roicut)];
SZRin = [SZRin;szr(roicut)];
Distin = [Distin;ROI_Polar(roicut,2)];
Peakin = [Peakin;peak(roicut,:)];
id = ones(length(roicut),1)*9;
IDin = [IDin;id];
%
cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/130208GAD/SC24');
peak = csvread('SC24_peak.csv');
szr = peak(:,5) - peak(:,1);
prefsize = csvread('SC24_prefsize.csv');
ROI_Polar = csvread('SC24_ROI_Polar.csv');
SR = [1:22,24,25,27:29,189];
GFP = [30:117,153,154,156:159,161:163,167,169,172:182,187,188,195:197,200];
NN = [23,26,155,160,164,165,170,171,];
OGB = setdiff(1:size(peak,1),[SR,GFP,NN]);
roi = GFP;
roicut = intersect(roi,find(peak(:,1) > threshold));

PSin = [PSin,prefsize(roicut)];
SZRin = [SZRin;szr(roicut)];
Distin = [Distin;ROI_Polar(roicut,2)];
Peakin = [Peakin;peak(roicut,:)];
id = ones(length(roicut),1)*10;
IDin = [IDin;id];
%
cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/130208GAD/SC26');
peak = csvread('SC26_peak.csv');
szr = peak(:,5) - peak(:,1);
prefsize = csvread('SC26_prefsize.csv');
ROI_Polar = csvread('SC26_ROI_Polar.csv');
SR = [1:58,206,256];
GFP = [59:150,194,195,197,198,202:205,209,211,213:215,218,219,221,230,234,243,244,249,252,253,257:260];
NN = [186,187,193,196,199,200,225:228,231,232,237,242,247,248,250,251,255];
OGB = setdiff(1:size(peak,1),[SR,GFP,NN]);
roi = GFP;
roicut = intersect(roi,find(peak(:,1) > threshold));

PSin = [PSin,prefsize(roicut)];
SZRin = [SZRin;szr(roicut)];
Distin = [Distin;ROI_Polar(roicut,2)];
Peakin = [Peakin;peak(roicut,:)];
id = ones(length(roicut),1)*11;
IDin = [IDin;id];
%
cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/130208GAD/SC28');
peak = csvread('SC28_peak.csv');
szr = peak(:,5) - peak(:,1);
prefsize = csvread('SC28_prefsize.csv');
ROI_Polar = csvread('SC28_ROI_Polar.csv');
SR = [1:32];
GFP = [33:108,113,115,126,128,131,138,141,143:145,150,152,154,156,159,163,164,167,168,170];
NN = [117,149,161,169];
OGB = setdiff(1:size(peak,1),[SR,GFP,NN]);
roi = GFP;
roicut = intersect(roi,find(peak(:,1) > threshold));

PSin = [PSin,prefsize(roicut)];
SZRin = [SZRin;szr(roicut)];
Distin = [Distin;ROI_Polar(roicut,2)];
Peakin = [Peakin;peak(roicut,:)];
id = ones(length(roicut),1)*12;
IDin = [IDin;id];
%
cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/130208GAD/SC29');
peak = csvread('SC29_peak.csv');
szr = peak(:,5) - peak(:,1);
prefsize = csvread('SC29_prefsize.csv');
ROI_Polar = csvread('SC29_ROI_Polar.csv');
SR = [12,21,22,29,30,44,51,57,64,76,84,86,90,91];
GFP = [5,6,8,10,11,13,14,16,23,25:28,32,34:37,39:42,47,48,50,52,55,56,58,62,63,65,67,68,71:73,75,78,80,81,88,89,93:97,99,101];
NN = [38,45,59];
OGB = setdiff(1:size(peak,1),[SR,GFP,NN]);
roi = GFP;
roicut = intersect(roi,find(peak(:,1) > threshold));

PSin = [PSin,prefsize(roicut)];
SZRin = [SZRin;szr(roicut)];
Distin = [Distin;ROI_Polar(roicut,2)];
Peakin = [Peakin;peak(roicut,:)];
id = ones(length(roicut),1)*13;
IDin = [IDin;id];
%
cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/130206GAD/SC10');
peak = csvread('SC10_peak.csv');
szr = peak(:,5) - peak(:,1);
prefsize = csvread('SC10_prefsize.csv');
ROI_Polar = csvread('SC10_ROI_Polar.csv');
SR = [1:11,13:30,32:37,40:44,121,152];
GFP = [12,31,38,45:107,119,132,134,143,146];
NN = [39,126];
OGB = setdiff(1:size(peak,1),[SR,GFP,NN]);
roi = GFP;
roicut = intersect(roi,find(peak(:,1) > threshold));

PSin = [PSin,prefsize(roicut)];
SZRin = [SZRin;szr(roicut)];
Distin = [Distin;ROI_Polar(roicut,2)];
Peakin = [Peakin;peak(roicut,:)];
id = ones(length(roicut),1)*14;
IDin = [IDin;id];
%
cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/130206GAD/SC11');
peak = csvread('SC11_peak.csv');
szr = peak(:,5) - peak(:,1);
prefsize = csvread('SC11_prefsize.csv');
ROI_Polar = csvread('SC11_ROI_Polar.csv');
SR = [1:11,13:30,32:37,40:44,121,152];
GFP = [12,31,38,45:107,119,132,134,143,146,166];
NN = [39,126];
OGB = setdiff(1:size(peak,1),[SR,GFP,NN]);
roi = GFP;
roicut = intersect(roi,find(peak(:,1) > threshold));

PSin = [PSin,prefsize(roicut)];
SZRin = [SZRin;szr(roicut)];
Distin = [Distin;ROI_Polar(roicut,2)];
Peakin = [Peakin;peak(roicut,:)];
id = ones(length(roicut),1)*15;
IDin = [IDin;id];
%
cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/130206GAD/SC27');
peak = csvread('SC27_peak.csv');
szr = peak(:,5) - peak(:,1);
prefsize = csvread('SC27_prefsize.csv');
ROI_Polar = csvread('SC27_ROI_Polar.csv');
SR = [1:46];
GFP = [47:108,115:119,123,128,131,132,135,138,140,141,147,149,151];
NN = [];
OGB = setdiff(1:size(peak,1),[SR,GFP,NN]);
roi = GFP;
roicut = intersect(roi,find(peak(:,1) > threshold));

PSin = [PSin,prefsize(roicut)];
SZRin = [SZRin;szr(roicut)];
Distin = [Distin;ROI_Polar(roicut,2)];
Peakin = [Peakin;peak(roicut,:)];
id = ones(length(roicut),1)*16;
IDin = [IDin;id];
%
cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/130206GAD/SC28');
peak = csvread('SC28_peak.csv');
szr = peak(:,5) - peak(:,1);
prefsize = csvread('SC28_prefsize.csv');
ROI_Polar = csvread('SC28_ROI_Polar.csv');
SR = [1:46];
GFP = [47:108,115:119,123,128,131,132,135,138,140,141,147,149,151];
NN = [];
OGB = setdiff(1:size(peak,1),[SR,GFP,NN]);

roi = GFP;
roicut = intersect(roi,find(peak(:,1) > threshold));

PSin = [PSin,prefsize(roicut)];
SZRin = [SZRin;szr(roicut)];
Distin = [Distin;ROI_Polar(roicut,2)];
Peakin = [Peakin;peak(roicut,:)];
id = ones(length(roicut),1)*17;
IDin = [IDin;id];
%
cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/130206GAD/SC30');
peak = csvread('SC30_peak.csv');
szr = peak(:,5) - peak(:,1);
prefsize = csvread('SC30_prefsize.csv');
ROI_Polar = csvread('SC30_ROI_Polar.csv');
SR = [1:46];
GFP = [47:107,113,116,126:131,136,144,148,151,153:155];
NN = [];
OGB = setdiff(1:size(peak,1),[SR,GFP,NN]);

roi = GFP;
roicut = intersect(roi,find(peak(:,1) > threshold));

PSin = [PSin,prefsize(roicut)];
SZRin = [SZRin;szr(roicut)];
Distin = [Distin;ROI_Polar(roicut,2)];
Peakin = [Peakin;peak(roicut,:)];
id = ones(length(roicut),1)*18;
IDin = [IDin;id];
%
cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/130206GAD/SC31');
peak = csvread('SC31_peak.csv');
szr = peak(:,5) - peak(:,1);
prefsize = csvread('SC31_prefsize.csv');
ROI_Polar = csvread('SC31_ROI_Polar.csv');
SR = [1:46];
GFP = [47:107,113,116,126:131,136,144,148,151,153:155,158];
NN = [];
OGB = setdiff(1:size(peak,1),[SR,GFP,NN]);

roi = GFP;
roicut = intersect(roi,find(peak(:,1) > threshold));

PSin = [PSin,prefsize(roicut)];
SZRin = [SZRin;szr(roicut)];
Distin = [Distin;ROI_Polar(roicut,2)];
Peakin = [Peakin;peak(roicut,:)];
id = ones(length(roicut),1)*19;
IDin = [IDin;id];
%%
for n = 1:5
    SZRratein(:,n) = Peakin(:,n)./Peakin(:,1);
end
%%
MeanPeakin = zeros(19*5,8);

for i1 = 1:5%stim
    for i2 = 1:19%IDex
        for i3 = 1:5%prefsize
            MeanPeakin(i2+19*(i3-1),i1) = nanmean(Peakin(IDin==i2 & (PSin' == i3),i1));
            MeanPeakin(i2+19*(i3-1),6) = i2;
            MeanPeakin(i2+19*(i3-1),7) = i3;
            MeanPeakin(i2+19*(i3-1),8) = length(Peakin(IDin==i2 & (PSin' == i3),i1));
        end
    end
end

%% plot
figure;
SZRmean1 = mean(SZRin(PSin==1));
SZRstd1 = std(SZRin(PSin==1));
SZRmean2 = mean(SZRin(PSin==2));
SZRstd2 = std(SZRin(PSin==2));
SZRmean3 = mean(SZRin(PSin==3));
SZRstd3 = std(SZRin(PSin==3));
SZRmean4 = mean(SZRin(PSin==4));
SZRstd4 = std(SZRin(PSin==4));
SZRmean5 = mean(SZRin(PSin==5));
SZRstd5 = std(SZRin(PSin==5));
SZRmean = [SZRmean1,SZRmean2,SZRmean3,SZRmean4,SZRmean5];
SZRstd = [SZRstd1,SZRstd2,SZRstd3,SZRstd4,SZRstd5];
%plot(PSin,SZRin,'b.')
scatter(PSin, SZRin,'k.','jitter','on', 'jitterAmount',0.1);
hold on
errorbar([1:5],SZRmean,SZRstd,'r')
%xlim([0,6]);

figure;
Distmean1 = mean(Distin(PSin==1));
Diststd1 = std(Distin(PSin==1));
Distmean2 = mean(Distin(PSin==2));
Diststd2 = std(Distin(PSin==2));
Distmean3 = mean(Distin(PSin==3));
Diststd3 = std(Distin(PSin==3));
Distmean4 = mean(Distin(PSin==4));
Diststd4 = std(Distin(PSin==4));
Distmean5 = mean(Distin(PSin==5));
Diststd5 = std(Distin(PSin==5));
Distmean = [Distmean1,Distmean2,Distmean3,Distmean4,Distmean5];
Diststd = [Diststd1,Diststd2,Diststd3,Diststd4,Diststd5];
%plot(PSin,Distin,'b.')
scatter(PSin, Distin,'k.','jitter','on', 'jitterAmount',0.1);
hold on
errorbar([1:5],Distmean,Diststd,'r')
%xlim([0,6]);


[PSin_sort,PSsort_index]= sort(PSin);
PSinstr = num2str(PSin_sort');
figure;
boxplot(SZRin(PSsort_index),PSinstr)
ylim([-0.3,0.4])
figure;
boxplot(Distin(PSsort_index),PSinstr)

%gaussian fit Szr 10deg - 0.5deg
beta_r = [0.1,0,300,0.2,1];%[Amp0, x0, xsd0, Amp1, xsd1]
lb_r = [0,-10,0,0,0.001];
ub_r = [1,10,250,1,10];

[beta_r1_in,~, residual] = lsqcurvefit(@Gaussian1D, beta_r,Distin,SZRin, lb_r, ub_r);
Rsq = Calc_Rsq(SZRin,residual);

x_plot = 0:450;
Z_fit_in = Gaussian1D(beta_r1_in,x_plot);

figure;
for n = 1:5
    plot(Distin(PSin==6-n),SZRin(PSin==6-n),col{6-n,1});
    hold on
end
plot(x_plot, Z_fit_in, 'k');





for n =1:5
    figure;
    scatter(PSin, Peakin(:,n)-Peakin(:,1),'b.','jitter','on', 'jitterAmount',0.1);
end

for n = 1:5
    figure;
    hold on
    plot(1, (Peakin(PSin==n,1)-Peakin(PSin==n,1)),'bo')
    plot(2, (Peakin(PSin==n,2)-Peakin(PSin==n,1)),'bo')
    plot(3, (Peakin(PSin==n,3)-Peakin(PSin==n,1)),'bo')
    plot(4, (Peakin(PSin==n,4)-Peakin(PSin==n,1)),'bo')
    plot(5, (Peakin(PSin==n,5)-Peakin(PSin==n,1)),'bo')
    %{
disp(mean(Peakin(PSin==n,1)./Peakin(PSin==n,n)));
disp(mean(Peakin(PSin==n,2)./Peakin(PSin==n,n)));
disp(mean(Peakin(PSin==n,3)./Peakin(PSin==n,n)));
disp(mean(Peakin(PSin==n,4)./Peakin(PSin==n,n)));
disp(mean(Peakin(PSin==n,5)./Peakin(PSin==n,n)));
    %}
    xlim([0,6]);
    hold off
end

for n = 1:5
    for m =1:5
        Peakinmean(m,n) = mean(Peakin(PSin==n,m) - Peakin(PSin==n,1));
        Peakinstd(m,n) = std(Peakin(PSin==n,m) - Peakin(PSin==n,1));
        
        %Peakinmean(m,n) = mean(Peakin(PSin==n,m)./Peakin(PSin==n,1));
        %Peakinstd(m,n) = std(Peakin(PSin==n,m)./Peakin(PSin==n,1));
    end
end
figure;
for n = 1:5
    subplot(1,5,n)
    errorbar([1:5],Peakinmean(:,n),Peakinstd(:,n));
    %ylim([0,3])
end

%%
for n = 1:5
    subplot(1,5,n)
    errorbar([1:5],Peakexmean(:,n),Peakexstd(:,n),'r');
    hold on
    errorbar([1:5]+0.2,Peakinmean(:,n),Peakinstd(:,n),'b');
    hold off
    axis([0,6,-.2,.2])
    %ylim([0,3])
end

%%
beta_r = [0.1,0,300,0.2,1];%[Amp0, x0, xsd0, Amp1, xsd1]
lb_r = [0,-10,0,0,0.00001];
ub_r = [realmax('double'),10,realmax('double'),realmax('double'),10];
[b_all,~, residual] = lsqcurvefit(@Gaussian1D, beta_r,Distall(Distall<500),SZRrateall(Distall<500,5),lb_r, ub_r);
Rsq = Calc_Rsq(SZRrateall(:,5),residual);

x_plot = -20:350;
Z_fit_rateall = Gaussian1D(b_all,x_plot);
plot(x_plot, Z_fit_rateall, 'k');
%%
%ex
x_plot = -20:350;
Z_fit_ex = Gaussian1D(beta_r1_ex,x_plot);

figure;
subplot(1,2,1)
for n = 1:5
    %plot(Distex(PSex==6-n),SZRrateex(PSex==6-n,5),col{6-n,1});
    plot(Distex(PSex==6-n),SZRex(PSex==6-n),col{6-n,1});
    hold on
end
plot(x_plot,Z_fit_r2,'r');hold on
plot(x_plot,Z_mean2,'k');
%plot(x_plot, Z_fit_ex, 'k');
xlim([-20,350]);

%in
Z_fit_in = Gaussian1D(beta_r1_in,x_plot);

subplot(1,2,2)
for n = 1:5
    plot(Distin(PSin==6-n),SZRin(PSin==6-n),col{6-n,1});
    hold on
end
plot(x_plot,Z_fit_r3,'b');hold on
plot(x_plot,Z_mean3,'k');
%plot(x_plot, Z_fit_in, 'k');
xlim([-20,350]);

%%


x = -20:350;

figure;
plot(x,Z_fit_r2,'b');
hold on
plot(x,Z_mean2,'r');
plot(x,Z_plus_sd2,'r');
plot(x,Z_minus_sd2,'r');
axis([-20,500, -0.25, 0.25])
hold off


figure;
plot(x,Z_fit_r3,'b');
hold on
plot(x,Z_mean3,'r');
plot(x,Z_plus_sd3,'r');
plot(x,Z_minus_sd3,'r');
axis([-20,500, -0.25, 0.25])
hold off

%%
% Dist from suppression center ‚ð y0cross ‚Å normalize ‚µ‚Ä •ª•z‚ð plot

y0ex = zeros(length(Distex),1);
y0in = zeros(length(Distin),1);
for i = 1:19
    y0ex(IDex==i,1) = y0cross2(i,1);
    y0in(IDin==i,1) = y0cross3(i,1);
end

nDistex = Distex./y0ex;
nDistin = Distin./y0in;


