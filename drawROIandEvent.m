function y2  = drawROIandEvent(FVt, dFF, selectROI,color,stim)
%%% plot ROI and Event %%%

% èáî‘Ç…Ç∏ÇÁÇµÇƒï\é¶Ç∑ÇÈ
y = dFF(:,selectROI);
for n = 1:length(selectROI);
y(:,n) = y(:,n)+(0.07*(n-1));
end

ymax = max(max(y));
ymin = min(min(y));

figure;
if color == 1
y2 = plotEvent([ymin ymax ymax ymin]);
else
    y2 = plotEvent_color([ymin ymax ymax ymin], stim);
end
hold on;


plot(FVt,y);

ylabel('dF/F0');
hold off;

ylim([ymin ymax]);
