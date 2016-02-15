function [index_1, index_n] = GetIndex1(centers,ROI_Polar,dist_set,roi)
%���S���� dist_set �̒��ɂ���זE�� �Q�_�ڂ̎h���������Ŕ����ɕ������āC��ׂ�

% stim1 �̒��S�̍��W
X0 = centers(1,1);
Y0 = centers(2,1);
%[X0,Y0] ���S�ɉ�]��������̍��W
ROI_Polar_rot = zeros(size(ROI_Polar(:,:,1),1), size(ROI_Polar(:,:,1),2),5);%��]�p
%[X0,Y0]�𒆐S�ɉ�]��������Cstim n �̒��S�� [0,0] �ɕϊ��������Ƃ̍��W
ROI_Polar_rotn= ROI_Polar_rot; % ��]��� response center n �̒��S �� 0 �ɂ��킹��

%%
for n = 1:5
    X0n = centers(1,n+1);
    Y0n = centers(2,n+1);
    
    %stim1 �� stim_n �� ���S�����񂾒����̊p�x�����߂邽�߂�(X0,Y0)��̋ɍ��W��
    [phi,rho]= cart2pol(X0n-X0, Y0n-Y0);% phi ���X���Ȃ̂ŉ��ŕ␳
    %disp(rad2deg(phi));
    %-phi ��]��� stimn �������S
    [X0n_rot, Y0n_rot]= pol2cart(phi - phi, rho);
    
    %stim1���S�̋ɍ��W ROI_Polar(:,:,1) �� -phi ��]������
    ROI_Polar_rot(:,:,n) = [ROI_Polar(:,1,1) - phi, ROI_Polar(:,2,1)];
    %��]��̋ɍ��W��xy���W�ɕϊ�(stim1���S�j
    [Xn_rot,Yn_rot] = pol2cart(ROI_Polar_rot(:,1,n),ROI_Polar_rot(:,2,n));
    %n�������S�ɕ��s�ړ����ċɍ��W�ɖ߂�
    [ROI_Polar_rotn(:,1,n),ROI_Polar_rotn(:,2,n)] = cart2pol(Xn_rot-X0n_rot, Yn_rot-Y0n_rot);
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

index_1 = cell(1,5);
index_n = cell(1,5);
%ind_uni = cell(1,5);
%%
ROI_Cart_rot = ROI_Polar_rot;%stim1 ���S�ŉ�]�������W
ROI_Cart_rotn = ROI_Polar_rot;%stimn ���S�ŉ�]�������W

for n = 1:5
    [ROI_Cart_rot(:,1,n), ROI_Cart_rot(:,2,n)] = pol2cart(ROI_Polar_rot(:,1,n), ROI_Polar_rot(:,2,n));
    i1 = find(ROI_Polar_rot(:,2,1) < dist_set & ROI_Cart_rot(:,1,n) > 0);

    [ROI_Cart_rotn(:,1,n), ROI_Cart_rotn(:,2,n)] = pol2cart(ROI_Polar_rotn(:,1,n), ROI_Polar_rotn(:,2,n));
    i2 = find(ROI_Polar_rotn(:,2,n) < dist_set & ROI_Cart_rotn(:,1,n) < 0);

    index = intersect(roi,i1);
    index_n{1,n} = intersect(roi,i2);
    rem_i1 = intersect(index, index_n{1,n});% i1 �� i2 �̋���index�� i2�Ƃ��ď���
    index_1{1,n} = setdiff(index, rem_i1);
    %index_uni{1,n} = union(ind_1{1,n}, ind_n{1,n});
end
%���W�`�F�b�N
%{
for n = 1:5
figure;
plot(ROI_Cart_rot(index_1{1,n},1,n),ROI_Cart_rot(index_1{1,n},2,n),'ko');
hold on
plot(ROI_Cart_rotn(index_n{1,n},1,n),ROI_Cart_rotn(index_n{1,n},2,n),'bo');
set(gca,'YDir','reverse');
end
%}