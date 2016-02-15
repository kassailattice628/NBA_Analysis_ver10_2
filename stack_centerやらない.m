function out = stack_center(stack,slices)
% calculate mean center of intensity from stacked image
% 'stack' is the staked image
% 'slices' is a vector of selected slice numbers.
%
%
% for i = 1:length(range), range2 = [range2,(range(i)+2:range(i)+8)];end
%
%

center = zeros(length(slices),2);
%mask
bw = true(size(stack,1),size(stack,2));
s = regionprops(bw, 'PixelIdxList','PixelList');
idx = s.PixelIdxList;
x = s.PixelList(:,1);
y = s.PixelList(:,2);

figure;imagesc(stack(:,:,5));colormap(gray);hold on;

for j=1:length(slices)
    I = stack(:,:,slices(j));
    %I = I + min(min(I));%intensity Ç™Å@ïâÇ…Ç»ÇÁÇ»Ç¢ÇÊÇ§Ç…íÍè„Ç∞í≤êÆ
    sum_region = sum(I(idx));
    center(j,1) = sum(x .* I(idx) /sum_region);
    center(j,2) = sum(y .* I(idx) /sum_region);
    %figure;imagesc(I);colormap(gray),hold on
    plot(center(j,1),center(j,2), 'r*');
end
out = mean(center);
plot(out(1),out(2), 'b*');
hold off;

%% test
%{
figure;imshow(I);hold on;
for j=1:length(slices)
    I = stack(:,:,slices(j));
    I = I + min(min(I));
    sum_region = sum(I(idx));
    center(j,1) = sum(x .* I(idx) /sum_region);
    center(j,2) = sum(y .* I(idx) /sum_region);
    %figure;imagesc(I);colormap(gray),hold on
    plot(center(j,1),center(j,2), 'r*');
end
out = mean(center);
plot(out(1),out(2), 'b*');
hold off;

%}