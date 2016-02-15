function [out, out2] = sepcomptrace2(mat,select,Bhead,stim,sampt,stimON)
% [out,nout] = sepcomptrace2(dFF, selectROI, Bhead, 30, FVsampt,stimON);
% stimnum = �h���̍s�ԍ�
%%

%�h���J�n���Ԃ��܂ރ|�C���g�̃x�N�g��
%range = floor(Bhead(18,1:end)/sampt);
%�h���o�����Ƃ����index���o��
i_stim = find(Bhead(4,:)>0);
lstim = length(i_stim);

%% �C�ӂ̎h����I�ԂƂ��́C������ύX%%%
range_num = 1:lstim-1;
%range_num = [1:17,20:lstim];
%%
%range = floor(stimON(1:end)/sampt);
%range = floor(stimON(range_num,1)/sampt);
range = floor(stimON(:,1)/sampt);
%�h���p�����^�̎�ށipre stim �̃p�����^���ז����邱�Ƃ�����̂łƂ��Ă����j�D
list = unique(Bhead(stim,Bhead(4,:) > 0));
list_num = length(list);
%list = unique(Bhead(stim,1:end));

%point ���ōs���� sampt�ς��ƑΉ�����̂��ʓ|�Ȃ̂�
%�b�Ő؂邩
%pret = 0.5;%�h���O0.5�b
pret = 1;%�h���O1�b
prep = ceil(pret/sampt);
postt = 8;%�h����8�b
postp = ceil(postt/sampt);

%output
out = zeros(length(select),(prep+postp+1)*list_num);
out_sd = out;

for i1 = 1:length(select) %�eROI �� trace �ɂ���
    %y0 �ɏo�����s��˂�����ł���
    y0_mean=[];
    y0_sd=[];
    ny0_mean = [];
    ny0_sd = [];
    max_meany0 = 1;
    for i2 = 1:list_num; %�h���p�^������
        y0 = zeros(1,prep+postp+1);
        %�h���񐔁i�p�^�����j
        i_n = 1;
        %for i3 = Bhead(4,((Bhead(stim,1:end) == list(i2))& (Bhead(4,1:end) > 0))) %�h���p�^�������o����
        for i3 =range_num(Bhead(stim,i_stim(range_num))==list(i2))
            %disp(i3);
            t = range(i3)-prep:range(i3)+postp;
            y0(i_n,:) = mat(t,select(i1)); %���f�[�^��y0�Ȃ̂ł�������o��������...�s���i�g���C�A�����j���h���ɂ���đS�����ꂳ��ĂȂ�����P�̕ϐ��ɂł��Ȃ��H
            i_n = i_n + 1;
        end            
        % �h����ޖ��̕��σg���[�X�����ԂɑS���Ȃ���
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
%������roi��\������̂Ƀg���[�X������ɂ��炷
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