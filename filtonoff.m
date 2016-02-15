%%% filtonoff


if get(ui_filtselect,'value') == 1
    Type = 'high';
    cutf = cutf_high;
    N = OrderN;
elseif get(ui_filtselect,'value') == 2
    Type = 'low';
    cutf = cutf_low;
    N = OrderN;
elseif get(ui_filtselect,'value') == 3 % band-pass
    Type = 'bandpass';
    cutf= [cutf_low,cutf_high];
    N = OrderN/2;
elseif get(ui_filtselect,'value') == 4
    Type = 'stop';
    cutf= [cutf_low,cutf_high];
    N = OrderN/2;
end
[Bfilt b a] = filtbutter(N, cutf, Type,fs,Bv);

if get(ui_butter,'value') == 1
    B = Bfilt;
else
    B = Bv;
end

plotdata;




