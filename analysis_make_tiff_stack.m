%make stack-tiff-label

%9x9 retinotopy
cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/130906WT/depth1');
sc4 = tiffread3;
sc4_0 = mean(sc4(:,:,1:18),3);
sc4_dff = zeros(320,320,736);
for n = 1:736
    sc4_dff(:,:,n) = (sc4(:,:,n)-sc4_0)./sc4_0;
end
stimONframe = csvread('SC4_stimON_frame.csv');

sc4_dff_label = sc4_dff;
for n = 1:81
    sc4_dff_label(1:25,1:25,stimONframe(n,1):stimONframe(n,2)) = 1;
end

outputFileName = 'SC4_reg_dFF_label.tif';
for K=1:length(sc4_dff_label(1, 1, :))
    imwrite(sc4_dff_label(:, :, K), outputFileName, 'WriteMode', 'append');
end
%%
%StimSize
cd('/Users/lattice/Desktop/NoneButAir_KASAI_MacTest/Analysis2/130909WT/depth5');
sc23 = tiffread3;
sc23_0 = mean(sc23(:,:,1:49),3);
sc23_dff = zeros(320,320,1000);

for n = 1:1000
    sc23_dff(:,:,n) = (sc23(:,:,n)-sc23_0)./sc23_0;
end
stimONframe = csvread('SC23_stimON_frame.csv');
stim =[11	225	22	67	112	112	225	67	22	11	112	22	225	11	67	22	67	112	11	225	22	67	225	112	11	225	11	112	22	67	22	11	112	225	67	225	22	67	112];
stim_unique = unique(stim);

%{
sc23_dff_label = sc23_dff;
for n = 1:length(stimONframe)
    sc23_dff_label(1:50,1:50,stimONframe(n,1):stimONframe(n,2)) = 1;
end
%}

label1 = imread('deg05-1.tif');
label1_ch = double(label1/255);
label2 = imread('deg1-1.tif');
label2_ch = label2/255;
label3 = imread('deg3-1.tif');
label3_ch = label3/255;
label4 = imread('deg5-1.tif');
label4_ch = label4/255;
label5 = imread('deg10-1.tif');
label5_ch = label5/255;

sc23_dff_label2 = sc23_dff;
for n = 1:length(stimONframe)
    if stim(n) == stim_unique(1)
        X = 1;
    elseif stim(n) == stim_unique(2)
        X = 2;
    elseif stim(n) == stim_unique(3)
        X = 3;
    elseif stim(n) == stim_unique(4)
        X = 4;
    elseif stim(n) == stim_unique(5)
        X = 5;
    end
    sc23_dff_label2(5:10,1:64*X,stimONframe(n,1):stimONframe(n,2)) = 1;
end

sc23_dff_label3 = sc23_dff_label2;
for n = 1:length(stimONframe)
    if stim(n) == stim_unique(1)
        X = label1_ch;
    elseif stim(n) == stim_unique(2)
        X = label2_ch;
    elseif stim(n) == stim_unique(3)
        X = label3_ch;
    elseif stim(n) == stim_unique(4)
        X = label4_ch;
    elseif stim(n) == stim_unique(5)
        X = label5_ch;
    end
    for m = stimONframe(n,1):stimONframe(n,2)
        sc23_dff_label3(11:60,1:100,m) = X;
    end
end

outputFileName = 'SC23_reg_dFF_label3.tif';
for K=1:length(sc23_dff_label3(1, 1, :))
    imwrite(sc23_dff_label3(:, :, K), outputFileName, 'WriteMode', 'append');
end