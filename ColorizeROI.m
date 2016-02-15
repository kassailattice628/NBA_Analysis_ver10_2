function [ROIs,img2]=ColorizeROI(img_path, roi_path, val, val_min, val_max,map)
%{
imageJ �쐬����ROI�� Matlab �ɓǂݍ���ł���
�eROI�� parametor �����Ƃ�color map ���g���ĐF�t������
a = 'AVG_sc23_9x9Pos31_Szr_reg.tif';
b = 'SC23RoiSet.zip';
map = colormap(hot(256));
[ROIs,img2] = ColorizeROI(a,b,x1(:,1), 0.05, 0.2, map);
%}

%���摜�̓ǂݍ���(gray �摜�j
img = imread(img_path);
figure; imshow(img);
hold on 
ROIs = ReadImageJROI(roi_path);
img_sz1 = size(img,1);
img_sz2 = size(img,2);
nROIs = size(ROIs,2);
BWall = false(img_sz1,img_sz2);
nBW = false(img_sz1, img_sz2,nROIs);

for i = 1:nROIs
    %ROI�̈ʒu���̎擾�C�n�_�ƏI�_����Ă���
    c = [ROIs{1,i}.mnCoordinates(:,1); ROIs{1,i}. mnCoordinates(1,1)];
    r = [ROIs{1,i}.mnCoordinates(:,2); ROIs{1,i}.mnCoordinates(1,2)];
    %ROI�̈ʒu����mask�쐬
    M = poly2mask(c,r,img_sz1, img_sz2);
    %�SROI��1��mask�ɂ�������
    BWall = BWall | M;
    %�X�� mask �� matrix
    nBW(:,:,i) = M;
    %plot(c,r,'white', 'LineWidth',1);
end
hold off;
% chekc
%figure; imshow(BWall);

if ischar(val)
    x1 = cvsread(val);
else
    x1 = val;
end
x1_ch = x1;
%x1 �� val_min �� val_max �ŋ�؂��Đ��K��
x1_ch(x1_ch < val_min) = val_min;
x1_ch(x1_ch > val_max) = val_max;
%x1_ch = (x1_ch - val_min)/val_max;%0-1:
x1_ch = (x1_ch - val_min)/(val_max-val_min);%0-1:

img2 = zeros(img_sz1, img_sz2);
for i = 1: nROIs
    img2(nBW(:,:,i)) = x1_ch(i);
end



%figure;imshow(img2);
img2 = gray2ind(img2,256);
figure;imshow(img2);
%map = colormap(hot(256));
caxis([val_min, val_max]);
caxis([0, 255]);

%%
img3 = ind2rgb(img2,map);
%figure;imshow(img3)
%RGB���ꂼ���mask��K��
img3R = img3(:,:,1);
img3G = img3(:,:,2);
img3B = img3(:,:,3);

%���Ƃ�grya�摜��RGB�ɕϊ�
img_d = gray2rgb(img);
img_R = img_d(:,:,1);
img_G = img_d(:,:,2);
img_B = img_d(:,:,3);
%�SROI�� BWall �ɂ���̂�
img_R(BWall) = img3R(BWall);
img_G(BWall) = img3G(BWall);
img_B(BWall) = img3B(BWall);

img3(:,:,1) = img_R;
img3(:,:,2) = img_G;
img3(:,:,3) = img_B;

figure; imshow(img3);

%save image
[fname,dirname] = uiputfile('*.png');
if fname ~= 0
    imwrite(img3, [dirname, fname],'png');
end
%}
end

function [Image]=gray2rgb(Image)
%Gives a grayscale image an extra dimension
%in order to use color within it
[m n]=size(Image);
rgb=zeros(m,n,3);
rgb(:,:,1)=Image;
rgb(:,:,2)=rgb(:,:,1);
rgb(:,:,3)=rgb(:,:,1);
Image=rgb/255;
end






