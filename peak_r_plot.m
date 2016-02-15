peak_1 = zeros(length(peak1),1);
peak_2 = peak_1;
for n=1:length(peak1)
    test1 = find(peak1(n,:) > 0.05 & peak1(n,:)==max(peak1(n,:)));
    if isempty(test1)
        peak_1(n) =0;
    else
        peak_1(n) = test1;
    end
    
    test2 = find(peak2(n,:) > 0.05 & peak2(n,:)==max(peak2(n,:)));
    if isempty(test2)
        peak_2(n) =0;
    else
        peak_2(n) = test2;
    end
end

%%%


figure;
scatter(peak_1(GFP),ROI_Polar(GFP,2),'ob');
hold on
scatter(peak_1(OGB),ROI_Polar(OGB,2),'or');
figure;
scatter(peak_2(GFP),ROI_Polar(GFP,2),'ob');
hold on
scatter(peak_2(OGB),ROI_Polar(OGB,2),'or');

%%%%%%%%%%%%%
%%%%%%%%%%%%%つかわない %%%%%%%%%%
%130208
%depth1
%SC3
GFP = [6 30:32 42 61:126 149 151 155 157 168 169 181];
OGB = [33 127:147 152 164 167 180];
SR =  [1:5, 7:12, 14:20, 22:29, 34:41, 43:52, 54:60,182];
%SC5
GFP = [6 31 32 42 61:125 149 151 156 157 160 161 168 169 174:176 178 182 191 193:195];
OGB = [126:147 150 152 159 163 164 166 170:172 185 187];
SR = [1:5 7:12 14:20 22:29 34:41 43:52 54:60 183 190];
%depth2
%SC7
%GFP = [17 51:119 138 141 150 151 165:167 170 172 174];
GFP = [17 51:60 62:89 91:119 138 141 150 151 165:167 170 172 174];
OGB = [12 120:136:142 143 146 156:159 171];
SR = [1:11, 13:16, 18:21, 23:25, 28:47, 49,50];

%depth3
%SC15
GFP = [44:110 143 144 146:150 152 154:161 169:170 172 178 180 181 183];
OGB = [111:142 145 151 162 165:167 171 173 175 176 179 182 185 186];
SR = [1:26 28 30:32 34:39 41:43];

%depth4
%SC21
GFP=[30:117 153 154 156:159 161:163 167 169 172:182 187:188 195:197 200];
OGB = [118:152 166 168 183:186 190:194 198 199];
SR = [1:22, 24,25, 27:29, 189];

%depth5
%SC23, 24
GFP = [44:130 164 169 171 175 178 179 182 186 188 190 192 196 198 199 202 205 206 209 210 212];
OGB = [131:160 166:168 170 172 174 180 181 183:185 187 191 193 197 200 207 211 213 214 217 220 223 224];
SR = [1:43 204];
%depth6
%SC26
GFP = [59:150 194 195 197 198 202:205 209 211 213:215 218 219 221 230 234 238 240 243 244 249 252 253 257:260];
OGB = [151:185 188:192 201 207:208 210 216 222:224 229 233 235 236 239 241 245 246 254 261];
SR = [1:58 206];
%depth7
%SC28, (xRFcenter ,yRFcenter) = (434,179)
GFP = [33:108 113 115 126 128 131 138 141 143:145 150 152 154 156 159 163:164 167:168 170];
OGB = [109:112 114 116 118:125 127 129:130 132:137 139 140 142 146:148 151 153 155 157 160 162 165 166];
SR = [1:26 28:32 158];

%SC29
GFP= [5 6 8 10 11 13 14 16 23 25:28 32 34:37 39:42 47 48 50 52 55 56 58 62 63 65 67 68 71 72 73 75 78 80 81 88 89 93:97 99 101];
OGB = [1:4 15 17:20 24 31 33 43 46 49 53 54 60 61 66 69 70 74 77 79 82 83 85 87 92 98 100];
%SC30
GFP = [10:14 16:26 28:30 32:36 41 42 50:52 54:56 58:60 62:64];
OGB = [37:40 43:49 53 57 61];

Peak1 = peak1';
m = max(Peak1);
Peak2 = peak2';
m2 = max(Peak2);
for n = 1:length(Peak1)
    nPeak1(:,n) = Peak1(:,n)/m(n);
    nPeak2(:,n) = Peak2(:,n)/m2(n);
end

figure;
plot(nPeak1(:,GFP),'-ob');
hold on
plot(nPeak1(:,OGB),'-or');
hold off

figure
plot(Peak1(:,GFP),'-ob');
hold on
plot(Peak1(:,OGB), '-or');
hold off

