function [yy,sampt2] = plot_ROIave(dFF, FVt, stimON, nROI, interp_times,method)
% interp �� sampling ���𑝂₵��onset �̃^�C�~���O�� ���Ƃ��炻�낦��
t1 = linspace(1,length(FVt),length(FVt)*interp_times);%�� sampling �� �� interp_times �{�ɂ��Ă�
FVtsp = interp1(1:length(FVt), FVt,t1);%interp_times ��sampling time
yy = zeros(size(dFF,1)*interp_times, size(dFF,2));
if method == 1
    me ='spline';
elseif method == 2
    me ='linear';
end
for i = 1:size(dFF,2)
    %interp_times �� sampling point ����}�����f�[�^
    yy(:,i) = interp1(FVt, dFF(:,i), FVtsp, me);
end

FVt_stimON = zeros(length(stimON),1);
for i = 1:length(stimON);
    %time 0 �̃|�C���g���h���O�̂��肬��̏��ɐݒ肵�Ă݂���...���Ǔ��}�Ȃ̂Ő��m���͂Ȃ�
    %���m�ɂ��邽�߂ɂ́Cclip scan ����sampling rate ���グ��ȊO�ɂȂ��D
    FVt_stimON(i,1) = find(FVtsp >= stimON(i,1),1);%S-(interp_times);
end

%dFF��trace�͂����Ă�
y =zeros(1,30*interp_times+1);
for i = 1:length(stimON)-1
    %�h���O5point,�h����25point �ŏW�ߒ���
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

