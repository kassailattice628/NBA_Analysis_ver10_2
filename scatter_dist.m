function [ROI_Polar,index] = scatter_dist(mat,roi,center,phi)
%
% plot responses as a function of distances from a response center
%  <input>
% 'mat' is matrix of roi intensiy data
% 'roi' is a selected ROI
% 'center' is a center cordinate of a res_center estimated by gaussian fitting.
% 'phi' is a gaussian rotation angle.
%
%  <output>
%
% 'ROI_Polar' is a polar cordinates of each ROI whose center position and
% rotation angle is corrected.
% 'Rsq' is a Rsquare value after fitting distribution.

% centorid data (um)
ROIcenter = inpuXls; 

% center cordinates (X,Y)
l = length(ROIcenter);
X = ROIcenter(1:2:l-1);
Y = ROIcenter(2:2:l);

% center correction
X = X - center(1);
Y = Y - center(2);

% rotation correction
ROI_Cart = zeros(l/2,2);
ROI_Cart(:,1) = X.*cos(-phi) - Y.*sin(-phi);
ROI_Cart(:,2) = X.*sin(-phi) + Y.*cos(-phi);

ROI_Polar = zeros(l/2,2); %[theta, rho]
[ROI_Polar(:,1),ROI_Polar(:,2)] = cart2pol(ROI_Cart(:,1),ROI_Cart(:,2));

%% calc subtracted data (subtraction)
mat_diff = zeros(size(mat,1),size(mat,2));
for i = 1:5
    mat_diff(:,i) = mat(:,i) - mat(:,1);
end

% peak detection (for coloring plot)
mat2 = mat';
index = zeros(1,size(mat,1));%
max_ROI = cell(1,5);
%%
for i = 1:size(mat,1)
    in = find(mat2(:,i)==max(mat2(:,i)));
    if length(in) == 1
        index(1,i) = in;
    elseif length(in) > 1
        index(1,i) = min(in);
    end
end

for i = 1:5
    i2 = find(index==i);
    max_ROI{1,i} = i2(ismember(i2,roi));
    clear i2
end

%%
%%%%%%%%%%% plot1 %%%%%%%%%%
% the response to largest stimuli (10 deg) is subtructted by the reseponse
% to smallest stimuli (0.5 deg).
%figure;
%scatter(ROI_Polar(roi,2), mat_diff(roi,size(mat,2)), 'ko');%plot Ç…çïògÇ¬ÇØÇƒÇÈÇæÇØ
hold on
% each color (b,c,g,y,r) indicates the preferred size.
for i = 1:5
    c = select_col(i);
    scatter(ROI_Polar(max_ROI{1,i},2), mat_diff(max_ROI{1,i},size(mat,2)),c);
end
xlim([0, 350]);
ylim([-0.2, 0.15]);
%hold off

%fit
szr = mat_diff(:,5);
beta_r = [0.1,0,300,0.2,1];%[Amp0, x0, xsd0, Amp1, xsd1]
lb_r = [0,-10,0,0,0.001];
ub_r = [1,10,500,1,10];

[beta_r1,~, residual] = lsqcurvefit(@Gaussian1D, beta_r,ROI_Polar(roi,2),szr(roi), lb_r, ub_r);
Rsq = Calc_Rsq(szr(roi),residual);

x_plot = 0:350;
Z_fit_r = Gaussian1D(beta_r1,x_plot);

plot(x_plot, Z_fit_r, 'g');


%%
%%%%%%%%%%% plot2 %%%%%%%%%%

figure;
for ii = 1:size(mat,2)
    for i = 1:size(mat,2)
        c = select_col(i);
        subplot(5,1,ii);
        scatter(ROI_Polar(max_ROI{1,i},2), mat(max_ROI{1,i},ii),c);
        ylim([-0.15, 0.3]);
        hold on
    end
    plot([0,300],[0,0]);
end
hold off

%%
%%%%%%%%%%% plot3 %%%%%%%%%%

figure;
for ii = 2:size(mat,2)
    for i = 1:size(mat,2)
        c = select_col(i);
        subplot(4,1,ii-1);
        scatter(ROI_Polar(max_ROI{1,i}, 2), mat_diff(max_ROI{1,i},ii),c);
        ylim([-0.2,0.2]);
        hold on
    end
    plot([0,300],[0,0],'k');
end
hold off
%%

function c = select_col(i)
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