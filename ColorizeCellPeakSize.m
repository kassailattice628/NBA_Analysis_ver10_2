function [ROIs,img2]=ColorizeCellPeakSize(img_path, roi_path,val,roi1,roi2,roi3,roi4,roi5,SR,map)
%{
imageJ �쐬����ROI�� Matlab �ɓǂݍ���ł���
�eROI�� parametor �����Ƃ�color map ���g���ĐF�t������
a = 'AVG_SC7.png';
b = 'SC7RoiSet_match.zip';
[ROIs] = ColorizeCellPeakSize(a,b,i7,i7_1n,i7_2n,i7_3n,i7_4n,i7_5n,SR,map);
%}
%���摜�̓ǂݍ���(gray �摜�j
img = imread(img_path);
%figure; imshow(img);
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
    if ismember(i,SR)
    else%�SROI��1��mask�ɂ�������
    BWall = BWall | M;
    end
    %�X�� mask �� matrix
    nBW(:,:,i) = M;
end

img2 = zeros(img_sz1, img_sz2);
for i = [roi1,roi2,roi3,roi4,roi5]
    img2(nBW(:,:,i)) = val(i)+1;
end
img2 = gray2ind(img2,7);
figure;imshow(img2);
caxis([0,7]);
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

end

function [Image]=gray2rgb(Image)
%Gives a grayscale image an extra dimension
%in order to use color within it
[m, n]=size(Image);
rgb=zeros(m,n,3);
rgb(:,:,1)=Image;
rgb(:,:,2)=rgb(:,:,1);
rgb(:,:,3)=rgb(:,:,1);
Image=rgb/255;
end






