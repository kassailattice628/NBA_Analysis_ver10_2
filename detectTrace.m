function y = detectTrace(mat, threshold)
%mat�i�s��j�̗�f�[�^��臒l�𒴂������̗̂�ԍ���
%���o���D

y = [];
for i = 1:size(mat,2)
    if max(mat(:,i)) > threshold
        y = [y, i];
    end
end

%{
%���X�g���h���b�v�ł�݂����
x = SC******;
y = 1:size(x,1);
y(x(:,5) >= 0.05 & x(:,5) < 0.1);
y(x(:,5) >= 0.1 & x(:,5) < 0.2);
y(x(:,5) >= 0.2 & x(:,5) < 0.3);
y(x(:,5) >= 0.3);
%}