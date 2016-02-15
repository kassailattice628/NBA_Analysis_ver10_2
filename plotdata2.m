%% plotdata2 %%
readheader;
if Bhead(27,n) == 1
    detectsp;
    %%%波形データを描画！%%%
    %抽出したspike timing の値を，figure2に表示したい
    set(ui_dtsp,'string',num2str(insv));
end

switch Bhead(27,1)
    case 1%open all
        y1 = B1(:,n);
        %
        if get(ui_axis_auto,'value') == 1
            Vmin = min(B1(:,n));
            Vmax = max(B1(:,n));
        else
            Vmin = vmin;
            Vmax = vmax;
        end
        %}
        
        if isempty(p1s)
            subplot(s1);
            hold on
            p1s = plot(lpv4,B1(lpv3,n),'m*');
            hold off
        else
            set(p1s, 'xdata',lpv4, 'ydata', B1(lpv3,n),'Marker','*', 'Color','m');
        end
        
        y2 = B2(:,n);
        %{
        if get(ui_axis_auto,'value') == 1
            Vmin2 = min(B2(:,n));
            Vmax2 = max(B2(:,n));
        else
            Vmin2 = vmin;
            Vmax2 = vmax;
        end
        %}
        y3 = Bp(:,n);
        switch get(ui_plot,'value')
            case 0 % V main
                subplot(s1);
                set(gca,'title',text('string',['V-DATA: n=', num2str(n)]));
            case 1% I main
                subplot(s1);
                set(gca,'title',text('string',['I-DATA: n=', num2str(n)]));
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    case  3%open photo
        y1 = B1(:,n);
        subplot(s1);
        set(gca,'title',text('string',['S-DATA: n=', num2str(n)]));
        
end

if Bhead(5,n) == 1
    Vmin = min(B1(:,n));
    Vmax = max(B1(:,n));
    set(p1flash,'xdata',[Bhead(16,n),Bhead(16,n)]*1000,'ydata',[Vmin Vmax]);
    
    amari = rem(Bhead(9,n),Bhead(8,n));
    if amari == 0
        amari = Bhead(8,n);
    end
    flash_correct = Bhead(16,n)+Bhead(24,n)/1024/75;
    set(p1correct,'xdata',[flash_correct, flash_correct]*1000,'ydata',[Vmin Vmax]);
elseif Bhead(5,n) == 0
    set(p1flash,'xdata',[0 0],'ydata',[min(B1(:,n)), min(B1(:,n))]);
    set(p1correct,'xdata',[0 0],'ydata',[min(B1(:,n)), min(B1(:,n))]);
end
axis([tmin tmax Vmin Vmax]);

%%% header %%%
set(uiT,'Data',HeadTable);
%{
%total firing rate with sound in [Hz]. Latency is defined as 2 [ms]
spkNtS = length(find(v2fB(round(2*fs/1000):round((Bhead(11,n)+2)*fs/1000))>0))*1000/Bhead(11,n);
%firing rate before sound in [Hz]
%spkNtC= length(find(v2fB(1:round((timebs(2))*fs/1000))>0))*1000/timebs(2);
%if spkNtS*spkNtC == 0
spkNt = 0;
%else
%spkNt = spkNtS/spkNtC;
%end
%spike Number of whole trace
spkN =length(lpv3);
%}

refreshdata;
drawnow;