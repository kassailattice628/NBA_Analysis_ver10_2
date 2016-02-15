%%%open header file%%%

%[Bhead, Bv, Bp] = SelectOpen(headlength);
global Bhead
%global dirname
[Bhead, Bv, Bp, datap,fname, dirname] = SelectOpen(headlength,dirname);

if fname == 0
    fname =[];
    dirnme =[];
    %clear dirname;
    subEvent = subplot('position',[0.3 0.5 0.45 0.15]);
    subROI = subplot('position',[0.3 0.05 0.45 0.4]);
else
    
    %%%
    readheader;
    
    %%%
    nlength = length(Bhead(1,:));
    
    
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
        'Calc Delay PTBon';...
        'Elapsed Time (sec)';...
        'Images_#';};
    
    %%% open new figure
    
    figure('Position',[50,100,1100,800]);
    uiT = uitable('Data',HeadTable,'ColumnName','Parameter','ColumnWidth',{70},'RowName',HeaderList,'position',[100 300 270 450]);
    ui_n_disp = uicontrol('style','text','string',['#n: = ', num2str(n)], 'position',[100 750 100 20], 'fontsize', 10);
    
    ui_n = uicontrol( 'style','edit','string',n,'position', [25 750 50 25], 'fontsize', 10, 'callback','n=str2num(get(ui_n,''string''));readheader;set(uiT,''Data'',HeadTable);set(ui_n_disp,''string'',[''#n: = '', num2str(n)]);', 'BackGroundColor',[1 1 1]);
    uicontrol( 'position',[10 750 15 25], 'fontsize', 10, 'String','n', 'Style','text');
    uicontrol('string','n +', 'position',[10 725 30 20], 'fontsize', 10,'callback','if n >= nlength,n=nlength;else,n=n+1;end;readheader;set(uiT,''Data'',HeadTable);set(ui_n_disp,''string'',[''#n: = '', num2str(n)]);');
    uicontrol('string','n -', 'position',[50 725 30 20], 'fontsize', 10,'callback','if n <= 1,n = 1;else,n=n-1;end;readheader;set(uiT,''Data'',HeadTable);set(ui_n_disp,''string'',[''#n: = '', num2str(n)]);');
    
    %%%%%
    %uicontrol('string','Plot Event', 'position',[100 270 100 25], 'fontsize',10,'callback','subplot(subEvent);stimON = plotEvent([0 1 1 0]);');
    uicontrol('string','Plot Event', 'position',[100 270 100 25], 'fontsize',10,'callback','subplot(subEvent); if get(ui_event_color,''value'') ==1; stimON = plotEvent([0 1 1 0]); else stimON = plotEvent_color([0 1 1 0], stim_color); end');
    
    stim_color = 6;
    ui_stim_color = uicontrol('style','edit','string',stim_color,'fontsize',10,'position',[205 270 40 25],'callback','stim_color=str2num(get(ui_stim_color,''string''));','BackGroundColor',[1 1 1]);
    ui_event_color = uicontrol('style','popupmenu','position',[245 270 110 20],'string',[{'gray'},{'color'}],'BackGroundColor','w');
    %%%%%
    uicontrol('string','Open Xls', 'position',[100 240 100 25], 'fontsize',10,'callback','subplot(subROI);[subROIplot,dFF,FVt,ROIns,fname2,dirname2] = openXls(FVsampt,dirname2); dFFraw = dFF;dFFdet = detrend(dFF);');
    
    ui_FVsampt = uicontrol('style','edit','string',FVsampt,'fontsize',10,'position',[205 240 75 25],'callback','FVsampt=str2num(get(ui_FVsampt,''string''));','BackGroundColor',[1 1 1]);
    uicontrol('style','text','string','Sec/Frame','position',[285 240 70 20],'fontsize',10);
    %%%%%
    ui_detrend = uicontrol('style','togglebutton','string','Detrend','position',[100 210 80 20], 'fontsize', 10, 'callback', 'detdFF;');
    ui_filtdFF = uicontrol('style','togglebutton', 'string','LowCut','position',[185 210 80 20], 'fontsize',10, 'callback', 'filtdFF;');
    Cut_dFF = 0.005;
    ui_cutdff = uicontrol('style','edit','string',Cut_dFF,'fontsize',10,'position',[270 210 50 25],'callback','Cut_dFF=str2num(get(ui_cutdff,''string'')); filtdFF;','BackGroundColor',[1 1 1]);
    uicontrol('Style','text', 'string','Hz', 'position',[325 210 30 20],'fontsize', 10);
    
    %%%%%
    uicontrol('style', 'text', 'string', 'F0 = 1: ','position', [100 185 45 20], 'fontsize', 10);
    ui_F0_end_frame = uicontrol('style', 'edit', 'string', F0_end_frame, 'fontsize', 10, 'position', [150 185 50 25], 'callback', 'F0_end_frame = str2num(get(ui_F0_end_frame,''string''));','BackGroundColor',[1 1 1]);
    ui_offsetdFF = uicontrol('string','Offset','position',[205 185 50 20], 'fontsize',10, 'callback', 'offsetdFF;plotROI');
    
    uicontrol('style','text','string','selectROI', 'position',[100 160 100 20],'fontsize',10);
    selectROI  =1;
    ui_selectROI = uicontrol('style','edit','string',selectROI, 'fontsize', 10, 'position', [100 135 150 25],'callback','selectROI = str2num(get(ui_selectROI, ''string''));','BackGroundColor',[1 1 1]);
    uicontrol('string','Draw ROItraces','position',[255 135 100 25], 'fontsize', 10, 'callback','stimON = drawROIandEvent(FVt, dFF, selectROI, get(ui_event_color,''value''), stim_color);');
    
    %%%%%
    nROI = 1;
    ui_nROI = uicontrol( 'style','edit','string',nROI,'position', [260 105 50 25], 'fontsize', 10, 'callback','nROI=str2num(get(ui_nROI,''string''));plotROI', 'BackGroundColor',[1 1 1]);
    uicontrol('style','text','string','nROI','position',[215 105 40 20],'fontsize',10);
    
    uicontrol('string','ROI +', 'position',[100 105 50 20], 'fontsize', 10,'callback','if nROI >= ROIns, nROI=ROIns;else,nROI=nROI+1;end; plotROI');
    uicontrol('string','ROI -', 'position',[160 105 50 20], 'fontsize', 10,'callback','if nROI <= 1,n = 1;else,nROI=nROI-1;end; plotROI');
    
    %%%%
    
    subROI = subplot('position',[0.45 0.15, 0.5, 0.4]);
    subEvent = subplot('position',[0.45 0.7 0.5, 0.2]);
end