%openfile2%

%%reset GUI
if exist('s2','var');
    delete(s1)
    delete(s2)
    delete(s3)
    delete(subEvent);
    delete(subROI);
    delete(ui_dtsp);
    delete(ui_dtsptitle);
    delete(UI2);
    clear s1 s2 s3 subEvent subROI ui_dtsp ui_dtsptitle UI2
elseif exist('subEvent','var');
    delete(s1)
    delete(subEvent);
    delete(subROI);
    delete(UI2);
    clear s1 subEvent subROI UI2
end

set(ui_plot, 'value',0, 'string', 'V-plot');
set(ui_axis_auto, 'value', 0, 'string', 'V-auto');

%% read data file
n = 1;
global Bhead

[Bhead, Bv, Bi, Bp, datap, fname, dirname] = SelectOpen(headlength, dirname);

if fname == 0
    fname =[];
    dirname =[];
    subEvent = subplot('position',[0.3 0.5 0.45 0.15]);
    subROI = subplot('position',[0.3 0.05 0.45 0.4]);
else
    readheader;
    nlength = length(Bhead(1,:));%トレース数
    
    t = 0:Bhead(2,1)/1000:Bhead(1,1)-Bhead(2,1)/1000; %ms
    tmax = t(end);
    set(ui_tmax,'string',tmax);
    
    switch Bhead(27,1)
        case 1 % open all file
            B1 = Bv;
            detectsp;
            ui_dtsp = uicontrol( 'style','edit','string',insv,'position', [450 790 650 25],'callback','insv=str2num(get(ui_dtsp,''string''))', 'BackGroundColor',[1 1 1], 'fontsize', 10);
            ui_dtsptitle = uicontrol( 'position',[450 815 120 25],'String','Detected Spikes', 'Style','text', 'fontsize', 10);
            set(ui_dtsp,'string',num2str(insv));
            
            %%%%% plot main %%%%%
            s1 = subplot('position',[0.3,0.6,0.45,0.3]);
            y1 = B1(:,1);
            p1 = plot(t,y1,'b','YdataSource','y1');
            set(gca,'xticklabel',[])
            title(['V-DATA: n = ', num2str(n)]);
            ylabel('mV');
            zoom on;
            hold on;
            %detected spikes
            p1s = plot(lpv4,B1(lpv3,n),'m*');
            
            if Bhead(5,1) == 1 % Vis stim ON
                p1flash = line('XData',[Bhead(16,n),Bhead(16,n)]*1000,'YData',[vmin vmax],'Color','r','LineWidth',1);
                p1correct = line('XData',[flash_correct, flash_correct]*1000, 'YData',[vmin vmax],'Color','g','LineWidth',1);
            elseif Bhead(5,n) == 0
                p1flash = line('XData',[0 0],'YData',[min(B1(:,n)),min(B1(:,n))],'Color','r','LineWidth',1);
                p1correct = line('XData',[0 0],'YData',[min(B1(:,n)),min(B1(:,n))],'Color','g','LineWidth',1);
            end
            hold off
            ylim([vmin vmax]);
            
            %Bv, Bi 両方表示するか
            s2 = subplot('position',[0.3,0.48,0.45,0.1]);
            B2 = Bi;
            y2 = B2(:,1);
            p2 = plot(t,y2,'r','YdataSource','y2');
            set(gca,'xticklabel',[])
            ylabel('nA');
            
            
            %photosensor
            s3 = subplot('position',[0.3,0.36,0.45,0.1]);
            y3 = Bp(:,1);
            p3 = plot(t,y3,'g','YdataSource','y3');
            ylabel('mV');
            xlabel('Time (ms)');
            
            subEvent = subplot('position',[0.3,0.25, 0.45, 0.08]);
            set(gca,'xticklabel',[],'yticklabel',[])
            subROI = subplot('position',[0.3,0.03,0.45, 0.2]);
            
            openTable;
        case 2 % open header
            openheader;
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        case 3 % oepn photo
            B1 = Bp;
            s1 = subplot('position',[0.3 0.7 0.45 0.25]);
            y1 = Bp(:,1);
            p1 = plot(t,y1,'g','YdataSource','y1');
            title(['S-DATA: n = ', num2str(n)]);
            ylabel('Sensor:mV');
            xlabel('Time (ms)');
            
            hold on;
            if Bhead(5,1) == 1 % Vis stim ON
                p1flash = line('XData',[Bhead(16,n),Bhead(16,n)]*1000,'YData',[vmin vmax],'Color','r','LineWidth',1);
                p1correct = line('XData',[flash_correct, flash_correct]*1000, 'YData',[vmin vmax],'Color','g','LineWidth',1);
            elseif Bhead(5,n) == 0
                p1flash = line('XData',[0 0],'YData',[min(B(:,n)),min(B(:,n))],'Color','r','LineWidth',1);
                p1correct = line('XData',[0 0],'YData',[min(B(:,n)),min(B(:,n))],'Color','g','LineWidth',1);
            end
            hold off
            
            subEvent = subplot('position',[0.3 0.5 0.45 0.15]);
            set(gca,'yticklabel',[])
            subROI = subplot('position',[0.3 0.05 0.45 0.4]);
            openTable;
    end
end


