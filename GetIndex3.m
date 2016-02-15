%���S���� dist_set �̒��ɂ���זE�� �Q�_�ڂ̎h���������Ŕ����ɕ������āC��ׂ�

% stim1 �̒��S�̍��W
X0 = centers(1,1);
Y0 = centers(2,1);
%[X0,Y0] ���S�ɉ�]��������̍��W
ROI_Polar_rot = zeros(size(ROI_Polar(:,:,1),1), size(ROI_Polar(:,:,1),2),5);%��]�p
%[X0,Y0]�𒆐S�ɉ�]��������Cstim n �̒��S�� [0,0] �ɕϊ��������Ƃ̍��W
ROI_Polar_rotn= ROI_Polar_rot; % ��]��� response center n �̒��S �� 0 �ɂ��킹��
ROI_Cart_rotn = ROI_Polar_rot;
roi =OGB;
%%
for n = 1:5
    X0n = centers(1,n+1);
    Y0n = centers(2,n+1);
    
    %stim1 �� stim_n �� ���S�����񂾒����̊p�x�����߂邽�߂�(X0,Y0)��̋ɍ��W��
    [phi,rho]= cart2pol(X0n-X0, Y0n-Y0);% phi ���X���Ȃ̂ŉ��ŕ␳
    %disp(rad2deg(phi));
    %-phi ��]��� stimn �������S
    X0n_rot= pol2cart(phi - phi, rho);
    
    %stim1���S�̋ɍ��W ROI_Polar(:,:,1) �� -phi ��]������
    ROI_Polar_rot(:,:,n) = [ROI_Polar(:,1,1) - phi, ROI_Polar(:,2,1)];
    %��]��̋ɍ��W��xy���W�ɕϊ�(stim1���S�j
    [Xn_rot,Yn_rot] = pol2cart(ROI_Polar_rot(:,1,n),ROI_Polar_rot(:,2,n));
    %stim1 ���S�� stimn ���S�̒��_ x = X0n_rot/2 ������ stimn ���� stim 1���ɐ܂�Ԃ��ĂQ�̉������d�˂�
    Xn_rot_sp = Xn_rot;
    Xn_rot_sp(Xn_rot >= X0n_rot/2) = X0n_rot - Xn_rot(Xn_rot >= X0n_rot/2);
    %X0n_rot/2 = 0 �ɂ��Ă����H
    %Xn_rot_sp2 = Xn_rot_sp- X0n_rot/2;
    
    Yn_rot_sp = Yn_rot;
    %x = 0 �Ŕ��]����H
    %Yn_rot_sp(Yn_rot < 0) = -Yn_rot(Yn_rot < 0);
    ROI_Cart_rotn(:,1,n) = Xn_rot_sp;
    ROI_Cart_rotn(:,2,n) = Yn_rot_sp;
    [ROI_Polar_rotn(:,1,n), ROI_Polar_rotn(:,2,n)] = cart2pol(Xn_rot_sp, Yn_rot_sp);
    
    %n�������S�ɕ��s�ړ����ċɍ��W�ɖ߂�
    %[ROI_Polar_rotn(:,1,n),ROI_Polar_rotn(:,2,n)] = cart2pol(Xn_rot-X0n_rot, Yn_rot-Y0n_rot);
end
%���Wcheck
%{
figure;
polar(ROI_Polar(:,1,1),ROI_Polar(:,2,1),'ko');
hold on
polar(ROI_Polar_rotn(:,1,1),ROI_Polar_rotn(:,2,1),'bo');
polar(ROI_Polar_rotn(:,1,2),ROI_Polar_rotn(:,2,2),'co');
polar(ROI_Polar_rotn(:,1,3),ROI_Polar_rotn(:,2,3),'go');
polar(ROI_Polar_rotn(:,1,4),ROI_Polar_rotn(:,2,4),'yo');
polar(ROI_Polar_rotn(:,1,5),ROI_Polar_rotn(:,2,5),'ro');
%}
%%
% �}�b�s���O����
figure;
plot(ROI_Cart_rotn(:,1,1),ROI_Cart_rotn(:,2,1),'.','color',[1,.3,.3]);
plot(ROI_Cart_rotn(:,1,2),ROI_Cart_rotn(:,2,2),'.','color',[.3,.3,.3]);
plot(ROI_Cart_rotn(:,1,3),ROI_Cart_rotn(:,2,3),'.','color',[.1,.3,.5]);



