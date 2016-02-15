function out = ResCenterCart(val, n)
% calculate a response center from weighted sum from 'n's neurons.
% n is a number of the cells used for calculate centroid.
% val is a vector of peak amplitude calculated from each ROI.
% for exammple
% n = 20; if n is not used, all ROIs are used for calulation.
% x1 = csvread('SC1_peak1.csv');
% val = x1(:,1)
%
% ‰“š‚Ì‚Å‚©‚¢‚à‚Ìã‚©‚ç20ŒÂg‚Á‚Äcentroid ‚ğŒvZD
% out = ResCenterCart(val, n);

ROIcenter = inpuXls;
l=length(ROIcenter);
X = ROIcenter(1:2:l-1);
Y = ROIcenter(2:2:l);

if nargin == 1;
    n = l/2;
end

[val_sort, index_sort] = sort(val,1,'descend');
valn = (val_sort(1:n))';
indexn = (index_sort(1:n));

X = sum(X(indexn).*valn)/sum(valn);
Y = sum(Y(indexn).*valn)/sum(valn);
out = [X,Y];
