function [out, ROI_Polar, mat_diff] = scatter_dist_peak(mat,n, n_comp, OGB)
%{
cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/130909/depth4')
mat = csvread('SC19_peak.csv');
n = 10; %  number of rois for calculating response center;
n_comp = 5; %comparing response betwee minimum and n_stim;
OGB = 90:size(mat(:,1));
[out, ROI_Polar,mat_diff] = scatter_dist_peak(mat,n,n_comp,OGB);
%}
%select roi files
ROIcenter = inpuXls;

l=length(ROIcenter);
X = ROIcenter(1:2:l-1);
Y = ROIcenter(2:2:l);

if nargin == 1;
    n = l/2;
end

[val_sort, index_sort] = sort(mat(:,1),1,'descend');
valn = (val_sort(1:n))';
indexn = (index_sort(1:n));

% cordinates of response center
out = [sum(X(indexn).*valn)/sum(valn), sum(Y(indexn).*valn)/sum(valn)];
out = [94,259];
%out = [103,235];
%受容野の中心を (0,0)にする．
ROI_Cart(:,1) = X - out(1);
ROI_Cart(:,2) = Y - out(2);

ROI_Polar = zeros(l/2,2);%[theta, rho]
for i = 1:l/2
    [ROI_Polar(i,1),ROI_Polar(i,2)]= cart2pol(ROI_Cart(i,1), ROI_Cart(i,2));
end

%差分
mat_diff = zeros(size(mat,1),5);
for i = 1:5, mat_diff(:,i) = mat(:,i) - mat(:,1);end


%peak stim size の検出
mat2 = mat';
%dFFmax = max(mat);
%%%%%%%%%%%%%%%%%%%%%%%%%%
index = zeros(1,size(mat,1));
max_ROI = cell(1,5);
for i = 1:size(mat,1)
    index(1,i) = find(mat2(:,i)==max(mat2(:,i)));
end

for i = 1:5
    i2 = find(index==i);
    max_ROI{1,i} = i2(ismember(i2,OGB));
    clear i2;
end
figure; scatter(ROI_Polar(OGB,2),mat_diff(OGB,n_comp),'ko');

hold on
for i = 1:5
    c = select_col(i);
    scatter(ROI_Polar(max_ROI{1,i},2),mat_diff(max_ROI{1,i},n_comp),c);
end
hold off
%%%%%%%%%%%%%%%%%%%%%%%%%%
figure;
for ii = 1:n_comp
    index = zeros(1,size(mat,1));
    max_ROI = cell(1,5);
    for i = 1:size(mat,1)
        index(1,i) = find(mat2(:,i) == max(mat2(:,i)));
    end
    for i = 1:5
        i2 = find(index==i);
        max_ROI{1,i} = i2(ismember(i2,OGB));
        clear i2
    end
    for i = 1:5
        c = select_col(i);
        subplot(5,1,ii);
        scatter(ROI_Polar(max_ROI{1,i},2), mat(max_ROI{1,i},ii),c);
        ylim([-0.05, 0.3]);
        hold on
    end
    plot([0,400],[0,0]);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure;
for ii = 2:n_comp
    index = zeros(1,size(mat,1));
    max_ROI = cell(1,5);
    for i = 1:size(mat,1)
        index(1,i) = find(mat2(:,i)==max(mat2(:,i)));
    end
    
    for i = 1:5
        i2 = find(index==i);
        max_ROI{1,i} = i2(ismember(i2,OGB));
        clear i2;
    end
    %subplot(4,1,ii-1);
    %scatter(ROI_Polar(OGB,2),mat_diff(OGB,ii),'ko');
    for i = 1:5
        c = select_col(i);
        subplot(4,1,ii-1);
        scatter(ROI_Polar(max_ROI{1,i},2),mat_diff(max_ROI{1,i},ii),c);
        
        ylim([-0.2,0.2]);
        hold on
    end
    
    plot([0,400],[0,0],'k');
end
hold off


%%%%%
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



