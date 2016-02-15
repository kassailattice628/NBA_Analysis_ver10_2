function [ROI_Polar,ROI_Cart_ori] = POLAR_CART(xRFcenter ,yRFcenter)
%ROI_centorid �̍��W�� response cente ���S�̋ɍ��W�ɕϊ�

ROIcenter = inpuXls;

l=length(ROIcenter);
ROI_Cart = zeros(l/2, 2);
xROIcenter = 1:2:l-1;%x
yROIcenter = 2:2:l;%y
ROI_Cart_ori(:,1) = ROIcenter(xROIcenter);
ROI_Cart_ori(:,2) = ROIcenter(yROIcenter);

%��e��̒��S�� (0,0)�ɂ���D
ROI_Cart(:,1) = ROI_Cart_ori(:,1) - xRFcenter;
ROI_Cart(:,2) = ROI_Cart_ori(:,2) - yRFcenter;

ROI_Polar = zeros(l/2,2);%[theta, rho]
for n = 1:l/2
    [ROI_Polar(n,1),ROI_Polar(n,2)]= cart2pol(ROI_Cart(n,1), ROI_Cart(n,2));
end

%{
function degrees = rad2deg(radians)
    degrees = radians*180/pi;
return
%}

