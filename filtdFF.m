%%% filt dFF %%%
% dFF = dFFraw or dFFdet
[dFFfilt b2 a2] = filtbutter(2, Cut_dFF, 'high',1/FVsampt, dFF);

if get(ui_filtdFF, 'value') == 1
        dFF = dFFfilt;
else
    if get(ui_detrend,'value') == 1
        dFF = dFFdet;
    else
        dFF = dFFraw;
    end
end
plotROI;
    