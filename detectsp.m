%detectsp
v2ff=B1(:,n); % temporal trace to use refractory period..v2ff
%Psudo-improving method of the temporal resolution.
% �[���x�N�g���Ń������m��. -1 �ɂ��Ă�̂́C��r�̎��Ck �� k+1 ���ׂ邩��D
v2fB = zeros((length(B1)-1),1);  % v2fB : Binary box for v2f
%{
for k=1:length(v2ff)-1
    %    if  v2ff(k)<spDparams(1) && v2ff(k+1)>spDparams(1)    % use only threshold
    if  v2ff(k)<spDparams(1) && v2ff(k+1)>spDparams(1) && (v2ff(k+1)-v2ff(k))/(1/fs) >spDparams(2) % use threshold and slope threshold
        %v2fB(k)=(spDparams(1)-v2ff(k))/v2ff(k+1) -v2ff(k)+k;
        v2fB(k) = 1;
        v2fB(k+1:k+round(spDparams(3)*fs/1000))=0;     % make refractory period�F�s��������������Cv2ff�̒l��0�ɖ߂��D
    end
    %    end
end
%}

k = 1;
while k < length(v2ff)
    if v2ff(k)<spDparams(1) && v2ff(k+1)>spDparams(1) && (v2ff(k+1)-v2ff(k))/(1/fs) >spDparams(2)
        v2fB(k) = 1;
        k = k + 1 + round(spDparams(3)/1000*fs);% skip check during refractory period.
    else
        k = k+1;%check next point
    end
end

lpv3 = find(v2fB>0); %pi
lpv4=lpv3*1000/fs; % in [ms] timing
insv=lpv4';


