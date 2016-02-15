function [out, peakamp1, peakamp2, peakamp, r_area]= StimTraceAverage2(mat, select, Bhead, stim, sampt,stimON)
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
range_num = 1:lstim-0;
%range_num = [1:17,20:lstim];
%%
%range = floor(stimON(1:end)/sampt);
%range = floor(stimON(range_num,1)/sampt);
range = floor(stimON(:,1)/sampt);
%�h���p�����^�̎�ށipre stim �̃p�����^���ז����邱�Ƃ�����̂łƂ��Ă����j�D
list = unique(Bhead(stim,Bhead(4,:) > 0));
%list = unique(Bhead(stim,1:end));
%�h���p�^���̎�ނ̐�
list_num = length(list);

%point ���ōs���� sampt�ς��ƑΉ�����̂��ʓ|�Ȃ̂�
%�b�Ő؂邩
%pret = 0.5;%�h���O0.5�b
pret = 0.5;%�h���O1�b
prep = ceil(pret/sampt);
postt = 2;%�h����8�b
postp = ceil(postt/sampt);

%output 
out = zeros(length(select),(prep+postp+1)*list_num);
peakamp1 = zeros(length(select), list_num);
peakamp2 = peakamp1;
peakamp = peakamp1;
r_area = peakamp1;


peak1t = 2;%sec 2�b
peak1range = 1:ceil(peak1t/sampt);
%disp(peak1range);��
peak2t = 3;%peak1:peak2(sec) 8�b
peak2range = ceil(peak1t/sampt)+1:ceil(peak2t/sampt);
%disp(peak2range);

for i1 = 1:length(select) %�eROI �� trace �ɂ���
    %y0 �ɏo�����s��˂�����ł���
    y0_mean=[];
    
    for i2 = 1:list_num %�h���p�^������
        y0 = zeros(1,prep+postp+1);
        %�h���񐔁i�p�^�����j
        i_n = 1;
        
        %for i3 = Bhead(4,((Bhead(stim,1:end) == list(i2))& (Bhead(4,1:end) > 0))) %�h���p�^�������o����
        for i3 =range_num(Bhead(stim,i_stim(range_num))==list(i2))
            %disp(i3);
            t = range(i3)-prep:range(i3)+postp;
            y0(i_n,:) = mat(t,select(i1));
            i_n = i_n + 1;
            %figure; plot(mat(t,select(i1)));
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