figure;
plot(Peak2(:,GFP), '-ob');
hold on
plot(Peak2(:,OGB), '-or');

figure;
plot(nPeak2(:,GFP), '-ob');
hold on
plot(nPeak2(:,OGB), '-or');

%-------------peak stim size で 色分けすると？
figure;
plot(nPeak1(:, intersect(GFP, find(peak_1==1))), '-or')
hold on
plot(nPeak1(:, intersect(GFP, find(peak_1==2))), '-oy');
plot(nPeak1(:, intersect(GFP, find(peak_1==3))), '-og');
plot(nPeak1(:, intersect(GFP, find(peak_1==4))), '-ob');
plot(nPeak1(:, intersect(GFP, find(peak_1==5))), '-oc');

figure;
plot(Peak1(:, intersect(GFP, find(peak_1==1))), '-or')
hold on
plot(Peak1(:, intersect(GFP, find(peak_1==2))), '-oy');
plot(Peak1(:, intersect(GFP, find(peak_1==3))), '-og');
plot(Peak1(:, intersect(GFP, find(peak_1==4))), '-ob');
plot(Peak1(:, intersect(GFP, find(peak_1==5))), '-oc');

figure;
plot(nPeak2(:, intersect(GFP, find(peak_2==1))), '-or')
hold on
plot(nPeak2(:, intersect(GFP, find(peak_2==2))), '-oy');
plot(nPeak2(:, intersect(GFP, find(peak_2==3))), '-og');
plot(nPeak2(:, intersect(GFP, find(peak_2==4))), '-ob');
plot(nPeak2(:, intersect(GFP, find(peak_2==5))), '-oc');

figure;
plot(Peak2(:, intersect(GFP, find(peak_2==1))), '-or')
hold on
plot(Peak2(:, intersect(GFP, find(peak_2==2))), '-oy');
plot(Peak2(:, intersect(GFP, find(peak_2==3))), '-og');
plot(Peak2(:, intersect(GFP, find(peak_2==4))), '-ob');
plot(Peak2(:, intersect(GFP, find(peak_2==5))), '-oc');


figure;
plot(nPeak1(:, peak_1==1), '-or');
hold on
plot(nPeak1(:, peak_1==2), '-oy');
plot(nPeak1(:, peak_1==3), '-og');
plot(nPeak1(:, peak_1==4), '-ob');
plot(nPeak1(:, peak_1==5), '-oc');

figure;
plot(stim_size, nPeak1(:, peak_1==1), '-or');
hold on
plot(stim_size, nPeak1(:, peak_1==2), '-oy');
plot(stim_size, nPeak1(:, peak_1==3), '-og');
plot(stim_size, nPeak1(:, peak_1==4), '-ob');
plot(stim_size, nPeak1(:, peak_1==5), '-oc');

figure;
plot(nPeak2(:, peak_2==1), '-or');
hold on
plot(nPeak2(:, peak_2==2), '-oy');
plot(nPeak2(:, peak_2==3), '-og');
plot(nPeak2(:, peak_2==4), '-ob');
plot(nPeak2(:, peak_2==5), '-oc');

figure;
plot(Peak2(:, peak_2==1), '-or');
hold on
plot(Peak2(:, peak_2==2), '-oy');
plot(Peak2(:, peak_2==3), '-og');
plot(Peak2(:, peak_2==4), '-ob');
plot(Peak2(:, peak_2==5), '-oc');

stim_size = [0.5 1 3 5 10];
log_ss = log(stim_size);

figure;
plot(log_ss,Peak2(:, peak_2==1), '-or');
hold on
plot(log_ss,Peak2(:, peak_2==2), '-oy');
plot(log_ss,Peak2(:, peak_2==3), '-og');
plot(log_ss,Peak2(:, peak_2==4), '-ob');
plot(log_ss,Peak2(:, peak_2==5), '-oc');

figure;
plot(log_ss,nPeak2(:, peak_2==1), '-or');
hold on
plot(log_ss,nPeak2(:, peak_2==2), '-oy');
plot(log_ss,nPeak2(:, peak_2==3), '-og');
plot(log_ss,nPeak2(:, peak_2==4), '-ob');
plot(log_ss,nPeak2(:, peak_2==5), '-oc');

%%
for i = 1:5
    ROI_GFPmean1(i) = mean(ROI_Polar(GFP(peak1_max(GFP) == i),2));
    ROI_OGBmean1(i) = mean(ROI_Polar(OGB(peak1_max(OGB) == i),2));
    ROI_GFPmean2(i) = mean(ROI_Polar(GFP(peak2_max(GFP) == i),2));
    ROI_OGBmean2(i) = mean(ROI_Polar(OGB(peak2_max(OGB) == i),2));
