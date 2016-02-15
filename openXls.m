function [y,dFF,FVt,ROIns,f,d]= openXls(FVsampt, dirname)
%%% open xls from imagJ <- FV %%%
global Bhead
%[fname2,dirname2] = uigetfile('*.xls');
if exist('dirname', 'var') == 0
    [f,d] = uigetfile('*.xls');
else
    [f,d] = uigetfile([dirname, '*.xls']);
end
if f == 0
    y = 0;
    dFF = 0;
    FVt = 0;
    ROIns = 0;
    return;
end

dFF = dlmread([d,f], '\t', 1, 1);
%FVsampt = 0.253889999;%(sec)
%FVsampt = 0.128897999;
[FVflames, ROIns] = size(dFF);
FVt = 0:FVsampt:FVsampt*(FVflames-1);


%%
y = plot(FVt,dFF(:,1));
xlim([0 floor(Bhead(18,end)+Bhead(1,end)/1000 + 5)]);
title('#ROI = 1');
ylabel('dF / F');
xlabel('Time (sec)');