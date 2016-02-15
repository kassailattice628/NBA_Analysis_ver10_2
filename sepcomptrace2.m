function [out, out2] = sepcomptrace2(mat,select,Bhead,stim,sampt,stimON)
% [out,nout] = sepcomptrace2(dFF, selectROI, Bhead, 30, FVsampt,stimON);
% stimnum = 刺激の行番号
%%

%刺激開始時間を含むポイントのベクトル
%range = floor(Bhead(18,1:end)/sampt);
%刺激出したところのindex取り出す
i_stim = find(Bhead(4,:)>0);
lstim = length(i_stim);

%% 任意の刺激を選ぶときは，ここを変更%%%
range_num = 1:lstim-1;
%range_num = [1:17,20:lstim];
%%
%range = floor(stimON(1:end)/sampt);
%range = floor(stimON(range_num,1)/sampt);
range = floor(stimON(:,1)/sampt);
%刺激パラメタの種類（pre stim のパラメタが邪魔することがあるのでとっておく）．
list = unique(Bhead(stim,Bhead(4,:) > 0));
list_num = length(list);
%list = unique(Bhead(stim,1:end));

%point 数で行くと sampt変わると対応するのが面倒なので
%秒で切るか
%pret = 0.5;%刺激前0.5秒
pret = 1;%刺激前1秒
prep = ceil(pret/sampt);
postt = 8;%刺激後8秒
postp = ceil(postt/sampt);

%output
out = zeros(length(select),(prep+postp+1)*list_num);
out_sd = out;

for i1 = 1:length(select) %各ROI の trace について
    %y0 に出来た行列突っ込んでいく
    y0_mean=[];
    y0_sd=[];
    ny0_mean = [];
    ny0_sd = [];
    max_meany0 = 1;
    for i2 = 1:list_num; %刺激パタンごと
        y0 = zeros(1,prep+postp+1);
        %刺激回数（パタン毎）
        i_n = 1;
        %for i3 = Bhead(4,((Bhead(stim,1:end) == list(i2))& (Bhead(4,1:end) > 0))) %刺激パタン抜き出して
        for i3 =range_num(Bhead(stim,i_stim(range_num))==list(i2))
            %disp(i3);
            t = range(i3)-prep:range(i3)+postp;
            y0(i_n,:) = mat(t,select(i1)); %元データがy0なのでこれを取り出したいが...行数（トライアル数）が刺激によって全部統一されてないから１個の変数にできない？
            i_n = i_n + 1;
        end            
        % 刺激種類毎の平均トレースを順番に全部つなげた
        meany0 = mean(y0);
        sdy0 = std(y0);
        y0_mean = [y0_mean, meany0];
        y0_sd = [y0_sd, sdy0];
        if i2 == 1
            max_meany0 = max(mean(y0));
        end
        meany0_norm = mean(y0/max_meany0);
        sdy0_norm = std(y0/max_meany0);
        ny0_mean = [ny0_mean, meany0_norm];
        ny0_sd = [ny0_sd, sdy0_norm];
        
    end
    out(i1,:) =y0_mean;
    out_sd(i1,:) = y0_sd;
    out2(i1,:) =ny0_mean;
    out2_sd(i1,:) = ny0_sd;
    
end
%
%多数のroiを表示するのにトレースを微妙にずらす
for i = 1: length(select)
    %out(i,:) = out(i,:)+ (0.2*(i-1));
end

figure;
plot(out')
hold on
plot(out' + out_sd','r');
plot(out'- out_sd','g');
axis([0 105 -0.05, 0.3])

figure;
plot(out2')
hold on
plot(out2' + out2_sd','r-');
plot(out2'- out2_sd','g-');
%}