%%openfile%%
issub = exist('subEvent','var');
if issub ==1
    delete(subEvent);
    delete(subROI);
    %delete(subTraces);
end
f_open = 1;%open file style
n=1;
global Bhead
%global dirname
[Bhead, Bv, Bi, Bp, datap, fname, dirname] = SelectOpen(prm.headlength,dirname);

if fname == 0
    fname =[];
    dirnme =[];
    %clear dirname;
    subEvent = subplot('position',[0.3 0.5 0.45 0.15]);
    subROI = subplot('position',[0.3 0.05 0.45 0.4]);
else
    B = Bp;
    
    readheader;
    
    t = 0:Bhead(2,1)/1000:Bhead(1,1)-Bhead(2,1)/1000; %ms
    tmax = t(end);
    set(ui_tmax,'string',tmax);
    
    detectsp;
    ui_dtsp = uicontrol( 'style','edit','string',insv,'position', [450 770 650 25],'callback','insv=str2num(get(ui_dtsp,''string''))', 'BackGroundColor',[1 1 1], 'fontsize', 10);
    uicontrol( 'position',[450 795 120 25],'String','Detected Spikes', 'Style','text', 'fontsize', 10);
    set(ui_dtsp,'string',num2str(insv));
    
    nlength = length(Bhead(1,:));%ÉgÉåÅ[ÉXêî
    
    s1 = subplot('position', [0.3 0.58 0.45 0.3]);
    p1 = plot(t,B(:,n),'b','erasemode','normal');
    zoom on;
    
    hold on;
    p1s = plot(lpv4,B(lpv3,n),'m*');
    if Bhead(5,n) == 1
        p1flash = line('XData',[Bhead(16,n),Bhead(16,n)]*1000,'YData',[vmin vmax],'Color','r','LineWidth',1);
        p1correct = line('XData',[flash_correct, flash_correct]*1000, 'YData',[vmin vmax],'Color','g','LineWidth',1);
    elseif Bhead(5,n) == 0
        p1flash = line('XData',[0 0],'YData',[min(B(:,n)),min(B(:,n))],'Color','r','LineWidth',1);
        p1correct = line('XData',[0 0],'YData',[min(B(:,n)),min(B(:,n))],'Color','g','LineWidth',1);
    end
    hold off
    
    ylim([vmin vmax]);
    %title({['S.Dura=',stimduration, ', S.col=',stimcol,', BGcol= ',bgcol,', S.pattern= ',stimpattern, ', Size= ', stimszx, ' x ', stimszy],['MonitorDivide= ', divnum, ', Position= ', position, ', S.delay= ', PTBdelay, ' ms'],['n=', num2str(n)]});
    title({'V-DATA',['n=', num2str(n)]});
    %xlabel('Time (ms)');
    ylabel('V Data (mV)');
    
    if isempty(Bp)
        p1s =[];
        s2 =[];
    else
        s2 = subplot('position', [0.3 0.45 0.45 0.1]);
        p2 = plot(t,Bp(:,n),'g');
        %title('S-DATA');
        xlabel('Time (ms)');
        ylabel('Sensor (mV)');
    end
    
    %s1 = subplot('position', [0.3 0.58 0.45 0.3]);
    %s2 = subplot('position', [0.3 0.45 0.45 0.1]);
    
    subEvent = subplot('position',[0.3,0.35, 0.45, 0.05]);
    
    subROI = subplot('position',[0.3,0.05,0.45, 0.23]);
    
    %subTraces = subplot('position',[0.3 0.05,0.45, 0.13]);
    
    openTable;
end
