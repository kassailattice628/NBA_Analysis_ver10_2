function [ROIs,img2]=ColorizeROI(img_path, roi_path, val, val_min, val_max,map)
%{
imageJ 作成したROIを Matlab に読み込んでから
各ROIの parametor をもとにcolor map を使って色付けする
a = 'AVG_sc23_9x9Pos31_Szr_reg.tif';
b = 'SC23RoiSet.zip';
map = colormap(hot(256));
[ROIs,img2] = ColorizeROI(a,b,x1(:,1), 0.05, 0.2, map);
%}

%元画像の読み込み(gray 画像）
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
    %ROIの位置情報の取得，始点と終点を閉じておく
    c = [ROIs{1,i}.mnCoordinates(:,1); ROIs{1,i}. mnCoordinates(1,1)];
    r = [ROIs{1,i}.mnCoordinates(:,2); ROIs{1,i}.mnCoordinates(1,2)];
    %ROIの位置からmask作成
    M = poly2mask(c,r,img_sz1, img_sz2);
    %全ROIを1つのmaskにしたもの
    BWall = BWall | M;
    %個々の mask の matrix
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
%x1 を val_min と val_max で区切って正規化
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
%RGBそれぞれにmaskを適応
img3R = img3(:,:,1);
img3G = img3(:,:,2);
img3B = img3(:,:,3);

%もとのgrya画像をRGBに変換
img_d = gray2rgb(img);
img_R = img_d(:,:,1);
img_G = img_d(:,:,2);
img_B = img_d(:,:,3);
%全ROIは BWall にあるので
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






