function [y,peak1,peak2,peak1_max, peak1_min, peak2_max, peak2_min] = plot_interp_ave(mat,select,FVt,Bhead, stim, stimON, interp_times, method)
% interp �� sampling ���𑝂₵��onset �̃^�C�~���O�� ���Ƃ��炻�낦��
% [y,peak1_1,peak2_2,peak1_max, peak1_min, peak2_max, peak2_min] = plot_interp_ave(dFF, selectROI, FVt,Bhead, 6,stimON, interp_times, 2);
end1 = size(stimON,1)-1;

%%%%%%%%%% interp1 %%%%%%%%%%%
t1 = linspace(1,length(FVt),length(FVt)*interp_times);%total sampling point �� interp_times �{�ɂ��Ă�
FVtsp = interp1(1:length(FVt), FVt,t1);%interp_times ��sampling time
yy = zeros(size(mat,1)*interp_times, size(mat,2));
if method == 1
    me ='spline';
elseif method == 2
    me ='linear';
end
for i = 1:size(mat,2)
    %interp_times �� sampling point ����}�����f�[�^
    yy(:,i) = interp1(FVt,mat(:,i), FVtsp, me);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%

%stim point update
FVt_stimON = zeros(length(stimON),1);
for i = 1:length(stimON);
    %time 0 �̃|�C���g���h���O�̂��肬��̏��ɐݒ肵�Ă݂���...���Ǔ��}�Ȃ̂Ő��m���͂Ȃ�
    %���m�ɂ��邽�߂ɂ́Cclip scan ����sampling rate ���グ��ȊO�ɂȂ��D
    FVt_stimON(i,1) = find(FVtsp >= stimON(i,1),1);%S-(interp_times);
end
sampt2 = FVtsp(2)-FVtsp(1);

%%%%%%%%%%%%%%%%%%%%%%%%%%

pret = 0.5;
prep = ceil(pret/sampt2);
postt = 5;
postp = ceil(postt/sampt2);
list = unique(Bhead(stim,1:end1));
list_num = length(list);
%peak calc�p%
t1 = 1;%1�b�܂�
peak1range = 1:ceil(t1/sampt2);
t2 = 4;
peak2range = ceil(t1/sampt2):ceil(t2/sampt2);
%%%%%%%%%%%%%%%%%%%%%%%%%%%
%mat��trace�͂����Ă�
%�h���̉񐔂��p�����^���ɓ����ɂȂ��Ă��Ȃ��̂� cell �ɓn��
y = cell(list_num,size(mat,2));
y_mean = zeros(prep+postp+1, list_num, size(mat,2));
for i3 = 1: size(mat,2)
    for i1 = 1:list_num
        stim_n = find(Bhead(4,1:end1)>0 & Bhead(stim,1:end1)==list(i1))-find(Bhead(4,:)==0);
        stim_l = length(stim_n);
        y1 = zeros(prep+postp+1, stim_l);
        for i2 = 1:stim_l
            t = (FVt_stimON(stim_n(i2),1)-prep):(FVt_stimON(stim_n(i2),1)+postp);
            y1(:,i2) = yy(t,i3);
        end
        y{i1,i3} = y1;
        y_mean(:,i1,i3) = mean(y1,2);
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%
peak1 = zeros(list_num,size(mat,2));
peak1_max = zeros(1, size(mat,2));
peak1_min = zeros(1, size(mat,2));
peak2 = peak1;
peak2_max = zeros(1,size(mat,2));
peak2_min = zeros(1,size(mat,2));
for i = 1:size(mat,2)
    peak1(:,i) = max(y_mean(peak1range,:,i))';
    peak1_max(1,i) = find(peak1(:,i)==max(peak1(:,i)));
    peak1_min(1,i) = find(peak1(:,i)==min(peak1(:,i)));
    peak2(:,i) = max(y_mean(peak2range,:,i))';
    peak2_max(1,i) = find(peak2(:,i)==max(peak2(:,i)));
    peak2_min(1,i) = find(peak2(:,i)==min(peak2(:,i)));
end

%%%%%%% plot %%%%%%%
yt = -prep*sampt2:sampt2:postp*sampt2;
figure;
for i = 1:list_num
    subplot(list_num,1,i)
    plot(yt, y{i,select}, 'b');
    hold on
    p = plot(yt, mean(y{i,select},2),'r');
    set(p,'Linewidth',2);
    hold off
    ylim([-0.1,0.4]);
end