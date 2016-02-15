function [yy,sampt2] = plot_ROIave(dFF, FVt, stimON, nROI, interp_times,method)
% interp で sampling 数を増やしてonset のタイミングを あとからそろえる
t1 = linspace(1,length(FVt),length(FVt)*interp_times);%聡 sampling 数 を interp_times 倍にしてる
FVtsp = interp1(1:length(FVt), FVt,t1);%interp_times のsampling time
yy = zeros(size(dFF,1)*interp_times, size(dFF,2));
if method == 1
    me ='spline';
elseif method == 2
    me ='linear';
end
for i = 1:size(dFF,2)
    %interp_times で sampling point を内挿したデータ
    yy(:,i) = interp1(FVt, dFF(:,i), FVtsp, me);
end

FVt_stimON = zeros(length(stimON),1);
for i = 1:length(stimON);
    %time 0 のポイントを刺激前のぎりぎりの所に設定してみたが...結局内挿なので正確さはない
    %正確にするためには，clip scan してsampling rate を上げる以外にない．
    FVt_stimON(i,1) = find(FVtsp >= stimON(i,1),1);%S-(interp_times);
end

%dFFにtraceはいってる
y =zeros(1,30*interp_times+1);
for i = 1:length(stimON)-1
    %刺激前5point,刺激後25point で集め直す
    yt = (FVt_stimON(i,1)-5*interp_times):(FVt_stimON(i,1)+25*interp_times);
    y(i,:)= yy(yt, nROI);
end
%Time scale (sec)
yt = FVtsp((FVt_stimON(1,1)-5*interp_times):(FVt_stimON(1,1)+25*interp_times)) - FVtsp(FVt_stimON(1,1));
sampt2 = FVtsp(2)-FVtsp(1);
%%%%%%% plot %%%%%%%
figure;
plot(yt,y,'b');
hold on
p = plot(yt, mean(y),'r');
set(p,'Linewidth',2);


%StimTraceAverage(yy, selectROI, Bhead, 6, sampt2);

