%%% detrend dFF %%%
if get(ui_detrend,'value') == 1
    dFF = dFFdet;
else
    if get(ui_filtdFF, 'value') == 1
        dFF = dFFfilt;
    else
        dFF = dFFraw;
    end
end;
plotROI;

