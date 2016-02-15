function [ROIs,img2]=ColorizeCellType3(img_path, roi_path, val, val_min, val_max,map, Type1, Type2, Type3)
%{
imageJ �쐬����ROI�� Matlab �ɓǂݍ���ł���
�eROI�� parametor �����Ƃ�color map ���g���ĐF�t������
a = 'STD_SC21.png';
b = 'SC21RoiSet.zip';
map = colormap(hot(256));
map = colormap(jet(512));
[ROIs,img2] = ColorizeCellType2(a,b,peak,0.05, 0.2, map,SR,GFP,OGB);

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


if ischar(val)% if val is path of the data file.
    val = cvsread(val);
end

%ROI data (ImageJ) �̓ǂݍ���
ROIs = ReadImageJROI(roi_path);
nROIs = size(ROIs,2);

%���摜�̓ǂݍ���(gray �摜�j
img = imread(img_path);
%figure; imshow(img);
img_sz1 = size(img,1);
img_sz2 = size(img,2);

%ROI�̈ʒu���i�[�p
c = cell(nROIs,1);
r = cell(nROIs,1);
%temporally  mask
M = false(img_sz1,img_sz2,nROIs);%Mask

for i = 1:nROIs
    %ROI�̈ʒu���̎擾�C�n�_�ƏI�_����Ă���
    c{i} = [ROIs{1,i}.mnCoordinates(:,1); ROIs{1,i}.mnCoordinates(1,1)];
    r{i} = [ROIs{1,i}.mnCoordinates(:,2); ROIs{1,i}.mnCoordinates(1,2)];
    %ROI�̈ʒu����mask�쐬
    M(:,:,i) = poly2mask(c{i},r{i},img_sz1, img_sz2);

end
%figure; imshow(BWall);
%�X�� mask �� matrix

input_name = input('Input IMG File name... :: ','s');
for i2 = 1:size(val,2); % if val contains data from several stim-params, multiple images is made in every parmetors.
    tic;
    x1_ch = val(:,i2);
    %x1 �� val_min �� val_max �ŋ�؂��Đ��K��
    x1_ch(x1_ch < val_min) = val_min;
    x1_ch(x1_ch > val_max) = val_max;
    x1_ch = (x1_ch-val_min)/(val_max-val_min);
    
    %mask ���珜�O���� ROI �� index 
    %������ val_min �ȉ���ROI�� mask ����O����
    ROI_lowest = (find(x1_ch == 0))';
    %SR�����O
    ROI_rm = union(ROI_lowest,SR);
    %nBW = M(:,:,setdiff(1:nROIs,ROI_rm));
    
    img2 = zeros(img_sz1, img_sz2);

    BWall = false(img_sz1,img_sz2);
    for i = setdiff(1:nROIs,ROI_rm)
        img2(M(:,:,i)) = x1_ch(i);
        BWall = BWall | M(:,:,i);
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
        hold on
        if ismember(i, SR)
            col = 'w';
        elseif ismember(i, GFP)
            col = 'c';
        elseif ismember(i, EX)
            col = 'm';
        elseif ismember(i, ALL);
            col = 'w';
        end
        plot(c{i},r{i},'white', 'LineWidth',1, 'color', col);
    end
    hold off;
    
    
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
end%End of the main function

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