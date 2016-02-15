function openGUI

global ui
global prm

%define params
prm.headlength = 50;
prm.selectdraw = 1;
prm.selectno = 1;
prm.n=1;
prm.binms = 1;
prm.f_siv=1;
prm.spDparams=[100 2 0]; %Spike detection parameter
prm.insv =[];
prm.vmin = -50;
prm.vmax = 50;
prm.tmin = 0;
prm.tmax = [];
prm.savefname =[];
prm.cutf_low = 100;
prm.cutf_high = 1000;
prm.OrderN = 2;
Bfilt = [];

prm.fname =[];
prm.dirname =[];
prm.fname2 = [];
prm.dirname2 =[];

%openTaable“à•Ï”
prm.FVsampt = 0.574616;
prm.F0_end_frame = 15;
prm.stim_color = 6;
prm.interp_times = 10;
%%
ui.a = uicontrol('string','Open File', 'position',[10 790 80 30],'callback','openfile2; clear A;','fontsize',10);
uicontrol('string','Split Data','position',[200 790 80 30], 'callback', 'splitData2', 'fontsize',10);
%ui.head = uicontrol( 'style','edit','string',headlength,'position', [100 720 40 30],'callback','headlength=str2num(get(ui.head,''string''))', 'BackGroundColor',[1 1 1], 'fontsize', 10);
ui.head = uicontrol( 'style','edit','string',headlength,'position', [100 720 40 30],'callback', @editprm, 'BackGroundColor',[1 1 1], 'fontsize', 10);

