function dir_map
%% %%%%%%%%test
%���_130906_depth1
%cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/130906WT/depth1');
%���_140625_SC
cd('/Volumes/SDCZ64G/training');
% 9x9
mat = csvread('SC6_peak.csv');
l = size(mat,1);
SR = 1:57;
GFP = 58:116;
OGB = 117:l;
%intersect
NEU = [GFP,OGB];
roi_path = 'SC6RoiSet.zip';

% Preffered Direction �� ���o
PD = zeros(size(mat,1),4); %[max value, pref direction, null direction, DSI]
[PD(:,1),PD(:,2)] = max(mat,[],2);

PD(PD(:,2)<5,3) = PD(PD(:,2)<5,2) + 4;
PD(PD(:,2)>=5,3) = PD(PD(:,2)>=5,2) - 4;

%max �� threshold ���� ���������̂��͂���
NEU = intersect(NEU, find(PD(:,1)>=0.15));

ang = linspace(0,7*pi/4,8);
for i = 1:size(mat,1)
    % DSI �̌v�Z 1- (non-pref/pref)
    PD(i,4) = 1 - ( mat(i,PD(i,3))/mat(i,PD(i,2)));
    
    % OSI �̌v�Z vector averaging:
    PD(i,5) = sqrt(sum(mat(i,:).*sin(2*ang))^2 + sum(mat(i,:).*cos(2*ang))^2)/sum(mat(i,:));
end

% OSI �̌v�Z vector averaging:



h = hist(PD(NEU,2),1:8);

%colormap �p�̍s����쐬(HSV���)
col_deg = linspace(0,1,9);
col_hsv = zeros(256,3);
col_hsv(:,2) = (linspace(0,1,256));
col_hsv(:,3) = 1;

img_sz1 = 320;
img_sz2 = 320;

ROIs = ReadImageJROI(roi_path);
%img2 = zeros(img_sz1,img_sz2);

nROIs = size(ROIs,2);
BWall = false(img_sz1,img_sz2);
nBW = false(img_sz1, img_sz2,nROIs);

for i = 1:nROIs
    %ROI�̈ʒu���̎擾�C�n�_�ƏI�_����Ă���
    c = [ROIs{1,i}.mnCoordinates(:,1); ROIs{1,i}.mnCoordinates(1,1)];
    r = [ROIs{1,i}.mnCoordinates(:,2); ROIs{1,i}.mnCoordinates(1,2)];
    %ROI�̈ʒu����mask�쐬
    M = poly2mask(c,r,img_sz1, img_sz2);
    %�SROI��1��mask�ɂ�������
    BWall = BWall | M;
    %�X�� mask �� matrix
    nBW(:,:,i) = M;
    %plot(c,r,'white', 'LineWidth',1);
end
%imshow(BWall);
% pref direction ���Ƃ�

img_rgb_8set = cell(1,8);

%�w�i�摜�i�����p�j�̍��摜
img3 = zeros(img_sz1,img_sz2,3);
img3R = img3(:,:,1);
img3G = img3R;
img3B = img3R;

ROI = intersect(NEU, find(PD(:,1)>=0.1));
%%
for n = 1:8
    BWpart = false(img_sz1,img_sz2);
    img2 = zeros(img_sz1,img_sz2);
    for n2 = intersect(ROI, find(PD(:,2) == n))';
        img2(nBW(:,:,n2)) = PD(n2,4);%/max(PD(NEU,4)); % mask ������ DSI �̒l������
        %img2(nBW(:,:,n2)) = 1;
        % pref direction ���Ƃ� mask �ɂ܂Ƃ߂�
        BWpart = BWpart | nBW(:,:,n2);
    end
    %img2_8set(:,:,n) = img2;
    col_hsv(:,1) = col_deg(n);%�F���̒l�����߂�
    col_rgb = hsv2rgb(col_hsv);%hsv �� rgb �ɕϊ�
    map = colormap(col_rgb); %RGB colormap �ɓ����
    img2 = gray2ind(img2,256); % DSI �̒l�ɂ�� gray �l�� 256�ɕ���
    img_rgb_8set{1,n} = ind2rgb(img2,map); % map �ɏ]���� RGB�@�s����
    
    %RGB ���Ƃ� mask ��K�����Đ؂�o���D
    imgR = img_rgb_8set{1,n}(:,:,1);
    imgG = img_rgb_8set{1,n}(:,:,2);
    imgB = img_rgb_8set{1,n}(:,:,3);
    
    %�����摜�� ROI ������ DSI �̉����F�摜�ɒu������
    img3R(BWpart) = imgR(BWpart);
    img3G(BWpart) = imgG(BWpart);
    img3B(BWpart) = imgB(BWpart);
    
    %output�p img3 (R,G,B) �ɑ��
    img3(:,:,1) = img3R;
    img3(:,:,2) = img3G;
    img3(:,:,3) = img3B;
    
end
figure;
imshow(img3)

%figure;
%hist(PD(NEU,4),30)
%%




