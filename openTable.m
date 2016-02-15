%%% open table %%%

HeaderList = {'Recording Time (ms)';...
    'Sampling Time (us)';...
    'PlotType';'Cycle#';...
    'StimON/OFF';...
    'Stim_Sz1(pix)';...
    'Stim_Sz2(pix)';...
    'Monitor Divide';...
    'Stim1_Pos';...
    'Stim2_Pos(dist&ang)';...
    'Stim_Pattern';...
    'Stim_Duration';...
    'Stim_Color';...
    'BG_Color';...
    'Direction';...
    'Shift_Angle';...
    'Grating_Freq';...
    'Shift_Speed';...
    'Dealy TTL2(sec)';...
    'Delay PTBon (sec)';...
    'Correct Delay PTBon';...
    'Elapsed PTBon (sec)';...
    'Images_#';};

TableLeft = 1150;%1150

uiT = uitable('Data',HeadTable,'ColumnName','Param.s','ColumnWidth',{70},'RowName',HeaderList,'position',[TableLeft 350 270 450]);
%%%%%%%%

ui_plotEvent = uicontrol('string','Plot Event', 'position',[TableLeft 320 100 25], 'fontsize',10,'callback','subplot(subEvent); if get(ui_event_color,''value'') ==1; stimON = plotEvent([0 1 1 0]); else stimON = plotEvent_color([0 1 1 0], stim_color); end');

ui_stim_color = uicontrol('style','edit','string',stim_color,'fontsize',10,'position',[TableLeft+105 320 40 25],'callback','stim_color=str2num(get(ui_stim_color,''string''));','BackGroundColor',[1 1 1]);
ui_event_color = uicontrol('style','popupmenu','position',[TableLeft+150 325 110 20],'string',[{'gray'},{'color'}],'BackGroundColor','w');

ui_openXls = uicontrol('string','Open Xls', 'position',[TableLeft 295 100 25], 'fontsize',10,'callback','subplot(subROI);[subROIplot,dFF,FVt,ROIns,fname2,dirname2] = openXls(FVsampt,dirname2); dFFraw = dFF;dFFdet = detrend(dFF);');
%FVsampt = 0.253889999;
ui_FVsampt = uicontrol('style','edit','string',FVsampt,'fontsize',10,'position',[TableLeft+105 295 75 25],'callback','FVsampt=str2num(get(ui_FVsampt,''string''));','BackGroundColor',[1 1 1]);
ui_framerate = uicontrol('style','text','string','Sec/Frame','position',[1335 295 70 20],'fontsize',10);

ui_detrend = uicontrol('style','togglebutton','string','Detrend','position',[TableLeft 270 80 20], 'fontsize', 10, 'callback', 'detdFF;');

ui_filtdFF = uicontrol('style','togglebutton', 'string','LowCut','position',[TableLeft+85 270 80 20], 'fontsize',10, 'callback', 'filtdFF;');
Cut_dFF = 0.005;

ui_cutdff = uicontrol('style','edit','string',Cut_dFF,'fontsize',10,'position',[TableLeft+170 270 50 25],'callback','Cut_dFF=str2num(get(ui_cutdff,''string'')); filtdFF;','BackGroundColor',[1 1 1]);
ui_Hz = uicontrol('Style','text', 'string','Hz', 'position',[TableLeft+220 270 30 20],'fontsize', 10);

%ui_offsetdFF = uicontrol('style','togglebutton', 'string','Offset','position',[1375 270 50 20], 'fontsize',10, 'callback', 'dFF = offsetdFF(ui_offsetFF,dFF); plotROI;');
ui_textF0 = uicontrol('style', 'text', 'string', 'F0 = 1: ','position', [TableLeft 240 45 20], 'fontsize', 10);
ui_F0_end_frame = uicontrol('style', 'edit', 'string', F0_end_frame, 'fontsize', 10, 'position', [TableLeft+45 240 50 25], 'callback', 'F0_end_frame = str2num(get(ui_F0_end_frame,''string''));','BackGroundColor',[1 1 1]);
ui_offsetdFF = uicontrol('string','Offset','position',[TableLeft+100 240 50 20], 'fontsize',10, 'callback', 'offsetdFF;plotROI');


