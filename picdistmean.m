function mesd = picdistmean(r_pol,diff,i)
%r_pol = r_pol1;
%diff = diff1;
%i = i1; <- �������S1����̋�����100um�ȓ��̂���
%int = 50;
%0-400��m�̊Ԃ�int�ŋ�؂�̂�
%mesd = zeros(400/int,2);

%r1�������S����SD�ȓ��̂���
%����� r2�������S����̋����� SD�Ńm�[�}���C�Y�������̂��g���D
int = 0.25;
%6SD�܂ł݂Ă�
mesd = zeros(6/int,2);
if isempty(i)
    ra = r_pol(:,2:end);
    dd = diff(:,2:end-1);
else
    ra = r_pol(i,2:end);
    dd = diff(i,2:end-1);
end

for n = 1:size(mesd,1)
    l = (n-1)*int;
    u = l +int;
    mesd(n,1) = mean(dd(l <= ra & ra<u));
    mesd(n,2) = std(dd(l <= ra & ra<u));
    ttest(dd(l <= ra & ra<u))
end