end
figure;
scatter(peak1_max(GFP), ROI_Polar(GFP,2),'ob');
hold on
plot(1:5, ROI_GFPmean1, '-sb');
scatter(peak1_max(OGB)+0.2, ROI_Polar(OGB,2),'or');
plot((1:5)+0.2, ROI_OGBmean1,'-sr');

figure;
scatter(peak2_max(GFP), ROI_Polar(GFP,2),'ob');
hold on
plot(1:5, ROI_GFPmean2, '-sb');
scatter(peak2_max(OGB)+0.2, ROI_Polar(OGB,2),'or');
plot((1:5)+0.2, ROI_OGBmean2,'-sr');
%%
%{
for i = 1:5
    ROI_GFPmean1(i) = mean(ROI_Polar(GFP(peak1_min(GFP) == i),2));
    ROI_OGBmean1(i) = mean(ROI_Polar(OGB(peak1_min(OGB) == i),2));
    ROI_GFPmean2(i) = mean(ROI_Polar(GFP(peak2_min(GFP) == i),2));
    ROI_OGBmean2(i) = mean(ROI_Polar(OGB(peak2_min(OGB) == i),2));
end
figure;
scatter(peak1_min(GFP), ROI_Polar(GFP,2),'ob');
hold on
plot(1:5, ROI_GFPmean1, '-sb');
scatter(peak1_min(OGB)+0.2, ROI_Polar(OGB,2),'or');
plot((1:5)+0.2, ROI_OGBmean1,'-sr');

figure;
scatter(peak2_min(GFP), ROI_Polar(GFP,2),'ob');
hold on
plot(1:5, ROI_GFPmean2, '-sb');
scatter(peak2_min(OGB)+0.2, ROI_Polar(OGB,2),'or');
plot((1:5)+0.2, ROI_OGBmean2,'-sr');
%}

%% 最小の刺激と最大の刺激の応答の差を plot
%{
peak1 = csvread('***.csv');
peak2 = csvread('***.csv');
peak1_1 = peak1';
peak2_2 = peak2';
%}
for i = 2:4
    A1 = peak1_1(1,:) - peak1_1(i,:);
    A2 = peak2_2(1,:) - peak2_2(i,:);
    figure;scatter(ROI_Polar(:,2),A1,'bo'),hold on; scatter(ROI_Polar(:,2),A2,'ro');
    hold off
    xlim([0 300]), ylim([-0.3 0.3]);
end
%%
peak1_1 = x1';
peak2_2 = x2';
for i = 2:5
    A1 = peak1_1(1,:) - peak1_1(i,:);
    A2 = peak2_2(1,:) - peak2_2(i,:);
    figure;scatter(ROI_Polar(:,2),A1,'bo'),hold on; scatter(ROI_Polar(:,2),A2,'ro');
    hold off
    xlim([0 300]), ylim([-0.3 0.3]);
end

%%
peak1_1 = x1';
peak2_2 = x2';
for i = 2:5
    A1 = peak1_1(1,:) - peak1_1(i,:);
    A2 = peak2_2(1,:) - peak2_2(i,:);
    figure;
    scatter(ROI_Polar(:,2),A1,'bo')
    hold on;
    scatter(ROI_Polar2(:,2),A2,'ro');
    hold off
    xlim([0 300]), ylim([-0.3 0.3]);
end

%%
peak1_1 = x1';
peak2_2 = x2';
for i = 2:5
    A1GFP = peak1_1(1,GFP) - peak1_1(i,GFP);
    A1OGB = peak1_1(1,OGB) - peak1_1(i,OGB);
    A2GFP = peak2_2(1,GFP) - peak2_2(i,GFP);
    A2OGB = peak2_2(1,OGB) - peak2_2(i,OGB);
    
    figure; scatter(ROI_Polar(GFP,2), A1GFP, 'bo')
    hold on
    scatter(ROI_Polar(OGB,2), A1OGB, 'bx');
    scatter(ROI_Polar2(GFP,2), A2GFP,'ro');
    scatter(ROI_Polar2(OGB,2), A2OGB, 'rx');
    hold off
    xlim([0 300]), ylim([-0.3 0.3]);
end

%%
%個々の細胞から 応答の中心（重心）の座標を求める

cent(1,1) = sum(peak1_1(1,:)'.*ROI_Cart(:,1))/sum(peak1_1(1,:));
cent(2,1) = sum(peak1_1(1,:)'.*ROI_Cart(:,2))/sum(peak1_1(1,:));

