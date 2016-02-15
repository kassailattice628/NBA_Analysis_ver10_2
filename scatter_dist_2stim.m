function [out,ROI_Polar] = scatter_dist_2stim(mat,n,n_comp,OGB)
%{
cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/130909/depth4')
mat = csvread('SC18_peak.csv');
n = 10; % number of rois for calculating response center;
n_comp = 5; %comparing response betwee minimum and n_stim;
OGB = 90:size(mat(:,1));
[out, ROI_Polar] = scatter_dist_2stim(mat,n,n_comp,OGB);
%}

ROIcenter = inpuXls;
l=length(ROIcenter);
X = ROIcenter(1:2:l-1);
Y = ROIcenter(2:2:l);

if nargin == 1;
    n = l/2;
end
out = zeros(size(mat,2),2);
%response center ÇÃ XYç¿ïW
for i = 1:size(mat,2)
    [val_sort, index_sort] = sort(mat(:,i),1,'descend');
    valn = (val_sort(1:n))';
    indexn = (index_sort(1:n));
    out(i,:) = [sum(X(indexn).*valn)/sum(valn), sum(Y(indexn).*valn)/sum(valn)];
end

ROI_Polar = cell(1,n_comp);
for ii = 1:n_comp
    ROI_Cart(:,1) = X - out(ii,1);
    ROI_Cart(:,2) = Y - out(ii,2);
    for i = 1:l/2
        [ROI_Polar{1,ii}(i,1), ROI_Polar{1,ii}(i,2)] = cart2pol(ROI_Cart(i,1),ROI_Cart(i,2));
    end
end

mat2 = mat';
index = zeros(1,size(mat,1));
max_ROI = cell(1,n_comp);
for i = 1:size(mat,1)
    index(1,i) = find(mat2(:,i) == max(mat2(:,i)));
end

for i = 1:n_comp
    i2 = find(index==i);
    max_ROI{1,i} = i2(ismember(i2,OGB));
    clear i2
end

f1 = figure;
for ii = 1:n_comp
    for i = 1:n_comp
        figure(f1);
        c = select_col(i);
        subplot(size(mat,2)/2,2,ii)

        scatter(ROI_Polar{1,ii}(max_ROI{1,i},2), mat(max_ROI{1,i},ii),c);
        ylim([-0.03, 0.4]);
        hold on
    end
    plot([0,400],[0,0],'k');
end
hold off

f2 = figure;
for ii = 1:n_comp
    for i = 1:n_comp
        figure(f2);
        c = select_col(i);
        subplot(size(mat,2)/2,2,ii)
        scatter(ROI_Polar{1,1}(max_ROI{1,i},2), mat(max_ROI{1,i},ii),c);
        ylim([-0.03, 0.4]);
        hold on
    end
    plot([0,400],[0,0],'k');
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


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
elseif i == 6
    c = 'k.';
end