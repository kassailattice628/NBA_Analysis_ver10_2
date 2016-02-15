function [out, peakamp1, peakamp2, peakamp, r_area, sd_peak]= StimTraceAverage3(mat, select, Bhead, stim, sampt,stimON, cutTrial)
%StimTraceAverage2 では各ROIの evoked response の面積を計算．
%(StimTraceAverage は peak amplitude を計算
% input
% mat: data (dFF), select: # selected roi, Bhead: Bhead
% stim: header number of the stimulus
% sampt: FVsampt

%%% example %%%
%map
% [y, peak1,peak2, peak, area] = StimTraceAverage2(dFF, selectROI, Bhead, 9, FVsampt,stimON);
% size
% [y, peak1,peak2, peak, area] = StimTraceAverage2(dFF, selectROI, Bhead, 6, FVsampt,stimON);
% dist
% [y, peak1,peak2, peak, area] = StimTraceAverage2(dFF, selectROI, Bhead, 30, FVsampt,stimON);

% angle
% [y, peak1,peak2] = StimTraceAverage2(dFF, selectROI, Bhead, 20, FVsampt,stimON);

% [y, peak1,peak2] = StimTraceAverage2(dFF, selectROI, Bhead, 29, FVsampt,stimON);

% 2stim, zoom のときは，stim == 0 にしておくと，distance と angle (ヘッダの 30, 31) をあわせる
% [y, peak1, peak2] = StimTraceAverage2(dFF, selectROI, Bhead, 0, FVsampt,stimON);

% img
% [y, peak1, peak2] = StimTraceAverage2(dFF, selectROI, Bhead, 40, FVsampt,stimON);

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
%range = floor(Bhead(18,1:end)/sampt);
%刺激出したところのindex取り出す
i_stim = find(Bhead(4,:)>0);

lstim = length(i_stim);



%% 任意の刺激を選ぶときは，ここを変更%%%
range_num = 1:lstim - cutTrial;
%range_num = [1:lstim-20,lstim-13:lstim-1];
%range_num = [1:77-2,85-2:lstim-1];
%range_num = [1:48-2, 53-2:71-2, 76-2:lstim-1];
%range_num = [1:17,20:lstim];
%%

%range = floor(stimON(1:end)/sampt);
%range = floor(stimON(range_num,1)/sampt);
range = floor(stimON(:,1)/sampt);


if stim == 0 %rand8, 16 で 2stim, zoom の場合は index がないので計算
    a = unique(Bhead(30,:));%deg (deg==0 のときは ang なし）
    b = unique(Bhead(31,:));%angle
    
    %刺激パラメタの種類
    list_num = (length(a) - 1) * length(b) + 1;
    list = 1:list_num;
    %angle, dist のパタンのベクトルを作っとく
    %stim_order = zeros(1, lstim);
    %[angle;dist],,,,,[0,0] の順番（[0deg, 2dist], [0deg, 4dist]..., [0deg,
    %10dist], [45deg,2], [45deg, 4], ..., [315deg, 8], [315,10], [10,10]の順番
    stim_set = zeros(2, list_num);
    stim_angle_set = ones(1,length(a)-1);
    stim_dist_set = a(2:end);
    for i = 1:length(b)
        stim_set(1, 5*(i-1)+1:5*i) = b(i) * stim_angle_set;
    end
    stim_set(2,1:end-1) = repmat(stim_dist_set,1,length(b));
    stim_order = zeros(1,length(i_stim));

    for i = 1:length(i_stim)
        stim_order(i) = find(stim_set(1,:) == Bhead(31,i_stim(i)) & stim_set(2,:) == Bhead(30,i_stim(i)));
    end

else %
    %刺激パラメタの種類（pre stim のパラメタが邪魔することがあるのでとっておく）．
    list = unique(Bhead(stim,Bhead(4,:) > 0));
    %list = unique(Bhead(stim,1:end));
    %刺激パタンの種類の数
    list_num = length(list);
end

%%
%point 数で行くと sampt変わると対応するのが面倒なので
%秒で切るか
%pret = 0.5;%刺激前0.5秒
pret = 1;%刺激前1秒
prep = ceil(pret/sampt);
postt = 5;%刺激後8秒
postp = ceil(postt/sampt);
%%
%output 変数サイズ確保
out = zeros(length(select),(prep+postp+1)*list_num);
peakamp1 = zeros(length(select), list_num);
peakamp2 = peakamp1;
peakamp = peakamp1;
r_area = peakamp1;
sd_peak = peakamp1;


%% output の取得
peak1t = 2;%sec 2秒
peak1range = 1:ceil(peak1t/sampt);
%disp(peak1range);で
peak2t = 3;%peak1:peak2(sec) 8秒
peak2range = ceil(peak1t/sampt)+1:ceil(peak2t/sampt);
%disp(peak2range);


for i1 = 1:length(select) %各ROI の trace について
    %y0 に出来た行列突っ込んでいく
    y0_mean=[];
    y0_sd=[];
    
    for i2 = 1:list_num %刺激パタンごと
        y0 = zeros(1,prep+postp+1);
        %刺激回数（パタン毎）
        i_n = 1;
        
        %for i3 = Bhead(4,((Bhead(stim,1:end) == list(i2))& (Bhead(4,1:end) > 0))) %刺激パタン抜き出して
        if stim == 0
            for i3 = range_num(stim_order(range_num) == list(i2))
                t = range(i3)-prep:range(i3)+postp;
                y0(i_n,:) = mat(t,select(i1));
                i_n = i_n + 1;
            end
        else
            for i3 = range_num(Bhead(stim, i_stim(range_num))==list(i2))
                %disp(i3);
                t = range(i3)-prep:range(i3)+postp;
                y0(i_n,:) = mat(t,select(i1));
                i_n = i_n + 1;
                %figure; plot(mat(t,select(i1)));
            end
        end
        %y0 に入った，切り出しトレースからpeak1, peak2, area を取り出す
        %{
        peak1 = max(y0(:,peak1range),[],2); % stimON から 2sec
        peak2 = max(y0(:,peak2range),[],2); % 2sec から 5 sec
        peak = max(y0(:,[peak1range,peak2range]),[],2);
        peakamp1(i1,i2) = mean(peak1);
        peakamp2(i1,i2) = mean(peak2);
        peakamp(i1,i2) = mean(peak);
        %}
        area_each = trapz(y0)*sampt;
        r_area(i1,i2) = mean(area_each);
        
        % 刺激種類毎の平均トレースを順番に全部つなげた
        meany0 = mean(y0,1);%１個しか data がなかったときのために，列の平均を取る
        y0_mean = [y0_mean,meany0];
        peakamp1(i1,i2) = max(meany0(peak1range));%stimON から　2secまで
        peakamp2(i1,i2) = max(meany0(peak2range));%2sec から 5 sec まで
        
        peakamp(i1,i2) = max(meany0);
        
        y0_sd = max(y0,[],2);
        sd_peak(i1,i2) = std(y0_sd);
    end

    out(i1,:) =(y0_mean);
end
%
%多数のroiを表示するのにトレースを微妙にずらす
for i = 1: length(select)
    out(i,:) = out(i,:)+ (0.2*(i-1));
end
figure;
plot(out')
%}