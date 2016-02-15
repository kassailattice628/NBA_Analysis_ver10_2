function [out, peakamp1, peakamp2, peakamp, r_area, sd_peak]= StimTraceAverage3(mat, select, Bhead, stim, sampt,stimON, cutTrial)
%StimTraceAverage2 �ł͊eROI�� evoked response �̖ʐς��v�Z�D
%(StimTraceAverage �� peak amplitude ���v�Z
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

% 2stim, zoom �̂Ƃ��́Cstim == 0 �ɂ��Ă����ƁCdistance �� angle (�w�b�_�� 30, 31) �����킹��
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

%�h���J�n���Ԃ��܂ރ|�C���g�̃x�N�g��
%range = floor(Bhead(18,1:end)/sampt);
%�h���o�����Ƃ����index���o��
i_stim = find(Bhead(4,:)>0);

lstim = length(i_stim);



%% �C�ӂ̎h����I�ԂƂ��́C������ύX%%%
range_num = 1:lstim - cutTrial;
%range_num = [1:lstim-20,lstim-13:lstim-1];
%range_num = [1:77-2,85-2:lstim-1];
%range_num = [1:48-2, 53-2:71-2, 76-2:lstim-1];
%range_num = [1:17,20:lstim];
%%

%range = floor(stimON(1:end)/sampt);
%range = floor(stimON(range_num,1)/sampt);
range = floor(stimON(:,1)/sampt);


if stim == 0 %rand8, 16 �� 2stim, zoom �̏ꍇ�� index ���Ȃ��̂Ōv�Z
    a = unique(Bhead(30,:));%deg (deg==0 �̂Ƃ��� ang �Ȃ��j
    b = unique(Bhead(31,:));%angle
    
    %�h���p�����^�̎��
    list_num = (length(a) - 1) * length(b) + 1;
    list = 1:list_num;
    %angle, dist �̃p�^���̃x�N�g��������Ƃ�
    %stim_order = zeros(1, lstim);
    %[angle;dist],,,,,[0,0] �̏��ԁi[0deg, 2dist], [0deg, 4dist]..., [0deg,
    %10dist], [45deg,2], [45deg, 4], ..., [315deg, 8], [315,10], [10,10]�̏���
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
    %�h���p�����^�̎�ށipre stim �̃p�����^���ז����邱�Ƃ�����̂łƂ��Ă����j�D
    list = unique(Bhead(stim,Bhead(4,:) > 0));
    %list = unique(Bhead(stim,1:end));
    %�h���p�^���̎�ނ̐�
    list_num = length(list);
end

%%
%point ���ōs���� sampt�ς��ƑΉ�����̂��ʓ|�Ȃ̂�
%�b�Ő؂邩
%pret = 0.5;%�h���O0.5�b
pret = 1;%�h���O1�b
prep = ceil(pret/sampt);
postt = 5;%�h����8�b
postp = ceil(postt/sampt);
%%
%output �ϐ��T�C�Y�m��
out = zeros(length(select),(prep+postp+1)*list_num);
peakamp1 = zeros(length(select), list_num);
peakamp2 = peakamp1;
peakamp = peakamp1;
r_area = peakamp1;
sd_peak = peakamp1;


%% output �̎擾
peak1t = 2;%sec 2�b
peak1range = 1:ceil(peak1t/sampt);
%disp(peak1range);��
peak2t = 3;%peak1:peak2(sec) 8�b
peak2range = ceil(peak1t/sampt)+1:ceil(peak2t/sampt);
%disp(peak2range);


for i1 = 1:length(select) %�eROI �� trace �ɂ���
    %y0 �ɏo�����s��˂�����ł���
    y0_mean=[];
    y0_sd=[];
    
    for i2 = 1:list_num %�h���p�^������
        y0 = zeros(1,prep+postp+1);
        %�h���񐔁i�p�^�����j
        i_n = 1;
        
        %for i3 = Bhead(4,((Bhead(stim,1:end) == list(i2))& (Bhead(4,1:end) > 0))) %�h���p�^�������o����
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
        %y0 �ɓ������C�؂�o���g���[�X����peak1, peak2, area �����o��
        %{
        peak1 = max(y0(:,peak1range),[],2); % stimON ���� 2sec
        peak2 = max(y0(:,peak2range),[],2); % 2sec ���� 5 sec
        peak = max(y0(:,[peak1range,peak2range]),[],2);
        peakamp1(i1,i2) = mean(peak1);
        peakamp2(i1,i2) = mean(peak2);
        peakamp(i1,i2) = mean(peak);
        %}
        area_each = trapz(y0)*sampt;
        r_area(i1,i2) = mean(area_each);
        
        % �h����ޖ��̕��σg���[�X�����ԂɑS���Ȃ���
        meany0 = mean(y0,1);%�P���� data ���Ȃ������Ƃ��̂��߂ɁC��̕��ς����
        y0_mean = [y0_mean,meany0];
        peakamp1(i1,i2) = max(meany0(peak1range));%stimON ����@2sec�܂�
        peakamp2(i1,i2) = max(meany0(peak2range));%2sec ���� 5 sec �܂�
        
        peakamp(i1,i2) = max(meany0);
        
        y0_sd = max(y0,[],2);
        sd_peak(i1,i2) = std(y0_sd);
    end

    out(i1,:) =(y0_mean);
end
%
%������roi��\������̂Ƀg���[�X������ɂ��炷
for i = 1: length(select)
    out(i,:) = out(i,:)+ (0.2*(i-1));
end
figure;
plot(out')
%}