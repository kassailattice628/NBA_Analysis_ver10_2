function [peak, peak_ave]= PeakPosSearch(mat,Bhead, sampt,stimON)
% input
% mat: data (dFF), select: # selected roi, Bhead: Bhead
% stim: stim position is defined in Bhead(9,:);
% sampt: FVsampt
% example
%peak_pos = PeakPosSearch(dFF,Bhead,FVsampt,stimON);

%�h���J�n���Ԃ��܂ރ|�C���g�̃x�N�g��
%range = floor(Bhead(18,1:end)/sampt);
range= floor(stimON(:,1)/sampt);
s_dur_p = range(2)-range(1);
%�h���ꏊ�̐�
list = unique(Bhead(9,Bhead(4,:) > 0));
%�h���p�^���̎�ނ̐�
list_num = length(list);

%point ���ōs���� sampt�ς��ƑΉ�����̂��ʓ|�Ȃ̂�
%�b�Ő؂邩
%{
pret = 0.5;%�h���O0.5�b
postt = 3;%�h����5�b
p = ceil((pret+postt)/sampt);
%}
peak = zeros(size(mat,2), list_num-1);

for i1 = 1:size(mat,2) %�eROI �� trace �ɂ���
    for i2 = 1:list_num-1
        peak(i1, i2) = max(mat(range(i2):range(i2)+s_dur_p-1,i1));
    end
end
peak_ave =[];
