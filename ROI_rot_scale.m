function out = ROI_rot_scale(cart_path,param)
%cat_path <- centroid
%img_path <- img
%param <- beta (2D gaussian fitting params)

center = [param(2),param(4)];
%phi = param(6);
%rescale = mean([param(3),param(5)]);
rescale = (84.6233+41.4533)/2;
phi = 0.7335;

roicart = dlmread(cart_path,'\t',1,1);
l = length(roicart);
roicart = [roicart(1:2:l-1)',roicart(2:2:l)'];

%%%%%%%%%%%%%
%�ʓ|���������ǁC Cart �̂܂� ���S�ړ��� �ɍ��W�ϊ�����]��XY���W�ϊ����X�P�[�����O�� �ɍ��W�ϊ�
x_center = roicart(:,1) - center(1);
y_center = roicart(:,2) - center(2);

[theta,rho] = cart2pol(x_center,y_center);

%rotation ���� cartesian �ɂ��ǂ���
theta_rot1 = theta - phi;
[x_rot,y_rot] = pol2cart(theta_rot1,rho);
%
%scaling
x_sca = x_rot*(rescale/param(5));
y_sca = y_rot*(rescale/param(3));

x_sca = x_rot*(rescale/41.4533);
y_sca = y_rot*(rescale/84.6233);
%{
if param(3) >= param(5)
x_sca = x_rot*(rescale/41.4533);
y_sca = y_rot*(rescale/84.6233);
else
    x_sca = x_rot*(rescale/84.6233);
    y_sca = y_rot*(rescale/41.4533);
end
%}

% cartesian ���� polar ��
[theta2,rho2] = cart2pol(x_sca,y_sca);

%rotation ���ǂ��� cartesian �ɂ��ǂ�
theta_rot2 = theta2 + phi;
[x_rot2,y_rot2] = pol2cart(theta_rot2,rho2);

out = zeros(l/2,2);
out(:,1) = x_rot2 + center(1);
out(:,2) = y_rot2 + center(2);

%[out(:,1),out(:,2)] = cart2pol(x_sca,y_sca);