%% readheader %%

%%%%%%%%%% header%%%%%%%%
% headerのデータは，Bhead に行列で入っているので，n番目のトレースのheader は，Bhead(:,n)でアクセス
%{
Eheader = [recobj.rect;recobj.sampt;recobj.plot;recobj.cycleNum];%~4
PTBheader = [get(figUIobj.stim,'value');sobj.stimsz'; sobj.divnum; sobj.position;get(figUIobj.shape,'value');get(figUIobj.pattern,'value'); sobj.duration; sobj.stimcol; sobj.bgcol];% ~14
Delayheader = [recobj.tTTL2;sobj.tPTBon; sobj.tPTBoff; recobj.tRec];%~18
Gratheader =[sobj.shiftDir;angle; get(figUIobj.gratFreq,'value'); get(figUIobj.shiftSpd,'value')];%~"2
Flipheader = [sobj.vbl_1;sobj.OnsetTime_1;sobj.FlipTimeStamp_1];%~25
%}

fs = 10^6/Bhead(2,n);
if Bhead(3,n)==1
    ptype = 'V';
elseif Bhead(3,n)==2
    ptype = 'I';
end

cyclen =num2str(Bhead(4,n)); % cycle number

%PTBheader
if num2str(Bhead(5,n))==0
    stimflag = 'OFF';
else
    stimflag = 'ON';
end

if Bhead(38,n)==0
    monitor_dist = 300;
else
    monitor_dist = Bhead(38,n);
end

stimsz1X = round(Pix2Deg(Bhead(6,n),monitor_dist)*10)/10;
stimsz2X = round(Pix2Deg(Bhead(36,n),monitor_dist)*10)/10;
%stimszY = round(Pix2Deg(Bhead(7,n),monitor_dist)*10)/10;

divnum = [num2str(Bhead(8,n)), ' x ', num2str(Bhead(8,n))];

Stim2Pos = [num2str(Bhead(30,n)), ' & ', num2str(Bhead(31,n))];

if Bhead(11,n) == 9
    stimshape = 'Images';
else
    if Bhead(10,n) == 1
        stimshape = 'Rectangle';
    elseif Bhead(10,n) == 2
        stimshape = 'Circle';
    end
end

if Bhead(11,n) == 1
    stimpattern = 'Uni';
elseif Bhead(11,n) == 2
    stimpattern = 'BW';
elseif Bhead(11,n) == 3
    stimpattern = 'Sin';
elseif Bhead(11,n) == 4
    stimpattern = 'Rect';
elseif Bhead(11,n) == 5
    stimpattern = 'Gabor';
elseif Bhead(11,n) == 6
    stimpattern = 'SizeRand';
elseif Bhead(11,n) == 7
    stimpattern = 'Zoom';
elseif Bhead(11,n) == 8
    stimpattern = '2stim+lag';
elseif Bhead(11,n) == 9
    stimpattern = 'ImagesRand';
end
%flash_correct = Bhead(16,n)+(Bhead(24,n)+Bhead(26,n))/2/1024/75;
flash_correct = Bhead(16,n)+Bhead(24,n)/1024/75;
%{
HeaderList = {'Recording Time (ms)';'Sampling Time (us)';'PlotType';'Cycle#';...%~4
    'StimON/OFF';'Stim1_sizeX(pix)';'Stim2_sizeX(pix)';'Monitor Divide';'Stim_Position';...%~9
    'Stim_Shape';'Stim_Pattern';'Stim_Duration';'Stim_Color';'BG_Color';...%~14
    'Shift_Direction';'Shift_Angle';'Grating_Freq';'Shift_Speed';...%~18
    'Dealy TTL2(sec)';'Delay PTBon (sec)';'Calc Delay PTBon';'Elapsed Time (sec)';};
%}
HeadTable = {Bhead(1,n);...%RecTime
    Bhead(2,n);...%SampTime
    ptype;...%PlotType
    Bhead(4,n);...%Cycle#
    Bhead(5,n);...%StimON/OFF
    stimsz1X;...%StimSize (Degree)
    stimsz2X;...
    divnum;...
    Bhead(9,n);...%Stim1Position
    Stim2Pos;... %Stim2Position(shift and dist)
    stimpattern;...
    Bhead(17,n)-Bhead(16,n);...%Stim Duration
    Bhead(13,n);...%StimColor
    Bhead(14,n);...%BGColor
    Bhead(19,n);...%Stim_Shift_Direction
    Bhead(20,n);...%Stim_Sfhit_Angle
    Bhead(21,n);...%Stim_Grating_Freq
    Bhead(22,n);...%Stim_Shift_Speed
    Bhead(15,n);...%Delay TTL2
    Bhead(16,n);...%Delay PTOBon
    flash_correct;...%Calculated Delay PTBon
    %Bhead(18,n)...%Elapsed Time(sec)
    Bhead(18,n) + flash_correct;...
    Bhead(40,n)...%Images_#.tif
    };
