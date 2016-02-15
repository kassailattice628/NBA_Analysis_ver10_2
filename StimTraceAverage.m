function [out, peakamp1,peakamp2]= StimTraceAverage(mat, select, Bhead, stim, sampt,stimON)
% input
% mat: data (dFF), select: # selected roi, Bhead: Bhead
% stim: header number of the stimulus
% sampt: FVsampt
% example
% [y, peak1,peak2] = StimTraceAverage(dFF, selectROI, Bhead, 6, FVsampt,stimON);
% [y, peak1,peak2] = StimTraceAverage(dFF, selectROI, Bhead, 20, FVsampt,stimON);
% [y, peak1,peak2] = StimTraceAverage(dFF, selectROI, Bhead, 29, FVsampt,stimON);
% [y1, peak11, peak21] = StimTraceAverage(dFF,selectROI,Bhead,6,FVsampt);
% [y, peak1, peak2] = StimTraceAverage(dFF, selectROI, Bhead, 20, FVsampt);
%{
x = peak1;
y = 1:size(x,1);
Y = cell(4,5);
for i = 1:5
Y{1,i} = y(x(:,i) >= 0.05 & x(:,i) < 0.1);
Y{2,i} = y(x(:,i) >= 0.1 & x(:,i) < 0.2);
Y{3,i} = y(x(:,i) >= 0.2 & x(:,i) < 0.3);
Y{4,i} = y(x(:,i) >= 0.3);
end
%}

%刺激開始時間を含むポイントのベクトル
%range = floor(Bhead(18,1:end-6-1)/sampt);
range = floor(stimON(1:end-6-1)/sampt);
%刺激パラメタの種類（pre stim のパラメタが邪魔することがあるのでとっておく）．
list = unique(Bhead(stim,Bhead(4,:) > 0));
%list = unique(Bhead(stim,1:end-6-1));
%刺激パタンの種類の数
list_num = length(list);

%point 数で行くと sampt変わると対応するのが面倒なので
%秒で切るか
pret = 0.5;%刺激前0.5秒
prep = ceil(pret/sampt);
postt = 5;%刺激後5秒
postp = ceil(postt/sampt);


out = zeros(length(select),(prep+postp+1)*list_num);
peakamp1 = zeros(length(select), list_num);
peakamp2 = zeros(length(select), list_num);

peak1t = 1;%sec, %2 sec
peak1range = 1:ceil(peak1t/sampt);
%disp(peak1range);で
peak2t = 2;%peak1:peak2(sec), %5sec
peak2range = ceil(peak1t/sampt)+1:ceil(peak2t/sampt);
%disp(peak2range);

for i1 = 1:length(select) %各ROI の trace について
    %y0 に出来た行列突っ込んでいく
    y0_mean=[];
    for i2 = 1:list_num %刺激パタンごと
        y0 = zeros(1,prep+postp+1);
        i_n = 1;
        %for i3 = find((Bhead(stim,1:end-6-1) == list(i2)) & Bhead(4,1:end-6-1) > 0)
        for i3 = Bhead(4,((Bhead(stim,1:end-6-1) == list(i2))& (Bhead(4,1:end-6-1) > 0)))
            t = range(i3)-prep:range(i3)+postp;
            y0(i_n,:) = mat(t,select(i1));
            i_n = i_n + 1;
        end
        % 刺激種類毎の平均トレースを順番に全部つなげた
        meany0 = mean(y0);
        y0_mean = [y0_mean, meany0];
        peakamp1(i1,i2) = max(meany0(peak1range));%stimON から　2secまで
        peakamp2(i1,i2) = max(meany0(peak2range));%2sec から 8 sec まで
    end
    out(i1,:) =(y0_mean);
end

%多数のroiを表示するのにトレースを微妙にずらす
for i = 1: length(select)
    out(i,:) = out(i,:)+ (0.2*(i-1));
end
figure;
plot(out')
%plot(out(:,24:47)')