uicontrol('style','text', 'position',[100 750 40 20],'String','#head', 'fontsize', 10);
ui.savefname = uicontrol('style','edit','string',savefname','position',[200 720 100 30],'callback','savefname=get(ui.savefname,''string'');', 'BackGroundColor',[1 1 1],'fontsize', 10);
ui.b = uicontrol('style','text','string','Save File name', 'position',[200 750 100 20],'fontsize',10);


ui.selectdraw = uicontrol( 'style','edit','string',selectdraw,'fontsize',10, 'position', [10 665 400 25],'callback','selectdraw=str2num(get(ui.selectdraw,''string''));selectno=length(selectdraw);', 'BackGroundColor',[1 1 1]);
uicontrol( 'position',[10 690 70 20], 'fontsize', 10, 'String','selectdraw', 'Style','text');

uicontrol('string','Draw Select', 'position',[10 640 80 20],'callback','drawselect','fontsize', 10);
uicontrol('string','Draw Ave', 'position',[95 640 80 20],'callback','drawave','fontsize', 10);

uicontrol('string','Align Select', 'position',[10 610 80 20],'callback','drawselectalign','fontsize', 10);
uicontrol('string','Align Ave', 'position',[95 610 80 20],'callback','drawalignave','fontsize', 10)

ui.plot = uicontrol('style','togglebutton','string','V-plot', 'position',[10 580 80 20],'callback','ch_plot','fontsize', 10);

ui.axis_auto = uicontrol('style','togglebutton','string','V-auto','position',[190 640 40 20],'callback','plotdata2');

uicontrol( 'position',[190 615 40 20],'String','Vmin', 'Style','text', 'fontsize', 10);
ui.vmin = uicontrol('style','edit','string', vmin,'fontsize',10, 'position',[190 590 40 25],'callback','vmin = str2num(get(ui_vmin,''string''));plotdata2','BackGroundColor',[1 1 1]);
uicontrol( 'position',[190 565 40 20],'String','Vmax', 'Style','text', 'fontsize', 10);
ui.vmax = uicontrol('style','edit','string', vmax,'fontsize',10, 'position',[190 545 40 25],'callback','vmax = str2num(get(ui_vmax,''string''));plotdata2','BackGroundColor',[1 1 1]);
uicontrol( 'position',[190 515 40 20],'String','Tmin', 'Style','text', 'fontsize', 10);
ui.tmin = uicontrol('style','edit','string', tmin,'fontsize',10, 'position',[190 490 40 25],'callback','tmin = str2num(get(ui_tmin,''string''));plotdata2','BackGroundColor',[1 1 1]);
uicontrol( 'position',[190 465 40 20],'String','Tmax', 'Style','text', 'fontsize', 10);
ui.tmax = uicontrol('style','edit','string', tmax,'fontsize',10, 'position',[190 445 40 25],'callback','tmax = str2num(get(ui_tmax,''string''));plotdata2','BackGroundColor',[1 1 1]);

uicontrol('string','n+', 'position',[10 510 30 20], 'fontsize', 10,'callback','if n >= nlength,n=nlength;else,n=n+1;end;plotdata2');
uicontrol('string','n-', 'position',[50 510 30 20], 'fontsize', 10,'callback','if n <= 1,n = 1;else,n=n-1;end;plotdata2');

ui.n = uicontrol( 'style','edit','string',n,'position', [25 545 50 25], 'fontsize', 10, 'callback','n=str2num(get(ui.n,''string''));plotdata2', 'BackGroundColor',[1 1 1]);
uicontrol( 'position',[10 545 15 25], 'fontsize', 10, 'String','n', 'Style','text');

uicontrol('string','Get Histo', 'position',[240 640 70 20],'callback','hget', 'fontsize', 10);
uicontrol('string','Align Histo', 'position',[315 640 70 20],'callback','hgetalign', 'fontsize', 10);
%histgramplot ‚ÅChspikes ‚ðget‚µ‚ÄC•`‰æ‚·‚é‚Æ‚±‚ë‚Ü‚Å‚¢‚Á‚½D
uicontrol( 'position',[315 615 40 20],'String','binms', 'Style','text', 'fontsize', 10);
ui.bin = uicontrol( 'style','edit','string',binms,'position', [315 590 40 25],'callback','binms=str2num(get(ui.bin,''string''));', 'BackGroundColor',[1 1 1], 'fontsize', 10);


uicontrol('string','inserth', 'position',[240 615 70 20],'callback','inserth', 'fontsize', 10);
uicontrol('string','savehisto', 'position',[240 590 70 20],'callback','savefileh', 'fontsize', 10);


ui.sp1= uicontrol( 'style','edit','string',spDparams(1),'position', [10 410 40 25], 'fontsize', 10, 'callback','spDparams(1)=str2num(get(ui.sp1,''string''));plotdata2', 'BackGroundColor',[1 1 1]);
uicontrol( 'position',[10 435 100 20], 'fontsize', 10, 'String','Sp1:threshold', 'Style','text');
uicontrol('position',[55, 410 50 20],'string', 'mV', 'fontsize', 10, 'Style', 'text');
ui.sp2 = uicontrol( 'style','edit','string',spDparams(2),'position', [10 365 40 25], 'fontsize' ,10, 'callback','spDparams(2)=str2num(get(ui.sp2,''string''));plotdata2', 'BackGroundColor',[1 1 1]);
uicontrol( 'position',[10 390 80 20],'fontsize', 10, 'String','Sp2:slope', 'Style','text');
uicontrol('position',[55, 365 50 20],'string', 'mV/ms', 'fontsize', 10, 'Style', 'text');
ui.sp3 = uicontrol( 'style','edit','string',spDparams(3),'position', [10 320 40 25], 'fontsize', 10, 'callback','spDparams(3)=str2num(get(ui.sp3,''string''));plotdata2', 'BackGroundColor',[1 1 1]);
uicontrol( 'position',[10 345 80 20],'String','Sp3:refractor', 'fontsize', 10,  'Style','text');
uicontrol('position',[55, 320 50 20],'string', 'ms', 'fontsize', 10, 'Style', 'text');

%%% Digital filter %%%%
ui.butter = uicontrol('style','togglebutton','string', 'Filt(Butter)','position',[10 250 80 20],'callback','filtonoff','fontsize',10);
ui.filtselect = uicontrol('style','popupmenu','position',[95 245 135 25],'string',[{'high-pass'},{'low-pass'},{'band-pass'},{'band-stop'}],'callback','filtonoff','BackGroundColor','w');
ui.filtcheck = uicontrol('string','Browse Filter','position',[235 250 100 20],'callback','browse_filt','fontsize',10);


uicontrol('Style','text', 'string','Cutoff Low', 'position',[10 220 80 20],'fontsize', 10);
ui.filtfslow = uicontrol( 'style','edit','string',cutf_low,'position',[10 200 80 25],'callback','cutf_low = str2num(get(ui.filtfslow,''string'')); filtonoff;','BackGroundColor','w');
uicontrol('Style','text', 'string','Hz', 'position',[95 200 30 20],'fontsize', 10);

uicontrol('Style','text', 'string','Cutoff High', 'position',[130 220 80 20],'fontsize', 10);
ui.filtfshigh = uicontrol( 'style','edit','string',cutf_high,'position',[130 200 80 25],'callback','cutf_high = str2num(get(ui.filtfshigh,''string'')); filtonoff;','BackGroundColor','w');
uicontrol('Style','text', 'string','Hz', 'position',[215 200 30 20],'fontsize', 10);

uicontrol('Style','text','string','Order(n)','position',[10 170 60 20],'fontsize',10);
ui.OrderN = uicontrol( 'style','edit','string',OrderN,'position',[10 150 60 25],'callback','OrderN = str2num(get(ui.OrderN,''string'')); filtonoff;','BackGroundColor','w');

%%
    function editprm(hObject,eventdata, handles)
        str2double(get(hObject,'String'));
    end



end % end of function openGUI