text_selectROI = uicontrol('style','text','string','selectROI', 'position',[TableLeft 215 100 20],'fontsize',10);
selectROI=[];
%ui_selectROI = uicontrol('style','edit','string',selectROI, 'fontsize', 10, 'position', [TableLeft 190 150 25],'callback','selectROI = str2num(get(ui_selectROI, ''string''));','BackGroundColor',[1 1 1]);
ui_selectROI = uicontrol('style','edit','string',selectROI, 'fontsize', 10, 'position', [TableLeft 190 150 25],'callback','get_selectROI;','BackGroundColor',[1 1 1]);
ui_ROItraces = uicontrol('string','Draw ROItraces','position',[TableLeft+155 190 100 25], 'fontsize', 10, 'callback','get_selectROI;stimON = drawROIandEvent(FVt, dFF, selectROI, get(ui_event_color,''value''), stim_color);');
ui_STA = uicontrol('string','STA3','position',[TableLeft+260 190 50 25],'fontsize',10,'callback','[y, peak1,peak2, peak, area, peak_sd] = StimTraceAverage3(dFF, selectROI, Bhead, stim_color, FVsampt,stimON,num_cutTrial);');
num_cutTrial = 0;
ui_cutTrial = uicontrol('style','edit','string',num_cutTrial, 'fontsize', 10, 'position',[TableLeft+260 165 50 25],'callback','num_cutTrial = str2num(get(ui_cutTrial,''string''));','BackGroundColor',[1,1,1]);

ui_saveSTA = uicontrol('string','Save_STA', 'position',[TableLeft+240, 135, 70, 25],'fontsize',10,'callback','save_sta');

text_deselectROI = uicontrol('style','text','string','deselectROI','position',[TableLeft 165 100 20],'fontsize',10);
deselectROI=[];
ui_deselectROI = uicontrol('style','edit','string',deselectROI,'fontsize',10,'position',[TableLeft 140 150 25],'callback', 'get_selectROI;','BackGroundColor',[1 1 1]);

nROI = 1;
ui_nROI = uicontrol( 'style','edit','string',nROI,'position', [TableLeft+155 115 50 25], 'fontsize', 10, 'callback','nROI=str2num(get(ui_nROI,''string''));plotROI', 'BackGroundColor',[1 1 1]);
text_nROI = uicontrol('style','text','string','nROI','position',[TableLeft+115 115 40 20],'fontsize',10);
ROIplus = uicontrol('string','ROI +', 'position',[TableLeft 115 50 20], 'fontsize', 10,'callback','if nROI >= ROIns, nROI=ROIns;else,nROI=nROI+1;end; plotROI');
ROIminus = uicontrol('string','ROI -', 'position',[TableLeft+60 115 50 20], 'fontsize', 10,'callback','if nROI <= 1,n = 1;else,nROI=nROI-1;end; plotROI');


text_interp = uicontrol('style','text','string','x Interp','position',[TableLeft 85 50 20],'fontsize',10);
ui_interp = uicontrol('style','edit','string', interp_times,'position', [TableLeft+50 85 50 25], 'fontsize', 10, 'callback','interp_times=str2num(get(ui_interp,''string''));plotROI', 'BackGroundColor',[1 1 1]);
ui_interp_method = uicontrol('style','popupmenu','position',[TableLeft+105 80 110 25],'string',[{'spline'},{'liner'}],'BackGroundColor','w');
ui_ROI_AVE = uicontrol('string','ROI_AVE', 'position',[TableLeft+215 80 70 25], 'fontsize', 10,'callback','[yy,sampt2] = plot_ROIave(dFF, FVt, Bhead, stim_color, stimON(:,1), selectROI, interp_times,get(ui_interp_method,''value''));');

%%
UI2 = [uiT,ui_plotEvent,ui_stim_color,ui_event_color,ui_openXls,...
    ui_FVsampt,ui_framerate,ui_detrend,ui_filtdFF,ui_cutdff,ui_Hz,...
    ui_textF0,ui_F0_end_frame,ui_offsetdFF,text_selectROI,ui_selectROI,...
    ui_ROItraces,ui_STA,ui_cutTrial,ui_saveSTA,text_deselectROI,ui_deselectROI,ui_nROI,...
    text_nROI,ROIplus,ROIminus,text_interp,ui_interp,ui_interp_method,ui_ROI_AVE];