%%% open Xls_XY cordinate %%%
[f,d] = uigetfile('*.xls');

cord = dlmread([d,f], '\t',1,1);
nROI = length(cord)/2;
%XYcord(:,x) �� x�Ԗڂ�ROI�̍��W�i�d�S�j�����o���D
XYcord = zeros(2,nROI);
XYcord(1,:) = cord(1:2:end-1);
XYcord(2,:) = cord(2:2:end);


