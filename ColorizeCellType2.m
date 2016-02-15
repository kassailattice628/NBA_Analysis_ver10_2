function [ROIs,img2]=ColorizeCellType2(img_path, roi_path, val, val_min, val_max,map, Type1, Type2, Type3)
%{
imageJ �쐬����ROI�� Matlab �ɓǂݍ���ł���
�eROI�� parametor �����Ƃ�color map ���g���ĐF�t������
a = 'STD_SC21.png';
b = 'SC21RoiSet.zip';
map = colormap(hot(256));
map = colormap(jet(512));
[ROIs,img2] = ColorizeCellType(a,b,x1(:,1), 0.05, 0.2, map,SR,GFP,OGB);
[ROIs,img2] = ColorizeCellType(a,b,peak(:,1), 0.05, 0.2, map,[1:313]);
[ROIs] = ColorizeCellType(a,b,x1(:,1), 0.05, 0.2, map,SR,GFP,OGB);
[ROIs,img2] = ColorizeCellType(a,b,diff2(:,1), -0.3, 0.3, map_kbcwyr, [1:239]);
%}
ALL =[];
SR = [];
GFP = [];
EX = [];
if nargin == 7
    ALL = Type1;
elseif nargin == 8
    SR = Type1;
    ALL = Type2;
elseif nargin == 9
    SR = Type1;
    GFP = Type2;
    EX = Type3;
    ALL = [];
end
%ROI data (ImageJ) �̓ǂݍ���
ROIs = ReadImageJROI(roi_path);
nROIs = size(ROIs,2);

%���摜�̓ǂݍ���(gray �摜�j
img = imread(img_path);
%figure; imshow(img);
img_sz1 = size(img,1);
img_sz2 = size(img,2);
BWall = false(img_sz1,img_sz2);
nBW = false(img_sz1, img_sz2,nROIs);

if ischar(val)% if val is path of the data file.
    val = cvsread(val);
end

input_name = input('Input IMG File name... :: ','s');

fig = figure('position', [1, 400, 1000, 330]);
for i2 = 1:size(val,2); % if val contains data from several stim-params, multiple images is made in every parmetors.
    tic;
    x1_ch = val(:,i2);
    %x1 �� val_min �� val_max �ŋ�؂��Đ��K��
    x1_ch(x1_ch < val_min) = val_min;
    x1_ch(x1_ch > val_max) = val_max;
    x1_ch = (x1_ch-val_min)/(val_max-val_min);
    %������ val_min �ȉ���ROI�� mask ����O����
    ROI_lowest = find(x1_ch == 0);
    
    %for i = 1:nROIs
    for i = setdiff(1:nROIs,SR)
        %ROI�̈ʒu���̎擾�C�n�_�ƏI�_����Ă���
        c = [ROIs{1,i}.mnCoordinates(:,1); ROIs{1,i}.mnCoordinates(1,1)];
        r = [ROIs{1,i}.mnCoordinates(:,2); ROIs{1,i}.mnCoordinates(1,2)];
        %ROI�̈ʒu����mask�쐬
        M = poly2mask(c,r,img_sz1, img_sz2);
        %�SROI��1��mask�ɂ�������
        if ismember(i, SR)% SR �z���� mask ����͂���
            %elseif ismember(i,GFP)
            %elseif ismember(i,ROI_lowest)
        elseif nargin == 8 && ismember(i,ALL)
            BWall = BWall | M;
        elseif nargin == 9
            BWall = BWall | M;
        end
        %�X�� mask �� matrix
        nBW(:,:,i) = M;
    end
    % chekc
    %figure; imshow(BWall);
    
    img2 = zeros(img_sz1, img_sz2);
    for i = 1: nROIs
        img2(nBW(:,:,i)) = x1_ch(i);
    end
    
    img2 = gray2ind(img2,256);
    %img2 = gray2ind(img2,size(map,2));
    
    %{
figure;imshow(img2);
%map = colormap(hot(256));
%%caxis([val_min, val_max]);
%%caxis([0, 255]);
for i = 1:nROIs
    hold on;
    c = [ROIs{1,i}.mnCoordinates(:,1); ROIs{1,i}.mnCoordinates(1,1)];
    r = [ROIs{1,i}.mnCoordinates(:,2); ROIs{1,i}.mnCoordinates(1,2)];
    if ismember(i, SR)
        col = 'w';
    elseif ismember(i, GFP)
        col = 'c';
    elseif ismember(i, EX)
        col = 'm';
    elseif ismember(i, ALL);
        col = 'w';
    end
    plot(c,r,'white', 'LineWidth',1, 'color', col);
end
hold off;
    %}
    
    %%
    img3 = ind2rgb(img2,map);
    %figure;imshow(img3)
    %RGB���ꂼ���mask��K��
    img3R = img3(:,:,1);
    img3G = img3(:,:,2);
    img3B = img3(:,:,3);
    
    %���Ƃ� gray �摜��RGB�ɕϊ�
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
    
    %figure; imshow(img3);
    
    for i = 1:nROIs
        hold on;
        c = [ROIs{1,i}.mnCoordinates(:,1); ROIs{1,i}.mnCoordinates(1,1)];
        r = [ROIs{1,i}.mnCoordinates(:,2); ROIs{1,i}.mnCoordinates(1,2)];
        if ismember(i, SR)
            col = 'w';
        elseif ismember(i, GFP)
            col = 'c';
        elseif ismember(i, EX)
            col = 'm';
        elseif ismember(i, ALL);
            col = 'w';
        else
            col = 'k';
        end
        plot(c,r,'white', 'LineWidth',1, 'color', col);
    end
    hold off;
    %{
    %�摜���ׂĕ\��
    figure(fig);
    subplot(1,size(val,2),i2);
    imshow(img3,'border','tight');
    axis off
    %}
    %save image
    %{
    [fname,dirname] = uiputfile('*.png');
    if fname ~= 0
        imwrite(img3, [dirname, fname],'png');
    end
    %}
    imwrite(img3, [input_name,num2str(i2),'.png'],'png');
    toc;
end

dirOutput = dir(fullfile([input_name,'*.png']));
fileNames = {dirOutput.name}';
mont = montage(fileNames, 'Size', [1,size(val,2)]);
%saveas(mont,'mont.png','png');

end%End of main function


%%
function [Image]=gray2rgb(Image)
%Gives a grayscale image an extra dimension
%in order to use color within it
[m,n]=size(Image);
rgb=zeros(m,n,3);
rgb(:,:,1)=Image;
rgb(:,:,2)=rgb(:,:,1);
rgb(:,:,3)=rgb(:,:,1);
Image=rgb/255;
end