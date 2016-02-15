%オーバサンプリングして平均を取る場合．

%130206GAD SC26,27,28
x = 1:1000;%FVsampt = 0.25389
% FVsamptq = 0.001 (1 ms) にしたい．
%compt = 1/100;%0.001;
%compt = 1/10;
compt = FVsampt/1;
disp([' "stim timing" is ', num2str(ceil(0.5/compt)), '.']);
cFVsampt = 1/FVsampt*compt;
xq = 1:cFVsampt:1000;

dFFq = interp1(x,dFF,xq,'spline');

select = selectROI;%126
stim = 6; %size change
sampt = compt;

[out, peakamp1, peakamp2, peakamp, r_area]= StimTraceAverage_0725(dFFq, select, Bhead, stim, sampt,stimON);

%stim timing

