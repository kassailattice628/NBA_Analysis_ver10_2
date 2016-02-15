function [peak, peak_ave]= PeakPosSearch(mat,Bhead, sampt,stimON)
% input
% mat: data (dFF), select: # selected roi, Bhead: Bhead
% stim: stim position is defined in Bhead(9,:);
% sampt: FVsampt
% example
%peak_pos = PeakPosSearch(dFF,Bhead,FVsampt,stimON);

%刺激開始時間を含むポイントのベクトル
%range = floor(Bhead(18,1:end)/sampt);
range= floor(stimON(:,1)/sampt);
s_dur_p = range(2)-range(1);
%刺激場所の数
list = unique(Bhead(9,Bhead(4,:) > 0));
%刺激パタンの種類の数
list_num = length(list);

%point 数で行くと sampt変わると対応するのが面倒なので
%秒で切るか
%{
pret = 0.5;%刺激前0.5秒
postt = 3;%刺激後5秒
p = ceil((pret+postt)/sampt);
%}
peak = zeros(size(mat,2), list_num-1);

for i1 = 1:size(mat,2) %各ROI の trace について
    for i2 = 1:list_num-1
        peak(i1, i2) = max(mat(range(i2):range(i2)+s_dur_p-1,i1));
    end
end
peak_ave =[];
